Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE82C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 03:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 33DFE60890;
	Tue, 18 Aug 2026 03:15:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9UmpEgpYMXM; Tue, 18 Aug 2026 03:15:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 544A360843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787022918;
	bh=JqkyRM6xjWCo8lj3l89IvXsONo1TWOBAT/Lb8/ilaeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eSeJNIIX+4BnuFLxC884LP3SohBw2z1WfTu6bm3nKrKzsqxldhhUJU65Wsa7MJs4c
	 1LCpMlUIzgjmj5aoGEl2ataudhYdoN2UygskCiio/j16hwQKirAxvw/jbee3eFuQuT
	 ub8J8xDeEaSQgdGS904JCe7Ws2V+MjYtkJJkb0kJxUEizbbxTkptxn27+7thS2fb/7
	 3Ne2PA4PBKHWJyn5HNKDUReScgnEThPsMTcMuoMy8WNJMOWE2zUDW9rrI/hZ3dQain
	 C8a1EKzoRNu2S4UGAgzxhMkEPLYyJkQwWVrf0D67KZZ40hrflGESikXOnhFS3hMuH/
	 +ZUnvfk5vKHpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 544A360843;
	Tue, 18 Aug 2026 03:15:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 69DB3230
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 651EE4085E
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7vT78rO0rbV for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 03:15:15 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6F9BE40878
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F9BE40878
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KWyueUmi
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F9BE40878
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSQk3sLCXv+5KsAjaLJal8CyVQC3nqP/pGpMkTP69OraANOFNLnJ03b7AEqnkXZ39WXG9hCAQKLyToYk+RRsxXxGuSDEItBARRmr+3GnbbNbYBaDEYEzzB3PPUZuJsWh2k4PIbRknbsrmQbymFkkFx+P1ZvN8evK7YrunooD067XB7QAwEC0z4qgIpYw2hCqtkxgVPWyx0uKv1kfvFFx8ZuSll2KU2TY4be+QS2T4Uzz7Fged0ZETF5se3tVBuCLPGSTb4SosEdB9+1ANPZvIsWkLGPkrdl8cJbl9r/UDSDf7HC1HzZJG/3LZhEXo2l47lvA/7rRP5j7fI0Exqecqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqkyRM6xjWCo8lj3l89IvXsONo1TWOBAT/Lb8/ilaeI=;
 b=mqWadAZH6mko93rTEVc8oH1SnYBJDlpzoDt0zm2QiUh0EhMY9BIldj16TK8zngZ+KWRGG3DP9thy5febZuaR/qCMv4RXz8a6hsMz5pcZNiGoAe62xFGg9UutnwKCvxqed3QLs9JHv8kRRlTloxODjejoDmJUYK6/mrE/CZ53f3I1RYeyYt2ztG08t4OWWqlTLAp0ZH2K58zJqqY3vT+1D/agTA1l9rO9maspA0COtWE9U2fu8gotHEoPyyzR64T0G1rIWt2rgLBK1Futq2QMYdVgDEQeGfTA3IvOf8hLTIgJzuXVV6pt5K1kQ8kpI2kpSY0zcpilkGYZwefodUMq7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqkyRM6xjWCo8lj3l89IvXsONo1TWOBAT/Lb8/ilaeI=;
 b=KWyueUmi2xYnSs0YPn/F63ltmhnZjqwSWOl0Ab8oOJUlLG6yaKZ/HItzmwhtxv2UqaQdYQvF5dNath4MuU/nuVFeIelT32BWTkVJDIC0MQIP8sg80+HG/bDIen6AbJE/PRjjkPTExlbH/5m5TVBCk39vresKGstYprwV0BWjvE4v+upkZip6fVGFUsANjzzUFOo9Qv7XCJFvNwhAk5ytROygP5lXObUxcN5wqMsqBmlrzmmoJ70oOW9+NVYaaAK6r39emGChWCGbQJ9jj3uFDX5zVolP8fXCmEUnz8kXFrBh7aJqMHrUm/DUfW22iBetQ1ULxVQol3Vb1flwt0/BVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI2PR04MB10113.eurprd04.prod.outlook.com (2603:10a6:800:230::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:15:11 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 03:15:10 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 18 Aug 2026 11:18:50 +0800
Subject: [PATCH v4 3/3] net: fsl_enetc: Add 1G SGMII mode support for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-imx95-v1-3-12ef3eea3943@nxp.com>
References: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
In-Reply-To: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI2PR04MB10113:EE_
X-MS-Office365-Filtering-Correlation-Id: 4895c94f-e20d-4481-def2-08defcd6e9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 6LRnlySgYaRpIL10wubS6IIBVvZB3++itrdjvtKg1W3e/Khwaz9pAyMF2rpUh5+raRiEIpAIDuF173SOqDQPucWmjmNdkgxoewN5ngFI5dTn4H+WS5zARsImXLUJLxpXnfaKhXSfcfnp4Rj+p5trqAezcNwyvRPTKuaQfFEVpeYGfEtsmWfGcOxw9Nq4JrNWMEdpdYlJYsZeYDO5w0OoItejrrs5TGZ7J/4PizehLfUYaLVKbk0HDicJ1HtN4Ll3bB51i6INBQOd4/uYeDpZKArqAEWgBHroA8rY3fKJ36o9hhWwiPeFMGmAPNWkOwEaRXMAld1SdhxeRaWmnYuKR9QUnwyOn6FvdEM8wNddTmh9VbvB5py3wDP7rxPdUa/esrSlEutbIZCb+vx1k6xFfj2+dGEdgRbmzXtnpAFZ8V7y1/s05EQ+oDzj03jsSYtg64IEjJqCY5y+wK0x5GnoLZVjzFP6p8QJF0JFvQUwPKABWrpUu9AVT8eV3zyEtZmmnwVIDO+AgTGwqbYY7oWWLIsDYZoFCdiRg2/VV1HRvk/4BRzLW4gLKAK3jB0Jy12NLGSYhl+jJ5jCMmyM0alI107KNNxkF+FQRZQdlDYYrpAcUeka99+mTH2A5E+bAg7Lb7XAKvNC/Hq9hUz1/pDpYWpzrS5QOE1xS0M4yJHoc9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU84OFJScmdaVVgycG41MnNFTlRWcFFheTlTMWljODF5akwwTHVqMjN6elFH?=
 =?utf-8?B?b2ZmdUx6YVV3cmNESWIwUWMyN0hESU5ydDdGYkl2anBXcU1VUW1VeVoza1kr?=
 =?utf-8?B?VmlBbmtoNkp0TUtqZ3oxOHd1R2VKZUgyU0FYV2NSaGtkS2VOTkhPNHlQeFhq?=
 =?utf-8?B?Ymw5M1BLbGkrSzRwVWYyVXliTzV1bG5jUGtFUnRIMkx1bUY3STdNUUxYUG5k?=
 =?utf-8?B?bVRzQ2lnQUplZ2VRR1YzOEZJeVdRZzc4Mkc4N3Y0U3BKbkxiTHJJSlV1a3pZ?=
 =?utf-8?B?OXNBTGtlZURxT1BCbVFhaTlTZVJUYm14T09PQkxZYk9BdUlScUIxdk9tdFBI?=
 =?utf-8?B?RWFxVklaU1Z5VXdENkFvbVVkUzBheHpxN0E2ZEZaNkVUQkdwenJBQkJBaVJG?=
 =?utf-8?B?dDZHNkpXMVJpSXgzRTQ5cGNrcWpBYkM0ZTlqVTVVa1FLb1p5WW1NalZVdXNZ?=
 =?utf-8?B?WFhRWTJ5alYyZnU4V2lMbXQ5Z3Z2L2owUmwwNTVFN0gwREZPUFRoS3ZsRlgv?=
 =?utf-8?B?MWxZR05YOXl2U1l5UWFqUlR6YnJwL3BrRHRHb2d6L21ScHZNbWR6dTFUcHFE?=
 =?utf-8?B?WThYeWlJVWczZGt4YUt1bkN2bzRtQXdGOFBTaC9EQmk1UmpFTGhZK0taa000?=
 =?utf-8?B?eFljMVVjR2RXbDFvV2REUml5RG1iRXhFQkxZSmh5SkdsaVN2OUJsYkx3dlRB?=
 =?utf-8?B?aTZqSWVrT1lXbk1iOS9TVENBNmliSUx4R1hXZFI5SEpYbUIrRFJJVGpDbEI1?=
 =?utf-8?B?YytkbDVuZGFvTGlsb2U3Q3FYZnhPeWxEOGo3bVRocUpZRFo4NWxmNGgxT001?=
 =?utf-8?B?aGhNQ0J4VjZvSnFjeGZRL3c2MW9zcmRncUxkWnNWOXNtWWhYMUJxMFlubk9F?=
 =?utf-8?B?K0tsRWZ3T1cvSldXWGhlMXZMN1l5T0c3TU95THI1VlZvOVowSjhFcmxqa1BG?=
 =?utf-8?B?NzYxMWRSL2c3a1REU1RYYUdZWXFLVlVnMHdKTVUrRDJDdC9PR2ZUSGN1bzBt?=
 =?utf-8?B?M3BLQWpLNi9UZFMwMkdESVc1ODU5bXk3eTZBelg5L1BpNkRvc25YUEpxbVhT?=
 =?utf-8?B?RXFxZGRBWUs1Y3JQd2cvY1A3RWVPL1dMeTh3Yk4zbUFDYk9oancwSHJsUGVa?=
 =?utf-8?B?M2dlbGVTdFZvSzhtR29lM2ZycC9jMU4vOU1MeDVtWmNCaTdLam5MbDlvSFRw?=
 =?utf-8?B?V2FnV1poaDB6SFV2a29ZaDIwaVRWUlplZnFheHRLUDZGckRlTGd2dDh5TW4x?=
 =?utf-8?B?alJOd3hpd0ZIcXNselVYdGw5VWFBUFZwcFFvN1YrSTZMckVnWGY3cW03SktC?=
 =?utf-8?B?ZmVrUS9vSWhtQ2R2UHlkeDAvZXdadVBydWtjZ2RYOXE1VmlZTXQ2V0dQdmRU?=
 =?utf-8?B?b3I0cVlwcjdITmRTbXBnb2FvTWcvWS9vSEJ2QzFHam8yelYyVGF0OGJzRnJ6?=
 =?utf-8?B?bkgrZFB5SmQ5WlJObE01bHJFeGVERXdaSEFlMjZ3MVNsZEpjalV3bW5hMmxI?=
 =?utf-8?B?ZE5zQXdwWEhTcWs2bTNQMGhIanhRaXlzMllLRTEzK1o0cERtTWtQKzl1ci9w?=
 =?utf-8?B?TVVaakthTm4wdnErenkrUyszMTE0YWdTQ09FanJOdGIyc3diNU95cVJWZTRW?=
 =?utf-8?B?cTd2V0k3aDUzQ0R6Z0ZYUlJFTHd6cnVISHNuUTdFUHArbHFhdXp3d0l3RWY5?=
 =?utf-8?B?amRBTXZEQ1EzdTV5bDZKSFVGaE5wS05SK290SW9zODJZaVNqYURhTUtoaGxX?=
 =?utf-8?B?MktmY2l2ZU0xbmlIc1ZJYXBmbU9SN2N0cmVtcTUramttRmcvYW90azloWndM?=
 =?utf-8?B?aXJEVURpSmV5U0F6NHYrUFJPYVJqUzladFU5MXE5eGhwdzJkZDExMjNSdXR0?=
 =?utf-8?B?L3JWcElWcHl0N2RnZEVQUDl2NGxjTy9GUmxjRU9INE1GYVBwUktYVC9rcERC?=
 =?utf-8?B?MDV6d1dBOXN0eGxiYXNwTUFjRGVUbng5MkVVbFRyTCs3QnV4RXBGSFFxVjIx?=
 =?utf-8?B?R2lOczNvaldEMU8rd3A5RmVPWkVWVWkrSGRPS2RsdmpRR2lqNmRvbm1rUWUx?=
 =?utf-8?B?SkpGUU5UaFQ0SEMrdDdhc0MvL095eWNBWDFENU9VcGpLWCtYam8yTkN6Zldp?=
 =?utf-8?B?MU5CSWtMbE1WdkFETGp3NHpxc1paWEZSWThBb1o0eitablZtb2xFdjR6bHA1?=
 =?utf-8?B?QjRCTytBQzNrUkdVK1FzMlA4enZkQm9vQzZtYUp6RllLVFY5K2xvYmxqV2F0?=
 =?utf-8?B?K2ZhaURVUHVNVThwVExrYkIyaGdVNmMwZ2owd1piVFpScmVSei9yTndLSVMv?=
 =?utf-8?B?N2NmN3NGdXJYVTRhNHVsWW5mN3ducXhJb0luTnEvUDVOV0NvK1YwbHFqQm1H?=
 =?utf-8?Q?ZKxD1omVRd6uKFFsfnh4zCZ9t1IohDP45b079?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4895c94f-e20d-4481-def2-08defcd6e9b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:15:10.8909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfscYJezGn0x1ZpuHVMVscdGijSMDYt2Kzipkky62yrRkhKfjkZM35bDj2ye8d+Xkvv/6VZSgNI0d55xifmQwvcMBpM5Wfm4ERmjoPq/LoVe7V2Wq0OtuXKJ5JadZPjG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10113
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

From: Alice Guo <alice.guo@nxp.com>

Add 1G SGMII mode configuration for i.MX95 platform in ENETC driver.

Note that 10/100 mode is not supported.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c | 19 +++++++++++++++++++
 drivers/net/fsl_enetc.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index f393af40e27..779088cc20e 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -35,6 +35,11 @@ static inline int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
 	return 0;
 }
