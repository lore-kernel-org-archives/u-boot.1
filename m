Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04656CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:09:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5395846D1;
	Tue, 26 May 2026 08:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uTfA/A4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5D584671; Tue, 26 May 2026 08:08:47 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38C1846EB
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7Tp5cDZcQWTk/FGUPwlj29diKbV6NrAsdsWTYXeQE3HPJbMWqeTBPM9e0v3poSlfcL2bVf50FxX29adadVBZNlqNIMUDEmr4jFQhh2kn6vh5/6G7eoYmYfBVVFr2D6666fbUN94i33NZheF4s6z4fr8wizlIidNiPCVmnP3r3FaEUedcpc8jPFh8FbF43887EQ2mbO0sWv5kgvVJ14Y0ZVgHiFRnfTfsf4xt/i2V87uJCFthoVItYGBEdHpwoHZASxCU7y6KgUgrbRIr7JR8vVnESVP1+dX2H6tIrollSZLnZjvbbV9DjLwNj1kNtYNF57PdEIxlOSbiBGb8wiaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6ep+huhbbATQA8qsRhurrn02+Z3rTd41BQjtqDoOdk=;
 b=YIWiCxpidDEa8KWMWQr9AsVgy7S1bnKsU1ZcKlCoyf+m5ypbLMjYlUllZVDA4PXWzIuyH5T2Fpx2aARj8WfQ5luy83XXw/vUN2iPpaVkl4NUYT5hzPlwvRDZs64tRlR7Hrjd8HKokFcNBf4rCsnY1EoSLuI3CFBScEr2uoNtmJlWDas07+cq942WB/eWpV1UILI6UA0fRYyUd3kl6xpSpd1lCxCl+KW2rpfd4idmTijxC6dEph1TR4XERmeJ25uUomhYr9Sv17CvGfobbM+G/t34C6oa2xW2xd0xhWCogLvF7V/bTqGaO8d0cQzjbAZaLrfr6q2DZM2lLYE/p5bSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ep+huhbbATQA8qsRhurrn02+Z3rTd41BQjtqDoOdk=;
 b=uTfA/A4zhGzsAwhzII9NEDCCJvtMTjLL/vpqm3R11aw7fTSNXAJRayZa0YE+S11N0b3+fOxn8pfW0d25aIn7ikflF+a/To2ronC/v7kVt/cIpv9DOKjFpiT4G09reX90bP/ueMrNQywXlJLez/7F0enNVT4BC4OUr5kH2lUEk/0nKCYh5w7nd/ozNAXdRwHN8A3vjuf6zaAIcFzFIUSfL1ZALHjZIXwCku+sqGhbvgxy2fzxSyvgi8oiDKF2X2uho64t9ddAuDcycXBpCW4r8xDcuhA/pd4ToTMR/6tzy4rtZkr4Yw46eAAkwifwa7GQa9isTgU4RQt2oTQjcXJPZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:08:44 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:08:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 26 May 2026 15:25:14 +0800
