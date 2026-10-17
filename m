Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF5CCA463
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 04:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0685F814BE;
	Sat, 17 Oct 2026 04:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8c71I6TEV6bG; Sat, 17 Oct 2026 04:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2D9108149A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792211789;
	b=R3U19s1MbeY02L6R9qUPdHE5lNw5ByPdhi6tkor+A+hv9VMlf+aWCWGcGdgKVJdv9+5U
	 MZZiZQrsaxetx1F86b3eFjoK3z7bXDhOygB7MlgVqMW6dD6MmzZ1agysW8T4kVvUaX02i
	 bgTZCeh01T91o5Xa4soPgHhbNcdTBbi+x2N/EjJ2Brdgi2UG2QieG42lDhaeWP2+nfYJJ
	 sfd3Uc+uBaHpMP7yv4cqWa/cpq/PrX07ywDoSx5ID4OiXYsnSwtv7TZAJEDO/17mzZato
	 heSKdUvjYtkOm8JtPLZGRJRddN0Ym39XyRh90qvJLu1wC4rrDQdUsjBdwT/708vbrZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792211789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+8yCL+/zTQPmbVurkp/ehtWN4wh1Cy2SGWRQY9zJ4zg=;
	b=Aosm8EzR6DOSVsZs3V68D8fm+WOZbyxtJp4iOWZEitCzH6/O3brRYAflu2sFNaHy7NYe
	 tUqtefX31FaKHKLaQ8QlpRn+tpCVUu2+8LhHxQTVJhmiUGkYTIxsKPjgy7TGaxotQ3vgT
	 qSpJGJRxlnizRnN+IYV9u3Em6BswnBHHqZUWibTb4vIS1C8sHEhV/fZLZJFAU+8brnX9p
	 MLECQOjGHpnlOAXjWNVLdFAOPAgzeEWDuhC/7wD3kXvM3HUn1VRTSOu5SDEDW4La/Mbnx
	 OPiQgDjCBlQnLmybE5Fljz0zdK1YGpw9peZLPkJYninv3Nn1ytgkHjkWNpC7kbSxvpg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792211789;
	bh=+8yCL+/zTQPmbVurkp/ehtWN4wh1Cy2SGWRQY9zJ4zg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VUuJe5/3HbcJOsuX4yDNqHbxaxT5NMef1SFqnK1yHI2KLv7K9BH/h4MYo8WdhznEP
	 rTcgnzNSAniLSIMEsmMGxsQJW6o/ewtamTrtGqqNBvTb3zbN+MCnWExrJ77/+y/pyE
	 NncBqgwXgsdiSIIjMpWfYf1GrlhuEiwApt9NOPcvedS+sgo2B7d7ortxwWZ1Nzze3F
	 2Nv3ayB+oj4miwUs4h6mZgUBd8JLNeGrXJHSkVblcMFLXQrSwuufpnHxUATX3wOuZT
	 uK76NpjFyf4m+Hu8qTtUESsxfFB0vtwUQ9FL11zoZtp8Dd0RagbphjTXHOZSF6iXM5
	 FIpHISiUcy9sA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D9108149A;
	Sat, 17 Oct 2026 04:36:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24186255
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F29B94081B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h32oXNT3ONbL for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 00:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24E8F405E3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792197342;
 b=PCZWJIwA3diM4dGUxwvt3MitqluzA5WCRZ/z1EPODHWHmz+QGJHwQKGvUmoFeADqzgQM
 5LUcs+dBmpE+hHtPwJWTCJy7IoUSQEkzekxZhYRgZ7WlDf8VcFZhzF9eNXeg6Ei+nOJAI
 Deo+wVH57OrIqTHqVLvWbuahtlG5e345xQ5w4Gs9IOyvEp7qNEDfP5+5yVEJ8R+OgrhwP
 Acg0LHumOFv5A6o8XoAFUr33xcUrR1c88bjHQic4iwaoV7KiPFnJmnrv9MuERwB8m5Tvc
 OPc5+aFqf0svN2gcyEjK6SI7dYTg79jShr+TePSe9xEjyQuRdb0FIOCyoyCiLSdlTjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792197342;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=+8yCL+/zTQPmbVurkp/ehtWN4wh1Cy2SGWRQY9zJ4zg=;
 b=rulU6ag9QdP0ZkR0t7NmL+fzImbe1w6tXOfhsvVa6LphI102yEwumU7Ct3biVG6bn2yy
 a8TsuIV/4To3XqnJTFT1dI/ADraoNU05CB37s5mDJ4rcyoFTovvewf+YwX+miBIyRaHMG
 kc+zAGHpn6pESnFwkjG1ztxbC02xQLDfgpa8mJgkODmKbySCVsIieBXjudddmjeJ4mlk2
 dHUYSBLNM2J0Bpz9lXxAdNtjuUShEp6VJ4b1qbcR6uyUS7jMywFgV8d6EiHfNgY8z1nkC
 0wTZ2/SirmWVmUoyokVs5LMBtvo+xydmbkUx7HuE2U9poQHxMxXKBlTO3XoJjg0K2Gg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jY3vSvbA; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jY3vSvbA
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24E8F405E3
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 00:35:41 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-48e94879f02so219537fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792197341; x=1792802141;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8yCL+/zTQPmbVurkp/ehtWN4wh1Cy2SGWRQY9zJ4zg=;
 b=jY3vSvbA1ZL9pnVm3e53bWqHcD9HVRU/Pqo2itUuFpDQrH0HwfrSdtubT3Xr2TfFrI
 WFcHUHjFNB/gltnLPKt9kSK6e1zLvyOhxTiAGu2unjp+HSdjsmr2rqlZtd4X5D46a6J7
 eqAvjsQ3o3KIdvGP+HYog+QxauUOCwLJNvBMmeKsel94dbu5m5l7jJmNDynzMOmpz0zB
 XpvV7kUntjN8+cpxsgPwIg9LgvVpmm/Xm8DeojAUr3aeetqsjt26UkCYojTRQ8jHCk0S
 NMdKSX9UIPE63t0B6h+2nlG/iSLXl6cqH80C/8fctQLmbd3dRCpvCQp1sZvmKPfaSswj
 18jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792197341; x=1792802141;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+8yCL+/zTQPmbVurkp/ehtWN4wh1Cy2SGWRQY9zJ4zg=;
 b=xN42nngz9eIItatYyowx0hq5CznLijxMYNyyogSVk71HNHv00zIA4BqXmr87KfxFw+
 kEfP0RcPmkXMQvcq4CtiR3aPU/1+7oPQWwTekRh2Tfjr23Hi2fMBgeb/dEtuIEdT27yp
 h8gFT+aIqBnwfetjyvKW5WM8ERDU7zabV6L1Xl73rb5UuE1ZvLYPQf0a3CuUyXKBWqs1
 Ah7GIUA0i46DWVrqj9GH8XYC90Az61Zzknv3RUmPKF7LwN9TD1Xo0Ex6kcaeDyB283UC
 YWfIhLgma7BHjJ6V9mxmJWJFD3xsP3USOLhYxBzB8nD4v23dLSCXBWKpXmyF7ilAHSDd
 d+yA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpgMbSCn+lhhbqrGC80mgxje5+FsIm4myepnUy3Zd356CW7pOQhZrFZ4RsFVM/V6Q5qj5T7vY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKkoYIbjn1wztqv+Q1k6tEPERZRbXVegoDICG2fkawzG37Aa5Cy
 KWk1cRT19Hxxz3NlQZfNsf626KlyOzYtatwXpUzVybRWYAYbEubWt6M7
