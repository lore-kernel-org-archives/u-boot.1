Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDCAC624C6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A75BF406DA;
	Tue,  1 Sep 2026 09:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 68qxy3tYXhaI; Tue,  1 Sep 2026 09:13:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253993;
	bh=0LnAcxOmzhh8cikNUoNXaMHMHLsuXANh4B1Ydb94IoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYD9azuOztXN3cO4m4q3ASFzY/ZYWIJ12i8TyFojrOz2NHsctMq0Myh57Ym54I/mf
	 7z/Dv+Z21CyiV4dtAxIS4t/w4iufIbLzmAg97PliSdSUge2690q9fN2XnM0PToQ0A7
	 Es9T09PshBmDOgb/sJwcQKaT2Bs+9GmEcOUJv3jB+Y8EmcEgNQ+jT796DTL8KX27QC
	 k+BC99Y5pYSdZw9XM/FKWDoAtvPpTXfUxgU1Kul9dXmNRvojdozrdY57aAGtoLtjYj
	 G+01DojXP3sMlzqgI8vp5dFNqV5ybBrTSBKI7nAyq3rUgZj+C6NlWhZQZJrlKBzgBd
	 VM2xiFy3wAv6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4862406CC;
	Tue,  1 Sep 2026 09:13:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 082C9105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE55F406CE
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjiMLTUXlB5Y for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DYBm36Ae
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48A03406C6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EAD76602CA;
 Tue,  1 Sep 2026 09:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F99D1F000E9;
 Tue,  1 Sep 2026 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253988;
 bh=0LnAcxOmzhh8cikNUoNXaMHMHLsuXANh4B1Ydb94IoU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DYBm36Ae5wyx3JKAJ9tIaW4LbZGFf4Dr52tqAFTaRypkdYVQ4M/+Iko8WE/3Yp8hK
 y/44lF6XFB6CdzRVtwZ93JYQKOGlWt0vYzkA2A/hZa7Lc8+1PkJllCcS/CCq5D7lQO
 5cTBkyzc6dpkA5JrP+N/iOYBtf9/12aGy6WMLNHF5zMhXnMEtR2vjqy8BvtxKNUt0j
 qNWTu+1fs3Mqfss1dTDbZ1me2G1mssW2x4uX7QcCI1r5vrm2KpNisCsZmrK1tjqSeV
 rZe9vSCBNX2BLGpwCV/ByGv5zLIzDe9gIvoXr44T8cf4cGADs0neUdYa9hWxRRF2so
 KPLENFFqmlb2A==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:00 +0200
Subject: [PATCH v7 02/13] mmc: arm_pl180: Configure Ux500 signal direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-2-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
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

The Ux500 MMCI variant can control external level-shifter signal
directions through the power register. Parse the standard ST MMCI
device tree properties and set the corresponding direction and
feedback-clock bits.

This is required by the external SD card slot on Samsung Janice, where
commands cannot reach the card unless the direction controls are set.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Acked-by: Peng Fan <peng.fan@nxp.com>
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

