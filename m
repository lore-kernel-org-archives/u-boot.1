Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8A6E8384C
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 03:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E5583AA9;
	Tue, 17 Feb 2026 04:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JL+By6Cr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jp9YoKQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDDF83B8A; Tue, 17 Feb 2026 04:56:56 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD9F83642
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GG1iGe048833
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 03:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=IdfX1Oc7GL432U+hxn/TwiZvllP0ElxFiSk
 TkqA5dso=; b=JL+By6CriOjIiiJuQdnM1ZTCOXKtrpuvTljjtQtbkuAL1vOfNvV
 irFYUfF1TncLBkbHyqlKNJ6YORRVzhtRh0UelMN1MRYNxcO0oM//4gFvVXck4V6R
 ghXUhNRX49fBxUe3wtHMPzqqfrDyuR5odlimeopOr281pbbPwZLuAW4s1hY0lj99
 VefavEuI7eynb48ouzKBSPmZPaUDsbdKpRQkoCdoAU0qxNxDsNcYYcFNXJfW7CTm
 GqP8qIysgaayRZiB7httMay6y7911p9wUb/sDtv+1TwG/OJmvM/fleUujgxXPrq2
 E4BAg4/IA8xN3vafeojbLtnKwDbclsiAtrw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d8154j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 03:56:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aaf2ce5d81so45433685ad.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 19:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771300610; x=1771905410; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IdfX1Oc7GL432U+hxn/TwiZvllP0ElxFiSkTkqA5dso=;
 b=jp9YoKQSAwMhYU5k/477sjP/QYYaKIYMg6C97s3OtI51fLFX0mzNku8vpZQFt+4qoz
 uh4dEtvGKERAl0lraAc+HHxiQo0tE0tLPOBYLAbC2J3wNLzZoZSeg6eZ3kmuD5IG4gEL
 AOR4qwBCP+d01RfCdk/Jz1PUICLrRyYXei2cQugVrjUWbSZ0x+4Cq2taYiLf6hETWJ4t
 fi9hZJIOg+hjriqDyv/W5QYSBaaddECG1Ar7nGQp/ndxujyD8h3iZ5us0hNXUOvGy1lR
 McYTDP/7sB+wnyLcQHWcIa+gYga9TiL33ffXD8MFqD0L90b0quqtZeHFvVGZZZiBAkJo
 URRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771300610; x=1771905410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdfX1Oc7GL432U+hxn/TwiZvllP0ElxFiSkTkqA5dso=;
 b=gCQ2OFIUjowj7KoP3cnYV7jhtQgDLvr6CIPrxCwYAn5/n9YUMFNG+wn9a4m5bPpdJW
 VoLHczaZ1Jiy6i/+PfI67+lrMQnhFz2wXTUgAJ5XVIhFoF8eInn3WdQGegYfRBTXQ4XE
 aTozCXEly6n4C1c9PG0gCQIMTVs+DzPCVWWfnEB/hV5oEN1pg2JDp9ThHw0kfoO0yY5J
 9W4hbLkxGrr7ng2/zLnUqsgsBpJ7VVclvz8x3Hy+4F5VdrLH+GuEqPAqL/mRMNqMnw1z
 hz3sJ5Ykz0iEjM7V4D+8AZeQze2Srl/DZ1NHvLBaFyKaEjjRsaNnfKkicbjztBwD9iRt
 cKaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaKCCHJGgcvwGafGIQYoS1qt7AOhXdJ017ciOwtCErwZ8ZKsesVKEb1CTTt+5Mf4CuIf30gv0=@lists.denx.de
X-Gm-Message-State: AOJu0YwvJdqZ2PNjN4f85+R8YBWckEplSfPi6wnDHWd9wTN30TvSQ7Aw
 lvDtZOCWtAmUlc926cmjTHHhI7D22C5ELKipcfL6q9MBXaulUMOXDqwbZxOD43AKHRROs7ZM6br
 pM+hLm6ZZpPW2dDA6dSb2OFNtsNUpue8kNqHMT8rCRlS8zSOgEzs7PW82
