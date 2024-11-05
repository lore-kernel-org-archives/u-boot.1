Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D392D40D08
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 23:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E697A8913F;
	Wed,  6 Nov 2024 00:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BvjfA5vG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BCD8917B; Wed,  6 Nov 2024 00:31:07 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647ED88EBB
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 00:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0WB6ESRl8TTcyJvLRm33Z0Ng9Ks6p3cXRWAIG2dA8DDQHSwLFbwMl8kGWHSfRbD2AENikmkgkp5C9ob5lUw25FLDlhyXUPvfsXa4saUimLd3M1w19l/64dDTzDBOGNMF6vPe4AI4oof8E7UZzCOo+yoEd4orpEWP7wKixf6lo3ssbrsQoAosG6brXoftDB90MSoVmiq4i8h9taSilGxi9l/+Yscp14F7YTSNTlZcAK9UqsXQkAC5cWOhRWrsiuRut6N2JNxMHjbaXDIzCGOY2senFe3aqs/5k8OAaCT/FrwGGi+Gvr1LJ037mAko5rzByW6El1t1Gk1fe1471i7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Joia+mWOj2ExW10Q0ebMUxbf+7F0OkBXyILSsPsBhR0=;
 b=S1I+zl5W1mmhy0visfiPypVzqR/g2F55Zg6jOj2CtZ7Lwm+3bpZqFkDsMv4Y0EPFuTnRsQ8yC4BEOUujCFSchmNAakkYrT5ZOwYGrr5ojZTfNMN6SuYTV/RgaKBV8s3vKJoJux7d64ToFIq7uNDoQFhlAxZGB28gTSL0k5cZ7cBu74DnLybd4rL/cXtJXdVjXrgrDkfnrHDidagksaqlmcxLZuRXO+2/172sZyyPIL4gevaQZzZepaVh6jIFqrXY4Gf1tC7UZbK3Rjqu3hT4/iaYbX7xeei+RzqHu7JRPxfGuE8eAem5DZbxU3GCvaCbtnCfYK3DW3Tp9uybMESN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Joia+mWOj2ExW10Q0ebMUxbf+7F0OkBXyILSsPsBhR0=;
 b=BvjfA5vG48sKIn9NDFjO+8gnuxQ13U1fzcR0b5hgLpFtEaKEVGio61P/0ypZc6m3u+AlDxQlguGzrxXWfh2UtQreg16kmb2lleSz2eJqoarf+ry8WgNUC6/keFac56Z7cJOkyrjXPO3DbT4E0sadG+C+pMgeW8ghNTjnOVUkZQF1MZS/QsZ3LGMo5PnwPMeSBd3hs6SZo0Z4Ppq185vyhUEIAFzqPHehSoV5IE2DrCy2Tsf5vpm3UNbMwJdxtELQStDuBjagLHgRDpcOdC3KY5WUiJYoxJS7IGPqAPa1zbPNsTcC1qWu+pk+1rBGBRfdb5Xt62r5gOf8hlMAV+5KFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Tue, 5 Nov
 2024 23:31:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 23:31:02 +0000
