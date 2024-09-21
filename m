Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1076CF9C68
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 03:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D02884DB;
	Sat, 21 Sep 2024 05:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zpPM9xOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92ED4884DB; Sat, 21 Sep 2024 05:44:22 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BCB88AB2
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 05:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv7nfGpojk7SSetMPMCQbrwXlvOd1M38ahtyuM1R8u2hJk8MAazyI1eAVfWZ41BOWh4mqD+u+IzJHdaP5MQPL/JGSxfMZq1zC2ZFM7/X0CEewluitmvSvGkbRo59CHti/qOPqXX3xPvdS48TulM0RxjPuNSsqmzpf8SLA/fMrx1QIK3FVq72vlrIVMfkVG5G/kRIAj0/G7DqkEQpNa5PYdU8W2zfYOBZJH8LpMOnap+Z5clkjyNZGYp0JM6ZunQ3iP5tdKcdWcVOSTwfQwVKJwLd8hUEGO70CMhc1FHh5xBdG6bCoALtzR0yEqIvH1CCYYs+zlaXlbwZ6RbDo9Yj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL2WUbdpCCdF0Atc32EvM/rgoTAIppaLvvQCD+Qk3xo=;
 b=su1ZfH2deaBkH5n2xJOi7HPANsEXlvujo8dRaGtkDlhpxH+p4jgBVGvd2p15Uo8mREYGdApy/DM0bbtCutU43fY7g0LmSCOwBDtRTyeG+jbOxEzQpSgnb0i6+3En5QT0Q26ln5sBUZjI1zBcqYE0KOdQqVTQIBUKK0ugN3EhsXi+IvubwujFbUSSV58ACNJe3djcagDw06wxCFEUqUWGWY/XM9U5r8zdjls3wqqz6tT8peQNlnDGTxaRw4X+fovo/znnfgBvqL6wElyeJNeFXdNMYW5z26vavIwTgkXYZUEYGWLR+beAFk3YFYAynv2gpaLVu1ndid7wbek2nnLZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL2WUbdpCCdF0Atc32EvM/rgoTAIppaLvvQCD+Qk3xo=;
 b=zpPM9xOyJlZMVXuiYm2+9eAsNfJQpz57d6YYvkMafLlljWos0Vw9eM6pLNJAULrfKduvC5B6t0sa6UeZWLeRh7uJg5SzbN8D5jxtSnX6CGJoUG9DK+EM8M4pj8ypixIugNb6BP90Ayq+GyWHuMjXTnA5FgahB/gTCn3I97Ix4N/7+kaSIA5ThH69bLctKXSz/Xyu2duVy6xDqSBBVfVaKO/ZuyAd4WU4MP6aNB+cryXrpmNArF6Z12GVfx7eGdzLr4eVy50j9BhLC0EvoEE4qJqYkS/fkkjrz5O5Ne87FsSbUjz/EVSfLF/53VugKBqfn5GlLLTeM3kpFWv/ih45yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9418.eurprd08.prod.outlook.com (2603:10a6:10:421::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Sat, 21 Sep
 2024 03:44:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8005.010; Sat, 21 Sep 2024
 03:44:14 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH v7 09/13] net/tcp: define a fallback value for rcv_wnd size
