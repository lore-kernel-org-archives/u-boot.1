Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC38ED35165
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 16:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A7F684056;
	Wed,  1 Apr 2026 18:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dY07dmI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8652584073; Wed,  1 Apr 2026 17:05:06 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF15083F7D
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 17:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ioana.ciornei@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRoR5qZCqZDCjy7cCeHVnajCkd8UsXtwmp1fUG12J0k9zyT4tw1bdt3sAEkswXbx7S4eE/Mej1P2ld0PcR88o5O5SdqPVQWe+JtJljxGmH8GnlYoPgb+WriV86vIegMHL++UqwWssby2+oVBlQkHj7OVZDsBlScay4fIWz2jUuM0MIf6LkFySlSI2FpNBjFbmFvlsO8SLD6hDn0aOk9q1UAGmCMSaUzWXU+bBfD5tFhFRXPZOh+VnfkFSKUb/Uy/2x9Sii1zoIa4K6ItRe2rR1jEQ+RhsTiA9osg6AFfwsdXd+2z1rILf2DsM8kCmvnrn9IgyrASZusecyZqDWedrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W643xtBDtyDne21tJivYeaDgCmIg4jn58H1LenYNKDM=;
 b=aO4P+8ZRkUnP82SFqNMDnHdOpziJFNokvcxlOOJPfiWl8o1pW/ts7stK5oC1Pk9hA7PGAlHchOwXhw/iLXpRbaWt00/TvUqdeXkBW5wcdv2h1xzZx0yTH7vE8SQ53Jb4CsTqX8kVc+3V3C3x428t5KSMx0wExMmg3drmCSHY5UtJIISVTGaV0OjV0zN2LZ6mTZ+KFasvOje/9rNOHpAhqyyZicZD5b8c9HTL+x6qoK1GR50H0+bcqXvNgKoRcolSivzEutSoCzAwh+p6hh73pZi8Z7998n6eVN6DK0R8NBGrRrRiYqiQQQkl2VabBGk5fja4RFvnYGIF1WoiJtGBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W643xtBDtyDne21tJivYeaDgCmIg4jn58H1LenYNKDM=;
 b=dY07dmI8DdL28t5RYOYw2HCvSb1wHEnteODxDCBNy+LsjdRjMOEmUqDMl43+P19vCoirg9ctAAdIOoUXTfmFuBGys085iJWhWIZRCd0gslBj2TAY2C2QZVRkpgWyrDfLPZuHnGgi5wH39xiUdhgQhFe3vw1VzAAabfm3i6+Uuy6ZSZcJr6GBuzTemkIyI2vkT5SvGou2i8Adurjx45OVLh9THXLiTlNK4Vhez5ja+zcjCPovfnxKRzza9ncKF7EdMeYDUHMZVXJRynxGrtGkkk0Bqm8Gy0KiDjLv/RzDfSDkayrC1ZvIbQIAa2yy/PleOXhkYlWQnQC1ub59+maJYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:04:57 +0000
