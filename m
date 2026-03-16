Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAE0F53D81
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 18:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E028184144;
	Mon, 16 Mar 2026 19:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="yTtZnCNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD3A84105; Mon, 16 Mar 2026 17:42:09 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F81084088
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-485445e80bdso42508505e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1773679327; x=1774284127; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i+DmVgQoyzj6fn5CSyGFNueCxPGLUBBy+IvUThTMHQ0=;
 b=yTtZnCNQ/ddSjhZWKB0VGzeovULClNPuHUaLczHviUmCGt0ZdN6PtsIDhUX2AA2fqz
 zkfjF5kQbISpjFHJTjGcwEcHJZJ8nMz201u2F2akeiHaXUizAe5InMF1ap5RQzMbyQjx
 +9RdvyJUHKlKR3XzTjwML76iIQ/lawG3HTMuR5mBYHqmvjAqp1I3rztaFWsMsp3uNiJ4
 L0d+q3kqSvzOHa5GJ8oYhjgqvyBijk/ADF6MPOPdqei6sOZu6/52ZNfcLP02ClUKnOCD
 lF6azMsHy7iJSt+crdLXNFYA0HBGbjn8nc+J9x3zBZE2y3by9f3YwblIWUx2oTUN/PUM
 fqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773679327; x=1774284127;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+DmVgQoyzj6fn5CSyGFNueCxPGLUBBy+IvUThTMHQ0=;
 b=GBEBFHHc5LsYlUedODT4K79ZNnGJm3HI1ZvP9ZAmJMT50Wd+NGzQj91xwKFljLNu3a
 maYYikMgA3D13IZliJ1tI2fEiPUv9dcBHiGfVKuSEfwngK8aPjs7bvqbQDmxX2YB/RHT
 WG1F12d5XS7ygeS8jAooapG81DBhdQUYFp4vBHZzwyOWx6PlAZP3pjo1LVLIgGWtNfnn
 Qc6eOptcdNUdEmaUvYUWqUUIyMTeW7Tjkio5LJtSm/9TApCigWeNtgWZn49CwLuUHSoI
 BfHJfA6tpmBml9WO43ACfaQjDlLC24c7/Ue2gjR5Jj5nq1XJTBi1WujYxed3qgXO7gqv
 AIeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl5mHfo5ku+MyIsF3Tv0wu4wKrAF8Rb0iRHQFqVUfqTkKS3B1ijP0yLPnhbGl8p2+3CS2VDfs=@lists.denx.de
X-Gm-Message-State: AOJu0YydmXfS1TEri/UiYiKnpCSRYBXZH4HU5s948332AudxtpcGBnHy
 QK/MmJ2AODhha40U5aqFkiJ3heEyUqbp9n1427CAWbj80cryZkJY6/uzDjoIbM8Ic+k=
X-Gm-Gg: ATEYQzyr/mmglVkPZH9YTpQ+fVzXlUJeAcWt6whOpjfwwnSyDgZZHs+y4JubYodTun3
 +XDEND3ukxLwRfFndXhKbHKj3qU1s8W/jiRXj4OldOfdiz3ppfG2yz7ukWwP+4X9dmrQuRs/xWS
 Mvi3xwDPWQ6KcwdjYQtiL8Ejp2c1jvxrAyHrdzENBzoXDN5fkI4UNRLfVdv12KFTacS4boDCb6+
 XgUMXrB+Jz9Nuc6Kg607gxf9Q+0yCIVDIl/r0IhNzBZCXT9t+6xo4KANCsUD+F82MfGx9HOkdgr
 xe2mNtIYDjNTBUTBEWked1YJI+DKuMwUb35USeRwf+AYX4AqUTUt2LIeLQzNnS+nc5Qxznasikj
 qECyf3jxMB4w5P72oMqPmTXLDnCsccuvKeUM0M4r9oWSEFp8OJIAJgsFW0DTgdB7Q58mFCHUV6L
 litRwpGKXSbSLNub2E1bMZmXISi1M+uHLuzKmGXaRoM1QfVLJ2ohZeKMyUnJAAQhnJz2ToxzlPZ
 G831w==
X-Received: by 2002:a05:600c:8b29:b0:47a:7fd0:9eea with SMTP id
 5b1f17b1804b1-485566e314cmr235062765e9.3.1773679326946; 
 Mon, 16 Mar 2026 09:42:06 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae.
 [86.98.192.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea98070sm3865885e9.6.2026.03.16.09.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:42:06 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 16 Mar 2026 20:41:50 +0400
Subject: [PATCH] scsi: Fix oversized data length in scsi_inquiry()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scsi-inquiry-len-v1-1-a8176ee6620d@flipper.net>
X-B4-Tracking: v=1; b=H4sIAM0yuGkC/x3MSQqAMAxA0atI1gZahzpcRVxIjRqQqg2KUry7x
 eVb/B9AyDMJtEkATxcLby5CpwnYZXAzIY/RkKnMqFwbFCuM7I6T/YMrOWwarWxRlWWtc4jZ7mn
 i+192/ft+XqsOw2IAAAA=
X-Change-ID: 20260316-scsi-inquiry-len-9910c4755813
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=alchark@flipper.net;
 h=from:subject:message-id; bh=3m8tR5aS49zr8BFzadDLOVOQr2CU6D2K3F1zAu6e1Rg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTuMLpTpDntb/G510qiFdGttSFTTh2pWCy0U+PYM5luR
 albdVJXOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZjq4ukM/zO3B3xwMd6rHp05KWGS0B0F1jsMLnOlNv7ROxr9p7V2ej7D/4wH9hW
 fspSE/2Xe3yd0xjxnS0q7Z9fJAHdPz2cawiHvWAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Mon, 16 Mar 2026 19:24:05 +0100
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

scsi_detect_dev() sets the inquiry data length to 512, but
scsi_setup_inquiry() only sets the command up with a 255 byte length.

This causes some SCSI devices such as the Foresee FEUDNN064G-C2G07 UFS
chip to fail to respond to the inquiry command, preventing its detection.

Set the data length to the size of the scsi_inquiry_resp structure, which
is the maximum amount of data that scsi_setup_inquiry() will request.

Fixes: 570712f4bcc4 ("scsi: Extract device detection algorithm")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 8fe6b38a8c74..6a3a91b1d32b 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -513,7 +513,7 @@ static int scsi_detect_dev(struct udevice *dev, int target, int lun,
 	pccb->target = target;
 	pccb->lun = lun;
 	pccb->pdata = tempbuff;
-	pccb->datalen = 512;
+	pccb->datalen = sizeof(struct scsi_inquiry_resp);
 	pccb->dma_dir = DMA_FROM_DEVICE;
 	scsi_setup_inquiry(pccb);
 	if (scsi_exec(dev, pccb)) {

---
base-commit: 841856ed9675b26ec517fdd00b5cc0aef8db508e
change-id: 20260316-scsi-inquiry-len-9910c4755813

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

