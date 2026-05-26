Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B56ECD5BC9
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 00:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B851C848F0;
	Tue, 26 May 2026 02:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="d1J+S0YN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CC284926; Tue, 26 May 2026 02:25:52 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A2F8490D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 02:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSEpb/sIeuNKE+zqpR+rMiQTU18Dcaz1c9DdLRhMi0rNGEBBhV/8OtAWl8td8N/r2ts9mv5op0k7CI5ZDiQ4OIxCDFXuLflQnxMl6mJ4+fRxv1uMmF65ssvXtOEe2Cv0LPN+DVclo6MEFg30n6f/cWtJ7uQtzbX9ia2nKsB+LeBDBCabO/sSeU8ZPtXiGXENFwgHbTznlzQ1GYFQqOs2fS+ZOw34lywWrTs7ANaBjX6XpODakGfHJhNvs+LgbQpuvhMW7ET7V7m+5PjPuLyOjOPYGCcMkqh8l+L2G4HSzWPprFAKfVcJXyZk03ubYAyzXLGjxaZfZrA95G3ylknuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=Jyg2FjTNAun6PkLjy7q9nWNNvIyVu5SxAwUJ+KaQT4RaZb9gD71mzUiyaYs0OWaXqDSHDG3VtmvGHZntU9CmzWpEQSarFCOODsrkpTQz5fJID5f6ikr2rS938EBb4FIL3gBWycVJ742HuX/Wyl8wTmaiFSCNPMF1WQL7IajjB5nE/NehDkRVjQLBVb3LSo9eSB2Y1eFdxy6CXBoHGCpmo5DdZjzv3IZh++fS+uOzpp92f/lfbcbi4+w0jWVeMdPkgsOffA7ve2dLaqrxr79nfGSteR65IRLr7uLeFfUtwV8OWU2uOcHHa/JAx0BxfTDdnW4os4nhTpaoemvWqIBK8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=d1J+S0YN6QJH1149OFC5t0wh5e4EJoRgQfS2cYvXpObPc/3qX+idOSsCYqegi717Fdtc2kD+AGcCP7z8SbqP6Gz4qB2uJvi1RdJdQnCLtoj2+ALlYoR4sMUZUVWlbfd76LYCq9BiP1JvA2yf6gUA+Fqt/tpAHrnT12bA5fNuiH4qVzcvqBTu/JNciH7qb3F0gH9StGQSBtyaQNlZPiK8yOKOwFhMkMAQhm7B/Wl0DEbLtjQ2C9OO5vy/+zS2FisbaaQo6CyHCHFdA37SnVRskLFwAFcjWNNvPiI7ESGND1xg9M1d7y6U73845mVaqYzN35rcvCypH+c2lr2KfKBVNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB7682.eurprd08.prod.outlook.com (2603:10a6:150:61::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 00:25:48 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 00:25:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Anis Chali <chalianis1@gmail.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v10 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Tue, 26 May 2026 03:25:23 +0300
