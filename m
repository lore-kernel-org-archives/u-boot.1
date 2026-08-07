Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48D5C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 15:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0C6B81336;
	Fri,  7 Aug 2026 15:07:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WS3shthK5rch; Fri,  7 Aug 2026 15:07:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 721D38132F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786115255;
	bh=5V6giPKohKEhxISnWMukA9QbwU4gP93mbDll51RO9Dc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QmRtu01id0qhxAl01tSooQ7+VFlzA9zOgRWd2Z2LQ0LeR8zSR+ZpxYwgwvxnMHIQ2
	 OQWh8COpiK8BxWfOaC1gTjmuY+KNxsPFqGaigj+iWbLHzhJPzBf8XOQKaahD54rx+2
	 XT0+8dMMNoWbAbDkAmLFZuqb8eZIpLeLN1/fJSYW5C/9irAZ5yfVYgpPeX2st8qLLO
	 /7lQviP5G1QmsLBjELdOCkLF9mmI9BASGuK0CmEO+vsdlMlFvx/hJadv5RmOQTCssq
	 wXlHrozdrLgKXFBONCGxiKe3p8uYJ90jo8yVECzgyp+rcCmSlSxS0Pw9aAD/QGziU6
	 Pgi2F6dPKx82A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 721D38132F;
	Fri,  7 Aug 2026 15:07:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAA95259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEE7360A7B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IbVoqWsBeMWD for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:07:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E1730605CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1730605CF
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1730605CF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:07:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpfoVDorFeO/sn5EAvhnlKcWZGnU9revAXK34UEEJYmO6/8XB9iwh+BEqgUk4pteqKTOR5xv4TlO1iQeKJmuqLMXzCnuL2Qv+fKC4KZVu1gqUTHrc/xXTr4eFnLWy3uj+BuCwaOBKydTbmUOp1nMEuqYNHpVSHfhmF2Ea8e7QWRY7KopZ+NygQTN+HlyEec3f/6Cg1NRBVGp84mbnQF/LwJZUptHRCCEI9DvbBahWUlbcKXz5C4L0xBeD7zZ2JZMaHhEQYHbj72L4rNK52zyok4Cnf3oSGWWOXQPOelu/SJZHj1G29WwdERC/E2gF7i+fI/fQNE9pDBRUGSoqrToWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5V6giPKohKEhxISnWMukA9QbwU4gP93mbDll51RO9Dc=;
 b=jsbow4bkt53j0ZxDqWSnDunqstV+Fuy4GPdLlAF9rwt+8+LVty+w0Mz7r48xAI/TKGNigqXD/DHau6G9FHIzqFA/ybruAYEVwDbupI/BbuhYbJW1WHj73d6wOw8VSFG4CaU0NdrrlvLRabiDw+2ieayqda0BzWhf5oyNNljRGcdOLRl8TdJVbGwwMGs8wEDOE6AnjeeGZ8O3SVkpGLYzPyguDfzm/bT6vB5/vxKMtA8S3pSfR8O8DwzaFbwMo26VIZDuKHJufel/akySatqbeSUUYQgoEMqZIX2DMNr7lENyyOjj9IXfkahhCgVLEiduPw4cdNyioR1fkj3vpMAsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.22; Fri, 7 Aug
 2026 15:07:25 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 15:07:24 +0000
