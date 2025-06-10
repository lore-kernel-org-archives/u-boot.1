Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E0C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 04:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA0882B48;
	Tue, 10 Jun 2025 06:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="XdIzI0hF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DCD8004F; Tue, 10 Jun 2025 06:51:07 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A910801BE
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 06:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLYHDYz4TTdplNHaIveYjRKjRyNnBU76SXBzDbWRP0nJvBaiFLrdJED97DJpjVFwChCfnvDCOa1pZt2OxqSZiO46jFPaqwxpmj75e2RBl1TL6EZsna+2iAVS0xaNMTCKnD2tgKoYSKUagov8bc0QbIlpTedLsa0JV0liKlkNZ4sTiLPtRtZlhqC/y4w/smCZt3mH9cN7wkmEU/Ubat1am2bVJ/XgS2S02lYX+aPGraaUnJPxpBjMx5IHD8tg4ev4im3dCmLsmLNBrTPTlOW7JgCdX155IE85P4hmjxDPJ9iMEcLSL+TpP86mCIdKxMipOE1SSpcKaa4UGCt7grmDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbljTcmS3UGM9lIhUMPz2Yrsr38HFrNqK1n/j2Ca/eA=;
 b=m8Bmp2OzaAwCEUp8nVKqtq0Zc4gG3jsnHxSa0usMOry4dMXBdzfmBBOtBlW1+sAvGeqHfjoYrxwTjchClQ4wEEZCdn/cxpXOm7Pw0F3zKf3AC0H/JKO7YVE2HleSO9+aWhYL//gtlPYDMtwGJORjXl46hb7M1r1nNcSS9Avldc2tvfPdJ7vfNjJiAlhn2lgM+xvq1R70LIV9JsA2FSyV9vqHAjOIADMGtV0DJQhzXz3OXHWFQ9WD2WBQEiydL5lgedf+OBYJEGz4J2N69Byio3e92iMpqxbEEJt27GKekHMA9rMm29/WvqautVjXbT28+WHVxQjtDR3pe9r7ED48ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbljTcmS3UGM9lIhUMPz2Yrsr38HFrNqK1n/j2Ca/eA=;
 b=XdIzI0hF4F3QsN/ev+H2bhsiPPofOH+dGWtQXY7+pcr6fIGwqhwkBCx6pkNUS1Xr5Xrs2Qaf4UCPXCi/5KIKJvlnj4HEQnTnHxMb/A3299529QK1FuCps44p/2idY/Q5KvaZJfZMEK8vmL6i2Q0tO3OMUiVXSTy39KuFSIbV0VFVXWAY2BsmiWvl2gDuyxs4BJBmkcVmhuOsqrzZFSd9ejBi/tBHjU+fkbYlfMBcqy4yNbyop7PxwXzyUwOEhnrGK0n58qBLpD/jg9O/JeXQtV+jdloJ0srFAKqGbvpaWBeZAs3fft+kmnI30lggV6nmvswNxZDTQDOUcA7YS0fGiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU5PR08MB10774.eurprd08.prod.outlook.com (2603:10a6:10:529::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 04:51:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 04:51:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 1/3] common/spl: fix potential out of buffer access in
 spl_fit_get_image_name function
