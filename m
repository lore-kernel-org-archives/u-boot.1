Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8FFCD3425
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EAE83959;
	Wed, 12 Nov 2025 17:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b588QZcP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DAOw5ioY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C1DC83CF7; Wed, 12 Nov 2025 17:59:24 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B1E83952
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:59:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AC9ghta1109118
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=YTLR16W6Cjz2wlWRh5tlPv8eXVFp3QN/pFC
 bMA2icN4=; b=b588QZcPXozCpEm7q+lJtJF853F9I8GJS3LDLu/nia9LehqHUll
 IrQ8QL9Xb9s8BGK/A70MIyqkj8N9Hdce28Ds9pM9vjGNmY4cxPX6+YT17BCHLyhK
 ZXTVX7JhrFuoOSvqvwA8qYfN+99ffOEI6a61GqG3y3qPjYRCngQzGp+UYQHH/pY0
 IOiDfGep5qb8m47unB3t4yk64+09+1ODMm9jRiTcu0qXtVLXzm3tQhoFIg72c5LA
 9xJzdrr6AdGAAh8pXX7BT4IO8JsA8xNlOo/dAyOscNpTaBPN4yBc3vlPjQS93ASd
 57VEFgQQJvpPdEL3U5nFNcUiAOSjFFds9qg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqum19n2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:59:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso2120801a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1762966759; x=1763571559; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YTLR16W6Cjz2wlWRh5tlPv8eXVFp3QN/pFCbMA2icN4=;
 b=DAOw5ioYwQW5iHufLA9lnnfivuaI8Avjl8LO7wQ6H5HeqmApSoVFFi9FH2exo/x6Vu
 S3+jP+uY+HqTuMC+FlO+AByP6T9vJhH1B7azBdMAI0tJehHPgvOGim+xM9V574abJU42
 1p7vq3A4Ht6MPDoESXAOAFX9hY9FBgnHIHcp8KKIOvfEoD3rC0v75zKRnihNxyOozFUo
 v6VvffaC7jsN6nJps7Hxx+XHUa0QuHZWsHHRjtxmInc9e0+INy5iwb14Iv60tKYGn4BG
 8QbDZJOmMpmYhuuhbqrXq7Y4FrEcg6H4JNuA+t+rlHujDCzdszgVyzoUOTYn2zv84p2f
 wYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762966759; x=1763571559;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YTLR16W6Cjz2wlWRh5tlPv8eXVFp3QN/pFCbMA2icN4=;
 b=id7IZN+N682j8Zzp7HAETdQ4NhXvR8zAqK10pdkxguSF+ZtqlblCAM+RZtgLukqY9U
 Flwt6pTFlTW+i/cs39E3/O4RAWCGOasZ9oCgNxTp4kGKVlJwfUa9pFQYESJPvtL9exBS
 Hu9ynRQDBxU/5ODEmN9kzc9DHT2xXZQc4aKoxGfXCxMblR4UWzHcgobD9XyJo7afOEtS
 UYBaEi8O9sBHvhJntXpt9kfm7sekZpSabW5Q9OpMyhKdyoHgnFB4wmPLDDLpsuc2mm1b
 ovTF7X87BmiCeqK1lTu7xIThMEqaJSG9u1oTGnYK3MjuPOP4dM2xUC5B0sr0SAS7/0os
 Yq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVj8G6f+T59q1eLfo79Z5jxVODFQmgcGdsn03JGGF5vLOoxXLCH7+TVbBTV6CDgZ5PrMXFRRs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywci+uwbocHtayA5kDpSSoiN2AYhjAe2ViT/1zz6IakvkHWsteA
 fMuHrDkXeo7qUFm6ZrM7cbrlOJVo0nlrpTENrKoVqYmKAw4Uc2hPvw/xcPqOL44IW77fg5EVdIp
 14yPCudf8/K7RxNDud5Tl3sVux55X48dtUdDzum76GDN8I6tQTZS1R4xJ23igNwpX
