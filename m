Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94AC8C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 04:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 940B183145;
	Wed, 16 Jul 2025 06:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="JXOSXZ84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550078315B; Wed, 16 Jul 2025 06:57:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDE483123
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 06:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDILc024674;
 Wed, 16 Jul 2025 04:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=d0II+4duL/2E++T0xx1j3tC6
 1GVPLWkW0/dsWhd/m4g=; b=JXOSXZ84imO8xcHzsUqrYi6NaLlqKPJYzmgsDl/F
 JDX5CBzSbyNFDq/DUwHyclihv0yRRB4CtDpNJISAFkbVJ7KFdpnAxL6F5KOdRSX8
 ASHaMJxGtHORw6PWzdRHGPXj7KKw6SFl3BDJrwxcS0N3GJXqzVPYrAqjZi/e8HTQ
 IysEmbJA5DxA0a2MXTM+JLoie8YEdR3s/dpYZxNCiFtIgXC6PAqUkaEiH624r+Mp
 0L1oj91xCutOYVAA1b4z+MAIrRp4HGGqSRStxwcw8+V0mlfeV8AtaYZ58j2FDOW/
 R/IrDMw3podMHIrLKrDxD7fbIB7A69Xq/UKRqfuMyJu34g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpdegf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 04:57:14 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56G4vD4m024356
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Jul 2025 04:57:13 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 21:57:10 -0700
Date: Wed, 16 Jul 2025 10:27:06 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Casey Connolly <casey.connolly@linaro.org>
CC: <trini@konsulko.com>, <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>,
 <lukma@denx.de>, <seanga2@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: Re: [PATCH v1 0/6] Enable fastboot support for IPQ9574 based boards
Message-ID: <aHcxIj299SjS8wzG@hu-varada-blr.qualcomm.com>
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
 <7f4689e8-e727-438a-95c1-b1dd49890cea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7f4689e8-e727-438a-95c1-b1dd49890cea@linaro.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA0MSBTYWx0ZWRfX+pX7g5nAT1oR
 CysPNArx4cwMYlzUAT+th1S/uOY+T0gMjnbLC6oMFiz6TbGvbRGfLQkWzb9SgTT/EXy8c1zOrqq
 doOG2gTtDalJ9qBFgyKWmvz+o4wXwhwONd3yDDdMxuXU8+HHV5fbd55wv6jEiN3SFlZhk9w3H8x
 ed0vo6cQqvPvUStWfOP5P6KheisA5NsdLSuOx3xMCmLJ5HoKQN2p3nS9iODOx8aLnxTvgbdeISP
 3cTY4pKlzF4qR1VFGoAi2CSOOIXS0/rAhJLddcJyt6kgcieHiF0eO+iGE+GHKlW+u07Un8EtDbT
 OoXoD+Wc7+Vuhizze9hhesfw55c5OPQYIfOrRhiAJmnyTsu4F8Nvk/y7Pp7guZHAcIyCqC8ev6B
 ie88xqsiolVInD6uInrBma3cWhTXahtp1yaCVKRtMaFQcbUXNLSaSCqdxbROLHW4y5qumte1
X-Proofpoint-GUID: aNF7yH-HSyWUE9H_huFP4qacHFpd9eET
X-Proofpoint-ORIG-GUID: aNF7yH-HSyWUE9H_huFP4qacHFpd9eET
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877312a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10
 a=9XabRrNJ_bRDcgU-d34A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160041
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

On Tue, Jul 15, 2025 at 02:30:09PM +0200, Casey Connolly wrote:
> Hi Varadarajan,
>
> On 7/15/25 12:15, Varadarajan Narayanan wrote:
> > This series enables MMC based fastboot flashing for IPQ9574 boards.
> > For this the following are added/enabled
> > 	* USB2 & USB3 phys support
> > 	* USB Gadget support, Fastboot-MMC related configs
> > 	* Flashing related documentation
>
> This is awesome! Glad to see you have the superspeed phy working. I'm a bit
> confused though since the of_fixup code in mach-snapdragon configures all
> the usb controllers for high speed only and removes the reference to the
> superspeed phy, is there some missing commit to adjust this?

CONFIG_EVENT is not defined in ipq defconfig. Hence of_live_build() doesn't
notify the EVT_OF_LIVE_BUILT event and qcom_of_fixup_nodes -> fixup_usb_nodes
is not called.

	=> bdinfo
	. . .
	fdt_blob    = 0x000000006fe3b5e0
	. . .

	=> fdt addr 0x6fe3b5e0
	Working FDT set to 6fe3b5e0

	=> fdt print /soc@0/usb@8af8800
	usb@8af8800 {
		compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
		reg = <0x08af8800 0x00000400>;
		#address-cells = <0x00000001>;
		#size-cells = <0x00000001>;
		ranges;
		clocks = <0x0000000c 0x0000005c 0x0000000c 0x0000005b 0x0000000c 0x0000005d 0x0000000c 0x000000d1 0x0000000c 0x00000060>;
		clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
		assigned-clocks = <0x0000000c 0x0000005b 0x0000000c 0x00000060>;
		assigned-clock-rates = <0x0bebc200 0x016e3600>;
		interrupts-extended = <0x00000001 0x00000000 0x00000086 0x00000004>;
		interrupt-names = "pwr_event";
		resets = <0x0000000c 0x0000002c>;
		status = "okay";
		usb@8a00000 {
			compatible = "snps,dwc3";
			reg = <0x08a00000 0x0000cd00>;
			clocks = <0x0000000c 0x00000060>;
			clock-names = "ref";
			interrupts = <0x00000000 0x0000008c 0x00000004>;
			phys = <0x0000001d 0x0000001e>;
			phy-names = "usb2-phy", "usb3-phy";
			tx-fifo-resize;
			snps,is-utmi-l1-suspend;
			snps,hird-threshold = [00];
			snps,dis_u2_susphy_quirk;
			snps,dis_u3_susphy_quirk;
			dr_mode = "peripheral";
		};
	};

Initially, I manually overrode the 'phys' and 'phy-names' to just have the usb2
phy and it didn't seem to work. Only after bringing up the USB3 phy did it work.
Not sure what the relation is between the two.

Thanks
Varada
