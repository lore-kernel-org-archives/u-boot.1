Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CFDD13C3C
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0068583C4B;
	Mon, 26 Jan 2026 17:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LLTGWBU7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kcpu57s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1271983CEA; Mon, 26 Jan 2026 17:02:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6F083C04
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60Q8shN4762743
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fzCZ4lsUkQ5h4mx6ZaOp9sYiiBd7OLMV9qz
 HPmsSGHY=; b=LLTGWBU727Dcs7u0biy4usC8djqKH5yfxAB10SwNxkkrbU9JDsL
 JpDfeSOnaL5C1a5S+iDrUekEcL3RL/Zfd02pt3C3k121QRUeOouSe2mJbE9N9Ygq
 TdO04j9WMzmKumb6apNicKNvhkGGk3mynm0n7+xSQicDuMIYTkRIJIuLrbYa6KER
 rEoYsxHy+F0s1KgOsJVYwpEhAfytX9Fql0xJPuj0KaQAohMMmlCws3nV6TPDZjED
 ob68UlpM3URKInt6brDPhXEy+fszC5ryexmogvZY/2PhwMbdVN8nFE7zAJdKFrKX
 Wj5jje79zrs5/oALkGG3tGk1k4acgzn1jUA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f51t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:02:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-822426d21a8so698711b3a.3
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769443352; x=1770048152; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fzCZ4lsUkQ5h4mx6ZaOp9sYiiBd7OLMV9qzHPmsSGHY=;
 b=kcpu57s84MGAHqmv29l70bLxzKIiebx4ZEvvZktaR9khSlEh8TQgAiTavWbuDePT0j
 V7TMPwMIwANPmRNMqCQ8X9dyqZ271+vEpsswYeLQKPUz0d/BcTW1tBiVMpaz5+tTHiE/
 BUP5H+kNgeFgCoxpe6FjRxvcA3OTDPftfuLeBMhnAksFfUAEhq5kRzaPOIKX28H3fZQh
 htTeozBdXUBZJb6QyfKW9Z3/G/rbPbb8VDYVWI1ahRQTr4arezi+D7mULsvqMDQ0RQqX
 NuuvD0Ul4zG1MVirADojTQ9g5wACZ+czGchOV4dQL/IKvd/xCJS0OAWetZh3iyat9O72
 yIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443352; x=1770048152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzCZ4lsUkQ5h4mx6ZaOp9sYiiBd7OLMV9qzHPmsSGHY=;
 b=J4QLb0rcXYBmiZGoWqhN35yB/72Ark5zq2JHg5aoyFy81JX6mlQGSlF/vMMv5uRuNp
 PRTOkF6QIE4qwcC4/GhNjVnBerJFEHiPX6eFaAhesbL6DZs2k4UQel3O2/Xz5sB1uRDr
 94fv56AinRKPrF7LeLhjxBoo2CBxCPDyn7OLwvekUoiWoN69cVPBOHs1mH9mwgQG6+tI
 9q/uLz6BeqA2bmwQeonE3oyODCl8cgMy1FLlkaRH+Y5IkTWKFLz9SjiANsjJFlGEPLgE
 qVBFLl50mBWJGIdND96ucWNjJcQNUWheO7mZ3ogBivojRiwbeEXF8MJH3XdkS3F610E/
 19+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzGK4S95RyVLzpbgajyq1/yrUtrMhuYc6tQl7iKPzExMxylNFSoF5TewX/eS21qimdUhL9mJg=@lists.denx.de
X-Gm-Message-State: AOJu0YxdZUvRTHqEf54q82k0jV7GrPDwSkOaqfkNAYzYczCfG7MltMnO
 jZ03eD+rIWeFt+nU4TQeO8ce6FAxAzMLWmbGgTGYChYKCqq/DDZEbpYtygEUtvATXM2MFYcl/ul
 e+R7BgXjhhGKb2p9GY6V+sheXm3BN96zYsRTRmZ+58lsl1Jip9El9/ZKO
X-Gm-Gg: AZuq6aJNJCrguoBcYfz4Nj/rTEm994PYQupbvFnzbZV4TdAZltoeq2pqLBBMZO7hGNF
 7geQ2oT68aQlyLL8zGiTpzxuEVfRVK+arlwZ4y7fKIru5OCNYf+qVfBJHpdjEMKf/4YPLGkbHvL
 6tUSvuJ3udYNR3DlWfnERtWSirOOG6Q0cCr+dIfg3/E5Xd4BHeSi14oCYQJwEBjIybVCAstZwun
 ruVeQ48GiARsVsNWUaLAArGBrmpSKPBkJGyWo5e5nR/L993lR2NsgobxQ1gqRsmDtUNTrxzaqwg
 SIYahSyurLnqkZ3NtOHUKa2icpBtCVAcR09cHksn9KyKO8N/6cI5eITqr4CjNyHIJly4ySQFY38
 Q5xJEUHOHZS9dbQndpdRtzT1JJDERGtn+T9HIkS9La5Ba0yMFH+iLrgC9EHc0Dn13ALqCuhZxPO
 aeN8m180eOfM4c3fBILYWvUE+GTIpngewpvfaNBQ==
