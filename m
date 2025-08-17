Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F099C8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CABA831BE;
	Wed, 27 Aug 2025 09:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="diy5C4Tu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E428A831C2; Wed, 27 Aug 2025 09:06:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 053CA831BB
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngW9Y80q79iDm9ww/oJX64VqnX2eQXxm5G1Ey/0JL+3OjyvyVQIh5uwOYv7jGjClQkDVs2MxTo35scPmkorGW7S5LQisn81KSckKRVBepgQ7aun1pQCFlG1WY/Ne0eUY4kg+1U1VBTUG50WAuU4+Tv2s0wdyuBJrAA0HAH3vIKJeML+D63ZCKph0yEh3ht6xPXBUyZvP2LN89n0pahbxtqEAhUbHLrzOSPlNfhVn1BcyLhq8rE1OIjPB9XrdV5S0GpG4GFpQhE3XkBfp9qVT8fpckf+BpuS2XENgGEdfKz0tOUOVasFB5v6vNQD7v520wk6oa/rqD99ozZ9A5+yyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIUmnYhyot9YOhPJ3TnJHFO3VlNCNKsx7BAt8OjxFjQ=;
 b=d0YG1VfYmUS+lWLbV5TnlmLPw+zG2G7Eyjgk8K+kS63W8nAXejBGiJUwd5uIMBdIu6oGg3mlI0OfCPy4gYOxyCmQfhsgsh6EMbsUgKPkotOumCG1H/vs7U+bs3ZUl8pQI5BgYV7JEMGWr+KpTmE5c0hhuWijngaDF3DGPvlZeA1KgeNNR8DjvN5f46LCfrqP+G9HV0NMs4ONS0BbrTTx9/dyNZpC4eXlOoDAc3hT0UoZHfE4R3/5UWIAKRLWQXcKaeBT/i9llQCHDq52Im3dGR0GNScH8n6DlTqG/qiHVbQ9gUcMZa+6kaGah6GS8Yj9YF7fhPmrhw3AMHMhSuYjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIUmnYhyot9YOhPJ3TnJHFO3VlNCNKsx7BAt8OjxFjQ=;
 b=diy5C4TuIft2u5v7/4Auni7Ry7iV540RjVWkClI6RHhImPvyZYXHfuNbBUOro50efX4BppmTKOUa/tpej9Jpk8aW07mxv/whJvvPf3kEiIHiIRwcOGYxOe8Kz13S3AelPMKVQzxjCEKT5YbusUv+WkDzCozcBNTwtXeLgm9VhJFUpnDi5uZXoDHIK6j2lDHtBTIuJ4528sSJ3qGHe6JlgPOYMSSEeIz/onq9w13QFXPTxCiH5e+XTD5/KFwiM2tQXcVHRCNCqKjVhxlYY+8SGaPOxcNwQ8r1NghJGZ2jeNOf8d01HR/XaD4hb1ivaFZe2IfJIUgz75ckbHWdGbwiBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10101.eurprd04.prod.outlook.com (2603:10a6:800:24a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:06:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:06:43 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v4 0/2] Restore support for i.MX95 A0 silicon
Date: Mon, 18 Aug 2025 02:01:05 +0800
Message-Id: <20250818-imx95-v1-0-f68a19fe30b6@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOEYomgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nz3czcCktTXYtUQ9PEFONE40QDSyWg2oKi1LTMCrA50UplJkqxtbU
 AZo0YS1sAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10101:EE_
