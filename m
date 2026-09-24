Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1580AC9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 20:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C5D540ACE;
	Thu, 24 Sep 2026 20:45:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C01xS3JWS8P0; Thu, 24 Sep 2026 20:45:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F202A40AD5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790282719;
	b=QHK9uOmUDL0zBq8jsc3jRP5Xk0CyuFV1h5T6yD0qQ5h7QFxv2pB86Is3SIrMzpUK4Vh1
	 ElBdELc3s0ElfBwUXfChufDMEEWAhMcph07NxW5/JJhrc/pQXRTSYj1UOf55vxOy5AKpz
	 zNXU2uVXjE31ExyYWGQxG2ib0s/tbip4l2X90D2FuJAeRMRBe2FRjxY1pg24OfxraSGo9
	 rtA0T/QDhssLB6YaFv4aM4SefL/mk924XhyLt2AWMAPxK2SkRfT5DTxgxnQ83rLDcvidi
	 7iOUk3Tz0clNp6gf3myhpqdzwhkhKFOXaL+4o/A4F4HbLFSX4saqBTW7HJwYCAwOxVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790282719;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BzfUv4RDgiR76FZc/Wq2jXV3qwXLDgoYobfWvcKDE3w=;
	b=Zv6vpyyEl2uBNu6Q1HPZ7kHKHIH1RVg0HF6qgYMChaBCV/WtC8S/uG1nmBEV7d3qWhn0
	 VQEM0Jt0LM8pKg7CiAammxy0Fo4K9UhIDGMsTzVChjj2tfNh3a33LIK9QJ/kH1bkvIYms
	 DXxrDur//SI8SX2Hk1Vu3XtnGo8HcHwBjfIxWzKWy8NFL/qRquFj1Wl5iNYi2zK6DowCF
	 s8z/DZ+JKr0ZossqOighNthqJSRPpWWL9OWRGFAn+hC4JUbA52xY9E7LRO3yFUfIiDySJ
	 jD9ZW55sktx7nAvUxJuSmjECgz8m3ktdthSqdpmWMKDQtGkYJms65YBmn4wPm3j3HEw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790282719;
	bh=BzfUv4RDgiR76FZc/Wq2jXV3qwXLDgoYobfWvcKDE3w=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ObeylLlHDf1M0txxBtt25e8k7ZMKSPwdgduBdLGIFW3kZZ3RixiB8dwqK9pT6+LfH
	 aNjhtJN+TWrdJhIK+g88uKvnCCixWqRp2vhEa0U6xrswFTOtOfrS1UFAIywxJDz0FI
	 Rsi1zUYPvzxcAI+ZDd5q48AKo0NkInljtjgaNLeS78N7iZwhA0aNOgU9bR+t8o8IPe
	 q2ouhAtLgIL4qX0ZewxQDlah6ehmFNQTMVKC0itsh+HYqkNhi9LPjcGlhm+jzyb7Ga
	 r7KyH2oCtVIpKQz03sjjat/zlqhs1uJcaSi3ivjPJZsGwY0EOMUO+BfLXYmlcKRgJl
	 fuFB1dfJ/SBlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F202A40AD5;
	Thu, 24 Sep 2026 20:45:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D8AA332
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 20:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 65B8560BC6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 20:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 31sTKt_GHgi4 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 20:45:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9F21E6067B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790282715;
 b=RELAs621ph8mU25dOLapTQg7WgbCDz1PCYum6tIwB65z6ei0SQKEzwv7FUreHlw8PG8L
 tVS/h389++G9nc7FoXN0OAXURQtWBF6enfRSYmY4ZdFPw4ePQxKI43Wn0k5P9yN+zaFaX
 r+TElTQYT1pEdHqGccLifrIQwR0W/h4KPjUFNPW0OQcEcRlxw3AJMMJcdR5F+4WB/1dOY
 NYeialecIKlqrvRYdqQS4x3dkmHvD7vycqvsFfErGmKfvjFVjXPR0GaBjMzGpIwJYPAca
 rxB4w6sqiGfhUvViT8W4vfV/IJ7n24EPZd4ioAVBRsHpQJF6nOloRpoES+oXOOVIW9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790282715;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=BzfUv4RDgiR76FZc/Wq2jXV3qwXLDgoYobfWvcKDE3w=;
 b=tWvTf0OZ5IOEHJqEy+YjF9QsMxuG3b2M1shVRQB2LR6gU2XDkh+cLiMljmdhyo7w1Or/
 LkM96g22z6YeOqR/PHd0ntmEVYABAwpNSf/rk5guu4f41bg1Pio+JHvtBTFFDERs/RO9f
 GiNsmeHciEivAReDHe0RRG8ExMh+om8QZXgG0NuYj+1BA0Q0wOKJDe+Afm3Mn+zwF9Tm1
 3Twy53N8e1r3iL1mUk++ZirggMEAN0WKY8XRLpXuZHYwxMADkTH3bjuYB8pf6Igpl2l6v
 Lr5PiRTDIfZNGUzAtS8lyq9dK1u+W6RP36Ew7cOfsGCMImLqRcpENaeZNotURj4KCFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Zi8BUxcR; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Zi8BUxcR
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F21E6067B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 20:45:13 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso3019435e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790282711; x=1790887511;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BzfUv4RDgiR76FZc/Wq2jXV3qwXLDgoYobfWvcKDE3w=;
 b=Zi8BUxcRFyVcaUoE7JBG36UAmhVcbdU4Jauk0yiKHRPkDStxrmNa09SN/TsD8l+b5N
 JNi8HVwmv2FCUcWXl7NEggNxtKMGKsW/ns0dcsP1PZiuAwoHHfPoaun5IHQZMLqbCS+I
 CHFB+njxcOdDTfehHCkTxc0ohddbR9jnKxMD11GutUdUxPFlhsYqaz+8c3G8Gynqs2f3
 o4UjDKV2bMUvKrtorFoBgswdrHJN75evZ7WQuDnKWxKs3sXoRDXLz2ewfRPK+/ZfanWT
 lz8i8M0JD5asuhkL/HRMeK/FUZ3uOSLXRPL++6m6eESMh80ihS/QqlRtpXL8YB5vFpjR
 8ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790282711; x=1790887511;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BzfUv4RDgiR76FZc/Wq2jXV3qwXLDgoYobfWvcKDE3w=;
 b=TlFpxw5FAQ/cqDp5syEMtJ2FTX/Ct3mRGUrjOi1RLdlAbWKKlaeKpN2UG1Xn4RTSFh
 fC70JlMDoq2f59x1waYzXLNz7VamHFN2ueK+L1lU5KaT7E1bWoopI2ragiR1F6XtR9lO
 CwjeZVTvjYCYzpipkbo7VyR8NTXfOKh32s6rg3twxGD0nSZVxOlF0+8RCvFbODfIfZdk
 g0SA1IXgt9E6BuATCw97YVgPAQxwK5D7XsYQiBO5D2f1T4/8MQOYAvP+uJmTrLpHF78R
 7ad/OQoOO/aPraGlCWgM0ApIMFLlrR/WKjQ/65Jjl23yL2JszLL0NJPH0ly3PW3LJIQP
 yklw==
