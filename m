Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CC9FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E78784119;
	Mon, 27 Apr 2026 14:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RRcNHmF+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IsUleudT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40D184119; Mon, 27 Apr 2026 14:06:58 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC7F8407E
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 14:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R8T8Ce2913806
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xcDfx6D81qrZ42GllMZe+dWFbCCuhCtHPicj+je1RTE=; b=RRcNHmF+nBS5Fshg
 CFScL4W2x9NG2JiZHwZkfhmiGMC2khSgZhd1LVP9yXb7DSK31Id9UPB5/CI5blZj
 nPDdpC3BGC73lLQc8/xUkjIWgUhCsEfmLeYIagrXs/EzeT3rnZjKUpC9PbwZ72oQ
 kHGdebUuY+Ccs2VbwJyg3Eg+DdGVPzQakVqPsyN3rBXg7wP7SqOgsj3THtD1IvO7
 bPS6W+40yK/DjVtiSR7ePs1WSVA8MSItZbzTstcBuJ77N7mnl4qkKPFjpLukTNSl
 0zWmwb062eAGyA5acQDMQ3Oqja5E2YGk5i9JM3f2NsuN++MqT1kMlt6wetxCCiGf
 PeYpLQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt26xhc7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:06:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-362d9dd9a49so4537550a91.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777291614; x=1777896414; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xcDfx6D81qrZ42GllMZe+dWFbCCuhCtHPicj+je1RTE=;
 b=IsUleudTpfeKWyujmZuWqekt6Xj0rQiGeoA4RIw0j3D9BBc27f/5ULc5xMHmTsZscF
 0lC56dtDEAxuy5SWKC2cktJLof/aeLgIxhAvGJpQfipBoojKzW1ctKeJ6J/0+Lio7TvN
 dWQlzZR5Ulvo/eK1MKKidDpQambfCHes48hyLS38oxSNbLnYWfAwr6wy2TrM8mvI5Dit
 j/+DFgwW/tZWE6YH6eLiOKpXmX6jiw0bv2Yd/CwPdhb3J3Fa4dlISn+W/PBP4v1yE6N7
 tt5RUWztSgSHNf/wBImAv0GtiIs1hVPTtVPpSNKbXKZbM65aGL7xBkfDLp/PKT4OUBfg
 q/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777291614; x=1777896414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xcDfx6D81qrZ42GllMZe+dWFbCCuhCtHPicj+je1RTE=;
 b=kYX9Ma81942YX3OnzhnCij7AUUQRaj7afGLCIYDSFgNNOgE0Gf2MdHmdd4EsIMhrXH
 o4jjqlKy4xg5TLtnkIDq6Ms7zN47xBv+T1AFY6DicbVwyZgt4eLPxi9bGFUe2E73U96w
 Hd+bYVp8O55txr5qRPSKqn7ePW/p+u1cHJuEAD+AgDcwoMfJacppsqHFKkG0ltmpISzb
 1KqulxIepQ8Nd0dCxtz6oTm25llTfFMhvNuG0lS2H2l3Z+wgoVsUj4CZF/efa9TPnJ0Z
 vxNy8lPfVh3C7Lp/EOv5OzgXFD33DntOxNPDTSFPzxtiyBpt/okBDhuczhdiKqTIbB4l
 yBtA==
X-Gm-Message-State: AOJu0YwDncIGJHpu5nZc9YQ6+YA5wYR7Y4BJ7XVgv0UIrJFMlpc+zLwJ
 yCGpjMRRdLUchkLNkjr4no22241D3LcjQj6qxScsFnYArVN7Ph3rTzYHO2jswe9Tf9AgzMZR8To
 vSuE8zi1UVaUR7Zbdz+FzS9/PKYUfySIbANLrmD2PqwNd2+DY0mOLNalw
X-Gm-Gg: AeBDievo8HZcBNYR9PycGANTeDmRYMxmN2cYxCRCK2Y2DEAS2c5Wa6yfXqNx+5qat9s
 4RTa3MNCkp9UhyyO8wFlwu+Y4dBkauZC4bkbvYHMPPcSgVwC6IZN4Z2bU31rOtBN1q6Q1Zbqb3T
 J0BYhDvrgTCiW0QBmVqrDDN/3VXsUXSG4ih6c33/d5Q6z7xHhsEFnQJSd3axphXwWHzfA8woAn/
 l85gcbT1d3wPp3NnjXlT/f8o9pDdKtd0k4rS9cQW0nt7rd+SVV8B+cyY3z4/g8IA+3Gz5WLbkXU
 6oXLHAE2EJbTm2pOzpEoeQ2ZXUHEA/Ic0Ui/0/3XATHksUdcq61Mmu6rj2ClG4WIM7aijHkPpuI
 ECM7uQ7BwuwMqzIUwuMTNkJufgOewFLlT+MSGbr22yxetz3I+jKILU5thSmIxQeMkjYelY9PlwJ
 FW05d1hf+gCgYLs3pyAd5JarMmJmS4dlxc1wx/Hp70qZxOaOAOTAri6C0F2ESQ
X-Received: by 2002:a17:90b:5112:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-361403f4e8cmr42633957a91.9.1777291613773; 
 Mon, 27 Apr 2026 05:06:53 -0700 (PDT)
X-Received: by 2002:a17:90b:5112:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-361403f4e8cmr42633872a91.9.1777291612782; 
 Mon, 27 Apr 2026 05:06:52 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140feea38sm31832910a91.6.2026.04.27.05.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:06:52 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 17:36:42 +0530
