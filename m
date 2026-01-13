Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD28D2D0E0
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 11:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 794C883693;
	Tue, 13 Jan 2026 12:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8l4PzX6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TImeCock";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF4B83885; Tue, 13 Jan 2026 12:54:43 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A36682B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 12:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60DBDcfj4164893
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bWedJJB9w4l
 xBWdzr7jKX7v0Mtk4waqiEIWqrTajtqQ=; b=Z8l4PzX6nThVhA9oW5HqISTCp9F
 C1BY1nJZ8yzCCThLBc54wrVtyjTiDf4yGGflvb3NUImQZ5o+h7IwBOYNehAScKnN
 qVtrEPdRL7CuIrMikalJsxlOJDBSHbncI6cpMUcR65pGrE6TKCs7rHnKBm5dSclr
 YPpkvZ0+mXrHKjYPGyXa/eIjv8sqW614BQA5HXhyumkUuF8CNegW6K3xaFSx9s3S
 C0x+mvPlop/yV3x9XwCPDJv24oqjPHcoC5bZCqzVuGgtX3nI5N+TvlHtvfut0T46
 0wmmYPtAe0hUdIkR073/lSgnYJYhco0nQwjRpVCoTq/QHp5fGXwSZq69khQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnn06r3fd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:54:39 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-bce224720d8so5366371a12.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 03:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768305279; x=1768910079; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bWedJJB9w4lxBWdzr7jKX7v0Mtk4waqiEIWqrTajtqQ=;
 b=TImeCockgd4fXwhRDIX2Ng9f2KAwNUu198fx4YBvgSRYPzKk+mAcdzxT4juTkdBnJE
 yQnVe4xQIP92Udd20n+KqF9S2lwxlPJ2k5W6iTTJHdMLiuZHnHTxlPGEEQqmk16Q9cHQ
 xGOjJXghfqzYyukU08lMee26iMKY5BVpDGLYqFj6ZlVIaDEKJVOiuuvh7tSsFzER6bRP
 M+wCmwYZLAgQU9CsRNa3wwrcgd1SnpX25LZZYDUWADdSjOcqDAjoerNMFqeTo5K+GUeN
 RnTFzLDSLcaUuZfuX75fu7AhNgDgCQ3j7kzJ5aFCRR9q5I7hIkUBS2LIoUXUq8QVWltH
 TjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305279; x=1768910079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bWedJJB9w4lxBWdzr7jKX7v0Mtk4waqiEIWqrTajtqQ=;
 b=glx0IZhDFzeJ0RWQM9xldiCHog51uUijixUKK0saIf12nJlcPPZev0SFnTf2Mx/iDn
 G6wvAFIarlh2YlMieQQM8ISdzagUESPqdta8FqgPCE++PAJxyzAhVIYzBHq1FqgTopXc
 sk4Rpnq1N9pyuV4koCm2zoeIIbA+cpAH9WAR0GQy++9Lus09FhLlX2SIEScUFYlqSTZz
 hdRK0hdYUmjZPA0SMWW8a7A+flBBABi7qsi8LggX6Q1gtyfpUAwaQuLjqSNpCyLcVDnC
 AOD4s3iXj1tW6pbXbdzIt6y1R0xiqOLxf4E8L43sL3InyOpMEyBjuCzmIol/h5rMjTK3
 lOcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXRyXg/oRbiJmgJg9NnUggufbDO21FrUT5kOx3FrWwzV5igYnzzQTNlE03wMshPNnL0gLyLFI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywml5DwjfPo/wLXvkNhqcgaEc85Y1B00FSdzOgAJd21r3WxKEkD
 mSUVhuBiUHdcJFs16dmCSSdxzhrDpQIrOsJ+a5KQZ1dcrrtKhgmBXwqIBhX1lSuvw7A2L2HjMDq
 kmytvlBpG3K6sy1fgj7LRxO95zFHkZwOViph9XbA4Zl/ra1i5RChsquJP
