Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2305CC83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 18:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D0EF82F03;
	Wed,  2 Jul 2025 20:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNXojcj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6F5481FEE; Wed,  2 Jul 2025 20:01:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85F482F08
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 20:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DIT5V018559
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 18:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=412woEduuwr
 r3Ifyd2ZLsCrx5wUr2kIDJGrJFKDrel8=; b=bNXojcj3vKMCVRTdZmkb9OZGcQc
 j8afEOeYW73DDGuLS+UTQK8mOpTNjVuCJ+x8j4ELQaeexeNTbxTYRzT4Nnh4NTVw
 ThAOQi11rB6eOLkkkFPgzTMyE8Egqa0aCO75fsRdtJE3LRud/t2Ljp+CTAOKkfdb
 qTXyC8lC9B1LQa3/EVkX8Wli8NRpBpaVCsC7C2i0JJdT9z3z/ARtLXGeA+X1uwE3
 +jjW8Rbbp872J90Agg8LtBD4nBtFa41s+aMwR19MZuPZoJQSD+dCo8ow4WMGZLN1
 1rkSeW1W7o/UEzUptsCJrHMSOEZpCu2DuRHcslQx1RI9PrR3EF314oMQLmw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxnmbb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 18:01:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-234a102faa3so52079955ad.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 11:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751479312; x=1752084112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=412woEduuwrr3Ifyd2ZLsCrx5wUr2kIDJGrJFKDrel8=;
 b=NDj9ND4qUHgdBH60KspPjZTNaAwuxY/W1/93tpFrxtiyNZUSmXaNuybMfNXNzFDCLU
 6jYWuuUlX8Jy2JvnUXKLZkUXmHHT43GKP3cXZhuMx7UWsCJQZBHXsL8h+ATkSk7h8cqO
 HDT0PafL0lsCFbb0J1ZDY93KGPgqDi5hOncwjNxBrsK8aX9uWXy6xDqwLKn9XsABpNBB
 tfKCmi/GcgW8wpOVBMCIoWqvVVrv3/guWbuz9VOboBAcM7VAaphgpHcJZAiAB/AaP2It
 XwbPhQLsfC5lOp4RGEJiJ/J7P+tTF7lH/0M5JxQ0oMaV3/kV3GuZwmif0m85gEzGBQOH
 zFCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViQK3mIHuhcZ9HrrcNjgdThUkGm7ALqA9ERthM7uNbfZdx0ohuWXFc8RyE2cevWwHvIw5HSZI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywk53fel/09/CQvhk676wflClM5s+SQJ5AGf96iLAIJH6nHQPOF
 zrGyJnwDW3GGvSWZ15ipbrh3mAhC2+gtk46ZFXJrmmFUPu9K0VzR+URjntdlBWq+Bjo9CyrYltD
 pq6z89dgn/d2pk0102IKlZQJSegT92hEvFriUl1InyEapqq4uO1ziPMfK
X-Gm-Gg: ASbGncvqzdjZSqdWLgVgECg4J69vqrb6MoeU9iBpoVDTTmQ0yTR/qlzigzAkYdescMZ
 i6BxHXmn+Ft92IVGlcVCumgV9e3WwHtRKmsDJ3DmO7qz3/rR3CMUQilAgJ72sZyPwhx93h+2qXa
 TtSORIoIqDJmEa116Qi34uj6DdKrzb/TL3IrzqB7XS0FvOVGqa9MGs3CKz1m7miD7V6deFG/oP2
 V1So+k3X18gPY8d7CppFAZb6uU4bgRRxdlEvoBIWsaH4FHjSPB5lYQOF7v68j9HeFjczMM3bo0x
 GD7LnYsW4egej41x85S/KL6udKuDBJjArXHV96+aFsLrsoE+/nItSJ0WraHHoxH4ak5sTzAO1fi
 eYF6sezwfRiNxke59t2HyTCiyrOshFzuYm1zQ/jg+Sg==
X-Received: by 2002:a17:903:1a27:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-23c6e58df66mr66200755ad.28.1751479312068; 
 Wed, 02 Jul 2025 11:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1AHzv/e1Ral9cnLGKcEjX7q26CP1uVod5oOmU5nJoB0oWgg2MK5cU0bk+Hha3OfkWbs6gKg==
X-Received: by 2002:a17:903:1a27:b0:235:eb8d:7fff with SMTP id
 d9443c01a7336-23c6e58df66mr66200145ad.28.1751479311511; 
 Wed, 02 Jul 2025 11:01:51 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e39besm143315345ad.13.2025.07.02.11.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 11:01:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 2/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Date: Wed,  2 Jul 2025 23:31:31 +0530
Message-Id: <20250702180133.1889709-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
References: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0OSBTYWx0ZWRfX4KiESWO3kTTq
 eIZoSDCbHIc+dxQfpAMn2fFGns1ACLL3LCAf9jq85Q6mby3fdoh7TnmTLGgx5WSRk0ilZ6NhDof
 vmsF3I0woJ4UnJ3ziAewxXrI6pSnR0mpRBnHe+aXEKujx9DM33igIbDh5MVzmcizt1uZwCwouIg
 4xLjjD1BoKgXcsgyo006uqPUB84cyWp+UXRanaQFCBR4+i8nl/fXMp+A7lM0tEaCKYf2qEr+Ol0
 0g6jJt6bftasQ9cP74fn6D8pP+7suzgfVZxUXGKHAcYY9nm99UrrbmBloWw6KiVNBmaX+2rIjLW
 NWUt0iEiz2SbIvOXj4CR2A29KlvXy24wat6MwAisOeXCVnNLNidP2aNtnUVPPEkdoxNGTrTgKWs
 ss6c/CY4aN5DXNM8vDcDiE64NL6Gxy/Bb8XTZ09aeqdjLv3XCRrE1eccLAEcCx3PoAheUel0
X-Proofpoint-GUID: FqxsI94lkUlr0w7b0S4N-Qfe7oOayTrx
X-Proofpoint-ORIG-GUID: FqxsI94lkUlr0w7b0S4N-Qfe7oOayTrx
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=68657411 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=BD0JAyWONCbPKr0S2ysA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020149
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

