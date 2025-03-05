Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D90C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FE080F56;
	Wed,  5 Mar 2025 14:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qq7JVC9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 509F3811B3; Wed,  5 Mar 2025 14:29:09 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD71807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbGr4Rr90O5dV/si6wSZKraPAwKb30D8ZVmGdgzv0yQ7X/nVMHR5qhYh6nwVin245J73EUtzKQxVAq3uEiV9e7f540Z/718JysJahDtUxDJnVJkp+E172fTjloh5FFkqtHgr8IDjactpq/iaP2d3RHblzFHMXYPYa2zCjTBDkciBGGSWmXQQvXxK5W/yhNYSn5Kv9fO/o+VoFyPkhL9HwUgYSjnOJSltdfZtFvdfB/AuXvb7phlIYRW4Z6gHp51+CFRc90ZwblrjkZUYUjeyvcjooc1/zeaKqKr8VVJ5LM8ViHbBeOtHquJlFmeF/7r98Jy1IVzTI/scWVTjmQwp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s/VmubPqADPCUjrMAESckuCgRp0vRsLLFMesVlsMUs=;
 b=MGe77oOTnNPZWDwQVCMNvvXLMyUbkm8Od6k2A9ATclavRN/eccOIgQmeTrt9cogX4fJxKvEsJsdQ3d8RETdQTj8BqbEir/OYo3ZZavbgTSsvBBg8GRuOMHP960kuVvB7Ahmsltji6T76iM7V7vvzFw+sJ2HHFojFQjVXMk91uNKxtx7Dd7HWzlciiua6ds7jOkuz2VwT9S5AFwJa3iu8Kw6VLxiCVEKJP+47DrPF6fgSGzjIdJM0ihFjDsvlwR4pZCC6IPRV9thxmdKmMuknv/3JAWWgK7COwADDqWL1pi98Mf5bM7oJPq2AQ5Ira8YX9cd0bq3z22l0FrseUxCImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s/VmubPqADPCUjrMAESckuCgRp0vRsLLFMesVlsMUs=;
 b=qq7JVC9j5TY0KpNZXHEOl7yPV4SMFUFh0lUBOMlmkNHA4EErSKxmcnK6i0xlxPpHZl8yiHXT5lVqLy+1JQcnvk85G+i0PyW5UdrDzypLGCAaqXQijb7ie9ix4y+YHAHhK2wiqJbm15aAz/qSUmFIGu9CmNdiv6ZdnOa2E7d2JuZrwievf01kdxkKf5tRK2mv2zJG7ZGk1ke22y0P3ljQ7eMgofAcBC/STFwN8/mw/PEFEAuxZGvessRZXzUA0XRuBDazMVl1blwHbhjYmg4KjGRMrgKvrfYZnvmHK3/SXzEOH50HtGptQ/VQ+ZnWEpTsd0nZxG8kROl/O+8uea7vFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:06 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:16 +0800