X-Gm-Gg: AY/fxX5fP2lBJeJfEnQ86sNAdy/woL7brABTL2u8SO7OeibiAsaf7U6j31QONG2Ot4S
 MTswM0jnp1RV8nX1Tc9Miqxz4SKycnSAix2u5/WNP6McDfZShvNFJ8n8KTfQRESXLUV+udk0MwL
 dUvZRSlDJfDzE010wWgCjbnoA2ZDmtBFy52wlXb4k9J9FOFEYYyRfsf+1MkaL8ZYC6aPWUc82SQ
 ZeFAozZ3Qo5jyZjUtWf1AcqOGhG2kdU8sClvX/5XiFnMN1uCoAV+tf3qbj72mFfWPQlMmss6siR
 u1wWJXV1tgGyB34aq8fGV1QpHVwxHxAFY8+UnTM4LSbZycWSfiDywFOEaaRmM+6Apv3902N0OUt
 LaWCHrVM9qm5LVJzHDuWZi2H7xHKWegBEek7rcNEpfKpETJaJv1/hoIgmO3CPcJcYvLEduhXpMg
 DjEZY1i8YXXJh3pletyw3wZIkSuDyM
X-Received: by 2002:a05:6a20:a11e:b0:366:14af:9bbd with SMTP id
 adf61e73a8af0-3898fa11762mr20015523637.71.1768305278533; 
 Tue, 13 Jan 2026 03:54:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEY9k6fLFWTho4MWjlgI/GmNqEKIlQNq8M+2l0+OOKgnAbTnbxheZVAJ+4LmUZIeICjWgZvYQ==
X-Received: by 2002:a05:6a20:a11e:b0:366:14af:9bbd with SMTP id
 adf61e73a8af0-3898fa11762mr20015496637.71.1768305278013; 
 Tue, 13 Jan 2026 03:54:38 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfc2f481sm19734073a12.10.2026.01.13.03.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:54:37 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 3/3] arm: snapdragon: Integrate OF_LIVE fixup handlers in
 ft_board_setup()
Date: Tue, 13 Jan 2026 17:24:04 +0530
Message-Id: <20260113115404.1448759-4-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
References: <20260113115404.1448759-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tmG79zv5q5paZrGnBpiupDC0kUQyu01g
X-Authority-Analysis: v=2.4 cv=ZODaWH7b c=1 sm=1 tr=0 ts=6966327f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dNq8-6AkJomuVFahDgcA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: tmG79zv5q5paZrGnBpiupDC0kUQyu01g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwMCBTYWx0ZWRfX09OYgGFwqEiv
 0Au0zZUAUnqV0f8pEs3JZeBGm2iFYsXuXKkJ39+r4oqTpMhlG2SRNv9ON3BXpXWUCj6M5vZLuWC
 oDVReWgoTPlIcWkzjO9tLadlzJaHDiu8rXIadSZNcu9tN06uWKpFaLZdxnA1Y2tPkvlAAHM1m1u
 w/sDh5MQvexBDaBrvZMcuexKpDt9XNSFhAFzzK8Gk1SXoG9Sl0hKojRjZffr48lpkRM0bzarBax
 ZHiq0d8UBlhl5qweAJBxjjezq87YDJKwoGL8lgslvhlV+kt+Ku9gkeC7VFegY1QtDT1vKxaA4Eg
 ttK4Q/NfA0iy5fWRfrzdquKzt0h5ATqCnZlk1zvgMJ8s07jiOOH4qC9LIhiw48RLbQSvEQpj5sN
 sisCUzpjZzfheqxHeXp6BT+ugkXfhCwUcwauoZAHVeIQKezIbwd6fGnxjdz72IzwRh/CJAZ7LKH
 jOixoNU9YxCEr1mUJRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130100
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

Integrate the device tree fixup handlers into ft_board_setup() to
enable runtime device tree modifications for Qualcomm Snapdragon
platforms.

This patch adds:

1. ft_board_setup() implementation
   - Calls all registered fixup handlers
   - Provides central point for device tree modifications
   - Executes before passing DT to kernel

2. soc_specific_fixups() function
   - Handles SoC-specific device tree modifications
   - Currently implements QCS615 MMC node disable
   - Extensible for future SoC-specific fixups

3. fixup_dt_node() utility function
   - Generic device tree node manipulation helper
   - Supports multiple operation types:
     * APPEND_PROP_U32/U64: Append 32/64-bit properties
     * SET_PROP_U32/U64/STRING: Set property values
     * ADD_SUBNODE: Add new device tree nodes
   - Automatically adjusts FDT size as needed

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/of_fixup.c | 114 ++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index eec2c0c757e..1a74db51cae 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -26,6 +26,7 @@
 #include <linux/errno.h>
 #include <stdlib.h>
 #include <time.h>
+#include "qcom_fixup_handlers.h"
 
 /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
  * USB controllers. Rather than requiring source level DT changes, we fix up
