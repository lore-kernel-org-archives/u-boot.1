Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDFAC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:52:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C858B607D3;
	Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-2rq7f9m5D8; Wed, 29 Jul 2026 08:52:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA0B5607E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785315148;
	bh=+V00aPytUUUlhPRHGbAQRgOK+RRs9cHaGhs9mm+0mDg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=zkhhOhp8cs9BGHFMbxTrQQp8Hd2Ri+lPUWOejIMqem39x0i7oo+OwJej/AM7OsElk
	 TYFrB7cy4xG2yM0uJw+Nt9nZQrgrBjPKS58oBXRDlVWQAOE7IY701wVZdOOjTnabgo
	 9yubYxFmotwmLhyitQdOaHM3H3A4+he+YAn8g3UbGsGSuiLeIm45tdkaasyo2pDC/E
	 zq9Pgxk2xFAUTrHFjZzQgLWxCuHXLBMpP6Iwk/aaf37rUX2wfAADYJeH/nrNXl6nqv
	 7bL2ew2WGnNKzRKCQaV2mM/egHsyUHZ+gqgSILFnNE9Q8WTMlQnZvnit+9JFbbZIuL
	 LpSb3xBTZFuNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA0B5607E5;
	Wed, 29 Jul 2026 08:52:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 750E4490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B86B40B11
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5vCatjwARYD for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=aswin.murugan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 580FE40879
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 580FE40879
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 580FE40879
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D454F8493F; Wed, 29 Jul 2026 10:52:23 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884198404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:21 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7f8ZZ683437
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:52:19 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqbn1rpwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 08:52:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb5cc1e139bso533818a12.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 01:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785315139; x=1785919939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+V00aPytUUUlhPRHGbAQRgOK+RRs9cHaGhs9mm+0mDg=;
 b=bQY7cnZVgw50gZYgmoTDX3bHx4EN0HkZpVE8OnLuVeY8l4KJji3OPXzcuqTI+U2Nu6
 TmsVeNBp8kzojFwgWYsVUy/3cR64XibAeIA1EfjA+yxRGKLNEOcWA4Q6GglYdyhxDDks
 HkN0F1Cc+dMSC3ya2VwG3RzgC1CgO6R1xZY/niAbRr0i0W3r+tY11aDjJmwIEfbpL7cG
 upOZ/EzZhKE8uOf5++LYOZDima/81YfpqEUcZLvVfzCnHGQCoWKm8x5B5tMYzC76CFr4
 iJPSa3ntBrd9fKidqJ19p9pyJr53wnGT3/Y9EQ+NbwmAfl3AG2U03pafqHa6uHnw8NmF
 Q4KA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK0a04wMnj94SsbctOmIXOsunzFIYwqoLmqqAbua9nBdvmYfmNkvHuwvRMR/DRPS3b7dRPnuo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7CR5aAF4L9eu4D1733t008Vnk9vaj4wXsBbO4gpLsqJNFOhfb
 nY3kmCjnETUW20ECgcHOn8a3B2IE3qiBKtGEL4SY4w8juIbPIcCRq3NA6tzfJLt8Bp2HnjS/Z6q
 RZIk4WabSmvWDLs83gh0Ahpx5iQ/dHfcf3oJ6Tzuxg/KiEJwQvN+OCsGD
X-Gm-Gg: AR+sD110hCc2nmJOmnG0v2hixASo8hHLq+OSo2wq9O54aMC/t5Q1uPZvLJEpk7G39ZV
 QuX9wLxU645xpNTXW/uoTXRruuhKaW8DglDv+KSvVkDZvrk6G3IQ9LUvFACUxcBwxGfpK/hcnwF
 t0Woy9Bwbd46DZdq5LQGG3w5HY/NWwd5NYN9qBRSnwSZ1qOzFbZHdgQc+qVUn+N6xhHIdYBnsYd
 dpk6NlzFsRRAV0rZQoZGCg6oiqsoUJ/gyaTCtwvH1NDvyphy8GNhHdkI+T5wsMqJ+b8lug+yxdy
 GVNbm6TfcNMliJ7N5RWtBthbh86iSDBzZKcYu7c16Iz8Kj4B6hkjQVwCRAhQR9OCsGGEvoIDP6x
 Tk8cJnBFnh/gs/jNfHQYMzjXi8TeqTih3D5zGqvyFSLEm+Bt7A1h3BBPXf/JZzc0KdrB/cxsq7a
 rNTXX5ZNngnjvGNb3P8gU=
