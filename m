Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03FCC531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:40:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 596018110E;
	Fri, 24 Jul 2026 03:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9vQcfI6y28p; Fri, 24 Jul 2026 03:40:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 747AC81105
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784864401;
	bh=6yHJpaaA06jHzeEEyNSapPs616AYRU7j01e3gRp2BwE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ND2jfAceQzeKRPqodtBApEAhQWF8WFgFqT4ZKbUsYUtnIxP0YuALV8lOvVXqLBbFU
	 8hJu9EH5hCSYUxSp+cq7S/WJ4yYW0BWM1edZB367n5eDZlkl5iPJQlu42KsLEasibP
	 6M5boHWoAnX02cm8XWwdosPkzgf3U1EoAAxjbVsPXhqQVDzHCl/64LsyB1Q2lR/lDC
	 OG4V3scBIHDU036VohQQ/vfozSc/cKtiDXNDPTeXvz+0I4tGTWo896lkPUMk4k1KZ3
	 NpJLLU72eEVHxD+hhSSiTTJHdRFzRoLqcbYiSERDILog3YCYiUzmMeQphfIcd418G2
	 sfAf1BlOH9n8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 747AC81105;
	Fri, 24 Jul 2026 03:40:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 709FE490
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56A35401A4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dRQEUNrGoBu for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:39:59 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7D43E40072
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D43E40072
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D43E40072
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAWHaZqo+NOvmEvQEyWjY8JZMV9t4bdcH/uMBRGnStf2SrA3lhFNE/6JdfNvHZKFff3X1lTqn91t8wYFkIGKJ8YcRDeauWiHH0WUuo7hdM+LYfneZM4dh/R2jbc42OOlSfatwnSA8CzOXNXln0KqfX0FclT2tFY15+HK2p6lNhKVEtVZHx6l+EoVl2uJvMe6vlsySFil3nP3edH/nzCcLtmXs1P2EEPkA8G6lMbE2W3T2gavQY6AWA8xL+DRvIrHxP+lgcm7K5JOZjj230jCNr57UHjnvo3nvlYu9FCMKSyvEAiqJNJvNMyMawXINJxwKOj8tlVgYGdlSCgQmKRBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yHJpaaA06jHzeEEyNSapPs616AYRU7j01e3gRp2BwE=;
 b=ONIog0pFpnK4x7vM7ndj/ev00T9H5nIKlFgVf73y/WvV49g2DzkP1tUfUoy+rsAygPpuHwLM8wuQ5jebJwUlyl8X+DGBRciqaoANFolGOQseny/pRUCOUUjWfmeGOmdAN5EC6nlptbyka/yLKJ6WKtN9BAorLtk4pYWEKtv5nuMVw6DDjbmKsc54mZIwicZzQAzvBzruyAMso6SBCA7w13cTv354+zGzQuNZfN0o0YalY9DRifaADjxPOhuANIoy7bFjCDnJtEItLn+4eyQHsbJEiehR4P7quj316DMy9Sfh8e/wJTgrfxQJuJFHeISvfDlCV/D/1T8HFPSzmefmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:39:52 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:39:51 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/2] net: fsl_enetc: Add SGMII 1G support for i.MX952
Date: Fri, 24 Jul 2026 11:43:22 +0800
Message-Id: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFvfYmoC/1WNQQ6CMBBFr0JmbZMyQi29inExrYOOiagtEBLC3
 S1KTFz+n5f3ZkgchRO4YobIoyR5dHmUuwLClboLKznnDajR6ANWSu5TU6NiY6mx5Fm3FjL8jNz
 K9BEdYUQ4fb80+BuHfjVsVOTXkCv9hv4irvhPqEAlVhT2nkztVuOyvAGT6CxargAAAA==
