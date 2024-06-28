Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081FBC30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 19:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD60885EB;
	Fri, 28 Jun 2024 21:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F48dj5pU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16E23885DF; Fri, 28 Jun 2024 21:49:35 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB3E885D4
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 21:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d561e564d0so570747b6e.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719604171; x=1720208971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB1ZpeeYfm0ikiA+SusNYq6oF4MO/JsjIiAhAdRR1Qo=;
 b=F48dj5pUAcBNJ3HMwL0BtZ1BwVgnXNxXhBDKYxzCJXC++bKuKyFGklG2a5Ed8wwVxh
 UdKgkiEZ9njZxKW5hHMl/4AhNav0Z8/AhejKokPGaySqUoL3lJhqyrA+62Zb/jvxHtJG
 GfEiCU6QCjnEoe1mOBbHDQ9XgyRB2hNN9GRwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719604171; x=1720208971;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FB1ZpeeYfm0ikiA+SusNYq6oF4MO/JsjIiAhAdRR1Qo=;
 b=Qk8NriTUBcD7dGHLwgtA1SfFdHfixzQGvAMpnJX/qu4JUGlrgIq3ITqM3Ffh5k1htX
 cVgtpcHdSThwX99izWUCFYQV3NPjQcKw93yqUOpbP71BLyg/nOyzGeOYuTdsJgf2QtNT
 sqOeST1dWrKrNn1cZMtNieXlSlBdE3TUyc2jz33ENEA0ErvX7rYcCuOtxAQd/nS3Rbsz
 JTP7bdlrtGNXxgdWBRd/MygNvnbkJsVspJ11TveyvmU0sOYpWdIALHWyjLNIaJVX8f0U
 BcP/h9oKAdIg/7OchAwNEeyF/WnMRZskV0r+eRgdiYZnleoRs11oqKUn/Q7Y8SEHA/1j
 46qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIzH4ucK6o1v78mbXAgY+xuBdUqEUsJjZD3lL0cNRRe5MLqicI1M/hmTKKSRXWXI1I/7PPxoBaUeTctXUUbHU6FUCKuw==
X-Gm-Message-State: AOJu0YyRqLvpnILNO9q2/aZt5GRZd4sSwMTuD35HmtGkuadY2LupczhU
 tiT0VO0w4+TC8phX5S4o3jvgklcRzfM6/Na9iCcJTFuxysbLdBaxtUCYc16VZ+k=
X-Google-Smtp-Source: AGHT+IEPQGF8YVyVfEEDkhVO6oz1Y2U5OIpt3zuc7Wb4wFyCGTvUDCTE93BcMUI1mbD7d1hm4ElyUA==
X-Received: by 2002:a05:6808:1156:b0:3d6:2cde:e923 with SMTP id
 5614622812f47-3d62cdeecb2mr6292655b6e.51.1719604171421; 
 Fri, 28 Jun 2024 12:49:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 12:49:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Joshua Watt <jpewhacker@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <l.majewski@majess.pl>, u-boot@lists.denx.de
In-Reply-To: <20240619212330.24842-1-semen.protsenko@linaro.org>
References: <20240619212330.24842-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH] cmd: gpt: Fix freeing gpt_pte in gpt_verify()
Message-Id: <171960417069.3614069.9775527984234668320.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:30 -0600
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

On Wed, 19 Jun 2024 16:23:30 -0500, Sam Protsenko wrote:

> In case when either gpt_verify_headers() or gpt_verify_partitions()
> fails, the memory allocated for gpt_pte will be freed in those functions
> internally, but gpt_pte will still contain non-NULL dangling pointer.
> The attempt to free it in those cases in gpt_verify() leads to "use
> after free" error, which leads to a "Synchronous abort" exception.
> 
> This issue was found by running the next command on the device with
> incorrect partition table:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


