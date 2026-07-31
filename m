Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372E3C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 07:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 688F480F8B;
	Fri, 31 Jul 2026 07:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m0L2dOsFNGEZ; Fri, 31 Jul 2026 07:53:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D12080F82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785484408;
	bh=9pXgtwJbSkoKuN1egnUA/R6yaBO4N4y6zPf19xvQ92U=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fDZzFPFTdYRkttpZhLjGfU3OT4yvNk0oOY7pKn69Ve3FOaNGYLsBbtKzkD910/1Uq
	 0JMYxDCG4fnlkXavETh8tTRpFZzT262+rBPA3Wz2R6ACT4D6enFlAmbMf6J3187U91
	 b170vpxFcocOdwtvFd4qVBLaPAzwXz4z6Tl0l56Pm5GOZrY9cz6pCUbHHhHvzIz3Yk
	 nherKEHxnVQ77IWLlALy0v0g12mVG93zF+hRUsyaEoED+shv2CK7ReDCOnpFMBc2Kb
	 qUAigjz6Xd9j1uhFovdgMy4dFMJOnE73AF7DG98pmFNSr2btdjfxhORRL/eaR6UofB
	 bbtZOsCcAb/pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D12080F82;
	Fri, 31 Jul 2026 07:53:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9406627C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7973680F75
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMqFLjf7kEfe for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 07:53:25 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BD3F080F84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD3F080F84
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD3F080F84
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 07:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGs8p9awY1I5agCL+CCVTrJN9uOAdvyT8svZgJzCV8r4QM3Vrtg1NozViul4r6MHRE1jAk780PjlYWDIg8g2B+k5v6ZsvtG02Ng1l6iAOsj2yfo0DkA/WRLOzA+Ss0uybXmHzP4SGWXIeW5CXAbm8f9UtJMVooCUI1846iWhV5Y04CEaTlm+emGTFojtl9CMo4sloCeyVhf8Rix+0W6OfbIzRC5WZsPLfaO4ZopIGEJ+Jq0+z1ay4YHHAB9MNKhLHbvJzJcPX4LYZRBn76mhPhkSlNcrD1Mo2wWh2TFH4lTYdmx8Uwz6QZHkHhwxA7KF1ec1Ig9Z51Y7a25N+GMrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pXgtwJbSkoKuN1egnUA/R6yaBO4N4y6zPf19xvQ92U=;
 b=TX8lAcJdomdcXdE20NlWYorKuIRNK2ov8s2hZL3DvLcEFzg1SKWVfhhBCCiodYZxx8s8zQpo+4scH5nLiIwH7P3B/V7H19qAj3DhX37gxtPpNEtDmqgZDN7+avGxx0PjbRd44//Y7i2UMOSia6MFnqPnPpoKujjmNlwuY8sYIWe2/ecVAj4QxI2RRuCHoivSPLWEJ4cLLMnifR8Ned059NRt7kgszpgoTWDTScl0zUkEuCp7VJfV2xXwzavBRY8ByL7FqsT6ouKfoOsarALp6mde6o4NCuEBzqrI4u/TPakZA0zsbYn6rqk7o6x/80HeSfnAxK503+6hxmocbnA3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB11954.eurprd04.prod.outlook.com (2603:10a6:800:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:53:16 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 07:53:16 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/4] board: imx93_evk: add i.MX93W EVK support
Date: Fri, 31 Jul 2026 15:56:48 +0800
Message-Id: <20260731-93w1-v1-0-62d8459143e1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEBVbGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2NDXUvjckNdQ0OTlDQj4+TkFOMkJaDSgqLUtMwKsDHRSmWGSrEQseL
 SpKzU5BKQfqXaWgCpbFs9bAAAAA==