X-Gm-Gg: AYBFou3JA6buDn1PpRBuG2Bz3L4kdRL1SDjf38R/ZcQCrKWKQvS4Heq42EKGhbbjn31
 Uvq4b3UO6k8ovEH3Bl2xSZhH/kX6bDqVpagnidI8iJqAeynrztmm6mxqhcIdPj3/t1XekT32BdG
 7DLkFs/+uQxposFy0Byn6dSBDnGuVhrevnvPOGtEbjihYn/Q0zdFqIYou/Jn3wmDLgu6/osG8aq
 FzrtQIX3WhHw9Se5dvHKzC4xar5/itGaUh8q/D7ufO72ZZt9tXnKBgBxG3naw/VVDYDqjLlDK5v
 vR4s+UduLk5TLyW7fDYxgXIhL+Hk60dlOGhzL6jba3wDiGm4LxtliTLU+Zp8oj8DsGHOGL6p5EF
 H4f9tzE45OlIw4kUt3u9LPrPWJ0FFjBGLCQlaScmx/Y59gw7oSVTGoHYKLCzP5fVPODfu9lsdRF
 7GP+dhnLgNOHgI1WgJwTyh7EmtbACihobXsMNROzuGYKgZ1DT/Oo70dhj3Mnjr+xByLZ5Dl46GS
 2HfCvP/KOidaR/G/B53wUue0kiQszAH62FQiaFl3UrzEwwIeHID60yNE5V51mzc7HvmnMKjQsPq
 8v1/I5CtN59n9EjDz5542CZmlWMNay48KfFcn3i3mKotO9wmJNMrG2H99ke8bEjWydpwYe0S+Ny
 8qk2dGmWqSsQk51vLSU/LEA==
