Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FD3C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 11:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A25B84AF2;
	Fri,  3 Jul 2026 13:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iNmQz+aM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A768184AF2; Fri,  3 Jul 2026 13:57:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857D784A63
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 13:57:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCHB30+GZKGYCibJUkOL/140m3yEZviBw0c34Dxo7DDq//Me7+Gz/Zoi9x4+a+bi5UzbMmxMa8ZvyHoll+k3U5FsH3evsplCjMZYTUjBP4iZMyQxqkyAH6ApSCTuq9mMG/UV2QorWoDe0TNf+fjGWmcgn+3naCNZ/nBZPZ/Guahpr1CzxW6NDFSIaK6uEW7LcCMKBnNWhMXYmPy+B/hPp97ZwcbwOFdIZZQnXiYKq2bbSk4M+SXmCz0WGAgJuC3xoSfzmKWfFJG9pQ18t2goJbinzMPpPJO/3WWSeo6nPQy21zpq4DhMuIxYRqOHGy9deZxAYHjXtlXK1OCy0Z3zow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lKXSf1Uv+lMdz+nnGtK10Dp8d4+KhpQi+FN7m/Vawk=;
 b=l4QuufDCNNKlH2NA+brFH3wHHyQehPX8CJh3ZFcVMHVmPUCeuPvu8NtkSy2FYeemuoCRjTVpnbUENDAm0/6NCl4oMgaWzwFmQ23BObWoq/Ec/RDqOeg4gR4L1ovrgyW3JRsh6H4Z8luVaVq4LNfBmb/2WmeYid2pIq3OZwvo7cIzPneYgjpUrJTu8dJtV/BTTA6BR1UWc30DKgNZrR3XfZ1Pf+/R+A+PvWoWm3bzNKydm3fWDySTZcpmI+eYjl8WOsGQGmaeUjoxtje3tiZuLbvi9BpPwfpt/KOB9OZLNtUThDV0yeeJObDx5jGEdILMMb8aFzrVDxfWXQsD0XDqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lKXSf1Uv+lMdz+nnGtK10Dp8d4+KhpQi+FN7m/Vawk=;
 b=iNmQz+aMjw+k8sJd+kejBga2uhwZ+cJWq0adiMwY+eGbb9I5GxYo3Lz8DnCaonKolyQaOIFAino9jk8PP3+v/TulraQNEyxHbgvhHURDZi/mazpWAYmObqG1BqysivGsBIwG6/rMoxRkixdb2IeZ4gBPXv+byRcd8w3HkQp1mnXfEq4YKt5Z7XRpiIpUniZn0tKXjQgk9HuoAINYd6RFfWpD+im0+yOyQaZAeetkSuy8thUtnmhQ/ZxbWN3IQjee1i2D93pJ40zKNvvs4qSddTs9nqb692un/46E6f1HhlzKqpQQUE8pkj+ki7Tsc4hOKFsDz0n6LQakvfC+HfYpUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB8172.eurprd08.prod.outlook.com (2603:10a6:150:7c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 11:57:13 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Fri, 3 Jul 2026
 11:57:12 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v15 12/24] net: hifemac: Convert to common field_{get,
 prep}() helpers