X-Received: by 2002:a05:6a21:4516:b0:3c4:42d9:58e3 with SMTP id
 adf61e73a8af0-3c8aafa0605mr7195308637.13.1785315138681; 
 Wed, 29 Jul 2026 01:52:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:4516:b0:3c4:42d9:58e3 with SMTP id
 adf61e73a8af0-3c8aafa0605mr7195269637.13.1785315138266; 
 Wed, 29 Jul 2026 01:52:18 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7265547bsm6747719c88.7.2026.07.29.01.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:52:17 -0700 (PDT)
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, Michael.Srba@seznam.cz,
 ilias.apalodimas@linaro.org, sjg@chromium.org, linux@smankusors.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] mach-snapdragon: raise block cache limit to cache full GPT
 table
Date: Wed, 29 Jul 2026 14:22:07 +0530
Message-Id: <20260729085207.1585073-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3MiBTYWx0ZWRfX5x71c8vBqzN/
 WD2fO5+DMKC0zrVfDux2HsKGMtp2o0995B5TrLKKrZwWtQfj64kGeM0iAwZLu/3aVFSSdpX8Noj
 nsNVK6hGVbJskDJD8UzX76xkTp0sU7k=
X-Proofpoint-ORIG-GUID: EN1k-o71wq6fauo4vowFtu5y90DGcZNU
X-Authority-Analysis: v=2.4 cv=csCrVV4i c=1 sm=1 tr=0 ts=6a69bf43 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=J54uKDEkSAFcm6cqkTIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3MiBTYWx0ZWRfX6AtJ9oMzfPMi
 e1M3zXAaVtmKPOdf4aYC6nlkNlB+YK73JXmG6/aVbrcjBXUNjx2ue3EzPHjxpfUSF91q706si1s
 6kZJpllTp0YH+T5IRUCYFkck7LYrqQNm/VpwXevb1HMl9vf+J1rGWDMfLH+BG5Y50fsNgsr/93k
 EPYY3jw1mvWRibNg16kqq5J6ZjKhOgIjQT5X1S5CnAgL/97RBbMmw/A8a6HigJ6mW7Bn5DVwK/+
 Az+kg7z3sww0BlrrnwuRZbgfpbLj/+RL25ybl1TlLQZgvz15w32IGu2Zt0ncCtHkGbNQxiqjdmt
 FH+48TTkuCrG5Of4MlLNvFsu88WOSP/mysjwIidPkaPXsEX7PXGrgiYv9PlM/RQr+wkTaBjFEDI
 pZgWUqpm9Ez0kXn3vOKAAEBkgdSxu1YdITNDK/vQkNqe/SNeltQ9WwN5AtvqFfE9qSjb0naTgb6
 iJOPqWRWZJzFBzga8UQ==
