Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7129DCCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 417D9838FA;
	Tue,  4 Nov 2025 18:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BFpWw1sZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F2F832AD; Tue,  4 Nov 2025 18:45:09 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6105C835FE
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWAjIUvHZI2UqgOspaAskx9BirccqZnQWwyZrF1jlaa3XpDWPM12CLWEuwi5GQ1OHrDFsuevVUJAucSDC/VPZaJI+uusSi3XtYQ/qD0SKD4njMvg3NJajvV5f2h9D/lXOFHVE1zuTeNdbaDCvOKRrf/KtJ7aDlOppCzYptP/JRCL5d5JdSBwBFTG3hffZeW59l3iJOMAruXcVuq2iOh9QCs/tIRcwH0vUl3nFtfHnvvEjeNf/efp6AqniFQ/B6ip4TfqQHdkAG4KPtqlqRPC7sKUBRzmtuYDxuEJjlnROUyEQZ1LIAomba4OSYu2qWqwk7VmkcgWX2dqb00AatAcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Klt7/is5OFiiWD+cSoLkFxe0Rce9npS0qlMBHzIlKbg=;
 b=GhliUsOK+fxTe4wZyCtwO0t0c/gzH9MngDBUX7bsEylFdp4g4lnmUtx3zVgSCfa9yzMUkVzCjTPBzaz9ApJJKnf2jIlICPRLdSznBFqmcS+FsVSnZJunyoTY2mLQrM/ThLtrbSJoSOG8NL0gyavyOxyTTy8BJODJPvHByOIfoqTGxqYFswFgv+zUBe3qXAwVFoH6brik2gsrYIFBSZsYZ2fQYx0B6w4iUD0O1xg9PmYTMTw8+k4830GvAN03BZCaEV8PNXHQdfXaDtxAsBYrIVgtUqluNU/uOOlLv3DmQ2Kdr4O4WXUO3cciDNH8dQz9spvsv+hRDt4D5yBeo4N/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Klt7/is5OFiiWD+cSoLkFxe0Rce9npS0qlMBHzIlKbg=;
 b=BFpWw1sZxd1d2RpPcwTVFkTTuPlcyBB/RdV800yVeO2EtDvb+LMP/+nf3ck2kBa6tdlCZQRTGpXTZSORQ69IESrCgsbK6x1Xz2/6qCPZzuFV3FwEMXj4Nkx7RGQPOp4Hrwy4qxiiXu6+OmYOpdpBBrDmIdujWdkClMCEof0rBt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:45:06 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 17:45:05 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 3/3] test: gpio: add test for gpio-line-names lookup
