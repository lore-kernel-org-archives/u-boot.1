Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF207C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 14:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E886883280;
	Wed, 16 Jul 2025 16:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aKgRYjVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAE583257; Wed, 16 Jul 2025 16:44:35 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4700B830B5
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 16:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMaty2YZ7HwcgY0h9vIVp0LQDje3xdSGO1ST5iIWhYflsPDML0quXM3/AMym4J5iPGmYmnF7P7KmrgSgZoziweL/0aIxucllirNuArn1qsessaIVkSZ+S8HPxOsl5PV9j75nWyWC6Sp+UZrCbWEDAEn5Q8ePx+6xUL9ta0cXBJGCZymrOlkto+5PitqzseSw4dAQy2H6rnHNa44K08YxCCs1aA4dC0yPZ4ypzfOVPdsIi+41fpm26QJCE6vd+97J+6T1mNMBpTu0uQFJP8vk9xgUPH5TQpvcgBgAlAYBsDrG0WmiNygFgSSIsmxq5pWBq47NIIlN1cOKa1mGoZyV9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v7AhiIhV18tWfTa+YaOX/4nse7UdhPvXnch8rGd4Qw=;
 b=f45qlOLqffrwB/7RuIPdpGWU8PHx9BmVeZ+7w6m2c3ZAq5rfYaoMOemPJINLwlPkIyRve7uy/Eq0bLQJ7aaqmzztIj16PgAsxhfZMn4jh8fePmuhhqQDSOKC39MUn0En5vLYyeIUbfysCUIRUnDB6K4SVNskbEvR4VVbN2FEzLAsYCAcv6VEwUt56CLR5E4SbYakDZ0wuikf5IVDzW9ePgii+/H5aPj1BvqxuWpD21LP1ZDTvuQzAlUeOaOpdMrmovRlRS5W44fBgo8Wa18CsgtXl5/HtAOIYXNVAYAhYUI+qp2vUd6RE9WwDE9aV2c4xJKqKKPGRFmiWFyE1zn8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7AhiIhV18tWfTa+YaOX/4nse7UdhPvXnch8rGd4Qw=;
 b=aKgRYjVfVwFp9H9/8cX7gYssFIg6wNioaCNf7TgbhtIaKEl74ek6mXYCGqL0Hc2BZxsLNaUArl0RhCKKqQAJUvTvZ/RGdSIMqIB9Gmt0gKfGDVMomcpCJdA7KvPX6iAJaapqV2E4W97K8bxMvfiQ1gNV6KoqnzM6XNMHjDA48B4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 14:44:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 14:44:30 +0000
