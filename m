Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD698C19F32
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 03:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29EE980F70;
	Mon,  3 Mar 2025 04:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fptB8Ilw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60D5981115; Mon,  3 Mar 2025 04:01:21 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61851807B1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 04:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJSPUKDhs84svwtKfenh66iVqraRcA4+9XjDzY2he6rEoSI/TlQ527NCRIHlLA/jPhh56kiP8Uz5d49IvdAUzgV+iK3R4unXxAqVhv1L2hYr5EOWBwuT765YqFqBxmZTtdq3yppXU9XXkddJj2kfaR9a04Ld9ADC+YE4YcPpx3/RHVNkn1jugQ+0XmOCAcaEQ6z1YA6470ziEgOAmtvRhiYsRa+bXVdJnmiHn6EVjtOFi1Q4DsoIl79TThvKYE5cIQN0wa7cUKm3BWn95sYn5kN5vwcO+MEEQ+nV/Tf+oF83G9LdHHnYwdHA5MdBNqVEmEEeTJqXp+r7wqtiPUl/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpU6uJU75lVRDBANdArjE3c9Ysdh+V/hfG3M3tS3BL0=;
 b=OazRImdm2ZMiLU00Hwu1geUk39RC/tJXkxj+KD8vQHAbodl6F7CUfgMPAVjewQ9i7Dp7gEsbQgAvJ+/JmWSA9rGYkeAizBcU38uXoPUFxuVkGF1F0bcfcVgWUYWoEz0kYbfH9W1e0FpJpFAFxhJiLV2LJ9tPvAdonldjzln9dBUsLC7ikyTY8M4CLeEvXMvCdO8SqSKOPpMaVc+JfR/veddI8IPNQFNmhjZIx6HNEJub9F9tP7Oe5P/IhOqOLeQsA+SEa00nc79jBT9HaoCEtVKWiCZWBM7t9+YONYLrQAkma9B81x28nywvlg/LvIazyFiyZ1moZmEggbKUjey5pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpU6uJU75lVRDBANdArjE3c9Ysdh+V/hfG3M3tS3BL0=;
 b=fptB8Ilwc55ORqhO67fBurEUNgjs7S0PkYYHOqr7xYInskelf6Dz10TrgEcp04NioPKcliDgi7y3noTgsthwgs7Bdcx9WpkormMYTYHqZqaES5fqnjDbjkHOGOXfkGIn056yYAFOgPgOXMVwubIc/jv5sBxrk4PayK1THmIni5bpirvrpxYLeTTCSnNDD+eOO3g9pt2lJU996Os7WZaq2oVWpeXTEpNsLyJmCfw6Ls/9TJJvZJqiBUcmqhXpW0ohcHpOjdV7itnlx9++BWlcjJJLXyVmzSgz91Yl+eHboJNBpXgr9NWjBU3NiZlVzO/zxXWT8Gj55iU143CpHghXgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 03:01:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 03:01:17 +0000
