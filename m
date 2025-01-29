Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB15C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 17:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3C080646;
	Wed, 29 Jan 2025 18:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CS1B6I4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565A7806C9; Wed, 29 Jan 2025 18:36:06 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500E8805DA
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 18:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeGn2rGVDWqU36ebS6EzJtlo8YENQXSjFN8CmWvxo2eW8FJWaD5sC4fMokt6ZeLT2tachl+AvO3Kdr8md/ATeJOpdYgVU+FYFxPGVl/VorMq6+aENqNDL4UPX7S/ZvFbT4b8widoIaXzpI+JIqoEQV3Ol6Wdah+C3aFHipqGLDddeCAMN+X+tjztyWiIB1AkdWLkvs79A9xqjxT7priNBJiyjN/5iZkTCaOlRbLSBt3DddB2+3IaM47Udr6Imhtzj4XX1zZeVXbDkSvgodk6dVFnstQR3Nj+FhwOeaTDejHEsFTJs0dhlyYTsp/1EfoOwnlQFCLZ0SyjarfBGUSwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC7OV3olbt27bfjFauGw23yKSFD0xj8Q1a2htno3clI=;
 b=DH2CIxC2s3Qzpf+sGgOkvjSnIE8R2qgjFa3uZ/lMBCXBg0p8iY+tFPV3h7vg6+RuT99saDmSj/NOTvIA0LN3eqrGwn75ZWn27jcVjvgC9BGfCPZuGJ83c6tq9WNVn+9x38xhp1E5RcwZxbkOGDPjQADJ96hT3lMw/eR6hOmFhCoD/4vTO3KtqQnXMOiyJhtEud631Jw1M+M7tkjU1H78uaFVdlbo1YlwGcPsCta4E8ils2sj9pOnWJDp2SUdOTolnaLuhLIfFw2XO8ssiEeTQRqGDBsVIUwPqvTkOZb4bwCOPhjfFUeYkc2zpHo5IOd58UOYMwN6HqU9PDU3vQXcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC7OV3olbt27bfjFauGw23yKSFD0xj8Q1a2htno3clI=;
 b=CS1B6I4EnyrGpAw5WCtVQdgv7mNTZLpZfalJQUBRgRzAMKcuqFhSBDNkS+6qwxolWHe+m3SbT8L5uMMJChA3xkm45bnfPVCBtg1/8dhSRXDAwwd/6B2g6oF23h0yGOa1WDbwy0R7EwvZe3QsYA4z+4nrXSVNifjGUyuimoQ1RDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 17:36:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 17:36:00 +0000
