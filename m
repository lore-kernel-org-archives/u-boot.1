Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AC9CDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CDF849E4;
	Sun, 21 Jun 2026 02:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PDZjoo9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43E683FEE; Sun, 21 Jun 2026 02:50:19 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FEA849BA
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kopZlJc2+6G5SKPB9SCLOG97pLuzcWtqmo14+mV4d3ucvqwYJTBXuv6ascBKKxJDZ/wgDxXbhTE6mdEDR9CPeEZ0RO/V6MS0KxV+15N1rTdLKRLdxJdvWba6M0hTOL8eyiWPJFfbIkqgSUx85F66bjKiR8sIvuN0rrBjaegKvThgTIAsHb+LWvDtAMvArn8wmd1UnXzBy4jUFxVsTqrDGdluF1Blsdc4HHzhpA4fiP8BruklLexfaOXTVJ7t+FKsmqK3nW5AzbhyBmsu2JbPiI+8ELgcH8OjG9Ca7Ji4K/TuvRNE7lZ1mOIJQWYgXKICOcybpinDW1hYJfYDNCP5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hny4iH35S6H3L/nAOr0FtbO6YStOXIEjumlaGZMBQ1A=;
 b=m2UuGvzWrGs94X1PbOFoBfNWdJjXsLSfwTUJQakBMy3SAxUqwVYN/Ru/68hSs9QENjQKgHDHNDV2cxtXFXfgDl+xQARNv44miW3TVLwtdoxKfDldCxbNp5y4s7exZC+wZuobkKASwkiO2X6nzJT2k2EJIqsx+LprEq4e3bnRSzYNarmCDOc2J5ut4FlnNDIOXubzFT2MLKocPInjjNXaewEtzFcOAHWvJ87G5ecwyLUt8I+LvlVVr2AFgL6LxdHa5bvtqpkG9iXVzgq/h7UL5+HohltokVDfNa/dwQPd6Ng66GTORzEtlJz7qVd8jLoSk3gQnyJHAxLefSHTNHv9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hny4iH35S6H3L/nAOr0FtbO6YStOXIEjumlaGZMBQ1A=;
 b=PDZjoo9kZGsBNNsOU8BHKppK0uFT7Or0G7OlskbeOzI0kIX5YppMpGnEKHwhuuqaWi+0s5J7kaB77+qewgQy79753HksauaqQbnid9mAdjGJjFrI9r1UPSGpEv9S+i4qoorMwFmfRkm2HCTr831lKvVVNMX4214Bsxx3C1bGf617RjTbYwc0WHki608NOVMcqjfncnSRkNiwzf1jZUKXR5sIcvL0hQn2pw34MC6rtOUb+T79aN42K2QRxfefa3KnBghilI9wJQjbu9lnnsYHyJ0yHTtFzCrIeOTUjVyAd2C+OjZ1ONTFelLNeys8FZGZlZ1BjlVNIaFH8INUkf8CgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:50:16 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:50:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:42 +0800
