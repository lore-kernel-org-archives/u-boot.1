Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E0C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 665868883E;
	Mon, 15 Jul 2024 20:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=st.com header.i=@st.com header.b="mCwlUjzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0BD888BF; Mon, 15 Jul 2024 15:33:30 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFF888820
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7926f054d7=benjamin.baratte@st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FCG49S025535;
 Mon, 15 Jul 2024 15:33:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=STMicroelectronics; bh=oi89jienJZtXN
 IJ/Z2q4QplNyaWFOTKuy9w2kr2T1C8=; b=mCwlUjzrVmc6QfBzEyOKjEZ9ipsSK
 +rg/EO5e/SWFvg2W5Ra6jO8NJ5Ipb1HSkREHdc3lZMJwg65lOrLPJUf305uZl7Hz
 1EwJ+4mFI6p7g4TXJ0/Une1/dIjIR3VQ+uvB+C6vuSWb0pZ4OpHR8ovVC44+833I
 ITlaDMsonTuWwJRCVDG72c6Sw4LCbLgmDyNzgDMN3TWq0BlI1BPF0l/Urogm5k6f
 WWFM+GU8PdvU6qh2+KbFN5F6zYoCiLP8hcDzMthSPgChgkbyVosKy7WEU2+s7dE2
 tabZbWhQNgUZHYSMd8ssWT6qK+PN6wNTQ5qXUksmwwXGFKIdN4Z5J5fNw==
Received: from eur05-vi1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40bgwx726u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 15:33:18 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS5rHZvHC2wiD7nhOyJ/P/7WZUzrK3s1NGUSLqYGu5mUTPRQvj+wlBdRZzf+y5eSs/ILbrGVbTPIjBBo0BaDHZ7UDb3WHZG8dsKaL0OWYdyc4e4ZnbIv97MYxaHCjl4MmT0imtCv94BNO4wDNTD3mGYdsXN+Z6j6XmmYeekKohxIJTGT4SLd8Q0kW0V6npq+aXZW+kyG14nRMf8VoSp7bGfq9BXclDIHFUKfeOYbIjmyOhPJObfLR3fzoQVlhdk7mifwoam5dMeBDq6c4ISzgKKXfzJ+z8enxuQCEjASzjCRkq4P0ibzd2ig6XUnMcWorrhuY6QpyT0TY0l9wriEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi89jienJZtXNIJ/Z2q4QplNyaWFOTKuy9w2kr2T1C8=;
 b=mvY8qNjm3fbpaupWaRRxz2unOFmmrdTpAnhqV46USV31LpkL2owUB7aaWTYM4dd1hJVvK603AxL9X/T1ajOOZ9klRu3gGacw1cVf1zPUFOCSAH75USdJ5g+rKbDH35pbWwDPUSi8ao0eCKe6bH5ofREBC+GAqsOuSb8Wvho/Dm+5UY5Vf10CGuo62OIeLUS4Uv8agcq1xu21yKBSK5gUagva85fHWJYCfHQcv+G+QCtM0p8CFPwDrs8Mxf5+pu7XYJyatUjvXv2lR93lY80/70Dh+kmzmEtRfMDhiagvh/93wHbsj77ZQTP1VMP/lQEV6yYl3KCCAkPDuUdq8eEAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22)
 by DU0PR10MB7120.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:33:13 +0000
Received: from DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370]) by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ad9:b4fe:13d6:e370%4]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:33:13 +0000
From: Benjamin BARATTE <benjamin.baratte@st.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "akashi.tkhro@gmail.com" <akashi.tkhro@gmail.com>,
 "abdellatif.elkhlifi@arm.com" <abdellatif.elkhlifi@arm.com>,
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "kojima.masahisa@socionext.com"
 <kojima.masahisa@socionext.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "sughosh.ganu@linaro.org" <sughosh.ganu@linaro.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: [PATCH 0/3] TPM PCR Management update proposal
