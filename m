Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BAEC3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58DD88CFC;
	Tue, 17 Sep 2024 04:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gLwepeJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5B688CEA; Tue, 17 Sep 2024 04:30:38 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7126D88CBF
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5sPTv2V595f+7MUhIzvNMqn9vuBUCK9BSc7IEpXGNeQW+G8axGpuOFCw3TF+Lu0vf6OAVFXboZ/BNc9nd4Dan//EW62WdbzdcvDacC3nAlvOan7bqs6CbETTIB339cTwlQMex4pZQ8v/dlozQQTBD6o8kNfMLGsbPQ7mlJkj7m0AxfxZ4PiaiOlGsUecUknzjcrKOUNcS22Z67M9AjC9GJV6phD+9nJxOGYPxDQxB56wY2hgKOAGqfoCnMynr4x8WFYC77lJgxCI5mvUau8nEp9x+Qo2q0y+FTrQ5AJRoLd+C40VIpLFqIn8ApDXAShwhS4u9mL/4uhsirVEqeGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fq2j9NH1zSFiX28Oz0r9vSNfqPi6zKByYhW4D+V0V5w=;
 b=G461ReQ18sikkQ0Ab0hcUDLt5Lgd3HdOwuW9RbiHTEIM+g6NnuixML8EuhdvNNqn8rME42jgVLAHUQzyCBR0YVXoAN5FWR0dry8YYDfCnjHu9AtLQ6+HrMiJUfSb+qKmCwQwq0N0NCHJn4iHB0pixVVldvKJQolH47Q0TFwTh3/v/kIu2MdL6FMj921vZUDsImPFQ9NDzlpOoYvOoBfTmanUKN0SV8Vdgk+SsU96HVrCQqR59KxGMrz8AjvG0t6w5knYTpmgtZyHfNWHUllts7yPg2m6bTqApZkyawVhqQyR43sJ5uVd2LKox2lhBzlYfl8BSLgK1SxyndP9iYcD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq2j9NH1zSFiX28Oz0r9vSNfqPi6zKByYhW4D+V0V5w=;
 b=gLwepeJ55uxdQDJ88ArQ1Q2BR5dnA05d4WxeSfQYeHLyZRs1CHrL5TY5tCDvyu4aMfDn7hmor/cWZRpQw7MjsCnrupKpaZpHAx88NRszstQHk1ChmCcPUugEF5nqwEVs6t67abpQb6Yjvsb183PfipZiXGMBNlEOVaxCdFfq+jA1QaUOfBwi8jdkbdip0dc/IHsCNf0fAJ2VuVUMC6NbdkQgHZ7Oycv439j9K9KfB+E8Cl303oj1kuxOVptBaIPo2Ea+aHRqBByBQ126ebRs/qSbJ4HT3Et63aRdUvFSoVr11WWkLLC4CMUT/cd7KgQyvnm2QmNjUgk+WoS+RyIlXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 17 Sep
 2024 02:30:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/21] imx9: various update
