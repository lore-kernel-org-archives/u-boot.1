Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47C9C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 11:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F099B849E5;
	Mon, 29 Jun 2026 13:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eezKeskq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmSuwY6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6753849EE; Mon, 29 Jun 2026 13:31:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4927B849A3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 13:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATK6f2656156
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Whxdyy+4iB1xZ+fotMCMad
 69/NA7U24gbt6Qok6QcyQ=; b=eezKeskqJsUm7vPyIlTBGQYDKO6r9bVNnHjTQM
 qSspLs1FB1Z86y+iZp2YPZ3ZaFta0xLqYxQq2+kLhoIgazpgI/wPtUvLkCnDpSmD
 dXY9V8ARrizmGgfUzhowfeBV/rN+h9IeTnmWHmOjYNQTlpizDtdFZAevbtEZYk0n
 azPiJP096Z0uVoUse5+4D9W7npZXgBi9UrBiIF9gE5/mMlB2NOu4snzXJK2vGEBQ
 mpehEO2ILcIsN0bqSG5UnmWglbNnRKoxa+lI0sk/cyPuPy3H4YdEaXo99FhmIgtm
 bDyzau7ODxvhLqUy/AnOoGU18Z3bMZFloOpwhdoDJSsLvdsw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3np7gjag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:31:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ed664e368so292589eec.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 04:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782732684; x=1783337484; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Whxdyy+4iB1xZ+fotMCMad69/NA7U24gbt6Qok6QcyQ=;
 b=dmSuwY6pCG7qNw35isApjkgmbu+xWyJDPakuj7CuIrm6xuGDNVV+OOiH/BMaCfiDb2
 l5I13Hk92ycRF/XhWDTYe3NEW00GpsBTZqAiMCUTYjhhp+Rh6epW/O2BvBYVO/YZBdg6
 X6irsd8dZ0+1QKktgywGJvY+nvmIHwraPOplmHa9ScXiXPZLPsJUcH/+ev1+FR6rm5GL
 HClEfmSTuR1w+65xqaxzTc8XSk++XPUoaBxBuVIyaKJeWh9zVe+xF+nw13Ndt8WTzSkO
 6SIErEueXs8XUn/jlbKz2LjVb5lBFHJrbPp68MTjUd5v3zjGLV+Pb5QxlbxfNIuGq+YC
 FSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782732684; x=1783337484;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Whxdyy+4iB1xZ+fotMCMad69/NA7U24gbt6Qok6QcyQ=;
 b=XCF74ddGoqbL4Rt5sJb4+ETePwAtS1ucCGwyKhjups3GlYpFwqQfWPUcReDcewnwuh
 eSNC1KxWyajCOmeNfL5g0HYTLM08M/rcX+khPFsCr75cl5J4UzMNWoMzdbflrygSH8N1
 lxDn9sEUPO9tI+0lhMHE+Zbh6fxHhHEphJULcQSv7Im/sR2gGSsr0tPXNlm9w8+P7K0b
 nxX50F5b3rTSih9ZMF51VLyhuPvOqnVZth9ni9o8UrsarRFKQxnTF98fCkv5GYyXowK6
 vIxnRXa3NhMlDkZ1WcsmNIq1udQo7CYBgD2oCUJfQDlLXbR4l5Sk8a9qAX9/ioX1V7dY
 3Y8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOTbVM6JEFYrgtsd2OmTZVcXvsm7mQ/quyKNSuIpprPDcwHaUeKgOhX3fpb/k3eS2E7tXqtyw=@lists.denx.de
X-Gm-Message-State: AOJu0YxuX+WTMzPUzeTy0ORkH6FTTBGHVePVn425fCseKdd8PSFAGJh0
 883k2iHLYI0QJSW3YV4e+610iIlRDcogPI2cn8EoWEfJ5VkZFcA4W0IEpVZaih9w0mRMn8BrTCH
 zs7k8S8uB8KBxosv7j8lI5d4lro1clGRgpi07lJOCJbXtHwPo9b/3aVXo
X-Gm-Gg: AfdE7cmy36KPUIBj1/VEvStyS3wRL7gFMd2id7j2DNyV0VtBxRdjdNLSoK1+hnKR0vF
 ySSWhV7AfGg7lorDjmILjJB0XEhwx+Y+q7NoJvFU27ujG3Xxac2WvZG3PdfXyRj7pz/xnvvIrwM
 hXmON6OZvm0j3ENBSXhL6XbWEowBgx5xbk1+bBOLwgxqOjR+SY6FfB1G6151j3LwvodpojZSNBH
 +1TQ9fNVHxyiFStE+4tOOy751Ijdsmlc843H424oU4m7AMOOsLsHrPFpsmkrKriYSxpIv18d4BQ
 u2R3LgXo/9Y/FZNn7mG81Y5Gk7b9ogVZVmEwtpvQRxkM1yFDcVgQjZUCwNKzjeVZv+WPj+yinoc
 OBvb1uKbsm1kuXN1SCObvKaLdhtC4pNlvYi1oanQcYEIm4KlrNrrmJsjEkgGTfkOyTkiUt6jUM/
 3I92mNlv03ZA30tnWeOLPpexPyJjOE9H+l6eyvUw8=
