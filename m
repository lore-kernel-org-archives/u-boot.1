Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6064EC43602
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 09:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10278849D2;
	Tue,  7 Jul 2026 11:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTEb4Hu0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKZ3p4JD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C30A84997; Tue,  7 Jul 2026 11:53:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4DF8498C
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 11:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678DlMU3138660
 for <u-boot@lists.denx.de>; Tue, 7 Jul 2026 09:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HO8v0Cd1bzdQTvOrm3nD4g5qFLZXKXyzzHfvQPHTLHA=; b=RTEb4Hu0x27MdGWd
 8oOasZspWiRi/joPpH4lAfeDl42/UlnCXUTYeEfIIAL5beWcfFdL+j4lKVEd2IJm
 JNPBO2CY0RFyiVW5v7jK6mioP7We5pFy9o1CjnbC0HNW1Ubd3xPI/RjSA8NTuABK
 7toSDOQMu8S5GhlsaPJ8QcoIyhmZi/VDXo/2+YfX2HdMBvD03suCBKhQjwJ0bGQ9
 NvMI1+ujreNFKlrrCanmzQdHZQm5IFnCf5MTCKl970jg7tr51fYSdZ0bOU42t/v6
 SZ0y6+R4URGHvEGDM46wdlpthsvX9ISTOVo8IRlxC2TK/rdgBRN/icA5x6cJTVKu
 UGNkzg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t159bnb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:52:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cacf17c7e0so49916685ad.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783417974; x=1784022774; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HO8v0Cd1bzdQTvOrm3nD4g5qFLZXKXyzzHfvQPHTLHA=;
 b=LKZ3p4JD/2KT4TvvNRaJ0H8f2I0+7qHPZYUF6B4dS1nDsQXeJpqMxKmYfIuwC5kFrZ
 3oLiQZ6+yPAhvaxxsR7LZK5JGEWy9sOwajs/ZC8rHjzZFXzkTuwQx3QwWSSqFoWQRyrX
 0DL8i+ytXakG1iOl7gJKvr4f70vTF5KJRdFVN+gVKN7CtjL2A7xy5PqScpP7MFWNmUy7
 4lMMankYhdlQw0Sxbl3WsfXmFzUQkdQRvh90xM/Dy/ORHuDu98bENMCkX7aDv5u3GJo+
 ATWMe09wwCce0rYAgsAjz2iOmwksOUTqYMgyHU+4wY8pI9ZTJie1M/MZu4i/ko48IqFa
 sdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417974; x=1784022774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HO8v0Cd1bzdQTvOrm3nD4g5qFLZXKXyzzHfvQPHTLHA=;
 b=pWJ8VBZMrKJXxxgbdvtzBHnsKK7bYkQ6li2wf3ryvJZbrBBa9D1ISHuk3qee3hFDeK
 5Lhyx2qK5WKzEGsSUEZ7Oldn29ITexh/PWFLtBdAqvtjw76UbOBJ8KZQgRruj9FLzD0E
 3C11e8IEFhWVcegD54tSuksycnmHneuNtlJtzXZxVr3XRVTGzwsKjF1BBzhouoKsJQiB
 kljvtSxkk0W9LQlqVKTGCiAPb/ocfE0SuyXbzTSSFPYDmz732uFm6Qu6LSyPQuNrdN6D
 6T/tSMhCAhwLbHditT7r9HIrQsrjHkI7n/33NsP2xEZ4KlJQEkUeH5yn5CWXwzk21PH2
 qQMg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpxrhgjwx4E4H6R0Xs9VFQzz4lC+TXR/3WhbbBSHzulp89aXnaZCc0I1Xx1O3/ELc6GoCGZbuY=@lists.denx.de
X-Gm-Message-State: AOJu0YxASKCYkSGpQ5OY1x2ZtoX6Ad8JeM76tHICjGPioIYnp4Ev8Obj
 gK1JcWVaimo65JzwlzH/XqzQ8LdTVlUmWfQmjMJafH6/Qx4ow+2dzYOOFYem+kP/zu3jQ62c6RO
 sIg9/HuTVh22vQAYrds4XVNJnTmnywfOOGr3jAHV4QUzTSwNSul08ixUE