X-Gm-Message-State: AFuF++knV7FcCC1guvF9vrSixfMw7BOHbd2gpAJO4Op1c/KJ1jnwffUQ
 ZDYYLzV1C4eXIVB05SvGCg9BkYw5/YnPiXQ3g6gRQ0BY/6bZtNLV9faWV6J1J9on3NQ=
X-Gm-Gg: AYBFou3cs+gLkn2xqVA/pyi62g0YZDuOgur3H0w5lYJLJlC5qf3YfeXsUtHWUHecdgR
 SS1yT3pm9kMmtkhb7lQyWPKvi4Nng6VEIoptY37y6GRjsi0T2w1aB8ytMPQfjZsTH/PGF9tMPkj
 IXhG4026KdfRm7SMfdQcfHU7BTQ6mIcbCanQTWLXXsEwmwNSATwUUV2+H38r5yTBFkm/trd4F6D
 XM0bHnbVl3oC4dUVxgvHVZQmizHqtob7vGRzR2lNBk0GwRIyOzwZUehwUkTf3+GrGUpU36AOp2z
 TNUc63BghwC6i7YaK8XPgu3XeZiQduLqvFdhQaFEQkIHl2Cl++ZJzaL/JncW29kChAIauck+7dN
 3LoBwUv2rdMKUtG/7m3Zmz6w0dtZSvjlc+/fheyRC2aSq2FSpJel20ilZIsUUjBNO3mcwPpRV2z
 wPSbL5hd+a7KYpZ9dnRdmYgwCpQnF8AXM2+RW+dm6EFluCYhZUbpurQgHnCdOCzaQHrUjRsr4pY
 nRvX79l5sSthE3WKTnIJMOkazPWb0MWCtZTyZp3HvLKl3csZDpNRwhwvtY0v+bc
