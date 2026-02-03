Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F2AE8783D
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E947842ED;
	Tue,  3 Feb 2026 15:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PMFtBl8Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD3A842FC; Tue,  3 Feb 2026 15:46:35 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E54842E1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcHlILPZROkJgu/Gv+l8XzL2Mhsy69y/fj78LMjC6iKQRrCPQCVsBsMcp32P96N2ZXzutTDFObrSauXw9z2fcMkLOwGoezMSLGqYw92Zz/mX6DdPNJTprfJYyvGeMGNN9sEm4eoPD+yF9iQBRuZmuaeGrv6b+f2EJnIwQdCtb0pG6KOs0YIgPpQ7C6jYGysKZQOGG8NlMirFI1nahR//qlLRDrLUfuXxb8UR/aSCD0ZcAcsjdlcHRoH/H5N55dfiVV/vOysAMvwqnJnqtIUKQWZ/OJ9plYbmSNDbJ4Ij8jeo9XwwOE+y3FRcICoSzBzHVinsS1WEE+l4tzt6Vmpyqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYVouaJVLLX74b2YXKZGxBP4fNA2K4y62dqATdHDRQo=;
 b=TwSiQukSRKN317bqFYuRw2OXX/6XxvzgXOmYg7MVaTC78MnX6cn1Ojjn22JnNuH6xrv+vazaz6/0057DKQUbTKwSkSo16PMn5suUhP7P15tnu54VrFUR0QLNs9Akbg1vwbYk06ZebwKohvnU9e6dSeo9HhSSIKqTSl3u99U9vJ3sgvVmDWNHRQePwUcMqNX+cOrD3kA/r3YnZwgt54FxiGgYHEBsFrf+Erh/8iTZ7csYgpYvQXGSd6SxgWH+dbJPJMgMP6uwh2kplC6oT//sbHGUKgu84ozb0be0TPJWEQuyvO60EWJxZiGYzkizTnAOzxLTkylKghPMXsYaYux8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYVouaJVLLX74b2YXKZGxBP4fNA2K4y62dqATdHDRQo=;
 b=PMFtBl8YF+XtQEpmAEnGWE+DT6YJL/28rsuyp6I4DpkBMq3kzNPuOw/i7otCe3tI7R4+UjfayB7LbLZ4N9yNiIt8GXv5UHRZcteGfYkZY4iZADi0NMsuli1VajOVhdidK1Pm9MN+XFp0R8gaq7j0PRDkGwCagL0HybADtkdkUi5wLs8YZo2FTvTJkTrOYMKRggBx+qpIpbrxQ+UkeZ6JdrWosViOTf096hb7tGB+FSusp5+qgz1zW56zQGwho2HjAKftW2uUDeLm8YrkKjdzuAM14A7jGSVeFJva/u9aXt5N5X06VYB2gNCSyUAqzoB8AQY1UsMn0O4BEyYA8sy/cw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10170.eurprd04.prod.outlook.com (2603:10a6:102:463::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:46:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 14:46:26 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 00/14] treewide: Clean up usage of DECLARE_GLOBAL_DATA_PTR
