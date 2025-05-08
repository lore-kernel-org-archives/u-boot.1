Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D812C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 05:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DBA81FAB;
	Thu,  8 May 2025 07:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="jhZ6Z0Gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 555D48210D; Thu,  8 May 2025 07:24:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6A398059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 07:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5484XDOs009383;
 Thu, 8 May 2025 05:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Un7E0fdbW8fiMxCFkBmGWZTK
 uWVJX5f0nlr/Sw5/2so=; b=jhZ6Z0Gmr3ti2mciKzba1HQnQcT+vQiICJxBfHTT
 GIozaRWok/udMRcduf9hhxFLcgsNdvNGQ8cDpLJo6qB3vnLixG28h47cGzWs5/dq
 5Zz4pYD5E48mL/R3pvhJBJm0QmZK3+sHI8ycX7+SmiIJB8eb2jhY1s5gw3oJM22P
 CgIg/ToGej0Hrxli4Soxxa8niX2P5hBl0/Kmfvj0RCRb1oEbSgVtwVjqcfkYAS2L
 7zd4h7nNqbnLCzLvQ5GVhyi2HG2SoO8uVeQRY1QZQ74Mq0mWfHABbyb5f2ckwPsH
 1sPhBK0vm4EuoBhN7relFk6Kf6NGuQLpo7gNyw58jXRwyA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnper3d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 05:23:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5485Nqji029019
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 May 2025 05:23:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 22:23:48 -0700
Date: Thu, 8 May 2025 10:53:44 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <avromanov@salutedevices.com>,
 <michael@amarulasolutions.com>, <hs@denx.de>, <sjg@chromium.org>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <xypron.glpk@gmx.de>, <cniedermaier@dh-electronics.com>,
 <ansuelsmth@gmail.com>, <venkatesh.abbarapu@amd.com>,
 <ilias.apalodimas@linaro.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/4] disk: part: implement generic function
 part_get_info_by_uuid()
Message-ID: <20250508052344.53pafaulmuu674f3@hu-varada-blr.qualcomm.com>
References: <20250507112812.3066301-1-quic_varada@quicinc.com>
 <20250507112812.3066301-2-quic_varada@quicinc.com>
 <16a681a0-e272-4a41-8391-75135959ad00@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16a681a0-e272-4a41-8391-75135959ad00@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA0MyBTYWx0ZWRfXyow7DXKAglDg
 lp41tVJHGzO+reTXthvxh5dd177lKeGn3t97RLfAia5YFNQAX5niH5ixTr5Ecbnw8UdV12KKgc1
 uLiPFriz+klxWF+C9gpR7uadNFCw0JbVdSuBpm6Dod+GSfhheuiSPmlyErXCh2w6Z7QIdbhVVBB
 u8aBN794xETiNfpezk0PIvzd9jNONJHXJHfsQctr54kicUs4EAgswQCs7yXYr+OgBA+4hFuFccs
 5PrYWpciHjB/1Ny+OQiR6Gu+xuFHBE6qWiO1gTN6Y3eD5lK/QZz9kmFywC2mJbUP2LQErJtNNyi
 H0fBg3qRxRjNSLY53MFS2Cv53c8WVE3V/5sZuUj/fMeEeHWckzcx3tQiKxa7TCxPEBEmEFDaG0v
 pWmjNsu7TdiLNcQkyoRKIOc1mKtcpfCACJLZ8UrzCNtdSWKHEDqJJAMt40c5GrdWgTFSqK/i
X-Proofpoint-ORIG-GUID: OjxDYDSK2HakOA9uVPgbRR59Esl2BS--
X-Proofpoint-GUID: OjxDYDSK2HakOA9uVPgbRR59Esl2BS--
X-Authority-Analysis: v=2.4 cv=Yt4PR5YX c=1 sm=1 tr=0 ts=681c3fea cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=YfCOm-DyAAAA:8
 a=COk6AnOGAAAA:8 a=5DVAiE9d6tFzlBzgXmUA:9 a=CjuIK1q_8ugA:10
 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080043
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

