Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCD1D29DE8
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806918352B;
	Tue, 13 Jan 2026 10:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7MczJnI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jzOJgcVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB64835FD; Tue, 13 Jan 2026 10:06:36 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A399C80077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D5nVr33735136
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QbNauAtnFCAjeEQXOX43OWIZFkB8KZ04VH7
 jL+2zmFU=; b=j7MczJnIMN0hUTVBwPQBE7PLeTrrf7NIbaWDh1qh6XPRePC0YIc
 iLKvzfZr40wbyjPV4bQXePiy0cGJbfjQo6G8tYXEjg0t+Diws96XB0bpbq1OJv6J
 dwart2goibYu3l4pFfJMvmabgLt9JghdY2qa1Vt0w7wEfvyPqISWndgfa7DyFSkF
 nKrG05hmW6IE2ihM1Nxnl3CN8MK59b/GrHM1NIvqSjNdhZhvm+KZertQdMN3eH8Y
 RP+lsfjpMFn1IqjpEi4s0w3rZQhPANAt8hEiilX+5Z8k0BPI4dS4CwBImYfv3kK+
 cDQp7xq5EmFD/xZMzJdqHWiUEvIEBL8I/5g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bng878j3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:06:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a377e15716so160731625ad.3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768295188; x=1768899988; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QbNauAtnFCAjeEQXOX43OWIZFkB8KZ04VH7jL+2zmFU=;
 b=jzOJgcVb0PC3a1U9a/Me9xaBBD8lXXVFFMfJpkOtSJO3oNe/qtZudN5MaH9t+LEoG8
 VWmSlcsJ9EOlL3A0UYvY92PGY0dHEyUA1PtO4tFbqY7WAEm3NOZ/hqNn6I2oD6vSmr/T
 Xe3X0GNbPybuxdB0cv0jCb08ZreUZtAP6kNPfqeBb+WzzjwIOZ7ui5er2nYxwrzFVB1O
 yMMFVs6KAO7o5nb4IaiQyIoFwukqaeTUZCUW1c1ZnsGrmF5Igl6BPFL5/Q/QM3Pdk69G
 moOr/Vvcj36YcWp9GWo+cTdmqRmJUXKNxIqyOEjyZIZ3Fh3dmvOnBg3fnKV1UYKyAKTC
 RmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768295188; x=1768899988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbNauAtnFCAjeEQXOX43OWIZFkB8KZ04VH7jL+2zmFU=;
 b=CAEeHTFvNCJu1qjrKpnHteLTBSYfcMFtCoAAIM9RsxGY/xSggu4Gqf+IxdMEUj6R8w
 O672vn4DP4lEJZJobR+EF7c+ryyxkD9qUH7CztciBx7BfG8VxtCtvOjxJZ8pxGfLyue9
 xrt/aO6wZ1L8U0pJpvFid2DjOg3c8OBJuEKeYb897fZ4AbhXT8/iqPZO5oER1Y1lJO1y
 DRbR12pL1KwqxKBThuEpuqjKrr+eVN3B/H8GBiiz0TIMpNjrnC/fkMsuwZB6UJ3ZvZ9R
 NqRFgWbPtby1Dj6hpeaBZ8g4Qy25Pz8KMN6TsNsiibI1kvz3IzmMguOxboA4EkgiAgO2
 bjVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHkrEQQ1Y+k1Vyr3h39p/GvAcQd/Rj0QPDUR1yOD7XFYOnyN2jO56WI/dwIUsB7zktA0QEU54=@lists.denx.de
X-Gm-Message-State: AOJu0YyRLSsPH1MQuZ1ZazL1guUMjwnQ+QBtKiqknXhs/a81YQJR9Lit
 CLcwmPBsGT3TpUbxSQVn21/Psy8i59nyADv5Gy6iCnbiLC/FFPOdJ2MOyHU8RVw6LaDD1EWnP3x
 7zxB4kuQfOz1SEvd1dZrg1l96x57GnKJAyCnsEXNAqC3goDEYp1vuFe6h
