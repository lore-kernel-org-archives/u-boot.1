Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4DC606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z1a5MvQ0;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FLorTyDf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B055E60AA2;
	Fri,  6 Nov 2026 21:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mcSvnyuY9wWD; Fri,  6 Nov 2026 21:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3E6C60A8D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794001014;
	b=Qsn6/OmSpdCiNtAlghzfrkCc+n7E1m9i4sqH6L+b6oNopUgckPWmvN9Aziv56t/Ow79+
	 hKf+TOaiBKGxjBfCzeh9X5h2R6aHH5QC/pPOy0T1NuLn7I86gjyz8fO1LHVWrl6UQDy5z
	 ZY6z3qV7pK9Gr9uzpV9AsWVt6KEm+zCi/rBZN5w7v/w9ow+T0Mho/KiT6wty97ksfTElJ
	 jxn/6jcHMYU1COjnK9jW0b92uQhZvVKmgNlMJMBliNBtQfs80WyqLz9i7lf9JE5hWlJaz
	 ZPvzRf+uzQ3fjB4CvOtOp5f1KolitKYiwKiJVGjTwFChpiKLYzyZQy+OCycxJS/riHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794001014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lm/4K+z5YuaNEGeeI7B/V/u+1jnGbRS6nU53u/N5v9A=;
	b=jutctpYzkTBce2PazcTwq71MnBEQOT4lx0hVWq2w1BrMvJ3SmIxDNEpV1gPpDUsvLX0V
	 jG6DxQx0mHhzjhiuttyt093e9WKYeGh9cw+60AxNetk3FdMpocJ5j9BI4AXdE7SPFfCDg
	 GQgMKX2S73F1MMXeFV2xcSEachwtKovEU5dGwaLzlzIZg6A3c5ZmoVvmFvzzjTreECYMJ
	 UTZI3ogQUaEbSPWiKDN+xUmVve3Zbc3U/Yw4pGlJBlxT6EkVX2QX/E+mpjFPqJNuTCh3m
	 yRHB+BZuBjAzBa2dX5zLmfbps+RNk29fzJYpXwgWXoDZg0zEiCFBKAPsYVgWZX5fiJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794001014;
	bh=lm/4K+z5YuaNEGeeI7B/V/u+1jnGbRS6nU53u/N5v9A=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z1a5MvQ0688LeQYYZQ+r1MW2AfmQqS5/eg1FdubIvVRNV8dmjt8HirDbhWw771DFl
	 LV6L0LQMo1e4+G2aRNM1icCBKDx23IWcBXd6kUQloyPKkxD4c5yzrduoz2dcAo1dsg
	 4wIaUbPFfiwZ/WyBFXOm3QO4Kl7/wvFUOtUrAtnXsJ1Kvpd3vleZKIJ7XDcrtffvmb
	 kyqS9Rk8LxHsgjjrxTwLu6U7bRGt7dCTrQIofykusqgWgdJBPdc/47ivx/LyRBNFka
	 m2djzipIgdsXUetMHHwCIUdykkVSTjyDwUmnlhTYPKJeDN8JlLU6Wukv8iy2DXH365
	 0vzeZ6FSpwTcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3E6C60A8D;
	Fri,  6 Nov 2026 21:36:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B28C235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CB3F40401
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fj3E7MqeGrFS for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:36:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 768AF400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=FLorTyDf
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 768AF400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:36:50 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4f14642adb4so619273b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794001010; x=1794605810;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lm/4K+z5YuaNEGeeI7B/V/u+1jnGbRS6nU53u/N5v9A=;
 b=FLorTyDfnvWxfeYG1sqAMSybLX1Etf25UeuCt2e5A3zPWBz8z12+0lxqf0BrUMwBDA
 aYGzZYZUQ9nDq9UKYzt2vNTDSbKy0ATVeIPzdc7xEl05pJoaU17cftEoMmcwKysmEbqZ
 E7ZcPEpkY9sXuO+gsc3H584MGNmhi8NNSfSYX0WyYMLv2ZSjfdfOFBHFeZziCgj3h7oI
 7gfKv7YFAVzqSDlvfwy5IzPiiVoUympxK7Yf7SOQ6TdhxXZkPT4XR3XrbZjkOYuAWBt5
 zHZEcV1YJ7kRD2scS9yo1LjHJ4SW/tmq2OvNqz5gyMruQeXH7fJXrY9BxYHUED068kVX
 RF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794001010; x=1794605810;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lm/4K+z5YuaNEGeeI7B/V/u+1jnGbRS6nU53u/N5v9A=;
 b=E6lRbHhi9X+zx/dEfMI0EG9gAI+9+MhBjg9cmicqchupq/JSwyMkIBzSr1pOHgJK2/
 Yt7L66sdqVgykiLVLPKUVOGWL18SvRty6gmDvk2zbTrxDQvgQ09bohVwmBOVf6XLxW3c
 UP3YIB+YGETgIcEOpQuKzHS6W8QjXwJEdYXmRrs58P23/aOVT2Am+pae2a0v91Mfw2Ir
 aO+T/FC3J4OTLySgkMTbdLeLfmxIIXMMlKr/PKbWuFTGgsWF3Ycyhl2BAgX5jkxjT8+7
 uSLWi8ow9Ni9XmzCHzU+kFcKW2J3xp5bfc5J9CIbd7/tTowvjdORqfbVTfQPsNC0bfmM
 hcfw==
