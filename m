Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C3EC54E49
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 01:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3B687D29;
	Wed,  6 Mar 2024 02:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="W7RpZK8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D2987E63; Wed,  6 Mar 2024 01:53:16 +0100 (CET)
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com
 [148.163.133.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0836487E78
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 01:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9795de6c48=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 425GnAX9024399; Wed, 6 Mar 2024 00:53:06 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3wp05yb9x0-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 00:53:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVKOxisW7Q4L03zW1LCkn/s5EVt6NH4jAOIAB+qz0h/rCVp3KcaBn1POIqdmqu7uUJkrScyZVSRAN3GoCr/zdHpa6aDcy8dv6BBfkrenXyKPKzij0aXn/5qP5zpMptX+rB9UKdfk40StZz0PSPOTlqUWIi/qfbISUj+Q2crfglVhwad/M8m/IC/sWQ9KX1I/EFdPFbUm6jKuuBgW93VVUyrnkB56g/CpiP1OplsHPr2pJbwtqx3mIkSNNGpCioy8Z2BEKj04Ha8cHKJG9xEoqSy0Ads2sfOUcn18S9qkr72uw0oV+wbB26/ci4lA11v9NQd4QdKhw4bPmZpLz3MBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNlhNTgm2P4ai7L4He0Eupy5D6Tad9/L5JjC8AGE8uA=;
 b=UvC5mb77+B/ajmVrHPtO11K5hHb9lVRl8coaSFokt4jDokPDQSWJEpvCnbLtAoBzZ37CJ3YB+G6TeKDAq6zdxRLqB/HY2Z6M7N8MY7HAYpDh8eTDJXo6tmngoymtGCYSsfGwGDEDRnEX8fm5QkOCUVPItihe+AEmxj5jii3v81e7pi81nAnSO+00CHxEoBmrzZUpjSgd5FXytoubJPeMqUjimtF02vAabwfBPc+HG9WHPe2KT0z17yuCowodcT+vuFNGEcJLXfpnij8XVL5nDd5tFrrj0OUpuqiXtwZsl9QG5fwVgGlfzYaRBlPiZmImaOU2Yjqhynz1aIZIKQ5BrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNlhNTgm2P4ai7L4He0Eupy5D6Tad9/L5JjC8AGE8uA=;
 b=W7RpZK8u9BeGBTuJ3S7KMK8LJtHjbUjVX79sqWFhLClOOZ6/pEIOl58AHm/k/oY1JVvJ/HkVs/gVSv0oPxFvbf/B2yrYa6XQCEiAD80kk9ukDYTuDm1NmSLK0w+P5oiakn+b9Ix+YwL3F+G6P5YRmKWLrX4izpgFVMtcMVGghnCybkrNAhASApeTHzmN0vcrZBkYHsyWQF8QWHiE+IRy671XLvPRuQZn9kiBoz5AjF7Wb8geKbazNBGUbKLSt9MeFSVY8P4uK5Eo2cDMIWeI5Yexo8EU0lvKbcA4VSE5uUfPDp5XDp8i+sKgctOvQWRkgBzVmHFSfGtWlMVCd4c01Q==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU0PR03MB9801.eurprd03.prod.outlook.com
 (2603:10a6:10:44b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 00:53:00 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:53:00 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v2 2/8] clk: qcom: clear div mask before assigning a new
 divider
Thread-Topic: [PATCH v2 2/8] clk: qcom: clear div mask before assigning a new
 divider
Thread-Index: AQHab2CiCp0IUftwaUGMCXLoB0tZXg==
Date: Wed, 6 Mar 2024 00:52:59 +0000
Message-ID: <20240306005230.2638972-3-volodymyr_babchuk@epam.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU0PR03MB9801:EE_
x-ms-office365-filtering-correlation-id: 9ba95650-51c2-4921-7507-08dc3d77c566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkvbALq0941ZIDK94lx4o04IRMv+vxrNarZNYaMqR1im6IJ/UMFlXHKwVq/WAVDQC/ebJdilJyl48t1uI8zoJsJpbt8sqaHS9dkG4hW5ZYZ1qsvqDqJiAl1MIitK9IiuLLZ+WwlelyjCnffTyBTVtEaxWSfjn6/LX6bA2o42Y47R2h9qP1KTbN+6O7jNcCcjtVyTMXPcNzOlacgoz16OsZI2wYqQMnt/XnaEwhZGjn4Q4coBgfrOvYA3JZAdIkNePV+ucQXl/4Br8DkQ3QEEeyeRLwZKLeJfsWeCR/z0gUPyCbUqsYm/PU91agAB8fVfcuAySo31APEuEoCs6iKCJAtCRWT4NQ/QqhsIuuSalDoWSrFbV4Y007wCMD+An7+kxDY9rxtD2YqN9nnnTVMtQzzFCxTP1MM6n7lqnqr0ZkPbgwjCEekNr7xwEjVexkBju4wBUJpKoe8MZvYd3D71GrvmzDigbHzaNMhmvg0UVvt6CfG3Q0Uvv6wJgm8CvOSck3jN6XVL0QCM/r+OfWVqE50B6Li2jzBMR/Dn2MfHl9zqGMtnEwozIZ+InCLeCojffsTJUKNHDydviUQD7vluTLuUhwATF6qnZ0HC/rChv+GCGdI0xtJaCPj8jtbecHVTGQ9DPUzCSoeUNLusToHqGwB8Qx5Ad5zo59Rz+oDE9oo1ciZR5lvVP9AwMRxWRZyLzk76vNQKA6jFPTRlIXVsAAi3a9BzVL6AsBmW5dM7GrU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K2c7jEtRxmazlVRfgNy9P21WrCO0YnXN2+TbtZrJNZpU7i6Y/G+3m8jnRz?=
 =?iso-8859-1?Q?NP63raYIHwmlv52rI6WoplnbR/5VGixPc5tz8ns+W/bjafVcNXQtCIZqJm?=
 =?iso-8859-1?Q?0iBzlFDuacO7F42Fq+R1fLtQOCh/KeoYjtv+ZL9eN56A9YTEOKARf5mtGp?=
 =?iso-8859-1?Q?1Intrm7Mkq47HdcNnFHZf3/a6ey2HD31SirW+VAJTjOQKurSlrpMt02USS?=
 =?iso-8859-1?Q?zHRM8DMvyYXAOmdB6ewPfhKD4oo0FKQ9EeQixfF8wTIuQNLFyBxLndEVWp?=
 =?iso-8859-1?Q?zupPnnA2VPMjfprrVzfaqpJm7/Fmlgu4mFfBkm131B1xyQBtbGNqPoVm1X?=
 =?iso-8859-1?Q?aT/nBeQiWsq4OvK32CZeac9ZAld3lExikR1CXcR43s2yca04vz1J5HabMb?=
 =?iso-8859-1?Q?E/XWBywHS4kNN2YNJBhGxkoJypn6lP8ufDOQRA3d+RwslwX4MyJIrHOPh5?=
 =?iso-8859-1?Q?hVfYkat6v8XocgBitdvsmvGQ1Uz0+h80Oc1ii8HgWajiCpIZR6/mn/fN3t?=
 =?iso-8859-1?Q?xeFl87ZjHEWS+YGgaNU1gDZxXxGMEB8ONTbS5ZlIZjXaKgkES1Z5n5vOgM?=
 =?iso-8859-1?Q?n8SppAAt29MpjFYj4ymO0Of/7UbIFAtfR9R0kRcZtBIZewAYvp/nIKcji9?=
 =?iso-8859-1?Q?Oeqi7yHl5TCbHXTP4nxI7enKtZ6r/yK3lP8cOMupZ+iPaA+MGph5O6rVyV?=
 =?iso-8859-1?Q?6jc2k0zNVaNsZsi8j0Vtapo8hCk+MUf76+j4BS8MwthPAIsJcH4CcPBOEB?=
 =?iso-8859-1?Q?Qxq/V4nNgcBaY9D4rykWTGRxizdODGXsPJG4/WRZqqBaEmn3MfW1yvyEUL?=
 =?iso-8859-1?Q?0cOEzJAMEQ/uQnjqOJkZhyszxsoC8DweStPMhC42+Rc07PXeB+YvhKMkWy?=
 =?iso-8859-1?Q?iP/EpGMZw+tuVlECsKoL/sJqkt0VU548SKrGLLnTtcDh1urJLMkg3HrdH9?=
 =?iso-8859-1?Q?P67WZ1GkH1T+/Jb704yUyt1CquiK6/rQlOGw9GC8lDp4tQ/GbVCfHMqgSL?=
 =?iso-8859-1?Q?6lA8Zcl+hUhUGlLYdRLjtWtQsDvhw2uIoc93WaM8X6nkf+pDBXWSiWyRl7?=
 =?iso-8859-1?Q?TowqfdbFVAVqBfU93Q1T9WNgSL+IOSY78aqe3cC7fv/TKekciU8+9feWld?=
 =?iso-8859-1?Q?33ik6HF4UQpngGqFK0u1lH23rDmlX01gjpCZarPhrU5b6HYDLbiUYGtE4x?=
 =?iso-8859-1?Q?we49Q5WwCuLQBAmBjP4+phQp6cHWo7BSjvHg1Uq4nBaDiFEllNf5comF4E?=
 =?iso-8859-1?Q?svdclb2TyHLSt1WcDZg1tbNFYpHx8cbn+cqzJviOZ6H/96b9xRmxPLqXDF?=
 =?iso-8859-1?Q?TeJfV5NtTW4kuNBczHjsdkIZ+31GUcyWN9mlrn0bA75HUai5nfRTZMSRdP?=
 =?iso-8859-1?Q?9HjygA/j1RQ9W4PTEpsyQXfySOIeYcuxO6Jr4PWw+mvkwphHCdR4eo1TFe?=
 =?iso-8859-1?Q?gAh7DSAZIOgqnVCKln9P03E7RuRgu0beovrfYygJpGObhAiqGqYF0UCABW?=
 =?iso-8859-1?Q?MaCGk38R2sihRTGdZtMRQASk8/0OxUm7bkuUOZ+EUt/XSf6fhvOkZkdROR?=
 =?iso-8859-1?Q?s19FSWqIbzVIHgnYs8ZPMRKLCJqwjC/7vD6wdMxyg+QbXFibNdErZFI4tb?=
 =?iso-8859-1?Q?p+Kjou9C0iL4JGNbj8HMzLLmGf2zQIq/Vsmpt5eiw9ZjJPe1yWA2pcYA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba95650-51c2-4921-7507-08dc3d77c566
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 00:52:59.3472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4/mFbDzSso5cI4dzKo8xrvSLKdGA6DUYsTLm5yc/QVLr68yaW6rWZoMnK+S6P1LrgR3qoLw3vz82P0ns1AJw+DLwq7GtDZNSRZyMB6Ufa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9801
X-Proofpoint-GUID: oYJ6FczNcbh2IITGoXT_T0SvIucqOg60
X-Proofpoint-ORIG-GUID: oYJ6FczNcbh2IITGoXT_T0SvIucqOg60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_20,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=870 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
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

The current behaviour does a bitwise OR of the previous and new
divider values, this is wrong as some bits maybe be set already. We
need to clear all the divider bits before applying new ones.

This fixes potential issue with 1Gbit ethernet on SA8155P-ADP boards.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

---

Changes in v2:
 - Reworded the commit message
 - Added Caleb's R-b tag

 drivers/clk/qcom/clock-qcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7c683e5192..729d190c54 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -117,7 +117,8 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struc=
t bcr_regs *regs,
=20
 	/* setup src select and divider */
 	cfg  =3D readl(base + regs->cfg_rcgr);
-	cfg &=3D ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
+	cfg &=3D ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK |
+		 CFG_SRC_DIV_MASK);
 	cfg |=3D source & CFG_SRC_SEL_MASK; /* Select clock source */
=20
 	if (div)
--=20
2.43.0