Message-ID: <9a3af141-7a1b-48de-8156-026a09146455@cherry.de>
Date: Fri, 7 Aug 2026 17:07:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] clk: rockchip: rk3588: Fix trivial clock
 configuration errors
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::34) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a353d7-6c49-4525-f825-08def49596ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: /XuXyEg/RLuZ99UB23RaJEFm5SooJ5vlHzBCI7byJoYnsGe/FqtvHjnChE1kZv/TgGgP7rmMHerP/01vUn+hHq4F48gA9RriuDjnu2dAu/CnSEjf2iYXUQbie0pQ50n6Z0C1RmOpn7Ra8K9abBIhs1kCkkXQPe+bucR9qM0Tulo1crx0gMWJCKIV3P8+gfRqk9xJw7viQfe9gYGRzL/HAIWB6sp9ojn263Ubj7ekfoyq+L8fN7R/t8oKDzLHTqkfVOApHxOaKTyxOizHJkHV6iy/gulNEzSImMd71jYjb9H+T4futf1ys9S6zgiFeuuhW/lfKTBgsUAQNRx0iejMaXYhcDsvgRTelKlD3/6ZfzLR5qXaKGta0cA6AkNqNOoOY7sYbWSH2tDBL4a9SRbLUdUVG3GJgoQC71t/1kltsWS252/yZIw9sg1XfiYeHllmuhi4GZ/7DtmWx49EntFZHbu12NO0AIUsxTq1WyiHrGX84Rnc/+ljyYXVo1JXm+Jjsy0ntk5+ZOQeuujIkgN+sDIK0d582jyEMBg0YM6CLjBZDd5lOnzx0dCQ2BLQv5tF+z6iavpMoFT+vX7zSb2tqm/CXOezcXpD1fdMyFOzWNquOUMB5DYiJk6r/rLgm5qCskXSEv5iUPFy4OBaFTY24dMna+qb9/S3Gtc3deBycZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk12bWlnejFiWE5PcmhXZ3RqYm5FdDZSZ3Z5MXJyVS80SVUxTEF3d3JKNUdN?=
 =?utf-8?B?UitJbWppZlpLZ05zYWRGNmkyRHczWkhuQnZMR1RObDBZK2d3ZlpFNlBwL2dw?=
 =?utf-8?B?eE01RjhGZk90M0VzYmdOYjhsMUNSMGtCdmVWeHc0QnFLQzU5UjRyTU95UmZX?=
 =?utf-8?B?K2s5ZTJJUkNvVDc5OVlBbGdBaUZlU1A0ZmM4UmVxejd4UkFwSVRNeEUwSEVl?=
 =?utf-8?B?Nk9VN0NGeU1vRUMrcHBvZ3NBbGR0b3lxY2lCVWY2TExydmhHSlFGbWRwTzZv?=
 =?utf-8?B?WUZ3NlZGSy9IUllKMnJQMGtKRVJqOFZCUkhWZUJYbEhSRXREa2Raa3dvVFdu?=
 =?utf-8?B?SGttbEozNmRPV0N4ekdnYVZXWlhLTXVNSU9CaENUZjJCbVIxWWNTR2VnTjNo?=
 =?utf-8?B?UmEvS2tkQVg0OHpVR1pWbjZ2SHpOaXVWVTd0R3g4aEx1M2pETVg1R2hlM0VK?=
 =?utf-8?B?MEpqR0IvVWtyYVNFZHVnQzNwcEdXMWVzM3RwRkZXLzFjYm9mSG45dE1oeVdu?=
 =?utf-8?B?T0RXU25DeWU0bGpvZ2VINDk4OW1vNDVFNi9kSGs3YnI4SnI1RXZ2ajJJekFy?=
 =?utf-8?B?YkNyZW1Wa2Vhb3JiMUdPN25pU3I4YmZJcVIzZU9zeDdMazdzRGZzWGhHZjh5?=
 =?utf-8?B?aEl2MlQyakVpb3dlOUY5dmV1R1lGbFNidVhXQU1GN1N5NW9aN0d0RmtoOVcy?=
 =?utf-8?B?aGtaMm5YOEVuS2pOeEVHNnZQL2Q0bDdPMlA1dG9RcENWdlowUytyWG80RnZ0?=
 =?utf-8?B?bFJMZ0ZTRG5LMGdQdmJWcWRTSEt6aVpoNnJpdXFRZG5OSmx2ZnVyeTFzcWpl?=
 =?utf-8?B?MUdPYVI5WDB2TWthdGJTZUxEVi9hMzBiMXFSa0xCUGw5OTJzZ3d3NmFCcE5w?=
 =?utf-8?B?cGRtMWpLYTdvNjBLR2dBRHd6THA1SmMzZUlKUHY4M2tobm9lR2dTQS95bGl4?=
 =?utf-8?B?T2JoVVpMV085NWFYYkZ4TGF0b3M5KzFINmgwSHFIdDRhTkNBTnlZclhQV2t3?=
 =?utf-8?B?YndIc29Nb2J0OWc0UkdqbU8vTVJkOW8ralJoTmd0MXAzNEhtalFaZUZXV2NW?=
 =?utf-8?B?WEN6WkZQSnpOSy9BUythNmZEMmRDZFdMcFJuekpQNEhCazhzMElCb1E3T0cw?=
 =?utf-8?B?NXJrQUlVSnV3N292Y2tTM1hnbzBmckE1Mk91ZFp6cFhhNkxQU002c3FWZ1VL?=
 =?utf-8?B?WGtHeDZ4ODh4OFpFZHdSZkhXT29vcXJzSnpzcUJaRFJhMkdZNExTaEVSK2RN?=
 =?utf-8?B?RWZIYlE5eDgwMjFtYldTRGUwYXNPRmJHZFdONXpBMG01THlsaERjZ2dBTkxv?=
 =?utf-8?B?MWVJOEZwZkRCLy9PUWJnUVN6K3MxWUNqZm95dUoyVHRNNGdYOUYycm1EVlZW?=
 =?utf-8?B?ZVpnbnJRWnlOZGVaUUhOdlNsM2hNRElUV2JWaGpsb0RSYjR4V3pyWVk5SlR0?=
 =?utf-8?B?NjZVRk54TnFveXJNaFN0dmV5NGJQWlJXK1Mrc21sSFhObHdmUU9SQ1RFREMr?=
 =?utf-8?B?NGpKWDErUDE3V3BSN3NBbEhCTHlMV1huRFczM01JaitraEZkM3dIS0lSZmUv?=
 =?utf-8?B?TWF2M0tnSUpPTHJIWXpZQWFhUjE3M3ZpRjNheHc3dS9nL3RiaGRublJYUGhp?=
 =?utf-8?B?cCs1UGJGY1NmVk1uR0FGOGVTcW8vNmpFM1JZNEY1dlI0NlNkV1VOVWVRZXlM?=
 =?utf-8?B?UTFyK0xKc3RRQk5oNzV5UjBvY0tSLzBmT1NxRm41aDNHempIaXJJYzVDQzF2?=
 =?utf-8?B?TEwyT0I5TzJLNHNQNHNoUDRSZ1kvMjl2Z2o3OEZGV1ZhRExCbmxoZXVoT012?=
 =?utf-8?B?aWdPbjROUmdxSlBxVTBCM3JHNkowOWZSc1ZhWHRodGE1eXVqcG5DekZad2Nh?=
 =?utf-8?B?ZUxkSVU1Vm51MUthNGxwZmtjQk1MQ0lWckhJOGlFYnQyd2s2eXduVjdXK2Qv?=
 =?utf-8?B?QnBMQTVBNHRORXdDbUx1Yi9ibnBFL0RZTks1bVVocmZoLzVTKzJXUktnR0xK?=
 =?utf-8?B?d0hJay9rYUJoNjQyUmZCQ3BjRCt3OEpoZEpJeFcxOElhZThlMDB0ODhCeDZZ?=
 =?utf-8?B?M2k3TWJaVUJDWDhLcW5MQ0NORGhWU1RmSXZUNWJvaEhQbWhYd3ZzclMydW15?=
 =?utf-8?B?RlZyekQ2UG9oRWVoWVlTb0dXSm5HTW9vNzZHS1ZxWGVrdmFCTVVNYzZvNFIz?=
 =?utf-8?B?a090U1hpZXkwc21MQzUrWC90MCtDNGdlcTJSYW5yRzlSdWp3U1dLOFRJOUFL?=
 =?utf-8?B?VzhCZUZCakp3d3FqZ2lLekc3bzBzcnIvbVJmdGUrYjhWbGprNVZHTlo3bVpN?=
 =?utf-8?B?QnhhalRrOWtiaFlRbytkbTFtcFc5dStUM0tndG5IblRPVFBpR3MrMGVCYWRH?=
 =?utf-8?Q?GC1ms7+Fg0Ymoz46F6krOrRFlynx4d+ioyfmnFUEd3D0O?=
