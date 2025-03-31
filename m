Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68070C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 18:09:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48FA81DE3;
	Mon, 31 Mar 2025 20:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mgrl7Igx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EAD781E5B; Mon, 31 Mar 2025 20:09:30 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 032C48129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 20:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c7f876b321so1333663fac.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743444566; x=1744049366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9dyxn1l46DWvJHaIV9DOZ+4gp1VeTQ5GE7HJEJvpp0=;
 b=Mgrl7IgxUXP+Nu73EFbsVBRmMm9Xwg0b/GrX8FY+Q5DtVSkKePcAg6jcIalTGOyi79
 eZ7uM73e5rO28Bi1WIyb+DHVqS0xWHBzfX02aSJXj1C+2rOZX8R52RVLF6DMR4H8Zf53
 Stg97NrZtuy/I55L+UTNlj1hxBBwjqHkh55Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743444566; x=1744049366;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9dyxn1l46DWvJHaIV9DOZ+4gp1VeTQ5GE7HJEJvpp0=;
 b=NmI9DbUT8PAaeEXBm+4i9ZlMjqXe6yX3wlk1k/8o8EsNyjN5VSONIOILLQ4i8xSDZD
 GMW3OHJ1f1ECiei91SKn+lUC+ulfybT4VUY1kXD07BbtqU96GYU0xZAMqNceilv68L9v
 a0oviMTKMMzjPsIsglTSzQOb6K2tBZxeJJh9fTHl1+1Y5+KY/5LfKEif8z4MN5GDzVxg
 0qLwD1UlIurmsJDGiDQzNwe4EZzdVpPDqH3ZQtnaj4/5CYuxEdM3Va5RUmX/mpUHISyw
 Y01QwtGs63aPnr0E4fqVvyOuPAqZ6tf/xzQYWyFXubmboctbEOjzc+0AkzkOQyJWabvY
 nnSg==
X-Gm-Message-State: AOJu0Yy2ej6100W0cGSrA02ZMG5yU6Ls+LqUTse+GnmKIWhklMPMmN6P
 uvgRTjL9AlVoHuSA1tiTNqYCLIXb06SyWTdPpLRAAzt0dwHI5VChRuXJJMuXppOUGiqsMpBQa0S
 X
X-Gm-Gg: ASbGncsd5yJDmegYZdgYvFnEPm1ORCsxK3dD6ZwcRtQm86GzjEXnhZH5jPQAI1jHfRD
 G3MliPH4ZE/Rehr9RvZZgbM/u7+Iu/mxuXdhdtc2KxtGZFTbsIFdIf5CfCYhtNpA6/p70kl8KKu
 UplOWO4sriyspFbvIkZ+tpwrGC+g5MlYGZgeOGeBBMgUOFZED8foxF1Wcj3unh8Au618YCzf/A1
 G1prZAG/rf+w1Xer0WRbpTLGVtCUvwzU4YOkDUN3keCf64w6ujgKbQ6nBBbbzV6bdXiFQ5rIGvr
 eFKf+yM/yWCfUcnHPyNZ5IHta9WsGzTwla5GpnfVDOTe1DZvvUGFS7bAq293Qax0x2/0YoW28fJ
 /tW6x
X-Google-Smtp-Source: AGHT+IHzz2HQRNzb/FvaSOH/SKD3U9Z78YY/fXRReajVBjfD0yrIYOMZisDlxEd3cDghZKThWbfxEA==
X-Received: by 2002:a05:6870:498a:b0:2bd:456c:92a with SMTP id
 586e51a60fabf-2cbcf5047e3mr6749061fac.10.1743444566675; 
 Mon, 31 Mar 2025 11:09:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a4850e6sm1938817fac.11.2025.03.31.11.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 11:09:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <a26d240f-9730-4439-b62d-f254aee6642b@linaro.org>
References: <a26d240f-9730-4439-b62d-f254aee6642b@linaro.org>
Subject: Re: Please pull net-20250314
Message-Id: <174344456559.2400215.9065117486556297481.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 12:09:25 -0600
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

On Mon, 31 Mar 2025 11:07:33 +0200, Jerome Forissier wrote:

> The following changes since commit 5e74863ad6613df9c69c576910b536e885083d65:
> 
>   MAINTAINERS: Update email of Mattijs Korpershoek (2025-03-28 10:33:48 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20250314
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


