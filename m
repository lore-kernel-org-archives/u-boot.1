Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84863C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 07:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970E0801DE;
	Wed, 19 Feb 2025 08:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="msqy7hWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B7A80C98; Wed, 19 Feb 2025 08:11:21 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84AF2800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IIxSQS016354;
 Wed, 19 Feb 2025 07:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=h7V0jtDH7rWOH2DD4Z5TvRFm
 IzP35yGE7HJTZ7Ajr4o=; b=msqy7hWM095O2mr2YBTL/ghSEpNOVB0fHl8TSKBX
 4UL4d8jFl7GxNDMhfguiXNPNrQdEuFG4xYqSkur8fh0ignfI+ElPOfInN4Xu1GG1
 sJg/7c+TQATUaRpi3WgwflMv8HvkPDlFMhILlHW/XkpovfLuZou7bOshWZZoLsb2
 Ty4tpAQbIvowE53WMYutlogGggmWJj6PAdWJJqSWf9x/u+AJuQq9TiLO9cIIkkch
 TUH3pjx+Hg/ZiCVIq3tQ5BRf42hPhrA6/dUNdGIhAAflPZlJZ7GRi9/COhe6GEGv
 hwGyop6wLAdd4DGHe5zLa5jM15CGXVzIP8LfOaFBD/8wcA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy11jcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 07:11:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51J7B0RM005496
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 07:11:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Feb 2025 23:10:55 -0800
Date: Wed, 19 Feb 2025 12:40:51 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <robert.marko@sartura.hr>,
 <luka.perkov@sartura.hr>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <Volodymyr_Babchuk@epam.com>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v3 2/8] dts: ipq9574-rdp433-u-boot: add override dtsi
Message-ID: <Z7WD+1953tzaZ+cz@hu-varada-blr.qualcomm.com>
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-3-quic_varada@quicinc.com>
 <504430a1-5275-48a5-8f29-3a4c8fdd4269@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <504430a1-5275-48a5-8f29-3a4c8fdd4269@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: q82SvA-_4ip3xnSD7K8F8XZumNKzYg1t
X-Proofpoint-ORIG-GUID: q82SvA-_4ip3xnSD7K8F8XZumNKzYg1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502190055
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

On Tue, Feb 18, 2025 at 05:38:14PM +0000, Caleb Connolly wrote:
>
>
> On 2/18/25 08:54, Varadarajan Narayanan wrote:
> > Add initial support for the IPQ9574 MMC based RDP platforms.
> > Define memory layout statically.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v3: Fix comments and give additional details
> >      No code change
> >
> > v2: Use upstream and override DT instead of own DT
> > ---
> >   arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >   create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> >
> > diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..390e2338d6
> > --- /dev/null
> > +++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +/ {
> > +	/* Will be removed when SMEM parsing is updated */
> > +	memory@40000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x40000000 0x0 0x40000000>,
> > +		      <0x0 0x4a500000 0x0 0x00100000>;
> > +	};
> > +};
> > +
> > +&sdhc_1 {
> > +	sdhci-caps-mask = <0x0 0x04000000>;
> > +	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
> > +
> > +	/*
> > +	 * This reset is needed to clear out the settings done by
> > +	 * previous boot loader. Without this the SDHCI_RESET_ALL
> > +	 * reset done sdhci_init() times out.
> > +	 */
>
> Thanks, this should be accompanied by a patch upstream adding this property
> so it can be removed from here later.

The driver in Linux and U-Boot are different and it doesn't need it.

-Varada

> Kind regards,
> > +	resets = <&gcc GCC_SDCC_BCR>;
> > +};
>
> --
> Caleb (they/them)
