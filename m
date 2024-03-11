Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDF1C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 21:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC2C87F0E;
	Mon, 11 Mar 2024 22:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="kRe6IlyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1E187ED6; Mon, 11 Mar 2024 22:33:54 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D429787EE7
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 22:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BHvYd2015991; Mon, 11 Mar 2024 21:33:48 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wt25w9fem-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 21:33:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANgfd5aLT5Ysm78sNNtK6+z45OC9bmYbBeaK2zXesFk7ZHDBCYrOjJmLihLIHq6oviaXTsxKfDVDX5dS7nkf4ygsD17jIxlpQyHqW2m05QrjDgMwe5jJTN63ss1eAoGYZj9k36Jo19qEAyP0rdE5BTO3KLDU97fbTrHARPnY52RnOG1hEtozNRWlKhAsoVbk8VJ/UXQVe6o/uBA4znKrtdxIi4QrCvHsO+w9zcUJcuXwSxgYWwfbgUgyhztGJ8h3bvp89DxGlQXItttNcfT5dqRgffFVAmTntcVsw8fp5bBILLDaQZWlaFjBzo5VOyDNC+T9pf63erYO9pY1j7MVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPIqA4aHnrzW2XhRpEe5kLUufOM3rMGL6bLNLtkl/eg=;
 b=ktPFaPwNs2WDhmmx/ZGnqZokGAbqDbHxZBKHB89Ang6+Nbp50fDEMV9+/x21YzmGR9BLN2v3hr7M2ryOS8uGvc2scjC+WXAykQSAHw/YoQhhheQYq+PvSNp1DxE6lxa/244OIf/1TAKZB3PjQ4RdHvOBuypPeM3SVi3ImmQFX5gf9vZNNjujW2T/OflVy8P9xVS66vuBaFDztpSOJIcQmCIhLVwVuMT8t5EUcmBzCzjNo+084GuJcBLJtSRGXpwbxgB139E81h/rPe/eKXbhYDinEL1ih/nHdkKkw90ke3OeswNKOmTOdI+tYqNM3Y/1hvTC5lQe7b5qDO4LOXcNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPIqA4aHnrzW2XhRpEe5kLUufOM3rMGL6bLNLtkl/eg=;
 b=kRe6IlyFtP2YTEPiZn9M5j/GSrkxQ3bj/MoIaniffUEtoepkMLt5nWfsvp/WEHhkUnFYtRJILEmzqYo3ZZZ3gewGNhk4YLrp0JtYvyuPmcXew4UhKgdX9MK5riIPib1scYKUO7EweAkd6F1yezDUnx0UBCpYZh1Op5Iw56koewt8lTwZeiWlxOXiO3Plm1SrbOeBtutCqVMYp9gRpLo2f5eO9HqPUTnxO3bsGm7GMnLEVEQARrG+EfEeBezjQa6xnvqPH04NRdfhBzIZCkw1ww0Mbo1OsT/1qT6DMZORnCDo1JDUm+86PSNQxjqgm83OowJNtWaB+Kp4hN2BBtmVpg==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU5PR03MB10472.eurprd03.prod.outlook.com
 (2603:10a6:10:526::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:33:45 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 21:33:45 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v3 2/4] clk: qcom: clear div mask before assigning a new
 divider
Thread-Topic: [PATCH v3 2/4] clk: qcom: clear div mask before assigning a new
 divider
