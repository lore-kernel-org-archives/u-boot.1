Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044BDE7718C
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574448035E;
	Fri, 20 Dec 2024 03:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uGdojap/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3C08021D; Fri, 20 Dec 2024 03:55:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B375A80379
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGZH11hrPcgNfn1kfPlO+slgDEgkcSWBBfe2MCkJffalFf9prUphNWTLM+WwFciTICgFWTwrZ3C37kLJZVb/lVf4qX7mANFF971O8O6l6T9WYibBGgmDteOTqF3XV39txrPwb+sefx2uQ2Izh3R9VOE8x9lQfb+Ne4Lm+7IBAnEH/xomB/gptYBw/1khLNp2pEXk2LTxp69uIdtqyny81X1sz4u9hXZGPszSD81e9FmZKE3mtLRYmBeNiP54XfLd8EZWoKxh0rxSx6ciVW5Lx5X+U/K3QdKbhXgAOIstYeenUJELrUVqmkNNumGp/RTu6qrDebwcDBH4rnyemEbWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqbOh3e+DZ9lJ9katl8007z9+w/bilMQFO5QqOWb76g=;
 b=j9cvrAma0lbe+YIKDdXOWB9C0igcb4DAja99L+L0KB0yti6gcECXWkkpB31a68+7WLsIDw50og3XQmGq3k8PRwprM4S7F0Q3JDnl1qHfG9C7cMOOsvjnAX+ILw9AGvBCF2qqI5lShhNJ2fSSuEd5TEbF8B5kBbXHDblV8AJUrTk4oQRdTEcU4qzTJ++ijsXSXyQRHqp+kQ4AGeIBVxA6TgME4+ODLg2EQIxJ4Gurg+uo8Vxzv072ThxvNluocftmWY4WlSL9kfVro8O617alZ2gYk+DeWcElsesp94aZoTHydIc0xU5tEoZ7SRWq4pGeZgP9UGz/Ui43qSsw3uP/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqbOh3e+DZ9lJ9katl8007z9+w/bilMQFO5QqOWb76g=;
 b=uGdojap/DZBMRH/lY/KJuMsL4pv469lO4iwl/lIqqTwWfb72J8QDvVigk1+LejMwqENnCzIJ3zWaE/5847f8s63oG5olU8vQmCCuDJvHCebw4m3O/8GIkrP95rhLKP2YujLgLxwlflx/pavuirey/X5uhCMYiEvjo7KzGSUwVEGCGAiCuVR+kAwNX39kBh9mbFMfVMS8rMaaVlv2hqfOed9Y+EUkIcLj8C9Y9lK2NDmfJg7f3xKNxK2FRvi9umJxVzTORgF/5K44WR0c/VViE2yKt4JQ3fNH4f8h89EhD3W7KUcEGDCypPmNvM7MMvdamFqDMh0P91XhDV9rARgNIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:13 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:13 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:00 +0800