Message-ID: <19c83083-4887-4a95-bff9-77ec56f47558@cherry.de>
Date: Wed, 29 Jan 2025 18:35:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] ARM: renesas: Simplify board Makefiles
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250129170514.82118-1-marek.vasut+renesas@mailbox.org>
 <20250129170514.82118-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250129170514.82118-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::42) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c5b6f2-8819-4e2c-62ff-08dd408b659b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a251U25KOXV4dVhqU0hmN3d3TlpyTnlmRlQrcmY4UTN6eVhsaGowSEIwR0FM?=
 =?utf-8?B?bUNrQjk1eUp5M2NxVlpTcHZBa3ZjczZndVBKSG1DTmpMMDNONEhzemlKckRV?=
 =?utf-8?B?MHM4L3lDSExzQjZrM3lWMGdwZ0U1c3RaenJuaXlrdmUxWmlCTG9HYThudG9v?=
 =?utf-8?B?RnZibWtPU0RHQnUwbGFlbXdqV21kWmVwRHdhSG1raU1taUxwNlVaV1JzRkVt?=
 =?utf-8?B?SkZlM3dDUzFoTHU1aFFQcFRjYk1McjJSNTZJRDRUc3lYcVpIellDK3RiQUZZ?=
 =?utf-8?B?b1BQK1E1ekRSN3ZsQzNiOHJHUk53L2E3UWVLRUpGSS9XR2JYc0tYQW9xSnc3?=
 =?utf-8?B?aWx1QlU5TmFkYU10UG51MUd6bnlyMSt4MlUxSEdrSWxDTWoxaVpJdU1OODl2?=
 =?utf-8?B?Y21NTktUOFZzVUVZam1CaUNURlc5K1dHN0FyOC85OEZyL3dzMTU4WWVGQmRB?=
 =?utf-8?B?T0t0M0RqV3Q3VnQ5ZEVCSW9Ob3NPeTNtU0JjRVl1SWJLdlNweWRUU1l4ZGpi?=
 =?utf-8?B?NWNVN2FYZzQyU3RRN2Evay85SER6SlJhcU91VkE0dkJmZXgrNjVpSXR2YlU5?=
 =?utf-8?B?aHhBQTIvVlVFL2YxakZjbm4veHRqQWhkS09oWHEvRWFSdEhBeTk0WjVhNkt6?=
 =?utf-8?B?TSs5bWdPaTBtVTNQUS9PaEdtN3hxNnRHbG03dXZyb2NtbEpaWW1NZUg3M0hJ?=
 =?utf-8?B?OGJyNWQvN0FtcTlIVDNjMXZzcmNjVHNLalBKREJ2ZGxTdGZQdE90TFFCNUpI?=
 =?utf-8?B?MUVodEZoVjdvYk4vRmVkaUluZUJQZ2h2VUd2d3ZVNmtGc2NpckJXTCtmQW9u?=
 =?utf-8?B?QllGWTJwS1lycWU5clhIWThrNklRWkpYMEJMak91WWpvdWFrV1ZocGNsNzh3?=
 =?utf-8?B?R2gzZTVjb1Y1NFQ3WXVIY0ZXdnBzb3RxNGlrYWltYVZGTFVSRENFS2JqWE4z?=
 =?utf-8?B?Y1hvZTdVak9aM2FsQnljSWNnQzVYZUhzTTlpNnBWYk9CdFFXNzkrMDZpL2Y2?=
 =?utf-8?B?WlkyS0c1NDNUcFNKVXRmcmxLV1lBQU9Uay94RWdIRkYxNHdLQy8xVGlkNlBS?=
 =?utf-8?B?UEJTcElnSEU3YlF3Z1cyN1c4MWYxSllGaHlMUXo3YXVwUkxCR2pNZXRZVFl2?=
 =?utf-8?B?L3ZhTkN5dXpjd1JPTVZ5Tkc1Y0RBVXNBUTdPNVhxVUp6b2R1L1JpbmE0R3FK?=
 =?utf-8?B?MHhnMm5hdDQvZnh3S2ozRXVtaFUyNW00eHd5U2FFb3R2N3VENVRVb0lTSEE3?=
 =?utf-8?B?ODdja1I1ejJFY3NsRE9jY1VjRXVleW1GVEl4S216VUdTcVQ5ZG1ocWRNQ1RG?=
 =?utf-8?B?ZjlZdlcvdEZvMTI0TzVVTjIycXRjdmpjZUhPakorazk1by9FSk5kczhXWnhk?=
 =?utf-8?B?QmtZMHROQlIwbkxmZFgzRm41MVVLRDNGZityOG55S3JXTjE5TUVIYk1JdUYw?=
 =?utf-8?B?dEY4ZUxyTDI3Z2VoT08xTlRNMmV1SGRLaGcrajZLazRtMCsrbDhOV0Jlelkv?=
 =?utf-8?B?R1lPVU01ZkZSOTRMZWlZMHVWR25hNHhhbHljSG1vODV0TTNQeUxxbkRsd1Iv?=
 =?utf-8?B?ajNtMEswbUl5YW1hS1FUY2Y0Y3lIdlI2bm1pUkdYWVdUZk5CY21DdW5DaEdu?=
 =?utf-8?B?Slo1RTIwNjl6N0dwaEEyWEF6WXBWcis1cnh3ZHpLTEVXVmxhK2tqYWVWeUdl?=
 =?utf-8?B?WkFUaU1vQjhoVmdXaHoyYTh5dTYzU0JCdGhiQ3ZnK01WNjFtY1JRdTdPUmxE?=
 =?utf-8?B?cDdhWnhoUXJiazZDRWNTYUxiOFBFVkJCZjVHeGFyZEFGcjlETFBvWXZwRS85?=
 =?utf-8?B?Rys3SUxMYng4a3FhUjdvWVNITHlJTU43NGM5bkNSUXVwcFptclhOR2ZWWkxn?=
 =?utf-8?Q?upv7aY3Gk7to/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC9tb1hzV24vMzRKeHBVSUw2QUpmT3hXbTlQaVJBclFVV2dNbVZRTGVWMnFR?=
 =?utf-8?B?aFUrdU9ENmNPa2NxeXVnenN5dHRHV1UxMXpudlVBTzVycFdIeUhReG9SMWZq?=
 =?utf-8?B?MUE0bWFDMzIxUXptUGpYUnVoY2dFMDVaZ2lhS2lLaWR6SDc0THd4MHUxU3dy?=
 =?utf-8?B?YXhEYzV3Tks0Q01oSzdZQ29qb3p0Uzdna1U5NVZlcXpIMlp6Qyt3dHdHbVR2?=
 =?utf-8?B?czF0UUVlVjhuRUoweGV3WXYvdTRXVzBXSDJDYlFBNDRSdDVrWWdVZFUzTXk0?=
 =?utf-8?B?MnVXeXkwQ0pYL0I0WXgzY3FhbGJIUkhMb2VqRy9xTWR6bUo3TDBBVExhMGNY?=
 =?utf-8?B?ang5SHZtbm1BSWtUV3BMa0dnOFY2RHMxV1RHaE0xUjRITUxsN3hCSlVBb2Nl?=
 =?utf-8?B?QS9tRWszckZmY0Vnc3BZRUxUdlRhbG90VWRnME4yME95QVlTSCtqOUQzeHJB?=
 =?utf-8?B?M2ZacFdUUXFldFN1d2Q5T0MvWURsTjJRNDFhRS9HNUowaCtScUlhaXBFckJV?=
 =?utf-8?B?bEE4NFdBQldvZ1cvTzR4cDI4SmFQSnl4dTNrV0xkcit5UmlJMUdwOTZ0OC80?=
 =?utf-8?B?d0ZDbmtkYWswSDhtaFRrV24vczgvVUlxZDI3ZUYyY2E0b0VYTjVQSjh3cDFr?=
 =?utf-8?B?YU9wYld6b1pPUE9GNzNTS3RkY3BxOCtzWGN2bzlHY0pobllhREUzcmZMSGxy?=
 =?utf-8?B?eUpxUGVieC9uTUhoUHJzWFRUSmZWTHhYUTY3UnhxYUlwd1ZsVGV6aUROMlRu?=
 =?utf-8?B?MXR4MWF3OFZMWTRrdFpHTFBhMGVqYTlmK0ppRWFhTnVrRExqdnZJd1ZSWWMv?=
 =?utf-8?B?Q0xSMVgzZ3lybVZMNTM5ZEh4R05zaEdnL2FkY2JOY3dGRVFteE9NZW5QVzNV?=
 =?utf-8?B?WXNFM1I4WjFpeTYrUm5PY1VtSGpySGhlTC9hR21GWEU1dEJUQVZqWlI1U0VV?=
 =?utf-8?B?TVBWNXJXdWV6d1k1MXdFTTNvcnR1dkFpS2VmL1gwZExCVkN5TDdteHRyRWMv?=
 =?utf-8?B?M202Y0paYk5UeWlnTVdTQjF5ZWdrNUU0dTdYNkxadCtQOFRiRVZITjU2ZVNQ?=
 =?utf-8?B?TVNVVFRTMDdVZVdiRURKRVA1Z2VPYXdyenkxNjhSTmpGdjhmRGd2dGsrVDFs?=
 =?utf-8?B?dVp2ZGF6RkNjcGRZdEFyOWZEa0ExWUpWZFM1cHVsSmFOdUVJN2pMdHo1YW5a?=
 =?utf-8?B?V25zMm1oazVLS0xNSXNJM25xRGdRcG13T2NSbzAzelN0ZnBQM3d6WW1GYTkx?=
 =?utf-8?B?d3ZMdXJySTEzSGNlT1ZNZ1pmbEhaSkEvcDN1Qlk2UFpBZzF6RTdyTm13SDgv?=
 =?utf-8?B?aGcwWk1HVHZ4SmdKNFd6OERYYWtBTnNRVXlNNGdoUjhxcWJRY2ExaFNHTmRs?=
 =?utf-8?B?TlB4ZGFBcUNlcXVZMlh1WityanhBSE1BdUtMYm8wV2FhdXdsSTR6VmJzT3R6?=
 =?utf-8?B?T1NxNjJDYWdzWjNqT2MwM1hhM3gydmNjZWhlRU5YbXNhd2sxRG9SaExDRTZs?=
 =?utf-8?B?L0VBWEh3TUpSc2o3REtDeTZzYUt6a2RBNVF3YkpZeENCTUtCYXVJUmNhM3h4?=
 =?utf-8?B?VzNCRzEvTFZ4L2ZEeXNiVTBTV2VlVVpUM0FGekV5dnB0a0lybVlla3hLYjYz?=
 =?utf-8?B?cmNnVVpFNWhsenFrVzFzWnBzbGgwUFVQcEFoVVdmenhtYklKQ0xnUWNVZXZ2?=
 =?utf-8?B?SEQ2U2dYelZqYlQwNUg2cGVPUlFzOGxWVkZzRUt1QzZSdTdOMFJJUG1DVzVh?=
 =?utf-8?B?TFhCcjcvdnlHbHBqN1V1UGVPTFA5SSs0UkJnOHBnMEt0TmlQRHRoc1dMTWY5?=
 =?utf-8?B?dkdBSk1pSlhYQzZIaFZLaU5tdUxwc2laRGgya0Rzb1pFYUgrZUh3RFNoRWxw?=
 =?utf-8?B?RCtWQXZaV2c3QWRmK2tiZFlLY216TjdLeXJFR1dLeXF6ZU5seWl2Ym0yL05K?=
 =?utf-8?B?aW5jMm5mUmpodkpDWG1DS0RFRit5a3Fpa0dRMlNCQnJWa2tuK093TGtxbWZN?=
 =?utf-8?B?RllUcENINmVlSU1JM3RkZU9QU2Fmb0JKbEs1NnpJMjFBSGZucDlUNnk2WW0w?=
 =?utf-8?B?Z2hJaVVnbEdEc2dVVkdhRXl4QlVESzhpc2FTS2JrbE1Ba05jZ1BFNFdBSVFO?=
 =?utf-8?B?Q21GOHdOdDNKQlNaZjZjUWZGTmtZWEV5NkYyY01TZitYZ3RrallJYklCeGxw?=
 =?utf-8?Q?g8DtuUPG4jAe4mbwvA8maGg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c5b6f2-8819-4e2c-62ff-08dd408b659b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 17:36:00.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDls90RjCL/l8BYMNJe0Z3IXwc3ZGBmwrZEc5Y3U1iwd+tFKxfctQpn5+/qWeO1S+GvQwB6S2p9Mon68MgmzfhW6ZEmmZqliIEt8w5gMw8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762
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

Hi Marek,

On 1/29/25 6:04 PM, Marek Vasut wrote:
> Introduce board/renesas/common/Makefile and remove the multiple
> duplicate copies of obj := ../common/*.o from board Makefiles.
> Let the build system include the common Makefile using the
> HAVE_VENDOR_COMMON_LIB and build the common objects that are
> shared by all the boards that way. No functional change intended.
> 
> Some of the remaining board files which include board specific
> settings have been updated to use obj-y += to avoid rewriting
> the board obj-y target and avoid dropping object files from the
> build.
> 
> The board/renesas/common/Makefile is now also used when building
> RZG2L targets which also set CONFIG_RCAR_64 symbol and 32bit R-Car
> Gen2 targets, however, this common code is specific to 64bit R-Car
> only. Inhibit the build of this common code for RZG2L using extra
> ifndef CONFIG_RZG2L and do not include any code for R-Car Gen2 so
> far.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
