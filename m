Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4936C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37ADE607D4;
	Mon, 17 Aug 2026 13:34:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cBiymMYMefCS; Mon, 17 Aug 2026 13:34:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16E69607BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973647;
	bh=MVmDvCTDaLiIg/uUvwRtwVPie0drcrbgjxFvbq+gTtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NBRCjVDmIJYrTEA+bAAlwE0FI8jhRgcxZ+Uhra5hNGPt6RpmdmOxfVnUX40bRuZHJ
	 R666xrV/RSJ7KL2yaZMWGdCD0lQPJ4jVIXHVpKWGtgjN9Bczp1d0gpXpcRbFFYnB26
	 KuwBoqccL/h4OkV2WSrKIrm19FIC/RuSsmUQpY/Bf4uvzibWdLcl1nJG+JY3XLDWMA
	 vKxQjc2xCDcJSKRw+Ojlg1wLLlZjvn0vu2Q/CawmjuRH6tvXnZDDDICovyNFjI8Opy
	 NZDzF7gb2eDZxblO7hS2HupHGjfFTNp+sjm5VEJuUI+mVZFj2T6z/zUKSw5gpy7cQU
	 ZejOahcB0Ep8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 16E69607BA;
	Mon, 17 Aug 2026 13:34:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9296B2B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 846C640726
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m3-rMZBHJA5W for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 990E1406A8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 990E1406A8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=nZBeWp2d
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 990E1406A8
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB792404AF;
 Mon, 17 Aug 2026 08:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B1F1F000E9;
 Mon, 17 Aug 2026 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956258;
 bh=MVmDvCTDaLiIg/uUvwRtwVPie0drcrbgjxFvbq+gTtI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nZBeWp2dGPUFrfC1qJF/0UVRJXvi8lBEHMt5hO2a/0f1DA+IFSXapUEbFED2kYvsi
 8ecj0GgXsYfezkXTy0/0ICawOuP0hY2cTHrN3GC0Gn/UqMds8ojnl3/1HvUJl3I7nS
 gsi6khv//wZJDygrb4rJ/WTtuCcdSGyIXydIRX9wb8d98EamGoakxDKGQMW6ACbzoj
 Z7/3Zsc+sCV2FIclApFMzu3F3faCfHRcheCYmDljIgYvN7yN30677ojYPN0Gs1aSDs
 wBCSjiTsi8Z2FWjqd31x+cRI7Wf4pqixh+ar6fXNIM27/OBVE0mWzpblBZ0y6Xy+QR
 uUDwTjjGAHKLQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:06 +0200
Subject: [PATCH 2/8] mmc: arm_pl180: Configure Ux500 signal direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-2-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:57 +0000
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

The Ux500 MMCI variant can control external level-shifter signal
directions through the power register. Parse the standard ST MMCI
device tree properties and set the corresponding direction and
feedback-clock bits.

This is required by the external SD card slot on Samsung Janice, where
commands cannot reach the card unless the direction controls are set.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index f00b0ff0dc95..af21b814641e 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -427,6 +427,19 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 		host->version2 = false; /* ARM variant */
 	}
 
+	if (dev_read_bool(dev, "st,sig-dir-dat0"))
+		host->pwr_init |= SDI_PWR_DAT0DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat2"))
+		host->pwr_init |= SDI_PWR_DAT2DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat31"))
+		host->pwr_init |= SDI_PWR_DAT31DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat74"))
+		host->pwr_init |= SDI_PWR_DAT74DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-cmd"))
+		host->pwr_init |= SDI_PWR_CMDDIREN;
+	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
+		host->pwr_init |= SDI_PWR_FBCLKEN;
+
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
 
 	ret = mmc_of_parse(dev, cfg);

-- 
2.55.0