X-Received: by 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id
 5b1f17b1804b1-49feddbbe6dmr15936085e9.25.1790282711373; 
 Thu, 24 Sep 2026 13:45:11 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff0658747sm5091835e9.1.2026.09.24.13.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 13:45:10 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 24 Sep 2026 22:44:58 +0200
Subject: [PATCH] arm: mediatek: support firmware A/B selection in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-ccaione-upstream-mt8390-ab-v1-1-352e05af3c35@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NSwrDIBQArxJcVzCaqMlVShbPl2drIZ+qKYWQu
 9c2XQ4MMztLFAMl1lc7i/QKKSxzgfpSMbzDfCMexsJMCqlFJxuOCEUhvq0pR4KJT9mqTnBwXKv
 aNWPTKuMNK4E1kg/vX/w6nJw29yDM3+LfiPTcyjWfGnOQiOMyTSH3FSkaNepGaXBYW/ACDQjZW
 UAjvVXkvHTtWLPhOD7KCDNAygAAAA==
X-Change-ID: 20260924-ccaione-upstream-mt8390-ab-631b4d4537f7
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Chris Chen <chris-qj.chen@mediatek.com>, 
 Torsten Rupp <torsten.rupp@8tronix.de>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Genio firmware updates use MediaTek v1 metadata in misc to choose
between bootloaders and bootloaders_b. Support this ABI in SPL so
systems replacing BL2 can retain their firmware update and boot-success
handling.

Make selection opt-in, since trial boots need an updater and a
boot-success owner to maintain the retry state. Reject corrupt metadata
and failed state updates rather than silently restarting the retry
budget.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
This is intended for systems with an updater and a boot-success owner
that maintain the MediaTek v1 metadata. The option stays disabled in the
standard defconfigs. It covers the firmware FIT slots; the DDR loader and
SPL in boot0 remain shared.

This patch depends on the dynamic MMC partition selection series V3 [1].
The mediatek-staging base e3ed6c6436ab includes both that series and the
Genio SPL support.

[1] https://lore.kernel.org/all/20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com/
---
 arch/arm/mach-mediatek/Kconfig          |  17 ++++
 arch/arm/mach-mediatek/Makefile         |   1 +
 arch/arm/mach-mediatek/spl_ab.c         |  35 ++++++++
 doc/board/mediatek/mt8188-genio-evk.rst |  88 +++++++++++++++++++-
 include/mediatek/mtk_ab.h               |  48 +++++++++++
 include/mmc.h                           |   1 +
 lib/Kconfig                             |   1 +
 lib/Makefile                            |   2 +
 lib/mediatek/Kconfig                    |   9 +++
 lib/mediatek/Makefile                   |   3 +
 lib/mediatek/mtk_ab.c                   | 139 ++++++++++++++++++++++++++++++++
 11 files changed, 340 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 13d5819510e..316337949b4 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -221,6 +221,23 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config SPL_MTK_FIRMWARE_AB
+	bool "MediaTek firmware A/B boot in SPL"
+	depends on TARGET_MT8188 && SPL_MMC && SPL_LOAD_FIT && SPL_BLK
+	depends on !SPL_RAW_IMAGE_SUPPORT && !SPL_LEGACY_IMAGE_FORMAT
+	depends on SPL_EFI_PARTITION
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
+	depends on !SPL_OS_BOOT && !SPL_FS_FAT && !SPL_FS_EXT4
+	depends on !SPL_FS_SQUASHFS && !SPL_RAM_SUPPORT && !SUPPORT_EMMC_BOOT
+	select SPL_MTK_AB
+	select SPL_MMC_WRITE
+	help
+	  Select firmware FITs from the bootloaders and bootloaders_b GPT
+	  partitions using MediaTek A/B metadata in misc. Track trial boots
+	  and switch slots when retries are exhausted.
+
+	  An updater and a boot-success owner must maintain the metadata.
+
 config MTK_GENIO_BOOT_IMAGES
 	bool "Build MediaTek firmware images"
 	depends on TARGET_MT8188 && SPL
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index be3604a6776..96eb3ccb35c 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -5,6 +5,7 @@ obj-y	+= cpu.o
 obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= spl_fastboot.o
+obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/spl_ab.c b/arch/arm/mach-mediatek/spl_ab.c
new file mode 100644
index 00000000000..1a4b2f0bcc5
--- /dev/null
+++ b/arch/arm/mach-mediatek/spl_ab.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2026 BayLibre SAS */
+
+#include <mmc.h>
+#include <mediatek/mtk_ab.h>
+#include <spl.h>
+
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
+{
+	struct blk_desc *desc = mmc_get_blk_desc(mmc);
+	unsigned int slot;
+	int ret;
+
+	/* This platform boots firmware FITs from the eMMC user area only. */
+	if (IS_SD(mmc) || desc->hwpart || !mmc->ext_csd) {
+		ret = -ENODEV;
+		goto error;
+	}
+	/* U-Boot does not enable the eMMC cache; reject an unexpected cache. */
+	if (mmc->ext_csd[EXT_CSD_CACHE_CTRL]) {
+		ret = -EOPNOTSUPP;
+		goto error;
+	}
+
+	ret = mtk_ab_select(desc, &slot);
+	if (ret < 0)
+		goto error;
+
+	printf("MediaTek A/B: slot %c, partition %d\n", 'A' + slot, ret);
+	return ret;
+
+error:
+	printf("MediaTek A/B: selection failed (%d)\n", ret);
+	return ret;
+}
diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
index 43948bb4365..2f1d80c04cb 100644
--- a/doc/board/mediatek/mt8188-genio-evk.rst
+++ b/doc/board/mediatek/mt8188-genio-evk.rst
@@ -36,7 +36,8 @@ followed by U-Boot SPL. The DDR loader initializes DRAM, copies the fixed
 ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE`` to ``CONFIG_SPL_TEXT_BASE`` and enters
 SPL at EL3 with exceptions masked.
 
-SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
+By default, SPL reads a FIT image from partition 1 of the eMMC user area.
+Optional firmware A/B selection is described below. The FIT contains
 Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and the
 U-Boot control devicetree. It is an ordinary, directly parseable FIT whose
 first word is the FDT magic; the complete FIT container must not be compressed.
@@ -225,7 +226,9 @@ For example, after enabling ``CONFIG_MTK_GENIO_BOOT_IMAGES`` as above::
          --enable SHA256 \
          --enable SPL_FIT_SIGNATURE \
          --enable SPL_RSA \
-         --enable SPL_SHA256
+         --enable SPL_SHA256 \
+         --disable SPL_RAW_IMAGE_SUPPORT \
+         --disable SPL_LEGACY_IMAGE_FORMAT
    $ make olddefconfig
    $ make BINMAN_INDIRS=/path/to/firmware-and-keys
 
@@ -252,12 +255,12 @@ Image                Destination
 ===================  ================================================
 
 The standard Genio 510 and Genio 700 partition layouts name GPT partition 1
-``bootloaders``. SPL selects the partition by number through
+``bootloaders``. By default, SPL selects the partition by number through
 ``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by name.
 
 Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
 the platform recovery path and any backup bootloader partition while testing.
-Selection of a backup partition is not implemented by this SPL configuration.
+Selection of a backup partition requires the optional firmware A/B support.
 
 Using Genio Tools
 ~~~~~~~~~~~~~~~~~
@@ -360,3 +363,80 @@ Use raw images with the eMMC boot-area aliases ``mmc0boot0`` and
 ``mmc0boot1``: these aliases write the downloaded bytes without expanding
 Android sparse images. Sparse flashing is supported for GPT partitions and
 the eMMC user-area alias.
