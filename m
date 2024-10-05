Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5C8CFB421
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 23:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2AE8898B;
	Sun,  6 Oct 2024 01:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="II1//NEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B77889C3; Sun,  6 Oct 2024 01:47:31 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B138888DD
 for <u-boot@lists.denx.de>; Sun,  6 Oct 2024 01:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoZtJyKsx/63XbzTaIDXmzeU7RVL5dauLcHWqEchchCv3Mz1X7j8RZKvqE34k7Kwdn3IkFyOa/HR9cKxAJq5pVERewO0mMBTmnsEVwyy7Dsk4arcNseyoO6B+RYAv6t8//7VrjL0ApQzhIpYOA10bDnCMyrpOOuIsZVdFx0UURqqsZ88nVqUj3327eetPGwswS2EGlHmu3WTWogHLYRCrLmnZZlZnDPg2vTfILAnOBVMiC/Y+wxwJ2tDzRUGUEL9TCWIAi7334eesdXrO4AtJXt46bUq7zEDf4fEZl7JkkJFrFURARyyxv2lUGS7K805wm4UcUoZwLP1vfn8Wdm6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOkKN5SbAM5fM8gJX+9pWtyP5081QRvfdM6+ZJT8o+A=;
 b=nY/uvfjT5fOYP6305KGtoEhh6GMoRRZlQ/wKgemooibJ6NuU7KbpCnNkGZJhhS0DPaWXvTuBoDNMIlQ4nWGUV1/J3ClGcpzZp02MZNJc9T22/MNljjT9q5KmWCUur/EN81a2vwoWFoRWizMQeL+MFnxE3jFHe+3zwYzdN6oeuht0l7QSkwSI2JzmSXiYs3EsxzIl9lljkbL7CSRSGDXs7XYfpwQ77+qo3hm7Rb+8e1S2dn+zLEFKv7KAsAet0w8GVpJP4oTQ//VDIDfbcvyxfhIrfSWCmFqaJFxwqe4QrbGcua0UZHjvDeYfWBvRz0MXFZoWI6fD8+AV3AbYvp+waA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOkKN5SbAM5fM8gJX+9pWtyP5081QRvfdM6+ZJT8o+A=;
 b=II1//NEMawTxWUqMJcn6pzGF/zGBzu4wCUi7G1Ft7MZMNxPoBMz1HiNmfnsXRqB2zkLImzTmD0RFRVRpmFjjV92xEdDx11QDA13PgIioFMtz3Ok0RiXIFqemiCPLM9Dmaj298xS8YKn60Jfwy9XwBW0dWepUbw6oSVxw7xafusfZ8fcu3VuFXSfi57Maf7fFSgQKclG0XyEkWy2bGLlvEgRDM2UxIFn15qKdBtUtRYhNoqY12tcUvRy+sjrxvN2t5hhR3gZH2bv1c8u8zuY5yIe1oIXJftJjQuaOzqzCeMkqij0pGXCFViRsdB9YNq2YyWoMITdqPzHRdCzziak4Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sat, 5 Oct
 2024 23:47:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 23:47:26 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, trini@konsulko.com,
 michal.simek@amd.com, d-gole@ti.com, jonas@kwiboo.se,
 prasad.kummari@amd.com, tejas.arvind.bhumkar@amd.com, ricardo@pardini.net,
 jit.loon.lim@intel.com, jim.t90615@gmail.com, andre.przywara@arm.com,
 teik.heng.chong@intel.com, ssunkkan@gmail.com, nm@ti.com,
 Han Xu <han.xu@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1] mtd: spi-nor: Add mt35xu01gbba octal mode SPI NOR flash
