Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A08CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48409838F8;
	Tue, 28 Oct 2025 17:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="JF21TZvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0EB838AB; Tue, 28 Oct 2025 17:28:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E2683710
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl/Q0LCv8Q2zUshPvEfvuJ8kCkFsRY1OQVrRuSQ11ksHzjYn0vOfNZO9TYpwkL8Hp21vREQMYV3AtinkEehFavPAqPZgeD2vqUwvTNIsJCLpF3E7AwiqOBwLjjjR01SZx4Tt4kb/Sz7WIxHwhxSMWkdsljyyuGDaTeLd/4hwo8dRlm7TSrMpN8FHhjVoa0xSwJz46Kv3nDjMNiv+5a9svaZhW5wxrKWdNmdQYXExdjkPnPpyKaHHxeimanwVqHk9B2SA7K50B4s3BQKpPm25p48RIwNtFqOhr1vZhzw+G1MFi8jM/+0mJezxfQ591ZsLzYidq/iNitqKtxiPk+JOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lM6eKn6PCsOJaRmc5ssaJsKnvVhzvnCLZZisdWa8X90=;
 b=Whk1YgvF530bUGlspeI95asVzrqPRPufvereSrXV6lBGjRY9MzpeyHVnjsUf0Va8INsMmwBIalIqf+JuGPL7lhbJFcjjLJv2HhGdyZv1NvzUoI+/kLnrFP38AcL9WhXSkk3VIXwZ3Bai9vA/6wHZWiXhuArrc4hImb1CfSu+Og6zy6+PZAr/uWtrMYPd9IA2WqGj/zfNyvO9t9WyzS9WhzRsJSHrIVLSFpNef21gWRRpdZ2Uz/OYmLPz6FrpORhV4VhXL4F7vyJ0bOx15mCRvP+fR2k4aSW7J7OW8tNX5ufG7IPuPfiKBZyCAFNNNNavwOdbhnjDZ4mO2u3xxNlSdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lM6eKn6PCsOJaRmc5ssaJsKnvVhzvnCLZZisdWa8X90=;
 b=JF21TZvV0j3UFiHZIV8d4On2b/XzNN0KzmQ/DcOfkoR5k8sSKwEnaZFkCrKSpT0+foxFJ1CR5PsG+NKoN1EzWcG+yu3h3Bo67WN7gjQQr9jxxMhXIEeQUFLD58qmyTRA1C9Kzamt++t5pSZ8RNF81VrpM3V6eZI6Njo3TFnR6cR7llLw6a5vwvnfXipgnAYtM54iUHBHIDGuWrMOmoprzniHgdcGn2ZrQQKjRo0wj9rs6Fh206aPmuOdkUEcwbZZu0VJw8vpXJH/wBXje2aHH2Z4hTCDDwUQOP0BIwFtVh5u9hNd9DHwjK+XTNrCI5tyn+nZHcK6mEhUjoT5SoSXEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 06/11] spi: airoha: buffer must be 0xff-ed before writing
