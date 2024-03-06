Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6137C54798
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DF18802D;
	Wed,  6 Mar 2024 02:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="EsoOnVHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A1687933; Wed,  6 Mar 2024 01:53:31 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971DE87D33
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425GnAXA024399; Wed, 6 Mar 2024 00:53:07 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wp05yb9x0-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFEe3AuPM7kOdyct3+x5W3Dp/3qAuDqLizHkitOb0YVuruOztmGJwhsXS4WIISUVe4t+HyiVzz4JEzQfyoHQz3seGYQIDWZJFLuhE0S13n5SOzRvDjDvXi1qYT/pSIrxH+2jxQ1gLEehs20Q2EFpxcr3ItuY0G8d6PVnjywHDaE6SUo8n2CBNiarf3g9wfOAtUJx7cd7vXAxAB3OPCpY6QU0482vfUcBSoHXJ3AGKAx7YkdU2scdtLs88i9XvBAXke3vo98/PDp8HvCiORM/rYO+1BojhlvFbjTOE5oAuqLgdiVGfL5uClpqLC52Y3SbnTdQEclPEcLvRxrnI4xQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1r1Zx3tDvXc5QXSxuSnha0P7XjczFbNzzFGCOpaUkM=;
 b=CkctHWFZpigvMGfcDOlB3gCGQJOnzv0ILt2GiGXvqepYRNGaPUDrq1nFclEnBArLNBVMjasEKSEbt3Jl7j7yX7SsWNIsnYxgtoHHbPki0EeYYUVTmTHWbqfqRJN2qf70XiOZ+1qhUb2sK7aTJK+ZxUG/BbrInB/cZDDIHKKOrapMIkbw7b2TyFQGX6pD37z4y/PvBF+Wx/AM9TK8XZ6tq8hAQwiYZ2y7Z9GOGV7ESnMqUV1ZqIOGGz5DNpJz9TrOxPtdoTo1Pb2QTpCdpGDZxp75kdPuUeAzNgBqxcE6x6XfM8vHuMi87QNMSgQQDGnW4YWrbUfORTRHyjzlAZuWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1r1Zx3tDvXc5QXSxuSnha0P7XjczFbNzzFGCOpaUkM=;
 b=EsoOnVHFek4VQEFYI9AsKfEDdTc+nU8EFVev665Z8T+4y23O5P9MMqmFd3h84Z1T5j5PgBN3p1DETcg9AMEtmYn1WBVSgAEDexVeB4In3GTzD21m5wb0TAtKWrc1fCRGDolv/dz/RHl3bOnkJqUtlqFDsql3RVOtkLxJdSq2t52VyOLKRinQbQt2mzvDjH1j5G6ycSZdHNRd+DhYymz5wOu07tk78xeyqwjDhFWJ6cF//CGW0rLOqpcNFI1+bFywuzy5VQVur792gutqIZJcc7SN4p5uMLOr1wodNUGSY7J/9U95w+bF0i7B3sKiOlaOWrYG7PGuF7WhKVlbm0kM5g==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:52:59 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:52:58 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Elmar Psilog <epsi@gmx.de>, Joe Hershberger
 <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Ley
 Foon Tan <leyfoon.tan@starfivetech.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 =?iso-8859-1?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 Tom Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v2 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Topic: [PATCH v2 0/8] Add support for Qualcomm SA8155-ADP board
