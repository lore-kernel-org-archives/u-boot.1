Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8CDCD4F26
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B01849AE;
	Sun, 21 Jun 2026 02:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Dt4Gc2R7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 257F1849BF; Sun, 21 Jun 2026 02:49:58 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A0A883FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtvxXhSSK2V/do/7sJU6yp/Jw9mGGucViIvtCB743nONRyH2Dr99WeceNpV+qycsIrIii3bhl4u0+hB1lLGAt3PGOmNJPc14omw5ObtCIJBqL9axmMt1+87WnR4ViRQSeF2xHJN2Cme35+8vtRj8ZQ6+KVQiPaUsAErnflI5pGM/JwHIFBtdo3FVHS8/udfXIWa55xe7xSIKBP30bvZ87OdmOIuhPQ93RrJIIb2zuVWTvFae901lZ/OrX2t8WRwyaHed6g8EoeNICNiODwUl3AsNCPHwk8HneB2wUxMyettLifAIJVnMhd6Ha90t2kM5nvKE+aHGL00gKTRqmi1vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gNONLE7ke1619C2KvNDbQVrlXX15NdroVPbrsedmLI=;
 b=eIVqS+SRHjX1o5kSj6KJYl+ynyDUR8oadEUqobn1T13DyRWzvsFyp67FYIBmQXnJxHd5bSc5sdPsVVkx2YG+zTtKB64K7ei8xjPYCLLwJbPcuLekEMzN17/529Ce8sWNJRswNiJUZ/tr6FZjF9vpODOTm385g32C6PZ3YEJHWvDB9mmA0BMWQ9r7rkTEuEA5DHC6n2kjrJpzvaQ2Fp2FKRFY0sozlxJEnzh3iXuqwtoRD8uP7Stklvk2a/MT3VwuvQrI9ZDsyVNUMUsVbiBCXI66vc9PdQFlheJjze44dShMFNyAooBssGbfN+smqY/x9QiiChOQ543fF4BAfCpUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gNONLE7ke1619C2KvNDbQVrlXX15NdroVPbrsedmLI=;
 b=Dt4Gc2R7mOKQoYmxtC//sV3ZpGIWym2bk+VqPIT5ex1dInaqSGDcnTQ+BD+FpiYfpPCkry/vlsMt3f5+D9xb3qA/ZDV8u33/wfv0w2W5SgJt0Sgup5okwsLc8P98smuVwc2GTVM4sV+wqCxJ3Qml48d24CbKR1irZgRnMs/G/+Lvk652994cMyNtpJN1qJPgQpXbffDmligW5lMZEJ0Z+h+SfxBThX/Tg1DE6XmU5g5zMsoKhc32/ySEp/WfzRjeCZ5GPEm8SJvWrEmppGC7BAArmpFBENW1UUw0bgpX4c+1bFuhVPqwUpJPBE5CpXKQ/PNeH+E2mxys3Q4ED+k5Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:49:54 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:49:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:39 +0800
