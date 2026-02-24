Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21906F3C991
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 929A383642;
	Tue, 24 Feb 2026 16:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="M2TV7u4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E2783D3D; Tue, 24 Feb 2026 16:18:54 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1954682BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fub/Ri8fJT7okpE3BSx/KUYY66EU/r1YKcx9N4o/Nq6V07Q41lyHzGpVjKXczH8uyrvhKfW6SobClCTPVbnVTN7B2pnEXirp+KYuZpjbr4BOJu8P7IVntc5VE5zzJ6ndDoaRLFkOOp2Lw6IwKeMaeIfKrduLO1SYt+XyiVbz/LAOKZngrKxlT6g/pJ5A3KOb+MdCQe3ClgyBIPV7Ic6teTaxn64lEiosWS7IH7pN4LpBvVZxj2B/12EwQbGgVuGGBw1oAybYtVa+715/8BAiE37F+CK0NnIJ8LwEcfvps2w/YSlH1qLY/ed5n2PK+rvqQGPfFIrOdaHy/Xb/1YGW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf8YboonyacwRloUcKUD/74XCNlnCKzEkC0N+sZAz8Y=;
 b=iAid32vRiU8khH9eoGvJ4uHHvtcWh3Rxrg4BX3chrEDZLS84nCm2LigMVV1Qo5jVAIQKcFD1YnjgV8ZFJp6yt+2W1WxFEcX4hgbMVAwfttxguU55oTkkLwLelTweWmAxdI1do6VP0m9ZkYSDcdt8cwujFsp9NWn+Xe5cfkQGNYkVrHIzymcvq0AxKAE7wshVRa3yabS/GXmaLlu0DacrfAOCUIdr6srzFaNYV6PDkHMmnzjPEThjZ7Zcu3f5letVWbyWusM1LOs4uKg/UJarhj92GlX9XnnxL9uWzCGiJjnRYoFxuvr+v7PhDxvx6+V7u2HgWTMMPpoWPFbChyvqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf8YboonyacwRloUcKUD/74XCNlnCKzEkC0N+sZAz8Y=;
 b=M2TV7u4pliHeFBSoomw3utGVYqFjz/zaK5dRCLjp8FlPrXxzWP04prE4NpbRO2xjBKuGg/LE3KpezWkhgzAGX5I3S3fuMVbJ0AQKmW9BzL1ad+jtBP8Cq1PiZrW6RTyAAnKqt874OQzuFXXSYLl0QXsVDXfuf0Yra1kodPWCe+uqui11vky9/gRzlyTIWLobI4yncohLENTas/ScjmVcHZu3q2VMWhxFMrjsVNQ8uFFvJ0juUlpHXDJI9phZhAndbutEINV6LL6nAfv9U/HZND6/LNv5g/qygzB4MdK98CCcKqhKWKh7IqEQK8R6lQvLx9a5+6hkmRZdiALB8V5TdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH0PR03MB989099.namprd03.prod.outlook.com (2603:10b6:510:3ae::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:18:49 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Tue, 24 Feb 2026
 15:18:49 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Boon Khai Ng <boon.khai.ng@altera.com>,
 Janne Grunau <j@jannau.net>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] usb: xhci-dwc3: Call xhci_deregister() before asserting
 reset
