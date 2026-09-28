Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46834C9832F
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 09:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1127460698;
	Mon, 28 Sep 2026 09:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4vwiWd25E7LT; Mon, 28 Sep 2026 09:18:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1D34D60681
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790587082;
	b=UgPjJJ0kzmHcdUKdO8mF8Hsu6Yo7pnQQx6WSEPf86ydGrRUgOBfLhlalo3bbTwT0L/wo
	 OQESAu4ObReA6RGKPh2DfNTlcCEf+qqPJhrgXrbuBSaBFEfHwrNVAOksnTZoYVbAUSLAU
	 KgFcJINH91qx3G/HUJXIfWFPqQlxjIlJSJY4tMMAWZYtp7WbBIw5+eyO5SBD2B2LL9hps
	 9VMrQmway3od1Q5CiQgWLERJhjBY4XoOZI0C8Tz4Xxxva7ytWP7I78Ss2IKXk4b8tcZqn
	 X/ljJbB4Affgg6taRKsw0GpMXLzscP8hvRP7nDjGl0OADFEcN6sj8jRD6PI6GkjXLyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790587082;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nSpdCA8+4v6FtSLh9Hoy3Jk57BMRXbgmGUE9qzsYsQk=;
	b=MxMgFUZ40YwVXduUoIntl3HBbWJHrvzokcu4tCIPdanwzUMzWtTQBdokbH+vwnJjuldw
	 FzNLRG0KheGbYUIcPGYq/F4+jRfLbJ8Bv4ogwmaamheCrdDONaseE5V9Fpit4jUI6s7Vy
	 Q28QbiQbhXvharw9Kk5Y7FP9BxwbCBmS4NPlQVDFMfB8e1saSw3GHzn4ddlISSZvLGJV7
	 jw9VaMZSVaAZSc9G2/VMe5+QS3LhOewlvb29m4SSm18wqsQ9hP76xhtahVWwgaFaZjnQy
	 DGKKzeTc7zgVY4zk5F7H40twlkpAfCg01SX5FHEuN6Mp/wYQDMHZdduZVzwtZFBDFrQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790587082;
	bh=nSpdCA8+4v6FtSLh9Hoy3Jk57BMRXbgmGUE9qzsYsQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nOsUM362yB8acAx0/3HnWVRSTpq/0ugZ56ay0bJ3P0Gq6WF/jBME0KV5M/99y58yB
	 /BI7bq6OO5+bRRvqH6FA2pU0q2yn9Mp4HIb9UXSt4Rd30zM4Z33rJCgkG4iPWFOYNQ
	 ooHVynUFtc31jqdI/DuSNjOdJEkwNOV0phD5tM290os37D/K+oVHkF+bHQ6AfjQf9Z
	 AoBVwshXxs+efPg9yg08h0WYgKELRq5nWwl4iyJYnEZIB0X9BJg2BF9Pfo3Hg3lBbj
	 5pLo0wClAWpOEIaUdW/uhWP9HtLMsRNsWJmr+rkYWtDXL1ntX49KIjwmMONqEPcBoR
	 NJJH4UMswOw2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D34D60681;
	Mon, 28 Sep 2026 09:18:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC78872
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8840480AF9
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2S2cEUm6XDAm for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 09:17:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 447FF80DEB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790587070;
 b=U8LMAaJ7VgF/wFQEk9Mc6D80F+8aWl/lsMt+XrMuWdlU6lXhqBvZHQt17C3H+ADHcgI7
 aX3IogJ4f7q6jLVTkfGifbDTxDfEMNlD6npiexu6OLiCgltjFqjZeSUjRlph9iwQ0iGas
 G+yr0tZMiC+Bx4bF++4YHlDbbRFoyGAyQlZemxM42IvbG3tJKfNBrBYQVr1WseQOwNPzR
 g6oa0dFikT6e6nyYuzWp2FkMxV+tGP98ApcVhp6O/EFaYIjL95M2XRk/9G85w2UoJS6PU
 3966XYKSp51DDsVcXjHNJKkXd2Qv9lYiA3Bd7iJ663h29x37gx0MFKZ9cSYhtE3UGrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790587070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=nSpdCA8+4v6FtSLh9Hoy3Jk57BMRXbgmGUE9qzsYsQk=;
 b=czTzGF7mSKNU1fsYB/+J/jGbfkq7YGPqli/kLFbZPc0zmpDsDgtuI6zGT5YqbmhxwjhD
 zlMBzoHFa7jrr0hZUTBMhO24/F0aAw/nKgxlfmH10rVq5VTM2T0D7LVhMvvRH5pXWjJsF
 cW5uaN8ot5ksB7QP0PdL55olte7y8FrW/N4yIzbbKiEVRgMHjd7vv+ozZSnJQCyreAl1W
 Shscn8qPcUHbzIGvYY7MHTMtYe7C1E9chbW7IygdPHOBe6hwnFMHDxs7hiuD7iZ8Kna8U
 +PnuFtwCVvZb6uQPMulUbn1kzRvjZcsGMma1d1S7En2m4UHDzMSVh5MWnIvyMXEkpeA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JfaNXoRc; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::f;
 helo=mail-wr2-x0f.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JfaNXoRc
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 447FF80DEB
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 09:17:48 +0000 (UTC)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48879d4fd8aso1561819f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 02:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790587067; x=1791191867;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nSpdCA8+4v6FtSLh9Hoy3Jk57BMRXbgmGUE9qzsYsQk=;
 b=JfaNXoRcUQgU6qipkBksSWtf52hgXwlo98ogB1snRLpqypSYa3Jw9cNDMNF1guY9lo
 UOIQ4bYI9e/uqJWMNzBqVdiZpcEBnMJoC19Tvwy93DXhW5zkF3PHl42x59cx2wgpZov+
 GTd7ArYeuEz6b1ZtimHWi5O18WhHWBD4aq9D/Mle6+LJ3t8SBTJxQhcVHbHXSZ+jTn62
 XB8bmnUzrv5wMpzEaL8Qf3q3umxE7cdM6KAlfp0XoCD/W4df7/zhFIgWSnNh0SDZD1r2
 GNMjqPFuoA94vw7U21e2Oq6AgmSRGiq3J60qTOYq9QwxR/l9GLExD79d/Bs0c1jiS32c
 7omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790587067; x=1791191867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nSpdCA8+4v6FtSLh9Hoy3Jk57BMRXbgmGUE9qzsYsQk=;
 b=FOVsCFt/q6lAg+sdSUT3tOxkmLHhy33O0b/U7MTi1fl77s3odEuT01jW1sZZ0HLSeT
 O1Jtury2aZD0aBRUpnuXjnYZfQdCXB70SQGz19gZHmWppc6La0Ws3d92MfE3CS4pFGCq
 lguntVLWYR0cxg0iQOsOEUaazj7OpwOPZP7EEiH1xvIbAe9aNGrl5lscUenxFf8FwvGc
 66wp8G1FqtIxckRmAcxzlW2LmWp5nIGWE0LW0bCQp+ncVFUv6heZCU4ASWUe4sRABhtG
 UO/+xOHaWq1aaUKLzk4kFl002FpYtfbD+Pq5HQdlJlrp/dJm0YltmBVi2qrBMtJwutNL
 f1rA==
X-Gm-Message-State: AFq9FYJ/sdOjfA7B0Z6MLFnKUtD5rhWOWn0Fe5PEXvdD5Jh5yg3PqvnQ
 +HEDZPDxvufsiLEQXezoMB92rG9pTyAVHyrAvgKhYVdk/u3A2y+SGQpyXwA2UUrOEd0=
X-Gm-Gg: AYBFou30mqkiK139YaMaxpO3ExP5enm1SxXoFxRhH/2N+najQlZSj838JcwkDoRoJaN
 mxtqNR4tYmuuDm8yrklS8pzSasjMlTjFRcgucyzN3jvsIHAGgXH+sXRNnPnyUO8WOzgM1lC9FgI
 YnaPeV/xLGNsa8Cplz3QsNr5aEtou1X4PMy7l7KBk5Wc0L9tNRO2Ye7rN+u4EfPLTWuL3D6prMb
 eKWn6BYN1d0qRPLNnrC8IVSG3ZmeozVNlLVkZeCKCAYV+e5D5LY5CMNHbbfd6PeSmOtldv9GCWu
 +jRMu4UFBn/aNn5ZNmynFZG/GORXpkxWZo31NMAHH6ouXtOPnKxwg3PObO7bz9Uvp8JR+jQtjN0
 zQCCtiDKJanDwh6WbrnLPs56RkJscahiwoF5deFPWXCmDdTxvBzXqGiSyaDWWUeASKOf7QuiTNb
 pgpvztvYk5BTw8CVWB3p/SUG33yJIv5MIaY//ZWY/r/rbhCrvJuA7hN3c/OQteHfJTUXaiEC2D0
 KUqfr+tm3+9+NXhNofIdt4Lmr4AqUmGczON81GSRL2SSM5DYWp8EGRRdax3wNtoyu3KrnPpFpjz
 b7F8D9WC57Jv7M2qrJCQLGzhTS5HCYeyvSfpP/o1Y7WZa8krol2pCBUF
