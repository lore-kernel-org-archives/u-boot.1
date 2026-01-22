Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E8CC44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 07:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0559983A6A;
	Thu, 22 Jan 2026 08:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PTXoQlwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD35283A3B; Thu, 22 Jan 2026 08:09:46 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C3780077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 08:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPpaNgnaOxxCgC27s8lsnoj/QLAWRL/LoEuTjp3A0Ze1yqWM4GS6JTu0lU8D7vP+ypuzsz6grmnz8/z3ZAoJ7/FYvI3AYcWDkQ9re2MfQsaUhZ9/WJV6Fuxk1NDMFvlLKXhmMEQqjCoDe4Gci/WTnlXqTKsrX3HiGbGGXgCl9cvBVnZ6AB2QN0IBh+Oy26SLjYLHPytR8Yr0XpeJAvg/jMYcnVDH79S2H8PCBaFKloD4zlhyjgmcM+m9lnIaFGgKHP6QNi9OO3REAHvbHigF+7ctpKlMfctzg9b9/i/zaqxRVQVMdu23NdfVU1phd4bopxNzawJMGdqUCnKWnP3qnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU8b5nmeJ5Eo4tER9oy4qI3lt4gAhrZAb7ZX2loDsFY=;
 b=l8cdCs2RUX1cYbtZ1z7GfKnPUu03k06vaDnJAm3XE2Nc1vGEUaye+Rs95d+YFNxyS0oWYxOuqZkt6heFM2iOuTfoo8xIDagRQgIMXC0CkJHsMTNWcS+se9ldqWEK5czZ0ANQX47K4+umXUunLWzrCLbxco4SzWAJBGcjHMMikQfCJpMkKrMADnNFHt1DEHsNyoFwgqaotfNm6BAgJnn+5oMOVXdZcj9DMiq1Kkul2nOIlBwQ5xFvXGqiHe+YeGVJ7p4uLqfyfcTU1yb9Rr41jdFctOX+WCTC8riSJHqt5uoXyTsRvooLYW5uRa669nmmRwIeMkqWsMTbjJ8rMEmdlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU8b5nmeJ5Eo4tER9oy4qI3lt4gAhrZAb7ZX2loDsFY=;
 b=PTXoQlwN9LKuKqsZkS12uyZF/frXzRTyPvVhHslJ0CuEz2R0J2J+5oYK5Ygw29l/ZzMw4bFXu2UKvTkdMzdXOxWga53uGd7j5g0qC6fzXuWlTszZ5F448aOI8qG3TvDFaWzENkb2Hqk16KyDhstCai68j4692631MqPd8rBmZ5WvfUrB2mAmQD1kNSy6/lyd3b/FCM4wgKBmJ5eCqAAaIXqSOXQCipdm5uTtOptBuF6l+0RLmrZap88yZ/++Ujhe5GLtoSkFRf+vIDqmeY3Smi7eFVQG2lSO8BETyAt6F14CaoT45Ykd7Hq0LbZrJ+EhxR6kb3WYUiH4fNtrFmavCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 07:09:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 07:09:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Leo <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 oliver Fendt <ofendt@googlemail.com>,
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1] mmc: sdhci-cadence6: Fix the license to GPL-2.0+
Date: Thu, 22 Jan 2026 16:24:00 +0800
Message-ID: <176907022016.3206735.1527384955563471085.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112023948.46008-1-hal.feng@starfivetech.com>
References: <20260112023948.46008-1-hal.feng@starfivetech.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: f6527110-c2f6-4598-9d7e-08de59853632
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDQ0K0R0VlE3S2wraVVlVGpPMGdkWXNoSHM5UWN1bUZ2bUNUTTJBOUZPVU5r?=
 =?utf-8?B?T1ZMZXd1cENCTjhHakk0bEw4VHJjNUtNR1RFaVovcDNNQzcxSFBlbFd5Wlhz?=
 =?utf-8?B?YzJpNkVBa1c3N2ZiVE9ReWxiZFhSOGpBeCs2c3ZkOHRyLzgwQmRUN29rb2hS?=
 =?utf-8?B?MTA0SU1PYkZRdGcxc3RoQUNiSkNIQm9sckxTdTlEMUdFQVRYVytnbWd0eklS?=
 =?utf-8?B?WmlLZ2lQZVdKY3EwL1JWbHRPMFFOMEFFS3NRcFRDZ3I1ZzhUaEljYjh5WGxH?=
 =?utf-8?B?cUl3SUhrY0NhcE5KWHdZNFV2USt0RFhpWmQrTU1Kc08yZVFhdzU3ZVJwMEFt?=
 =?utf-8?B?Sm9udDBCcVZpdzdnNkpyaFNlZTlmR2l2VTZNWVo2bG9JM0daSGl5blNlblFG?=
 =?utf-8?B?VDFUTDJ0SEdFOGJKVUhCWnhycy91YXd3bmQvN3RFOERmMW9YcVJoYkNuWlc5?=
 =?utf-8?B?cStPMm9pZnFGN2xIWklxeVdqU2h0V3E3YWVQUW5EcFhVVXAzcmNnZVNDWitu?=
 =?utf-8?B?QVNqaDIxaTNjR3Q0elFkM2RKcXZUWmErSGhhRVZrVXQ2dmZMOGJ6MkxYakh6?=
 =?utf-8?B?RkRWd1BWUHhRYThFUHlUbW9zMFNRZSttNDM1MHd2WGVCOFZBcWFVVjhCV0ta?=
 =?utf-8?B?SzZRMlRHeTByeisybHZqdlp0R3h2aGJhemZtdjBOSWw4Q3MxUnljTGpDNWJ2?=
 =?utf-8?B?S3ppUGE2ZndsbWdNUUdOb1hGRXFEcTNyUkJyeC96NXc2cjVvUWRKN1dwSUFX?=
 =?utf-8?B?R0pMUEhrd2FKZ0lkT2x5WGNFZmhLY2dTU2oxMFRnOVdmVGN0QzdXcWJFTS9M?=
 =?utf-8?B?UjlCRnEyZS9lNlNsemM1S1ZLbGx0UFNncmRmK3hwc2FONDBzZERPL1NFTGFv?=
 =?utf-8?B?S3ZlakpMRTVnaVdSQnpNSUxkQml4eUhjZ1NpbTVxckFxS01CNUJhWVdLcVZr?=
 =?utf-8?B?MkpDdG9UaDRQTmNYeFRJVXFoTm1MY0plSVk0MDhDSStiUE5OU3lGYnZzV1Bo?=
 =?utf-8?B?UzJyNmxiTnlpUlJCVGVDUnZ1bHBuZldWYmc1U3NhUldGWVFsdU9yS2hES2d6?=
 =?utf-8?B?MlBuVjhtdU5naFpheDkyQSs0bENUUDZlWW95eVpIYTkzbzNsUXplem8vRFls?=
 =?utf-8?B?OXVRaFdlRGw0cmlMNHN6aHlrNUhnTDVrU0Fpc0k0a2hDVHIyTGt1N0JRRUk0?=
 =?utf-8?B?OG4xV3BhSHUvTUJZQmVwSDk5S252ekhPWkc0VGI5SGlXc29nY3ZiY0NvRmtj?=
 =?utf-8?B?TVM2eWpoSnpTKzB3cE9RMm1mT3lIMGNVeUEwRDJmSHVjSStPSUsxRnlMSjBD?=
 =?utf-8?B?bS9XV0dvTGhJMldzQ3BVSlhrVCs0VjdIN1dsUUVra01Ya0Job3F3VlZWcXJF?=
 =?utf-8?B?WENtSzVIczErdzE0U3RqSUZqOWZTQnFWVjNLZy9YZ0pOMHcvVFF3Vit3cDFW?=
 =?utf-8?B?bG5heWR3UkVVdXhRVE52MW41KzFvMlhFdlZCZGdYU0w4QnRWaEh4Q2FITkNo?=
 =?utf-8?B?WDZNU3EzVjJxbjRsNmpXRjlleHUwU3VienE2aVBtSmlldWFWbEZJZ2JGZlhK?=
 =?utf-8?B?V1Rtc3BqMnVJa0lxRkxHSG5acDNEN25vRG9PL1czVmdTN0JOWlRXU2VNZzdt?=
 =?utf-8?B?MWZpajdBZm1sbTZHQW5NbitCVUczL1ZzTWE5ajJvdk5iU1pja2tDM21IRHFU?=
 =?utf-8?B?OC9NSVEzVEhtcjhLN2hEdTRnSmhsMGpKMzNTRWk2b0RGWStjRkdGOXIwSWpS?=
 =?utf-8?B?R3FmaTRNZEdINGplQzFIQ1UvODBtTUs5aVZINUR3ckpKanYrRFcvL3UvMzQr?=
 =?utf-8?B?b0czTk9SaFFmcGJlNE8wU2JWSXJnVHdiaCtTNnJ0VW4zVnZZZG02TGR0UVBz?=
 =?utf-8?B?RlBlZFgwcEdnb1o3TE14K0pHVDNTbTNTSXl3cGdweVpjVkNlYmFxRmxWOG5Q?=
 =?utf-8?B?YS9ra3hEdk9Ia1RGMitIbDdIMGdRaTNzOU1IWmF4NFh2c2RBa2RRSitGdktM?=
 =?utf-8?B?QlNFZlczV1BNY0hKUUkyTGszY1QwaloxSTN4bXk0RjRoaDh5UXVRSllWNG1J?=
 =?utf-8?B?MExuby9HODZBZHY5SkVlN25yalp1K05lNjFjQnNiT3dsR2MwSEVlVHZ6Wm51?=
 =?utf-8?B?VzFjVlA0dSt4RTFqelhNUUhzTG5XY25kRURXK3hETlZvdW9TUXBkbkpJYUtq?=
 =?utf-8?Q?eloQGn5SojY2DCdOE31jSCs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3BGbVkwd2xoK1JvdFV5QWxYQmJDUmorNVdsam1DSHdFNHR6TTluQ3BHSkND?=
 =?utf-8?B?dEI4K05IRVowZEJXK0FEL3poTTgvSjcxS3R5VGk4cnh6elBTR3IrODA2N2dW?=
 =?utf-8?B?SjlGa3liN1l3bkVzdW1mRzlBdWtKUUkxcVJaVGJyWUcwK3pnby8vZmtvdFd5?=
 =?utf-8?B?L0xNMVlJekp4VHN1UXo2Y2F6VDBUUm81VjMxcnlWNnp6OWUzYlU5bTdWU1Fu?=
 =?utf-8?B?bUI2T1I4cE9LdTBXNXlBa0lSSnJ6TkxET0swRTNoVXVRdzdkVm8wRFZac2VE?=
 =?utf-8?B?Tndxb2U0Y3lpRGpNWldURGdYaTl5SlIrcGQzVUpBc0hBSHBQWkJqNWhmaGtP?=
 =?utf-8?B?VEdvRDJWVm1SZU9SZTZnMUYvQjkzU25HOFdQZXBEd0dFcW85OEgraUxUSVJL?=
 =?utf-8?B?RnkzODAxajlyQ29sMlc2N21LOW9qOUJpd3ZXR1pKU1hzUERyby9FSDNhdFJr?=
 =?utf-8?B?ZUc1TVVieExJRmVHUGJmY3g0RVAvcHNFcVdiS04raWJaSXcwV1NMSnBrZDhQ?=
 =?utf-8?B?M080azFrRUx2dU41VFBsVTlVQStFajl4Q3NySDNPb1ZBdzRhOWxtSDEzbkNB?=
 =?utf-8?B?NDNjRENoK2tEQWdZQWJDcmpyMTFiSzVoKzJiNTRkM3VzM0U4OGtVRFhKYkxr?=
 =?utf-8?B?d1M4RUVZMDBlSUxtOE1Uc3ZGOXY2N3BDOHdXS2kwMERmVWxoQlovUkxLUmpU?=
 =?utf-8?B?aVB2MStSMkhIbUFFak1xU0JMaGE2WXB1eEl0ZHAyMVNhR2dwTGtWTHBEVjZ0?=
 =?utf-8?B?Qi9ZQUlKMWoyOW5Hc0xub21NUHhDTCtWN3g0TnJDQ0VyeU11WGtyaFFxUEtO?=
 =?utf-8?B?TFIzVlloM2VLTUhGeVc3MEg5b25pbDZ4MVdRQkxHZVB5bXRDN2U1NHBEb2xX?=
 =?utf-8?B?SXVDSFNsblhKQjMwN0x2eHZHVUJMdWFiSzFtKy96WVh0cFMyZkh2aWlOUUxz?=
 =?utf-8?B?R3RtWkF3T0Z4ODJIOENaMTNNOWRnVTBvRFlGN0hkUU1scURLamlDZ3U3M2g0?=
 =?utf-8?B?cTFDTVZncVluRFR5N21xZzlxc0k3MFV0dS9raThGZWFnS2VvbkFmMUcxbzFT?=
 =?utf-8?B?UGpEZTRGUnFyOWZHYkQ2dE5aYXhmVG1VNTJFR0V0elNsamZiaFpGSGJTdUJ1?=
 =?utf-8?B?WTNoVXp6ZzZpTWtkeUFpSi9jNVZxekl1U1RuSy84S1hRelg5elFUWTROaW1x?=
 =?utf-8?B?Mndwek0zQ0k4ZHVzT0szUVpKajlobFl5TkRXSUNCaC9DSkNVNHd4dDQxTkpG?=
 =?utf-8?B?NWc3bm5ZTTc3SlIwSjY2Ukh5alRpUWE5VWNwSmtsOTR2SHZneHpVcktiWkpW?=
 =?utf-8?B?R1VVdElXaU14Q0Era0syUEZiODJQWmkvaFEvNHE3WklVeFl0ZTdjeDFNYlN3?=
 =?utf-8?B?a1daeWh0VVFmQ0ZwZmtHNUdYeW9odGpMODZ1ZnZCQjM0cytGZ01URFIvNmZy?=
 =?utf-8?B?TzhkNUJtem1RcnlQbHViZytiMGhzakpOWTlrZTRESWd4YXN0cDhqeEJta1Rz?=
 =?utf-8?B?YkxQSVgyMDVVNEZrQnVPejdsR2pXRktGd1ppTVpld05ZTlhYbWhKRFlaOWlK?=
 =?utf-8?B?aWZzd3ZwM3pXNmtYL3paeE9hdlkzdG83UGt4TG4wMWhxVW1TRVJaMVZCOWZ3?=
 =?utf-8?B?ZFVUTGVwMFFkZ0FpNEk0cDlzQzJCNnhWS0pDNFYrSm5RY2lXOGR2bDlEQndh?=
 =?utf-8?B?VzJyWUc4SHBDVnNDcUZnOXVrQ2tDWVdpTE9VZkhtV2srbzJkanhuWkFoZS9j?=
 =?utf-8?B?WWdsa0czNW02NGcwalM5MG03TGlBYTFybXhlandmcHRhbmhia0hYUlVGUEtW?=
 =?utf-8?B?bnl1c1ViZ0tMQU8zWTA1am5tMCt5ZklPZG1yOUV3UTB5cEQ3YVVZUmsydEpj?=
 =?utf-8?B?MVRuS2pmN3ZsNW9BdTBGZFE1UEFhK0U3TTNBNzh3NVBtbkQrenVIKzRHRzBl?=
 =?utf-8?B?N1BLeExhbXlIZ1MzbDhJd1NwdkRIck5hZTJWRlNvdXBBMnIvYWdVeUVDQ0VM?=
 =?utf-8?B?aVNJeGxUUU9hYmhiY1pkTkU4OGsxNHlIQ1dpcVFmaFViZVBCVUsxbDl2cU9K?=
 =?utf-8?B?WkJLd21mR2NwSzRZRjFUQWorZlJzaTB1aEFLWUlOeFoza2JkeGVZbkcyaUdL?=
 =?utf-8?B?eExxRTJ0OER5UDgwN0tWM3pubkVndmYrckFjdUxPeUZGR2lIL0dSWEFlQXBt?=
 =?utf-8?B?Mlg5Qlh6eHNUK0lrMUFwZUlQL0NLWnE1SC96KzZkODhrOXRRRjk4bDlTekJu?=
 =?utf-8?B?cGxGayt4NFB5dVlTMW1jZVBBZXRVc3BTa3Q3UmlBeksxZE81R2F6VjRXallP?=
 =?utf-8?B?eUs1K0J1RGFEMDdydGZ6a1FjZzJvVlVvbnhxYzJjTUxubjdQYnZDQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6527110-c2f6-4598-9d7e-08de59853632
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 07:09:41.4924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYkcFCExT0u27kDuWuU7kBJ8aX8qTHgayT3ebFfsYunUuHaxlbGDW51zTtDpJDBzoqlcRz53XYowptx5A92nAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7586
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


On Mon, 12 Jan 2026 10:39:47 +0800, Hal Feng wrote:
> The license of the file is not valid. Fix it to GPL-2.0+.
> 
> 

Applied, thanks!

[1/1] mmc: sdhci-cadence6: Fix the license to GPL-2.0+
      commit: 0e6ed6117552e6b0ba8675980ef9580fea2ae3ac

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
