Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C2BC44500
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 06:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478428341A;
	Thu, 22 Jan 2026 07:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjFJnvk6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hkrpZJP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1805E8397D; Thu, 22 Jan 2026 07:34:53 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0645C80077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 07:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60LMr6711407059
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 06:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=g10gSz0db5VLW9cwai1Z/EWb8MOdmC1k0TI
 YM6dG+Jg=; b=IjFJnvk6U6WOV2A82BhDB179RYlckkS7Ev5R6WznkvphNgG0Ew6
 twlMmdbhWS1AT3AUUl/74ajexTrIffq56o//MfXqe9JaINaF/BT3xEFV07owTPxX
 NjLyRvjSOQYSzIeHvZS28d2VHkpU+NwWXqlQOWhVfUuJEsyvskdYAIn9Csbw/8x+
 4jPprVtI7QhQ38ilMwseMi9HcqdZWG1g5EnRmndp1JgR5t9HbIgFKdzYAfMNUdMV
 vFSANFGP8IevYC30MtnWuc+xKTDbv+wSH5oBYRlTjdxcVBtmNpNDSh1dmLcHolNb
 oBUWAcRkjxh2r7dA8S1ML337ycaQM1Zx9Vw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu802s5d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 06:34:48 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c337375d953so361818a12.3
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 22:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769063687; x=1769668487; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=g10gSz0db5VLW9cwai1Z/EWb8MOdmC1k0TIYM6dG+Jg=;
 b=hkrpZJP0711H9ajaspkI5Tr9CO9iauJfm3nM2hO/bPq9a71tybalFkoW9eH4Ut61hN
 QL8O95+si60B0mGaIU3TQV3jemTnD3oLnk+aRjQkLUbmXbPXSIM0tzwFjBwjFOi8LBZo
 sY5oql5TSN4AMEJ372lMxbeYWeizVrPIxvkC9Qj5ksEOM9yTxRu/UucPhTc/k2z+7NVk
 BL6kXx3IynsEvqpT6DBTRO9frczkGHZ11cEG+Arz3/e2Nuftj1kKTAp1UH2SUUh7i9ux
 Bx2HUZQbh+0u/7eCyojfej9l/KvZphgc8jGD1auoNfxRkyP/ecyzlQ0d2HDMaEIGNABG
 FRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769063687; x=1769668487;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g10gSz0db5VLW9cwai1Z/EWb8MOdmC1k0TIYM6dG+Jg=;
 b=nbAiS1YCMy/MPdH4dqRfm+divXpuHWUPDZhLEl+QUwzGwyJR2QzV9Tpa/vuApBpB9g
 TlrUMToyhPOFap//Vf/NWpVZhP5rr6H4LmFX7ReBj2m4hToD9DJ3c7yEASre52cg56AK
 Ihxog6yum7p8L2rtUTgXtpr9NSYmo/XlJGKTew1GAaQe/d0HrekPYpj974ksgdrkkJy9
 viQJ0TqhyaQSTjWU4l0wx5bCnfhbQUnx0GqS8TkMUT1sox0apn6U3hLl4PNAj/qcqDy4
 5UEej38BEuzSP8NrPoGSmvk3jxFMKN2Rz2QDtVaNX4xwSFvQstt/Z6Lp+xNI2U8DeY9i
 s3+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP9V6lb8OU8Mo9fmiez3AZsN64pVnx75shBXqWu94A29SJJJye/DPHMwmlqt4XVonMMrO1nKc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6ZhNqrfKabFHu+ykcb2okK8EJ20XN6NlEXCmw/26JwWLx+cln
 QAJCsq8AupRH5iIkleDUz8swUBvPG1mXqkvqAa3S90bcDRxb0wfYRMo93UnjO3cm6t1++d/Pyzd
 INP2/cmV1//dCffeZTqHwirvJqB67LW1gyjcScDG/6XIFfQsZT74tAIxc
X-Gm-Gg: AZuq6aIB/ycgBJWV99yfg8tVp3Lz5KJESPaYLKWDOeKRwLegh3f9+E8OAwOwRQHDNb5
 M7d4sextyh1JMROYKNTBfxI0tQ2ZtlSProxjN1b0f6LMRSkkNjMJZlwGyEfDJzxgu81bEGVMrIQ
 RJaWqtGSBJo2/A+apZDvkqipw8aM5g5E0BZYhND74AzWG3OM2sTdVJIqL/7McExoXJ3olO+qfqJ
 GZ6Bhl3voMGhYyEZ20Lz7jznzPThRDEKC1LyU2ooqFB5CA46bw6GT500OQVe5ujwwPHDsNVuqSM
 XaZhzxVua08nol2hy7GGqqN2DnP+2lXO9zSnFrOL++dmk+rgSrdAo+MxfgKwhQiMwVlSTsbYeGl
 8/tab1AWvEclMBEXLc0P6fYeB9qjDUqfg8R40FXcPmql6TgqvntPx9yhBsGEcCo7jDMXhdBPB1c
 FrfiftXyvvOYrLM0u0KMgV7ka7NdblgXQc8zVr1A==
X-Received: by 2002:a05:6a00:3693:b0:81c:717b:9d2f with SMTP id
 d2e1a72fcca58-81fa176fafdmr17128670b3a.5.1769063687369; 
 Wed, 21 Jan 2026 22:34:47 -0800 (PST)
X-Received: by 2002:a05:6a00:3693:b0:81c:717b:9d2f with SMTP id
 d2e1a72fcca58-81fa176fafdmr17128646b3a.5.1769063686866; 
 Wed, 21 Jan 2026 22:34:46 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12779desm13803781b3a.39.2026.01.21.22.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 22:34:46 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, varadarajan.narayanan@oss.qualcomm.com,
 gabriel.dalimonte@gmail.com, u-boot@lists.denx.de,
 caleb.connolly@linaro.org