X-Received: by 2002:adf:e197:0:b0:488:8cf8:14 with SMTP id
 ffacd0b85a97d-4888cf801d1mr5939679f8f.0.1790587066338; 
 Mon, 28 Sep 2026 02:17:46 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64ef3asm26404622f8f.30.2026.09.28.02.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:17:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 28 Sep 2026 11:19:46 +0200
Subject: [PATCH v7 11/12] video: mediatek: add hdmi driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-add-genio-510-and-genio-700-hdmi-v7-11-ee4a61a8ac1d@baylibre.com>
References: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
In-Reply-To: <20260928-add-genio-510-and-genio-700-hdmi-v7-0-ee4a61a8ac1d@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Julien Stephan <jstephan@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
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

Add a UCLASS_VIDEO driver for the HDMI TX v2 IP found on the MT8188.

On probe, the driver waits for a plugged and powered display, reads
its EDID through the DDC bus to select the preferred mode, configures
the HDMI controller and PHY accordingly, and then programs all the
components of the vdosys1 pipeline (MDP RDMA, padding, VPP merge,
ETHDR mixer, mutex, DPI1) to scan out the framebuffer. The
framebuffer is allocated by the video uclass before relocation, sized
for the largest mode the driver accepts.

Only RGB444 with 8 bits per component is produced. Above a TMDS
character rate of 340 MHz the transmitter scrambles, and the sink is
told to do the same through its SCDC TMDS_Config register.

mtk_hdmi_regs_v2.h is a verbatim copy of Linux'
drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h, kept as its own header so
that it can be re-synced with a plain diff. The single deviation is
VID_DOWNSAMPLE_CONFIG, which the MT8390/MT8188 datasheet places at
0x8f0 rather than at the 0x8d0 used by the Linux header; A fix was sent
on the kernel list [1].

[1]: https://lore.kernel.org/lkml/20260828-mtk-hdmi-v2-fix-register-offset-v1-1-118ad5d7ebe3@baylibre.com/

Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/Kconfig                     |    1 +
 drivers/video/Makefile                    |    1 +
 drivers/video/mediatek/Kconfig            |   22 +
 drivers/video/mediatek/Makefile           |   15 +
 drivers/video/mediatek/mtk_hdmi.c         | 1027 +++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_hdmi_regs_v2.h |  263 ++++++++
 6 files changed, 1329 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 15000e21840..cb3ba6a6f63 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -770,6 +770,7 @@ config VIDEO_LCD_SPI_MISO
 	  option takes a string in the format understood by 'sunxi_name_to_gpio'
 	  function, e.g. PH1 for pin 1 of port H.
 
+source "drivers/video/mediatek/Kconfig"
 source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..a20011b9b17 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -92,5 +92,6 @@ obj-$(CONFIG_VIDEO_SEPS525) += seps525.o
 obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
 
 obj-y += bridge/
+obj-y += mediatek/
 obj-y += sunxi/
 obj-y += tegra/
diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
new file mode 100644
index 00000000000..a10f2360391
--- /dev/null
+++ b/drivers/video/mediatek/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2026 BayLibre, SAS
+#
+# Author: Julien Stephan <jstephan@baylibre.com>
+
+config VIDEO_MEDIATEK_HDMI
+	bool "Video HDMI Support for MediaTek SoCs"
+	depends on VIDEO && ARCH_MEDIATEK
+	depends on DM_I2C && PHY && POWER_DOMAIN
+	select I2C_EDID
+	select MISC
+	select MTK_POWER_DOMAIN
+	select MTK_SMI
+	select PHY_MTK_HDMI
+	select SYS_I2C_DDC_MTK
+	help
+	  Enable support for the HDMI TX output found on recent MediaTek
+	  SoCs such as the MT8188. The driver reads the EDID of the
+	  connected display, selects its preferred mode and drives the
+	  vdosys1 display pipeline (MDP RDMA, padding, merge, ETHDR
+	  mixer, DPI) to scan out the U-Boot framebuffer over HDMI.
diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
new file mode 100644
index 00000000000..38ab13e94fd
--- /dev/null
+++ b/drivers/video/mediatek/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2026 BayLibre, SAS
+#
+# Author: Julien Stephan <jstephan@baylibre.com>
+
+obj-$(CONFIG_VIDEO_MEDIATEK_HDMI) += \
+	mtk_disp_comp.o \
+	mtk_disp_merge.o \
+	mtk_disp_mutex.o \
+	mtk_disp_padding.o \
+	mtk_dpi.o \
+	mtk_ethdr.o \
+	mtk_hdmi.o \
+	mtk_mdp_rdma.o
diff --git a/drivers/video/mediatek/mtk_hdmi.c b/drivers/video/mediatek/mtk_hdmi.c
new file mode 100644
index 00000000000..2c211118530
--- /dev/null
+++ b/drivers/video/mediatek/mtk_hdmi.c
@@ -0,0 +1,1027 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek HDMI TX v2 support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <asm/io.h>
+#include <asm/unaligned.h>
+#include <clk.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <edid.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <generic-phy.h>
+#include <i2c.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <mapmem.h>
+#include <time.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_merge.h"
+#include "mtk_disp_mutex.h"
+#include "mtk_disp_padding.h"
+#include "mtk_dpi.h"
+#include "mtk_ethdr.h"
+#include "mtk_hdmi_regs_v2.h"
+#include "mtk_mdp_rdma.h"
+
+/*
+ * MT8188 vdosys1 registers: the display routing (SEL_IN / SOUT mux) and the
+ * sizes of the asynchronous clock-domain wrappers between the pipeline
+ * blocks. Both the offsets and the mux values below describe the MT8188
+ * vdosys1 routing; another SoC would need its own set.
+ */
+#define SUBDISP_MIXER_IN3_PAD			0xD48
+#define MIXER_IN_PAD_MODE_BYPASS			0x0
+#define MIXER_IN_PAD_BI_WIDTH				GENMASK(31, 16)
+#define SUBDISP_MERGE2_ASYNC_CFG_WD		0xE50
+#define SUBDISP_HDRBE_ASYNC_CFG_WD		0xE70
+#define SUBDISP_DISP_DPI1_SEL_IN		0xF10
+#define SUBDISP_DISP_MERGE4_MOUT_SEL		0xF18
+#define SUBDISP_MIXER_IN3_SEL_IN		0xF2C
+#define SUBDISP_MIXER_OUT_SOUT_SEL		0xF34
+#define SUBDISP_MERGE2_ASYNC_SOUT_SEL		0xF48
+#define SUBDISP_MERGE4_ASYNC_SEL_IN		0xF50
+#define SUBDISP_MIXER_IN3_SOUT_SEL		0xF60
+#define SUBDISP_MIXER_SOUT_SEL_IN		0xF68
+
+#define OUTPUT_TO_MIXER_IN3_SEL			0x1
+#define INPUT_FROM_MERGE2_ASYNC_SOUT		0x1
+#define OUTPUT_TO_DISP_MIXER			0x0
+#define INPUT_FROM_DISP_MIXER			0x0
+#define OUTPUT_TO_HDR_VDO_BE0			0x0
+#define INPUT_FROM_HDR_VDO_BE0			0x0
+#define OUTPUT_TO_DPI1_SEL			0x4
+#define INPUT_FROM_VPP_MERGE4_MOUT		0x0
+
+#define MTK_HDMI_MAX_WIDTH			3840
+#define MTK_HDMI_MAX_HEIGHT			2160
+
+/* the TMDS character rates the PHY can lock to, see mtk_hdmi_pll_calc() */
+#define MTK_HDMI_MIN_PIXEL_CLOCK		25000000
+#define MTK_HDMI_MAX_PIXEL_CLOCK		594000000
+
+#define MTK_HDMI_HPD_TIMEOUT_MS			100
+
+/* 4 byte header + 13 byte payload */
+#define HDMI_AVI_INFOFRAME_SIZE			17
+/* 4 byte header + 25 byte payload */
+#define HDMI_SPD_INFOFRAME_SIZE			29
+
+/*
+ * HDMI 2.0 requires TMDS clock scrambling and a 1/40 bit clock ratio for
+ * TMDS character rates above 340 MHz.
+ */
+#define HDMI_TMDS_CLOCK_SCRAMBLE_HZ		340000000
+
+/* SCDC (Status and Control Data Channel), HDMI 2.0 section 10.4 */
+#define SCDC_I2C_ADDR				0x54
+#define SCDC_TMDS_CONFIG			0x20
+#define SCDC_SCRAMBLING_ENABLE			BIT(0)
+#define SCDC_TMDS_BIT_CLOCK_RATIO_BY_40		BIT(1)
+
+/**
+ * struct mtk_hdmi_vic - CTA-861 Video Identification Code of a timing
+ * @hactive: horizontal active pixels
+ * @vactive: vertical active lines
+ * @refresh: refresh rate, in Hz
+ * @vic: Video Identification Code
+ * @aspect_4_3: 4:3 picture aspect ratio, 16:9 otherwise
+ *
+ * Video Identification Codes (CTA-861) for the timings this driver can
+ * describe in the AVI InfoFrame. Anything else is reported as VIC 0 with no
+ * picture aspect ratio rather than as a wrong mode. @refresh is compared
+ * against the rounded refresh rate, which lands exactly on these values for
+ * every one of the timings below, the 1000/1001 variants included.
+ *
+ * 720x480p60 and 720x576p50 exist both as 4:3 (VIC 2 / 17) and 16:9
+ * (VIC 3 / 18) with identical timings, so they cannot be told apart from the
+ * timing alone: 4:3 is assumed.
+ */
+struct mtk_hdmi_vic {
+	u16 hactive;
+	u16 vactive;
+	u8 refresh;
+	u8 vic;
+	bool aspect_4_3;
+};
+
+static const struct mtk_hdmi_vic mtk_hdmi_vics[] = {
+	{  640,  480, 60,  1, true  },
+	{  720,  480, 60,  2, true  },
+	{  720,  576, 50, 17, true  },
+	{ 1280,  720, 50, 19, false },
+	{ 1280,  720, 60,  4, false },
+	{ 1920, 1080, 50, 31, false },
+	{ 1920, 1080, 60, 16, false },
+	{ 3840, 2160, 24, 93, false },
+	{ 3840, 2160, 25, 94, false },
+	{ 3840, 2160, 30, 95, false },
+	{ 3840, 2160, 50, 96, false },
+	{ 3840, 2160, 60, 97, false },
+};
+
+/**
+ * struct mtk_hdmi - HDMI transmitter state
+ * @dev: HDMI device
+ * @ddc_bus: DDC I2C bus, for the EDID and SCDC
+ * @dpi1: DPI feeding the transmitter
+ * @merge3: merge of the two RDMA halves
+ * @merge5: merge buffering the HDR back-end output
+ * @ethdr: mixer and HDR video back-end
+ * @mutex: vdosys1 mutex
+ * @padding4: padding behind @rdma4
+ * @padding5: padding behind @rdma5
+ * @rdma4: RDMA reading the left half of the framebuffer
+ * @rdma5: RDMA reading the right half of the framebuffer
+ * @phy: HDMI PHY
+ * @regs: transmitter register window
+ * @clk_bulk: transmitter clocks
+ */
+struct mtk_hdmi {
+	struct udevice *dev;
+	struct udevice *ddc_bus;
+	struct udevice *dpi1;
+	struct udevice *merge3;
+	struct udevice *merge5;
+	struct udevice *ethdr;
+	struct udevice *mutex;
+	struct udevice *padding4;
+	struct udevice *padding5;
+	struct udevice *rdma4;
+	struct udevice *rdma5;
+	struct phy phy;
+	void __iomem *regs;
+	struct clk_bulk clk_bulk;
+};
+
+static u32 mtk_hdmi_read(struct mtk_hdmi *hdmi, u32 offset)
+{
+	return readl(hdmi->regs + offset);
+}
+
+static void mtk_hdmi_write(struct mtk_hdmi *hdmi, u32 offset, u32 val)
+{
+	writel(val, hdmi->regs + offset);
+}
+
+static void mtk_hdmi_update(struct mtk_hdmi *hdmi, u32 offset, u32 val, u32 mask)
+{
+	void __iomem *reg = hdmi->regs + offset;
+	u32 tmp;
+
+	tmp = readl(reg);
+	tmp = (tmp & ~mask) | (val & mask);
+	writel(tmp, reg);
+}
+
+static void mtk_hdmi_enable_hdmi_mode(struct mtk_hdmi *hdmi, bool enable)
+{
+	u32 value = enable ? HDMI_MODE_HDMI : 0;
+
+	mtk_hdmi_update(hdmi, TOP_CFG00, value, HDMI_MODE_HDMI);
+}
+
+static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
+{
+	u32 value = black ? REG_VMUTE_EN : 0;
+
+	mtk_hdmi_update(hdmi, TOP_VMUTE_CFG1, value, REG_VMUTE_EN);
+}
+
+/*
+ * Clear the General Control Packet AVMUTE, in case an earlier boot stage
+ * left the sink muted.
+ */
+static void mtk_hdmi_hw_gcp_avmute(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, TOP_CFG01, CP_CLR_MUTE_EN,
+			CP_CLR_MUTE_EN | CP_SET_MUTE_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, CP_RPT_EN, CP_RPT_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, CP_EN | CP_EN_WR, CP_EN | CP_EN_WR);
+}
+
+static void mtk_hdmi_hw_reset(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, HDMITX_CONFIG_MT8188, 0, HDMITX_SW_RSTB);
+	udelay(5);
+	mtk_hdmi_update(hdmi, HDMITX_CONFIG_MT8188, HDMITX_SW_RSTB, HDMITX_SW_RSTB);
+}
+
+static void mtk_hdmi_set_sw_hpd(struct mtk_hdmi *hdmi, bool high)
+{
+	u32 value = high ? HDMITX_SW_HPD : 0;
+
+	mtk_hdmi_update(hdmi, HDMITX_CONFIG_MT8188, value, HDMITX_SW_HPD);
+}
+
+/*
+ * The driver only ever outputs 8 bits per component, so force 8 bpp and
+ * disable the deep-color GCP and packets (TMDS_PACK_MODE_8BPP is 0).
+ */
+static void mtk_hdmi_set_8bit_color(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, TOP_CFG00, 0, TMDS_PACK_MODE);
+	mtk_hdmi_update(hdmi, TOP_CFG00, 0, DEEPCOLOR_PKT_EN);
+	mtk_hdmi_update(hdmi, TOP_MISC_CTLR, 0, DEEP_COLOR_ADD);
+}
+
+/* the driver only ever outputs RGB444, so keep the downsampler bypassed */
+static void mtk_hdmi_bypass_yuv420_downsample(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, HDMITX_CONFIG_MT8188, 0, HDMI_YUV420_MODE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0, C444_C422_CONFIG_ENABLE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0, C422_C420_CONFIG_ENABLE);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, C422_C420_CONFIG_BYPASS,
+			C422_C420_CONFIG_BYPASS);
+	mtk_hdmi_update(hdmi, VID_DOWNSAMPLE_CONFIG, 0,
+			C422_C420_CONFIG_OUT_CB_OR_CR);
+	mtk_hdmi_update(hdmi, VID_OUT_FORMAT, 0, OUTPUT_FORMAT_DEMUX_420_ENABLE);
+}
+
+static bool mtk_hdmi_tmds_over_340M(u32 pixelclock)
+{
+	/* RGB444 8 bpc only, so the TMDS character rate is the pixel clock */
+	return pixelclock >= HDMI_TMDS_CLOCK_SCRAMBLE_HZ;
+}
+
+/*
+ * Above 340 MHz the sink has to scramble and use the 1/40 bit clock ratio
+ * too. A sink advertising such a mode in its EDID is required to implement
+ * SCDC (HDMI 2.0 section 6.1.3.1), so write TMDS_Config without first
+ * reading back the HF-VSDB capability bits.
+ */
+static int mtk_hdmi_scdc_enable_scrambling(struct mtk_hdmi *hdmi)
+{
+	u8 val = SCDC_SCRAMBLING_ENABLE | SCDC_TMDS_BIT_CLOCK_RATIO_BY_40;
+	struct udevice *chip;
+	int ret;
+
+	ret = i2c_get_chip(hdmi->ddc_bus, SCDC_I2C_ADDR, 1, &chip);
+	if (ret)
+		return ret;
+
+	return dm_i2c_write(chip, SCDC_TMDS_CONFIG, &val, 1);
+}
+
+static void mtk_hdmi_enable_scrambling(struct mtk_hdmi *hdmi, bool enable)
+{
+	u32 value = enable ? SCR_ON | HDMI2_ON : 0;
+	int ret;
+
+	mtk_hdmi_update(hdmi, TOP_CFG00, value, SCR_ON | HDMI2_ON);
+
+	/*
+	 * Only reach for SCDC when scrambling is required: a sink that never
+	 * advertises a mode above 340 MHz does not have to implement SCDC at
+	 * all and would simply not acknowledge the write.
+	 */
+	if (!enable)
+		return;
+
+	ret = mtk_hdmi_scdc_enable_scrambling(hdmi);
+	if (ret)
+		dev_warn(hdmi->dev, "failed to configure sink SCDC: %d\n", ret);
+}
+
+static void mtk_hdmi_disable_abist(struct mtk_hdmi *hdmi)
+{
+	mtk_hdmi_update(hdmi, TOP_CFG00, 0, HDMI_ABIST_ENABLE);
+}
+
+static void mtk_hdmi_change_video_resolution(struct mtk_hdmi *hdmi,
+					     const struct display_timing *mode)
+{
+	bool is_over_340M;
+
+	mtk_hdmi_hw_reset(hdmi);
+	mtk_hdmi_set_sw_hpd(hdmi, true);
+	udelay(5);
+
+	mtk_hdmi_write(hdmi, HDCP_TOP_CTRL, 0x0);
+
+	mtk_hdmi_set_8bit_color(hdmi);
+	mtk_hdmi_enable_hdmi_mode(hdmi, mode->hdmi_monitor);
+
+	udelay(10);
+	mtk_hdmi_hw_vid_black(hdmi, true);
+
+	/* data islands are an HDMI concept, a DVI sink gets none of them */
+	if (mode->hdmi_monitor) {
+		mtk_hdmi_hw_gcp_avmute(hdmi);
+		mtk_hdmi_update(hdmi, TOP_CFG01, NULL_PKT_VSYNC_HIGH_EN,
+				NULL_PKT_VSYNC_HIGH_EN | NULL_PKT_EN);
+	}
+	udelay(150);
+
+	is_over_340M = mtk_hdmi_tmds_over_340M(mode->pixelclock.typ);
+	dev_dbg(hdmi->dev, "is_over_340M: %d\n", is_over_340M);
+
+	mtk_hdmi_enable_scrambling(hdmi, is_over_340M);
+
+	mtk_hdmi_bypass_yuv420_downsample(hdmi);
+}
+
+static int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
+					    const struct display_timing *mode)
+{
+	unsigned long link_rate = mode->pixelclock.typ;
+	int ret;
+
+	ret = generic_phy_configure(&hdmi->phy, &link_rate);
+	if (ret) {
+		dev_err(hdmi->dev, "failed to set the PHY to %u Hz: %d\n",
+			mode->pixelclock.typ, ret);
+		return ret;
+	}
+
+	mtk_hdmi_change_video_resolution(hdmi, mode);
+
+	return 0;
+}
+
+/*
+ * Copy at most @dst_len bytes of @src into @dst and pad the remainder with
+ * spaces. Unlike strlcpy() this does not NUL-terminate, so the full field
+ * width can be used for the string.
+ */
+static void mtk_hdmi_pad_string(u8 *dst, size_t dst_len, const char *src)
+{
+	size_t src_len = strlen(src);
+
+	if (src_len > dst_len)
+		src_len = dst_len;
+
+	memcpy(dst, src, src_len);
+	memset(dst + src_len, ' ', dst_len - src_len);
+}
+
+static void mtk_hdmi_setup_spd_infoframe(u8 *buffer, const char *vendor,
+					 const char *product)
+{
+	u8 checksum;
+	int i;
+
+	memset(buffer, 0, HDMI_SPD_INFOFRAME_SIZE);
+
+	/* SPD InfoFrame header */
+	buffer[0] = 0x83;  /* SPD InfoFrame type */
+	buffer[1] = 0x01;  /* Version */
+	buffer[2] = 0x19;  /* Length (25 bytes) */
+
+	/* Vendor name (8 bytes) and product description (16 bytes) */
+	mtk_hdmi_pad_string(&buffer[4], 8, vendor);
+	mtk_hdmi_pad_string(&buffer[12], 16, product);
+
+	/* checksum over the full frame, so that the total sums to zero */
+	for (checksum = 0, i = 0; i < HDMI_SPD_INFOFRAME_SIZE; i++)
+		checksum += buffer[i];
+	buffer[3] = 0x100 - checksum;
+}
+
+/* the refresh rate of @timing, in Hz */
+static unsigned int mtk_hdmi_refresh_rate(const struct display_timing *timing)
+{
+	unsigned int htotal, vtotal;
+
+	htotal = timing->hactive.typ + timing->hfront_porch.typ +
+		 timing->hback_porch.typ + timing->hsync_len.typ;
+	vtotal = timing->vactive.typ + timing->vfront_porch.typ +
+		 timing->vback_porch.typ + timing->vsync_len.typ;
+
+	if (!htotal || !vtotal)
+		return 0;
+
+	return DIV_ROUND_CLOSEST(timing->pixelclock.typ, htotal * vtotal);
+}
+
+static const struct mtk_hdmi_vic *
+mtk_hdmi_get_vic(const struct display_timing *timing)
+{
+	unsigned int refresh = mtk_hdmi_refresh_rate(timing);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_hdmi_vics); i++) {
+		const struct mtk_hdmi_vic *vic = &mtk_hdmi_vics[i];
+
+		if (vic->hactive == timing->hactive.typ &&
+		    vic->vactive == timing->vactive.typ &&
+		    vic->refresh == refresh)
+			return vic;
+	}
+
+	return NULL;
+}
+
+static void mtk_hdmi_setup_avi_infoframe(u8 *buffer,
+					 const struct display_timing *mode)
+{
+	const struct mtk_hdmi_vic *vic;
+	u8 checksum;
+	int i;
+
+	memset(buffer, 0, HDMI_AVI_INFOFRAME_SIZE);
+
+	/* AVI InfoFrame header */
+	buffer[0] = 0x82;  /* AVI InfoFrame type */
+	buffer[1] = 0x02;  /* Version */
+	buffer[2] = 0x0D;  /* Length (13 bytes) */
+
+	/*
+	 * Data byte 1: RGB output, no scan or bar information, and A0 set to
+	 * mark the active format information of data byte 2 valid.
+	 */
+	buffer[4] = 0x10;
+
+	/* Data byte 4: Video Identification Code (VIC) */
+	vic = mtk_hdmi_get_vic(mode);
+	buffer[7] = vic ? vic->vic : 0;
+
+	/*
+	 * Data byte 2: active portion same as picture, the picture aspect
+	 * ratio of the VIC, and colorimetry "No Data" since the output is RGB
+	 * (CTA-861 only defines the ITU-601/709 selection for YCbCr). An
+	 * unknown timing gets no aspect ratio rather than a wrong one.
+	 */
+	if (!vic)
+		buffer[5] = 0x08;
+	else
+		buffer[5] = vic->aspect_4_3 ? 0x18 : 0x28;
+
+	/* Data byte 3: no content type, default range, no picture scaling */
+	buffer[6] = 0x00;
+
+	/* Data byte 5: Pixel repetition */
+	buffer[8] = 0x00;  /* No pixel repetition */
+
+	/* checksum over the full frame, so that the total sums to zero */
+	for (checksum = 0, i = 0; i < HDMI_AVI_INFOFRAME_SIZE; i++)
+		checksum += buffer[i];
+	buffer[3] = 0x100 - checksum;
+}
+
+static void mtk_hdmi_hw_avi_infoframe(struct mtk_hdmi *hdmi, const u8 *buf)
+{
+	/* Disable AVI InfoFrame first */
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, 0, AVI_EN_WR | AVI_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, 0, AVI_RPT_EN);
+
+	/* Write AVI InfoFrame header */
+	mtk_hdmi_write(hdmi, TOP_AVI_HEADER, get_unaligned_le24(&buf[0]));
+
+	/* Write AVI InfoFrame data packets */
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT00, get_unaligned_le32(&buf[3]));
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT01, get_unaligned_le24(&buf[7]));
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT02, get_unaligned_le32(&buf[10]));
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT03, get_unaligned_le24(&buf[14]));
+
+	/* Clear remaining packets */
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT04, 0);
+	mtk_hdmi_write(hdmi, TOP_AVI_PKT05, 0);
+
+	/* Enable AVI InfoFrame */
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, AVI_RPT_EN, AVI_RPT_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, AVI_EN_WR | AVI_EN,
+			AVI_EN_WR | AVI_EN);
+}
+
+static void mtk_hdmi_hw_spd_infoframe(struct mtk_hdmi *hdmi, const u8 *buf)
+{
+	/* Disable SPD InfoFrame first */
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, 0, SPD_EN_WR | SPD_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, 0, SPD_RPT_EN);
+
+	/* Write SPD InfoFrame header */
+	mtk_hdmi_write(hdmi, TOP_SPDIF_HEADER, get_unaligned_le24(&buf[0]));
+
+	/* Write SPD InfoFrame data packets */
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT00, get_unaligned_le32(&buf[3]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT01, get_unaligned_le24(&buf[7]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT02, get_unaligned_le32(&buf[10]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT03, get_unaligned_le24(&buf[14]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT04, get_unaligned_le32(&buf[17]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT05, get_unaligned_le24(&buf[21]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT06, get_unaligned_le32(&buf[24]));
+	mtk_hdmi_write(hdmi, TOP_SPDIF_PKT07, buf[28]);
+
+	/* Enable SPD InfoFrame */
+	mtk_hdmi_update(hdmi, TOP_INFO_RPT, SPD_RPT_EN, SPD_RPT_EN);
+	mtk_hdmi_update(hdmi, TOP_INFO_EN, SPD_EN_WR | SPD_EN,
+			SPD_EN_WR | SPD_EN);
+}
+
+static void mtk_hdmi_setup_infoframes(struct mtk_hdmi *hdmi,
+				      const struct display_timing *mode)
+{
+	u8 buffer_spd[HDMI_SPD_INFOFRAME_SIZE];
+	u8 buffer_avi[HDMI_AVI_INFOFRAME_SIZE];
+
+	mtk_hdmi_setup_avi_infoframe(buffer_avi, mode);
+	mtk_hdmi_setup_spd_infoframe(buffer_spd, "MediaTek", "On-chip HDMI");
+
+	/* Send the infoframes to hardware */
+	mtk_hdmi_hw_avi_infoframe(hdmi, buffer_avi);
+	mtk_hdmi_hw_spd_infoframe(hdmi, buffer_spd);
+}
+
+static int mtk_hdmi_controller_pre_enable(struct mtk_hdmi *hdmi,
+					  const struct display_timing *mode)
+{
+	int ret;
+
+	ret = mtk_hdmi_output_set_display_mode(hdmi, mode);
+	if (ret)
+		return ret;
+
+	/* InfoFrames are an HDMI concept, a DVI sink must not be sent any */
+	if (mode->hdmi_monitor)
+		mtk_hdmi_setup_infoframes(hdmi, mode);
+
+	return 0;
+}
+
+static int mtk_hdmi_controller_enable(struct mtk_hdmi *hdmi)
+{
+	int ret;
+
+	ret = generic_phy_power_on(&hdmi->phy);
+	if (ret) {
+		dev_err(hdmi->dev, "failed to power on the PHY: %d\n", ret);
+		return ret;
+	}
+
+	mtk_hdmi_hw_vid_black(hdmi, false);
+
+	return 0;
+}
+
+/*
+ * Mask every transmitter interrupt. Linux keeps
+ * HDCP2X_RX_REAUTH_REQ_DDCM_INT enabled (the hardware uses it internally for
+ * the HPD state machine) and drives HDCP2X_CTRL_0's software HPD override,
+ * but nothing here re-runs HPD detection once the output is set up.
+ */
+static void mtk_hdmi_disable_all_int(struct mtk_hdmi *hdmi)
+{
+	/* disable all tx irq */
+	mtk_hdmi_write(hdmi, TOP_INT_ENABLE00, 0);
+	mtk_hdmi_write(hdmi, TOP_INT_ENABLE01, 0);
+}
+
+static int mtk_hdmi_read_edid(struct mtk_hdmi *hdmi, u8 *buf, int buf_size)
+{
+	const struct edid1_info *edid = (const struct edid1_info *)buf;
+	struct udevice *chip;
+	int ret;
+
+	if (!hdmi->ddc_bus || buf_size < EDID_SIZE)
+		return -EINVAL;
+
+	ret = i2c_get_chip(hdmi->ddc_bus, EDID_ADDR, 1, &chip);
+	if (ret)
+		return ret;
+
+	ret = dm_i2c_read(chip, 0, buf, EDID_SIZE);
+	if (ret) {
+		dev_err(hdmi->dev, "failed to read EDID: %d\n", ret);
+		return ret;
+	}
+
+	/* read the extension block, if any */
+	if (edid->extension_flag && buf_size >= EDID_EXT_SIZE) {
+		ret = dm_i2c_read(chip, EDID_SIZE, buf + EDID_SIZE,
+				  buf_size - EDID_SIZE);
+		if (ret) {
+			dev_warn(hdmi->dev,
+				 "error reading extended EDID block: %d\n",
+				 ret);
+			/*
+			 * The parser looks at the extension block whenever
+			 * the base block announces one, so make sure it
+			 * never sees the leftovers of a failed read.
+			 */
+			memset(buf + EDID_SIZE, 0, buf_size - EDID_SIZE);
+		}
+	}
+
+	return 0;
+}
+
+/* true once a sink is plugged in and powered on */
+static bool mtk_hdmi_hpd_asserted(struct mtk_hdmi *hdmi)
+{
+	u32 mask = HPD_PIN_STA | PORD_PIN_STA;
+
+	return (mtk_hdmi_read(hdmi, HPD_DDC_STATUS) & mask) == mask;
+}
+
+static int mtk_hdmi_wait_for_hpd(struct mtk_hdmi *hdmi)
+{
+	ulong start = get_timer(0);
+
+	do {
+		if (mtk_hdmi_hpd_asserted(hdmi))
+			return 0;
+
+		udelay(100);
+	} while (get_timer(start) < MTK_HDMI_HPD_TIMEOUT_MS);
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * The pipeline reads the frame as two halves and feeds the DPI two pixels per
+ * clock, so it only handles progressive timings of an even width. Rejecting
+ * everything else here lets the EDID parser fall back to the next detailed
+ * timing instead of scanning out a broken one.
+ */
+static bool mtk_hdmi_mode_valid(void *priv, const struct display_timing *timing)
+{
+	if (timing->flags & DISPLAY_FLAGS_INTERLACED)
+		return false;
+
+	if (timing->hactive.typ > MTK_HDMI_MAX_WIDTH ||
+	    timing->vactive.typ > MTK_HDMI_MAX_HEIGHT ||
+	    timing->hactive.typ % 2)
+		return false;
+
+	return timing->pixelclock.typ >= MTK_HDMI_MIN_PIXEL_CLOCK &&
+	       timing->pixelclock.typ <= MTK_HDMI_MAX_PIXEL_CLOCK;
+}
+
+static int mtk_hdmi_get_display_timing(struct mtk_hdmi *hdmi,
+				       struct display_timing *timing)
+{
+	u8 edid[EDID_EXT_SIZE];
+	int panel_bits_per_colour;
+	int ret;
+
+	ret = mtk_hdmi_read_edid(hdmi, edid, EDID_EXT_SIZE);
+	if (ret)
+		return ret;
+
+	ret = edid_get_timing_validate(edid, EDID_EXT_SIZE,
+				       timing, &panel_bits_per_colour,
+				       mtk_hdmi_mode_valid, NULL);
+	if (ret)
+		return ret;
+
+	debug("Display timing:\n clock %u Hz\n", timing->pixelclock.typ);
+	debug(" hactive: %d,\thfront_p: %d,\thback_p: %d hsync:\t%d\n",
+	      timing->hactive.typ, timing->hfront_porch.typ,
+	      timing->hback_porch.typ, timing->hsync_len.typ);
+	debug(" vactive: %d,\tvfront_p: %d,\tvback_p: %d vsync:\t%d\n",
+	      timing->vactive.typ, timing->vfront_porch.typ,
+	      timing->vback_porch.typ, timing->vsync_len.typ);
+	debug(" flags: 0x%x\n", timing->flags);
+
+	return 0;
+}
+
+static int mtk_hdmi_controller_initialize(struct mtk_hdmi *hdmi,
+					  const struct display_timing *mode)
+{
+	int ret;
+
+	mtk_hdmi_disable_all_int(hdmi);
+
+	mtk_hdmi_disable_abist(hdmi);
+
+	ret = mtk_hdmi_controller_pre_enable(hdmi, mode);
+	if (ret)
+		return ret;
+
+	/* let the new configuration settle before unmuting the output */
+	mdelay(50);
+
+	return mtk_hdmi_controller_enable(hdmi);
+}
+
+static int mtk_hdmi_get_comp_by_alias(struct udevice *dev, const char *alias,
+				      struct udevice **compp)
+{
+	struct udevice *comp;
+	ofnode node;
+	int ret;
+
+	node = ofnode_get_aliases_node(alias);
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "cannot find alias %s\n", alias);
+		return -ENODEV;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_MISC, node, &comp);
+	if (ret) {
+		dev_err(dev, "cannot get %s: %d\n", alias, ret);
+		return ret;
+	}
+
+	ret = mtk_disp_comp_enable(comp);
+	if (ret)
+		return ret;
+
+	/*
+	 * Only publish the handle once its clocks are on, so the error
+	 * unwind can rely on a non-NULL pointer meaning "enabled".
+	 */
+	*compp = comp;
+
+	return 0;
+}
+
+/* disable the pipeline component clocks, in reverse acquisition order */
+static void mtk_hdmi_disable_components(struct mtk_hdmi *hdmi)
+{
+	struct udevice *comps[] = {
+		hdmi->padding5, hdmi->padding4, hdmi->mutex, hdmi->ethdr,
+		hdmi->merge5, hdmi->merge3, hdmi->rdma5, hdmi->rdma4,
+		hdmi->dpi1,
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(comps); i++)
+		if (comps[i])
+			mtk_disp_comp_disable(comps[i]);
+}
+
+/*
+ * Program the vdosys1 muxes to route the mixer output to the DPI1/HDMI path,
+ * and size the asynchronous wrappers along it. The mixer and the merges run
+ * in a two-pixel-per-clock domain, hence the half widths.
+ *
+ * Unlike the Linux MT8188 routing table, which muxes the mixer output
+ * straight to the merge4 async wrapper (MIXER_OUT_SOUT_SEL and
+ * MERGE4_ASYNC_SEL_IN set to 1), the HDR video back-end is deliberately kept
+ * in the path, in bypass (see mtk_ethdr_config()).
+ *
+ * vdosys1 has no power domain of its own in the devicetree: this relies on
+ * the VDOSYS1 domain having already been powered on by the probe of a
+ * pipeline component, such as dpi1.
+ */
+static void mtk_hdmi_configure_vdosys1(void __iomem *base, u16 width,
+				       u16 height)
+{
+	/* MERGE2_ASYNC_SOUT --> MIXER_IN3_SEL */
+	writel(OUTPUT_TO_MIXER_IN3_SEL, base + SUBDISP_MERGE2_ASYNC_SOUT_SEL);
+	writel(INPUT_FROM_MERGE2_ASYNC_SOUT, base + SUBDISP_MIXER_IN3_SEL_IN);
+
+	/* MIXER_IN3_SOUT --> DISP_MIXER */
+	writel(OUTPUT_TO_DISP_MIXER, base + SUBDISP_MIXER_IN3_SOUT_SEL);
+
+	/* DISP_MIXER --> MIXER_SOUT_SEL */
+	writel(INPUT_FROM_DISP_MIXER, base + SUBDISP_MIXER_SOUT_SEL_IN);
+
+	/* MIXER_SOUT_SEL --> HDR_VDO_BE0 */
+	writel(OUTPUT_TO_HDR_VDO_BE0, base + SUBDISP_MIXER_OUT_SOUT_SEL);
+
+	/* HDR_VDO_BE0 --> MERGE4_ASYNC_SEL */
+	writel(INPUT_FROM_HDR_VDO_BE0, base + SUBDISP_MERGE4_ASYNC_SEL_IN);
+
+	/* MERGE4_MOUT_SEL --> DPI1_SEL */
+	writel(OUTPUT_TO_DPI1_SEL, base + SUBDISP_DISP_MERGE4_MOUT_SEL);
+	writel(INPUT_FROM_VPP_MERGE4_MOUT, base + SUBDISP_DISP_DPI1_SEL_IN);
+
+	/* merge3 --> mixer_in3 and mixer_sout --> merge5 async wrapper sizes */
+	writel(height << 16 | width / 2, base + SUBDISP_MERGE2_ASYNC_CFG_WD);
+	writel(height << 16 | width / 2, base + SUBDISP_HDRBE_ASYNC_CFG_WD);
+
+	/* mixer input 3: bypass mode, no channel swap (bit 4 left clear) */
+	writel(FIELD_PREP(MIXER_IN_PAD_BI_WIDTH, width / 2 - 1) |
+	       MIXER_IN_PAD_MODE_BYPASS, base + SUBDISP_MIXER_IN3_PAD);
+}
+
+static int mtk_hdmi_probe(struct udevice *dev)
+{
+	struct mtk_hdmi *hdmi = dev_get_priv(dev);
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct display_timing timing;
+	struct udevice *vdosys1;
+	u32 fb_size;
+	void __iomem *vdosys1_base;
+	ofnode node;
+	int ret;
+
+	hdmi->dev = dev;
+
+	hdmi->regs = dev_remap_addr(dev);
+	if (!hdmi->regs)
+		return -EINVAL;
+
+	ret = clk_get_bulk(dev, &hdmi->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable_bulk(&hdmi->clk_bulk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		return ret;
+	}
+
+	ret = generic_phy_get_by_name(dev, "hdmi", &hdmi->phy);
+	if (ret) {
+		dev_err(dev, "failed to get HDMI PHY: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C,
+					  dev_read_subnode(dev, "i2c"),
+					  &hdmi->ddc_bus);
+	if (ret) {
+		dev_err(dev, "failed to get DDC I2C bus: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret = mtk_hdmi_wait_for_hpd(hdmi);
+	if (ret) {
+		/*
+		 * Booting without a display attached is perfectly normal, so
+		 * keep this quiet even though the probe has to fail: there is
+		 * nothing for the video uclass to drive.
+		 */
+		dev_dbg(dev, "display is not connected\n");
+		goto err_disable_clk;
+	}
+
+	ret = mtk_hdmi_get_display_timing(hdmi, &timing);
+	if (ret) {
+		dev_err(dev, "failed to get display timing from EDID: %d\n",
+			ret);
+		goto err_disable_clk;
+	}
+
+	/* this powers on the HDMI PHY */
+	ret = mtk_hdmi_controller_initialize(hdmi, &timing);
+	if (ret)
+		goto err_disable_clk;
+
+	/* Set up video private data based on the selected display timing */
+	priv->bpix = VIDEO_BPP32;
+	priv->format = VIDEO_X8R8G8B8;
+	priv->xsize = timing.hactive.typ;
+	priv->ysize = timing.vactive.typ;
+	priv->line_length = priv->xsize * VNBYTES(VIDEO_BPP32);
+
+	/*
+	 * The framebuffer is only cleared by video_post_probe(), after this
+	 * function has already started scanning it out: zero the part about
+	 * to be displayed first, so that whatever the memory holds is never
+	 * shown.
+	 */
+	fb_size = priv->ysize * priv->line_length;
+	memset(map_sysmem(plat->base, fb_size), 0, fb_size);
+	flush_dcache_range(plat->base, plat->base + fb_size);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "dpi1", &hdmi->dpi1);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_dpi_config(hdmi->dpi1, &timing);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "vdo1-rdma4", &hdmi->rdma4);
+	if (ret)
+		goto err_disable_comps;
+
+	ret = mtk_mdp_rdma_config(hdmi->rdma4, plat, &timing,
+				  priv->line_length, false);
+	if (ret)
+		goto err_disable_comps;
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "vdo1-rdma5", &hdmi->rdma5);
+	if (ret)
+		goto err_disable_comps;
+
+	ret = mtk_mdp_rdma_config(hdmi->rdma5, plat, &timing,
+				  priv->line_length, true);
+	if (ret)
+		goto err_disable_comps;
+
+	/*
+	 * The display routing muxes live in the vdosys1 syscon register block.
+	 * It is a clock provider rather than a pipeline component, so resolve
+	 * it by compatible and grab the register base directly.
+	 */
+	node = ofnode_by_compatible(ofnode_null(), "mediatek,mt8188-vdosys1");
+	if (!ofnode_valid(node)) {
+		dev_err(dev, "cannot find vdosys1 node\n");
+		ret = -ENODEV;
+		goto err_disable_comps;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_CLK, node, &vdosys1);
+	if (ret) {
+		dev_err(dev, "cannot get vdosys1 syscon: %d\n", ret);
+		goto err_disable_comps;
+	}
+
+	vdosys1_base = dev_remap_addr(vdosys1);
+	if (!vdosys1_base) {
+		ret = -EINVAL;
+		goto err_disable_comps;
+	}
+
+	mtk_hdmi_configure_vdosys1(vdosys1_base, priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "merge3", &hdmi->merge3);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_merge_config(hdmi->merge3, priv->xsize / 2, priv->xsize / 2,
+			      priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "merge5", &hdmi->merge5);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_merge_config(hdmi->merge5, priv->xsize, 0, priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "ethdr0", &hdmi->ethdr);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_ethdr_config(hdmi->ethdr, priv->xsize, priv->ysize);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "mutex1", &hdmi->mutex);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_mutex_config_hdmi(hdmi->mutex);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "padding4", &hdmi->padding4);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_padding_config(hdmi->padding4);
+
+	ret = mtk_hdmi_get_comp_by_alias(dev, "padding5", &hdmi->padding5);
+	if (ret)
+		goto err_disable_comps;
+
+	mtk_disp_padding_config(hdmi->padding5);
+
+	/* the timing generator goes last, once the pipeline feeding it is up */
+	mtk_dpi_hw_enable(hdmi->dpi1);
+
+	video_set_flush_dcache(dev, true);
+
+	return 0;
+
+err_disable_comps:
+	if (hdmi->dpi1)
+		mtk_dpi_hw_disable(hdmi->dpi1);
+	mtk_hdmi_disable_components(hdmi);
+	generic_phy_power_off(&hdmi->phy);
+err_disable_clk:
+	clk_disable_bulk(&hdmi->clk_bulk);
+
+	return ret;
+}
+
+/*
+ * The HDMI TX node has a single, SoC-specific compatible, and the vdosys1
+ * routing programmed above is MT8188 specific as well.
+ */
+static const struct udevice_id mtk_hdmi_ids[] = {
+	{
+		.compatible = "mediatek,mt8188-hdmi-tx",
+	},
+	{ }
+};
+
+/*
+ * The framebuffer has to be reserved before relocation, long before the EDID
+ * says which mode the sink wants, so ask for the largest one this driver
+ * accepts.
+ */
+static int mtk_hdmi_bind(struct udevice *dev)
+{
+	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->size = MTK_HDMI_MAX_WIDTH * MTK_HDMI_MAX_HEIGHT *
+		     VNBYTES(VIDEO_BPP32);
+
+	return dm_scan_fdt_dev(dev);
+}
+
+U_BOOT_DRIVER(mtk_hdmi) = {
+	.name		= "mtk_hdmi",
+	.id		= UCLASS_VIDEO,
+	.of_match	= mtk_hdmi_ids,
+	.probe		= mtk_hdmi_probe,
+	.bind		= mtk_hdmi_bind,
+	.priv_auto	= sizeof(struct mtk_hdmi),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/video/mediatek/mtk_hdmi_regs_v2.h b/drivers/video/mediatek/mtk_hdmi_regs_v2.h
new file mode 100644
index 00000000000..435da311110
--- /dev/null
+++ b/drivers/video/mediatek/mtk_hdmi_regs_v2.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2021 BayLibre, SAS
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _MTK_HDMI_REGS_H
+#define _MTK_HDMI_REGS_H
+
+/* HDMI_TOP Config */
+#define TOP_CFG00			0x000
+#define  HDMI2_ON			BIT(2)
+#define  HDMI_MODE_HDMI			BIT(3)
+#define  SCR_ON				BIT(4)
+#define  TMDS_PACK_MODE			GENMASK(9, 8)
+#define   TMDS_PACK_MODE_8BPP		0
+#define   TMDS_PACK_MODE_10BPP		1
+#define   TMDS_PACK_MODE_12BPP		2
+#define   TMDS_PACK_MODE_16BPP		3
+#define  DEEPCOLOR_PKT_EN		BIT(12)
+#define  HDMI_ABIST_VIDEO_FORMAT	GENMASK(21, 16)
+#define  HDMI_ABIST_ENABLE		BIT(31)
+#define TOP_CFG01 0x004
+#define  CP_SET_MUTE_EN			BIT(0)
+#define  CP_CLR_MUTE_EN			BIT(1)
+#define  NULL_PKT_EN			BIT(2)
+#define  NULL_PKT_VSYNC_HIGH_EN		BIT(3)
+
+/* HDMI_TOP Audio: Channel Mapping */
+#define TOP_AUD_MAP			0x00c
+#define  SD0_MAP			GENMASK(2, 0)
+#define  SD1_MAP			GENMASK(6, 4)
+#define  SD2_MAP			GENMASK(10, 8)
+#define  SD3_MAP			GENMASK(14, 12)
+#define  SD4_MAP			GENMASK(18, 16)
+#define  SD5_MAP			GENMASK(22, 20)
+#define  SD6_MAP			GENMASK(26, 24)
+#define  SD7_MAP			GENMASK(30, 28)
+
+/* Auxiliary Video Information (AVI) Infoframe */
+#define TOP_AVI_HEADER			0x024
+#define TOP_AVI_PKT00			0x028
+#define TOP_AVI_PKT01			0x02C
+#define TOP_AVI_PKT02			0x030
+#define TOP_AVI_PKT03			0x034
+#define TOP_AVI_PKT04			0x038
+#define TOP_AVI_PKT05			0x03C
+
+/* Audio Interface Infoframe */
+#define TOP_AIF_HEADER			0x040
+#define TOP_AIF_PKT00			0x044
+#define TOP_AIF_PKT01			0x048
+#define TOP_AIF_PKT02			0x04c
+#define TOP_AIF_PKT03			0x050
+
+/* Audio SPDIF Infoframe */
+#define TOP_SPDIF_HEADER		0x054
+#define TOP_SPDIF_PKT00			0x058
+#define TOP_SPDIF_PKT01			0x05c
+#define TOP_SPDIF_PKT02			0x060
+#define TOP_SPDIF_PKT03			0x064
+#define TOP_SPDIF_PKT04			0x068
+#define TOP_SPDIF_PKT05			0x06c
+#define TOP_SPDIF_PKT06			0x070
+#define TOP_SPDIF_PKT07			0x074
+
+/* Infoframes Configuration */
+#define TOP_INFO_EN			0x01c
+#define  AVI_EN				BIT(0)
+#define  SPD_EN				BIT(1)
+#define  AUD_EN				BIT(2)
+#define  CP_EN				BIT(5)
+#define  VSIF_EN			BIT(11)
+#define  AVI_EN_WR			BIT(16)
+#define  SPD_EN_WR			BIT(17)
+#define  AUD_EN_WR			BIT(18)
+#define  CP_EN_WR			BIT(21)
+#define  VSIF_EN_WR			BIT(27)
+#define TOP_INFO_RPT			0x020
+#define  AVI_RPT_EN			BIT(0)
+#define  SPD_RPT_EN			BIT(1)
+#define  AUD_RPT_EN			BIT(2)
+#define  CP_RPT_EN			BIT(5)
+#define  VSIF_RPT_EN			BIT(11)
+
+/* Vendor Specific Infoframe */
+#define TOP_VSIF_HEADER			0x174
+#define TOP_VSIF_PKT00			0x178
+#define TOP_VSIF_PKT01			0x17c
+#define TOP_VSIF_PKT02			0x180
+#define TOP_VSIF_PKT03			0x184
+#define TOP_VSIF_PKT04			0x188
+#define TOP_VSIF_PKT05			0x18c
+#define TOP_VSIF_PKT06			0x190
+#define TOP_VSIF_PKT07			0x194
+
+/* HDMI_TOP Misc */
+#define TOP_MISC_CTLR			0x1a4
+#define  DEEP_COLOR_ADD			BIT(4)
+
+/* Hardware interrupts */
+#define TOP_INT_STA00			0x1a8
+#define TOP_INT_ENABLE00		0x1b0
+#define  HTPLG_R_INT			BIT(0)
+#define  HTPLG_F_INT			BIT(1)
+#define  PORD_R_INT			BIT(2)
+#define  PORD_F_INT			BIT(3)
+#define  HDMI_VSYNC_INT			BIT(4)
+#define  HDMI_AUDIO_INT			BIT(5)
+#define  HDCP2X_RX_REAUTH_REQ_DDCM_INT	BIT(25)
+#define TOP_INT_ENABLE01		0x1b4
+#define TOP_INT_CLR00			0x1b8
+#define TOP_INT_CLR01			0x1bc
+
+
+/* Video Mute */
+#define TOP_VMUTE_CFG1			0x1c8
+#define  REG_VMUTE_EN			BIT(16)
+
+/* HDMI Audio IP */
+#define AIP_CTRL			0x400
+#define  CTS_SW_SEL			BIT(0)
+#define  CTS_REQ_EN			BIT(1)
+#define  MCLK_EN			BIT(2)
+#define  NO_MCLK_CTSGEN_SEL		BIT(3)
+#define  AUD_IN_EN			BIT(8)
+#define  AUD_SEL_OWRT			BIT(9)
+#define  SPDIF_EN			BIT(13)
+#define  HBRA_ON			BIT(14)
+#define  DSD_EN				BIT(15)
+#define  I2S_EN				GENMASK(19, 16)
+#define  HBR_FROM_SPDIF			BIT(20)
+#define  CTS_CAL_N4			BIT(23)
+#define  SPDIF_INTERNAL_MODULE		BIT(24)
+#define AIP_N_VAL			0x404
+#define AIP_CTS_SVAL			0x408
+#define AIP_SPDIF_CTRL			0x40c
+#define  WR_1UI_LOCK			BIT(0)
+#define  FS_OVERRIDE_WRITE		BIT(1)
+#define  WR_2UI_LOCK			BIT(2)
+#define  MAX_1UI_WRITE			GENMASK(15, 8)
+#define  MAX_2UI_SPDIF_WRITE		GENMASK(23, 16)
+#define  MAX_2UI_I2S_HI_WRITE		GENMASK(23, 20)
+#define   MAX_2UI_I2S_LFE_CC_SWAP	BIT(1)
+#define  MAX_2UI_I2S_LO_WRITE		GENMASK(19, 16)
+#define  AUD_ERR_THRESH			GENMASK(29, 24)
+#define  I2S2DSD_EN			BIT(30)
+#define AIP_I2S_CTRL			0x410
+#define  FIFO0_MAP			GENMASK(1, 0)
+#define  FIFO1_MAP			GENMASK(3, 2)
+#define  FIFO2_MAP			GENMASK(5, 4)
+#define  FIFO3_MAP			GENMASK(7, 6)
+#define  I2S_1ST_BIT_NOSHIFT		BIT(8)
+#define  I2S_DATA_DIR_LSB		BIT(9)
+#define  JUSTIFY_RIGHT			BIT(10)
+#define  WS_HIGH			BIT(11)
+#define  VBIT_COMPRESSED		BIT(12)
+#define  CBIT_ORDER_SAME		BIT(13)
+#define  SCK_EDGE_RISE			BIT(14)
+#define AIP_I2S_CHST0			0x414
+#define AIP_I2S_CHST1			0x418
+#define AIP_TXCTRL			0x424
+#define  RST4AUDIO			BIT(0)
+#define  RST4AUDIO_FIFO			BIT(1)
+#define  RST4AUDIO_ACR			BIT(2)
+#define  AUD_LAYOUT_1			BIT(4)
+#define  AUD_MUTE_FIFO_EN		BIT(5)
+#define  AUD_PACKET_DROP		BIT(6)
+#define  DSD_MUTE_EN			BIT(7)
+#define AIP_TPI_CTRL			0x428
+#define  TPI_AUDIO_LOOKUP_EN		BIT(2)
+
+/* Video downsampling configuration */
+#define VID_DOWNSAMPLE_CONFIG		0x8f0
+#define  C444_C422_CONFIG_ENABLE	BIT(0)
+#define  C422_C420_CONFIG_ENABLE	BIT(4)
+#define  C422_C420_CONFIG_BYPASS	BIT(5)
+#define  C422_C420_CONFIG_OUT_CB_OR_CR	BIT(6)
+#define VID_OUT_FORMAT			0x8fc
+#define  OUTPUT_FORMAT_DEMUX_420_ENABLE	BIT(10)
+
+/* HDCP registers */
+#define HDCP_TOP_CTRL			0xc00
+#define HDCP2X_CTRL_0			0xc20
+#define  HDCP2X_EN			BIT(0)
+#define  HDCP2X_ENCRYPT_EN		BIT(7)
+#define  HDCP2X_HPD_OVR			BIT(10)
+#define  HDCP2X_HPD_SW			BIT(11)
+#define HDCP2X_POL_CTRL			0xc54
+#define  HDCP2X_DIS_POLL_EN		BIT(16)
+#define HDCP1X_CTRL			0xcd0
+#define  HDCP1X_ENC_EN			BIT(6)
+
+/* HDMI DDC registers */
+#define HPD_DDC_CTRL			0xc08
+#define  HPD_DDC_DELAY_CNT		GENMASK(31, 16)
+#define  HPD_DDC_HPD_DBNC_EN		BIT(2)
+#define  HPD_DDC_PORD_DBNC_EN		BIT(3)
+#define DDC_CTRL			0xc10
+#define  DDC_CTRL_ADDR			GENMASK(7, 1)
+#define  DDC_CTRL_OFFSET		GENMASK(15, 8)
+#define  DDC_CTRL_DIN_CNT		GENMASK(25, 16)
+#define  DDC_CTRL_CMD			GENMASK(31, 28)
+#define SCDC_CTRL			0xc18
+#define  SCDC_DDC_SEGMENT		GENMASK(15, 8)
+#define HPD_DDC_STATUS			0xc60
+#define  HPD_STATE			GENMASK(1, 0)
+#define   HPD_STATE_CONNECTED		2
+#define  HPD_PIN_STA			BIT(4)
+#define  PORD_PIN_STA			BIT(5)
+#define  DDC_I2C_IN_PROG		BIT(13)
+#define  DDC_DATA_OUT			GENMASK(23, 16)
+#define SI2C_CTRL			0xcac
+#define  SI2C_WR			BIT(0)
+#define  SI2C_RD			BIT(1)
+#define  SI2C_CONFIRM_READ		BIT(2)
+#define  SI2C_WDATA			GENMASK(15, 8)
+#define  SI2C_ADDR			GENMASK(23, 16)
+
+/* HDCP DDC registers */
+#define HDCP2X_DDCM_STATUS		0xc68
+#define  DDC_I2C_NO_ACK			BIT(10)
+#define  DDC_I2C_BUS_LOW		BIT(11)
+
+/* HDMI TX registers */
+#define HDMITX_CONFIG_MT8188		0xea0
+#define HDMITX_CONFIG_MT8195		0x900
+#define  HDMI_YUV420_MODE		BIT(10)
+#define  HDMITX_SW_HPD			BIT(29)
+#define  HDMITX_SW_RSTB			BIT(31)
+
+/**
+ * enum mtk_hdmi_ddc_v2_cmds - DDC_CMD register commands
+ * @DDC_CMD_READ_NOACK:      Current address read with no ACK on last byte
+ * @DDC_CMD_READ:            Current address read with ACK on last byte
+ * @DDC_CMD_SEQ_READ_NOACK:  Sequential read with no ACK on last byte
+ * @DDC_CMD_SEQ_READ:        Sequential read with ACK on last byte
+ * @DDC_CMD_ENH_READ_NOACK:  Enhanced read with no ACK on last byte
+ * @DDC_CMD_ENH_READ:        Enhanced read with ACK on last byte
+ * @DDC_CMD_SEQ_WRITE_NOACK: Sequential write ignoring ACK on last byte
+ * @DDC_CMD_SEQ_WRITE:       Sequential write requiring ACK on last byte
+ * @DDC_CMD_RSVD:            Reserved for future use
+ * @DDC_CMD_CLEAR_FIFO:      Clear DDC I2C FIFO
+ * @DDC_CMD_CLOCK_SCL:       Start clocking DDC I2C SCL
+ * @DDC_CMD_ABORT_XFER:      Abort DDC I2C transaction
+ */
+enum mtk_hdmi_ddc_v2_cmds {
+	DDC_CMD_READ_NOACK = 0x0,
+	DDC_CMD_READ,
+	DDC_CMD_SEQ_READ_NOACK,
+	DDC_CMD_SEQ_READ,
+	DDC_CMD_ENH_READ_NOACK,
+	DDC_CMD_ENH_READ,
+	DDC_CMD_SEQ_WRITE_NOACK,
+	DDC_CMD_SEQ_WRITE = 0x07,
+	DDC_CMD_CLEAR_FIFO = 0x09,
+	DDC_CMD_CLOCK_SCL = 0x0a,
+	DDC_CMD_ABORT_XFER = 0x0f
+};
+
+#endif /* _MTK_HDMI_REGS_H */

-- 
2.55.0