Thread-Topic: [PATCH 00/14] treewide: Clean up usage of DECLARE_GLOBAL_DATA_PTR
Thread-Index: AQHclPmVOZhfiI7Tykq5GNWvlOXbRrVw2kJAgAArhoCAAAai4A==
Date: Tue, 3 Feb 2026 14:46:26 +0000
Message-ID: <PAXPR04MB845957CDB8EF1B3B8B4E0D32889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <PAXPR04MB84594DBC04C4957716EA9C79889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20260203141630.GG2603314@bill-the-cat>
In-Reply-To: <20260203141630.GG2603314@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA1PR04MB10170:EE_
x-ms-office365-filtering-correlation-id: fa69c57c-dd94-4a97-f8c1-08de63330200
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NUzEVJUJrBT6UeNiqMMXBRqdcjEDVmoekPaSETSicR7zwDTQFc4PsNM4Ojrh?=
 =?us-ascii?Q?xdhfXSnYSE+0ZO7buSIc3d+O0i/Xa/PeXSWbv9SM92prCEgOK9kJlx6D42M+?=
 =?us-ascii?Q?vA8i169e+TB//cJ2cz4WE+6Kg4YK03a/dYr793DG27czY6o58JhQ12Vnfla5?=
 =?us-ascii?Q?8v1tO2XT+B+l4zgc1TyiB7FasRK7uZpspnZdFpvLwPAA5IKHnPbHAGtpcnCB?=
 =?us-ascii?Q?TqQ96lC0w6yNLW4Dzm3xHmttQt7mfsJCVeigJT1RsoUw4koYRNJrkP1CLi6s?=
 =?us-ascii?Q?UWWqjfVn2ux8ZqnTYgIVUUiOZIh7RAC4U1ozuwmY07Yn5jjWVQxARXQu1wJW?=
 =?us-ascii?Q?bn4syLOGQBBnwqP3BxS8mnnsLsJshK4ioPWXIM7ZgWMyeO+MJX+Dd13bEVGn?=
 =?us-ascii?Q?WkkhG5BIcOY/ssdujrW3oBIFi8+J8Gjm8gs69cl0gzk763pnUGyFfjs2q3iw?=
 =?us-ascii?Q?PQUbV4e1OQCGTXhutOe7fU8bmkPaWx4A3wWpqBpEEYADsphuoRfgWq3778sZ?=
 =?us-ascii?Q?NygHku84yWDfDdaeTxrq+snns+jDeDAi9jicLtNn4SB2JTNLEBAuJMF4aRHg?=
 =?us-ascii?Q?XyZMfpwEZBuX0JSqcIo/0gXd3+Vf3t/ssT9NDNglUDEV6nzUWrq78OounKIR?=
 =?us-ascii?Q?XXdx02BmoMJtwdmIi3W7lxYBoZ6QZix6a0m2HhONoj/pQRMs8NCeeSmdi5Fw?=
 =?us-ascii?Q?aAlTqgf7+6615aH1kimbBtUrmjgmaDy/DsoKeGs9Xr4+uLruCoKSb44q4XF5?=
 =?us-ascii?Q?+jLYwgnjeGlKIg5iwbAmZSIZJwHEfT49wLvEevKaHIDv+Bsvfx/n564V7qQo?=
 =?us-ascii?Q?KPvErwtjsteKIJuo+gUUC96IXlbLsNyLpgwT+WEk2gQ+wzGoUGRkask9P82Y?=
 =?us-ascii?Q?wMrOFlTrDZAhgq7fSLnLexjGr7E+UMFSJWcYSZ9hWVoM7sFbbZOaziBXLCAq?=
 =?us-ascii?Q?XokX52OL+omKBLg/uRfRcesZbhtdxEyZfKv79zBovzy7HhrNsQbXPNtdRWrx?=
 =?us-ascii?Q?Qb9Zv3ZIS/NuhSPZhUtMlJEGoyaYSlSowUuu5RD2p7HFtDwfoFyYX1Y0/k8R?=
 =?us-ascii?Q?B7NGWjAAmZs9/bWL1DKmfyaq8X2g4hed46+mhi4TS/W2E4gcUk1IjPBPO6mD?=
 =?us-ascii?Q?9XLFai4XTRiKUaqzF7HYwEQ4wT/tnWnTGMRdQon3C3akxK0Cg+G9YS/ZaF0z?=
 =?us-ascii?Q?mRWAhkmA3mJcufQLM1Q26H4UzicST1z0sxkSeSYPMMRcSQ2K8KshaU6I9jdn?=
 =?us-ascii?Q?L4gg3E5/sWiBWceYwnJuEYNTtsId32BNlrUWqVDzsJF+NOtrOjonEOdDscfj?=
 =?us-ascii?Q?l4ZrzPdFH1AW93CpfAF8f5snt3TiIE2b5c9WEajq+dbOdthgmFTk3L74Ol8D?=
 =?us-ascii?Q?F68uQHXMgC+Hx7fZrthnD6nosTpR3n1PC41tHN8mVaGjli0sdSN1vN+Yd3oE?=
 =?us-ascii?Q?h6MLTj7Yuuqz5a7qspICpuQd3RFRzMsmvvAaak+2zqMsUW4K/AnBartjriAY?=
 =?us-ascii?Q?gErkdNPz+0EaskntUldhPbwoyDNMf0LaTLRYPlqpQjdjbLje5ix5PisHR5Rd?=
 =?us-ascii?Q?9k6vZY8iioLclM9CLRYiziThFKa7W24GNmHG/LGvgPWV54u4suu0RFbu28Ed?=
 =?us-ascii?Q?oCZS0em5NnMJKUX6h007npg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LHSm7gR2jYwH8w49gUeWdPwou466XzVMg6jIrP+RnKme5nwK+zgqBfowRRzb?=
 =?us-ascii?Q?sZ8B4z1XTuuMdmSt7vq7dSWxlRKWGED+1qiMo53S9TVwP+cW3TujXNtMUR32?=
 =?us-ascii?Q?5614lwwjEvWWebhHDEugR/naEIZ6vR+l9mDFwG+d41Q+BJCFGNChADnu75DE?=
 =?us-ascii?Q?UVXjw2XWBzFWtfIBlzwflJuhgMB551+ejGlxE9KZ6kfx8e/2EVASokMiUl1X?=
 =?us-ascii?Q?fvScZCOG7c6xxz7XyJg63hdsdRYxGMsYbXbWUa2SO/DCn7hbtD0g21uAbVGJ?=
 =?us-ascii?Q?RaChjqQQTY4aDevNVJavoiHMT9WyvUyW2GQghVnGYN8CfMBvteb46NVUSZib?=
 =?us-ascii?Q?r+Q+oUPWIVNK6rBrw/XnBrE+9BxEX+wa4f+qjusodBEx1zhSm8nCwcO/Wssf?=
 =?us-ascii?Q?w1Ay9c0X9lga6wuosmI1CItId72WuX8a9x7VrmRqKGQ0b7VJxV6QolInHGDo?=
 =?us-ascii?Q?P8rwZiRMMwzWaGZePb/fGiDrq3wmn+yq4BfnBu9mUm9MkaIo6ppPfw1yk9Mh?=
 =?us-ascii?Q?SKWHqKPUXgeB4s3eNZPpd9i/yFuGakadsId5tV2KoOgxIQ5Jd/r+zqd2AoW0?=
 =?us-ascii?Q?PZPgGJX6kOa8F3qPaxESp+NTjDXeqqNPK+cJBolhKoose6wEUswJHISIRXGT?=
 =?us-ascii?Q?b4iRWIEMz4MLQOJceAYQj3PMpmBXMFnUcEXHGGfHjJUOnTaRMkYKpRyHRwGU?=
 =?us-ascii?Q?1anmfsjaXgDLounKmNmoRfYdwAADFwyBCNcszRIt6YTRpltxw+jubtp+ALjM?=
 =?us-ascii?Q?oiRfD7bAhJ7t5Rfh0OVTi3BJ+2HgO0X5X2mgl3Zg39Ev4ElHEtD0wYLHCroK?=
 =?us-ascii?Q?lH6k2EQktMTtu2VfQpkHBUenF8jw64sfGEy0FyZyXtcXm703gNToJiZC1q1X?=
 =?us-ascii?Q?rt/ACKklT0EfGSgRyZ092/99sT+tOXciDwVl8wf4yuzPsdkuMl/FRuGGbThd?=
 =?us-ascii?Q?DCP4ydhN3Z8mlv7EwwfF736TLM0pXc/szGrSfCFpWukuUuqcuwcbhEi31J/6?=
 =?us-ascii?Q?uaG9Tk7xDNIEXCkR5sUWXhou0T6Cj4QGygY799ihqpwJrU2QfR+pG2iBcpmY?=
 =?us-ascii?Q?irMhmCmI4cnGpwT+/1yReKF5yr/qmHDb0vPHL7+LrBXN9GocJXW5XiqKiD4M?=
 =?us-ascii?Q?NwR2q4llto5C3SlAu0JkVJKRKNMRkm/cRcYhgY3sAKqYJUrwLeel+K+CJDaS?=
 =?us-ascii?Q?+jsxp3b/Nbj4d8sTP4Tp4yWp3w86AYI+WIfyiAZdCY2zwa0VfxK6n6r4edCo?=
 =?us-ascii?Q?KI6m+BP8n/nHtgpYC6gRcBFqCalTb0+qI76D23wtUEmPqL1Qg4a27d5vNoWJ?=
 =?us-ascii?Q?UqAoXO1IqksCy+SVCW44ByhaePIoshzs1VtStjYKrjAQMWzXMCSCVFdb0xHu?=
 =?us-ascii?Q?nQ5U0CwwhLuZKO2ZGdpY8BSD0Ubp1ak1ODEj+reQWDJdnp8b9I9nJWc0elxB?=
 =?us-ascii?Q?s9gX0/j49SLsFW/VzW6RLaE87C/unxFzfETKbpJe7eoqJu98wMQFkz5SAsqQ?=
 =?us-ascii?Q?B5Z/5y46ZNYP5B3XO/iBTrnHnwbpcM0sbuvMVeJ91J/NQkrRkE6154F7OUac?=
 =?us-ascii?Q?6p16K8g6BWeoVU4uIezjvlKhGFvZLXVYmMuFZEbqhlo4G7TOglf8iG8+K68J?=
 =?us-ascii?Q?t8Z4AzK2kjwlaxJQO2I+9r41wKzY1lYnKQiKj2cZAITi8CWRXfgbzjiR3pEV?=
 =?us-ascii?Q?1H9CkS1Ee8/TQ0jqM7a+cpyruNGQaHkhOGvDg/1LVdHnkdjU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa69c57c-dd94-4a97-f8c1-08de63330200
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 14:46:26.0492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I9Eh00Af2Lxl2dizbju64D74Qfaw3SFjusvkc9mFAvW1aS/yfyI+k/wsmwFGhjQBOFuWd48Wj8MRUHvYwy99Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10170
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

Hi Tom,

> Subject: Re: [PATCH 00/14] treewide: Clean up usage of
> DECLARE_GLOBAL_DATA_PTR
>=20
> On Tue, Feb 03, 2026 at 11:42:04AM +0000, Peng Fan wrote:
> > > Subject: [PATCH 00/14] treewide: Clean up usage of
> > > DECLARE_GLOBAL_DATA_PTR
> >
> > B4 fails to send the last 2 patches. And I am not sure how to send
> > patch 13 and 14 in the same thread. So just resend, but seems resend
> > still fails for patch 13 and 14. (:
>=20
> I like the idea. I suspect 13/14 are just too big or too many on CC and
> the mail server rejects it (gmail rejected this at first so I just kept i=
t to
> the list). So it might need to get broken down further.

I see. I use "b4 prep --auto-to-cc", so the CC list is too long. I will tak=
e
care in future.

Patch RESEND 13/14 has been sent out in a standalone thread, sorry
for this if this brings trouble for you to manage the patches.
Please let me know if you need me to make all patches in one thread,
I could drop the big cc list and resend all.

Thanks,
Peng.

>=20
> --
> Tom