X-Gm-Gg: ASbGncsiqkcvj9CPFhpep+MxrgbS78MEK4SBma+92SA/9XiVETLqEOqTMXN50QzwwY+
 40o0jwmGH8P4f5r7WBIXaeImEr3fUIA8wZB6bl7647kAQLGX9SKvm4AH0fWrHrN4YEtPy+dXMU4
 u2o2jsGpC4QD2Bay0cwyUfmUlX2ANW79S3F7XF6wr2xJkt/a5yUJQb87nieuQPl3tcmNOlujRTh
 NSabjf/y5oi3iFQknSLjAnYWHB3auW3752qGqMUTQCWe1naxpp2qYi8Rcw2Ny6SwKVcm7qiQk12
 YWONUipXv4OC4vlMzJfVuJEzHjerTA05DZwIOax9z+ZLMUz+YHB8WNkcHRQOkUGAafezyOxoZM4
 3vMz7VML+yDzIvRAfdPau8uYL32TX1bC6XRGSqMXRD23/uIHUso5FTt4aE13P4Cr0ZnBvm1LWtR
 1aAZtkd8DgDeiqN2Rtng==
X-Received: by 2002:a05:6a20:3d84:b0:34e:8864:793c with SMTP id
 adf61e73a8af0-3590908dd78mr5418392637.8.1762966758956; 
 Wed, 12 Nov 2025 08:59:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgqTttSudGt9BhHmUQL6Jb/uz4tWbcM1N0uISnbUW3to6aZ7SLR/tIRexZFtMkOuhXx2J5ZQ==
X-Received: by 2002:a05:6a20:3d84:b0:34e:8864:793c with SMTP id
 adf61e73a8af0-3590908dd78mr5418355637.8.1762966758459; 
 Wed, 12 Nov 2025 08:59:18 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bbf1868ad0asm3232308a12.31.2025.11.12.08.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 08:59:18 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] smem: msm: Fix memory-region lookup,
 direct <reg> mapping and update SMEM host count
Date: Wed, 12 Nov 2025 22:28:51 +0530
Message-Id: <20251112165851.1561418-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzNyBTYWx0ZWRfX50XzfUHRHcc7
 9Po5s4o8IQMq9zAWEGhcZTXg6/J9GizzGPtRAuU+l7EnP1xLOWUDqyXCrq9vszFJwRd7fOu65s3
 KOAdY+UnTjKHbn8s4SblqcvgHec9fh3DvpsJCQuWVqZ2Njl4i51xtK/Qj6HSVW1QsCvK2Nu7eHl
 nsO62cGfPMDQZKolyryyqUArahJ/cctRFy8GMaQwoGoNxeRO/NDjKjtktIksK7l7ecunBEESrS/
 DACtBEW0aVaptdliTJrssOWN1zw3dhhnkoK3ACcf6qDcjnF/DCybQu6CxXSEIiUfKqg/VMzRbSO
 l55MASVlBTV1xb0s2k4CcXadIiKrFTXcCMPvhV+p1p1RQtiiIpf6PRGMqAVyaxjut9gxFWvX+ow
 4zttulV93qH2NgzZ85GbZNzIfFWLdg==
X-Proofpoint-GUID: nPUURD22VZoXkK4bXGYABqJSl1QXTKQh
X-Proofpoint-ORIG-GUID: nPUURD22VZoXkK4bXGYABqJSl1QXTKQh
X-Authority-Analysis: v=2.4 cv=KeTfcAYD c=1 sm=1 tr=0 ts=6914bce8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WokWHbWv6b6XxTtlubgA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120137
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

The SMEM driver was failing to resolve memory regions on some boards
because `dev_of_offset()` + `fdtdec_lookup_phandle()` did not yield a
valid DT node. Modernize the code to use driver-model/ofnode accessors
and make the probe robust for both DT styles (direct `reg` vs
`memory-region` phandle).

- qcom_smem_map_memory():
  * Drop fdtdec path; use dev_read_phandle_with_args() +
    ofnode_read_resource().
  * Use dev_read_phandle_with_args() +
    fnode_read_resource().

- qcom_smem_probe():
  * Try dev_read_addr_size() first (map via <reg>), else fall back to
    qcom_smem_map_memory() with "memory-region".
  * Check "qcom,rpm-msg-ram" presence to add second region.