X-Gm-Gg: AfdE7ckPhUto8IAYb4uJLayOngJOX32NzKBGicv3F/Xt9DDia6mDRGNSvBjzyF+bc8+
 HMBhLDF2A1g8U5D4zmtBqVCrOQSvjYm0zjxiJV1un2xovBL/hDbOIq8Tm5MZSPuk9ENkaw0pXC8
 K1uqltLZllFXSqPG+icalqjUVMbZEhMTPiuvoC7N0SubRumpOnigkvHWctVFzx3S0uc2bcDmxyO
 JvahwcNaZEtA0FmmoYlLE0KdpFRBE93VAMPTMVL3M2L25qbwLXWvGuxlFtJBMgfd7QqZs5sMfsY
 n6J18lKm4FS2lib4BQzJT6CpQjYectwAe6Iyfl16tGSQFE7sXK5emlXleOw59LrJ4muevaRlhSt
 K8sn+NdpOTB1FuKjCvwymxQoyYjQsZAAzjKJu9t4c/x7cKSWdFli6afyK0eiW/q5oRCyNrVPIC2
 XcfKaN8mTTXKkQOFWkKamvak0mPNfob0GFRzpuLqE=
X-Received: by 2002:a05:6a20:d81b:b0:3bf:49c8:f77 with SMTP id
 adf61e73a8af0-3c08ece59c1mr5061320637.9.1783417973956; 
 Tue, 07 Jul 2026 02:52:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:d81b:b0:3bf:49c8:f77 with SMTP id
 adf61e73a8af0-3c08ece59c1mr5061289637.9.1783417973445; 
 Tue, 07 Jul 2026 02:52:53 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm6516300eec.2.2026.07.07.02.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:52:53 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 15:22:42 +0530
Subject: [PATCH v2 1/2] serial: msm_geni: fix RX FIFO init with proper
 cancel sequence
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-uart-v2-1-d38277b6c4ce@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783417965; l=3907;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Y65YiBj21lNkiB+2lC4G+QEkURYudWnnanjydAJRstY=;
 b=ViMBEkGJ4ZEO7iq3jXOnbdKviYGis1vhzoTnOJFPbGkPFaCko1sSUh9y3TZ4/HF5bhwWa/Lce
 eSQzFTeoUq4CAG4xTlJ7Qf9f+D1BqS+CkAm71zQlNO/4N4BAzM79KxR
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: mGEIOQ4eKLPZjnTH1lVLZ8i87XPE2_PK
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4ccc76 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=UGD0GoFJ_WPd41nO-vYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: mGEIOQ4eKLPZjnTH1lVLZ8i87XPE2_PK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfX7EV2baJkAzyD
 IQFfnz1GTmLiS2YQxOYa6jcdUC9g5JC+yVv7h0whufpfiXNahbunG76hzRVMhj/75u6ovvXOS1t
 vNLDv9Hos0EKDADb06UvcKrpPvWb/po=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfX3iSbO4LbZmhh
 3G3PGseAA1bO8SNDsVUb/R7gbfkpyk59q+ZXJRhfxem9B1MJm9cUsnomUJV2Wvn62zuTqwPenoH
 8mWxjH9Tq2izy+IJd88LM0Qn3ytWS81Sfc/BzW2IQXZJ/u8w+OU+dpLYg34uArjYrpBM4tVMGCc
 Yizjv4g21+cB4Xp1RQ9musC3xAc4yqGwSWfqM33k6Nh8WIpgWkox3S7dZJ8pbsCaqAE4mDr8Fh1
 u/bD9r4xG1KBFhSpY97GdumiPfqBAzbBPJ4tH+dYb9ibElJAqOJpoBE6Sm5isEtARKianOQU7Em
 2gQcgKvFRVekaTSn5E11GnQmWKh7gaRSZt7agbhighlwS8yNXT/geYu+aV7YnTBxebXUBWIM8QB
 GeQYifRitNIowdt3KpdtlUsq1rQZAhkcS2M2px4TB2KfWgEUT2dlzPAK+xKoXK9p6h7djLgElPv
 bNgCxYg4Qu4l+BKdnwg==
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

Replace the abort-only RX initialization with a proper stop sequence
that matches the Linux driver approach. The new
qcom_geni_serial_stop_rx_fifo function sends a CANCEL command instead
of immediately aborting, waits for completion, drains any remaining
FIFO data if S_RX_FIFO_LAST_EN is set, and only sends ABORT as a
fallback if the secondary sequencer remains active after cancellation.

