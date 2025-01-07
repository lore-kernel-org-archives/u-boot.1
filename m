Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9924CE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 09:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1393F801E8;
	Tue,  7 Jan 2025 10:24:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="O+erVJzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7AC8036B; Tue,  7 Jan 2025 10:24:40 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4AF801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 10:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5075Lufe006140;
 Tue, 7 Jan 2025 09:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PDZmNEQ4Vm+9BPAJns7VZKoc
 0+5XHe1ulvZLMvhX9ns=; b=O+erVJzGzk0VeQxSH1o8d6/+lZ7tAkBuxmFUpvTx
 YcWolxi+ktb/7VhpAQ7uk6s9c9AlLjhM//Xc4kFu4Bodm8aSel4s3s5RfWtNzumX
 XwBM7E3yNMD+WKsl0OjfOc9tDXE+SvvC/tb63/UBEbJmNjS2Ff+rZS4VT3gmeWXn
 ufRLDo8upV97vT3rv8ZuRfJvDG898Xj7W20KReKB6CkE9JHQf1wJ077OJX1uMtW/
 pSBB+Tm6yH9RWQFxLM85qMRPNE620nVdOvOh9+gN8Vdp5ISmAbCtDBhQeumqfdJ8
 xTzlEoox0YdoUoIKz0hMXTU+Wk01ShqOJQrEAvo+acvSXg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440x288h0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jan 2025 09:24:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5079OIdN009189
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 7 Jan 2025 09:24:18 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 7 Jan 2025 01:24:13 -0800
Date: Tue, 7 Jan 2025 14:54:09 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <neil.armstrong@linaro.org>
CC: <trini@konsulko.com>, <caleb.connolly@linaro.org>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Message-ID: <Z3zyuZZ0TA47KXpZ@hu-varada-blr.qualcomm.com>
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-2-quic_varada@quicinc.com>
 <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1ae282b0-8e68-4360-b3d2-73a10b7b8f37@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 7CaLUjNHUoKH_P2ip-xdpNN0EfD_Dnh_
X-Proofpoint-ORIG-GUID: 7CaLUjNHUoKH_P2ip-xdpNN0EfD_Dnh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070077
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

On Fri, Jan 03, 2025 at 04:17:14PM +0100, neil.armstrong@linaro.org wrote:
> On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> > Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
> > Define memory layout statically.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >   arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
> >   arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
> >   2 files changed, 33 insertions(+)
> >   create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..7d01d5f6a1
> > --- /dev/null
> > +++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +/ {
> > +	model = "Qualcomm QCS9100 Ride Rev3";
> > +	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
>
> Why do you redefine those ? they are already defined in the upstream sa8775p-ride-r3.dts

To include QCS9100 info to the model and compatible strings,
so that users might not get confused if a wrong U-Boot has
booted on the platform.

Please let me know if this should still be removed.

Thanks
Varada

> > +
> > +	/* Will be removed when bootloader updates later */
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x80000000 0x0 0x3ee00000>,
> > +		      <0x0 0xc0000000 0x0 0x04d00000>,
> > +		      <0xD 0x00000000 0x2 0x54100000>,
> > +		      <0xA 0x80000000 0x1 0x52d00000>,
> > +		      <0x9 0x00000000 0x1 0x80000000>,
> > +		      <0x1 0x00000000 0x2 0xf7500000>,
> > +		      <0x0 0xd0000000 0x0 0x00100000>,
> > +		      <0x0 0xd3500000 0x0 0x07c00000>;
> > +	};
>
> Ack, this should be removed once the SMEM code is merged.
>
> > +};
> > diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..979462dfec
> > --- /dev/null
> > +++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +/dts-v1/;
> > +
> > +#include "sa8775p-ride.dts"
>
> Why ? this file will be automatically appended to sa8775p-ride.dts, no need to import is before.
>
> > +/ {
> > +	model = "Qualcomm QCS9100 Ride";
> > +	compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
>
> Same, unneeded.
>
> In fact, this file is completely unneeded.
>
> > +};
>
> Neil
>
