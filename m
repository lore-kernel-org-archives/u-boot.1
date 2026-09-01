Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2D2C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 04:21:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8EA860603;
	Wed,  2 Sep 2026 04:21:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKQaV1WGMSJH; Wed,  2 Sep 2026 04:20:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788322855;
	bh=SdsWrbtzwklVN5+MJ4UmxgmEexnJ5jITv8aO/qgbdeA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbLcM9IB0St8T6oQeHlKtlBikNYBn7M7FJltXaV3vnk/tKUDYPN8Xs0wQhBEhTGqR
	 tyImco/GRgR6cZ4yRDgIBUV+IwHzvTwmW+e4JID/10paiGk6013YPXHbTFWwR5tjtp
	 wGqlvxeNkREAlGUqfmA1+z63k/wii0Rb3vVMEfhq1Pu7GTtFAiaiIDDFYkyOq3GZgX
	 7rq+OhO+xAlWugx/wxtuUEgEcqhv94+IsYDBqoSpRmO5r9pIBEP3SHpjRbRkFYTQnK
	 uXYwDQngaaXkzItIIB/lx4mBLzPbDZAWDnvkmewaXhwn+BOYLpoNXOmR5JJo4+J5fR
	 kgv6kZbmYysLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89D9660665;
	Wed,  2 Sep 2026 04:20:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 28D8A118
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E86B4063E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qOsCwm2xOy1l for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 19:58:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=WbXkKgnJ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V6G0Tejp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 013234069C
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 19:58:37 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgqIE2748276
 for <u-boot@lists.u-boot-project.org>; Tue, 1 Sep 2026 19:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=SdsWrbtzwkl
 VN5+MJ4UmxgmEexnJ5jITv8aO/qgbdeA=; b=WbXkKgnJPt1udjvd2MoPHSuE/uG
 U7B2cZ4uxURlhJ7Cb+adLJcuD4F1TVif2AjV/OkGyQXsI/d62Pxpkm2wJ5qMb268
 yq/XBqfd3enPjeeFbc0DByv0LRuzb1Q+ouEBSmBmTqpSXMzp1Ay+irPYNywjzG7u
 Va27uL7PfUyUv1PFyiA2/fanUPypU5qBDlD8l0FYcpzTkJ7cNBszEnB7gm8puVoq
 KuypON+14R1pBdOy4UvtQulTEQSWJ3jOXQCy1UAJ0fkHT8jd1lwTeFlFojqDYIG8
 bAJJVMYjKRYBd+k/zAOyT+PGItQrBw3NunE5nC8BoMudMoTHwrzAr4JTmUQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wp946s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 19:58:36 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso282233a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 12:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788292716; x=1788897516;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SdsWrbtzwklVN5+MJ4UmxgmEexnJ5jITv8aO/qgbdeA=;
 b=V6G0TejpX0nQLnXeQH0pib6XIs1pinvodrW3Lnl+TzhbOYhLU+fOtwizmktjnj13uN
 PG+uVsho2TiY+NGQVjaI2/fqt8D0jbUM3+uiJmZfvxH5yArrdd4NfjejZ3QLhp3CTmAy
 gDqlXKKEaRQpGicuVPJM4CZ9VQDXR5hLDX8y29JXUmqN88gHSjmAuFTEGdj2/gZMsFiN
 VF17GFgOVithRhnfyH5ZQBd+QLe0uIAAGh66WfVzxTbBqHHSMUpowjW/5CpdlhUCPyyt
 YNt6WSGCn3okVVosm1l3M0oaheA82HKkeu7qC1bWOfWDL9O4KBYvbYT0CRx9xR0sEHOw
 kKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788292716; x=1788897516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SdsWrbtzwklVN5+MJ4UmxgmEexnJ5jITv8aO/qgbdeA=;
 b=mUzGsIwfoRoJVOynhQxLqAnP2BvxqSxcDyioTRtzEwk/AWJH/NJ/wRXmy2SGaNux+b
 7lXFOeh+zwDh0jMvPgw23eRDaA3cTMA2wNWVUoA8fWPWIvh42UAClQ0q03z9bdcRsCzD
 6J5lhJo797seUU7+4NtYzIlIfpWvf+AsM+B8Gg3wTlbV/HM40oxT3xbZxjXRzv1GaP+y
 HqdZQ6NnzpeYNIiYsM8yaC2DBbpVDkdQ0RXpZtIYmBHFydSpml8ln7I9sNeSHRfpQunE
 0wuI7dAOXct+aDH4B4ffBuzfMYxf2OUwBzpxVp+riTyzY8TbmD1Ga6GriPs80/Zzk/qK
 elSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSLVQkjJPMLVW6zoea5ZIJOf6Tc/Wo0j/sZLSCnyr/41F7YfHNlsnrPr/NsFz/bO+JVephPFk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lhFT6Jd9ie3uoZn9A/D2GOJzuqv4omft4usu5QkpJ+Nhe310bF
 gWmbjeEDsZmYlv9SdhCaHZK2f4bHiIdhQe4jf31Ww1Xfu955H0pAofO41NW2yrKk8NJjGi9z3TB
 HFLzxTninhc39K5EfAcIoYxQv9HzX/a1+T/QLCpMqhSA+AiNgy4ysj+IZ05dT0AqgX1vvg/4=