X-Proofpoint-GUID: EN1k-o71wq6fauo4vowFtu5y90DGcZNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290072
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=+V00aPytUUUlhPRHGbAQRgOK+RRs9cHaGhs
 9mm+0mDg=; b=EIediHmZWTVAaDBnWnzMtL8X5M81CHIF7EK3H+pvecor8x/sgNT
 cen2Z7pykG7duC3+6kvI2dJZvCGZvghujuGJ/spmK5XOsmK/tAC+sOU8J5wiGq86
 qsBDput0hH3Q7d/cryjm2/7pxBIAVXIC3Uivwamr2h6ttBNkzIrou5gAhpTyOQhQ
 67ROvCILn5K5XjRaecvPbp1SVPMi0mde2RZTnevmUs4ZCVLmcZf2eDl2HqapaYMa
 usuWA3QWz4LK1rOvhi7y+LZOHvz9KSmugrouqGmbXUdVkTnNVqQhXrkO1dsUwBhZ
 A+GPzwaEJ/lt/jkDHbWRL0765YnUJvbUAzQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785315139; x=1785919939; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+V00aPytUUUlhPRHGbAQRgOK+RRs9cHaGhs9mm+0mDg=;
 b=V2Lo2EbrjsGCKu4QvcAJoWk0A70aHkzm35OWvEKAi8+NU6JOIvNaGj0sA2djMqTCKS
 yxtlX3sD93QnySwDhz2cr+JyoQTmnHK+d1euIEC+dDqA4/xivpo6HVB+AwO4XN4w1+cY
 VXqcY+Vzvkyov5nRoPXnkdlabsnGXpA1JdkQv620bZpvgTS/l+ZtjJryiTyyaFuunKQM
 SIIjGJP7QRXkeTYAWgk53NaXdmDuM+jS3moq4iSOGHGXJqUBpCPb3DHT1GBbGw2qjEiZ
 xBhoH5TEIuCTBO4m0mxHWIVZxH/5lpTDPHeUqkUXUAiJD39EuZ4wIlU1IEDLaNkNwZwc
 19hA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=EIediHmZ; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V2Lo2Ebr
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EIediHmZ";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="V2Lo2Ebr"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

part_get_info() calls find_valid_gpt() -> alloc_read_gpt_entries(),
which re-reads the entire GPT partition entry array from disk on
every call once per partition while looking up each partition
during boot.

This happens because blkcache_fill() skips caching reads larger than
max_blocks_per_entry (default: 8 blocks/4KiB), and the GPT entry
array is bigger than that, so it never gets cached and every call
triggers a fresh eMMC read.

Raise the per-entry block-cache limit to cover the full GPT table
(computed from CONFIG_EFI_PARTITION_ENTRIES_NUMBERS) so it is cached
after the first read, turning subsequent GPT entry reads into cache
hits and avoiding redundant eMMC accesses.

Improves boot time by ~800ms on eMMC based devices.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 80bf510d31f..223137b1198 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -11,16 +11,19 @@
 #define pr_fmt(fmt) "QCOM: " fmt
 
 #include <asm/psci.h>
+#include <blk.h>
 #include <dm/ofnode.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <init.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
+#include <part.h>
 #include <soc/qcom/smem.h>
 #include <sort.h>
 #include <time.h>
@@ -30,6 +33,12 @@
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 enum qcom_memmap_source qcom_memmap_source __section(".data") = 0;
 
+/* Number of 512-byte blocks needed to hold the full GPT entry array (entries * entry size) */
+#define GPT_PTE_SECTOR_SIZE	512
+#define GPT_PTE_BLOCKS \
+	DIV_ROUND_UP(CONFIG_EFI_PARTITION_ENTRIES_NUMBERS * GPT_ENTRY_SIZE, \
+		     GPT_PTE_SECTOR_SIZE)
+
 #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 static void show_psci_version(void)
 {
@@ -153,6 +162,15 @@ int board_init(void)
 {
 #if CONFIG_IS_ENABLED(SYSRESET_PSCI)
 	show_psci_version();
+#endif
+	/*
+	 * Default cache only covers 8 blocks, too small for the GPT
+	 * partition-entry array, so it's never cached and gets re-read
+	 * and CRC-checked on every part_get_info() call. Raise the limit
+	 * to cache it after the first read.
+	 */
+#if CONFIG_IS_ENABLED(BLOCK_CACHE)
+	blkcache_configure(GPT_PTE_BLOCKS, 32);
 #endif
 	qcom_board_init();
 	return 0;
-- 
2.34.1

