Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB92C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 17:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26439887FD;
	Sat, 20 Jul 2024 19:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iKVJPvmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3FD8882D; Sat, 20 Jul 2024 19:10:14 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC62887F3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 19:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5d3cf39c239so1597431eaf.1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721495411; x=1722100211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CdLmVw6QwR1vitAGukde828ZUrkpQ7qkopPsXiO5F3Q=;
 b=iKVJPvmFaBgRYCdKptPi2eiOwCq7PmLICPXI7XYCiiymPYbSbHVq4GdFe2VH8SGey3
 vzW2VVE4a5g+zQ/tUe1ST+fXo67I88gAPTEdx6qY3Btekd560xL841km6Cer1G2JgvID
 64aQvX3gM80QFihIPDSOTSbV8FfZ4dIp/o9t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721495411; x=1722100211;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdLmVw6QwR1vitAGukde828ZUrkpQ7qkopPsXiO5F3Q=;
 b=U+n+Clzqsf+4F9r9c8qXiKBxVEEWdYGFaT663JiR6+srrKuJMGsfjFfF1tm1sKwxmi
 DwQAhem4tICX/dbF5QDTIhR81qoyqlEwjD0rEvx+C68ODYaeXApm7G2seq/+80XT25Cp
 XmTs5fb18+l3o3d/jm9DmQ8Qi1YN9P8q5qW/o8hceisWMXU+hE7SLypH8Su3brUhhDST
 ffDLec9H2AtdOTKrpDg/tjW1LTFEfRqO4gT84azcWZGGQKlZQwBsJ189sUGDOo16i3zI
 PizQPoa31Nm1UvnbOzXm9PMb3S3k/w/bq3eYCVbs31UNSy+kC7E9ZQbUcZsG2peC3A9c
 9mVw==
X-Gm-Message-State: AOJu0YyZ3eGyTGsPAOGjhIE6UbVLrfiPg2BAf0pxsUFHoQlp91hcmFfY
 Appo/jDgvRQUMuacTZgmT3IlM3EGWRgfzVPO4tcKySJ0J5zXVCE4o00OjJsJnp0=
X-Google-Smtp-Source: AGHT+IHVFWiP+ZaQ8pwtL2FA1/4S7bEtFZYy6ATmwsK+uT9wMo5i3MIXslqh9lsm7CB9DGnBl4Z7NA==
X-Received: by 2002:a4a:e90b:0:b0:5ce:f75b:175e with SMTP id
 006d021491bc7-5d564f5fb1fmr3332974eaf.4.1721495410630; 
 Sat, 20 Jul 2024 10:10:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189bd5sm773037a34.65.2024.07.20.10.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 10:10:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20240715114200.817719-1-sjg@chromium.org>
References: <20240715114200.817719-1-sjg@chromium.org>
Subject: Re: [PATCH v3] bootstash: Do not provide a default address for all
Message-Id: <172149540939.3268377.6175901184381929195.b4-ty@konsulko.com>
Date: Sat, 20 Jul 2024 11:10:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 15 Jul 2024 12:42:00 +0100, Simon Glass wrote:

> A valid memory location to stash bootstage information at will be
> architecture dependent. Move the existing defaults to the main Kconfig
> file for this option and set 0x0 as the default only for sandbox.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


