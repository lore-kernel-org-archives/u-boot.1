Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F808C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98E7482AF6;
	Sat,  7 Jun 2025 00:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="G9gjG6/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CBF81F0D; Sat,  7 Jun 2025 00:31:26 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8001382998
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xc86eLLp0HUlbCfsORh0l2p/7nWPeiJQ1WsXt0T9urm1YJxAUS/E77JJAFPFD9VB/ivPgSo1PELrtmFH7ygygw/oHMrvwPFHtKAZYrQ4qZv9XEONhxMXoNzAYrAynoTLzA3APEJV0/AjA3KvumhpI/GM4kw53ZTBLQq0U8S05zXklIRQ/5pPr2PPUEI62fnR4h46/mtNtERIzfv4/j1oNiMVadu5nMakd80iHAHvzpdO9e/WpNN/jpks6ZJdu8qxbhlSYDcn3xy6BfoeUTdNWCfa9+vmLx/6mSqe0eGfY29qRhyCtHnOTfCM0CE7Ab/vzXIvPGmz14POsN326UipMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UJSxXjVTGbFtTsusWtDse8Eh9cadYMxboA7Ljra118=;
 b=R2hSO8PHWLalNYoZD6j+Di4ZMHgJ0SqoLpZloffvmwEmtIkn4msN0lt2hNpjAii2yV4ZHMedbXo5TFHcuEZFUPYc+d3QCUZMCELE1j+Fwj7VozEKxaP++eZL0dUmvMZTWRNomut0Y+gRDXJe5NrGKw/8u//bBPPU7qm046vaBvm6P+z2Ka5oy6Df+/RTeD87XpWatuxEtqN3xN/8PxmHz3wzHssEHYe+T8ks89VerjgMrliITLufta6nXPSeLVh2HAF96Q/gMJqzY0/8/IRVbHfGhiv0235sz8+yBtv5zoQ+Fpme8QIhvIMXi6UEeV967ISP7exb9WXIWLGgNBbQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UJSxXjVTGbFtTsusWtDse8Eh9cadYMxboA7Ljra118=;
 b=G9gjG6/9VafLknWSvoTF01apzP+jtW72M/rMuPJJmAdljplQ1rWvaTSK27eXQ5eFRLSojymGTI3aGv/Lb0/zRYPwk8boSzerzXG4msqq/QTKYK7/QuezsTH5TPN8K9LYdChAIJKrnob2+WthXddTxBDUJAqax0OXmBRmGIE+y4YSPILY1rTDdFgJ4asRrBRts7N3b7bmTUL0E+LXI2Dgo/R2xSzS24q1XgJ5jj5sYGW7A4WoeWeGjl8yhfTcMiyC9H2VkNGf8tUQPWFLbSKlBgzpTjucuAc9ufnhG7cVbuPlH4T7e6g5mYiwVvJGqc6ly6qQhsntDrfWocxZRWi8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB10377.eurprd08.prod.outlook.com (2603:10a6:10:3db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 22:31:18 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 22:31:17 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/3] common/spl fixes