X-Gm-Gg: AZuq6aLpSv/HcIl/YNBjB+SBdg1dg4HVppVrIkvtrsCA3UQWEjKG+83sOPCBqajolHh
 2MOCLt/pSJ/zgXIJg5PV4FAoomvCXRkAL4xx0QLuOB3c4OfvKpLOZNxe4abpIZGMPTiwF+7Xb1v
 kfuU1iRwZvBZMKdROyybfW1gM7jxaw1sfLGeAKZ8gWJYanT+THQZN3KxM09OjqyWOlrYdoPiTit
 jDT7p1NnWVURKaMYk17hEPelcVPvnuQ+Y4avfu3StI89nOOOB9bpIIQjc7K4pXZEsQRDffXJep8
 T54aLBHfZC03Jjvgg3t3VmMU0UXvzSWK1y8oxtcsygkp5bWB0Dy2V7XVhAnzc2Q8+RE3rFrl5Xs
 O+DV1OW9zDNNWkjxRneaqoBimXv5ydXC2ffRkVLtWOUs8F2iQRlVLDm+ko/x7fqEuCyz01xfq8z
 2C/+v/bvQBY61KDaOQf+N0++v5rq2RJKTYeZ9SpLXi1qTFf0r2Upw=
X-Received: by 2002:a17:903:1aa7:b0:2aa:e23c:2697 with SMTP id
 d9443c01a7336-2ad175b1491mr86922205ad.57.1771300609972; 
 Mon, 16 Feb 2026 19:56:49 -0800 (PST)
X-Received: by 2002:a17:903:1aa7:b0:2aa:e23c:2697 with SMTP id
 d9443c01a7336-2ad175b1491mr86922035ad.57.1771300609422; 
 Mon, 16 Feb 2026 19:56:49 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeaa5bsm83180535ad.81.2026.02.16.19.56.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 19:56:48 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, gabriel.dalimonte@gmail.com, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH] fs: fat: Handle 'FAT sector size mismatch'
Date: Tue, 17 Feb 2026 09:26:43 +0530
Message-Id: <20260217035643.2383088-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=6993e702 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=5p_tG3gqAAAA:8
 a=NEAV23lmAAAA:8 a=YfCOm-DyAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=kvHvfpOrqeMORAa8gaAA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAyOSBTYWx0ZWRfX5RO2Qhbdfj9Y
 xpdGX7C1xK5oCfLLsloOIo9QcAPODq1ZtLqGGJjC8OCTAAtsKMDLOqiVFCUBPfC5fGbojtF+mti
 u/PSPPOFu8vJjGBsDf30k5+jqd1Fb6kHhkq9REZbFvO4aq4raHf55mcN7tUVYVnyjLzGQyohpG6
 9tYumzLgZIxsgk3fg5LUm/Yi/Yta3+2U2Kn+Y/H40T4xiOLMcKxeyEakCClUuuFAj96r+RPPlzn
 vlAMQc4vl4+NPg2MX0XKccLvJvjG9nBL0uOXqpLIqIdupKhq+W34CDA+WXfBgOka5wq8aN7mJfl
 NJdO+5QeutEI/5O3QYIaP/Y5LLg+Zq2CHwwy79RzNTnZaOJR8EbUiEOZ4HwSVmJ+1FplxdKPdpQ
 gDujxDBeJ7LMt9Xg3BsGaj+E61GgB/gWxIUhdZkLVZBP2UiqNnbVjLT49ZFrYQt6AAukniiBtVf
 7rS6cliO5CCKmkUSQ1g==
X-Proofpoint-GUID: XF2j3RvdJ0ma0u41s9LUxVKiAtkcYD-p
X-Proofpoint-ORIG-GUID: XF2j3RvdJ0ma0u41s9LUxVKiAtkcYD-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170029
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

Do FAT read and write based on the device sector size
instead of the size recorded in the FAT meta data.

FAT code issues i/o in terms of the sector size. Convert that to
device sector size before doing the actual i/o. Additionally,
handle leading/trailing blocks when the meta data based block
no and i/o size is not an exact multiple of the device sector
size or vice versa.