Date: Tue, 24 Feb 2026 23:18:28 +0800
Message-ID: <20260224151828.20838-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|PH0PR03MB989099:EE_
X-MS-Office365-Filtering-Correlation-Id: c6700d4d-0461-4a85-566e-08de73b802ac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DnAccf2KNQJDBBxu/vIFYm57X1TySQS9+4gqmsyik34ptxw8LbqaMYgYeEFa?=
 =?us-ascii?Q?NInL4LzDzccdON8qPhP9l/LN/EpyhBC0FCPwBTS9aMchVC9BX7BKAiG/E8C3?=
 =?us-ascii?Q?EVazQYRNuD7GxH7gj0M3MwBlTixqeV7sOH55jOwjFctkLRNB4lYTWdlj8Mdd?=
 =?us-ascii?Q?Ip0Gg0HGwea3f6/M+HsxGpDTYwB6RNjQwnH4OpSUXRI92I8cOki1z8/JqKvv?=
 =?us-ascii?Q?k+BnpEqFanNhaX+Gk/B5JpkAwRFROt6hNXoSWEByKCIudq3a/N9cNCWqq+yV?=
 =?us-ascii?Q?yx743DKX38xqFmeYgWaIFxE22rL/6xx+FBEUtE2DEnOfh1fjZgiT9Nvw0Qn4?=
 =?us-ascii?Q?mq9jZe3+ltQ5iyf/rFgWzZ72t9Sz3EQCRltIFmp+x8W3tq3TdM+SiHHKYRyW?=
 =?us-ascii?Q?Hw14ooMgXJkp86ZOntq4dU9YPol35GO6dr4giROozNPowBMDXKuM6/s/46De?=
 =?us-ascii?Q?1qMOxbLpyPID5m6dveTWHlmZdVtTjxmcee2jY9KUAUbl2+35JwMpfYllie7J?=
 =?us-ascii?Q?eNSYkBgHi3IRUT7TuijPAQb3YUwl6eqg0cC1HiG0Y8rocdC1QI+4BKRcqoEL?=
 =?us-ascii?Q?QqHYbJUpqBxTlGSntHKnIfU6KKDgxFLWnHhsSZN1wxdrbyiiGv1aX14ySzL2?=
 =?us-ascii?Q?roxW1bREhm/2gnj1YVnArYrQeNLaYelt+MGBbaaFK7VfLqA6Cdw2H9jCTxjH?=
 =?us-ascii?Q?xGCaLa174d3gQUNZGv1EbC0H9XNzrjIBQO8J4k/62BOVvkWXiNFGkpQlbZEZ?=
 =?us-ascii?Q?8oyXTDyW01xRrphfGu+dRjsYWYrUESKDxvPW5x8hzSjGyn+Gl+aDHbTt3x5t?=
 =?us-ascii?Q?dZR3NBqP3WUr4u1I9rhnzM3dtRKTxfg1Rzsd43xuudjStn1dvFt/YNgTT5v7?=
 =?us-ascii?Q?Nrn2rlchKp3ErnQ17EnWd3jSUnZBbb0chKKIw4+TpUfI9Xa168O94l4CzwbY?=
 =?us-ascii?Q?5W8TPodQ481SfPbFFysZoFiTl5QaWGNAxHwGnLMrZdow2T+ejKq4U6PoYXUG?=
 =?us-ascii?Q?TMnO/lovbR6aFog8CDtq87jtzWhm/i4W4Kgpe7KOtMkIWu6R38JM8inPZ8cP?=
 =?us-ascii?Q?RudWIiwiQAjjnR3c4hXnmO7jdBKQARjr+2zj13S8oBVqkZ/WN4YwRWADjg0K?=
 =?us-ascii?Q?b+euOiGL9I9AQbFywNfE6UFkI+Vuscu7LayFgVgHGFlKeFtw6X9CtEB6yx5u?=
 =?us-ascii?Q?fS7VwvE7Dp8/6rDSai1EPqMA/5krOABZRj6WZUeu7UugwKCCf/DmbWfpkLeY?=
 =?us-ascii?Q?kjDLohTjvC+YjQ7c9+9G9txP1OHMQZ5aDDvDOX3+Mky2Erw4umMojxJPF6hM?=
 =?us-ascii?Q?X3cfZ0buOba9OtUQR4NCj7/lPhgy5x+MhfdKyaIkGMQ7pXOijR+32H2UuckM?=
 =?us-ascii?Q?2VIKr5l+r8ev4wYCsaOFW02ukzGLSfTrdCI1pZTXZ/mFwO69uvr8cwT8LNtr?=
 =?us-ascii?Q?W9gqjdQaQ94bjdrN1Wb7j0H2Y3FMCYsYkUIQplr+YfTtKRXzUd4Z2fK/TawQ?=
 =?us-ascii?Q?rkeA1yS4z/4j/XeP2p7wccPwG4BEVIr0e+z0+FXb6Ce7335w9GrRNJVFZBde?=
 =?us-ascii?Q?LAR0sYNDN47l8rdthOo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WME9gSJr4ZXm6PCdW7PrJ+5IxFzhxWk8pZKKruE+OufIqI0hatEfsRLZcGnh?=
 =?us-ascii?Q?mtviSqTtZiaERdGNF2Jqeznx524RAkmk1T0xIHeLx2GBCasxEzHuf5aDlqxF?=
 =?us-ascii?Q?PvM00Z+Ij98rLhbHokrnDF8AvROaHbUfero6Y9Vrr8dTSVIu1TWHBxJBZypm?=
 =?us-ascii?Q?D3N8NfRcLcc0T10QuPHOrwFnEG6PPsxN45gfwrgOu4epuELlHFzvxYPggm2b?=
 =?us-ascii?Q?YXhjZ+nGMTY6TqUUgA5KO+KoCvrXiBLaHn4sxnexkt9B1dyJhy2pD4yyKmp4?=
 =?us-ascii?Q?Vv/rAKniZvTzPgVG7tV9MgYxdOgLp2k1nCKbGUwnYtYcti8wAc7fZMYd4yzZ?=
 =?us-ascii?Q?t92xlvbIhMs8xFDOTNvQDwtZ1TbtZAQfFyr0Rd80Y595KecII5FOaz7LoETW?=
 =?us-ascii?Q?EQwn1FpI1d7iBwmYvTulD6EyTYMRFTAypqI+lKugapuMMH0qybafDRI0Wle4?=
 =?us-ascii?Q?OnUGEw1HxfFNsKgdYDypUuqtV2vqrGyYDYQxr1K5/UAMjJtQ8kIlYsq0u9qo?=
 =?us-ascii?Q?MJX/wH/R7S5ya/HKDiEp8RQINR4JJMtGb5ZIykgO7o3OMrxu5Gb6Lg9cWl5g?=
 =?us-ascii?Q?KT4DDQqzzwkGHMcpAhwZ+uO+vSCxluG5OZ/36o93zULHTJi5peIG4jonx8s5?=
 =?us-ascii?Q?WFx10QixzfrD+mtCy4O2hBlXpi7IKWPOFjxG0amtOaGHs4KchCraYN7AnVud?=
 =?us-ascii?Q?VPvr1TpLFuAdJGb542rF9YqQdJSWKO3opfuOJvOW3iqBECFxjRtyeZ37XxGC?=
 =?us-ascii?Q?VGv1LR7ORqwfyJeOmxFCn6xSTtdgzNpa2Thqm3XPD/MRbmqz/ScatAPDkpN5?=
 =?us-ascii?Q?xvIdRtUwM9sJlUdVMhAjl0vdUwoY23/27zCJU8/C9qTvrWWB21mX6IOLM9VU?=
 =?us-ascii?Q?2JjNV2J0J0nePfDHF/aQ7fSGPdpzV3vWAqDsTjeGAPDmv9PR9ct/lRXCyRyc?=
 =?us-ascii?Q?OH+MQ7dM21fHPa8lCfd1RYVi9RUkAQwoWdRV/X3dViHMz8UqBd4R2kfOBdmm?=
 =?us-ascii?Q?UB0YJpaajn1+bunOkjnEsZc6zWIdfkfIqOvKoAjxjUDFm7fhgoY3qa0uUQcO?=
 =?us-ascii?Q?WVZ+Z3IYlApB7ftiZDmCXC3AqAEgPpbPJ5Y8ngIkDDHrx5G08W0ZFFS+iZ4T?=
 =?us-ascii?Q?s7loa0OpS3R2n4uqD4wHcWCLRHuTju570dHkLmQuxePJOb1i50nxT3ruuuJw?=
 =?us-ascii?Q?f2GulUhN/XCz2QykiudkYAAhdAYluqW4Q43j0JR30h+3Mvi+aEytuZtNDjnK?=
 =?us-ascii?Q?zku5csbOTy4rQtMVvWRqMsMQ1RTRbkl+pxxLndSCw38ctVQtpVIvry8A90k/?=
 =?us-ascii?Q?LDhEovru4i6ZGjzkTlMq93TumOsJQH8rcG3LZz1KxJyINKm+Momr8axYCMm9?=
 =?us-ascii?Q?jQfm8UyZfW+GOSCQ3Kyzqc3mwUbcAQI2zVw5sDCVSmDLGhFsTLAM8alXcFR8?=
 =?us-ascii?Q?GiF006C5INVQWTTmMDAHvBZLiWv2tCwgsmSsJyKwoDwqQWXVxCuZnMu4bjZ0?=
 =?us-ascii?Q?XMmt86BH+TjPBVG7IjS86J0ddT6+ixBt+wQs5PJSXkZyWZBd9eanAKDu0X5/?=
 =?us-ascii?Q?y1kmyVm1JwNceKRmq/jKVAYYKLneiIyhvS6C8Z4Qa63xLZs6MvLmXuEI9eC1?=
 =?us-ascii?Q?LgGkgle/6v/dk/GiFfdUd76NYAiEduHtg5cyO7bCUXsA/8lUFC4p6j7OeYX0?=
 =?us-ascii?Q?n3ru39uWETxi/AhZLij3pwlsUwt8+QCSn8p12U8/kK8Xhqjo5zaAeM1OP0jT?=
 =?us-ascii?Q?IRZsM5ARXQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6700d4d-0461-4a85-566e-08de73b802ac
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:18:49.3776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mY5bGc06EC1RNEctIYQrzgjNNEUC43qBCLyZB3LMlm4m38B9AY/Iec3CwPerRBzQM1MtPk3IrCRE3L32/aRj9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989099
X-Mailman-Approved-At: Tue, 24 Feb 2026 16:37:49 +0100
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

Reorder the remove path to deregister the controller first (and return
early on failure), then shut down PHY/clocks and finally assert reset.

This prevents register reads/writes after reset and avoids undefined
behavior.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/usb/host/xhci-dwc3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 8ad07a4b98c..3504a7cf42c 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -226,6 +226,11 @@ static int xhci_dwc3_probe(struct udevice *dev)
 static int xhci_dwc3_remove(struct udevice *dev)
 {
 	struct xhci_dwc3_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = xhci_deregister(dev);
+	if (ret)
+		return ret;
 
 	dwc3_shutdown_phy(dev, &plat->phys);
 
@@ -233,7 +238,7 @@ static int xhci_dwc3_remove(struct udevice *dev)
 
 	reset_release_bulk(&plat->resets);
 
-	return xhci_deregister(dev);
+	return 0;
 }
 
 static const struct udevice_id xhci_dwc3_ids[] = {
-- 
2.43.7