X-MS-Exchange-AntiSpam-MessageData-1: OmTJWFyT0pQyeiI3l70c2oSl9PrHYGcnBWA=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a353d7-6c49-4525-f825-08def49596ac
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 15:07:24.9386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76457+JapOW2OnoBRre1stTKBz/YKb0kGyvOdQ0UQo1/KNrgoZfgvyLavcU2CWW6kivc476sW3zrQSh6yTiGhntWfQzE9YGPpeSmcUraZOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5V6giPKohKEhxISnWMukA9QbwU4gP93mbDll51RO9Dc=;
 b=GPhQ/t7KyXIfDsQgCKnxr4tKqpjqyGApVxnRoDNC9MJe3xpJ+s8sCdjdUXUod2f5I4HOnI727dNHcNjBhYhMzQ3A7UHnjHTI5oe/12krqzoFvQKy20ifj+BncNzSzUOpREbR+2c36bWvwLAvj7qPmSvAwb8Ww2WcLWcgIkd8EBk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=GPhQ/t7K
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The RK3588 clock driver has a few trivial copy-paste mistakes in its
> clock handling.
> 
> Fix the trivial clock configuration errors:
> - remove duplicate PLL_CON/MODE_CON defines

RK3588_MODE_CON is not duplicated. However, it is unused 
(RK3588_MODE_CON0 was preferred) so its removal is fine.

