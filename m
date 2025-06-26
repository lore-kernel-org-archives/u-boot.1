Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26634C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627D780E9A;
	Thu, 26 Jun 2025 13:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aRkUyery";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C93182D83; Thu, 26 Jun 2025 13:25:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D807582977
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9jkb1002570
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=l1JVvWAbCvv
 Re97vVur6V0N85gPror/RpYXtcsqWnTk=; b=aRkUyeryCKtqJqxuV2EEfsHSHcc
 p8Dh96dBVaADVfOrQ/quZvJC3oQWl5U9Y5P0BQKlwXnq8gOPTwPfp7EXxsZdeEIN
 4evRCHenjnE2BKMikSm3MS4X+DsofZIabWAydCjpbLWD9VFD6G7ZGTlH9rpZkf9r
 0VbwEhuX0O0FTgZ6cQYNXhjUBBDyNU70nqsyLe2hiLLUkgjrVFv0t1Y8+MEWlJqT
 w5aUQKGa5lkxG3jfxQNlLYaXawfEz9xgr7x8DmSlOYakOZ+U8ZBbaRXNs2izYE4+
 ZYwvhDqMe4BV7xjD0XliUfFTCrB9BcHU6HnrpsTw5z81J8V/rrAITCVEwTA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47emcmvtvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 11:25:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2358de17665so9529275ad.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750937109; x=1751541909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1JVvWAbCvvRe97vVur6V0N85gPror/RpYXtcsqWnTk=;
 b=snNQpS6frKqZ9fQtDBK39Aznsn5IkWWKjIbY0AYPeLorkKdNGn+5SyuD0WUfnsnMWC
 Kqzsfi/nN7E14WGJm5pcn1D3t5y9ufY+KbCExfcFijWFTcIe3QA9qnY8hh/TtOqrvXyb
 dtPVbFXSioNoM9p9nnip4QAB21lLqmzuL2pt/VooXEmFlq9coJQdSqUhL/m5e+Ldhsou
 ZIUWmOicRVNMeEvyNPkUycSDkG9x9/hotbF9d76ls5VDxv63uRFb9o/Eva0OPb9td1nf
 wdx2LCD3HA0fHR3oGUWctQ2GZkr72q4oFZKEJCzeDst1tfdc+TVmzksTC0vmtwV8sSe2
 9USA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH7EQLQejRajwBFMz+zCtxjjVdPWSluSq4YRvyqB5TDJ3yYprbz52wgvZNjja1I2HuId9K85M=@lists.denx.de
X-Gm-Message-State: AOJu0YyojBdEq3HaYtXJucTrG3GJ8RhoaNhI3qwGNX1ZUhoKJYoXOzTx
 QP+1G4UyCjuvj8GukpVlbxBEn8wmRVmogdcLRYu2poOC2sec22czCu3WDikNhGnMxaWNY9R0tYC
 LYLlitBmiaq+PXFXaymwQBcslVZ/qdHpGbFOjx+a0fYmHRkSwVIU55Y9e
X-Gm-Gg: ASbGncvJTSrlnZ+0EDST/wjido23AkV+5DVvg90EZBkuU/oHepEtdL56cgZgoUfDVf2
 NSpPxVQN6L+vv5jmD+1k8l9ogI38s5EHF9TmgJFXdCsIPilv5XeepPbULeuP9qUxNiIFE/sENgd
 ChfyGDGFjXdUZzchpgoEvLv1gwI8pqaiWIAexx2XD48STIDI/wd8NqWeG6fH6vJySEie2wQ84bR
 FaYG/KWwL7OL9yLDCDnMQGE6t4SSzBLU+EOZfnIzXxgI0hsM2eMPHkRGD2it+47EOM27UYWSBYU
 uXyk3+gf1C+LeRR44D2Y0zXs7/EaApqf7C8NY1zvYu5gugZeWUTQi/fC8FspKmKLWmCymS164IC
 N+Vhlv9PHMNbF3mlgoy4sgdvMxmu0DsLsgRbpln2p7g==
X-Received: by 2002:a17:902:cec2:b0:235:779:edfa with SMTP id
 d9443c01a7336-23824044853mr103191175ad.32.1750937108676; 
 Thu, 26 Jun 2025 04:25:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGpPrR+GGHmoIB6sIT9RM5jSpl6k2bIfSSpHT7LKaVWoSxEOI55MSkF2Fso5gfuuxKxKxTZA==