Thread-Index: AQHab2ChwTCOAuvjKUykLNd7i3Tl2A==
Date: Wed, 6 Mar 2024 00:52:58 +0000
Message-ID: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 5e7f1aeb-aa47-46dd-fc00-08dc3d77c469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVKsUiIP2tsNW314dQ6OLXFhGIQKjUrnvWaGT604+I1V6Cf2ZqmjAb++Xxo87ksUkgWTall2EvVv83O1/nh+LgDN46haixmVHyJXqJl+qq/NMRoR2n/EbugUnrJgNYb16CeyKM3LiNwU92hd3BOS+DU+UwFV7mBjCma/tS3bqNYxmK+UpVBMxQg4WprpxFPOsVIZYAUln5al1VZtqeARS9XUFCCZA1lnUSXmTZxorrLXJRk74276xY2Yc+Mpsb7bpuMpTLUkJDD/tiQIew9F5fLQloBBvoCQcuSvRnza8AReeYI2cFRoDFrXDqL0avzJUA1beHdj4mvayQjcSl+PP5zDNnZ9gj280BoJLvipXoq0mBgZVzDMebXvzEIzuB/MMvib9OZH0I8IXO5duJzrvuP3UUrpDi2SCfzEygvehTJFHrT9Tq7XXW1S8GHri+QoI7OJcaETBSTCP1YZVmsjg6aHjlzEJQFF4dWuBZeYfcQcUEZ7e+phD7YBG6pKYHqCNbUW2+EPqTj89a1a4k/bYDsGYVkNw4MtQJdHMIwcLhT9NIErZ5EfaV5Bptals9OA5cuBuEtvaVd2IisaWAFG6dqhLV2TRWuHC5MPFjp4r7YAPhj7gU85KVAO7JqfhXUsCiroEa7kB5NYTXsg1Hq8PpnNoqgTbl3WozCouns8X5xrgTdLMyZ3qJz/z/YdSUgYHpOP09QplUkh6jwJn1jShg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JvlkHEl51WE11PTCA2JPd7ijCGeQnmsajdBIrFH7m3gW7LD5LYs0KtZ0OP?=
 =?iso-8859-1?Q?hRUnSmTrmcPj/9rW8RgOtNLbk2LC8j7FTMMi6/hTeSHrJHBQnMxCPgHAGT?=
 =?iso-8859-1?Q?mYH6merH4PJBGrggwk3pdREDTt4Qgx5nJVHu6ZVz9tr/Br2EWK18mMG2WY?=
 =?iso-8859-1?Q?y0XCgTcDXKK5UFNxgvBxXNrU20EUOd9o0WY1AfzXK9xh9vp4hDnkBfkDIR?=
 =?iso-8859-1?Q?isCoJ2C7d7n4/XXbF9RdtujuGngoCFhNTp789HmxFO77tJnlNyLHYG2Ccx?=
 =?iso-8859-1?Q?4On28BRlR7/YW2nvONRCEONPuzQ6ZyPUV6v0qsy0zC87lMfOPdQ8wd7l44?=
 =?iso-8859-1?Q?jgVgmlQQeSvSps2t8JVMy0OsfVBGZ4t61LzqsDdBxN/3nCq3F1QD9Ilsmo?=
 =?iso-8859-1?Q?jGAdtrJUg8DKRDaYeG70Ul4ZPJ8vQj83B+rhPGN7HD0pTF7tvs3Hs6mH28?=
 =?iso-8859-1?Q?f5EIiZvJs3p6DU5XfSvJH1ON1ylCsoV2+Xw9u+zC9l37Ki91GoozE+v9PA?=
 =?iso-8859-1?Q?qWkbBftQLntXNj4HKy+rZP+o/fe0tt6vynuNBnQgQocChuli4MoBgAtyib?=
 =?iso-8859-1?Q?WdyAEDrgU2i5yZM1uq1noyS3a1s3BVSboaM7F7BtULtf9piz20SouW5pZb?=
 =?iso-8859-1?Q?ATAEdK++hhH0qQvOAN+kgbRCqYOfGKYlRUW+rm0tCkihbRWz88Y/WEs0xY?=
 =?iso-8859-1?Q?N8gms/grZgarHaSRYdrFgN8YZPrxsJLqlDiTZkafEv5Y59bR6/1HPqTseV?=
 =?iso-8859-1?Q?++wqycnIM9eCp9lBrbnB0vctFjHQaEC8M1lHIneCWaGzq94JUJVEc9+hGv?=
 =?iso-8859-1?Q?J59rgikmvWNiDkf9W35dF7r8PtNCThR35qsTR/0XQB+N/eLzRMR0/kO5EL?=
 =?iso-8859-1?Q?fq+OwUVP2xhqw+Wcb0nMG067TAB1CxZXC+TJ8ZWyuQjmfzkTH4YTivGmPl?=
 =?iso-8859-1?Q?jVnmbTO1lAgIrEG29nRpi143UDZoMMrNr48uM7v2qcqLOT0XdiN2qVzhFT?=
 =?iso-8859-1?Q?bIP/q6Lobsbbff10qGVgB0CHMxhGQLFQ04lvtIq1XkpIJyFcrpBPKDRDiq?=
 =?iso-8859-1?Q?ZcF659m/U5Dm+gQoSt1yErGAEHdqbgIuo4wZPpF3iRI/LjX+trelK6Ut1q?=
 =?iso-8859-1?Q?Drb1M9iFrDejSY+4sEtwUgYC7LHhwAEk8YEHHGP+oRFSgPlJdLfndhR/aP?=
 =?iso-8859-1?Q?DENipI3m65r4fT23vX9x31HF5A7gqfFl7aANO/7cu3c3Tk/d7Wh0rN963t?=
 =?iso-8859-1?Q?z2m14w1im5dr2uXc8nCNd7FvwMOznq4KPCADALlvJNZIU7yEmlIdDO4XCw?=
 =?iso-8859-1?Q?vc9BoTueXl+O1JJkrc4TVvTMeBi2JnG3r34D5R8XGtsldYb3WbgG06lEAm?=
 =?iso-8859-1?Q?FFexFPcptGcp5R/abs4Xll/7LzVQkvJQHw2gZanoXuF91h/3NEZHbsmkRW?=
 =?iso-8859-1?Q?YW62pGR0jUVvK5lX1Zk3w5l6v2Kk5qN5IMevDCvBIFOaf4c6ymH1JSNgve?=
 =?iso-8859-1?Q?UQ1dJtV0Wygg/xK/ABrYOB3jL0ycgQ09RZ3euLXisrkm7jIN5ysmGS1EFq?=
 =?iso-8859-1?Q?qEUDuddTUsAyZoiDlOvKa1YANaQGpx8Th75BKzDw2hWc1962sba5gv64CA?=
 =?iso-8859-1?Q?af5lMEGKx2odvsb4y8Sgn+MY3QNXO7QVO8d5aJe3gLbkNT160ke9t7dw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7f1aeb-aa47-46dd-fc00-08dc3d77c469
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:52:58.3586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgWXJfYW3xiSoCypooDaeh8hlgz8Ao0NeDzmkwr51sP8b0VwU57iT+IUpTbpyNTyre2crUYj3iVyDnxbaTGHLmhYR6Tli4RFphXvRvX0KkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-GUID: -a9RzFBC7SYfxlHrlqOOQRxqi9o4tN_m
X-Proofpoint-ORIG-GUID: -a9RzFBC7SYfxlHrlqOOQRxqi9o4tN_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=827 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060005
X-Mailman-Approved-At: Wed, 06 Mar 2024 02:16:00 +0100
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


