Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A582F88092
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A660684206;
	Thu, 16 Apr 2026 09:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cG1TFVhr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U0yJYHwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51179841D5; Thu, 16 Apr 2026 09:03:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1058F84201
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G4TvF11554426
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QBoDv6QJK6d
 aOftuHlCid1YB4lmL83N0uWw/Zsq3n1Y=; b=cG1TFVhrDlK417OKpxcIuwEKWCJ
 DXcQDrl+Mg1Dt2hM64wTSJzK5F9n02vw06BJZZIr2vROWedKHjlSVCp2gLRrOk01
 IOqkSAoNST4NP3OEj/tBA6JJJlBU2Jhc5pVUVkbZSEqxSgNc4hoDjvgn6+bRMjBm
 spanLaUkhAxUianugS2AmO3RRvb1FZ50TDRLQXX02/26fUpkFQcU9Z3xERl/lBaz
 QV9wTBZNVBgaZe3iL5SfvBlzcLtbgMCkwo2HpOAxeyO13EeemSFWXnHgjUvxswvp
 v3APcK/n5k4F02wpcZnrNwuigqa6+oXvM5MndBZlczGJ++k6JF7kXOGu56Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djrsn8fbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:03:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4654f9bb6so43951445ad.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776323029; x=1776927829; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBoDv6QJK6daOftuHlCid1YB4lmL83N0uWw/Zsq3n1Y=;
 b=U0yJYHwWciIwTMlbFJJQV2uN6b3zK90jogZBoBgtfu+PsLL+O7Fe7XS7ZwrtgnRDRT
 kP0dCp7o71b+aVajDDYrinMprpppSchUPx7g3BpaAlj+8hRXwXz7PMmQ5XaoGZzlAGov
 AHO6D8/mkyKsFiOQYvt5hSaWisRkNmapCr2JxOen3l5TPvkPfoJZ/M2jNW8B0ponS0Kk
 P3BrofABAfwckl+EViekge8rLEqbAwTSlk+9OPzboAUEl0gd42sCaU2ZFGO/X0uEPXmj
 tuktXQVYCq6oNIBAqq3bJ0++IiUyYDvHLdX43eEHpNQryAe7klo8yFDFMDVAdUo5rYKp
 rvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323029; x=1776927829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QBoDv6QJK6daOftuHlCid1YB4lmL83N0uWw/Zsq3n1Y=;
 b=F1OxJdQPiABWKPBQHcq62JtbiGmuJo+pTg9yw0o95gZY5otVl7nVi3mdDfU/6VrBMK
 QVN04VKYafhatRsfsLAMoSDtGrF9qunzn6bv6zXDwSYyMdGFxtQ5vwnHWeEWCCxg4uRS
 H8gOXACgTp5H/B/ro8ygtVm4UMlLhUCRGpL2pQ8VT4HUqBNAaZO3UWVejFlPOPA2ecUE
 +m5sa90UPTyk8INKdZycGtUe6T5QYW3/XazcM8xIrvPTtHztO1nIGKzlwh8jmje3GKOd
 KktEiNX7V1fiBqhLvExUIMHH2mRrIX20VSwVsVGncoYTrCY13p1W67E1sCanVjZxCAKh
 PreQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9tDngmsFUgmu98XO9bvV6ALZCgPzNFSu0vOACY6YlMXa+deAfiqJOLDhk1aG7uFVim2ZSVfhE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3tAuOPolu9218GaFIX6BpCQOrfNGt1hlBFFyByZ/eSD757PgC
 l7al3Bprm3lSqJxTFwXyRoRuEDJ3iBO4OjvSt7iE1L4S9JFnhDniHFDvXnFeDJobyRvNUQo8GPO
 vUsvO36sseEiasuWE75k5D+L8ivTTj89rOrKgU+mUboYTPrZ0I8hJpo+b
X-Gm-Gg: AeBDiesigyLX6C3AU9eSk7KGUQJbs9I7Bpi48TJz0KphHsa0QmSQR7IRqsL9yxwivKv
 OsKOkagBc1AYZxPqOrRLyoGKYAmtqB5MMWdwYX26gm9VrtEDpV3DgNU6LOO4GVBjnCY8wtJBx0q
 3NR908iNZ1KBoRTDRVB3T0qqoqzXJL1YAMIwGLBmFyDA3vLq+Q0u1/xmKZltdjhwX4Q7wM93xkN
 8JGRdRCkt3rkOsX+cXMwFVhepLbfa6ShnvNpvLaQLYNjZzZ0BMNF4Rxq/3jVSAm1UfcA+9FddSE
 cgYH5BBySs6osBIlt4Ihnw6nCAsN1We4yGq65vrqncNxQmBiglIw4JPzKCkeN2vPtGRHNUVKz7i
 R9y1xglraAyzOEFoF5TyNTx3M1mcunsP2WnE2WnDER4Ksmn/tsNQek8KuZJX8RReZ5a7VLPOlCn
 lJMEQW4XJCfld7cuLb+k7zm5mFq36F3mIldLB4l7qvh4viYInVn3o=