+
+Firmware A/B in SPL
+------------------
+
+``CONFIG_SPL_MTK_FIRMWARE_AB`` enables A/B selection for the firmware loaded
+by SPL from eMMC. It is disabled by default. Enable it only with an updater
+that activates firmware slots and a service that confirms successful boots.
+After selecting the board defconfig, enable it with::
+
+   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
+         --disable SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION \
+         --enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC \
+         --disable SPL_RAW_IMAGE_SUPPORT \
+         --disable SPL_LEGACY_IMAGE_FORMAT \
+         --enable SPL_MTK_FIRMWARE_AB
+   $ make olddefconfig
+
+Install a complete ``bootloaders.img`` FIT in each of the ``bootloaders``
+(slot A) and ``bootloaders_b`` (slot B) GPT partitions. The ``misc`` partition
+stores the selected slot and boot-attempt counters. When migrating from BL2,
+replace the FIP images in both slots with FIT images. If FIT signing is
+enabled, both images must be signed with a key trusted by the installed SPL.
+
+The DDR loader and SPL in boot0 are shared by both firmware slots. Keep A/B
+disabled in download-agent builds.
+
+With SPL installed in the standard RITY eMMC layout, the boot flow is::
+
+              BootROM
+                 |
+                 v
+   +---------------------------+     +---------------------------+
+   | boot0                     |     | boot1                     |
+   | DDR loader -> SPL         |     | U-Boot environment        |
+   | shared by slots A and B   |     | not a firmware slot       |
+   +-------------+-------------+     +---------------------------+
+                 |
+                 v
+   +-------------------------------------------------------------+
+   | eMMC user area (GPT partitions)                             |
+   |                                                             |
+   |   +-----------------------------------------------------+   |
+   |   | misc                                                |   |
+   |   | Selected firmware slot and boot-attempt counters    |   |
+   |   +-------------------------+---------------------------+   |
+   |                             |                               |
+   |                     select A or B                           |
+   |              +--------------+--------------+                |
+   |              v                             v                |
+   |   +-----------------------+   +-------------------------+   |
+   |   | bootloaders (slot A)  |   | bootloaders_b (slot B)  |   |
+   |   | FIT: BL31, BL32, BL33 |   | FIT: BL31, BL32, BL33   |   |
+   |   +-----------------------+   +-------------------------+   |
+   +-------------------------------------------------------------+
+
+Firmware updates and rollback
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Use an updater and boot-success service compatible with MediaTek firmware
+A/B metadata:
+
+1. Write and verify the new FIT in the inactive slot.
+2. Activate that slot for trial booting.
+3. After booting and completing the required health checks, mark the booted
+   slot successful.
+
+A newly activated trial slot has eight boot attempts. Without confirmation,
+even a working image eventually exhausts its attempts. SPL then selects the
+other slot on the following boot, provided that slot has attempts remaining
+or was previously marked successful. Blank metadata initially selects slot A.
+
+A failed FIT load or verification stops the current boot. Configure a watchdog
+or another reset mechanism if unattended retries are required. Keep a working
+download/recovery path for exhausted slots or damaged metadata, including
+damage caused by an interrupted metadata update. A slot already marked
+successful is no longer subject to trial retries; a later failure of that
+image requires recovery.
diff --git a/include/mediatek/mtk_ab.h b/include/mediatek/mtk_ab.h
new file mode 100644
index 00000000000..515c8c68f59
--- /dev/null
+++ b/include/mediatek/mtk_ab.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2023, Mediatek Inc. All rights reserved.
+ * Copyright (c) 2026 BayLibre SAS
+ */
+
+#ifndef __MEDIATEK_MTK_AB_H
+#define __MEDIATEK_MTK_AB_H
+
+#include <linux/types.h>
+
+struct blk_desc;
+
+#define MTK_AB_MAGIC	0x544f494d
+#define MTK_AB_VERSION	1
+#define MTK_AB_MAX_TRIES	9
+
+/* MediaTek v1 disk ABI, including the original AArch64 structure padding. */
+struct mtk_ab_control {
+	__le32 slot;
+	__le32 magic;
+	u8 version;
+	u8 tries[2];
+	u8 padding;
+	u8 reserved[12];
+	__le32 crc32;
+};
+
+/**
+ * mtk_ab_select() - Select and account for a MediaTek firmware slot
+ * @desc: Block device containing the GPT user area
+ * @slot: Returns the selected slot (0 for A, 1 for B), only on success
+ *
+ * Resolve bootloaders, bootloaders_b and misc by name, validate the v1 record
+ * at the start of misc, and persist any required retry update before returning.
+ * The caller must provide a valid, non-overlapping GPT layout.
+ * A zero counter denotes success; counters 1..8 consume a trial and 9 is
+ * exhausted. Only an all-zero or all-0xff record is initialized automatically.
+ * Writes preserve the rest of the block and are verified with an uncached read.
+ * This single-copy format does not provide power-fail atomicity. The caller
+ * must ensure device write caching cannot hide an uncommitted metadata write.
+ *
+ * Return: Positive GPT partition number to boot, or a negative error. The
+ * caller must stop booting on error; a failed write may have changed storage.
+ */
+int mtk_ab_select(struct blk_desc *desc, unsigned int *slot);
+
+#endif
diff --git a/include/mmc.h b/include/mmc.h
index 9a796e0655f..623ca027ccf 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -212,6 +212,7 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
 /*
  * EXT_CSD fields
  */