X-Gm-Gg: AYBFou3rGwUzPgM04k1T8SO2pP+zWgMfEyT4AV2QSPWbQpKDEwuFRoeFV4nUXx+xko+
 GoRbu5LiGsRzLV8gdOq1XobKqoIF7F2wO8zMO11RVcfAob5V/28rf2IS35IDDl3Yv9CpXyyK28V
 kRxYQ22eputBod6PBTIB869JX5ZOgdFyNmmUtx8w+Cncubgk7blgQGowBTnyLjGl4ilfQjNpa16
 b9aWE77LnEaFKbFyY+SWeukv+7QgWOK0+xpV2tL0xcBxqcsxWEfx042Hs1RjBCPzDHpbjEWuAs0
 /N8Xk2HDmX7ms8koYOuCA2PcLysqB9Yu0OXoLUv1bfhmcfs07BBp2p5iIOFJ5a6p0SxQElWemTE
 qp0BePIrMmIobI/C/zKhIf6KRG3rgFtLo20o1/MWjtBKTOCzyXD9QWw+67uirKuMQinkFzEr+oG
 nbzYKJu5vuNl4HhpRa
X-Received: by 2002:a17:90b:534e:b0:398:e6b6:acc2 with SMTP id
 98e67ed59e1d1-398e6b6aed3mr25291553a91.12.1788292715928; 
 Tue, 01 Sep 2026 12:58:35 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:398:e6b6:acc2 with SMTP id
 98e67ed59e1d1-398e6b6aed3mr25291473a91.12.1788292715448; 
 Tue, 01 Sep 2026 12:58:35 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1430eb4854csm726433c88.15.2026.09.01.12.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:58:35 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 sumit.dhami@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Subject: [PATCH v1 1/3] sysreset: qcom-pshold: Configure PON reset type
Date: Wed,  2 Sep 2026 01:27:46 +0530
Message-ID: <20260901195748.1192630-2-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
References: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a972e6c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=LW9D_-4wNyH7aS83yREA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: q0THMptFdP4niTTY5cMbReYRtEKUPn1A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX/m7PXW4txUbl
 03YiG06T6FCZjdq3/8YPe4d6LedY7Buk7CznREbHRj3wxh5PVDct6Pf2XJJ8n3Nl5uw929H4Zcc
 WvXxQNfD905af0rSbaSQKbZCN9H1sgU=
X-Proofpoint-ORIG-GUID: q0THMptFdP4niTTY5cMbReYRtEKUPn1A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3NSBTYWx0ZWRfX6lXzP7TMMcVL
 HukqmoVMeG+xyZg+ndlDwFl6Hw0XRamc0mqgv0qxUq58xWtEpab7aAigiVx2lUqcT8rk5hCR2Hb
 FP2m/tl7zhhJIlaxRNRKe9nioVGAMrJN6t8j61NQ6niav7AwdixtjoozsU+24Mssy4IpSK8YxWp
 P8M2d6Sf0vsC0O07jmSZ4KilIP2Fi7EdB6ZzGEt8QkHGWEOVYOWbb7+UXwvBMjK4/aSVRkz71Mv
 slz3hjIj2HPvvi0ZQRxp+ofYRChI4TXBAKn/TqpRkVZMd7oij0BV8DuF5CB/OelRp1NIbKvkBDS
 mwipE45i4wY8ry4uupZd4tOy9Dgfo7uOystv7HbUCExwJ/vIoXPB7NCL0t4b+CMFqlcbVkxwEVh
 t2zuuUMjtPOhmkSE84YduUdn8szpcU/aJnzqb0fV4GlTPzAfNrgTuKlgSonDQSSziOSpuhK6rDc
 /cOaF2SOs4pNsgPVWCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010175
X-Mailman-Approved-At: Wed, 02 Sep 2026 04:20:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Configure the PMIC PON PBS reset type before deasserting MPM PS_HOLD.

The PON PBS reset sequence requires PS_HOLD_RESET_CTL2 to be cleared,
the requested reset type to be written to PS_HOLD_SW_CTL, and
PS_HOLD_RESET_CTL2 to be enabled again before deasserting MPM_PS_HOLD.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/sysreset/sysreset_qcom-pshold.c | 137 ++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 7 deletions(-)

diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
index 45290478536..de7c0b388aa 100644
--- a/drivers/sysreset/sysreset_qcom-pshold.c
+++ b/drivers/sysreset/sysreset_qcom-pshold.c
@@ -13,15 +13,94 @@
 #include <sysreset.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <power/pmic.h>
