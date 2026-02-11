Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147F6ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760B083DCB;
	Wed, 11 Feb 2026 19:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BaCowXMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9DF83DFF; Wed, 11 Feb 2026 19:23:10 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACAC83015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8MAFBo7mPeu0Y7Tr2F5inJopXpDSkDFALjhwLKIgIFo2Sgf4Zr3A7Q/21WAwcAjH+RbRsBqWfC8KGOuswH6Wc+ze8Avq6nn2Yk/NeMp38/OnvuWCX+s5Rqd91m9E3Btf99nnBh8LhLHf4aadjeuLyDg4rKfl+gb0L2NECcMA3JGg6dA5T9MQVP5648cAcwlux3NtCCe2od1XkKJp6EbmbrMDZNzYHIfOSyhOzSLKdCtVQO7LxR9M5LslnADZzwk/rPuCWCohzRPJU7hbDKqS5QhxoH6dvLwHkSuUR82wvMmYu8fHa/pyFzQ6CdFyQqJ7+OvYRtqPFthoH+UG0IS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8edFNr2wb3rnx5qNOWjV69L5P62Z4Q6udTOC84o0/Ls=;
 b=XPOak3wl9SPhhvwX0xHsmZZWlF6JjxevH6gDANUWvl8ua9qhCRz1zHsJtSK6eXhyFbqAEIpEU5Xn5XbMctNzS3s0N39tn4S6GOEiJI22hzqFGVtzXU90esWHWfqQBOe2gZz0uxLji63iNtuhJfh6IZ6ynDopzoGRP833U8RVf+dzAfZUwVwFuRedRBi2oeIVg0cD+RuLY+O+OdrjstO9Xmb4M8KUW5hD8woyQSRHs8NhdlEO0innqFyWa62j4ExLKKabYmNxGfrIiWK48DzeW7+3l3VW1Knjf0M5RIUYxaErvIb+BtOjwSSbUz6ak4eA3MYT5rxY+CdL6o8BEtUeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8edFNr2wb3rnx5qNOWjV69L5P62Z4Q6udTOC84o0/Ls=;
 b=BaCowXMGng48Vw5ExgnvkqonLkFuR8006SVcvnhojN7ZelAEdbZwlLP7xq5R9HujkPesgIM/ZDnOvS3pQjenuxTvXSG7NCl00htnRIK8c6jabIomxrl/HPBygqdn+ryefq2LIkbWMQPbvU2ofjM1zu5rBCWhCvcGq1URMAQX00rQ5RIGvGs4e5MCR/G2HdYdZixF4msC6YCFpI6Nt1U7cbrxNJbHCJXEXvmpgF5Sxaao6Xp23n6RdUiLBf8JOnHdiRNRNYrXElPuEDFKpicYCMSDJLM9eYp11i+3BMZ20+VfzdBRFQ6ZqAjtEMyWODhJ/k3hr5ev901Jkuu3r8OjBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:23:06 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:23:06 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 06/16] net: airoha: init switch before GDM port
 initialization