On Wed, May 07, 2025 at 01:47:40PM +0200, Casey Connolly wrote:
> Hi Varadarajan,
>
> On 5/7/25 13:28, Varadarajan Narayanan wrote:
> > Add function to search for a partition by UUID as partition
> > names may not be unique.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >   disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
> >   include/part.h | 20 ++++++++++++++++++++
> >   2 files changed, 57 insertions(+)
> >
> > diff --git a/disk/part.c b/disk/part.c
> > index 303178161c0..abae79a55a7 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -698,6 +698,43 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
> >   	return -ENOENT;
> >   }
> > +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> > +			  struct disk_partition *info)
> > +{
> > +#if CONFIG_IS_ENABLED(PARTITION_UUIDS)
>
> Please refer to checkpatch output (the b4 tool will run this for you
> automatically).

Ok

> 	if (!CONFIG_IS_ENABLED(PARTITION_UUIDS))
> 		return -ENOENT;
>
> > +	struct part_driver *part_drv;
> > +	int ret;
> > +	int i;
> > +
> > +	part_drv = part_driver_lookup_type(desc);
> > +	if (!part_drv)
> > +		return -1;
> > +
> > +	if (!part_drv->get_info) {
> > +		log_debug("## Driver %s does not have the get_info() method\n",
> > +			  part_drv->name);
> > +		return -ENOSYS;
> > +	}
> > +
> > +	for (i = 1; i < part_drv->max_entries; i++) {
> > +		ret = part_drv->get_info(desc, i, info);
> > +		if (ret != 0) {
> > +			/*
> > +			 * Partition with this index can't be obtained, but
> > +			 * further partitions might be, so keep checking.
> > +			 */
> > +			continue;
>
> For part_efi (which is the only one relevant here I think?) you can check
> for -EPERM which signals the end of the partition list I believe. Then we
> aren't calling get_info() 128 times for every LUN...

This is a replica of part_get_info_by_name() - [1]. Not sure why it has
it that way and didn't want to miss corner cases (if any). Please let
me know if still you would prefer to change to check for -EPERM.

Thanks
Varada

1 - https://source.denx.de/u-boot/u-boot/-/blob/master/disk/part.c?ref_type=heads#L685

> +		}
> > +
> > +		if (!strncasecmp(uuid, disk_partition_uuid(info), UUID_STR_LEN)) {
> > +			/* matched */
> > +			return i;
> > +		}
> > +	}
> > +#endif
> > +	return -ENOENT;
> > +}
> > +
> >   /**
> >    * Get partition info from device number and partition name.
> >    *
> > diff --git a/include/part.h b/include/part.h
> > index fcb3c13dea4..3e6eb0ec33f 100644
> > --- a/include/part.h
> > +++ b/include/part.h
> > @@ -315,6 +315,20 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
> >   int part_get_info_by_name(struct blk_desc *desc, const char *name,
> >   			  struct disk_partition *info);
> > +/**
> > + * part_get_info_by_uuid() - Search for a partition by uuid
> > + *                           among all available registered partitions
> > + *
> > + * @desc:	block device descriptor
> > + * @uuid:	the specified table entry uuid
> > + * @info:	the disk partition info
> > + *
> > + * Return: the partition number on match (starting on 1), -ENOENT on no match,
> > + * otherwise error
> > + */
> > +int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> > +			  struct disk_partition *info);
> > +
> >   /**
> >    * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
> >    *					    and part name, or dev number and
> > @@ -386,6 +400,12 @@ static inline int part_get_info_by_name(struct blk_desc *desc, const char *name,
> >   	return -ENOENT;
> >   }
> > +static inline int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
> > +					struct disk_partition *info)
> > +{
> > +	return -ENOENT;
> > +}
> > +
> >   static inline int
> >   part_get_info_by_dev_and_name_or_num(const char *dev_iface,
> >   				     const char *dev_part_str,
>
> --
> Casey (she/they)
>