- Additionally, SMEM_HOST_COUNT is increased to support newer SMEM
  versions that include more remote processors. This avoids failures
  during processor ID checks.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/smem/msm_smem.c | 56 +++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/smem/msm_smem.c b/drivers/smem/msm_smem.c
index ccd145f9afb..b6b92d3530d 100644
--- a/drivers/smem/msm_smem.c
+++ b/drivers/smem/msm_smem.c
@@ -88,7 +88,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SMEM_GLOBAL_HOST	0xfffe
 
 /* Max number of processors/hosts in a system */
-#define SMEM_HOST_COUNT		10
+#define SMEM_HOST_COUNT		25
 
 /**
  * struct smem_proc_comm - proc_comm communication struct (legacy)
@@ -821,23 +821,34 @@ static int qcom_smem_enumerate_partitions(struct qcom_smem *smem,
 static int qcom_smem_map_memory(struct qcom_smem *smem, struct udevice *dev,
 				const char *name, int i)
 {
-	struct fdt_resource r;
 	int ret;
-	int node = dev_of_offset(dev);
+	struct ofnode_phandle_args args;
+	struct resource r;
 
-	ret = fdtdec_lookup_phandle(gd->fdt_blob, node, name);
-	if (ret < 0) {
-		dev_err(dev, "No %s specified\n", name);
+	if (!dev_read_prop(dev, name, NULL)) {
+		dev_err(dev, "%s prop not found\n", name);
 		return -EINVAL;
 	}
 
-	ret = fdt_get_resource(gd->fdt_blob, ret, "reg", 0, &r);
-	if (ret)
-		return ret;
+	ret = dev_read_phandle_with_args(dev, name, NULL, 0, 0, &args);
+	if (ret) {
+		dev_err(dev, "%s phandle read failed\n", name);
+		return -EINVAL;
+	}
 
+	if (!ofnode_valid(args.node)) {
+		dev_err(dev, "Invalid node from phandle args\n");
+		return -EINVAL;
+	}
+
+	ret = ofnode_read_resource(args.node, 0, &r);
+	if (ret) {
+		dev_err(dev, "Can't get mmap base address(%d)\n", ret);
+		return ret;
+	}
 	smem->regions[i].aux_base = (u32)r.start;
-	smem->regions[i].size = fdt_resource_size(&r);
-	smem->regions[i].virt_base = devm_ioremap(dev, r.start, fdt_resource_size(&r));
+	smem->regions[i].size = resource_size(&r);
+	smem->regions[i].virt_base = devm_ioremap(dev, r.start, resource_size(&r));
 	if (!smem->regions[i].virt_base)
 		return -ENOMEM;
 
@@ -852,10 +863,14 @@ static int qcom_smem_probe(struct udevice *dev)
 	int num_regions;
 	u32 version;
 	int ret;
-	int node = dev_of_offset(dev);
+	fdt_addr_t addr;
+	fdt_size_t size;
+
+	if (__smem)
+		return 0;
 
 	num_regions = 1;
-	if (fdtdec_lookup_phandle(gd->fdt_blob, node, "qcomrpm-msg-ram") >= 0)
+	if (dev_read_prop(dev, "qcom,rpm-msg-ram", NULL))
 		num_regions++;
 
 	array_size = num_regions * sizeof(struct smem_region);
@@ -866,9 +881,18 @@ static int qcom_smem_probe(struct udevice *dev)
 	smem->dev = dev;
 	smem->num_regions = num_regions;
 
-	ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
-	if (ret)
-		return ret;
+	addr = dev_read_addr_size(dev, &size);
+	if (addr == FDT_ADDR_T_NONE) {
+		ret = qcom_smem_map_memory(smem, dev, "memory-region", 0);
+		if (ret)
+			return ret;
+	} else {
+		smem->regions[0].aux_base = (u32)addr;
+		smem->regions[0].size = size;
+		smem->regions[0].virt_base = devm_ioremap(dev, addr, size);
+		if (!smem->regions[0].virt_base)
+			return -ENOMEM;
+	}
 
 	if (num_regions > 1) {
 		ret = qcom_smem_map_memory(smem, dev,
-- 
2.34.1