X-Gm-Gg: AY/fxX4ZhoBt1wivTztVOl/Vi902rjKqosVYQn8IqWVmkO1VsyeFha6xyYd7pkY2RS/
 HaT/uaqC3zF7eTrjOpH1CKZILsQ3/H8zbLX0wZLq9BwdManDKfgC6elG8pLxt4tmnzQ2EqRs7dl
 cZZUoL1DzT5pTDkJixpFGeQ2usauplg0LmyjgxE6gmjGg1wjiEGMKicRFvv7GiszW+ll1tpx6Ql
 eY6F4WFa8xrNZ76qjIuVZ2RUU+fkwdmYqawAWzgueWWIlouTc7nalDzf6QXitJ89IqF/Q6MdlzF
 CHvCQeMoCvP2FEbp/g6FqF7s6aIoTS6Iu/lBRUxdquZsCTBzA53dgWPy6J9TR7TUVv2IFp5HPJB
 VbLs3nBkxXErxHqmMyNXHvRrPcLKbS/QtjGZ6PlVwpHit5DDmADz+AbGS+mRTaJcF0yz2GNnmZH
 khLqdxJdTPHo7P8H5CjiUjdD92Ag6d+CL0p8W3nA==
X-Received: by 2002:a17:903:37d0:b0:295:543a:f7e3 with SMTP id
 d9443c01a7336-2a3ee458e26mr198357405ad.27.1768295187773; 
 Tue, 13 Jan 2026 01:06:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9l/MIq0IBgzlALiFuGYzAdqWX37aID93J7xv/+hYNusGpyV0OOaneh/yvZr8nsgQTpwx5Uw==
X-Received: by 2002:a17:903:37d0:b0:295:543a:f7e3 with SMTP id
 d9443c01a7336-2a3ee458e26mr198356805ad.27.1768295187161; 
 Tue, 13 Jan 2026 01:06:27 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2f8asm197714955ad.57.2026.01.13.01.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 01:06:26 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, balaji.selvanathan@oss.qualcomm.com,
 me@samcday.com, sughosh.ganu@linaro.org, gchan9527@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2] arm: dts: qcom: Add reserved memory regions and EFI memory
 mapping
Date: Tue, 13 Jan 2026 14:36:21 +0530
Message-Id: <20260113090621.3402096-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3NiBTYWx0ZWRfX+He/HoGK6wcQ
 T3qCFX45SZSCc1Bk+o8zQQftKTsIKbFcpl0sPCxL7nAzQ9PGjkChbIqjMRCwCtHgeraPmnTOn7m
 0F1D4qr6MKE+KT5ziMvw2aMKSy5Qyv1KgbShPtV9DdQhMGRWuWNL5ZHYSsP9lUXc9YBu/zFG6iF
 WmCJ3/kjDGDkrqoCUUpqPmLJbgKp9mmPvl0OAfuMdEoKM8bakOw2gHAxaCN4Boq6u1IgozXnmIJ
 kyRY4+eZ6W1ZQxgBIXXH4+t1b/6mDaepqe/N3Onev/73f0PJ2nkdoy1MIpvmZ16QTr6Ql4G5GU6
 O850AfDR6BxQ/ZaV0LbaxXtMj1uc4G3CReBeCFbbMnVIpR4BJtALtH64Qa4EgZjbgdl1lEmZZF/
 +hOrso8yuLHNNezxsftkgVyglyiwyk/7cflccqpBpXiJHTB1d4b1T7QJa0FoH2f66ArUmmsCFm8
 XclR7s7wXgaCYJgbCSw==
X-Proofpoint-ORIG-GUID: npsa05HLJq_BnwpKwOdtqmUDH35EbCax
X-Authority-Analysis: v=2.4 cv=IOEPywvG c=1 sm=1 tr=0 ts=69660b14 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cbjIQD_8dHH6LqlRK1AA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: npsa05HLJq_BnwpKwOdtqmUDH35EbCax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130076
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

Add reserved-memory nodes to QCS615 and QCS6490 device trees to
define platform-specific memory regions that should not be used by
the operating system.

Implement efi_add_known_memory() function in board.c code to
parse reserved-memory nodes from device tree and register them with
the EFI memory map. This ensures proper memory protection during EFI
boot and prevents conflicts with firmware-reserved regions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Instead of adding reserved region info in a new
  qcom_reserved_memory.c file, added the regions to reserved memory
  node in override dts.
- Link to v1: https://lore.kernel.org/u-boot/20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com/
---
 arch/arm/dts/qcs615-ride-u-boot.dtsi     | 56 +++++++++++++++++++++++
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 26 +++++++++++
 arch/arm/mach-snapdragon/board.c         | 58 ++++++++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
