Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC420C44507
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B4C84D45;
	Thu, 16 Jul 2026 03:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hXyuzaFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E459084D6A; Thu, 16 Jul 2026 03:08:59 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37ECB84D45
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 03:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6a190528769so1642715eaf.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784164136; x=1784768936; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bmu9dmFM7Npnk54gIyuGcAI8b6AKDyJfoPXE0jos9Cc=;
 b=hXyuzaFApvfgr/N3RPnUfN8Wd9i/AI/iTUEr6/OAnKsOPnPGw4URPj0PfRpKYD/+IH
 2nrFsZNh+d6b+KqUVIi9Nh2xffmr99e8/9bOcUXjR/jTLHT+K2+OjQLJokQiRKCBKLoF
 C4Uj5gqrT/7SNlCDwuwDLFOvdOhSyGAPeFwZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784164136; x=1784768936;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bmu9dmFM7Npnk54gIyuGcAI8b6AKDyJfoPXE0jos9Cc=;
 b=C/Td+2xQAuwSYxzVi2PKY/xDxC+nA+FRv8p2B9HMzf3ZIjSLh5c2i5SoHuY/FOdmLU
 p7b+2OiDSzjZLCgW6ktnbfVypA6i9Nu6M9RfW8Ci6PEJfgT6rwB2uY/rlGnjSaX2Zaet
 0l1ktasoy5wzWIiJKbtjWqViCDvK4S81ZRLJiaw5awJYeZWAaj6TXQxV0UlfVF/Nusku
 K1b+1JwN19V9vAWxavuok582XgktsIClqQmsO1zHajw9oDeQvswL9mUuMrisjHtNBSzf
 k5xiFxsTF/329pSKS+7HUeT8th+KWxmcMA+a64jIQKhrYW1bldMTboUd08cbqv5wjH+D
 hqHw==
X-Gm-Message-State: AOJu0Yxg+GUU205ek8FGgOdwRzQgde8m6bNQ5MUfAM0maRN4WcNHxgtc
 2LIGSKVeXaZ5TftymfuI47NWDeiVPJyxJSZx3g8/BC/kVg/b5pPu9Kyu/gXm9Wtq+cO+etoyov/
 5yE6C9lQ=
X-Gm-Gg: AfdE7ckzlc6EiTtAm05jd91jbGSAJsXUiwi855PWRiLBpB/3IWlW2JJF8AVlnVJ4A5L
 7Y8BzUlwf0PqBoneO56LwEbGIke3TgavXRHOodDt2vK3RMrLR6tQkVTi5LGpEixc5/wtQwJUYZg
 yGf6943dSktYTY1IYSdOLFknIlNHanpGnYK1XciPyU0OHY7OJzsJlo6+ptbc2XEVVC3i+aNur0/
 OtMi9AbrHC8j2bfxtgnFnRZvCCeL19GWAw0e28rrGbVwjfhDJRtE8mg8KPmud2HqCpDS0z9uPP4
 MLfG85Z5uUxhBHMOlhLRFsSjIA04LKUUZavjjpvazaWCtPIwqLS7DLUlDjntaZ1HOTg7R8nuQG7
 cxBxjuVBZcH2wwL3Yf/qqGoDw+2tDZHUf9hq69/19rviPMGhPkWFI9FzQkcUzM47ztD7yddO8HL
 2bnW7LCFia1BLbrgAlFrRTnYSthO0Se+/FJzzRzy0sfKGukoRFP+kbMOfOVMKqKgHAgqJTRt4w+
 SECoVVrRKiqwMysimG/k/gHPA==
X-Received: by 2002:a05:6820:a0a:b0:6a1:40ad:cfa9 with SMTP id
 006d021491bc7-6a3d9c2f265mr3133108eaf.0.1784164135838; 
 Wed, 15 Jul 2026 18:08:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a38e9bc8casm11503854eaf.2.2026.07.15.18.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 18:08:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Bryan Brattlof <bb@ti.com>
In-Reply-To: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
References: <20260624-335-ddr-cke-delay-v1-0-21d65d40a83f@ti.com>
Subject: Re: [PATCH 0/2] mach-omap2: am33xx: ddr JEDEC spec fixups
Message-Id: <178416413466.164922.1815779899316696582.b4-ty@konsulko.com>
Date: Wed, 15 Jul 2026 19:08:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 24 Jun 2026 10:35:06 -0500, Bryan Brattlof wrote:

> Someone figured out that we do not wait long enough for the DDR chip to
> be ready during initializing. During that debug it was also discovered
> we don't handle warm resets correctly. These 2 patches should fix this.
> 
> I don't have a scope fast enough to prove these patches have fixed the
> reported issues but I am boot testing (cold and warm resets) with a BBB
> at my desk which seems to be OK with these applied.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] arm: mach-omap2: am33xx: ddr: ensure proper reset->cke delay
      commit: b158ef7c445a1ab66134c410c901766d0a73e486
[2/2] arm: mach-omap2: am33xx: check VTP before reinitalizing
      commit: 3ddd0f9bc879ab62522164b50c41181e909b9a0b
-- 
Tom


