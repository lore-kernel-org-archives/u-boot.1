Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC86CEFB7F1
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 03:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C513E83BC9;
	Tue, 24 Feb 2026 04:50:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k7b++chY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UynsvBR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6E283C8C; Tue, 24 Feb 2026 04:50:20 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952A183BC9
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 04:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61O3Krji1396551
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=dpDNU33plnW
 dqPx7vR7sWcIzX4EqFR8dxRtifjmYAt8=; b=k7b++chYy3JqukQyC3fGuceSJt4
 JT7c23FbrC65auntf7BHYBz72LP1H5r/np2gavSDK4SRshjKmryMHrBSk5IkiVUQ
 kR6VEdoV9PVhn+SEHZ2DNrPPPoPsqiGpWwCFPTBek+jTSzhTvhffnjbLqL+ErUei
 Tmz7lAuwxjAWIwRnnn348muqU2t8Zin12CaCHAyCKZqYaBvvpnGxXu7x/BuyEEN7
 SUCkwQCxWkSrjJhSNsHf0i+cR1yw9Lj3VlLT9LLMZm++st2FzEMA6BWIi1gohQji
 mkkekFl0pxwjuaAYsBy0aZrRC+ZV7paNFyfbbNgvSpOJNjKDmgPS4W+v6wA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtx09mh2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 03:50:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2adaa9c4b89so1524835ad.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 19:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771905016; x=1772509816; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpDNU33plnWdqPx7vR7sWcIzX4EqFR8dxRtifjmYAt8=;
 b=UynsvBR/YJCDMb+CPtJrbOVoSA/O70x0BJB3X7f+b41ecOlLXFfXegGy96Zo4U6pZj
 t2GSbaB3XAWRDVOZlm4QXD6J8H1xjDG6WPH5LpczPZm04CtTZarx3npGyEHFWUM/ZbeA
 Luy9ogd9nVSqsWd2dG6umvplDg+Yedyb3E9MCgCy7ETBUXRJ660JdGe1rXcoiPaZwRV+
 45hM+rTL2ZZc6v66XUYrPOqIyhPpg0Q6QX8ugjBxXByXavtFykdwu/Qhv0sc5C0SwvMC
 AEWpcp9I782Z4GazRkl/5lAqFbYunWmkdMyYyOmtWoDToZLQwK3Go91awykCe6755pGh
 GhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771905016; x=1772509816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dpDNU33plnWdqPx7vR7sWcIzX4EqFR8dxRtifjmYAt8=;
 b=B8AKTq8GazlwADpo1duaJfN2IsoLHYluByAqvDTVPeGT8HjdHqG9BE0x9V9BPhk/k5
 ANKnVjcGBgKzLa2lltzB9qwILlmBQMh525rOAVPuxZrHZ7ANOrnnQoxacM0I9qsPo3G7
 HATj4tiKP88LZ7qE2BxgQcvK4CTR0QZvul+xn+CMVkBcvstBJvdG3p7Fbk3nV/QC4u33
 TddQp2jGSF48oA41HiAexM09q1Fm4akfKzhLJY46a81n2j3KzJyNpAbz8BfayfyduXIg
 mAobKlrJOlz+5HvmpJuxgS/XmdWWv3QpZMKmCnHPejlh5srnypKHg43g7qitz70tlkhQ
 xXGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbrsga5mLWutcHVtfProPGmizJ1rJHOdPFPKofYmDA5d1tYMUl2uakaBK/sl8MPxeEffIrYzs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywq1breHad5LDLgwA7Y+zZTsZ30FnQufvNXY+A6WC5tMZ3RC0Dg
 U4niWRYTq7TYoMHH/J2tvMLTN6bium5qtAEURB6oR0chK1OVywy678lhTPL0BsmwbLfwEbiItPb
 NxvIDajYWb7QUZGIiwJk/RHr9jmvvzx9yL1JU6i2skfXhiyxvd0oP/0KD
X-Gm-Gg: ATEYQzwu0Y2GH8rgNT6WyEK5hSdZ9aSmAwxddPgOHyUWNseMy5Hy737mUKT/bErkLAf
 I9cRUwP1OdtdGZM6Bz4ZOvf8aqguVyraOwRC8y051L4o8a1GUGFeGPvTtXyd0bhx5Ll4dljXsnE
 S/Lz8qbw5YScKEUH/TqWN6CNVA1F6HIy2qfMLLZfJlU/A06C4J4DnP816kp33DKZZ6VnvamVUtT
 Czdx8wv6DQ3/gIhXd8CgFOrEdHLlw1ZJfWf18eXiNNbPV8dCceiPl+nid9+PRAXd9Bz1TCOVveo
 gsGy+qUAdbmsA+CZlVjpGSATYqxxz0HFsx0CjnImz+vLFT5OXUsgxYlHtVx4h3e3xOFztr/F9w5
 LtWyiWpvbk77T9LwvdF8WmZ1u9oKY0gG2HYbroLZFVhXikddS3jaoNI3C6LEcXAD8Rb6CIi+aRx
 0CD7ivWyf7wQVkxqcxHTCPUUi4vnE4R9J6WJBHglavFb6CQRws4w8=