Date: Sat, 21 Sep 2024 06:43:49 +0300
Message-ID: <20240921034353.1298452-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240921034353.1298452-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004595.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::440) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f74c5f-71af-43e0-5170-08dcd9efa9a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?35XUjoCyBaN5imGnEc6E2ZW2ajwl5YWI+QKyJZXuV2Qe7TbYahoBuns9LwDQ?=
 =?us-ascii?Q?P2xSteMZx5VZcSL8R0rH1LJH44IkYIiOQXeJScevEePIC5pqcf8LNYk10w2y?=
 =?us-ascii?Q?e6xXwvboxILXqtGqBmZxp2EUMVK31KwiuIORZFRAZxFX0BEyYuG4h+DiwY6y?=
 =?us-ascii?Q?TNVjC6cvefbKrUQaM9yZymK6GMEXzZ/NeqMIVsx4ugOSLpR6Kl22Mxu5pguw?=
 =?us-ascii?Q?NJ2Wk9tPcF8mqbBa0cgzI++zRXnzD+0gJDETOGrz9qE8W8cmYJb0tU8Roai2?=
 =?us-ascii?Q?0yVB4OzfVQ9sodysq7+KP+dwquok3c8ui10UhCx0V/tAGS4olfj2iNZ+QYQv?=
 =?us-ascii?Q?G3OhG82VbOCD8a3/VzzDnTOy0tNxl93pFKZ9i4iUZHr22wzARVvQnpwxmFV0?=
 =?us-ascii?Q?H4ncqg2TUqVqVbw2c5V2oK9r7+0BgPUzkYPg2DpK24SfS+TPCjiLMpARjTtH?=
 =?us-ascii?Q?+NfDWlUkOoVrc+qtYyHx2YOM/mA0C84WvMh7E/Wkn9ooYuudk59Xak5ghBj0?=
 =?us-ascii?Q?FRg8VWQ440YqdhzWQ4/e06tQ73CuMLb/58y4XuSgTmOKV5d9VwPlsEhxvyji?=
 =?us-ascii?Q?kR2WVNZM3uAjjdTqCIu0TVha+KiguUIjP7ohSYCDcLCsXJUsN+Hs+HoR1GV7?=
 =?us-ascii?Q?Ve0JAQObnWwhfvJl2Lz+SwMPOpGtbyb7K3zU0jcVn8prDEHDx/R0v7SNgyP+?=
 =?us-ascii?Q?5QHplbWPRlZWAvfq4oAYo68UR8Rk6Db+Hl3FpuyKSy9gRzgwm+Jng0fr8qFJ?=
 =?us-ascii?Q?GP5D6b5I9NaMxsjt9ivZp/M05YrMzeRy4ZIHYMCzFyxFK8cOiTxHCEFI6djJ?=
 =?us-ascii?Q?A9shh6HzZCvNxqUEOLeXaOZ4bu5s/PS+n3G1KN2nvQasAvZhYtzgWjkXMkDd?=
 =?us-ascii?Q?y39fNMbhGeinr61MOOjWB6qYjS5mEx8ZQtnXPnySg5IHIg6mKj/PnKa2KnLw?=
 =?us-ascii?Q?tgAPhpMaT6g1s6sCDM1MmJUjDW4M44xijUQ2nRSqCTxECY8DsZGbx6G5el8a?=
 =?us-ascii?Q?hSD3smldWMb11aW1p4xSZGAi6uuzeJGvgBIgKqttLBdWRgUlvTAxziYy30WB?=
 =?us-ascii?Q?My2A2m7tPaL6xw6WS9AJAulMqn7wlwbzvOY70RyjJIqr0SFx/oh/rch8cJue?=
 =?us-ascii?Q?pnsasIXPDq89sX/f8Jfj009YhnTMud1rw95MaJsdYMKTDS3Z4YHJuTfoyN3m?=
 =?us-ascii?Q?/cIgXly2CmAdumeCSqhiDYUlFdNZILxDDVl/hG6PMLKhGAYH7+freqS7O783?=
 =?us-ascii?Q?FBM/m+mDDPpKp4S37q+YHMYmrNWtcD0a6YAgvSsFYtxJRivqhkrKcQkr7WIw?=
 =?us-ascii?Q?LLkQ+Dhm45IYWSCQRrdvOOWyqnY7H6uSGhGNeFa62t0E2ngDmiO41RZmwTjw?=
 =?us-ascii?Q?/aldkl8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tbZpQNydU1Jvw4+5ZbBftZ86vKtE+pTO8KunP7zIDeHPMBoC7Xj9Ly20sayE?=
 =?us-ascii?Q?OdXzRQMcVMing3xA2y4KkWXA2LFAnHwUvorceTCd438Txpvcu78xgUQV3v7W?=
 =?us-ascii?Q?DJjnOQy3eKrXtiW9KFzgj+8HrpTqGjfHWkB21kh7+DfAEr+siKCULrsiX8j9?=
 =?us-ascii?Q?DjoFGexowtHl+DK3cSI/u6kcFI+1niYDARonBmavPxroTCwQyGHc/52fp4t1?=
 =?us-ascii?Q?MVdoFMhFFZcaIngSMD4vUpjoydAyPxFRzdfHgr5E6Tal9QNYfvt8SYAmZX5G?=
 =?us-ascii?Q?2dtRjA/zYYv34OIQaLBmebg1Hl7VAwt1R1dC8IPwFvzFLt9YBVsIHaWP+V9f?=
 =?us-ascii?Q?RPtmp+eaNsgoGWxrGSlrfvV+Qvg1LcHJSOk1DH48QxCzppSi5qrPYdgWeL6c?=
 =?us-ascii?Q?z4sA/wQKAh9gL+pTC/ByfTM7HzKwZ099I0whtakaZmkcnYuCFG7lEDuTUsu9?=
 =?us-ascii?Q?XXstMnxx0U+nUZCVZEq9Nyu1YSEEltGf/mDQrIDVaFZkILhPZnDwsPEeLj34?=
 =?us-ascii?Q?APMySmMQSjIkeITi4OE+FWlIQLqmTNLq027z8mkCQhxfVKjDvpXIS7MlRcWL?=
 =?us-ascii?Q?tz80SNmX7S6rdLh5yj+SxbPvn2rN6x8Nf9+poDuPPNcDVscmwm7T2qor1zG2?=
 =?us-ascii?Q?ut60C09boKYQCuGPe1Rnqey8GmpYS+XATVwjurTv4ugaTtBEt6k8fXbFCdwb?=
 =?us-ascii?Q?GpVJnhuLY5DNcH5yO2MZiVTMaLCNaVNZnOv0yC6gq1bACP0/pXrWkEriP5/k?=
 =?us-ascii?Q?8u0v3zMFtxZCvBcjXA/NHVQxKdtyERxM070JZ07hUy4UE/G9V0sPMZzn6xOK?=
 =?us-ascii?Q?fVoW7GVTxoaRn7e40PU2H1Q0rrYdsEdwn375JArroqDrlhdxJAHlXbhQka0R?=
 =?us-ascii?Q?Cj3YTvLqpAv5xwrzNsf5z6yXnH89C2ctIKiiL6/Vm0PPShFjoTk2+Eq5hDN7?=
 =?us-ascii?Q?Wan/Du+ygI2A0IiMFtLoYLWUOEE979c5vFVkFDtR0649S4R1zB9vY3zAAiX3?=
 =?us-ascii?Q?Y4mTUmJHHCIccC8FVj/6HimVigbnIhsYI+wZFnjjya/n1LRrr+ewHuCIyKSi?=
 =?us-ascii?Q?pNAGmlzrfoYrZmduFNhy91UsRd2DCS277V0hR4Keyby/ya5dL8NFHyV9I+6z?=
 =?us-ascii?Q?xyY4vdDTYHz+JagTnILefPc+uGbnku2ob+2VJYhveB7m7TyXJkSb+2EU6lTd?=
 =?us-ascii?Q?Hpz4opMJR7Rmm3cJha92Y5gk/zRgk8aOnNBJmaJ83g6ySSkpL2+3SaibN6c/?=
 =?us-ascii?Q?qWfO4fpak+WSB2LxiZDRBldCBFHsNsgmc40yCE0pgZXjCxt1P/jUkGDfW/F7?=
 =?us-ascii?Q?TydtkuWsS/hDvcMFw1sOghvGM+XQdTWBYjua/Ze8IuYl6NZS51pgz8ggtI2w?=
 =?us-ascii?Q?a889UtBMH/eNj/B7BBr7kZyiJUIw6SgECbwzTK9QUxBR5Lokg6B0iHozCiL7?=
 =?us-ascii?Q?qPKWhC8vuTvn+chWpL5AiOaJ38nETRR2zCmBRpW/d1/kQDsAj7hN+WMooV5y?=
 =?us-ascii?Q?1w0KU8gwVv9OlSuPUnRV9aBdVnt6K5A7hFJE8t0h6ct/VQQg+8R/RyRY82Qm?=
 =?us-ascii?Q?DJ8sWNWadMU9dTdaQBhyXaH8tkrTsOE5iecljU5xdN9DsgeQoVzzegRrU6Hy?=
 =?us-ascii?Q?jGBQEi0NpaxdJ9t8DCt1ysw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f74c5f-71af-43e0-5170-08dcd9efa9a8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2024 03:44:14.7859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZV5mPPfIXNkwW89WvqsTOv1ZiwT214HTNlnvPMpi3H1B+jKsuUcDf6Ob+Nu5jRxxo5cP/V0IHs+iN/roOx9fBd2QJoiPxe05z4yj8iQCNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9418
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 647454fc064..90f2ee1f5f7 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2

