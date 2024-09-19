Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88768CDD563
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7647389078;
	Thu, 19 Sep 2024 02:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TuDRa+jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A0C89099; Thu, 19 Sep 2024 02:15:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 197D689079
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU+9aet2kCm1+hWyBiawg8Q0guHNw5LTUjh29Hnp8R5P9lUm2x3fVWPnXb/hto0y952AMe6rsRWFb2SNkzh66TPubUF7AK1NmeRESKBKLeiJSSteP12bBmOYlzs5kFk1UjgKf2889IFrx+/4BAkzJ+wLgr8qt0kvzswssfqlphqEckpQjrJU/13zG5QQLUrlHhsUmPuoXwevpoum8ymNQA0WqWBjCW6mNgNn5InlPARVQI66zHG7OmgBlJ30nynPefis2E1kWAzyNcVjFRfKZgSAhGVeQGDWNlS5DnwIM7glIMCsPp+0dRjaYhrDTgwbUupjxzJ2v9357y/yzxFc1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdToP7gHQHcuq9zk5Dq74N304u7ZJ8NVoQdxnwwRELA=;
 b=ZM2wxFZjnoLE+VcPvOERUPB1wjHDC6Ak+NkuZL2qqH1fm5xXgu13FbVHg7FSRwmMKs2eZ+ojpQgU7yitccJziOy7s6Z3FZaGwYmo67NoeeNXd4eBsMHN12sv8IpWdqpLAtKQ8+oEtEKQNKe4bH0XToHTdO6nWaGjDLYxqO1m4WJmttTk7+c1WCCxags0IvdenmHKgmnl1YN+ZIL7u+qfrIycpkeNuYjtULzUgpl+gFN+uzMk3dbB0a1ye2id/8YkI8WD7vTO2LsuCaROjdQWD4bP909ctHzJF0RixqwwEi/UdaY7/zH45ZCJHYYsyDWzKZvsHSQWffFkahnJsxPzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdToP7gHQHcuq9zk5Dq74N304u7ZJ8NVoQdxnwwRELA=;
 b=TuDRa+jm7R3UECrMtqJF0dvkvtgU63E3yJkJ5fzeRysfxZthMXOwNI9L/Rg2DhJujr93jN4mBad1l5tn3ru5F0lohZjSovx0/Hq+c868J2yOqVxVUCfZTuy5d0H633lsKS+Z2JBAtxTCrFwoFGOuvQAqnK0Mo9z+h/L0Gg3yGZ01eOhgJqnUDZJVySyokS9Rkv6U5wMU5lScHXzehTjKBVv1hM2WvTa+GM+ope6gAqkjwLdu1Ut7DI7GzA6d3Mro4l/SoplwrrsXNHvbhIaBe2nCs96h8AgHFI//OaLAvHxMIfBNavWc1wMTyqvZa5TRPZTXeO/rUal4W21D2qUQaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:12 +0800
