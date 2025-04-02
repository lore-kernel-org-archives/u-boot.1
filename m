Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD7FC28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A424981CF0;
	Wed,  2 Apr 2025 17:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="dvQCD1tG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FA281E1F; Wed,  2 Apr 2025 17:56:53 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7219580FDA
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532ATYQf014402;
 Wed, 2 Apr 2025 15:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VMxQMDM1n2yPA88YMMaxuXFS
 CMwaaKqyL8xHBsH1Vdk=; b=dvQCD1tG++SFeuzMHFKTtynkRjLSz5SrKeoElR+0
 mx+LlLwrRJqTLtInOsBRmC7gqxsDYM7mb/U6Sfyam6BUOAmynf6pLRrrVICeaVmi
 Ofejr9SGZQNVHt/f1+9m6OzODajqn3ttyFWvHUDpysy0uqJ+VCtNriYJx59oi51I
 XXQEcuIll+P/jwjO50lJWFv04enVcZRRWboMx0i2f1vZ55iwi2CLyQkRHSbMy3EK
 BVrPsqJWb/DtNvLPYln8JEUNw8ciymmwNPCuiSxPt4cqA4/Q3NjJ+Mc5jz8kY2Hg
 vHacE46S7FeN0gpj9eGZaSF+FNQHYJ6nkgHFVhJb4DMXFQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7tvkyxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 02 Apr 2025 15:56:28 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 532FuSML019594
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 2 Apr 2025 15:56:28 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Apr 2025 08:56:24 -0700
Date: Wed, 2 Apr 2025 21:26:21 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <caleb.connolly@linaro.org>, <neil.armstrong@linaro.org>,
 <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <michal.simek@amd.com>,
 <marek.vasut+renesas@mailbox.org>, <cniedermaier@dh-electronics.com>,
 <sjg@chromium.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/3] scsi: Implement get_blk() function
Message-ID: <Z+1eJULkwOWl6ZCB@hu-varada-blr.qualcomm.com>
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
 <20250401080015.1470999-2-quic_varada@quicinc.com>
 <7e90eee8-990d-4f80-b918-a53f1ef30e22@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e90eee8-990d-4f80-b918-a53f1ef30e22@gmx.de>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=67ed5e2d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8
 a=-loAjjW0pCZ9fMcQaYcA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: OeBF9Hv-x6C160k1Xh_jprHBDQDOA1_z
X-Proofpoint-GUID: OeBF9Hv-x6C160k1Xh_jprHBDQDOA1_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020101
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

On Tue, Apr 01, 2025 at 06:29:31PM +0200, Heinrich Schuchardt wrote:
> On 01.04.25 10:00, Varadarajan Narayanan wrote:
> > Add a function to obtain the block device for SCSI.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >   drivers/scsi/scsi-uclass.c | 30 ++++++++++++++++++++++++++++++
> >   include/scsi.h             | 12 ++++++++++++
> >   2 files changed, 42 insertions(+)
> >
> > diff --git a/drivers/scsi/scsi-uclass.c b/drivers/scsi/scsi-uclass.c
> > index 1ee8236c05c..c2e34082bce 100644
> > --- a/drivers/scsi/scsi-uclass.c
> > +++ b/drivers/scsi/scsi-uclass.c
> > @@ -10,7 +10,9 @@
> >
> >   #define LOG_CATEGORY UCLASS_SCSI
> >
> > +#include <blk.h>
> >   #include <dm.h>
> > +#include <part.h>
> >   #include <scsi.h>
> >
> >   int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> > @@ -23,6 +25,34 @@ int scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
> >   	return ops->exec(dev, pccb);
> >   }
> >
> > +int scsi_get_blk(const char *partition_name,
> > +		 struct blk_desc **blk_desc_ptr,
> > +		 struct disk_partition *part_info_ptr)
> > +{
> > +	static int is_scsi_scanned;
> > +	struct blk_desc *blk;
> > +	int i, ret;
> > +
> > +	if (!is_scsi_scanned) {
> > +		scsi_scan(false /* no verbose */);
> > +		is_scsi_scanned = 1;
> > +	}
> > +
> > +	for (i = 0; i < blk_find_max_devnum(UCLASS_SCSI) + 1; i++) {
> > +		ret = blk_get_desc(UCLASS_SCSI, i, &blk);
> > +		if (ret)
> > +			continue;
> > +
> > +		ret = part_get_info_by_name(blk, partition_name, part_info_ptr);
> > +		if (ret > 0) {
> > +			*blk_desc_ptr = blk;
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> >   int scsi_bus_reset(struct udevice *dev)
> >   {
> >   	struct scsi_ops *ops = scsi_get_ops(dev);
> > diff --git a/include/scsi.h b/include/scsi.h
> > index b18ae37b861..1ba55516588 100644
> > --- a/include/scsi.h
> > +++ b/include/scsi.h
> > @@ -9,6 +9,7 @@
> >   #include <asm/cache.h>
> >   #include <bouncebuf.h>
> >   #include <linux/dma-direction.h>
> > +#include <part.h>
> >
> >   struct udevice;
> >
> > @@ -349,6 +350,17 @@ int scsi_scan(bool verbose);
> >    */
> >   int scsi_scan_dev(struct udevice *dev, bool verbose);
> >
> > +/**
> > + * scsi_get_blk() - Provides SCSI partition information.
> > + *
> > + * @partition_name: Partition name for fetching its info
>
> Partition names cannot be expected to be unique.
> UUIDs should be.

Will change to UUID and post a new version.

Thanks
Varada