X-Gm-Message-State: APuU4Z9WeHku1JLnhMfw6FlVc/aG0PbLhE3dNg5tOSo73R2N3mNl7tjU
 AAForihW9tQ/Lhm1hCWhp/Yd1T/548qeR4/ltmZT758J+/eSRoT243WbjHwJEa7KGIc=
X-Gm-Gg: AYBFou33wqGgRmADKXUCDRnuZPNNAwhyv8XeDIEKbfeeW05tUhRccbSLW/aA8B++6Ls
 fuUTfizBL2PYz3rHPRlL28xyPgavFSKE7WcfSEXM5+FIuMGzcvCtSGaLXl1cda3S7efNn2cjOsr
 DvjCiObtQNbfgtij6ls2dRTUWD4viKITiUaDWC8sZuKXkbJemWQaCeO25fu9/AzU5tiNOLN8BNr
 STLpAt1BDg/Yp6ZSqSLjbZZ3LIPpZkBLE+1qWVlzIxhNh+cZmiZyT3x5reuwZXQCgdSH83TupLs
 5u347Kyvc8SbqbK27tpAoDo2VvzuC4IhpsalRWo0RE+j60z74MUQR+TqYoBvZNuQ3hHK+tm3Ouc
 JDHNAOchPkfwRu+wOKIVVXqbPmzQPvfKAM5pm2P8uqS6WhR14r4DUaGU/E82VmmR4kVmxYF+TsL
 qSWhQ63k4Y72wbBkWApLFGpUAmoDTtm9kLu2k3qLCQzIfdr+IFfJcMUZPmkN1BOt+r1nqshgVfy
 pWtowX9+sqkP9WMIAEzMbjjExUbC3xSpcmoiQCAukEFsEFNNC1dwytPnm0OrBWxc+SaD/kZL92Q
 TL1AHROwbprf5jXy3l8pZeq6TOX0cnzDYw==
X-Received: by 2002:a05:6808:4fe4:b0:4dc:1374:99ae with SMTP id
 5614622812f47-567e13d23demr3206270b6e.56.1794001009728; 
 Fri, 06 Nov 2026 13:36:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ce15:58eb:7458:e922])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7e70338sm2475624b6e.12.2026.11.06.13.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:36:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] mediatek: mt8189: add UFS boot for Genio 520 and 720 SPL