Tested on UFS device with sector size 4096 and meta data recorded
sector size 512.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
Changes in v5:
- Fix CI error reported in https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12821&view=logs&j=a007cd84-3be0-5a02-8a7a-a34fb3052485&t=216c79d4-eaff-5600-0b8f-3a63c01a45d6
- All CI tests passed. (Please see https://github.com/u-boot/u-boot/pull/868)
- U-boot SPL for (am335x_evm, am335x_hs_evm, am335x_hs_evm_spi) includes the
  FAT driver. The additional checks done in this patch resulted in increased
  code size causing it to overshoot the '.sram' area.
- Address this by using the existing disk_read & disk_write routines for
  SPL.
- Also bail out in case of sector size mismatch for SPL

Changes in v4:
- Fix clang warning reported in https://source.denx.de/u-boot/u-boot/-/jobs/1365316
- Remove unused function 'size_to_blocks()'
- Triggered CI, it fails with this error https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12817&view=logs&j=a007cd84-3be0-5a02-8a7a-a34fb3052485&t=216c79d4-eaff-5600-0b8f-3a63c01a45d6&l=405. But that seems to be seen on top-of-tree without this change also.
- Link to v3: https://lore.kernel.org/u-boot/20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com/

Changes in v3:
- Respin, no changes
- Link to v2: https://lore.kernel.org/u-boot/20241125085213.460723-1-quic_varada@quicinc.com/

Changes in v2:
- fat_sect_size is declared as static
- The else block in disk_write() function has been removed
- The commit message has additional details about testing
- Link to v1: https://lore.kernel.org/u-boot/20241119073048.3469260-1-quic_varada@quicinc.com/
---
 fs/fat/fat.c       | 210 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fat/fat_write.c |   2 +
 2 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 9ce5df59f9b..a725d924fd9 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -45,11 +45,13 @@ static void downcase(char *str, size_t len)
 
 static struct blk_desc *cur_dev;
 static struct disk_partition cur_part_info;
+static int fat_sect_size;
 
 #define DOS_BOOT_MAGIC_OFFSET	0x1fe
 #define DOS_FS_TYPE_OFFSET	0x36
 #define DOS_FS32_TYPE_OFFSET	0x52
 
+#if IS_ENABLED(CONFIG_SPL_FS_FAT)
 static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
 {
 	ulong ret;
@@ -64,6 +66,206 @@ static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
 
 	return ret;
 }
+#else
+static inline __u32 sect_to_block(__u32 sect, __u32 *off)
+{
+	*off = 0;
+	if (fat_sect_size && fat_sect_size < cur_part_info.blksz) {
+		int div = cur_part_info.blksz / fat_sect_size;
+
+		*off = sect % div;
+		return sect / div;
+	} else if (fat_sect_size && (fat_sect_size > cur_part_info.blksz)) {
+		return sect * (fat_sect_size / cur_part_info.blksz);
+	}
+
+	return sect;
+}
+
+static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
+{
+	int ret;
+	__u8 *block = NULL;
+	__u32 rem, size;
+	__u32 s, n;
+
+	rem = nr_sect * fat_sect_size;
+	/*
+	 *           block N       block N + 1      block N + 2
+	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
+	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+	 * . . . |               |               |               | . . .
+	 * ------+---------------+---------------+---------------+------
+	 *            |<--- FAT reads in sectors          --->|
+	 *
+	 *            |  part 1  |   part 2      |  part 3    |
+	 *
+	 */
+
+	/* Do part 1 */
+	if (fat_sect_size) {
+		__u32 offset;
+
+		/* Read one block and copy out the leading sectors */
+		block = malloc_cache_aligned(cur_dev->blksz);
+		if (!block) {
+			printf("Error: allocating block: %lu\n", cur_dev->blksz);
+			return -1;
+		}
+
+		s = sect_to_block(sect, &offset);
+		offset = offset * fat_sect_size;
+
+		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		}
+
+		if (rem > (cur_part_info.blksz - offset))
+			size = cur_part_info.blksz - offset;
+		else
+			size = rem;
+
+		memcpy(buf, block + offset, size);
+		rem -= size;
+		buf += size;
+		s++;
+	} else {
+		/*
+		 * fat_sect_size not being set implies, this is the first read
+		 * to partition. The first sector is being read to get the
+		 * FS meta data. The FAT sector size is got from this meta data.
+		 */
+		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
+		if (ret != 1)
+			return -1;
+	}
+
+	/* Do part 2, read directly into the given buffer */
+	if (rem > cur_part_info.blksz) {
+		n = rem / cur_part_info.blksz;
+		ret = blk_dread(cur_dev, cur_part_info.start + s, n, buf);
+		if (ret != n) {
+			ret = -1;
+			goto exit;
+		}
+		buf += n * cur_part_info.blksz;
+		rem = rem % cur_part_info.blksz;
+		s += n;
+	}
+
+	/* Do part 3, read a block and copy the trailing sectors */
+	if (rem) {
+		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		} else {
+			memcpy(buf, block, rem);
+		}
+	}
+exit:
+	if (block)
+		free(block);
+
+	return (ret == -1) ? -1 : nr_sect;
+}
+
+int disk_write(__u32 sect, __u32 nr_sect, void *buf)
+{
+	int ret;
+	__u8 *block = NULL;
+	__u32 rem, size;
+	__u32 s, n;
+
+	rem = nr_sect * fat_sect_size;
+	/*
+	 *           block N       block N + 1      block N + 2
+	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
+	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+	 * . . . |               |               |               | . . .
+	 * ------+---------------+---------------+---------------+------
+	 *            |<--- FAT reads in sectors          --->|
+	 *
+	 *            |  part 1  |   part 2      |  part 3    |
+	 *
+	 */
+
+	/* Do part 1 */
+	if (fat_sect_size) {
+		__u32 offset;
+
+		/* Read one block and overwrite the leading sectors */
+		block = malloc_cache_aligned(cur_dev->blksz);
+		if (!block) {
+			printf("Error: allocating block: %lu\n", cur_dev->blksz);
+			return -1;
+		}
+
+		s = sect_to_block(sect, &offset);
+		offset = offset * fat_sect_size;
+
+		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		}
+
+		if (rem > (cur_part_info.blksz - offset))
+			size = cur_part_info.blksz - offset;
+		else
+			size = rem;
+
+		memcpy(block + offset, buf, size);
+		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		}
+
+		rem -= size;
+		buf += size;
+		s++;
+	}
+
+	/* Do part 2, write directly from the given buffer */
+	if (rem > cur_part_info.blksz) {
+		n = rem / cur_part_info.blksz;
+		ret = blk_dwrite(cur_dev, cur_part_info.start + s, n, buf);
+		if (ret != n) {
+			ret = -1;
+			goto exit;
+		}
+		buf += n * cur_part_info.blksz;
+		rem = rem % cur_part_info.blksz;
+		s += n;
+	}
+
+	/* Do part 3, read a block and copy the trailing sectors */
+	if (rem) {
+		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		} else {
+			memcpy(block, buf, rem);
+		}
+		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		}
+	}
+exit:
+	if (block)
+		free(block);
+
+	return (ret == -1) ? -1 : nr_sect;
+}
+#endif /* CONFIG_SPL_FS_FAT */
 
 int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
 {
@@ -581,6 +783,7 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		return -1;
 	}
 
