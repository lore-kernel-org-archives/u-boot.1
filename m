Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7550FD262B2
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285FF8341A;
	Wed, 21 Jan 2026 07:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ex0GhU5S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNHXdyoB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 652BE83A2D; Wed, 21 Jan 2026 07:39:37 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CD582A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60L4XfEQ3230794
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zeyeEuV31wl
 aWPNxOQ9K07vuz2RkeYVrVnkvNlk2dgA=; b=ex0GhU5SSmtVye0mBz8BWMRS+wp
 1BSYKQr5CyZcpEn9d2UquOSSesJzLZ1MiRbQ6E2jfXgp7pc4POH0WvFc3ESgCKeH
 fzMgCqBJtjJyjUkcOFwzAEYqi1wGRQ1XdDI0rRuhgi4yncNPQnzLKWuG3PNIJ2Xc
 MZAOe+px2fudkq6tyJr3NCiECAbiUFVdlSdg3sSrZv2gsUxFRdoYbApIKR8CZEUQ
 VNXCXZ0ovbuSGVRa90z8foqxkNfxlW8QLFmPdkB1OUpKg2ujKzcfNlXjZ5jRQEr5
 HLBa1KS+r0gx1d8YKQuCNitS53o+t6NMNR60ER0e0WqRMjgd7gl6N/xBJNw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btqvp8b4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:39:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a784b2234dso21826525ad.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 22:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768977573; x=1769582373; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeyeEuV31wlaWPNxOQ9K07vuz2RkeYVrVnkvNlk2dgA=;
 b=UNHXdyoBqfcnpUJt5HM3GLgwFyrqnlhWxbblupyQHDgpTL9rx38OWARKunLng8qqr5
 i8EsXkpHXCIGJRc9kYklHtPyK/0t/yptF8VANtUG+1VAHVdn8ZrVhWucQ8KgczYrU8+d
 zXfm0p2FCmHNG2b0RqtfrZTYiU9VqZStwp6kMTCVpGoH7cYkuhwPPrZqk+gfNvg+lVvF
 BEny/joNR1e5gFO2dmCFPn1adUwnccL188AlAxK/FHUcSCRtm+RLv6cUaDD9qKIQlaNm
 6Ne0Jfsrln8aHcN/SWafNjAlGV41X0L0eF5M36/C6CKoKjc/ot8lvxfQycT0lfIlMTcK
 Jq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977573; x=1769582373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zeyeEuV31wlaWPNxOQ9K07vuz2RkeYVrVnkvNlk2dgA=;
 b=PmtPvFlj7h4BqKCrM/mqj5+iHkj9RI1WfeuqTop4/NiKE3UNIBG6Sc98dP2E1Jm2nj
 DbyQYU7DVHRDMqkT47X2P+XHe1lPMvOpgWDaASYbm+8pImrVw6fGlPP8kM5hEO909Mdt
 R91fpiQvSyzyVaiZ+gAnZp0G7huHzi/VrsdRlywYZ/gcTiPkgwOqjZFFDOu4hKmzPzbY
 ufuHNz6fO7V5CC8/nicrdUaLAa0vqZZfx8NQ8ZXeDNZTiO/Hxa5iJyK0TM2l/f5clEHj
 PVEYH16XROaCvLqP1oxZX6gOxDZvsEwzxywOssxJDNzR5Dnh4VUoNAKyYYsKA8m1tZ3r
 xvUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9SNunBAJEeVD+egoH5ZRCZgobknWymBhj3IwoKGv2oGetD3TGL4nydrfq0sMdfiTEwGratvk=@lists.denx.de
X-Gm-Message-State: AOJu0YyUmbrtH1qYNkqympvHuA9Rrr2MWAIT05ddU6XYvcmHTK4BBhSK
 45iOlOkrd5IzvnqPkwCdyc/hZi11+0BD2Okr2kSpnblUBwriFY6LQR9Dw+QBNzpbusiVPE30zM+
 ZT0bMmXfP6PbUcI0IZh9vG3grd1R67TU/aLx1neZYNARwmLcaNYNiyUvo