Date: Sun,  6 Oct 2024 07:46:20 +0800
Message-Id: <20241005234620.2782188-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: d39d5677-1a0b-4318-e7ec-08dce598111d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?13EheOP7YF4G7hk7lehDP96S+xEjfLvGz9h7a0PAh+bXsF9PJfkaQ1Cx5GDH?=
 =?us-ascii?Q?HGeqUAubVz4FZFmL5xPFlPxuH3/od+HJWru/iMzvW8oendn8+b3tcR77qTtt?=
 =?us-ascii?Q?0zXPrygny/ZirLPyD0sMysDUJBXEcxDXKldqwl7ljICqeI5yDIolpAZZbPAn?=
 =?us-ascii?Q?Ew8qEUFbGUG7KD1eZ91Ei0aHSAbdruVUjGhWrLX1bKiviFGppPug4uYscxwr?=
 =?us-ascii?Q?BPNb/6MzDuV4BnLzxfVOyIvF7/44YzR4yXczrKmXYcwJWCXKlZlBQfeYn5WJ?=
 =?us-ascii?Q?Nc2tauwusmPF17GHaQ6gUuUbx00prqZoCWNL6Dsyj4X/3yLWKdORNeK6B71B?=
 =?us-ascii?Q?/u4PEMtgYA3luaRkrXp+YDNwfMYzbdly8ImlYFS9F1LYQuxqibRxbE6EI41H?=
 =?us-ascii?Q?k00fktwqoSN+pPKIJPYmLXUoisnP+4yHoxFdep6P1GVx4sKZ4YxtOWVyvrnk?=
 =?us-ascii?Q?o7ssod3LyqqdRETVHiwYQ//vH7GTRauw06j4LMl5u5SkGqUCcxM3g2SG9mwn?=
 =?us-ascii?Q?QYqE96roXjg2X7JNp0LxLaqFJiwV3XUXUoyJlGD+INWE5Y6h424QDy9wvJ1R?=
 =?us-ascii?Q?EJFAkCl0ZfOsx7KWfHaJIxeonm7cCz7tbpz96asXRI+HMd0u7f6CZzxe633b?=
 =?us-ascii?Q?7CpdklJMw4Guf6ym5i7xiaR8sgA9Hnhydc4nHz9uNVWKXjO/dkU9/PjQSnVj?=
 =?us-ascii?Q?gxDEPdTToPZ8RM3cB9DUhkDKCvZ68emK9vDgYq4g3z18GcbYeFLQnSzvUaKs?=
 =?us-ascii?Q?irBNaCnUGptNdV33tltx0OkMTqgrV0ltWdgq33RwteI5+dIQ6iX+QF1PIoi/?=
 =?us-ascii?Q?Bwv64YclyzJBmTj+E6EO/DwwKA76gEjfEh4AAcAkyCGydIunHQH0IGkNYjWL?=
 =?us-ascii?Q?f/oqQkuw2/9mmHrYkdq+7usnVWREcKUlWylFRshC+paHhcN1eaOGNRAZ75ir?=
 =?us-ascii?Q?FsQ51tgcO6xsr4Ey/2Ahj/cgRsuTYLBCOIEM4iRAMyO0X+IhhwGnJFPV9KPW?=
 =?us-ascii?Q?s4iCDOoBEUuWtmqwSMWMO7K260aCOZdwSF7k8R8pHaltCY2E30malyFdeJsB?=
 =?us-ascii?Q?SyaX6ISax/BccfcL2wBH5vLN5fZcqF3HB47Bj+NIS+1yJVLgvV1zAW+3bEe5?=
 =?us-ascii?Q?RHflNM1s68NXKNAT8sV3tyzN50E5ihv4db8znQGNqRDMjnJiF4NBcgtWdbW6?=
 =?us-ascii?Q?7U8zm+B2M3Aix44Sk1eSvioPaf4hJiL/wMAJ941vFug8APJim8F+GEq927L/?=
 =?us-ascii?Q?pWjqbLXVF8ulF47v0HsAh+rAbzFPc7/EqXIodYicr+K7dBLB/Nu+uqfcizGf?=
 =?us-ascii?Q?Zf57yAzDwm8QTNMcGjkUqs6Mu3JyFXay8vhXlA7cTr0sdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bJu8VJDXCUoehRdpiDKWsRMYa7NUHwsVuHMT/2C2splPSnRdIir7xhfjuHIQ?=
 =?us-ascii?Q?3v+JOeJoh3HsK8OdHEiR2GfwgenbvC6/GOoup41xexz4agAZzhLlttQbdtSe?=
 =?us-ascii?Q?RKpNUTRUfZDi+DEL7Ie1H2DdGWwX8u+gohfdw37NG3HcO1Gql9WUwgqJc+Vo?=
 =?us-ascii?Q?3Tt2bvuJInpHgd3/fuM1CgFcBvYe6iP48pKA1Jo81z24rC27B0wK2vyQ92ra?=
 =?us-ascii?Q?kqGmHzSVdL38PYnL10wCQ2ME49HyaaAzFyg3fpPL7d2+V9+sLUtH+3GNUTZ2?=
 =?us-ascii?Q?fGIg2J4wei+Hx+FsdZUEXfuzzyprJbKioemIpBshbAtcA9MZdqfqhtu4oAuo?=
 =?us-ascii?Q?xiCRMPU89KOFcRP6RBno+XrxcpsJ5I5pOl3BtiqQDxrIh7nuLmqqjk7tyyAH?=
 =?us-ascii?Q?MNNPV8UhxBVMgVoBWIYg4KSypzWYm+/byUq7BzHGAvlYTVDOmKleb2bQDVtX?=
 =?us-ascii?Q?MvkTIMSwCtJe8oKYnz8038Dr+sXO9vb+c2bxkybjFYL3VtB2s3nG4p4pYECw?=
 =?us-ascii?Q?4N/I52cSDwjnqZA0G2BkU2BMFMVDjLGiyzrQ0Urf549w/W8YRoH3RXyUT61J?=
 =?us-ascii?Q?RU7rZt+4Y5xdyKeeyKW+AIiVcTvIsmYuaVoNhQumuEMqler0IMmXPkivLOdz?=
 =?us-ascii?Q?uAT6ebH+XBE5AHZtMh2ogDzqWDwaDuERePFFTAALC4MKMHH9rqKR9DLHg4P4?=
 =?us-ascii?Q?8yOtkC8wpJ+YGiQhlwkpy56k4FQd7iejn5eubE/H7LuXBI7uNCT9L3z9Bb9q?=
 =?us-ascii?Q?jSETTG1T+iug7z+uLDl+1oSmcH0i46Ije9wzTr/fUI2qK/+xJc40ZKBwqCsD?=
 =?us-ascii?Q?TFTpSR+KMDwlIvOjZqxxVqjo0yApDXsdvi+VsQdEaBAFf0DYWPYHdaIGifpG?=
 =?us-ascii?Q?kE5SY5GgilVXEU02ZpY9p9VC0w6UXxQ368vLMk+d6mqycdMGqWJMHSIphctq?=
 =?us-ascii?Q?diXM3CorTcdPgmJlqh/uhIeUA5457n6TBqaNd81VWf+GYYmLchoVsUtrWb+d?=
 =?us-ascii?Q?QpCDGrhvvvHgwClz+0orfneTSzD+pYWetNcWbkBsP6jos/pEo2bpksN/eu0Q?=
 =?us-ascii?Q?Ct5FJobkt+hih0N05uZ7SSoZQ+DRfk+AiBS0jGa1VZGY8B5PSbWaJsYdTupX?=
 =?us-ascii?Q?PtqXg3SMH+xOGxO/OhVvk/vInr2AzTf2NsmACL/fWwvpZWVsgf9ANIkr9ZEs?=
 =?us-ascii?Q?DMBdb9DZfLBDNkF9rmdked8spFlor95BahV9FKNzZlpl2NtDlzAIOQMab7pv?=
 =?us-ascii?Q?YnnkwwYfBcmUtAMGahCCTufbMCPdSKoPgxr4sQGT+8kzLtSbXa4w9GUJyRTi?=
 =?us-ascii?Q?iw0qo3hTX8b32Me55gs2FB1R4oOhGQpHwKTNxGMsP+MEWur2bgOQtWLYyrwg?=
 =?us-ascii?Q?yD1vstkZW2Mjqdig2EQAS66dm5dsQbAhTkgU9XlfTX4iwyNWZq7qOwY91MSx?=
 =?us-ascii?Q?3/+uTO1eidG8zdGKroXclb6AB0DsLOHSTCH/8tyVhmfZfQOCp/lgn4Qs3dJC?=
 =?us-ascii?Q?IagaprS6mQnJs0iRKG0eywYZjF0IIQp4FhH7Fc3KSu4qcHK9zUW7hHRqK14z?=
 =?us-ascii?Q?cQwzPqBEBCAuNzJJG7xD5gQZSk6cl6RmzGWwny5F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d5677-1a0b-4318-e7ec-08dce598111d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 23:47:26.7697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrupoRlxaf1L4y29p8/JhvYPHqy4t7GbW3jZsoVi4ecUOaTNpwkSisnKolIomW+RBLbLHNuq3RLhHoV73m8X5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676
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

From: Han Xu <han.xu@nxp.com>

Add SPI NOR flash id for mt35xu01gbba which supports 4 bytes address with
octal mode read.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 88709a52b3..db38687b4f 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -329,6 +329,7 @@ const struct flash_info spi_nor_ids[] = {
 #ifdef CONFIG_SPI_FLASH_MT35XU
 	{ INFO("mt35xl512aba", 0x2c5a1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("mt35xu512aba", 0x2c5b1a, 0,  128 * 1024,  512, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("mt35xu01gaba", 0x2c5b1b, 0,  128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 #endif /* CONFIG_SPI_FLASH_MT35XU */
 	{ INFO6("mt35xu01g",  0x2c5b1b, 0x104100, 128 * 1024,  1024, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mt35xu02g",  0x2c5b1c, 0, 128 * 1024,  2048, USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
-- 
2.34.1