Message-ID: <20260526002534.898340-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260526002534.898340-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb7168d-4ebb-4f22-7e08-08debabd558f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info: KrrufSgeatTVaoWoWxUgIV6Jh/07KO14RoMvzh7REABW/1vXr6Eb3Wyt4staD2zf/I88YDlzgYTiXxVCDGG89DYTWZVY1pbDUx9zIc714Y/5McH0oJF8iVLwTxR5XK0KRA3vI/QQrQcoh6dgPbbtE+qOVUtahUJnPhhVsMCHCdWk0FN/jKFWxlkcmcBPqeR4n9anSB9dV4uGaaKmh2zTDUFuICl6HxzDgkI2lUHn5gVa0PVFCFwoJqOaq13rA48KoEl73Q9vk1Z7OYOADKFxYMLfhsYTcpXoB8OC3l5rhF6qnzWmrAk5ka3BnW6CPZOs7djsAsqajwSz/CuzmZJYYnIExeE+9yt0xq3L+FfRmktZ568IAQYyCoQZzDiW6fTy96uaaUDoBFxYtdhux4dQLQhGb3HbKfVMHUMGGsbJ2QU+xUBHKzZzZ8scjzLJPhwfNJ9imMF1XNOWaDQNF3tNf9pSm7EbPeDLCd7/fOZgN6GN6tILIrFtcTLcvTW6VIp8Sf5eOtzgZ1E43DBpjZ8tB5FIRr9IErSbU5J/uTP9Jf3/meUylFZiqc4H5e6DR6u4pbjEaj/3CymLfvpoPVICwMzfv/owyBA2o79iv1I7hhy4isTsA84pObIq3ItR9QIWA+YTJsPYG13Ao4YU7rEiOrBQidZPcl+ljIoQXNlOShjh7rtwicQdetNCVwce1qSUnKvbzv3187VokNCzeODdi+HA4Gp9ieF7W4c4XErWi2RSqoabMX9X31X7jJLg2Dyghgo3rAd0hja6l4P7A7JpwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TN7rObKQY6TE7VX/UM937VoawQWO+Bj5CsLoEl3Lu6/eQsNWPK7kU7IjWLt0?=
 =?us-ascii?Q?wpvyNggvuPqtOftdetgeVKftdYB0KKiutAVxltRcpnOM/aem3r6F1XawUwe6?=
 =?us-ascii?Q?n9EFGzPHRsrVInc5lzur0hSFfOLUW9rBOxAbgQb9JK6eYX2Q/lfIWYlWd3RB?=
 =?us-ascii?Q?jfn68wwsTrDU0DRyxpeM9i2pg5gM+fAucxKTFhCLORA2aL5yLIwgiiYWmmGG?=
 =?us-ascii?Q?KVb6yB2K3+nTBTp9K6+Qlpl4NOoeWuxCTW1qQ/08+8++JCgAB7IpuT8KsNay?=
 =?us-ascii?Q?7CbDmtqncNFOXlwtff/pElEYT2D/B2YgmpwCfMKaMd1AFX8O8f+Nmva57X3Q?=
 =?us-ascii?Q?+RgWmVRjf/heWYYnzU0Fk0vGJPzcJ7WHNkhkagSkiGA+5rZ7aFWK9giLtEGb?=
 =?us-ascii?Q?SUCAwSj4bTyUdMwB6dPr9zV5BIDLGv3EkxhBlJvN1eP63MPNDivGfizleVnu?=
 =?us-ascii?Q?z818wibzWQKeDJyVX+sW96A9uapOBXMorc21vWtyfxgFzUj2PAlwM1PyA3gD?=
 =?us-ascii?Q?v2jjX5ixZn3h3gOPJy8GdwQgLYCkluM8F6LAjagxCVBdB63IqppmtIFeteBZ?=
 =?us-ascii?Q?37loklx247oxwOR3q6Mq2MqPUnyj6w2jup7fj1JEBMRs7tC2mO+iTaEtn/Yo?=
 =?us-ascii?Q?qOf/OmiMk9MvcMDtlmqjpgJacXHV2/BcmDcK2FgW3D7vd4Fbh8r4jl2SZLc8?=
 =?us-ascii?Q?edwTcVPmUdv3G814BiOgfeP85ddk8JsuaMU3ZfpTC2WCcZ+J/u8atz78TCrG?=
 =?us-ascii?Q?KmNflQ55Qoylc1tcD4BbveBaP3h12+43qzdSGDdGTbvccAj32TcG9EiwSQ9G?=
 =?us-ascii?Q?NDSxSkJWHm7ZtvFJqIyr1DiamEqQ7yAkjFYXwl6cUj5dppkQrkBvAm0KH7gG?=
 =?us-ascii?Q?8UcohDS4TNSMqlvmbGyKP0Li5NKEQW3MF7hICcoU2Pq0DRHEaB16S0kLCzyq?=
 =?us-ascii?Q?AeEy/RvF1KqMr0HmIzwPsFq43wqLtAuoPEmZHGxmUCuj27yqSUupXJCLphFZ?=
 =?us-ascii?Q?mKf+ri8pPpiXh+QY9M3fp1VohnzVrctDE08sUBPkJvhYi4ahMNwnDFgf3G6r?=
 =?us-ascii?Q?YXSBhlqPbMz5y3OMGiOxQSeHu1oshEOoZXG1fyEw0R7ig4bn9sHOyuU7GD+y?=
 =?us-ascii?Q?eRc1mnumw18x/cBiRUkzbZkH0/Fk7pibr+7OhZKfitIxjgJOcWtdtrYvRw2L?=
 =?us-ascii?Q?mtlmX/XTb4Q4QS+HTRxByHhF20pW+1IaUqLI4OyqYfR4UzSCcld1FbCBzUEI?=
 =?us-ascii?Q?4c55+biky4Y4Kh23bbGxmWg/tKgmmxTtKdQvG7C56vFTf8nVutzHkmbvZblg?=
 =?us-ascii?Q?mHfjhu2CSsmrcEA3kFVN3qZBxSZ4XDqG41I4+09rA2q0dbGdB+Er/tUA/Mrf?=
 =?us-ascii?Q?AltN/Qx5iuDC4N5Og4mtwoKdwPPQPwJe2tkcfzkvTjltYqlbeBF4Fe9NBjkp?=
 =?us-ascii?Q?83UwWp44dFKt9rBiX5xIiJzFdCMHaY1oVEudwPVD2sqcG8+NcPZ5UOvXX6Z7?=
 =?us-ascii?Q?1+8VcRsW3GYvzsSJHdwFYjXV1tKcy8nBE3jfoPccNOroM5W9lM+zTDO9UKXj?=
 =?us-ascii?Q?/X+KF0Ldzn50XWVatNgxYs3lzpEB2IWh87oQgXgKBmpx9826Q6+uAP3UC6PW?=
 =?us-ascii?Q?AmCfLzRefZkwPbzMrH77E59RdxGgn5t804DSj0rZlDy4kEd8GXbZHrxehqF9?=
 =?us-ascii?Q?XKtWHT3vCJWUPHJmLeCysyd+dcRpF4gSpOJwQ8cZBvc4IctoANYZ1GGB6rEz?=
 =?us-ascii?Q?GEXxJ6mInNUYoRGF/aZum8N5UePvSkQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb7168d-4ebb-4f22-7e08-08debabd558f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 00:25:48.2147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mx309LVu1Rc5QyeydadGqNdju50mi5E+WWurgiT30HaHuQesryx3Z0jfdsPAUFAmUjZyWe3PFCPdhBiPVrSonRqjIzaC1lzVYId5EHZ13I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7682
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