Thread-Index: AQHac/vL3GOuVBuOiUq96fqEYfvdew==
Date: Mon, 11 Mar 2024 21:33:45 +0000
Message-ID: <20240311213334.3567389-3-volodymyr_babchuk@epam.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU5PR03MB10472:EE_
x-ms-office365-filtering-correlation-id: 461be092-b71f-4e01-314f-08dc4212ee8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/QhqY+CDDZtKGuAGy7x0brneyE3T1DxUXAa7Q+gwqY1GdjPKA5+SyOxmDG1AxK9JQ9taiXZzq9Krj1Be9BUTOJzH3HxNL0GAk/xXl++GMYfp+KwrB4BE8/mdGCNfVNT7rs98xoKCgBxbN4pvUhOaz0LVPyPK6RkVZDBb5m3lZ9w9XSjJ5ldBLBR7qtN6/IKAXEHBuNNUlak7TFLrB9MykCEZW9uAPqiQuaFy3UCoKDLzyr4Z2+DvIR7teHxAVHkEslItTIQ/XkzAQht4yA/TvzSF6t7zGLRmnjuvim8Or8geUSJWXo9UnhcdbXWDAvCCP5iXJLhtvNZkaerEdlzUMCrQ5m0g5ol8RLxEfRbhmC+Y2ObXqedaI4bq/SQOZFjB3mtleYBetY3wPyC4exuAEug+MbAUW0jEUpvW2uZuPmGuKjFRuTqb6yRnV9riTuLB+wQCQ6faocFH+OsTtaoaJ+pP8tpmEDV95QY0LfyTAPIMv3SegvtMVYAxXhKdZtCbEWdbxYChC2h0WdI+D4VrMHUzPpt8yUwMPtj6WGjjpEE0IxRZAYzbslgt7KmhvF5a0nTVHBDEeo9ATP4L/df8nWjmi5L8GHVQIp7oJISqdlGw5WmYhl1Yt14gvi0+M0ZJHH5YqxzMoZpwXdifmZHK8BQRskYZ6iCgwlQL8EWdWZ1P3275gRIYDpn6BwW1K4FKqNX+QjD5o2PmG8WvOrrdK3V3TE8ekWeikCYG+w7IS0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZGVBucrl9BlDxYDmyEfZ9UPc2cIfkaDCj2i/SZkGsowR1PwfTVRL1PfIwz?=
 =?iso-8859-1?Q?jgifdpovQ10Ng1SZEe3JepNtnmfR0xwWnSVozeiTpwTNNFavaf7cfvWiWu?=
 =?iso-8859-1?Q?mz9cg4dWJppv208vAZjLcTEVyHi9TYED1dmwWRclrvXYXZCJGJIV65lYiZ?=
 =?iso-8859-1?Q?1vQyxJ/zaTY+jPc8L/tqiX+BWoGkwAKnZ641BiNApPp0A+9nxc7Es6ws0R?=
 =?iso-8859-1?Q?UdYP1pJ+GDNYUnuyCMr4EOz5/IolyL57doX1ANDhnJdQn6u1wbxyiG2bvI?=
 =?iso-8859-1?Q?SZrdt/2WIZb5Dwreut1cYmGBI99gjM1jl6xcP518DsPXqIVChl5k+SVtzQ?=
 =?iso-8859-1?Q?OvdukGt/RLqfkxpncMT1Une/I/7IXvDnjuliSeYzM+Si+eUJQ+aXaEhViB?=
 =?iso-8859-1?Q?pEvdxXHHgfAdkBRrJreFCrSM4FiL0vzRxpbWFeSIqrZjYsQRW+99yfJZpH?=
 =?iso-8859-1?Q?WQbjr0WyICqM5kbVL/bL0cDBtEej3axxz1JDjElwmOVI8khcqpK5h/OyIA?=
 =?iso-8859-1?Q?aNICGozLjLKKt1+0hMnTQspmps+m7KiJuQ0WYJQUTKfOpIZxp/S8A19m8X?=
 =?iso-8859-1?Q?JFFYXFRPYQa+Zly+0bL+mkFQoHICHKqJ55aHR2hBz4IZJjImZkel5UPwFh?=
 =?iso-8859-1?Q?ABW6SEciWFFxkXyKi32Xe4B7l82bP0KHddqEb8YbM/yphuzb4dgO9kwlsi?=
 =?iso-8859-1?Q?ay37lIyCORbwGom6X9N+ApNSTjvDbFjw4nkJTbZB4PAu0/HVbMkxwPs0CU?=
 =?iso-8859-1?Q?7LtmmRnd3OcitMgMJk18nPv+Mj7IZxXomoRgV04PfaCjnSjWnSiX2YBJWF?=
 =?iso-8859-1?Q?YqOfQmGH79znM33iDuJS2554POuEn2rXuPjs7TAMOD7sOcZJW81Wt7Kbge?=
 =?iso-8859-1?Q?sGglovZgK4icprzftHUsTL4ddC7++ojp7+rFtVF3HoefDOjRRpGfLntd+q?=
 =?iso-8859-1?Q?JX+NoV3uYN383SM5AP1S3t5x5o5/auYRXzR89xMim/GwPJT2o43vhjl4vI?=
 =?iso-8859-1?Q?1s76KVdFi2tSGFYhW+OIMnW1/smuBKfnoEGl7eRu1pt9Qcdwsaa3xoS/GH?=
 =?iso-8859-1?Q?N9vM5ExJzOLyb656t2arDcjN+50Q7pri8D+khE8tuut6GkzmODHz5AfLIJ?=
 =?iso-8859-1?Q?iZfdBxv2Pndeg4N9KeuiTveykyqNgwC2HRtS/ctcwxsMdY26Kz6kqrL3gb?=
 =?iso-8859-1?Q?pw0hPR4smETZSVMhsshTYwO9CNsMOYkarl4IGrfyAYaVDY/9uiCqmUTrx2?=
 =?iso-8859-1?Q?8NY5c7cGKPgTAFRKoHvhfl5pMM5nzCKDvNkhJHfIgaMB44T7/Ccs6vCMwj?=
 =?iso-8859-1?Q?pQX9SburSxWtf+bScmGK11ihqO1ijJJy73x2CeI15ssKUniVQAhMYKmzz3?=
 =?iso-8859-1?Q?Ru8O+KD8rA5ist+o2kHS0+FZsGwgaBDVQEYoTmSkyQJsnb/ulgU+eATc6K?=
 =?iso-8859-1?Q?me03XMx7Yy+66gvJttuHb05Y7k3oK44gs3E9do+DQt1uPBzumZMRGIYi8v?=
 =?iso-8859-1?Q?kG95e96/FcWI+x4ZStdQny+oXeyhfxbxRMOabKqB2LTmWS4mHUIbJITSfV?=
 =?iso-8859-1?Q?kEFsKoLyKI2Bq/ZZsTg4Ag6EG467AWP+jQUMU4ArY6m+ZXC4XU4aMezzgH?=
 =?iso-8859-1?Q?/xQeylKTrwWegG7Gor3RSFa5RSVvle/w2KGSWjloWr3X4o7q85Pcj99Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461be092-b71f-4e01-314f-08dc4212ee8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:33:45.4036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClrwAmJyAiuJ3liHVP+PfZZuYcAiUvkKQqbbYsIoHxzA1i8pfht89GVvOReAqIpetJWyQnon8pUA6W/9XDEIgQrpF2nrHiyCNj4QaYvwCjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10472
X-Proofpoint-GUID: wmcb-e-PqBY5tchLbxmNv3dI53T8vX7d
X-Proofpoint-ORIG-GUID: wmcb-e-PqBY5tchLbxmNv3dI53T8vX7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=881 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110166
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

(no changes since v2)

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
