Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29801D711C8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929FF89251;
	Wed, 20 Nov 2024 17:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Myq4e3d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A33B89251; Wed, 20 Nov 2024 17:43:35 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206B389229
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FUDm005773;
 Wed, 20 Nov 2024 16:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=7FtIYlWpCTm9MG00R34O86Of
 Y25MCeZW3UMrXqUKGOw=; b=Myq4e3d5l0I/AgBvDWEuTsPNpyFZ9fRI3GfexKlo
 TSF1njthJzqR5GvOeNUvPN4u6oZ9kLXZfiW88A0VYnmJqSzxBIObVCudtTOyToVm
 6VJnncR9vM2FgeL9kp1/P1Xr5yJjU05PHsTOqf314Brpe0cII94DzoFr2B8gFYC9
 8iXHMIAlzsQ6/V+R52gvtlHVndv1vV1nWtsza7zdrmxl0RjDPD8pOfhOlYazYWyE
 up0B+P71a+4YdZbVvTvAQGm0Xdk8tXWMqVr+frJAr+wGlUxuevJF/wPDg450xaj2
 8K6wr16s3/DAuK0txJQwE9ffwLFZkQXYFe4MVgb8tdvP1A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7xj04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2024 16:43:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKGhO8q014794
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Nov 2024 16:43:24 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 08:43:21 -0800
Date: Wed, 20 Nov 2024 22:13:17 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 <christian.taedcke@weidmueller.com>, <ada@thorsis.com>,
 <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <Zz4RpTSocR/U+4+u@hu-varada-blr.qualcomm.com>
References: <20241119073048.3469260-1-quic_varada@quicinc.com>
 <20241119154436.GW3600562@bill-the-cat>
 <2f5b61a7-9417-49b1-90b7-8aaf25f65cde@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f5b61a7-9417-49b1-90b7-8aaf25f65cde@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: bBow4oSl8w3usvHeMr65ZCZKJJ8rWuUq
X-Proofpoint-GUID: bBow4oSl8w3usvHeMr65ZCZKJJ8rWuUq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411200114
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

On Wed, Nov 20, 2024 at 02:55:48PM +0100, Caleb Connolly wrote:
> Hi both,
>
> Varadarajan: Thanks for sending this patch.
>
> On 19/11/2024 16:44, Tom Rini wrote:
> > On Tue, Nov 19, 2024 at 01:00:48PM +0530, Varadarajan Narayanan wrote:
> >
> >> Do FAT read and write based on the device sector size
> >> instead of the size recorded in the FAT meta data. This
> >> helps to overcome the 'FAT sector size mismatch' error
> >> and enables U-Boot to read/write those partitions.
>
> Does this ignore the filesystem sector size or account for it?

Accounts for it.

> There's a whole lot of logic added below which isn't really
> explained here.

Will post a new version with additional explanation.

> >> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >> ---
> >>  fs/fat/fat.c       | 227 ++++++++++++++++++++++++++++++++++++++++++---
> >>  fs/fat/fat_write.c |  19 ----
> >>  2 files changed, 214 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
> >> index e2570e8167..f4bad99335 100644
> >> --- a/fs/fat/fat.c
> >> +++ b/fs/fat/fat.c
> >> @@ -44,24 +44,223 @@ static void downcase(char *str, size_t len)
> >>
> >>  static struct blk_desc *cur_dev;
> >>  static struct disk_partition cur_part_info;
> >> +int fat_sect_size;
>
> This variable should be static, no harm in 0 initializing it here either.
> >>

Sure.

> [...]
>
> >> +
> >> +int disk_write(__u32 sect, __u32 nr_sect, void *buf)
> >> +{
> >> +	int ret;
> >> +	__u8 *block = NULL;
> >> +	__u32 rem, size;
> >> +	__u32 s, n;
> >> +
> >> +	rem = nr_sect * fat_sect_size;
> >> +	/*
> >> +	 *           block N       block N + 1      block N + 2
> >> +	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >> +	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
> >> +	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >> +	 * . . . |               |               |               | . . .
> >> +	 * ------+---------------+---------------+---------------+------
> >> +	 *            |<--- FAT reads in sectors          --->|
> >> +	 *
> >> +	 *            |  part 1  |   part 2      |  part 3    |
> >> +	 *
> >> +	 */
> >> +
> >> +	/* Do part 1 */
> >> +	if (fat_sect_size) {
> >> +		__u32 offset;
> >> +
> >> +		/* Read one block and overwrite the leading sectors */
> >> +		block = malloc_cache_aligned(cur_dev->blksz);
> >> +		if (!block) {
> >> +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
> >> +			return -1;
> >> +		}
> >> +
> >> +		s = sect_to_block(sect, &offset);
> >> +		offset = offset * fat_sect_size;
> >> +
> >> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> >> +		if (ret != 1) {
> >> +			ret = -1;
> >> +			goto exit;
> >> +		}
> >> +
> >> +		if (rem > (cur_part_info.blksz - offset))
> >> +			size = cur_part_info.blksz - offset;
> >> +		else
> >> +			size = rem;
> >> +
> >> +		memcpy(block + offset, buf, size);
> >> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> >> +		if (ret != 1) {
> >> +			ret = -1;
> >> +			goto exit;
> >> +		}
> >> +
> >> +		rem -= size;
> >> +		buf += size;
> >> +		s++;
> >> +	} else {
> >> +		/*
> >> +		 * fat_sect_size not being set implies, this is the first read
> >> +		 * to partition. The first sector is being read to get the
> >> +		 * FS meta data. The FAT sector size is got from this meta data.
> >> +		 */
>
> This is the disk_write() function though, I don't think this behaviour
> is correct?

Will clean this.

Thanks for the inputs.

-Varada


> >> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
> >> +		if (ret != 1)
> >> +			return -1;
> >> +	}
> >> +
> >> +	/* Do part 2, write directly from the given buffer */
> >> +	if (rem > cur_part_info.blksz) {
> >> +		n = rem / cur_part_info.blksz;
> >> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, n, buf);
> >> +		if (ret != n) {
> >> +			ret = -1;
> >> +			goto exit;
> >> +		}
> >> +		buf += n * cur_part_info.blksz;
> >> +		rem = rem % cur_part_info.blksz;
> >> +		s += n;
> >> +	}
> >> +
> >> +	/* Do part 3, read a block and copy the trailing sectors */
> >> +	if (rem) {
> >> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
> >> +		if (ret != 1) {
> >> +			ret = -1;
> >> +			goto exit;
> >> +		} else {
> >> +			memcpy(block, buf, rem);
> >> +		}
> >> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
> >> +		if (ret != 1) {
> >> +			ret = -1;
> >> +			goto exit;
> >> +		}
> >> +	}
> >> +exit:
> >> +	if (block)
> >> +		free(block);
> >> +
> >> +	return (ret == -1) ? -1 : nr_sect;
> >>  }
>
>
> [...]
>
> Hi Tom,
>
> > With this patch, we now have
> > https://patchwork.ozlabs.org/project/uboot/patch/20241113044956.1836896-1-caleb.connolly@linaro.org/
>
> I suspect my patch would corrupt storage on write, I'll give it another
> test and see.
> > and
> > https://patchwork.ozlabs.org/project/uboot/patch/20230730111516.v2.1.Ia13846500fab3d5a1d5573db11a040d233994fa6@changeid/
> > for seemingly the same issue. Can you please try these other two
> > patches and report which ones do / don't handle your use case as well?
> > Thanks!
> Kind regards,
> >
>
> --
> // Caleb (they/them)
>
