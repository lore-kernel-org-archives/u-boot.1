Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A46CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1232D84949;
	Wed, 17 Jun 2026 09:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F0KXXXv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE10803F0; Wed, 17 Jun 2026 09:06:30 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE650803F0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqIcdBTauetdEDRGajirgijx7mFAGH0n1OHhPUmUrzLNts/vklEvb6P4xIK8lfPdCg6xKOXH3mSsPqQJP2dEZ8pTPCCC0jxNTuRm5YYLEERJYCqM7JeSWhA3AcYCJXm4AfC4wtKBGNsu+3bA+1xfmq7ziZYf+AirHPJylpsQno1HBzgb3VcPtiCJ1rtG3OGX1XkQ9BW7fLMjbEyhYGrfxFaeUABzVJaymh7CxqggsvOue1EACLPtXnptCVRvNwUo6gMbsCNpQjCB5Vc66Sme1EkLzCcVyKpOkfFKoErPjymdP12f5O3hKR6X9svz0OieFkr+Q8JifHLduBFUTiF5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gNONLE7ke1619C2KvNDbQVrlXX15NdroVPbrsedmLI=;
 b=aHQ0WRtzaQ8NTlGgbqzSRrAO0TuCodoBaCNraerKsV9cgtsTqXHu4NgVn5b8UKaL9Qc0sY8qhjcBeoE418r7+DkBZtFyI3tor8+xcxCQj43cUDZL6jHaXF98EsT4uYlYq0CwYYlIc9qW28GP6m61V9NVUGrry/7cjvXTfzNVe63rpm1kaFj6lCXV4RbbstvSyGHQyiCTrgsexooFC0zU1bDbxUex0spULyNXo2UOJ2TcdDmJXtClpHujhGvvZQdGfA4ZAfOXAWqx5odUrNztg4x1QqrFpoRzeQn+NNWUMQNUAKjZtfDoXihSnf4IZMzYBh4yb3L7lDKPh5a6+lA2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gNONLE7ke1619C2KvNDbQVrlXX15NdroVPbrsedmLI=;
 b=F0KXXXv/6By/0EvNO4jPP+GTKdrG9m9nULiS9Vp+q5rmymDFKv30Iq0LTsuJeiXexDM4tShXy3nX38EOYts1M7d2q+wUBPJHKrPL5WJyiUapYFOWrN30uCgaXhNTEwkbAi2fkiUYI56/VT4utKXwMB421osW5dBKEaSF4l+C73wTXj1kSRf2jQ49Wk41BxLgeDnFnXlPTB9x8/A1Og5KBlsrIlFWH+yYis00Bp8PGZOCR9SLVNyL9AHU8dFb6fztjZylsuflo58VjU++4QP1XpG0e4V6ZiC2UTuIQSn1mcV/DMlelMC/8tYZ8vCo9JtnO2hq3hiMEvAs338RgaMeLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB9906.eurprd04.prod.outlook.com (2603:10a6:800:1e1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:06:26 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:06:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Jun 2026 16:23:03 +0800
Subject: [PATCH 04/11] usb: tcpm: add lightweight PD negotiation tracing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tcpci-dwc3-v1-4-b824fe1e9299@nxp.com>
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
X-ClientProxiedBy: MA5P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB9906:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2ec0b0-2cc4-49a4-c942-08decc3ef290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: AsmcqwyaQC+akC1lVXVIwr1G2QpX9M238X93YvyzSFETmBR9ErPxxQSJdjwCBnkCNxQi08aIWB8qshySsn51zDM5lBummXa4fDZU/CcmQb0EB/jpHEFqZZYOViMjLCCMqSBjDpUB6FbhVya3MtwUvEZ9ugnqYhzDja5V+hwdevyUG+vmIV3pHtJRAnlQV5lYasAqJ8UBxmszzjpkwQaH25GaaZjZUxHLqq6FazrsS8va/gNlibfAuOW22BRITKNprCH5Ji18i3DjqTBAxLiBtSk5bobYyAB1xOAYfSwV01wfQze0LWKqs0T0YQxyMNtIuCknPO6flBzJnAwt5qPFTcOQbc8kwHm93BMWoBoTtO4Mq/YwrZjj1kBDnxyxHhfGv9YuVwHD9wLtIqv9Dtdd3fkkD8MrwmnsLdErtMBUa6nuzxxZiy8k0rfBGVAQFM6UdUfHlJFDLYBo6eBx2sKZlJ7pLMXWT0SGFG3fBNz/O2xjAE8CMEbfw5LsPPN4sihruUw5VmUxh+3r/D1d4J88gxT1kcvCVJwOefsbTOJVouLTbimjmNY7NC6j9a5x5xec2Qulo5Rr/5/J2ZlvnX9FP/OC2Z15W5zdoT+BC4nY38gZDTJeTsbLfG38K2drLiKLq5nlS4/4/09IZIh+x+s8HZ1POX5B7j7DGdOLkNMfc+KxmRU9iP1eKmQKlaLaKZ7S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1dUQ0hCU1ZyK044SEN5OWljWWxnRmE5U1BFSTFVVVFDMlBWZkRzV3ZQem0r?=
 =?utf-8?B?THU3QlNyZjYwRWc5bWJYVUY5R1JnTUdvZXJzc2JveUp5OHZMTnMrNHo2Vytn?=
 =?utf-8?B?NC84b3ROa3pZa3ViaDVxUHJleDRxSWZpMUM1NHN5L0U3ZVMyNWlYdlY4NFdZ?=
 =?utf-8?B?b1AxQ3E3Qk5wV0VxR05FYWx0dFlWWU9naU0zeGg5bUR1OEdVUjI0VzJLcysy?=
 =?utf-8?B?ZWtxU2dWczhNZjJOdjVISjdhVEl6dG5hbC8wTEJqbGQwQ3F0Q01rcDJhRjhG?=
 =?utf-8?B?ODd5MnR3RTJLcUV3Sm10ZUxMcjloUFlNRE5rTHdDdnNubGdsN1VRSDdyVVh1?=
 =?utf-8?B?TC95ekhBV1lKbW5SZ1dhaWRBS25iOU80NlF0TmlTVXowZnFMMk1vaURUMEhI?=
 =?utf-8?B?U3RNMndnVm52NjFEQzE4bkZlMkhTc2I2R2pMd3ZQZ08vbWlTVTlrT01HcWpF?=
 =?utf-8?B?UlhNZjdXemUxVTdMUUw5WjR0S3ZtOTBPQ1dNN0VEd2ZlRng4eGJHWjRwYnR5?=
 =?utf-8?B?Yk5ERnQ1bjRKVnJkaFY4VFlTZXhTR3M2dFRWekNnOGFpTHZXN3dFR29ieEY4?=
 =?utf-8?B?WmsvNW1QYkY1WGtueStvVEEyNndUaTNEcFcwZVBLY0cvdjkvSDdEVnk2eWU1?=
 =?utf-8?B?cHpmZ1NwQVRoUXFsNytGYzVzMEdUOTNJK2ZkbkNteDdhMldKU2dDSTdoSGVi?=
 =?utf-8?B?dDdTSFQza1dCY1hRK1dJN0JqRDYxbUVpU3lwQkNCQWlwbWVMKzU3aUdBVkRu?=
 =?utf-8?B?TEdMazlLbTZUcnFQYjRHdWFHeGpXUWEyc0hSVTByV0lUazNuODhrNVd1QS93?=
 =?utf-8?B?bEIyb3ZHcWxyeGpwU0dzUjJxeWY5dWFxdXRTNFEvODNLSExnQ2Erc00vcmlo?=
 =?utf-8?B?dTFtR1hnQ3J5Y0Q5VEtUV25naUhEWUk3R0luQ2JzdDZFRVJ2UjdhS0VxZDVM?=
 =?utf-8?B?alMrOUdZcnl2RWVzbE53SlJib1ZUWXVoMzVFblF5SkRkdHZCc3M3VzcreDBP?=
 =?utf-8?B?M1VMVXhKTXJycHVVVVZtTTgyS1ZqYkthTVVYeklnRmdMcDFoaHZ1NFhOYWIw?=
 =?utf-8?B?S3dVS2RMaFBuUzZOVmVpWDdBbEovK0VCTFdxbU9lZlk1ZUM3RWZjNWhFcW1T?=
 =?utf-8?B?ZS9wRTVkdnAveHJoSFQxWnFoOTk0U2VUUU5hVEpoSWpnZUVKbDZOOExEeWJm?=
 =?utf-8?B?OGtub00zaEtPVzZTUGNrMWdiY1crSUFNWStEOXlGN0NHN09uUFdEdFVuMFdH?=
 =?utf-8?B?UndKVjM2WXlWL1R6NVc5UU9yTWxVNGVpend5a0ovSG1zVUtxKzRkeFk4WXJl?=
 =?utf-8?B?SlplaXlaT3JtR2xLL2VpRkFEamVEZ1BBU0ZRZkJ0OXJGWm5YRTVhQjNYSUdT?=
 =?utf-8?B?cG9qdlV4QVE5ejVBeWFmMEY4b1cyTmhMK056RHNPRE9IMStMSWd6K3dTcGZI?=
 =?utf-8?B?dDdyenllUkxqcnR3Tk5wL1U3OXA1SlhtclFScDN3RDc1MTNvNHQ2SzdZeVFx?=
 =?utf-8?B?VzdCRnpjMEpzc1FuTjhXbE9wZU5Od2ttK29TR2VIbXVudmhWWjQvRmt3ZEo3?=
 =?utf-8?B?S1FMTHNub2NMcUdFdHNudUQ2b0NtczVWY3RrKzJSeHNnQnhRYklPZjMyaklS?=
 =?utf-8?B?cWttMndtdnFzKzhLcDdIMjVjYllvZVZyY1VQSGlETmc3a2krNW5wRUNBTTRB?=
 =?utf-8?B?LzJ0WEhQTVpGM3lIbDNmN0M2dVM3S01OZUlyaDJRanQrdWdONVU4RDBoK1JU?=
 =?utf-8?B?SHIwbzh5aUlSUWdhQjlFd3MvMFM5cFBIWWNHV1FZNEczaTlXWVlsNERjM0du?=
 =?utf-8?B?WlpxdWppVXgwajVKV3N3VEczR0toeW11WHVNYlRXR09jOFpmWHFuTVdpSUQ0?=
 =?utf-8?B?bTV0TzVJV3dHdGM5Z3NycndSNXA1YzRETU1QcGxObGlmSlpkRzRMQ0pWbGpS?=
 =?utf-8?B?Rmdma0xzZUhobjg2cWRDdVBOdGJ5OUg0Qk41STFGQ0V4RnkyWGV5YUUrZmZC?=
 =?utf-8?B?MmlmVHh1ajRWTmZnVHlKQ0tlUGoxVHFJY0tKYlVHSElLbWhMMU9ZZEZ3VlRD?=
 =?utf-8?B?Mk1ZaWwvU0taajR1SmRlb0MvUmVUaVpINzJPOGlXS1FBbDNtRGZvTVFhNSth?=
 =?utf-8?B?VjJiT0pNOFByMmtuUVIwL3BlOHhBWXNJQytuMG1NSTBSRHZlelhxVHp6Y0hL?=
 =?utf-8?B?MFJ5OVl6anVIc3AvUWhSZm1OUHNnUVcrc3FLNlpRaU9NQm5NaE0ySTRjZStr?=
 =?utf-8?B?RFV5L3ZQVDJpSTBNdFZwZVRyQytoT0lqMlR3cVNpZUZhMzJIV3czcGNCTVFi?=
 =?utf-8?B?c2RBRHhVSFpLUkQzSVdBRElXMnRMOTMrVzFDT3IwNG16UVpRMnhWSlN5cEFj?=
 =?utf-8?Q?w2Tyd33brFdrjQNj7zBoxyRUhAzazSrtb3sAs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2ec0b0-2cc4-49a4-c942-08decc3ef290
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 07:06:26.5005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qO5TKTnAdkCMEnL9h5ANqa0eRl/Vk4M/T+UnmxszXez245mxYVNfVXiHfMEFOgIE9WzcXCDfNYuAoqnal/NW2S8tLvkGypmfwpDmEq6TSCd0hzlLXCKwm+9viLFoaRrI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9906
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

Add a zero-overhead ring buffer trace facility for debugging USB PD
negotiation timing issues. Trace points record timestamp and event
to a RAM buffer without any serial output, avoiding interference
with PD protocol timing constraints.

Trace points cover the critical PD sink negotiation path:
- Source_Capabilities reception
- Request construction and transmission
- TX completion polling
- Accept/PS_RDY reception
- SNK_READY state entry
- Post-ready polling

The trace buffer can be dumped on demand via pd_trace_dump() for
post-mortem analysis of PD negotiation failures.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm-internal.h | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/tcpm/tcpm.c          | 17 +++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/usb/tcpm/tcpm-internal.h b/drivers/usb/tcpm/tcpm-internal.h
index 56144209002..138b0dc089e 100644
--- a/drivers/usb/tcpm/tcpm-internal.h
+++ b/drivers/usb/tcpm/tcpm-internal.h
@@ -166,6 +166,46 @@ struct tcpm_port {
 	unsigned long delay_target;
 };
 
+#define PD_TRACE_MAX 32
+
+struct pd_trace_entry {
+	unsigned long ts_us;
+	const char *event;
+	u32 val;
+};
+
+struct pd_trace_buf {
+	struct pd_trace_entry entries[PD_TRACE_MAX];
+	int count;
+};
+
+extern struct pd_trace_buf g_pd_trace;
+
+static inline void pd_trace(const char *event, u32 val)
+{
+	if (g_pd_trace.count < PD_TRACE_MAX) {
+		struct pd_trace_entry *e = &g_pd_trace.entries[g_pd_trace.count++];
+
+		e->ts_us = timer_get_us();
+		e->event = event;
+		e->val = val;
+	}
+}
+
+static inline void pd_trace_dump(void)
+{
+	int i;
+	unsigned long base = g_pd_trace.count > 0 ? g_pd_trace.entries[0].ts_us : 0;
+
+	printf("=== PD TRACE (%d entries) ===\n", g_pd_trace.count);
+	for (i = 0; i < g_pd_trace.count; i++) {
+		struct pd_trace_entry *e = &g_pd_trace.entries[i];
+
+		printf("[+%7luus] %-30s 0x%08x\n",
+		       e->ts_us - base, e->event, e->val);
+	}
+}
+
 extern const char * const tcpm_states[];
 
 int tcpm_post_probe(struct udevice *dev);
diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index d6af0fae7c1..1ce46118fea 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -23,6 +23,8 @@ const char * const tcpm_states[] = {
 	FOREACH_TCPM_STATE(GENERATE_TCPM_STRING)
 };
 
+struct pd_trace_buf g_pd_trace;
+
 const char * const typec_pd_rev_name[] = {
 	[PD_REV10]		= "rev1",
 	[PD_REV20]		= "rev2",
@@ -193,7 +195,9 @@ static int tcpm_pd_transmit(struct udevice *dev,
 		dev_dbg(dev, "TCPM: PD TX, type: %#x\n", type);
 
 	port->tx_complete = false;
+	pd_trace("PD_TX_START", type);
 	ret = drvops->pd_transmit(dev, type, msg, port->negotiated_rev);
+	pd_trace("PD_TX_DONE", ret);
 	if (ret < 0)
 		return ret;
 
@@ -213,6 +217,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
 		return ret;
 	}
 
+	pd_trace("TX_POLL_DONE", port->tx_status);
 	switch (port->tx_status) {
 	case TCPC_TX_SUCCESS:
 		port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
@@ -626,6 +631,7 @@ static void tcpm_pd_data_request(struct udevice *dev,
 
 	switch (type) {
 	case PD_DATA_SOURCE_CAP:
+		pd_trace("RX_SOURCE_CAP", cnt);
 		for (i = 0; i < cnt; i++)
 			port->source_caps[i] = le32_to_cpu(msg->payload[i]);
 
@@ -668,6 +674,7 @@ static void tcpm_pd_data_request(struct udevice *dev,
 		 * but be prepared to keep waiting for VBUS after it was
 		 * handled.
 		 */
+		pd_trace("SET_SNK_NEGOTIATE", 0);
 		tcpm_set_state(dev, SNK_NEGOTIATE_CAPABILITIES, 0);
 		break;
 	case PD_DATA_REQUEST:
@@ -736,6 +743,7 @@ static void tcpm_pd_ctrl_request(struct udevice *dev,
 	case PD_CTRL_GOTO_MIN:
 		break;
 	case PD_CTRL_PS_RDY:
+		pd_trace("RX_PS_RDY", port->state);
 		switch (port->state) {
 		case SNK_TRANSITION_SINK:
 			if (port->vbus_present) {
@@ -775,6 +783,7 @@ static void tcpm_pd_ctrl_request(struct udevice *dev,
 		}
 		break;
 	case PD_CTRL_ACCEPT:
+		pd_trace("RX_ACCEPT", port->state);
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			tcpm_set_state(dev, SNK_TRANSITION_SINK, 0);
@@ -1655,9 +1664,13 @@ static void run_state_machine(struct udevice *dev)
 		}
 		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
+		pd_trace("SNK_NEGOTIATE_ENTER", 0);
 		port->pd_capable = true;
 		port->hard_reset_count = 0;
 		ret = tcpm_pd_send_request(dev);
+		pd_trace("SNK_NEGOTIATE_SENT", ret);
+		pd_trace("REQ_MV", port->req_supply_voltage);
+		pd_trace("REQ_MA", port->req_current_limit);
 		if (ret < 0) {
 			/* Let the Source send capabilities again. */
 			tcpm_set_state(dev, SNK_WAIT_CAPABILITIES, 0);
@@ -1672,8 +1685,10 @@ static void run_state_machine(struct udevice *dev)
 			       PD_T_PS_TRANSITION);
 		break;
 	case SNK_READY:
+		pd_trace("SNK_READY", 0);
 		port->update_sink_caps = false;
 		tcpm_typec_connect(port);
+
 		/*
 		 * Here poll_event_cnt is cleared, waiting for self-powered Type-C devices
 		 * to send DR_swap Messge until 1s (TCPM_POLL_EVENT_TIME_OUT * 500us)timeout
@@ -2255,11 +2270,13 @@ static void tcpm_poll_event(struct udevice *dev)
 	if (port->state == SNK_READY || port->state == SRC_READY) {
 		int settle;
 
+		pd_trace("POST_READY_POLL_START", port->state);
 		for (settle = 0; settle < 1000; settle++) {
 			drvops->poll_event(dev);
 			udelay(500);
 			tcpm_check_and_run_delayed_work(dev);
 		}
+		pd_trace("POST_READY_POLL_DONE", port->state);
 	}
 
 	if (port->state != SNK_READY && port->state != SRC_READY)

-- 
2.51.0