Taken from 679aac5ead2f ("tty: serial: qcom_geni_serial: Fix RX cancel command failure")

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Replace the abort-only RX initialization with a proper stop sequence
  that matches the Linux driver approach.
---
 drivers/serial/serial_msm_geni.c | 63 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 3dca581f68f..a580dee8c8a 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -362,11 +362,70 @@ static void qcom_geni_serial_abort_rx(struct udevice *dev)
 	writel(FORCE_DEFAULT, priv->base + GENI_FORCE_DEFAULT_REG);
 }
 
+static void qcom_geni_serial_stop_rx_fifo(struct udevice *dev)
+{
+	struct msm_serial_data *priv = dev_get_priv(dev);
+	u32 irq_en;
+	u32 s_irq_status;
+	u32 status;
+	u32 rx_fifo_status;
+
+	/* Disable RX interrupts */
+	irq_en = readl(priv->base + SE_GENI_S_IRQ_EN);
+	irq_en &= ~(S_RX_FIFO_WATERMARK_EN | S_RX_FIFO_LAST_EN);
+	writel(irq_en, priv->base + SE_GENI_S_IRQ_EN);
+
+	irq_en = readl(priv->base + SE_GENI_M_IRQ_EN);
+	irq_en &= ~(M_RX_FIFO_WATERMARK_EN | M_RX_FIFO_LAST_EN);
+	writel(irq_en, priv->base + SE_GENI_M_IRQ_EN);
+
+	/* Check if secondary sequencer is active */
+	status = readl(priv->base + SE_GENI_STATUS);
+	if (!(status & S_GENI_CMD_ACTIVE))
+		return;
+
+	/* Send CANCEL command */
+	writel(S_GENI_CMD_CANCEL, priv->base + SE_GENI_S_CMD_CTRL_REG);
+
+	/* Poll for CANCEL completion */
+	qcom_geni_serial_poll_bit(dev, SE_GENI_S_CMD_CTRL_REG,
+				  S_GENI_CMD_CANCEL, false);
+
+	/* Read IRQ status and check if S_RX_FIFO_LAST_EN is set */
+	s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
+
+	/* Flush/drain the RX FIFO if needed */
+	if (s_irq_status & S_RX_FIFO_LAST_EN) {
+		while ((rx_fifo_status = readl(priv->base + SE_GENI_RX_FIFO_STATUS)) &
+		       RX_FIFO_WC_MSK) {
+			readl(priv->base + SE_GENI_RX_FIFOn);
+		}
+	}
+
+	/* Clear all pending IRQ status bits */
+	writel(s_irq_status, priv->base + SE_GENI_S_IRQ_CLEAR);
+
+	/* Check if still active after CANCEL */
+	status = readl(priv->base + SE_GENI_STATUS);
+	if (status & S_GENI_CMD_ACTIVE) {
+		/* Send ABORT as fallback */
+		writel(S_GENI_CMD_ABORT, priv->base + SE_GENI_S_CMD_CTRL_REG);
+		qcom_geni_serial_poll_bit(dev, SE_GENI_S_CMD_CTRL_REG,
+					  S_GENI_CMD_ABORT, false);
+
+		/* Clear ABORT IRQ status */
+		s_irq_status = readl(priv->base + SE_GENI_S_IRQ_STATUS);
+		writel(s_irq_status, priv->base + SE_GENI_S_IRQ_CLEAR);
+	}
+
+	writel(FORCE_DEFAULT, priv->base + GENI_FORCE_DEFAULT_REG);
+}
+
 static void msm_geni_serial_setup_rx(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 
-	qcom_geni_serial_abort_rx(dev);
+	qcom_geni_serial_stop_rx_fifo(dev);
 
 	writel(UART_PACKING_CFG0, priv->base + SE_GENI_RX_PACKING_CFG0);
 	writel(UART_PACKING_CFG1, priv->base + SE_GENI_RX_PACKING_CFG1);
@@ -494,7 +553,7 @@ static inline void geni_serial_init(struct udevice *dev)
 	 * it else we could end up in data loss scenarios.
 	 */
 	qcom_geni_serial_poll_tx_done(dev);
-	qcom_geni_serial_abort_rx(dev);
+	qcom_geni_serial_stop_rx_fifo(dev);
 
 	writel(UART_PACKING_CFG0, base_address + SE_GENI_TX_PACKING_CFG0);
 	writel(UART_PACKING_CFG1, base_address + SE_GENI_TX_PACKING_CFG1);

-- 
2.34.1