X-Received: by 2002:a17:902:cf12:b0:2b0:6df2:8cd2 with SMTP id
 d9443c01a7336-2b2d59b92a5mr250875985ad.19.1776323029418; 
 Thu, 16 Apr 2026 00:03:49 -0700 (PDT)
X-Received: by 2002:a17:902:cf12:b0:2b0:6df2:8cd2 with SMTP id
 d9443c01a7336-2b2d59b92a5mr250872115ad.19.1776323023603; 
 Thu, 16 Apr 2026 00:03:43 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b1174sm54195255ad.70.2026.04.16.00.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:03:43 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, aswin.murugan@oss.qualcomm.com,
 simon.glass@canonical.com, tien.fong.chee@altera.com,
 michal.simek@amd.com, visitorckw@gmail.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v7 1/5] arm: psci: Add API to check for support of specific
 PSCI function
Date: Thu, 16 Apr 2026 12:33:26 +0530
Message-Id: <20260416070330.3006528-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416070330.3006528-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ONoZDzZPkPJWPfE-UV54yhGRhFoN7psf
X-Proofpoint-GUID: ONoZDzZPkPJWPfE-UV54yhGRhFoN7psf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA2NCBTYWx0ZWRfX/zFQsKIENx8U
 WgWsrQjjOiYP+Icq6MZuG5yqEiMz2+Sjxr9IvOkq6zoJp4E4dqaRW4+PU1YM7cVqVw2r8OIsAhq
 p3dUvaIqcfPPIvB5DYQP9wrV8ej7EZZj1mavqbdzSVLbeWfrfJUDDuyVHXZ7WCtPGXpDIEMipsu
 3/1A9Aih30bQPqneCl4VjaFbpbavKJ9fQn+pwXenAb2OqDx3YvrImjvk0CF0O0K7N1lc2rgQ+2p
 pw6LePWgb5Izc+B7JV2rhQMNs/Im6+0SbvybltTOw15yIyexi7Iejt6n5v0q7EY5UWtgef536Wy
 blAHNQTdJl0bJ4mBbSJNhFkw4YhQvS1cSnS/dRlMSDpCMxamSNvfP/mQO11POpIsK/w7YtXWywx
 ODJHVvzXdDDJuCmN6nMPv5jZtiNBk9Y6+mDRJEHIKrYZ+ICdaJg116JQF/0toUENLL61clXdmeb
 KbtVM0P0tdMPx9UTwrg==
X-Authority-Analysis: v=2.4 cv=EojiaycA c=1 sm=1 tr=0 ts=69e089d6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=B_h1StgqK4FeiTQRNJUA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160064
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

Add an API to check if a specific PSCI function is supported or not.
This is based on the psci_features() function present in Linux kernel
(drivers/firmware/psci/psci.c).

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/cpu/armv8/fwcall.c   | 15 +++++++++++++++
 arch/arm/include/asm/system.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/cpu/armv8/fwcall.c b/arch/arm/cpu/armv8/fwcall.c
index 87de09979b1..f834d770dd6 100644
--- a/arch/arm/cpu/armv8/fwcall.c
+++ b/arch/arm/cpu/armv8/fwcall.c
@@ -129,3 +129,18 @@ void __noreturn psci_system_off(void)
 	while (1)
 		;
 }
+
+int psci_features(u32 psci_func_id)
+{
+	struct pt_regs regs;
+
+	regs.regs[0] = ARM_PSCI_1_0_FN_PSCI_FEATURES;
+	regs.regs[1] = psci_func_id;
+
+	if (use_smc_for_psci)
+		smc_call(&regs);
+	else
+		hvc_call(&regs);
+
+	return regs.regs[0];
+}
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 9e3ad57073d..5ed6833c155 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -342,6 +342,7 @@ void smc_call(struct pt_regs *args);
 void __noreturn psci_system_reset(void);
 void __noreturn psci_system_reset2(u32 reset_level, u32 cookie);
 void __noreturn psci_system_off(void);
+int psci_features(u32 psci_func_id);
 
 #ifdef CONFIG_ARMV8_PSCI
 extern char __secure_start[];
-- 
2.34.1

