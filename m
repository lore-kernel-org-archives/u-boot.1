Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3413ECA6015
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E470440959;
	Fri,  9 Oct 2026 16:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzsFIoS3SavG; Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B67AE4094C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562561;
	b=ZcPeI5SjQn662H3yHQUPPeUwAXcmTMJFS2PpdPDumFIEKUlaZULJMBcn2ZXopAjc++i5
	 MH6LioSe+vmVNbRqJA77YHBcZqP3XsePC5VpumMud4tqBuQ0HM7pwIQbs+DoHYf+9zxkf
	 VGokGiizhAafGDD6wvejB2RhftWV0oqeLLWeYKJ0NtCYl4ew900r3mCa39jn8nC8SETwc
	 LTdxCPdxQLzb4AJiZmwizch9N/FiCBEGjcm9ZF9v/F2zOLTnxmIUP29HLC3gD3qqjVVMd
	 zPRQVIrr8XjOvWBSJ1xUCZmquVwEbLOrgrf3ToFvfIUPhlX9poyISwm+RnKfKQNTDCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562561;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0EnB7mGMB+ioWkNVhqYDx9N6C5/KMszOrEPlTaFRrOA=;
	b=Gz/CtuVT+1yM3BMAO4YaVdQAkZHiCaPUzbOT7ryU/k7Pvaj4plSnaeUESOmBZw1C2rwd
	 eUEFJsv4KSsaeZfgv06SV98a1/FwbtWN4vh+2hsB7tF6nXC6u9S8L1CTFcYxfjf3uYi9j
	 SdT8A3R5SURIICgoXp5YHFMwvpl8bNmtOSZ6asPwbxvfmLAojKc9WiwfIR4mW3YL1DwRr
	 SKcY03ZbEyHMeIYhh5pMKGgok9APW3EvZn3BU60+ajQXI0Cn42pjF5AU+s17KSL2+/hgl
	 SnN4KcFWu7AVSZxzdWlo3FPcHQi9JCwii9cPYdjwqA6SRYHiYrFJuI9VdHWLnID2mfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562561;
	bh=0EnB7mGMB+ioWkNVhqYDx9N6C5/KMszOrEPlTaFRrOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=liNRczGQKfdVwWuqAeaHt+cBWk1QrqatrjsP2+m7VFuv3uiSnG23BKUghSfvLWbsM
	 K8F/jOAA9Z4vg58GsvTkNSFr6rWEgHFZ51wAoZdQ/z2dAsUriXKQIdgutYBQ7/s4QG
	 YMPgo4kxpNn5RrHK97nDFaZj44z3bsxPxKGK7QvWiEYSiUrMOeFamj4rnj5MN2a8qM
	 R8/hF6HiKg6TmyJn7e/rmKQDBApKPqdmixuBwMSmcuSZEMpZB928pCAh6RFJAgvHCf
	 eLS2jggkWqO0sCzIyjoronk/xSut+7RV54cvtohBqKA/OzHN4Je28QGjqD7rwmr1be
	 CTW8AR+P2fNEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B67AE4094C;
	Fri,  9 Oct 2026 16:16:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F53E75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 453A18141B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mb8TyZHps7Ba for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:15:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3011781412
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562559;
 b=ZlHoZ8UEXh0xzhwG+UjQBCDESo/vM0KKF2Xn4A+mdM21UFfBEAzDGgGKkddX4CfT5TpQ
 wp768/tT3EFub1/v2qwDs/Lis+ARZpoV7DCBmBZ/Dq7kMDYgPc54d7w/E32mtwe3kqhGW
 UELM0dSBb8w1eF0EgecXp165/aGF9X7Pn7lhBMQ52xAwfuFGJBx1KVDMvq49R31eM5KNC
 N0u+qhB/nDtgxjeCqpcTD2D3loMCFJe0zqEy4DvYyVecZTckwqBSVBy90kRgtXOVIpG2H
 b49ROerKppdMiLYjwZJJdkrgVrED3WqrKpXnEQTlPIX9BnqNSbzfsEzbia9c8Mbj25A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562559;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=0EnB7mGMB+ioWkNVhqYDx9N6C5/KMszOrEPlTaFRrOA=;
 b=D8FB5NqduvaUN7ptGGqNfhW5vsjhjf4O+tLV+phWRBpWkJUaq88W+Mkqj2CW0Lme8+qF
 Fn8NDJF1L/F38D+baNC52lrOAqcqjrWZZv9/b84rPL5SemigdaK+tHLYzCtZSggLFKhe9
 VPVqu8OWwvF6iRBE1FoXPdGq9s/JkB/sAwEhylcngGPE9CQLOjb15O4/GEOfHtroQ8ZIR
 zyaYDK83xlyXNZbrRTmR6vQVZQ/k4Uni0EMB0vNzjcjuK/3evRN00JH6VPPvi0j6/LEEX
 LB+WdPO3LwGzm8aDg9SqWFzgyUzCyybgS1wVNyXwdhuZqZAkoswmipaot+UkO7DBk1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=OhjYt+K6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=OhjYt+K6
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3011781412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:57 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-82395ae2ea8so5568839a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562556; x=1792167356;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0EnB7mGMB+ioWkNVhqYDx9N6C5/KMszOrEPlTaFRrOA=;
 b=OhjYt+K6+3F0avoc0/NDiUWnoHitC9NqY8q7RrH/7Anpm/gRIrwD4JOjZssduaz3tb
 v7jPm923c0XfHwTLFFdzXRWdkSRneLBns2jExfQfKD2gTST5qfJNEoJtRx0yu2iAynBA
 aaMJbb/HX1eEcB9JkC5VvMejiAUjlYiu4nGQYHYOF7DAo47wokOmG4RViI4vLR9RPw6D
 4cAnXWb2EFWkU2Jx33YyVRsC5VlScqi3CegNkA2P+uQBWlRjkDCLTXyVhJvj32YPW5jM
 jsow35hNlTp7T5kWuE5aN7WVhpQCvJmU6xTDDudq8KqjqYMUZ0bRr4mkPK1T0p0AdJ2l
 42Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562556; x=1792167356;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0EnB7mGMB+ioWkNVhqYDx9N6C5/KMszOrEPlTaFRrOA=;
 b=AS5N7Bpw8DPrlMLBjaoyPMc3qKxBjSZ2Xav1dBZK66MwfcM9iplAUET/Jm/jMevC9s
 ss7HdQf4GYxuB6iXyStl6jaxWHFtcfJvTlsH2cEleas4XDyWfaENDSxuSaF38dR9CR/y
 0ecPOlruGyZQsoL3bu/teAUq/lNQ2JuU+BJSqxj+UEN5nsbKzLXp5BlmGLQQe6cEHwcP
 4Tc7ZeOWLPOx87rWtv7utNdVgv0MQI+yHYILEMuvyeft1miqZHYoe5lgKqaOX5oOxsKO
 nXuDB36vsf+rfxwAxFyGjYqAFxZzeafOtqLI5up0dIyluMmr9MOQ6tmjbC4prZB1MyV8
 0UFg==