Date: Fri, 06 Nov 2026 15:35:50 -0600
Message-Id: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwW6DMBBEfwX5XEfexSxgVVX/o4oqYy+p0wAJC
 6hSlH8vJDn01MtII83Mm6sSHhOLctlVjbwkSUO/GnjJVPjy/YF1iqtXaJDAQK676VsfuE+DLtF
 oOZ/03Iq2PpBvyypyadTaPY/cpp/77sf+4WVujhymbeyZGPkyr8DpEVMdi/g70GWvT169ET43w
 mK10QQ2x2gaLKrwPojsLrM/haHrdqu8qb+nXfbPZSA0FigQonULbsXGC+ttKk0uixBtEWokX5T
 QNhSAKZZgioCVqfKcLNVQsFf72+0XVJn/MEMBAAA=
X-Change-ID: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/4ySwQYxYjZsJ7nfScN5gzsAsW8zPSe7a72+LQzMirw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7kg6eR1aE933+kTNrKu9IJUjLE//RIJT37yew
 JN2rTk73USJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCau5IOhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ar04IAJ5G7NZCC2CK9SnT7EqSAqjhZhsQOBGSPjy7CoA
 WBGO8mGSPkI6ntyPqquz/jdA5DDHicSEfPi86fmo8JyWgEuP3PlYarEEzybCBzSKmkTo1vjszCL
 K0qnDMPgMHLwRetORA5OeaR/U+PuZrnc0lmCOFPjvrBUCUFl5bZejjqkqHKClfr1Bbqn1QQ4R25
 LLGocsSfYm5E547i4UVd8i2kdWAgemdS4CPvzln3nSo68b5ob6c0mg3OpLDRNW/T2MPJTelGnKJ
 h9HydPHD5kcFFSTPfynLYjXRyzE0oNkvX1/OlqCjTMViXtXsXRyREjpJ1TEBNT+5Fwv0gfpvYQp
 tSdo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for booting the Genio 520 and 720 EVKs from UFS when U-Boot
SPL replaces the platform BL2.

mkimage gains the UFS BootROM image header, and the MediaTek UFS driver
skips its secure monitor calls when running at EL3, as it does in SPL.
SPL can then load the firmware FIT from UFS. A new config fragment,
mt8189-genio-spl-ufs.config, selects the UFS boot and sets the BootROM
image header to UFS. The DDR loader that runs before SPL must also be
built for UFS.

This series depends on:
- "spl: ufs: add UFS boot support for Qualcomm" v4, which adds the
  generic SPL UFS loader:
  https://lore.kernel.org/u-boot/20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com/
- "mediatek: mt8189: add U-Boot SPL boot for Genio 520 and 720" v2

Tested on the Genio 720 EVK booting from UFS.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (6):
      ufs: mediatek: skip SiP calls when running at EL3
      arm: dts: mediatek: prepare Genio 520 and 720 UFS for SPL
      arm: mediatek: load the next stage from UFS in SPL
      arm: mediatek: make the BootROM header info configurable
      board: mediatek: add a Genio 520/720 UFS boot config fragment
      doc: board: mediatek: describe booting Genio 520 and 720 from UFS

Fabien Parent (1):
      tools: mtk_image: add UFS support

 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 17 ++++-
 arch/arm/mach-mediatek/Kconfig               |  7 +-
 arch/arm/mach-mediatek/spl.c                 |  2 +
 board/mediatek/MAINTAINERS                   |  1 +
 board/mediatek/mt8189-genio-spl-ufs.config   | 10 +++
 doc/README.mediatek                          |  1 +
 doc/board/mediatek/mt8189-genio-evk.rst      | 39 +++++++++--
 drivers/ufs/ufs-mediatek-sip.h               |  5 ++
 tools/mtk_image.c                            | 97 ++++++++++++++++++++++++++++
 tools/mtk_image.h                            | 16 ++++-
 10 files changed, 185 insertions(+), 10 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
base-tree: https://git.u-boot-project.org/u-boot/u-boot.git main
change-id: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70
prerequisite-message-id: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
prerequisite-patch-id: 8adf07351c5a4eb61976ceeced2d0ab0eadf235d
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175

Best regards,
--  
David Lechner <dlechner@baylibre.com>

