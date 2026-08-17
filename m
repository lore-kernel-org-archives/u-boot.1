Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC223C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B23EC60852;
	Mon, 17 Aug 2026 13:34:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKFiAjBRH4Zg; Mon, 17 Aug 2026 13:34:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA4926084D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973673;
	bh=MVmDvCTDaLiIg/uUvwRtwVPie0drcrbgjxFvbq+gTtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PWkZWoSQqNApDC1yAlDxzxs+4sTHYjrO3KOGgSzrTa/lGgE04TWXjquYXoBEgcsxp
	 9jJ3OQthxcRIjcrtFomeXc9K0zeeh2RGgn2vlfifyVFbohK1I//hvylPud74HsDRHr
	 Wq6YtOAh4YCd6qLePf2qhakFR1C8wliSLJGT1OPuJlhR7BHuNv8bllQymkDP6OblI+
	 Bd0GxyPGvY8NVn38iC5/t+NaFDNNu2dIo7Ai4Ad1bjRQITkTSe09fH3XV6igGGBGOs
	 RdUyX1S0IvSkKAyEW7x3slU/7Lz5WRBwARQcUSVKFPJaNHMVxxrG+yoRNcfI1g2nSL
	 TFoyAkTkFVUzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA4926084D;
	Mon, 17 Aug 2026 13:34:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C096E23F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECCE940735
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njB7B7gRb0RQ for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:31:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5918940731
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5918940731
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NeSLk2Kv
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5918940731
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5945E6020E;
 Mon, 17 Aug 2026 09:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D195B1F000E9;
 Mon, 17 Aug 2026 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959117;
 bh=MVmDvCTDaLiIg/uUvwRtwVPie0drcrbgjxFvbq+gTtI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NeSLk2Kv7BLAHGGuZpG0G+VR7rIF706G5bvJflmLpQSFWS0agVJwsHUz9xmslmcqP
 HL99O/iWtylB0LGC4BK5EqdmgzPlKBCRLrZi4P/omqqJbMkQNCNBv8bf+pv07YLkKu
 0Tj4Dr1uDK4kjeXM9mzI3SoCoNxXy/GP5iz9+zHDTnu9i93CgKmq9IMVJ4OgOpK+Sb
 Ftv7jqETzntAAUlOretwZMJFxSVx5EG+l9VYN5AHILo5yTHONyp9Cjt7IHdw1HBgMh
 MNCUHobfXQQYJBdeYKdphc/GkxRUGWUzRXADwK2wWPZSDtyS5glpHbFyARhHmwixA3
 os1Nre7vpBngg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:51 +0200
Subject: [PATCH v2 2/8] mmc: arm_pl180: Configure Ux500 signal direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-2-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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

