Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24032C4450A
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 05:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72ED84ACA;
	Wed, 15 Jul 2026 07:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sony.com header.i=@sony.com header.b="JW/PVDhI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D26F84AC0; Wed, 15 Jul 2026 07:03:09 +0200 (CEST)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71048846A4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jacky.Cao@sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F3nJMF1840190; Wed, 15 Jul 2026 05:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=p1; bh=RS5Sj0X
 QnVkTZ6BM1BYyBqs5Ha0JxHVotsvq99ZAUkU=; b=JW/PVDhI8rLzVt+IdimoYyp
 P2GMWsxNGf3qawmr56xw8SfruOQmItqtAAWhOCAM0yAEvlqN/3oScMXzaP7pn4Nd
 HMpKgQHP0LUHe+XQRZxgin0FnTVx3lMi7anVcyQMpc3HwDX6bcGGJJk9G2YiEQV4
 SCWhgt8FTmUXC1+a5MbTmsYJc8F1YA/udyk/xnR7hmMyt1D0tKf5c3xeDB2jGTnb
 GCaDdlCn0i966EYsWXdSX0pFSQHLIAD3TEDUTTM2Mmno8pdsE94Q1oCMlv0Jo1c4
 9j8M/AhdZYiK/lfpeTOYxkZno2vIsmsZ+4IsL/3eC5tWHlN/20if+D3L/t7J1Pg=
 =
