Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAF4CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7903849E5;
	Fri, 19 Jun 2026 13:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UK+Ne2+I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YivCGq0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788D5849E4; Fri, 19 Jun 2026 13:11:04 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8EE849CE
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JB7FZn557063
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qEa1WnDEW9MEwmwlmA2ju1lFsJpRaDV4KHuEUOv1eiw=; b=UK+Ne2+IeJRlQBU/
 y6DT7D00jd3rutkyH/PW2wUX/6wo/UD5ggLQjJ2wD1/2odhHlKBUad1EwUu9B3WJ
 b+zYcRiwEGJeXuVCeF7WdB58T588Mq5dr51DBp5AThyjzP9knAhSO6nOS6Ij+2iu
 OHkP7M/nDyaY2Jf/MnN57YoVCpW3MT5EQZZfs+1zC6m25Tis25vdZ8OPolGy8kW+
 5Eaz3QCDdBdycGZVYxAeyuZp7KrRuGxB7h9R2RbOBn0pJfYFCipZYtBx2EROWMAz
 N+47OpFww5Rk7vg7RtR8ju5lWU4nLAkH0+H4dNze/LDPS9sErnIgG7qhSkZ6TjB1
 //NN8Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evm22bpcn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:11:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso44302765ad.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867459; x=1782472259; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qEa1WnDEW9MEwmwlmA2ju1lFsJpRaDV4KHuEUOv1eiw=;
 b=YivCGq0x6+GyJi19V14B0R7wtVIhb4Eq4MKx6HyansBWtoLtW9zX33MPibCF/necB/
 aDu2HwhRR7uY/55L9dJHNF7pyuIcWk2IhOjffjfWfyXzGdFJSjAuLh2fcHswEqs371rc
 ZGeBp1oDB27g92yEtU7RqzhXwkbyHAdsYm7X9eAKhdaudxs1l/Myb1V2VamP3rQGO3GA
 hfcq1aAZzIHw2AB3p65U7fdBKv6YmG9tOBJSs2I56uL6H2MEt/JXLYwsiH/GWamnQ+FL
 jhhmL274+5qB6zkfRu+HgRYWACZ21HOn0rGDGz6rqfRz7puZTyGmBQJRxID7mTDRgk3u
 fAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867459; x=1782472259;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qEa1WnDEW9MEwmwlmA2ju1lFsJpRaDV4KHuEUOv1eiw=;
 b=aZJ+9y09hsA01lY0WBh859S+gl8D/1EefBUdGkyJlMZS0jlPKWLcO1QpvDkFFdtIgD
 TWzDKf+5Ud7HZC7fcwwgXwdyZxFwxngn5apEncLEy4vGRBj2n50p7AGATYSncISFNkrV
 rHba9qTbfMs+AhSnexQSbl4IjgLHnm/N6MFO/Oh346MSqwBp2kzS3LM0HOOh6DskjzPm
 Q+zyw7EIwM4nmmhJD5xrRQQS37mV2ykZEPKTPrA8htfi0161aE9KLEZ8FDMRT38IDciK
 AVhxOepyE7hNh9fmiENXpDdAiIq9gn6kDx/9H1rj5oBnj+hmCqNgWRI9nutEvUTZ39mA
 2iDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8C1A6Ju14lhuLC3y2nAFe4/gUpx9TVFZ3VhEc8RRX3rRpVd5cRAiWKJ/SWUobnIr4NZ1PmvnM=@lists.denx.de
X-Gm-Message-State: AOJu0YwIhmpxRdzD7uxc5XTT036fpgCWzQqLVMuFy71tPD6MzD9Goafv
 RVvSYnQH27AnYXNwpL2157WJJURyEN2epOYm20nYN+Mp1wxbuF0zURA9v9jesXDRUXZjZtG0xAm
 GszBchvR2wGWOK6XWKn5grixSkj3fPd7+nnGPW9o1fzsiwmQgJ3zGO0QS