Date: Mon, 3 Mar 2025 12:08:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: j.ne@posteo.net
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] powerpc: mpc8xxx_spi: Catch bad chip variants earlier
Message-ID: <20250303040838.GB13236@nxa18884-linux>
References: <20250217-immap-size-v1-0-f9be2e9e7b1a@posteo.net>
 <20250217-immap-size-v1-2-f9be2e9e7b1a@posteo.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217-immap-size-v1-2-f9be2e9e7b1a@posteo.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e50200-8883-42d5-30cb-08dd59ffaa10
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?0mMqzhRMOzrowp2uiIYC2C3DUZex1Et//pPXQRLV+FD5feDjLvIU2+yi5m?=
 =?iso-8859-1?Q?pYNj2KTkGYQUklj6b6v7xKQsk6xBFkwXiuAi2yMajIgXcrRxYpKiAvQuvU?=
 =?iso-8859-1?Q?nu13eltjFLIDFQ9vzwirONgq1cIHhMEjJIzUr7UCdmaesgewdRaIUiOvLd?=
 =?iso-8859-1?Q?N9lhdQzM1rMkiCKqgepUV9tYHLp2yAu16xgN7GgbAa7ttqqzIsjERUWHKz?=
 =?iso-8859-1?Q?EN5dCgAyIGUmqqvM5FPgVr2V6lL1kb5/dRWyViqt0xEWTrU1bC+noziBhk?=
 =?iso-8859-1?Q?PqNm1Rh6CcC/DCuKYCntDo9WLw9lacnfnHrpJSAFMXhrLbOzFyewpmT0fH?=
 =?iso-8859-1?Q?OkTJVmxscAAeK6ULt6p/VIrodOzxPBIYP7tYjHsc66vEjSeAIxDo3DIt/C?=
 =?iso-8859-1?Q?cSV7wk0dw/MkjmdZWoN6Dazwcu/QSh4S5xKYDZNVxgWEVgu6qlOtO3vgSv?=
 =?iso-8859-1?Q?gb/QR0oAibHeLEGSawnUrNkaFQwWmV7a3IjHEB3uGlo2VnkpCdKRjpX1sr?=
 =?iso-8859-1?Q?QWAH4Hp6lmBch0zJm+U86q3WBm/NfZzaIo7N9tVje79GlyFLORYTfRenTc?=
 =?iso-8859-1?Q?aTlQVSw7wZ1wQQp2N2oxquGjM8+5aNuCWdqEtiDPw2cjEQN7Iwl1Bmkz/M?=
 =?iso-8859-1?Q?12T4+BC5HJnHC2SHaDNAwGiqjDO2WjGkCm3WbWKrz/2nwb5OVHxXtLgOb/?=
 =?iso-8859-1?Q?BvZG/OLfu+NP538510cezD/D33+jXTSiKzEYp+o2Lj9ToU/7TgPXQSg0jL?=
 =?iso-8859-1?Q?xCgdcWUOBkGsoWqsXArM5BwFw/4CJDDYcfMolHDEftovV9myfWsBad7Zlo?=
 =?iso-8859-1?Q?8sVh5mR8sAurhkPUaTVLF1NBn5lev7d9tDGfPtmE+ZpX46jkaiJL71x1BX?=
 =?iso-8859-1?Q?HDHG1sCfrZnqyDV90c0U84881YrMAfq+c5aZOzm9dJ3JjTF+OkPadrkLO4?=
 =?iso-8859-1?Q?A0fwdMdWvRQeXDLtmWa1yuErucsBQhssq1kOscrJFb/yKRt7XIlYnJEUQf?=
 =?iso-8859-1?Q?DgdwMw1xfBih7xDlZ0K2tEj39qhpXsgF5iI1DMTu0gua9Vy0feQkbJugbq?=
 =?iso-8859-1?Q?SlRP3+YNhkt/6gPgUF8fDl3/eJQJAh8q4xoJpoUIP9K0zfDlmnI2x5Vxr+?=
 =?iso-8859-1?Q?gUSGEjo7vOBqAsCyo/7DIuZO5BMKVSNHMSTlvkxkmyEfyMkN5o9CNUVxaR?=
 =?iso-8859-1?Q?cf3Ud6oh/YmB+wfb9Wc+Q54YArhWH1ipWOrxs6Qy5ATnaAgRp6pUCfPSm7?=
 =?iso-8859-1?Q?4TPrAU5h1AnDX9kMFYBluzZvgcr2IArjYpyGhbt7BxNb/X4bWzTbT8mtXp?=
 =?iso-8859-1?Q?miG7ce+HsrqxCxYfq1QOccar8imU0mig66SansQoH5tSdPfCmirSGfcMkD?=
 =?iso-8859-1?Q?Z0IxmY96ExtjyFigpckNA3AIcXeSTsmsI94shJ76r9Qmth2pB9iPaLyoAT?=
 =?iso-8859-1?Q?NHbAFq2ZS+kJH5cMjiizHvd9O6q05hlNQ7rUNFXWm1FLqRv3yZu+aiDKfg?=
 =?iso-8859-1?Q?BkQBkr7J4AS5ugO/T56lUt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rYd1k6oFjwjRwR9fMGncnNV2KwGlAyRG4XkOBS67XjZxRUUNov7IbuC7Nl?=
 =?iso-8859-1?Q?Ajl+krQSsyt0EdOgLVBHkP+lDyt7JPMIw75u7PVisXB1iKlt2qpYKCUt+A?=
 =?iso-8859-1?Q?2OAEr4GQfHABj0gNrXI1uXNev6adfifVv1jyjw1rjlgNPliP5HZ5PesLq7?=
 =?iso-8859-1?Q?rX3ok5XJIQ3vdVO5ek2dWLosuhO94ppvWAOMAknAJEIv3WeqrEn45/mq+5?=
 =?iso-8859-1?Q?3YNtX4HBBQizYyIwO8Poy50Dl4M33cW/0slKMf/jDQOsVZiz56tIGWy9Vg?=
 =?iso-8859-1?Q?LW7rtxL5QBMBMZlPyjILjAj9HrSfMRk25BPzUXpAY21cB77F+efEIOIOjG?=
 =?iso-8859-1?Q?OoCTdnkT5bIPDQOrQkKfiPiSoCukEp0uPGqSIMdoWpJWavf1/sO5LGe3Jg?=
 =?iso-8859-1?Q?92SMW4UR79tmpQIi0+WsPghR39gfh8M3mcllg74QHAxKPiH+ir40KicOob?=
 =?iso-8859-1?Q?7CREfXyYUqLkD+fihnVfpng5+/vRZYQb3nmYX+A6EJp8xu5j0mLkD+eD+l?=
 =?iso-8859-1?Q?3RPAxa/CEMAO4oSq8FJdBHGRL0yH4JFRKE52+kFpyULqrtnuuvvYTDCnXF?=
 =?iso-8859-1?Q?IhrqajNngD4hZG9+4VNnpqtXM0QMe+d8kquucr7yKY7NOicoi3sdO4cGvQ?=
 =?iso-8859-1?Q?m33QSacZJE8cWrIXi9AXJxFvYchZyqkUs0/kiCnnstOZ8MlUQiAG+H7QHC?=
 =?iso-8859-1?Q?6NBclRTMfINWEkuIvvTfPQSQgm3Igy1L9Bfna0IZwOm2m0EkrKAXzVv/0z?=
 =?iso-8859-1?Q?gw7h5NV558Tz7dtvVLj8PX/OheKYJhpAecFRytv2gZ7sx2IL3VCPtDeFFg?=
 =?iso-8859-1?Q?ud1D3cZtQZk/K2crbFrgyfLWZDR/HX3gyuWSjqKN6bzBSe3N5kdjh2JajL?=
 =?iso-8859-1?Q?PQ398nJzo9ZyqHQG1uV/VSEctRSees4nf9T9PZfL5btw9FjYHWPsZlTe6b?=
 =?iso-8859-1?Q?ZJ86T0LGoeDYZFpwUuxZh5MdRkWovZOpuqotCoE5LOu9KooH5wFrAoMlAs?=
 =?iso-8859-1?Q?nYO0Rqk9jtU6hP0odFjexZgCSNrN69cBDt/qwmsQ3BvAzTw4H1BfDYqoLD?=
 =?iso-8859-1?Q?UpxoyiQ7RJlLLQOUWzANvJGC+jJWTvIb0ZPcfIzwF5npg3HwxVDh9/cjQs?=
 =?iso-8859-1?Q?GvsPt9IQguA7sHe+lPepiXedO8+EwkYI+CoJ5J6wC8Rxj59WzVJ5JwB3DD?=
 =?iso-8859-1?Q?3Udew3vSN7saFHKswE7NlghhcbfokB5g6CLedDlOwmR2b32GYT9CJEmuA2?=
 =?iso-8859-1?Q?JQ4bqAVu03mxNHZa7HehJP598wCFkrR3X8ytjNwmiQyuBWQKqam0cuJXZF?=
 =?iso-8859-1?Q?4P2xiW3RbBhzH/0jnkAddyYsE2+1wWUzJ5WV2WQT2nP3BwU+aRGKCMnOag?=
 =?iso-8859-1?Q?4dSSUAklCnvXCyJpejYiSUU/sE6MckrECmgeEMTRSSEbkyH8tD+giCwFWG?=
 =?iso-8859-1?Q?aTj+/W0lISDfi8mmXYFMGYRPMJwM/VVBui7tQ4Dk3JNyihOQ98ckgXqRie?=
 =?iso-8859-1?Q?THUjm3qDLdboNmnvu4KdUhWRArhlhnU8v0a4fidUkTU2/6ipHsus9FO6Gc?=
 =?iso-8859-1?Q?uPj1TTU46GKNx3cMknWMYd8uNiFkYKyPhz8idFjPa6V8nCgaqPYmUdVoqU?=
 =?iso-8859-1?Q?G3pLsPswNvGqnz4WMaa/E1Hpd8aaRTV04/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e50200-8883-42d5-30cb-08dd59ffaa10
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 03:01:17.8781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPYmd4Yzy/z7CmsQOSRKDDh54i8PncABU7Dl+xAShxnW3r2IrltwEt9hQ+ngOjUK1KmnQ35YkmujiHZbwTyg7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
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

