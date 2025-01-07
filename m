Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6442E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 06:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B096B8060C;
	Tue,  7 Jan 2025 07:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kPB1YiRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6EA680634; Tue,  7 Jan 2025 07:59:10 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 006EB8060A
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNG1Qpoum5cCBarxl4ezhglBFPl2FGWsFvo1tOU0to1HZ+6RCOXXYdBlPQOR9ZI6AQgRyJWQwLf7YislffCotgsfG2UA5PszrOKLqmqMQShVr1P/GFKGqydn6GwcS3qL976QJMIQN5Dmfjy2T+5vhoRe1IRbT8gACnVz+esaBbgaW6eRBmkjeQO2OvrgPbdxaGGlRsuh62O5qLe0afL/0DM+Mg5Slq0Ec0pot9g64UwPUaSjhJKT8oBLzlm0X7jnGWkFW1XCt8q4ZQ9uRM/WyhI00z0NERJWZ5iW5M4PCaN1TsMOXWjMswT9a1ePmFZVNjnqam4wqQcqlVkfo061FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffrfmx6MiKX6+wzlQ9UoZMbr89Tt8EK9U1+Ps/iNe3Q=;
 b=aislSyhI9Pw2qZKYqaXxCwLjyzmeJMEKMy5o61OaKfiVMedW/yC9eSPWBElfCvifrMRO5MmqYsYerV0wn0nyZyL7PVGM6kjtnAJrBfirKFCwAAQfaGsqjbHjUs+scdRZyDSFUcqEgb33qd+vibS0xayQrUOaio6XDDJEpMmdnfJgeLOFUM/j5ZChVg5jE+DnFi2GUTggCiS9lRX8Uof+h+yOGgusG1017gXuG4K+AybZbSDhS6S1xFBtWKZosWQglO2Gx+GsRFaa3Yd+nFrUEJrSylPa0Fj3kM11kfFbtBwcxCzvT2kau2UONhnay0Q1ZCvBvy627yMbpi3igHADxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffrfmx6MiKX6+wzlQ9UoZMbr89Tt8EK9U1+Ps/iNe3Q=;
 b=kPB1YiRhTb5IoC0RlKxzHE1UZ6zJof/HD4ZohQZVALuDerorGSrguksmEs2xfDCbCrcQw31OJ1dwASJMWhI6/coN14Zh45jugVQf/1SpEKoLaPd9ZsRvFVKyDj59kewUZSqgTq0euMTySWALFsBuqP6KtQPPURsR5qjzAlFLsIPHejGYQiWyA8Q3rA4qcht6TGEjhWJ1/WAK8+EQrbMbghfMBn/0pF5eNv+febSkDLEF+uQmkI3I2Uez8/GC5nrvGOtQ+kQylD4Lpa5vVWWS8F7DleHk2r8CMFZrs+YkXUGjUcyZpFJ+ELoD3EqafLHIg87kPXo1x9g4IEjUzLqN8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 06:59:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:01 +0800
