Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199B3C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8997483B95;
	Thu, 22 Jan 2026 00:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eW2yYxdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B882F8313B; Thu, 22 Jan 2026 00:51:50 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3659483B87
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkPdb8lTKS/8+yCO+WHWA3CbyVJ1slAuwPVg40HFCEQJ/A8kFDWpiBs1X0o4+Ff239Rg3l6BnEBFIH3kzNKLrK0z5svKGwcJ1hekhIpt3JgeuGpKS/geWO3Ev2nYf/UPXtfvPaaAYvZBzSCZ4vthmOvQIfdhSewybPhwItJ3Yu+aD4r/ZjFZyqzB3wWHYzc5fatcGZb1zkixkQaCed7v79C/r+gDimnqZfQJw5NY4ApuRGIvvmCNKLx3kietSu2cDziOdCWtiD3bMfdRfw0oPZCV0sF/weDUNWnnmVHYMw0Drqk90UVQA2f2Pn5VJQWeLQC60YFmONgZuARJ97zTNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH09k77HHxb4OMiixo7YFusCCUuZrD6U3lpiM6l1i54=;
 b=pxANKa25BQHkBRTGAoRxV8lYYpA7XB95pj6d3ugILm0UaV3Bu540QhWnIk/zuMutWllsVPA4c+VPy0vhHL9JIJuYiOvbxT0rUB9OPxBNaciEBAwW9nKrLdTjpAX0ItvUk2/I35aUCEeSWxyAq4BWZTbINGWE9zBW0iP3EhSJacoHL9vg+S3CtwlB2LPH3+MLIrjeFHzQdLBHR10T+CrhDY0crANnpOw3ipSq7GMQ7ou0e6wdXMqRg/y4RTy1MSqsjAaIYLGQRJ9F8IfTKi/1eEMyCHKw8s6Mp5Ti/k5fLgJ5W9R/wDkcEoc4QaHk5Mm7gGhTK50q/YIzh80YVy7JIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH09k77HHxb4OMiixo7YFusCCUuZrD6U3lpiM6l1i54=;
 b=eW2yYxdfQnztBdquVHXkszgBKG2eaGsHG2XSK8OEDupSmPe5xDnsGrF6yAQ8SAQr5SmB7KvVIO8azaY7z3FDLE/MbFLAgB2yGDTHOMmkUVPIs+qc2yij5XAO5++ZPlxrWpSqdIzDNHIx7mRSwgNB91BKlmnj8kOPGx/mE7bcwFBUoHyUSVJO1n320rdQxBM7y4Nuyhralcup4pUeI7jHUU6E9bE27z1mksWpn2y0KFs9Di1uqaKbaZ4DjkK6wvE6Vm4L6lL3rYvkN5p6afj8Eu/vusGQjtdYJGdI3I0q3SDGK/kzkI4ewqy6/FNu/5C4d7jgd1cjdM/6RdUJVkX2VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:50 +0800
