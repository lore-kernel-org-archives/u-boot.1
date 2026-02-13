Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85B2EF48CC
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 05:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2926783015;
	Fri, 13 Feb 2026 06:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pnG3UOGr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFsuvUsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C13D383936; Fri, 13 Feb 2026 06:37:36 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A6F80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D2dcjg2093478
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 05:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=quBYJELYFuehbmaI2bclFr8PEeMx/V28VKB
 N0j3ZhaM=; b=pnG3UOGrB2VZkggtZl0l5/13uNM5cq8AwiDi9h1gOh8cHwDECB3
 QqkmPRoknQaXacy+U1TwdiPZbh20whgIGQGJm3SwaPuagqnmXg1Ih7zRw/A340lO
 3F++QJsr1jM+sD4eJFfhk3IodO0GcQJK0Dia+l8xNAIyWNg0BrA3O3PhfHWwJhDs
 VP8GW4fbvNIiuCZtYUXDCHKNqFcBi3xaxgTMCVzM57PWiI8ZrV0b1j02/yGTy+MN
 U6sPIbEdNegw1nWVeutC3QHrpwu9JmZIuLjouHhSsnqM1uu6xm6gf5zoGYGr/EYb
 3ShOr4haWQc/EqIl2tY+zuiGZqmSKgfVlAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9k6y2aeg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 05:37:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35678f99c6eso495470a91.1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 21:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770961048; x=1771565848; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=quBYJELYFuehbmaI2bclFr8PEeMx/V28VKBN0j3ZhaM=;
 b=QFsuvUshhwcV/4t1GwAPwVVOwXCG+KqSIEfxGE0MyF5CF+zALCw+MhFa4ZX2ZuVKx6
 l/zuSuBPMmB9hJKYk88hVW55B44DotTUTNYA8JUSoLuyGXWS/dh2+vvDGxgFEy0HnszG
 +oJIzE8E521Gy4VKJV6fD7NaQfMbpyZmQbAmG7q7FsyvzeZtrxuKp5mqT9u/g627Im3W
 ql+8+yWwr0gO+2WzCo0Rrw6tmlzdaUWz9Y2/95PTTNMxi4Us66zATeRTntwgSKjwST5f
 QO36bNzxNRJerl1jiOU0ByNZeHnoCxdvP7AK6ckgwvsfZSzzw2bOvkrFqJ/sEXuuvftB
 yIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770961048; x=1771565848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=quBYJELYFuehbmaI2bclFr8PEeMx/V28VKBN0j3ZhaM=;
 b=ed76Q9jP+PYa7uqVHsdN34Lc8xloPCE7C6wqBSOOJlWzvECr7q3lNHbNIrzJdpjqhr
 /crQe02TPFsrlxlDCaURcQwCihEwFGu1U6t1TQr4QYVb9AWXOBVpB0o72tbSrz6AywFd
 Gnmz6MGSvJraz8mxazwSDdByxuWajjVVUYdNo5oONpuEzk8EPBWw0WFH6cWfnyQ/FFgS
 OTpCNwOVS1T0UX69Nq8N+osPe1NPd+f8EHyCEJF9rTnsTStuse2nDLypgzix0YvR7enn
 /UKr1qx8KkElOGicbtnZ3vgC9/fYubkm80KWl6QKVFr2/1C6WB0CtD8JlLla30/yvUL+
 ismQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdOKrdwaNljXDKcIFvti8VniXckKvVjdatvFF53M/etPlXgQAdgeeGVwbNzg+Di8Up9OS45dY=@lists.denx.de
X-Gm-Message-State: AOJu0YwJIOFzIkwlQk5BPq1AEnhQkk2PRLw3CFPEZ3WpjleL1xOF0Daa
 +l6FBrVQjJETeeLFf5r7pth7lVg/mKMrXN6G1UWES10sTAETMB/Kso7WnkJXTeArz2cWeKZqsSH
 53iX8rpgU7hhrMcBfH/Vh8As4K2mxLIOxXk/0dkmz3oeJYb8ABmKKDezE
