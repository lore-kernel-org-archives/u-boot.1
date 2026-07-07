Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B908C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12788497A;
	Tue,  7 Jul 2026 05:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XtbURign";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800F48497A; Tue,  7 Jul 2026 05:57:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618EA801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv0OLejeEJJtUPwB4JOHqifnjuRizSxMDfLU2XuGBlLyV8YuTFfK/AIm8RBQDNyO2EuinosqqP/ApyooB+Iyr+S2gG4cMtC39SW6Ojja/qzHteRhIcRLFZHjPTBPIWymo6A12eAmYOaWdvb+lHRdSGAZogH0Cd87olnuqtsBuJ3exBJJGSAArhDc38kJ9V8WveKRczkuZgu2paXJeEiPllWMeGct/0PJ1b4tRMWXb6gzXPLuqiZz/8UhZwLogW7+VJxWr2ZV3T0kAem0ZkQ3VC6f8ylHBzuTHxhd4CrIcXXn3UbFwowRXgqOYDEEGJuNmSgyAdqsHVB6gioubnuu4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8R6eNGU+9SM2sHQ/SC1/6otR7x2IuJu2jQ9trFD9ME=;
 b=j5GA0VuKYlutvOZUHowXkxz06gRPzs2tmQzNJ5ibX4OFSOvhr+pM8B6+FHfcpx/Oiiplswib1/ZCcURqfkq/Wo5Hy5yD6Fyn2UrSa9/lSBaUKbx5yHcCVob8WokVCCKwSYNyO6zsyzoHoGTOK9fs3Ee385ZRxrXw7EMsQq0x3LIMGjgxM/LIdwO2EXU1Ajl81z281Klf8D1raw2vmGRKDzpc6WOGyiZFgVDcMJniwPwiX2BTQGI2gd9f5ztffFD8s+QQl1QTwXh5/U2yCcHVFmeui+JQaTdd034lklqyxK21W4Ipn5olPN1163eqfqRKWI6GepYMsB6NvZoRbsh50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8R6eNGU+9SM2sHQ/SC1/6otR7x2IuJu2jQ9trFD9ME=;
 b=XtbURignTKct3NU1JudiCXH6mgRlGT9rINGIslpXaA2G7b4gOc0v28WOz8IUDD0ysePJAMQNDZmgESWsB/CN9OJ8YL3v0We4mZJ575BGuLVYTYHhAA8VaTWwtyHR0JICfvjgusfJN+2hpR1lUQRzFMUok/05pMl5EXZzI3SSxHoYoFaxM5P+iziUd31O+dbwUYN2WltGbVeet+fcKi6crkKGwvp9taMTYaX93gELJZ97tPVLgOvqKcMXxMSNoyVMRMtBwseYHrVoagoiAndfNjAZeDP69pljxNY7A05sNiWOYTalI5IVlNQgq6knI/LetIM5nDPufJh7QEegfVS5fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU7PR04MB11235.eurprd04.prod.outlook.com (2603:10a6:10:5b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 03:57:06 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:57:06 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 07 Jul 2026 12:00:25 +0800
Subject: [PATCH v1 1/3] net: fsl_enetc: xpcs_phy: access PMA/PCS via
 MDIO_MMD_VEND2 on i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-imx952-v1-1-1262c7c6f7e9@nxp.com>
References: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
In-Reply-To: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::8) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU7PR04MB11235:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3d3dd7-2937-4502-6173-08dedbdbcfdd
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: KRdSciMmQFu89clx1i9w1XACLz/Tj3uHdu8nzKF3al5Z3V7rXNIJwCSnJgzh+N9nCQewDiNd7ndQIVAhlmQ7cBBolC4KrM4kkpiW8SVvz3di69UiSaDldO+R0mvovFe5OsbJej3ox7J0fmfRFfw5IPPtPXDXxrgT6bh4i0xYsKIsgGLR8F2vhRsYuZP9g3umLn1Omr4GiO4p1lA1OlsYbP7xUgYBw6aTQfEAOks3atf7fCjQQBF+SKnve18HDizjgApgxrq9AKpG9RJqdoYkRpBy5honxmQ1WUlpZ0FK3+FNIHTcSOOxnTLmIQ1I1CTIuGgEnk2gNPatXwyIRJksI518N4En6odhxM7nKzOMRhV9uoYGTWyg3otYr5HBsE4dKGVSUUClr9oKML4hdSLz2OAKHX9Qx6E8DKlfzNqQAWSheDc902Kqa24tXt8OXExGx65D8jvCLrCOc7YOC77qHTppqU0Yufeu4DWgAVhRLLLZFPTJVGtjzjlFTtQXn0BJznXZSOEd/6ITqNJaihzNiZ5LNnNbhb4l2dLhrBN7dT3om3Dvmbwo+Ire59rdMww0qBRLneBgT+VH/3HiIvXwvtbfiSHP4Ae0pwfwRqZR6BFZMRT3GBqnSDbM8fTt+RMKygBG/YYCV4eSox4mwFmlVq5xnU1hnmpFaZ9pro5w1MQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVPVGppRENFVTJEaCtZTWI0NXFxc29Rb1BKb1diYjN4V1hhUUF2Qy9oaXY4?=
 =?utf-8?B?T3NFbGxleEhZSm1ldXhZZ3ZiK2t6Ri9ObFhQNUlxRkdtbXBHNU12d3RkdE9M?=
 =?utf-8?B?OWIzK212eXptNnpaK2E4Sm1uQndVZXBjM0czVFdzU2QyV1lxRFZTcWJEZkpy?=
 =?utf-8?B?cEMxUDd5ekErVEZ2eUJQNVUzbGtyRzlYUjVyWnJWdGVQNzlEZ3pITkxjWmFm?=
 =?utf-8?B?UTRqblNTYXFNUitTZmhnQ3E3U2ZkS1htU0pnaC80aENIdS90TnZ4VzZwYWpt?=
 =?utf-8?B?bUJsbzhBZ0FvSk9naUlNTUN0aTFpejg4encvUWFHaVlPWVN6OGhQKytmTElZ?=
 =?utf-8?B?SlFIZ2ZJYktaMlNKcWJqODhROE11S2l3ZVM2SHJwMktNVVViM1pVMlkxRlBt?=
 =?utf-8?B?NW1VN09vOGE1S2tqNVA1VlJYeGtaRE55eFdaaVF3THZXVDRnNm5TVXdtVGY0?=
 =?utf-8?B?WUx6NmVLbnA2WU01MTdPYXJqdEJYUHdJZnIvc1p1c0RVWnpwOFVxMmpGNVJv?=
 =?utf-8?B?ZmoyVnA5QkZLNDB5M2pLUWZxTTJjZmJhamwxcmlJa2s1SjArQ1FrTGJWWjVp?=
 =?utf-8?B?RnEwT0t0QXE5VXlpdmNyWEtTMlNBNkwzaXNpdUhBTkkzbjBUck9FdWkzMjQv?=
 =?utf-8?B?eDdKSTlTeXRSWGpoRGJPdG5NR3NHVVpaU0o3MWVzTHhYSW9FVGRJT04vQlpQ?=
 =?utf-8?B?azJ4VTRpWngwempGZ0xDYndhOEhPWTdqVWtwYW1kTk45b3l3dlNuYUJXdm95?=
 =?utf-8?B?Y1NVUkp3bmNsTzR4UXQyTDlqY2hmSXNERFBkc29VYStTTkxPTmFPRys5aUww?=
 =?utf-8?B?ZlMwbVBpZGY5dTJJd0E3NGdsTmltaVZqQWk2b3lWeUFRRWdYekxNV3YzWkdh?=
 =?utf-8?B?eUh2WXByQWt0NVZJdGxtVVNrSFpUSkdOWTdBVnJ3dnVsL0VlR2lPNXp3NXFl?=
 =?utf-8?B?T25KWlRmbzJuY0VFU3VNZWxtMHlsN2YwK1ljS0FqcXRXWDlTWUZRdEVaVjBV?=
 =?utf-8?B?VktmNUUxRTIwRUc5d0xKdVdpaUFkY2QvODA0YlJhSHB0TkxKRXFRUG1yT3ll?=
 =?utf-8?B?dEtxSW5rWmcrSC9tQlN3OXFPZkYxLzJYRzhUL0Z1TlhFRXhnWjFkNUNBZlJq?=
 =?utf-8?B?WW9LbnJYSDIxTk8xQjlLL0xSM2MvcFNzVUNIc0tJbnFpc0Z4YXNvTUhJRXJZ?=
 =?utf-8?B?Vm0yQkIzTng0aW85eGdLblFjVElGS280a0Y0aDZqT2NDUkV0VWhsSUQzeUZ3?=
 =?utf-8?B?cEI5M1h5QXM5bkdYNFR5VUV6cW91bk5lRjU2eHdFdG5PbWZjd2xCM3ltcnZV?=
 =?utf-8?B?YXF2ZGhaekhPUG5jU05YNEFGdTZ6aWdpdHlhZDkxb2VFQnBYbm5nTlY5Y3RQ?=
 =?utf-8?B?c3Z6TXR2SjRMVWRkdFh6ek10WWVHNXJmOGx6eGJuMHd5czJCNEQrT2pDOGlu?=
 =?utf-8?B?NjdlNlcvVzA5M1g2YllDWE5IZ0dRRHhmd1c2aHF6czZKdmtDUVJUNVRGeHZh?=
 =?utf-8?B?ekJyM01JOUc2V3JOZGpqMVRvK3lBMnFxS09qcmZEVmpmYTM0NnZ4WkxyaEFK?=
 =?utf-8?B?S29pN3h5K3NmLzUydlFpTVpaZCt6N2daVVF2SFdqdUdIMmYvNkZUblVkV3VD?=
 =?utf-8?B?aXRhN1Ztc3dPcXZveGU3QzJQYkY4Q2YyQlJqRmxaOTg4YU54VnJPaXRteDZC?=
 =?utf-8?B?YjRwWmZzV3ExYlcxOXdQVFRGLzlyN2R5NzMzbEUxNUtxbVRtNmVDdERTSW9r?=
 =?utf-8?B?R0lOaTd0Uk9va0FDdVdhcGFvcU95cVRPaERKRVpJTS9pRkh4L2NOZng2MXJs?=
 =?utf-8?B?bFBCaC80ZjlqN05hSzBuL0d1QXptOE1ERk5nQnRIcHRvNnVlUExkNFVsb2JY?=
 =?utf-8?B?TnlPQ25WdFVEZkN4M1dvamd1aC94NlpoUEdIK3FPcU9aSFpsNmRSZnNkdit6?=
 =?utf-8?B?STEvOEltMEliaVVpVXVtMG5qMW04Ulo1L0xlWWVyM0pIMTJkMlUrKzJKWlVP?=
 =?utf-8?B?cUhvcloreFVZTU5URnBmaFlOZkI4aXNzQ2JKanZ6YU85dDVQZFBQa1dZQXlQ?=
 =?utf-8?B?aFI1YXRoazl0cldsSk55RzM4VjlyVDYvc1hvUG5JY1drRENtQWgrb0lnTHl0?=
 =?utf-8?B?Wm1aZS93cjVlK3Frd25lRDQ3S3N5M2ViU0RudVIyazd5Wmw0anJJQzRUclY5?=
 =?utf-8?B?L0d5TmtPU1FndzJuUVkvcERXUFBVdk9VRUR4L2NvbXlXcVFZY2tReGFBQ0tk?=
 =?utf-8?B?RTNUWDZPMW9iczBocWhLWUd3bWpwUVVJTHlYSTlLL1VwVS92UFY0eUhiMjF2?=
 =?utf-8?B?ZGdHNW5PY2MyVGZrNGg3NXZIbk5mWjFLNEVzYXBPTjdYWW4zelVRaWVsUWwx?=
 =?utf-8?Q?C+BE02B4IL/nlI1V+IgjP8MmSMZq0J3NfrTWW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3d3dd7-2937-4502-6173-08dedbdbcfdd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:57:06.7465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jmqm7BPwr/fCSpYR9HbY1kL8ty6R5/gcfJ2puvzrpXj9MvnEGJHkxH2k41PTakUOyQC93pj+b4F5wwsg6ImXPuPLk6sGq+O9qKkDC2oZFe1ZdPF1KwZ8tJMnms3KVxsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11235
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