Subject: [PATCH 07/12] imx8ulp_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-7-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: f14d322b-d3d5-4744-5436-08de5948095d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlI2VTNqbm54Z05aZHBHcHlpSDBuL3dULzhrZExSZitjZWtnRWppVjF4TjhU?=
 =?utf-8?B?ZlFPcXB5ZnZFUS9tQ3k4QnFBQkZjVHI2QWphenJraWFHWFo5ODA5S0d3aXFt?=
 =?utf-8?B?TE02RmVNMDNXcEVVYmI0TmFmcGsrMjRDb2F4TGhyNUVQSmtGV2UrR3VFK2p3?=
 =?utf-8?B?Nk1IaDlYZy96ZGNPVGRSWXFkSjg4S2QyUWRrQmoySlRNZHNQOFJxRVZpdXM3?=
 =?utf-8?B?SnFiKzNZWk1LV1ZoK3dqc2RYRnJodDhTazYyVmdrbEVGRjVwRmxKN1grSWk2?=
 =?utf-8?B?UFBEZTBlM05oVlc4M0ZJNmU1Uzhhc1Y0S0YrM1BzM0ZMS28vQ3FydlpRNGNz?=
 =?utf-8?B?bENUSGpmNTJhVU1vOFVUVGxlZUNhVHJkdGxWMlQ1MHlmcjl2YmlkV1RXOHZr?=
 =?utf-8?B?Q2VLL0RxOVBvaTZFZ3MxdUF3UEY0ZXhiemxVeU5GOWIyT3JEUXVubUVOL0xW?=
 =?utf-8?B?RVhxaEJtcWFuV3FQdW80RTE5MnBaRE1lRlMyTnFhSFpSRFZoaXFJU21hUHRV?=
 =?utf-8?B?OWlPWEQvZHVyMmx6cjVpbzYzWGlLRFl6eGdRTm9YK3JhR1VLcW1FL3h1ME5X?=
 =?utf-8?B?bW9SeVJnRzcvWXhGVGE2SWNzUEtqLzZrMnVneDBNZVZOdExreUxSUWRyL1Iw?=
 =?utf-8?B?a0tlWGdIZjBQa2o1dlRhNVBzcFRycXF3N293R1Q3aEhKSU9hZDVkYTRSYnRw?=
 =?utf-8?B?RXdDdzNUaXJsaTNNTk53OFNoTUJ0clpyM2RHWkZkNjFzQm9jaWltYnlTYzQ1?=
 =?utf-8?B?bk1uSXJyR2lHa3BmUFVadjhLWTZyNTVieGRYQ3E1TjBNbkh3ZGNEM2RIMlN5?=
 =?utf-8?B?dzRqdGNaR2JLZmV2OFpSOHZlK0lJa3ovcDMvNzFRSUhBc0pIUzBKdDNWTDZQ?=
 =?utf-8?B?N0Q1clVHa3lhRExVNlEzMzlBSm8rYm5Gck01M3hHbS9WR1MxUXdqQkdYYmJl?=
 =?utf-8?B?dEFFM2FFUk5TeDNnTUtZZkgybkdnckJFUFNlRHpLV2NQdG1nQklEcm0zN25j?=
 =?utf-8?B?blUvTnJBTDZZQWxPZ3QxLzBwSy82WDF0YnphZnY4NlBTaHhTOGhUU3VZRGEz?=
 =?utf-8?B?cFQ0M1FwYzBWaTdWei9kYXBHMWQ5czY2TXpkNmtWYjlhTTJEZXBzWDdaUHhx?=
 =?utf-8?B?OHNlQ0RteWxoK2phNE8zR25TWXRIMjJCS1Z5RVhZWGJsak4rNEQ5WlpBcmhV?=
 =?utf-8?B?SjRNMmZOOXp5MmU2SXVjVmFGK3ZwYWpETXlCR3BOczNQYnM1RVdZbmtJc0Ex?=
 =?utf-8?B?L0RiUElTaUhvS3hnUk95alo3Y3ZxOEk1YkhKSGZMRm10TGI3NFlxdjh5bk04?=
 =?utf-8?B?cFhUelhDV3R5OXprMXlCZTFCaU56bVpZSFRha1FJU1JJL0w5MjZnVkNmbWlE?=
 =?utf-8?B?bTFodDh0RWpLWmNacUhJNDZpczJ4MU4vcG0vdWtBMFNqa3BCM3RwdG84VmRx?=
 =?utf-8?B?OTZPK050SUFOUW5idC84dHh4Zy9RTmo4bzQycEFHdFEwNno3cVM1cURpTDd4?=
 =?utf-8?B?Vkx4b0xEYXA1VFRpT0ZlMGdOT3hRUlM3aHFRNXZWUDBQSnpCVmhLYkt2VjUw?=
 =?utf-8?B?NjVRY1IvbW52L0NERUFjWGZjZ05EVU1jcjAwNGgwbWdMUm9EVkhFbzNLNzRH?=
 =?utf-8?B?ZDZLLzNZVG1YS1lvUnVocHVCTjF0cnJtcUY5TzBrQ3VrQXIybVRSU3dCSFg3?=
 =?utf-8?B?ZGVhZGZMUWs2UUFHbjdLZWY1VW9CcEMweHhBOUd4a3E2NC81bHoxeEtRcnow?=
 =?utf-8?B?cVpRWWFHZSszZVRrdUdkZFo4bUFqNnhFMkpBVW5Pb1dtcHNqdVpraDJLcUY4?=
 =?utf-8?B?MjRUWGVaZEZ4TmRhUUhHQ3RCUzRqWDZweDNkNUZoc1V1SmIrTHFYRkl0OXda?=
 =?utf-8?B?VnhxQytkVTd4T3dDLythMWkvbktHZW5QVHdpalNGWDRuOVZXOG5BWk9EbENH?=
 =?utf-8?B?NGlid2NvWEYyVmMwSSt3Q05aZkdGOEw4Vy8rc2RDQUZmaExuLyt0YSsrNDg3?=
 =?utf-8?B?YVI4R24zU1draFd1WjBMdGpzRUtIL1QyQzU2NFI0cjRGVCtVazlMOStDK2ZT?=
 =?utf-8?B?WlRka2MyTlpmQ1BMcHJSY3BLSGxYMGNxZzlZN3hYRGlLckd5eWpQeGJ5NXFv?=
 =?utf-8?B?T1NFYTZaZ0F6ekhRbTB5UStJQlJNK3RyT3NlZzZXNUJzM3dwdG5XWnNDUUp2?=
 =?utf-8?Q?puLn6wLEcj6HNFOsHYX16bs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXROWlVKWWgzQ0Y5cjM0U2ovWFZIa2d4TE0zckhVRUZFM3psdnBUU0RzNXFi?=
 =?utf-8?B?Tmt5Uy9xMFUvUENHdVVsckVkSWhGdmFENjZkL01PZit3cFg5MW5wK0VVRWo5?=
 =?utf-8?B?TkJVTC8wT1YzRWNoeVJmUUtaM2MwV0pOZ0ptanVVTDB3UTdHQldiMFB2b0hM?=
 =?utf-8?B?bUxMOVM4MW9wQzhmb0VmTUV3TmhVNCtnRjZTYkVuNW80NUMwUXFHdjhDdUw5?=
 =?utf-8?B?dFlBbWxXSk1hdkdkYTdDNFpDd1ZwMUR5b3Y0WHZvWHVUL3FGdGlGWkdTbmI1?=
 =?utf-8?B?NVc4RXNZekVhWlpxRU5JWm1mdjMyV3JaTmhNb1cyR2RsWDYyN0hxSXVHYjlT?=
 =?utf-8?B?anNPbkxhZHdrYjRnNDNwR1FTbDBQQVoxSDMzR1VrcGlKMkFEZjViQldCWHZ3?=
 =?utf-8?B?TWgzaW5SYmM1ck5nZFF4ekRRNU0xTzFyS0VPN0FndWo5cXFvdFc3NERzZHhE?=
 =?utf-8?B?VGRGMTJaUlZySHo0RTNZdXVCeC9vN0o4TFpKT24vajJRT00rMHVzUndaRTRS?=
 =?utf-8?B?Q0hMWHpHMGNpZzBLQWcySldSU3NmU0wzSXQyNTRpYURIVWY4RVJYTXdLVGdE?=
 =?utf-8?B?NE1qZkFXai9scVlSUFViS3FIamVhOEU1ZW9rQ1QvaUNaSGlxcHpoZ0dQTjZa?=
 =?utf-8?B?Mi9DME92aTRBZjVMOHhXSTlZMWk4VDR4cUhIckdRN2RvclJzeUI5bFBqOFlK?=
 =?utf-8?B?dGoxWlVVTS9xM1FndjIyOEdIVk0rcEhKUGtjTFl1RlhyUk9VVFFoQVJJdUpB?=
 =?utf-8?B?eHFsUEpWbEZzZXZ5TVQ0S3ZjaHhFY0RyY2Z3Y1pzbThXblRJSm5abGxQOGRn?=
 =?utf-8?B?OHJzSENNN1BCVWR1QWVKU2hyNnRLL0F6dGFURGw5OEdTNXRHOFpVL3psSHpR?=
 =?utf-8?B?ak5MRWxYbW4rL0I1OVpGRDJnY3M5ZkxqbDJlc1VGM1ZYV2pmMDEwMHRzU05D?=
 =?utf-8?B?cXdudWJwS21aQjIrRGNlL1FZNEF6KzM0Z0FQZGRldW5WWnFvNjFxU1RGelA0?=
 =?utf-8?B?cUsxTXpEanlzUjRzUVZDUHk4WFZPV1hLUjBxcTVRWElRWlExbUpjV1BaNzE0?=
 =?utf-8?B?ejZvN3pRK3pYYWZXcTU1Y1NlOHhjem5ZQ3hySHFJVUNkODF6NlNabFNUdVht?=
 =?utf-8?B?bXpJdnVFb0E1WjZPVDVSdU85WnlWVVhycmJYMVUyRG82U1JoNUw2M1pvWTVv?=
 =?utf-8?B?RFRVWXlwS3ZHTzRqTHZrM2h4NW5TamhPTzFUN2taZkJCK2ZXaHR0UzlQQVhX?=
 =?utf-8?B?M3lGVER3dkZ4NlJQUk1aZ1pYdzA4Qzc5dWljWnB3Y3pzNXBiMGFRSTl5SDZZ?=
 =?utf-8?B?RzVnSW9nZDhITFdadG91ZTdqZWlKSmNDNEVDL2lkWlJiWmxoN1VIb3g0cWJu?=
 =?utf-8?B?N2pHMGl5WTZIbktWRE14eVNleWZOSVA3Y3VxSDU4cWdENmowdy92dzlLQ2dB?=
 =?utf-8?B?ZXQvQkJTSjBPNzM1WDltZmc3N0VIa3NvYVhIazhNOVF6eGZRRVNrclYxVm5L?=
 =?utf-8?B?TjJoQVVRRk5FSHFlTjdTQ1U1V2Zic2FJVG1EOFZ3Y2F3STU4T1F3RXEvNGZS?=
 =?utf-8?B?SEZLMHl1eWVJMW53elRkVW5ZcUJpeUVYZ0VCZTIxM3ZJTHJlT3QwVDZsOS8r?=
 =?utf-8?B?V1Qrc2EyS2JBSVVvT25Ib1hqQTVWV04xdlRVa3hqRHZXdEFoN3lUL0FDZWRE?=
 =?utf-8?B?eW9lcit2WndlTXRFWDN5TFdtb3NPYlRCajBqYllLWUcwejl6T3NLTmJXVjc1?=
 =?utf-8?B?ZXJrb3d4R0pwMDRZK0NIaWJ0WXJIdmhMNVBwUzRDRmNsRVBnR25JdjJIbVAr?=
 =?utf-8?B?YVFnZ05zS1orc2hFMnlYVnlyaUNvcU8yYmJ5akpFSmpNYTFEVmVIWkRHelEx?=
 =?utf-8?B?RDhqdUVpVXFUT214U2UweUFsemsxV050SDE2QVB5Yko5dmF0M3VRRGJyVm9N?=
 =?utf-8?B?akJiWWFWUzJPdERNSm1LdDNUTHZ0eklUeHpzQ1lKeVlkOHZjOUlKNDNUZXVV?=
 =?utf-8?B?eGhvTU9VME1IY3o1cmhIL2tNQnBmZGFnelZCbVZFdFRpWGc2WVdSZTRJYThn?=
 =?utf-8?B?blFZZ05ZcHR4K1ZFVUdsUWZianZhQ1FoSmNWZlRxc0FSRXg1ajhIK05BcG5N?=
 =?utf-8?B?Rkcvb1dsMjhHNjQrKzJRZ3BGMUpjdVN3ZEduNzNsZnlLSDdJYWdyMzA0UHNP?=
 =?utf-8?B?Wkt5em5qS2R1ekZvY3JGdkRCNTYxbDFKRDN0czNPWGFZd0RlMHBRaVFnTGhJ?=
 =?utf-8?B?eGsrL254ZUZzekl4YU9qTUthUUhSVEJQaDhGcW1aV2F3VEgvcjNMT1FDN3BC?=
 =?utf-8?B?UlJrWTh6K25ldVRvazhpTVRGU2hKS0VyUGFkWjhpdzRCdEJJNkhmQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14d322b-d3d5-4744-5436-08de5948095d
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:46.8818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Prj/o4Vz9zTefBRIdPGGK9VlS/pybrwCRk1Hm5CIfZxz3Ph0rYQ5rOOuOVSDEk7vz/6Jj5lYdIgbinDCbYyxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

From: Peng Fan <peng.fan@nxp.com>

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8ulp_evk/imx8ulp_evk.c | 2 --
 board/freescale/imx8ulp_evk/spl.c         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/board/freescale/imx8ulp_evk/imx8ulp_evk.c b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
index 4bf77a488cc..cd17f6960c7 100644
--- a/board/freescale/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/freescale/imx8ulp_evk/imx8ulp_evk.c
@@ -14,8 +14,6 @@
 #include <netdev.h>
 #include <asm/gpio.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if IS_ENABLED(CONFIG_FEC_MXC)
 #define ENET_CLK_PAD_CTRL	(PAD_CTL_PUS_UP | PAD_CTL_DSE | PAD_CTL_IBE_ENABLE)
 static iomux_cfg_t const enet_clk_pads[] = {
diff --git a/board/freescale/imx8ulp_evk/spl.c b/board/freescale/imx8ulp_evk/spl.c
index fe637077928..656c2723494 100644
--- a/board/freescale/imx8ulp_evk/spl.c
+++ b/board/freescale/imx8ulp_evk/spl.c
@@ -21,8 +21,6 @@
 #include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void spl_dram_init(void)
 {
 	/* Reboot in dual boot setting no need to init ddr again */

-- 
2.51.0

