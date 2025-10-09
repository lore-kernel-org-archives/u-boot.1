Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D57CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131B78453A;
	Thu,  9 Oct 2025 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QXmz2P5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C86848441D; Thu,  9 Oct 2025 16:19:01 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DEC84533
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7b97ce4fc60so312262a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019538; x=1760624338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MFhcgUNh6aaRe66Ay12W/uLbuiWomqXcJ0SElU2wJx4=;
 b=QXmz2P5vNmC8X9p8Ob2scuE+NjhI3y/9D/yBdE8MbzzNB97w0aL3AgKx3aLIGPF+zr
 Ur6l3hLZzhj847+aJ5SHW8VJHIDD89kwxTMKdfyF3l6Z4KNyot36ECo3QjumA7dlNOK3
 ghRggYkKZYY7HvPgojhz3M7WVK0a1/CEjPHxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019538; x=1760624338;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFhcgUNh6aaRe66Ay12W/uLbuiWomqXcJ0SElU2wJx4=;
 b=Yxianj2i4N+KGlChY8UZjtaMUYOgYro+0xW0CW3QoRBJgeZWR2htB/tdtRzLJrEcID
 DgOaX6+n69TIXOx07x0rrMRE5fqI6qcNZVFWEVtlhS2SlwjorwAGtddRRRf5OzJRpLOA
 vTaiv2cziYBge0aOYcEuLMrxQNkue0yNzA4s2Rw4J1XFuSumIcoNS/ABddWO98IOoj9I
 jwWJAeIE4pSiv5aAx///DoKtx6peVw0BIviOnZ4T+N4cH+XpUQrB67UFuKB0sc4bVrS6
 yHdrvBI6mkzitHrq5VsdX03IxORVgjrVbOgyMmn73yrpHPbzNc95BRiERdHfAVozti0W
 cNLQ==
X-Gm-Message-State: AOJu0YzGSJ3uMjCGNrPCQNGIbwjXwJDgkGH32W5zk/S3cLzRbNshQ6oT
 ZFg30VxCdPD1b/I+ijD5vNLQ29/ovAXdgb3IWEMydYbwb3zTtPPa5LPWyc3UD747R9IVzjcfaeO
 G1fIQGPw=
X-Gm-Gg: ASbGncvIw8wFXKpeg3+ZbkKqIfyEjFa5lTuUJMvKGg9b0MwZX5gGxnRMdaXTKDQaum5
 VKUCdUJSYRUj3xnGwJQRmEqGgBddzEuUSGjj3j23y/4dFN8b6lflQABZ4hDd84IIRM/4fOVX6aA
 t3Ji3dl7v9bK7s2ycTRAsbm0OSMZJGFXXFpDUrrlW8aYuRe3VLQG3AulZhfsznMDhyl3rUYqyt7
 UB5pLvrZnToOKPCqaeB5ajf24MbpVPKVMvPqwQ2ZVgs3riM14BhuXLEMvaf+ufAgZw49Vd8L5Mc
 79lU76jM5uTRjZZ2UUZMMsrIga4P3KlRkU8tvsYxphbA4bkPGLox2sQSKywZrSkn82Br8xzNt++
 ftooWYXlby9eIwz5EpTV1HDQK5CeimptfJqqi7Zb8tNWE5eBwzpEMBqa2mdV26C+upZ9QA0MN4w
 ZJwG09tOKd
X-Google-Smtp-Source: AGHT+IHBb2sWAxPaO9AFvPfPhtXuPdqmIhFWUIVyRuynwrj4goVIQ0ZstPFgWl0IkIgFzTnG/FiZ7Q==
X-Received: by 2002:a05:6830:6c09:b0:7b9:4bbc:23e4 with SMTP id
 46e09a7af769-7c0df7c9879mr3388722a34.20.1760019538494; 
 Thu, 09 Oct 2025 07:18:58 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250926153130.3680817-1-trini@konsulko.com>
References: <20250926153130.3680817-1-trini@konsulko.com>
Subject: Re: [PATCH] common: Make MMU_PGPROT depend on !SANDBOX
Message-Id: <176001953741.3159859.17912117132861844221.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 26 Sep 2025 09:31:30 -0600, Tom Rini wrote:

> While MMU_PGPROT is currently only functional for arm64 it can be
> extended for other real platforms as well. It does not however make
> sense for sandbox to enable and create dummy functions for. Make this
> depend on !SANDBOX.
> 
> 

Applied to u-boot/master, thanks!

[1/1] common: Make MMU_PGPROT depend on !SANDBOX
      commit: 0cdca862cb68a7f896e2095f5a248d3bc780bd29
-- 
Tom