Subject: [PATCH v2 01/16] imx: imx93_evk: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-1-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: ea638368-e759-41c6-0e97-08dd2ee8c3d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVRJMzZpK2VNMVRiMXk5bnQzVDl1bzlPa2tucHY3dE5HSTA3N1UwR0R5THJt?=
 =?utf-8?B?WXZMb1VwanlyMFhWV0c5QU5EcXErdm9nYjdYa2FnT3o3OFFTemRpTVRlYjZw?=
 =?utf-8?B?bVRoa2dwQnNpRWU4N3NNak1MMkRLQysxeTNucW1nOGlYcjdQb0pwbjFlanQ0?=
 =?utf-8?B?Q0V4K2p6NlcydWZVTldzMmlMRk5YeHI2Z2lJL01GbXFNRGRXbDh3ZlB0UWhr?=
 =?utf-8?B?NHIyY1Y5V1JMdXZzcVZoeEpIVW01UDAwRzV0THhWOWNFVVBLdW94aWVodEJK?=
 =?utf-8?B?aFlEem9jSTd4Y1BxVkdqRWYwSDZoS3pKVU43eFVBNUFPWmV1Q2Z2WmFhN2FG?=
 =?utf-8?B?eldEM2ZCQ0JPaUlFRjRIUWdxbzA1R2dmNFRndjJ2ZEIwbXNKbFVUMEo3SGVC?=
 =?utf-8?B?Q0tVZDl4TXJ6ZHpiOC9hc0trV054MW8xTXg0NlhWNEE5NHhwK21Bd2VRZVpJ?=
 =?utf-8?B?ZW5jU3FrcytEQmR2MU1GYmxjREJNUlZJY29aTnByOFRsME1aTmthRUZKRkZK?=
 =?utf-8?B?OFhkNzdHT01pbkRaTkFEcFo3T0g5aDErZ0RhRWoyZ2JRYU91VkRKWENCUE9S?=
 =?utf-8?B?bysrSU9wVmRTUFBhcGhiUldCcXFKOFA4UXZNM1NYZFlQdDhlTnc5MHZxL3BG?=
 =?utf-8?B?dzUyNWtaS3hUSUJZbjV3TElQKysvcUNhQ00xK2h4WnRneDlEL0drbXYwRytD?=
 =?utf-8?B?RVFmMmlKRXRFV2NXQmVhQjhYM1p6UC9LVWlUTERlY2dBZ0VDVE5QZnU3cmhz?=
 =?utf-8?B?OXI5aldGMTBoUXYrYkVSTEpCWGRXR2pOSk9vQnJ0dGV2T3hNSE1DS25xNWQy?=
 =?utf-8?B?TTQ5bllSU3pHb0txZHExcmExcnd2WDF6dFZGeENvQ3MxdVpjTS81Q3FtU3Bu?=
 =?utf-8?B?OWhaNDMrSGE3UzUyQ0dFVFhVZGRzVGV1MS9HMlFFQmgwc2lsMnRtYWk4VGxh?=
 =?utf-8?B?OHRKMjBQMGFhcWlicnhLNDhnUUN6QXB1VHFtOFY4TGpTWGplMXUzZ202ZDlw?=
 =?utf-8?B?WThKNnNJL1N0bk5QblVyVTE2YmxYSllLL2IwS1lLbXhBdDNiS1duQk1KM24y?=
 =?utf-8?B?c3hxa1ZseloybDZDMGZZenR2ZWtNTU5zb3lNT1RaYVEzWUVBbUkxVk90VWJt?=
 =?utf-8?B?S1RnTG0zQmowY3J2dTZBUms4WEVaSTA3WlViVytETnl6cXhuTHczMzRCL3FZ?=
 =?utf-8?B?bUVQMFBocmh4Y2J3M1RLbTFET2VYZVQrczFkeFhUQ2xsUmVhNkRwS3EzUjN1?=
 =?utf-8?B?andSODI1NVZLUGw4UGNKdmgzcmhPY0xlKzV0YVArZks4SkU5UXBqS2QwSEJG?=
 =?utf-8?B?NzNubVNkdHVpdjY0VGZ6am5nZjhwZUhwMjBGR1RJelg1YkdUeDRzaHlWbmo3?=
 =?utf-8?B?NzBCeWRibGx4dDk2bXRDZHNyVkRpSjMzWjBOT3BPaWpFSStaZDRZNE1CVUdY?=
 =?utf-8?B?emFpZkd5NXRqM0J4K0V5cU1KYVpFZzFzbk4vN3hjSVFueFFzdmc5VGQ2bTBR?=
 =?utf-8?B?Yk05cWtNZStsTkVIb0thODF5Y2ZGamNXZVNydlo0VjZrZm9meStWVnZSQW03?=
 =?utf-8?B?NkI3cmJPTDh0cVFMV3FFem1vNkVudTV3R3VBSGQyUkpOZVlxRFdpSHRBeXZ4?=
 =?utf-8?B?SGdRM3g0TDVTdklOSW53ZXRDUDVvYVNTNXhvUjN4MUVXWC83aTk3bU9Sb0pV?=
 =?utf-8?B?ZGFka1AwamtFY3cxMkVOc0FRMHQxRWJkejBGYzdYRnVzSXRBMUdTaFNxcGky?=
 =?utf-8?B?bkMvLzhaWUhWQWNPRzBDUU5nZGpvZnk1MnpZcGdPZGthOHFFZnBpdVVhcTUv?=
 =?utf-8?B?aUdLeW5PU093WTdYQisxZlJacVJLeXMrbXhJV3dQN0tBWXNHR1F3aHluNVlZ?=
 =?utf-8?B?djRKSkRWcGlaVlcwbEdmSGgzZ0R5VmIyQkN3Wjd4Z2RQenJTQW84Qk9UZ3F5?=
 =?utf-8?Q?4ILlKwCIK5HUU9SiWkGh/2KU16P73rHs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2JnMWFFRDVYOENKelFWVWJTNldGcmdSenpVeGF6S1h6OXMzMEpodHJjNlg1?=
 =?utf-8?B?Z2dYV28wKzVWczRIYTVZYk5QUGRjcCs1d21qdEc1Ymt5cHNaVzZKRkd3bjZU?=
 =?utf-8?B?STBGbW15Y2RZMHRCelhOSTcrMEFlL0V4eHc4Ly85K285YzZjb0tVTC8rSDVM?=
 =?utf-8?B?VFZlNVZtanBJZjVBdGR2cEtiY0p2WXR4dW1XMEhiM29xSlBaV2J2S2dIeFBU?=
 =?utf-8?B?cWR2djJSMUd5UnVONzV5amRibEpFZzArK0lGL2RjRlV1Q1IzaWZKQ0t6K1g5?=
 =?utf-8?B?UHBnMXFwQUxNUUlEaVcxMmVyVEpZQnZSU2ROSFV6TjNPK05mZlNJKy9lYXQ4?=
 =?utf-8?B?V0JFc3JxVXhJMndRTXJkODE0QWdjOHkyUDNuNkFkVXIwVG1DOGxWdmEvQTlZ?=
 =?utf-8?B?UDhDY21UUjBIMEJrZ3pGdEUrallBUjB0TU5seEV2SDhEbG5FWHByRVZheGNj?=
 =?utf-8?B?ZU9oR3JjRkNXNWZyTUtuQ3M4Uk16OEVidkRqekw1Qm1BUUFXMHZ0Z3RDU3Ft?=
 =?utf-8?B?cjdPblBPd1ZCNVIxcGtBOXlrQmNFSUh4VVQ5dHZid0p4b1VQYkQ0cVdtRk1p?=
 =?utf-8?B?azFmK1c4N0g2Q0xiM1ZVVEJHV29ZZC9IV05OaUF2dFI1Mm80MkkrcCtDYkhm?=
 =?utf-8?B?S1R5dTg5NTlMMlNZNkRvNnBCam4rT0VjTkpZSUZsVW82dWFQamc2ZHl5RmZl?=
 =?utf-8?B?OE9RblNqb3pGaEViTW1DSzVFSmdqeVVFdnBPM2hONzFhVUxDN091dmtnZDRJ?=
 =?utf-8?B?d1gvWXZjWkNSc3dGVzNSZmlrREoxajE4Nk1ZaTNIRUo2ZXV1UUJXVEMyVXhY?=
 =?utf-8?B?VHZQbGJpQ2NKMHJGSHFyRGRJS05SbjhxckxSV2orOElNNzZhNnd4QUlwd1hX?=
 =?utf-8?B?Z2hoRm9HRC9RYVJ0WVpES0xpQlZzTDRBTUozUURMNzJFUDR4U3Q0aU01cUtw?=
 =?utf-8?B?N285ZXFsTkxBUDhzOXlpM3VKWFc2eEhnb1VveTJ1Ymp1ei9JNW5maDBlT0ZE?=
 =?utf-8?B?NTBOajBCU3o0dzdOeXdpT2FXUTBHTVZMUFJPQytVeStxZEJRUnlrTlN4VUtv?=
 =?utf-8?B?UXB4eDFkYVNFM3M2cmlKYzg3VW1rTEIxQ01haVlqQkRma2NFRGRYK2RERWNK?=
 =?utf-8?B?ZW9mRzdiekhkWkpiWWdqVWFzZ3E3SGZpMlcxaHFVSzFMUnU2UytLNXBMNE1C?=
 =?utf-8?B?MTRtdXZ3ZGdLVjRpbDE3T2Y4K2xhMkNwbWtCZ2o5SVh3eU1JRjBGNXBRazBR?=
 =?utf-8?B?VFllK3VlUW9FS3Q4bWJvODAwdW9XMmJ5TnhjM1E2Yjl0K0lqRnFYb203eWx4?=
 =?utf-8?B?OVR3ekgrN25vRVFGbjBZa0FFTVJ3Tmt2UWpBeWV6YkhyVUVuVm5SQml1Lyty?=
 =?utf-8?B?cGlCMmM3SDlIems4bVZGMjlJdGZ6N2E1RUE0ekJXREFhSkFydEZlblVpSm5P?=
 =?utf-8?B?VXp5dWRSSWhYSTBzcmxNckdQWUlMaklpMUJINTZTYnVlYlE1ckEzRjYxcWlB?=
 =?utf-8?B?R2xSbmpZTjZiOUFuVlJXSytCemxaNlZxMkJMeS9Cc1h1NGwwUytreEdGS0Jm?=
 =?utf-8?B?Ym9oenNPZUlqY2lyZE80ck5yT2hZVDByL2VFdTVMQlI4OVhBWWU0TDlGN2J1?=
 =?utf-8?B?dG83ZmNqaFAwd3ZndEtqeGtQV1FOWDdQbDVQalU3aWRwZEI3dkFOcXplWGpm?=
 =?utf-8?B?RUhTMmxPV2YrVWtTbUtSaGE2ZTRXZCt2UTUzTTRaNE03ckJvN245T3dWU1Ev?=
 =?utf-8?B?Q0E5N1RBc0JNN2JvamVIcDRTWU5lVTFqSkowS1dWVW1MWnlRSDl0dFJDYTVP?=
 =?utf-8?B?cTd6VlpmLzdYVm9GeWpSNnhyOFBsaEp4d1RCNFN5dU0rWUxKdnRkRWxKMTZY?=
 =?utf-8?B?RFhKNWNpODRBTzJFeWo0MWsxS3RSazdUUVJodGhSY2dtSStVWDFtWFBFQzBD?=
 =?utf-8?B?d1NLWWZIVWhmSG4xL2VTSjIvUnZMZXRaTWhCR2ZvYm5UbFE2YUZyWjNLV1hp?=
 =?utf-8?B?YnhhZldwT2JWa2l0TkpMckd0UE1SQjRZbWZlUzJLWWFqeEhIOGlDTzlSMlMx?=
 =?utf-8?B?ak15RFNLbEk4QkRjVE1yV1BNU1BESUZkcFZBZzFsamJrS2pJVmhVaFJoL29i?=
 =?utf-8?Q?9MKIQlvruYCCxXQXSOi+OSnuM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea638368-e759-41c6-0e97-08dd2ee8c3d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:01.0537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgweoxetBWLmAcQ/9OJhci3CQ34twv2D4ON0NQI7G9tuwoB4eONK6rgK7ImGhp7mXKMKZzVz9xlH/MwgYa+l4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.