X-Received: by 2002:a05:7300:3b28:b0:30c:ab96:7303 with SMTP id
 5a478bee46e88-30cab967707mr9929554eec.19.1782732683514; 
 Mon, 29 Jun 2026 04:31:23 -0700 (PDT)
X-Received: by 2002:a05:7300:3b28:b0:30c:ab96:7303 with SMTP id
 5a478bee46e88-30cab967707mr9929524eec.19.1782732682967; 
 Mon, 29 Jun 2026 04:31:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ed3af8c35sm6395117eec.29.2026.06.29.04.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 04:31:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 17:01:17 +0530
Subject: [PATCH] serial: msm_geni: validate RX data with IRQ status
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIRXQmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNL3dLEohLdVAPzFAtL41QTUwMLJaDSgqLUtMwKsDHRsbW1AM7k1ZB
 WAAAA
X-Change-ID: 20260629-uart-e07d893e4508
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782732679; l=2107;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=PHcJz/12hF4k2V1JiSE1DNzSiQAPgtEFM+zJ49MD4Ng=;
 b=mq4wszCZGMIPDUnZ4bvGu9IUIh59zWVQ5kTsmeNh8FijzawxNxi9TRs1/nSIBznOMQ/gyrvrN
 dUH7NM+w8vVAnSJM9QAs4mCxZ90uPATV8CZEeSlQ99ycBa4u8OazOk1
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5NCBTYWx0ZWRfXzI9jVsW1p12Y
 izZKd4EgQ2ki9Rs4oWUl6LCh6psqdAWjs4gkyMGAMa8F0/9UvIgyYn8HJlyFyAPKdyxmYx4CreF
 b8E0kT0Q6g2gLLSKgxsBtBWSq+LGTEJ3iSlHQFA9/jMGDBB1dAZzxTJNYMvj+NMQGebA3AVtJOc
 XwI5fTCW/ajUzl86sKbQpVGv/9d0B+5FDhDwnwch0BpikcMdNzW6M10+wrk+KKy2I2UVn54gruO
 6bRmS2CK2bZA6D4OhCtIXanfLLd6DJ6BBCkyvnYN5jDdaFRVI4HsIl5CkC7CdSBmeX9G+LikMWO
 bnYvLVNzEcpbAVhs62+37aT830RCInVXFmJXvfPz5bKfavB4qgba8FvBQr5vZQAfMDvFaNcvXnS
 PFs648Xx4oz90dhBCwlGVX0s3uDQh5xmuzYR+ZvFRb+CPVBRmq1GoGGDIpxQBX393Hj+7Lik6KO
 qusvQ+ZHZrep2gU6bYQ==
X-Proofpoint-GUID: acDljKyLdRKOukqgI5ZPbV-zQARsATXj
X-Proofpoint-ORIG-GUID: acDljKyLdRKOukqgI5ZPbV-zQARsATXj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5NCBTYWx0ZWRfX9H+uYqigkpCU
 UnboMlsCLA1rH28638q2srEEIbUshigXoHKxLOYaiPY+8sqK4nEN4A8VMREJjyt+oA4Jf2qLGkH
 Fkbw3ypiFhqLQlVXY2/jteivvMvN5QE=
X-Authority-Analysis: v=2.4 cv=OcWoyBTY c=1 sm=1 tr=0 ts=6a42578c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=LIuirb-c8Ik9wrAr2uoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290094
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

The GENI UART hardware can retain stale data in the RX FIFO.
The msm_serial_pending() function was reporting this stale data as
pending input, causing U-Boot to incorrectly assume a key press and
stop at the CLI prompt instead of continuing the boot process.

Add IRQ status validation to distinguish between legitimate received
data and stale FIFO contents. Check the Secondary IRQ status register
for RX watermark or last flags before reporting pending data. If the
FIFO contains data but no valid IRQ flags are set, ignore it as stale.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/serial/serial_msm_geni.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..6d30f150966 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -424,13 +424,30 @@ static int msm_serial_getc(struct udevice *dev)
 static int msm_serial_pending(struct udevice *dev, bool input)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
-
-	if (input)
-		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
-			   RX_FIFO_WC_MSK;
-	else
+	u32 rx_fifo_status, s_irq_status;
+	int result;
+
+	if (input) {
+		rx_fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
+		result = rx_fifo_status & RX_FIFO_WC_MSK;
+
+		/*
+		 * Validate RX data with IRQ status
+		 * Only report pending data if valid RX IRQ indicators are set.
+		 */
+		if (result) {
+			s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
+
+			if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN))) {
+				/* No valid RX IRQ, ignore stale data */
+				return 0;
+			}
+		}
+		return result;
+	} else {
 		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
 			   TX_FIFO_WC_MSK;
+	}
 
 	return 0;
 }

---
base-commit: 6902fb4c17faa375003124c451c2550deab5463d
change-id: 20260629-uart-e07d893e4508

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