+
+static inline int xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	return 0;
+}
 #endif
 
 #define ENETC_DRIVER_NAME	"enetc_eth"
@@ -387,6 +392,9 @@ static int enetc_init_sgmii(struct udevice *dev)
 	if (!enetc_has_imdio(dev))
 		return 0;
 
+	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
+		return xpcs_phy_sgmii_1g_config(dev);
+
 	if (priv->uclass_id == PHY_INTERFACE_MODE_2500BASEX)
 		is2500 = true;
 
@@ -482,6 +490,14 @@ static void enetc_setup_mac_iface(struct udevice *dev,
 			if_mode &= ~ENETC_PM_IF_IFMODE_MASK_LS;
 		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if_mode = enetc_read_mac_port(dev, ENETC_PM_IF_MODE);
+		if (enetc_is_imx95(dev)) {
+			if_mode &= ~(ENETC_PM_IF_IFMODE_MASK_IMX | ENETC_PM_IF_MODE_AN_ENA);
+			if_mode |= IFMODE_SGMII;
+		}
+		enetc_write_mac_port(dev, ENETC_PM_IF_MODE, if_mode);
+		break;
 	};
 }
 
@@ -565,6 +581,9 @@ static int enetc_config_phy(struct udevice *dev)
 	if (enetc_is_imx95(dev))
 		supported |= PHY_10G_FEATURES;
 
+	if (priv->uclass_id == PHY_INTERFACE_MODE_SGMII && enetc_is_imx95(dev))
+		supported = PHY_1000BT_FEATURES | PHY_DEFAULT_FEATURES;
+
 	priv->phy->supported &= supported;
 	priv->phy->advertising &= supported;
 
diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index 6d868e82f8c..bcab6f252a0 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -104,6 +104,7 @@ enum enetc_bdr_type {TX, RX};
 #define  ENETC_PM_IFM_FULL_DPX_IMX	BIT(6)
 #define  ENETC_PM_IFM_FULL_DPX_LS	BIT(12)
 #define  ENETC_PM_IF_IFMODE_MASK_IMX	GENMASK(2, 0)
+#define  IFMODE_SGMII			5
 #define  ENETC_PM_IF_IFMODE_MASK_LS	GENMASK(1, 0)
 
 /* i.MX95 specific registers */

-- 
2.34.1

