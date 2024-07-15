Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7961DC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6CCB8886D;
	Mon, 15 Jul 2024 20:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="ncF4pJs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDA2388820; Mon, 15 Jul 2024 15:33:44 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D409388874
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7926f054d7=benjamin.baratte@st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FChwIe031567;
 Mon, 15 Jul 2024 15:33:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=STMicroelectronics; bh=AMrJ72fhqw6cG
 8FcVjC5Bq7yRtZi7PMUoIUvCB/UzNg=; b=ncF4pJs4ohClm50J2WhXmgphwHfdv
 XKqNPf9C3rLuWLHkT1U0VVb/7E3qac23/aZOryhrPHllZqInkTivZ6gcem+DiDks
 mmnh7/vSEQVGdm0wfWGrAtNedaCYeMu1u77+cBLK1kReteHBMDBHvYASfcFztfi6
 8pg51og9dHNe5W0VIcfI/a58GZIZ5sTSyHudB6jn8xyNKxV5mJryynbijeuZAOfR
 XilEAU9ud6CQt28QDxh1lXuFEQKaL8L+2yk4c9RAUd1+xSIdtSlNENhDKxFUjSUG
 OQSoMc4uIyquzDnZyS92HBv35c6X0pd9sfOvwbihoWIamdCHnEZ5uvDcw==
Received: from eur05-am6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40c4hhvqc8-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 15:33:21 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJFTwoLR80hua0anxjuC3+24VQzRDmYVhuardlGcVgnDCr5gL4mqLNXR5CxS3KQGNbYCZ/tmnYljcvHJQav3KsJaCuS36Wan5zEgeK2lyQbEfh1QUOGxF6qGLZO/8pkbcQof/x3zfkzI9qX4me0dx1BQrAmpr+12eh8K6h6JHL7yxRa39m+Ghls3LlEV994SoiBiu5TirLPdGUis8HFvRkr98GMyb+8iR+ApFkygh7yi9G2qQI096+jYZwwpVqFiykILC8jo1wyLiRtxncfdlsoloI8QukTSXK1s4zoR4JQg2l2BshFclXmmzSoqoGTdFRe3re1CWk+th2H0StezaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMrJ72fhqw6cG8FcVjC5Bq7yRtZi7PMUoIUvCB/UzNg=;
 b=GN3WG3fFubg9hoi8ha0EC3VzWK7c/YbbD54DfuNNBGWsJXAt8VPwS690Q4zcUMYBxBTElunJ+/3pdkIo9GqQKLXon8B7lgZlYHAtFwS4EhHjeZkw1TgvO9v7NHMyGsHsFrmORLbWv/xNJRO/64fQLmI+ycwbGjEosuw24SdWJ+Z9qOXQhmlNERRZUNijHh7jm9s89r5A/yhPs9A1MxFNnIqgOhV7IlUlyllmFN8kJIK7qAP67d59bEUVHZ8psfrP/NYH2gZPc1qxxUulPbnIvSoN1SD5gReOVJuwrtv3L0zDcqawUHLlellZpcdRIfs/hyrIVfRPxczXSmQXWMTfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by DU0PR10MB7120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:33:18 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:33:18 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "eajames@linux.ibm.com" <eajames@linux.ibm.com>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "sjg@chromium.org" <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: [PATCH 2/3] tpm: remove check on pcr bank count