Message-ID: <09ac42f4-b3c7-43f6-8f4f-0887b078b374@iopsys.eu>
Date: Wed, 6 Nov 2024 02:31:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <20241105154741.GI3600562@bill-the-cat>
 <CAFLszTjntxJShjnWK++NkonNrPdL0S-=zWf-N_AWUaZmfmArtg@mail.gmail.com>
 <20241105182619.GL3600562@bill-the-cat>
 <c8ad5da6-ba6b-4465-b00a-c7539c6f6bb1@iopsys.eu>
 <20241105230026.GP3600562@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20241105230026.GP3600562@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVYP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::22) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff4b61b-7d76-498e-53d2-08dcfdf1e950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjFERm1NdnBFbU04NVhDMGtET01CNVZCTFZjK2NHaThXbTdkTEJpRHpYWCs5?=
 =?utf-8?B?em5kRDFjWXpJSy9Ld3FubXJUUGs1NFlOTXV2QnphMmNZV3ptY3hhUHQyWjcx?=
 =?utf-8?B?UnFtTlluTDhkQTU3TmtqaDVDS1VsL1ZvRjZUNTN5cHBqMkY1RERINWFPWWFX?=
 =?utf-8?B?ckU3eHNGNjlOV000MFhIZmdOTS9EU1pIRVFPVjNMZTZSVnBsOGhTN2tLVEFX?=
 =?utf-8?B?aG11RjRwRy9TSDlXVWtvLzJsS2RoSjFOSGRUdkkxRkpGRSsyZlZhNXRKUXNI?=
 =?utf-8?B?N0FLSW5zd2wxWGVBdmFBb2lwKzNPN01xcFlLcDFrY2Y1dWRreWEzTTAwWkRV?=
 =?utf-8?B?SzVhWjFrNlRMU3pDelVubncyNUREVnZVLzJUTzFvM21jNzZWaTR2S1QyaHpv?=
 =?utf-8?B?M0lvMzRXNUFjL2pMUmpQdVpXNHJYbkNBNTduMWRQVVZLL1ZqRHNSVFRjOFF5?=
 =?utf-8?B?aC9EbWY4akYreWd1RndJamIyS3RJVit6cHk3RWF1RWtmOHgrb2U5T2pLSEtu?=
 =?utf-8?B?S0FYZkYveVM1SWt6NGIzWEk2QUtTRUZzRnl2Q3NYWTMvbVlFUzR0bndJYytH?=
 =?utf-8?B?emxUeG9Ea1V3WU5rN0RxRnRxaFJOTVFGdkFhekdCOVRrYVM5anRKOFREeEl1?=
 =?utf-8?B?Y1RXb0tQS0pQWW1Udk9jZjUrbG0xemlpY1NNL3dGVnpsOStYeWdvZVhxS1Q0?=
 =?utf-8?B?YmhIandJYzkwTjhKbmVVdVBwcVNpaUV0cUw0dDZxV2dtU0ZiOHhHb2xKQlJo?=
 =?utf-8?B?ajI2am1SczY4YkpHSzVqV05Yd0szeFVmYjJHVGlWeTlwMGpzZUNnbERYYVQ5?=
 =?utf-8?B?bW1PSFVRemYxd1UvaWZCV01WcG8wTDJNcWtWZ0pGbVAzTklJQVVlN2NFQWkr?=
 =?utf-8?B?OW1rWXQvcEVqd1h1NytKSkY3NXVWYTZXRndlUVZLMVd2SXZQaFdhbW5MbzlP?=
 =?utf-8?B?WVNTOUozMnRJS3ZzbURVbUVOdkRBb21NajdITm5Td3orRGo0V2RTL0RYZE1U?=
 =?utf-8?B?eDg2NHU1aFZhc1pQQkZlTnBBSVl5eTJLUVl2MGZQTnJjMGpoK3UwV2wxMkhl?=
 =?utf-8?B?ZzBOdHVxVXlQNTJpK3FvelA1RGpyeG03ZjNlZGw4ZVNmc2cvR0phaHhLQkV6?=
 =?utf-8?B?SGx6MjNCeVlyc2lXOEp5WW0vOWlPamkvYytVbE1xa1BibjQzTGtqZkFJYTA4?=
 =?utf-8?B?czVvSFRHZVRueFpwS2xQV3ZKM1F0RTBwaEZKWWpDZ0ovOWZUTXdYMllsL3NE?=
 =?utf-8?B?S2RaQ0ZQUDNsYkxDSzFjR2lBamFtdHcxRFJsekxHckMwS2hIRDVndTFFQTBJ?=
 =?utf-8?B?eGgxYTlRVFNUUGg4cWhWQ0pJS2xzZXZXZHhvT0ZFODFwa1gxRWdxaGxMdy9Q?=
 =?utf-8?B?MXBMRTJlbjI4MWp0SFpFUHVnb2RzL01nSDNzcGZ0bVorSHlGZXplWWhjdFFK?=
 =?utf-8?B?K0c1eHV3ZVc5Sk9FdWl0bzNncWNkYm9ZUy9qTlRVRUsycXNTR1pTOFU1eWhL?=
 =?utf-8?B?MHhYS3kxUzdZSXdtang4LzlzamJBb3BPR0p6ZS9HbHdrN0VtT2thMEg3YU8y?=
 =?utf-8?B?OGpQUG9aUzMzbmhWMTFRKzlBc2VLUkJ4NFlWREdaMlY0cEN1bVE1bklFbUpI?=
 =?utf-8?B?SHJXSjFPUjRic2lvbXNJVXMzellnNVBhRE9mb01obS9jRjU2SkxDWk9nZjdx?=
 =?utf-8?B?bmo0dmtaekIwMTE0M3UveDNDdnBlT2tTRXQxOGxTWGw0Nld0V0ZBYjBpMDNo?=
 =?utf-8?Q?rK4hxZ6UJVV+cY0TA+snxfA84hXQEFUV1kVVFdQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjJCai9oc2VYZjJwa0tjOXRReWNhUHhCLzFJam1jNFV3ZWIzOFp5MlI5d0RO?=
 =?utf-8?B?amozSVF5dS9nRTJVK0RaVXR6K2VDS1VNTzZWdWExVUVmSHdUcXNiRnk4Zkgx?=
 =?utf-8?B?anNYMUgvNnVNZlUyS1BQNlVWR3hHcjdMUjdoTHEwRnhoME9ZMDNWdUI1RmRI?=
 =?utf-8?B?eTc0V09vbEk2M2ppNUNLVS9kazFxNE9QTUNWNVptUG5KOGtHVGVudEk0dktO?=
 =?utf-8?B?YXBrSHU3NFRMRDcrSHFGNThsT3FLSDZaTWgvR0tJYjdkTVJScjBUV0VnZWZM?=
 =?utf-8?B?bjhrK1NLRGlGZ3NBS0V1eTQ4UmFFeHd4aFd3L0NnZWhvMTdua2x3TG1WVWlj?=
 =?utf-8?B?ZDdiMWJTWkoxcVZBUVN3UDRZb2JOQ1dPRkQ4WkcvL0wzSks2akQ3QzI4dUFw?=
 =?utf-8?B?L2xDU0MwUDlNMys5L0RaV1Fjak82cFNsRW8wR0ZXWklFYUxXOHE1K3JVNmt5?=
 =?utf-8?B?T3ZyS0U3TGxiTE83UDF0N3JCNUExSDZmUHJXVDBCbVRQbVlid1o1WDVhN0tK?=
 =?utf-8?B?eUFETXM3Y2ZXL2NaRkYvbVNOcTAzSDRmckFGVkp1T1YybjZjSkVWSmZsaFV6?=
 =?utf-8?B?bTNnUzdoN254VXZ0S3JJdmhWcGd3WU1uODM3Sm1sb0NCV0J3OG5OR1NrZ2Js?=
 =?utf-8?B?Q3pxV0VvY2JHbWQyOG11TUx2NmZ4ODBodmpMM3JLaVY1Q0JuS2ZOY1JESmZZ?=
 =?utf-8?B?WlcremFwVFR1Ty92bGpoVk12UFV1NklXakVRZXpSWVdYWHI2Vkl4NDkvODBW?=
 =?utf-8?B?Q1Y4ZHo5ZVUyVWFLRkVkWXRpRXlPMWQvNDFWZzMzcUhVQTVaeHlTTkoxRlpB?=
 =?utf-8?B?bms0QjQrM0ppQWRtenI0MjZmUVY1cHd4dFNEVEoyeGFqdkRjVUxXOHRpMU91?=
 =?utf-8?B?OXdEblFKcTJETWF4NU9OUy9pY0NuU3BUd0NnZzQ5ZE9OaENNdldTMzVrLzlV?=
 =?utf-8?B?aDhHUFgxZVdlMmZFN0NqTm9DRTlVeG1HdzFVcFhMSCsrZEU3a2xpcy9HY2dq?=
 =?utf-8?B?cUdHcUxva3ZCMEc1bG41Njl2eTZkQmd5U2dERFY3VmY5V0d6ZEtpNm13TWU0?=
 =?utf-8?B?QW45L3NRZjNidjdiaEJJSFJ4OUdnMlRlMndrdkxVdzJpbWJZL0NLNUM1c1V1?=
 =?utf-8?B?b1lUemRTY2JyQldXVGozeVYrZU0yU1NnK3F4VDVxZEdjVEwxUnpwMDYzV1pK?=
 =?utf-8?B?R2NncFFvTENDZXN1aEEzL29xbEdqSFFpcmordjlTY1hiK0VHSWFaaTNob0J1?=
 =?utf-8?B?NUQ2RkNGWnU3WS9MRVJxbnNIYU5PVGtQcnk4bmtOSi92czhadkJYMG1MNG1u?=
 =?utf-8?B?UnFqS0Y2N1AxdWFURnZabHJ1SW8rYi9pTTU5MElYU24zQmtZY1g0ZkE5UWtD?=
 =?utf-8?B?VGZ5UFNUMFZ5eTkxMlUzYzlGdzUvSmVTVVpKcW81RFdKZVh3SEp1Ky9BZVA0?=
 =?utf-8?B?dzhCSGw3aUZreUFlb2xRaFhYZmdQM0tsQ0UzK0M0c0xaNkVUUjV4dW5YWGRP?=
 =?utf-8?B?QmxyMUt0OHNEYWhUS2hHWTRSN21vOFh6WkV5WEdaa00zaWRIVDgyNDd0RzBS?=
 =?utf-8?B?SDRybWhIbHBXSjVuUDZ3dFJBSXpUVUVFTU1LRmFROUtCb2daVTkwSFB1L0d2?=
 =?utf-8?B?VjFmR1NTanFqUzV6a2h6eE1icC9DYU8zTnpSa1lla2taS1ZqTlBDRC9ZRzRk?=
 =?utf-8?B?RnF1WDk0YmQrajJZdUloV01IUjBGTEJjazl1QTdpNy9uR0VlVnlTT2czR0Vx?=
 =?utf-8?B?Q2RjUW03emZTNkNLZzJTZml5dC9OUE4reGtsc2R2Rm0wWmFwV3E0UXZUY1NN?=
 =?utf-8?B?OGVIanpXUXdCdnJvdS9hWVkyZTVUK2lhMmdFb3NtYm9PaERNK1NsZHBXVzJU?=
 =?utf-8?B?SCtkU21FcU5xQm5pbTFydGpkdFBpUFl5TzVQNElVc3NtUkQ4dUo0Sm5pZ0s2?=
 =?utf-8?B?WWtXSkNIZlphTHpHczkxc3ordUY2QjNpTmhGYWZVbDNLUWdRYjgrTGN3MU5W?=
 =?utf-8?B?LzRPUkp4NHZXQzhaTlBuNHN2QzBxRnBQbVRoUzhRbFU1ci9hYmxwRldZTUYr?=
 =?utf-8?B?TTZwVHBTNTQrbHBvemkzUkZpYUZTYTM0emNIdStGUXN6dG0rWG11VGhIdkNN?=
 =?utf-8?B?dGM0aU82TEtHQ0FjMVZuaGl2NncyWERPUjRVbUo1bWJ5MDIyZ1g1RHRmdDdw?=
 =?utf-8?Q?euFyfEncu5FV5Y3gMZ3T48A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff4b61b-7d76-498e-53d2-08dcfdf1e950
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 23:31:02.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8SKwDU235Jq5YR36mz6NE73tL7LBE2bKYwZJhokeVJOEqPbEIzNbn79z4mIkT8SUUG5qmRqhgI62rgx7qqTG/kacd5UsRoOVRshwXeQBNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322
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


