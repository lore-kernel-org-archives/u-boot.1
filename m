Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D91CD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863A684910;
	Wed, 17 Jun 2026 09:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Vvp74h1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF25803F0; Wed, 17 Jun 2026 09:06:14 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07D98491C
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJVtVuXWNOBU+6yCd5iVX6celYtQbxcbR9ikGpTp1mU65ultbAnpMTpScY6pMzVT21XWlx2HeQFPFoYTtQ4MxueT79CxUYdsPC85/EvSFw2akHQ5u39Wsr1OwaYkLFt2nhPDgV4wqphyHoQJDBR4hhECbHmMkOhggFXfe8NZr6j9JGWQbjIxgXeeXn6xMcVsC9LuRI4mAWLwrggyWuYqYv15IiN1RPm0kZC98VSx7DJJFbJTG4W/oJieFxQ3UNRXZ+hHMAs5ssnTqQkFj81pSzCl34SajfLAHRRfTZgLCZiZnGQrEJs2HMpIH6YNo2ffIGfc4p1OURUFzvaekiX1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8h0UP6cSqGCS5Fa+Ed4WoGgJZuMotibn5E0GpCQJug=;
 b=Nkoq+6d+0b4aYZltba+cykVoSbrLVlO45NxahLmsLoRaYIw1QzUStyJgFhhYSgg5zAm517pYWfmkVRNWxJrWgZ7Jlw/06+GUcWhzVR0chdzdM9127/Vb2A9+ezbmBdjL3Gq3QXVOR02CA7mOeyPuKnpgeKUsT3Jeo90UmICWYRSljmYDFCh7Mz1TUbtXQpxgA52GvHrIgS5kGwfqCOkj9+VNRbtDuD8t2PgHuqGgX5S8Af01VvetRwP/SASGuzQIPvfwjqZiGTL1jonsqZfR5PyY/t9e9y/ZtIHeIkdf35B3BbKHMm1Cv90C7XMpLH1yo0vAe97PHbrz5F/oUy4Tjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8h0UP6cSqGCS5Fa+Ed4WoGgJZuMotibn5E0GpCQJug=;
 b=Vvp74h1XtWcG1CXk5nXobvi7JTMTlMcGDpCyzzh08pNWQgAbbqbEE9Q6j4plr6xMC14RkBFsxeVSXwBpv50BwzAJXWzNVkGRF3XASXypMhJKWOvnxOGPLZwxWbOkJ9ni1SmyEW46n/mRMDyOs/Oo0yXqA2K8QJyr9HwPHaxb6emh25seIk6284sobaGvMUusSI8FDkh+hoGj2IAwt/vtzaksoPnfzGa5/37YuJzFGsHcEp1eLUzAAbTGOpp2sIFaeHl3eS+dE0Uo3mnSKCmXaP4C1RjRq/MFYsSEgIS8bN7dou6nvRqx9zPvW8zSa6Gg/KUz8loL0tB3/fWlcDYf8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBAPR04MB7240.eurprd04.prod.outlook.com (2603:10a6:10:1af::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:10 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:01 +0800
Subject: [PATCH 02/11] usb: tcpm: avoid hard reset for sink-only ports on
 Source_Cap timeout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-2-b824fe1e9299@nxp.com>
References: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
In-Reply-To: <20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0180.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBAPR04MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 736a4611-a8c9-4998-07f0-08decc3ee8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|19092799006|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p1CaUAMPqwrJGHJdGoukNjRxNGpZ6sxGTPsBvByk/8l97D8ta0y2feCSCA2R8/TGelZXiBEqLpFsbdG6qoGj9WwVlkrZj1sBYODV5XPDnT2jQVO/pIvn7UlHmnPlBFLOsjVi/vBEzlOboD7OEmrnfWWdGG+v1xBf5j6CRUyq01RtPdMbqBjLmvkzqsHuQAfwp904tNhhD3v+lxy248yIiJdUN5avrUK9lfAS+KGfgmEnt3/WvMqzkq9OgmxkqDtxMa6Ohzi0LjEeHOkqcr5ocMgrvio0J6UaGnsdOAosyaXL419fRj/txHn1frogQXzXEohq1AKFfyrqp6KaNKTiyCfEtsLe1b+7qiIm/FZ995kCtnA3XrVtuOZvIBtSVuej/hv9Kprp+pZeD72BhXYJUwYzWL5e59gdG6VKrbFHZceej1y+TEU/r979PoS9gIJYR411xFve/eY2qovz86QVJNPPIkwDrNwF38c/zUSGNK4eHtwqF3uyPspy3LGUyoei+I2ptJsxIkkzEHWmtbXFE411HjOxryN1cY5D+d5gNDNKGTdeplZl4L60QRiqEkGB6gWfU81+F+v/onKXnqHMzH446iwWppE1zMQos8l+dQv6nc6zHqeroj/li0qRAgs+7UojvpLHunAHoBMsRTGq1BOtbDtcF6eWohNa1TTbuzHu/JMNjwusGZZXpb7gjh7C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(19092799006)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZxNGZKcUN1alBXNk1VWkNUVlVJS0w2WHREc0NUWnJvVnU4Uk8yRkpLL3oz?=
 =?utf-8?B?eThKbHg1WHYrSWN2VTNUVGlsTm0ranV3azBtN1VyL3VaRlV4a3B0djJOWmpu?=
 =?utf-8?B?SFBPcTdkQ3YvUXlueVJ4TmVqZWZFTW9lZjcvUmc5bDhsZXNJMDVQdW9SRTNj?=
 =?utf-8?B?d1ZXcTZMMWtqeVNjL0FiQmZHVi8vbDlZN2lJU2N3U3l0UmNzaFlwSHFWQkc1?=
 =?utf-8?B?bmtuRjBKQU95S2pGNEQ4MGI1SE9xMEVSaWFMZ0MyeG5JUVpJYno3Y241QVVC?=
 =?utf-8?B?MTNhMFNJRnVLVG9OOHU2SS9iWU9vREJDZm9vUDlYa0RIWDRwa1krL0FRTWg1?=
 =?utf-8?B?OXhKSWZBRSs2KzJxZGtCWWxRN2k1dG9lUjRZaVZ3MTByMDZtdUZ2N2xEaDFR?=
 =?utf-8?B?U0hsM1J5dGtWQyt5KzBZS21aK1lWZ0tXVVdITEZwV2NZQVEvdWpIc3pzbkR0?=
 =?utf-8?B?aUQ3L2lqbVkyM21nTVpHNmhjVkJ4UlNIZ3FsVmx4cjdhZW1uMkFFTzhSc0k4?=
 =?utf-8?B?V2Q2NkhNYmQ4ZGNiblFkZUd4YkVZVjV4a0RpVVpYZ2VuNkpoMTBHTVcrVGIz?=
 =?utf-8?B?NCtpOXVEY3BxYlF6YUZrbUFwOXliYVZHYjVKS2RVREhpYzRkL3B1TTdkZFMr?=
 =?utf-8?B?LzZWTkRNNlRFYjRoS3cyaXZ3UDhjNzl5VlFsUWd4R0FiaFNMTm9rUUpLUHRD?=
 =?utf-8?B?NWdiWHZ5WU5tdUhiWS9HZlZGVjBJWUtCZkRFUWFpL3JOQVZLK1B6QXhLZTVO?=
 =?utf-8?B?Q1Vpelg3eEZQUlVVZ1EwUERLSmR4bGEyalRjVk5EVmEzeFhraU9VNkdmZ0Vx?=
 =?utf-8?B?R0xPdURSVlBNY05EeXJGbFdLS3ZjN1d5enNCL1RITGVCMEgrVnZmTXRVbkFq?=
 =?utf-8?B?ZEVXUE9lL09rOEZLSjJaNjg4L2dGK2FNS1Q5bnBHckI5NkNIV01FN0p6N3Qw?=
 =?utf-8?B?V1dRcXc1ckJvMVFwN3YybjVFL2QzVjdscUNlUUtMaE9TMnI3T21GZis5ZEtG?=
 =?utf-8?B?cVFESHJMTE5SM21kRUpRcy8yVE1PVG16U05FNVdxdVljQlIyNHJUMjVEQWkv?=
 =?utf-8?B?V3M4ODVLeDM4d09aa01CL1JlcGJqRE1oVWhHVmhzczdpdldnV29KY1JJNXlD?=
 =?utf-8?B?Nk5OMVBWL2ppU2Fwa3B2R29kdytMdEhsaVdWcmZKdEQyano0MEZPbHZ1SXdE?=
 =?utf-8?B?aTFkckdzNUdxQTh0MG9qcUJXOUtoT282VVhjeDBvTnZqSldYMlBXZFNCdXhl?=
 =?utf-8?B?VUlQSEtNY2lRNm5EbWRDeHFSc2ViZXdXdVUyRjAzaFUxSkJKd3FxMDlsNjRt?=
 =?utf-8?B?UTAzQy9UUVRpUmlOM2tWM0tlWFcxaTV6UEwwTlBiVmJIS0FJUVZsTmNGc2s4?=
 =?utf-8?B?aWl1UGJOTXRqSUxHS0lmSEJ1dWZFR3FOb09FbGNCUW5uKy9EaGtEd0FYWDYx?=
 =?utf-8?B?WG5CWmQvTTRrYkhqV3JrOEQrMGUzZFBhamRhV1NxRTk5Tit6Uk84eTdGYVVm?=
 =?utf-8?B?amxHZFZKUUdOMUlmc2krNG5MUzZCcnViT0JXeGpBaEpzbEV0bVFOVThGa0o0?=
 =?utf-8?B?ZTQvTGs0dzJSTkJ2TWVLWkc3c1VCTWt0NWhFblhYN09YWmhnZXYxa2FVYTBB?=
 =?utf-8?B?NldOdHVwbW1ldWpPR1VRN1NXU0p1L3Uwb29CWlU3WnNQM21MYWY5TnFOSnJ4?=
 =?utf-8?B?SlhoTlBTRzMxbWUwUytuV1E1d2hkNVpidXVNQitUZ3pEZHA4VHlrYW5RSmJr?=
 =?utf-8?B?ZG1IUEhrc24zQnkwZlVHeklmTW9DNHF2VlE3cHhEVG9JMU82VVdsRXl2K2M1?=
 =?utf-8?B?K2lUWC90L0ozSjNneHlrVUl3OFREREd5TnVLN2NHZnZ5VGdBY243ek14Nnk2?=
 =?utf-8?B?M0htMG4vODEwTTV4ZUNYRFozZTdUNmZBcUVWRTB4Tm9aQlNqNUtkRGF5Nlhy?=
 =?utf-8?B?T0Ywa3g2RmEzbWlndlhVUktLaGN3ZmVRbDlBVG9ncERnejR0dlQ1Wkl1VC9B?=
 =?utf-8?B?RVNKVDRSOGVjd1ZnVnlYZEkrZWtka2dreHZkOXAvbXM3VmVxWXdsVHJwZTAy?=
 =?utf-8?B?N3RLSzlNTDJaNmdUMkl6cTgrOUJORXRzaGxwdklYSnN3K2J5Y3ZoWE1CNUEv?=
 =?utf-8?B?UzBTV1JxTXVkcnZhamhUbUZkVXJaSTYvRkkvUWlYRHhFci92dVAxMEFhVDBB?=
 =?utf-8?B?dFk5YU90WS9KTmhyQVBxUTduaVNxM3paN0FwSkNMUEFNbFY5MGdqY3UrQUhW?=
 =?utf-8?B?dDd4SVI5OWhMNzVsd2F3emsyc1AyTjJjU1Nvd3Btancvc0gxbi9YWVNxM0Z1?=
 =?utf-8?B?c3dRZEtjNE9XdmtPVkN3ODhkT0I2Ym5wMmh3T0t1K0ZqS2RQazdFNE1nSEdJ?=
 =?utf-8?Q?T9Agc4qVszR4XGtBNEHbgPXm4Z/kkxHUJ9aP7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736a4611-a8c9-4998-07f0-08decc3ee8ea
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:10.5041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S8So9enssz1TfJyxkwuPfGxSAxmRzk1FZie0zX/iKIkrhPMh2RWsXJvyVckllsb4GxrJEen+SIaJ+jmsbfsZePDUAFvnlRHkFetbdnj1NT68PVVz8yhjvM81nA8D9NI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7240
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

When a sink-only port times out waiting for Source_Capabilities in
SNK_WAIT_CAPABILITIES, the current code falls through to
hard_reset_state() which sends a Hard Reset. For sink-only ports
powered via VBUS, this causes the source to cut VBUS, resetting
the board.

Unlike DRP ports which can potentially recover by switching roles,
sink-only ports have no recovery path after a Hard Reset induced
VBUS loss. Instead, gracefully fall back to SNK_READY to operate
at the Type-C default current.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index d6c0be82333..25ff0926cdf 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -1647,6 +1647,8 @@ static void run_state_machine(struct udevice *dev)
 			port->vbus_never_low = false;
 			tcpm_set_state(dev, SOFT_RESET_SEND,
 				       PD_T_SINK_WAIT_CAP);
+		} else if (port->port_type == TYPEC_PORT_SNK) {
+			tcpm_set_state(dev, SNK_READY, 0);
 		} else {
 			tcpm_set_state(dev, hard_reset_state(port),
 				       PD_T_SINK_WAIT_CAP);
@@ -1770,9 +1772,13 @@ static void run_state_machine(struct udevice *dev)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		if (tcpm_pd_send_control(dev, PD_CTRL_SOFT_RESET))
-			tcpm_set_state_cond(dev, hard_reset_state(port), 0);
+			tcpm_set_state_cond(dev,
+					    port->port_type == TYPEC_PORT_SNK ?
+					    SNK_READY : hard_reset_state(port), 0);
 		else
-			tcpm_set_state_cond(dev, hard_reset_state(port),
+			tcpm_set_state_cond(dev,
+					    port->port_type == TYPEC_PORT_SNK ?
+					    SNK_READY : hard_reset_state(port),
 					    PD_T_SENDER_RESPONSE);
 		break;
 

-- 
2.51.0