+
+#define PON_PBS_RESET_TYPE_WARM		0x01
+#define PON_PBS_RESET_TYPE_HARD		0x07
+
+/*
+ * Reset State of PON_PBS_PS_HOLD_RESET_CTL2 register
+ */
+#define PON_PBS_PS_HOLD_RESET_CTL2_S2_RESET_EN_BMSK	0x80
 
 struct qcom_pshold_priv {
 	phys_addr_t base;
+
+	struct udevice *pmic;
+	u32 pbs_base;
+	bool have_pon;
+
+	u32 pon_pbs_pshold_sw_ctl_offset;
+	u32 pon_pbs_pshold_reset_ctl2_offset;
 };
 
+static int qcom_pshold_pon_cfg(struct qcom_pshold_priv *priv, u8 reset_type)
+{
+	int ret;
+
+	ret = pmic_reg_write(priv->pmic,
+			     priv->pbs_base +
+			     priv->pon_pbs_pshold_reset_ctl2_offset,
+			     0x00);
+	if (ret)
+		return ret;
+
+	udelay(100);
+
+	ret = pmic_reg_write(priv->pmic,
+			     priv->pbs_base + priv->pon_pbs_pshold_sw_ctl_offset,
+			     reset_type);
+	if (ret)
+		return ret;
+
+	udelay(300);
+
+	ret = pmic_reg_write(priv->pmic,
+			     priv->pbs_base + priv->pon_pbs_pshold_reset_ctl2_offset,
+			     PON_PBS_PS_HOLD_RESET_CTL2_S2_RESET_EN_BMSK);
+	if (ret)
+		return ret;
+
+	udelay(100);
+
+	return 0;
+}
+
+static int qcom_pshold_read_pon_offset(struct udevice *dev, struct qcom_pshold_priv *priv)
+{
+	int ret;
+
+	ret = dev_read_u32(dev,
+			   "qcom,pbs-pshold-sw-ctl",
+			   &priv->pon_pbs_pshold_sw_ctl_offset);
+	if (ret)
+		return ret;
+
+	ret = dev_read_u32(dev,
+			   "qcom,pbs-pshold-reset-ctl2",
+			   &priv->pon_pbs_pshold_reset_ctl2_offset);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct qcom_pshold_priv *priv = dev_get_priv(dev);
 
+	if (priv->have_pon) {
+		u8 reset_type = (type == SYSRESET_WARM) ?
+				 PON_PBS_RESET_TYPE_WARM :
+				 PON_PBS_RESET_TYPE_HARD;
+		int ret;
+
+		ret = qcom_pshold_pon_cfg(priv, reset_type);
+		if (ret)
+			debug("%s: failed to configure PON reset type: %d\n",
+			      dev->name, ret);
+	}
+
 	writel(0, priv->base);
 	mdelay(10000);
 
@@ -35,9 +114,53 @@ static struct sysreset_ops qcom_pshold_ops = {
 static int qcom_pshold_probe(struct udevice *dev)
 {
 	struct qcom_pshold_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args args;
+	ofnode pmic_node;
+	int index, ret;
+
+	priv->have_pon = false;
 
 	priv->base = dev_read_addr(dev);
-	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	ret = dev_read_phandle_with_args(dev, "qcom,pon", NULL, 0, 0, &args);
+	if (ret)
+		return 0;
+
+	index = ofnode_stringlist_search(args.node, "reg-names", "pbs");
+	if (index < 0) {
+		debug("%s: referenced PON node has no 'pbs' reg\n", dev->name);
+		return 0;
+	}
+
+	ret = ofnode_read_u32_index(args.node, "reg", index, &priv->pbs_base);
+	if (ret) {
+		debug("%s: failed to read PON 'pbs' reg: %d\n", dev->name, ret);
+		return 0;
+	}
+
+	ret = qcom_pshold_read_pon_offset(dev, priv);
+	if (ret) {
+		debug("%s: failed to read PON offset configs: %d\n", dev->name, ret);
+		return 0;
+	}
+
+	pmic_node = ofnode_get_parent(args.node);
+	if (!ofnode_valid(pmic_node)) {
+		debug("%s: failed to get PON's parent PMIC node\n", dev->name);
+		return 0;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_PMIC, pmic_node, &priv->pmic);
+	if (ret) {
+		debug("%s: failed to get PMIC device: %d\n", dev->name, ret);
+		return 0;
+	}
+
+	priv->have_pon = true;
+
+	return 0;
 }
 
 static const struct udevice_id qcom_pshold_ids[] = {
@@ -46,10 +169,10 @@ static const struct udevice_id qcom_pshold_ids[] = {
 };
 
 U_BOOT_DRIVER(qcom_pshold) = {
-	.name 		= "qcom_pshold",
-	.id 		= UCLASS_SYSRESET,
-	.of_match 	= qcom_pshold_ids,
-	.probe 		= qcom_pshold_probe,
-	.priv_auto	= sizeof(struct qcom_pshold_priv),
-	.ops 		= &qcom_pshold_ops,
+	.name       = "qcom_pshold",
+	.id         = UCLASS_SYSRESET,
+	.of_match   = qcom_pshold_ids,
+	.probe      = qcom_pshold_probe,
+	.priv_auto  = sizeof(struct qcom_pshold_priv),
+	.ops        = &qcom_pshold_ops,
 };
-- 
2.55.0