X-Gm-Gg: AZuq6aLFxM26JrHmNN1MA3RrVPIFSeYRO1sRzID0q1O+wtoRiPU1xMj1aK7T9Yq5jPb
 mhKk19oH75fv5zO+PplWM6oFluPCBn9+KkrRcdMig4br8pNdSXzIBpZp5KHRwUIgeZZiEhK1amy
 brUYpmaDjFWNOrr8tgPT5CCzTWPlo5irsmSD3aTCbuVIh+e8Q/tLYLHtRfFpbsgr0KKHZxYrwFW
 JcG8AJRgIuHlsTzBH8+i+nCId3pFJPc0cJ6hPON3yliHbIX8zYKfii1zKozmO6oag3AA4L+oeGD
 JjjN6BuHrtsjFNWq4zwdmDVOnbwBfp0aKT3QxFDbOu4s8IOBXOSbBLW7zttGBdjlDHcj+PnFXGq
 q7mgSXZTYdxyLPtliTjR4nyWBOmiTtf6mX1T0nptEU/QPK2wk9U2TcMHw4MAYP2OsD74HnYefiE
 Vxe4NP87fH8jKn0NjwbSIBK2vvuqMxlLuCfBwRdUU=
X-Received: by 2002:a17:903:1a2c:b0:2a0:d5bf:b271 with SMTP id
 d9443c01a7336-2a76ad5bf2bmr38897005ad.32.1768977572673; 
 Tue, 20 Jan 2026 22:39:32 -0800 (PST)
X-Received: by 2002:a17:903:1a2c:b0:2a0:d5bf:b271 with SMTP id
 d9443c01a7336-2a76ad5bf2bmr38896815ad.32.1768977572200; 
 Tue, 20 Jan 2026 22:39:32 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193fc8d9sm141392315ad.79.2026.01.20.22.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 22:39:31 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v6 1/5] arm: psci: Add API to check for support of specific
 PSCI function
Date: Wed, 21 Jan 2026 12:09:16 +0530
Message-Id: <20260121063920.1500293-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qp_hAamQAv5zq8El8CYMUPtayOBUL3gp
X-Proofpoint-ORIG-GUID: qp_hAamQAv5zq8El8CYMUPtayOBUL3gp
X-Authority-Analysis: v=2.4 cv=cdPfb3DM c=1 sm=1 tr=0 ts=697074a5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=B_h1StgqK4FeiTQRNJUA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfX+XuckjFDyBef
 jBAC7fufaKlfZZ3Wte8Y2jmytpWReTfmw6N0GDkzfXI9ZlGc2RcB/WqpiBqSCg1LH8UsQfjiJWo
 ljHQ9xX5WLveeY1cxKTI9DPXs+u5WTAgKjsMbqNEu47F06E0qtZ0wf5wvu0FTSjtb/2QgkBcQpF
 cMAtQBZSn7kVqjTXrUqYcheff8Vfl2vey3ykHlzrKTzfgpVuzbythO6ZgdFgD+ge72WKNz9XC6B
 LX/q2KT9mjqHiD/8e4jzSwhEX0FbBxHuK3ff5v3XC6sK2Qicj3dxNciGiFmD1izjoIf3F+KovCG
 DvUkJP75XUeTSOcfbQ69CISB52D4kpKIX143ZkngTmfFQvV2pqqyg6J1B1vZI8LQpgeESnqyd+j
 WENcBcoLITS+ZUU8njQiBOFYPIq0X1P/hVk6BQOtICaswuNdozVSca5xGWuJSsSugrj6l5S0JA/
 FJyCVWgXyl9pZ1v/ipA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053
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
index 4c1b81483c9..0b788bcf0e5 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -336,6 +336,7 @@ void smc_call(struct pt_regs *args);
 void __noreturn psci_system_reset(void);
 void __noreturn psci_system_reset2(u32 reset_level, u32 cookie);
 void __noreturn psci_system_off(void);
+int psci_features(u32 psci_func_id);
 
 #ifdef CONFIG_ARMV8_PSCI
 extern char __secure_start[];
-- 
2.34.1