Message-ID: <dba6cc96-ec9a-4929-aa6e-191287099080@cherry.de>
Date: Wed, 16 Jul 2025 16:44:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl-boot-order: Defer probe of boot device
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250712211232.680047-1-jonas@kwiboo.se>
 <0df75337-a0e0-4076-93db-aa8632e23c8e@cherry.de>
 <13913124-c2b9-4072-b57e-7012b2a222ec@kwiboo.se>
 <9390c906-4462-4e02-83f5-5e7d05dd956f@cherry.de>
 <00bc1039-5163-451b-b3e0-81abb4a9185f@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <00bc1039-5163-451b-b3e0-81abb4a9185f@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0196.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: c61ba187-8366-436a-787d-08ddc4774590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFZNcXkzaGc0Vm5EUzA0anJuNysrV3cxMW8yZTJZZUlmRit5aURHc01tNzZR?=
 =?utf-8?B?RGZIYmtIQVNWYjZhMW9hNXYrbmdQKzRwSkhZMTQ1b3JWMGsxSWxrZW14MXFv?=
 =?utf-8?B?cnBNTWM2UWxRT292THViK1d3aUh0dnVEVUxxY3crOEVtTHVvcG91bXpaZ01W?=
 =?utf-8?B?ZVQrQXFOWkVscmtkZWwraTBST3lHcVV2NElGQkNYQTJWZXBITVlOZjdvRFEz?=
 =?utf-8?B?WnpsWU9iM2hxSEp0RG9VMnZPdnBEc09ucFJtMFZEK3RBUnZPSDZTeEozMHNB?=
 =?utf-8?B?WW1xZEJ1SGUyQnZHSGF4Nlg2MzJyS2thVGJ4dVVJelhIOHNyS0o1WmdKejNQ?=
 =?utf-8?B?ZjIzSlVFNE8vd0s1dzNjamxqSjFJaytDQXRIdlBWVTNhdFFCQ0pnbFhLMVZv?=
 =?utf-8?B?UGRrQXVqU3pGWDh4NXZmYUErQmZ2NnZRdzQveFNWL2I5eE16VWNxcDM5ZTR0?=
 =?utf-8?B?cThoUUk5NmFqRUUrWlgwRUtYS21xNFh4aXN5V1B5dDFkS3d0TjNYVTA2ZStT?=
 =?utf-8?B?TUtoRWxEZTNndkNhUy91bjlXL1ZCRnoxbjVuVHAvQjgySGlpU1MwdzdLS2lr?=
 =?utf-8?B?aDVsL0hMeFJQQkN0YmF2Q0h3YVVPc0IrbmxOb0RUcEZZM003ZTFFRmFLdlFy?=
 =?utf-8?B?bHorZ1RFczBVZGJyNW15bVkvemtZdGJoQ0VNL2EvUVpkZHd2eXFqUTc3eFZw?=
 =?utf-8?B?WHlvNXp0MnhOYWV2azhBZ1dvNTVRd3Rmb3BQNTk1SjBJSEwzaHNBbkZoem1l?=
 =?utf-8?B?SXVWR3Y2OXZ0bGIrL0crSi9RNTE3c0VRYlFXMGYveXNpeW4weHZpT2tuckU1?=
 =?utf-8?B?eTFNVDhLRDVUY0VSZ0FvKzRxR0pjZ2tBZHF6N1VNOUFsK0FnOFlweFVhK1Zq?=
 =?utf-8?B?QUFZakc1NEJqdExpNGlRaFRyM3ZLVFlYT3BYZW00VFBOUTRhZVZwb2lTSnhV?=
 =?utf-8?B?Q3c1TGwrVk9oQ2FpYXdkRlRMK1h1OTBGMkd4cG1POWVFdS9oK1VRTGlFeEJG?=
 =?utf-8?B?bjdrY3l1QnlWZWkrQnlhSmFxWGMybzljalhFT1lmRVV1cS85WEhXRHdsNk1t?=
 =?utf-8?B?NlRBTlRUS0VGWTZlV0N3S2xwK2ZKTzE2Vmh2WGRRUWpHL3ViQnRZOE9tcE5k?=
 =?utf-8?B?UWpoVWhWU1dya3JVam0ycDI2M0tydEpiMDlEd1UwQmFMZnVJcE9DeUlSNW9I?=
 =?utf-8?B?QmVQSUJXOGRUbU93N1hZdHlmWjdwcENJZlQwSWoraENIZEdRMThsY0prMFBq?=
 =?utf-8?B?N0xLdUNydW5HRVRyL2E1Qzg4QTZyTXozT3ZFNGNmTDl4dHJNM3JPN0F3OExv?=
 =?utf-8?B?UXd1YWd0YjBxMlR0YmRneXNpYWNySHI3dmg2aHhDVDBqNndIbTNVcjd2SWZV?=
 =?utf-8?B?N2ZzSk5LQnA3RG5VVVltc0NCRUI4VmNXbmxqS1E5M01GU1VHNXJ6WldGbWNL?=
 =?utf-8?B?eC9HMDNFb2N1bXlucEwvaTYvTGdockNXZjdBT3YyUTdUZ0tWUWgyMlRLNVBB?=
 =?utf-8?B?Vk9DUVorWTdvaWtiekRGMVhSQnZUcXdkd1JreXY3bGJYMHd6eVp3RDZjenY0?=
 =?utf-8?B?VEVSRzFxSFQ0WFE1VHFNWHZZcTEyM0N5UzJ6V0xMcW5BTDQzd0RzNC83TGoz?=
 =?utf-8?B?Rk1VeGNEK0hQS3c0RkRhTVprdHA0WTUzQlpuQVhGVEVPbDUvQUIzOGp5Q3Jz?=
 =?utf-8?B?RWxqd0lMQjZUL0tKeCtsZDIxdE5sNzkzekF6bGk2R1BndEJyZ0ora0VxeVo0?=
 =?utf-8?B?bVpGMmt0V3pjeHJzRkxRZjVUcHJyUG5VY1F6Nmx5Y2dCNWFmZDBoMGNSaDRs?=
 =?utf-8?B?d01ITjQ3Rk1idHlMdzEzTGZ3a1p6WHVGMk94aXl4VTZSU1d2MUtmcDRpcUlK?=
 =?utf-8?B?a09BalNhS3ZuMlN4WUZuWUxKNW0wNTN0bmxvc09qS0dTdEVnanJNMkZpNHNh?=
 =?utf-8?Q?JPHDlbSn+R8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZMWjQ2alRRY0pNQWRKZnp6ZE1adXZjTXBwSnU4dDg4TXRwaFR5Sy9meXp5?=
 =?utf-8?B?MzZEVllzbFZTQ1hCMzZIaW9EMy92NFpBVnlmR0xjQytnaitOaGE1UjYvQUhz?=
 =?utf-8?B?UFllREFDeFZqZVRMUU5wWS9pazYraHZzY1NJSk5Wek9qcTNndDJuQy95QTVU?=
 =?utf-8?B?ME95QUQ2QjRtVmtabE8yNXNnMXgySVdndnNJWk9ydU1zSzVPN2N2N0tFdVNm?=
 =?utf-8?B?VlJnbE5FK1FyQnRJMW1BVFR1TnEwZUJESE9FeW5aZFhaUTVoMVQ2cVZvTDFC?=
 =?utf-8?B?amdzTkFEQlozOHBPa0RUU09vY0lpYWpBaG1yMXVNUmJrbjgwQ2V3ZEczMUR1?=
 =?utf-8?B?T1UxZFR3WHovYTM1a21VTDlxbk8rdXk0eEVwdCtQd0lWMkhscjVJNmJaeWh0?=
 =?utf-8?B?NUpyc0tJL3VocU51ZU93aVUrNjRTako5eUtlblZLMU0vSERRQnRTYlpVdDZH?=
 =?utf-8?B?dFNrSG15RUVOd3FDUjhGT2haTWxEUXdCWjVuaGxKcFFLNmxJY0pLMjNxRXFT?=
 =?utf-8?B?WkJuOFNFMjNXSnMyZDJNeml5UXQ3Z1F1MXVvS0RXSDdZbzlmUWVuNUxVSzhV?=
 =?utf-8?B?RXE2MXN5MTZCUGU5Y2dGOWZOVzBrbXZ4WDIzUEpKRUJkN3Mzb1pHdS9SUXRx?=
 =?utf-8?B?RGZWMjJtR2p4WmpEUm9NRlc0SnozK1lXcEo4bDNOUjJGZklxQjlIVjRWV1Zj?=
 =?utf-8?B?Vzk4Q28xaVNqR2ErRHluWnU5aWJKRnRyalFvVjNqRTRGTEpaVktvUmY2YXA4?=
 =?utf-8?B?NjU0OTRDK1h1N3ZiUktBT3lYS3EwTWJQR2JEVXdqTnozRExCcjhQb0lUdmJT?=
 =?utf-8?B?WDNzQ1ErbkFQQVh2UXBwWVJocFVVa2lRYVl3SGUyQ0F5SVBoMTNnWDk2ajd0?=
 =?utf-8?B?Ny9sbzd6U0NhQWZnZkpvc1RyZDZ2SXFhbkdITTFBZGZoR2pRT29XRzIxbG02?=
 =?utf-8?B?ODFtYVBEN0tsd0hOQUN6UStzSEZiSDZNejNicVZCbTRVOGIvaXpWN3pEbkpw?=
 =?utf-8?B?ZUtGWVpGRjFDSG4vSkhtbUNGZzBwRmZNS053U1lIYUJrUkI5ODJWeUdZTGEx?=
 =?utf-8?B?WVN0U3IvS0lLUi85MGJFR0RETEMwVDFoQklOK2hMd0sxRjgva2J0a1ZLTmlR?=
 =?utf-8?B?L1NUeXFRNU5wWkxPajJlY2F6bUZBVVM3Z1NuUEdDT2tIMVFhY0U2OEhKNk41?=
 =?utf-8?B?LzIvalJYdkZ6TlFsaHo1Ni9JMU5uZWJ2MUttWEwrZnZHaDhGb3BqbDlsNFAv?=
 =?utf-8?B?ODZ6YW9HY2YzOWpxRWZBTE1NelZhbjRta3IvWjZjemlJaGdYSER4b01pMlox?=
 =?utf-8?B?a0RlTXdEeWF3WHJJNitBTVkvdWU1MDZQakhwYnI2SlIxUzc3TmVwWmlBY0N5?=
 =?utf-8?B?RFB6ZkF5c0xqSGVRRk83cDBEU2JOOHk1SCtYOWdhVEJ0bEtGeldlbUV6bDZj?=
 =?utf-8?B?aHNxNFNWam1hWWYrU3VsSTJlNG5aSDliaHVDTTJqNXJIRCtyektVYzlEWUdL?=
 =?utf-8?B?OXhuV2Y2aVgySlNXcHlCRUdkUng2UFl3L2Z3TnVsdm5wYlZEYVdrejZBeDFk?=
 =?utf-8?B?NlZuMUJlR1VLeFQ4MGs3dmtBNENiUU1aMkcrT3pHVUhIZ0lJQmlWUDhYems5?=
 =?utf-8?B?Um55a1JJQ1VLNVQ4U0t3dEszR2RiOWFVUnhGaGZMdGtpUVQ2M0pUNGdCU0U0?=
 =?utf-8?B?R2p5VDFkWi82TW1OVnVzRm9BRTN1WUcxOU05Q0ZpYzg1SEhCY1ZmbU05SUJK?=
 =?utf-8?B?aXY3Qmgzcm9uaWw3bWhRR3d1ZEwva3BwMzZiWlUrcHkwS2QyNjZQK2dtTmRs?=
 =?utf-8?B?cHluRFNXYXFjaHNkWmJZQjJwZndtdkJnekUwRG9kTFc5aWZ0TUs4WjRYbUhD?=
 =?utf-8?B?WXNwQUd2Ty9oNkl3QzloYnA0SWovb1NFZnRvWkRKQWcrT2Y3UU5kZUdPeW1K?=
 =?utf-8?B?eER3L1FIM2ZteHNhbUswb01sbE5Zd1ZaWHNzZTBQY0wwaXIxb3U5Q3l2Ny9w?=
 =?utf-8?B?R0FVSDllVDViYnpCVjkvNlF4Q0RKTUtIRjZkUTlOY3RoRW93T1FCWUZ4ZC9P?=
 =?utf-8?B?QkdROXZxSVM2czJoWW9oaUJoUTRrZU1lWGRVcVYxRnZidGxWUzFxMDRMd2N1?=
 =?utf-8?B?MEtxU2NYY1E1Vlk4TmhoL1kxMUFNVFZVempSR0ZmbGo5Y3JqMEdGTXJCOEZv?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ba187-8366-436a-787d-08ddc4774590
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:44:30.6740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lyNQOTBKHQohobm8R2Z91z1EY5lj/bQwesc+BlD5SKi7J4YhLAzRPeNLvykA6fidgrCAPyh5smVQTDNb8JumVzuCSxJmG8qSZZ/VP1bXA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9754
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