Hi,

On Mon, Feb 17, 2025 at 04:48:48PM +0100, J. Neuschäfer via B4 Relay wrote:
>From: "J. Neuschäfer" <j.ne@posteo.net>
>
>Currently, enabling the MPC8xxx SPI driver on an unexpected SoC results
>in a wall of errors because spi8xxx_t isn't defined. This is quite a bad
>experience, so let's catch this kind of issue in mpc8xxx_spi.h.
>
>Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
>---
> arch/powerpc/include/asm/mpc8xxx_spi.h | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/arch/powerpc/include/asm/mpc8xxx_spi.h b/arch/powerpc/include/asm/mpc8xxx_spi.h
>index 2b2095ad481d19a48e1f8d521626a0356773c0b5..3efd4bdcac2c3725a8065b3bb7faa11c78da0c78 100644
>--- a/arch/powerpc/include/asm/mpc8xxx_spi.h
>+++ b/arch/powerpc/include/asm/mpc8xxx_spi.h
>@@ -28,6 +28,8 @@ typedef struct spi8xxx {
> } spi8xxx_t;
> static_assert(sizeof(spi8xxx_t) == 0x1000);
> 
>+#else
>+#error "SPI register layout not defined: Unknown chip variant"
> #endif

This cause build error, would you please give a look?:
   powerpc:  +   kmcoge5ne
