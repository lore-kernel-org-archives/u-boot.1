Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB122CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 11:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 751E7830A0;
	Sun,  2 Nov 2025 12:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="liwdgNiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA8B83642; Sun,  2 Nov 2025 12:06:24 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC118307F
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 12:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3d56d0cb3dbso1972561fac.3
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 03:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762081581; x=1762686381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=39JmGOlNFi7B1rAeBrE2rNPHnpGhBfXYPhXIl2ipxes=;
 b=liwdgNiX305M4ffWaojSqbIk/wvjoIb3wmC47bbdMv6hUN5BEieYnmsb5+jpmJBElk
 Rtqft3VJ68sg/aLtcIgovAaCYY0/akHNQhG0AAjYB0tft6Ls4uGeSzGoTAVb0U87Tyd7
 /oHzszsrwxAWtw4BwS77qyGs29c1Gsl59Oajep3LgqLak2a5/EysRl9XJobzpz8Ty20R
 KtBxGQPYYWpGIpfEskQnUiANhepL1CYV2dncvzLTr/Cj6TkYVn8AKuTcLB1/BtH8BI/H
 86tQzUvB7TjMiVOR0h6ldf5VlAYC1AH5sqEbVzdjpGkysklUFMmNjpL83Bqtqp9La8X5
 FMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762081581; x=1762686381;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=39JmGOlNFi7B1rAeBrE2rNPHnpGhBfXYPhXIl2ipxes=;
 b=g55rYXZrnZkTzZT3A3TQbYyu2M63sFR5VJhTPyEgW+w4H02jyaY9A8xnCJ0yHHXwGi
 ekRwFZDN/LBELcbRHsp880zjL6uH1BD6NcSEKwREFENiarwBSYktuH+v0+Xzh1mQqvxJ
 WDE7FSS3JgFQ08fr4I9k8U5qPaQ3s5CfJLNIXEkFEbAHfv86dwg/p5QWqqatD7O5hgZY
 mwE+HeqqOqrxf/fpXWiRpANtpFDQCdRdKidZ1P/JSmCZZCSjZzmA+vkwKQo5/oWMhKAN
 JvgFF9u86jFfZ1yGDAXEJ0hmriftYO3e1E4adlMWV1WNFmlEAWCPRnoDwCJzGS0OQsmz
 mVew==
X-Gm-Message-State: AOJu0Yz6wEGxzUOgQ0qGGedsjSQAJFxjKn3iAQABiWrqqtRn0LgeVPDq
 oSHcpjN5jePv5IBimtDQe3SHCf+cINyayJJ3BiNDIgMf82YN0lw2GnoNk0qhgB/ivQX8OBa5VKr
 d8JxbnqFqHZX3/TNgAanD4QEekalJq2o=
X-Gm-Gg: ASbGncsWB9FheGwXWJWEj4BqeusgmVXQobw3grcV78NvirvKg4H3ePSkqq6yL5KBdZ+
 CbMTpgtZOCCaTgtpNkYrm/Y28SW+jfW7ZK5wNtNlkwDeVDFU7Knk4TWzWMOxyI2FVUpk05fk1Hy
 7vLqlVuEX7oc0nVd/rdsQ7nnzI5GYmFELDAENzgULvhnpHq19YVbdSzbsh6zeputfU1K4O+dsoK
 l5jFbSyphrIlhaD3fkyqDNqhhqkhSm3MYjHN8dxp5NfVGimCdfUC5ce/GhT1Fa6Jww4Pok=
X-Google-Smtp-Source: AGHT+IGl72p+YSPSz42kP1c2SLpAY/nIZxTZumyamjxEGL+znGkRk2tqKm93O8Rk0vNLvkeEMfcycPIpHFwnc928m20=
X-Received: by 2002:a05:6870:9610:b0:3d4:97:cc1f with SMTP id
 586e51a60fabf-3dacbfbc58cmr4241565fac.26.1762081580707; Sun, 02 Nov 2025
 03:06:20 -0800 (PST)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Sun, 2 Nov 2025 19:06:12 +0800
X-Gm-Features: AWmQ_bk9MsiYOSzkNxrvohUvmeZ1MLx3h9fCp_TirvBxLiiA76x2JIOkarAV6iE
Message-ID: <CAN7C2SBCqmxE_s-YTpRbXZjVGgP_Jyr_CGSxTMHNLwf=A4RjKQ@mail.gmail.com>
Subject: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and Fixed
 regulators"
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

- ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
- if (ret) {
- debug("Regulator vin regulator not defined: %d\n", ret);
- if (ret != -ENOENT)
- return ret;
- }
-
- if (plat->vin_supply)
- regulator_set_enable_if_allowed(plat->vin_supply, true);
-

This patch resolved the previous boot issue on mail:
[DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD power-on timing

Quotes:
"
While testing mainline U-Boot (v2026.01-rc1-00070-ge34d01d23e45) on the
FriendlyARM NanoPi NEO4 (RK3399), I observed that SPL sometimes fails to
initialize the SD card with the following message:

    spl: mmc init failed with error: -5
    SPL: failed to boot from all boot devices
"

So the NanoPI NEO4 boot stall is somehow
caused by the previous regulator patch.
However, this is very puzzling why w/o reverting
mmc works normally but not SD.

So the delay method proposed by Jonas in previous mail
about delay timing is not the actual root case for RK3399
NanoPI NEO4 SD boot stall.

Brian
