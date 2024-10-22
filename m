Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E741CD2CDFA
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 16:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D07C88FD6;
	Tue, 22 Oct 2024 18:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CCGUafyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01E6C88FCE; Tue, 22 Oct 2024 18:27:14 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25F688D91
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 18:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbe3ea8e3fso35763826d6.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729614431; x=1730219231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=feqMErR//ASxMgw1kPlY3T6P2tuGb0rL7+a7Ia1OoiY=;
 b=CCGUafyNt1aB+EBvMYHXllHoEGZWlyaUzQU7dvokw07uBHCmj5I6lrSQFNOlRUerxl
 XGv9nAqhdU60q7bqsSvCgtpJiT3/iu13yPYDpD2vxMKWRQBHh2oZsxsUhDi+fx4A5FeC
 JWvE1I6xbgBN5hOsTcgYsLGF+MCZ40bGkkk5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729614431; x=1730219231;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feqMErR//ASxMgw1kPlY3T6P2tuGb0rL7+a7Ia1OoiY=;
 b=d+XMnomPnfK219fT8AyxMMpB5vFD1PkmYSwzDXyqppbcYleYNIlFTRoB8i0yBUoOIv
 BOUbyhKiCGhJOCs1Ck1sYcE2GLkbbp1aYflcImzi06nq0FFblddH7AcDKgZuddnW8rFd
 Y6u6eo6OhpLwkYoGSiZ4NoI4dCW2SsEaJGr+6YeKQIqOk0yi7qgM0Zj3oBbi9X+T0If7
 EOw7PTwviU/LvsRYX5WcIjLnkTZm4Ab/x0/C9G0HXLT5zdHAd3BbAa53Vtk9DDVV5iSL
 0PukGTDl6zVH+yZp2m/WJ6yI00GUuXECSJtfbfa6E+ZAvuh7vs/U1MQw1B397o6Qot6X
 VKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI5zSHKCJ+23mwhj3N14coZdDRu7Wu3fFul8mKdT+HZCgVyo8XV53Sdt1m7LXGAj79lzdVNIw=@lists.denx.de
X-Gm-Message-State: AOJu0YyGkDbUpM25mew0VQgfZSgNKvuG9py7fvpDOrPcyJ6C+Tu9jbOp
 36l6exK+6b8Mjw85tARFrHmkj1kXjJwbO6cspCjPkZ/Kb8N9cVjQVdDwKEdgC0VlMVVm3hCEkcj
 17IFJBQ==
X-Google-Smtp-Source: AGHT+IEuT0e3ysxLyE2HLpTBrUEJ9CUCF+XwpQdt/egXOOZRYmsoyTcbWgs9tgFoEU5ucRedyD9pCA==
X-Received: by 2002:a05:6214:310e:b0:6cc:b5:bd4d with SMTP id
 6a1803df08f44-6ce23f36663mr30681736d6.34.1729614430866; 
 Tue, 22 Oct 2024 09:27:10 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2be4sm30344046d6.2.2024.10.22.09.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:27:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, u-boot@lists.denx.de, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
In-Reply-To: <20241014095620.216936-1-chiawei_wang@aspeedtech.com>
References: <20241014095620.216936-1-chiawei_wang@aspeedtech.com>
Subject: Re: [PATCH v3 0/3] aspeed: ast2700: Add Caliptra ECDSA driver
Message-Id: <172961442984.3127138.14971443761867455881.b4-ty@konsulko.com>
Date: Tue, 22 Oct 2024 10:27:09 -0600
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

On Mon, 14 Oct 2024 17:56:17 +0800, Chia-Wei Wang wrote:

> Aspeed AST2700 SoCs integrates the Caliptra secure IP, where an ECDSA384
> signature verification HW interface is exported for SoC crypto needs.
> 
> This patch series firstly extends the FIT image signing/verify common
> code to support the ECDSA384 algorithm. For better convenience, the
> device tree for ECDSA public key storage is also revised by referring
> to RSA implementations.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