X-Received: by 2002:a17:902:cec2:b0:235:779:edfa with SMTP id
 d9443c01a7336-23824044853mr103190905ad.32.1750937108306; 
 Thu, 26 Jun 2025 04:25:08 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d867b438sm154528185ad.176.2025.06.26.04.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 04:25:07 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Date: Thu, 26 Jun 2025 16:54:39 +0530
Message-Id: <20250626112441.143064-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
References: <20250626112441.143064-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GlHVzewiLL1ottJ8vUEZa8NL2YUAhXwD
X-Proofpoint-ORIG-GUID: GlHVzewiLL1ottJ8vUEZa8NL2YUAhXwD
X-Authority-Analysis: v=2.4 cv=J+eq7BnS c=1 sm=1 tr=0 ts=685d2e1a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=BD0JAyWONCbPKr0S2ysA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA5NiBTYWx0ZWRfXwF648x9LCo2A
 AomvcAhVjsmzqHnaya+bjNZNuiQOOLWZZjq+5deqqfYQv3CehdwQVPhVXAZNf7uPPOLj0FySH0L
 xFBUwzZ9Tkr30sZJNr8IHrDIx2nl+QAq+hutomC4/6j+afnlX/xzY1HE1acfFEcTEKna5PS/74W
 ojWGxibu9vE6TighHjamPSm7sTO92beOgY4lHB6X7QxWelkM59eUw9JpaToUaQtVcSZ2FmVLjWr
 TXeDhr1M9h+BCDEE6GOGIUq4NMz9lav7Ub6VCRS/AsvnXVudAEmjKN1d8/sAQn7ibtQnqbDgKj5
 H2hUDmx6/MBlI7vyXjgg49pjjJo0i6unIT3rQ8UvV+UWnfuJNqjJB/ZvM3pY+XtYFq/dZWGEe1t
 FQmyxK8KN7QWPRy75K5JqLpWTQ7gBf8Y1VRPcjxfAgEWj9Gff5zwbD1lhLL1t7yTOw5O3fPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260096
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

Partially reverted commit bb991ab7a9bb ("soc: qcom: cmd-db: drop
unused functions") by restoring only the cmd_db_read_slave_id()
and cmd_db_read_aux_data() functions, which were removed in that
commit. These functions are required for the RPMH Power Domain
Driver.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/soc/qcom/cmd-db.c | 45 +++++++++++++++++++++++++++++++++++++++
 include/soc/qcom/cmd-db.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 67be18e89f4..d0a6047b8a6 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -183,6 +183,51 @@ u32 cmd_db_read_addr(const char *id)
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_addr);
 
+/**
+ * cmd_db_read_slave_id - Get the slave ID for a given resource address
+ *
+ * @id: Resource id to query the DB for version
+ *
+ * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
+ */
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
+{
+	int ret;
+	const struct entry_header *ent;
+	u32 addr;
+
+	ret = cmd_db_get_header(id, &ent, NULL);
+	if (ret < 0)
+		return CMD_DB_HW_INVALID;
+
+	addr = le32_to_cpu(ent->addr);
+	return (addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
+}
+
+/**
+ * cmd_db_read_aux_data() - Query command db for aux data.
+ *
+ *  @id: Resource to retrieve AUX Data on
+ *  @len: size of data buffer returned
+ *
+ *  Return: pointer to data on success, error pointer otherwise
+ */
+const void *cmd_db_read_aux_data(const char *id, size_t *len)
+{
+	int ret;
+	const struct entry_header *ent;
+	const struct rsc_hdr *rsc_hdr;
+
+	ret = cmd_db_get_header(id, &ent, &rsc_hdr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (len)
+		*len = le16_to_cpu(ent->len);
+
+	return rsc_offset(rsc_hdr, ent);
+}
+
 static int cmd_db_bind(struct udevice *dev)
 {
 	void __iomem *base;
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 1190f2c22ca..16609ac9d78 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -21,6 +21,8 @@ enum cmd_db_hw_type {
 
 #if IS_ENABLED(CONFIG_QCOM_COMMAND_DB)
 u32 cmd_db_read_addr(const char *resource_id);
+enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
+const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 
 #else
 static inline u32 cmd_db_read_addr(const char *resource_id)
-- 
2.34.1

