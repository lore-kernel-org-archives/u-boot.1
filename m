Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E5D0C84A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37839835FD;
	Tue, 13 Jan 2026 11:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbCz3Zyn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Plkg4GjH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8B683678; Tue, 13 Jan 2026 11:38:56 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31607835FD
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D536PH2865791
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p+VggjjGNK8
 pe/+y3zZSrSqthDftyfFb0OWGnbIKg6o=; b=FbCz3ZynjOLWJ7Lf5GnqcwF/K0B
 FKmJp+lsp6lsekE00NdG3b0sh5sPHbdFYXgb5exwg/HrzPsO6rEymS/d29V57JWZ
 1Qu3Wx5SqeBvD/Ia9sF6c1Ft2hzz9XJw+ceZpV2NBGFOghX5DqwcGS3UstDP/A7X
 T6whAGaJtIJuopweNv4uxPsvQAfG7WGUgKBK4WuHp/gjNTY+Tp9I2YNixnzxS645
 4RaiQItS+To08xxtHLuIU2slirTzCqYaAhyODJoqy24vlOcM6ujbqoq4ta9O1ctc
 CZPsxWeQdFNCZd5MMtxiCs9u2PQH7AIHYt/a7FjFWbYl6DC7awQ1Z3K6new==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnfjh924x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:38:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a09845b7faso56142865ad.3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300732; x=1768905532; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p+VggjjGNK8pe/+y3zZSrSqthDftyfFb0OWGnbIKg6o=;
 b=Plkg4GjHbU7aTnrJbG0zvV1wtWPmuuIwg8QHglBY+wLpfFkQ9NkzlghNw2mP4RIkyv
 J3VTt53fId7RgbVAa+fuWDPNy7wbHXFibZ9TOxwkiq7Jyq2HFopjWiwSDc16GXKDeKQn
 kussH8qWj6ffoOiu+B6JxjmskEZw82iiUTl1T3xbA8umEEMpiNMu7zLi9K33EqVJ9pwv
 TpcF5DvV91KeEzQW4BRXxdMqyThWsR8Wnx/d80mtK/ikRg1bCSzvGk2HAJyBu7drS3T3
 uMEBHTnJR8+xoWF670t+ZB+5MnPBuPOcSL6bWXKL4ZFu4F1JVpLEnpaOSYB6AjbUr3/V
 YBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300732; x=1768905532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p+VggjjGNK8pe/+y3zZSrSqthDftyfFb0OWGnbIKg6o=;
 b=u/fV4YCVyV+wGHCDb1hvWpJejIGe7PY31QnUfaiDyDUN8wKVlj+mFYh5aXzEHep8m9
 N3HPG68nJkCW3JSMP47wxYaILoR0TSCo03BzD4O76faDBk6ldLB2ifp4AWUwfcDMDTNh
 6PX95JkZ+KWrb0dndm5kRnvT0HXjUM74Ay1Jl+7MdoS82Ig/woXnhmdq4XdebO0o2Uhb
 48OM7cpbrU4R45Tn+DNjoxwzK1hzfWMJphM1jAr8oJN/9shNjEKNZXdMUQSaNMvJnSeu
 EQuZTzG36gADDgozEuyu7CccFIdPUH2+hKZ1rmQmWL3OpuzjtyzHFUdGINnC2cBtFopI
 3Ggg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHuYxWoql0niVU+OTqjwKSabYGIlfoHk6i57LMRxtfT+wrqzWO2ImRqn55lwPMHBgFfByL+7o=@lists.denx.de
X-Gm-Message-State: AOJu0YzuFyemdMhH75424jF9Oy3cxw76jSrkTaZpujMiq1rnd2FtQikl
 j7Wqv2Y7pZE3vmAtRmo9fqapCscir0LteiRLtbNuca7DHXu3kr9AhM7yWA7VtW+Rmt6LBcTbrFV
 GaN3UAb/wq7zg6jpy29EDvBbqHXSZKsZwo+/tJLc0j5LzhAZ2JN2I1M7z
