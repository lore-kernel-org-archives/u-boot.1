Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A20D185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D62684222;
	Thu,  8 Jan 2026 14:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HKipqiMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D50E83B8A; Thu,  8 Jan 2026 10:53:32 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3973E83A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6G/KbLktdFci+UsXCB6GAnF05GyoxbGWmNJWZJ/3eR+G6V417i9aMkAhuir0JcvlLc6niOOHwNFjppgeO7XmmSqzKaABw4XYAX7/fZ/+754q7bAoY/p5OlP8RfT3ovclk6pLjXg0g0fPEtzVxrdC/6zdpUx0yHfv7p852Vm5HfvtjFHqDTbmPe5bNADQhmMrmo7bSP2R2w3EvOQSlOxcwRuaEhRyrMhhPaY3t4tQBpyUNuNdZNLj4DryNLmGSDgqZQ5TCgHR69+Ks3gO7LLdOAiF4KqF/CicTgm/kZw5TeKnJjqd/3in12ZLzWpQ7PUoybxYANeMNYPEqkCEJf4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXGnyeVOtRMiw1AIrtFAIBAJBf85+f6NS1jGJngWSg8=;
 b=CRdM/n8RUOlpp4Ui/hfB0grRZlXIX3nWgu8CLfbYEzgPE5fW6Jf6459oD2KXSTh8I2ZhxGFkXD3Rx1vFBf8r+B/nlJ09NMe+RJfpFZcpI8JUXPoTW2cUuxw6unzlHmb8be5E4GaVwFwmQRvDGUZPpV0AC9qR7ucio2hSzQCgy9KNKJEnjigDzOkx5Gzw2ox41bkpLQX5jttHQXqALhotuwQwWXxwfqSprtJtNwAEskKFMxdsg0ug/H/H56O2LN/gpMX1jNJgrpiho6ZyXY1RpivoRxvmuN8pnQgAjkreZqBYqljHKI8dNc61x1ui4U5dJxdgbvezGuovLnznz1BJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXGnyeVOtRMiw1AIrtFAIBAJBf85+f6NS1jGJngWSg8=;
 b=HKipqiMi8RS9/Nv8bH4YgI/WF8HBAiHuU+oBghoRxQQ+2EjH+jkB4nNKCaQVXJWLSPIaOVoE0lGe05qwBlO0WPVfcBDNtVv4hay1XxCAfuBPx8M8y5ShuoGzUcs2C8sRVJYWHjaD4s1qtF/cuCfB5KC3srR4/sY5uWsEik3M346FU4MQWi36Z+NOdxx7VS7/1F3D3NeTuzfcL/oVvqglmZQfnnpAvSjo9McCbeuNBSe8m1ZGLXSedqCAyvSo69IjFYUna43eO0uk7gUTac+0MIs3eIlvpEa6oMRQNo59gMkfyL5jWdqctghMVQF7nVGXBqCbVMnZ8ThSeFMTgaj0NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:27 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:58 +0800
