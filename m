Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A29F109E528
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA888406D;
	Thu, 26 Mar 2026 00:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rFJdDwOi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9363583FBC; Thu, 26 Mar 2026 00:05:57 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E06383FB6
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4670676ba03so133292b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479954; x=1775084754; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNQntCRwGG7HR8qhwvo88WwToFx203lUfTqr3kYaPgA=;
 b=rFJdDwOigvVRj9GvKue3uq+PjcntLLAEEJkBOsWsPt+xI6yCiP288Z+DwPTlMdt3td
 BVnF/Vx9L/S7oOOoJ+RL/5f8b7yg4xKH5/TbgpPAu739Xm+Rx2XbhhYk3/jN+HPzg/Gs
 36sRxB/xxgEFy81f3h/0bq7pRlKsX2BzcrJBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479954; x=1775084754;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MNQntCRwGG7HR8qhwvo88WwToFx203lUfTqr3kYaPgA=;
 b=M1cZKCGvgtXsrZtZTWPovVrIU32WStBjRtDGhf+gstgDkDkGp2QH44v2cD/2drdkw0
 gOYkn1yi8c/wnGHKBD0ka2QHv2PfWfY48DPjG12ZbsVHIAJ7RANej/C767RyvZY18GQd
 rQRizKUUd6zjHS3bA//LyRbrTumQE6JE4DMQP7UcDOmvOzrqiioAb+23hRUA84ZFi815
 HTjsPtFndHdVW3pP3xSOnLLMUF42IfK56snJTq/msVeiUIfsN10SXX6t5xwsnrpP/pAx
 f9unsjgZxGHYYTdZw9lCUHKK4ksyTXC2BtRecMydl382kf3giH+d31zR86Wcgp3BGYfr
 uI2w==
X-Gm-Message-State: AOJu0YysZZajJJkm/LwsNwkdw/edfG1shHFAjUVClRzO5e4cDDXKWEF6
 qLSZZpQI22eHKq0tzwz1LVTIZr81znlgSQmuS/Em8mB5KvC76eA/MmQ6LITtcm978AHBNbb5z9N
 HBWlLzdU=
X-Gm-Gg: ATEYQzwD929bvafsouyog/DEKR9OfkEteS1LfUswBMPyML/R31o2SufYvo41r1AFgod
 9FvRzIlqusUZFScDrR8XW3QLgjEsgyoN15ouKwtFXd5zOuWKhSQBsa2ch3hGujcND8+hXETbCAN
 FAUQ7Y1dJmCm128Lkma7rrX/Fw7v+MPiztwIcuIjIREJFr7A6KOaVOtAfM63Z8d2pxG7xrbXGw6
 JKk99ZiiLmzy/39Zb7HwMloxpj6MNAYIB2zBWp/YiZZ3lKn9ROH9FgFp2TSpwct3maOo3P1CzTl
 MtqgCVslW3uJCMm7pXV4SzwNqsmClmUV2mAeOOwG2BsaHv7k46TtrxJfhKB0+NnsNwwssbuzYSD
 5QCU83k4+GCqMoksW4oOl8SKJ5wLroYcadU5gsd0hzwvMc4ddbcsemRKDP4DCgqT+FJJ7/kZ/HX
 uLV/GiMmYi2IG0MY4XFSMghMJtDXwz4TV1U2L4++LK/5EVH9TT48RlKvUBRi2idyyViRDXJJ7KD
 ZjnA1IOxBb+WvgX6LZRbQlsIX1v1Zv1k9i8XRpVQNkKAy0=
X-Received: by 2002:a05:6808:5245:b0:466:f57b:2aca with SMTP id
 5614622812f47-46a5c78457amr2502788b6e.50.1774479953793; 
 Wed, 25 Mar 2026 16:05:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, ozndrgt@gmail.com
Cc: linux@analog.com, Ozan Durgut <ozan.durgut@analog.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Caleb Ethridge <caleb.ethridge@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Philip Molloy <philip.molloy@analog.com>
In-Reply-To: <20260310115938.2902653-1-ozndrgt@gmail.com>
References: <20260310115938.2902653-1-ozndrgt@gmail.com>
Subject: Re: [PATCH] configs: adi: sc5xx: sync command configuration
Message-Id: <177447995212.3508238.7106606184623812314.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:52 -0600
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

On Tue, 10 Mar 2026 12:59:26 +0100, ozndrgt@gmail.com wrote:

> Sync the command configuration across ADI SC5xx defconfigs by
> enabling commands that were missing on some boards.
> 
> 

Applied to u-boot/next, thanks!

[1/1] configs: adi: sc5xx: sync command configuration
      commit: e641ac90c26d4e0bb14ebf16d9b45e895e2135cc
-- 
Tom