Date: Wed, 11 Feb 2026 21:22:20 +0300
Message-ID: <20260211182230.968921-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: b183ea6a-d437-49e6-c838-08de699a99f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qFzq3Fh13CiWeePt+JzgrI73VRNZtVTxBs7VtiQ3YxI8sibS63Lkfr+Wmvkv?=
 =?us-ascii?Q?p0fJpBTq9LRLXyAWynwc165og2VhgvLjxRQDDfwEjME/hJF+ZF3CxwnscNzV?=
 =?us-ascii?Q?kU1Xse7ABasqWjrUCuezvEqUY9ZHOa0MHFwr1y9gm+ZjPABKIT/o4AXTYnkJ?=
 =?us-ascii?Q?7Tl/k+PlWgW6EnUb7aHEdsVoGf2nnB63+uv9PKd7+DZDbDaRlm0g3ck76svW?=
 =?us-ascii?Q?7qrehw/9pt8SbNOjh+Rnl5QKvn4GYQ3AMXvzXqv/XBE5OTTbqMwYkGeRxwiN?=
 =?us-ascii?Q?Kpc0N3EoeQxmDcxiZxrjLVkrXRYOMpNWPph05oACEFlD2VksHsL79qZ5ryr1?=
 =?us-ascii?Q?SiKZCgRgQ5BNCDSP49tf6MgLtlKZ9srxOln5Mtge6sc5vF9YP6TKrcW9+/h/?=
 =?us-ascii?Q?W+GwU+ajykdqkMgCHUJGnvXZIvuIvxl6vfqUgGUvAFIAbY2w9YXKiKkhX2wI?=
 =?us-ascii?Q?u3oGLSKTXgjvXWTC7/z7LFLg7pylFgSUAfHV3c51hMhIOUoo+DhvVT/kF5gL?=
 =?us-ascii?Q?L2om1MqQkKRWE6y5oavtui9F5j7lHcdkELgHFW0VKX665prLZ5cPYFIhRgQd?=
 =?us-ascii?Q?6kCgHkcWNvKMhSUlSHl7gCOAJyluecTEt6p4y4ZPcRY1bbNCQBI4KFXtFyoM?=
 =?us-ascii?Q?tZvAikQ62+z8x56SyXh0usWsV/CroXzkuyVW9X9qptLlNO2txAlxeiAvYWU8?=
 =?us-ascii?Q?lpwnQPrUNHuRU9RIU6xUzIVgNZnls84dixqw3DruBiqFi5y/PGvdz7x9GpFl?=
 =?us-ascii?Q?s9eFlLXvN19Uz2R3h9tOr4foulfyE2gXaoxY2O6ti619IPfndTkG8kMI+Mnc?=
 =?us-ascii?Q?ZwdWFGeetVcZpJdIONfYXpDXwVu8yuYNhZ60GPefS9nXk1mHgAhNmloNOmQr?=
 =?us-ascii?Q?79FOPi1sCBI5GI/dDKf/jb8LIaMbBPTIO6lokJ8bZ4S9uAO7pKxIRe/IzN/Q?=
 =?us-ascii?Q?UQIz2tUnq8VtPSyv0A3Hi8xl9NLHTwQfpgJYsMWv21rgmiOzwLnXecMTrW4D?=
 =?us-ascii?Q?jtrHkYYxAMAnX39cr4XQm/pQN9OyG8jlzk9JEaWXzZk7EXOYMpgwx5TwnOCP?=
 =?us-ascii?Q?SZtZbZY8hHKKGdz9fACQKdLKOieVqSrD7Ap1xf/lA3val1WD6eb2kVssyuEj?=
 =?us-ascii?Q?WqEkAcOpnBLBbnqfCku6PYFlsbgoG/uG+zpCPOOGDGy8p1GoklILTm1Rx4Dq?=
 =?us-ascii?Q?qSrONjrnSzspQ5tSLp8+ZAuBWCWEAZX6ECxy/9/Cvr9mNp4iA0bwtJZ6dlY8?=
 =?us-ascii?Q?6rpjAlIoHc3+7CygUhyEobUkd8X3Cokp09Pcitzfh40kJaXL9E6MyiiSL6HG?=
 =?us-ascii?Q?rZ1sy0j7qGcnHA584xA4XrDuvYQdbwPpjt2reqpRRhZBZKvDIv2c0rtbLXe8?=
 =?us-ascii?Q?3qpiyPG8jKUw208GqJwxRHmmg902MKet/FuOvup0r/QKEB4cTeKIaVlqKp8Y?=
 =?us-ascii?Q?v2dw3zitqchswejIQPeKLnqnZt5MOd+C53PwitpM7YXkWysyF8TC99sDa/c6?=
 =?us-ascii?Q?njDc3wnH4vIa34a2mEh79ZVi+j+7CYTMIT2y3Hs3i5QYtqF+ZJVe4juGVa1s?=
 =?us-ascii?Q?ue2vdpisYZ+lCcirif1IenwVPuUdwpkY6k69a/tTaeiBckbhMQ7wv2bhdIhn?=
 =?us-ascii?Q?/2IOqPG3BmGg0F6m/bpGNpB1moRuERIzXq4fVMZRwyX3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z3SRmcpdxRqcCFdf8U+tS/Dvzx4io8CqmvaMfUTo3EifjHEQpGvZJtXUr32K?=
 =?us-ascii?Q?CCdAmaHjOcVkYJW18mTBtXoIR3GvEgLWy5WTExzw373sDpHOG56bMCalzJzK?=
 =?us-ascii?Q?W3jjrU0F5+QqgPbKn76HCtErPcZvNy9o26PZ5P6iwH5ZiL4Rfdq102+IP7rN?=
 =?us-ascii?Q?DN2TvjAW7PD9lr/3ZSiN0MAri0kj1Xoe0RnxL8IVRhfEWFH+I+Vn5GA12xLj?=
 =?us-ascii?Q?76jqPIPakbyQ3PxTn8rFhEsawevE6wvdsFSYThtU8nv64pXRRLn2pkUm3Yzj?=
 =?us-ascii?Q?jbbi82Edlq3XO2Azj+bGSqD+9rvmxqVOa4KaYI3HpX6BLAMY3AWiL4eUFI9l?=
 =?us-ascii?Q?t+1LFpSI6Wy8oUAP82POwi6xwZlpOhwkxVMKX7/op6pBnD/d1SX0bie3o+Qc?=
 =?us-ascii?Q?/I7aM+o4+29AU7Tcyapzw3vp0mzxw+Qfzck2anzjXpHpgh5qJt4n2aTplL9Q?=
 =?us-ascii?Q?AE6r3VH36rwPNM69mVDlEWAxU5osjrw6Sn23ZJ+1Kej2LOSEzApionJuHjfx?=
 =?us-ascii?Q?E7WdUYAfdiF+JRxDhqcUvpgtetzo5MY8HQQtwrowJoaLx6a5KSG8fWZ194qA?=
 =?us-ascii?Q?E3GISYDWy1Zr0Wa43u88UHP+eDWtmASAszDo1gqqN1hJoYONhK90g30TjLg2?=
 =?us-ascii?Q?ZTiBVIy8QuTzREoDicqsdBQ1i6GibUBJo3CCJhwFlQRvsq9JZlK/fIyoDwB5?=
 =?us-ascii?Q?4uN310GNbMPh4UZxyGWldCi5KN56jRJ1bwXjOggh+KFeAaippC04A0Zd2WII?=
 =?us-ascii?Q?x/vyzOJ7Y1u0iXHlP5rFuDQD0Jh/7OvuKMurO+xBojHD+hAe9BqtcEQO27P7?=
 =?us-ascii?Q?w61WaD0eIofL35adBBpylm4m1E3R2pO78RfCz0jK2b8xjtGZyI34yYOTeGUQ?=
 =?us-ascii?Q?e4aeUKjobSMoAPqS1zxGBYODY4cYnC+ycENwgvkBqYophbSQ5ye72xLHPM38?=
 =?us-ascii?Q?uzJJsqfyD9n83z5C01Zwx4unxmA/hGSLh84FhtBDMKhiRHrrPCFrX8ee+faS?=
 =?us-ascii?Q?k+Mb1jT/alMKFJ4BlPhqRb74rcrpHHJsvxD3VIWKpfLZfxdYCVSzDGR/2DyR?=
 =?us-ascii?Q?00RHQLjTcXqtBwSxXTSYDqAJHh9nr01KSVuZ7auFNV6cclFFKq9iuX0QfZwu?=
 =?us-ascii?Q?bv4rHU6naGH/BSPpp24Gs6U+oe5+GIZiB2Qq5GX1W3AM7iCqO4rwt/HBnr+u?=
 =?us-ascii?Q?Ic06elJIM2cI4R3Pp3IMNFiO+kmcUZgTsEgvCZjMNqf363oHH64vxin/8zs7?=
 =?us-ascii?Q?2Ec2D+ZYYKAwxLqmfpQW2xNhOF4kpGS5sKjBbSzyg/Ql4TnQuJ/o3pEKkA1n?=
 =?us-ascii?Q?mIBK8E/bu+NypadsJuYk3DA84YnoN3ux5vfCgXemIq6a4kik39q9e6Ja1Lgr?=
 =?us-ascii?Q?HcTJI4j7z5ON8irwoZjyxvD/VZjDtYfb8VBk54cF85benmskFK5QRsLxXkwu?=
 =?us-ascii?Q?8TOmkwSdXdisvTPVSp0uX9v1zAG5sskoMU4Nl97coIGpCZer681PSaLwbE3M?=
 =?us-ascii?Q?DXgWfw/dCzQHe8naHqEXlZvLyWyIAeKR2EU4rE4DoVNcaGpeOhhDzPggVfeZ?=
 =?us-ascii?Q?be3t3zP3UGdOPuO3qnud3igxDa2lxZeTFwXl0BENDLJ+D4dR9cl8AaXu7mPO?=
 =?us-ascii?Q?zEu5yrGgaBjiyEwNkmFLwXQKkO2pdHp7X8hFsfFs2HQHBPCc9ZnWQkRVdLWC?=
 =?us-ascii?Q?Slm8irzesGTiTg2YSCCkqbfst+jh6qYD+DzxTWwXungUElvSU+y2Iwuk0ShG?=
 =?us-ascii?Q?+Ahd/qSb9F344S5iMksnBlQ38IiyIZ0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b183ea6a-d437-49e6-c838-08de699a99f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:23:06.4268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dntmlwfxn/Up4UtujowMeUgPjnRDgStzYqTh96ZKM2q4ACXmmykxsh63tKJXONQwxoRDsR+bYn5OCM9TDkSwmjByq93++yhSX270Fa3/u90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

Call airoha_switch_init() before creating GDM instances, so if
allocation of GDM port fails, early created GDM instances will work
normally.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 9052c807cef..fef803ca167 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -854,6 +854,10 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = airoha_switch_init(dev, eth);
+	if (ret)
+		return ret;
+
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
 			continue;
@@ -866,7 +870,7 @@ static int airoha_eth_probe(struct udevice *dev)
 			return ret;
 	}
 
-	return airoha_switch_init(dev, eth);
+	return 0;
 }
 
 static int airoha_eth_port_of_to_plat(struct udevice *dev)
-- 
2.51.0

