Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE10C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 07:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911088216C;
	Tue,  6 May 2025 09:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="AG4oHyjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C9580050; Tue,  6 May 2025 09:30:24 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242208210D
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545M5OAP012086;
 Tue, 6 May 2025 07:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=e+D9gBgeAWYezF+sFo4vDvt4
 q+PzZ/ypXPdzL7ThiRE=; b=AG4oHyjmCTUxULc63MV6AjCU226lfV503awhRQcU
 iqD/3ECxij04InO1Ii2/CzJAZ0HnaF2T9C/raEapfMMCDmCL4vf86xNakZATaLz1
 LLoC0QBor3iewZzxjkTsc36Q7OnORyq/wpcJwcSE1qKWF3aVZzsHrpURlmCbb5lZ
 QOcICtuaHbgABiw9T/um06eh/T91FwVaVO9NxxKn7ZQadKSsvQOPGT4MOuqPkudH
 EwSQox2qo5z2Elvt1UqcU0SNYp0gISTKLq0+JLyX0bqmFx/upzjFrGfhDti9T/NQ
 7iFIgqQ0jRLuRjDhwmTmnm5afxdqCkCrqfKMuxwgdy2C7Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f5tb9bc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 May 2025 07:30:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5467U3M5008940
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 6 May 2025 07:30:03 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 6 May 2025 00:30:00 -0700
Date: Tue, 6 May 2025 12:59:56 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <neil.armstrong@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <sumit.garg@kernel.org>, <joe.hershberger@ni.com>,
 <michal.simek@amd.com>, <marek.vasut+renesas@mailbox.org>,
 <cniedermaier@dh-electronics.com>, <xypron.glpk@gmx.de>,
 <sjg@chromium.org>, <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 0/3] Enable env in UFS
Message-ID: <20250506072956.otki522irhggugxp@hu-varada-blr.qualcomm.com>
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
 <20250401141022.GD5495@bill-the-cat>
 <7a5ac5c2-5bb7-45d2-838b-63fa07766c4f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7a5ac5c2-5bb7-45d2-838b-63fa07766c4f@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: RB7bn66T_VGd-Zm0AFg_uFvoBHetPxlm
X-Proofpoint-GUID: RB7bn66T_VGd-Zm0AFg_uFvoBHetPxlm
X-Authority-Analysis: v=2.4 cv=doXbC0g4 c=1 sm=1 tr=0 ts=6819ba7d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8
 a=_KatupUMz9aHpAZwxXkA:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA3MCBTYWx0ZWRfX3zkn1O/Bz/M5
 NWhbsJmISvwZX9woQnuPvT1OaYu8opKjdR8GRyD30SSj1FsIppjhRv01D0jqoiRVBhZy6QVi5CB
 siTvGA1hBOHRJgxz9snmPgkrETRHIw/7XfcZmjwd6AX8Z7njtQqXL1TkS/ToTsGQp+O1PqMWNd9
 O8Do7AG7ArjyALKQ7sajSv8u5dje73xiBszZTjLUTJpXUE6JFrqI71Z3ZPY2bBGD+Xpp866aqfe
 9E11zRSfjt0H+Z0y03u59lTO/ZjJ2PMdlHg7YpIy18786UYyU0vXcSoloVHuI+lfnVNl8WY8TQS
 kjEwHg9AqMfFwvva7AJqMZDJJRxQxBJx6KVmZcvq3fqEJNTX1jqZpr7EjG+Eouz3fpHYvDmUnFR
 z5lq5hc3Q5ualScF2b8HIRDSpseXxl+mCPghMkqoXtH/MGQovEwsh5NDuMCEbbehtnCO+LUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060070
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

On Tue, Apr 01, 2025 at 04:37:40PM +0200, neil.armstrong@linaro.org wrote:
> On 01/04/2025 16:10, Tom Rini wrote:
> > On Tue, Apr 01, 2025 at 01:30:12PM +0530, Varadarajan Narayanan wrote:
> >
> > > The qcs9100 based Ride platforms have UFS as their primary storage.
> > > Hence add support to U-Boot env framework to be able to save and
> > > retrieve the environment from UFS. The environment will be
> > > saved/retrieved from the partition specified in the config option
> > > CONFIG_SYS_UFS_ENV_PART.
> > >
> > > Also add an API to convert partition name string to block device
> > > descriptor for UFS. This API will be used to get the block device
> > > descriptor for the partition specified in CONFIG_SYS_UFS_ENV_PART.
> >
> > In general, I'm glad to see this, thanks! In specifics, Marek is trying
> > to bring more consistency to some of the env symbol names and so I know
> > CONFIG_SYS_UFS_ENV_PART is patterned on CONFIG_SYS_MMC_ENV_PART but lets
> > use CONFIG_ENV_UFS_PART instead which I think follows where Marek is
> > going.
> >
> > Also, this seems to be a generic ENV_IS_IN_SCSI implementation and it's
> > just that UFS is accessed via "SCSI"? Perhaps we should name things a
> > bit more generically, and it should already support various AHCI SATA
> > devices out of the box?
>
> I agree we should use scsi to access ufs, we do not need a specific
> ufs backend anywhere.

Reviewers,

Thanks for the feedback. Have posted v2 addressing the concerns.
Please take a look.

> > However all of that said, do we want to be encouraging environment to be
> > stored directly in blocks like this rather than a filesystem on UFS?

Enabling CONFIG_ENV_IS_IN_FAT and configuring CONFIG_ENV_FAT_xxx options
appropriately works for these platforms. However, the current build
system doesn't generate a FS image for default env settings. Hence,
going with direct block storage instead of FS storage. Hope that is ok.

Thanks again.

-Varada