Date: Tue, 10 Jun 2025 07:50:52 +0300
Message-ID: <20250610045054.1038235-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
References: <DAIKOVEG1GGS.2LH5IT55T3CGW@ti.com>
 <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0001A03F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::484) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU5PR08MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d218a70-d4cc-40e1-80d2-08dda7da66ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nGwDLQdiXPfWmO3okjmMgNipWFMYD5hCePjoY1JhwcL+EQ+Pc/wup+ry+c4X?=
 =?us-ascii?Q?0/WeQX9yhxcNacQPBUJCJDNa8pW0paJPU0hhPhSW1J+28RJXrb5pjHUjtL5A?=
 =?us-ascii?Q?EKom1c7SiP6LsQPVyeQADGrcQ5hlVI/fSpFEVRrjxL00n1oOeObSGERQ3Q8K?=
 =?us-ascii?Q?s1UwhwtH70FmypnBvy8MqpZwCoLWrVgZyi0kJ2sHSwK4ipKACQ2UGWihBJtj?=
 =?us-ascii?Q?e6+Qvwh4ReO+EVaMVjbgV5tRuhvT5035clrbLPOdKyc2UKv0o3cKgMZ3jAOo?=
 =?us-ascii?Q?90TQqfMtkWyX8uiiBB3pt0bzo3L9LIU2DvmMTLlToU4z3sM1UfvV8o8r5Ts3?=
 =?us-ascii?Q?GpqhZCGR4ssS3lW6nohMk4Fjk4qCRfKP4E7eD3d1DXUnrEhmXXLpoqw77Sjh?=
 =?us-ascii?Q?yKKp3qTUQeVwMLyDIrqMyPR7zly3QCS7fXbvHPoTLmJbhSf8pxffDueoK0l5?=
 =?us-ascii?Q?tYrBY3jxPgJAqPulUK+2V+CijlXs18I0Bi5BNmszj8XQzVeQ6+cx7Gi80PJI?=
 =?us-ascii?Q?h35bb79A/jphfE4J7zi3OKBAr5uujyGPXPeMgVf2gq/cESOHe0ykRY1lGiLn?=
 =?us-ascii?Q?9/amNVfSOPtyPSYFT9bsoHPL4CO0P5xCLV7JiQ3zpoPUzar2bbqPGphuJ+5j?=
 =?us-ascii?Q?vTauyAUdMM+6Szkvf6UNliGK2MXANmOvK9jCen4yotABdsUj23ikK2MyHXiQ?=
 =?us-ascii?Q?plQAi7gOR0ebDmsfYSuQIlko6t7z7BsbU3VBX67cry2Z+WRt9iu7NxdxrhWf?=
 =?us-ascii?Q?GMTZDAoxfR72VZMIs4kOh6ZHLJcZUf+tCUqNFPh1WcATTVHcEUWOyF+jDY9e?=
 =?us-ascii?Q?BEOzB5ZNfa4rX5QPQO/Lckk+gfzx4dPnKNBDlpznCl3d1RoY+ZWUg5QGSjor?=
 =?us-ascii?Q?NFIy9VPfkC5pjasqGKtNPAZ7iV7RMUhvqZhGM+F/7J3d1fWD5l6Rw+1d5uOk?=
 =?us-ascii?Q?Vjxfr0tySGguIiDXe5C3OqG5UUvpiEhZOj3IPXWrkNrWK+HU8YMAYliLGddo?=
 =?us-ascii?Q?2Dzf9W7v+VsXx1lxbLAPu3cvkNAM7gVTn/PmMmotd5Vm1uEC7Mt4n1wI7wkM?=
 =?us-ascii?Q?/vyMfis64ReX4rtXH9u6Ewlsw7Y8eqiV5tV3U1jbc4/7V5QCgc3zv2vBJFd+?=
 =?us-ascii?Q?KBYtuMPT1LbPeYfv8mL29jkw5eZtrrjiIMrnL+86Y/piVvCHTQ4uMMP7Dw0f?=
 =?us-ascii?Q?TSXdbbmquhKaURpjll919sCfrSpGe6ep9hv6pj5A0Y8K6dIBNHetqKTK6PRE?=
 =?us-ascii?Q?+S2stTkjX6IUVQP2OtGcB1XipcK4xhrT3iO9EJamCj5SM5WRznt+moW5LWZc?=
 =?us-ascii?Q?IjBCsGn40+jLIStiofUDZOQyO71EIw0sZmfWi6gv+K+ojeaUtUTW35JmjxY3?=
 =?us-ascii?Q?wGZQQo7KjjoJWI9synm5IlaJlT3kLHRQU5gTAmCQDaEVh6Myr5UocNcPEJcV?=
 =?us-ascii?Q?IwyazYf4pG3oQFmLfiUT6psyJPt6ipSXp9mLDniB7eLIknEaKF0v7Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KfFpcHr3TKoaXXtjWqQ5dHMbPI9NVR6D68NpVZUOlbMafoCS/Ejg/yrnbcCl?=
 =?us-ascii?Q?5payttXjVeKeNG59baB0Q6+uZL26LYWDtDmitAt2q7pZ70bvJrfpTPjnc+hn?=
 =?us-ascii?Q?cLH1Dx5GfSIc4FnNYAO6I53ZjUIyFT2geV/bLb7ruL8BTVCICDBrlV4dylQP?=
 =?us-ascii?Q?jSi37zz+MHXr/UeIc3rVFrC104ycUr0CgJMNbWninwIqYJ8xHlHh7GVadyoX?=
 =?us-ascii?Q?YoTWZICAIXczYgNl2HrWmtL7fhEVGpfXss2NslHvATjZsYagzqUSi0Nin8tm?=
 =?us-ascii?Q?6gvRY0uHUc4koRc5dK/0B6l2c9Ttk7nS+OJL0yOSKXs1l90eieW5nR6nTU/E?=
 =?us-ascii?Q?gPP91Va+S29FBSTAVl9DYET12Y5tKNZ55bxrKhRWJT7DlJ6FlM//pL5btaFh?=
 =?us-ascii?Q?mRog+2tThyQfbA/QjP1eSzVt5l9zKVvJXAojYv5lH9fe5VcmleusKEHaXeJx?=
 =?us-ascii?Q?iuSJZD7bothUfdwlO8ht9Va/KyKO9W7XROc6B1PZEbtlDq3BtTCAAmIrDEab?=
 =?us-ascii?Q?YqW+X6qrwTbuxXiFX5CuS2peU3fdQkEGnvDIO39jqE4xJRiI2wHR3dvP8Ibo?=
 =?us-ascii?Q?QPUU2owaDqownHZLkGSjYFnHFZk5/050cmMNOaL0WClmooFqis7D/Mk/zS5b?=
 =?us-ascii?Q?XQxxzE36LZDFq4H8kSOX4ug/TMsNg8kT09OWVhY0lTrPABpFCAJcVIHqgtBx?=
 =?us-ascii?Q?8AJpUYiuxv0PI0Hf7kEr6SsZ7iOCVAhqSGbWpSKNS09Rsa5HAHCqvsrooCOf?=
 =?us-ascii?Q?kYu5xq5UWt1YQOQ7x2AbLCVer+LAd5PWdYNFs4B3RsvkxDIF0kg63KZdY24T?=
 =?us-ascii?Q?/Kr0rRIG4Pxre5Eqj+7Jth4psRboMZcfOVUPskScHVL2yVgZdDtuGlGcG43C?=
 =?us-ascii?Q?KbID1tWCS67Ip/Fn/iFrihkYcNcYQIuizA+r3tGWcdYGS/UaIN6p6ODonAFx?=
 =?us-ascii?Q?+wAQdL3Nsz+UbuvygUPE2S7K5hJtSd5l7m/sIXl9vZOqJyAhRkFjoqTTqsBq?=
 =?us-ascii?Q?fmv+xv/R/MNsCdtTvasU1TlxN/8RWwpMrftml9OWo/1ChKNoY+RO7Si/kzkt?=
 =?us-ascii?Q?/fWIYd5WaekGykF4woxfbplcxOSjHw7fvAuGullNIWXdqJ1k7XgfOYbSJr8x?=
 =?us-ascii?Q?LhycULi3bN2mjLnkYudThhxkp+u+ZIKLgEpfz6wQQwZxci6wp6PMOO+MOOEh?=
 =?us-ascii?Q?RnN4qGRii3BOif9KvQAUMnOVSJwgCjood2MLZbMkyp3YwZV8ZiA7uIamlXq3?=
 =?us-ascii?Q?MTcTUBuaRF6fxgZsCa4uG6zQ/D8q9XLtmWDXYuiwpgrO0+8WZ9ywID8TyBlU?=
 =?us-ascii?Q?W7MNVvM1tmTT8PIsUCXD4sJLLVl+XKYAlN4n26uPenJV5CQ1T2W2og7Oyy0d?=
 =?us-ascii?Q?QXJYFpB3NRTxIwLkyYwdtxDegmzNcZ2rt2qo3SUkyZcAhQyqNIHLRAvIbuG+?=
 =?us-ascii?Q?W7XtAsxzUIY4n/tVdCCUC1Q73477cQm/scnC0yMGAVG5RI8UyTenKdl+b/RN?=
 =?us-ascii?Q?w6KX/r3J4NgfTSie2uBpKj1GyIrLfG3mPdvprVPRXyRRKz3y3NAP489teqy4?=
 =?us-ascii?Q?DryG94+gs4FYhRSYhF3XuTbABACQEyAIg+06qgo1fzLQ3vQnvMo8SvJ5dZuo?=
 =?us-ascii?Q?saVE4sj91WB3Frz1I2K4ISg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d218a70-d4cc-40e1-80d2-08dda7da66ca
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 04:51:02.9458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSEZ1qrazjkVp8fTYUIK8VZ3EcSIq3NO7DaqYCDZr5FlAgYYHYBnmlsDFN0AKnvOQzeo1raEfvhyPeo7FnxTil9dtgRf2SU68IfgDyb0HAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10774
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

