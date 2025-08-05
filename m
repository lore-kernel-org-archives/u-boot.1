Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9BDC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656238416E;
	Tue,  5 Aug 2025 10:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="1460pSSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACEBF84148; Tue,  5 Aug 2025 10:15:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C7F0831C5
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azmBmYqW8a0usfT3CszkQxY/XsHSIcN4ec+RuuBnSezwwU5gU/FH/I63Niy5eNX28+SwjCWthvB9bqR4Cqk7wLyW7N6PBn5MeOLTSQd7KTJcww7wu03WszlvB4A5FMdpZAwgfEfsYXhR4dC/PROV2dusubTl5n60ncISXIG5y/i3kAOuuQuzkUs1qm6nVsCf+g9GyN6MmaeLqNvg70q80EEcra/T7vh2zPTav0dU09PJe6/U+EutcJVgLGiuyDmxMsyTOTG+W7p0gLRrMn8JlRAraLmO6YkoRqWFeTDLwAyyNYl19V1q6cTHJq3fdhwk3yLjTcUdznwhn0PfB/lmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=f1aIa8vyeEK+jujeA93NjOd53HUBEKVDW+SddCwww84JJ3wgPOS1Lyk6ptLSqeXs9ogGZux6VCzjbog4/TFv6fVTFWwrhjVwuiRdOZFkRQHLKFX6VyT3htm+Gd3M/2pRg/TEojhyFRG5H/q3PVkWYXOefZY4S6EsHGlJgRw0qHmwtYDuta1vyzclVMwdB35PydPQuFF+ptHriA8hFQwkPXcn5q5AQ2dX7blXF4f+R8DafoHWcm4EJaV3SOB/y6QLTnBnpwpbgTcnJJQPfOttM2AO+w/uofUh/BdAk+73TJJwfGo7p+Vqo6LdMta2Kldt8wRIRJ+FGB54h/jbw21Jqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=1460pSSdZe9M93qtzQ0+FiCPXfOnNI6cBEMh5M1VkTr6B/aGK18uy7ZLtdJoG7bWYRM/1LBAqCT7r44CMrPNGKz5WtludClyqHIieju7+4npYyjzLqJOAQ5kpHCz+kw1hy5EOSJAlszMctO5WGo+C9TUWshxddiR7LPnB+hMDh+doPTlWs00vWIm0M74IDoZ3gRJQ604oUZu/Hgren4o8wGG8pO0Vbxvn2QHgsoiJzGafD1YlzcNDnUNrzrIZ+Q5GHRu06hlpwsre8IJuwlND8tsf7MIx6agssol/7riDybh6iSZHNjz5lMFxcUZTt52Xem7+9jxfDB2jzwgniBEMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB11074.eurprd08.prod.outlook.com (2603:10a6:150:1ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 08:15:21 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:21 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 01/22] spi-mem: sync a bit with linux-6.16-rc6
Date: Tue,  5 Aug 2025 11:14:50 +0300
Message-ID: <20250805081511.1482964-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB11074:EE_
X-MS-Office365-Filtering-Correlation-Id: 117dcdb4-c85d-4d66-f5c1-08ddd3f83889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZ6uGP+N3DtWA1VPuP16Yi7i+VfanyaZXkfBUe2yupOIwtKeYYuZeDM4INwW?=
 =?us-ascii?Q?E/VwZvucu45eckvQ6Sl8KR92MqdmX421sfJtSrrO+eB484Zt7LGNWOUEEVMz?=
 =?us-ascii?Q?+Ypz6/NRS4Sex9M6lizeeqwAdP+iO2vZiGbnHmHf5QX+SmYgqDFGE+WXWFMF?=
 =?us-ascii?Q?JsbyeY1lIJ2zfbpiD1QD218NlnOlE8wM8/PEJ/dm1dBbQmroCzPnv3W8XIfa?=
 =?us-ascii?Q?a9B2ful78CY7z9IUzZJUpa6lHkbpy6YgJCAHL9ZnM/SH3qZ01uI1J+R0tNAE?=
 =?us-ascii?Q?BYkFenf1ZwDcsNgKITPtxB6zNn5EePoNG8AnTpCz6RnSnZ64Ve2CkvK30Vtt?=
 =?us-ascii?Q?IbYd+3VNJoVQPojqhAt88ceZYPD3zCMHzlf8jwu3isTOmKIb8EpZZt4IL2fe?=
 =?us-ascii?Q?m24DAIgmDwtw7OOwhWtthUJrwWsZu/u00z66W647CJiIeMJS5Y0YzGw7n6sS?=
 =?us-ascii?Q?7rWbjffGjSJxE1FlYqFogSyGfEHA06Qf7ilZIDTnLL7SFm+csQwzVrdYpDwO?=
 =?us-ascii?Q?nrYlkvIFU40kju8aOSj1lZgC1K9EyDxdXSWhKGPLDQEU0Blu1vHanbKoDIn+?=
 =?us-ascii?Q?zAlw9/LQh4El1acNnwgSet/1pokAoTtSSNtCAf82Ij3B20EdoIpOQCzwp8dh?=
 =?us-ascii?Q?aOmGxatGuwCzdTGYcMBb64B/EtChxA2q4bOMdgUumiK8itAGS9RsWAA/n71d?=
 =?us-ascii?Q?LzJ0wQdjhwNGXwvAtCrUZTYADg2aqKoItZaD6bOPJNI4bbegiwHeOenMphr0?=
 =?us-ascii?Q?BQgfZ3SSH9Ooc0mIRgKsf3gBY0bZqhTvlPXxOSOLk0ltiXLo2sfM7QxfAQoj?=
 =?us-ascii?Q?/B0vAnpYn0H3tRE4RSbab2MRTQ1rooCpqZ0dfhLEw8fIyuQgmU84j277CwhS?=
 =?us-ascii?Q?HBaGB7ry1B7b13uUl+q3pAsLoItKs8sLej1Of/kGfUYhCjLRcmdkqP/Rhyrq?=
 =?us-ascii?Q?ZJmpJgqvoasziXSTht6XQ0/MyBX4EXZCL/DDaOi7fKDp43gGyTtBNokHQund?=
 =?us-ascii?Q?kMphrGwkYCXCHgsxxDb2YDC7Suouvm8anWhuQIMz+XKERFsaErD5ChgHumUi?=
 =?us-ascii?Q?vXYbkIogwIFCpYYwYMkumTEAX/UA8k4v77kIw2LTY4z4qOof/wZTtfen1NMp?=
 =?us-ascii?Q?OilyjE6Q1oAsEaCyZXWonyXfW0CC2OGv1PqQhzi38GRr3PCZSFsceoaVTFYJ?=
 =?us-ascii?Q?7iBg1RE91QODAUHcSY8LvNL6BxGq0LHDBrFr/YLld5j18GxnRjV9Dkn6pGYK?=
 =?us-ascii?Q?boftqQdHoX6TP/n3ZitpkYEnmGHcrLGQWdBJDryomOeQ3O1IkW4cfToJ0l+Q?=
 =?us-ascii?Q?/KkiMzxCmYVYBsv6eyXp7mOG4S3Csdc56HPTkgmbfk7Au11Go/F+72qt39CF?=
 =?us-ascii?Q?vrWgw1EUWW+EkoO13Be3R44DYHpCB+Uhf6HLRAMwFgiO1rr7QzPqwpqkcar5?=
 =?us-ascii?Q?Lj7NGTBbeIWktobpwX6hdI3Y4kHe4GDwRASWCCddwCHzFtc4FLY+BfE0AMhi?=
 =?us-ascii?Q?ygMvMed4XTA34uk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ciDcdT5SI+ACZ8BdfFb/8/MxO+pWo44I+jGsejPDeFqkj1ufCAM4Pjj4bp/h?=
 =?us-ascii?Q?eluFitQv3MjWNEr0zaD/kgTQ2dLqNvWFiZYWVE/elraWBQImiigawjHOBYu3?=
 =?us-ascii?Q?xvDcPdABQknMUyHMoYOdiKg0/hk9nVlZJJ096Oq1PtKC1J5pObCq1PkCDbPZ?=
 =?us-ascii?Q?WRBKoEg9TsvIGaS4W9VOtZIxh3ssrZR2K2fD1Ll32qEgdgI9o9e7QwYE9+Vr?=
 =?us-ascii?Q?IktNcdK75gzZOX4n7jCvjPd4EvgF1mCxfA7gbqrZpgaPHSeDk1uanUNIewJh?=
 =?us-ascii?Q?D5F5aTXXqMChN2EqlIk8KbClPAmPM9P7nF6tr1Y5LLXk9jMa003/kqfQYJSw?=
 =?us-ascii?Q?LAA0DSBqTst3KPV0U9mitmkFOw1jl0QRUsxz0gSyijGD3PqlRWnFkItk27op?=
 =?us-ascii?Q?u8wX5HuiHqCaQnM69fPwx8BoNyUKISCPlIGl/g4NoGTTWHWwTwqH/wx9thpU?=
 =?us-ascii?Q?mF9ZTsHI/uzu3ZWQL81PFho0ku91OlPWqVIfA9I8Asa2sk1vkb8rBZwfvwnk?=
 =?us-ascii?Q?zbkqj9QGM+V1FBo2rzNccNSDdy0dq0UNyMTWUzHFCqGbm8cpouvNxxuhAn/z?=
 =?us-ascii?Q?RwOvWW3P2g+GlFLuJtwLhs8e2y3VPXMBpYq29g2imU97FyzbdzXgPCrzhJZx?=
 =?us-ascii?Q?XgzcGdKf+Qydi3DXff3s0K3uGrcYfq68YoPOm2Ks5OOE2nAUfu/DIRURRKfd?=
 =?us-ascii?Q?SPFCZZN2Ute9GSty24pC686PWhtHsXJHVfetKqtFQjaBJmoJP1hHYtXhnJv4?=
 =?us-ascii?Q?cNjtbVVF+1Q8MmiG+r3GaY7WTs44Zkuete0MObEjpvIFlVjVMM4RWxri0MP+?=
 =?us-ascii?Q?iGajZYIMfKi+kr63eC/R1/SdRUg/Vr9xVp2YuLlPaQjntfCeXF8aMLH/MgNz?=
 =?us-ascii?Q?CSm33lxY0nKcH0UCzgWfYqYG6fXpX6eCkhdoygQXi5Ej9ehVIe92z00HHiHl?=
 =?us-ascii?Q?+usHgn2LibK05kRAWl62LOKIS7KSM9vsticxuAMnXZHSHTsTDSvkeOo8UTp4?=
 =?us-ascii?Q?MsrarCNI80YGZsTGlguVCsbNHUgzZl1zKbFnktfAd7tap7W70auz9adBLt6F?=
 =?us-ascii?Q?eH78Bq3cGt+RpL3cwW04yyMzK4DIn3Dmj4cc9+2kMhHWpUrQyM6eYt1dmg5B?=
 =?us-ascii?Q?fMhKxYxvBucy/MQkSurknUxxhow9P6MvJPL8q9W6xfsOIG6UogKsqjxv1ahN?=
 =?us-ascii?Q?+WT6znT4h7aau3tDfepkCIUdudeRXde0l+n8sD/nT1T+NSu9/GU0MI1qF2gs?=
 =?us-ascii?Q?5YJLzTFg6zYn1p8xtAZpcjM9IGJ+PvpQ7tXb4kyuTXoUctHQbMkQf6hC+cfu?=
 =?us-ascii?Q?F8R6mU0/0VMWFrFA3Yp3hKFgX/j+Z7zR5vSgFGMiHOypNVQot2kw1mRcVMUq?=
 =?us-ascii?Q?YUrSLuvu0/RzgkWPDKnTfwxhwktf/zKGaH1aSWNgFuTZ6eGrP7cABocYS+Z+?=
 =?us-ascii?Q?BM/l6UHnGhHu0gviYdEGejMtqa87mb9u78H68E0sQBoxZBNyw7SQE9fetfrh?=
 =?us-ascii?Q?rerWVnIB9NUCdU1EIA3ZDn9OVjyaCLK/EYi3P8oSAlsNsQc1wmRpf6fOHnXl?=
 =?us-ascii?Q?9/L2W4A7aJtfOzw1sjTJeMCMi4SdAPwVhfYEl633viKRWE3rDqi3DYd7n1Cj?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 117dcdb4-c85d-4d66-f5c1-08ddd3f83889
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:21.2527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASdY0fVfGbHC5NvewzPIEnTtaN9beixnFHAAYNw7kE2GcQHssZJHRVAC29mVkUMKq0K6MVKlzmZdNI/sTaAyOvJUn9A1Ze8OfEkykPMSXKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11074
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