X-Gm-Gg: AfdE7cnmgXbGri1HYIx+reGkAOmTh4FHwBWkMo71dvCHMNav4E/CSjWgObczNuxMikO
 s64CmMEWXWXv0NWMwdUmRtMwTXzOigK9qOUqP3ALHc8+/i9vF3XfsiTJWV/iAJYdq5LLLeOJr9B
 uWGlOuXz+H19advSqZgBv/JM604vtY1sfgp/8NeIlOh/cxRC8PckOvHEfPluFXBTRLPSeM5oLvF
 fTqlXygJ0l917+bDPrAxxMR+LyiBEQir+O88jktx5YVCYhvS1gABMJxOWDs8c3EfqrRJ324tQ61
 J0lN8Gvd2/RdXw4qpNbXqVy+whnJVQ4r49pLtrMSgD4CmnzTYepJUgzu6JzaBoBENvWEzUseG1m
 Nqd67+1CJNTDeeLS0nOyIxpsSGTzm2QNIEdAT6kH/TrZGHS5A1Zo7+f3ADnG7WbGYDGWt9k9kK4
 8MsElXcf3eVW6jaC0089tgN/8K1seh/02YJksz1Es=
X-Received: by 2002:a17:902:f610:b0:2c3:5683:9acb with SMTP id
 d9443c01a7336-2c718f98f0cmr40223075ad.32.1781867459224; 
 Fri, 19 Jun 2026 04:10:59 -0700 (PDT)
X-Received: by 2002:a17:902:f610:b0:2c3:5683:9acb with SMTP id
 d9443c01a7336-2c718f98f0cmr40222705ad.32.1781867458844; 
 Fri, 19 Jun 2026 04:10:58 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:10:58 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:26 +0530
Subject: [PATCH v4 3/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-3-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=1383;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=aIpmZ8K8GKIIxMZtjbJ7qIrAKvNzjeR9ao4qLgVjXf4=;
 b=GKP6olVUVi8vN/UIP/kwS7hAGkMhJu3mG2VTUBUfGma1vBu5Oul2JmzYb/+eOSveVRzY2W4Pt
 Yd/5S06QugUBHc36++XYIWOMqwzUUFiSWhf/6ZRIMVPyKyQf05NujXy
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=YN+vDxGx c=1 sm=1 tr=0 ts=6a3523c4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xAI3I7ZSbV2oIbCD5NEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: mMfW4s9JJG0rTHOdLKAf3JshoPIeFtlV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX0UL057UXsQb4
 IUtc89hXtXapD0VGCjfrs/Ln5OmdBNCnOyjZFNBeWsVa1SP0e8fOOtGP77ypODfsVn3VjcUSIJm
 uG4exulhRW+jGb0yLQKuW3igpIRyav4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX4YlmdnyfjRC6
 uIOaFnMjac1xmIZvW2TYXHktm09e49g9Rdiss3RJsiPZo4NNVfDvpxNcYxiycxzmsv3e60mPphr
 Ay5SZM6YWDydfUsNTmUCxKSLM4EAdGWycfaKs4fovM3JUDxlmJyJLgN72pmfqFCfvSnRCf5dbfu
 RW84waqvKLdC0gmxiIO8Kdao6woxTDoECHduExFsvps26eeoiq0gkJT142Xt5aO8sYEQU9EjmNt
 prdE67wFppZjl8NrK8MTJrFzUMDTpWRPOqowr4wvwvLzbEjJZCjkp1UvBhKk5zLo3A20CJBxRQM
 CSw+cwpgitpXUCuJFV78YQOoB76rQjhgFTkI/SAB/xtuSFnuEKEGO931FCIgFCoAWKSci5p4tAU
 D9Vd4oCtNmza/a/MCTJjA3ptFk5nEgtI6rxqkpkXmlnuFMBtLQkTrFg7vrMysx0bxXwqxG1Hkze
 +k6TD5cL9fLEfuop36Q==
X-Proofpoint-ORIG-GUID: mMfW4s9JJG0rTHOdLKAf3JshoPIeFtlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190104
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

In snagboot mode, U-Boot is loaded directly by XBL without PSCI
firmware support. The functions show_psci_version() and
qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
CONFIG_ARM_SMCCC is disabled, causing build failures.

Hence, added CONFIG_ARM_SMCCC guards to both functions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- No changes

Changes in v3:
- Added CONFIG_ARM_SMCCC guards

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/board.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 4ef046942d8..6ad05998758 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -50,6 +50,9 @@ static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	/* Some older SoCs like MSM8916 don't always support PSCI */
@@ -73,6 +76,9 @@ static void qcom_psci_fixup(void *fdt)
 	int offset, ret;
 	struct arm_smccc_res res;
 
+	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
+		return;
+
 	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
 
 	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)

-- 
2.34.1