+	fat_sect_size = 0;
 	if (disk_read(0, 1, block) < 0) {
 		debug("Error: reading block\n");
 		ret = -1;
@@ -651,11 +854,14 @@ static int get_fs_info(fsdata *mydata)
 	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
 
 	mydata->sect_size = get_unaligned_le16(bs.sector_size);
+	fat_sect_size = mydata->sect_size;
 	mydata->clust_size = bs.cluster_size;
 	if (mydata->sect_size != cur_part_info.blksz) {
-		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
-			mydata->sect_size, cur_part_info.blksz);
+		log_info("FAT sector size mismatch (fs=%u, dev=%lu)\n",
+			 mydata->sect_size, cur_part_info.blksz);
+#if IS_ENABLED(CONFIG_SPL_FS_FAT)
 		return -1;
+#endif
 	}
 	if (mydata->clust_size == 0) {
 		log_err("FAT cluster size not set\n");
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 0b924541187..86132a9177c 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -192,6 +192,7 @@ out:
 }
 
 static int total_sector;
+#if IS_ENABLED(CONFIG_SPL_FS_FAT)
 static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 {
 	ulong ret;
@@ -211,6 +212,7 @@ static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 
 	return ret;
 }
+#endif /* CONFIG_SPL_FS_FAT */
 
 /*
  * Write fat buffer into block device
-- 
2.34.1