Received: from seypr02cu001.outbound.protection.outlook.com
 (mail-koreacentralazon11013029.outbound.protection.outlook.com
 [40.107.44.29])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 4fbegnc1wr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2026 05:02:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL1OZRc763WfpjRP+qjEgtp2U5nyqwJWuugSmPuh6jH44PWJLVOvHVfU0zMS+Tk+b56Veo7p8lHivMSbBlIdNoIH1AjzH8raFRfMLTtAbFXDx2uWegWUNwf8q//ueUTiHQaeJ+K7bdFyIYDm0w3dhHNQeLFbTBfF/qk6tlqKNMkw1MsJ1McYnjXAjzJXqnhlp9PE8E73LZenJlyiLNrEeahFXUkk8+KA7gJWy/9OsHT1Xc9pvA2963Ln6quVkZgy01UDvXgsfRpkcR/CwVqNaCG/HWerYVWwItZ4siiXVVa04C5hJa3VEcLvx1KCZ/ZrJf36tS9kNE+h7HyI5F1z/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS5Sj0XQnVkTZ6BM1BYyBqs5Ha0JxHVotsvq99ZAUkU=;
 b=mvQa7K/Q4aixUUmL0M8YQKScR7cY5im74PI8aJm7saOhBaXDsdNDSroyapYNKHbgC3TgLWabnj9/Gzd65xTBMBX7tb69vpIo5/nBg/IlIThSwy4EgBI/P8s1FRVADUtRN5dGDhM3yRQsj50r6vGRl0lpPUVhK3zkLKEAD96ZrtJpLfqEydK/GWlBmTorMOr9QG7f/be69CdN0bshPcyCev59clXYh4a6/opXG4GDYcGkXS0dbHe9L6ANgrWp3u84UEOoSH4xpY6tF8QUMyoXkCqOvn/4PsuG7o4zwyRHjEVKe71A0utoRrv5BcYnZUSRSMo3xmJjFbj/JXxb/pc+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from KL1PR04MB6734.apcprd04.prod.outlook.com (2603:1096:820:d8::11)
 by TYZPR04MB6739.apcprd04.prod.outlook.com (2603:1096:400:33d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 05:02:40 +0000
Received: from KL1PR04MB6734.apcprd04.prod.outlook.com
 ([fe80::6812:7cec:2e9c:ad96]) by KL1PR04MB6734.apcprd04.prod.outlook.com
 ([fe80::6812:7cec:2e9c:ad96%2]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 05:02:40 +0000
From: "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
To: Tom Rini <trini@konsulko.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "nora.schiffer@ew.tq-group.com"
 <nora.schiffer@ew.tq-group.com>, "Steffen.Doster@tq-group.com"
 <Steffen.Doster@tq-group.com>, "alexander.feilke@ew.tq-group.com"
 <alexander.feilke@ew.tq-group.com>, "Max.Merchel@ew.tq-group.com"
 <Max.Merchel@ew.tq-group.com>, "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>
Subject: RE: [PATCH v1] env: Fix compile error for envtools
Thread-Topic: [PATCH v1] env: Fix compile error for envtools
Thread-Index: AQHdEqINARnpMVEBj0S9fvVbX43Nz7ZrP/JwgAD8eVCAAAVtAIAAExawgAE35QCAAHu0AA==
Date: Wed, 15 Jul 2026 05:02:39 +0000
Message-ID: <KL1PR04MB6734613DD25966E9F4CC6F9287F82@KL1PR04MB6734.apcprd04.prod.outlook.com>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <MRWPR04MB1233021A0AF8D2117DBE5984888FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
 <KL1PR04MB6734F919E17C467C8B29DBD787F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
 <20260714015324.GZ749385@bill-the-cat>
 <KL1PR04MB6734A43A5179C30DA1F9B9A887F92@KL1PR04MB6734.apcprd04.prod.outlook.com>
 <20260714213802.GF749385@bill-the-cat>
In-Reply-To: <20260714213802.GF749385@bill-the-cat>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR04MB6734:EE_|TYZPR04MB6739:EE_
x-ms-office365-filtering-correlation-id: 68457bad-a9ff-4d15-7e86-08dee22e4bc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: vnaOaW3GBMGvdoN7prNJRVBqFrFWJ6RCmG7maGy4Keo/K+uTe1OIQZ1mq7qaOXCdyepk1rT4f1aRFxaGxCG1WKY5Bx4x22BpwNJKytCg/G6gyhSIa//lVuPTO+Ds5D6PjeY1L/eIkImVy/MB+MBM5DGhz6eVNcc9EkrPcwUNOfSBZqwOSRyGilzH2ABfZ7cdV/7V2GWXbqjHZ5lWEaKrwUVZHIsQVCEbCt8WbuISzVhvcPYswpPKF0M8hEPaFmcDy0Vv1wMKyzpbvqEsdvDqkiH+1vfYCbLlm+Mw0vqplaR0bRXtGpPpr9ItJuUNm18XEmm493UL0uSl28j8MVdAM3gIUDuZ8YRdOkZ/SqxPzl4xlL1i6yTgpwxopVRW/P1lM2GC5wVLrmQ7y2ot/yz8cABg8KucWFRs5Nh0gf8Z4UGLkM4zv4ZkBYODEByopgqKdJiAu5M9YB+ZbW7FLPfI3yj+oTlYzFvG11YgIHGZOeWEE+u4b4x+g3rVvvDLMriADADPZ1qW8o0ESIVJBSWAEvNDyBMfzy8OlT4jgp4u1YjLnIg54IKxevD9vOBMR7abec2Ymkr60W/7mYSGdsUF5Pp47Lkjnz186iK7RGdo3QOkBxMtxNlxTBRW79BIa2dbbEyzBCYbd/AatS32/DLbQFARTOX4gRlzsc9X4Um5ciQoYE0oVx45AcRpRWDnhHHw3QAxhNjZCMdWXUz4uGnvy5jw8rZH3cLpBl8BKRmneqE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR04MB6734.apcprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BoCYjUyMylLOQvQtJny9PYEwXCXopYP7vR6jHUB23U7irw894H84CpzPdpyA?=
 =?us-ascii?Q?AnbPGcx69tE+qvQgrwxh/VwvC8sHX7pasbh9n/0JEi5vpgDTeLxi5lhsRzb2?=
 =?us-ascii?Q?ZHCcWebCndii/7qAJ0gsOAm7geAyCGp6NSwULOOVKgz+BF1gZKySmC6kBQbh?=
 =?us-ascii?Q?n9Q3UeuoK/Gx7k2ZWLZn6fQi2+GdeF9wjE8bRZWNrEQJ/xVA+4gdAhf3aWry?=
 =?us-ascii?Q?T1EFnw/La+IvP4GFs/VU4p8/PCy3inQpgUjD/Tunuyoyv24T0XakDQTMWG3R?=
 =?us-ascii?Q?a6X+nIoGIHVKSeMiSubgGTJQI7G9nryL32RDGdLaOsF3xOP4PfBAGUFEkiHG?=
 =?us-ascii?Q?xd3ODDz3No7dwZCupYCj9WfpmvpkGpXK0JJpWLEThJs85lcfjRCnHDrSUdfX?=
 =?us-ascii?Q?Vyx7NMqUDfKlCdhzbY/ERlotiAdyDelxSNsJfPlecwpEfF8bqJbNMDvKkMBl?=
 =?us-ascii?Q?JTSYBIUiFZjuX8lKTRukR9XtbWcDBTnZJiQkUdfCLI0t0PNlZMRUCimR3Zda?=
 =?us-ascii?Q?LsR6zJ//8j/RMploPecHWfm9nPESe47po3V1q6wfZdlIopuvC8ypGSlMMBBa?=
 =?us-ascii?Q?fE6/q/EGaI+91sBoKFyy8wvVK6ZkthK43RzCLpgypgJMcSxpdPc5vC+9Bag2?=
 =?us-ascii?Q?Ok3+OfIRasJMuol8j6Vwal/DcD4Vt5QJJkZfCIhs6aGVzdlC6kdoy0hw6upQ?=
 =?us-ascii?Q?gjRuKtOivFwgPZ6Mf2Kfbzg82NycUEmzEEXP1tVnB8tmOAhptqt1dq3WoB/Y?=
 =?us-ascii?Q?bKalpDtS/d0zKAiUMUyRfcD2EuzCsDKpaqVVWACNgZVIfVCM52mIb0dc7fl6?=
 =?us-ascii?Q?zKUCH2GnEVpckTX4Yk0uJgAXPG09HfNvu0xWWndp2Hyau7EHYTZeoXZ30hvZ?=
 =?us-ascii?Q?o7qBESm7KFP423Rv5r2Go7ks73KUHf3pVPMq8FPTjGzKdn/JUtxRB1dLgvrY?=
 =?us-ascii?Q?ngWQ7vKFasxY/jWd8vc2r7o113PCU4IbC61LY3ZaYqJgR2l5Jbltnvvnj1b3?=
 =?us-ascii?Q?ENijBmSlpg9HviJ39YfTqK1dNZagR3rMrEv5hbV3FJB4/y66pqyC3u7WTE/Z?=
 =?us-ascii?Q?W8uiYnu12p9MKb9weEPMc4ZUwZgN2D+vqaJBrL8FWj7coVQn2shdOp+en8I3?=
 =?us-ascii?Q?R9VLViNSQJ8EuLxbcOglwnYdXv4G5hSdCVUVGKjrepd85rntOa10F742C/K/?=
 =?us-ascii?Q?5JpMTvrbkVnzmb8+U3CXLAFiBYo3J+U25eoDwPwvhYI7e4veaHXA/KWX/ZqT?=
 =?us-ascii?Q?zPDr87Rq2+u5UxZdziRi8FW1jFEu+M6KkTHCb7l7svs4H0z/Okz1tH9/tDFG?=
 =?us-ascii?Q?lntFsU83tZH8LiHaBIf0haPZt/wer+ayroClDnetCaWvorjUROnH6fDa/EsE?=
 =?us-ascii?Q?lR2AycsBCwiF82iTi6rUMHJZbO+exoSozIRa9vykY8asZuXWvgG2NauGC+io?=
 =?us-ascii?Q?ClwT+MdeJ3XpXMuzfUlct+2cVGXp2+XPJNli5ovYqE5sIPUXDqKP/ofPV0DD?=
 =?us-ascii?Q?Qdj2M79wW77Rab51/WtcYSIh3fhIqiTey9vtj7A04kfdsaNIhofAb0p44wm7?=
 =?us-ascii?Q?Z4jUs2EmeDzzRdDfgiUiBDQ8uD01jL4Ztm+rHsMKax9R9il3NKbAJzclnIbh?=
 =?us-ascii?Q?a71W1rGGhdX4WDhYIlB9/Iwyr5M7u8G3aBfZtRI/ve5VSD/YgZsHIiteA5PD?=
 =?us-ascii?Q?Jzk+NLrzLBJTyZp/4btXQPFWXekP77SrGtiifM64S4/c7aZx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZqI5U7Yw5GFIhZfw4Ic50dgA2CaYpU0zb5lt6Ivqbo67rzp6P8xOoToPF1qg5I8tIbs3h8gsB8WI/nVyw6ccYYN2N2ur+9mhsVhpnazGGXluLoc3exo6gk5wlAMoQPFl+KQ64QAVyGmUgoyY4xKlGtcT0TLSxsgZDvl8MPuRgsBbo7mWFQhXo8/Ru0vMAjiglKsQYbC0vn2zV7EuM7YiB3PV1aOMVx98+DMurCg2IND+buKgcnJKHsjHGEVR4QNcVdo4OfNwoO6e0Nt6ms7fkMZcPuX+U7vLK+Os9mDsOI+BefhLEKmWPitKNJugRFVWfAe+Kni3NETyIGlB1FhD2g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /l021zFLfkTCGQuWhKcaJdVabT2+9xUFwfPSPgW7dcwvyJH4FXb7C2l0hK6UsXAuBP7D7uNDNfNqYsgZ0LvWxoW0oxJRUrYhXT5D4Fyvu43GJSlOPUDe7BjrdjhRa/zQLeLj3FDS5vLMxWNK/1D574svTfL5sO7ZWN2ZL23al0DzddwxhWlGG8jyCzhdxrDq+DVRE0G9/dwYlGLXJACI5qtqoHgLKZ0PECMXhlEwKHCrLniq2A7xUa6qV+wzrSpqkVg6XbLWCR4a5YwMrw83Ig75ru5wjqoIjv2qxeL+zSERr9UYwzYomj/HP4MPmkeupfh6PcZUO7XBaHiCJIGro9bGb6xF1MVpdq7ZBiJU7b3phsRj7QOBGUFMCYSdm80VtZG8p8U+LFB/8E5JlkOl3O2eeRE2MGnZ9MxVqSBaMpDYINvqxAqm5uwjJH8X0xzj3e671uqtjfDtoiBsXBZNAy5sS7YtXZ+sgYkod0AtQPqywK8+gbIjuJXMeylc6F89OJBbr996wvvLauU9Qk/0mG66figNpQdgxKbp26pZvbJQMdf1qIxbLZyE4LJ+BqCtdMe5RHB6MZ4gcLUqVzhAqT4aMmrOzsrtVKbDYhUG8z6DkOCI7PWFz2BQAF0sCxU3
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR04MB6734.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68457bad-a9ff-4d15-7e86-08dee22e4bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 05:02:40.0483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Saev+/pbHoDHSN2FAH1ZxgIToDROkltkf6fcFzkJkGMP5P/oOocrHMcTRUlU0U60FGnApSGr4rTY2MmtpDW2Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6739
X-Proofpoint-ORIG-GUID: zlhFb0rNuLMuD4B_CAxwLGedgmUfMnZX
X-Authority-Analysis: v=2.4 cv=f/t4wuyM c=1 sm=1 tr=0 ts=6a57147a cx=c_pps
 a=+YeZlyKqbgbo03hKanuxGw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KAb5x4SsHD3PzxGk7EmX:22 a=6Vn1QVPt8UGdu3r8PAnt:22
 a=LDj8jnAUO9HT1gaRq5UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA0NCBTYWx0ZWRfXzfIhHHC9UfAy
 RjbYx+VRhag+yEZFC4+atq9th16dIC7zCmu9x/C3aag6Wc8AidcF6Nd+TqEvlaOSk1fBDnarSiK
 F/x2Xm2U3X2E58WWsWNP8KA64hQgGucB5i86Lbqwkid7jZiGjnitGfjqYqpIl0mfybO9LcZ3jzE
 9aquTanijgLQ3n/NevhmKxWdP3fSuh0d/UmwDXsFsJYuAk8QVMf1TlKYqzefsmdZ04XhjDZOEbZ
 HjiIFPFNs5mDixfAjiFV1Gl4fBxpdge534JzXlxFHked9Up2aEC64QTS5hOzK/w3ePqKIG3OxUG
 O7DDBCZhFLaF+8abPFfWqVA7+6CY2kroluDBKCZpprgoBv/Zz/HVw6FMPV8VZzgJmaKx3aipGnV
 CiUFIOiGVqsnqD4Z4bMkbexnr9eqb4jAgNFrPu46gub3VoxMHas8AS1PNuH/2d9dKsHM1FJFk8E
 38oIdLXyyISMVKfh52g==
X-Proofpoint-GUID: zlhFb0rNuLMuD4B_CAxwLGedgmUfMnZX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA0NCBTYWx0ZWRfX3QiV/r/A2u+S
 7n+x9rWsVGERDCUf1p6S1HqsfWwxZiQFDBVaAcGJ8P5C+sKDtyTJiq/hANQLog5cQWieSLJHOnZ
 IMYTWCkxqf5wykC8UpMDaQqNvV5AhURZQyrJiYCiiJyQ8AC/fgT/
X-Sony-Outbound-GUID: zlhFb0rNuLMuD4B_CAxwLGedgmUfMnZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Mailman-Approved-At: Wed, 15 Jul 2026 07:22:45 +0200
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

>> Host OS is Ubuntu 22.04.3 LTS.
>> Toolchain is Arm GNU Toolchain 11.3.Rel1(arm-none-linux-gnueabihf-).
>> Also tried Ubuntu 24.04.4 LTS and Arm GNU Toolchain 15.3.Rel1, the=20
>> issue still happens.
>
>So, are you on an ARM host too? You aren't specifying where you are / aren=
't using the ARM toolchain in the above. Thanks.

Sorry for not explaining it clearly.
Host machine is x86_64 Ubuntu 22.04.3 LTS.
Using arm-none-linux-gnueabihf-gcc 11.3.Rel1 as a cross compiler to build u=
-boot and envtools for imx6 target.
I also tested on x86_64 Ubuntu 24.04.4 LTS with Arm GNU Toolchain 15.3.Rel1=
, and the issue still occurs.
