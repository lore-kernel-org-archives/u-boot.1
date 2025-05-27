Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C7BC54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736918383E;
	Tue, 27 May 2025 15:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="o/HJWu+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A008388B; Tue, 27 May 2025 15:29:40 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9D38384B
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=724286f330=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54RCungM001150;
 Tue, 27 May 2025 15:29:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 xmfwORAjZqMGe2QqIep4GzCe9bdXMj8pmLCQnYLw8HY=; b=o/HJWu+lAoHlsHhg
 9nmwPIty2ZEJgZSXaxQDYYP3TOGR8aXipKEdU49g2dNfVLw0cTCAz0oDW1IgJeDU
 E/aDDFC+NnjyV6gWpKcH43n7olQZmKE9rGKX+GI1j6aOuNXD7Fi+6XtLcKbjxRPt
 aVrj8zE3PoQ6LM+WKtFYw11rhtJWS/eFLx1yAyMs+X0TX3omD0xfSphWB4jpe2+j
 DFzmGYsninyfKrS7/N2cOJadUR6G1P3Vuqp2p6id/BXDjNya229OnZ51V6O9DELn
 1COK47Yh4rQE1J4TqUBALv45E5ohcqDKgbhxdFeQ/HjQPM5Tj53KolB0v2N3v5NA
 WfDjUQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46u3hk4hx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 May 2025 15:29:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A7E0A4004A;
 Tue, 27 May 2025 15:28:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DEB46AEB165;
 Tue, 27 May 2025 15:27:58 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 May
 2025 15:27:58 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Valentin Caron
 <valentin.caron@foss.st.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 01/13] clk: scmi: add compatibility with clock protocol 2.0
Date: Tue, 27 May 2025 15:27:43 +0200
Message-ID: <20250527132755.2169508-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
References: <20250527132755.2169508-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

From: Valentin Caron <valentin.caron@foss.st.com>

Since clock protocol 2.0, SCMI specification add an option field
"clock_enable_delay" to CLOCK_ATTRIBUTES command.

scmi_read_resp_from_smt() will return an error ("Buffer too small") as
the message length coming from the SCMI server is not the same as expected.

So implement a condition to SCMI clock protocol version to change the
length of the expected message.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
---

(no changes since v1)

 drivers/clk/clk_scmi.c   | 54 +++++++++++++++++++++++++++++-----------
 include/scmi_protocols.h | 15 +++++++++++
 2 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index af69850cdd8..e323a948780 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -84,26 +84,47 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 				 u32 *attr)
 {
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
 	};
-	struct scmi_clk_attribute_out out;
-	struct scmi_msg msg = {
-		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
-		.message_id = SCMI_CLOCK_ATTRIBUTES,
-		.in_msg = (u8 *)&in,
-		.in_msg_sz = sizeof(in),
-		.out_msg = (u8 *)&out,
-		.out_msg_sz = sizeof(out),
-	};
 	int ret;
 
-	ret = devm_scmi_process_msg(dev, &msg);
-	if (ret)
-		return ret;
-
-	*name = strdup(out.clock_name);
-	*attr = out.attributes;
+	if (priv->version >= 0x20000) {
+		struct scmi_clk_attribute_out_v2 out;
+		struct scmi_msg msg = {
+			.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+			.message_id = SCMI_CLOCK_ATTRIBUTES,
+			.in_msg = (u8 *)&in,
+			.in_msg_sz = sizeof(in),
+			.out_msg = (u8 *)&out,
+			.out_msg_sz = sizeof(out),
+		};
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			return ret;
+
+		*name = strdup(out.clock_name);
+		*attr = out.attributes;
+	} else {
+		struct scmi_clk_attribute_out out;
+		struct scmi_msg msg = {
+			.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+			.message_id = SCMI_CLOCK_ATTRIBUTES,
+			.in_msg = (u8 *)&in,
+			.in_msg_sz = sizeof(in),
+			.out_msg = (u8 *)&out,
+			.out_msg_sz = sizeof(out),
+		};
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret)
+			return ret;
+
+		*name = strdup(out.clock_name);
+		*attr = out.attributes;
+	}
 
 	return 0;
 }
@@ -257,6 +278,9 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return 0;
 
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK,
+					    &priv->version);
+
 	/* register CCF children: CLK UCLASS, no probed again */
 	if (device_get_uclass_id(dev->parent) == UCLASS_CLK)
 		return 0;
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 9046de7e3e7..762a1032c37 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -782,6 +782,21 @@ struct scmi_clk_attribute_out {
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
+/**
+ * struct scmi_clk_get_nb_out_v2 - Response payload for SCMI_CLOCK_ATTRIBUTES command
+ * Clock management Protocol 2.0
+ * @status:	SCMI command status
+ * @attributes:	clock attributes
+ * @clock_name:	name of the clock
+ * @clock_enable_delay: delay incurred by the platform to enable the clock
+ */
+struct scmi_clk_attribute_out_v2 {
+	s32 status;
+	u32 attributes;
+	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
+	u32 clock_enable_delay;
+};
+
 /**
  * struct scmi_clk_state_in - Message payload for CLOCK_CONFIG_SET command
  * @clock_id:	SCMI clock ID
-- 
2.25.1