Subject: [PATCH 13/13] imx93_qsb: Invoke the ELE voltage APIs when adjust
 VDD_SOC voltage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-13-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5048bc-0cf7-4cca-926b-08de4e9bc523
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFFVVzdIb0paWWpiUXpzWWliYzRobGR3WlJNQlNYL21zVFhoMjI5OWxPWmhW?=
 =?utf-8?B?RWJRdXcwaDVLR0xEY1JhTzk5LzFKbjVlVktQKzdld1p4d0xLL292TWxkQVlE?=
 =?utf-8?B?RkVsemtrUmhjN09PSmRZY3V5ZFhUaTNzRGlDSDRwOW95VEN6QkJhRVZMRE51?=
 =?utf-8?B?VlVrQTN4dUhuUGFNdmhNV3lqSXN1L3VOdnpNNVMwRjREVjluR09icDg1bytS?=
 =?utf-8?B?MjA0dHUzdkZQd1NtQVdqbTY5N2ZSNlR2a1JSdkpqaGVPeTFweXlqMDRrb3pv?=
 =?utf-8?B?cXR4cGcwejdNMEZkVFZZeXo3Q2lJSDBZeEM5T284ZVlKRG5YNUtKT1F6Zzll?=
 =?utf-8?B?cm1kTzJxM2VTOTFMNXNtUjdKbHdIQTlTcVFYallpYkE0eGVyZTJ0blBVNzNX?=
 =?utf-8?B?Q1I0Z1ZTNll0bTBmeENMRWc4SjVkRTc5QXltWmhxaVJtT1kxOXhNTmYwcU50?=
 =?utf-8?B?Z0ZzRXpvWisrQ01oUWZFM2FVMTJxQ0VybzduVDZjQ1lIczZiaStrTC80VHR0?=
 =?utf-8?B?eHhMdGkveWp5VnVBbXRrdjN0NGtFc1J5LzVYejluY2Yza1VBRWtZYi9HNDhX?=
 =?utf-8?B?K3BQZlZYcGFVTmJaOEZCY3RYa2poeUNXT2hUTzcrUjZsV0dnYlpxOHhwSUVL?=
 =?utf-8?B?Y1NDaFlkdzgra1dPZ3RPUWpJQnA1WEhEbTljZWhVUlhnc1ZLSnU2UTFVRmR2?=
 =?utf-8?B?aHU0R0dIcVY1STlkck0wV1pXa3pPK09BeHhIK3kyQmhhZzhDZGU4OGhKeXNt?=
 =?utf-8?B?NW43NVRjajd0QUNZb2FVRWVTTFBEL0ZjS3E4cjJNd2tvQzYyK21vR1BCSWQ5?=
 =?utf-8?B?a3hZZE9ZMlZPSUxPMlZxWUtzcExKd0QrR1FDcWZzYVpURkpvRFZSeHpjcno1?=
 =?utf-8?B?aDJ1OFRsUGpiSjhvTUh1akVXMFFmNG5Odkk4WTU1aUQ3NGdGVVJsM0xoWmFW?=
 =?utf-8?B?VkZmWHNycGEwRDJ2OC9ZakJUSVM5WFZwZXFkalIwNDloYXhzV2t5SzhJWExw?=
 =?utf-8?B?Z21BSG05ZGc3Mi9ndjVUNHJZMUh2b1k0eVk1amU0OVJTVHIrU242YkEwaXpZ?=
 =?utf-8?B?TW11dXdXMG1Zc3JGMVd3MmxJZ3B6bWFyRlJYUFI0aElwdDZ6cWM1T3d0UGFK?=
 =?utf-8?B?ZHRIRW5HdnZqNU9XQ0dlbHdlODV0dnAyTlQ5dkduUE8yVlk1THpJbnBWT213?=
 =?utf-8?B?clorQUloMlptQTFYb3psZkx0cFNoVzZNVHlXR1REbHozcm5ZZUkrRGd5bjg3?=
 =?utf-8?B?MTVHd25JUS9Pd1lvTWdWNVVqallUVWZnUXJndmE5VVVpdTVJV29OaVFNa3VZ?=
 =?utf-8?B?cWlWSk9oVi96eUpSd3ZMcThmMGZnM0x0Ulo5UGI1WXhBQXpCV2djVVoxYTFC?=
 =?utf-8?B?WXFCSHR0Nks3SVJWODRyVlJYYm9Fa0NDVTFnb1RLSHhDQ2R5VmhPemY5UHN4?=
 =?utf-8?B?ZG42TFFNN1lQeHFWcDNRcmY0c2lTdjVNOVdDd2FGL0w3NVVIeUVwTE9DT0Qw?=
 =?utf-8?B?M3VRekUvY1RaLzVOL01vM1dGclRXTTdPOS9YRGczN1JpNnQ2aHgyMjZEL0pL?=
 =?utf-8?B?L0hwbXd3UEgrbUNwZXlCSGE0Y2o2T2p3Yy9QcjlJdHZ3NEpnZGUvNkxob1hH?=
 =?utf-8?B?SFhNYkFiditWZDk3cS9udEs3MHFnZjRhT2VJSTEzblBJM2F3aEpnV2lxVnB4?=
 =?utf-8?B?VVZ3YnlzdzZOUUx3dG5Wb3paeTlSKzFTT0J5WllWZlNWS1hNZUdGSVNYOHRa?=
 =?utf-8?B?VDlIb25ocEVLZENtMk40ZWhJQmx1YnQ2T1FVSHFMd21OOTNIeHhLRGZFV01I?=
 =?utf-8?B?S2dyVkZiWWgrSy9sdzJiY3pOTjJFTkQ3WHdFRkRjNjk4NXE3K01VeElhMXFY?=
 =?utf-8?B?WEcvWHdySW1USlowSXF5eUpOSFRMdUZNWFFzL3ZOdzRSajRlUFhpN0JFQm5J?=
 =?utf-8?B?bkR0Y0ltZlAyQkIwVG1ac0xjK1RKWkxnSmhxR3BGbzR0dWlUdFdRaXZkMmxP?=
 =?utf-8?B?RG04czg0U0swMUEyM2VqSHh4UFQyYXU3MGU0ZjRlcEZMdVhjQ29FRmJnUGlO?=
 =?utf-8?Q?v1jEzm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODRScUVXWWlCYk5tWnhRZlNkYjQ1S1g3ZFlnaGduNERvb2ROOGoyd0grUjBn?=
 =?utf-8?B?M29RTklyemJiVkV6SXdLakpBUXU3S3MwV0JWYk9qY2FSelhFWGVRSkdqOE4y?=
 =?utf-8?B?dnpKeWFrb3pFZEpORU1aS0c1MWRrTEJycE96c3lTRmFNSXB3YWsvU0JmS0Vh?=
 =?utf-8?B?dzVEc005VmJrMnBIeHRlb3dnbit6RC9OMUpOKzZpZ01QQXZOaGkvbGgrWDhH?=
 =?utf-8?B?cmpwOXViK3NaYVM0ZXozNWdFUyt2eW9sWWtQRnoyanY2TGhJTFVrZWxBQlNC?=
 =?utf-8?B?YjluSjkxR25sb3RRSitqRW9VdE9JTDIxT1JEdmZJTDB1eUhHKzdWWnNNTGtJ?=
 =?utf-8?B?NklKU1huMFRvNkZOcEdwZVVOV0xndTZiaGQwNWhMRTFPVTcvZXppVWZ0anBC?=
 =?utf-8?B?UHZNek1aN1FJais0MUMwVEl2blA3N3VvRnlGSG4zZFByK2VNSWFrZ1Y1TmtO?=
 =?utf-8?B?aStxc2ZGTjZmMysrWEh6eWxrcWlvMHNtK2cwaEU2RUxzUjQraDhvWTR6UjNV?=
 =?utf-8?B?QnFlNzJvNUZvNHMwQ1pzWmVzdkRINTM5YWI5UVltb2VjSFl1M1NCQ3pYRkhO?=
 =?utf-8?B?RFRRdC9DbkF1a3lReVBLODhkaGpDTFRMWlJYODZBTUlEd0o0a1NaZ1o5YllX?=
 =?utf-8?B?T0F3d3FKYzdDQXpiamZ3QjdRWDhtVnI5eDdmYmJyN2NBbFNYNStsTUswM0NK?=
 =?utf-8?B?OWtaUWg2d3JuZjd0bTNsOWpqQWFkcW90TzBFSjZUa1IwNVJLZXpUT0k5bzRz?=
 =?utf-8?B?OXNQai9UUURJaDlQMDh4TkdqSi9xSmRobkF1SzZOam9CYmIzbEY5VVAxVVVD?=
 =?utf-8?B?NzNORzVDQmJReWsxR2tzckNjdi9xUG1EZ3BWVzVNQVY5ZmRxajczT0JnZ1da?=
 =?utf-8?B?TEpzUjlFWlVxTjNtWDVHbk52SHdBWFhka251T3hTZ0xnd3BoNlR3eTN0N2tE?=
 =?utf-8?B?TW1wanppeEgxeHdTY1RwQTFvQVc0VHd6dnhKZ0dieVdLVlc0clNTR2VZbWdi?=
 =?utf-8?B?eTE3emtJKzlxRHRnYXpNSlJmdml5ZlA3WkRHRnFrNDRqZnhNOExoMXFZWmNy?=
 =?utf-8?B?bzBkS0JtMmNBVm5tNXN2bUJUM29CbzRFTDN0NkJXYTU2VC8yRDZhYjV4L3NC?=
 =?utf-8?B?Z2VtNjFMUmN6RmhQdjNublVFZmVORndib2UzcVBTaXhZOFF3YU9xNkxBQWhP?=
 =?utf-8?B?blljUGxaY0RibStyV2hQVFVEcllnSmR6RVFYMEZ3dDhoME05aGl6M3I3aTBQ?=
 =?utf-8?B?aGNnNFhRbElZM1R0UWI0Vzc2RWJHV0M1MHVmRDR1dzdTK0JxL0ZFQ1IyNStU?=
 =?utf-8?B?d1U4cVVVZ2ptVDg5WmhwdGs1cWtnSlYzUFBjSjQ0WWRoNTdpQ09wQ3ZTdlc4?=
 =?utf-8?B?OGFhSTR1Wk52S09HRjNxMG1LanZJTHNzbXNHNE1kUkJOblg5UnAvc0RUQXln?=
 =?utf-8?B?d1duYyswc1UrbENzNHQvOC9JaWxXOVZiQVBCdVVUNitvTE0vdVJKWXF5bW1I?=
 =?utf-8?B?bU11ajREbFJ1YVpYWHl3dVJsNlQvUXNIWjVyY3lwY0VtYTRGK3ZTMEg0M0lI?=
 =?utf-8?B?YnFWWFJ6eVZ6RlE0bjN3VVJqVDlxK0pZdHZQa2dJY1NrdkNaSUFjcllLc0xs?=
 =?utf-8?B?Z1dDaWs5SC91Nys5UDA1bHpyV3AvWWNkRmxmRnFNSmN2NjFVN3dBTjhLNmNG?=
 =?utf-8?B?R2hvdEE5dzBiNFFVaGJMeEk4OEkzRDhRQkpvZXlIdWhYVWpXR1MrYS81UDR6?=
 =?utf-8?B?c2hwS3VWc0lhU0xSWXZQMmN1YjhsaUluK08wWnN4NUo4UmRtYWxEOXVCRE1Y?=
 =?utf-8?B?bUVHV3MyQ3k1L0VIYURkeEwxNEpGMlhFeDFHa2pHLzdQeUZWTURKZkdoNHdw?=
 =?utf-8?B?SDh3RlNOTWNnb25KTHFtWm5Yb1ltZTRBR2ZxOVViMVBDSnEwczVGMElWVU1s?=
 =?utf-8?B?bVBla3lzclpNemJZRlZ6SlM5TVhjQXU3Z1ZyS3RLSmNOYTVvckU5NlFNTFYz?=
 =?utf-8?B?WStFc2VUZ1hJR2NJNmlNRVhSejlXbTVXOWNCcU9QcU1TZk5BOXEzUTNpbkpO?=
 =?utf-8?B?TmhTdXo5M2h4OHk5aTFoWUxTZCtQVDdSTi9YMXNIOTI0V0E4aHhUWWxLdFJG?=
 =?utf-8?B?QXVUY01jSXp2TUd2V3VhRm8zc3V0NTd2ZTB2Mkg3RFZPd3hyQS9UT0hBMnVF?=
 =?utf-8?B?dW1YYzk4KzFZMWI4Tml6dzlSaEtJeFMxU1RSQ2ZXT29CbkN3c2hyVkNqMzVM?=
 =?utf-8?B?bWF6SmRlaXR2OThJMXpzNUFSV0NWbDl1ek44eUdzSiszc2lTSHVQV0wvQ29F?=
 =?utf-8?B?dzd0YUIyckI5WUk5dGJtdEpnVVdmRmtBQmJDSlAvTGxXU1llL3M4UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5048bc-0cf7-4cca-926b-08de4e9bc523
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:26.8771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzneFI0nkM1aVFCmQuDJkE8tXOE6bljiN29aJM6VnEYO8zyfqZ7lUWTzvtHe2wUqdwzF2K4WybGfcqoJzk2b9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

SPL will adjust VDD_SOC to OD voltage, because some PMIC uses
0.8V as default for VDD_SOC. So need to call the voltage change
APIs to avoid ELE Glitch Detection triggered reset.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_qsb/spl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/freescale/imx93_qsb/spl.c b/board/freescale/imx93_qsb/spl.c
index 7d0f225c9b5..9e64714521b 100644
--- a/board/freescale/imx93_qsb/spl.c
+++ b/board/freescale/imx93_qsb/spl.c
@@ -81,6 +81,8 @@ int power_init_board(void)
 		printf("PMIC: Over Drive Voltage Mode\n");
 	}
 
+	ele_volt_change_start_req();
+
 	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
 		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
@@ -89,6 +91,8 @@ int power_init_board(void)
 		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
 	}
 
+	ele_volt_change_finish_req();
+
 	/* set standby voltage to 0.65v */
 	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);

-- 
2.51.0