X-Gm-Message-State: AFuF++lJD2Q7u2ZVixpsJw9/ONfUXKAioaYoR1YQBmVtTDW2k8g1NrOu
 btKwpBVs9BxGKkp52xpVVf7OCKiBc1E/6R1r6fQzIpIKY8SCYpkFZs9yyrnt5/KtV8U=
X-Gm-Gg: AYBFou0o+DoVNmhM3fxRHrBlZysOp5HiVfj/TSYaCB4h8shXePoShtft7kuma5hag1J
 n9hLcHVKXwjboeccTbFZrofQS+f3JA7jZSfqordvuBHNKN6YQe8ljWX4SL8uPMrpr8ex5YJkh5+
 Gderocezf3K4+61EfMN8vVObasOusf4RFlZoP6v90o1sgFOFyvZMi69zJgaig6J+4PwfdvMQ59d
 31Kw9GMMc5bTkcveMTZlfRiQUBQuZsVEoVxvXAoviGPbBc1xMbgtkVfQcyusqyKdUjgf+ovWBL3
 JoSttI4F9pt8bvvhtvHrFgsJpWo7EOpneZJujGBkCN5vzSR180NJz/vKhgQdivenymgsT3djcCZ
 1ZuavMyIh3Jvsj0mmGucqepAyJyvDCDTyLQ3PvjMVjzZzvXToKgfje2LU4sYcuXsb6z2usnl2ri
 Q2Wh9vNyGroP87/MuQwaHaobxBonKosp/DeBAGhR5Ki5JdakfDLEKJWe7xqiatveFvfw7V5ugnC
 X8=