Subject: [PATCH v2 13/21] imx: Generalize disable_cpu_nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-13-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ed00df-fd7c-4874-c497-08dcd8401fca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmNSQWIrODMzRmhOZkw3c1hzeFpzSGZwNVUybFhmYkdBU25yNkdUOE54cDVq?=
 =?utf-8?B?VmFJK3doRzh5RnkrQnNhWENSUUx0U3NDdWRIa0dCTC8zMmNQMnZVbCtFT01n?=
 =?utf-8?B?d2xxKy84TmlYbXJTTTZWcnl5V0F3MDIrcWhBSmswSVl2SldWckxJTk5QMHh6?=
 =?utf-8?B?TWxoeFNyU2M2akRvM25RbFV6eDUwd2pPRWNPSU9TMUxPQmdaalJ6UVVxNGh3?=
 =?utf-8?B?MGhWTDRLcmY2Z3lqdUVkTFlibDlwd3ZGei9yc3ZTNHZ3cEh2blVxMFB2TWU3?=
 =?utf-8?B?aUtQb0lJU0lydTJMbWxpenhmMVd4cVFuaG4vc05BL1czaWU1eENoTlhRZVBm?=
 =?utf-8?B?cnhYZzVYQjMvL1kxUWkvaXBveEpKaEI2a29yR3ZNalpDcDMyZkVhM3A0YUJU?=
 =?utf-8?B?clhPc1ZCUSt5SjFPR2czeW4yekJtYVFZL2k1bHo2bG0zdk1OTmVaZFhvQXlP?=
 =?utf-8?B?a05tS1NNMHhTd2Q5UVRZV1ZvalQzKzR5dElzS0dla0FkNXdlbVE5T25yTGFv?=
 =?utf-8?B?ZmwwcTdFTmZpTit1VkdxL3V2Y1YzNGhDdWpPLzEwUmQvMHFldDBJUyt3eTdw?=
 =?utf-8?B?bGg3UjRZTnFTc3FMWkhjN2JNaDVYVEZVQXRvR2V3WW9RM0FheVBtRHpGeCto?=
 =?utf-8?B?cTd0L1kybXdlQiswdnlmUWdZYzVxOC9qckFVYWNTOXFUNEtqNVVaOXZ0M01J?=
 =?utf-8?B?cnlQT0pCS29OcTg5VFNraVJteWx1ZjI3cXl6ODN2R1NxbmJHcVRhUHRvZ0pN?=
 =?utf-8?B?R1dLNGRiRHRESUFtTjJMRGFyVCtFd2FiU2FkMDNiSEpqdDVTcnp3aG9sTXQr?=
 =?utf-8?B?Vm1obmJtQTlsZGRWSktZbm10RUZEVS8zbG00Wi91dGI1R3dwd2NkMVNsMWpB?=
 =?utf-8?B?aEtSSnByZ1ArUm5lRU1nRmV5ZXBhVXdEd1VvUUN5ZDZ2MmJsSDlUREV1TVlL?=
 =?utf-8?B?K25ybGttdVBoTXZXY1FsV0NGeitnb1h2UmxMa2JIWGdtdXV3dGgyd1BSQTFW?=
 =?utf-8?B?TWtQZmFjVDRXazJJajIrUnM3Yis4NU1YRkM5Y1NsNVdkcHZWK2gwY3FNNFBw?=
 =?utf-8?B?bTZpbFNKRlhsaTlGS1ZMcFBSZy9hUzhZL2lSUFBPYzFFL3U5c0EwNFMxejlm?=
 =?utf-8?B?RE00QUdVSkE4VVY0SExkQjRTNkkrYlhlTnZMNVM1TWVrMm91V2JIdjFiSlpE?=
 =?utf-8?B?SHRrUmpwdkNiczdxeVpmVG9jV2FmbmxEQ2tTQlQrblRjeHNNZzAwSmJHOEpK?=
 =?utf-8?B?dzJnWllpWjIwdThLUkxwc1l1UnZFRC9OcjNaS3FGK2xQMmR5MnpvSXMxVGNJ?=
 =?utf-8?B?K1hVLzJJTjR5bGZucTUwT2VDQlptQktEUDNlYk02SzZaa01UOFFLYTAxWjZP?=
 =?utf-8?B?RUE3b083UkRKdEJ0V2hZeENwU2hQWUl2VlFob21JVHUyOXhaVzFNY2dYUFlW?=
 =?utf-8?B?WFFMT0h3Zkp1RFgwcFRtVjM3TlAzSjNNbkVtWHBkTEh4QklSVWVzbUtrYXNZ?=
 =?utf-8?B?Y2RQN1hmRTNTWUVjT1RQaUxoRzNVTXZkMUM1SGEvWmNzcVFadXVNOEVsR0xk?=
 =?utf-8?B?RWk3UlVUaDNQang1azBMOU8vVlZIUW4zWEo2emplVElVZkZ4ZStEL2dUMVFI?=
 =?utf-8?B?cWtQWllpT1hCRjdacWh6azk2VFk4S1VwUHduWG1BSUYrcSt6ZGVBeHl1dkVn?=
 =?utf-8?B?QnJxK0lOOEp5M1hIdGJjRW5EL2UrbzBONjV2QzR5OXgvWDZ4WE1taGRCcGdH?=
 =?utf-8?B?d0tvUzZMZU4xczN6OXZTeXJWcVAwV2FnYnpYT1EyWFM3NWxYMVAxV25ua21N?=
 =?utf-8?B?eXRqa0U1TzZtdkVna3BRaUVjbEJna3ZBQ2tBaUFQZm9yU0hla2JSNmk2SnVu?=
 =?utf-8?B?VDdMNUVzY2IxR1h2czhrTHV2dG1zcUVSbWJFaktaS2U5WEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3psMkt0a1Vic1dTZDJ4andLRkpjR3ZnZC9vYWpHbHN2L1lmL3VTTGxsbGFJ?=
 =?utf-8?B?bkVETEhWM012QXlycmtmcVJkanVKSGswUVd4TGVUdE9BZ1JGR0haU3hlRzQ3?=
 =?utf-8?B?Q0N1cDFqVVdBZ2xjZ3RRaldmUnpzV1hFUkRrZmlEcm5SWW83bEdjeEp2TWRR?=
 =?utf-8?B?SGlIenhIWXB3b24wQVV1ZVdSWGdHWkQvTHc0NDY5MHIvU1V2bkkwN2RHc1Bs?=
 =?utf-8?B?SHpzaDh0L3dUbUpLZ1VlL0VCclZFNXF4VDdoeDdPSGM2V0gyWmNEVlg2NlRn?=
 =?utf-8?B?aWpFVDVQeFlFUTJrUkRlaXhGMmZtVWh2MG9vczI1UytLUElXQkxHQlFEU1J3?=
 =?utf-8?B?aExnV0JjejJFYnpKVm1jNG0yVkt2TkJWdi9SVFlaMVBNZ3VuemxYZnhCTUds?=
 =?utf-8?B?dlFyT3JPNWNrbHlKaHpLelRZUXhISGlnZVBwUDMzaEhtTGIzYWVjeVdOKzJv?=
 =?utf-8?B?dnFUYmkvV0RleEJRMDJYNEJ2eGNzSm1kQjMzd1d0RzJmbklGTWsvREJvdXJZ?=
 =?utf-8?B?YStlZVZ2TjlyU245N3ZyOW91VVhaZ2llUGtwZWRPUWV3bmd3TUVrOURhMStp?=
 =?utf-8?B?NC8xN0RwVVVjTC9qaXM1WC84ckNyL0FwUm5ndDhHVjJPQ1ZuUnlNYUl3VXRk?=
 =?utf-8?B?SENLTFFpZjZLY2dGZm9vNW1qSnBrUko2U1doMTZ4V2tLU3dURjdDSGYwNGhO?=
 =?utf-8?B?MWhqcXVoZll6R25EbUV3UW0zV3NMUytTVGxia2QxVTZjWHpMdmh4SURERVdz?=
 =?utf-8?B?SmUvcEVZdEgxbE9FR2JXS1Y5a05jRlhLZjgzWmVvL0FZUlgyamc4Q1JYQVlq?=
 =?utf-8?B?R3lNbS9Kc0VtZ2ZUQkE5UjlTcmQ0RUFodHhUYS9VMHJTREhibTJIdTVHbXRW?=
 =?utf-8?B?NVBQeEFKTnExNzU2Y2xzSjBXZ0hTMVliMW5GK2lEd3dFOE9ZdUVsMzNnWWgv?=
 =?utf-8?B?UWh5dDJ3NnRWem9SeTZsU3hMQ2l3dkR6VzhTU0lxcHR1d3pEdVRPZmlidHUz?=
 =?utf-8?B?eUx1Qk5BaEFlaG9QL0NhN1hKbDYxUWVoenBhbGltMnVraDZsSDc1U3pGY1NJ?=
 =?utf-8?B?OWdkNDczeXI4NGMrSmhsaXhMam9hSDJPYkJiZ3VrV2Y0a2V6MVRUMlgxdXVt?=
 =?utf-8?B?U1RGd3ZZZnAzaFEyODM2U1dIeGRZZlptcHY0RnFzN1dzWGlJNVFKT1FmUWdv?=
 =?utf-8?B?bHdHV3BleXQyMHlacEw1a2FsN3hlN3RHdGtMVDZrWlNBOVVZSGV2YUtzcXpZ?=
 =?utf-8?B?KzBtVFZTd201ZklaODAxV3dLVm51ckxVU2diWStVbGI0YUJqMWlvSUthcngv?=
 =?utf-8?B?S1ZaVVpKdWhVakQ3cWhTM3RsUUhtMEhmUUppSXMyZFEybUVYTzhQZnI4amlV?=
 =?utf-8?B?TXdoK3V3Um9OVWp0NDV2WGkzV3l4eVp2SmVuVHRrdzRUZ3RVSllIMkMxQ2U0?=
 =?utf-8?B?dGJ0RVVWRW9qL1hxU1g3MU5DRmZQeUZPUnVNZ2JOWGV5cGNqV2dyb3RXUXhx?=
 =?utf-8?B?aTZzNFN6MkM5eE9zQmRiZjFCZzU2d3V4Vlo1WlFRZ1daallHVzAyQ040OEt6?=
 =?utf-8?B?cGIrYlVmOWVhdjRxSDVsWGVBbGdPRmJCZjBRQktOSVlLeVBEc3BDN1Y0S1JZ?=
 =?utf-8?B?ODArZWpSU1lQYWdFcEI0VUJPRnJrVy9pNEQwU1g2NjZvaEF5blFvTCtvcm1F?=
 =?utf-8?B?UU5ON3EvcXV2SktKU3VRdms3R0d4ZGhhUlppMWROSlRXb0lNcWV5WHNuV0Ra?=
 =?utf-8?B?aGJqS0oyUmsxMWY5QjBmL2U4eU5KeFhYOVFIaHJiVlBSVkdCbCtwc1ZIblNS?=
 =?utf-8?B?SXpZMlVxTy9jRGQycThqdlRacFJOM3JsKzJyTUVlTG5hWkNaUzdiMTBVTFNN?=
 =?utf-8?B?amFSL2Z5WjY3VTM0cy9tbjBmMG5YbVVZZlFMYW1zT0s1Zjk2SnYxMzdGbGw5?=
 =?utf-8?B?c3FXVGhKdlVvanp0MmgyTkpXYTRrT0M0Nm84TEdlT3FGaTIxVm43SHU4U3dS?=
 =?utf-8?B?R2Fla0lBMTZyVEpzUEcxcTJxQVFHeGF1cndLOFBJMkRXMjN3T1hJL2kwMmQ1?=
 =?utf-8?B?ZXJYT3FER0Z2WGZKM2hTa3l5aHBrcnJTZEpQRE1PWlVZQkxybDIweHZKbTNI?=
 =?utf-8?Q?xCwyiVwusg4YX1FmY14ie6mdX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ed00df-fd7c-4874-c497-08dcd8401fca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:10.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ATpG8+gnBz1mjusLT+/UvODKLV7KMzSLPlc/FFh+nKwzutGig8oCk7M9TA+GAa2Wt6iFyXV+Qo+iY6sNDJ1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