Move the env to imx93_evk.env

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig          |   2 +
 board/freescale/imx93_evk/imx93_evk.env |  88 ++++++++++++++++++++++++++
 configs/imx93_11x11_evk_defconfig       |   2 +-
 include/configs/imx93_evk.h             | 105 --------------------------------
 4 files changed, 91 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..c52546084394a7cc26f35c93ac8fb62d9c5fe795 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -47,6 +47,8 @@ config TARGET_IMX93_11X11_EVK
 	select OF_BOARD_FIXUP
 	select IMX93
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
diff --git a/board/freescale/imx93_evk/imx93_evk.env b/board/freescale/imx93_evk/imx93_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..f692f42f78ab67f004a483d886388218fadcbc15
--- /dev/null
+++ b/board/freescale/imx93_evk/imx93_evk.env
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_targets=mmc0 mmc1
+boot_fit=no
+bootm_size=0x10000000
+cntr_addr=0x98000000
+cntr_file=os_cntr_signed.bin
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x83000000
+fdt_addr=0x83000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
+boot_os=booti ${loadaddr} - ${fdt_addr_r}
+mmcboot=
+	echo Booting from mmc ...;
+	run mmcargs;
+	if test ${sec_boot} = yes; then
+		if true; then
+			run boot_os;
+		else
+			echo ERR: failed to authenticate;
+		fi;
+	else
+		if run loadfdt; then
+			run boot_os;
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=
+	echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	if test ${sec_boot} = yes; then
+		${get_cmd} ${cntr_addr} ${cntr_file};
+		if true; then
+			run boot_os;
+		else
+			echo ERR: failed to authenticate;
+		fi;
+	else
+		${get_cmd} ${loadaddr} ${image};
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			run boot_os;
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index df62eecdde455af561a23a54fde5dfc0a66d1835..43a67232d045e6f308b7bf79998d707841d3886e 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -26,7 +26,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 260a5043d5370478a6245bd4eafcf5f1c24b495a..eb40a69d20cb0aeec973a9c1a32a6fcfd831b967 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -17,117 +17,12 @@
 #define CFG_MALLOC_F_ADDR		0x204D0000
 #endif
 