Subject: [PATCH v2 03/10] usb: tcpm: add lightweight PD negotiation tracing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-3-990ecacc111c@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
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
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 1069b0d8-4436-4885-9046-08decf2f0243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|5023799004|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: kReTxJjUrUN6el4asAM/493VqW0gxO4pdXwU3NbHzFlzSknagn8tr2MuqA9JwvywnF74gbvFBVRaZlHjPXg54k18HSdoluLkmafOhS3A3m3qAkxlcHP5QxldEYayTeJ5vdpx/JOrF/VO/i4wd+ZKBWkZK9dKArLcQonZAYvqe1aBm7HAROjk+dflGJ9dSrv6bZn4tH5B9dGkYggmUuULJCPbfNWdWQ+tXqCnkeCPc93YIyjHtUOmBa/xi45O1o9VhkIYDo7jqzSz9oihB+dFCmnQ2w8SQ1GLtsykrHFAmWqelWbWCOvNtr8z8yzI8y/P+BGA9cdBhp3jIXwjhaqEM7aAPFjSADorx0KmJjYnLdwElGfF4nQmJPLeapDo6SuFwfvs4sle8td1EWDenPLRocxbmBDy0DzVjsI4NOhbT+M/JiXC34+V2J0IK/lqN3Jx62UN9m3IAYrfiPdP/g1yf2W8pHdRFdFy7/syZhn5cJrLnMdr+8WeC2x+bPAjSI6XZMQig5oWzJ7iG4AZa/h/5asPDlByDz81Ycr8rygR8OI2VeTGTWIlxB4lpcg/oPjh/mcooSKw1meJgDsdB/1obY+A386AXCYJPJiKy0yM977Cp4v1tO5i6qM1ycoDWWWyZ361JDiBB9f/YWZ9f6I1FURNbspAWtol6ogTNxiQJHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpXMUpkTFVSOHZSRUtsUWcvNWlZS0MrMFg5bEdjMTNsUjQ5dXNyQUdrNHpJ?=
 =?utf-8?B?Y1NmQXFxZXNzMFJ3WjJYRXZKam9jWVB6MkxRNjBmUWNWcmNDZWFHU3F0dURC?=
 =?utf-8?B?L1NQMVRveGNTWGhRSmJZbjVYWTBEdS9tb2h3cWJIaUJKQ2ltUkt4TnFpazVR?=
 =?utf-8?B?SHR6Vi9qZlhHajRqYUtzME1FSjZrUTRISE5xa25ZSVRuYytXNjgyNC8wM2Z6?=
 =?utf-8?B?dkdnM0NKNWd2Y0lkOG0rSUxYVkhYTnlYL0YrQkI3UW91K3M1UHY2S1Q2VTFl?=
 =?utf-8?B?RGZlNmhNaUpVVk00Z1dxeDdCa0dOU2RKeUpWa0VWSldESXNCd0tNQTBPWlZL?=
 =?utf-8?B?K3p6NWR3eFJIVUpLc3FETHl2YldDNURDWWExUWg5K1V3UDJVanpWcUhzd1RG?=
 =?utf-8?B?V1VQbzZJS2xoVEs3YVIvY3hXZnR1NjhsR0tqYys0VmhtOU9aZkFMSVBuSzJT?=
 =?utf-8?B?ZUhqd200cHZNMkJjNFVLME5pdURJY3BSNVZXSFRiMitVRE9NZEM2a2l1UW5W?=
 =?utf-8?B?WWhXQk12blQ3ZXROYlhmVUpFWU1sMlhqZzlnc2c5b1AyNEc4TE1lMUo4NHBG?=
 =?utf-8?B?WlJwZHZKNXZyb1I5V1hZdjBvZm1TakVRaXF4amJDR2psM3I1bnI5SktDclp3?=
 =?utf-8?B?cXpoSG1LNk9lakV4aThMNVlRdU9kRkJjdG5mZEE5a0ZjMHFiU0x3Q0tCZ0Ni?=
 =?utf-8?B?Qmxzckx0V3NEeVVwZGcrQ1pUeDUzcnZYU1JrRlc5cHNkL3lmSjhHclhEeEVY?=
 =?utf-8?B?Z3RUZStLRnoxTFBGZG1yUjZhSzJWS1RLckNGOTNSYlBXNHRLRUdqbVY3amxy?=
 =?utf-8?B?ZjRKYnZqS3JqMTZyOEtzZ0RqSVF6Q29yb1JLT0tWcTN0UnpsMWpHQ3RVZ0tm?=
 =?utf-8?B?aTZXYzBQaTVyYjNqem1GcmpKQ3NUaTNNVW5hamd3K0RhTjdqc01WUitoQk4v?=
 =?utf-8?B?Mk5SYTlqU0pBNFFwOVY2TnJWWFBqUGZKaVNGNEtPcWxUbVMyL1M2MzhQcU9k?=
 =?utf-8?B?QUZUQ2pEc1o0aXA5T0VzS1hpUmRLUElzVGQwTHpyWHVJYkxxUWRiSUowTjdO?=
 =?utf-8?B?UyswMmlMcVlKSzZRQ3FSZkRudDNVNTAzRnZQajdBWTJzTEdaLzB6NS8rTCtX?=
 =?utf-8?B?RS9La3h1T0FScDJkdHJRL0IrSWYzS1dLMXBuSlJudmM5N0NrakVmd2NBTG9X?=
 =?utf-8?B?TUQ5MUpSTlRRSytDRm9MYlJhd1VQcjNsdCtEaUpYQkJDdGRVdHBNbEpNYzlo?=
 =?utf-8?B?ZGJCYllPSFRvcXozTDFCaVdOZ3hUV285QW5MRjZPd1BNc0p1RVQvSjRneWxo?=
 =?utf-8?B?d1puYzVDeGVpd2ltdi9HazE5dC9XclczMUFtRVlMYjcvTFVyay9KRFllNGpn?=
 =?utf-8?B?TysrMXpkVzlDTW5kSkNuSk82QlA1d0R6aE1VNksyWGxOR09IVkRIVnFMK2Fp?=
 =?utf-8?B?eHlKYmtkYTd3RmxiSFZPbEZ0UkRLdGZjMFpadDlVWUlRdGYwWm9vR3FVZi83?=
 =?utf-8?B?NU0zemRWaWdhSVJMTXZySytqUmYvblBHYUcrVldTaytHTlJieHE2Vm1raEJw?=
 =?utf-8?B?NlJITllvRTRZRFJRRkxOSkk5ZHUvVmxWOEhUemNDd1IvM2lJL2lma1JKbFpI?=
 =?utf-8?B?NVdSMjdxbWJ6NDJXTzh0djJkZFpMbTVyK2FjM3RtWkgvZDczZVdqQm5GdXp5?=
 =?utf-8?B?ZlZEODVqRGY5NHpaaXFpUzYzeHU2akpnZS9aVEZIWEhxK05GTnJCUVJCMTYv?=
 =?utf-8?B?K0dPZTNRVXdFNVhsdGFpNWpjbmw5YVpYSVdnNDhteDR1ank5dlJkRWxEOVN6?=
 =?utf-8?B?U1lSK0x5L1NmZUN0MXFPVVJGb0M1czhvdENOQk02VGxhc2VCU0xDS3hURlV5?=
 =?utf-8?B?OG9PZkZlUlFCMUFKL0JBK3l5KzU1Ryt3enJ6NzFtL3RSRWJ5Z285WG13ZDAz?=
 =?utf-8?B?WGFOd1IybGcwQy9PNFlHaGowR2NpMytqRFhxVHZzNUZhaklneWlWTzRERGd6?=
 =?utf-8?B?WVNzNng0c0djam9HK3VkeFR4aFFrMkZ2T0daNnU4Mi9hbHQxVHErVE1KTjFG?=
 =?utf-8?B?bVFBc2dSNFdMRi95ZVFVM0hOdjNGWDZBVllOcHhCQlJvSGtmR2dGRHdkRFN6?=
 =?utf-8?B?dU1TZjFkZjZWRFZWRXRmcndKcHRkQjRGcW4vM2VCdDZBMVZRK3dkZ0ZYMmhy?=
 =?utf-8?B?TXp0c3Z4Z2lIZkN2dE5OSnVjbjlqRThrSzc3ZzRNalBKSnN0UnJJcjNGZDg0?=
 =?utf-8?B?eVBTT3M0alRmRzZzWGlVMEp1NENReE1IV2FsbStReVlpZHBBdVVhenVpMnhh?=
 =?utf-8?B?dDlwbHhEbkEzNjhtRlhoU29kV3lhbHY0ejU0QUIxWlMxYTRjRzJJdXc4R1VZ?=
 =?utf-8?Q?0oDfhQJmz+ovqkzFoNibzMtGtBRH8wEp4EO4/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1069b0d8-4436-4885-9046-08decf2f0243
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:49:54.3515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY7fbPnFzBnhpeTQawWmvtWS3YOc8RrODS6YupEqsecj+XX0RBY4sykgEHQ9a+O4rx9paSmN2Tu4NHcUyNs212v0g/vAbcrkrhQfysP0SHGUjVIKoFqsQQzFKNHGTlt7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
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