Subject: [PATCH v2 02/17] firmware: scmi: smt: Interrupt communication enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-2-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=1953;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=AsqXw33M59VZNR1ELTRjnl0N6o5X/Dg4olHYCTHhcX0=;
 b=rhz9ra4duJD4q6dkYeihuZFmVVHiKZx/v+lAV2gGYD/s3C0CtHeh+WQwnBPI2dCHmrdrmJotg
 lN1r8qihbfmADWieZk3mp5zeDsDi0a3b90vefYbudv/soCF4e7gDqqD
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: a48a802a-f40a-429a-b206-08dd20a1b9a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clZrbWhEYWllRDBBcW5ua3Z2SWlLTlQxcTdGTFJLNWxMdmFnSVl6SkVTMWhz?=
 =?utf-8?B?QmhHKzU3LzloakRySmVuNGw5cmZzU3Z2eUpTQ3BmSFVPZVI1VWdkNkFwVmpl?=
 =?utf-8?B?cElnWG8rbTh0WHZ2alRKTkpzeElPWURaVjdTdExzYTAwTE1vS2FrNExZSEti?=
 =?utf-8?B?Qm5raExzUEdiRFowYkFkTGJhZk9Fdm1KQnh2MkwzYURnZHJMMW9wK2xpNXJK?=
 =?utf-8?B?SjNId01OOERiVGpvTHlOTUZ5NTBRMU5KZnZ6dnBkc3RxekcrTFZlOUFJSlBC?=
 =?utf-8?B?WlRwQ1l1WU9iWmFUODNucWl5bHhzL1hIUnBxM3JjTmtpQTVGWGQ0UGFETXdW?=
 =?utf-8?B?U2cwdzVaSGVGRVVZaGU3cWovM1hXZXp3MW5ZazlHRytST21JR1d4ZGlFNGZG?=
 =?utf-8?B?MXlwa1hoS1lKZloxNU1BSkg4S1AvZFhuOVpaR1ZDTHlSajNacWo1TjYxVFNV?=
 =?utf-8?B?TUwxaFNKQ0hwc1JRalJUS0MvWlEwUGFrQjR3WU51Zkphdit4dk42VkhQbVZo?=
 =?utf-8?B?dmE5M1ZmNGNnZXdOY0dZWVhrQWNKcCtqVUpMZXNoUWgzVVNxSjNhRXZyTkNs?=
 =?utf-8?B?Q0hlaHB6dVRZc2JHbUJ3dGVHNTNPdnM3cGJhNFNuZ2sxMzFzbmw0aXU2VGdO?=
 =?utf-8?B?TW1ZNUFsU3cyL0FnZ0ZpNDFkM2J0a28yYWdVVGIyaUlJTEJlYTlNb211MWNn?=
 =?utf-8?B?bzRqdTFzMk9BdG12SEVmY01sOVg0bVJWTTdrY1pqbkR6UGd3T3lFRG5SK002?=
 =?utf-8?B?cHFuWmpoZ0hqUndZTkV1czArTmlvR0hRZUkxQ1VDTFk0SVViVTBjbGZwTGJP?=
 =?utf-8?B?ZFNaNlpETXp0ZlpySG1wTzgyTllTTnFyTnBvbmZkNG5IY004K2Y4S0VTWkI0?=
 =?utf-8?B?aXVnMEVLN0hvSnYvbFRlN3hucFBIOVNhdkZHdEs2Y3BkY09XdHo2cmJqSmxP?=
 =?utf-8?B?L2Q5SnB2SDcza2NXTTI0WHdLWXpDRU9TTlpLVm1RRmlaMisvUS94aU5qN2h4?=
 =?utf-8?B?OEorcUdrY1dEMDByakJQSDdwN1JDNFJIaDBqcThsWTVIQStvRTJNRmJsdFE0?=
 =?utf-8?B?YXpEaXd3RHcvYkxpUUNaTS9NOHZhTVhQUHlMWE5NaXY5QllrYmhzZDAvVHZY?=
 =?utf-8?B?L1FZcW5DRkJlODk3OHhkSytXV2t6YzNUNFZ1eHh5QW9UbXZSUW9GajBadWZx?=
 =?utf-8?B?MC9XYm1CY09hQUMwek9QcU9IMUwwd1NCV010N2o5WEo1cWo3SFFzUWU0b09P?=
 =?utf-8?B?eHdtcGsrTHFaOWNBSVNwVHpUQVFzVnJwZDQrN2JiZzAyb25LVE5kcUR6Ly8r?=
 =?utf-8?B?OTBKMFZoa0xDMnNPNDdPbUV6WHNaTTRKSW1neGs2cGhjblNLMkRyeDJJQS9i?=
 =?utf-8?B?RUl5YjRLT0NsQ3UwV044UDdJcmRwclVxeVlqcm9MazhtNG5kZnQ5Z2lwRVZ1?=
 =?utf-8?B?SnhENzhnQ3JTUnY1cGk2MnpLOGR0amk3a0JUa2JqK1RxdGVheENTbDAveEdx?=
 =?utf-8?B?NjVoZkU5bW9Bd2lQbEp6R1drdW9BS2NqVnBPL0gwRGZaWk9BenhIbnJhUDhV?=
 =?utf-8?B?Ujc3eXJ4YXBxVDBLRS9XT0ljTFlxTDdqTUIvQmJZc0ZXN24wcWhUeDhtMHlh?=
 =?utf-8?B?UkFSWGQ3bE1OaE93VUNXZ3Y0VVVKOUM1cWpTOERWS05YZ1BnSkRyWmtreXUy?=
 =?utf-8?B?RUdkSE1iNGdYWnh5cmo2UnVJZXpEaE50YnVyam1GdEVsWWR2TjBmZGVQUS8v?=
 =?utf-8?B?MDJKT3FpNEQ3UkNydFoyZW1YZVI1c0V1T2VmVHBaVmpCbUxYLzBOU29JY0Fy?=
 =?utf-8?B?cENCdFkybElYejROejdlQkZ3eE9OK3pvRUZPaXUyaXo0aUNCN0hOWUQzTzRj?=
 =?utf-8?B?TThZSjkrNU85UWIyNnZQTnZKVVcvWjdHMU9hLzdwa1M2c0JQN2Z5VHhzZU5l?=
 =?utf-8?Q?W41M+V1oYjdh2SaNQXO2UCtzWw6kpqr6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmdaZDFyczhrOEFBSGlSdWVhSEh4dk41NUI1bW9zV2twb0x4alFjODhrVHFy?=
 =?utf-8?B?bVVZYlhic2VqTGRFT3dSSHVPeDhMQzdGbFhEQmw1OExuM1JEMndYN0J6V1A3?=
 =?utf-8?B?YmVUU0tvaC9nYXBoOEtNaE9yTHp3cHA5c0NTUEZJRmxJbGlWM1ZabVROdE9B?=
 =?utf-8?B?M0k4dUJIelhTS2ZKZ3Nad25vbi9NUFVGVEEzd25UdGVHSTcrWExMMzNvMkVn?=
 =?utf-8?B?cDgwS09hV3psbEhuUENiVm5KeFgvZmFVRVdhbkZxckswV1lKRlFXRkpIMTFG?=
 =?utf-8?B?YjdQWEtsdUMxallSWDNaMDFoK1JyaFd0STdJemJVTGxtTHYyM0ZWcVN6STVZ?=
 =?utf-8?B?NGh3NVJMRmt2Q09KY2ZjYzhnU3N2YWhuZjdac2NJRzBOT2M0ZUJtTXZCN1Bq?=
 =?utf-8?B?NzZzUUxzU0pjUTQwWUtYaHpuQlFBY1JCMHNjSjEzcE9KQlRBK3pJTkoxMTJk?=
 =?utf-8?B?bW81dlc2a2pWZ2RhbUVtVis5cHBEM0F3OHlyOERTeUZEMm9KVTVTOGpxdUhR?=
 =?utf-8?B?OFN3SVEyU3E3cWY2MnRheDdIcUprVjZsSFhlVHB6cllMMEIvWC8zNEM5YW9Q?=
 =?utf-8?B?RzgvVmg1eXJzUEp3bFBNeE9Vc3FueGN4U01YQ0Y1SVVFbTVTQnR0Q0JOTlpo?=
 =?utf-8?B?TStIUFBENFdDQ3BSejlKalpvRk5Oa3BJMU1rOVdXdE04Vk0xdE0zampNVUIy?=
 =?utf-8?B?cDBDZURZNnR1SlpWSjVpRnRLYzNYOGdkWC9YNEFhanNoWjhnR3hoamFvUlRR?=
 =?utf-8?B?R2dkb3BRQlZ0djRMcTIxTWNnR21uNTBmRjhxUVdQb2lnMU93YkFHY0NFNUJz?=
 =?utf-8?B?SXFWUU5SUnZGMUNUOG1tVDFpYnVVTlRQbmZVUHl6SHhUc1RwYVJPZ2haVzJS?=
 =?utf-8?B?QUF5UjcxQmlwVVV4MUV6RGJRVDhrZEdZcmZqTzVoT3lUQWw4cytCaVUwSHJy?=
 =?utf-8?B?Ky95T0h4NEMzMmFTVXRHR29vMHpyTDRzSERQMk1lNmdwWjVJM0FpcTZaMmZj?=
 =?utf-8?B?T09lT1ByWFdZYndydUFod2V5R2NtVS9HTXRkQ2xkbGRkWjFKRGpNUEp4ZzhB?=
 =?utf-8?B?SW5UN2E5OGY5ZDJtam10SFRVcndlc0Y5OWVjalJtQWU3aW9YYnh5WUdSR0V5?=
 =?utf-8?B?MDF6dGU0WFlzdGE1YlpYRmhUSWVlMDhXRFQ2V0k2K1NaNUJKK1dzOXV1QUs2?=
 =?utf-8?B?cnJnMWZWeXZ4aFBiWDFTaGZGU2lxZnBSWDIvbWZoc0xXcjkwYUJXTnFEZWJY?=
 =?utf-8?B?VWV6V2FKeW9udllubW9QWVZ5TnVHMS9LTUJzTGpuL2hjbHhhaGliWXFFd21r?=
 =?utf-8?B?ZGZjMVNmY0hFeUxtK2xXbE02YlBTYzZPek5rb3EwVFhBZTVvVWtRWDNBZVdR?=
 =?utf-8?B?RXFEUWlycWxtOXRiWE1kaUdmUE9QZ3ByMHBycERvU095SzdTTDJ1dGh5ejdV?=
 =?utf-8?B?Yk5kZlpZc3BWNUpsWG5ZT0dCcVFlVW5KekFxY0dOamw1OG10cWFiQ2dzcC9W?=
 =?utf-8?B?L3pid3lXb2llbXZHOEE1cVJyVDcvYjVxaGpPeEVQcnBpNzNxWVZlcnRHNDFv?=
 =?utf-8?B?aVhPei9PWWhjcm1oNkhReS8vV0M5Mk5aR25jOWh1U2N0TkE2UUJhMWpEbFhX?=
 =?utf-8?B?WE5TN0JCL1pFU0VVVmVuYmhLemt1amVvRlA3dXFJVEY1VDVvSERTUC9vMVl5?=
 =?utf-8?B?ZmpkdlFnWFI4bm9GbjFMNTRrUXJ1Qm9ESDFZallSSGRSUm8zbHVmODVna1Zh?=
 =?utf-8?B?T0Z3c2FKeFExL2dyMEVrbW1neStkTGJRdGFTRGMreHErVWRqalNUK2l1Q0tT?=
 =?utf-8?B?RlhmN0haQjhhWjk5dnVNdHRWLzNyMVI3Y2x5V1FtR3lwQW1uTTNsdkoxR25J?=
 =?utf-8?B?V1BtK2g1UjdMV2pJRHVEMXlpaEYzbGgvQSt4SkxPVkVKR3JrT2p3bUJ6bEVn?=
 =?utf-8?B?ajhLZ0k3VlRNNEx0dUpzV0lDa1pGMjhSd1A2MWhUUm9wMHpKRVNZWnFJSW5a?=
 =?utf-8?B?dWgwZjlYL2VwTzMzc0ozdmZPRXVDWXNwbTlqd0RZclptanJIYzBvT2RnUHhp?=
 =?utf-8?B?YnVuUGc1WHRnNnYzZTRuMDk2T3lTanVrWnNSQTJKVTV5VlROMHRuVjNRd1ZD?=
 =?utf-8?Q?+nzCfm9KZKrWgOPWeKBUqaSlU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48a802a-f40a-429a-b206-08dd20a1b9a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:13.3631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmxDBbhzZy2jY9QP6NepaCKsY3hiJRpNQZwJA0VHiPGEAeB9QA61aHTzaaCjxY3Zmaj5LoMqaazLLeZRRxBwiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

