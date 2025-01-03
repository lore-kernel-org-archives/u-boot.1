Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D32E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26047805CD;
	Fri,  3 Jan 2025 07:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dN82qkz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D32800D7; Fri,  3 Jan 2025 07:47:01 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C83D8805EA
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRjCcT4/lk6kosI2yux/fmXtRda6n+TIIdZoHjuK22Ozx+Otg2muYxuABP5UKAn4S2qcc2VAUtMipWtRFhJoG6icO70+W+DN+b6I6Jlr8oW3OHyAjCAJ/Arh66YwOGcg0b2qokcqfxox9b1kZAHnjeaxabDFQxw/yq1k+vlZcHEyU4PBNUJZY9EasNjpNhGlxEPPg1zrHRnpkjtygl1deoUJgygaJ8Jdb5YJD54b6AphP0QlWKF8prx+LcvwrO11BDU7eP24hnVws/0dKJ0T4r3lIdVhSTizXBVheb+3+dgZcRpnyZOnwEBFuIKzvDsTNnqeuid3cnnxv89RNhMvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=jaL4NgUHi4cYrMi8j4/ElQmxe0/pOUCNMNGjH22KGZTB9Mf0DLD2dqp6U+MRgKftyu0z4uS/RcTE9Lpda4CpkhbuyI7+SEI2pDDRNfW+swYyCsbOyh0bHru/U/ITvLrEOR/s45xD5KIjOrL3HMUCyaFIsEaS8IzLrseudjoFeNuQJR5Y5rkovrGZywyNrpT5a9fR94WpaB3SyMLlboomX86K5J2lyrOM/VitzRuOHPY6jJ41j9qnMftSFkdLoYhDd0F3cPO5HQ4V+zciK8AgryDtpVILK8mzk5vMVbrMMj/95RVwaOFgrlHmtNfs7AF+8QjnV70zE2wn6sTskXIkXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuwOEQZEourDzHfu60ciKo7M4Bx1uaaHFcG+diFR7v0=;
 b=dN82qkz4Od1UfOMDSIwmnK15gDUlr2P5SfROdK49Zb/EuRXN2fh35ZtJ5Lnb6z4DJu+WodPAy0HYT0ELo73MO+8Q/L8ygOKvyNaDWb5WFNnsNnV8qSQ/t3GlugGULdOXRGIlrAE8H2FErIuDOy5C9elTxRYrA2+DzVoaRPjfzUb+umL9gmRTlSMeK20siwMnK5lgdHCTTSRS6R3ira4If3mDZhWcjoyUUppfKyL3wuDrOXWVp8nY2FXkT1bpS4Wz4/KPHY6/PekBFTChfJ2WzhTrUL8AxyB+tKsotEXZYJTzoYT15EjczkwXtTlViCpzcZR2y42KpJkra6a8udqdyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:54 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:51 +0800