X-Received: by 2002:a17:902:d541:b0:2a7:a1f3:f327 with SMTP id
 d9443c01a7336-2ad5f79f206mr133803825ad.20.1771905015796; 
 Mon, 23 Feb 2026 19:50:15 -0800 (PST)
X-Received: by 2002:a17:902:d541:b0:2a7:a1f3:f327 with SMTP id
 d9443c01a7336-2ad5f79f206mr133803635ad.20.1771905015315; 
 Mon, 23 Feb 2026 19:50:15 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad75027affsm86037945ad.66.2026.02.23.19.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 19:50:14 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, christopher.obbard@linaro.org,
 marek.vasut+renesas@mailbox.org, me@samcday.com,
 varadarajan.narayanan@oss.qualcomm.com, gabriel.dalimonte@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com
Subject: [PATCH v6 1/2] fs: fat: Handle 'FAT sector size mismatch'
Date: Tue, 24 Feb 2026 09:19:59 +0530
Message-Id: <20260224035000.1617869-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260224035000.1617869-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ala-H-S-vknVk4KS9w8JuDU_niyHa-gM
X-Authority-Analysis: v=2.4 cv=euvSD4pX c=1 sm=1 tr=0 ts=699d1ff8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=aUwB5lpW5mkkpEcbIREA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Ala-H-S-vknVk4KS9w8JuDU_niyHa-gM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAyOSBTYWx0ZWRfX8mby0z2/K5og
 qSKVLpAoi6wIHSOa9bDmEgVbN8ju619hDzC79UbbtsOeumVM3sADc2sM79sOUacHRRL23ALUIHK
 4JD9wIaYQDkLu4LGZDb4s1tq6Ndl7iVaC3s8oNtkeHk/V/U5kLYU/C9SdYfwY5L+AopbuPDdpQH
 oFw17CK4c3xWvU+VkCC6p5OzoxhzYGqg6M+LyCCqD8Qq504v0TT89icI3mLS04iFskPYNNhz/8t
 THu/78sdjYEWqSVw7K8aJHEL0t67ejzHrRGGLno7ahKXSByHG01Tw5DBOZ59VFFcRmQ0p1OOe8N
 pLtfOAy19Hn+MhQB24bXTB4i9YSpKrS13z68oO9SWcKu/EhWJEuSs+ltafBcW56sQOPL8GSLKqN
 sA88vhdImfKbJJaKHrgBwneENNrfWBvUSO3kxxYLja8G4IpdrPGItB1GwayxXj91jmznP7ROtVk
 g76cWEalggAGSfE48TA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602240029
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

The disk_read() and disk_write() functions of the FAT driver use the
blk_dread() and blk_dwrite() respectively. The blk_* APIs read and write
to the devices in terms of the device block size. However, the FAT
driver reads in terms of the device block size (from fat_set_blk_dev and
read_bootsectandvi) and sector size in the rest of the places.

This causes buffer overflows or partial reads when the FAT sector size
is not equal to device block size. Fix this by using blk_dread in
fat_set_blk_dev and read_bootsectandvi instead of disk_read. And update
disk_read/disk_write to handle FAT sector size and block size mismatch.

Tested on
	blksz | FAT sector size
	------+----------------
	4096  | 4096
	512   | 512
	4096  | 512
	512   | 4096

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 fs/fat/Kconfig     |   8 +++
 fs/fat/fat.c       | 152 +++++++++++++++++++++++++++++++++++++++++++--
 fs/fat/fat_write.c |   2 +
 3 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 19d52238713..9606fa48bbe 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -29,3 +29,11 @@ config FS_FAT_MAX_CLUSTSIZE
 	  is the smallest amount of disk space that can be used to hold a
 	  file. Unless you have an extremely tight memory memory constraints,
 	  leave the default.
+
+config FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH
+	bool "Handle FAT sector size mismatch"
+	default n
+	depends on FS_FAT
+	help
+	  Handle filesystems on media where the hardware block size and
+          the sector size in the FAT metadata do not match.
diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 9ce5df59f9b..85b511f75af 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -45,11 +45,146 @@ static void downcase(char *str, size_t len)
 
 static struct blk_desc *cur_dev;
 static struct disk_partition cur_part_info;
+static int fat_sect_size;
 
 #define DOS_BOOT_MAGIC_OFFSET	0x1fe
 #define DOS_FS_TYPE_OFFSET	0x36
 #define DOS_FS32_TYPE_OFFSET	0x52
 
