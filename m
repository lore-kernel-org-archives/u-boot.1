Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE55C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CDE880DD;
	Thu, 29 Feb 2024 15:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="mSxigFMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1799A880DD; Thu, 29 Feb 2024 15:21:18 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5238D87C61
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=978922fd78=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41TEGl6X018534; Thu, 29 Feb 2024 14:21:10 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wjuj380gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Feb 2024 14:21:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTnJHoSp65TACQfDM2TK89TGqg0G62m5M5Fm2jGshB4r4+PzYobvdsGgtaW1kibVa7z5xU1ZvrMKyaz54BrID0IX2qjfG1xfbJnyYWEuzNVeS1cGspdMbPxbL0cIkvfIY6yn4RUjwFJf8xJt0bvg6xDddF8XjR6ziteDQIzXgbpiwm0RrZppmZ8EvplTfbtocbc09HJCRxxRjmuD57OnuSi343woKXy+pLa+/4GFdy5q8h86fPJGZKBCdOuZ/6DSKHN8acIExOV+cFNuRwXNIcp1Z1PiTkY7pvU8WmuEU9fpT0+TCIyznO3oqE8X2xKflZNtYnuq583A/lKgJ4s2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kewmv3F4RxSFN4/jmPWqbaWXzYGN77AD5/TpxApFnsQ=;
 b=obxpmA1hKvOBzePExNF+nLgQdKLTXFxllj0czVhMLX7vbmrEwgb2C01niTDZq9uSdexo97T1zSvOjL1otjEy5cmAFs+V7NBNLTFmK3hFpuRq1LYe+0XfddpG9WWTrmNX+qK9ZLR08+g1gTgNOH2uYV4zCwBwETUPBkUljiFC0qrD4K7kvoJufyEjSaMdy3nEz3/7TtpKWnKjjTW4cpAr4frJVgqKBBFMQUiJToJXOJzR06hTQRwpqM7HXQ+fU4M3PoICY/TWRNOZpGQDbpBy02RYiF6a8S1Fq9sk9ZmkEuBCdFavf5xyQNoeBuJ4XhwETG5pR3YfNC19e3ZrYCS+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kewmv3F4RxSFN4/jmPWqbaWXzYGN77AD5/TpxApFnsQ=;
 b=mSxigFMIdhWGL2KuvpU+HyK8s4AsqpNTRn5LnPCUwKya6153gJs0IiPRstbepeKYe0r3XVWBUFqFZsO2Jh0RAf5fQF04mFA4kIG/WohVcxwX49iCvcwKZBu0EHIox3Nh5EUfAS7urL+2iyU0WzHIPjkI8Il/+i7QnF4g6JRYKhd3GNumSZAQaQgkeTgpriPVRI0lcl/ZJHNyq9yXvhXj5jXh/Fn98D7rP8QKND//RoxxORcd7lVpnUR5sXIwfbXP42cO76h2O+A4mgTRO+yBVvWS8Yji+gkR2yflAA9L7R+A/NNISVtAukz8xR15aal91hskXtb3oCSR7i5R8ZRBJA==
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com (2603:10a6:10:516::14)
 by AS8PR03MB7735.eurprd03.prod.outlook.com (2603:10a6:20b:405::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 14:21:06 +0000
Received: from DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c]) by DU5PR03MB10441.eurprd03.prod.outlook.com
 ([fe80::e157:6b89:169f:d30c%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:21:06 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 1/8] clk: qcom: clear div mask before assigning new divider
Thread-Topic: [PATCH 1/8] clk: qcom: clear div mask before assigning new
 divider
Thread-Index: AQHaaxqIASe1uhMlqkaUvm1YPSb63A==
Date: Thu, 29 Feb 2024 14:21:06 +0000
Message-ID: <20240229142043.1263690-2-volodymyr_babchuk@epam.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU5PR03MB10441:EE_|AS8PR03MB7735:EE_
x-ms-office365-filtering-correlation-id: ddaf9f91-1521-41ea-c2c2-08dc3931ab10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ucz7ApVoExf1zw0doXzBmWHJtlyqG8l5T7H064GgRo+/Eos4QbHeh+TjBMlaDfqdnYXoXKuxMa8HIjggPIFt1vGqDYn2GTIwt5/4xhcXTehUufcK7rAIKkS4v4mEOVl4unYWSvRK+qE9VtgySTFDKHZS/wfzpUYHvzxhy5/fz++18eDgDmBVgZPf/JwlbjpGp3nlue1lMecSzChU2o1IOc3QrJ8/75flvyccYYHff/PyZOPrAj4eAGXkjTQ7dc4KahHltrqw8GGlPzrUTojb79VKEfKt39hmoqQ8Qf3JaNZ58f0H6Jdp9HzENB5G9LXNS4e/WVi6QiU6qqA+5WpIkcSwCgmg9cK3zldvbj+nWyaejKwk0JwxMLhjJ204BlD8TUizWskBdFxltlJMhuE/H+wKD4H768T5t1QY9nUoOHr/GDdHPv5rl+faZGoKZuyQ6E2tITu/vQ7pBeY1kcxhruDdMwDbzfBVEQlgF4zbWHZhVqc9hZ9PCU5+0IOmd9zhPDH6SHmFRfG9e2HSIZ36Pm58oDVu8Z4g2MmHINfn5NBNLEgcTMWXgr0arUSHuqwyAkgXbERz0JZGqbfdu/Z5VoUK9/OL12h18WwtqH7hqp6srRlogrlfBl+5cDvFxNgMs3D3ZWyIxFDbOLETu0ttDFYsYtT1saYT0xY3nmyiJ8A3akr/spl230tWEvGUPaGmEJk2s5bmTtF+f8tVVJVITIrKnP/J+kUFAVe2GLV5P38=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU5PR03MB10441.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/exc4fpS2tqO71H5oCRc/n0GgUILWhDz9TfzqhcMrPOfJZDX5ZHhIqSWKP?=
 =?iso-8859-1?Q?n4kcxb3nZ4OZQWKltPIevsZJfc3G/GB8Gtes2Ih1QxuI66cfCDCQdlA7H9?=
 =?iso-8859-1?Q?g9vx/0rwLrhvWiriRcAqdL6sbm1Dzb9b08DQMkNHgZvtJIICBlH1xr5M3z?=
 =?iso-8859-1?Q?1NltxI/NFMFkXyAgjTK2PCYF7c/FtGZDTxA+L6DOzfo6W17k4IQqVrCo0y?=
 =?iso-8859-1?Q?gAow+SzqgwHhcLfFN8zxvL9TXmB2swpiuanXyzrrMY4OZsdHEaMqW7dEnF?=
 =?iso-8859-1?Q?s4cQJxZhqPGo6FL6W0ERHE5s1XIC8LtjqEuF6iS7NOTytBVfU/CslA6xNf?=
 =?iso-8859-1?Q?I7HiMGS1V9s8FhJDNoCJ+LBEJilKk/Wrpv40P7eXU6naIgh0wPIRqWnPJd?=
 =?iso-8859-1?Q?CPQ6GRjz5zrAXmsMiPWhjy/D9oTpGwJzFWGHOtoRw7iXaIt84BQYH1ufow?=
 =?iso-8859-1?Q?6gdlIdO5OFQEzGOIqSUO92u1RKIcauyA18L6mxw9BYTu5h5FRBxWMiTxs2?=
 =?iso-8859-1?Q?wdiOk/MHmFcpFelHsRve0XOZHKkr883xc4YvNfSZYgMCYf1bWjEAeNPcz5?=
 =?iso-8859-1?Q?o+w4cpXWVMt30WFqTk222lyHUll7ttMcPVHsPSE579N3OzofoR/tVPxyOE?=
 =?iso-8859-1?Q?Ou5JOMjMpvDVdgIi4GqGe7nkS/MQdzeVq30MQ9yuhhzFJBB9UhYme5GtBm?=
 =?iso-8859-1?Q?SQk/MR4hqlc7dZppF3gljL9HD9VkX+fAczBoWwNKBP6gcIDdrRz2iObKhB?=
 =?iso-8859-1?Q?/S2PjxdQzK9CCKZr0fwfG1TFWIctBZYF3csnj3t+tOiRJvdar4MwvCK85b?=
 =?iso-8859-1?Q?cTfL5mK6IeRqmADiMhmGQtpg15i9x6PTcuT9vPryCNxBNmvFVS0hIpVQj0?=
 =?iso-8859-1?Q?R4PSJLhiqhYpSWrGJ6hjjcJ/IxXusVlNfTlN8XCd8JCWy2EfwfReTtkgjH?=
 =?iso-8859-1?Q?Vfv+7SS51VIXyZWxfZgfGldD1VZxFKBTBNchuanKMGk7HXeg7mzJMn2l3l?=
 =?iso-8859-1?Q?97n0zJgVlQlz9/33OksLUHtaxFNOu8SAhAgPHRc1sn62Vv6gjEgvJNG+sr?=
 =?iso-8859-1?Q?rXy96Na1O8SVLSUXLTCZtCNz4Are5cp7sIbBKDNT4nhMiaaBb9qKu9BEkk?=
 =?iso-8859-1?Q?HFDeo+YgoRY52rzvUNIGRS/KfEsGcORhvvwfmS/7EvrdMthktTUnOTIYQK?=
 =?iso-8859-1?Q?WUsPmDl6Hq8Mor8NM29JPBxyK2GmNetKEglCMORbrnJFKFHiS/oaPJ1jYr?=
 =?iso-8859-1?Q?bb/WH9/+Eb0t8FfOPmwR39/cGPFXNO63AhA1eJFnWOU2U7xPTDCmP7W+9j?=
 =?iso-8859-1?Q?K56R/3PCunBV6aiE5YHNgWGZWW6POfDYwnlSmtyspHbj55dP1dNcm4KHF1?=
 =?iso-8859-1?Q?d1Bguoi6dNvXtp/524mk2qWt7o6qr9rHejwhX4UStPfA7J5VeFx8oIxrR0?=
 =?iso-8859-1?Q?VnFDUDfed0nu9fs0tyRxMn/VrvgUm9yo+SY18pPf0ofDgmerZTwRAN0/4n?=
 =?iso-8859-1?Q?Jg/zn4C55T+XH4SVlzSBPzic2PTNv1+9nqnK/g9T0jPcxsjH3JS683AWyF?=
 =?iso-8859-1?Q?0xwu97gcFr7xeQGHDwjYb/5202E8fcFojKHy0bhOCcw3fyoDSeN0rckq9d?=
 =?iso-8859-1?Q?d1QAqXcA8gDi08Gt0V/YU2Jjjm/i6DY/Dhs67D7dR0mM3i5zMHqRyigg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU5PR03MB10441.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaf9f91-1521-41ea-c2c2-08dc3931ab10
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 14:21:06.5489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L4gZZVjXe66pIVPoTuBmzeTw9fA3ZyeDBhzHmWSfpAZXNXLj+sSDWkMh4kBIt6zd62o7K7i/IkskmgMHgIGEsn2ldyFfIsS07FnIsLazZJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7735
X-Proofpoint-GUID: K-lkNvul6vDzRaH9BSJvyjUWHvUJyFA7
X-Proofpoint-ORIG-GUID: K-lkNvul6vDzRaH9BSJvyjUWHvUJyFA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=924 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290110
X-Mailman-Approved-At: Thu, 29 Feb 2024 15:22:15 +0100
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

We need to do this to ensure that new divider is applied
correctly. This fixes potential issue with 1Gbit ethernet on
SA8155P-ADP boards.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

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
