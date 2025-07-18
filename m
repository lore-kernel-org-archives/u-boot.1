Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD6C83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 07:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAA98349B;
	Fri, 18 Jul 2025 09:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="cCF63YoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50C998353A; Fri, 18 Jul 2025 09:19:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1417583479
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 09:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HMlrex025212;
 Fri, 18 Jul 2025 07:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=k/9sIzdIbNBQps97ZlZw1Ola
 44U1g5etzwnad6mvV94=; b=cCF63YoFGq1aTQeEU1dKneJtYqmmsbKECFLHfBMR
 br+t+AWDM40CeMb4opBX+zRcxA36wj+J4ayQ66acNoWq/20O7R7hpU97uaqMy63X
 k0DWhqSXff/AXvZwJhQkdnKyq83/rpgSh43A5b9bJgCqY9MmwXPLiXUjqhW7vXWM
 LittUuzXmAnNLYCUBxhNOPICoI4ob8cCQxH/jZN0keNwQPthyhgAtI+FmCa+haoc
 +Kgy10MNxsdxNKgMEepiS0tObgUgp4m4hs960KQ1pGpNZMYpku3wx6dFs+qujSeH
 OYtpG5AA5lj+eV6Fdo/GHcM2sP6DndxFX+zC0yD2FQ7uMg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqeqp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Jul 2025 07:18:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56I7IraY017852
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Jul 2025 07:18:53 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 18 Jul 2025 00:18:50 -0700
Date: Fri, 18 Jul 2025 12:48:46 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <lukma@denx.de>, <seanga2@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: Re: [PATCH v1 0/6] Enable fastboot support for IPQ9574 based boards
Message-ID: <aHn1VnPLEkha4XkX@hu-varada-blr.qualcomm.com>
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
 <7f4689e8-e727-438a-95c1-b1dd49890cea@linaro.org>
 <aHcxIj299SjS8wzG@hu-varada-blr.qualcomm.com>
 <cb99663c-07c7-4267-8cc9-d915e815bcf6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb99663c-07c7-4267-8cc9-d915e815bcf6@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=6879f55f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10
 a=rqhHNvtJU18GKsCjr-cA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: a_mefJczyZdWJaVZ7BYj1Zk7NeEqm7Je
X-Proofpoint-GUID: a_mefJczyZdWJaVZ7BYj1Zk7NeEqm7Je
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA1NiBTYWx0ZWRfX+hPYJgVeB2ui
 f14mwdMcnNF918Iayoa+klCslnYvzidSEeAzeRYcZOo8H8JZbi3O9eHMzbAJ6hHAa8FZKdj3HOL
 MGrVOzeJL805AHMkVIayS/R4Co1KXt5pGCnX38MevfzKqagCvWl1Dy0WrFDnsvT9i8Yec7V51e9
 LYqqRJltETUJUIssDYkG73iCivzxOT/kyqvFXJpZhM2QNjtLztOzs1g1Z456BL95F1TaJuHnATu
 vLlmxHTpyMipu+CxcNU8EaQ834hHp6AzwZM9hEtrP/zroeNLcb42aZTlnLJuhPx+MjCPpSSo/Tc
 zpVbJ6AJp68AErbJrdYGcWqVxJeYjjCfORLhSS9uxkUS+7M2KV0QN62zNnPMgaeJ62Y3ZusSkMY
 vMVVQLrIhQfCBfJJS04CP+0HpUl883CmySCkVAaD2p7Og3RaF6vreLdOlbe3DLfSqIGeggFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180056
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

On Thu, Jul 17, 2025 at 03:01:04PM +0200, Casey Connolly wrote:
>
>
> On 16/07/2025 06:57, Varadarajan Narayanan wrote:
> > On Tue, Jul 15, 2025 at 02:30:09PM +0200, Casey Connolly wrote:
> >> Hi Varadarajan,
> >>
> >> On 7/15/25 12:15, Varadarajan Narayanan wrote:
> >>> This series enables MMC based fastboot flashing for IPQ9574 boards.
> >>> For this the following are added/enabled
> >>> 	* USB2 & USB3 phys support
> >>> 	* USB Gadget support, Fastboot-MMC related configs
> >>> 	* Flashing related documentation
> >>
> >> This is awesome! Glad to see you have the superspeed phy working. I'm a bit
> >> confused though since the of_fixup code in mach-snapdragon configures all
> >> the usb controllers for high speed only and removes the reference to the
> >> superspeed phy, is there some missing commit to adjust this?
> >
> > CONFIG_EVENT is not defined in ipq defconfig. Hence of_live_build() doesn't
> > notify the EVT_OF_LIVE_BUILT event and qcom_of_fixup_nodes -> fixup_usb_nodes
> > is not called.
>
> ohh I see, hmm
>
> >
> > 	=> bdinfo
> > 	. . .
> > 	fdt_blob    = 0x000000006fe3b5e0
> > 	. . .
> >
> > 	=> fdt addr 0x6fe3b5e0
> > 	Working FDT set to 6fe3b5e0
> >
> > 	=> fdt print /soc@0/usb@8af8800
>
> Just fyi, the fdt command won't show changes to the live tree, it does
> direct FDT parsing whereas the live-tree is an internal representation
> in U-Boot (which is what makes it faster to access and modify).

ok

[ . . . ]

> > Initially, I manually overrode the 'phys' and 'phy-names' to just have the usb2
> > phy and it didn't seem to work. Only after bringing up the USB3 phy did it work.
> > Not sure what the relation is between the two.
>
> Hmm, you don't even get high speed USB? probably an issue with clocks then.

If 'qcom,select-utmi-as-pipe-clk;' is added to the controller DT node it
works. Should I post a new version

	(1) without SS phy + qcom,select-utmi-as-pipe-clk;

		(or)

	(2) with SS phy + qcom,select-utmi-as-pipe-clk; (i.e. same as
	    this series, with just utmi as pipe clock added)

		(or)

	(3) leave the series as is

Kindly advice.

Thanks
Varada