X-Change-ID: 20260724-imx952-e68a98abe0f8
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0335.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::10) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f97c37-e966-4f80-d399-08dee93537f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|1800799024|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 5hwfWvc3TuuMMAfCaMfG1MTGqR9KItyiawOZc9OpRobH8vx2qYoGfrqfzpbcGcFXp4oefm5SYWo6a3ZIkmb/puz2PGVXJl8nTwfV/BPlw6I6Ry5iyq2vDt/6L/X5vaBs/xCU5syw2zie8R5x08jCl7ZAkiCBn2etNNLxyMcE7W2vKKxve4EQbSxuwmJBHyOq21T3QnyVvRBGQ+VYGCoJeHt31ju9DsJ2gSNBVf8/499rzhs797CquGwvGxczHKaG5l8HKjwlrzzZAaJFLGsl/DoUuj8NGz4hEmA2rzzVT6qNBsQkFw1CHbnrLmye2z8hQle/pRFAe0q+GrYLK+grt3xYCOHqm7bMhXDZLGzueF0xwncoWyVZ+2SSAY6c0oiM5Ic++QFDbDQIBbE67HSidukK0ceVplhdMqU6LSz1YNgpiQMwTc+LK8ScW3ocX7GEX/RRPchDwFujm+9iAn0Qq6ZWaJ6H6+PsLrZdxRr//jjwppiHZdVi7HRSuKMylblZR2Xo5yTRC8OTdbidzebPi/d6+4RGqMG+daMeaXEZuBDCxey3k0o87EK9tGeQhWOfR0hNg7xMi93qyk4RVRtiTUkMptfZZpxG5IyTO9RFsDGNourq0phCDxRZwim6VuXF3oxdH4YrANb4uI5NZes+YVgW+1BF9aTdb2CpR+vU9Jk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2s5RzFkVFM2ZnIrSXNXZkdJODBTbmpia2wwazVQOHdZZHhVNFBTcFZ6UW9I?=
 =?utf-8?B?V24zZU5tSkE3RkdTTHpxL2NKblViMFBJcWhsMERpU3JVcE43N3BweC9tRzNH?=
 =?utf-8?B?WmYyUThHTDllN3pTN3lMdDcrUGlIS2ZyTTZWRFVHOVV0eDhjT2o0ek9pbWY4?=
 =?utf-8?B?Y3p5VFdNS0NHWEUrakw3S1JvSlIrMTluWXkwcndBZlNuN0E3dXlXUFl1eWto?=
 =?utf-8?B?elRtL0IreHJZNEFmSnBYbWQ1TmpnZDVkVjRBOUx0Q1F4eWFleVo1ek9CMEFj?=
 =?utf-8?B?a3ZuSmpzMk9mVGdNbS9IMnRjM25sdzRsbDdrZ3pPUlUvMkZDY3R2cFVLUDgy?=
 =?utf-8?B?TGZQMXdSWUZXVTFoR0EzenRJTmpYKzZLRWswQ2JEZXFxTmgyNUQ3ZTMwUmth?=
 =?utf-8?B?ZHhGNmd1bTl0SkZrL1EyekFDbzg0d0kyTG16UXZyNVgxZHpScGNRQThrdzhW?=
 =?utf-8?B?YUwyWkExY24vME9hVjNtSHJINnNtK0ZiSXV3TFBEMTB3M0lvWHhTL3FyNmh0?=
 =?utf-8?B?cXUxZ1o3WWZOUTlqOWx3UUFIdDBYbFVWZC9jUWdxWjM0cmpEUzZySFp1ZXFE?=
 =?utf-8?B?eDVYUWVyWUJTTTd6aFB0SEZRenE1anRwV3N0WmdDY0tDQ2htdnVXY0VZVFYx?=
 =?utf-8?B?TVFqaXdBYSt6RFFYdHljR2RZZyt6TWo0U0xIbGJScG5DTWN1Mmh4dVlxYlpk?=
 =?utf-8?B?WUhnb05Hc3RZemhvdVdLM1p0Und1TUx3RVpWSUE4eFdxTFVPOHc5Y1VrbDhK?=
 =?utf-8?B?NTB2NVF2N2FESTBPMC84aUJXaGwyQzEzOWRLQTRHUnhmR2NOc3lBYVFKWVVn?=
 =?utf-8?B?RHNYMzhyR0V1T0thWTdKNW43bzY3VFRUc1ZLSVpnVXFHZ0JqNDBkSTFNcmgx?=
 =?utf-8?B?eVpoUFJGc2pPdVNzSHVuVlE4ZUxwalNKQjFmcHlIbU9sQk82dkpSRFpyTGZB?=
 =?utf-8?B?N1BqeHYxUHAwVmhMS2J4dkF0b2h5TXg2aERoOC93UEhxb3drWEpTNWJuWUNO?=
 =?utf-8?B?T3EyK0E4VWpjNGFxYjJtYUpsZE55UUM1K0VUZWg0VDRhbG4yOEpPUlM5Tnlt?=
 =?utf-8?B?MnNBemRYdUxhc0JRV2Y2dDk0OWxxSFBocU04aHAraXFRR2pTT05HcGE2dTZn?=
 =?utf-8?B?bzJOQlhYSGg2SGFZRkExZUd5UCtDS3pPTE1ESG1FSXlxOVdib0YvTm5xQ0Za?=
 =?utf-8?B?bktmcktncXRwaGN0NUFiNERGZ2VhL2twaHFGdVJFRlR4c21WRC9wQ2JQcmZQ?=
 =?utf-8?B?ZTBHdTRqNWs3cW55MnZYZHl4bUV5VWM3MlkzeFhaT3lsYmgvSHUxUzc1M3lK?=
 =?utf-8?B?K3hTemNDN25SRWY1YVVIUVRRelpDVmJqQ0JSR2NPbXhtdWtrTVpKREpTYVZy?=
 =?utf-8?B?ZC9mS0E3aHlXT1NqMk85OGtWdldneE1SbFdGSUtDKy9ROXZSdzdTUHU4cTBM?=
 =?utf-8?B?b25VbFBzUW1hNDBXZHhvMXNDVkVwbndpUkFVVlBQQ2xJNWRtaFhvZ2FLUVVN?=
 =?utf-8?B?SFZQOHhKS0lSbmJwUW1NblQ1VVVTRnJLSzBHQUFWWXhLclp4QVM4LzRxZDFM?=
 =?utf-8?B?dVRGalZTY1cxaURmT05pU3dQWDNaYVZCdHU2TG53V0JTWDFUaEJnVzM1SDFM?=
 =?utf-8?B?T0hSQVpaSGY2emhRejBzcjM4UjMzeGlFdFo5YlhwOFMwNzFtZFFTWDZnUkxM?=
 =?utf-8?B?Y3F5SkxoVnZrdHRtalN4NzJxQVZta0tVb0wveXROdEhsTmhIcVJqaW5pUzZM?=
 =?utf-8?B?c3R1R2h5MWpteS9LejNTdTNvb0FmeHBCME5Mak5GQUJCeUVDaGNtY0g3QWZY?=
 =?utf-8?B?Q3dPY2ZXcWZCMHFHT2VIcktveU1GdDh5NCtPSTh3a0llU0RXdUJsVzdGbGlu?=
 =?utf-8?B?dVFpMFN0SGs5VnBZTGpWOHN0Q0YxTHozUFh4TGFTc1dSLzBuZno5RXNMNE9N?=
 =?utf-8?B?aXpqVG1ncDFWUloxV1VtUVMwejQvZW91Q0djbEdiVnUzbDVNb2w2cXBveUw1?=
 =?utf-8?B?K2lPR002N0Y3bERTd2cyU0hhbGFseE9XZUxROHZMNm1mQkFLL0U1V2lsKy9y?=
 =?utf-8?B?WWZpbUV3dGxFZUVUYlRzRC9XaVBqdDMzN2Q0ZG0zWmszSmJhZmZmT0VaRHM3?=
 =?utf-8?B?NVJWeDZGMzR2UDdlNFNrR0pXRnc0Z1MvZURiL1UyeWNpWVJNZkt1Sm1lS2Fi?=
 =?utf-8?B?K2JVTzNaNUlMSnpqQ0htc0VkVEtpcUlkZXZTeXJFMndXdmRmL2VGUGI1aWYv?=
 =?utf-8?B?YWtaL09PZmRQc3BtYklKWjlEeTVMZ0JwckJOTXJ6bVVidW01V1p2OXg3T0I1?=
 =?utf-8?B?OFV2Z25VcnhIYzVUVDhTa2dHRGdkNnhnQ0l0bEpWQjE4T2lLdlEzRTNERFpC?=
 =?utf-8?Q?Abe9ZTksagQIrrh2b/h/Ulocjdc6VF9+tKLUj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f97c37-e966-4f80-d399-08dee93537f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:39:51.7982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17Yua+/ckL1DPdvwOqw/9KM9AkHD/Yh0u9rWgeRYarBzfidHEkps694doQlZrq38Ul7g1xdXvBr+aKuv5SI6lUGPPLU/QwAK1MTaPrjGX2bX37Em9m2BfNkFfGWDWGZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yHJpaaA06jHzeEEyNSapPs616AYRU7j01e3gRp2BwE=;
 b=QGGklTKwnWzUDNilkGX1Ax/NNRJJcZ8zhuq0l6Hx58Qz9vPmn2kqb+oYWswuJUNPU4WaOKUs4z505qhArK4Zimsllt2PdB7HZ6reIB6BBvu9VGeF7T2dCYF7V10yYYQWiqfcL5UjRh++I+gl5GK30yHfNvC5n4CewtPsNC1+tuBU3DvP1E758/er5D3LpFVziiVcVffEKqugBdEir5kFtfBcEIZM4oZQoGZ44WymFB0SpxsdJLgeJ3HugP1bZocSwYRor8kgCK5r9uDLylnODILcy+DlXVqJjKPiDeU6MsblIpEdOEtvP/zljp/cTTEOb13KHsRBdPT86oPz7TWsqQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=QGGklTKw
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series depends on the i.MX95 SGMII support series.
Link:
https://patchwork.ozlabs.org/project/uboot/patch/20260724-imx95-v1-1-7131a9e17fe1@nxp.com/

CI:
https://github.com/u-boot/u-boot/pull/1019/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      net: fsl_enetc: xpcs_phy: access PMA/PCS via MDIO_MMD_VEND2 on i.MX952
      net: fsl_enetc_xpcs_phy: Add 1G SGMII speed mode for i.MX952

 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 300 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 297 insertions(+), 4 deletions(-)
---
base-commit: b36d120426151a4d9cdb211f1b6c81e4dce97076
change-id: 20260724-imx952-e68a98abe0f8
prerequisite-change-id: 20260724-imx95-ca124ac3ba65:v2

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

