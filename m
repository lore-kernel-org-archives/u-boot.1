Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885F6E6F083
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 19:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E247988FC8;
	Fri,  1 Nov 2024 20:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="S2ulrohD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46B98924F; Fri,  1 Nov 2024 14:40:35 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::711])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1948902F
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.gnau@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URFcuvBMl9OiJ5gBlfcqSDZimUGlLWLfEJNpQZSVuAVHQf77JdPw48OkwELFJx2XvjzupBGN823jKIsvBdLw1JbCWj2KSz4vwdSfN0pZmCD5TJUBPzWFaF1h6c/ZcpdA/e/rl3uZpY+TbAKFGKSBf9cZLoedaJKEFmjbO4dWqqUVUGSxsQWnIA6CAJtVOCc6r7h5M6Y1270UgeZp2UX5w+bdBDnFPFrkKkq0RD44K/gCl6uDtyLPqEl6oO4o7HhGaoSupc4+dvvM+pmVR5aVeN2qCQCKhmdEdOBZx/+yjTV6HfuAxegENlJAhNZWABaFHNkcof1Hn3eN4ZqWWfuiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy4CXPNe+nSGStA7SMXGMb6xPE1l0tTniVuApfRBUbU=;
 b=acxnkNO17oD3rbYed9Jem7aFOUohAA71Nr+dOxH4FS9H+c1BRPT3asGAqxXD8++iNsuGvLX57ZNNIvYpT20cp26abkSOXh9j5kpJwGdr07GCz4uV6qBnB6gbzg4szEO6JQLvM0GRskIiQnHLDew3UzhUGJ86lZHPJf0V5yhzQsAKvKzicHDBhcf+1TOWrCdGzcodTsxVz0J3F6ILc0gNwhh0LHmJDAW6vnEBbW7WiVtXGWjS+nF901rPZ1xUEQsTrqt1pUw+W7p/kjogugIgpigemvgGG+ltI9eVfc3uJZSpYBlacccHtZIed8vbd1BikNQnUmGg3GyAyEcC3d35sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy4CXPNe+nSGStA7SMXGMb6xPE1l0tTniVuApfRBUbU=;
 b=S2ulrohDivKQSx2ayOHUVFjBlpLW2szV7tCqyLoYdCLrqD0hdIwXaSSHzbKx3tMT9JPDilE+ZxSeZVkJzBs7GvdFaZXlGzNi7UUHdm2KFSroy9ZUz4KdazsAa4LNNPaZ12Jjma1sTLufRcUJH5Iq6B8+wIYhu8Na2TKyJrgdaSHc80ZOaceF4iVhRVQiSh97SM+EO5hy13KAmCSKhdN3V3lLRjaljLEjuteqi1mk581noST8W4d9bo92RWRfF7Fta3X8+rdgQH84IGPuQewtqIGBN1Ts+t7hUyiIt2V8ksDjKS+/lhsqGtIImG5IHuXLyODNT4D7qKqLmFpjjkhuLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com (2603:10a6:10:303::14)
 by PAXPR08MB6543.eurprd08.prod.outlook.com (2603:10a6:102:12f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 13:40:32 +0000
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::fd8d:f047:ac4f:6d6]) by DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::fd8d:f047:ac4f:6d6%4]) with mapi id 15.20.8093.018; Fri, 1 Nov 2024
 13:40:32 +0000
