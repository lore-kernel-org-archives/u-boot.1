Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E292ECE57E
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 22:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF3388E56;
	Tue, 10 Sep 2024 00:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="r88f7EJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE7E688E4C; Tue, 10 Sep 2024 00:24:20 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E854F889F8
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxTZYu9+Ln0IU9cNtkRQr6uDiYxNDmBTWdhKa6he575gKoNpiGKkquNV9oME3njCz3YOkCXAKlMUcD8z1rmXszPQdZUAt7IrfFJYqmomYSDM0hBiLnFW4QzM+hJDJrst7hpX6/Yo40vJ9R37D4nEJ4bdKqYYq8L3MkT2KOOPDVg0fxKCo9DBqhScXJXO1JfNh0+SM9I410dhHebp1Vp19uOqPvC1gWZODeReBUQz6QywQk7+2FjLCV+eCI/3zyIhxmKEpiovfVZX0KpqBuxcooyAUlqkNGtRdPOAN3HtLTN87FNEMzxxOUeeytKpUQT1NmNvRbvroBfXQkmbKskYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzsgTtBBhFwFichKnMzvvJMvJjAegPEkOJ1Xx+b0T80=;
 b=Ory/xcDwVkvF6aYOspjsHsoZj++G9WfTLM3D0KWiARH6ERjXeTSmn3pzCNAs3YNH4AnGDBjH2gxHGjRl1pfCRoDfh52TVdBoR0FN/k7STRuxZUJgKKwLl3neoU3Xb+yx//A4d5sVypJqOXa15yEB+KtA0ID0TvFk7zBzsOkV4sWZ3hfXvNK5NJiKFqH2WyJssX/KJZbqCok3IRDtKKf92RMvGx3HtfQ5g5EDIvmywvNu0s7C6Piw4q25tqraNDkwI87hOYgM1+VrXh+gaEP1mGXCUOz04SzE4sLliWR+3Ta4wJWvgF6oDx0i+yyUP27udw0i/9m9aX+JQ6n5fTw0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzsgTtBBhFwFichKnMzvvJMvJjAegPEkOJ1Xx+b0T80=;
 b=r88f7EJigykXQEOAcItKNMje0q+A/Z/lTK6VHeR4/D9kq94PIOLMvvyKlwYFDsNcCIbOnVedmDeUT6l/V9Dfj8YB6YOgUyE4L74+AfK8sYdLQKl4fhLrPWq5echNi6XtDqTaMzVK6rqnOrzAYX9cj64j9m8O3X3qyKEDFf59fwRM1Soo+VSgkt4xSzOzyyOJPQjEexbFci4hoXB1AU5w1nCBaACUqiGYqkwgzp+cr8FFgoU7uDdDFVAGDRGKuXBJmqwem7nMjrKyIMMxHBkEiUpSJ8id6Utk9RK9+8LU8+GxXIybLEv9i2hEnCB8J7xANMnzD2m122LXHU1JydjuLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9935.eurprd08.prod.outlook.com (2603:10a6:10:401::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.15; Mon, 9 Sep
 2024 22:24:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7962.014; Mon, 9 Sep 2024
 22:24:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 03/10] mtd: spinand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Tue, 10 Sep 2024 01:23:51 +0300