Thread-Topic: [PATCH 2/3] tpm: remove check on pcr bank count
Thread-Index: AdrWuwzJuY0rfat0SsmhrK3kEjxGLw==
Date: Mon, 15 Jul 2024 13:33:18 +0000
Message-ID: <DU0PR10MB52447C746D35B2C948CD2003E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=12646848-daaf-4a1e-9623-964ad9b84333;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2024-07-15T13:29:14Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|DU0PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: 398d2679-223a-4d0a-82a2-08dca4d2b002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3EufX6v+Z/W7GA+ffvZ2TU0Gr2znjsVY8L7YUO0k+7Z7j9WWKLcPnYG5u1xl?=
 =?us-ascii?Q?TAwrFIo3O/0LgaRbxDiUxMsMm9HQCcSNeyBkfarkB9HyOmCbslJAcH21ENUO?=
 =?us-ascii?Q?vLF7EVZSMAzoYtGgrX/huceheCFesvwHRDw/GH13RnPdwAs5Te95P6y6T+UA?=
 =?us-ascii?Q?EAsYH2ZhjIomzPP5xreSdZCD6OUqEtIf1Q5Mp9SelYOss1VOjdAX3jdLcvR6?=
 =?us-ascii?Q?Lhtg2UTRKhuD73ibBpBnYH57IIsOFLE7z48nx0uxew2ZDaxlhYFQy2cwRSy/?=
 =?us-ascii?Q?AwiWPPSihfhH5sNZVVSjVmBF8GxrAIUqfYpBz9lYKUvHjjXFgkzi16DijreF?=
 =?us-ascii?Q?Pt/b1gJhxqt+CXRwMG5DAvY+mLfJiujUyS79sDvhudTyImCOdRo8jX4WgeYr?=
 =?us-ascii?Q?QAay0FXgkqBHT+OKxXl9qFoLza4CvqbqH1q4g2G+AhZ/+6r+zqJMetocLy+Y?=
 =?us-ascii?Q?VkczCmCEFqdNh09F9uxVNj/pUFfDKSmpEspUQnMAY1NDHF648fpcMZx+C4FV?=
 =?us-ascii?Q?erGx1ezCAWqwDaqiJSDmvmNzws+7DHXCOv1aTA66Lfxop9cCcxR81ZGf9meI?=
 =?us-ascii?Q?nI+abx+u3FbU2XRxSGMNKGKAmncDtEjJkzN+T0xfY5uwpnUOQVoUV9nTjBM+?=
 =?us-ascii?Q?0onM0KZdNTWrRGVdB/LpB9YITEFQIWSF4guTyN4tNHrahNS0VPTlGnWp0NQu?=
 =?us-ascii?Q?uIpHVMRyWteXJYrmWAUOazgiJrpKoJskIiLOJu4Uq+PS62I7VudIvYhLI1nP?=
 =?us-ascii?Q?pL4YWlMLOVmrrxFamsWFge5wevtxlQZ3yxQTzXrNI2uxjhPE3qphXC+pQSpI?=
 =?us-ascii?Q?9mi/1QTmBA7m924n2C0vFf89BQCanM0bBPEhU0g7w7nHqZ6mHOdH2v1j+hR/?=
 =?us-ascii?Q?w3KuBCgYiqiizyda/Pk+anCaa66nfj3iD0pkEsRQqWjv6e6piCD0vzv7SCt/?=
 =?us-ascii?Q?fSIDIjdtSdAU+C5skwW6Bjt2DQ4yB/2jzMikJXJAeeAoXrwEgBCGcfda6x7l?=
 =?us-ascii?Q?Y4SIUvBh+sHh3Rryww4lK1unzx48indI+XZIrhnLrtPlcQ6+5IDQMUAqJX5g?=
 =?us-ascii?Q?/Cmn6kzr+C8x8Dr2EZcAeaV+CtYrOBlnBSjcRl5CsT08hwDKDWBuSKnJJefp?=
 =?us-ascii?Q?LwTn6XITT7IeKxtK5+UnS0KW2Od4BmkNBDUm7n6uDk55qXfP8IQ1xG+RDtmd?=
 =?us-ascii?Q?/7uQk2kn+Uu/xhCmHW6cVMwErwLqI8Hs9oshMVy97vAiKU45jMvzkq7Cu881?=
 =?us-ascii?Q?S6VkautEDd/qYNTRXB1E0AYj7zD0IIkauinn3cRNiYRLPsFcV7L0wO2lHnF8?=
 =?us-ascii?Q?6lndcqcYA4LBIZIkRnRSY2Z2jboKU50CyIoiod1VZrR8Ar11A/R/f1tInm2A?=
 =?us-ascii?Q?f4uo0ypkpoSUgmH6v4vyH/GfePW1VgQy1vN2ZEQIJD+pDH6XCA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yFWLWLL5CFNnh8B7i+hf+C3BCZnUW7qSY9obl3JBeBVWR00UA1GP7cf3R4/8?=
 =?us-ascii?Q?QytaSzoGnBQR+BUHOAaqcg75ouX8AgNTIxJwcV8pKEFeyD3gOZLw1VCOM6Vn?=
 =?us-ascii?Q?WEwwMn3eHE8D4hiDqQcJIERo2q5UlLH2YEPMBAFRidgAg0ows8OYzbVTEy+0?=
 =?us-ascii?Q?HGzNZxCRIf5co3VLWeGBqvQfd5k0CEKIRLSwEDOtzUYipUApJ9+xcrWzp5Cy?=
 =?us-ascii?Q?Mq87j1B1VBvDGY4oGUr5jDPeYLWdYbyVinMHsXPfn6y1iCJMziLxwceJaQGn?=
 =?us-ascii?Q?E3fu1+zaT1etbvFi0Blu4a9BY1cvIsRCrj4KWQSf9bYziONqZ6iMifh2BoGW?=
 =?us-ascii?Q?kW3hYiulAuuoiSG/hHW7NcDuSn0jmToFHNigIXttZihfq+HzryXdfF2qyDqT?=
 =?us-ascii?Q?xdyyubUAFYLTTN0uy8NT9nPwLxMuAJip/FhzGSg9oOdPuzePQbnfshM38LA3?=
 =?us-ascii?Q?8CZ0MnPPjmZxgfb22SLcg1ReGfyhejDoOKTii/RHPJDvyHKzQ40OxbLkSTtJ?=
 =?us-ascii?Q?uYxLnbKeOB1V28pqDImfNcm254lj5n4/uxXbZsLwSu4h5HbB5i4BvpO4NEC8?=
 =?us-ascii?Q?BuUdBKm8NBotOK4muwQJxt7qDK6Ojd5GinLJBH6Of3ZnL3ke10EKGcy4QSlv?=
 =?us-ascii?Q?CVLRGyILj9qWTaFVIga+YkYM3ykqf3kkkRb9fB2jKTx3jsdGel+bOoS4nMby?=
 =?us-ascii?Q?ZOyU5jCAIvQ3+FJbeCxKvMVDD6R+hh47OMtOX3jiYKEC+5fT3V2tRn5jEuhS?=
 =?us-ascii?Q?hqoPFIu2EXIYBilDATlr5ZBYsbSUfgK6YMr7LD6rwkwDWFGaRFspE03Y0otv?=
 =?us-ascii?Q?lVo4UD144yuiOWJsdBL1eXvT9G+MUj3a86ZbMDy+xd0k1LZwfy5enKIeDwfv?=
 =?us-ascii?Q?/etxZErnda4XdhYHUoeT0NB6Tm//pMDillfA4ZQrKryepTZRpMzm22ZS/s8G?=
 =?us-ascii?Q?GCOI3Ew0EljMyZX10N+FGdZNJOktothc49LSjr3AYmYM8NJaB1JhOjwCxueP?=
 =?us-ascii?Q?SUyQIFTPd0588D6d3yuyTAq8EnLlv/Q2oAZwleGGT1xl1LrVAp/VDAgbMQ75?=
 =?us-ascii?Q?3pm5f8JMs2jQ8ybJan9Zn5Q10HrtYiuKwD75lo5xhbka6R7By7Iquit6xQs5?=
 =?us-ascii?Q?2TkqIUDY1CZNyukSCpchb+nB8XX3ZZPcfKwReLLr/gL42/QXKkijKxgrxLp7?=
 =?us-ascii?Q?+c879bm2oyw1XKyH9s0vWVBf+v9iuLmUcK0xhJCZYHIP2ATsFUDgTY+VkW4k?=
 =?us-ascii?Q?v1ITa9otMsMAhDytaLtxnxjnD67Bs/k8k1uQmwnIDBRz9G+AKvBgYQX3WrXx?=
 =?us-ascii?Q?WxY9RrsIUhjrfiJ52EH6ibmnbh6krmdyv3AEfdz2oxVBsFf584b3Xw34ztVv?=
 =?us-ascii?Q?9+dQCUhDT6H/wpk0fF7/AxC9S4PZSVGJT46qLsOD9X82PRNZg7YbmKXzYuNh?=
 =?us-ascii?Q?BqM/J8FyFYhai5OnAS8JPqaoIEqJ+7ZBQOe4OOcOPKOCIuvJ1t8RDAGdczIK?=
 =?us-ascii?Q?9JpnVJI//Wc7uLjyyD0lCHXSA7dBVRgeKjhFJFzGQX77HwVQtI8eMCdO7kiN?=
 =?us-ascii?Q?TDc1mRVH+W18X/cHJBBRzg0sSkaCZP6baY8u7YzR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 398d2679-223a-4d0a-82a2-08dca4d2b002
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 13:33:18.0679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIHJixJlhXBCUAT52pLXeV2O4YPxg9J21YC6VVSGQDpW2GNgREd0pbSgg66Xw2XpjnMAFDl9WOLzC88ybX5hxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7120
X-Proofpoint-GUID: B0xbF1lbHq_eo5_frWvFb9luACz93qW0
X-Proofpoint-ORIG-GUID: B0xbF1lbHq_eo5_frWvFb9luACz93qW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150107
X-Mailman-Approved-At: Mon, 15 Jul 2024 20:14:57 +0200
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

The number of PCR banks return by the tpm2_get_pcr_info() is related to
TPM supported list of hash algorithm that could be greater than thus
supported by U-Boot. This is not an issue as long as the PCR active bank
hash an hash algorithm supported by U-Boot.
Therefore, checking the number of PCR bank supported by the dTPM and
thus supported by U-Boot doesn't make sense.
This test shall be removed or shall reflect the maximum hash algorithm
defined by the TPM2.0 spec 1.59 which is 8 hash algorithms.

Signed-off-by: Benjamin BARATTE <benjamin.baratte@st.com>
---

 lib/tpm-v2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 59e6cbafaf..64a2f15fee 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -413,14 +413,6 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml=
_pcr_selection *pcrs)
                return ret;

        pcrs->count =3D get_unaligned_be32(response);
-       /*
-        * We only support 4 algorithms for now so check against that
-        * instead of TPM2_NUM_PCR_BANKS
-        */
-       if (pcrs->count > 4 || pcrs->count < 1) {
-               printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
-               return -EMSGSIZE;
-       }

        ret =3D tpm2_get_num_pcr(dev, &num_pcr);
        if (ret)
--
2.34.1

ST Restricted
