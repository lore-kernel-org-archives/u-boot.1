Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7D8C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2856981F66;
	Tue,  1 Apr 2025 10:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ZuBE9CFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D61F81F0D; Tue,  1 Apr 2025 10:05:30 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAEE581F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5315fsHD032586;
 Tue, 1 Apr 2025 08:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yPjs3rPUxiK9YGerWwsfu693
 fcvu7+qKJnU8hkdDBQI=; b=ZuBE9CFpHMPBQCXyl5hIVAenPGyfNPC7pu1JX7wV
 nYK7AE2Abz+Pr0WiIuBA8/dOxQeFzXOKaLbWeZP40Rrs3QBmCfKkmPRfIraeiXj3
 qf0swJKEViWU56fcpbwcOocVixeKn7UYAGTy1sbcFH0lVrfw4DhZRLDi55txmx8I
 SqMrkU9MUvTAuZxSRrBJZT3zIZJgVOa/qtgOfH/ij/Qdwkv7VDCH5Nk3wz95s/WA
 acyncKBGWbGpIiBqpAbFYLkZRFLZQNlhEIa7aUmp6qvN9pk/NTnEknVd2YlTglB0
 +InuixTV07/hYXWctC+UJX6ePaiOud+sw1RLJFQEKVi8nw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qfbbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 08:05:18 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 531859si014530
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 08:05:09 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 01:05:07 -0700
Date: Tue, 1 Apr 2025 13:35:03 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Simon Glass <sjg@chromium.org>
CC: <caleb.connolly@linaro.org>, <trini@konsulko.com>,
 <marek.vasut+renesas@mailbox.org>, <neil.armstrong@linaro.org>,
 <lehmanju@devpi.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/2] drivers: scsi: Add 'erase' support
Message-ID: <Z+ueL91znYIyUu5D@hu-varada-blr.qualcomm.com>
References: <20250324100121.2490314-1-quic_varada@quicinc.com>
 <20250324100121.2490314-2-quic_varada@quicinc.com>
 <CAFLszTgcmA+p32F8EoeKuUJeNF6HrgxZ9PWYP6gOtD55AJCHvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTgcmA+p32F8EoeKuUJeNF6HrgxZ9PWYP6gOtD55AJCHvw@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67eb9e40 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=2OU-epLfCEgOxOWle9cA:9
 a=CjuIK1q_8ugA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: W1hODXKkzdvGZTD0x4mZ2lkRJlCRjigi
X-Proofpoint-GUID: W1hODXKkzdvGZTD0x4mZ2lkRJlCRjigi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=710 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010051
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

On Fri, Mar 28, 2025 at 04:44:48AM -0600, Simon Glass wrote:

[ . . . ]

> > diff --git a/include/scsi.h b/include/scsi.h
> > index b18ae37b861..d6b6e6b665f 100644
> > --- a/include/scsi.h
> > +++ b/include/scsi.h
> > @@ -9,6 +9,7 @@
> >  #include <asm/cache.h>
> >  #include <bouncebuf.h>
> >  #include <linux/dma-direction.h>
> > +#include <part.h>
> >
> >  struct udevice;
> >
> > @@ -181,6 +182,7 @@ struct scsi_cmd {
> >  #define SCSI_WRT_VERIFY        0x2E            /* Write and Verify (O) */
> >  #define SCSI_WRITE_LONG        0x3F            /* Write Long (O) */
> >  #define SCSI_WRITE_SAME        0x41            /* Write Same (O) */
> > +#define SCSI_UNMAP     0x42            /* Write 10-Byte (MANDATORY) */
> >
> >  /**
> >   * enum scsi_cmd_phase - current phase of the SCSI protocol
> > @@ -349,6 +351,17 @@ int scsi_scan(bool verbose);
> >   */
> >  int scsi_scan_dev(struct udevice *dev, bool verbose);
> >
> > +/**
> > + * scsi_get_blk() - Provides SCSI partition information.
> > + *
> > + * @partition_name: Partition name for fetching its info
> > + * @blk_desc_ptr:   Provides the blk descriptor
> > + * @part_info_ptr:  Provides partition info
> > + */
> > +int scsi_get_blk(const char *partition_name,
> > +                struct blk_desc **blk_desc_ptr,
> > +                struct disk_partition *part_info_ptr);
> > +
> >  #define SCSI_IDENTIFY                                  0xC0  /* not used */
> >
> >  /* Hardware errors  */
> > --
> > 2.34.1
> >
>
> For testing purposes, could you please implement this method in
> drivers/scsi/sandbox_scsi.c() and then try to erase the block in
> test/dm/scsi.c ?

Sorry, the above hunk should not have been in this patch. The
scsi_get_blk() is implemented in [1]

Will remove and post next version.

1 - https://lore.kernel.org/u-boot/20250401080015.1470999-2-quic_varada@quicinc.com/

Thanks
Varada