Date: Tue, 17 Sep 2024 11:33:52 +0800
Message-Id: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKD46GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mz3czcCkvd0oKUxJJUXYPkVGOLNLPk5BTjFCWgjoKi1LTMCrBp0bG
 1tQDaz180XQAAAA==
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: e8342f6a-8c69-4aef-5913-08dcd6c0b481
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTYyaEhRUkpLUzVvZ2RZWjRvalNZMmozSHdrd1Z5RDg5Z2lSME45VWFhUGsr?=
 =?utf-8?B?MmM1MnRobFhLaG40UTROcDdUMzNuRUppTTR0K2RyMEhVRTgwVmo1K2FtSnR4?=
 =?utf-8?B?TC9SSXZuaHM3RWtmRjhOUTRUQXJNYXNYRzNKSXVoUDh3TGVCRmYzaERkaCt1?=
 =?utf-8?B?WFd2VllJanprRGdCTEZHSFMwcGFLWWZBU2VjdkZnYzVrdFZWRHd6aVNROE5s?=
 =?utf-8?B?TzVqeXkwaERZVVBEQWhEaElzSW5HT3pCSnJIY3YwYi8yKzJxM0xCTUl2bEwy?=
 =?utf-8?B?dThWQVNjVXkreEVJb2tNd1VqVENEU0FJNzMwd0xhSURmSTBSQ0UwZjhZREJS?=
 =?utf-8?B?bTRId1BYbXpJK1NPY1VMNkYzTW8wTjlPMkttNFpWbWpQQndqRXRPZkVSVW9r?=
 =?utf-8?B?WjZrSjZNSk83Unc2TGxWSDhDcGx5b0JKcW5weExmVmtkM2tGUGpkVmFGbmpU?=
 =?utf-8?B?aHBFeW4zV3g4UkU5L2dYbjg1ckJsNERCRjh1L09aTk92cVR1aXF2V2JEWjhz?=
 =?utf-8?B?aWtXSDlXZ3lsNDRFL3VQWVZHUm5ZSzQ3WElSMm9xaEhOWUVyeWRFcVNZbWNU?=
 =?utf-8?B?enNUMXBTWFpSVUZCWmltMVpzTFZIVGRTVGxkWUxDNy9kdkJlSVNtVTk1dG1B?=
 =?utf-8?B?YitJcWJTT21qcC9OendqalZUOUZKekF0TjQ3K2prUXRGWUlhZFp1MUMzZ3FM?=
 =?utf-8?B?L0tBTHpjVWYvU3BKVmhOUXZwcUIvc2VYeTU3eHlaNS93c3ZmeFQ3a3BjYUM1?=
 =?utf-8?B?eGtoMm5mTGhCdDE4cG43a1RYN0tBNFlCVVIvQWxmS3c1YWs0cG1rdHQvS000?=
 =?utf-8?B?RVNYQUw4VEJIa1lvUlJqeC9OZVdoZDVHVFNnOHRRV1Z6WmIxc2FsRDN4Mmkz?=
 =?utf-8?B?TkdLYUFxVXk1ODdSTVNuRzk5TWhTcE1zYlJMcDM5VTRodTdsOVJxeHJjeFJD?=
 =?utf-8?B?akFTeDVTcmdZeGIzdHYrampHeUpsOUJxMklhQ3FjeTBnSWhHMkZKaW1MNHBM?=
 =?utf-8?B?UDdvYlJFaytxOXNlY3lhazhFZ1FtNHV1RGkzdjgrck9OWElWbWxDSmlrYkZq?=
 =?utf-8?B?Y3d2SmhEam1QQnQ3VWZrOU03WXRTTmd4dHFXc1dXS3Q5Y3I4QVlic1U2MWo3?=
 =?utf-8?B?RkVWemVoK1Q1ODArSUhtckdHeE1CNkhlZlJqeVJJVmhleU5qKzRLVzFmNWdR?=
 =?utf-8?B?V2lWZ1ZOaG5ZTmkyeVBvMzk0eXRCSm45eWJsTDJIT1ZxYUV1MEs0Z0VJamJl?=
 =?utf-8?B?b21RMmZHeHpia2xib2dGVllVNC9oY1B4K1EwK0lxMk9JQjV4Ykt1KzFJbGFs?=
 =?utf-8?B?V3J5OEpJN1lFWHlBZ1o2UnhrbTNYaFM4K2hRQS9mbm5IbVBpMGJXVW9FM0xk?=
 =?utf-8?B?V1lwbVEzbFNNNE04OUxmdGp1dFRBb1QrS2FwUVdJY3FDaERLcU5MZXNtZkI2?=
 =?utf-8?B?WkdaK1d6cnZoSmtpYXNlVTFzOGVoSlNlMExudFYxYlRGbkFnTjAxZnE0K0Rq?=
 =?utf-8?B?NEFyZklYYmlvM3FHNXVJek9iWnBtKzJqS0tQZFZLZkh4eDlRNXZpWDFmZ1RK?=
 =?utf-8?B?eVdSZTZncXh0VEZkdTg2QXRrZ1VZZWVadUI0RkliWEJFY0ErSHlGcCt0MTZj?=
 =?utf-8?B?Y2FhejFhcWV5UWFXeXM3Y1U3a1l2cGhjMXpSRGhCRUlmbzZGZFY1UzBOcWc1?=
 =?utf-8?B?eGdZMWljR1lQWXNyY0V4MWRuMy9KTFJTL1NMajVpcGtkcllxTVRqWUI1M1JJ?=
 =?utf-8?B?eXduOVVhZUh1UEdrekY0djlKcFlFY0s5em5hN3pVYjRycThzem9ZdjdqVUZD?=
 =?utf-8?B?ZENyNlVqS3ZmWHo1U1B0UWgveEcyTmhFcU1JSm04bVBzcUVtSGlIMit5NDFo?=
 =?utf-8?B?OWdodFNCemI3RGQrcnpReGVrVWRxMUFBU09xVFJNbTFtanc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW0xM0h0a0hPSm45UWR0QzBYUHJHNFJaWDJvUXc0cDVxUlY0VTZmdkdwZHFQ?=
 =?utf-8?B?MVdvbFZoQWxhaHRvR1MwZ3d0NnhHemp1dHdLb1VHQXRWNTFndy9tN2srOVZU?=
 =?utf-8?B?NjRvQlFTVXpMeTJPZlJPNTFWNjc5UGNUczJ1OGdJYXhFSU5qTGU4YzNScksx?=
 =?utf-8?B?WlV1UDQ5UzZEdkdRU2NaSXhDQVVacVdva1ZVMTd0RzRNVHJlVEdBS3JNWkF0?=
 =?utf-8?B?YjFPK1R4eG9NRVlYcXZUdzYrV3lMaFhOcUFPZC9acU1WNUJVaXdRZ1Jac3pI?=
 =?utf-8?B?VnVreXk2MVlTcDBRbDdBY1dWamx4T1JtcDIxK0lOWDNQZTF1Y2JHeWNoMWpQ?=
 =?utf-8?B?V2RMZ3hETXpEWFNyM01wc3Uydm03bkdaU21NZ0U4MUZUWGswOWpoeGtHOXhS?=
 =?utf-8?B?QWU3VG1HREZMT3hqcnBoSnIxSEpuU285ZDhyQXBJYXNLS0ozQ0VhQXdLaTRr?=
 =?utf-8?B?bnpKb0JmSU1jM3M4VzVtQThZUEhDTGRPSnEyZ0RLZDBTemRJQVZGRUo1L1cw?=
 =?utf-8?B?eU1YUkNrSnh1TXZnNzk5MC8yZTVSVjhYZXl3Sk5YTkJncGU2K0s1TXNnR1Za?=
 =?utf-8?B?OXdNV3hETzh2VzRVUk1KYjJOTUYyQndDclU4SUpvZmVNellUZWdMeGo2Ty80?=
 =?utf-8?B?TCttVTFKN2FrRkJhZ1ZvN3VvczZpb0hzbm1zUTJwRjJicnB3aURwUnBKejNX?=
 =?utf-8?B?dWVydVIzYmZ4cTJRS3ZneUVqRDhIS1B3RE1UY2ZjUEhoWFNSUGN6SmZ0Zmpo?=
 =?utf-8?B?SG9qQjZRSm9GdVZNUjg2UlZEZXkvWnlRZVRzQTJYQU4yTlVwelJwNEV1ZXJS?=
 =?utf-8?B?NXJsVm1zV0R3d3ZNaUI2NUJ4bll5aS9xM1d0cGRQU1BKU3o3VTdMQ0NkaXhE?=
 =?utf-8?B?c2JxeXNydFlZaDUyMjBkV1B1aWcvb0xybzFoTGhxOTJ1SlF3NEtWcGkyT2pG?=
 =?utf-8?B?Rkl2aFZ0OEJ6MlorVktZQmhLZHJMUjZMKzJOakM5N0hXbDUyb2krMWQ3VHk5?=
 =?utf-8?B?dytBNGY4bWdWcXhGMlN5Vi8vYitzczdYRkVFZDgreG1tRGkrVlhveHpsQVIz?=
 =?utf-8?B?b0JraEE3YlAycUhhMmhieW84QzB3eWtJOUNuNWx5c0ZQRkltZHRFdjVWUHRB?=
 =?utf-8?B?dk1MUnA4eHRPdVhIZzJLYVZyRVFKUFZzZjNOb2VOQkFSaWdRUStudHdaL3lt?=
 =?utf-8?B?TGdnSnQ1ZFFrU0JoUzRQZlNIWGNJYmdjYllwMUV4dEVLOFlmQjNuT0JIZUpU?=
 =?utf-8?B?NEs5bTR6NmpmbFk2OEE4Y005cnBBSmVEL2ZOMXV1S2VLWW5sRkp1QXRXWnpk?=
 =?utf-8?B?SG9YVVA5ZUtFMGgya2FkcTQxWDJYOFhHRWRjZXhYWEtQOFNHdUFZUExYampZ?=
 =?utf-8?B?eVFycWRjWmU4NDQ0cUFkNThXZXI2ekJFZlJPb3cyclJBRG41b1RVNWtJZ1Y2?=
 =?utf-8?B?anoyM0JrUVQ3WVN1anZtTUNnckE1SFdPTzhXbGRpMXdUTEZXZ0ZYaGNwRUhC?=
 =?utf-8?B?SmN6U3pEUVRoOEpuYUwyaElRMEc1bFZGWloxa2pNMUp0WXpSTEd0TGRNdVhh?=
 =?utf-8?B?cTVObzRLZnZTOFRXM3RmZWdGOCtYaHkzVGQ0RDF6dmpyQmtTb0pwclVReVRp?=
 =?utf-8?B?VDBYKzNZTjFoL2krMUhqNkcxZ1hVZjdQSjR1UW02YkZVU2djYjUzVUJQbmV6?=
 =?utf-8?B?ZE82Ny9yUktwUUwybDFyVERrdzhyZUFUMThsaU1yZzg2Smo4NkduQUpzOGZx?=
 =?utf-8?B?YVRQRXZabWs2aU5zQmNhRzhLNllzcUhQZGlnZTYvZFN5MG1pWjhSbCtJN1BU?=
 =?utf-8?B?Q2FpRWJtNDBFek15U3VvWGtRSmZKMUx1OG9xVDFEcllrd1crV2tvdGRGM3g1?=
 =?utf-8?B?K1hwYmRlVWtnMC9UYmloeDhPM1pKaVBkTnpZSG1ocUFJelRGaWFwemE4Q2g1?=
 =?utf-8?B?ckhnZjZRSmZlZncvQXNmNFY4OHpuNnA4ZWlUOWxIVmcxM1hVNmRwVWxQVGFq?=
 =?utf-8?B?cE9VQi8rTjJUOEpqTkZoUEVJbWZ6UjNHRVFlUHd0WCtzamcvd1R5UFp3WDQv?=
 =?utf-8?B?NjhmMTN0cGI4S2VSTzcrTEJGanFRNTZNN1o1QUVZRWdoNEUwT2tvZkIrUm5a?=
 =?utf-8?Q?AsjDxoBMfDzjKEleeDIgrvncP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8342f6a-8c69-4aef-5913-08dcd6c0b481
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:33.3667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5UMMIBDXLG+e8hIhj/CwpFSpZDLVQ+Dpl0K2/C7zgH0IIlatG/vdL1ylGs7Xlp4Jpwx8khwHkNnpEQEHJbv+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
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