This patch series adds support for Qualcomm SA8155-ADP development
board. Main motivation for this series is to allow running
virtualization software on this board and U-Boot is a good way to
break Qualcomm's boot chain at EL2 with more convenient ways for
uploading and running the code. With this patches applied it is
possible to upload and run Xen on this board. KVM probably should work
too.

I added myself as a maintainer for this board, but my abilities to
maintain it are quite limited as I have no access to Qualcomm
documentation. I used mostly Linux drivers as the source for
device-specific information, like register addresses and offsets.
If anyone wants to maintain this, I will gladly agree.

This is the second version of the series. It is now rebased onto
qcom-next branch.


Changes in v2:
 - New patch in v2
 - Clear loopback bit explicitly
 - Reworked qcom_cc_bind() function
 - Added timeout to qcom_power_set()
 - Minor fixes in register names and formatting
 - Renamed GPLL7_MAIN to just GPLL7 (while I like idea to use Linux
   naming convention, such rework needs to be done in a separate
   commit)
 - Removed unnecessary include
 - Fixed GDSCR register values for couple of devices
 - Enable GPLL7 only when RGMII clock is enabled
 - Rebased onto qcom-next branch
 - Removed unnecessary files thanks to generic qualcomm board support
 - Enabled CONFIG_REMAKE_ELF (this removes one extra step in the
   readme)

Volodymyr Babchuk (8):
  qcom: board: validate fdt before trying to use it
  clk: qcom: clear div mask before assigning a new divider
  net: dw_eth_qos: add support for Qualcomm SM8150 SoC
  clk: qcom: add support for power domains uclass
  clk: qcom: add driver for SM8150 SoC
  pinctrl: qcom: pass pin number to get_function_mux callback
  pinctrl: qcom: add driver for SM8150 SoC
  board: add support for Qualcomm SA8155P-ADP board

 arch/arm/dts/sa8155p-adp-u-boot.dtsi   |  30 ++
 arch/arm/mach-snapdragon/board.c       |   5 +-
 board/qualcomm/sa8155p-adp/MAINTAINERS |   5 +
 configs/sa8155p_adp_defconfig          |  35 ++
 doc/board/qualcomm/index.rst           |   1 +
 doc/board/qualcomm/sa8155p-adp.rst     |  87 ++++
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-qcom.c          | 131 +++++-
 drivers/clk/qcom/clock-qcom.h          |   7 +
 drivers/clk/qcom/clock-sm8150.c        | 237 ++++++++++
 drivers/net/dwc_eth_qos.c              |   4 +
 drivers/net/dwc_eth_qos.h              |   2 +
 drivers/net/dwc_eth_qos_qcom.c         |  46 +-
 drivers/pinctrl/qcom/Kconfig           |   7 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-apq8016.c |   3 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c    |   4 +-
 drivers/pinctrl/qcom/pinctrl-qcom.h    |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c  |   3 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c  |   3 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c  | 589 +++++++++++++++++++++++++
 24 files changed, 1186 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/dts/sa8155p-adp-u-boot.dtsi
 create mode 100644 board/qualcomm/sa8155p-adp/MAINTAINERS
 create mode 100644 configs/sa8155p_adp_defconfig
 create mode 100644 doc/board/qualcomm/sa8155p-adp.rst
 create mode 100644 drivers/clk/qcom/clock-sm8150.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8150.c

--=20
2.43.0
