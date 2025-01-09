Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A6FE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 04:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD028006D;
	Thu,  9 Jan 2025 05:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="gj2SWdxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5A9800D0; Thu,  9 Jan 2025 05:43:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796608001F
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 05:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094BcWA018074;
 Thu, 9 Jan 2025 04:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vu1D4WVPSMUDW3Z+E+gnYsbs
 Iw3yDcjdpfmPR5fQkZw=; b=gj2SWdxI4Xi6VV0G78uhC8tA0LZavIgXnzbY21fe
 nteY0TDWQdoMm6PClXmhVILUZcBAj4mysiKLyvAypV2G1FoNuyUm7O2LnfvYoWat
 7qsLpPLaUPrdzD1Dw9VjB0NcOdaI7uKIMuBkkhSGPg75v8iNHwk+gLjSL7fQGXHo
 CQK+W+WxWyjKdAKu2ZPPNXyKtq2fkvKryTsFN3jDL5tvrhj2SHj+A4TWtgPvdokq
 CXtmea/AQqavLKQkqyOXWrBsHphdGQ4dC1YAxWk68PpdtJJ9T5P9UbTd4iyLrkT4
 /ghYGd3e+xt10tIQzS8TWav4IlKFO6s2meE4T4tzGo+osg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44277e01v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 04:43:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5094hI3A018402
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 9 Jan 2025 04:43:18 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 20:43:15 -0800
Date: Thu, 9 Jan 2025 10:13:11 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <u-boot-qcom@groups.io>, <neil.armstrong@linaro.org>, <trini@konsulko.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Message-ID: <Z39T3x79hInoSdCt@hu-varada-blr.qualcomm.com>
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
 <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
 <909dc9b6-fb70-45c7-83f2-74c89b5049a5@linaro.org>
 <Z34RRETdZn8rDhYe@hu-varada-blr.qualcomm.com>
 <a56b87c0-0e70-4e0b-aeb7-9f10b2c7c6d0@linaro.org>
 <CAFA6WYPkOTb_tM86AEbUyJ4LJxu=9_f2ZQe3rQzZmy8K6uBbvg@mail.gmail.com>
 <bf8b7d1a-8c0e-4d02-892f-09776d270cf7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf8b7d1a-8c0e-4d02-892f-09776d270cf7@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: UqLek2xqVgwNUb20W9VPoGPYx8TUkKUj
X-Proofpoint-GUID: UqLek2xqVgwNUb20W9VPoGPYx8TUkKUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090035
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

On Wed, Jan 08, 2025 at 03:29:42PM +0100, Caleb Connolly wrote:
>
>
> On 08/01/2025 15:20, Sumit Garg via groups.io wrote:
> > On Wed, 8 Jan 2025 at 19:36, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>
> >> On 08/01/2025 06:46, Varadarajan Narayanan wrote:
> >>> On Tue, Jan 07, 2025 at 12:36:23PM +0100, Caleb Connolly wrote:
> >>>>
> >>>>
> >>>> On 07/01/2025 10:24, Varadarajan Narayanan wrote:
> >>>>> On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
> >>>>>> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> >>>>>>> Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
> >>>>>>> Define memory layout statically.
> >>>>>>>
> >>>>>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> >>>>>>> ---
> >>>>>>>   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
> >>>>>>>   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
> >>>>>>>   2 files changed, 33 insertions(+)
> >>>>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>>>>>   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >>>>>>>
> >>>>>>> diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>>>>> new file mode 100644
> >>>>>>> index 0000000000..7d01d5f6a1
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >>>>>>> @@ -0,0 +1,22 @@
> >>>>>>> +// SPDX-License-Identifier: BSD-3-Clause
> >>>>>>> +/*
> >>>>>>> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>>>> + */
> >>>>>>> +
> >>>>>>> +/ {
> >>>>>>> + model = "Qualcomm QCS9100 Ride Rev3";
> >>>>>>> + compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
> >>>>>>
> >>>>>> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts
> >>>>>
> >>>>> To include QCS9100 info to the model and compatible strings,
> >>>>> so that users might not get confused if a wrong U-Boot has
> >>>>> booted on the platform.
> >>>>
> >>>> They are already defined in dts/upstream/src/arm64/qcom/sa8775p-ride-r3.dts
> >>>>
> >>>> That file is patched at build time to include this dtsi file at the end.
> >>>
> >>> [1] defines it as "Qualcomm SA8775P Ride Rev3". We want to define
> >>> as "Qualcomm QCS9100 Ride Rev3", i.e. s/SA8775P/QCS9100/. That is
> >>> why having it here. This would not be needed once [2] gets into
> >>> U-Boot.
> >>
> >> hmm I see, well that's a pickle. I don't think we have a process yet for
> >> handling these cases where we're blocked on a DTS sync.
> >>
> >> I would rather avoid creating this weird situation where we use the
> >> sa8775p dts and pretend it's a different board especially if it's only
> >> temporary until the proper dts lands.
> >>
> >> Some proposals:
> >>
> >> 1. remove the model/compatible properties assuming the sa8775p-ride-r3
> >> board using the same memory map, add another u-boot dtsi for
> >> qcs9100-ride-r3 once it's merged in
> >> 2. import qcs9100-ride-r3.dts into arch/arm/dts in u-boot as part of
> >> this series (but need to remember to remove it later!)
> >
> >> 3. somehow cherry-pick the relevant patch into the subtree early
> >
> > This is the preferred approach, following should create a cherry-pick
> > patch for this platform on top of next branch:
> >
> > $ ./tools/update-subtree.sh pick dts db6231faa8ef46e5ff5d5ece0c930a07c6358562
> >
> > Then you should rather include that cherry picked patch in this
> > patch-set instead. The next DT sync will take care of it
> > automatically.
>
> ah that's perfect, thanks Sumit. Then this is the right way to go.

Thanks Caleb and Sumit. Will post a new spin.

-Varada

[ . . . ]