From: Andreas Gnau <andreas.gnau@iopsys.eu>
To: u-boot@lists.denx.de
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] fdt: Update fdtcontroladdr if fdt_blob changes
Date: Fri,  1 Nov 2024 14:38:33 +0100
Message-ID: <20241101133848.2278151-1-andreas.gnau@iopsys.eu>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00006629.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3d9) To DB9PR08MB7512.eurprd08.prod.outlook.com
 (2603:10a6:10:303::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB7512:EE_|PAXPR08MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7a0def-cab9-4033-98ad-08dcfa7ac166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Bhp6QbCkpHXZHlZXEqAdmuZt254bPcDtD1DlxwUc+ePmC/FHJJf0I82GO8F?=
 =?us-ascii?Q?kbo63WDt1E6e5TOk2DECljpug2IJ/dPPSYZemAmBrkB8Vp5FTXZA2+SkmmPt?=
 =?us-ascii?Q?JbmGnpecYSILdx3TyHaWT+HRWI3aaiuLcN3H6ED88O5suF95ayntQ7ZF+7A3?=
 =?us-ascii?Q?d4KXwNESnfvznskiSi7wKtwW/9UMIzQcImQ88gIgZXKbq7PV3hBWHXrbE/wH?=
 =?us-ascii?Q?knvG7Z8+KUfh5HX2DHw5MmyTJJw7t422KvcqjOG4GBWlP3tlvX0v/6cfyUNm?=
 =?us-ascii?Q?MjnGl9kvSyncigGFSDRnV9SRF/mpFJpyoQpRoKzUk13VW9Ibb8kQOOtSsYw5?=
 =?us-ascii?Q?R4vC5CDBp5ILXtFkjxJbJ9F2pS8o5sEP52ihtlzGVQa8aPypmcSnwykjV50n?=
 =?us-ascii?Q?93VOqLbj2KXAyzoQ5cvF2LuRUdmWrvlaGCiqtvnOcR9QRRfDolvNIPu2BC0B?=
 =?us-ascii?Q?HBzJB0kOaUadFJ4+lArnnSH4A2mScmNoMll5y5ruN0xJHTMzmJmA85Mwsqb3?=
 =?us-ascii?Q?lnYvpH9P0ghr+ukVUU4dyKdDPe52o/kAGKRyVRMjMxPgqHIYPytniUAW8A/d?=
 =?us-ascii?Q?obkBkb5/+VsPWNx6daFh77DD9orYzvbRsFcZZNiCO4z49VGqdod5me3hA5wn?=
 =?us-ascii?Q?JvcIR0dS3NhPVPrvFnGZtRLFgCppyhObk6362ZRRyTI2zXV4aloabY4PzH+I?=
 =?us-ascii?Q?zo/6hn/f2WKi8g/q4RuLxUWjveCKLl5bouY/yCQfxlJOJUKeZUTfLl42V3F8?=
 =?us-ascii?Q?ZxD1Mm+jz9vO600Y+ytYNg6qgrl5JU9tlb167FVZ8DhXF2mbz4ONVQLYNubM?=
 =?us-ascii?Q?YcbgQHc5zu0LcYATC5YNMMDHk6v13NaICa8jcAXbygBaJzt/Ez1APpJNtyOn?=
 =?us-ascii?Q?TSdXoHwIsgUNGabJh0rSrNa4Uhh1qV/zFYfJftSMrtKDhNecBzKrsmmew8N7?=
 =?us-ascii?Q?+U2zSMuAsYfJj2K+8qkXCwMG5eEn+gCF9FxHALxAcqRMRNA/P+FTfl9lUQ8u?=
 =?us-ascii?Q?cg3gM1+Y6lCZ3G7WZ1EXhDo9CxVackwI+lj2rTsgWKLhADsfuQyqtMduiwwv?=
 =?us-ascii?Q?M9vPbsFEnui7UnLkf9D53pz8qo+7hXb4T1+TIg3pZ51eLJX/L48s/184mf5s?=
 =?us-ascii?Q?8/rMnoxKmd3W6VO+Zf6DLz/YvJqLPeQOegKQawrNTm1G6Q2xhsTB/SeNSBmG?=
 =?us-ascii?Q?ab5ADSIfFa4FVFmfs9u7+BPl+4aTVexzdCBlDRdT0GlHNhvh6FREmRDiftI+?=
 =?us-ascii?Q?blJ9j040h+FteGtbyt/HY6uXCZiSAHPq4HasXfGBAJVN5mh9s86F/1hbZ0vd?=
 =?us-ascii?Q?Ru1QzN9bKLAGc5xT8Ko92Imz5x4UpdZeG7puyYhX9gYjq51L9IWVbVFoy6KC?=
 =?us-ascii?Q?9rhldj4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR08MB7512.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DV+9FFGxMtn66YqoFs8oFbQ8l/k2M1yhQk+Pc0vTt2t5ZnhLpIXhyAVPrpnX?=
 =?us-ascii?Q?1Oq6vgLv9QlR/XvpCELMtfQMXW1iiTGIyz3eH5KG/VgBLz4mL2YfzBACnDMR?=
 =?us-ascii?Q?ybklLNZyxfWaWERUj84HNUIXTJtUlUP34xr+aBVPqig9lTnNOlOtWu2s3ypR?=
 =?us-ascii?Q?aO7w9l9b97w/9iD1QCNjoRQFnonJurGg9CPGiLe2Q9ltjfrhumgjCwiysXTT?=
 =?us-ascii?Q?s0kHRWiLomdxOP7pi6IXousueVQ3FkJHcZDitLUB2lgqi8ibwGflz//4fLVB?=
 =?us-ascii?Q?KA0wnq5cedwbviGhxmn/Cxyo/yzfAVn5+87sRuMEU3HaqS8qvRUkb3ZGLzLV?=
 =?us-ascii?Q?igA107Ckf0+aGS+bGMO0XXUF2hNCvObr50rcZWzlBO9xDn9dh5s2F8pZkEDk?=
 =?us-ascii?Q?TMo0EEY8w5vQqvKxU9t1/cJZmV4kFl/wkRw1Lx2gsP3Io/+dReOiCnximgAx?=
 =?us-ascii?Q?d2NzzoIeL3mMXx8pEIpe9xikTT/ID4sMcjLf4wRwSJ4y6kyvVshM2hTItRfj?=
 =?us-ascii?Q?nZKlXkdZkiN+4HabI/yhC54JhQJWd9TnYZm/RJZsycdONM8s173ohK6OqDv/?=
 =?us-ascii?Q?xO6AeqhyYZ7EQ2xVTqlX7dO/0Ui3hVlio2rn8V/k4y6GiJUsqj7B9vxm/XyO?=
 =?us-ascii?Q?zWTH0ZiBq8+geX07QF5weeJJpIy45DYZ7rG3a6VDXRpS0H7MNcXli0yogTa8?=
 =?us-ascii?Q?phYLpowVLdwTpffBBRr07Ot3n5cJhTc+0HvLloOgZrSR08fjcupZ5CsZZpRz?=
 =?us-ascii?Q?2oSr8A7Wbq2hBua1qKvvkTUi19RiqNCLWGlDmXmH+26nXZJG2xq9gRnFICLO?=
 =?us-ascii?Q?xOquOxP+mUFdgvXKX8CSAay6fTxSEbpBsUDJIb20At8bA4V22jtnGXh+nE8n?=
 =?us-ascii?Q?YDp5D+oBaDz+hUmDbNsoUmklZbuDgKjsdOIeG65Xqsv4nNRJMWUcLkYckv1G?=
 =?us-ascii?Q?AUte/rhhoVmH0gUceO3uX66deOujvOGyVPmqBV1+ku9Y5TttrrPkEcFPkh71?=
 =?us-ascii?Q?nSjEqppP6gTde570SIqkRHP9e24qNXm9Pc4NXOlS28TV5XrfO6D7Z+ewbsgv?=
 =?us-ascii?Q?vUGE3G2fDZEvYPiNBhNy3fRdJvzjHyuchD/0zDN5TAe3InqtZAVbL1TixkhF?=
 =?us-ascii?Q?s0pIo7fbC8/2MEe0n6OIw2wTZdcEV+bhQ/Jt6NXRnJHITC+eTIjAU8AQJ/L2?=
 =?us-ascii?Q?9AN1OBov++XtrEBlp+9m0CBWllb1BPHbQBgaTpY2BrRMGyFriGTpiSz7Nip8?=
 =?us-ascii?Q?pHSDk14rslJIPcf3LjOD7YfRalWcsN82rzFdjZob8Zgp2Qxyx/rDrX3EoDZw?=
 =?us-ascii?Q?IJKDDmKE5yYDQKuZOIaX7CU8Y6SZTfZElDfissLyFyPSD4uShIa0DqGCYyIS?=
 =?us-ascii?Q?j6dZknFuFDWb6JqZkz+ZcX58N2bqNflHQ7bIJuKqtt/Ns+aOVnSXr4NSvL+n?=
 =?us-ascii?Q?VZ66iCx6NBLst8Lr50/MhRN+9RNqaS73iut1uovHsf2sZHSPlioR4Rxjc0eV?=
 =?us-ascii?Q?kILVDohOYTsxR2X03mnW/YGGsenBO8xADx3H6tlk/xO2W4BB6zr6H6Dh8gVV?=
 =?us-ascii?Q?Fqx9qifmqyjkvBWL/2JYfxNLpQZ1SsdYP7b3YzLR?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7a0def-cab9-4033-98ad-08dcfa7ac166
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7512.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:40:31.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EsztzBiplhhBkPwWKi4lw5NyCJDaewCGClSE0HP6nrMSdZP0wyxfW/8W2+eyDzyPP2UAMNDYH271Nf4chSnNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6543
X-Mailman-Approved-At: Fri, 01 Nov 2024 20:14:47 +0100
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

When a different FDT blob is chosen via fdtdec_resetup /
board_fit_config_name_match, update the fdtcontroladdr environment
variable accordingly. This fixes an issue where fdtcontroladdr would
still point to the previously used FDT blob.

Signed-off-by: Andreas Gnau <andreas.gnau@iopsys.eu>
---

 lib/fdtdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b06559880296..e3534b647556 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1759,6 +1759,8 @@ int fdtdec_resetup(int *rescan)
 
 		*rescan = 1;
 		gd->fdt_blob = fdt_blob;
+		env_set_hex("fdtcontroladdr",
+			    (unsigned long)map_to_sysmem(gd->fdt_blob));
 		return fdtdec_prepare_fdt(fdt_blob);
 	}
 
-- 
2.47.0