-#ifdef CONFIG_DISTRO_DEFAULTS
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1) \
-
-#include <config_distro_bootcmd.h>
-#else
-#define BOOTENV
-#endif
-
 #ifdef CONFIG_SYS_MMC_ENV_DEV
 #define IMX93_EVK_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
 #else
 #define IMX93_EVK_MMC_ENV_DEV 0
 #endif
 
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=0x83500000\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"splashimage=0x90000000\0" \
-	"console=ttyLP0,115200 earlycon\0" \
-	"fdt_addr_r=0x83000000\0"			\
-	"fdt_addr=0x83000000\0"			\
-	"cntr_addr=0x98000000\0"			\
-	"cntr_file=os_cntr_signed.bin\0" \
-	"boot_fit=no\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(IMX93_EVK_MMC_ENV_DEV)"\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs ${jh_clk} console=${console} root=${mmcroot}\0 " \
-	"loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}\0" \
-	"loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}\0" \
-	"auth_os=auth_cntr ${cntr_addr}\0" \
-	"boot_os=booti ${loadaddr} - ${fdt_addr_r};\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if test ${sec_boot} = yes; then " \
-			"if run auth_os; then " \
-				"run boot_os; " \
-			"else " \
-				"echo ERR: failed to authenticate; " \
-			"fi; " \
-		"else " \
-			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
-				"bootm ${loadaddr}; " \
-			"else " \
-				"if run loadfdt; then " \
-					"run boot_os; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi;" \
-		"fi;\0" \
-	"netargs=setenv bootargs ${jh_clk} console=${console} " \
-		"root=/dev/nfs " \
-		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs;  " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"if test ${sec_boot} = yes; then " \
-			"${get_cmd} ${cntr_addr} ${cntr_file}; " \
-			"if run auth_os; then " \
-				"run boot_os; " \
-			"else " \
-				"echo ERR: failed to authenticate; " \
-			"fi; " \
-		"else " \
-			"${get_cmd} ${loadaddr} ${image}; " \
-			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
-				"bootm ${loadaddr}; " \
-			"else " \
-				"if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then " \
-					"run boot_os; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi;" \
-		"fi;\0" \
-	"bsp_bootcmd=echo Running BSP bootcmd ...; " \
-		"mmc dev ${mmcdev}; if mmc rescan; then " \
-		   "if run loadbootscript; then " \
-			   "run bootscript; " \
-		   "else " \
-			   "if test ${sec_boot} = yes; then " \
-				   "if run loadcntr; then " \
-					   "run mmcboot; " \
-				   "else run netboot; " \
-				   "fi; " \
-			    "else " \
-				   "if run loadimage; then " \
-					   "run mmcboot; " \
-				   "else run netboot; " \
-				   "fi; " \
-				"fi; " \
-		   "fi; " \
-	   "fi;"
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x80000000

-- 
2.35.3