+#if IS_ENABLED(CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH)
+static inline __u32 sect_to_block(__u32 sect, __u32 *off)
+{
+	const ulong blksz = cur_part_info.blksz;
+
+	*off = 0;
+	if (fat_sect_size && fat_sect_size < blksz) {
+		int div = blksz / fat_sect_size;
+
+		*off = sect % div;
+		return sect / div;
+	} else if (fat_sect_size && (fat_sect_size > blksz)) {
+		return sect * (fat_sect_size / blksz);
+	}
+
+	return sect;
+}
+
+static int disk_rw(__u32 sect, __u32 nr_sect, void *buf, bool read)
+{
+	int ret;
+	__u8 *block = NULL;
+	__u32 rem, size, s, n;
+	const ulong blksz = cur_part_info.blksz;
+	const lbaint_t start = cur_part_info.start;
+
+	rem = nr_sect * fat_sect_size;
+	/*
+	 *           block N       block N + 1      block N + 2
+	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
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
+		ret = blk_dread(cur_dev, start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		}
+
+		if (rem > (blksz - offset))
+			size = blksz - offset;
+		else
+			size = rem;
+
+		if (read) {
+			memcpy(buf, block + offset, size);
+		} else {
+			memcpy(block + offset, buf, size);
+			ret = blk_dwrite(cur_dev, start + s, 1, block);
+			if (ret != 1) {
+				ret = -1;
+				goto exit;
+			}
+		}
+
+		rem -= size;
+		buf += size;
+		s++;
+	}
+
+	/* Do part 2, read/write directly to/from the given buffer */
+	if (rem > blksz) {
+		n = rem / blksz;
+
+		if (read)
+			ret = blk_dread(cur_dev, start + s, n, buf);
+		else
+			ret = blk_dwrite(cur_dev, start + s, n, buf);
+
+		if (ret != n) {
+			ret = -1;
+			goto exit;
+		}
+		buf += n * blksz;
+		rem = rem % blksz;
+		s += n;
+	}
+
+	/* Do part 3, read a block and copy the trailing sectors */
+	if (rem) {
+		ret = blk_dread(cur_dev, start + s, 1, block);
+		if (ret != 1) {
+			ret = -1;
+			goto exit;
+		}
+		if (read) {
+			memcpy(buf, block, rem);
+		} else {
+			memcpy(block, buf, rem);
+			ret = blk_dwrite(cur_dev, start + s, 1, block);
+			if (ret != 1) {
+				ret = -1;
+				goto exit;
+			}
+		}
+	}
+exit:
+	if (block)
+		free(block);
+
+	return (ret == -1) ? -1 : nr_sect;
+}
+
+static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
+{
+	return disk_rw(sect, nr_sect, buf, true);
+}
+
+int disk_write(__u32 sect, __u32 nr_sect, void *buf)
+{
+	return disk_rw(sect, nr_sect, buf, false);
+}
+#else
 static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
 {
 	ulong ret;
@@ -64,6 +199,7 @@ static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
 
 	return ret;
 }
+#endif /* CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH */
 
 int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
 {
@@ -73,7 +209,7 @@ int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
 	cur_part_info = *info;
 
 	/* Make sure it has a valid FAT header */
-	if (disk_read(0, 1, buffer) != 1) {
+	if (blk_dread(cur_dev, cur_part_info.start, 1, buffer) != 1) {
 		cur_dev = NULL;
 		return -1;
 	}
@@ -581,7 +717,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		return -1;
 	}
 
-	if (disk_read(0, 1, block) < 0) {
+	fat_sect_size = 0;
+	if (blk_dread(cur_dev, cur_part_info.start, 1, block) != 1) {
 		debug("Error: reading block\n");
 		ret = -1;
 		goto out_free;
@@ -651,11 +788,16 @@ static int get_fs_info(fsdata *mydata)
 	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
 
 	mydata->sect_size = get_unaligned_le16(bs.sector_size);
+	fat_sect_size = mydata->sect_size;
 	mydata->clust_size = bs.cluster_size;
 	if (mydata->sect_size != cur_part_info.blksz) {
-		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
-			mydata->sect_size, cur_part_info.blksz);
-		return -1;
+		if (!IS_ENABLED(CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH)) {
+			log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
+				mydata->sect_size, cur_part_info.blksz);
+			return -1;
+		}
+		log_info("FAT sector size mismatch (fs=%u, dev=%lu)\n",
+			 mydata->sect_size, cur_part_info.blksz);
 	}
 	if (mydata->clust_size == 0) {
 		log_err("FAT cluster size not set\n");
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 0b924541187..02e006f7c9e 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -192,6 +192,7 @@ out:
 }
 
 static int total_sector;
+#if !IS_ENABLED(CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH)
 static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 {
 	ulong ret;
@@ -211,6 +212,7 @@ static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 
 	return ret;
 }
+#endif /* CONFIG_FS_FAT_HANDLE_SECTOR_SIZE_MISMATCH */
 
 /*
  * Write fat buffer into block device
-- 
2.34.1