> - rename and use PHP_PLL_CON macro
> - use correct parent rate for TSADC clock
> - use correct parent rate for UART clocks
> - align BxPLL configuration to match other PLLs
> 

Please no cosmetic changes in a patch that has logic changes, split them 
in their own commit.

For the rest, same remark as the previous patch, when you need to list 
unrelated things, you need to split in separate commits. The individual 
changes are mostly fine, see my remark for the PHP_PLL_CON macro a few 
lines after.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  5 +----
>   drivers/clk/rockchip/clk_rk3588.c               | 12 +++++-------
>   2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> index afce8a44af3b..39295adeb38a 100644
> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3588.h
> @@ -105,9 +105,6 @@ struct pll_rate_table {
>   	unsigned int k;
>   };
>   
> -#define RK3588_PLL_CON(x)		((x) * 0x4)
> -#define RK3588_MODE_CON			0x280
> -

Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")

>   #define RK3588_PHP_CRU_BASE		0x8000
>   #define RK3588_PMU_CRU_BASE		0x30000
>   #define RK3588_BIGCORE0_CRU_BASE	0x50000
> @@ -129,10 +126,10 @@ struct pll_rate_table {
>   #define RK3588_SDMMC_CON0		0xC30
>   #define RK3588_SDMMC_CON1		0xC34
>   
> +#define RK3588_PHP_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)

Shouldn't that be PHP_PPLL_CON(x)?

Also, please take this opportunity to actually fix the offset and have 
0x200 added to it already as otherwise we need to write

RK3588_PHP_PLL_CON(128)

when wanting to interact with PHPTOPCRU_PPLL_CON0, and I would much prefer

RK3588_PHP_PLL_CON(0)

instead.

Fixes: 165d258386a7 ("arm: rockchip: Add cru header for rk3588")

>   #define RK3588_PHP_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0x800)
>   #define RK3588_PHP_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PHP_CRU_BASE + 0xa00)
>   
> -#define RK3588_PMU_PLL_CON(x)		((x) * 0x4 + RK3588_PHP_CRU_BASE)
>   #define RK3588_PMU_CLKSEL_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x300)
>   #define RK3588_PMU_CLKGATE_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0x800)
>   #define RK3588_PMU_SOFTRST_CON(x)	((x) * 0x4 + RK3588_PMU_CRU_BASE + 0xa00)
> diff --git a/drivers/clk/rockchip/clk_rk3588.c b/drivers/clk/rockchip/clk_rk3588.c
> index b9fd4bec311b..157a02e011a5 100644
> --- a/drivers/clk/rockchip/clk_rk3588.c
> +++ b/drivers/clk/rockchip/clk_rk3588.c
> @@ -44,11 +44,9 @@ static struct rockchip_pll_rate_table rk3588_pll_rates[] = {
>   
>   static struct rockchip_pll_clock rk3588_pll_clks[] = {
>   	[B0PLL] = PLL(pll_rk3588, PLL_B0PLL, RK3588_B0_PLL_CON(0),
> -		      RK3588_B0_PLL_MODE_CON, 0, 15, 0,
> -		      rk3588_pll_rates),
> +		      RK3588_B0_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
>   	[B1PLL] = PLL(pll_rk3588, PLL_B1PLL, RK3588_B1_PLL_CON(8),
> -		      RK3588_B1_PLL_MODE_CON, 0, 15, 0,
> -		      rk3588_pll_rates),
> +		      RK3588_B1_PLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
>   	[LPLL] = PLL(pll_rk3588, PLL_LPLL, RK3588_LPLL_CON(16),
>   		     RK3588_LPLL_MODE_CON, 0, 15, 0, rk3588_pll_rates),
>   	[V0PLL] = PLL(pll_rk3588, PLL_V0PLL, RK3588_PLL_CON(88),
> @@ -61,7 +59,7 @@ static struct rockchip_pll_clock rk3588_pll_clks[] = {
>   		     RK3588_MODE_CON0, 2, 15, 0, rk3588_pll_rates),
>   	[NPLL] = PLL(pll_rk3588, PLL_NPLL, RK3588_PLL_CON(120),
>   		     RK3588_MODE_CON0, 0, 15, 0, rk3588_pll_rates),
> -	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PMU_PLL_CON(128),
> +	[PPLL] = PLL(pll_rk3588, PLL_PPLL, RK3588_PHP_PLL_CON(128),
>   		     RK3588_MODE_CON0, 10, 15, ROCKCHIP_PLL_FIXED_MODE,
>   		     rk3588_pll_rates),
>   #ifdef CONFIG_XPL_BUILD
> @@ -655,7 +653,7 @@ static ulong rk3588_adc_get_clk(struct rk3588_clk_priv *priv, ulong clk_id)
>   		if (sel == CLK_TSADC_SEL_24M)
>   			prate = OSC_HZ;
>   		else
> -			prate = 100 * MHz;
> +			prate = priv->gpll_hz;

We also have a few cases of *PLL_HZ being used instead of priv->*pll_hz. 
Technically, they should be the same based on the implementation  in 
rk3588_clk_init() but we're not being consistent. In any case, not a 
blocker for this here.

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")

>   		return DIV_TO_RATE(prate, div);
>   	default:
>   		return -ENOENT;
> @@ -1343,7 +1341,7 @@ static ulong rk3588_uart_set_rate(struct rk3588_clk_priv *priv,
>   	} else if (priv->cpll_hz % rate == 0) {
>   		clk_src = CLK_UART_SRC_SEL_CPLL;
>   		uart_src = CLK_UART_SEL_SRC;
> -		div = DIV_ROUND_UP(priv->gpll_hz, rate);
> +		div = DIV_ROUND_UP(priv->cpll_hz, rate);

Fixes: 7a474df74023 ("clk: rockchip: Add rk3588 clk support")

>   	} else if (rate == OSC_HZ) {
>   		clk_src = CLK_UART_SRC_SEL_GPLL;
>   		uart_src = CLK_UART_SEL_XIN24M;

