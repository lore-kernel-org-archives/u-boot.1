Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F01FCCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0741A8367F;
	Thu, 16 Oct 2025 00:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JWA8aC06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F4083621; Thu, 16 Oct 2025 00:57:34 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE89833F6
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-64d696840b6so43744eaf.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760569051; x=1761173851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z5x4juXwdGc32iHC+2jd53/Qf7sGAvHEdn+SkAKGBA=;
 b=JWA8aC06LGUxkpionC5Ld3a7NdSFMKwH2DKxWhDwD1dqj6gKxXpnfhspjZrh6CBsfp
 ZR1EgiSLYfb/brvtQkZ37ugBWbraHcRcb9vSFbPxhtXd/ReN/9P+5KDzqRQ52+PEk6SS
 vmzAJPTqM4xx2j7AjeY8WqiTMpvYZWa+D6v7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760569051; x=1761173851;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2z5x4juXwdGc32iHC+2jd53/Qf7sGAvHEdn+SkAKGBA=;
 b=Bbu/5Hq0998/2rEprmwnuMX6Wip3j0hv0Xiz/F2OM55Z2gOVY4mqq/aw3hvunT1pJx
 MgZ8gauNiSyNGIzM1xmV9+rLQztr7RbYNP6meOhHMUMpWKNsWUTQMeoxXWL/gbNdUKXl
 5mMcfqkDL22JtgplsPwZtiVhlxOlMROSoqqQU5MWoqU2Nv2ceRgwCKe8rZxMcsaDZsU0
 2bRg6FCNyoOPZnnY6Xd8yP4D5JxIeWzMf7jmUtZSJfqWRLiHWJWVrRtR7IXALceVqppX
 m2IOOVxqe/r3zSRLOg8wkKScrSHKMyxJ4kX7raB5ZaAxtRroGN+QFzoERKCdlbG62dMP
 h+eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZQsSd28Ne3iBZ8RjF4I8wlJM105sXHIdesw4aA9PR8xOlWdg3BPMYViVRBY193QSNVigL1V8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy16loy4+V9Uwh9Ct61+sUbww2uopK+FI+q48kcYandpIDhlAOV
 8f5FkygyrxdjwUYDJGCa8sWhsRz2pzL1spf3ifnzoR3RyUz9QzhdS/Oml+LkEt3lqgjB2vihu1B
 1dtu3shg=
X-Gm-Gg: ASbGnctdsa6eaAiDeW4hDn3cdlQJjKVvBV4g0ayeXZC7g3/pYn5Zz2m6jHxPP4Lhj/J
 W3zCMPEj2eEvKWi1Th370LiG1R3pGnDKvg3kVOwtFBEloMHKeZ1eFRJuQFMORIik/zXcEC9Y/JK
 RACIyDhF6t22ry2clMcrDdmQ/cKIMavOFY45T3cTZBVoXSIJ+h7Kd1w35hVXbKJYSXmbp2Gs4hi
 DFEl6bqWn26KgAjchjGsxsHxonae6wtoUf+YoVoYbkQAUeAX0f/bRHstNFUpiScVhVCyHfhWHfk
 TzpG7y92rIblx4uQRGd3Qboo0VlE9Ck02Ui51tOoXWSfyN+IKcIoVElBcfqMkRIRmxKG69fl2m7
 GlAT2YiA27RPyJp0QtWZARKLTLvmWWsiH3N+Djv6ybFc1YECw1Dk83rKTRykzWC+TlIdDAF6LAm
 IHxKB6QOYSjTvkLJ4mWQFT3CQuxbXGurHLOIOIBtDnYB445Wic
X-Google-Smtp-Source: AGHT+IEOyZF7fMSDiTnyTUBlTuL1QDsmbTmcgkKg9Sqq85mf7DiBHBeQJDHpdfxVRT1v0LqXIaVAOw==
X-Received: by 2002:a05:6820:418a:b0:64e:8106:bb91 with SMTP id
 006d021491bc7-64fffed2959mr12197593eaf.8.1760569050725; 
 Wed, 15 Oct 2025 15:57:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5774854a34.29.2025.10.15.15.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:57:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: s-k6@ti.com, Neha Malcom Francis <n-francis@ti.com>
Cc: u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20251008113435.1437532-1-n-francis@ti.com>
References: <20251008113435.1437532-1-n-francis@ti.com>
Subject: Re: [PATCH v2] cmd: ti: Add DDRSS Inline ECC Error Injection command
Message-Id: <176056904969.760819.7266942092553878962.b4-ty@konsulko.com>
Date: Wed, 15 Oct 2025 16:57:29 -0600
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

On Wed, 08 Oct 2025 17:04:35 +0530, Neha Malcom Francis wrote:

> Introduce a new version of the Keystone-II "ddr" command for testing the
> inline ECC support in the DDRSS bridge available on K3 devices. The ECC
> hardware support in K3's DDRSS and the test method differ substantially
> from what we support in the K2 variant of the command. This K3 DDRSS
> command currently supports only single controller testing.
> 
> The ECC error injection procedure follows these steps:
> 1) Flush and disable the data cache.
> 2) Disable the protected ECC Rx range.
> 3) Flip a bit in the address.
> 4) Restore the range to original.
> 5) Read the modified value (corrected).
> 6) Re-enable the data cache.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cmd: ti: Add DDRSS Inline ECC Error Injection command
      commit: 4e4bbb49f9298ee8e5891c168ea4d6aa0463d285
-- 
Tom