@@ -165,7 +166,120 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 
 EVENT_SPY_FULL(EVT_OF_LIVE_BUILT, qcom_of_fixup_nodes);
 
+/**
+ * soc_specific_fixups() - Apply SoC-specific device tree fixups
+ * @fdt: Pointer to the device tree
+ *
+ * This function applies SoC-specific fixups based on the device tree
+ * compatible string. Each SoC can have its own fixup logic.
+ */
+static void soc_specific_fixups(struct fdt_header *fdt)
+{
+	int ret;
+
+	/* QCS615-specific fixup: Disable MMC node */
+	if (fdt_node_check_compatible(fdt, 0, "qcom,qcs615") == 0) {
+		int path_offset;
+		char prop_val[] = "disabled";
+
+		path_offset = fdt_path_offset(fdt, "/soc@0/mmc@7c4000");
+		if (path_offset >= 0) {
+			ret = fixup_dt_node(fdt, path_offset, "status",
+					    (void *)prop_val, SET_PROP_STRING);
+			if (ret)
+				log_err("Failed to disable MMC node for QCS615: %d\n", ret);
+		}
+	}
+}
+
 int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
 {
+	struct fdt_header *fdt = blob;
+
+	/* Apply SoC-specific fixups */
+	soc_specific_fixups(fdt);
+
+	/* Call all common fixup handlers */
+	boardinfo_fixup_handler(fdt);
+	ddrinfo_fixup_handler(fdt);
+	subsetparts_fixup_handler(fdt);
+
 	return 0;
 }
+
+int fixup_dt_node(void *fdt_ptr, int node_offset,
+		  const char *property_name,
+		  void *property_value,
+		  enum fdt_fixup_type type)
+{
+	int ret;
+
+	if ((!fdt_ptr || node_offset < 0) ||
+	    (!property_value && type != ADD_SUBNODE))
+		return -1;
+
+	switch (type) {
+	case APPEND_PROP_U32:
+		fdt_set_totalsize(fdt_ptr,
+				  (fdt_totalsize(fdt_ptr)
+				  + sizeof(struct fdt_property)
+				  + strlen(property_name) + 3
+				  + sizeof(u32)));
+		ret = fdt_appendprop_u32(fdt_ptr, node_offset,
+					 property_name,
+					 *(u32 *)property_value);
+		break;
+	case APPEND_PROP_U64:
+		fdt_set_totalsize(fdt_ptr,
+				  (fdt_totalsize(fdt_ptr)
+				  + sizeof(struct fdt_property)
+				  + strlen(property_name) + 3
+				  + sizeof(u64)));
+		ret = fdt_appendprop_u64(fdt_ptr, node_offset,
+					 property_name,
+					 *(u64 *)property_value);
+		break;
+	case SET_PROP_U32:
+		fdt_set_totalsize(fdt_ptr,
+				  (fdt_totalsize(fdt_ptr)
+				  + sizeof(struct fdt_property)
+				  + strlen(property_name) + 3
+				  + sizeof(u32)));
+		ret = fdt_setprop_u32(fdt_ptr, node_offset,
+				      property_name,
+				      *(u32 *)property_value);
+		break;
+	case SET_PROP_U64:
+		fdt_set_totalsize(fdt_ptr,
+				  (fdt_totalsize(fdt_ptr)
+				  + sizeof(struct fdt_property)
+				  + strlen(property_name) + 3
+				  + sizeof(u64)));
+		ret = fdt_setprop_u64(fdt_ptr, node_offset,
+				      property_name,
+				      *(u64 *)property_value);
+		break;
+	case SET_PROP_STRING:
+		fdt_set_totalsize(fdt_ptr,
+				  (fdt_totalsize(fdt_ptr)
+				  + sizeof(struct fdt_property)
+				  + strlen(property_name) + 3
+				  + strlen((char *)property_value)));
+		ret = fdt_setprop_string(fdt_ptr, node_offset,
+					 property_name,
+					 (char *)property_value);
+		break;
+	case ADD_SUBNODE:
+		fdt_set_totalsize(fdt_ptr,
+				  (fdt_totalsize(fdt_ptr)
+				  + sizeof(struct fdt_property)
+				  + strlen(property_name) + 3));
+		ret = fdt_add_subnode(fdt_ptr, node_offset,
+				      property_name);
+		break;
+	default:
+		ret = -1;
+	}
+
+	return ret;
+}
-- 
2.34.1