disable_cpu_nodes could be reused by i.MX9, so move disable_cpu_nodes
out from mach-imx/imx8m/soc.c to mach-imx/fdt.c and update
disable_cpu_nodes to make it easy to support different socs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h |  2 +
 arch/arm/mach-imx/Makefile                |  1 +
 arch/arm/mach-imx/fdt.c                   | 87 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx8m/soc.c             | 99 ++++---------------------------
 4 files changed, 103 insertions(+), 86 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 31ae179b211..d93e095e191 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -275,4 +275,6 @@ void enable_ca7_smp(void);
 
 enum boot_device get_boot_device(void);
 
+int disable_cpu_nodes(void *blob, const char * const *nodes_path,
+		      u32 num_disabled_cores, u32 max_cores);
 #endif
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 5262dca4ffd..47e2cb8d943 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -12,6 +12,7 @@ endif
 ifeq ($(SOC),$(filter $(SOC),imx8m))
 ifneq ($(CONFIG_SPL_BUILD),y)
 obj-$(CONFIG_IMX_BOOTAUX) += imx_bootaux.o
+obj-y += fdt.o
 endif
 obj-$(CONFIG_ENV_IS_IN_MMC) += mmc_env.o
 obj-$(CONFIG_FEC_MXC) += mac.o
diff --git a/arch/arm/mach-imx/fdt.c b/arch/arm/mach-imx/fdt.c
new file mode 100644
index 00000000000..df6fbf51dba
--- /dev/null
+++ b/arch/arm/mach-imx/fdt.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <errno.h>
+#include <fdtdec.h>
+#include <malloc.h>
+#include <asm/arch/sys_proto.h>
+
+static void disable_thermal_cpu_nodes(void *blob, u32 num_disabled_cores, u32 max_cores)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/cpu-thermal/cooling-maps/map0"
+	};
+
+	int nodeoff, cnt, i, ret, j;
+	u32 num_le32 = max_cores * 3;
+	u32 *cooling_dev = (u32 *)malloc(num_le32 * sizeof(__le32));
+
+	if (!cooling_dev) {
+		printf("failed to alloc cooling dev\n");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		nodeoff = fdt_path_offset(blob, thermal_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device",
+						 cooling_dev, num_le32);
+		if (cnt < 0)
+			continue;
+
+		if (cnt != num_le32)
+			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
+
+		for (j = 0; j < cnt; j++)
+			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+
+		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
+				  sizeof(__le32) * (num_le32 - num_disabled_cores * 3));
+		if (ret < 0) {
+			printf("Warning: %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+			continue;
+		}
+
+		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
+	}
+
+	free(cooling_dev);
+}
+
+int disable_cpu_nodes(void *blob, const char * const *nodes_path, u32 num_disabled_cores,
+		      u32 max_cores)
+{
+	u32 i = 0;
+	int rc;
+	int nodeoff;
+
+	if (max_cores == 0 || (num_disabled_cores > (max_cores - 1)))
+		return -EINVAL;
+
+	i = max_cores - num_disabled_cores;
+
+	for (; i < max_cores; i++) {
+		nodeoff = fdt_path_offset(blob, nodes_path[i]);
+		if (nodeoff < 0)
+			continue; /* Not found, skip it */
+
+		debug("Found %s node\n", nodes_path[i]);
+
+		rc = fdt_del_node(blob, nodeoff);
+		if (rc < 0) {
+			printf("Unable to delete node %s, err=%s\n",
+			       nodes_path[i], fdt_strerror(rc));
+		} else {
+			printf("Delete node %s\n", nodes_path[i]);
+		}
+	}
+
+	disable_thermal_cpu_nodes(blob, num_disabled_cores, max_cores);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 9ed27b59303..68d5762c2ce 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1135,79 +1135,6 @@ int disable_dsp_nodes(void *blob)
 	return disable_fdt_nodes(blob, nodes_path_8mp, ARRAY_SIZE(nodes_path_8mp));
 }
 
