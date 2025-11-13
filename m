Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5496DCD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 967AB83C62;
	Thu, 13 Nov 2025 12:34:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="plfhSjIB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UroY9e0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597F583DEE; Thu, 13 Nov 2025 12:34:54 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0587683B8A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD5SEKg3440692
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yf28lF3AuUw
 LsTgL+OTPGUf0G/KnvJ8ULHMBJewn9gY=; b=plfhSjIBNCvwnTZqfBpA165oF9W
 avZCEtZ+yxx9L+zL5MTZowzyZK7Ay/tyPVnsf0l+kBOZxSU9uT+C+WgAe0gySRdx
 rJQFOd5AcD7b0r0UZzIX3jUgOE1N9SZ5DiNXt7njgf25NN1NiMc/PEWbJ8ewFzOo
 ur5jvPtZa0FIBvwIRKurlUqViglAndPNfNP5489FO3Oo2WuEBXNzLOdt/ssglr7N
 PBun2O5h6kqAWLERilclGOpoNVBIvMjNjAE5Zxx5cYLlNRFp2MIBHRvRWrSINnBJ
 SqVGfNw8vuHWQN6pclF+m8cqRZLYrsEqOyW77UbaLsOrJI74apfOAqWK5tg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad978945r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:34:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-297f3710070so19239575ad.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763033689; x=1763638489; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yf28lF3AuUwLsTgL+OTPGUf0G/KnvJ8ULHMBJewn9gY=;
 b=UroY9e0ot6u0pBgiWX1tZ8Oty4SfxzOliE5O5vwvOMKKjQCq6KmrwkyxlKI1qs43Oj
 GzwU26eXueLgAcWIBl7yCp5kDtV8n/I7gV9ygSHcfyE4Fn1JZTNcnODzknm+FfKFGArU
 pqcSPAhT3rk1L7q1NH5PJeQQoLQgaF+IVORhSCQklnsq5tpWCBrcWRZA8Plpz+4jMLXH
 xCBslAbnwzL0v6lm4OWKwqkJKBzZmfxXLEaLNZKp+73zLJs9HyNdccaItctLlfWwzPN9
 DSwE3Ckoml/VXmhD2smx5L3ExxarhBq/1KoekwU9LYpvfJpDKeRFdDJUI1nDwzWVKBzo
 NGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033689; x=1763638489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yf28lF3AuUwLsTgL+OTPGUf0G/KnvJ8ULHMBJewn9gY=;
 b=NL2LDIX9s+LAYwy+cASQfmYpcoE65P+LpVMEXHd1ro+lM/QIQRPGxMu4quY/5dRVC1
 /98UNtjr3aZPH5YsxTexyJklX8eOCh/jASftTfBxDPJU91q4INVlnPjeQIQZHLCiarSO
 FIm7Ib60tWAUESW5XBH0I359aS/cnaTfhz8efpx2l+9bDBZwvhI7b9C6f6hXCTRva162
 G+LoVqhHdA+FgR5pf1rxjjSzeJNicd9OqDgQVwdJUPBJBrbK27rdpyUZM+oniBOJmgFT
 UEwpePfcu8dsLEx6NFsNM1ALweO/dEUtzpjtF4zBEeHsnkJr0jRbizSOzuyUdu29OKtJ
 oz5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOTWwAtJTaRle65pN7rHCEjE/zU20x7+v4yDv+oO4fizXAB463quyHyJBl1CCTVgMalBONBmU=@lists.denx.de
X-Gm-Message-State: AOJu0YxJyVmwRaCsK+0tLEEZhOSytcMioSizb3beR7oyETiUHMcU5/3H
 ie86tUfaUPTfk0LX9DXfCdnL14gOsFhpOizlEefo1hryK2AXbSfh3ZyfHw8z4Wx20jZKJfuoast
 zkKyJzW/xDGXhEm4HH9Y4PGGKnUh+yW4sKC8HYpmU9jwwu3lCH5ooJvtg
X-Gm-Gg: ASbGncvA7bqvpu7r/fvIIQm+HxE57RcQy7bfu3qLsvxEc29LugZ6NKRVDrcsytsc6R8
 04RQg5eqPqrpTTVYtBnnEP1Ho1JhbwXsa2aJkIm2rIcKq1bPTx94DxSJCHPX3gbTlSYAsfWr3T/
 cmoiM3KzhinB+1VVmxTACiLvo875ymz5KFB2nUwZj25Mb4tWwne1VfWt3tQIgf6VAa2VweQqvbI
 amU2KR3o5QFSRe/M5vAETOUdJz9nxEBUm7CjqN9z1OMTOqpsc8uJ1LrmRVQ5dyInjnjmcOrUyiL
 SYQrryI2XGTETOlb1vvSZkvHUWgA40ukHDsS9tSY4txTGXvAidQua/j80A6PI/AI2jkXMwiIYkJ
 Hxmxmx5AiJ6N0dPHAnVSvNyQiOD9xeYn5mjiwmuMMWM5uudGFaaH0gnN84cvtlSvyImGicUM1hY
 dM13gUl2jLSY9NF94HsA==
X-Received: by 2002:a17:902:ce83:b0:295:50cd:e759 with SMTP id
 d9443c01a7336-2984ee03821mr84775345ad.58.1763033689381; 
 Thu, 13 Nov 2025 03:34:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHknMApjQChxG3selEnRraHyHVf7XFrPpkdbBjq5TKhIO0B/VahUqsTrNAXU3wd37x3BmswIA==
X-Received: by 2002:a17:902:ce83:b0:295:50cd:e759 with SMTP id
 d9443c01a7336-2984ee03821mr84774935ad.58.1763033688911; 
 Thu, 13 Nov 2025 03:34:48 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2346e6sm22573885ad.22.2025.11.13.03.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:34:48 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v6 1/5] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Date: Thu, 13 Nov 2025 17:04:23 +0530
Message-Id: <20251113113427.2218045-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
References: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NiBTYWx0ZWRfXz/aHA4yOH3d7
 627PbXh450uS9/1pZqmZVmi54ofF4TfXZOlv5A9zDnkblsmR/oChE4xtmgyYY86nTwvtIP7L+GP
 s0hSzOuSOHV0MMHgqGUesLziv9vj6WQ7+Xn0OTQT2UHHnah2xiLx2lAzA6ohAL2pf/q8o+Ojf2i
 GdI95JVcJvxO2quUexKfhLu9lG1rl+UF3+zfHAeCuuAGn6fUHn8tlc39m/M47KdTjjaQe9PhyIW
 2SJg3PaoQg22OBvXmbAt9AEkhl8Jn50FhOSty1zPoybtP5Lc1HrUAE+etJSsF3Mo9z8DISi6pqw
 j6Du+s2vggdI9WEvnVBg1K7/RXFJdElwv7r6PotHarMRS3ID3bE8+cDfR2JB7rXEZ83DwOnXYwU
 zrn8tqOYplWVVcW5pPD6IVIF94rG4Q==
X-Proofpoint-ORIG-GUID: 30YQ-RPerLnehFizL0s01Gei3Nl85K_O
X-Proofpoint-GUID: 30YQ-RPerLnehFizL0s01Gei3Nl85K_O
X-Authority-Analysis: v=2.4 cv=PIYCOPqC c=1 sm=1 tr=0 ts=6915c25a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=BD0JAyWONCbPKr0S2ysA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130086
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
v6:
- No changes to this patch in v6

v5:
- No changes to this patch in v5

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