Subject: [PATCH v2 06/10] usb: tcpm: skip state machine for pd-disable
 ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-6-990ecacc111c@nxp.com>
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
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aee6e5b-3cb1-4eb3-5541-08decf2f0f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JKIMcVOtzKa8PDFL2Ij8a9Oyis19D14h/dKa/JwmTJo1POUccJ6PQ7khKNe1r9Tm0Mv3atpBn4CinKxOyoSbW5ozjIhdCm3ftnhkxzxPXtrWo1pI6Pfq+PYei1VS6HQatxXZMIGwUZ5oF6vAk3OlQMJLfjVf2w1lFkok5I7x4bv3WOp1NjF/mt2yOzquEP2nDqEQLb0v0bIZBBrmKJtj3iQbqBaPn+ccYUgxJIA36CAxoD+eRnQAgviT3Lcj8H8nedjlDqg7UElArvsuxVyxyeqSI7X2FsW+spC+Afxz6mKh+b58Vm+BT2vyO4eCRsdBuDe8HEQZwtdCVtCZdf0JPQasdCFYM7OML2xmCMgnsi68IBFYdyKiwHTXk0ynirwOkWjq2+KvyI5bO2G1p1vSC18Tpr1wSdSpGkqSFUpjy0YnAvI9Z6Rw/8Y7G2Zdo5jzpqGj66RlLAppuJzt2wRlhdrE3tisvMXm33rECakg+o7DVjDwtsTlUvTPqHAw8lSPcJ1Dk6oC4vXh/B5M2Tp2wPWCgNoRSPXkOJhs+j5GeaYGFOoM+BrVUWovA/rjKBfVHBR5kQeVlU0flcLO5JOijz4xhPI0vKNgPlDHU8v9tGnJTxD3mfhJKYYiuGXlunTaS40Em43qFYGHOcH4z4tOfURrBM7ezWpdEn42N71Zd7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MCtZT0lhS2M4M3NiZWxMQjI5VXVIc0RjQ1p1dThhcFdxeTkvelVhRTNObXdG?=
 =?utf-8?B?M0w3UjhXcGR2R0oxNXpEaUhmQVovSFBMM2NLSmFQdEFncU1wK0lSNUtCcmNr?=
 =?utf-8?B?YkNZaTVwMnhtMTBwV1N0TkEzQVpzZXdpbWdKYlQxVS8xQlBlckdRMHFtekNH?=
 =?utf-8?B?bkR4NDg2cFNRQjNkUHAxZGlkc1FZc25uSWtGbldFTFRYZDdLcUlCNXcwUjBo?=
 =?utf-8?B?eUtDUm1WQTFNRHYxcGQzOUVsS2ZCZmFoVldtbC9jejlxbENsZW5HVGFSemZF?=
 =?utf-8?B?Zzc0dkEvSlFMZmNXTCtJUTAxNzlkU3pxR2swckF5eG9TK3ZVR1h0QlF0RzN6?=
 =?utf-8?B?R2Y2ZFd0R2R0S0tkZXFFTXFGazNVcnJwV3g0ODJXSXlxaUdRcFlQOUVpbERz?=
 =?utf-8?B?cnJDRlRaVG1vcksvbTF0QlQva2ZnbkpjaTRZS1k0b0NBbFZmUUNESTJsNk91?=
 =?utf-8?B?TUt1ZU9WUWtEcEZjMXN3U2JtMC9MREhCaTVhTGRJTk9NaWVtWHc1a3ZOYUdx?=
 =?utf-8?B?MVZ2ZEgxemJvenhRdVoyN3FWamczeGFFRlowUkVCSVpFUGI2Uk1GYTNBeG9x?=
 =?utf-8?B?aU5QdytaaFFCVVBHc3dVTTR0cXJ1bWxLUXFObTlXaDFTYU9UZ21uTUVDN1Aw?=
 =?utf-8?B?QUxKT3I0YTA5d0NYL0lDTStMVmF3M3NmRGpmeG0xK0tiMmRVL0FSRWloNk1s?=
 =?utf-8?B?em9BaFpkQ2hRMzVsRzc0a2plenhVZU9vcW9SM0R4eHZiLzd1S2JxMjZUMDdr?=
 =?utf-8?B?dlg5OGJYM2dNK04xb1dPcHhYL1ZLWHg2WWF6eGlQN0xiYTREWVBsVk9zT3Av?=
 =?utf-8?B?STE2UzNXYWpSbTNQUTJSNlRmY1kzbkx5cmhLanFNYU40MzM0eklPOGNrTm9r?=
 =?utf-8?B?dzhScGg2ZGhFSXYxQnNla3NrSDdDS3lGNVFSMVVRWFVoeXRQUmRsYTczNmFJ?=
 =?utf-8?B?ZFFlb3hWOGpVeWh4VVBuWDBnSHJIdEFzMm90ei9hQTZnR0hvS3BXREFtUmVa?=
 =?utf-8?B?QkFjTjZ4ejBMeENyUmlUZTdkWXM2OXJzdVJ2WjdYKzVDbllIWjNJRVIxTnU0?=
 =?utf-8?B?djlQMm5sRXNwR04yYVkzNWV1TFJVRW1ZemFEajZWVGNxelg5Syt2SDJVNkE5?=
 =?utf-8?B?YjdhLzJSRXhMSllnMjk1TEI1d3BQRlRRTmF0aWo3RU1LRERzV3FlTU5sRS96?=
 =?utf-8?B?Qmh0OTBQUmtzL3hTMmtHU0NOMEJ6UTlUZzFOS1VaN3ZDSC8rQmd3N2sxQi9y?=
 =?utf-8?B?eFNpelBEeWVkdjNPZTJDeCtTUnNDRHBnM2RtNjlBV0N2K3ZDU1BURUhoTWU1?=
 =?utf-8?B?TmhSeG44eW1ZbTE2eEFEYndGeXZnSGxhaDQ1Q21yYXA2UlhHODBkNXhrM0ZD?=
 =?utf-8?B?K0pibzFxWHJsU2tKd0F0d0QyZnVzdURMblpQK1JQenVsTy9BeWZldFNTOE1q?=
 =?utf-8?B?YzFjQlQvYWhxdjlXVXE3SlZtQ2FmK0FlVWgwTjJXSHdVK0tFZ3ZDTUh3VkJM?=
 =?utf-8?B?R1Q1ekIzYzdUNUs4bWRodFRrbjN1d0FGWlYzb0krejNBSnIwMjUxUG91d0N6?=
 =?utf-8?B?bDA4Uy85SXpDMEFhZXhhRWN4bU5YbU1UbmpmRkc3bXVhNkNCU1RKeFBGMCtm?=
 =?utf-8?B?MWxldWRRVXdnSURDSnpiSWMrL3ZTL003RENCemtOWkRtZlpKeWJacTg2Qk83?=
 =?utf-8?B?SS9leGI5THkvWEtBZHluc1NERCt3eGRFcy9YYVBqN3QxRGNUU1UzSllvMXFZ?=
 =?utf-8?B?d0swM2JPcmp6VjdmTlpDQVp0eFQ1cWUxSkxiU3IrazYrdjJPUVlFL1pWbExI?=
 =?utf-8?B?ME5FcWVDRUYzbDRyMG9EVzlydUg0bmhlNy9Jakx6ZXpJSm8yK0pXWmlRVm9q?=
 =?utf-8?B?WlAzdmhPdE41OTE5QUFkQ08yZ0U0RGYzaWl0UTJsY1R1VEJ6UW5CeEE1T3dY?=
 =?utf-8?B?Wis0Q2cySEl6MUhncmtrZW9xN3UzUEN0R3BpOVlMc2l6c2RUYi91M3p6bFJL?=
 =?utf-8?B?Nnp6UE0rK3d1akJtRDFUbFQxRXVSSjdIOExyaHBESzJhVVNrcjFJZ1AyOWdh?=
 =?utf-8?B?R3phMXhJWGduNHBRb2grTjZYNDdjelVsWEhETXRBUlQ1SU5ldkdQdUN1TDhX?=
 =?utf-8?B?ek9CT2djL1prdjFTRjFuOWQ1Q1RWRkNPNUllTURUWHBpSXRLQUxFVHRtVVVv?=
 =?utf-8?B?bnMyMEdHRWpZaVk0VEhNZHcxNUVOeU5HTzQxdjRmRCttclY1NjJDZ3I3V1ZH?=
 =?utf-8?B?N2szWmxwZ3hjUmp1MGtTTWZpQy9NOHRWanlEMm5mNklEWXBWUkJQTDgyM3ha?=
 =?utf-8?B?dDFka2JRcnVEaXRPR3BQbnk3TW45djFVN0psaysrN0lsZzNzemFueDhtY3U2?=
 =?utf-8?Q?2UrMVGqKldSWp+SFpywU2fh68u7x4yZs5eQeh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aee6e5b-3cb1-4eb3-5541-08decf2f0f56
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:50:16.4363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1knc9dodmz5G4qXeytAZUqZbeneP657pv7Bc+/53pC08W0jJ7jNP6vxNaYBwhWIvCRIzHVKRT0Pbs8IImm/z7iKrL6EnhwdndJUwGWWgfwdgLtvyKB3lJGNJIVIsKsw
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

Check the pd-disable property in the connector node during
tcpm_post_probe(). When set, skip tcpm_port_init() and
tcpm_poll_event() so the TCPCI driver is probed (I2C accessible,
ops available) but the PD state machine does not run.

This is needed for dual-role data ports where running the state
machine during probe would disrupt an already-established USB
connection.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 1ce46118fea..32c67b8886e 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -2306,8 +2306,15 @@ static void tcpm_poll_event(struct udevice *dev)
 
 int tcpm_post_probe(struct udevice *dev)
 {
-	int ret = tcpm_port_init(dev);
+	const struct dm_tcpm_ops *drvops = dev_get_driver_ops(dev);
+	ofnode connector;
+	int ret;
+
+	ret = drvops->get_connector_node(dev, &connector);
+	if (!ret && ofnode_read_bool(connector, "pd-disable"))
+		return 0;
 
+	ret = tcpm_port_init(dev);
 	if (ret < 0) {
 		dev_err(dev, "failed to tcpm port init\n");
 		return ret;

-- 
2.51.0