X-MS-Office365-Filtering-Correlation-Id: dac75d2a-3f44-4442-00c4-08dde5384725
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHk4cVdGdC9ibjBvOHBZcEVLTjRNRHpYY2FFanJtYWpXRVpuMk1jUDNkeC80?=
 =?utf-8?B?NmpQNG9sdk9TSWZ4bE1qWVBieHQ0ZHRWM2M5MDNDNGZZK2w1d2hMbEV0bFQx?=
 =?utf-8?B?NjJQZWRjZzUyMFF1bkQ4WWJySWxWMjVwLzJvNVc4bjdMejZTdUNVQ3Bnd1NJ?=
 =?utf-8?B?dGVNMmloVUpKTzdhUkEwSnJTeG45UWdINldYN2RtaEtEUTR1YWxHMGMySVNz?=
 =?utf-8?B?QXlEaDJneEw5WTQ0QnpNNTVnTmMxOTVjbVFpbi9FaE1xTHQvc2VRWXBqSU5x?=
 =?utf-8?B?VWZOR09CYS9EQ0dvalhIenQvRkNkMlkzQjZkeE9GUXZIcXB0TFdRWG9jd3dQ?=
 =?utf-8?B?Mk9uaG16RW00bXQ2VWw1M0hSdnFHTjhDdjdzK1Zjc0xuM2ZuM1ZlMThSU21V?=
 =?utf-8?B?eXJQUEpKNEVpeS9VcHNiRFpHQ045MmRWUTJwR2FWekNTbFdBYzJRek5XdDVU?=
 =?utf-8?B?RzRZV0tqKzdkMmk5TDF6cGIyNTVpekdSaHdzMVBueEduRE5mWlRYRkwySXgy?=
 =?utf-8?B?NzcrWDI0S3l0ZS9OZlZaZTNXQTVYejNBSTBoQ09yUnJtSlZUUEpUS2Uzd3N6?=
 =?utf-8?B?ZVQzaUJpT2VyUEhHQkdOWlhJbm0veDhDdkMyeVo2c2U1dmxOdDc5anZtK1I5?=
 =?utf-8?B?LzZ5YnEyS0R2WE5oRXFPWGliR0swOEVhOHJxWkJrbmdKaHBOZ1RYaitZMEM3?=
 =?utf-8?B?djZBd2xtZnpvcGdUV1BBbGRZajJ2SGhSTjFZN0wzZ1U5RVRvcHh1WlJkQkhj?=
 =?utf-8?B?N1ptendIbHhpY3VhMDA0aWNoTmd5MHZGcTI5bVhYMzliTzFDdVM5ckpqYjQ4?=
 =?utf-8?B?WUlmQk96MzlTTWVGOVRkM3RtZzUxNHVkc092KzFVaERkZlRMM0NZUFFSdGNS?=
 =?utf-8?B?Vm96OXVIZUF3S1BoZnc5eC81WWUxbW1CSU9OOWJjenVXZnhVU0ZIK0lNdEJ0?=
 =?utf-8?B?S3B2TnEySUFtTmoxWDJob2RNTDZ1Z1pwSEZnZ0xHaHZ1TzNSL0pxMDd4TlpL?=
 =?utf-8?B?WGRRK3lSbnE3WXcvRFM4ZmVHUW9mdmwrcFIyOWx6OVQvUzd3aGFOcUlnWUN6?=
 =?utf-8?B?WG52K3crTkd5MGR2QlcvakxEQmV6VHBFSCtIR0xEa2ljakJORkt1RnNMZDBm?=
 =?utf-8?B?SDhkT05HMHJTa0MxMGRrOUYyQzNsbkIyU3duL1VhbWNDT3JEWEFoWkhLWUdM?=
 =?utf-8?B?aTBXamQzS0U2VGZ4dWREbFA1L25lUkhrbDVpYk5PcEs4eFExeGEyYWtjbHhI?=
 =?utf-8?B?aUhieHVDZ2dDc0JrTHVYTDVUbW5KbnZJaWljd1NYTjZIbDlJRytrZktONzh3?=
 =?utf-8?B?TWIraVdTNHQ4VUVPTzNjQkx3cktzcGg1MnRUK0I1em9ZaXZxNkFPOHBQZC9j?=
 =?utf-8?B?SHpqci9iTjdPMVFTb2krMjAzYmVkYzVyQlAxRyttb1o4SDlqZFlWQ29xbjRn?=
 =?utf-8?B?R3dENm4zTWM5c1dJTlV1dzZkK3RCTXJrWjhpNEcwL2s1TzFINFVBREVmdVhs?=
 =?utf-8?B?OU1ZRUFkcEg0cys0RXlQL1VjcEw0a3hzSW5YTmdwdVdxclE4ZzlFR2hhY3Rt?=
 =?utf-8?B?RFZzSUErbmhMdVBEdVhUb2JoSzZUNnpkaEVYeHI1eHlHZUJjNHBhZWdtbXNO?=
 =?utf-8?B?WGJzUFBybWVxc0tHejA1anJVR1RXL3RIT1ZqNDBmekpSU1FTRjJzTFpkcG5C?=
 =?utf-8?B?QTFBaDFESE5DakVZOFE4OVZPMWJLNGhFMmNwVExoTXdrV2xlV3F1VEtaaVBB?=
 =?utf-8?B?RjBvdW8zNTA1U0xSY2FWNFo1UlpoRkVJT1FINVN0b1dWOTdiaklISDZNeGh5?=
 =?utf-8?B?ZFJuK3lPWkpEVnF1VWZvU3ErNGQwSi8wUE5EQXFFSWNhaS9uczJnY3NIUXBl?=
 =?utf-8?B?QzJBUjNTYkpFVnpJekZwQ1ozdm92YXFQK0tPWVVhVXlBRXRiVE81bnZQQmo1?=
 =?utf-8?B?aXlvOXdaZmhGM0c4d253QWp3ZTJ5VFNJZGFOVVdmWGU3M3dpRkNaUmVneEVU?=
 =?utf-8?B?N1g0cCtSZllBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjlyeTZUQWVVb0EvRmFuOGZlWmwrUkg1WDNHQ0NFc1dSdmt2Y1BNZFh0UlFy?=
 =?utf-8?B?TjJCMzZZaWxCMmtkSEtLVTRybDIxYjY2MmN6NXByNVNHay9rbHhBRUdWT0tP?=
 =?utf-8?B?aEFLSk9sV1V0VDVpbmQ0WHdQcmdTN2E2WVRHOW45RVRpcWpyZHYxTktvVXFI?=
 =?utf-8?B?cEt0cTVhdGZrSlcvVVJkckpLZ2F3Y1lMUTRSeGE2aDdZZ1lwSDByUnJPNnZX?=
 =?utf-8?B?OFpYQVRrQ2FPNHFGM2lUZXdpd1FnQm1maFhrcks2UjBlTGNIeEZYc0x4M3BC?=
 =?utf-8?B?ZnVObHUxc3paOGtlUk15U0lZRHBkWHR3cC9vVlFwNDRWTGFIRXpkbEpobHJz?=
 =?utf-8?B?VEpORjNyUWdEbzZ4cnhtMyt5WENwS1p3UHBXaGZ1WmFXVFNLeGxZcnJXMTBm?=
 =?utf-8?B?TXc2MldQVjh6UUIwRUNBWTlmUkhiNzJDS216RXZGTUE5RVUyRUtpSUVKVXQw?=
 =?utf-8?B?VVRYY0xXWmE1dFNTYlBVdlhuWFNnYnNEMHY0VUxTaCtGc3hBbUUwYm9HWmpr?=
 =?utf-8?B?Z2xYcFRzTkM5R1dTTmcwaVArN1ZmVG5Qekt5QmJyMmdReUVGek0xUi9KUk4z?=
 =?utf-8?B?YW5aKzI2ZmVDRXk2OG90Z2didmJqWDBySktWditjSHVYdGxTS1JRYjdLS0Y2?=
 =?utf-8?B?RmE2STdXeUZmalJzR2ZaZEE2WWE4VGhUemc4K0lTVkZUWnVKMndVbndXNGYz?=
 =?utf-8?B?RnNhTjM0UjlnZHRwR1g2OWRaeDc3bjNVU0RoUFFJRnU4d21uQkQwTjB4amNM?=
 =?utf-8?B?ZlRFbjFGS1dGZzRIQWp1cUlIRkUySjFuZkMrTGFERFZRZm5jeldiUlI5ZGt4?=
 =?utf-8?B?NUdMOUVTUHZRZGkyTUVlNG50Rk8wN1RDV2p2L1ppKzNmZzVqZ1Vrc1Z4NStL?=
 =?utf-8?B?YmNSZWJEYzBlQjRBbkFvNUhhOVJDekU3ZTloSU1RaWs1cTROR1lLdWF6Tm80?=
 =?utf-8?B?WEtCUWxtSnNERjN6R0ViS2RoNThkSGNzYkkxSUtXK3R4bDhFUXVDTlN2blBi?=
 =?utf-8?B?T3dBYTJwcitpa21Rd0RoQXdCblo1Z1BVcndyaGxPVnhlbW9RUUxONUREd3l0?=
 =?utf-8?B?QVlpTzE4VUR2dnFWRlhoMVJINytaQzFrb3ZkK1FVRHVpMEdqdlJ4OTgveTli?=
 =?utf-8?B?VjNIc3JHaUViVWcxSGFJekRqRkpOZHprdWpQYkpmUzhKZm9WYTVyQ1laMEZK?=
 =?utf-8?B?c1hIZHR4NWhNc29NYUtVMXhMVU9aNXFOT25Sci83YVRGN0hGL2lwZFBsZWgv?=
 =?utf-8?B?TEZUUTJsWEE5YnZVS3RqcHlRT0lOZURLVFpsU3RwMm52ckZFUEZBYkZRZ1cx?=
 =?utf-8?B?VkJ5V25xRG5pWnFzRXdzakh6RHZ1THFBSjU3dVlrY1JVNmxQRmkraDZXejVs?=
 =?utf-8?B?NnlyWXpPUXlBeHNuR1JKT3VTa0xCZ2FKSWVBcURaOEhRb3hFZUhGdTlLQVlt?=
 =?utf-8?B?WGFLR1U2anYwZzVmT0srbXVLWFFPajQwZVplQ2hMaVhZZzZvOXN2RGJtOTE2?=
 =?utf-8?B?Ni9rYzBFbnNPVzZCZHZQMk82aVNoL1duNVk5a0tGUzlBM3VoZTZXVWNIL0xv?=
 =?utf-8?B?andEaWZhYWFwSHJKL0picURUUlhoSmlRRVhJMWZmZHc3bE45UlFLVFBXMXN6?=
 =?utf-8?B?djFTNG13eS85ZVJKV0V5RncwK2hzeUFrMmhncFFhNDBYcWFWa09GY2Q1QXU5?=
 =?utf-8?B?OXlsaUJBTFN3QUQ5Rm1ncVI5ZUxPR05VN2EvZG9RaUJ0UUhFNUhtSklMNHJw?=
 =?utf-8?B?eE9jVGpZaW12b1BqZmxkTGtveUZoRXRIaHExajRaU1ZXN3JmMW5xRnA5SHg4?=
 =?utf-8?B?anhqNzZscitVZmZlNllLQkozQVpDZWNoeURRSXNGZVhyeWhSTUdJbnJscFd2?=
 =?utf-8?B?dCtyUGZnaTFMbmtVSDRPclFrMW92eVBOQUFnNkNFNmdyOGJCUzg1Zm5ZNnVy?=
 =?utf-8?B?OEYwVEJwb3RNYnNMamMrTmFjbFRFN1NjSENhMWVkWHVTR25iTzF3TjQyek9X?=
 =?utf-8?B?RXBncTY3U1kzNkVOTVNuL2F6a2k1UVdqSVJQQUxEOWdLa0VXTFlMVWpzTGFv?=
 =?utf-8?B?N091cXlTNzNjUXkwTE5tZ0VGeU5tdUF3aFZld1RNYUN1Rk9lNjJ1QmNTVFdr?=
 =?utf-8?Q?b+J9AcBNoxSWudp9EFlRMu+LQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac75d2a-3f44-4442-00c4-08dde5384725
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:06:43.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asJhqq4XbVOSwl5iWhSDJHoqv6FFLQH9/OYZsrdd3Se06isDnALoGTFN7Tfy3jBcqgk9ZdHSrpesVExOA5Nc3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10101
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

Changes for v3:
 - update the binman etype to generate a configuration file and a .bin
   file
 - update Get ahab-container.img in imx95_evk.rst
 - rename configs/imx95.config to configs/imx95_evk.config

Changes for v4:
 - update nxp_imx9image.py and add testNxpImx9Image to ensure 100% code
   coverage of nxp_imx9image.py when running binman tests

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      binman: add a new entry type to support .bin file generation for the i.MX95 platform
      imx95_evk: Restore support for i.MX95 A0 silicon

 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 tools/binman/entries.rst                  |  12 +++
 tools/binman/etype/nxp_imx9image.py       |  77 +++++++++++++++
 tools/binman/ftest.py                     |   8 ++
 tools/binman/test/350_nxp_imx95.dts       |  22 +++++
 15 files changed, 360 insertions(+), 191 deletions(-)
---
base-commit: 3dc5e9a0108bb114175b6362f9cb22367402f624
change-id: 20250817-imx95-8e15ad3a3a09

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