Hi Jonas,

On 7/15/25 5:22 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 7/15/2025 3:11 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 7/15/25 11:36 AM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 7/15/2025 11:07 AM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 7/12/25 11:12 PM, Jonas Karlman wrote:
>>>>> Boot devices are being probed when SPL boot order is determined. This
>>>>> may delay boot slightly and can prevent booting from SPI Flash on boards
>>>>> that use same pins for SPI Flash and eMMC due to pinctrl being applied
>>>>> prior to booting.
>>>>>
>>>>
>>>> How would that be possible? One cannot have the same pins used for SPI
>>>> flash and eMMC at the same time? So that would be an issue in the DT or
>>>> a misconfigured DT for the board?
>>>
>>> Correct, basically there are SoCs, RK3576 and RK3588S comes to mind,
>>> that share/mux pins for FSPI and EMMC. And some devices with those SoCs
>>> have options to mount a SPI flash or eMMC module using same connector.
>>>
>>> E.g. Radxa has a SPI flash module for ROCK 5A/5C that can be mounted on
>>> the eMMC connector. And ROCK 4D has a shared eMMC/UFS connector with a
>>> SPI flash mounted onboard (in some configurations).
>>>
>>> When I tried to boot from SPI flash on my ROCK 4D and was trying to
>>> describe the eMMC module, SPL would instead first probe the SPI flash
>>> module and apply the pinctrl for FSPI func, and then when it tries to
>>> lookup more boot options, it instead probed the sdhci controller and
>>> applied pinctrl for emmc so loading FIT from SPI flash then failed.
>>>
>>
>> Yeah... but that's an invalid DT you just used, no? SPI flash AND eMMC
>> cannot be used at the same time? So we should either have SPI flash or
>> eMMC enabled in the DT and not both? Or are you planning on supporting
>> booting from SPI flash entirely and then somehow have proper load stuff
>> from the eMMC and not SPI flash or something?
> 
> Something like that, some scenarios I envision for future:
> a) an eMMC module is mounted and BROM report eMMC as bootsource.
> b) a SPI flash module is mounted and BROM report SPINOR as bootsource.
> 