X-Received: by 2002:a05:6808:10c7:b0:4f1:6c9c:78c8 with SMTP id
 5614622812f47-50c5acb2e81mr1806337b6e.59.1791562555954; 
 Fri, 09 Oct 2026 09:15:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 09 Oct 2026 11:14:07 -0500
Subject: [PATCH 04/13] phy: mediatek: add an MT8189 eDP PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mtk-genio-720-edp-v1-4-4fbcf5b2904d@baylibre.com>
References: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
In-Reply-To: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11207;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=QvFdEXuFxtvrWd4pJudWuF9Kk6MPM1oZKXc9v5xliug=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRLsaUM4W7ABJnLBSkgTw2fiv/D8ehuTE98oU
 smGFEs3e5OJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskS7BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AJk0H/3WW22wMJFp92tCm2xOxwyCxc+7B+DOlgNvZBtw
 z+OLJEH6Bov1jDpGJzJPgZtfTvXWwxn/1WWCbcXYhQ/KbP+A66v528pKINXvpsK75sWU0ZtdcTV
 9bX5WX5WmuOTGqADvRNxBT/rwBvIxYS6mBg4j0tl694VqNrHo+oDaIb+LlkjmFw7Vm8/vs+td/i
 Ht8jNUV1i2dUz/MCUOz2NV8qYribux4Zv9qBmG9mJ2f5/B5O5oLJHzjnAtkJunxlABX7lYyhVAm
 +hW/E3VooP0nxBLSw+EZ/d1zzAQ3gSErdUFrAeQj4bpzNNPInVMs8u/y6GNmHwQnNY1K5bVoXc3
 7p4k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a PHY uclass driver for the embedded DisplayPort TX PHY of the
MT8189. The PHY is a block of its own, separate from the transmitter,
holding an analog and a digital register bank: the former carries the
bias and impedance calibration, the latter the link rate, the lane
enables, the per lane voltage swing and pre-emphasis, spread spectrum
and the AUX receiver.

The register layout and the operations follow the Linux DisplayPort PHY
driver, drivers/phy/mediatek/phy-mtk-dp.c, as reworked in the in-flight
"PHY: MediaTek DP PHY refactor and MT8196 eDP" series. The MT8189 PHY
places its banks like the MT8196 eDP PHY there, while the registers
inside the digital bank mostly match the MT8195 DisplayPort PHY; the per
lane driving force register differs from both, so it needs a compatible
of its own.

Calibration uses the defaults, which are also the reset values: efuse is
not programmed on the boards this was written for, and the device tree
describes no nvmem cells for it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/phy/mediatek/Kconfig      |  10 ++
 drivers/phy/mediatek/Makefile     |   1 +
 drivers/phy/mediatek/phy-mtk-dp.c | 276 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 287 insertions(+)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 26d0de54a23..917c009a7b7 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -1,5 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+config PHY_MTK_DP
+	bool "MediaTek DisplayPort PHY Driver"
+	depends on PHY
+	depends on ARCH_MEDIATEK
+	depends on ARM64
+	help
+	  Support for the embedded DisplayPort TX PHY found on MediaTek SoCs
+	  such as the MT8189. The PHY provides the main link lanes and the
+	  AUX channel to the eDP transmitter.
+
 config PHY_MTK_HDMI
 	bool "MediaTek HDMI-PHY Driver"
 	depends on PHY
diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 6dedec70edc..ad3272ffacc 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+obj-$(CONFIG_PHY_MTK_DP) += phy-mtk-dp.o
 obj-$(CONFIG_PHY_MTK_HDMI) += phy-mtk-hdmi.o phy-mtk-hdmi-mt8195.o
 obj-$(CONFIG_PHY_MTK_MIPI_DSI) += phy-mtk-mipi-dsi.o phy-mtk-mipi-dsi-mt8183.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
