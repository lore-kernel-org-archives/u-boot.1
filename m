Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE64E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78ED805ED;
	Fri,  3 Jan 2025 07:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UQNkW77V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEAF805DF; Fri,  3 Jan 2025 07:46:46 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D488058A
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:46:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GN+jwHzH93naoaOtNNWD0oSH4K2N7Vcn+8QEf9R/qoABg/luRIhwFZgOI9FPsXysw01EPmMhv7W9J7QKyOQcKQqw3lEXcO3RsKawwQp/QO32C/H03sxit1aydZSKKup5yPaBJ+mKQndNiY08GfpPdv6/AzhrAyLJLhm8vldEXMxyFDnP0D/j2qmYFqRHs156g/7C6uNZlFFFBLWuIASMP91buHPyDi5UQFgHST46jg3xd6NSn+pPSMlZ6E/PmwWCTrD4anFK355npU+eZIdTSf3mxtSzt6ktMe3Fi5WNLymDiKS4m/jkXBqAN0rTH7KTbSzzQkeBnAoOaTO2dObj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=lp+2yZrOCxOz0LoY4yE3eQUewtf4at/wbICvQFi9z5lW8qtG2KnsK8JE29dLkG5b9VtWLMshXdsn6V23as7QytRsHXQfsBjBPGaWDww5+C/Qjb4H7zzuP2sXRgXAe9xDCikLncRTMGtj3bR5o13CU/sClKm6EXmmk7M4GwqWZWAIfVJNLY8tWyUR9B+z4ci1l3UWlHyEyAjfs6SjYbDcW1Xw53p7zco+ggjnsvoSd1qRjm6JdUzc9ZGnYKgIf5YdlqeW3lwsBGDZNe98Jt//+mXbhBPH7vVRWIAprcpsSI+4yo9G8K454hVm40MDLjy6/uYs5fRRpXXwI7fvz6In1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=UQNkW77V0spoMj7OOYbBgsclsw+PwXrBnV0S5OXLxWfoVDih/TuXD7xhQPfj32KIEGb/VOwWIstDQNputQqDRf8yauAkq3iCSKGuBS85xBUbIfo6FJfkmssMWg+GTXKgZSzE/XREO2p+qsedf7qK+JIa1f8Y+G5Kp4brWpmflzamYZ5lU2Esei6KQb5vgkui0agmwKfmREQOw0gxae6Q3wDH8HTABKTAu1p+8EoivAfVSUhpTRqAqkorp9ewqDEh9Gk1sSorp6T7JFt0SZ810db040VkcseDtxEfgLBIjyv6mDd0A0sFG/MjvRpx/S8B/7+s6tW/UeiMZUh5vPgSUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10903.eurprd04.prod.outlook.com (2603:10a6:800:265::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:46:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:46:38 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:47 +0800
Subject: [PATCH v3 12/17] scmi: add the macro SCMI_MSG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-12-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=1060;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=04Fugt2pLh/tOsYnH9qSnBxxNCtFxPv3ln1VhqSdivE=;
 b=axoTdjb1Iq1WDlDvyEIrelNWlwf5Bj/BQJTSboObljod385YtW+owTB4gK/L6m8UITvme+yUy
 sBvu2agGNf1AG0jma3vgDw/VQeKdrYRtb6PAi74kHViaCwwBWm4otIz
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10903:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fd5711-034d-4c58-1ba8-08dd2bc25fc2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXJYbXJZRllJR3dQdlRPd2lUb0xwR1FJbjJ1Z0Q0REJLSGUxMHZoaEs1Nk9O?=
 =?utf-8?B?N2dpMGcrbGl3U0gxR25pdmpJV1U3VlQwUERwRHlEOVVzNzdpVmNEU2tQUHlR?=
 =?utf-8?B?cFlvTG5pZDJYajBoRm1lWkJVemNLRElPMVZzSFZ3SVJFV2RzYzVvejJVTDRC?=
 =?utf-8?B?QkU0VHFLZEZ4MEorVHl3dkhEZzhJR2p4T3VmWURnZWRIRGYwWmJSMUJldGM2?=
 =?utf-8?B?T0lvTi90MW1Qb2x5eVVtdUtwL1RDMGV4TFNoUnp6TFdscTFKWks2VnlqK2FO?=
 =?utf-8?B?TFBoaDNsQitEUEtuWW9kNlZLcjlRcXZxY1gyV2M2RjN4SzgxSTRYYW05T2kv?=
 =?utf-8?B?K3pncXE4MkJvZHJUVGkzZTF0eTNWYU9WekJzUktrOW5MM0xweXh1UG85WlVU?=
 =?utf-8?B?UTZacWdueHVyMExBOXN4Ym5DTE50VDRvcmxLSVhod3Q3a0ZUam1FMmxnUVJN?=
 =?utf-8?B?dTlwMUY3OWRzanpqbnV6ZklGa05SQW1TN2FIdlEyNUwxZnFUWGVpeEFxTzdB?=
 =?utf-8?B?S05aejk1S1dFeWdlYjhuNVV2d2xhWFViQ1FqQUFPc2tDZGJWSEl4SFZUd25n?=
 =?utf-8?B?M0VCTHhJSFdqN3NJZlhRbjc2ejIzbm5uaGlQYzBDUTc0VnRkaE9xQ1hCc00z?=
 =?utf-8?B?WVZyUzNVRFYzdHA4ZStqZzNDMHFpRGJ5UEpmcVdoajZKVU8xWWRJYXBsNkU1?=
 =?utf-8?B?bWovUCtMdDFGRnV5eC9lZlhKbUtnTndGRHkzK0R4ZXpvMjhkMUZKUjVYbTkw?=
 =?utf-8?B?amRPSjFpY0ZId3dOV1VwSnlNUjBIR05ROFJQdUh2NlV5TTREZW12Uk1wcS9M?=
 =?utf-8?B?NGpSd2pKRk02ejc0ZGk0S2Jyd2NWU09vc0tPUVBwUExWZ3pjVXVJY3hRME9h?=
 =?utf-8?B?U3h5MnlYeTNRbW1DbFNXZXczRS80TXhVdFBFMXliRFdWN2ZMNGg2VjFNcmpQ?=
 =?utf-8?B?TVVvTW8rdFE0andPVmRMMGJnR25IVm1FN214K2lGQnhyZk5mUCt4U0RydEVw?=
 =?utf-8?B?S3dWWjUrVENwSmZ1aFNjT3AyZTR1cU9aTktWMFFmaEdPS3NVTktBRHhMUlkw?=
 =?utf-8?B?ck43QjFSV0EwRnh2TzBqZ3d1NWVNS0N5M2lEK2FEL3JXTTBabnc1cndiVkRu?=
 =?utf-8?B?OTRmVEFTRnZKY1NQQi84V2lBOWpnNnZ5K0xZQ0NkZ0ZqYmdkSW5XVE1vMlVk?=
 =?utf-8?B?SllETUp2ZjFkVCs0cHNEZzhZR2haSzJzakZHV0VxSzJDMlZ5YjRGcC9wRCs3?=
 =?utf-8?B?c2w3eFk1bFpDbnk3eTFKQkgzNVlhbFVpSktTSGM3UnlRamdzNVFWQXl5bXFK?=
 =?utf-8?B?Y09IZDgxdVJ0NTdYOVZtaXp1bFJ3QnZsM2oveHkxb096bVVWMEVQTWcyMUwv?=
 =?utf-8?B?anFBelVLbE5FZHNKTE80VTdWejZ0UmZMQkhsVEpRWDNQRjk2MkpQN3BOWjEv?=
 =?utf-8?B?KzRtZXBQV0drQlNSalAvL0NIaGQrVVlOZk8xNWdYaFZ5WDRjdGdBelVmNDN4?=
 =?utf-8?B?MlVIQ1RHRlVrZmJKTURZQ2ExK2cweGJycWJCRFJuS1NTbmRsaWFvUEtFOW1X?=
 =?utf-8?B?MUplZlRVcExaREJST0liS3RicUxkeGVTR28rM2ZaOWtzVytZblNVaTJIN3dK?=
 =?utf-8?B?eTJnbG5IcnQyWEZVNlRRNXk0RU9aRWN0aXdkUE9WdlI1VWJPNk9UMFZ6NUda?=
 =?utf-8?B?eS9HYVFFeTlBOE1ja20rL1ZiUS84c3A5YURCZUF4VlQ2Q1RONXBRR1dsY1ha?=
 =?utf-8?B?ejRnVjJrY05OampIVE4vUmNZQmVxNWVkaFcxNTFUS1dvT0J0Tzdpak8vK09O?=
 =?utf-8?B?clhtcGRDQVNGNEFWeHVlVm16NzZJR2NYa3ZDaWxDN0g4UDdoQ1E4M1VkVDIz?=
 =?utf-8?B?aEZMbnFVWWVMdnMxNnNSckxJS0h5Z2s1TVBOdjU1MzdVRlpDQ1BGRTlnL3B2?=
 =?utf-8?Q?kjG7xVCU6C+DbD7D/3CAsKiF+6Tn/w/w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEt5cWJHbnhCeE91bnNLWFJHN3htQUhoUjBCOHBqYlZjRUpmQU10bVpXeEhO?=
 =?utf-8?B?S3k2RE5CSWdLY1g0ZTVSeHlIRFhhL1duT21qSjVEUDg2c1ZIcWU2ZDdOTWIz?=
 =?utf-8?B?RHBRU1JuQjhmN2U5NzVmYld5SUFUaWFibjk4NUNqaW12Z1VWT2haa0hsYW5s?=
 =?utf-8?B?YWFFVkQ0dXNGMVBHMjRRQTBkcDBnUzkraFNqZnN1dllMVEEzZWU0MWtmL2JD?=
 =?utf-8?B?QldhNFBZTUo5MEZnVmlUbEYvVVk5YkhNNXpWV0FCQnJtQjRLOStoems0UHNC?=
 =?utf-8?B?UUI3WXAvSjlNbURBdk00SFZ4WVFucDV4Vy9UcStjTjArQ25OQnk3RFJIanl1?=
 =?utf-8?B?cDdWYkFMbTNqNW80Ykg2MzlvR3BCdGoweUR6Sy9VVkJTVXFQcThBZVJNYUkv?=
 =?utf-8?B?dzkyTVNSWXlLZHFCY1dpTHlzdGYwVVBtaUU0RDNEUG5lTEdVK1JMUXpWamVi?=
 =?utf-8?B?empuellYMldLSVhVbE80WFUyelpmT0V5SkR1LzB3SVpJKzV1Rmk2aXR2S3hW?=
 =?utf-8?B?T2xZRjdWWWxOc0tZbUJWYk8xS0dkL0tINVpHYUhoak9Rckw3S0dSNThqZE9y?=
 =?utf-8?B?ekxkM2FRaGVKSVU0TnJpQ3BsQVFPdkZiUHhvNUE0OW82dTBzbml6VmVOakhi?=
 =?utf-8?B?Y0l6eWFUZm1rU25sTEF3NUZ6U3hqd1hvcHp5VXppNEo3b20xQ2RaUk4xZGpp?=
 =?utf-8?B?cDUyVFhXMkg5MkV0V25Sd2RrMW5XSUhCV213dUxXNnFRSDNTWG1HZnRpWldo?=
 =?utf-8?B?bEViYmh6TXgvS1NTbXFVdUtnTGxqWWQ4elZTVndBUWtZZGhPalY1OVlVd0Fv?=
 =?utf-8?B?ZVB2RG9VVllLdmdqMElydHgxN2JWWWVPbUlmZGhLeEVySWg4dGhvcXIxakFy?=
 =?utf-8?B?ZE5mTEN4MU81MVE4Rk9qL3RlWG5lR1FZNmdMZ2hFSDlxYXlhQ0VMb1RNdW1w?=
 =?utf-8?B?UjBQc0ZSRnZWVG5SN2YvWUhMTHhPQzhIKytpbUhxSUlpZ1Z5TkpES3hJaklD?=
 =?utf-8?B?T01QTDUyZ2JBOEhETHdnVVVidElJL245S3Q4M2N3cUQxQks1bk5lRUViTHA4?=
 =?utf-8?B?UTNPYlZjYzRndHFyb0U2ZDUyM015OWx4cHV4T2s5eUdya0U4U2ZxUkpvNUdw?=
 =?utf-8?B?bTE1eCtsMnhKOUhjWXBUazZOOGM2c3R5L0hXUUhFTFhTajVOTERReHBuVThw?=
 =?utf-8?B?YWxuaWllUGRvekRSaDB0SWJzZFF3dWozb2tFbzdPbkc2VWx5emRScHQyUXMw?=
 =?utf-8?B?ZTJoMUVIVDFRMktnQ0tCQlZJRkpxY3lVWW5TNjRBNmxMV2pMYURaelFLZzNJ?=
 =?utf-8?B?SkxMTmlMQkZTOFFBY21lU3lTOHo5Q0FlNEFGUmdCbzVJRGNlalBpSGVPenQr?=
 =?utf-8?B?eUlHMXBVdi9UZzZ1NnJrbElYWTF4MnEzZERIenAvS21wS2NMUlkraFlCeEhO?=
 =?utf-8?B?Qml1S0F1dUlFdFpVWmwzRTROUm5ReDg4SVhNcXk5WEowT0t0SkgyZkNBdmFN?=
 =?utf-8?B?aW42cWFJRkR5Z0lBbmVtZkEzeTRFS215RW9vd1BDdmMvaVZiZDJYVGMxQnM4?=
 =?utf-8?B?Y1pOY2pLOURMWERyTGw2R0lnby95aXN2b2d6MjBBL3BLMEVWVHNFZWR1WGJD?=
 =?utf-8?B?SHJBR1NlZ0hYZXN4TGZnYjBwRlZVY3JhSXpaNXdDVmlPN1oxd255TEF6eW44?=
 =?utf-8?B?K09sOUVSZGQ0QzV1Zk9ObnVPTVMzY2EzVG4vaElOYmJEWTZIQ29HQ3ZBS3Bu?=
 =?utf-8?B?R0IzRXE4MVlTeVIrOXROeTJKZDhuK3BuQ25ibGtiWFpXUHBhS1ZkdEk0R09V?=
 =?utf-8?B?WEZ4K0RMRitDTDNMSDR6OFVWd2k1UUhGMDVGZXlsd3pHcEd1em5oVjhKMXVL?=
 =?utf-8?B?RHphYXROVUNFakI3b3NmR29DcCt4SGdWZEVndE93eEZBNDdBajdUeFErOTZG?=
 =?utf-8?B?NW82WnZ2RGN0U2hWOEtBSTJvR0dWSHpMYXA5eFQ4RHRPSkpXWmJGWkd5em5V?=
 =?utf-8?B?Z1RIVkNVeVVkNkI3UkZHZXY5VWxPWXNEZGJhZ2VyV1BvMFVDM0dDSG5JWDY0?=
 =?utf-8?B?U2duZTBwOENqQ3RwSWdqNi90clVldnNrN21CQXFEcjJMbjhzMzFrVEMvM3hG?=
 =?utf-8?Q?jsK0ShWq83MRdrU/DcjOV8STl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fd5711-034d-4c58-1ba8-08dd2bc25fc2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:46:38.7622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS6nSJ6FYQXawoVtMRf/J0nnM14bl0Zrt52GGT7MYDyw3cZCT7JQI3BpMbVnP70SlEO64fOxe54GesHgu7tN2g==
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

From: Peng Fan <peng.fan@nxp.com>

This patch adds the macro SCMI_MSG for protocols that do not need
_in_array.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_agent.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/scmi_agent.h b/include/scmi_agent.h
index 755986d6c424ccc881ac0943a88735cbcfacb001..5508a126a6dc504afa6d896c78c760b1af0d3deb 100644
--- a/include/scmi_agent.h
+++ b/include/scmi_agent.h
@@ -54,6 +54,17 @@ struct scmi_msg {
 		.out_msg_sz = sizeof(_out_array),	\
 	}
 
+/* Helper macro to match a message on output array references */
+#define SCMI_MSG(_protocol, _message, _out_array)	\
+	(struct scmi_msg){				\
+		.protocol_id = (_protocol),		\
+		.message_id = (_message),		\
+		.in_msg = (uint8_t *)NULL,		\
+		.in_msg_sz = 0,				\
+		.out_msg = (uint8_t *)&(_out_array),	\
+		.out_msg_sz = sizeof(_out_array),	\
+	}
+
 /**
  * devm_scmi_of_get_channel() - Get SCMI channel handle from SCMI agent DT node
  *

-- 
2.34.1

