Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E65ECD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 16:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8961C80287;
	Thu, 18 Jun 2026 18:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IbBmdfZj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVNQmtjI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A5308056B; Thu, 18 Jun 2026 18:28:01 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DC48005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 18:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IFDupG1559270
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=rjskPnDHbgqB2RGvGMlR7GXzPCltlFq04Kp
 FB9dyJvM=; b=IbBmdfZjXu0ZLW8Cpt2aUgLUa7oIxE5H1EyF1EgZ8iUdLvoM5ie
 8Z5v3OptIbZnK+uGK+HLJpl402Na2MDd2rHLLp+LHwSNCPufu1VuYXmGyRHn5xc9
 NU4K6lTx5Z/H7kzYxTPIISQgmv9RfmOiM5LUtnwow4xD/DiHhiz+ERboqTmuJbiD
 NNX+dnlx8vCzyYJckZ6KKf7UDdgCDXyXBNAM8364sZDPuiwYgh3XXVxFjQ60JljA
 OSlUqOg9+xGx2gT+BT9dIBOWEVvMbr5ym1BYCQM/iacq1/JnSaojq5EC+Ouzg19U
 CE+D+DHdHJaTiGZz5tsnsOjBKcSyp5GRtBw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn41nm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 16:27:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c6b4271491so8874475ad.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781800075; x=1782404875; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rjskPnDHbgqB2RGvGMlR7GXzPCltlFq04KpFB9dyJvM=;
 b=SVNQmtjIOMNVWItlr44MRST0vXrglbRHv6E4Iji4LKVmrfDLl/ghv4OarMJsm5BC6p
 g7v7Q4k8PR/Jxp8/u/pWTHMFHYxQ8t2aDhN7TsScG9nKgWTaQOLki/wfC276rmfrk7P/
 YImeSIydsg1u2ZRSMqctq5sZCze9TIE4FIKFtmGlqg9RvhPtaly8e9Du+GFa4GzE8f3t
 rYxNRKY3E0MGW9lz1zvDczjSwVZ2dL4bTJj/1u6oL4qJCqnSeXiQD1IHp3T9jxHCr9M+
 awepOGWs3n+eJDgBRIe9ckspVeMS+fwFVMnLaLspLyRYiTNiE4v0t4N57KG7pa/KPMDR
 uhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800075; x=1782404875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rjskPnDHbgqB2RGvGMlR7GXzPCltlFq04KpFB9dyJvM=;
 b=UvNi+lQg9ojpVe5fCqwvuWlJmnfvXygFYi6qzO+lxVDxAyoPdYhErIxjhB17TMfbBm
 vnDdHNkJhgkBnBWt5RJVe3biVgC2cv7a4EaqCzPLR+BRHEfzZrSzVP4mVWectBjZrHB+
 jRcAVySAwofGa4WjHaMXKFplX7SsfZhIpBR9xyNQzA/g9My0e/VwPeehbfIQ2wcJ/0ik
 bI3T1O7SX/hgnqmYWdlD29AfXioCejUoxHoGfdnlRrIA4776BOPZl9VACPKCq+Baz5hi
 0oIVmBgvCBQ0GYwlkWWVzGHHrRzNBJHuD4tDGlZiJAc467p+6bv0gd/Po0FNwaRLI90W
 Xobw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bcStNx1Qr1/Gbik8egZ8rLmYGkS5BtOX4OKHivcAt6vDhjmeuFUu7rcfRP7dS696CaQSZc68=@lists.denx.de
X-Gm-Message-State: AOJu0YyUHAPafGrw/JH1MAgM+16JK2W/h4eGJn8aYEB5exYR60FfPcfE
 FfJC01liYFxZgoE1ONSfTpU0bdYx18nx3lFxsSnGkLQ8K3v5Ws2VELBMS2VXm86td5D6UDWDRsh
 r+BFFpysrtS9RsZLGomQBaNpiFIwjZ0PAL2Ac6faYVg/uhuauciuAQVqY
X-Gm-Gg: AfdE7cnxKU1nVJWdJgBmRfDK8mF67PVl0ByjpLNJYchPS5zM9BkrUluvKuwhPVyJj8g
 Iakfh8ZTNVZnprdutpzkjZCHK+1tcmZEFnS+boGj7ITN5lQUQCsStQC+mlhfrTanMVRc/ER/Asz
 lWN4Hd8cGLQnHY3V/GM6AZtc9FTeBhr0De12v70Z69eXUQbvbgKDhIWB47H0i23i8PZqbsLMb+q
 qoFb97sU8yS/rwkjzRma1wiPLIofv56/Ny6fPa8atqQDhVL4KTAPf1fOgxrnPltuVKxXHBp8L4q
 VoiPZbEDg5aSvWcd2qFQa//Zq6NeZQWt/yY3dai1iDxD+UTdGTOd26GrZMEdUG7EHB0IJvnEK2j
 xcr8h94Og1z/D97xjC7oiKw6exJQOMV+Plkgqs1vd/ky4Yc3pyyrvIEww4VVQnG2QXHV0PSwvti
 gtULRlSKMn6C2eQWc3ryJ5REyDiUKcbQ==
