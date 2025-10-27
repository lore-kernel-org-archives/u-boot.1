Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8F2CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC2E836D1;
	Mon, 27 Oct 2025 12:33:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="liqHmx4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A44836EE; Mon, 27 Oct 2025 12:33:58 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C214E80107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R7nkEH1065061
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dAlYdpwsXlJ
 iZKBCPHSUh0CxqTW9l836d37CC47imKY=; b=liqHmx4tfphdc1SDKoHkFEtXhwZ
 uepT2MER5zGa8qE9TENED3LITE3XCcLZX2H8GrrJ7Wva9awZIDXAeS7odD0xk5gu
 Y9zR07bPcNI7YdUV8/aYHIn/4qQ/FI5JGY/5CNc/CvPWjDho70GAgCrCpHnmhfXb
 EB3I1+slvDMM2eNMHY8MM7yn1Wzxp0qz3Sy3CIDQKs+U49lPOpn1LcaEz/HjR9Ny
 nHZE2SCWnXUnhnuw/7lktZf0UwX7kodv5/uy3M5sRK85OwIcczj4JiJn8fGZDtrr
 /oRx5S6NVt+RGbSW3S/cejO91U9Nby9suwAPaePbKrnWBRwU82XrfW3NDVg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps14b1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:33:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-290d860acbcso101839745ad.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564834; x=1762169634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAlYdpwsXlJiZKBCPHSUh0CxqTW9l836d37CC47imKY=;
 b=hyrttHCIKD3UUKzzybslcwmUQ1lRMnDvUdhkQkbsqnj97QTCRtaVlsONNSlj9c2Mmx
 6dGoIjFHxA5fP0zl9U7l0dkGZgHdCi7tE1RmOB5CZvHKK5BfyhHUJRejpsk17h3Npzol
 9odwtVpKnwVnS2fYhPRDxQ++5LSMnmzyztj1gkLrHZrQaFZMMaM1vWl0euUU4WfFb6QR
 Ykxc24C2viBRzue9lQ+2e3Dww+GHKsMtpgTl2lBdDiUwyhgeIM3geTBryMeADngp14lM
 i88h24iQo48jnVNxT0MF46lS48bKHu+Y2RaeEu+zNgoYvpqvfq0nrFrQLIkRTReqti53
 dISQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUenIEM67wHmUejH0W7KKkTa8aLFOdQG58ks+CLh8F0dI5dMCbbTC/HnnTG6pd30QEcCII3MJ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4etdeWwxxsQ6x1Rw/PrBLQaYjbQHHj3xajKnDA7IAiHHi/uKY
 Wu9+Cwfil7Rf06AlmO8sb1JgLiSJEz0uyPt/XoykUCqWe/KFfONxjuwX+RAKL8KFCnr/syIZrZG
 vGAjgQ3vThlbEXS5cOibuI/I8pPIJ+Oo3Hp296h+aEqX39PH8p/SHWCCO
X-Gm-Gg: ASbGnct78SswGs7nGUshRDZGX6RDmAjxf0NPKdflwNrcDcfRaAut61BQieBhYyT8Pd2
 IxfzJQfFxbi/pWhs6SOW1bjaRmYukHwAIJXBKrzFMHA5LMehCs9JluxjsrI+hTzYnGiPYsSJSzP
 mcoUdDo7Dpn6Ev+3fr38sIfaaaQ+kaoGTSZHVEkQeI8Lmd1aJJm/PtJP6wpKcgdVJ64vqq4jd1D
 hGvFFxsBWrs8e6zja4lWExTpi3lnRTYVSKfRhxH4xB23wdfaNiz2k6nj3XjNgvwdIN6nmCmLcZw
 E1UI8mt9OmunnKjkIkl2juBSBiW7Z5qz2ihNhlk67FlFz7wIA2XBZjwzjqvpdZevjlQBBvE24AA
 bIIbrD+PCqqqkEu1oSWTB0YMjVy4kuze29LG9j/tG8EvvzDUVtPvtH1HD2d3BaQMJMVpCgabfGX
 VOTILb2ZL7
X-Received: by 2002:a17:903:1d1:b0:290:2a14:2ed5 with SMTP id
 d9443c01a7336-290c9c89fd2mr381538055ad.4.1761564834071; 
 Mon, 27 Oct 2025 04:33:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpSGdNOrhPPCzpw9cAE969GTVNOwst5MfD9k9e9kT3HfQ2vnEc5AFdoMvAr4uMD5dplm72MQ==
X-Received: by 2002:a17:903:1d1:b0:290:2a14:2ed5 with SMTP id
 d9443c01a7336-290c9c89fd2mr381537725ad.4.1761564833584; 
 Mon, 27 Oct 2025 04:33:53 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf4aa5sm78497825ad.13.2025.10.27.04.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:33:53 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v5 1/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Date: Mon, 27 Oct 2025 17:03:09 +0530
Message-Id: <20251027113312.3815169-2-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68ff58a2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=BD0JAyWONCbPKr0S2ysA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LgK-SVl_lteytg4B8L7BjQeGS97eTYeg
X-Proofpoint-GUID: LgK-SVl_lteytg4B8L7BjQeGS97eTYeg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfX355GOzJHPKEP
 QMeY0spgBZV6d6d44BlQKzO48IlPch9V4GMQfIJFiLF2SXPfws6quuS1novuL1cmn3DXGqxk0iP
 2QbW5sN4aJWSLmveiPwfdyGi4TBhobyiuFn2hPOQqIOaBp/1y24m7OVa9lq3RXamfx0J8wjSwav
 KcHYhqy9PwBAMrYWL0sateBQPOHhja58QJ3NeHPF4qHa52u7zUjNd7wwX4GGkaa8ytVnKHWY8FM
 0J3BHM0nnEgA+VBr5gxGLRvTchig7X1KmlDKpTvDhIi89qjtpfuCbVcjUMXHUr6kRYcL/H6yE5+
 J/rDCLzBUdw7sjWeUHVnqOhoK4wajyoaiXlkp+NIZZOtLqxXjV3WQMOVrGk7PoxKMmjRSBhN8TK
 mmlVaUoJRLuB2yPYQSLWcJ10zdGc5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270108
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Partially reverted commit "soc: qcom: cmd-db: drop unused
functions" by restoring only the cmd_db_read_slave_id() and
cmd_db_read_aux_data() functions, which were removed in that
commit. These functions are required for the RPMH Power Domain
Driver.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
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

