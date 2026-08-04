Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA25C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 22:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2CA260792;
	Tue,  4 Aug 2026 22:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRuIWZZX_z1Y; Tue,  4 Aug 2026 22:33:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 302376066B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785882784;
	bh=pTp12NDzCvuFEor5DWAbD6lra2hpW+L+Tw1kzdCJPWU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fiypH9FKF4FkGADGvZAA9QXN8Qoq/hQJh2loACRm1a8PuB3vQkZc2kKCqm0pLHlim
	 TQu5S2xlzI1x83OehoVVGaIsUuJYr/yNPJHATXOrmWAHnVkznIrsZsqdBM4TJJ8JdC
	 6TQAVavqzFVBzSZXVIKKisM9p/NafPb0VpHHXbgtCGq64LcV+FFgcr2YXT/XMJxPDO
	 TY9FPnv1tI/7RFCiNnJVq9tSu7hxlzX28rtOUIj3xFZrJKewzaV5+MJw9VR42qnWry
	 SK4oAb9HDjV/UkV72Gk+I0uysB+4eFLVmBLGgrziOnJGpSfIoZvYqrLrVKseMWOPkH
	 CdVHcUEtibjRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 302376066B;
	Tue,  4 Aug 2026 22:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B272E218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFDDA40731
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaSkEnKVgmrT for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 22:33:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7906D40506
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7906D40506
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7906D40506
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 22:32:59 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6aae90e595fso212826eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 15:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785882779; x=1786487579;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pTp12NDzCvuFEor5DWAbD6lra2hpW+L+Tw1kzdCJPWU=;
 b=cyzOUJWqGMGIafFbkan2IbukupucmaY0o9ndJpEBT4pemi31RMvlsz5js6KW0tRHI0
 JMBxKwMsfI5+B0oM7LDnmpirR3y4fbAAPbJYEoNHCQxIcsfENZJuI3EsOA0KL1QWTwCj
 VVnMvp1iNBAG45igzyPTL5vQUbtvrRfWrYCatGUrNuQT24sfxM2O20ihGwJaeuAb8m5N
 TNOgnafBjVcIG3+83J2FE/7TZgSHtkrjWoP+KgFCUWeMuHwqJ5SVzbvzY7K1tWgs1mck
 ECYXQktNMs3oE3zxkWiyVJhQKCvMsdij2nUw35I+uXE992FawHOybTtXNLK8YO9Raw4c
 ZM2A==
X-Gm-Message-State: AOJu0YyQr8mMHnkdl+tNJG5bdabppxov3AK0o0q8PwZNV3eiN1291RIk
 gpD3PFVBxqPSUmJeqvi/zmV6Det2/9yPppIp9+hHptRqA8wKPjffSEe31G7qETFvfj4=
X-Gm-Gg: AR+sD116sbfbXqwU9D8Dm81UboHYCJMc7JCPULl69d0CoHlOMBOqMBmtruKq6W+Kid9
 uvkN+/MHqFRSSq/97Ny+xQtkJltn3Q3x/qc+7JJmqBp51uwG0sBDXmNWSFI7Bk3+y+e7/OHlj68
 kbzUhEFYq7P1qeibZkICLdwnofWDAO18RUEruaIqjRTYMu3LAWchjrysSjW8kZ02UaeIeRVx3fo
 33FgTtx3k6QxTlQ8aAcdee5t6wIzJju0X0v4cC3GpvZsCaMIE2sHHKPYnTaF/p8+k44oROpjFvQ
 dPuLnlcTbefoDXH1D2GISB5eRFqdmimdPGchYYwQN6UNV6z3BycX1KwrlbUONlrgh0njmDb/++w
 hZje4fmwxoxubasCVCTO6yBXim7Y8ZPFTHKq/pm5K4o2y7nked7I4UJRcvK3eV+80lRAHkpiSMK
 NV8hgVmg4h5JKeFferM7f7SGuAy+rAZJvDKprfBhSooyy2U6eb2KmF1IYRtjB7TwXXfQ==
X-Received: by 2002:a05:6820:1889:b0:6ac:c1b4:1a21 with SMTP id
 006d021491bc7-6ae96c1b323mr1445946eaf.6.1785882778821; 
 Tue, 04 Aug 2026 15:32:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a444:841f:6b21:eaf5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6ae93d524d3sm1016111eaf.6.2026.08.04.15.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 15:32:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] power: mediatek: add MT6366 PMIC support
