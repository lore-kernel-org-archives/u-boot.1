Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFABE64AB6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 15:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17B92894EE;
	Tue,  3 Dec 2024 16:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="T23jDAkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1241894F0; Tue,  3 Dec 2024 16:08:40 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F16588E5C
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 16:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37oIG6008710;
 Tue, 3 Dec 2024 15:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Md/8QbxK0Z8VReBeDUU2WZ0P
 Xx7ACwy+rHMrAHRHhvs=; b=T23jDAkLomaLZNgUxHCfLTGJCOs4rFLM+30Hxw6F
 ytUGNn2IN0dFoBY/I6lvYy7Fu2eRVGZI/hLDy3B89KmoxWDoDNyxvesbky59U59v
 KzTfwnqZxhy+Gds6IPlt3v1sbRgARFgRiQiH/3UpkdXioYRx2fIc6Nz6bukbV4HZ
 ZVJ0jJbpi7hFfdHZlcIt3vnQcFComYK8XH4hZ7ClPws3mlP1261MllVG10ceEiwb
 cp/fD6Olg2NMexc4dCWTEaXosyT+c9pi3+gh97EUp2e3iQKBJv1WvyTOIQFVIaCJ
 S0ygMlI+oTXQ5nLsG1ym8E1XFNT/4O6BpGgJyx5mtIxH2w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437tstgdaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Dec 2024 15:08:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3F8WDv014310
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 3 Dec 2024 15:08:32 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Dec 2024 07:08:29 -0800
Date: Tue, 3 Dec 2024 20:38:25 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <trini@konsulko.com>, <christian.taedcke@weidmueller.com>,
 <ada@thorsis.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <Z08e6RA9st/WmyM0@hu-varada-blr.qualcomm.com>
References: <20241125085213.460723-1-quic_varada@quicinc.com>
 <01c891bc-4fbb-4ef5-aa22-bd10a8ae0aff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <01c891bc-4fbb-4ef5-aa22-bd10a8ae0aff@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 1xKJ80QOk3OP3RJZGbF3-n4ZT-sXOnKM
X-Proofpoint-GUID: 1xKJ80QOk3OP3RJZGbF3-n4ZT-sXOnKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030128
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

On Mon, Nov 25, 2024 at 06:47:48PM +0100, Caleb Connolly wrote:
> Hi Varadarajan,
>
> Thanks for re-spinning this.
>
> On 25/11/2024 09:52, Varadarajan Narayanan wrote:
> > Do FAT read and write based on the device sector size
> > instead of the size recorded in the FAT meta data.
> >
> > FAT code issues i/o in terms of the sector size. Convert that to
> > device sector size before doing the actual i/o. Additionally,
> > handle leading/trailing blocks when the meta data based block
> > no and i/o size is not an exact multiple of the device sector
> > size or vice versa.
> >
> > Tested on UFS device with sector size 4096 and meta data recorded
> > sector size 512.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>
> I'd appreciate it if you could just CC me in the v2, then you don't have
> to reply to the v1 thread.

Sure, will do it from next version.

> It would also be great if you could include a changelog so we can keep
> track of things across versions. Just for future reference.

Main motivation for this respin to address the comments of V1
	* Updated commit description with better explanation
	* Changed 'fat_sect_size' to be static
	* Removed the incorrect read related code in write function

Does this suffice, or should I update this in the commit log and
post a v3? Please let me know.

Thanks
Varada