X-Change-ID: 20260731-93w1-114df23ccd3b
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB11954:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ece9255-d704-4cfb-a270-08deeed8c770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Tk8UvGvREt1nfNV3SEpxKUi1ThOhGwLENTFyRups7SnVtD4gSCi4OjNBevpj19OWEQtC3aZG5d/tQTxQiDM8MgoKIuUovVCNp4Fa+hRtVETfJuae8DObXJKsN1PZQBXFN3Aney+BH9NsKW3xFOvAqMCDWL7ZOtRgHQICnP28uvCWNOFeLpy+vMQe+9Q8jFP6PUeWZ+khIS8WfTAKLp+5vXLLCczLK/rTJ4x8atz8y8v5W/ghXmV5wJzf4u1DYAO3MHMVyLh8Gt+6MDRIx1piBBWwhcOhvsncP7Tw4vYc0uMIKOSMUDDKoFDsOtDy3P5/WDXdy4QMSapnbViY+qfbgme9JHxXIQFa1tiiOFgSY38L9H44HCE4Ct4y14WGaCPrOtMJta8YOdBRTi4D6l2kcMqrgxP78pASR/6ExaEJ3Vf8RkYcrtGSr8Qn2kJl1eeL2hBvHKYh7IMLUR4J61J15RzqAK/aAFsWZvbucAStduUey+UgIGDVRzVvZFiq9BpZzSLwDHg5jNaKP7XRwOEWzvhF/G3B5n4KUSvdWg/lKMM+zmO9Pfmfz3pmpkYmb5OF1KYTXECQbxYxorBp1j77rhx/vFATQTYtE7FpfzHK/TiJFO9Mcu9sm4SkYKuMhvcWwuAt3SREj6gtXwG4eW1XWY/b6Cz1iKnrI5+9mpARYQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dngzazN4Nlc0cVVOVWpPVXhVRkNHUmViVWdlSTZtUUZoRFY3Vm1PeGhtYmYx?=
 =?utf-8?B?Tit4c3J0ZWU4eHBXenJwZnhKVUZQK0dmelpuQVBEZlNIVC9xK0d0Vlp4SDAz?=
 =?utf-8?B?VVg0OUV0NjNaZ1NnWVdPcTczZEFxeU15dDZYTlZZbEhHTXZUckhxSVJHNFFK?=
 =?utf-8?B?WHM1NWJ4SWNSS2JsK0pPRG0vVXV6cWFoNkt1SnJUQTJ1VjhwLzUwMzZuQk1N?=
 =?utf-8?B?UzFSQzNNODUyd2VmekNhempNcjBtQVpkNDY1ODVock5RWjJzbk9JYmFXRnRl?=
 =?utf-8?B?THd1RUwxKzhXUWlkVUJZeTBuS3M0alA1bDhqZDRGYUprTDNoL1FTSWpnQmUz?=
 =?utf-8?B?TVRHMy9zdWMyOXBJM0t0UTF4KzBwYXVXK0Q1VEZ5Qi9TNG9acHZRQmkydmxw?=
 =?utf-8?B?UkdtSXJBZ2pBZkpERjQzQjdLU2ZQVE0xYldvQXVXeTNSSjlUdk9JTHBOL1cz?=
 =?utf-8?B?ZFlIU1U1ZWYvTDhwWjhwaHpzdXQ1dEVrOE9jVkluSHZrZ0ZFek5heVZFakRV?=
 =?utf-8?B?VFFmazUyTEorSUp1WkpvQ0c4RGRianE0cGIzbGlWRmlEMDNoNkQrQXRNV3ht?=
 =?utf-8?B?Y3NMNW1VODJkbGo1T0RvUHRlM0p6cDJNeitaYjJFSE96RTRYcGl4YkZCZmxL?=
 =?utf-8?B?T0YxeXhOWnBQWWtUWkRTaUxIVmh4V2E2ZjNuZytNajdkSks5Q0RqbUsvK3N0?=
 =?utf-8?B?MzlnTmdCRTVrL09JZ1RkVm1RMzNrdCtXOGdRbjR3cFM4bFNodlRvZ3c0QmVE?=
 =?utf-8?B?SGZRbkpMUml3M1Jtam04bjErdTV2NzFVN2dVaUMvZVdIalNQbHF5OTNITVly?=
 =?utf-8?B?VFdyaFR3aXh6VTBLYTVSNkRaNG0rWndKYWtQUlJNeWRTTG5pellqZzA2R21z?=
 =?utf-8?B?SHM3WW9FcUxjUC9rR1JSK2UxZG1Fb0FOTERqUTZNb2NFWmV0cGFkTjRYQThk?=
 =?utf-8?B?TW1oWU8wT0J5TjNPS1BUN2hRZHNrL2lPSGY3emhheStuWGhrNXlWZWc2UWtt?=
 =?utf-8?B?blF2eHVqTzFtbjlDUmpaUEVqMGVMSmZuMnBHbGtxRTZoOVZITlhKaVBrSEZK?=
 =?utf-8?B?TFo1RmQ2Q3o1Yit4bWR2Q05ydTMxVW9OanUxTXJ6c1NaUllGa2ZsYS96OUZt?=
 =?utf-8?B?QnZicHJISXhGT3FtNXF4YUxoa3N6ck1iOFpUdDI5dC9DTDJwU3BweDl2aUNs?=
 =?utf-8?B?cm9HaC9wRE52aDM3bjNCcTFMR1Z4U3FUNkpZaGoyRnJZMVM5LzJXMFpGcGwr?=
 =?utf-8?B?WkhCcUtzc2I3Q1lyUmJveFNTQ0FuZkpxcVgveWZZeSt5eWtYaTVYR1lHUHYw?=
 =?utf-8?B?bW1TMkZqbHZhdThjckRuWWRFR09UcHJ3b1JGRm5IU1Q1K3F2ZU5rUWE5Q0dt?=
 =?utf-8?B?RFIvWVAyM2diaUtXK1BWcm1CKzN1UjR6aFBzL2s2Ui9SKzU4WGk4US9WSXJq?=
 =?utf-8?B?UXpnc3p4aTJmV2pVU0dPVXVORUppaDFZdW56V1A0cXF0N1NQWHdiUHBNdVc1?=
 =?utf-8?B?SnhzdkJjNUhvS0htVXJjTXY1RGpvNStsRVpDZEtMNnYrVW1FMzRYSGFtOTQx?=
 =?utf-8?B?Nk56SzhGeEV6UEtYUGh1M21LeU9vRjVSU2NXVzZwL1QzVGlneWZMRGRGbkla?=
 =?utf-8?B?OVBZZFJIaG1lYk01cUZHOTVsZ2lha001VjYyanRsU3FpeWV1K2QvbGxSKyt5?=
 =?utf-8?B?bitRMGEveWhqR2xJc1VoZ296VVBMcTI4eHNOUy8waG4xcm16OGRrcGN2S0hW?=
 =?utf-8?B?VTF6b08wbXQ5Qk0zbUtsLytLYWdmNlNWNlZkZWVxOEtoYTZoWXZydndjSWxD?=
 =?utf-8?B?N2ZsYjcyUzg5YkEzcGVncXJ5YkRUSm01eXpyNWxGRCtSdXdzdjZOMk9vUzd2?=
 =?utf-8?B?OGJrUTBWOFVKdWlkSEFyamtnS1VxTEkwdEVYRHlyT2lFTlZJeWJrSHJUS1lC?=
 =?utf-8?B?cE9iMkJ3c3kzczRHeGV3NWg4WHFQWXlwb0U0blRxL2tnL0llc255U0o2bmtM?=
 =?utf-8?B?VFFwRnV6WGoyaXNRU2pQeExPQTczQlpoMnBHUU5OeVpPMXBJV3VieHY5U0lp?=
 =?utf-8?B?WXRoZVhIdis0WldBT1JDLzQzSUVpb29na3R6aEh0a2w5UmFob1lzek5DeG9J?=
 =?utf-8?B?WGxHUmZBOFNXNmo4RUM4ejArQmVlUTNlbmYxWFNjTXcrbGhsVXZaK01NdFFS?=
 =?utf-8?B?NEtkRVNzdUdienVWb3FSRXZHZnd4OUFBaURnTDZOVkJhcVR1NHVLdFNXNE1Q?=
 =?utf-8?B?UEZ0SzU2M0ZOa1pqNGpEU0hvR2tSTXo2TjA0YWlSRGpMY1ZwcmRtbU02aXBn?=
 =?utf-8?B?WUpwSDRCMEF6YVprSkpDeElxbjFuMVoyZzhmVHB6NjJLdzdPNTFibVY4SEZm?=
 =?utf-8?Q?TX9FNvfu8y4iESNzIxlPmC39lqCq5Nr8UNt4/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ece9255-d704-4cfb-a270-08deeed8c770
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:53:16.5087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0DIMJhmWTLrXRG9DcA7TAn88pCDY066oMj7dJ4CD7alXVyNYpDp6mpQ/CqdYNLtluyiSjdqBZ47u1rDdJS9PSgwpQQEV1/e2Mwa1Xa5o9bezvTgLiNv84koSIuKOEZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11954
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXgtwJbSkoKuN1egnUA/R6yaBO4N4y6zPf19xvQ92U=;
 b=c5kA1tJD3TTq0YsEq97rOYlHTQiPmeT6wQhO8wwLKTtuNgS2Gd06B6fSqe3A7nGokqtV/PV+Eo4Vo2wqYuLKd52uCTPh9n/7piANQXPqovynbUgRzWlm6I0dNmtc+tU6CEaw1Tl5TfZRFrRLfCJxDCDz0FpMgRJDp+PTqWcPpXnljg+2qrr4ILPoqBYYKtaD3+VycGlb/hhRcRqEYdYowUMMCYYSzBwZcn81ECvIbzRzaFzFX540GWnvjlPFUi/coQshS1yZJqTdvJ6aoYeTWUh7XqPLrIMI6U//RnEkujBBGQlcaPrPqAy1J2XdxEZB+81y/TWJ95Gq9hwe+5gbvQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=c5kA1tJD
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