Received: from DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49]) by DB9PR04MB8251.eurprd04.prod.outlook.com
 ([fe80::46c7:1df:4f1d:bb49%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 15:04:57 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Subject: [PATCH 0/3] drivers: net: fsl-mc: add the nowait option for apply dpl
Date: Wed,  1 Apr 2026 18:04:42 +0300
Message-Id: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To DB9PR04MB8251.eurprd04.prod.outlook.com
 (2603:10a6:10:24f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8251:EE_|AM9PR04MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: 72046438-cf92-46dd-9467-08de90000998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: b8sirrrJnBQeHhvUbAshTynZ3fk/PTfi9/cEjNKz/BnDHtthEwThpgTpliMcOUo5T/pBr5dns1n1kFq/pGHOuC53WTSUeVBq5ViBowwh1hIA4CSpqPBlurDsoTj+wfS6MHUYiSCrBNwfGi5LAzK+5UzfuxkHaaWtwCOZtc+AnA5xAaFCs5KOMp8A2bC9CknqtloJXe62FN5l1TF/EpiyOmZSVmDx27boSdsIVwjcLuQuoa7H9SiNHZKQfgWUWq5eleO7TIFKV42sNCPBUgW8TUf5UnnEgQcr5vjgKBizTOnxH2JRUvYVM04FFEAD6Zg8a9rKNQ/E2iH7ICmnlbH12q5SG2hHwzVAJrqxv02rVFA9lW0WUhLbP0Opf0cm+XMthYbGwxRR6TMpRYOXkMWW0HcWjnsJspBhOHsCfu9/+AXEr/JYXHYsVlBY7xc0mVDa4UXNUjMFt0Zoo/tuMJ7vmkAZUgCeC+HW9tbpXTrJWVw+gMELK2uK1zKdZ3eSUftnCULJTyMcZdLwyPjFkc+BSk70okM4MWEgnkiaNkoewRG0iW33XzRuC5MpBQ62VyUXKTT+0RMMXHNc9mYgvHwE7nPaziti1EGkyaM+CWeTLZ9M0r46A31eGT1nSn0v+CslS6GzjGb6xLE4cm4kINVpuFH8coJYDZrLC3Iv2ltMUy6AUcaPIolGpdebMpeDrp/RotfQv5wIW+h2pObENes6I7bANJmzpjA7bY8DtNeNS1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8251.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGV/enK27uzyDgSgyhpLt9DKNVygcPxqF90327z/HfRthyxZOV11TsSmqzNZ?=
 =?us-ascii?Q?DCcm/Gg8zWHsiWYDW0UsPf9NflobyGLktzDKYkuLiMPfbLGYQXIuVn3+2g43?=
 =?us-ascii?Q?1lezyV1C8oWWZvFoBRwJg0sc1FP+iSgmEtL924HgQyefOBdxTyLMLkn/yhP/?=
 =?us-ascii?Q?7F6mnuLL6iY0oWJ4LlJxfmVQhqcwTyHE3V+p5Bbhw5XgHE6E0lnydjuUMaUd?=
 =?us-ascii?Q?I+OSVOi5HGCPb7HW0Db397DdTJ2pSwlQzZZqs8DIv3W3ucDZCT+wI2WMR/Nc?=
 =?us-ascii?Q?WTmHM+x456BbtN9ZVbaVT/MsYGI+hzXbHm679zs04ElbDuWsNAM8N4+eh2Z8?=
 =?us-ascii?Q?acZJDjeocq9ZITktEN2x6bCJLsw92nKrT7QcBfM1VeUmCdFF45+B03FCobk8?=
 =?us-ascii?Q?RhkS5YWzqx/VBz0/wAY0J2LyU/pzGzXp3yAxZRL/0HgxCMOmkbbkBYnZD714?=
 =?us-ascii?Q?2nDPIg5n0RNFNJLSrn9F8CexlS+8gdLwRNhd25nHq6HnlEB6hYe9vkFtesLX?=
 =?us-ascii?Q?UgcSqfw3l0LipUwc4Khd1iVTNVlI+9xJS2xsO0dd5JfS0KknfpP0y0y2bwU2?=
 =?us-ascii?Q?UtxX9acjyAAbk0o51nnHe8kCHNG741kR0ZYFQH5H5sH8MzbpEpVFdnaksT9h?=
 =?us-ascii?Q?tkBgHSkzs6UJ8JYzDh9VVNsLu2iXg2fzhrzv6UB1hBdzRipDD8eEJ1hXyCvR?=
 =?us-ascii?Q?0kupIa/fRH3NIq6H+5gZl226N2x6yS8AmWPMZPxIDXogfAbPwc6hOrJJ+H0l?=
 =?us-ascii?Q?P90CLCAr6rndrB3h4DUO9wtGrBUVCQTp5Es471NDl1xQnWP9zbE3EfZhun1U?=
 =?us-ascii?Q?/7cz5rGrUm+UUlgquVum5ZU7/1Z1QUkAPUk8RJNccFumhe42osIn/0filG9b?=
 =?us-ascii?Q?dHWuMvPAyZTczsL5fnR+2itbSHYNLTjC0emIoVphVIZpZX8bOmZVM5LKy6ZZ?=
 =?us-ascii?Q?tauV/3Zv09Umr7uDZKlBIul7nUJFJAthXm+lhFFx19F6e/Z5dS83IQN3ZVky?=
 =?us-ascii?Q?kZg97oyemcWWNnX1S37OO4aDhj+SdPytVbgPai2qpfpgpfnHoZzlAcPRuv3C?=
 =?us-ascii?Q?9zrOfCgL6Jho9epdmU9bmTP/Jx4L9MEp/NnxvolI6+10cnQOji3JobnbPctM?=
 =?us-ascii?Q?8a4BMmSco+K2CnVhVl4jbUKrtt0HmCIi0BRuPkHPlAmeheYeLgeoQOY3WAKd?=
 =?us-ascii?Q?gAddULPge6NM6osUn7tuU2MOGrn8SOHFba712Q1Rw+hFoEqOuQ0Y1320fvN0?=
 =?us-ascii?Q?dbsCIxDXnRCpBJbnLpzWiiRDQQgNKIeN193LpCXgJnWYnD4cByGNGfCy9nC9?=
 =?us-ascii?Q?bjrnO4HHkFqrSKFufXfCS4xhAjlXlKQpQez3sL5flzwwTGqAMXxBghbvwIIv?=
 =?us-ascii?Q?vf8bWqeBIgOSuz2ygDlhbo/KVyX6hyI4YqdLRY6VVq7Vfw4xl67eYy+NXkDc?=
 =?us-ascii?Q?p6I36qHzGxJoKb8jYfQGKqs5tzR3AMy8fgbQbRTFo4OQ2lGtieaKc5iyxHl2?=
 =?us-ascii?Q?d2vJJqqwGfPy1kCpuZYE4mj0+ARuYNztVZDRpyZs8GCwnbuM39RTFZ6zvHA4?=
 =?us-ascii?Q?JqglwYo5jSgcZVUOsCzQsskj9SJxdh6pO1fHN2CYL5JqFqGRCUeq/srlVr+a?=
 =?us-ascii?Q?7qTGIlTUMpBS0Yw2oDsmow8bAi6Zw0FxkudPkjMV+sRFxTIGBSXif6K/Tepr?=
 =?us-ascii?Q?SjAGNNKkaRc7p/W48KsIogxpE75ooISsklEb+4wE3Ut3EwbrUN5Wh2DlpoVl?=
 =?us-ascii?Q?HHWlujNTTg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72046438-cf92-46dd-9467-08de90000998
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:04:56.9724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUniDTR8ymM5HkSbCxHagFhwUK9+XSngH9HtgxIUYWdCToPeDCQjiuZqYE63WUWW4HWIrdO6Ec1R7KEdBzmdvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:15:20 +0200
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

The process through which the MC firmware parses the DPL and initializes
all the requested DPAA2 objects is a complex one which can take quite a
bit of time. For the those circumstances in which a fast boot is
required on DPAA2 based SoCs, add the 'nowait' optional parameter for
the fsl_mc [lazy]apply dpl command.

The first patch cleans up the wait_for_mc() function by removing an
unused parameter while the second patch makes some subtle changes in the
help text of the fsl_mc command so that it's clear that all the current
parameters are mandatory.

Only the third patch extends the apply dpl command with a new optional
parameter - nowait.

Ioana Ciornei (3):
  drivers: net: fsl-mc: remove unused parameter from the wait_for_mc()
    function
  drivers: net: fsl-mc: cleanup the fsl_mc command help text
  drivers: net: fsl-mc: add the nowait option when applying the DPL

 drivers/net/fsl-mc/mc.c | 45 ++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

-- 
2.34.1