Subject: [PATCH 5/6] net: mvpp2: Use dev_read_addr_index_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-devfdt-net-v1-5-be3597b85b5e@nxp.com>
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5P287CA0049.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8109a4-8242-4cef-6a12-08debaed3dbd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|52116014|7416014|18002099003|56012099003|22082099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: k6pspZWgtYlRjGjaKqqKc2BpTncibMta3bRG4UEOovmcRHzEIYnaU6uDuRyAJtwDLaoJ6ajpSRQ6mFCnGqduF/lVyPfoI4bXluAfkw0Myecx3cq6gmpB8JZWBu7ZIg1mSmJoimFln6FqNKWduLXB+2dqiMYi/XfyOCs8UnoubE1xgXbgN5dcVvNqkjxAIf+0NHcjK9MbWOoAuMbiJj/Te9rLOFiOUv0RrokxGKhDBK8/VdRqiGCdz5ezCF+11895QDoXRwZB4r2NulT4LSbZZWeKeh3WhETmiwDKXt8vDBa3+CtpurAezjBCP5NoT7PxlbhEokeqLPyffabSlhNiCZXJ8v6sSVDC76AddZ8vOfZRgfSC1QgJOSa5xBfiZKsHkIraJjlghuLub4ZZZqmL2O/XSGM7At0yzGmCjs2tyAX5vgfD2WJ4RgAxqwTJj/Mse+s5BzAmdDInDaMgHzi+fs5W+kiO0NRP7T2i7YeXvb27fem9gB1QnwrPB4mhzgqBl6vCQmcEjkGppbN/VKubXeF5fJ5eRJLYYyEl9pmc7Y7v60fnZ1hu+nvXmGPyyvdGqLUGVQFOMZPHCRj5+yUexiKEdop/V+I/t40G2wiIcCk6EFlIoOqKcQga/Iwyu21jpZN5nURZ9vhxPfLXIscq1Q5sgE7P/Awzd1JXEm2EbkgxzcYmqx19hHH1aRRKCoO1go/mnoXUU326eqTaCOCMqc3FwrUo0L9ZrrroKCHTjIJG2ayLpyfCObr4I07lO9K3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(52116014)(7416014)(18002099003)(56012099003)(22082099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akladE5RWHpPNk5qQ2F0Mm0wZG12VmlyRENHVlFTUUVtamtwa0xnazhNU0xR?=
 =?utf-8?B?MElqbXRmRHVqeU5vUXZaNWpzcmlPSHFPV0o1QjQydDVpbC9sREcwMU5TRVMv?=
 =?utf-8?B?L3o5cndBeEg0cEEra1drTnlUa3d1bUJaYTg3a1UwS0U3WHIzN2RDc21zRkFr?=
 =?utf-8?B?azJkTkRWZjQwQXpRZHRqbWZuTk9FVVd0VkhKMjBNTG1INDAxNmgwdC9GTk9p?=
 =?utf-8?B?MFpKMEN3RERNMzVsZVprWjBCbXVVOEZOV2daMTUxL2VnSHJod0tGRUVxQ2Rk?=
 =?utf-8?B?MEhvSldDUkF3Y05hczNOWitoR3NBaUdKWVI5OVZSY0VnV0pCVm0xS1d5ZHIx?=
 =?utf-8?B?ZHRickxuQkJyb3NsM1pFZkFQL0NCQ09SWXRuWlRGMVRLVkg5ZWpNcmt4SnRh?=
 =?utf-8?B?dkNlUDRhWnlqTHRST3ZLTEhyeDVQN2VobjQxUUkrL2k0RGFOTzd5S0FZWFl5?=
 =?utf-8?B?V3lzYmp0UW5PNG5oRFdTdkFHNUgvV2U5ZVNUSndNZVVDZENaYWFBYmpla0hH?=
 =?utf-8?B?L2NsTVVaaTEzWW9iUVYwd0ZEUENmUzhzR2Nqb2xabXZDeGMzRmhwZy9SZHpv?=
 =?utf-8?B?Q09KSzVGWGNlQW1sKzZqT2lyRGk1K08xcGRVSDRSSUcyY0g3dFNuM3I4dE52?=
 =?utf-8?B?TzBkWUxKd1dpWEZKdmwxcGdSYVhMazVUV0VTTmFnSHhXQTlyUTJYaWttUHM1?=
 =?utf-8?B?eWN3dk5jUE81Tk16SnlFUnd5TVFEUHFaaEFiU2N5UVhGakNHUzN5cHQ1THVQ?=
 =?utf-8?B?M3Y5Z1FiSUVPL3FUWDkrTnpFc2FyT2h4aGpQQjlFbHdzOWdwZ2hzcmliamtm?=
 =?utf-8?B?RGpXWnFuSkc0cG9zZXlGanRwVy84VTBEc25PNytxK2ZhaHBqeVlLa3pDVUds?=
 =?utf-8?B?anRrK0RuWmtjQUJGMUdEYkpBMUZnWlAzOVZqV2Vua0V4V2hGS1pKenA4cXIz?=
 =?utf-8?B?bzJhalBaSlM1NHpCVHRoY3IwSFI4bDI4RzFma0tsaHVvVGJmcTBSblBOazJr?=
 =?utf-8?B?c3FBZlEzSkRxMVd6VWVLc1RGRnkrT3laUkt6ajhaTEw3ek03WmIwMGJWWE44?=
 =?utf-8?B?WWRaMnF2VE01Wko5RjZObzBGSWhMZ0pxUDJ0WDZVY3lrdUpkUHdrdWFZdnVD?=
 =?utf-8?B?WjdQWHNtbWRUVzM2NldjNTMyM3JmbzlmK0xpME1tRzZSOU93RE9yYmpYWUZU?=
 =?utf-8?B?ODJJNmZVcDhqTDdUc0RWSVhQb0M0TndJZjd0T3VDRmlKSlF1UTg3YUd3Ym0v?=
 =?utf-8?B?bTZSK1lvaXQ4d3RoOWRCSVhzc0Zrd2RJNStSVHMzQnBoSVhHd3JJcTB3SjBK?=
 =?utf-8?B?Rmx4blBjZ3h2OXBGamlGWDFyZUZOM2dYdFlBUXRhUTFzL0RHQldzeFJFQUF3?=
 =?utf-8?B?RjZzNEJBNGhGakFBWWUweFFmMXM2NWhKZDVURDIydEJkZkVMMlBXS1g0Ti9U?=
 =?utf-8?B?VzlBMmxDVW9BVlUxa3d5QjZtNkw3a2tkQ2h4bTdJZDBWMzI0WEpHTm1PQ1VC?=
 =?utf-8?B?RnNTbXppdzc3eGpqWUw2N3NNdXZBZ2gzc05iS041TldiQnJKWUp0RVo4S1JL?=
 =?utf-8?B?TlNPWlhkY2lNSk9YRUU4bHA3bWFUU2lMb3dCSjhqQk1hY01tWXhlWkh5akNZ?=
 =?utf-8?B?NUw4cDRJUkNnQTFNQnVaWEFjNysrZVpvbnJwZWtCb3BpOWlmTkhKSjFMbVBK?=
 =?utf-8?B?R2NZWk9wQ2JDNUZzVElHNkVwQ3ZyZzhYWnEzU2x5bm5FY1VUbkpXUnJxMWMz?=
 =?utf-8?B?ajN4eUlRUzQ3RHc1akNOZDhvVEJGbzEzalJSMjFNME1FZm8vU0JGa21vUFFK?=
 =?utf-8?B?R0J4U1ZOYVZIV214SVR2SXN3WFNZYmc5ZVBabjRlWUpuUVpoZjZmUVdyNERR?=
 =?utf-8?B?R2JHOFhaYmdRWWRVYUw0Z3pvM05BYm5wN1VRSDBJYWxaTW13RmdrLzlxcUFu?=
 =?utf-8?B?QXdWblYwSm1HOEJEcHdBM1UxSTVJdzM4czZQTGRWRDdhMHN0cm9VN0xDWUE5?=
 =?utf-8?B?RFNNeVFuSkE4LzZlM2ZhajRzRWMxclowa1lxRjNTZDZJWktndkJTd28zcUsr?=
 =?utf-8?B?K210QWNGWDlub3lMRUc1dVlzRmo5cGtnbmZBeEV4cGY3TlVyWWxpeHhqbWRu?=
 =?utf-8?B?S1FjRm4vUURUVmR1TzFnRENWTEsrU2Zwd3p5MXgraktWL005MXg1a2s1OVB3?=
 =?utf-8?B?ck9qWXN3MC8vdm9BNjdRaEVJUVRxbWNIWnFFTkpVQUZJVzBVT2NSQVpibmlJ?=
 =?utf-8?B?MEFrTitNMVhoVGgzSVFoazZFOHk5alBmSnc4Z1dRZm53YWxLRmh1OVFwYnZN?=
 =?utf-8?B?aytZb0R2c3UzUERGVER0UFo3TDJYaHNFWk13OWtIUkNiRjVwVkdzQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8109a4-8242-4cef-6a12-08debaed3dbd
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:08:43.9997 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3lvA7bs0lN1t2GrBYUmZkC2fjmcfoT1RlAtqS/DC+JE2tBKOo52Mzk6qmm8DApghZ+qr4w1Oek8NPCx4sRNqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098
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

Use dev_read_addr_index_ptr() which supports both live device tree and
flat DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/mvpp2.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
index f9e979c4d58..193f82ea07d 100644
--- a/drivers/net/mvpp2.c
+++ b/drivers/net/mvpp2.c
@@ -5296,16 +5296,16 @@ static int mvpp2_base_probe(struct udevice *dev)
 	}
 
 	/* Save base addresses for later use */
-	priv->base = devfdt_get_addr_index_ptr(dev, 0);
+	priv->base = dev_read_addr_index_ptr(dev, 0);
 	if (!priv->base)
 		return -EINVAL;
 
 	if (priv->hw_version == MVPP21) {
-		priv->lms_base = devfdt_get_addr_index_ptr(dev, 1);
+		priv->lms_base = dev_read_addr_index_ptr(dev, 1);
 		if (!priv->lms_base)
 			return -EINVAL;
 	} else {
-		priv->iface_base = devfdt_get_addr_index_ptr(dev, 1);
+		priv->iface_base = dev_read_addr_index_ptr(dev, 1);
 		if (!priv->iface_base)
 			return -EINVAL;
 
@@ -5346,8 +5346,7 @@ static int mvpp2_probe(struct udevice *dev)
 	if (priv->hw_version == MVPP21) {
 		int priv_common_regs_num = 2;
 
-		port->base = devfdt_get_addr_index_ptr(
-			dev->parent, priv_common_regs_num + port->id);
+		port->base = dev_read_addr_index_ptr(dev->parent, priv_common_regs_num + port->id);
 		if (!port->base)
 			return -EINVAL;
 	} else {

-- 
2.51.0