Thread-Topic: [PATCH 0/3] TPM PCR Management update proposal
Thread-Index: AdrWun51uDli/qaWRAahQZJ7sIfaHw==
Date: Mon, 15 Jul 2024 13:33:13 +0000
Message-ID: <DU0PR10MB52443C66160A76356C74F512E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=0cb73162-6d1a-475d-b2ef-8b32dbea258a;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2024-07-15T13:25:09Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5244:EE_|DU0PR10MB7120:EE_
x-ms-office365-filtering-correlation-id: befeb737-5b0f-435a-d121-08dca4d2ad22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018|3613699012; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5+iXrkw2YlJ0hXXURA0xD6N5zNPLCVU9454CKL6Xgqss4ZjH+7cmoz2NGzqE?=
 =?us-ascii?Q?c2uBlvQGL1cjl/k10VYqX/45ScJmHPqVVdEaVP8fwAETI4CEtYImZhwPxV2b?=
 =?us-ascii?Q?L88Yhg1TdPQM337dXdt8tE2hvtCsjPWk6DGOPiHvOo+nAE5bYoBd3zQA2Hu8?=
 =?us-ascii?Q?TEjMm4te6vgqD5YtEOeWs64djN2zRpzXY9694JL31wj8wamp3pTJDga2FNge?=
 =?us-ascii?Q?oeuYFGoAAe77R0A0BKXghEFhhTDQyrQNYGdgdlGWGgdXPoG2Jrs4w3vcPeua?=
 =?us-ascii?Q?c+65C8IO8u7Hse4T00z2Z51ExNOx10bC9Kx1HIqoNYcTnJL+H8Pj0VrzGmwN?=
 =?us-ascii?Q?j1WogRzC/WIPN0MYrKF2tcjpahoh4bDt/ZaBGa2PqFoMMol5NjoyOWoA95JB?=
 =?us-ascii?Q?IRZzYr699WFLTPUe/zdbPrpSNb6SIgOA6/fcPA9EO2vgbwURVBQ5vMH3IN25?=
 =?us-ascii?Q?cmz7ERVkRoioxTd6qDXdLQwDhNl64Oz9Cc2ylNUffqXi84MMXMQUVdwD5coR?=
 =?us-ascii?Q?y+vPWF++pjnpJPJAq+HTfZWz7c2WyyrCqKOX1DwU8HGrzPNnU7WAjmIsFp6T?=
 =?us-ascii?Q?GAwZo6kQ8a/QXwUUATJdQZqYm/kiiJ4xPTHePAc7ag6GfgQ8QGrH0BNR9ytH?=
 =?us-ascii?Q?1szHrRqcO6ZPQVD/rS1bqbp2f4RJQXlfzlYJ3ZrsjaWFzlannJ5GxpEkix5f?=
 =?us-ascii?Q?iWjFPpesOG4CP3mDDYpvHTLJqKhHBgR6E2bZzh+ILIsL1lhu3/8FtBnroBrZ?=
 =?us-ascii?Q?j3Zk9IX3BnSMehAO/TgBoxEJIV9FQRrjr7jYpsDwDz/534vczLwQW3LJ+b94?=
 =?us-ascii?Q?JPhwvEm32eJaNgvVJUSQfdk5GXTZswwXhezEGp4RapGCg9fA4s9FaIiHx20L?=
 =?us-ascii?Q?+6XClEXYjCCWmfJrX787YPvSfAZ3DZiy8qIVBaICMx8vvZuDqw8nQ87Kj6nj?=
 =?us-ascii?Q?YQyOSdNeb1eDHvznHgXFd5qjuwrfSIyyYQs1KG4atYJSEHI/B+jejil1XWeC?=
 =?us-ascii?Q?axXZicZfpx1gcOrfwov3cLZ5gL9g2Ua4PGXN2ZP2+FDT7oABcdZDe5X1mh2f?=
 =?us-ascii?Q?PpRNQ4v+zq8KnDNSmpAIg77WgNCAbFJlJPHNRTlzxPJ61D0fxzE//5WqAlJT?=
 =?us-ascii?Q?cj702uw/weTuJKRmfP/Xhac+GRt2BqRjB17T5MEfFYdROqVYJf8zMGpVAZuW?=
 =?us-ascii?Q?duMRrzpZKuhvV6iFLDx+VR4nPxvcaxhmO0yJYwH8m98JVLc/IwKluIFhYCgG?=
 =?us-ascii?Q?hE9VqDuWoxhn9FOv0grDj66rMzxWXXN4EgR7HjgWwirwRfD5JbfuoBTYPiUW?=
 =?us-ascii?Q?TeP+8zyGK14CzrHzG+MMVZVIUmjBvqo5EdJoXpIF1vqO1xD1bCkKjPiDf3xU?=
 =?us-ascii?Q?fL81lKumM28fzMO0VXSwxcqfJNm6UAUFLRLRq0sGn29/2JvJ1LB4zcLbXppk?=
 =?us-ascii?Q?DR1uyWtM/LY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3AYtYClljknvGuhypaRFbNKhNb9MnHM3h+Dnly8Nc++v9A1s5u6FMzkeEfHd?=
 =?us-ascii?Q?UbKe3ZGOiexskiE8/Dc86JSjVg4xhjNjADVnxX/KwDwhPnpWvXCjYVTOCXJg?=
 =?us-ascii?Q?EfpKNogJUanGH0HVg8KFuA5K0OEnr7NcDDZEnNAW6Re0nPSvdy5lQkUqESj6?=
 =?us-ascii?Q?J6/Yt2tJxFXjfuhOn4i/3eITdvQDX+D/z5aoYe6h9wk2kVnjVb1THNlU4gtN?=
 =?us-ascii?Q?96b4lkowikFydVAsqcIVQWyxbti9QTWPaprq/3Wag5+5ymDdodluLUxDmCPo?=
 =?us-ascii?Q?8juShqyp0euC+FyfHOtp8k8E5gRdmUo3nE+2ij3b/8f8ZrZezDJEpU9AEVIk?=
 =?us-ascii?Q?yAh9rekvtM6CcKw4jF8/knnA09ObRazXkKbYPVCBqgNPfqkk5C+z0hZMMv9Z?=
 =?us-ascii?Q?UyxaxsvbHIbd/0GLhUomXXvVDnNmA8eUu/pgZ8Mum34Z+5ZsUiF8pAJz4NkK?=
 =?us-ascii?Q?bFBSGHv2CKxj8DgCT5sZmSFNMXLqkA+OImzl6neXJBMASUP9zzviYwA7gGm6?=
 =?us-ascii?Q?T3bQpMWvzp512vza08d9AY5pHL4rN2lhQc8c1fWnGeaQhQe/q0+AVlUr053R?=
 =?us-ascii?Q?vEcjWCFdd1xfUnsBq4uhMFErIjZrLO54uBwOgxXoVG4njiahYlGvqqj0ulT5?=
 =?us-ascii?Q?siO+NkqVL5bIHnEBXkesS32OLRpiOzi4aCT2hqifRb5iuQMmkLzgsCoiR4TY?=
 =?us-ascii?Q?oxuJRQ3j+BorGacS38lseR/KqapXdMEaVIcrGTr21OkiGV2cG88ReLV7AB68?=
 =?us-ascii?Q?z0GtbdEbIbK7h+81sB//hkKkLf58/MzXnyQ2Opm0P6TnhS9Gkeu3ZwuTsz6J?=
 =?us-ascii?Q?K8VJnevHcA6We9DWdDS7OQ9UnrxM1VTMP2NAxCwbwQ1Bl+b/bevnxZct6wRB?=
 =?us-ascii?Q?A6ThwLtx/t65aaxII2Ry54g/gSvNouunnCJISTrjrcg865DDjoeh/5Z4dt89?=
 =?us-ascii?Q?WphrU/8rIQzttvenenJrNq861PVEXs7ngh2V4iHVVCOklAfCX7D8ElNLtK2t?=
 =?us-ascii?Q?FFayzhRVrScN+zVoLn7/cVa+lmN1Ht/KRp1nmikqqzJbaCx3i11saxm4H7JX?=
 =?us-ascii?Q?jsbgxlLJe+FCx/dHCFZbQLyFv66mKXsWCHpotEwfXhk6AP5SEBflVNUkCHAn?=
 =?us-ascii?Q?hmqQfinh7UdtNBG9iRHORgu1elhDD9U6I9QCLiiNO5mtMo40pwoDaN0nTUlw?=
 =?us-ascii?Q?HtNMVir0DMAI2BinR5Vuxzz0DoHGVu4LcA90zy5Qq2gO7i1ftyiR95po6ryi?=
 =?us-ascii?Q?saS9IcfKJUegEG6G2RyMhLNuTcSiv++SXnqxyWruCKeIAr6JQZ0qY7NImTAo?=
 =?us-ascii?Q?nIWN5p5ud8DypO1p5Fxxqt+sSk373WRmAOPsOOegvnMuVYDHTmVV7LkRONwh?=
 =?us-ascii?Q?MROSNnQGNx7GJXorjdAoL+zt2te5GseoBOidvv0W4VSeG0kdwyw96lZ36KhT?=
 =?us-ascii?Q?NIZDejNhTrt8kITp7wKmfhfS2M7vnS/kt9o0D1TPctwaszLuDlx9Ep+9C4Ga?=
 =?us-ascii?Q?Yfyh8cRyVFdpjwo8L53VnDbn3+GTfq8yoXRvfAPX/L/SGlcROqSt0G8VXG3A?=
 =?us-ascii?Q?sqzkge2yUrKF6m08jJmT1kpO0pLjh2K/C27SOTdw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: befeb737-5b0f-435a-d121-08dca4d2ad22
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 13:33:13.4105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7TykZeXUTEaKLcFPTGfAirQ8fMf7iiy6iaJPDasIlokGoeUaNDc8w76RwdK0gzB3WZSMKRemYC0QEpSe/MOzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7120
X-Proofpoint-GUID: hsa09dOc4UnTFyGSgVnbR-uUF5fbe3sc
X-Proofpoint-ORIG-GUID: hsa09dOc4UnTFyGSgVnbR-uUF5fbe3sc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
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