index 68fffc70fcb..ec607061ba0 100644
--- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
+++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
@@ -11,4 +11,60 @@
 		      <0x0 0xc0000000 0x0 0xc0000000>,
 		      <0x1 0x80000000 0x1 0x00000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: hyp@80000000 {
+			reg = <0x0 0x80000000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_boot_mem: xbl-boot@85d00000 {
+			reg = <0x0 0x85d00000 0x0 0x200000>;
+			no-map;
+		};
+
+		aop_mem: aop@85f00000 {
+			reg = <0x0 0x85f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		xbl_dt_mem: xbl-dt@85f40000 {
+			reg = <0x0 0x85f40000 0x0 0x30000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat@86200000 {
+			reg = <0x0 0x86200000 0x0 0x100000>;
+			no-map;
+		};
+
+		tags_mem: tags@86300000 {
+			reg = <0x0 0x86300000 0x0 0x1200000>;
+			no-map;
+		};
+
+		tz_mem: tz@87500000 {
+			reg = <0x0 0x87500000 0x0 0x500000>;
+			no-map;
+		};
+
+		tzapps_mem: tzapps@87a00000 {
+			reg = <0x0 0x87a00000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		pil_mem: pil@8ab00000 {
+			reg = <0x0 0x8ab00000 0x0 0xcc17000>;
+			no-map;
+		};
+
+		secure_dsp_mem: secure-dsp@a0000000 {
+			reg = <0x0 0xa0000000 0x0 0x1600000>;
+			no-map;
+		};
+	};
 };
diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
index 8d4871135fa..cf6de0036d5 100644
--- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
+++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
@@ -15,6 +15,32 @@
 		      <0 0xC3400000 0 0x3CC00000>,
 		      <1 0x00000000 1 0x00000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		axon_dma_mem: axon-dma@80600000 {
+			reg = <0x0 0x80600000 0x0 0x100000>;
+			no-map;
+		};
+
+		xbl_dt_mem: xbl-dt@80894000 {
+			reg = <0x0 0x80894000 0x0 0x40000>;
+			no-map;
+		};
+
+		pil_reserved_mem: pil-reserved@84300000 {
+			reg = <0x0 0x84300000 0x0 0x16b00000>;
+			no-map;
+		};
+
+		display_mem: display@e1000000 {
+			reg = <0x0 0xe1000000 0x0 0x2400000>;
+			no-map;
+		};
+	};
 };
 
 &usb_1 {
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..f32d29a9242 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -19,8 +19,10 @@
 #include <dm/uclass-internal.h>
 #include <dm/read.h>
 #include <power/regulator.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <fdtdec.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/bug.h>
@@ -709,6 +711,62 @@ static void carve_out_reserved_memory(void)
 	}
 }
 
+/**
+ * efi_add_known_memory() - Add platform-specific reserved memory to EFI map
+ *
+ * This function is called by the EFI memory initialization code to allow
+ * platforms to add their reserved memory regions to the EFI memory map.
+ * For Qualcomm platforms, this parses the reserved-memory nodes from the
+ * device tree and adds them to the EFI memory map.
+ */
+void efi_add_known_memory(void)
+{
+	ofnode parent, node;
+	fdt_addr_t addr;
+	fdt_size_t size;
+	const char *name;
+
+	if (!IS_ENABLED(CONFIG_EFI_LOADER))
+		return;
+
+	/* Parse reserved-memory nodes from device tree */
+	parent = ofnode_path("/reserved-memory");
+	if (!ofnode_valid(parent)) {
+		log_debug("No reserved-memory node found in device tree\n");
+		return;
+	}
+
+	log_debug("Adding reserved-memory regions to EFI memory map\n");
+
+	ofnode_for_each_subnode(node, parent) {
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		addr = ofnode_get_addr_size_index(node, 0, &size);
+		if (addr != FDT_ADDR_T_NONE) {
+			efi_status_t ret;
+
+			name = ofnode_get_name(node);
+			ret = efi_add_memory_map(addr, size,
+						 EFI_RESERVED_MEMORY_TYPE);
+
+			if (ret != EFI_SUCCESS) {
+				log_err("Failed to reserve %s (0x%llx-0x%llx): %lu\n",
+					name ? name : "unknown",
+					(unsigned long long)addr,
+					(unsigned long long)(addr + size),
+					ret & ~EFI_ERROR_MASK);
+			} else {
+				log_debug("Reserved %s: 0x%llx-0x%llx (%llu KB)\n",
+					  name ? name : "unknown",
+					  (unsigned long long)addr,
+					  (unsigned long long)(addr + size),
+					  (unsigned long long)(size / 1024));
+			}
+		}
+	}
+}
+
 /* This function open-codes setup_all_pgtables() so that we can
  * insert additional mappings *before* turning on the MMU.
  */
-- 
2.34.1