X-Received: by 2002:a17:903:234c:b0:2bf:379b:53f5 with SMTP id
 d9443c01a7336-2c6f3465c9emr39945445ad.23.1781800075257; 
 Thu, 18 Jun 2026 09:27:55 -0700 (PDT)
X-Received: by 2002:a17:903:234c:b0:2bf:379b:53f5 with SMTP id
 d9443c01a7336-2c6f3465c9emr39945135ad.23.1781800074826; 
 Thu, 18 Jun 2026 09:27:54 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c6e54e823esm40789475ad.72.2026.06.18.09.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:27:54 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mateusz.kulikowski@gmail.com,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com, peng.fan@nxp.com,
 me@ziyao.cc, patrice.chotard@foss.st.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v1] spmi: msm: Fix V5 ownership table offset
Date: Thu, 18 Jun 2026 21:57:18 +0530
Message-Id: <20260618162718.1984873-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE1MiBTYWx0ZWRfX88DuJ1eExITT
 BORjarwy1KzjCx8sMO3SLdoZZ1x88uw6hD5Xvvnb6g+2b8QliC73lPNoaRSwkbLKwxm0+llWRH2
 B+UL2NFmJ1tPvRSCoyxJ45riUWfnAk+DD0gqoAltLxosJpgVF+lc+Kb1gJJEZ83jvbs5Z9rKBDt
 q5lXfQ6RYDg+/bzd5QQo8vbwPsLv6jA+Tkqt2JgSM4FkQOdLpVGz+QBS9zqbRLsovIFercexZSO
 iMNSX/UQC7a8eC21Pgr2PRk/u7cfw0QQtZiSCeugz5HNXI80FzAul0THjtl0nmBdzHJzsT9tSb6
 bC65VsuXsPrlK5LFIAAWhsbd+ihRd/ALRHwPpqj85pOnmVBxY9bSk/BkDRFU9G/qS9ILsG7/vkJ
 8P/yL1BFQC8bV22vmQ9aMreq2nM9q3oEvkQP+V9tgEbQlEh4EgpKYUap2R4KzZvKsI05rbFhJ9j
 8f6EtC5eKijT+B5/YRQ==
X-Proofpoint-ORIG-GUID: H5WAW1fKuF5FwHOz76exrvs4jgNLoimk
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a341c8c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=9AdMxfjQAAAA:20
 a=EUspDBNiAAAA:8 a=_l2AY-rO-Bj6gyqKvEcA:9 a=uG9DUKGECoFWVXl0Dc02:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: H5WAW1fKuF5FwHOz76exrvs4jgNLoimk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE1MiBTYWx0ZWRfX7sA1neGb8nwU
 MVasDm3kDUwZG7BaoU2gmB5e1vzk65O+yKSOyYC/Tlo5rz7gxsbmjGSv3y2EjgG3coVohwoK8yw
 6KM1gwkHEFs57rKz5Ee8FuFUtAgR1LQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180152
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

The driver reads ownership registers from the wrong address for V5.
The ownership table is at offset 0x700 from spmi_cnfg base, not 0x0.
This causes incorrect peripheral ownership detection and potential
access violations.

Add the missing 0x700 offset to match the kernel driver [1]

[1] https://github.com/torvalds/linux/blob/4b99990cdf9560e8a071640baf19f312e6ae02f4/drivers/spmi/spmi-pmic-arb.c#L1737

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/spmi/spmi-msm.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index b89dd0b406b..a665850cd65 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -260,11 +260,21 @@ static struct dm_spmi_ops msm_spmi_ops = {
 static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
 				    uint8_t slave_id, uint8_t pid)
 {
-	/* Mark channels read-only when from different owner */
-	uint32_t cnfg = readl(priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i));
-	uint8_t owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
-	bool prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
-	uint32_t prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
+	phys_addr_t owner_addr;
+	uint32_t cnfg;
+	uint8_t owner;
+	bool prev_valid;
+	uint32_t prev_read_only;
+
+	if (priv->arb_ver == V5)
+		owner_addr = priv->spmi_cnfg + 0x700 + ARB_CHANNEL_OFFSET(i);
+	else /* V7 */
+		owner_addr = priv->spmi_cnfg + ARB_CHANNEL_OFFSET(i);
+
+	cnfg = readl(owner_addr);
+	owner = SPMI_OWNERSHIP_PERIPH2OWNER(cnfg);
+	prev_valid = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_VALID;
+	prev_read_only = priv->channel_map[slave_id][pid] & SPMI_CHANNEL_READ_ONLY;
 
 	if (!prev_valid) {
 		/* First PPID mapping */
-- 
2.34.1