From: Viorel Suman <viorel.suman@nxp.com>

When interrupt driven communication is supported, the transport allows
the caller to choose between interrupt and polling driven
communications. To make the choice, the channel flags are used. i.MX95
uses interrupt driven communication so that Channel flags should be set
to 1.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/firmware/scmi/smt.c |  4 ++++
 drivers/firmware/scmi/smt.h | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 67d2f45002490ab64a6bc997eda93a8f4681d99b..e5b902dcb0e641065f4c0faae6bc6660a7e2c6af 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -48,6 +48,10 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
 	if (!smt->buf)
 		return -ENOMEM;
 
+	/* Command should complete via an interrupt so that set Channel flags to 1. */
+	if (IS_ENABLED(CONFIG_IMX95))
+		scmi_smt_enable_intr(smt, true);
+
 #ifdef CONFIG_ARM
 	if (dcache_status())
 		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, MMU_SECTION_SIZE),
diff --git a/drivers/firmware/scmi/smt.h b/drivers/firmware/scmi/smt.h
index 9d669a6c922666c48e7dce4c0affd7b47cb137e4..768b0f4c8a8d1cc7966530e724d278d72c2a167b 100644
--- a/drivers/firmware/scmi/smt.h
+++ b/drivers/firmware/scmi/smt.h
@@ -84,6 +84,16 @@ static inline void scmi_smt_put_channel(struct scmi_smt *smt)
 	hdr->channel_status &= ~SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR;
 }
 
+static inline void scmi_smt_enable_intr(struct scmi_smt *smt, bool enable)
+{
+	struct scmi_smt_header *hdr = (void *)smt->buf;
+
+	if (enable)
+		hdr->flags |= SCMI_SHMEM_FLAG_INTR_ENABLED;
+	else
+		hdr->flags &= ~SCMI_SHMEM_FLAG_INTR_ENABLED;
+}
+
 int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt);
 
 /*

-- 
2.34.1