> Kind regards,
> > ---
> >  fs/fat/fat.c       | 218 ++++++++++++++++++++++++++++++++++++++++++---
> >  fs/fat/fat_write.c |  19 ----
> >  2 files changed, 205 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> > index e2570e8167..efbf892c7a 100644
> > --- a/fs/fat/fat.c
> > +++ b/fs/fat/fat.c
> > @@ -44,24 +44,214 @@ static void downcase(char *str, size_t len)
> >
> >  static struct blk_desc *cur_dev;
> >  static struct disk_partition cur_part_info;
> > +static int fat_sect_size;
> >
> >  #define DOS_BOOT_MAGIC_OFFSET	0x1fe
> >  #define DOS_FS_TYPE_OFFSET	0x36
> >  #define DOS_FS32_TYPE_OFFSET	0x52
> >
> > -static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
> > +inline __u32 sect_to_block(__u32 sect, __u32 *off)
> >  {
> > -	ulong ret;
> > +	*off = 0;
> > +	if (fat_sect_size && fat_sect_size < cur_part_info.blksz) {
> > +		int div = cur_part_info.blksz / fat_sect_size;
> > +
> > +		*off = sect % div;
> > +		return sect / div;
> > +	} else if (fat_sect_size && (fat_sect_size > cur_part_info.blksz)) {
> > +		return sect * (fat_sect_size / cur_part_info.blksz);
> > +	}
> >
> > -	if (!cur_dev)
> > -		return -1;
> > +	return sect;
> > +}
> >
> > -	ret = blk_dread(cur_dev, cur_part_info.start + block, nr_blocks, buf);
> > +inline __u32 size_to_blocks(__u32 size)
> > +{
> > +	return (size + (cur_part_info.blksz - 1)) / cur_part_info.blksz;
> > +}
> >
> > -	if (ret != nr_blocks)
> > -		return -1;
> > +static int disk_read(__u32 sect, __u32 nr_sect, void *buf)
> > +{
> > +	int ret;
> > +	__u8 *block = NULL;
> > +	__u32 rem, size;
> > +	__u32 s, n;
> >
> > -	return ret;
> > +	rem = nr_sect * fat_sect_size;
> > +	/*
> > +	 *           block N       block N + 1      block N + 2
> > +	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > +	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
> > +	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > +	 * . . . |               |               |               | . . .
> > +	 * ------+---------------+---------------+---------------+------
> > +	 *            |<--- FAT reads in sectors          --->|
> > +	 *
> > +	 *            |  part 1  |   part 2      |  part 3    |
> > +	 *
> > +	 */
> > +
> > +	/* Do part 1 */
> > +	if (fat_sect_size) {
> > +		__u32 offset;
> > +
> > +		/* Read one block and copy out the leading sectors */
> > +		block = malloc_cache_aligned(cur_dev->blksz);
> > +		if (!block) {
> > +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> > +			return -1;
> > +		}
> > +
> > +		s = sect_to_block(sect, &offset);
> > +		offset = offset * fat_sect_size;
> > +
> > +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> > +		if (ret != 1) {
> > +			ret = -1;
> > +			goto exit;
> > +		}
> > +
> > +		if (rem > (cur_part_info.blksz - offset))
> > +			size = cur_part_info.blksz - offset;
> > +		else
> > +			size = rem;
> > +
> > +		memcpy(buf, block + offset, size);
> > +		rem -= size;
> > +		buf += size;
> > +		s++;
> > +	} else {
> > +		/*
> > +		 * fat_sect_size not being set implies, this is the first read
> > +		 * to partition. The first sector is being read to get the
> > +		 * FS meta data. The FAT sector size is got from this meta data.
> > +		 */
> > +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
> > +		if (ret != 1)
> > +			return -1;
> > +	}
> > +
> > +	/* Do part 2, read directly into the given buffer */
> > +	if (rem > cur_part_info.blksz) {
> > +		n = rem / cur_part_info.blksz;
> > +		ret = blk_dread(cur_dev, cur_part_info.start + s, n, buf);
> > +		if (ret != n) {
> > +			ret = -1;
> > +			goto exit;
> > +		}
> > +		buf += n * cur_part_info.blksz;
> > +		rem = rem % cur_part_info.blksz;
> > +		s += n;
> > +	}
> > +
> > +	/* Do part 3, read a block and copy the trailing sectors */
> > +	if (rem) {
> > +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> > +		if (ret != 1) {
> > +			ret = -1;
> > +			goto exit;
> > +		} else {
> > +			memcpy(buf, block, rem);
> > +		}
> > +	}
> > +exit:
> > +	if (block)
> > +		free(block);
> > +
> > +	return (ret == -1) ? -1 : nr_sect;
> > +}
> > +
> > +int disk_write(__u32 sect, __u32 nr_sect, void *buf)
> > +{
> > +	int ret;
> > +	__u8 *block = NULL;
> > +	__u32 rem, size;
> > +	__u32 s, n;
> > +
> > +	rem = nr_sect * fat_sect_size;
> > +	/*
> > +	 *           block N       block N + 1      block N + 2
> > +	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > +	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
> > +	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> > +	 * . . . |               |               |               | . . .
> > +	 * ------+---------------+---------------+---------------+------
> > +	 *            |<--- FAT reads in sectors          --->|
> > +	 *
> > +	 *            |  part 1  |   part 2      |  part 3    |
> > +	 *
> > +	 */
> > +
> > +	/* Do part 1 */
> > +	if (fat_sect_size) {
> > +		__u32 offset;
> > +
> > +		/* Read one block and overwrite the leading sectors */
> > +		block = malloc_cache_aligned(cur_dev->blksz);
> > +		if (!block) {
> > +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> > +			return -1;
> > +		}
> > +
> > +		s = sect_to_block(sect, &offset);
> > +		offset = offset * fat_sect_size;
> > +
> > +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> > +		if (ret != 1) {
> > +			ret = -1;
> > +			goto exit;
> > +		}
> > +
> > +		if (rem > (cur_part_info.blksz - offset))
> > +			size = cur_part_info.blksz - offset;
> > +		else
> > +			size = rem;
> > +
> > +		memcpy(block + offset, buf, size);
> > +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> > +		if (ret != 1) {
> > +			ret = -1;
> > +			goto exit;
> > +		}
> > +
> > +		rem -= size;
> > +		buf += size;
> > +		s++;
> > +	}
> > +
> > +	/* Do part 2, write directly from the given buffer */
> > +	if (rem > cur_part_info.blksz) {
> > +		n = rem / cur_part_info.blksz;
> > +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, n, buf);
> > +		if (ret != n) {
> > +			ret = -1;
> > +			goto exit;
> > +		}
> > +		buf += n * cur_part_info.blksz;
> > +		rem = rem % cur_part_info.blksz;
> > +		s += n;
> > +	}
> > +
> > +	/* Do part 3, read a block and copy the trailing sectors */
> > +	if (rem) {
> > +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> > +		if (ret != 1) {
> > +			ret = -1;
> > +			goto exit;
> > +		} else {
> > +			memcpy(block, buf, rem);
> > +		}
> > +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> > +		if (ret != 1) {
> > +			ret = -1;
> > +			goto exit;
> > +		}
> > +	}
> > +exit:
> > +	if (block)
> > +		free(block);
> > +
> > +	return (ret == -1) ? -1 : nr_sect;
> >  }
> >
> >  int fat_set_blk_dev(struct blk_desc *dev_desc, struct disk_partition *info)
> > @@ -575,6 +765,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
> >  		return -1;
> >  	}
> >
> > +	fat_sect_size = 0;
> > +
> >  	if (disk_read(0, 1, block) < 0) {
> >  		debug("Error: reading block\n");
> >  		ret = -1;
> > @@ -645,12 +837,12 @@ static int get_fs_info(fsdata *mydata)
> >  	mydata->rootdir_sect = mydata->fat_sect + mydata->fatlength * bs.fats;
> >
> >  	mydata->sect_size = get_unaligned_le16(bs.sector_size);
> > +	fat_sect_size = mydata->sect_size;
> >  	mydata->clust_size = bs.cluster_size;
> > -	if (mydata->sect_size != cur_part_info.blksz) {
> > -		log_err("FAT sector size mismatch (fs=%u, dev=%lu)\n",
> > -			mydata->sect_size, cur_part_info.blksz);
> > -		return -1;
> > -	}
> > +	if (mydata->sect_size != cur_part_info.blksz)
> > +		log_info("FAT sector size mismatch (fs=%u, dev=%lu)\n",
> > +			 mydata->sect_size, cur_part_info.blksz);
> > +
> >  	if (mydata->clust_size == 0) {
> >  		log_err("FAT cluster size not set\n");
> >  		return -1;
> > diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> > index ea877ee917..f7a210d790 100644
> > --- a/fs/fat/fat_write.c
> > +++ b/fs/fat/fat_write.c
> > @@ -192,25 +192,6 @@ out:
> >  }
> >
> >  static int total_sector;
> > -static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
> > -{
> > -	ulong ret;
> > -
> > -	if (!cur_dev)
> > -		return -1;
> > -
> > -	if (cur_part_info.start + block + nr_blocks >
> > -		cur_part_info.start + total_sector) {
> > -		printf("error: overflow occurs\n");
> > -		return -1;
> > -	}
> > -
> > -	ret = blk_dwrite(cur_dev, cur_part_info.start + block, nr_blocks, buf);
> > -	if (nr_blocks && ret == 0)
> > -		return -1;
> > -
> > -	return ret;
> > -}
> >
> >  /*
> >   * Write fat buffer into block device
>
> --
> // Caleb (they/them)
>