By testing U-Boot EFI Measured boot with ST33KTPM2X32DKG9, the
EFI_TCG2_PROTOCOL is not able to register due to TPM PCR management.
This version of dTPM support SHA1, SHA256, SHA384, SHA3_256, SHA3_384
which make 5 possibles PCR banks avaiables but only 2 at a time are
supported.

The tpm2_get_pcr_info() exit in error with this dTPM as it's supports
more hash algo than U-Boot. But this is irrelevant as the hash
algorithm used depends on the dTPM active PCR bank and not the returns
of the TPM2_CAP_PCRS which list all possible banks.

The series of patch propose to list exhaustively all the TPM hash
algorithms by the specification 1.59, all dTPM to supports more algo
than U-Boot does.

In case of dTPM configuration of PCR bank not supported by U-Boot, a
warning message will be generated and the PCR bank will not be updated.

This will not change the boot process anyway.

By highlighing this, I have seen that the commit e7505b3:
tpm: allow the user to select the compiled algorithms tries to provide
more flexibility in the embedded hash algorithms by reducing the mapping
from TPM2_ALG_SHAxxx to the U-Boot supported algo. But it should extend
all tests of the TPM2_ALG_SHAxxx in the lib/tpm_tcg2.c and Kconfig shall
no longer enable all the hash algorithm.


Benjamin BARATTE (3):
  tpm: update tpm hash algorithm according to tpm2.0 spec 1.59
  tpm: remove check on pcr bank count
  tpm_tcg2: hash algo optimization

 include/tpm-v2.h       | 43 +++++++++++++++++++++++++++++-------------
 lib/efi_loader/Kconfig |  4 ----
 lib/tpm-v2.c           |  8 --------
 lib/tpm_tcg2.c         | 38 +++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 25 deletions(-)

--
2.34.1

ST Restricted
