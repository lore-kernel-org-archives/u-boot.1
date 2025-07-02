Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BECC77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 17:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A22582F00;
	Wed,  2 Jul 2025 19:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WH6Xhu1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3913B82A76; Wed,  2 Jul 2025 19:13:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092EF82EB8
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BHbg2010383
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 17:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q1Bz0c9e+NT
 CjrvyQXBcuAKfk4RPO9VGG/2KSz1J4A0=; b=WH6Xhu1cqIQiDkpybvi/G/tyTuN
 f01YsgvZVccGi1RpohObN/BQVm3zc4JqBQYcZN0q0eL4FNy8edFCE/gmS7NA4Sp2
 e9wsOQITLkX+doXtgo72dPke8GJJlgvNJoprjHuY0aBH+JiVAesGoV/usydgJ77r
 7F4rZtdPX9VPa3FfXOLzhzO8OSOjkWpRqAIasAcWMen0hzMC/KBL6vtyFKS/G3Iv
 iEB97DO36uP4/h5gp5EBl1gfYMSGV5vApwjGGTLDSNWjtV61IZDiHWdrcbHPuUDH
 FWm2SSF2759CC5Meg0MUlni5Y3b13AfLrljbd+CWlegdLWLTjgorT3wPvAA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47mw30ag6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:13:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-748efefedb5so1067237b3a.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476434; x=1752081234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1Bz0c9e+NTCjrvyQXBcuAKfk4RPO9VGG/2KSz1J4A0=;
 b=ulpkieGVO/6T4BOMEahA0frC86MWMLHAgeYrRtOh0fX7fo4SGaYjbqS9L3JYoHptO8
 Got0DJ32MyQHv5EuV9in9izJU7nEn3Ygchipdnq0CPalH7ind4SV17CtKwZhu83uuFGq
 tjhRrn/gzJQLENZiWgGa2IP378Ll6P+g3yYfpvM+v98KYEUAuOe6IbbjzEIUeWl+5yPA
 e5lTAUahhY14BeWnH8sJw3WbhU+lceNMleYZqr8YHXbAg3dWMWzZ2deWwMJidG/AavQt
 AWLzgMxyZvblC3zDv1hq8/AJa2rU8kEilu9VyCzJ97gzCMBAYJrtr7LxCkhZXAlhpdGp
 3z8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1chnQSx2kQJAa1+7BPRXZSWJYzFd3GzmbbmL4YEJQ65Q4UZHHcxr09eWjActAR387o/aWnZU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7I32RFn4BanZ6Cw1+ZjoXnr8IYCT/euRDfibqygI87cvqtpie
 3DBuItWTOwOXVDLJshltIrwFfH7NP6+MqDIgIQAtJtiRsLngEYMTxn7a6a+PqeXYy3vMmnP+dtO
 uQLwpyCQ1M3JLIDB2bi4Mwi1f6ET9C8VO320iOFVeWU/6D/JHwoSNfT6I
X-Gm-Gg: ASbGncuiacNonNi7gk5BBgCgrtxFmJiYqZ6WzH+QSY9CvQLhNNrhjLf82h88NML1UbV
 2htBgv5bgfOIbaGYo6Qxlq/EDvyKbyaGDD6OINAUvSOM2ab9R9fjVnpmQuRIMDMYCPNibhnaBbO
 XB+Flv+zy92qwENNSE0SvwRT/aKOI6nX7RVP+pK4GyDQ0WD3gJiadn2QtR2LWxCvhUrhBUc/yZf
 Q74ZNzjLenRdZaJm4pkJbg21w44OhWQ/YtLunKeQCxmM4Lz0SEoJM21OTz/GHnalDoSC0gJDOLe
 8RCwSStLz02awq4+24rMgq8HJojUXHYOF4Cg3xLafy2+31pVAEN9eYS6xgKUx8rkP4NYVI89tCf
 xPU1vi3V12FjgUD5bw4lgjf45cAN5Z8tujQlIQWwNFg==
X-Received: by 2002:a05:6a20:a104:b0:220:396b:991e with SMTP id
 adf61e73a8af0-222d7f08c58mr6616966637.32.1751476434309; 
 Wed, 02 Jul 2025 10:13:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYuJlvXGukFi73nU90OYl0l/DS0pJUY9w5XCTcl0LtNwfhWOXlp/g4wX6KY5MTqkc7CM2pJw==
X-Received: by 2002:a05:6a20:a104:b0:220:396b:991e with SMTP id
 adf61e73a8af0-222d7f08c58mr6616920637.32.1751476433913; 
 Wed, 02 Jul 2025 10:13:53 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c5837sm15144873b3a.116.2025.07.02.10.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:53 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] soc: qcom: cmd-db: Add cmd_db_read_slave_id() &
 cmd_db_read_aux_data() functions
Date: Wed,  2 Jul 2025 22:43:33 +0530
Message-Id: <20250702171335.1811080-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
References: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CY4I5Krl c=1 sm=1 tr=0 ts=686568d3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=BD0JAyWONCbPKr0S2ysA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: kunZqzaDnxfl9D1s292pRww_dkMNCKJD
X-Proofpoint-GUID: kunZqzaDnxfl9D1s292pRww_dkMNCKJD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MSBTYWx0ZWRfXy1aWDVSI3WU/
 99vbIRVmquwz6oKWHvzBvnl+zymh28S1FEQg8BanNm4PdP/F+CaDYMG6Fe0n+FTQR5UtGa6Z90W
 dMj3EZqJ5ihb1UI2FNyXEr5m8ztrixnHY5fNxZY+fdgkFdFNyEPLlIwf7ONbYcJtO6sJu6DqA0a
 ZvgFE2PEA6zfb6AJZ59XSIkZnfYlldWdNjh3DP4Qgm9kZlI3sgbBarb8ilpbkNqU86SAuHrv+1+
 0W0+Cw5Twfad2hVRwPrCByBQNAeMKhzo+sfZvDwh3uv7Kqhw5jP8K5j4op3eRAKILoN/VASfJR+
 i2NtYSFizv03oxDpxMKu+AxYFqE10xGx+seM5RJZamNpRW+LMiPLJNWE/RRUB/lB5KER0cs190B
 9VYcOil4v1pTxLqqKw+iLAslSu+2HVA3MUHrpiD5iTFLh+qUULXBuR8o5d1ZagBdsnXUACbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507020141
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

