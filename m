Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05720C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 07:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52CB2801DE;
	Fri, 21 Feb 2025 08:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="HIjz3W3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D85FD8056B; Fri, 21 Feb 2025 08:29:07 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699038007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KMWKUM026296;
 Fri, 21 Feb 2025 07:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Ba2whHb+GMR1euTapzX086cu
 8FToNZdcMCECC5iityc=; b=HIjz3W3HgCG/GPETUUdVurJBGw1A3Sb5lacPVwRN
 qBZp1nVTAymV+ppH6k2UZKnrLMSIW9VN6Ymhsa5LNKgU15+QkOCAmSQMGEdGTW1S
 OBzrTQEpzkVaaSj2JS7KMjr0eBdgzhekZ/0jp+vAj6R1vozZatod7K2Khwu0zjjx
 EbI1EFafyLzcg/5dtdizgLd7Joz/FGi4gD8s0KK83EjrENg07KPqfen5yVRsILny
 1g8U3mj/hMW4LdcvVcvhTmMtb7s8MW0bXFVgzzKkG+QdkhNps9rNfqO7S+PHGIH/
 pGwrlfvmnXMQCcbPcGe9olGserj3J0DE7KQVro8Ay/xilQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x2r3u3ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 07:28:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51L7SbDf026863
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 07:28:37 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 20 Feb 2025 23:28:32 -0800
Date: Fri, 21 Feb 2025 12:58:28 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>,
 <lukma@denx.de>, <seanga2@gmail.com>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <robert.marko@sartura.hr>,
 <luka.perkov@sartura.hr>, <Volodymyr_Babchuk@epam.com>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <pbrobinson@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: Re: [PATCH v4 2/7] dts: ipq9574-rdp433-u-boot: add override dtsi
Message-ID: <Z7grHO0deU8CQ72B@hu-varada-blr.qualcomm.com>
References: <20250220073937.133687-1-quic_varada@quicinc.com>
 <20250220073937.133687-3-quic_varada@quicinc.com>
 <47882bed-ff45-4c86-b3c5-920ee6f0dee2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <47882bed-ff45-4c86-b3c5-920ee6f0dee2@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: iD-2cFnsc1E3c2-nFtuSdW3C9wBDdtVi
X-Proofpoint-GUID: iD-2cFnsc1E3c2-nFtuSdW3C9wBDdtVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 mlxlogscore=940 suspectscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210055
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

On Thu, Feb 20, 2025 at 08:44:23PM +0000, Caleb Connolly wrote:

[ . . . ]

> > +&sdhc_1 {
> > +	sdhci-caps-mask = <0x0 0x04000000>;
> > +	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
> > +
> > +	/*
> > +	 * This reset is needed to clear out the settings done by
> > +	 * previous boot loader. Without this the SDHCI_RESET_ALL
> > +	 * reset done sdhci_init() times out.
> > +	 */
> > +	resets = <&gcc GCC_SDCC_BCR>;
>
> I understand that Linux doesn't need this reset, but devicetree doesn't
> exist in Linux to describe what Linux drivers need, it exists to describe
> the hardware. This reset should go upstream. Ultimately this file exists
> purely as a stop-gap solution and the goal must be to get rid of it in the
> future.
>
> I'd appreciate it if you could also send a patch to the kernel adding this
> missing reset.

Have the change ready and tested. Will check with the person who
posted initially without reset to confirm that I'm not missing
something and then post it soon.

Thanks
Varada