Several updates to i.MX9 SOC and i.MX93 EVK, the related code
has been in NXP downstream for some time and gone through several
public releases. Some are directly cherry-picked(with R-b kept),
some are modified from downtream.

This patchset includes:
power domain on fixes
TRDC cleanup and update
MAC address update
i.MX9301/9302 included.
runtime detection of voltage mode
PMIC update
generalize some code for i.MX8M and i.MX9
i.MX93 EVK update and misc.

CI passed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Frank Li (1):
      imx9: soc: Serial No align with rom setting

Jacky Bai (1):
      imx9: soc: Mask the wdog reset in src by default on i.mx9

Peng Fan (11):
      imx9: soc: wait ssar when power on power domain
      imx9: soc: Change second Ethernet MAC fuse layout
      imx8m: soc: Drop disable_pmu_cpu_nodes
      imx: generialize disable_cpu_nodes
      imx9: soc: Disable cpu1 for variants that only has one A55 core
      imx: generalize fixup_thermal_trips
      imx9: trdc: cleanup code
      imx9: trdc: introduce trdc_mbc_blk_num
      imx93_evk: spl: update pmic settings
      imx93_evk: Remove CONFIG_IMX9_LOW_DRIVE_MODE and ld defconfig
      imx93_evk: add back Low drive mode ddr timing file