Date: Tue,  4 Nov 2025 18:44:58 +0100
Message-ID: <20251104174458.3385564-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104174458.3385564-1-ravi@prevas.dk>
References: <20251104174458.3385564-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::24) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB4PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: b840d57d-7cb4-490e-6d48-08de1bc9e3cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2co4gXSAgyaFtoktjknnUt/pOfMsvvf2Qwz7/dMMJuubmaE+6+6h9ccgEyFE?=
 =?us-ascii?Q?sTOW8GJqYugoc8JeJA9fiEM75GS95ZLL/UVtQGUjz0zxfxXJPxtSRoc7Q8qu?=
 =?us-ascii?Q?kFtq5vya0MQmEWUrudbkIkQh5Cxb9aJmnH5IyBim04IDuFb/76fFPwdb6hx1?=
 =?us-ascii?Q?1X6VzoEG9BpXpdYubLgUUFhNtWtYTWsVZEQS0pmH18nkQ/+Oza+lDWQGIY8P?=
 =?us-ascii?Q?4vMTqpuBeH9adKdzWvCJhkqGj9bLo17Cn6v9oXSjBIWcQW7oCrj+z6tSAIBE?=
 =?us-ascii?Q?6kyBuRuaW0goI+llmxmVVgFmPlrVyNM5FgxPBtumIq+dSd0XGQS9aGb9LyYS?=
 =?us-ascii?Q?OBuaeBLE1aRTd86Lmf7xKSA89MPvZktJacmNwAgfKBGvgnfl0dNT7INcWgo4?=
 =?us-ascii?Q?AN9LodWfPfdEjiBwbxa/FXxPw/lNsg9zbsN7ZBBB46s/hbCsSpepP0X+tlM+?=
 =?us-ascii?Q?LfbVzwLBJTJIiBqH+KXotHHr624wXXfjoQUphe/Hq+aFo/QP5WDhXPfjkfQN?=
 =?us-ascii?Q?PUbPTXXkbkkZ8gaZWVNdHCZh15nI7vCIvP2WochGlNZc60aQhPUHDQcfrIQ0?=
 =?us-ascii?Q?wn4/kx3p44Zw1i/XiVVRdvO+BDJyO/+ehwBMu6uT+Hno6R76LtKhcCOVXwDG?=
 =?us-ascii?Q?76/eclhGFZoAVIRGw6uETTCo22Ig2T1tplat2U03xfDl1GrCfR/7gYxtJ5Cv?=
 =?us-ascii?Q?ahe9JADTRVmxBuzPXAhmdJ3kLJ9e1sbZVWU7t5+LXyeGNNlnv4h42mY8Udbx?=
 =?us-ascii?Q?7Md2vVIVh1ZWHxPPGe/xh6HE8gRezPzrdSLx55UDTGQ1t3WTEsd1qjKALajv?=
 =?us-ascii?Q?j1vYJLVeeXF2HYQYil/e+i7kGfnaDgchTA+PsdjOjTKZh2HMisShtcomL4zA?=
 =?us-ascii?Q?MfXcCjviSZQPDVaE72xc6oPNWI9doKdiie4Hvo5u/4pLjXMyLa2dOKLWQyy2?=
 =?us-ascii?Q?FoW9+8P7pJmfFWaBqmRx+377CsRFBdU3crgLnIRMdpsTj7RynHAgHFfcR8T3?=
 =?us-ascii?Q?sEz54TI2Mx71o8xqgt0s26TZ5D2erWL2achQG2cV/bqRTHDh6ZA+9y+wVBi2?=
 =?us-ascii?Q?mE6oaxVVfQ/N6NeTDoT8aUuEY2EfCPOXwFSLvli+C4ElqIFVi3HV0ODdXFSj?=
 =?us-ascii?Q?tldTzrrJtUqurzEsss3CGxCceW7AqrM8+6Aq1V8LR54QWBeV1JZoKUVWvxLr?=
 =?us-ascii?Q?FF2x/OrPjIMxF+KZ4fevJRohJohSotlP2GBImydJQr2/5r+pE1YwxLf65aBs?=
 =?us-ascii?Q?WJPQaRmWAf4rD6th4p8KWbgECx15WODJ4xAllco1IS+8TskBzCVfn4hVTlsd?=
 =?us-ascii?Q?VxUGLrRF3DLRYfDxoe5lWI7T92choBtB3b2qv01OjVRoCvXXP3PyUBKnhlHr?=
 =?us-ascii?Q?VCrpeY2cOWwPFYnIGP/0dYKqP97nhAvzWRjmI9mqaSDhcyoEwnLHicHJF5gw?=
 =?us-ascii?Q?ySNbLASTnqXbublcmht+luuw9yBr2ItP8zPe3PSMdJxwRF4MNjQPLU1DLvVx?=
 =?us-ascii?Q?LAAbCP5YHBUQK1kzFkJXcgGKhOIYYvVmpd2G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zICsDh1dTWTvcQ4MfuHe/UTOlH+b/Bcg9eINFGn9sQFbZOWlT+cZbtM+QmQ+?=
 =?us-ascii?Q?NglJok5Fz+qO0rKpPMixFzGkSFxwqtYL0UzBaNVXSpoSzKBUh1TXz3FkBy2X?=
 =?us-ascii?Q?eLmFZ1DBvSU7Nrb3UWVXL3phbsHahovAHLWUnn0LwZBG1liARS0AUB/KWdCL?=
 =?us-ascii?Q?3fGyXqUjIyTK1t6paVFN1eI1OVUSH1gb/ofLOA5pzWhmDQlqY9ezAm3YK4xZ?=
 =?us-ascii?Q?2xyZS9IkTXRODzJE85I+5KBVySzfWokdtl2UzFcuJd7OpOZRbWQ2kX/H3qVf?=
 =?us-ascii?Q?B3rmKZ2LUsdKihXOop40iAjis4+K5Z8gmoVbqxXmyai4kkigKEsDOQybN7SB?=
 =?us-ascii?Q?Ak17+nDdGC+y+Pns73yfiVVejU1vo4fE+LJxjxp1un4MQ3/MKlsTv1jZViyv?=
 =?us-ascii?Q?Uroa0isoXrvMeMV/OvBjXheAybyqRy4qRP50o5JwU6CqAs+Oe2WPaQVDBbXM?=
 =?us-ascii?Q?dkHfQBEiMDlQQ3xJe/40L0A+WGRMxDZ1/i04NunQCG2xgTibVnYh1zmAKb3F?=
 =?us-ascii?Q?0foTPGjBcKu5X0JXrIsToCsJSaTAV0k6zfAmWASIsniLB+AMvxyqgjkrPzYm?=
 =?us-ascii?Q?UryLIJ0KmDvrdVG9lVwEqT7MULlmOpCelte6mht330wsIVbvMgWk/mDADCc/?=
 =?us-ascii?Q?e8KVhi2gg25W9oAhobG/ryQDRAkPZ+mF4LpvACsteMWpX6aKETeUElCMk0lb?=
 =?us-ascii?Q?ikFD0DN0w6rHRmO9YrmjGbWr2RV5jczNqW+HIo48jpixHsTSnZ7FXJusTnRx?=
 =?us-ascii?Q?PCShh/PYcnciboomthPCEGypsvzr4RA1GZwragg2YxUdYLPuCq4r9u5XEyLl?=
 =?us-ascii?Q?frWnVo/TWEOT2PMXgviBDct78IDiOVzJxFnghzEjZavOkFf2JKBDJ9YTpzSq?=
 =?us-ascii?Q?Y+wFQRhuWD0VJ2ytSvY/sWtgDfpUZKrDKJtEW/9fJirCAd8EosHwO1eXibk0?=
 =?us-ascii?Q?FyzSCXe2GvHVW8PWC01Tm0qDO+QzdFqX24PMixoCOvLmYbnOFb3nr3imk5VI?=
 =?us-ascii?Q?yJRgxaI2jaogij+LtIxuVZSnYOnHK5WZ1xQ+Tp4xOpSnxhdZxfTsLhvUC5Jt?=
 =?us-ascii?Q?vRNZc/rP8+s3fy2tRY4lTwnx8w/x1xUTfU1PkxmFiVMiCwtsMnUwOLZo4UOG?=
 =?us-ascii?Q?oRUOIKwcsWFU/QFnFk+kowVTiE6RgC6L0IHDi7q7OdGKn32hrSUcB7DIhPgF?=
 =?us-ascii?Q?A5sMwquIaMhS424vvv6k0m3su0XQpLPS+fYVo1jB0sQbdMKUM42sJxu+Gjbn?=
 =?us-ascii?Q?duWVXQtPsDIrN84Un1XKlhsm8edtZZAYI6DcBcN2eFXu+l4bEjCPiXyiueW9?=
 =?us-ascii?Q?11XExu9nXqsaqu3H/HKbiB81dMGyr9PnVDNxt/gnzPEbANYtDX+5GPdhfzhs?=
 =?us-ascii?Q?5NEa36eIrO0jzyNHZ8jdiMob6zMfHw4poz/+phQnyz/PhEydCkO7TjqbWQU0?=
 =?us-ascii?Q?Ohm4+ZKR+oElFGqt0olcTzI33L7/piMn2+M36Nh65dT5XWm3VUFnI/Vf3nDQ?=
 =?us-ascii?Q?A/J1rXf7ruBYW2vTdjj0PsJAFXHMW9RC4IX4rDXU1SbqQIRMiGe3NAVF7QpZ?=
 =?us-ascii?Q?3JnV0mMP4LjZoVufywWSe3KXnnsIM8n6wRbnaLuj0jYCarxykymxonuzoHRf?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b840d57d-7cb4-490e-6d48-08de1bc9e3cd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:45:05.8909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DaXBFiOlyWlygfNw1ZPc0dJhigLECMNPhXF8v7JN2iyV2VuHtx2vVacKcNBvTdMWgrXAs0AiWn5wNzJEQ0Pz1ehx1yLO9v/CzWgfuXGrGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6286
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

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 arch/sandbox/dts/test.dts |  2 ++
 test/dm/gpio.c            | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index a2c739a2044..13d8e498b03 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -823,6 +823,7 @@
 			#gpio-cells = <1>;
 			gpio-bank-name = "a";
 			sandbox,gpio-count = <25>;
