Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78715C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 09:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9CA8484C;
	Fri,  3 Jul 2026 11:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RiKiXeYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21E084867; Fri,  3 Jul 2026 11:12:53 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A174847C8
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 11:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytkh59nN9i0LzR+o/6rchWdUl/GYOCPSZQK3tQyPdPHvxJQi0x+ieqD4U2xc7xi4fQMTHgUXsGr4WBabGBETASEt4tKaYIW561rTfRwDjCbBP/wHmS5pr4svovMeJfH8ruPbsxjBy0oKtUo6QuhV7yUCxtG4m0+Bp2RysSkOlQaGshEc/fj2PQkM4wr7NBUPa+waQTv4juF+pIgbr8oSmFkTTfmkqUnOmEsFKaapRDpW26tXtyJQiGvMGZVvPDsuWwdAgTwyPA9ST/c7TSjqBMd5hB8w4FsyYcW4/LeQ+f1F3WPxNtjVDUb8zH2OvO7Js6Mmj1GRfrmPhjfKfgbrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSdqFkLJ1i7sP1Ma0LoQ2CVvsUpRqCX9exThhlSsIM0=;
 b=e4cHz7OPH8jI2WqBFszBdA+TPSEcUy6SO+v4SvRkhNvY3PA8+G1maLRWqoGk7zUgqF2H35T5UemQMyc9mJRES68xfcqCsWObFzjuS88VFRL40qzROwDDNzbJ7uQEjv1l3EH/GwcF2YbLmwx96aDqXbQYWrFulenk8iv3d0jDoCvd4xl9wmSezlJckYWBzX4qlXugndGjLRHqRLLMj41LVdfiyeZPc++dqRJYbilkMH8dtqNqxw387pjJpoG3y3268mhu+JA8reaHmAwzNq0bnodKZcxEfJ4LQGsriC7A8x1EhpoQTFpBNT2vdKw55sU2IwzX3AVL9ZgjbgY9JsjqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSdqFkLJ1i7sP1Ma0LoQ2CVvsUpRqCX9exThhlSsIM0=;
 b=RiKiXeYaUfmTtVXf1gGwr+E0OrR7tAkPXVrB8NCOsHGveb2pzSm9PrPuMN3F6GLy/ZPTZAV8FdRv918fWT2nW3dt6B3YBecPILcRIO7QcA9+UaQTCLoOMKSy29CzpBjqoXWQlDDvltDiF7d/4EcvwV/6f/bW60goBFojJpEvIofBOMD74RZju/fWp3f4RUwBDEn4Y/M6P7RVKFofgLv4sPYLTcaK46/nnC14gZfHRCdLUdt3MJJ4sIbiE4xupTXyeKWk4exMu3kPb6rP5GwdiDlS7MJcnPYeqvrSU3mBK13kuXMOBXSduHTRtpT332OL/6TT7v1kEwgfhAtwy8iqZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11579.eurprd04.prod.outlook.com (2603:10a6:10:60c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:12:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:12:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jul 2026 17:11:24 +0800
Subject: [PATCH 1/4] dm: core: free fdt when fdt_create_empty_tree failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dm-core-v1-1-076d395bded4@nxp.com>
References: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
In-Reply-To: <20260703-dm-core-v1-0-076d395bded4@nxp.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0242.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11579:EE_
X-MS-Office365-Filtering-Correlation-Id: 50022d86-241c-4138-ecde-08ded8e33c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rtD+lQUdTPXx8RG2sdxqT8/Yp6oyyzUrbkAPQ9F5Ja1OCcGsgmdq7sTGr9UZssyaAwF+kijhdPQgZ9ArjusFAZFWqJuA3FRS+toYPboo5XTvD680v+q3CuMgJ8e2drh8QnpRpVi5/iTMtIDTdspgqVpJTN7jyucizPRvoiEcL1unV+JMb1NeaMnInoVaCNL4wr8jgnWQtdPsHUdUzpopXBRqsN1oXqaoijj6zp3crVnbfbgo1FzrPeCBB4ajeew6JJAkl3gU7KsnXPn8TDlpt113pCgF+haa8k4YGmX5F6KdImUqp90yFgd0OtbsqnEETuQgKSAlrGuT8jqWg5v2WHWo21iNPc7yOCyCv3tm2z1StJApzlN60Q9/qB9TsAlWpPPApiuBO5dyRT+o3lv4Z1kUFp53bUfckdJlXqjwKEvZliuh+8j072OcFIWtgTPXu5er0A9EwbWHjm9s7qPni8/G0FH3QudUu9bNAg4JZU4BD1AyukLqD5rpf6jV15HTVt/BLkUVl2Mc/IOA8YGx29fCkxCkzU/1uvl39LQRH+VTKlufzoETPa5GDiaAgXWXexywC7zpZGjx0Uy1SLi5boB2bdt6OZuoisPW56z5hGU6NgyOVljtTkd9P1qHEVI56ihXUW1P1Z/akOTUuX5PhFPE85rlXS6yOD0kP2o+qf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlEvODFqSEd1VlpFR09RT2kwdldpMzMyUU5TZ2N4ckRIaVlvaUZwUWJJd2NX?=
 =?utf-8?B?dTByK25uZFg1RXpRbzQzMFc5cDJ0YjlSaWx5d2F1c2tHWjJ3VXlpMTM1WDJa?=
 =?utf-8?B?aCs1SnpvU3c0a3M0OThrNnpjRDZRZ1ZSci9MWm5wME1PcGhZOWpXcUFEbUVS?=
 =?utf-8?B?Qk9TMmZ6SkVxZWdEbXhRcXlSU2d4T1hocFZ4Y2hZK1VoaG0wei9ScXFlVCta?=
 =?utf-8?B?OExHMnhPVmJJOWxTM3RzQTNSY1BYaE1IbFoySGtxbS96anAzUXhEYmdBaXJ2?=
 =?utf-8?B?aGtVQUhnVElFbWZWN1FuV1RUTzFOdE1CMUo5RzYxMUk3QnJEaWFuZTNTTUVt?=
 =?utf-8?B?QmQxcWYzNjAyUTJnYnJvbzd4TjEyNEFGNks1cVlWYW1adVdaRnRtQmU3cVND?=
 =?utf-8?B?RndqMFpaNUtRZGM5K2F2Y3NtTTM2US82SzVYT3BQdFFKejB3dDE0ampZMVpw?=
 =?utf-8?B?b3RSS2FxaXp2S21JTnhoNkViWmlyZ2l5VmlzOTNGVFNBMkQwR0cvQmZaTDBI?=
 =?utf-8?B?U2tSb2RqMy92ZTNJU0QzVFBtb1BpdzkvNEc4NDMwRC9sRjhmYnNoNFd2NllK?=
 =?utf-8?B?TW9GeUkxRFZwdlgzS3lBQ0hReGcwYmd5NklhZ2NiWk9UMW40Z1FyVFJCUS9p?=
 =?utf-8?B?K3V6UHk1N0F5RXR6TDlZb2M1Q084T3Q3SUFzV3dEeHo0NG92RkJCMTJmRU56?=
 =?utf-8?B?UXRqUndmaEkrVkNsVUFoSDF4TSs4cm5YczNwdUdYY0dCd0NRaGg5QWNWdmU2?=
 =?utf-8?B?ZWZ4V044M3RpWEN1VHZYRFZpK2htRkhRaVJiUy9RNVdJQ0V6TGlEUERlUzRj?=
 =?utf-8?B?bzJqVWtWQ2dsMml1UGVmSDEyS0gvalQ1WmhRNjdoUlNoUjMxVnZRam8xL0E3?=
 =?utf-8?B?aWE4NXQ2Q3huQkZwVDg3Nkdoam9vUnNqcU5UbFlZTy9uWU9XREJPekllQVBL?=
 =?utf-8?B?MXM2OUt4UWJUZjBsRHZyTGtaLzAwYkw0S1VpeDI0aklzZWNncUtvZW9KMUhT?=
 =?utf-8?B?dlhrM2d5Sm52NWxLTWlhYWp3eExxZTlJdWdHWm9lcHRzZG1IU2VKRHh3TlFm?=
 =?utf-8?B?M2puRWJCKzVuWUpxTVd0TkZxY29rOUFlVlhDY0x3elcxK21oNjRVTSs3Y3A5?=
 =?utf-8?B?ajFvM2t6ZFBIRDZPb2xYTEUvWENoVkJvczNJbTNZcWc5QldNY1l1amY1TCtH?=
 =?utf-8?B?S0JYVFRWRW13NWYyUitTZXUzSzhiNTZGSTZ1dXA5Z2RlK2xzcmowWGl5Y0Ux?=
 =?utf-8?B?MS9aNzNjNkxXMHlzUkFPRXJFeGQ1L3VCVGRCY2dGVEJxKzJkVDU3SVNSQ2Ju?=
 =?utf-8?B?dWI0S1Q2NFk2ZjcveUZ5Q3o0SHk4UjMyRXRPZUtuOXhkNk1IM0lpclRIbHBP?=
 =?utf-8?B?d1ArUGg1b1VzWW9hMzhzU05PYkxZeGZENGVUd0phcXFRRExCeUppZ3I3TVNq?=
 =?utf-8?B?eVp2bVBmWmc3MG9hdUdvRlVBRlFwdi9vT2dIVkRvWno3L3d2M0hNRVl2SWsy?=
 =?utf-8?B?Y3NYOUtORUhUMFVpdDRwbFZyS1EwTXR6L1BUN1U5Uld6SlZpZmdRVFFmdFJB?=
 =?utf-8?B?OHJ4dTBPanQ4aFRYN1NJNVlHNjhocU5zaDF1eFRkTnNJcFFZazI1ZHQwN1JL?=
 =?utf-8?B?MFhoa09uVVBYbndFMTdFdjhrVTVVMDVyajA1RUhwQ3RrYU9yZTR6UXM1Uk9F?=
 =?utf-8?B?ZU1YeXlhOHJ0TnFPc2JMNEhIS3luRlNzaXpLcFFXOVR1Y2I3OVFMaDVFTzFV?=
 =?utf-8?B?VlBndERXTndXZXNFK2YzL2wrQzdTRlVPS2laT1p5SHluZkU3Y2VlcUwwQWFF?=
 =?utf-8?B?SDNkUGI2WGV0Yjk5Y0FMTVRVN3NBUTdyOWF5MUF4dlNLa2VFUW1xM0ltWTE3?=
 =?utf-8?B?aGkrRmE1UzVMT1R4aFdqemsxdWQrNm0vVmdFVWFyMU1GUjF6T09IKzVRUE1R?=
 =?utf-8?B?aTBQMVlBVWROSEcyYmM1N2d0emR4L3JiLzRsbUM1US8xa29ERWZsYXErZTN5?=
 =?utf-8?B?WGxncnBBV0ptNm9YMFhLQXVTWXJOdFdVRlp1VlNPSm1sSzFZU0VVRjVhUkNW?=
 =?utf-8?B?N3NJQ21tVmFCZVFtWkN4MWRFUGZqVHduejBxTXlqVnZTUGU4Qk5FYzg3TVlO?=
 =?utf-8?B?bEh5aGxXOHFuRjkzNnltUWlGNUNBbnd6YTNoMnN6SlBSeWVqdndSbklCeDRF?=
 =?utf-8?B?ZE5MTjB2MHlZaEZpN3N2cks1ckJwZllnaWRRUHByWnpKeC9KcnpSWlBQTExn?=
 =?utf-8?B?MTFCcFM0Q3VFTFNxd1pia3hKQnJ2a0tiZXNhcGxJdWZXbHdyTm5leCtwTjFt?=
 =?utf-8?B?WXY4NU9pYWErdWxuVXZYN2cxZUk3eW1HM0twNGpwQzhJc0FoQ0cwTE1DRVBh?=
 =?utf-8?Q?iNnwmF5vi7969hUw+fXtUt8bebruFu1m33RY2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50022d86-241c-4138-ecde-08ded8e33c6b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:12:41.7306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cN8Vp/fOomCjuWMsGEq0saHMBIHow2NT6jtA14Mz+TF3S5IUl93djBSAlmISBG3W8UPFGW+QmNsjk+5hgzr2NC6cADvjAbaQYqqErPp0EAJlIVPRMk3bDx218UOEOFhF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11579
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

From: Peng Fan <peng.fan@nxp.com>

If fdt_create_empty_tree fails, the malloc-ed fdt buffer is never freed.
Add free before the error return.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/core/ofnode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 1388b481031..b5d13c43db1 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -130,8 +130,10 @@ int oftree_new(oftree *treep)
 		if (!fdt)
 			return log_msg_ret("fla", -ENOMEM);
 		ret = fdt_create_empty_tree(fdt, size);
-		if (ret)
+		if (ret) {
+			free(fdt);
 			return log_msg_ret("fla", -EINVAL);
+		}
 		oftree_list[oftree_count++] = fdt;
 		tree.fdt = fdt;
 	}

-- 
2.51.0

