Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18524C02182
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 02:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F828076E;
	Fri, 24 Jan 2025 03:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fR4ZNEl3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3729C80780; Fri, 24 Jan 2025 03:01:58 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD228806DC
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 03:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso17634465e9.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 18:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737684115; x=1738288915; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oBU45mVDMTtceEBhwW/R17cdbuw+nSQxrKpIINd8M+U=;
 b=fR4ZNEl3wqiRtW3VacVsg9JaP74ZqWMJSSdlnPVfjmwp4g64CsbfMFlEOk2kbXS/D7
 xUEpbO18Ei65De+OoAoijfFB3dcClCw/Rs2ZNrD9qrb0rzZE9BcIxBBVOPAb15WwmUS7
 OJAHeR6coBOvvxOC+OorDzVnKD+OZjMpxmKYEzEOL9NBeBC+gsbCD3pic2/MeKkDS3Sb
 cZhMVS2WSHfLOru+EDfWynlGBheCny/kmqTUNSdozWDx4zwfLWi1MQIcIWtOLPREAqIM
 qJPmLMeeloQG3lJTdz4payVOnnLu9KiJJackZnoaYsbMAEAdqvhkCEt4pd/Qy2bxjyan
 575A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737684115; x=1738288915;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oBU45mVDMTtceEBhwW/R17cdbuw+nSQxrKpIINd8M+U=;
 b=vSITt1SYv9ZY7AmW/BYxjmEQqPD0MC5LmSXf56NeugZAokXZy21Moxjxv2CHDy9mGP
 5oRfFA03q/ABbNPTApqIM0BDjQVdLBIO2UsH/Ll8rFRYZ6Z32+UMwigZiWjgQmU5xMrN
 wfNMQnzuOB7BjaIsD09xCKOfQmEkQZNxMmHvWzM/9MW5u9Df6dclQXn65H6KXERmgn9h
 52GIc2oYtfGFCk3s3ZqQWYPDVSVapJJPpbBfbgZYY4xwIG9wuXp1wK9/5YUh7JkRwlKL
 l0h/ZPF2EToH4P6oGwpqvII8fhjYxtgt4wGFxT9TBzsRNT3wRzN/eJlZhPazSi2CbSLf
 jDHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPzCHy/rFFqOeKr8zSxH5/wIzocipuJjUGJ+xizYX7stciNz5g6qfjRJQZybmmGImcgcVxlL8=@lists.denx.de
X-Gm-Message-State: AOJu0YxHUf0w9jARJy4Jz//XZeS/a12V2Zf25iJSuEhoumHx26Xcid4L
 N0uamt/UHF2jljYhOF/mxgMByC+xSyJwmFo2pwQ6qvCi/JoLkQ/ls4c00cKMaAA=
X-Gm-Gg: ASbGnctuTdTa6A8FlIMSgD5aa1EGYTQ5ea5w2xxZvl+Bq+baKx0fH5g6j6LX8gIJRn5
 uk0peazH3OoqAv23QbmxVu+vQcI57ZXbme96maA20I3MbgB7RyRegWmcQc/60OJhZjQ5yPRzPcW
 k4R0QUOboGw5FF0u5QA5V9eElglCZTzV6pFhu6IPt1f07tW7mBMKc49djAKg3yf93xLooJ4PwAC
 yPwDzCJKfAwyftOzTd4Fjzc8OzivXARMwNWX1eK22DOJDzgO6aPIH9jBoSWgBntr9fauNW1fgb3
 n0l9OdnSRGsPSzfkIvnuJa4H9g==
X-Google-Smtp-Source: AGHT+IHqLvzFgH7WiI8gpZ/U/n99BJDL4zMQjVsNmum6bkZLFSZsZIMEkv4aLqZ35r3gYu4nyYCZvQ==
X-Received: by 2002:a05:6000:4024:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38c2b783fdbmr1159020f8f.15.1737684115176; 
 Thu, 23 Jan 2025 18:01:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d79csm1253624f8f.39.2025.01.23.18.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 18:01:54 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 24 Jan 2025 03:01:48 +0100
Subject: [PATCH] scsi: do not fill the LUN in the second CDB byte
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-topic-sm8x50-ufs-fix-v1-1-18b7c220cc34@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIv0kmcC/x2Myw5AMBAAf0X2bJNVivgVcaAWe/BIF2ki/l3jO
 JPMPKDshRWa5AHPt6jsW4QsTcAt/TYzyhgZDBlLmSnw3A9xqGsdLOE1KU4SMDc1DWRdyVUJMT0
 8R/1v2+59Pw+e1c9mAAAA