On 06.11.2024 02:00, Tom Rini wrote:
> On Tue, Nov 05, 2024 at 09:59:57PM +0300, Mikhail Kshevetskiy wrote:
>> On 05.11.2024 21:26, Tom Rini wrote:
>>> On Tue, Nov 05, 2024 at 09:07:17AM -0700, Simon Glass wrote:
>>>> Hi Tom,
>>>>
>>>> On Tue, 5 Nov 2024 at 08:47, Tom Rini <trini@konsulko.com> wrote:
>>>>> On Tue, Nov 05, 2024 at 08:15:25AM -0700, Simon Glass wrote:
>>>>>> Hi Peter,
>>>>>>
>>>>>> On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>>> On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
>>>>>>>> Hi Tom,
>>>>>>>>
>>>>>>>> On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>>> On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
>>>>>>>>>
>>>>>>>>>> Legacy TCP stack is bad. Here are some of the known issues:
>>>>>>>>>>  * tcp packet from other connection can break a current one
>>>>>>>>>>  * tcp send sequence always starts from zero
>>>>>>>>>>  * bad tcp options processing
>>>>>>>>>>  * strange assumptions on packet size for selective acknowledge
>>>>>>>>>>  * tcp interface assumes one of the two scenarios:
>>>>>>>>>>      - data downloading from remote host to a board
>>>>>>>>>>      - request-response exchange with a small packets
>>>>>>>>>>    so it's not possible to upload large amount of data from the
>>>>>>>>>>    board to remote host.
>>>>>>>>>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>>>>>>>>>
>>>>>>>>>> This series of patches fixes all of the above issues.
>>>>>>>>> I know Peter asked on the last one, but I want to ask as well. With lwIP
>>>>>>>>> merged, why do we want to add features to the old stack? I can see
>>>>>>>>> fixing issues, but not adding new functionality as well. Thanks.
>>>>>>>>>
>>>>>>>> Let's apply this. It has tests and the old stack is still used by a
>>>>>>>> lot of boards. At present lwip is only used on one. There is more work
>>>>>>>> to do on the new stack, including finishing off the sandbox
>>>>>>>> implementation.
>>>>>>> I agree with applying the fixes pieces, I do not agree with apply the
>>>>>>> HTTP server pieces. This series should actually be split into 3
>>>>>> But what is your objection?
>>>>>>
>>>>>> I would much rather just apply it ASAP. It has already gone through 12
>>>>>> versions, during which lwip has been prepared and applied.
>>>>> Yes, and to be blunt, the first bit of feedback I provided was "can you
>>>>> please look at the lwIP series instead?".
>>>>>
>>>>>> The HTTP server is a useful feature and we should be able to use it to
>>>>>> test networking in U-Boot in a more self-contained and performant
>>>>>> manner.
>>>>> I very much do not want to add more features to the legacy TCP stack.
>>>>> We're likely, long term, to still need some cut-back version of the old
>>>>> stack for the limited SPL cases.
>>>> This series has been in progress for a long time and it seems unfair
>>>> to just drop it, with one one board on the new stack.
>>> Well, I continue to not say that we should drop the series, but that we
>>> should take the fixes and not the new features. Because as far as I can
>>> tell, the current TCP stack is in such a shape that it's not
>>> production-usable anywhere and so the number of users argument is
>>> irrelevant.
>>>
>> I expected something like this when lwip was finally merged.
>> I was a bit surprised when Simon decide to merge this patch series.
>>
>> At the moment we have no plans to update u-boot or backport lwip patches
>> to u-boot-2023.10.
> I'm sure it would be engineering-wise prohibitive. And, thank you for
> contributing your TCP related fixes upstream, it is appreciated and in
> the absence of the lwIP work would have been entirely uncontroversial.
>
>> So we will use our solution based on a legacy stack. I understand that
>> we should switch to lwip somewhere in the future. Unfortunately it's 
>> not a fast and easy process (update u-boot, rewrite http based firmware
>> upgrade, test new u-boot for several hardware configurations, test
>> customer devices migrations and so on).
> That is always a challenge, yes.
>
>> Also we are limited in resources, so I am able to put my hands on u-boot
>> only from time to time.
>> So this is a long story.
>>
>> Tom, Simon, Peter: what patches do you want to accept?
> In a quick look, 1-10 look like bugfixes to the stack with 11 being
> netcat and 12/13 being httpd, and I assume that's what Peter meant by 3
> series instead of 1. So those first 10. And thanks again!
>
1-5, 7-10 are fixes.
6 -- It's almost complete rewrite of legacy tcp stack and whole tcp api.
It's NOT possible to fix main issues of legacy tcp stack without a big
redesign :-(
netcat -- something like a sample of new api usage. It was written to
test & debug new api.
httpd -- this is what our company is needed.

so I recommend the following variants:
1) minimal:  1-5, 10, some parts of 7 and 9. As I remember these patches
does not change current api. Unfortunately they does not fix main tcp
issues as well.
2) reasonable: 1-11. This includes new tcp stack and netcat. I think we
should have a sample of use new api usage. Fastboot and wget is not
enough :-(

Mikhail