Date: Tue, 28 Oct 2025 19:28:20 +0300
Message-ID: <20251028162825.3353166-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: 25269c59-d733-4fe2-2f97-08de163f0ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fRO61y4mFu5pfyHYqYLG7UYZTyivz02ZNSzZq9Lv18m7ZyzMVIEkr0zZtOvF?=
 =?us-ascii?Q?TibsBUvl2XXYG5bA+dKDDih+Y/Qa6gQyYG1RLx7jTcrfRemdSgMKq8uGNrSj?=
 =?us-ascii?Q?La1e5U959HOm1l+4b3ZMSBJWxwlgXnR7/29S8YNvOE8SZcqa6LZqJRu5Ys6c?=
 =?us-ascii?Q?3xsGVqmNPJASGMTd/lVpUzMHO2B6MhtVNEo//FHlVXfJ192ivVg6cqxv62/P?=
 =?us-ascii?Q?0IlrV9Zf/NFT8inZVfIgf//Qmbyvs2aLwoKya2/nJ8nwrZqqpsuzVkXv+Ynk?=
 =?us-ascii?Q?uC+x/GLEEy4OrT9AR1Fb+OtOb8pXucWjyeqhi6zdOqBVT5BA6BGdKG8CfeSm?=
 =?us-ascii?Q?mnuzo8wo8jaLEE/LrDPojAI2l9YCQCBDwW6O/NAID97HpScYRaCQjTB24vfk?=
 =?us-ascii?Q?Ld3bPPm4N7EMwdvJEDcdoy2S2pGnMVodsw6TwIXwmPVT68eviamVyEeCyk8/?=
 =?us-ascii?Q?oXh+OL6TLh3Gnbjo85f3dxW3/wC97xgmQdtJvmwHpH9ZbMeslJiH2pAss09B?=
 =?us-ascii?Q?DMHY1/tf+prGn+ZaRpd2T+xe/h93kMnOt6Xxubo48zXKDSaStIwe6qPPeS8L?=
 =?us-ascii?Q?n6bATr0WSL99OiQRCsNQeNnPFh71Gh/4Zop3hHss2L9rX1+QuPLETNow23oM?=
 =?us-ascii?Q?N8sq/MMJjLa9RNCh4zwzx5DkDy2ma2oMwvA0owY6Yd+O4cKVFJaUoF8pZgTq?=
 =?us-ascii?Q?C8si6+O+UZn0JrDuVguHqjF4QkVOgsVNUl7tV/Bf+Joh3q0MGomEF0iCN62v?=
 =?us-ascii?Q?W4XRB/Dpo4ynCZBaDW2mUB5MBuJlGhLt8FfQBms5k87/X9aQndWjlKBq6PUF?=
 =?us-ascii?Q?n2jmReFRkC83pcKbVdScdcK1+ShVKPt5+IFs3MQ8qIv7y8vLE1nvbo0yCQnr?=
 =?us-ascii?Q?5YczsjmPYM9SYY7dVSBiZfJMms+4XmCHj1wK9CaHTkj7e2A/Jx1uKShGtJXd?=
 =?us-ascii?Q?Zva+6gdprjXnW31npV/oYsuIk41hCw39FD6lgrsUAbTNCWHgXSoBv7WQAKgX?=
 =?us-ascii?Q?GZPMUrfLC9rEL8qy82vIfm2qK16l1Xh5sWkYh/wy1TxixGV3+8Aezsuq78tK?=
 =?us-ascii?Q?wILDjzO4uf50bPDyUqwKKVsu+NrVXt5DEOzRc7Oar5CHiXpDL0g2dhJTZssn?=
 =?us-ascii?Q?YnovMpU30xG+dzo1L64DOjEJkynniItYgWHcKxNcIKZVsaXDTZ+T0y2jWcof?=
 =?us-ascii?Q?Y80mKjY4pmsU51yEX1cX6WONlRLkErODjUzAPf6T4sQjVgdL0SMnpBHDQlPd?=
 =?us-ascii?Q?0mXFVt/gD5Bfy71A4o18jtJUfbUngRW6ANxeHale+ly7ggEzRtLCMsRy60VJ?=
 =?us-ascii?Q?xsv/2XwCp0pek1gGR3pikOKTPKQXKu/Sr1Xllx9kbpcmup7gN5+C14Lef15j?=
 =?us-ascii?Q?EXFWJbVmd6U4pXIt1yslEhosDzRXNkIfKTv20D49EFLNYh8iM9QSLQHLcCc6?=
 =?us-ascii?Q?i5VrCga0aallHSJFANQCJfvFN+YUOBdNzsYZ2EiaHgckJTeujXjA8ZP7Xolw?=
 =?us-ascii?Q?BPp/Y1J4lIuORj3xFidPsVu6qH95rd0JAjJz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3xEu2SUPibjNrSG5NTfb8HBPFrw0iQIZFUBaS0+XcPEe3X4uFLauN3RBYjLT?=
 =?us-ascii?Q?CqaHdLbOXZ+HY9XqUcVanLnYU4tG/1dgkBmLmNjRhvsOwysG/VyJmWoom+3p?=
 =?us-ascii?Q?RHWQNTT+oIHpA3YFsgKmRbAGzvcMD5E2wAgBJDlFjlFkVegheqHEN9+x1tW2?=
 =?us-ascii?Q?1nd8Jt+b450qTB/bN24NruXjkXFSBuDo+KRXQ7LQVgXaL3JJZWpq0uwS7Oey?=
 =?us-ascii?Q?ksBS1Bac1Acf9W4olSaHYWHPvx5KAyREbHrowDFOM53fV0vs6ktAxyliVWn4?=
 =?us-ascii?Q?Sh5yqi85oC+AEuZqs3j12erFDh4LDHc70eWMxpDwYNlcWf4vxzVpaigI1UfN?=
 =?us-ascii?Q?DBQyXnZ//pelQaGBInHjynZV7XdiNxkom6N53ssrdFfcTKwM6Un9TUoorTzl?=
 =?us-ascii?Q?r9fWn5BNg3fZPiXW96HjOJG0MvFcQ1sHF9NWCc3uN7Amje9XLfHjjCPuKPMB?=
 =?us-ascii?Q?iqMBZswV8RXkwqRza2XU/opuwIA1jqh2lPKacw3IJSJDEpiOpicjjuro633G?=
 =?us-ascii?Q?pcu/xgLfOdK0CNPXZMsVeBr7XwQQBYEFsBHtokda2UmcRxf10AZWRd91cFb4?=
 =?us-ascii?Q?svAaxXsOOA4N3qktGa/EIM1TuMRdBMRlXHfHE3dHczp3FS9KUxmrmUVyprqj?=
 =?us-ascii?Q?8JDKB63QS3b8zeGTHjampk+eV8E8JSFhetiAF8dU+6G88/3sR6Go56zKiQdW?=
 =?us-ascii?Q?zclMlYrRC+JUbUakcNcxq9b2GLzvTzWnzQqgO6m7sBtI1mEk6LW6tGu0LiaY?=
 =?us-ascii?Q?9PagugcBnyMPRJ2dH0+4s0x15aKBkKgsUnTreZZ2wG8HkYsaVJm/IEOqBfqa?=
 =?us-ascii?Q?O0fqolwduPsdwlJV9Atg0VU/r8DnEwgUnTwwieiYfEOELHkugOGNtKatMi/C?=
 =?us-ascii?Q?S9PjJI11fReoo6YnNPyTxoxjEpzB7n3w2lDiX4yPfQXXnMysBmdiRNcJBC2S?=
 =?us-ascii?Q?G0/Y6zunsKj5k1tqsw87gqoM0K5V8nzMDykehFyPoSDrGFkTcODV4INTDnh4?=
 =?us-ascii?Q?gJHDzuJyw87DvP02Seh+C6VLVEj6bM5ZAKwBczOJeZrMCyG//Vvp/0aADOaq?=
 =?us-ascii?Q?/m3OwSqbOWIes+Q7m4D6XaQI20pMNNLjHwmH+pAH8BIhdmmGs15PYW/s+jx0?=
 =?us-ascii?Q?Lupfg7ze+zqR21Sf48VxRMIKljCu6TCca8a6WibSZG6EkxyZ02YJXIVjItlI?=
 =?us-ascii?Q?YiznmgbrSkutuHHuQMytBQkQnPP8ezfj4pT3cSNw9UxbsbKQNQVGMHdDP7Rb?=
 =?us-ascii?Q?Jj4F0B17omRWVmMVacXpT5dwOSI38Qq7plM17hyXprfzBKPi0eDpeyQsQnf8?=
 =?us-ascii?Q?sB2JV+jCrqRgAluDEoX66akvFClnB5QpvpwwzoC87sx+qvSt3lIvf8qjia9h?=
 =?us-ascii?Q?HYJVBrm0LrWiwgBO6zI1K8wIkpiAB3z0yadTAvVBm+nNDv0dqnb+3+PSOP3y?=
 =?us-ascii?Q?YeOa9KLWR4v+QgelLUCp3QA/gAwhMLcV46K+ah3wWbnsVhfSnbHjrm7ghzEo?=
 =?us-ascii?Q?5NwVItgg1iQlzpGgipA2FZXiz06vVoYwrZJoYbDRMS2YLWpu224JzUY/pfu2?=
 =?us-ascii?Q?+NXryIT1yi/Z3fZ3pSpJDGP7EVG7/GTWBW/iykn3wUDm9+/m/P403WEV7WOs?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 25269c59-d733-4fe2-2f97-08de163f0ea6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:41.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vtThaNAOtUSjLXQ8PyFxF/Am4Yu+Tki/KNcbeV42pn89LgRIvvZxzVlYfhpDmAZaTJ6DYqhS4q45k7c6/Os9rs/bIfHrzXh/BRGrQW0O9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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

During writing, the entire flash page (including OOB) will be updated
with the values from the temporary buffer, so we need to fill the
untouched areas of the buffer with 0xff value to prevent accidental
data overwriting.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 65381060407..23c4507b10d 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -819,7 +819,11 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		return -EOPNOTSUPP;
 	}
 
+	if (offs > 0)
+		memset(txrx_buf, 0xff, offs);
 	memcpy(txrx_buf + offs, buf, len);
+	if (bytes > offs + len)
+		memset(txrx_buf + offs + len, 0xff, bytes - offs - len);
 
 	err = airoha_snand_set_mode(priv, SPI_MODE_DMA);
 	if (err < 0)
-- 
2.51.0