From: Alice Guo <alice.guo@nxp.com>

On i.MX95 the PMA and PCS registers are reached through the
MDIO_MMD_PMAPMD and MDIO_MMD_PCS. On i.MX952, the same registers are
only accessible through the MDIO_MMD_VEND2.

Add a per-device "without_pcs_pma" flag to struct enetc_priv and use it
to select MDIO_MMD_VEND2 instead of MDIO_MMD_PMAPMD/MDIO_MMD_PCS. The
flag is set on the i.MX952 SGMII configuration path, so all other
platforms keep the previous behaviour.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.h          |  1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index bcab6f252a0..aab69d0168e 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -193,6 +193,7 @@ struct enetc_priv {
 	int uclass_id;
 	struct mii_dev imdio;
 	struct phy_device *phy;
+	bool without_pcs_pma;
 };
 
 struct enetc_data {
diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 6414324e7d2..a8c720786a0 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -258,12 +258,18 @@ int xpcs_phy_write(struct udevice *dev, int devaddr, u32 reg, u16 val)
 
 int xpcs_phy_read_pma(struct udevice *dev, u32 reg)
 {
-	return xpcs_read(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg));
+	struct enetc_priv *priv = dev_get_priv(dev);
+	int mdio_mmd = priv->without_pcs_pma ? MDIO_MMD_VEND2 : MDIO_MMD_PMAPMD;
+
+	return xpcs_read(dev, mdio_mmd, XPCS_PHY_REG(reg));
 }
 
 int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 {
-	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
+	struct enetc_priv *priv = dev_get_priv(dev);
+	int mdio_mmd = priv->without_pcs_pma ? MDIO_MMD_VEND2 : MDIO_MMD_PMAPMD;
+
+	return xpcs_write(dev, mdio_mmd, XPCS_PHY_REG(reg), val);
 }
 
 static int xpcs_phy_common_init_seq_1(struct udevice *dev)
@@ -1270,6 +1276,8 @@ static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
 {
 	ulong begin;
 	u16 val;
+	struct enetc_priv *priv = dev_get_priv(dev);
+	int mdio_mmd = priv->without_pcs_pma ? MDIO_MMD_VEND2 : MDIO_MMD_PCS;
 
 	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
 	if (an)
@@ -1278,9 +1286,9 @@ static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
 		val &= ~MII_CTRL_AN_ENABLE;
 	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
 
-	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val = xpcs_read(dev, mdio_mmd, XPCS_PHY_REG(PCS_DEBUG_CTRL));
 	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
-	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+	xpcs_write(dev, mdio_mmd, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
 
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
 	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);

-- 
2.34.1