Ye Li (8):
      imx9: soc: Configure TRDC for M33 TCM access
      imx9: soc: Print UID in big endian format for EL2GO
      imx9: soc: Change FSB directly access to fuse API
      imx9: soc: Add function to get target voltage mode
      imx9: clock: Update clock init function and sequence
      imx9: Add 233Mhz DDR PLL frequency
      imx93: Add Low performance parts 9302/9301 support
      imx93_evk: Enable M.2 VPCIe_3V3 and deassert SD3_nRST

 arch/arm/include/asm/arch-imx/cpu.h                |    2 +
 arch/arm/include/asm/arch-imx9/clock.h             |    3 +-
 arch/arm/include/asm/arch-imx9/imx-regs.h          |    7 +
 arch/arm/include/asm/arch-imx9/sys_proto.h         |   11 +
 arch/arm/include/asm/mach-imx/sys_proto.h          |    8 +-
 arch/arm/mach-imx/Makefile                         |    6 +
 arch/arm/mach-imx/fdt.c                            |  129 ++
 arch/arm/mach-imx/imx8m/soc.c                      |  179 +-
 arch/arm/mach-imx/imx9/Kconfig                     |    6 +-
 arch/arm/mach-imx/imx9/clock.c                     |   40 +-
 arch/arm/mach-imx/imx9/soc.c                       |  246 ++-
 arch/arm/mach-imx/imx9/trdc.c                      |  175 +-
 board/freescale/imx93_evk/Makefile                 |    6 +-
 board/freescale/imx93_evk/imx93_evk.c              |   33 +
 board/freescale/imx93_evk/lpddr4x_timing_1866mts.c | 1995 ++++++++++++++++++++
 board/freescale/imx93_evk/lpddr4x_timing_ld.c      | 1496 ---------------
 board/freescale/imx93_evk/spl.c                    |   55 +-
 board/phytec/phycore_imx93/spl.c                   |    2 +-
 configs/imx93_11x11_evk_ld_defconfig               |  126 --
 drivers/cpu/imx8_cpu.c                             |    4 +
 drivers/ddr/imx/phy/ddrphy_utils.c                 |    4 +
 include/power/pca9450.h                            |    2 +
 22 files changed, 2602 insertions(+), 1933 deletions(-)
---
base-commit: 1630ff26cc960439b5949b80cfc604a2c8aa47dd
change-id: 20240916-imx9-update-0ce38f6ccd3d

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