X-Gm-Gg: AY/fxX4ajNVIFZztsds3IRwYcfWD1e0H8q0mYjYZ4juz+0R2TXvhE7vWtewOm5rweFv
 6tD4KcwHAclzLAQmgBDbmHbRkiZ6bN/WPUh78JARCFCYqMORXDn/QGB8/ZZdzOwWrszbB3ZXWh7
 sra32N/g42gmoCYrAiiOybcIGjc7IYGW7YpgwTFpyAMD1I+LDaQeiB+suhOVkEvW2ONpGDSCH73
 shoubhluaSPgFBgMedOjbh0nCpKU2/yA3akg2tEvLfHEBU5Lgv9PwueKMF1A6hMXVVjhCBnE4iW
 fsH3CYo6QzOV9JsZ/KAU9LxPbrplQNPTUJ3pyDRrQKstSl5pZXJyJkbuLmc9tCG16tfeFpdpxJx
 +oCs1WHHgJgPjAPg3/bfeiYIQsFSEX+4fpNpztJOd9IAnBjwh4CWOe8nQ3WRgnDoic1ptWS0dvr
 VQGmmJYxbLM8K+TJrxdammewUZcWEuI0M/3czTbgE=
X-Received: by 2002:a17:903:41ce:b0:2a2:acc5:7a42 with SMTP id
 d9443c01a7336-2a3ee4dcbe0mr201466895ad.48.1768300731628; 
 Tue, 13 Jan 2026 02:38:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLFz6VBimc6Yh+QOXmBlh1tmtlVD7yx6bQUxlmeHIn8bj2VUE75R4IWl2YAqV40F625ixKig==
X-Received: by 2002:a17:903:41ce:b0:2a2:acc5:7a42 with SMTP id
 d9443c01a7336-2a3ee4dcbe0mr201466735ad.48.1768300731175; 
 Tue, 13 Jan 2026 02:38:51 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm195286965ad.47.2026.01.13.02.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:38:50 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, christopher.obbard@linaro.org,
 me@samcday.com, michal.simek@amd.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 1/5] arm: psci: Add API to check for support of specific
 PSCI function
Date: Tue, 13 Jan 2026 16:08:36 +0530
Message-Id: <20260113103840.1948029-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MCBTYWx0ZWRfX0rBZJh/OtLH/
 h5tPDnpCp5/L5EJ9CugbrbAi+hrNjSWY9Hqke+pyeu0xy2iIW2k7/1VaMJcOnKoPSWzJ4k+A/oy
 zvV2e+hJ9dFVsCjk6GBZo2/St7DUfNBxTZbHTvcCwMvy6W91C3z2TnjHKggBG0tOuwWXVcZNoQW
 Q6Qkzi7lAVH6WEz+dLoBjaJaAuKKtbud0Yk9gtpHJkiMOu+2WQjoIQAh9rno2onVDOsfI8Ew24N
 CuLO+TYV7vGQWEVyC8FDurvzEh6UMi18VeaVv/sCn1bddySRJJ1BMW8DDaEt8jGudks0+y78B2G
 FKMwsj6GrI3IlKBxbpGftBzVoDly5kQNsLqgUCoQOzgDitO2BCFZtOo2BBJagiAX6wQz7PTWIFH
 vyE++hdmXGej8PPTAhvfDGUAhao9RGDaG6Mfr+7nGTjHS72P/uZDS6PYnG3aS0xwxgfqp9C4dh2
 JzhSsMkb3HcJBasYZNA==
X-Proofpoint-GUID: XCNWXPGSDmc6tjIIhWAnJrFxmW0w60TC
X-Proofpoint-ORIG-GUID: XCNWXPGSDmc6tjIIhWAnJrFxmW0w60TC
X-Authority-Analysis: v=2.4 cv=XJQ9iAhE c=1 sm=1 tr=0 ts=696620bc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=B_h1StgqK4FeiTQRNJUA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130090
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

