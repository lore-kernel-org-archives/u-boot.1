Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A13BE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 05:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5120F801E8;
	Wed,  8 Jan 2025 06:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fOXfOay1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5D28036B; Wed,  8 Jan 2025 06:47:17 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365DC80040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 06:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507KFrL2028518;
 Wed, 8 Jan 2025 05:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=n5VtrOam1kPmj5QdkjXUVz3M
 2P/kziBhtqDqmeAqREk=; b=fOXfOay1t+D7Uegne8esQYfzspNn23xjcbWmdFOQ
 vD8jNCCJ1WBdrbtlEg1UlbuXApeZyLpQIvdSJ/W4QnG7nWGvhf0AsACjF7RQxlmA
 XunneabMBu0OBCTQjYnbT0QfAwdEj+Vgso0FSmUKkFMgRuW28WWtzcbO+scXKJF4
 swgCoNoIDD33toxj7Ham8h5wUyKJYZid+1r6YZpjZj48i7rsdla7P/gQzN9vHK0Q
 UrnbZ0vDlLiJZK9W1X3SQ8Up4IwXdG3v2QcQpWAmss2qN+WYXq6vYtnM1ob1Llke
 Wk2GyoI0OiBjFU7D7qzoyo05oy27VXJ/V4UXC0qXLWJnOQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441b589258-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 05:46:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5085kq1U018415
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 8 Jan 2025 05:46:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 21:46:48 -0800
Date: Wed, 8 Jan 2025 11:16:44 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <neil.armstrong@linaro.org>, <trini@konsulko.com>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Message-ID: <Z34RRETdZn8rDhYe@hu-varada-blr.qualcomm.com>
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
 <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
 <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: o63OTxdkS-hC8BsutJS6nh9DT6ToM015
X-Proofpoint-GUID: o63OTxdkS-hC8BsutJS6nh9DT6ToM015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080044
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

On Tue, Jan 07, 2025 at 12:36:23PM +0100, Caleb Connolly wrote:
>
>
> On 07/01/2025 10:24, Varadarajan Narayanan wrote:
> > On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
> >> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> >>> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
> >>> Define memory layout statically.
> >>>
> >>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>> ---
> >>>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
> >>>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
> >>>   2 files changed, 33 insertions(+)
> >>>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>>
> >>> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>> new file mode 100644
> >>> index 0000000000..7d01d5f6a1
> >>> --- /dev/null
> >>> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>> @@ -0,0 +1,22 @@
> >>> +// SPDX-License-Identifier: BSD-3-Clause
> >>> +/*
> >>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> >>> + */
> >>> +
> >>> +/ {
> >>> +	model = "Qualcomm QCS9100 Ride Rev3";
> >>> +	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
> >>
> >> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts
> >
> > To include QCS9100 info to the model and compatible strings,
> > so that users might not get confused if a wrong U-Boot has
> > booted on the platform.
>
> They are already defined in dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
>
> That file is patched at build time to include this dtsi file at the end.

[1] defines it as "Qualcomm SA8775P Ride Rev3". We want to define
as "Qualcomm QCS9100 Ride Rev3", i.e. s/SA8775P/QCS9100/. That is
why having it here. This would not be needed once [2] gets into
U-Boot.

1. https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/qcs9100-ride-r3.dts

Thanks
Varada

> > Please let me know if this should still be removed.
> >
> > Thanks
> > Varada
> >
> >>> +
> >>> +	/* Will be removed when bootloader updates later */
> >>> +	memory@80000000 {
> >>> +		device_type = "memory";
> >>> +		reg = <0x0 0x80000000 0x0 0x3ee00000>,
> >>> +		      <0x0 0xc0000000 0x0 0x04d00000>,
> >>> +		      <0xD 0x00000000 0x2 0x54100000>,
> >>> +		      <0xA 0x80000000 0x1 0x52d00000>,
> >>> +		      <0x9 0x00000000 0x1 0x80000000>,
> >>> +		      <0x1 0x00000000 0x2 0xf7500000>,
> >>> +		      <0x0 0xd0000000 0x0 0x00100000>,
> >>> +		      <0x0 0xd3500000 0x0 0x07c00000>;
> >>> +	};
> >>
> >> Ack, this should be removed once the SMEM code is merged.
> >>
> >>> +};
> >>> diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>> new file mode 100644
> >>> index 0000000000..979462dfec
> >>> --- /dev/null
> >>> +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>> @@ -0,0 +1,11 @@
> >>> +// SPDX-License-Identifier: BSD-3-Clause
> >>> +/*
> >>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> >>> + */
> >>> +/dts-v1/;
> >>> +
> >>> +#include "sa8775p-ride.dts"
> >>
> >> Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.
> >>
> >>> +/ {
> >>> +	model = "Qualcomm QCS9100 Ride";
> >>> +	compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
> >>
> >> Same, unneeded.
> >>
> >> In fact, this file is completely unneeded.
> >>
> >>> +};
> >>
> >> Neil
> >>
>
> --
> // Caleb (they/them)
>