X-Received: by 2002:a05:6a00:3389:b0:81f:521c:b640 with SMTP id
 d2e1a72fcca58-823412b97b6mr4104072b3a.55.1769443351798; 
 Mon, 26 Jan 2026 08:02:31 -0800 (PST)
X-Received: by 2002:a05:6a00:3389:b0:81f:521c:b640 with SMTP id
 d2e1a72fcca58-823412b97b6mr4103975b3a.55.1769443350059; 
 Mon, 26 Jan 2026 08:02:30 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8234fd9a5a7sm2277205b3a.63.2026.01.26.08.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:02:29 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot@lists.denx.de
Subject: [PATCH v1] fs: fat: fix buffer overflow on repeated fat_set_blk_dev
 calls
Date: Mon, 26 Jan 2026 21:32:24 +0530
Message-Id: <20260126160224.2718059-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=69779018 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=l6rqwx8q1VO34AIQI6MA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: jShU_lKseQlo0N80GtvHbHd2qnu7eD8j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzNiBTYWx0ZWRfX/B7MBYxLLhvD
 542SjYHNKcgSu5SK8Tp57wIrL5RZRNCvmGrYdn5dP/ipD9IDI8Pz0W719N0Lv2Fa78cWGHn1nzw
 AQbFoccF6If9IlrbHJTBTyiYeJ9SzIk8TwxSJ1wNu4X1JepmUaoJQJ1bPKFDZ8c3amSRy9/Za7X
 qn/luxmaAS4u3+/kJYI76mxmdg8bFygTgMzh4s4EVG/Nv5807UOrV9Q0ymrSOV6D3jn2gqSPcEC
 WcJrCrLryyrueqLMArBnqnnYjrJMow9v4HbcQAbzy41OF66I8VQ2OED1lbQMc14k0Gjl16kJlS+
 rOKsLk3oTDluGty2V9ZLjfB1Stj1V2VgYz5kZ4wUDxVdwXBnk4F6lXDKraf63Q66aHWQ39n4Ot3
 m6xt3+3Flbo7UvosDUDv/HHlDDkLzOTfgrZu4YFr06aTw0MOAFxoyU4zOJTwwwLWgoIVtluWMB/
 4lO3jxM2bGSh90UY7DQ==
X-Proofpoint-ORIG-GUID: jShU_lKseQlo0N80GtvHbHd2qnu7eD8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260136
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

Fix a buffer overflow that occurs when fat_set_blk_dev() is called
multiple times for the same partition.

On the first call, fat_sect_size starts at 0 and gets set to the FAT
sector size (e.g., 4096) after reading the boot sector. On subsequent
calls to the same partition, fat_sect_size retains this value, causing
disk_read() to attempt reading 4096 bytes into a 512-byte buffer,
resulting in memory corruption.

The fix adds caching to detect when the same device/partition is being
accessed and returns early without re-initialization. For new
partitions, fat_sect_size is reset to 0 to ensure proper
initialization sequence.

This patch is based on the changes in the upstream submission:
https://lore.kernel.org/u-boot/20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com/

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 fs/fat/fat.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 05acd24d8bd..8138f7418a1 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -257,10 +257,28 @@ exit:
 
 int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
+	static struct blk_desc *last_dev;
+	static struct disk_partition last_part_info = {0};
+
+	/* Check if we're already initialized for the same device/partition */
+	if (last_dev == dev_desc &&
+	    last_part_info.start == info->start &&
+	    last_part_info.size == info->size &&
+	    fat_sect_size != 0) {
+		cur_dev = dev_desc;
+		cur_part_info = *info;
+		return 0;
+	}
 
 	cur_dev = dev_desc;
 	cur_part_info = *info;
+	last_dev = dev_desc;
+	last_part_info = *info;
+
+	/* Reset fat_sect_size for new device/partition */
+	fat_sect_size = 0;
+
+	ALLOC_CACHE_ALIGN_BUFFER(unsigned char, buffer, dev_desc->blksz);
 
 	/* Make sure it has a valid FAT header */
 	if (disk_read(0, 1, buffer) != 1) {
-- 
2.34.1