-static void disable_thermal_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const thermal_path[] = {
-		"/thermal-zones/cpu-thermal/cooling-maps/map0"
-	};
-
-	int nodeoff, cnt, i, ret, j;
-	u32 cooling_dev[12];
-
-	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
-		nodeoff = fdt_path_offset(blob, thermal_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		cnt = fdtdec_get_int_array_count(blob, nodeoff, "cooling-device", cooling_dev, 12);
-		if (cnt < 0)
-			continue;
-
-		if (cnt != 12)
-			printf("Warning: %s, cooling-device count %d\n", thermal_path[i], cnt);
-
-		for (j = 0; j < cnt; j++)
-			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
-
-		ret = fdt_setprop(blob, nodeoff, "cooling-device", &cooling_dev,
-				  sizeof(u32) * (12 - disabled_cores * 3));
-		if (ret < 0) {
-			printf("Warning: %s, cooling-device setprop failed %d\n",
-			       thermal_path[i], ret);
-			continue;
-		}
-
-		printf("Update node %s, cooling-device prop\n", thermal_path[i]);
-	}
-}
-
-static int disable_cpu_nodes(void *blob, u32 disabled_cores)
-{
-	static const char * const nodes_path[] = {
-		"/cpus/cpu@1",
-		"/cpus/cpu@2",
-		"/cpus/cpu@3",
-	};
-	u32 i = 0;
-	int rc;
-	int nodeoff;
-
-	if (disabled_cores > 3)
-		return -EINVAL;
-
-	i = 3 - disabled_cores;
-
-	for (; i < 3; i++) {
-		nodeoff = fdt_path_offset(blob, nodes_path[i]);
-		if (nodeoff < 0)
-			continue; /* Not found, skip it */
-
-		debug("Found %s node\n", nodes_path[i]);
-
-		rc = fdt_del_node(blob, nodeoff);
-		if (rc < 0) {
-			printf("Unable to delete node %s, err=%s\n",
-			       nodes_path[i], fdt_strerror(rc));
-		} else {
-			printf("Delete node %s\n", nodes_path[i]);
-		}
-	}
-
-	disable_thermal_cpu_nodes(blob, disabled_cores);
-
-	return 0;
-}
-
 static int cleanup_nodes_for_efi(void *blob)
 {
 	static const char * const path[][2] = {
@@ -1359,6 +1286,13 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
+	static const char * const nodes_path[] = {
+		"/cpus/cpu@0",
+		"/cpus/cpu@1",
+		"/cpus/cpu@2",
+		"/cpus/cpu@3",
+	};
+
 #ifdef CONFIG_IMX8MQ
 	int i = 0;
 	int rc;
@@ -1402,13 +1336,6 @@ usb_modify_speed:
 
 	/* Disable the CPU idle for A0 chip since the HW does not support it */
 	if (is_soc_rev(CHIP_REV_1_0)) {
-		static const char * const nodes_path[] = {
-			"/cpus/cpu@0",
-			"/cpus/cpu@1",
-			"/cpus/cpu@2",
-			"/cpus/cpu@3",
-		};
-
 		for (i = 0; i < ARRAY_SIZE(nodes_path); i++) {
 			nodeoff = fdt_path_offset(blob, nodes_path[i]);
 			if (nodeoff < 0)
@@ -1440,16 +1367,16 @@ usb_modify_speed:
 	}
 
 	if (is_imx8md())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 
 #elif defined(CONFIG_IMX8MM)
 	if (is_imx8mml() || is_imx8mmdl() ||  is_imx8mmsl())
 		disable_vpu_nodes(blob);
 
 	if (is_imx8mmd() || is_imx8mmdl())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 	else if (is_imx8mms() || is_imx8mmsl())
-		disable_cpu_nodes(blob, 3);
+		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
 #elif defined(CONFIG_IMX8MN)
 	if (is_imx8mnl() || is_imx8mndl() ||  is_imx8mnsl())
@@ -1466,9 +1393,9 @@ usb_modify_speed:
 #endif
 
 	if (is_imx8mnd() || is_imx8mndl() || is_imx8mnud())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 	else if (is_imx8mns() || is_imx8mnsl() || is_imx8mnus())
-		disable_cpu_nodes(blob, 3);
+		disable_cpu_nodes(blob, nodes_path, 3, 4);
 
 #elif defined(CONFIG_IMX8MP)
 	if (is_imx8mpul()) {
@@ -1495,7 +1422,7 @@ usb_modify_speed:
 		disable_dsp_nodes(blob);
 
 	if (is_imx8mpd())
-		disable_cpu_nodes(blob, 2);
+		disable_cpu_nodes(blob, nodes_path, 2, 4);
 #endif
 
 	cleanup_nodes_for_efi(blob);

-- 
2.35.3

