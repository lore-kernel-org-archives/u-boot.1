Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7F5E6FE4B
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 22:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC51D88D4E;
	Sat,  7 Sep 2024 00:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C4kWcmdF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE52988D52; Sat,  7 Sep 2024 00:38:01 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0A288D4D
 for <u-boot@lists.denx.de>; Sat,  7 Sep 2024 00:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf92f96f83so13560336d6.3
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725662278; x=1726267078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loSPyIzvcvUAtTFrCDQRrPFIFfacriUDnETZZ1rdWrw=;
 b=C4kWcmdFTZR3rUKPkfLLyDY9HU63bonZ5BeK+y+ngFhq/dQfP2cqFMZkU1les8yzb0
 iX/zMiNA+R7Lz3ciM13XrKwrootzdDPQkAk0mMMDGDJ2W0diF6w+ALi7XAyFLkJDkNBE
 lU3gVeEBv/5kNY4Kj1f/gyN+6rWT3QLKSy7Zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725662278; x=1726267078;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loSPyIzvcvUAtTFrCDQRrPFIFfacriUDnETZZ1rdWrw=;
 b=eK/t2yJO7DHvKVywlyrWjB8/vDYrQ8V5H7JoHOkntAEPhDEi3TQt+u3z2omHB95dtY
 nW0Ez+3HhxQKiXXd0U1zwAkgPyNKSs8WTWkfWaC7dREkKb9tXiDSNbrK+TWvnp1rrkKw
 vklAsgXbOKGR1TwsCMF2SfMCpVQZqwIzXE4pyIlZRWlgXbuEwUb4OQOvoehUht3FWHlf
 VsJdvYOrsgwJlyvrM8XkS3brUBWh9BM9U5k/c45/t+XKp9+dQupZQsC3mBF6TfjcvowP
 VtWwQjmMVjNgW+GhCvdSjTlIdyb/yZgR2v6BMGPC6GEejarrFA6am8dnuT51stEdY6bL
 qW8A==
X-Gm-Message-State: AOJu0YwMoZ6pavtKeS7nkpctbvy8b+kHRyBPC8sDwXQIyIK5psetd2q3
 jzu6Llx1syg6CdKKZ11OHIPlQT9/WDLfE9cWFshSpf8AHIQczNKBIqp8FqvFCZU=
X-Google-Smtp-Source: AGHT+IFKl9gUp3AFTuaiDDmCDr1Dl0w0OJOYR9Ku2XPEyzEP3usTR1r6VZ62u82+c6KeaDSFAQogig==
X-Received: by 2002:a05:6214:5508:b0:6bb:a329:5dd1 with SMTP id
 6a1803df08f44-6c5282f913emr39958146d6.8.1725662278212; 
 Fri, 06 Sep 2024 15:37:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201e47a6sm20481296d6.55.2024.09.06.15.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 15:37:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240815195746.749042-1-sjg@chromium.org>
References: <20240815195746.749042-1-sjg@chromium.org>
Subject: Re: (subset) [PATCH v3 0/3] This series adds a few patches to make
 it easy to use the system dtc in
Message-Id: <172566227676.3908710.3568578988369610881.b4-ty@konsulko.com>
Date: Fri, 06 Sep 2024 16:37:56 -0600
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

On Thu, 15 Aug 2024 13:57:43 -0600, Simon Glass wrote:

> buildman. It updates CI to do this for world builds, to save time.
> 
> It also includes an old patch which is now needed again since:
> 
>    e13fcae3fce Revert "buildman: Always use the full path in...
> 
> Changes in v3:
> - Drop patches previously applied
> - Add dtc patches
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