Subject: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
Date: Thu, 22 Jan 2026 12:04:42 +0530
Message-Id: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcWbdBQh c=1 sm=1 tr=0 ts=6971c508 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NdH2wwV_UUrT48UC1CkA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA0MCBTYWx0ZWRfXyLns6w12vkCy
 TafwP+QpuJIA+hwMoq3sbFLIGtZK0PYsicgmBP02EKbcSmcTIfd/pAq7J+KWQV/Fi1xawAJJmQ4
 07Z9l7WS3ewJn8mFFzpHzWkyW+Q9aJzaEYhnDgaGx3KJ2du5incW+nak/ZjVHmY9an2ixBpTJjI
 58OlxY1HOMXVx04hOn2GHnidfGE7WgVAfWulAEOZToCsUh2IgCJhGlebDYcKv47IQnp/vu7gA7q
 F2WgrslZ88ylJ4fdPwA0Uq0HXMVb3R/uYazqzz2KlcfWtfQIuEP5LepL9iNVA74UFAWCa01vjVS
 SEmeiECL4T5g+8LKP4IdNmzIibDNMsEsaGctWdnXGsLGjMpEyZ6jwmAoyTM0qmvM5Czsnel6PcE
 kgMs2QGIC6IbvdSIspnpD/5qaa+RWh68jcIjWd/WEqJa+I0lx2WamzM7QrHYXzAWnNk5qR+S45w
 4F2P3G7DkQ/ULE9hTAg==
X-Proofpoint-ORIG-GUID: DVLITrP81SvtAg0pNsDUdnq6n1ALZ0oJ
X-Proofpoint-GUID: DVLITrP81SvtAg0pNsDUdnq6n1ALZ0oJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220040
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

From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

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
Changes in v3:
- Respin, no changes
- Link to v2: https://lore.kernel.org/u-boot/20241125085213.460723-1-quic_varada@quicinc.com/

Changes in v2:
- fat_sect_size is declared as static
- The else block in disk_write() function has been removed
- The commit message has additional details about testing
- Link to v1: https://lore.kernel.org/u-boot/20241119073048.3469260-1-quic_varada@quicinc.com/
---
 fs/fat/fat.c       | 218 ++++++++++++++++++++++++++++++++++++++++++---
 fs/fat/fat_write.c |  19 ----
 2 files changed, 205 insertions(+), 32 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 9ce5df59f9b..05acd24d8bd 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -45,24 +45,214 @@ static void downcase(char *str, size_t len)
 
 static struct blk_desc *cur_dev;
 static struct disk_partition cur_part_info;
+static int fat_sect_size;
 
 #define DOS_BOOT_MAGIC_OFFSET	0x1fe
 #define DOS_FS_TYPE_OFFSET	0x36
 #define DOS_FS32_TYPE_OFFSET	0x52
 
-static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
+inline __u32 sect_to_block(__u32 sect, __u32 *off)
 {
-	ulong ret;
+	*off = 0;
+	if (fat_sect_size && fat_sect_size < cur_part_info.blksz) {
+		int div = cur_part_info.blksz / fat_sect_size;
+
+		*off = sect % div;
+		return sect / div;
+	} else if (fat_sect_size && (fat_sect_size > cur_part_info.blksz)) {
+		return sect * (fat_sect_size / cur_part_info.blksz);
+	}
 
-	if (!cur_dev)
-		return -1;
+	return sect;
+}
 
-	ret = blk_dread(cur_dev, cur_part_info.start + block, nr_blocks, buf);
+inline __u32 size_to_blocks(__u32 size)
+{
+	return (size + (cur_part_info.blksz - 1)) / cur_part_info.blksz;
+}
 
-	if (ret != nr_blocks)
-		return -1;
+static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
+{
+	int ret;
+	__u8 *block = NULL;
+	__u32 rem, size;
+	__u32 s, n;
 
-	return ret;
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
 }
 
 int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
@@ -581,6 +771,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		return -1;
 	}
 
+	fat_sect_size = 0;
+
 	if (disk_read(0, 1, block) < 0) {
 		debug("Error: reading block\n");
 		ret = -1;
@@ -651,12 +843,12 @@ static int get_fs_info(fsdata *mydata)
 	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
 
 	mydata->sect_size = get_unaligned_le16(bs.sector_size);
+	fat_sect_size = mydata->sect_size;
 	mydata->clust_size = bs.cluster_size;
-	if (mydata->sect_size != cur_part_info.blksz) {
-		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
-			mydata->sect_size, cur_part_info.blksz);
-		return -1;
-	}
+	if (mydata->sect_size != cur_part_info.blksz)
+		log_info("FAT sector size mismatch (fs=%u, dev=%lu)\n",
+			 mydata->sect_size, cur_part_info.blksz);
+
 	if (mydata->clust_size == 0) {
 		log_err("FAT cluster size not set\n");
 		return -1;
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 0b924541187..b686afd32c6 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -192,25 +192,6 @@ out:
 }
 
 static int total_sector;
-static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
-{
-	ulong ret;
-
-	if (!cur_dev)
-		return -1;
-
-	if (cur_part_info.start + block + nr_blocks >
-		cur_part_info.start + total_sector) {
-		printf("error: overflow occurs\n");
-		return -1;
-	}
-
-	ret = blk_dwrite(cur_dev, cur_part_info.start + block, nr_blocks, buf);
-	if (nr_blocks && ret == 0)
-		return -1;
-
-	return ret;
-}
 
 /*
  * Write fat buffer into block device
-- 
2.34.1