X-Gm-Gg: AZuq6aIKFWqjkmjCaJJA36TQ1syj4B7bV+RPi5rwJMoxTwqfxZFHpD46fNm7AUmhc4y
 9+qdBThCdxmHPunGGhrWWcEELv8nKGCCOvgj4N+QlTnSB+AllO9S0OKfLoffldxeTZ43a9lkzZ+
 LlsGAqBLF7MO87e086KoYXOYlIJ+C/MPNyfi50F47ldGm0sIcxP6TjS9gEMQ9b51/Ybl8ZtIMCx
 E7xSjNpGxx9mKwyAFoFbzrKx5ygmjUkr51KdOqUJ1AkOR1GQPgW0e90z5uCj2yRoNCJrkLtXmY/
 61W0WPjbuEVrNAnj5fIa7PyaDFSBqm2Pv9TJb9orNiF5O1kF603e6p5xrT78jlX91/VsABYN5m7
 olbEpE65RQUvRgA6OnKWUCAPm28slDLj9j7m9m8sXBFywgbQK9T/xAU/Cn8xRjVxQ3gHH5Wj3VJ
 SWBt+kJVRvgGcawRmI3qPZsDL4QRmDiPjmj90j76X3NuiG3HzozSA=
X-Received: by 2002:a17:90b:4c92:b0:356:1edc:b64 with SMTP id
 98e67ed59e1d1-356aab9a342mr778796a91.8.1770961046868; 
 Thu, 12 Feb 2026 21:37:26 -0800 (PST)
X-Received: by 2002:a17:90b:4c92:b0:356:1edc:b64 with SMTP id
 98e67ed59e1d1-356aab9a342mr778760a91.8.1770961045855; 
 Thu, 12 Feb 2026 21:37:25 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-356a88ac286sm451394a91.14.2026.02.12.21.37.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 21:37:25 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, gabriel.dalimonte@gmail.com, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v4] fs: fat: Handle 'FAT sector size mismatch'
Date: Fri, 13 Feb 2026 11:07:19 +0530
Message-Id: <20260213053719.2590474-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NsTcssdJ c=1 sm=1 tr=0 ts=698eb898 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=YfCOm-DyAAAA:8
 a=5p_tG3gqAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=NdH2wwV_UUrT48UC1CkA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=zQLMK8awuJ6_Hvp-_9Ux:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA0MCBTYWx0ZWRfX68b6xP8blFc2
 04EGCYSfDM8bbdKz05XXRc1AhC51K9158PX/Ga6MdPaRJJfIx3hVd4kalLGWk20whOU7pmXONU9
 YwaUeGe1Pg3bmwG1DeQSIY+0BL4Q+b10rRUnslCw/BKkobsTDEhvymV8xJwFxC469imlHMEVAtm
 LT58JM15Q84S/gmaVqogjP5OK+mDB+yDRU9IAvlja2oKOkOh4jzcWDzByAIPWKnIpXcuJ/n65GL
 1BxJrBvxFGSWqfNgXOGDCkoxSuMeWS0CRbFXN7ZFvfP6HJN7Btv3Lb9S1CedXDxQFIOTZDlb3vy
 J+FM4tyyv7J5Qb+BgFB2POi1aolzWhXyUXAH0CkUU1qw7vJxPfQV4swxHQem4fUSD/FL5rW9mvc
 TVvFW3ws2UTZbk3HiA1iiY9911+oHAT8snZrITCid6fiH53p7qKRsdLvgD92FHPu32b7K4M+B6u
 7rL394ZyTfk82gMjEdw==
X-Proofpoint-GUID: DiXLsOtW8vl7IbEeymkcvPpZ3zuZ5gtc
X-Proofpoint-ORIG-GUID: DiXLsOtW8vl7IbEeymkcvPpZ3zuZ5gtc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130040
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
 fs/fat/fat.c       | 213 ++++++++++++++++++++++++++++++++++++++++++---
 fs/fat/fat_write.c |  19 ----
 2 files changed, 200 insertions(+), 32 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 9ce5df59f9b..af66cf7c98d 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -45,24 +45,209 @@ static void downcase(char *str, size_t len)
 
 static struct blk_desc *cur_dev;
 static struct disk_partition cur_part_info;
+static int fat_sect_size;
 
 #define DOS_BOOT_MAGIC_OFFSET	0x1fe
 #define DOS_FS_TYPE_OFFSET	0x36
 #define DOS_FS32_TYPE_OFFSET	0x52
 
-static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
+static inline __u32 sect_to_block(__u32 sect, __u32 *off)
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
+static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
+{
+	int ret;
+	__u8 *block = NULL;
+	__u32 rem, size;
+	__u32 s, n;
 
-	if (ret != nr_blocks)
-		return -1;
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
 
-	return ret;
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
@@ -581,6 +766,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		return -1;
 	}
 
+	fat_sect_size = 0;
+
 	if (disk_read(0, 1, block) < 0) {
 		debug("Error: reading block\n");
 		ret = -1;
@@ -651,12 +838,12 @@ static int get_fs_info(fsdata *mydata)
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