This also fix 8-wire support a bit.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-mem.c | 13 +++---
 include/spi-mem.h     | 92 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3579b7d7db5..6f06650384c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -120,18 +120,21 @@ static int spi_check_buswidth_req(struct spi_slave *slave, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
+
 	case 8:
 		if ((tx && (mode & SPI_TX_OCTAL)) ||
 		    (!tx && (mode & SPI_RX_OCTAL)))
@@ -300,7 +303,7 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_release_bus(slave);
 			return ret;
 		}
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 2eb05a2e5bc..e68e2b50e85 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -17,16 +17,32 @@ struct udevice;
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
+		.nbytes = 1,					\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+	}
+
+#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+	{							\
 		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.val = __val,					\
+	}
+
+#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
 	{							\
 		.nbytes = __nbytes,				\
 		.val = __val,					\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_ADDR	{ }
@@ -37,22 +53,47 @@ struct udevice;
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_IN,				\
 		.nbytes = __nbytes,				\
 		.buf.in = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
 		.nbytes = __nbytes,				\
 		.buf.out = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_DATA	{ }
@@ -62,7 +103,7 @@ struct udevice;
  *			   transfer from the controller perspective
  * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
- * @SPI_MEM_DATA_OUT: data sent the SPI memory
+ * @SPI_MEM_DATA_OUT: data sent to the SPI memory
  */
 enum spi_mem_data_dir {
 	SPI_MEM_NO_DATA,
@@ -70,6 +111,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -80,26 +124,35 @@ enum spi_mem_data_dir {
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: whether the address should be sent in DTR mode or not
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
- * @addr.dtr: whether the address should be sent in DTR mode or not
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
- * @data.buf.in: input buffer
- * @data.buf.out: output buffer
+ * @data.nbytes: number of data bytes to send/receive. Can be zero if the
+ *		 operation does not involve transferring data
+ * @data.buf.in: input buffer (must be DMA-able)
+ * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted.
  */
 struct spi_mem_op {
 	struct {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u16 opcode;
 	} cmd;
 
@@ -107,6 +160,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u64 val;
 	} addr;
 
@@ -114,28 +168,35 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
+		u8 swap16 : 1;
+		u8 __pad : 5;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
-		/* buf.{in,out} must be DMA-able. */
 		union {
 			void *in;
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
+
 /**
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
@@ -143,7 +204,7 @@ struct spi_mem_op {
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
- * This information is used by the controller specific implementation to know
+ * These information are used by the controller specific implementation to know
  * the portion of memory that is directly mapped and the spi_mem_op that should
  * be used to access the device.
  * A direct mapping is only valid for one direction (read or write) and this
@@ -223,10 +284,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
- *		    limitations (can be alignment of max RX/TX size
+ *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @dirmap_create: create a direct mapping descriptor that can later be used to
  *		   access the memory device. This method is optional
  * @dirmap_destroy: destroy a memory descriptor previous created by
@@ -300,13 +363,16 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 				   const struct spi_mem_op *op,
 				   struct sg_table *sg)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 static inline void
@@ -315,6 +381,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
 #endif /* CONFIG_SPI_MEM */
 #endif /* __UBOOT__ */
 
@@ -337,7 +410,6 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 			    u64 offs, size_t len, void *buf);
 ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 			     u64 offs, size_t len, const void *buf);
-
 #ifndef __UBOOT__
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
-- 
2.47.2