Seems fine if the system is booting from the eMMC or SPI flash, gets 
more difficult if it doesn't as we'll not be able to rely on the BootROM 
to tell us what's populated.

> For now only scenario a) is possible on ROCK 5A/5C, because the sdhci is
> currently enabled in the FDT that would be loaded in next boot phase.
> 
> For scenario b) a DTBO or an alternative FDT config in FIT can be
> selected that disabled sdhci and instead enable SPI flash controller.
> 
> Main reason to support something like this will be to use the cheap SPI
> flash module for bootloader and use NVMe for storage without requiring
> a special DT or build of U-Boot.
> 

Makes sense, it just makes things difficult when not booting from this 
external module (e.g. via an SD card) to know if there's any external 
module plugged in and if so, which one. I would assume the plan is also 
to patch the kernel DTB to support whatever is plugged there but not 
necessarily force booting U-Boot from it (though this can be done later 
on I guess :) ).

>>
>>> With probe and thus apply of pinctrl happening later when images are
>>> loaded we should be able to create a single boot image that dynamically
>>> can apply correct FDT/DTBO depending if it was booted from SPI flash or
>>> eMMC. Or for the ROCK 4D case (can only boot from FSPI->UFS->USB) being
>>> able to boot from SPI flash and then switch to use eMMC for storage.
>>>
>>
>> I see... So the point would be to have a DTBO with pluggable eMMC which
>> disables the SPI flash and another one with pluggable UFS flash and load
>> the appropriate one based on the boot medium used by the BootROM to load
>> the TPL? This however makes a fallback impossible (e.g. booting from
>> SD/SPI flash so we don't know whether UFS, eMMC or no pluggable storage
>> medium is provided, no or corrupted proper on SD/SPI flash, how to know
>> which next storage to try?).
> 
> Correct, for the ROCK 5A/5C their DT currently enable sdhci controller
> because this is the most likely use-case. However if the user use a SPI
> flash module instead of the eMMC module (same connector), runtime could
> determine this and use special FDT or apply an DTBO as you cannot mount
> both a SPI flash and eMMC module at the same time.
> 