The current code have two issues:
1) ineffective NULL pointer check

	str = strchr(str, '\0') + 1
	if (!str || ...

   The str here will never be NULL (because we add 1 to result of strchr())

2) strchr() may go out of the buffer for the special forms of name variable.
   It's better use memchr() function here.

   According to the code the property is a sequence of C-string like
   shown below:

     'h', 'e', 'l', 'l', 'o', '\0', 'w', 'o', 'r', 'l', 'd', '\0', '!', '\0'

   index is the string number we are interested, so

     index = 0   =>  "hello",
     index = 1   =>  "world",
     index = 2   =>  "!"

   The issue will arrise if last string for some reason have no terminating
   '\0' character. This can happen for damaged or specially crafted dtb.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 common/spl/spl_fit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 86506d6905c..ab277bb2baa 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -86,11 +86,12 @@ static int spl_fit_get_image_name(const struct spl_fit_info *ctx,
 
 	str = name;
 	for (i = 0; i < index; i++) {
-		str = strchr(str, '\0') + 1;
-		if (!str || (str - name >= len)) {
+		str = memchr(str, '\0', name + len - str);
+		if (!str) {
 			found = false;
 			break;
 		}
+		str++;
 	}
 
 	if (!found && CONFIG_IS_ENABLED(SYSINFO) && !sysinfo_get(&sysinfo)) {
-- 
2.47.2

