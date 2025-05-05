Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F7FC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 05:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D572480F03;
	Mon,  5 May 2025 07:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="S0PZQKV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64FD81F7B; Mon,  5 May 2025 07:26:37 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E5480BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 07:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5452jog2007308;
 Mon, 5 May 2025 05:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Az7xW0JPBG9BKJUMTnDHiuzZ
 LxLLwOwEJem8GK1k+fk=; b=S0PZQKV8eXMCi0rwnHwkHs84zbWkDW55HCYJWrMf
 +JGdTfQuX32RIsBic/7Epy3ZDTjEpiNPspFrQI+HxwxVfiT/aghG8dIthAwn7EY4
 T6biSn0h6eAbQnaAns8QZqPp3GmJJte8VQZE/tLhtPOQ5I/976a5/9SP8KJGQktf
 n3deFPUW9UiGlvGxPFXZF1htNcgQWOnClLYthmX8Pdk1ITKweQyVfe6+7pZJZsHO
 p9MAgp8QjTAR3GB3+YX57B9Gz4MRt291UiicOy9Tozuvulc3wX/6aFddFQV+fcJf
 V7sg64YNXzK6fE66OzFvaAbvo+JyeIhnH63pukNy24a5mA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dafg31x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 05:26:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5455QMRO001317
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 5 May 2025 05:26:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 4 May 2025 22:26:18 -0700
Date: Mon, 5 May 2025 10:56:14 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <trini@konsulko.com>,
 <ilias.apalodimas@linaro.org>, <seashell11234455@gmail.com>,
 <clamor95@gmail.com>, <ycliang@andestech.com>, <me@samcday.com>,
 <robert.marko@sartura.hr>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 1/2] sysreset: Implement PSCI based reset to EDL mode
 for QCOM SoCs
Message-ID: <20250505052614.ttvitp53rnjamahc@hu-varada-blr.qualcomm.com>
References: <20250430085428.1090801-1-quic_varada@quicinc.com>
 <20250430085428.1090801-2-quic_varada@quicinc.com>
 <9e06d089-3fd9-4161-988b-14273a2aba0e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e06d089-3fd9-4161-988b-14273a2aba0e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: edGSVqHy08s-kpT0RtCuAS3WmaP0qFnk
X-Proofpoint-ORIG-GUID: edGSVqHy08s-kpT0RtCuAS3WmaP0qFnk
X-Authority-Analysis: v=2.4 cv=atqyCTZV c=1 sm=1 tr=0 ts=68184bff cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=IjXoko2qv1Fpd6tAV8sA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA0OCBTYWx0ZWRfX/8PBo1nqlWal
 s+mgDNKzONhQ2VNxsCzcl0CpDTjkb+mX9QTdJsDk0rFHUAQ4UPGJ2mtjavxRycdEiH0Xu5/mNyh
 17WVGCuyz45eDbCIln/cKzXStvwYL6RdEw2LpGeRv54+WOwE7RBj2+c3Kv8xx3ZdZ8Yla3twQ9V
 zp7W02iVgZcc4i9y1rpUcwW2jyx0sdA2t6iXyLynncNKGHV1TkNNkfyfB4QqFiq9h7gaxTi04CN
 NL3h1cl1FqlutkFue546oxuhu7CizOScEQLq/clOob9nKS+b1owmHb59+vWKg22/qP8farPY4Q1
 H0CW8/pYTH3xYKqUL9PUqxEra+Mx4xUnadFs/Avz1pjT8ozW8D2x1Yg8tyh/F0p56pfDFn1rDyP
 KbzsbmZkSLJvootsji+LYmB1K7NhjmDOxcAKeBfMcYBbmriQpElzFXhB9SRy71jD0y1FHU4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050048
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

On Fri, May 02, 2025 at 02:32:52PM +0200, Casey Connolly wrote:
> Hi Varadarajan,
>
> You have almost entirely ignored my feedback on the previous revision.

Sorry. Since you had said "For now I'm fine with this new
sysreset-qcom.c driver", in [1], I assumed you were ok with just
addressing the technical issues alone. Will add a new op to sysreset_ops
and post a new version.

Thanks
Varada

1 - https://lore.kernel.org/u-boot/1e0e9a72-40a8-4ce3-a390-edef1d6a03d8@linaro.org/

> If there's some technical disagreement or you don't understand my feedback
> then please let me know (in private if you prefer).
>
> This approach is fundamentally wrong, full of layering violations and
> totally unsustainable (imagine if every vendor started polluting core code
> with their custom stuff).
>
> These abstractions need to be improved to add this feature properly and
> there's no getting around it.
>
> Kind regards,
> Casey (she/they)
>
[ . . . ]