If booted from that medium, the BootROM would give us the information so 
yes it's fine. If not, we need to attempt autodetection I guess to 
figure if and what is connected there.

> If I am not mistaken vendor u-boot may already do something to this
> effect, try to identify SPI flash and load a special FDT in such case.
> 
> Such feature would only be board specific, and possible may require a
> special boot only DT for SPL, something to investigate in future.
> 

And likely two different DTs one for eMMC and one for SPI?

>>
>> Maybe we would need to tentatively apply pluggable eMMC DTBO, try to
>> probe, remove the drivers, apply pluggable UFS DTBO, try to probe,
>> remove the drivers, etc... Seems very complex though :/
>>
>>> Something to investigate more in a follow up series.
>>>
>>
>> Have fun :)
> 
> Hehe, I do not think it needs to be that complex, but this idea could
> very likely also never amount to anything :-)
> 
>>
>> Don't we need to describe the eMMC (sdhci) controller with the pinmux
>> for SPL to be able to load proper from it? Which would conflict with the
>> one from the eMMC controller's? This all seems to be due to some WIP
>> state, bring-up of Rock 4D and odd HW configurations rather than stuff
>> we should support in the long run?
> 
> The ROCK 4D variant I have come with onboard SPI flash and a UFS module
> mount. I think there may be future variants without SPI flash that
> instead can support use of an eMMC module.
> 

The product page hints at supporting the typical Radxa eMMC module but 
not at the same time as the on-board SPI flash, are you expecting they 
will have a 4D variant without an on-board SPI flash at all?

> Current board variant that have an onboard SPI flash also configure BROM
> to use FSPI->UFS->USB boot order (or USB when MSAK-button is pressed).
> These models cannot be booted directly from a SD-card (or eMMC).
> 

Interesting design decision.

>>
>> I'm still a bit confused by what the plan for 4D and the additional
>> pluggable storage medium are, do you have anything in mind?
> 
> With my current ROCK 4D series only SPI flash boot is supported. UFS
> boot support would be interesting but I have no current plans to look
> into that. Fallback to read FIT from SD-card should also be supported.
> 

Would be, but if you cannot boot from the SD card at all, I'm not sure 
it's that big of a deal? You would only be able to store proper on the 
SD card then (better than nothing I guess, but still odd).

> Trying to boot from SPI flash and then later switch to eMMC was just
> something I was entertaining as an interesting idea, mostly because I
> had no UFS module until one was delivered earlier today ;-)
> 
>>
>> With my current understanding, I would say that we simply should remove
>> the part about preventing to boot from other storage medium as that is
>> the result of some WIP state that shouldn't make it to upstream U-Boot?
>> We can describe the current limitations in the documentation if you want.
> 
> I can try to simplify the commit message in a v2.
> 

That'd be great thanks.

Cheers,
Quentin
