Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D070DC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4DF801FB;
	Wed, 12 Mar 2025 09:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fNQ1hAYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597D580756; Wed, 12 Mar 2025 09:51:39 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE892801BE
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BMHt4l024132;
 Wed, 12 Mar 2025 08:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=OYRkpzC0HVNJU5xNhMofPu4G
 owdNtDz20HghHa5TNz4=; b=fNQ1hAYLuO+6dYECXu3tTVeKiUDXn1KDtFLYiNCV
 JK0z3/Hjppzq03sPAAY3n9FBUnW1hfHJIP2mb2/oz8oPpR941AZ9hD+XynxoRlk2
 a/Oq5fn7qf11LrSlVXX5aTBfuwa7ah2rUubZJXz17HwlrS8HdxRrY7uWqudmUER7
 iBtkrIQe1Puo7xWh1cc5P7TBoWdwOO5ZDY4huQzPMypBAD9WpW5hzPbvrTxBpO0x
 iG373UejdzqBhaQcSsplLRbTf5Z68D6dldf5xKulIEOf52cH3SxF2ZKPQ3+nyiKU
 P+7wGmZ18c0dYHMTdl0T+EFZsl107Q2lYql5VfmdBJIP4Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2mhqps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 08:51:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52C8pFO7026759
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Mar 2025 08:51:15 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Mar 2025 01:51:10 -0700
Date: Wed, 12 Mar 2025 14:21:07 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <Volodymyr_Babchuk@epam.com>,
 <lehmanju@devpi.de>, <sjg@chromium.org>, <robert.marko@sartura.hr>,
 <dmitry.baryshkov@linaro.org>, <andersson@kernel.org>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH v1 6/6] configs: add qcom_ipq5424_mmc_defconfig
Message-ID: <Z9FK+10hx9lMFUaI@hu-varada-blr.qualcomm.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
 <20250304110105.2762124-7-quic_varada@quicinc.com>
 <c138a744-4423-4b3e-8b1f-abe77d6e228e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c138a744-4423-4b3e-8b1f-abe77d6e228e@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: BlvEG2uJkctWeDZjOg9EddVyHRE6IDUp
X-Authority-Analysis: v=2.4 cv=aKnwqa9m c=1 sm=1 tr=0 ts=67d14b03 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10
 a=jz8rinVNK-teBKU19B8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: BlvEG2uJkctWeDZjOg9EddVyHRE6IDUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=450 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120059
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

On Tue, Mar 11, 2025 at 03:27:25PM +0000, Caleb Connolly wrote:
> Hi Varadarajan,
>
> Thanks for the series, and apologies for the slow reply, i've been out sick
> and still finding my feet again.

Oops. Sorry to have troubled you.

> On 3/4/25 11:01, Varadarajan Narayanan wrote:
> > Introduce a defconfig for the Qualcomm IPQ5424 SoC based RDPs.
> > Presently supports eMMC.
> >
> > Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
> > defconfig, u-boot.mbn size is ~480KB.
>
> What are the differences between this and the other new IPQ platform? Can
> they share a defconfig?

They are very similar. At this point, CONFIG_DEFAULT_DEVICE_TREE,
CONFIG_CLK_QCOM_xxx, CONFIG_PINCTRL_QCOM_xxx, CONFIG_DEBUG_UART_xxx and memory
map are different.

> Alternatively, could most of the things here be de-duplicated so there is a
> "base" config which they both #include (similarly to qcm6490_defconfig) this
> way we can nicely keep track of what parts of board specific.
>
> If you'd prefer to keep it this way that's fine too.

Would having an ipq_defconfig and including that in ipq9574 and ipq5424
defconfigs be a good approach?

> Should I be expecting more platforms like this?

Yes.

Thanks
Varada


[ . . . ]