Subject: [PATCH v7 04/19] scmi_protocols: add SCMI misc protocol
 protocol_id and message_id for getting the ROM passover data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-4-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cddba8f-1a76-41cf-091d-08dd5be9b3db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWtIOEhpU0Q5WGNUdUZ4MU8vSjJ4SXJwd3VrVjJjbFNIQ3BtZHJsRk51ZEI3?=
 =?utf-8?B?SFAwTDYxWEN1aitXQm1VTDczNUJ1ZE1hMXlQMG9Ga2M0M2czcEJFeVRmNkJy?=
 =?utf-8?B?QWs3WVF0ZlFHMWczZ1grNERWc283NXl5K3JxN0lVd2hOSHRXZHVXYVFNc2Z4?=
 =?utf-8?B?L1AyZi9tK2tRc2tKVm03dHh0NzVscVJLNEI5TVV1WjdxQ2tHcjBnMC8zNkFU?=
 =?utf-8?B?U3l5SUZ5R0taOVJZUFpnaTdxbUd4UEJMUi9SY2hkd293YXBZK204T2lqUU0y?=
 =?utf-8?B?dHhwSldHLzZQSldlWFJGRDRObURDUU01aUZ1aU50TUttUGtYZjd0ZHp6UnhI?=
 =?utf-8?B?ZUgvcm14bEdsU0dIT2VaOVB4QSt2anJiUE1SaGtXY3VqZGxjcDRxWWxzQ2FO?=
 =?utf-8?B?VTNNZFZlSnAwSkFCck91TEV6ay9RYlVkQ1k4bmJUY0xOZnZhcmJBSnY2aVEx?=
 =?utf-8?B?eXllWGFLVDVqNUF1RU9OMnpmMXBwU2RkeDRuMm5HVmhEQ3ZqZ2ZCeE9UaVlp?=
 =?utf-8?B?bjV0TEhzOU82YXhPQmMwTEhzQTJkZ2NhMGtZTlpDVlh2cGR0SWU5YWdBVzBV?=
 =?utf-8?B?WGR1WVVXRkN6QWlvTDdzNGxrTDJ5RFROditOL3czZThRYUliY0dUYUxVMDFW?=
 =?utf-8?B?M0xqbGZUMjVzZ1pRdzgxcEtBOXdZS0xKNUdhNHBkVUxaNGhwc2oza2hkQUwx?=
 =?utf-8?B?NGZwVlRYcG1UYktuQXZ6TE9NWmJ5bEJ0NlFsWlZJa2pNUXplNnB3dE5MYjl0?=
 =?utf-8?B?Y2Ftbm51YkdFRDFha1Fxa0lGbUhLV0YxQWxkUWMvODdKa3Vvdjh4dzhzRGI3?=
 =?utf-8?B?OTliMy9BUU9Pc1g4eHVXbXhOZlF1aXVCU21seWQ3Mk4wVWxLYk1YOC95aThn?=
 =?utf-8?B?VHBiUFV2SWlKaE4yUkc1T2lqZ0lLeE5EYyt2V09VWm9RSVNyRnZRL09MMFRL?=
 =?utf-8?B?cVZrdlFaTmFzOTF0c3RBTG5adVMxS0JldHhycWQxR1p1ZjNUcFIrUG1KQnBx?=
 =?utf-8?B?N1FCU29xa1JjbUh1TWV2eklnWTdRK0hlZ3Y5Mys2UVJkTllZWFNTZ3lQK3Bl?=
 =?utf-8?B?RmZzcnh2RU0zRXBOTnVtOHlzVEtKSjU5Vk9UVEdMVmUrVTdOMEhwendkRjhn?=
 =?utf-8?B?R2thSDdqVlpUSEI5dVIrRXNxNnlTNTZHYVNJcFlCKzdzbVJQRXlSSHpMMXFM?=
 =?utf-8?B?U2I3R21IMzk1Z2FtYkFiQWRheVR1c1JHNGxXdTJ4M011dElSUVZTSTRwM1Br?=
 =?utf-8?B?YTN0MGtFb2NjbWliSVBac0VZcEN4UzVSMk9RcC9pQjRZa2xKcFNiSmFES0Zk?=
 =?utf-8?B?Y3pndzRzQTdFcDMzR0FrdHVMTXk0VkFTRDBoTkJKS2JyM2Y0cnFmWXU5OWJz?=
 =?utf-8?B?L3A2bE14RDRwUFFUWi9BRm8wa2xtUGdvNDB5RkVWTUhQOHNiM08yd0c0bGp5?=
 =?utf-8?B?UWtkN3dITk5BT0dIZFFqaVR2bkJ5SGFUTzQvcHpXQXJ4bVZCNUFMaGJJSjFq?=
 =?utf-8?B?MXM5ZDd2SkRtOURza3hJK2hYTTVYc3VGajh2Y0oyYm9zamxBZHVkbDJscjZL?=
 =?utf-8?B?Z3k5cFQxZWsybU1PS1NtNW1KUFp1R2hzcDRQTWp4dDV5TStGZFlJdElCK3B1?=
 =?utf-8?B?MEtuRHdlaW1hdGdQRlE0eXovT0U5U1h4NXJwVmtlWmxUY2pJWU50QVN6VmJq?=
 =?utf-8?B?Y1QwL0Q0WlBXdmlKU1hlWDhXMHRRbXlZUnpYc2w4L0M3SW0yZmIxenl0VTNa?=
 =?utf-8?B?dG5GWlhqakpoZFZveEpIYmticGlrWUlnTzRyajdUOE1lZlJLMVlHMkZMWTZl?=
 =?utf-8?B?aENxN0RXS0dCYzY4Qk5pRDY0a0NjZTF5Q2t0WTNHQUhuUlF0QTJqTmVadVMr?=
 =?utf-8?B?aTZNY1RHQ2xFbzdTbHd6UE81OGQ2eDJISHdsUHpiS0FheXoxVkQzN2ZGZjVn?=
 =?utf-8?B?dGpFaVcxNStNRnJkMmljVTlwWTErMm1vRDE4cVEvaGdXcitmTnM3RHZ1YW9m?=
 =?utf-8?B?Zmh3ckxtQWpBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJ2TkxKaDJpSEwrcnlZMi9lK2hiS1dwUElzVTNYMkd1VVpqRVU1VElVRXJV?=
 =?utf-8?B?RVI1RGtZeWRDZmh2Wm1obGZnNXpEcGFqTlppa3RjNVhkLzNvakp4bXFIKzB1?=
 =?utf-8?B?R1ZXKzA5UVRhdkd4LzdlZkxuTGpPTlVKZDhveUdHeFhBRENxRW1wL0RWaEdS?=
 =?utf-8?B?MDBjSkxHeTUxUEwwMGF1dmM1dTM5TFpMbTJvaWpISmNxWHBsdWJrc2U3WDFr?=
 =?utf-8?B?d1Qrc3YyL3N6Ym1RY0RuMnNseFcyeG50WnNFeGtoU3NWRHRUSWhIS1lPZkV4?=
 =?utf-8?B?NzBlNkkyNTJzbm5qNFZIRWpsL1pFcXorcjFkbEdHRm5XSkZ6dnNXdVNwaEJi?=
 =?utf-8?B?clBLMWxUcFN5ek1oaUxvaUd4SkRWQWFqK2lLY2puK1FCWElTeDRncnN6aDVl?=
 =?utf-8?B?eXd6SXplUElnN2VKWFM4WGh2T0JrZ21DMlBDRnN4K0VGRVVYM0NrK001NTQz?=
 =?utf-8?B?dDhBY3B6ZVFpYlJDQnZ1VXBZaVV3S1FUL2Q2SGZNRmxXTDdGKzBONndUL2ZU?=
 =?utf-8?B?aEovQ2MvYXRZN1NCY09jMWZxNUtGZmU4Skd6L2t3aDNXem1lWWdlbmk3ZnVv?=
 =?utf-8?B?MGJVazZDUUc4cGR3blBRMjNTQmRlQW5ZOGpJUmhkWHdpUmpiUGpLZ1FHSWlQ?=
 =?utf-8?B?TEFsNWpKL0s4TzhEcWFOWUR2dHlON0hEaldJQ0xBcVhUQjFpVXVCZ0NVY1NE?=
 =?utf-8?B?dklIbTBrQjVNbGtiNWp4bjNIOE93YjlwWFZFQkk1YkpvYThIWmllNE1uVjlO?=
 =?utf-8?B?QWJoakRLMWM3UUtJK3A5djQ2R3JUNDIyS3RjYXBGMGFZUkl3emRZU1pZelBp?=
 =?utf-8?B?QWRLZHhXbTVIRUpzN2VUMW1lTmNqU0xGQ0tUSXRiT0hSRllFTFRic254OTFo?=
 =?utf-8?B?KzcrWWNTNmkvYTl6cmxEMVNrTk1yNkQzaXh2NUN3WVBWZ0ZsUUJiNkdlZWtk?=
 =?utf-8?B?Mml0dWFFcVh2ZFZWQk1KMXh5MCtNRDNhbEpWV3ZtUHppREJadEd5SnBJbks3?=
 =?utf-8?B?TjlDeHRmdk9SdnNvNEtIMUtDU3pvaGZtME5MMy9iOEtNanZ1T0lKWkw0Q3Zx?=
 =?utf-8?B?cUJlYXRGN2ZwWUlKbHFQSFZDSTh2Q3ptQzVaNTVwWjJQdFM1anhtVHpKRDZL?=
 =?utf-8?B?SVJQdk1veDBEMGpKZlQ2ME5NbWNqeFRtMVB2NGRsQUFLaEM1VThLd2ZkaDNT?=
 =?utf-8?B?MDZodElhdmVBZEVLK2FWMmdqQU13bWV2eVJNdnFkakEyNmJNdnNmTkpKZTdn?=
 =?utf-8?B?ZjFmL1N4ZTYyWVdnU05NdzJ0VXoyd0x3OFZzVUdFYjR4MDMyOWNwdVpGdE9x?=
 =?utf-8?B?T01lWHZKTlhSbEV3dkEyMko2N1R3M1pXdmFtUUVvMGhiNXF3aHhqSGRjZ3BS?=
 =?utf-8?B?Z09xQ0ZjUk1NWUtUbStaWXlRK3RPRlJqeU5pWlI0MzRzK0ZLbXNSNEtGTmEr?=
 =?utf-8?B?RWF4M0dUMmtKeWtPT0NHVktiVkZzQXRjcjVFZFdWczY4emNraXpFVFYxeWI0?=
 =?utf-8?B?cDF1Z0hTbld2RVZFS1dXV2czcklvaEQ0VmthcjhMTDgwQTdPQUt4TmZXd2hi?=
 =?utf-8?B?TnRVN3dYdDhTRmg0N2pvZWcrTDBLSmswWDdZcm84OHhtVWpHOC9oOVovTStJ?=
 =?utf-8?B?N3lzSHp0NTRkKzVmZldzbzIwdDJ2SzF1YS9PbXlXUFlVOVI3bVZVWmF2WC90?=
 =?utf-8?B?bXN6OTE5ODIydUZQUVdYZ3BrOWVnWHFLaUQxNFdBeFdFRVlmYjYrRC93VVhq?=
 =?utf-8?B?YkZENTJ0bGNaYUUyNGRhU1N1NERmbHVPU25Rd2g4Vmo1SzJZT0dVVkpIT1ls?=
 =?utf-8?B?RERIei9ibTIxZCtLL2owTzlKWFQzNEt4YkJtZTNaODlHK2hPRkVCUFB6MVRQ?=
 =?utf-8?B?blZrb2VSNndiZEk1SWd6YkIvK0ZVdUhWUU1KRTg1U1BlRGZoYXBVR3hUZTFy?=
 =?utf-8?B?cHgvdHBTY1J1L1R1dzZrb1dwSUZGKzhTUnBBaGQxSDZzYjJPNVoyVnRtM1VM?=
 =?utf-8?B?NHBKOGZvc0xPSVlUWEs2NTBlajZlVXBhNjdBL2F3SEYyWlNSeHNtc1huWCsv?=
 =?utf-8?B?aFdlM3psS0FIQVdtdW5tL3M4enZFU1ExTVpmSzRqNkhqSVllbkN5VXh3V0Js?=
 =?utf-8?Q?oqU7sInIoQxXZ02lRuNoGPPK6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cddba8f-1a76-41cf-091d-08dd5be9b3db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:06.0776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Sn0nSoSLjXmQubqbK/Ho9RENcswuW4K3/KSfO+6JSXOyfcDPeIS3FEG55J6xW/B+DtghBrg3QG0clAay3I6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

SCMI misc protocol is intended for miscellaneous functions which are
device specific and are usually defined to access bit fields. It is i.MX
specific. This patch adds SCMI misc protocol protocol_id and message_id
for getting the ROM passover data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 279ebbad44..06de4a601f 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -25,6 +25,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
+	SCMI_PROTOCOL_ID_IMX_MISC = 0x84,
 };
 
 enum scmi_status_code {
@@ -50,6 +51,10 @@ enum scmi_discovery_id {
 	SCMI_PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
 };
 
+enum scmi_imx_misc_message_id {
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+};
+
 /*
  * SCMI Base Protocol
  */

-- 
2.43.0

