Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8D8C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 09:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F5E84994;
	Tue,  7 Jul 2026 11:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cIBP1gt7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HR35vCFZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D335846B4; Tue,  7 Jul 2026 11:53:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25E4846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 11:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Dlea3138657
 for <u-boot@lists.denx.de>; Tue, 7 Jul 2026 09:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BbEOT6btFeztqVmko/pkV5GgFYClq5gA5zzo3nkgITQ=; b=cIBP1gt77csl9FOB
 QjOPl5xED4VDBl0pYP6FY2fwm15oBY/zXF+Py+oLQHKr91dH50kHLW+btMk0taGP
 85xmWL4it1zYuUl7o5knzXNxpCu7bax/0AtTll5m8ComgF/8UPzF/sQmDLqVZPG4
 NSDfyb85rxK86HXipp0ZPYyTNXtk7kD4KYh0ppajSWdhw8Yjv/XGr8BHKFQI+bSl
 Iyosm/1atJE9AvDvvC7HQkYsWDpL1Y3ruLQj+3Z+T+ZZI4iRfjCOtk6P7G+qpcAC
 94I48U5pedZuT0xhi1JxPvqj7BObjFxSYFmvGJAdYNixnZPHAPZpMvPHX72Hnrv7
 jrV9LA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t159bnk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:52:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3881937456bso573779a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783417977; x=1784022777; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BbEOT6btFeztqVmko/pkV5GgFYClq5gA5zzo3nkgITQ=;
 b=HR35vCFZnImYrq54fMKJez+OIXpxiYIAIM0ejDYZUDHnDil8BsaMQDSn/BFXnNYV4o
 dHMhsepR9tKOjbevpGvbcm8Z3q4WhftEhF/e3J9Sz031D7/WUEmtviQ6rmDECOfnVyue
 oQ0/jLG8qO6MTw15iwjDVA5zIT/sCj78lj/+mAYikMjDcZWMFaMrXqEhusvtWENKkITR
 TUeAB1X6fLXybjo+YIfxN2fzM+6t6YlQwSlly5n8tYTbEDwqJh6RPPpXkut/fgCF9NbV
 dUdx4VGDS7aoWZYpI/djBxUqE4seNsn30ZfvGGgkNd/GDlWseeHMDbNHr6c174r28TbM
 5+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417977; x=1784022777;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BbEOT6btFeztqVmko/pkV5GgFYClq5gA5zzo3nkgITQ=;
 b=P058TC+FgCOMzT8PB2WBAIFjO0OzE2iNQ/LRREnsv//gNX8RNnG9htuaYM/BqiIFPm
 hMuGyorkJFGvWXM3TPMIWO0jba2BHLORrjm/JD6yVq/CG5VXDHs8uKY2MH42yhOv/6xd
 WR92GxxzAoPeMoTnD1qRf6Le7BhBdS+KF+0UIotlYD1DVL+NHt6VSp9LXqA2rQQ+mghO
 KtAETB8hsnPEpZV+/W+PWTZNeIIHdRnMvWYtErWgQpVEniQfEmeWJtoUYwGSVToWdJDj
 WMlcCIXl9bFA90WVIdTrwtJpArznKUpkoxgsDd3lP0W61Q11h7bIVqUxENeaimq1Z7hF
 sIAg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpx+dVcbVGz2PAi0iHFRFir3iacyeE1c5fVge5zAqBdSJPPDPaoWRcRV6LPLDKlE2GhGP8fjUo=@lists.denx.de
X-Gm-Message-State: AOJu0YwPUrH0KMHvD0EvKjt06/b8spqPPDg5lsOmuWkC7WPO/rOLS8/5
 GGF9oGmcBxUitWo/S8L2VlN4Lt+efnUPAKBd7THI2fNjJPCcu+lV3u9aaO03aO9kzwYwNQIu5UJ
 siRspc9NrVShStWpbMqA5v4Z6q2k3ZeukSoSFoVuPz4t2tdoGqa9aJuj9
X-Gm-Gg: AfdE7cn4vvrnHbRWkBx5hk+tAyA68GMJh4zSxG3pww7Y36pvyRMahtQB/VIY+tMAGyA
 RkmCKg8yc/5rhnX9Fh2rx1Wi8Cj25P2pQp7Q2KUW1Lm9Jr/CkOw8Wn4FDQY5OoUACitaJgFM2Wp
 P8UztIjo0+Nbp3Rl2Zru0F3LdWUXzAohGKo4lzbY7o/jkWmMwsBvLw9S1chw+IMivaVst5xcTKW
 /liSCPfwGh8mhSGqt4HKwKMtLo4yZUbIyc6VSbJRuUEm54OMRg6cepp3Y06ukLNBlm/Xmuyu4bM
 rkuPmXBGSOKgPJKKTEa+61aowiDH1nY5SvghNtrczQqW5/nUw+RnVWMYvBNDkfAXkm1hCLA6kvL
 pWf1aJW4t1TVGeWcJ5So41kO0EOf5vZI6SYz9TQhiyDRHU7BnJWKdLsTjvKt+QJdXe+8801VNNc
 yYo2ZuZ3rOOeVFaL8COBDAun0Ptj/jHWSRkQj/Emo=