X-Received: by 2002:a05:6870:3349:b0:49e:1c69:1f57 with SMTP id
 586e51a60fabf-4a7579fdc3cmr1345162fac.41.1792197340643; 
 Fri, 16 Oct 2026 17:35:40 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a73b5b4291sm2745091fac.5.2026.10.16.17.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 17:35:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 16 Oct 2026 18:35:17 -0600
Subject: [PATCH v9 03/17] crypto: hash: allow DM hash in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-submit-ce-series-v2-v9-3-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
In-Reply-To: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 u-boot@lists.u-boot-project.org
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>, 
 Raymond Mao <raymondmaoca@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sat, 17 Oct 2026 04:36:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL cannot
enable UCLASS_HASH independently. Any SPL code using hash_digest*() has to
rely on U-Boot proper also enabling DM_HASH, and the FIT hash path selects
the driver-model implementation with a non-phase-aware preprocessor check.

Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and use
CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. This
lets SPL FIT verification use a UCLASS_HASH provider without requiring the
U-Boot proper hash uclass.

No in-tree configuration enables both DM_HASH and SPL_CRYPTO, so the
Makefile object key switch does not remove hash-uclass.o from an existing
SPL build.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - Document that no in-tree configuration relies on the old SPL object key
    (suggested by Tom Rini)

Changes v2 -> v3:
  - Remove the bare software-hash fallback scope
    (suggested by Simon Glass)
  - Document that SPL_DM_HASH needs a hardware provider unless a
    phase-aware software hash provider is added
    (suggested by Simon Glass)
---
 boot/image-fit.c             | 50 +++++++++++++++++++++++---------------------
 drivers/crypto/hash/Kconfig  | 13 ++++++++++++
 drivers/crypto/hash/Makefile |  2 +-
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6ab6c6c7da9..0ed809aa1f6 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -33,10 +33,8 @@ extern void *aligned_alloc(size_t alignment, size_t size);
 #include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
-#ifdef CONFIG_DM_HASH
 #include <dm.h>
 #include <u-boot/hash.h>