Date: Fri,  3 Jul 2026 14:56:15 +0300
Message-ID: <20260703115627.2317120-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260703115627.2317120-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a154ff-68bb-4d70-6d21-08ded8fa380c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|56012099006|11063799006|18002099003|22082099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info: cSPW/izeeAykgTbxfjceCSfXr+QJO8GJOKP0WNP+/SQaeIh764eOHwFN3ebwQjizmE7A9K2UvqekblOcwr83Wh91AjGzEH1cSr7sRyPSDvIBsL1TyTtyB3JlSSmgJdWZ8fzpaM5ToIGmP5aNTmq9a774Zl3cgLXOZA5LLpLEhJ38dhXMZ1i9blkHn4xtLB7Gfmu0xVEjTqEoiwoawle2tcY0wzibD8WhSX/tBMxGImNrnp04twEyi4S1oqHHI7sIjkin+r3XbdujMoKVicEFUR525F7z7blldr/yR37MMEzw68RsfkGSyR7ENc4Xiglyzkb9ukwdeFvWb79gzUA7XXguOoDyqcPIhp93+NxXFnct0O6qRAYX9PZM4HxkGi9BiFJBKD2sZwo9c5rKh+n7xIl+Q63Nsk/tx1yibMdg6qJbiLNEYUadDlY/zcHd4PqUH9pA1i3KM4fhTrz6IhYoJ663Eo81OlRKlsdFEM3b2eIcfvAmrOO6vd4H4tj/4wMefVH1jBwZqhsAMVfSfRQFDUT10jNGqOSoPZYlLT0rNBAuIWElCz1fp9EEYsZQtRZDSUbGifoQQPsMMO6X/TE6jbGObyTylYJkCP+wQ2puOXW2WOIezMpLB4eKtAklR3Z5v11imDUTJqAwYJdneqyHj2aq/CODbIusR4YLD4FBi/3++SucLJkL1X7iJqFEWJboSqr/58NZz/FQEA5namv8RcH7SYEmzh2QrUaudW0C/awhMmX+meP18hydaFtfY6EN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A0I85aQinybLSKwkhmcFgdDl4+x2ESfhytAiO046+pp0UYt37VXaFxej/kPy?=
 =?us-ascii?Q?pAyhQzs/dm7o3wFd8N5Gro1fqNlyj9VE7UJWfrVmaNmf3ThzlF2GhqOd6tgw?=
 =?us-ascii?Q?g14eWhfIS62HdDlZPI/43uqW9qub/zeVqnU9SEQNP87Fd2Q5EsrN2UpEtSQG?=
 =?us-ascii?Q?I7rL5dPsuFe4+MmDBweYZUoOOQjCHh+fBL1CeG/Fyw3n7dhshaD6j5oX91ep?=
 =?us-ascii?Q?RIMzjBWLDuilSWIlhypnSL8HcOzCP9zPrSsAIkqBKOWyOyWAfsH+YuAPbaqm?=
 =?us-ascii?Q?elT/88HEIucGjZubU70BjSD6HmKjty+yQr/EMWcxbTdm61dMGVlbqua050Z7?=
 =?us-ascii?Q?L+QnIGoIond2jSSGMrD2oUitdLRHfx08otEvhInvk/32BsY2hIXTEUTVVTJY?=
 =?us-ascii?Q?qTOgkrsePmPySFFzhp2dj74VDg+wCHjtMuPPHiZkdDPrszR2Bgo/5FwijS0n?=
 =?us-ascii?Q?aV+v39YlOuhnKoDK35QS2ZS5hKx5JfSFX/PdlsrNwDAMLJMLITYP0s18ZAUN?=
 =?us-ascii?Q?+cDTPWevp5wFNHYd8Dm4nPIG6u6xMMruRrvIwXZcHPUV9ae4IBrPZB0KX9EO?=
 =?us-ascii?Q?eAJZIZwZk2BcpLluPu1XKxjTbeyAnnwnwrKcEGKGA5OARZijTiptWaxCzdNa?=
 =?us-ascii?Q?nO4GQgJX23Y0OFMOzF4VAYg232qV0c5vqI0PcOwolEbKskCi0c5C7kFj3JCn?=
 =?us-ascii?Q?/FUKW7Wa/nKcX5M+q8F1q1n0qXOfGDpJlHqto/Yo/VoXou/nS/7z6FqFYAaK?=
 =?us-ascii?Q?JST1PVsQuW9wpGUaaBvxJA0XvhSiJGpGk66XTl5thMp1KSrHG0+DVIw/JKTT?=
 =?us-ascii?Q?4qyOKrq2bd8iCCzg7YIuVtvz1pcyqkPCPYUl6n9XyuEE3X4ydE1t5uOOqbJH?=
 =?us-ascii?Q?7IuSREJOw/TqPplsBRLwXuM1FlyQ2qfTowE0lKWy7trOHPfTeLFy/G+MhfaQ?=
 =?us-ascii?Q?6jhuRMengxKtDeilibNhvX/+H2sOxYlKD5x0qFpEVEHqd/M7TpZKnQlCfHn7?=
 =?us-ascii?Q?p1VVzi1I4V6UbDo/Nn5YTpTaqov1waZYWVNNY/6vXvtlnuhNj4AHJvXwn74A?=
 =?us-ascii?Q?M5RkhRodhXSScfPslB4C6iigf4Jm5Jm0p+tfhNs3hFGFVWfcO9BSbEZJuceS?=
 =?us-ascii?Q?S2dIssZblSezSY6VgzRErkKtEaJTAbmH1sXbzgXqVOgnTNyvsfVtZ+74uLRw?=
 =?us-ascii?Q?fv669DoAP7eq6QcdNR9QbbxhyiTH/7tVKmvfdx8V4Ws/BO34vLI5TETjeXwk?=
 =?us-ascii?Q?pcBzx45I+ca5VPKdeb119j/HSmPZQzBZOgux+65PORRT7a2iDHD6PSp/r2D3?=
 =?us-ascii?Q?jQ0vqcikHDw/hCjoB4DFGJYjZIvdc6pUpyydhHXb+foN8KkA7mJ9mP2A2XoC?=
 =?us-ascii?Q?/GBjmcgBIT/Mdp9y6qB7MHkJBdYBL285TVA8V0idVdPPA89KHhlDl68+gBFx?=
 =?us-ascii?Q?Rh+8hdU3GjOTsCiZVI1kaXQ26vSlawfMpN7UgTv/6NftoGHN0Q614/FWYzJ9?=
 =?us-ascii?Q?+zkCd2arC+Mu6GCkwaE8J6GGvNrQ2K3sy03hB/d6GUYUqYHcoGJJQZ5G9V1Y?=
 =?us-ascii?Q?POc+/NYDkuFzW8mQN3TQNuJOHrBzupOh66G6MvCLWCnnhsWep/c04MvXnb69?=
 =?us-ascii?Q?HMlv1hWrkboCO5JkEVUY9Eq+rYyl9PIvwVhFkoJHfk+VAphgzR9v3mbBk7Kr?=
 =?us-ascii?Q?ir5xx+xIYovg6wwTNaIiOSz0q4MC3dQIZ8tBhRAmtksYg0Hq2MkhsYPIeE1x?=
 =?us-ascii?Q?Wn4yJxnW73IL8iRX7S1let+N8HBgtZY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a154ff-68bb-4d70-6d21-08ded8fa380c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 11:57:12.8539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fGkzmrQ8LsSbBXzGf+VEQniY2fb7u0YiBlHGgNu1N2GpHCih+2Rqy0M770Xkz9BUgqbV49uVJo8zFY7R+XtLhv2U9QulfPmnRznpPMuKZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8172
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/hifemac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/hifemac.c b/drivers/net/hifemac.c
index a64665c4023..7dda8cb8815 100644
--- a/drivers/net/hifemac.c
+++ b/drivers/net/hifemac.c
@@ -401,10 +401,6 @@ static void hisi_femac_get_strings(struct udevice *dev, u8 *data)
 		strcpy(data + i * ETH_GSTRING_LEN, hisi_femac_stats_table[i].name);
 }
 
-/* Non-constant mask variant of FIELD_GET/FIELD_PREP */
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 static void hisi_femac_get_stats(struct udevice *dev, u64 *data)
 {
 	int i;
-- 
2.53.0