X-Change-ID: 20250124-topic-sm8x50-ufs-fix-3280b05c6e76
To: Tom Rini <trini@konsulko.com>
Cc: n-francis@ti.com, bhupesh.linux@gmail.com, u-boot@lists.denx.de, 
 Love Kumar <love.kumar@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OBs6RZhTnRcfpDC6ENyWH7IaOXOosniknMR0DU9zFBY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnkvSR1NlJJRoUkdv/6IEMdw3gZqu2BnJiMKJFy4Si
 tpz3O8OJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ5L0kQAKCRB33NvayMhJ0Q26D/
 44DrTjq6eOj2g9N2pu/vgGiSnfqrfVtYHNsXESbxIPBN2oxfeNWSIdMl6UMPudJyAlg3sLrb7sp/zd
 TMW7/SVZm6SovWZJTO2qwQ85T1M8nhd0Zp+Yo6yjxTQ6pYUOrNtxK/xEfWEdp8Gl490CrrhU3NLKNM
 nZnLFK066lVrYzxRquXCHvPxlPh7a02p/JLnbObfjaeAkWfyS11t7IPqCdt/ue7Xb01HIr2uzxqKJH
 zop65zpsmuSJvI5rCxekKY4xMfuDTAeo1+cxv+8wN9HJy66qQ3W0AIE440qFKNdaVeuM0XgkhKZmVH
 sEv5cXidLYG+aA4viJpOZYLonTswnQEWwpxbgiklAEonFFNV1Tf+YhE7zGEhtpLcbLrKKOyQ7wLL25
 7/EDTN2DOTRjdC7MSk8YqydSDDGxdlXMr8PeD5NUmc6lt7bCQWFoVrkSkO8UCu0TvOP8OWqEVcMBa5
 V38ij3wYzbLmgvPT1fapaFbWhesTNEvPviNnIx2Gp/w0AAy4CMksTqKnU3tmNx6FH25F3S7EGscevI
 W+cgNThfh8oNSslWQ0i/cqaR80S/cRKN5LfJIJuKPVj/ot5ErVmZztXraO9Y75YFHcoXBGDuotVOHD
 18aeqDkLrvkntBXeqK/AIM5wAPG0kQl1E8yZwShGIPeBc1E/man1IhVA0y9w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The SCSI specification originally required that the second
Command Data Byte contain the LUN value in its high-order bits,
but this field has been marked as reserved since the SCSI-3 spec
from 1996.

Some vendors uses this byte to pass vendor specific data,
and specifying the LUN can trigger strange behaviors.
For the record, this happened on an UFS device where LUN0 was
working perfectly and reading the other LUNs would get the last
buffer data that was read for LUN0, making this issue very very
hard to debug.

It's sane to assume U-Boot will probably never encounter
an SCSI-2 multi-LUN device, if somehow it happens the enquiry
command would need to get the SCSI level to handle this case.

The Linux fix was added in [1] to fix the exact same issue.

[1] https://lore.kernel.org/all/Pine.LNX.4.44L0.1409021108380.2308-100000@iolanthe.rowland.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/scsi/scsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index bcdeda95ed1514119057cc67974fec465cf5672c..cd0b84c062252118d250b9305728e03f61736600 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -38,7 +38,7 @@ void scsi_setup_read16(struct scsi_cmd *pccb, lbaint_t start,
 		       unsigned long blocks)
 {
 	pccb->cmd[0] = SCSI_READ16;
-	pccb->cmd[1] = pccb->lun << 5;
+	pccb->cmd[1] = 0;
 	pccb->cmd[2] = (unsigned char)(start >> 56) & 0xff;
 	pccb->cmd[3] = (unsigned char)(start >> 48) & 0xff;
 	pccb->cmd[4] = (unsigned char)(start >> 40) & 0xff;
@@ -66,7 +66,7 @@ void scsi_setup_read16(struct scsi_cmd *pccb, lbaint_t start,
 static void scsi_setup_inquiry(struct scsi_cmd *pccb)
 {
 	pccb->cmd[0] = SCSI_INQUIRY;
-	pccb->cmd[1] = pccb->lun << 5;
+	pccb->cmd[1] = 0;
 	pccb->cmd[2] = 0;
 	pccb->cmd[3] = 0;
 	if (pccb->datalen > 255)
@@ -82,7 +82,7 @@ static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 				unsigned short blocks)
 {
 	pccb->cmd[0] = SCSI_READ10;
-	pccb->cmd[1] = pccb->lun << 5;
+	pccb->cmd[1] = 0;
 	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
 	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
 	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
@@ -103,7 +103,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
 				 unsigned short blocks)
 {
 	pccb->cmd[0] = SCSI_WRITE10;
-	pccb->cmd[1] = pccb->lun << 5;
+	pccb->cmd[1] = 0;
 	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
 	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
 	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
@@ -289,7 +289,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 
 	memset(pccb->cmd, '\0', sizeof(pccb->cmd));
 	pccb->cmd[0] = SCSI_RD_CAPAC10;
-	pccb->cmd[1] = pccb->lun << 5;
+	pccb->cmd[1] = 0;
 	pccb->cmdlen = 10;
 	pccb->dma_dir = DMA_FROM_DEVICE;
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
@@ -353,7 +353,7 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 static void scsi_setup_test_unit_ready(struct scsi_cmd *pccb)
 {
 	pccb->cmd[0] = SCSI_TST_U_RDY;
-	pccb->cmd[1] = pccb->lun << 5;
+	pccb->cmd[1] = 0;
 	pccb->cmd[2] = 0;
 	pccb->cmd[3] = 0;
 	pccb->cmd[4] = 0;

---
base-commit: a416d9e680718de1c76c4196e1db77e3ca07662f
change-id: 20250124-topic-sm8x50-ufs-fix-3280b05c6e76

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