Subject: [PATCH v3 16/17] imx: add V2X container support on i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-16-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Teo Hall <teo.hall@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=4715;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=5mjLko0D90emd8eazTMT621owZ10RDbCttkbBOSrtws=;
 b=AfouRxAgjCJfyd7n8XeOPg9Ew8q1PaUL+XOekVyVIyKVz/oxU1JBx3Ug2RH7pu+bfZ/vw1ST2
 uJAsXuJ9QsZAiZJxC9iAnNyizGKEvuTTzVjdlRAb72SKi2ewnGuJss0
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cebd643-0477-4961-b3dd-08dd2bc268fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dS9Uak5TUnBISUZiTjBZdW1iK3RZMjUrd05waU8rSXVWbnpZYm5lSXByeTZn?=
 =?utf-8?B?OHR6dkNURU5US0dqcjdYUGZYZ3oxZ1FaK3ZZQWQ1NGhJSHA3WGpPYTh6a2ZN?=
 =?utf-8?B?UnpKOWxmd3VMc21pbEVRM3g5RW5kcmVpNWdXMTE5NWtuVzVONlRGUldoZVVO?=
 =?utf-8?B?UldlTmZ6KzdhM2xIeW5JVDZJbDYwRGdBMVBsaFNoZ1VDZy9zMWMrbHlXUCs3?=
 =?utf-8?B?dW1SNk1EaHYrb1NVTTMwYjByajNoWktvSTNiTUFod3AxUHFrQTQxempjbW1h?=
 =?utf-8?B?NlV5QTRFQWhQN1QyYXJiTW83QXhCdHNBYTVCeUZ5RFAxWjBxQmVIUk9Dc1NN?=
 =?utf-8?B?YU5HV3NkcDNxQmg1cG1DbEdpRFFWMlVwbjdEdGFpMlZha1kvNlNIcjFLdFJh?=
 =?utf-8?B?V0pZLzBZeC9iQWhLb3c2MDlZQm1PcVljelVpQ2MvNjhXZkhna3JjeTZJZ1lR?=
 =?utf-8?B?Z01TWnpGaUl1bTVqMitEeTV0ZnZLeUJzR08yRUZ0NjB5eFY5UlRUOHVON0E5?=
 =?utf-8?B?MFBRaXNXdU1TWU1NU0ZoT291ZEFnVnIwY0E1d0RxZytNenVEZE1WYjVwOUR5?=
 =?utf-8?B?bi9PVmdvczNRbk5VUzRORW5KV0lKZkFtRzNLWHAxRTdMS1o3MWJrYlJYMGth?=
 =?utf-8?B?b1VLRjdKdlNYVFFBZnBLdGtmNkZkVkl5Yi92cWhjaWdjUjVHS0IrTlQ1dzVK?=
 =?utf-8?B?YkxVdlpGYkN1bW1CUFc3OVJBbVBYWENPK05pWEJCTHA3YU9RdUZZSDQyYjVz?=
 =?utf-8?B?YStoVjNGSk1yNGIyOHNLaGFML09HSUo1YVN1YXM2NW9yY3JaZzBSUFlCMGNE?=
 =?utf-8?B?SFJHZEd3clVZdTIvL2V1V2tjWFJYYlhPYkJGOVZ3TTF5am9tUE56ZVRVUE45?=
 =?utf-8?B?ZDY5b2ovZGk0WmxscUtxSlBXOUdxT29VZ0FwYTgvTzFhREVsMDlUMlJ4Mm13?=
 =?utf-8?B?aWsxSmNaQUVsRW5hS2ozY0wvWFBXR3E4L043dHVBaEVDNTlmVG11czZVN05D?=
 =?utf-8?B?VTZNTURBMUFnL3g1YTkyWGFkY3VsaENhekJ6aUFSNlVwWEdjbHdjd1BRaVB2?=
 =?utf-8?B?cVl5M0pFN1VVSno5M044UnFBNWNIQTdHd0dFY3Vod29KeGVIRm85d0s2ZTdQ?=
 =?utf-8?B?MXJtVTFvZVdDYXpDR0MydHRTZkFUb0VxK3RjcnJaRnlaTkZ0bWRVekJkRzZ5?=
 =?utf-8?B?cnU2VkJLamRKTWNDY3RXazR1MVVqRDdTalk0aW5kMXBFdldEcUUrQXhqblFh?=
 =?utf-8?B?c25ON0ZQVnM4NW9CaVRoc2tWNmlhU1JMUFhQcUhVM1RheTgxcmxWOWRRak1u?=
 =?utf-8?B?ZGUzcW0xMTgraGRzZWM3Mno5bjlIWW4wa3ZNSDJBTnhxRGQ5OUxrbm55Z1R4?=
 =?utf-8?B?TFZ5d1pVNWt5dEJ2T3NtblpYR0VnUXVHS1ZuUHFROC9yVDc2Nko1Z3c4R1Vw?=
 =?utf-8?B?NnE2M284bzFmOTFVMHE3dnVaNkV4U01DM1Y3UiszcEoxbXdSVU9aaERtM2gz?=
 =?utf-8?B?cHpRN1NBUEx4NFRPN1V2bkxPajdPSWc4UlFRd01OUWFrQjVNS1ZxeXBTNGlR?=
 =?utf-8?B?RXkrR3IzNm01blkxNU93UXNRTFpSMldGU2MxcG00MHJxcUhmemgyc3paQ2Vo?=
 =?utf-8?B?K3E3TVAzMnl6UDNWVk1rdytWNkRhWGlTVHErQWNxTXIrQ1h4TnQrMXN3eVA5?=
 =?utf-8?B?OTl4S2VRWE5xZXBGQTJxckgvZ3ZkT1o5Y0x3M2JncllVK0Z0YllJZ3k0T0Qw?=
 =?utf-8?B?Q2E1YUlyQ0NrK0JGQ0w4cG1LSGZuZTJWWnJ5UGtBUnFGUjMzcUhObmkydnFH?=
 =?utf-8?B?VUw2WjRNS1JOVmpSZnJjQ0RhT3NZeitxSnB2UHJaTEhJS04wRGxTWllZQmRi?=
 =?utf-8?B?TFRNTHJqNjVkb0RnR2NnelFxTTV1S1lxVE1iZmkzUFZ1TTNBVkdtZVZuRmR2?=
 =?utf-8?Q?EWdhlMwzfwvpTUgt2eoab3rX9vOrizAF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWpCZ0F5aWVkWUhlTmdrY0FJQWVmQkdYZzRwazUyTFpVYkpCTXRuM1VoUVQv?=
 =?utf-8?B?QW1ZTVUyMGtXenNubi9NbWxhOGJ0bVJ4Q0VieFcvZXYzemhQbXBuMnZPN2M0?=
 =?utf-8?B?eDBlNVozTWFNN1JUckJVRzNUb1FXTHdub0xlbzFzNy9LOUhJOVlZT0dNc0JH?=
 =?utf-8?B?Z0kzY3FxenNrK01qTjM1OEhvLzI4aFFBMmIwNFBEV0IzMzk2dm8rOTdZaEc3?=
 =?utf-8?B?c3ZmL1BtUEhpcC9ZU0NNWCtxUzc0eXo2ZktqaWw1cHdENjIzU2NzV0pybjZY?=
 =?utf-8?B?eWNEcEJKWGZ1QTlrSWJ6YW1vRWlucytWbDA3VUFBMjJvNnFJb2RxeXpaT1pR?=
 =?utf-8?B?U1ZiM0kzM3l5R1NEdGN6K3Jubyt1NkE1T2pwSktHVDR4WldnTStiR1RqdHhE?=
 =?utf-8?B?STI4Rzc0b1R1a2NPWnprYmRaNUtzVkRGVTU2UWZSeWFkRGxUZ3VSMDRQZXBj?=
 =?utf-8?B?aTNIVnlsNFA5VXlhRjNRVzZSTjJtbjZRNHJWOEQycXBjeTVPc3VrMWp2REJU?=
 =?utf-8?B?dGJWM3JoRlhWOUpHUUs4ZTg4U3hmcjQ0M0lCcFJ0WlBBOUllSllDQUFJdDZM?=
 =?utf-8?B?YUV4ZnlWTWh1MWozNE1rYjU3VVdvMmFNaWhLKzk2UFFxTGQzUFF0QzJsK09r?=
 =?utf-8?B?V3djQUorZGw3MnJ1NnBiUDFVV25XcDB3M0YvenBpdm1hY2twTU1uMy9mL3Zu?=
 =?utf-8?B?bnV2Y3VRMEpzUlBRQlFtOEF4SlN3WkFWNWptYlQwYlRJWnp3czdsQnZqS3Bl?=
 =?utf-8?B?aXJ0NXlLNVgvVkxXMVVKelNTRzJhSGdnSjc1UUc4L1Y1RUNiVWJtUGpJd1BQ?=
 =?utf-8?B?MEd5M0JPVW9JV3A3N3BRRjFMckttRU5XYXhKM0R5ZVNLczJzaWI4ZHY0Unhj?=
 =?utf-8?B?VG1ObER3R2ozYjhCcVkvMjBVbHlQWXRsVGJHR3R2MVMySUJZUFpUNjBqeDVi?=
 =?utf-8?B?L2VZMWNFRTg0cW5La0dGaksxaUpGUVNKeFZDOFViaVlwK3BYYUZjUkM0WDQw?=
 =?utf-8?B?cG8raE44ZUVUYm1WbjEyQjFWMTFaVEU0RnBIaGZOM2RTVVg1SkdQQnNlS3dV?=
 =?utf-8?B?ZmYyN1VDYTl4dk50WExvVVJPVnhsaUR3QXZTTlcyVnhmZW55eEs0ODFYOFBk?=
 =?utf-8?B?M2ZuckJBK1ozRHdGWDAxY2VrQmNjYzBaSEZpTE1sU0dHQlZPMW0wZDJSTGUw?=
 =?utf-8?B?Q2J1NWZrUlBWVHozcktLNERDdU5MNFMyYWk5UDFrY0x0NUNITjkrNWtVU0h6?=
 =?utf-8?B?WWZzRklKSjc5TUx2eFBjZUhuNEF5dWRVSUFHQ09LUklqaUFuUGxYUDdITGRk?=
 =?utf-8?B?aHowSDlDbWdPWFlGRXNNVytENjRhQi8wUzJNbHRGSHhaZTBtbHJyZC9iNy9C?=
 =?utf-8?B?SkU0MzFET3liemNYSlhVcFBIeWhHNXJFc0xVRHYyR2RXUHhFNjU3Y1hSZFJz?=
 =?utf-8?B?WU5oMExrZ0ZsTEl0RVJWazZlNHRneFNPbStYYlZ0K2FhZVRpWjJJUzg0Zk00?=
 =?utf-8?B?dmNSdTV1U2hpMHBLOGNGQTdjOW0xSytrLzdqQ05OclVjRTdFWjJLb2hMNGZj?=
 =?utf-8?B?Z3AzVFFhMDBQNHJsSDEzYmIrUS9RK3BNalZ1V2x2WTRQNlB6ZGQxKzRBMjlT?=
 =?utf-8?B?TTBkZWdQQ2VKVElXSnlrYmFjWkt2bmkxeWZtRHpibmd5K1ZCUE9qKzVUeitQ?=
 =?utf-8?B?bEFyK1F5T1Vhd1VCL1hONXBudDBvb2p4UEplYXBiZUZROXZUT1JMVW9BOXp6?=
 =?utf-8?B?WHFSY2pXaE1tN3dkV3JJcnN4cFMxeGF6bTBGV2FCeEhZWUViaHYyVlltU3Rz?=
 =?utf-8?B?K3V2KzZnamprdDFlZ2tDcHJMZU1nWS9sZlAvckl3OXEwR1RHZkxGZXJwcTNh?=
 =?utf-8?B?alhyS2RCOWdYRCt5blNsUXVMUTk0QklNL3F4aVI3WDJWRjdxWnI0RzJ5NEo0?=
 =?utf-8?B?eEMrdndoYTVTakcvZktENVg1b2xEN2VxYlMxN3NWaHJWQXAva2d4MVVDc0Qw?=
 =?utf-8?B?VE42Q2VpV29mSlRHcVpZZGdzNFNwWlJza1I2R3BTMEFVWnZpVG9CYVZLaTRz?=
 =?utf-8?B?dDBFWDlHUnZHeldLWUpOQm1nbWY0ZjB4N2lCZkk4V0ZFVnhGa3oxTUppbWFM?=
 =?utf-8?Q?N3knqPLI2c6oX3RJX+cuOMrFF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cebd643-0477-4961-b3dd-08dd2bc268fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:54.2490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNMok2D2oAy0ZNPRsZgGfmWBU/3Rph3dyWYyXQ0SWK6/+chc33C8RIVPxbaeCWps/MIuyWL6JqkX1E+BcgeHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10903
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

From: Teo Hall <teo.hall@nxp.com>

This patch adds V2X container support on i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a0681862098a6566a873873f24069b88..54ae7721888dbc93fdaba8e5aedc52c4506bb1c1 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -231,45 +231,62 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		debug("v2x container size 0x%x\n", value_container[1]);
+
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
+	}
 
-	return value_container[1] + offset2;
+	debug("scu container size 0x%x\n", value_container[2]);
+
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +296,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +329,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +343,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +356,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.34.1

