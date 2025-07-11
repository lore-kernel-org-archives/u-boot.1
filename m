Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E041C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E17805D7;
	Fri, 11 Jul 2025 16:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MxFsEAyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D452800D7; Fri, 11 Jul 2025 16:39:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B8A826AA
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAkHhf031114
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RrAmVw3yRVr
 XJy8riaedoRi2gSPo99nCEf2LE3VxmFc=; b=MxFsEAyB5LNrAWg8CMKYuB4BU9i
 NqTq8zs0FZ1aasmirDdn8IFWWUDl/rxMMEeRv4kN0KRept59WeZ2E6POlp+2To/q
 brGlZvETwMr2+PxAfSDP1q+ZN+f0yDOHkGSPkOXDMOp8NL+/SBbTDuDiYXpC4H6S
 8x56OGZ9EkH8tX2Iw23w0HvnpxYGVSyA0ftzjCZTo08cvPITX6/HwlDD7c/3V5m/
 JGze38uJ+tYeU6hixBFDIejmIX6QADtCHoHq/X/PtWXfO2zGVJR3eWFboI7rG63e
 27lt0GkrNl9LDZdiEr2CK+njTsOhl6vaHQhf2w8PQ9ORNAQxBnbhiLdW2qw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u15armc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2369261224bso23479495ad.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244745; x=1752849545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrAmVw3yRVrXJy8riaedoRi2gSPo99nCEf2LE3VxmFc=;
 b=mXn4uJNppMCelfrTuoGJl9gogsnG3BIZdPggjRijMkeHLl+NxsEoPFzUnHMyfpf1HB
 wU4eP0O+iUPdKyKWVvD2rZRs4jsDfEGE0nMuAYnBTalydEIHyMzHk/Foo7qLCcgm6iHI
 IMHdJCQzQCbtNh5GAYWk9RvrEx+N0oj20IfXcjS2KVzOiq6KuU7B9gy4BlX/jUrsInDI
 Wr6WTdTKSTQQuFL9+fjqMVCNxjR04kq+KOasvqIcsya+fBSFi5bF34itEz/MEvl082oX
 hf5BrOQ/LGLnI4DbNdU5EU2OA2gjklS5BEE7Iye0HMQSZgNCTLU3zB1pOkWdaktCU5N/
 aqaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFmJnnumbmhiAgFlT9Sszuom/FLhjUuH+VpB5V3RxB6byabAIT++cJS2oC4OntiPms+7bO5HE=@lists.denx.de
X-Gm-Message-State: AOJu0YyIojPTSr4V+j/neBuoscg4Po99NoaI3ld9Px7hgTaxsz+OTQM3
 W6l78kFfHLbqSVJjs5ocaT3rAWIopgBzwz0ROs2iYjBReH5ST2pDl+jInwIzbWbtYJ0XTqfm+tu
 6aNxWzH7c3+XDB8nfe0Ud2fCNqylcmfhY1en4CB5W6cMSU7rS+JruYplI
X-Gm-Gg: ASbGnct4fBmDkmaty9MQ1Ax0y+wbP1mfWKtjXT+3UAeRZn3Qfz6F28ir6nU4sem4htR
 UHGfS2axsGwty4YtnR/3TJYkyxUVsjKciqJaEbIrMAbKKZNn/cE/Bv5Jx01Xod6FDdmdkeM9g8B
 ofZvVwzd3W+fmzSZvPHPEETkROHQz4DZRfIuy6hQdlAI2Lfaz2yjkdgshRmILWDuv5yoJ/hqD/4
 Zj1a60evBmE0Xstq+9LxloKRWMFmAordwef68xfdzR9W2JYn8Q2SuvkvdcyCak2WzgIVqlpcwdc
 qi7LvEd7pAZbSCrB0W2GSTmGbxsBppm3by4dsfomzmA7WAQ54vmSOKE/b3A80sOWUOlM+n4TPpx
 7iyi2V66J2cCfa/NF6eW6NSHdxUUNdU+PvUPnLYzuwa/ko35SJA1QY/7nPj8=
X-Received: by 2002:a17:903:3b8c:b0:234:c7e6:8459 with SMTP id
 d9443c01a7336-23dee18b35bmr43875365ad.20.1752244744945; 
 Fri, 11 Jul 2025 07:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnxmYCxXNM7A3jMBlSj4VFuuwt0ddQkiw1C8pHQpJC/FmMGkVYSwIXUhy1GqMUEj2tgX0i2A==
X-Received: by 2002:a17:903:3b8c:b0:234:c7e6:8459 with SMTP id
 d9443c01a7336-23dee18b35bmr43874985ad.20.1752244744527; 
 Fri, 11 Jul 2025 07:39:04 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42ad948sm54234675ad.61.2025.07.11.07.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:39:04 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 1/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Date: Fri, 11 Jul 2025 20:08:48 +0530
Message-Id: <20250711143851.1490617-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wuLxKDA8mLwsTbUrVA1XciJk1vjFLYUp
X-Proofpoint-ORIG-GUID: wuLxKDA8mLwsTbUrVA1XciJk1vjFLYUp
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=6871220a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=BD0JAyWONCbPKr0S2ysA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNCBTYWx0ZWRfX7ztAUTqDPQyw
 2Ux+W+6iHEp9rAca/8WlE0bjcPqWeoNvsPSPBcKzx6wqBThbtgxsacWkNozZ2UWhbXqoKgApMnM
 exeNipCVqG8IWmA1hIpKgoK/jPl6ifOrja3Ow804ga92yp1rFlYVv1n690UrruFKCbbBF6zRLtp
 yh8YZJ6U4j9mZNzQ/8TkEkLghJuYCTznGUDmCrFwJlErHCjBs+/g876UXqMQiH6tpS2QoH8Ewys
 1XzHyZczxEV0eRpmslpl+NFVYArlm3ezkOs2KK2ntYGKqOOK5GrlRfqbR+P53YhC3Fx/jzvblVu
 AQUMrsrnKfN3maiLBuo+UZtGCxSpGIAO2GIFIyjnKqVZCDqQ/0Eqya1F9kk6wJRnnbHCat5Ce7B
 BALZk05t6/BcEfZYPFJESRo/j0gFM+KrelHyQqaqIWor3KQjrP/hKMXRZsQDbK75PSil+Tad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110104
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

Partially reverted commit "soc: qcom: cmd-db: drop unused
functions" by restoring only the cmd_db_read_slave_id() and
cmd_db_read_aux_data() functions, which were removed in that
commit. These functions are required for the RPMH Power Domain
Driver.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v4:
- Moved this change before the RPMH Power Domain Driver change

v3:
- No changes to this patch in v3

v2:
- No changes to this patch in v2
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