This series adds U-Boot support for the NXP i.MX93W EVK board, a variant
of the i.MX93 EVK that uses LPDDR4X memory running at 3600 MT/s.

CI: https://github.com/u-boot/u-boot/pull/1027/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      imx93: clock: add 900MHz entry to fractional PLL rate table
      board: imx93w_evk: add board support for i.MX93W EVK

Ye Li (2):
      imx93: clock: add 450MHz DDR PLL rate
      board: imx93_evk: add LPDDR4X 3600MTS timing tables

 arch/arm/dts/imx93w-evk-u-boot.dtsi              |  171 ++
 arch/arm/mach-imx/imx9/Kconfig                   |   12 +
 arch/arm/mach-imx/imx9/clock.c                   |    2 +
 board/nxp/imx93_evk/Kconfig                      |    2 +-
 board/nxp/imx93_evk/MAINTAINERS                  |    2 +
 board/nxp/imx93_evk/Makefile                     |   12 +
 board/nxp/imx93_evk/lpddr4x_timing_3600mts.c     | 1998 +++++++++++++++++++++
 board/nxp/imx93_evk/lpddr4x_timing_3600mts_ecc.c | 1999 ++++++++++++++++++++++
 configs/imx93w_evk_defconfig                     |  172 ++
 configs/imx93w_evk_inline_ecc_defconfig          |  173 ++
 doc/board/nxp/imx93w_evk.rst                     |   72 +
 doc/board/nxp/index.rst                          |    1 +
 drivers/ddr/imx/phy/ddrphy_utils.c               |    4 +
 13 files changed, 4619 insertions(+), 1 deletion(-)
---
base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
change-id: 20260731-93w1-114df23ccd3b

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