Date: Tue, 04 Aug 2026 17:32:00 -0500
Message-Id: <20260804-mtk-pmic-mt6366-v1-0-f3b36b8a1a47@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWtSJRO8iljQThnikhaRiHdX7
 M63OP8FnhyThzK6wNHBnpc5IIkj0H0zdyTYBIOSCmUuMzFto1gn1mFgiiiswVSjLIxVDYTX6sj
 y+RWr+rff24H09mbgvh+a6QVvcwAAAA==
X-Change-ID: 20260804-mtk-pmic-mt6366-fd63c609df2a
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Julien Masson <jmasson@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=wGZ2mAURsyPCpHnvD1GIlksuHXEWRhTwE85scz5S1oo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcmhktTG8FUV1tVp46QVNRCAQCurDkItVP14Fn
 KPMfaJzlvyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanJoZBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUFcH/1iL2XmsFqh5xcAFs6ee0NBal8U5TyqO523wQAc
 5KbWIVVXNq1Ql5Vq4f8DN5zzUluZGwdfkzzEx/7Hk2QO2J0z+767rKrFU/P0lSgzD9d+JPAShmx
 RrNmop72YSl9HqMphp0+bfcXsRvCSgLoFug0E6A3KChl8CZZ1dF7lNk/SC0r9dQmQ0463JYvEEw
 wACaOoteOlnHDK+AwDFB3A3FWHocx52TQ1QTkxbvKmdoMbFA3ah9HGeNqh6D9xAEjYuI3ezeyLh
 uwUuHriqvLn7uRlY1MUkCLQIMPV+u2jgrPOdIBGF68b90/dQ/rd2tqOan+glKsm1D0/jjSju3oU
 xv+E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785882779; x=1786487579;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pTp12NDzCvuFEor5DWAbD6lra2hpW+L+Tw1kzdCJPWU=;
 b=HXZabv8hR8Ln+crrtNedg+hyXs9ePbggJWuhlUvXpKxMj9jDskrRay1Dz1S+4UCT17
 sS0xuBq1ga49kqNZ0WPiGqIi019t9Q5rLpbs3zzeAbvQy3rhjsWMZTTtYox+T350wH8T
 q2aFfcm1b5QbUKugemJPxzSCPqYX5ulm+6UltKtsokOyK/hqL2lJLL8d8eIlTym6AWaY
 msTIHyOyIxIH0hIy6LicCjzMJQYCSYvE24lsQ+KWFIa3NhfMgAqbLRByGL+LRpHCSirN
 DagNsiuZt1Dvr6/uzRCvopRqhewDn0q7mr0LApW7bGR9OZAlV1OBxAJPjN5JRZd/Z5nC
 kYFA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=HXZabv8h
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

As part of bringing up Genio 360 EVK, we need a new PMIC driver for the
MediaTek MT6366 PMIC. This uses the same PMIC wrapper as other Genio
platforms but the PMIC itself has a different register map, so gets a
new driver.

This also includes all of the devicetree and config changes needed to
enable it on the Genio 360 EVK.

The patches prefixed "arm: " depend on the recent board bringup series.
"power: " patches could be applied sooner (no dependencies) if we want
to split this up.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (7):
      power: regulator: add MT6358 driver with MT6366 support
      power: pmic: mtk-pwrap: fix clock names
      power: pmic: mtk-pwrap: use mt8195 fallback for mt8188/9
      power: pmic: mtk-pwrap: add mt6358 PMIC
      arm: dts: add mt6366 PMIC include
      arm: dts: mt8366: enable PMIC
      configs: mediatek: enable PMIC on Genio 360 EVK

 arch/arm/dts/mt6366.dtsi                      | 273 +++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi |  23 +-
 arch/arm/dts/mt8366.dtsi                      |  12 +
 configs/mt8366_genio_360_evk_defconfig        |   6 +
 drivers/power/pmic/mtk-pwrap.c                |  92 +++----
 drivers/power/regulator/Kconfig               |   8 +
 drivers/power/regulator/Makefile              |   1 +
 drivers/power/regulator/mt6358_regulator.c    | 371 ++++++++++++++++++++++++++
 include/power/mt6358.h                        | 130 +++++++++
 9 files changed, 848 insertions(+), 68 deletions(-)
---
base-commit: 5e3d0c7cea29c6d31493af34f21ed6c3e30d0e80
change-id: 20260804-mtk-pmic-mt6366-fd63c609df2a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

