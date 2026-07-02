Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D659C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 06:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE26884CEE;
	Thu,  2 Jul 2026 07:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="cIP5CADG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD83F84CDC; Thu,  2 Jul 2026 07:58:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5668984CC0
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3XnZy4KVz4okq8B65utGb5Ni537GwG6vEcN+bjJqGC4kou8EE8kfrSPQ88OZ0gIXtqzyA0g52YVTdCE2E0WiYlPlkw5qR+LaPrbuyXpjSheDQW0cD0bpWKk1Qos/a8aidncC/dCUSd8KEHp0ZHR/qHSFRPBBQLWCttbKqBIZhpmNTVJVMbT2fYX1FOwBgXXNdBOSdJrxExPBhrhHy4OSDTkA7MPbRijSlTtBtBG8J/04QCIII9eOvY/grxM7DLYXnlW6ScdTHkjKgFiEZuvWAEtGWnzQJ6YyP/oR32UDGGlTPDUKYVGFbZK5W8oXJkU10EQJhrUQMmNpR2rWRAhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=DVqPNKxF+HKrT2BwDq1hEN0M2bLWcoVWylKEMvac8+EAaVOl/QPmko22Yc7s5eMTWKJMgxMiQ4I/PmD+25gY4Tn0Sz3Lmj+QRTr4tDhXRoEa6iWqEPrl/6ciWQC0eUTVETIwcxn+ZNkDvODoCgp3xZeRnXu9XcVWq2PUrM5LBAVPcjtr6UrB5rLBhTMs0AZ3ApZVoFNFBLkZbX+S6//F2blRpGLAIdgTWTP5U1cVOvl/lNnZ+M9dQWgj0AHgHbSPF4XUC9cr9B77T1hM03hEHsaEtwA6aMyBtPfl0A2wHcEcwixB4EzTVCiXF+1BFE1RAY0o4hGaWuirNRZKbmMCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=cIP5CADGVnvH9Cga01Mh+t6jgH/j6flCkQqrn+TfaQBNcbfVGoOWEv9avgWHR49x3gfegLchUFwbuG5ARxLiBsxopO9FsW3c/O+/W9wxCStTlIOEZXMxDnTVLC7uyR6nk8iEB/o62KzXbZMUQt5HwsfbyRXapi98CqqjlJxlwkwqXu70bPC5qKgawT9pf89tgO8m6TODCmShwopuUcmIDpwMsSIXAIrW7xktieQhmQRuhHp+Q7GFFckYwuwvVw1aPSlCTzUoJeq8B7k00DcEpGIEU0smIn1jlJrJ87aDHvLH0kmGHiq+a4jifn0m8uwk7tHVjDacHRtAMJfjzv643A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:35 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:35 +0000
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
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 16/18] configs: airoha: an7581: enable pinctrl/gpio support
Date: Thu,  2 Jul 2026 08:57:42 +0300
Message-ID: <20260702055744.2164975-17-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7a4bd3-ad37-4fdd-9f09-08ded7fef446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: H8dEWxS221Hge9H1jVT/DbC3kQF0W5o8JE6sO6Sz3AVDJbRLHLfYvGzGld5FGWg64guSX370ohjICTz1X6Y6y1qdkmH0DU+Zg3rr+KKzjTBWZNme1xaRW/b6cgrKDptOZKs+LBHkROQYMdzqNkE/QFNLWZIxLhxjMBBVLePXo7rzCyBlthUR7FqVJxB86eulxR/5x7SJj96V2MWXdHC1PTYFODRxVms93uOsPHUn++id28G65Kh0ShzhTGzBNzOLq1cyYv7oCJUhzi0Tf6TdQtbx78WR9k0JzXQpIDf/4o0y7ErXZ+B+PCnRHxN0qv4JVuIn9C4svBRxiq/x/MCk+HRIyIyfezK0m01QvxGMRDV8jhQIe0d6LKI5Rr5AWqcTec/Sd5eWMIbzdb7tITfnTs6Aw9xaHp0TYY65gEBApEI7FP4eglOAeCy3Dg2JZQuLJvjyY/30EL2fB3hJDP5WTKRkwpOFjyUUDrD7HAYmxamyZ7jAdqVImyZftDcwD0FctWZsyQ+Wu2lMb+DAp0+IlsnbU8QjXM6bNSlOOOkMiMUdSYJgcheE0s219cQabRjrfobShFeyTYq6wWADj55cjwdQW8e1ftvb+oKmcGGq+/WjW8KE9iiu0HTj2rF++EaydJvYvcZcaRKfgTR185W91ZrhPqTUf1iADzlXujg44N+EEs6nGtovef59fPWvJJK+/r7X2jhR8woZ4d9ONV905I+Ag++AdMZH+5Ux1ruePqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mbE1KV/fwoRtbobUsf6tN42EVAX6gwNqYmNzWGnK6W4yQytIXXdfoEB1Totg?=
 =?us-ascii?Q?NgtFPwvhUdnNP+3sxiZ7jCJ/p0zwQYb8+dtsMju/KHq3tVqttv9G+y/40aTm?=
 =?us-ascii?Q?rjeJvfg9sFqLzcn220SbIhsXHegkC8pO9xyMCUNlBTmqCOQGNuMcBd3DJs/S?=
 =?us-ascii?Q?jIBEvvIcJrXCnFRDUodmgFli6ZyYC8FSuohewEMNWsUJcYSaz/sYekUaSHru?=
 =?us-ascii?Q?pGEMxnAsKYLwbK7Cid1R24Saxsg2JiOPUeY833YfTFLp/f5IEkVqgAy3ig72?=
 =?us-ascii?Q?Un8lcBp429++NEvIwN0HWtSnDE6i3L9YilRfJiSmYNV83eUlsMLra1kWFPQR?=
 =?us-ascii?Q?+ZLv2Xn4KR3+jqCCWdAY9tmJaUjj1jQVTvAmjAaM/hIWOc14oKV1t2N4w8wC?=
 =?us-ascii?Q?nhgS6LKWoQmfu7R3YS9oJX+rxtuK4iAk4yQknCceksdtNEeoIbRNfTXuFcWV?=
 =?us-ascii?Q?fy4UmYeJUC2+wM7s5+jb218r1kZDev/krmLVxiR3qmIdvRMa0vkD23cayrWQ?=
 =?us-ascii?Q?imqBNrVRYHiyFoxBJ5GLurJ2Y0j/KLwwzPl1aLG0uqnDm4R0SypQPqjxKA/0?=
 =?us-ascii?Q?BJIgMhYnP/bqJ88odsF0/ZPlI7jnrlVgBE56hUubgu62653Cgl+O6qAXW4Lm?=
 =?us-ascii?Q?li95X4ikNmZsTXV8b8SKJCz71za+K8l0SZANgvVjQZTMUvTrnHOtbWpzEAee?=
 =?us-ascii?Q?c4tbM4ea5/3c6hEjWTOIICXAKYmGXsDLQs6xvGoPAGOEAOogCgKWp8d6b5/u?=
 =?us-ascii?Q?g19stM4msWpQVis4aLAA/PFfrYwVjzLe4hnGZKw3NOKzFl0gbpv3agiH1pYt?=
 =?us-ascii?Q?KCg67rN/49QR59t7nQ54MeleCI6KyPt7RDfSbGDHq3YMAyv+GjeoFyBFQxRX?=
 =?us-ascii?Q?+sj2JQdvrQsnGdQSKiyRGKDlMKO3BncunuTQ83iM00nFJhQFkrdnlsRlflQQ?=
 =?us-ascii?Q?/otDBz0nTKC89G9QIIqVvr4YY94SnkGoSkm6/hKEjHEEfZh4bYO2t4CCk+Uj?=
 =?us-ascii?Q?STcbuatgNFAJ2UOoHtygghGhTaqNOZNuffSG0+MSMtVgjEG/3awqFIGQDTWy?=
 =?us-ascii?Q?NyDSdVUyqiYqA4U+rVPE6Jm/pQEJfNG5Vgz1gWPKyglyOFL6HTVYEb8Dgg9W?=
 =?us-ascii?Q?OHJFUXdYIocWwbia0tpKvFfk6skuansDtOw/vgZZs5p3PbgnfszpiEU/UqpU?=
 =?us-ascii?Q?9y6qHOvt06zcUfBM4esCqXtUfk+vJ5I7NFwFVLxyrAxuvHcrX37PISOmx1cj?=
 =?us-ascii?Q?AKhKTI4k2L+1PCjGuDxo4cp1Fo95xLrTMmjML4jkK+A6qYC0ZeozDPHKGqsS?=
 =?us-ascii?Q?kfQaHVZlhldi583iS9qlW6iE/5tzXisjrh9ajHKup6yGMCRqL4RfmDIjcS34?=
 =?us-ascii?Q?Ux9B+CimbARuS1PrRO45DaI1VmVh7md5cxgpWq93ByOLYi7lqyDL+u8rdYW4?=
 =?us-ascii?Q?19G207wFCo3nDzl54z6al/qCUt+ASxfFYC9A1DIYF1umj3fSUKtK48xqEgOP?=
 =?us-ascii?Q?rXsoB7JGIHKbNhukSJ/sdYNxpzCD6cjcPUXPQ/PsHi5PlDnsnhZuBzSK9WV8?=
 =?us-ascii?Q?dZBFNYqA7bSZ+ko1f85hJbKf1KW5/8FD17BZtqsMxMAq3N1l4alcFdoQdX/B?=
 =?us-ascii?Q?G26TopN3IloXxpSezdol1At8JSAqMJ2aITpgND2q57+ISeNaB/h/mX70orfe?=
 =?us-ascii?Q?O5brtNlGt01P3mOBi+eGOVYhfnEnasHTxFn0uhPyU+0BnV5XsTOdwrT1NoSg?=
 =?us-ascii?Q?JyeCw+jTISFOy4jf4JR/9BB+NEPcYqQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a4bd3-ad37-4fdd-9f09-08ded7fef446
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:35.5240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2HMSto0v5+qLA/NumKQST0VvC/NOuYJoqvZKJq3zkXA4kfJGAzOsPKAJrWV/dNW0LRZ8C8lHReWdnc1ypsImN2UGTLXV3AhtryM/49r8OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

This enables AN7581 pin controller and gpio driver.
Defconfig was minimized with 'make savedefconfig'.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 configs/an7581_evb_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 07569fa0a4e..a615994cc76 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -72,7 +72,7 @@ CONFIG_PCS_AIROHA_AN7581=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-CONFIG_PINCONF=y
+CONFIG_PINCTRL_AIROHA_AN7581=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.53.0