+In file included from arch/powerpc/include/asm/immap_83xx.h:19,
+                 from arch/powerpc/include/asm/ppc.h:24,
+                 from arch/powerpc/include/asm/u-boot.h:23,
+                 from arch/powerpc/include/asm/global_data.h:98,
+                 from lib/asm-offsets.c:15:
+arch/powerpc/include/asm/mpc8xxx_spi.h:32:2: error: #error "SPI register layout not defined: Unknown chip variant"
+   32 | #error "SPI register layout not defined: Unknown chip variant"
+      |  ^~~~~
+make[2]: *** [scripts/Makefile.build:146: lib/asm-offsets.s] Error 1
+make[1]: *** [Makefile:1980: prepare0] Error 2
+make: *** [Makefile:177: sub-make] Error 2
   powerpc:  +   kmeter1
+In file included from arch/powerpc/include/asm/immap_83xx.h:19,
+                 from arch/powerpc/include/asm/ppc.h:24,
+                 from arch/powerpc/include/asm/u-boot.h:23,
+                 from arch/powerpc/include/asm/global_data.h:98,
+                 from lib/asm-offsets.c:15:
+arch/powerpc/include/asm/mpc8xxx_spi.h:32:2: error: #error "SPI register layout not defined: Unknown chip variant"
+   32 | #error "SPI register layout not defined: Unknown chip variant"
+      |  ^~~~~
+make[2]: *** [scripts/Makefile.build:146: lib/asm-offsets.s] Error 1
+make[1]: *** [Makefile:1980: prepare0] Error 2
+make: *** [Makefile:177: sub-make] Error 2
microblaze:  w+   microblaze-generic

Thanks,
Peng
> 
> #endif	/* _ASM_MPC8XXX_SPI_H_ */
>
>-- 
>2.48.0.rc1.219.gb6b6757d772
>
>
