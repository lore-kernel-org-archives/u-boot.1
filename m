Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD91BC3ABCB
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B7F88F45;
	Tue, 17 Sep 2024 04:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sFlUvKxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B2188F45; Tue, 17 Sep 2024 04:31:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A37B88F0A
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdQoHjh3FIpJGvGi+P5oGS1J0h405ozSEe7bkrWxY0kd+eVmLZ3vHF3U9ZUgicRFvExUtf3Tyj5tTlZsZbG+zd5+JbOPmcmgbLCB/Ss3/C6hLKNdHNPxjM5e4QawOqjK49aT1Z8Vh6xfTxjV4MsWG6tg3CFnXY/WL3NSqJBZyHIazoXDnQPCGtIqyeZMaP1ELXmaCU/AOlgQ/bLtEo6dsqbnrjsAkYVSr7vZA9krbecvlL7KJO35KOaKkGMXojKZT33cc63vL1cACzuMljigXUhGZUphwUBCUyd05YjaBoGIKl9ciDUa5+nGl6v94dPfCGWVW4wlecleE2URfk3+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOzEUvo7I/DFtxEp4b+VsMBd1oJzXLTq02ZgJXwZ6KM=;
 b=XHhlB07l4qcDYYw1lEA7hhNXnRu67N3GOIKGNilZIQdxkw/KtSBQxR5GFltQxQawulXbhRMnEr07528dr5NF1N0rAjko5uhjIDVZELzA5uxLcqKvatPlFHxhknX2tyfreDu3cyv0/8hW4LAtz3/guk/MJKkHsCvKY9amrIBx7M29mxbwMqOtakLsua5R7AWx2Sw7SDrfKRqyRAc2i6+IEz3S0dNoIf1DZwpIOUjMSGEavmtbXhq06pCuR0Gbgu2IVZP5Rk4H85L/FhP5YyVy0Gg6YtheM4n+I6sLD93ctX/PUm32wPRigTItlyYBlymRTZV8G/VoFGHV9zR1PWZ9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOzEUvo7I/DFtxEp4b+VsMBd1oJzXLTq02ZgJXwZ6KM=;
 b=sFlUvKxwiPGmNs8tu0idpP4V7cJBK2VaU2hK46aflcT50wys51ZzjDLaUebUQIxEvMJmuxhmfd82e4kpLTL3CgMNHmzMEDMUeg+cKKxj5l4yjossoV/sZgsub2L4RPnaWKqxK82D8O0PLH6iwK9MilPKjvloS8C25SDhoW4JO94raAs/sAg4chVo4xzmyBlOi9Epe7OZD16BA0sYReM5AyLA/5tHuzqTmGu2ttNjH3Y38hOPbzoEL4qcFKP6tODESPLjtzU7Y/nYnqM7Lv+QcQZhpCeT94MKe8Idq6x/MJXEbhzG0PkD2fcd+4r/DU9p+fEoTVh0DW1FTBR8JmF10A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9420.eurprd04.prod.outlook.com (2603:10a6:10:35b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 02:31:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:31:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:10 +0800
Subject: [PATCH 18/21] imx93_evk: spl: update pmic settings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-18-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e69501-ecc0-4368-6a79-08dcd6c0cee7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SStuYnZ3Rno5bUtLWDViTWl1dkdxUWQvK1ZzQ3c4NDJNYmR6QTR0U2FJNzdk?=
 =?utf-8?B?aW9PTFhZdTJwMk9ZK3JzWFVVQ1pYNjNWU25DK1hHZndubTU5WVBvSnp1Y0xl?=
 =?utf-8?B?YnBQMGtuaitVZXRxMkVzVGZOSHRDNC9ZbTExU21SWGh1YTBqaVBYL2VTRUo0?=
 =?utf-8?B?ZnBkdXVweGlJSk1pRmtxZHQ4UkRwdFRvNWhWZldIT0lJUzdaTW5tbEQrNElX?=
 =?utf-8?B?RXJHOEpVQkdWYTVWZVNueWFzVlZ5K2U0T2x1V2RodlJZeE91SG16SERoTEt1?=
 =?utf-8?B?Zys4aEZwcUFrWDdLYlhYbGU0bUJXeUtCcm9JSjV2SXArTVRVcVVvbXVXSnl6?=
 =?utf-8?B?V1lMOVl3TCtmTm4rL1BWVm1rOVpEMlVXdGQvQUtVWGR6bUpMUVdxUjZUQ3c3?=
 =?utf-8?B?T0hpUWlpK2VPaHRFWHRuZUJLSzU4S0llbVlYZGcvcVhwZVdVMWFMbFVhc09X?=
 =?utf-8?B?eHFXb0VCQTlPdGpLWHgxZ29RL1dXOEt1SWVCUEtEUzd4MzFsRWFjdmxmKzNn?=
 =?utf-8?B?SDJLVmo3L2J1VFJHT3IvNDNwVW1KaS9QcWZabURIMG1keDBEWGQxR1Y1L083?=
 =?utf-8?B?dC9NZkJjaXdMbDN4OHhsWWVLVkU1NWhEL3U2aXNSWkh4M3p0UTB3YWlFRVJQ?=
 =?utf-8?B?dVdWWDJXaUF1b1ZOamx5THJRcGNJSHhkTVNlbzNUVzV4azg3VFdsYnJockxC?=
 =?utf-8?B?SmZWUHZ3VmVxSDlBYngyTnBqMW44SlQ5ZytkeG1rcHNvUW1FbkNKaVl3dWF2?=
 =?utf-8?B?eS9NQzQ0dzFwZXRnM2l3Nm9NYnIxT0dsdHlNMHVQL0J0dkdWdXo5N1BTNEFl?=
 =?utf-8?B?RkFkaGNWTUZzYW5CbHRDckpxc0owRzlCcHlkaDdJR3dLdytIOCtMZU44ZkFy?=
 =?utf-8?B?aE1aVVcxZkVPcW02YlllTC93RGRqUHk0U0xKcVo4VE1sVGlXSlBGalNkUGk2?=
 =?utf-8?B?REVZTEViV0Y0c1hyWFdocjVmNlRuMTIvekQ1VFBoa0NpV3hteFE0VHdCc3FR?=
 =?utf-8?B?NTZBMlV2Q0k3Q0VjU2dWRncxaUdjcCtWbUY4Y25UU1hKK1BnY2tNTWljamhs?=
 =?utf-8?B?L1B6VmFmeHJuTzZZZ2F2cEpQQnRqNXNxSDFmYkZzZFdTak9BVzNqYW5PNElW?=
 =?utf-8?B?NzFBWGs0d05BL0psb1BqMTVJZ3dkTWRsM2lLUkR4ZXdld2dNaTRnVDNNL2dN?=
 =?utf-8?B?NGlGSE9QeVBGSW5tT1o2WjJNcnB0RmMwMEFMV0V5Wi92QWRvY2lnQUM5OFg3?=
 =?utf-8?B?MEpod3pHZ0hJQWtFNVlxRm10YWZkL00yWFAzVkJWdWpaQ3N3VzlPalJrWmRM?=
 =?utf-8?B?TzlSOWtmRnZxaGVzQmZtMVpLYnAralJoRlFGTmNyK0swRjhjWVFJN0hiK3FM?=
 =?utf-8?B?aVlFZFJDOE5XSUdXL2xPRnJoMTdEbEV5QnFuWWhGcnJ4R1J5c3pWbkVQOWdO?=
 =?utf-8?B?cXVnZGFQRktuMXdRYW5ERm9ZNjRlb0lCYmRaVTNUVzVBWUNjZHBiTlArOElt?=
 =?utf-8?B?K3hmcWE2bDBCL0xHU0NVeXJvbDBINnBJclNCWTBQUmdseUNveXU4amdZaFdt?=
 =?utf-8?B?YTJQcDhvSjdVWFlnRVFqWkxQTmVUdlBrSjExS08xVE5JeTF2SmJ5dVVFQzly?=
 =?utf-8?B?WlZyM0Yvd1RvUzZ2ZFYweEQ0VjNMRnBYRUZ0KzlxMEhNOEtSZzQzOFFLUERq?=
 =?utf-8?B?bXNDcDV2c01iSnJnS1BWNXM1TGE3NGxzQlVZVGVGYzBWamIwYlRJcisvMVBh?=
 =?utf-8?B?MGZScU4vTHlMS0pDak5LYUM4LzdWQ2VYdGRpSTNYU1h4T3MxWTVsUGEvaDYy?=
 =?utf-8?B?U2Qza3VsVWZRa0RvQ2Zkcks2TG42UllZSGc4NnJaOUpRQ1ZCNnNXUUhRbTdU?=
 =?utf-8?B?Q2IyOXZQUDJWcUpnUDh5djNnbi9OTWJNSDNRd1lKRVNnMFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JJSU96ZktzZG5aQTE4elYwNUV2aE5jSE5vNWFWL3VUTlJsZmp1aDBpRk0v?=
 =?utf-8?B?WG1WL3FrR2xsRm5keVhuYXQ2VVBWSFBpZElxc3RVY3E5QWc1SnhiN09nN0dW?=
 =?utf-8?B?K2pNWHE2dFI4S09kZUh3VHhoU2ZvcktoalVLaGxDalRQdyt1R3ViTjlGRVhH?=
 =?utf-8?B?TTZSR21UV2NxWlJQYkVQWHk1bkU4WHRMM2ZjcW95dW9iampMc1c4QkJmVkRy?=
 =?utf-8?B?eU5vZkNiM3lUR1FYTzBrWlFrS0ZLR3JBaVNMS3hoS2lKaVNyNmFWekNIQnpQ?=
 =?utf-8?B?WDNRUXgzcHBMNTd5TVlQTmNLNklhYldtazhYbzM4aWo3MkNCS2hxVnNLOS9w?=
 =?utf-8?B?aDFWazhnQUFVREJ2Rld0cjJ6dFdBUVRuWTJLNGNKT0tjWnJ6My9SSFN4aHNv?=
 =?utf-8?B?RHk1OU1HTGJoTjM1SVdaYmJqWU9WWGFnRnZHVHZ3OFh1ZFRSZDVjanVJT1hD?=
 =?utf-8?B?K2pXRVFZZStFb2E0NTdZelBpZFdrVmRVLzBQUzRNODVzYy9yZjg2aEZDWEVQ?=
 =?utf-8?B?R3JFRFFNTnNPTFdaT3lIMll2UmYyTmU3cEFxV08zaFl5L3JjVnZRNWFxeTA3?=
 =?utf-8?B?cXY0cWxGb1dTV1FPSVFCanRMVG5DRHlVSzdrbElHY0N1a05IQ3dxUGUxTzdQ?=
 =?utf-8?B?M1p4ZkZZL2s2WTU1WHNaRlpaczZFRzUwS24weEF3MDZweG1HQmdlSk5JcDYr?=
 =?utf-8?B?YlliUjdSMkczWDBhcU5lWVp3azZuSklBT3gzdzJHVVRHZWcxSTVLVG5WTVY0?=
 =?utf-8?B?RDB6ZWZFNW9tWWJob0l6cno3S2duc1ZCOS95V0lNSDNRNDlCUlJLWTVoSEF3?=
 =?utf-8?B?OTVTTGlGaFRXU0pmeFQ4VHR2dWI0NEgxSHhySnhLdnFOWkJkRkpNVGZLdXk4?=
 =?utf-8?B?V082TnNWQ0hkOWJJMnZWT3VEQ3UyaC9VSEYzK28ySE9iY2pBclNYQzVkdUVZ?=
 =?utf-8?B?SjZvL3NWSmVzbVJUTTJhZ1o5Q2VXM3Y3SFd4VHpPTXoxekozd1VVZHVjUFJj?=
 =?utf-8?B?MFlWenczeXdKSHFvV2ZPa0ZMMDdMQUZiSVd5TGNDS0x0QStTQjFOdHBSbjNx?=
 =?utf-8?B?ZjJRR3NNUXJIQXZvTnVtR04vTTUvNHd1blc2T3Z2dmpObGpRaEFEYW82bk5l?=
 =?utf-8?B?UmoxVFQ5TWZuOWY2WDVxYTRqQ2pDQm11cFM2OWk0S1NKbFJ4YjZBZmtlWWNX?=
 =?utf-8?B?a0JRUEFKTTA3YUxaVHVxVHpBUENVc2VQby81b3c5QU9IV2liR2p6UVVBQ2sr?=
 =?utf-8?B?NzNaeXNPWE52L2p1dzVybFlmUkxlNXQ5RW9lRnhiVXh4Unh3WVAvWTNjdGNU?=
 =?utf-8?B?R0tiR2gzSWZNb1BOL1YxemltQzh0VFRuWis5YTd3ci83MzZKWWlXdnIxUFNy?=
 =?utf-8?B?czhsR09DMVpHME4xNE9QM2FMN1QyUnBsODNscW43cVJFUyt1N254NTJTNnlw?=
 =?utf-8?B?eGJkVC9sdmorc2dLbHlUYzNjQ0IyalZCOGlvcW82QzRiTFJYTlFLS0NSM2s0?=
 =?utf-8?B?cjNBL1JlclloWW1vZ20yTU9ZZk9Yby9kTXdYWGVvRWFjaUFqRnpkRjdRbmYw?=
 =?utf-8?B?d1l3dWJtckVrNEhWQW9xZ2xzSVZPZWxaaHIvem1hUmlnaVZac1dDdnVZajV2?=
 =?utf-8?B?MUdOWTdwQ1F6V3h0K09CR0dndVplWWdGemZNWkJlclZ5V0NlQzgxdE9vbXJG?=
 =?utf-8?B?Ym9tbEw2bDdRWVZ2QWNPY1FXUUpZbXBIUVJTdjB4ays4UzFQcytVU2E5V2Y5?=
 =?utf-8?B?RlpheStzMUNHVGVDdjZDcFRLSEwvLzhndE1ZS2tDbmFwTzM2V2c5d3N0aXNH?=
 =?utf-8?B?VndRbWtUNjYyL2Z1NDBSMWc0NVFYc3pzdk53V3J4U3VxNTV3a0ZaeUtnNTdl?=
 =?utf-8?B?dXYybjNQWnhEWDBzV0F2QlZ1d2x6ZlRGSWo1UHNYRlNCTFRnbEJMb3BuTHl4?=
 =?utf-8?B?NjZqYzhrVEN2anRYOVRIaElyV0F5elgxS2I2VjVjc3AxV3hZRWgyQUtyeDZD?=
 =?utf-8?B?ejBVRTJVUCtsdTQxdkR1VmkrREdlS2g1R1Jwd1J2UTFjZG9iTTA4TkR6blZk?=
 =?utf-8?B?a09ScThRVjJYTENUU3ZPOTBYQkFIZW1UOXRpN0JFY2gyOU53K1hiYXdPcGF4?=
 =?utf-8?Q?b1PQkvjvEr61MMczbGe85Lts0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e69501-ecc0-4368-6a79-08dcd6c0cee7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:31:17.3733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcabYFOofDCh6YOZpJ/c3K2+0LIv0YbG178J1Cu/psr3GHKg3Yd051ElZ5Dg4TmkfG8A91maFBJHNCLNZhY7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9420
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

1. Use runtime voltage selection for LD/OD/ND mode.
2. According to latest PE/TE report, the voltages of VDD_SOC for
   LD and ND mode need add 50mv margin, so LD voltage is 0.75v->0.8v,
   ND voltage is 0.8v->0.85v.
3. Use TOFF_DEB to differentiate new trimmed pmic and old pmic

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/spl.c | 42 +++++++++++++++++++++++++++++++----------
 include/power/pca9450.h         |  2 ++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 2ad7489ada7..503286ce3af 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -62,6 +62,7 @@ int power_init_board(void)
 {
 	struct udevice *dev;
 	int ret;
+	unsigned int val = 0, buck_val;
 
 	ret = pmic_get("pmic@25", &dev);
 	if (ret == -ENODEV) {
@@ -77,20 +78,41 @@ int power_init_board(void)
 	/* enable DVS control through PMIC_STBY_REQ */
 	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
-	if (is_voltage_mode(VOLT_LOW_DRIVE))
-		/* 0.75v for Low drive mode
-		 */
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);
-		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x0c);
+	ret = pmic_reg_read(dev, PCA9450_PWR_CTRL);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		buck_val = 0x0c; /* 0.8v for Low drive mode */
+		printf("PMIC: Low Drive Voltage Mode\n");
+	} else if (is_voltage_mode(VOLT_NOMINAL_DRIVE)) {
+		buck_val = 0x10; /* 0.85v for Nominal drive mode */
+		printf("PMIC: Nominal Voltage Mode\n");
+	} else {
+		buck_val = 0x14; /* 0.9v for Over drive mode */
+		printf("PMIC: Over Drive Voltage Mode\n");
+	}
+
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
 	} else {
-		/* 0.9v for Over drive mode
-		 */
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
-		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val + 0x4);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
+	}
+
+	if (IS_ENABLED(CONFIG_IMX93_EVK_LPDDR4X)) {
+		/* Set VDDQ to 1.1V from buck2 */
+		pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x28);
 	}
 
 	/* set standby voltage to 0.65v */
-	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);
+	else
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
 
 	/* I2C_LT_EN*/
 	pmic_reg_write(dev, 0xa, 0x3);
diff --git a/include/power/pca9450.h b/include/power/pca9450.h
index b8219d535ad..f896d829d37 100644
--- a/include/power/pca9450.h
+++ b/include/power/pca9450.h
@@ -54,6 +54,8 @@ enum {
 	PCA9450_REG_NUM,
 };
 
+#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
+
 int power_pca9450_init(unsigned char bus, unsigned char addr);
 
 enum {

-- 
2.35.3