+			gpio-line-names = "", "eth1-reset", "rtc-irq";
 			hog_input_active_low {
 				gpio-hog;
 				input;
@@ -851,6 +852,7 @@
 			#gpio-cells = <5>;
 			gpio-bank-name = "b";
 			sandbox,gpio-count = <10>;
+			gpio-line-names = "factory-reset";
 		};
 
 		gpio_c: pinmux-gpios {
diff --git a/test/dm/gpio.c b/test/dm/gpio.c
index 34a5d1a974e..0fb05b5ca06 100644
--- a/test/dm/gpio.c
+++ b/test/dm/gpio.c
@@ -143,6 +143,17 @@ static int dm_test_gpio(struct unit_test_state *uts)
 	ut_assert(gpio_lookup_name("hog_not_exist", &dev, &offset,
 				   &gpio));
 
+	/* Check if lookup for gpio-line-names work */
+	ut_assertok(gpio_lookup_name("factory-reset", &dev, &offset, &gpio));
+	ut_asserteq_str(dev->name, "extra-gpios");
+	ut_asserteq(0, offset);
+	ut_asserteq(CONFIG_SANDBOX_GPIO_COUNT + 25 + 0, gpio);
+
+	ut_assertok(gpio_lookup_name("rtc-irq", &dev, &offset, &gpio));
+	ut_asserteq_str(dev->name, "base-gpios");
+	ut_asserteq(2, offset);
+	ut_asserteq(CONFIG_SANDBOX_GPIO_COUNT + 2, gpio);
+
 	return 0;
 }
 DM_TEST(dm_test_gpio, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.51.0