+#define EXT_CSD_CACHE_CTRL		33	/* R/W */
 #define EXT_CSD_BOOT_SIZE_MULT_MICRON	125	/* R/W, vendor specific field */
 #define EXT_CSD_ENH_START_ADDR		136	/* R/W */
 #define EXT_CSD_ENH_SIZE_MULT		140	/* R/W */
diff --git a/lib/Kconfig b/lib/Kconfig
index b6e65b17ab6..147bf6865be 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1364,3 +1364,4 @@ config UTHREAD_STACK_SIZE
 endmenu
 
 source "lib/fwu_updates/Kconfig"
+source "lib/mediatek/Kconfig"
diff --git a/lib/Makefile b/lib/Makefile
index 8710be39f3f..646a25a4630 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -3,6 +3,8 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+obj-$(CONFIG_$(PHASE_)MTK_AB) += mediatek/
+
 ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_EFI_CLIENT) += efi_client/
diff --git a/lib/mediatek/Kconfig b/lib/mediatek/Kconfig
new file mode 100644
index 00000000000..20110734e1e
--- /dev/null
+++ b/lib/mediatek/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config SPL_MTK_AB
+	bool
+	depends on SPL && SPL_EFI_PARTITION
+	select SPL_CRC32
+	help
+	  Select and account for firmware boot attempts using MediaTek v1
+	  metadata in the misc GPT partition.
diff --git a/lib/mediatek/Makefile b/lib/mediatek/Makefile
new file mode 100644
index 00000000000..71f8dbb374c
--- /dev/null
+++ b/lib/mediatek/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += mtk_ab.o
diff --git a/lib/mediatek/mtk_ab.c b/lib/mediatek/mtk_ab.c
new file mode 100644
index 00000000000..8fa69bc1dbc
--- /dev/null
+++ b/lib/mediatek/mtk_ab.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Mediatek Inc. All rights reserved.
+ * Copyright (c) 2026 BayLibre SAS
+ *
+ * Disk format and valid-record transitions follow MediaTek's TF-A mtk_ab.c.
+ */
+
+#include <blk.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <mediatek/mtk_ab.h>
+#include <part.h>
+#include <linux/build_bug.h>
+#include <linux/errno.h>
+#include <linux/log2.h>
+#include <u-boot/crc.h>
+
+#define MTK_AB_MISC_INDEX	2
+
+static_assert(sizeof(struct mtk_ab_control) == 28);
+static_assert(offsetof(struct mtk_ab_control, padding) == 11);
+static_assert(offsetof(struct mtk_ab_control, reserved) == 12);
+static_assert(offsetof(struct mtk_ab_control, crc32) == 24);
+
+static u32 mtk_ab_crc(const struct mtk_ab_control *ctrl)
+{
+	return crc32(0, (const void *)ctrl, offsetof(struct mtk_ab_control, crc32));
+}
+
+static int mtk_ab_layout(struct blk_desc *desc, struct disk_partition *parts,
+			 int *numbers)
+{
+	static const char * const names[] = { "bootloaders", "bootloaders_b", "misc" };
+	int i;
+
+	part_init(desc);
+	if (desc->part_type != PART_TYPE_EFI)
+		return -EPROTONOSUPPORT;
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		numbers[i] = part_get_info_by_name(desc, names[i], &parts[i]);
+		if (numbers[i] < 0)
+			return numbers[i];
+	}
+
+	/* The metadata read-modify-write needs one block in misc. */
+	if (!parts[MTK_AB_MISC_INDEX].start || !parts[MTK_AB_MISC_INDEX].size ||
+	    parts[MTK_AB_MISC_INDEX].start >= desc->lba)
+		return -EINVAL;
+
+	return 0;
+}
+
+int mtk_ab_select(struct blk_desc *desc, unsigned int *slot)
+{
+	struct disk_partition parts[3];
+	struct mtk_ab_control *ctrl;
+	unsigned int selected;
+	int numbers[3], ret;
+	void *block, *verify;
+	bool changed = false;
+
+	if (!desc || !slot || !desc->lba || desc->hwpart || desc->blksz < 512 ||
+	    desc->blksz > 4096 || !is_power_of_2(desc->blksz) ||
+	    desc->blksz % ARCH_DMA_MINALIGN)
+		return -EINVAL;
+
+	/* Locate all required partitions before updating the metadata. */
+	ret = mtk_ab_layout(desc, parts, numbers);
+	if (ret)
+		return ret;
+
+	block = malloc_cache_aligned(2 * desc->blksz);
+	if (!block)
+		return -ENOMEM;
+	verify = block + desc->blksz;
+	ctrl = block;
+
+	ret = -EIO;
+	blkcache_invalidate(desc->uclass_id, desc->devnum);
+	if (blk_dread(desc, parts[MTK_AB_MISC_INDEX].start, 1, block) != 1)
+		goto out;
+
+	if (!memchr_inv(ctrl, 0, sizeof(*ctrl)) ||
+	    !memchr_inv(ctrl, 0xff, sizeof(*ctrl))) {
+		puts("MediaTek A/B: initializing blank metadata\n");
+		memset(ctrl, 0, sizeof(*ctrl));
+		ctrl->magic = cpu_to_le32(MTK_AB_MAGIC);
+		ctrl->version = MTK_AB_VERSION;
+		ctrl->tries[0] = 1;
+		ctrl->tries[1] = 1;
+		selected = 0;
+		changed = true;
+	} else {
+		ret = -EINVAL;
+		selected = le32_to_cpu(ctrl->slot);
+		if (le32_to_cpu(ctrl->magic) != MTK_AB_MAGIC ||
+		    ctrl->version != MTK_AB_VERSION || selected > 1 ||
+		    ctrl->tries[0] > MTK_AB_MAX_TRIES ||
+		    ctrl->tries[1] > MTK_AB_MAX_TRIES)
+			goto out;
+		ret = -EBADMSG;
+		if (le32_to_cpu(ctrl->crc32) != mtk_ab_crc(ctrl))
+			goto out;
+
+		if (ctrl->tries[selected] == MTK_AB_MAX_TRIES) {
+			selected ^= 1;
+			ret = -ENOENT;
+			if (ctrl->tries[selected] == MTK_AB_MAX_TRIES)
+				goto out;
+			ctrl->slot = cpu_to_le32(selected);
+			changed = true;
+		}
+		if (ctrl->tries[selected]) {
+			ctrl->tries[selected]++;
+			changed = true;
+		}
+	}
+
+	if (changed) {
+		ctrl->crc32 = cpu_to_le32(mtk_ab_crc(ctrl));
+		ret = -EIO;
+		if (blk_dwrite(desc, parts[MTK_AB_MISC_INDEX].start, 1, block) != 1)
+			goto out;
+		/* Do not verify a write against U-Boot's cached copy. */
+		blkcache_invalidate(desc->uclass_id, desc->devnum);
+		if (blk_dread(desc, parts[MTK_AB_MISC_INDEX].start, 1, verify) != 1 ||
+		    memcmp(block, verify, desc->blksz))
+			goto out;
+	}
+
+	*slot = selected;
+	ret = numbers[selected];
+out:
+	free(block);
+	return ret;
+}

---
base-commit: e3ed6c6436abc18af0c7a0298ac72f83ebf2b5d1
change-id: 20260924-ccaione-upstream-mt8390-ab-631b4d4537f7

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