Date: Sat,  7 Jun 2025 01:31:06 +0300
Message-ID: <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606205410.GC1382132@bill-the-cat>
References: <20250606205410.GC1382132@bill-the-cat>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0118.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1c9325-5365-4b62-35fe-08dda549d9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umsuRlLH0D4UgyLFe3+5AL6gALdj3xdEsLq9lqSLzyeCD+85c6CUdO2VDqO2?=
 =?us-ascii?Q?u7deaqPeZkHfUX5Tkm3fxsowE5knajEWSzFw73Td1rizok47jlX+kydN+Se9?=
 =?us-ascii?Q?xiadhFTDCXY+/M8V7xnVB6rRpmz3rnVFQkqmqg4N0mlDVj7aQniMDZ9iWYVO?=
 =?us-ascii?Q?VSilAzhHiE39w94AU01egER1EY5YA9yV/DKBz3bP+NVSvkZJ5SHMfQnPT9vG?=
 =?us-ascii?Q?x4UfzU5HHLM0iDvfbN6L60hJ7SeNBrpwEQ0h6CRr+d/AoyTN7oM8OT/PEslh?=
 =?us-ascii?Q?Ghk/UtSwDBOJCMyhYlHLLbfD2ZGDCWYR4pA//ZRegTSnZkcD7z/9dlI/eMt6?=
 =?us-ascii?Q?ih//lHcqAXOfDy1c/EuzUpS7Gizr+1MIZKfeKQxqXZUfaUY3x4yJIn3VDFRW?=
 =?us-ascii?Q?UxDMP+yYoKzHfNe/VYjDnEQSqzngOKoZSkNOImm+vXQqXlsTo5tyKBlTFH5H?=
 =?us-ascii?Q?WFdzubDpLomtjfmHvbkfaEOmOOy4/5iRjF/ffB+jztrtLUJuLm2aIWNsNYdf?=
 =?us-ascii?Q?+bmBLyqdLql/1Ohb5ltedI6orMfMBvybAeZx4A891ixgeBInrhyeo4KDcAEz?=
 =?us-ascii?Q?6L2JJd2dIeBVDjxqpjG+AWKFjWAJiDeN7s2nzX/r4QkVBULKd9nZZs1fy0Fa?=
 =?us-ascii?Q?FQPKByboo1mAv2eDy6eguRreNqX1SyUtyE7HZt+lMIBcihNqb7BZwVD0f8CL?=
 =?us-ascii?Q?dU06LPwd07TQBeEOkULtfqHfkDwFM4AhJGQldxWypHQRDWjXAE8N0R+HjPGS?=
 =?us-ascii?Q?UydLLptpZ/XyX2P+mK9M3IirggJnJXkzLXR1OCl0PPm4lB5FaAxg2WhnfXcZ?=
 =?us-ascii?Q?RS+f9uSWOBsjJAeeeU2NdpzIqOcjOabGoNIp35Hyl93AJbzX0mdM1shJ6kFT?=
 =?us-ascii?Q?liMeMwB+AkcjU4DiQ1TsX3bmRRHka9BTkW/UG2bIEC/lTtHfkO2hKfA+htVm?=
 =?us-ascii?Q?JBJAf0LIayvFlbiVCGOzNunioL7ueUnoTb7tL6qi8jnN9aP7zv3aS550CBJr?=
 =?us-ascii?Q?TpcGmbH/tsh+IMiL+770h+tugN7HWqB7iJTKhOFRuGuu0nlycTh7MoVB3xly?=
 =?us-ascii?Q?RBRmwbslo/ET9nBxTCjdov3SwtJuW8JZV9KtyQqLYHcTxviG2/mq0imddXl/?=
 =?us-ascii?Q?JdNRfcviZjKjhsy1vXU6D/rengb4nTdSjyaulSCgvtw4BS0wJFVhOnHMdGsU?=
 =?us-ascii?Q?bvjPtmDs4FDrPmvyRXU4VeV5S58QM3x/x1hd6r36G7MhapzdU4FcjN4E3DoZ?=
 =?us-ascii?Q?WEpQgPRru43j+vYSSpIPtx/GmjoKdshObd0wbYkrwsLUzCR7xaqPnnFoCZ7w?=
 =?us-ascii?Q?B39HfmDK8+PoSn0E/n1L5L56FwT/8myRcJrdNeKRzu9guqLNgzMhR5To1jbk?=
 =?us-ascii?Q?ejAqCTIndNuT+pJnzsmhFLqfgIeCSRyLCthOx7Rv6/GVKiCH404MlE2K2N9m?=
 =?us-ascii?Q?5ZALRMLvcyDH0uPFcyMifD9sjK9ubhdBYC8NZFOpXqMepQc/I8uIdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZp39Y6zNMcovIUAm+IzwgOOlTqa822hmuZPuneEsXjUjBNZYO8Ga/gwUYmD?=
 =?us-ascii?Q?JCCikatoLKyNSGfVuQu9Hvy9eXLUKiKPbJFKr8UxyMaXjB8Q4fR5dRGCm6/l?=
 =?us-ascii?Q?D+ibZ17r86WorkuMTf5ynt1VoWB8MwPsj//t05FlkYuoAyR/pY+BG8yK83jE?=
 =?us-ascii?Q?sH1lkRjvP9Hog3fXkSf1at8c3HkuDVJfuJ9ODD9mOAKCzm+Ni3lPoJh7+XMs?=
 =?us-ascii?Q?91MRlM6nhVng5z13tvHCXqk5Du5bZB/5grrufY28RgycHfdzsPsfhftyjpFD?=
 =?us-ascii?Q?qMUS5T3qWHHiHCoe32PPox8ri82hdJ9ytdJ/TpfCfLfbhqxdjt30qarYZ0WR?=
 =?us-ascii?Q?Gz03/YF4j8Qy6vMYzy0g0X4yR73Fe1D83/99YQUdkm89p+UUvMnVR2ngPF6W?=
 =?us-ascii?Q?lC2JpSmb037oRsw+YN1W77eMPRihnULMUnu+2Dw0QppAiclxNadz5xW9Pwn5?=
 =?us-ascii?Q?163dqsBRnXCieWU6c/nKW5VaiBo6IABDP5LrF3hrFgxD7Ey8HkOwW7PrgqDC?=
 =?us-ascii?Q?7MOXWjN+1cbIbv7DUTcFLqn1u4jR2Cf0/9ZQBI0YkxLJcIBlMvn69BKogLcR?=
 =?us-ascii?Q?7Lv2Cl8HAvaRakpP5ukQ3oMZfEWnTg3CyB4dt9xi1pI45n8iZ8xE84drX0B6?=
 =?us-ascii?Q?YE6+DdGvJJEL3R3/vziaukc5y074qJp8IzirHZKjGoXzM8B7NofqarenlXG0?=
 =?us-ascii?Q?fcq5bEpDJvRQjbyAbpKgTzcqYkprBZjewEgtXP666uOkQHD+QmoExinCKg0Z?=
 =?us-ascii?Q?LKd83GTMDpGHMEHGDqMfHwGxonuf8BBMN2HG79nA8KrTbR7oMzz9GDMegq2k?=
 =?us-ascii?Q?50+vgfMwgWv3b6lbveECILCQGPk2DCzDmKDdrqMQOmu3I5SduKncan+Zend6?=
 =?us-ascii?Q?2m/6TEF2wbIsKE2S3tIYT6IamCcJXjPHuLlEAx8785XAUe8Yjt8JFvoARrFA?=
 =?us-ascii?Q?5WvMWkQ67y1+gbBwYZfR1V3uVbhsjuBPs5Yl+uV5xOGxIeCecHFpCB6CrM+i?=
 =?us-ascii?Q?bMcJF2eQWblBC1Do+1b4KlLyJ2CODkGBfnfs8G2zFTfOmCzthmhQsBpkCR4D?=
 =?us-ascii?Q?RAtpQ88jhk8ttupTAVZFvb1YO6tx+7d18fGItsmRpHt19mz75oblZxyvb8vK?=
 =?us-ascii?Q?A3TmQD/XLFqk0EJA8XFTEqPzKDnXUcEhIEunCzBaJa44T/fruweTOb74vaH9?=
 =?us-ascii?Q?skWSlhZV0zue6zqPh5Zeg+CJ+PWKrYaqLB9Ix7zndqGt7+8R1242JroMPnI7?=
 =?us-ascii?Q?k2LAvfBlbfQXgRyQcjrbTWokjeFsLtv8iGcSXb2e+F60xFuSE15il24dnmhI?=
 =?us-ascii?Q?kdTB4faFEaB/yjRu9qQ84dovh5S6y5ExCxNte+z1z0b++MgG3EnGo/QfFeBS?=
 =?us-ascii?Q?XaNTodnM9Dk/eNU5AlU7ItwPyxygNu6TM2dN2HvjbnVV+d7WGmWtct33S6K8?=
 =?us-ascii?Q?ovyw4Y1v79SG4SXp5ug2ZA8jIFQEewvKoU5kltWSjZ+VGQuSdafNvrDjyzah?=
 =?us-ascii?Q?ScN8PH8ZWoC1WrG95YQrJ3ekZvg5VRg0hU5aLIRuthXQBm/r1vw2Lb2TFI03?=
 =?us-ascii?Q?m0JvkcGmycaZLfZm6EfXnMItPdnaQbuxhzO3VESaK7tUmlApBMlNMSl3dlbj?=
 =?us-ascii?Q?lOE9TEX4iQHGOf4i/kdGU2o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1c9325-5365-4b62-35fe-08dda549d9f7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 22:31:17.4773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIooL1MPraDpzYtafVHOQOdTtkP5s/GwltcLCU1uDlwN0YjPatP5+yrL4u24Fq7j/Yd6MSdDdVM0kV9FvS19CJaLqpBqZZQPgUOcqzzqDTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB10377
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

patches for various bugs in the spl code

Changes v2:
 * added more details to the patch descriptions.

Mikhail Kshevetskiy (3):
  common/spl: fix potential out of buffer access in
    spl_fit_get_image_name function
  common/spl: handle properly images with bad checksum
  common/spl: improve error handling in spl_fit

 common/spl/spl_fit.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

-- 
2.47.2