Subject: [PATCH v2 1/4] fastboot: block: Add device selection syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-fb_gpt-v2-1-9e7fe3c1649a@oss.qualcomm.com>
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777291604; l=4085;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=2jyIUq/p3c/U+CuKZp5vOyIHrJtYn/zQ6ymWpe+3Fhg=;
 b=ZAi/9SfCmRUbTTVdvCvyJHnvr5GOirJ0A7sh/lCXY9uCTULePSIewgwR20+kL6+nYGyEAYsSi
 QxSgMynZpVOBwU/xJ1KEt0+ZD59GCu66MCrX+5JG+2bTVYxX8Gxi0OH
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: jEYfGrgPSgxCtrlpVVb-y1bayyvehJFp
X-Proofpoint-ORIG-GUID: jEYfGrgPSgxCtrlpVVb-y1bayyvehJFp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyOSBTYWx0ZWRfX+vJeesiu/lEn
 mzrk0X/giUM8D2u3yqTpc1l6BvQQxC4iGH2u+2S/heZHavTeOqcFDm4NJyc/qyo5dFqyGq7wCQ+
 c8iQHU/gZ92/c0LdSn/kTvRIk7wHPislU7cra9Zg9oA2Co8f0IKQnTrh9uxbuO+SzfLzBv4kZv2
 qcZ9QM9vDmZ8L4+a2YS+kkzHILHWBrpYjs1JZuS6FO4TxiJQ6vtsLMAdm5FV958Ui4C2NgZ2Deb
 YQ1W84EIYq/k86qq+9W6A3bG6dMRiJpHWLTVw/Su+Y5t/kAgkecu8kRHoFdsSRdp+/yhwAb66Rg
 cHAsqvX/3ym0k4eTEAC8hnpw+qdMd46cKTzGmjzqNrT93kAsg9yFIdnNmiOTHFkVrK/+7DPnwC5
 BRMVzM4WoQA97rGXT1APsCa94ZHTzXQwqdkLlaNm//BoM2V1gcrbyIF2HsMWUi0Bsc6W3X1b7Vl
 JBPZY2hpDbiSvLbH9rg==
X-Authority-Analysis: v=2.4 cv=FM8rAeos c=1 sm=1 tr=0 ts=69ef515f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ur9GPcVNT4V7s1MEKRwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270129
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

Implement device selection syntax allowing users to specify the
target block device using "N:partition" format, where N is the
device number. When no device is specified, the default from
CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID is used.

Modify fastboot_block_get_part_info() to use the new parsing
function, enabling operations like "fastboot flash 0:boot boot.img"
to write to specific devices while maintaining backward compatibility
with the existing "fastboot flash boot boot.img" syntax.

Example usage:
  fastboot flash 0:boot boot.img      # Flash to device 0
  fastboot flash 1:system system.img  # Flash to device 1
  fastboot flash boot boot.img        # Use default device

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly created in v2
- Has only device selection syntax related changes
---
 drivers/fastboot/fb_block.c | 53 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 51d1abb18c7..061ffd930a5 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -11,6 +11,7 @@
 #include <image-sparse.h>
 #include <malloc.h>
 #include <part.h>
+#include <vsprintf.h>
 
 /**
  * FASTBOOT_MAX_BLOCKS_ERASE - maximum blocks to erase per derase call
@@ -124,6 +125,44 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
 	return blkcnt;
 }
 
+/**
+ * parse_device_partition() - Parse and validate device:partition format
+ * @part_name: Input string in format "N:partition" or "partition"
+ * @device: Output device number
+ * @partition_name: Output partition name pointer (can be NULL)
+ *
+ * Parses the input string to extract device number and partition name.
+ * If no device is specified, uses the default from config.
+ * Returns: 0 on success, -EINVAL if format is invalid
+ */
+static int parse_device_partition(const char *part_name, int *device,
+				  const char **partition_name)
+{
+	const char *colon_pos;
+
+	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+
+	/* Check for colon in partition name */
+	colon_pos = strchr(part_name, ':');
+
+	/* Reject invalid format like ":partition" */
+	if (colon_pos && colon_pos == part_name)
+		return -EINVAL;
+
+	/* Override if device:partition format detected */
+	if (colon_pos && colon_pos > part_name) {
+		*device = simple_strtoul(part_name, NULL, 10);
+		if (partition_name)
+			*partition_name = colon_pos + 1;
+	} else {
+		if (partition_name)
+			*partition_name = part_name;
+	}
+
+	return 0;
+}
+
 int fastboot_block_get_part_info(const char *part_name,
 				 struct blk_desc **dev_desc,
 				 struct disk_partition *part_info,
@@ -133,25 +172,31 @@ int fastboot_block_get_part_info(const char *part_name,
 	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
 						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
 						   NULL);
-	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	int device;
+	const char *partition_name;
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
 		return -ENOENT;
 	}
+
 	if (!interface || !strcmp(interface, "")) {
 		fastboot_fail("block interface isn't provided", response);
 		return -EINVAL;
 	}
 
+	if (parse_device_partition(part_name, &device, &partition_name) < 0) {
+		fastboot_fail("invalid partition name format", response);
+		return -EINVAL;
+	}
+
 	*dev_desc = blk_get_dev(interface, device);
-	if (!dev_desc) {
+	if (!*dev_desc) {
 		fastboot_fail("no such device", response);
 		return -ENODEV;
 	}
 
-	ret = part_get_info_by_name(*dev_desc, part_name, part_info);
+	ret = part_get_info_by_name(*dev_desc, partition_name, part_info);
 	if (ret < 0)
 		fastboot_fail("failed to get partition info", response);
 

-- 
2.34.1