-#endif
 #define aligned_alloc(a, s)	memalign((a), (s))
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -1325,43 +1323,47 @@ int fit_set_timestamp(void *fit, int noffset, time_t timestamp)
 int calculate_hash(const void *data, int data_len, const char *name,
 			uint8_t *value, int *value_len)
 {
-#if !defined(USE_HOSTCC) && defined(CONFIG_DM_HASH)
+	struct hash_algo *algo;
+	int ret;
+
+#ifndef USE_HOSTCC
 	int rc;
 	enum HASH_ALGO hash_algo;
 	struct udevice *dev;
 
-	rc = uclass_get_device(UCLASS_HASH, 0, &dev);
-	if (rc) {
-		debug("failed to get hash device, rc=%d\n", rc);
-		return -1;
-	}
+	if (CONFIG_IS_ENABLED(DM_HASH)) {
+		rc = uclass_get_device(UCLASS_HASH, 0, &dev);
+		if (rc) {
+			debug("failed to get hash device, rc=%d\n", rc);
+			return -1;
+		}
 
-	hash_algo = hash_algo_lookup_by_name(name);
-	if (hash_algo == HASH_ALGO_INVALID) {
-		debug("Unsupported hash algorithm\n");
-		return -1;
-	};
+		hash_algo = hash_algo_lookup_by_name(name);
+		if (hash_algo == HASH_ALGO_INVALID) {
+			debug("Unsupported hash algorithm\n");
+			return -1;
+		}
 
-	rc = hash_digest_wd(dev, hash_algo, data, data_len, value, CHUNKSZ);
-	if (rc) {
-		debug("failed to get hash value, rc=%d\n", rc);
-		return -1;
-	}
+		rc = hash_digest_wd(dev, hash_algo, data, data_len, value,
+				    CHUNKSZ);
+		if (rc) {
+			debug("failed to get hash value, rc=%d\n", rc);
+			return -1;
+		}
 
-	*value_len = hash_algo_digest_size(hash_algo);
-#else
-	struct hash_algo *algo;
-	int ret;
+		*value_len = hash_algo_digest_size(hash_algo);
+		return 0;
+	}
+#endif
 
 	ret = hash_lookup_algo(name, &algo);
 	if (ret < 0) {
-		debug("Unsupported hash alogrithm\n");
+		debug("Unsupported hash algorithm\n");
 		return -1;
 	}
 
 	algo->hash_func_ws(data, data_len, value, algo->chunk_size);
 	*value_len = algo->digest_size;
-#endif
 
 	return 0;
 }
diff --git a/drivers/crypto/hash/Kconfig b/drivers/crypto/hash/Kconfig
index 72b955ac791..272af7bce18 100644
--- a/drivers/crypto/hash/Kconfig
+++ b/drivers/crypto/hash/Kconfig
@@ -4,6 +4,19 @@ config DM_HASH
 	help
 	  If you want to use driver model for Hash, say Y.
 
+config SPL_DM_HASH
+	bool "Enable Driver Model for Hash in SPL"
+	depends on SPL_DM
+	select SPL_CRYPTO
+	help
+	  Enable the hash uclass in SPL so SPL code can bind and use
+	  UCLASS_HASH providers through the driver model. This is useful for
+	  FIT verification paths that want to calculate image hashes through a
+	  hardware hash accelerator before U-Boot proper is loaded.
+	  HASH_SOFTWARE depends on DM_HASH, so SPL_DM_HASH alone does not
+	  provide a software hash device. Enable a hardware hash provider for
+	  SPL when selecting this option.
+
 config HASH_SOFTWARE
 	bool "Enable driver for Hash in software"
 	depends on DM_HASH
diff --git a/drivers/crypto/hash/Makefile b/drivers/crypto/hash/Makefile
index 33d88161ed4..9f0d30f9be3 100644
--- a/drivers/crypto/hash/Makefile
+++ b/drivers/crypto/hash/Makefile
@@ -2,5 +2,5 @@
 #
 # Copyright (c) 2021 ASPEED Technology Inc.
 
-obj-$(CONFIG_DM_HASH) += hash-uclass.o
+obj-$(CONFIG_$(PHASE_)DM_HASH) += hash-uclass.o
 obj-$(CONFIG_HASH_SOFTWARE) += hash_sw.o

-- 
2.53.0