X-Received: by 2002:a17:90b:2683:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-387d6b973a3mr2480988a91.1.1783417977504; 
 Tue, 07 Jul 2026 02:52:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2683:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-387d6b973a3mr2480964a91.1.1783417977071; 
 Tue, 07 Jul 2026 02:52:57 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm6516300eec.2.2026.07.07.02.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:52:56 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 15:22:43 +0530
Subject: [PATCH v2 2/2] serial: msm_geni: validate RX FIFO data with IRQ
 status flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-uart-v2-2-d38277b6c4ce@oss.qualcomm.com>
References: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
In-Reply-To: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783417966; l=1862;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=WgJ97MQieMuwQrWkP5Z9Z2Xw5qlC9l9N/YhHg0+TxLs=;
 b=3EDqxBZCBc1nCcntbYbhRP2KesUHhcunCR0OLjr5rSXzBfEEckG0vAqJbfAbrv0ii8Wrrelxx
 SX9LHseiknMCUuMey4i1nr/Olqa/DcBU7eOnH5YNKVLqd7P5/imE740
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: OdkHeWxDBfHHTf5jgLkjBFlP-bJsTpOP
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4ccc7a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Mah8TU3vj13mPlbAr3AA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: OdkHeWxDBfHHTf5jgLkjBFlP-bJsTpOP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfX5sGC0sDaU7+l
 0rm8N9YPGCG1WqmIVMliLrwyf+ayGELRn+nXoqib0nqwc+MHU5Zdtxaw5vni06CupRiHQNGNyx1
 vvelPgF9x2np2TyjdhN1Uu+/71pSTPY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfX+qJLWbtwabh3
 QspgckmyWBjQqzxUgVbc4KfSOUN2Jbty7viCbj49hF9+7AwnEcZEvWXgehyni2K8JS6incuS+VH
 AVwkn0UErD+1xQfXzD6D0wmfJkV6DzmsjcR7CFMRi3OsER1F/LPYYI/ylKwF84IenY6cARdQAoD
 RkII+bpb+O3qLqedGgSjWwLkqB8ZyEKG3YPyYL31CVBri2AtiSD58YCHA3tG1JalkeRZMwHoo93
 xH7g2pID3PyU3/8qgstKTSn3a81CUkpvbgYrBilcBLZELiDaQau7T+PzovwA/wjuoN3BFhTrjfu
 qGRwm+q0q6GBRhFCDrAOcuvf0Vsr8XFpu3v1DIaOGevVZGP6954zfz8HVTc01Xh3AhRq2gX7qbG
 sQ5M3J5xSdX1JRFU83EX1CMor83tlr/jHyhNIa7cDTMhLAKEote1bN4b/9Z2ry4N1CJlE5pkbbq
 kq0+KhSo8sKG/B1P4PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070094
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

Add IRQ status validation to distinguish legitimate UART data from
electrical noise in the RX FIFO.

When the UART cable is disconnected, the floating RX line can pick up
noise that the GENI hardware interprets as valid data and places in
the FIFO. So, check the RX IRQ status register for RX watermark or last
flags before reporting pending data.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 drivers/serial/serial_msm_geni.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index a580dee8c8a..07d38178759 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -483,15 +483,29 @@ static int msm_serial_getc(struct udevice *dev)
 static int msm_serial_pending(struct udevice *dev, bool input)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
+	u32 fifo_status;
+	u32 s_irq_status;
+	int word_count;
 
-	if (input)
-		return readl(priv->base + SE_GENI_RX_FIFO_STATUS) &
-			   RX_FIFO_WC_MSK;
-	else
-		return readl(priv->base + SE_GENI_TX_FIFO_STATUS) &
-			   TX_FIFO_WC_MSK;
+	if (input) {
+		fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS);
+		word_count = fifo_status & RX_FIFO_WC_MSK;
 
-	return 0;
+		if (word_count > 0) {
+			/* Validate RX FIFO data with IRQ status */
+			s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
+
+			if (!(s_irq_status & (S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN)))
+				return 0;
+		}
+
+		return word_count;
+	} else {
+		fifo_status = readl(priv->base + SE_GENI_TX_FIFO_STATUS);
+		word_count = fifo_status & TX_FIFO_WC_MSK;
+
+		return word_count;
+	}
 }
 
 static const struct dm_serial_ops msm_serial_ops = {

-- 
2.34.1