Message-ID: <20240909222401.2562898-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240909222401.2562898-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: edeb880a-f9e4-44c5-6d7e-08dcd11e2244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ovQaULqJn0OFYuE7A+hWmaHW9Pt2YQL8T8SomF1YhkRW997W+Xp8ra7IyJcl?=
 =?us-ascii?Q?UmWSH8QtkSoMWJZ4CvdhGlF/Dm9Ao0VB55+vNILBVmm/2Kh0ruViaa0kX6EF?=
 =?us-ascii?Q?Qau9CLfP4m/+1kl8tQeRzzkgztS3CNIRsYgcOVi8BNsIz/x8xRjdJQbEaFOk?=
 =?us-ascii?Q?ooY/Rd+gub1TgcDdzbjSdDfdtvaUstYF3nMjj4KxkrjdVApIagdUVYw9rsFb?=
 =?us-ascii?Q?12ob/BH+6NuvVvn4Rqn25m+vvIaa8cph4UQ9Ufxca5jL8FzVGPXP4zzrZSev?=
 =?us-ascii?Q?00etSE/F2H4Hcj11AKD+9OeyRzjQB1E5UzEQXOj9Uoh2yg122VkVje4A3DiI?=
 =?us-ascii?Q?S0Q/MdtM38VhreuoTdF0pf/BEPcswyU00vDlJX/v+KRM6km29k1Tm3iH9F2A?=
 =?us-ascii?Q?6Atu5SwlvctmkdiYaGyb8sYzD//5uKILcG+5y9laeG7COxmnMg4dnHqb98hi?=
 =?us-ascii?Q?nCQUx9zU8W53vhoeJG7eOL+9rL0f0lG9hITZqXzHSaO+g8gT/ATz828faR1t?=
 =?us-ascii?Q?qplAooFNqz8iEEy+vnCKMProMfDe0hlxuzVhS+ElMwkQHSIF2qv37iQrduXR?=
 =?us-ascii?Q?VIjNQyO8GWLZk54SJ9dFdPPxKqn1z3Q3KsqQG+nan8mbeQDBHW8u1fhcrmbj?=
 =?us-ascii?Q?uPCI7SvJpyeU+0QyIwAezYBmkUaEbPPqma036rCYUG/SNBfeFajd2eUwMctV?=
 =?us-ascii?Q?P7ln+12TRt0cKPZG/PpJYK2MbhD1yvMDDo6WsKehGJfVpf5XZ7z1aThnfn6D?=
 =?us-ascii?Q?BNPVrHSKTULlox+qwb8uhzPR6DtCZgtuVFGr1gQV4dK1CYylO0XKJdAWFuiw?=
 =?us-ascii?Q?JOH3bmKmufwq2aDX52HnOKuWhnSi8qJhxVNqL+bJx5GEFKej7CGvs6X+WrLn?=
 =?us-ascii?Q?xZS2H45C3pqbOUGP18EuC+KNhLaiaKKXetvqS100WmBz4I4x6kxHE7h1nnYP?=
 =?us-ascii?Q?EfBBl1o+Kl3r8C9AzlrwdnGzN7XjVzYPAGLL+ZQnBi3BO9Ha6JWGVa4j2Oe3?=
 =?us-ascii?Q?dkvVHlQnz8AYku+66p366+EteGSLGVI1UBEIyAR1ltE/m1cbrY/AehhLdjLW?=
 =?us-ascii?Q?VCCe6ci2oSwtquNiwkbHIE2zrZcvAeONvp7e/5eA6kuvxumcqYmC0wDsFjmb?=
 =?us-ascii?Q?h6w0LZPvfrPOvKS72LBL+aiHLg5HsIoYoIjrSjo+yHDyXp/bk6VO7mcrzcfp?=
 =?us-ascii?Q?DMVBT5FzrTsWlvLn+o1ODk2vQlECDn9RO37FoaSesP6QxRMh+ktRXbMSCCnb?=
 =?us-ascii?Q?AVtGeQ55yC2P1Scf3YkV6K4QqUazsIMtIoe1LDGQAtmH+3p4cgUtoDOWbdB4?=
 =?us-ascii?Q?w8B0Hpn9d5g9DaRbTYIVvWhZmRcEHL531WcDi0ZikeYzsllsxx5d9k0ItnVz?=
 =?us-ascii?Q?CPHPsxV2TgHT0iiUcqjY4LBo3TJAjq7a2gSH2ZoOVl/aQtq2niBn+OOmr3wG?=
 =?us-ascii?Q?9flFi6L+QRU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?joE/WIzM1BesR0sd4Rub+mqw3yh9nySlJRRSa1R2xv9mWNOFLdb6kEH/nD+i?=
 =?us-ascii?Q?g0Irfuk1Yu5gg0gVeDIdlAKR8cU19jaXqk44XBRQKUXeB7DJy81nHF8t/eW1?=
 =?us-ascii?Q?FyK8ExYvoCDlIz6ISmmNKLzFod7A814PBtLK01nGQzND1eVm810E+9yUnw5K?=
 =?us-ascii?Q?ildLiADFA77E76XfVufpLUT3ZSJ034T28w1z8ZBoTBpcRctvFo///82L+toE?=
 =?us-ascii?Q?/P4IQrcmRQK/yXHoMzxZ6crB80Cfk+qaLUDbkoUB8wySyHh9gmoPJkFHEjxu?=
 =?us-ascii?Q?p+8A71ZnUrwd+BG8JnoL8I7ExGcwwKQVYsz+KNaYg80aye/nOCoaRIKpZ/6x?=
 =?us-ascii?Q?xOFKf+Pp2uRVeR//9VET+lU90C5MpKztk81LxuCxMOvr03uw5XaIqcENIY6c?=
 =?us-ascii?Q?DYcGA7siZc8FQPG4R7qdFgjgM8CJ89olCTTUhZno3b/zpuvQbCbqRBTmdnr7?=
 =?us-ascii?Q?A/6b84D8jMt29Itl21UVZrPS/QP4NXzbqwWhPNNOt3vHhbz11njW33NFG6uR?=
 =?us-ascii?Q?ze+QrotoRNCQtwNRMAIHum98vP+GAoO+5U4gcRm+eenVvRMinLsOB/33Aivr?=
 =?us-ascii?Q?sV1/lKqBHBTqQeAqcvHrWEadrdQDPh8MGJs4C3jN1Fvxiwx2CmVVBB8coGqp?=
 =?us-ascii?Q?nqoOSaXR3a3247WmKO+0mYAABKjuwvVnKXYoTu7hfUvLUOEBMBgdJtFOdas0?=
 =?us-ascii?Q?qPtguAolDTWydXv6315Fe8iJ2i1m2XCfPY5ZX1JT3GuLcIXa5K3wM0WWeQcd?=
 =?us-ascii?Q?zEqG3G2x5kHirAJ08Li7tygDs7zaD4nPm+wCQwLgt2OwdyDVwyKUzab6Y6c7?=
 =?us-ascii?Q?hxY+pMrsWtwZOV2NqT5JVNTD15eUxb/XP/rOQ8kGfSa2pGq8Y85jvIx33+0G?=
 =?us-ascii?Q?3gbaBnxpkMZ/BILOatLNr+vUQhTx8/+aDPhelw7eBaCb3HJwcNN8LEB4Fttw?=
 =?us-ascii?Q?2S2CujeNvtXlSgWBbkmnbIOy8mjJUZ44YxOLaNJyOJaqm/rr/Dxl8AFPSCIb?=
 =?us-ascii?Q?2jtEbMo2c7eFf8xQuEUlScqOnbdy2AolcHLkKBB7VYChDr9AWYYXuR74wSuE?=
 =?us-ascii?Q?yicrxtHtaUPo6y2XMsjUur5i6YmBtbFO3RPYe4Iz2xc1/PlApq6+nzEuVD5a?=
 =?us-ascii?Q?mmUVmLlsNY+ipJbCoj864Aa+l9rV9+Ok/I8ATo/1xrtSEBP7nIQqdIDcvjk9?=
 =?us-ascii?Q?+dgc16mCWfZJEbA/gzOPUvSevT8HQQLC3yVgc+1wZh6bS90qSBUYvhzs95VT?=
 =?us-ascii?Q?2KELrcnjGexpFr6YNKu7syHTuvk5a9YyTEqzKNC16PVhn7A54SlSAPxWynNb?=
 =?us-ascii?Q?oWkPBB777Cip6rwx7eH8uV1frmgaN10e1CuJNwY4VHXKysK2TIMbR6rNtdgV?=
 =?us-ascii?Q?5fLflV1zqwsmzgKMt5IZlk44g2zFrMFQP3adc21Lrxfrg46o6R7jFtIu695Z?=
 =?us-ascii?Q?YR8HDrbmU2kQWUERwiYjKHIMMcWiiV5GJoI0u6iYe/N6gxdRpPrbM0FUMEMj?=
 =?us-ascii?Q?9dFLe3LAuF6qXhQbCats1vnLtHMkXMbQ6cNDSGDyyf1DPNme12tWqtrY0u52?=
 =?us-ascii?Q?Tpq5BfDP+pN/HYRUL59JAAgy20gwQhd6zz7phbFFbGKTsDu5fFLx/QXH6Dej?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: edeb880a-f9e4-44c5-6d7e-08dcd11e2244
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:24:13.6600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8Sb76vyuEJYVeBdl0akvGUa6mtvW209woeYyODsea+LfhwUv20TC4Jq089/r9Zh4PpQufVNLZFqjxkbwza4Alkoypr9j0vFTc4ivcmsTIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9935
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8f227ce81fa..62779dd3e51 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1267,12 +1267,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.45.2