new file mode 100644
index 00000000000..71ea1dfc17b
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek DisplayPort PHY driver
+ *
+ * Copyright (c) 2019-2022 MediaTek Inc.
+ * Copyright (c) 2022, 2026 BayLibre, SAS.
+ *                          Markus Schneider-Pargmann <msp@baylibre.com>
+ *                          David Lechner <dlechner@baylibre.com>
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <phy-dp.h>
+
+#define MTK_DP_PHY_MAX_LANES		4
+
+/* analog global registers */
+#define DP_PHYA_GLB_OFFSET		0x400
+#define DP_PHYA_GLB_BIAS_GEN_0		(DP_PHYA_GLB_OFFSET + 0x0)
+#define XTP_GLB_BIAS_INT_R_CTRL			GENMASK(20, 16)
+#define DP_PHYA_GLB_DPAUX_TX		(DP_PHYA_GLB_OFFSET + 0x8)
+#define CKM_PT0_CKTX_IMPSEL			GENMASK(23, 20)
+#define DP_PHYA_GLB_FORCE_CTRL_1	(DP_PHYA_GLB_OFFSET + 0x34)
+#define CKM_CKTX0_EN_FORCE_MODE			BIT(10)
+
+/* analog per lane registers */
+#define DP_PHYA_LANE_TX_0(lane)		(0x100 * (lane) + 0x4)
+#define XTP_LN_TX_IMPSEL_PMOS			GENMASK(15, 12)
+#define XTP_LN_TX_IMPSEL_NMOS			GENMASK(19, 16)
+
+/* digital per lane registers */
+#define DP_PHYD_LANE_DRIVING_FORCE(lane) (0x1000 + 0x100 * (lane) + 0x18)
+#define TX_FORCE_VOLT_SWING_EN			BIT(0)
+#define TX_FORCE_VOLT_SWING_VAL			GENMASK(2, 1)
+#define TX_FORCE_PRE_EMPH_EN			BIT(4)
+#define TX_FORCE_PRE_EMPH_VAL			GENMASK(6, 5)
+
+/* digital global registers */
+#define DP_PHYD_GLB_OFFSET		0x1400
+#define DP_PHYD_PLL_CTL_0		(DP_PHYD_GLB_OFFSET + 0x10)
+#define PLL_CTL_0_EN				GENMASK(2, 0)
+#define DP_PHYD_PLL_CTL_1		(DP_PHYD_GLB_OFFSET + 0x14)
+/*
+ * Spread spectrum on the transmit PLL is an active high enable at BIT(3), as
+ * on the MT8195 DisplayPort PHY. MediaTek confirmed this for the MT8189.
+ */
+#define TPLL_SSC_EN				BIT(3)
+#define DP_PHYD_SW_RST			(DP_PHYD_GLB_OFFSET + 0x38)
+#define DP_GLB_SW_RST_PHYD			BIT(0)
+#define DP_PHYD_BIT_RATE		(DP_PHYD_GLB_OFFSET + 0x3c)
+#define BIT_RATE_RBR				0
+#define BIT_RATE_HBR				1
+#define BIT_RATE_HBR2				2
+#define BIT_RATE_HBR3				3
+#define DP_PHYD_AUX_RX_CTL		(DP_PHYD_GLB_OFFSET + 0x40)
+#define DPAUX_RX_EN				BIT(0)
+#define XTP_GLB_CKDET_EN			BIT(1)
+#define DPAUX_RX_DEGLITCH_EN			BIT(2)
+#define DP_PHYD_TX_CTL_0		(DP_PHYD_GLB_OFFSET + 0x44)
+#define TX_LN_EN				GENMASK(7, 4)
+#define DP_PHYD_IPMUX_CONTROL		(DP_PHYD_GLB_OFFSET + 0x98)
+#define EDPTX_DSI_PHYD_SEL			BIT(0)
+
+/*
+ * Calibration normally comes from efuse, which is not programmed on the
+ * development boards this runs on, and the MT8189 device tree describes no
+ * nvmem cells to read it from. These are the values Linux falls back to in
+ * the same situation, which are also the reset values of the registers.
+ */
+#define MTK_DP_PHY_CAL_BIAS_R		0xf
+#define MTK_DP_PHY_CAL_CKTX_IMP		0x8
+#define MTK_DP_PHY_CAL_LANE_IMP		0x8
+
+struct mtk_dp_phy_priv {
+	void __iomem *regs;
+};
+
+static void mtk_dp_phy_mask(struct mtk_dp_phy_priv *priv, u32 offset, u32 val,
+			    u32 mask)
+{
+	clrsetbits_le32(priv->regs + offset, mask, val & mask);
+}
+
+static int mtk_dp_phy_init(struct phy *phy)
+{
+	struct mtk_dp_phy_priv *priv = dev_get_priv(phy->dev);
+	int lane;
+
+	/* the PHY is shared with DSI; steer it to eDP */
+	mtk_dp_phy_mask(priv, DP_PHYD_IPMUX_CONTROL, 0, EDPTX_DSI_PHYD_SEL);
+	mtk_dp_phy_mask(priv, DP_PHYD_PLL_CTL_0, PLL_CTL_0_EN, PLL_CTL_0_EN);
+
+	mtk_dp_phy_mask(priv, DP_PHYA_GLB_BIAS_GEN_0,
+			FIELD_PREP(XTP_GLB_BIAS_INT_R_CTRL, MTK_DP_PHY_CAL_BIAS_R),
+			XTP_GLB_BIAS_INT_R_CTRL);
+	mtk_dp_phy_mask(priv, DP_PHYA_GLB_DPAUX_TX,
+			FIELD_PREP(CKM_PT0_CKTX_IMPSEL, MTK_DP_PHY_CAL_CKTX_IMP),
+			CKM_PT0_CKTX_IMPSEL);
+
+	for (lane = 0; lane < MTK_DP_PHY_MAX_LANES; lane++)
+		mtk_dp_phy_mask(priv, DP_PHYA_LANE_TX_0(lane),
+				FIELD_PREP(XTP_LN_TX_IMPSEL_PMOS,
+					   MTK_DP_PHY_CAL_LANE_IMP) |
+				FIELD_PREP(XTP_LN_TX_IMPSEL_NMOS,
+					   MTK_DP_PHY_CAL_LANE_IMP),
+				XTP_LN_TX_IMPSEL_PMOS | XTP_LN_TX_IMPSEL_NMOS);
+
+	return 0;
+}
+
+static int mtk_dp_phy_power_on(struct phy *phy)
+{
+	struct mtk_dp_phy_priv *priv = dev_get_priv(phy->dev);
+
+	/* the AUX channel, with RX deglitch and input clock detection */
+	writel(DPAUX_RX_EN | XTP_GLB_CKDET_EN | DPAUX_RX_DEGLITCH_EN,
+	       priv->regs + DP_PHYD_AUX_RX_CTL);
+	mtk_dp_phy_mask(priv, DP_PHYA_GLB_FORCE_CTRL_1, 0,
+			CKM_CKTX0_EN_FORCE_MODE);
+
+	return 0;
+}
+
+static void mtk_dp_phy_disable_lanes(struct mtk_dp_phy_priv *priv)
+{
+	u32 lanes = FIELD_GET(TX_LN_EN, readl(priv->regs + DP_PHYD_TX_CTL_0));
+
+	/* lanes have to be disabled one at a time, from the last one down */
+	while (lanes) {
+		lanes &= ~BIT(fls(lanes) - 1);
+		mtk_dp_phy_mask(priv, DP_PHYD_TX_CTL_0,
+				FIELD_PREP(TX_LN_EN, lanes), TX_LN_EN);
+	}
+}
+
+static int mtk_dp_phy_power_off(struct phy *phy)
+{
+	struct mtk_dp_phy_priv *priv = dev_get_priv(phy->dev);
+
+	mtk_dp_phy_mask(priv, DP_PHYA_GLB_FORCE_CTRL_1, CKM_CKTX0_EN_FORCE_MODE,
+			CKM_CKTX0_EN_FORCE_MODE);
+	writel(0, priv->regs + DP_PHYD_AUX_RX_CTL);
+	mtk_dp_phy_disable_lanes(priv);
+
+	return 0;
+}
+
+/*
+ * Reset the digital part of the PHY, keeping the lanes that were enabled and
+ * dropping any forced voltage swing and pre-emphasis.
+ */
+static int mtk_dp_phy_reset(struct phy *phy)
+{
+	struct mtk_dp_phy_priv *priv = dev_get_priv(phy->dev);
+	u32 lanes = readl(priv->regs + DP_PHYD_TX_CTL_0) & TX_LN_EN;
+	int lane;
+
+	mtk_dp_phy_mask(priv, DP_PHYD_SW_RST, 0, DP_GLB_SW_RST_PHYD);
+	udelay(50);
+	mtk_dp_phy_mask(priv, DP_PHYD_SW_RST, DP_GLB_SW_RST_PHYD,
+			DP_GLB_SW_RST_PHYD);
+	mtk_dp_phy_mask(priv, DP_PHYD_TX_CTL_0, lanes, TX_LN_EN);
+
+	for (lane = 0; lane < MTK_DP_PHY_MAX_LANES; lane++)
+		mtk_dp_phy_mask(priv, DP_PHYD_LANE_DRIVING_FORCE(lane), 0,
+				TX_FORCE_VOLT_SWING_EN | TX_FORCE_VOLT_SWING_VAL |
+				TX_FORCE_PRE_EMPH_EN | TX_FORCE_PRE_EMPH_VAL);
+
+	return 0;
+}
+
+static int mtk_dp_phy_configure(struct phy *phy, void *params)
+{
+	struct mtk_dp_phy_priv *priv = dev_get_priv(phy->dev);
+	struct phy_configure_opts_dp *opts = params;
+	unsigned int lane;
+	u32 val;
+
+	if (opts->lanes > MTK_DP_PHY_MAX_LANES) {
+		dev_err(phy->dev, "invalid lane count %u\n", opts->lanes);
+		return -EINVAL;
+	}
+
+	if (opts->set_rate) {
+		switch (opts->link_rate) {
+		case 1620:
+			val = BIT_RATE_RBR;
+			break;
+		case 2700:
+			val = BIT_RATE_HBR;
+			break;
+		case 5400:
+			val = BIT_RATE_HBR2;
+			break;
+		case 8100:
+			val = BIT_RATE_HBR3;
+			break;
+		default:
+			dev_err(phy->dev, "unsupported link rate %u\n",
+				opts->link_rate);
+			return -EINVAL;
+		}
+
+		writel(val, priv->regs + DP_PHYD_BIT_RATE);
+	}
+
+	if (opts->set_lanes)
+		mtk_dp_phy_mask(priv, DP_PHYD_TX_CTL_0,
+				FIELD_PREP(TX_LN_EN, BIT(opts->lanes) - 1),
+				TX_LN_EN);
+
+	if (opts->set_voltages) {
+		for (lane = 0; lane < opts->lanes; lane++) {
+			u32 reg = DP_PHYD_LANE_DRIVING_FORCE(lane);
+
+			mtk_dp_phy_mask(priv, reg,
+					FIELD_PREP(TX_FORCE_VOLT_SWING_VAL,
+						   opts->voltage[lane]) |
+					FIELD_PREP(TX_FORCE_PRE_EMPH_VAL,
+						   opts->pre[lane]),
+					TX_FORCE_VOLT_SWING_VAL |
+					TX_FORCE_PRE_EMPH_VAL);
+			mtk_dp_phy_mask(priv, reg,
+					TX_FORCE_VOLT_SWING_EN |
+					TX_FORCE_PRE_EMPH_EN,
+					TX_FORCE_VOLT_SWING_EN |
+					TX_FORCE_PRE_EMPH_EN);
+		}
+	}
+
+	mtk_dp_phy_mask(priv, DP_PHYD_PLL_CTL_1, opts->ssc ? TPLL_SSC_EN : 0,
+			TPLL_SSC_EN);
+
+	return 0;
+}
+
+static int mtk_dp_phy_probe(struct udevice *dev)
+{
+	struct mtk_dp_phy_priv *priv = dev_get_priv(dev);
+
+	priv->regs = dev_remap_addr(dev);
+	if (!priv->regs)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct phy_ops mtk_dp_phy_ops = {
+	.init = mtk_dp_phy_init,
+	.power_on = mtk_dp_phy_power_on,
+	.power_off = mtk_dp_phy_power_off,
+	.reset = mtk_dp_phy_reset,
+	.configure = mtk_dp_phy_configure,
+};
+
+static const struct udevice_id mtk_dp_phy_ids[] = {
+	{ .compatible = "mediatek,mt8189-edp-phy" },
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_dp_phy) = {
+	.name = "mtk-dp-phy",
+	.id = UCLASS_PHY,
+	.of_match = mtk_dp_phy_ids,
+	.ops = &mtk_dp_phy_ops,
+	.probe = mtk_dp_phy_probe,
+	.priv_auto = sizeof(struct mtk_dp_phy_priv),
+};

-- 
2.53.0

