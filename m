Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA612CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 23:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B62684717;
	Tue, 19 May 2026 01:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="6EYW0Pm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBF984815; Tue, 19 May 2026 01:51:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD5E1847C8
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 01:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQojddh+JPfQsMSyA5Y4rvXbqt6th+tc68IeX2HFNCWFKCPeDRFbtpqnhTWWyvj7M7Vl1TvSTq/5rXhlrr26JCX5RxpvAk1fPTO2n94EMj398vq3g5l/3JxgTXBqGygWlKDH0CLQmpm6qC4r/ufSYCnmqK5TASWpwieTIWRCq122xrqU3mMR/9RTWvYLbOQId/q4xMiE1wc5Catqn4tc0L9Gbj42BcCxNfdDcmkeXLMnRxJf8egnP6SboD0UlaxlS1aZZhMHUsa//AiF89ZtXN4N4sS/OloQwtJEe8GPZLrMv16/4sd5fNRTFxwyZjTyx8L1PynriC5gbngi9Y1gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=FGOWnjnP65MHmhyUT8UVf7BmVIM2ZML4k1/5j/kkietg7J5DriUBbv1m/U/wUCUV8qBj/wH8N9xkuynN8X4tw5ytHRYh/qAftnyduQYlSV3Jsh5/hyDubYMUTHqKCu4mD0KtlixqYhUpF3M2lwgK24WbCWw/pe/BooP6avj7xrmTqnWYvRaR0CaUwuSLGmRaeyJcmzya4bpGTOuCvR6sg2/UcdjIdNLvNAOwM6/gGOXXL1LTzQ8DDHEZZIoZuRZTVZN4CgVcacHu/GsFvqtY3DYI5t6n7qWD0qrZzQxPGkvAEZTNREKNsU3WCB3en0v7myhAgjT7LqZ9wXYQK+QzTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T1LpfATk7jVDirzAKlOUOF5G5WUPWBDic3eRt21rtc=;
 b=6EYW0Pm8CHU0zwYj0lfXOYOc+bkr4rVunJwRidZmctArKdrwtOC1zlv0y8tP3bsup5wL7a0eWDyeShrTLaczv5C7DGPbQymsAcqLyFJ1sqWmHN7ait/M2CWaIdosP6GVMpU1hT/iCpQkVQacn2T3LYPSubVOEFto9al4Du3J20csdOwmTOMojbEdKoxat2VXw/WWG5Cxx7qmln2SSLuJiiT/FXtkqsm1yIx4HBxTCtxgw5wZR6g4LK16QT6dvFoITUufeLr2jTjn+FSGXUobp60tsj4EskETpagZFwq9adSn+700ATDBkzynNdXOE7hlm10X+XuTVS62hMSPmBdEgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5802.eurprd08.prod.outlook.com (2603:10a6:102:8a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 23:51:41 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 23:51:41 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Dan Carpenter <dan.carpenter@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Heiko Schocher <hs@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v8 10/12] configs: airoha: an7581: enable pinctrl/gpio support
Date: Tue, 19 May 2026 02:51:13 +0300
Message-ID: <20260518235116.2664557-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260518235116.2664557-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb96261-f201-48e5-5ff9-08deb53868bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|56012099003|38350700014|921020|11063799003;
X-Microsoft-Antispam-Message-Info: kJojlcLHo7eQTFvGPW06SU6/Fa3jw6wOhz4d8ELoAnJxleobIdWY/GU8cS6GNGlDqMjVSsbZYXsxuzXqBqslNJFSgPQ/SKcvL8aFPslnBGnNyZ+hAAyFuNNnpxYQsNvr5aHAa74+3X2apeRTDZgswJomqrEM/ctoTxNxxsntsvSNTvsF+xdbCKkdIQsV/GJWaeO9FxiRuBBYmRiKMSkZHh8RueWJcNWjpbxQoJTnt90rHSzBxArLqD7LaHebSDjB4Agse+2y/hOhj1yc6v0MLoH1T7haqWHjFIMqYbcQXkerC9gPDYvjEzTt4xt8/I42BmFSrIiajgwYAxh0Vq+auWpneT4aTKdBgYK/NPV7ZPTVNmpanfBOzY0AZkmjDAE96hyedwj3xpBbhhmapcA0UILz+p0xqy9SAT167jZ9RsF2kH2QPtY4mH3lsucmlC671sfN/HDs5LEmvuoe85e2u/xbDbzR9u8rX+yZqToJqID3fvhBv6yZ3mV0/TfZnc7c5O2Ang5bW9A4BJGktlaE0fHzu/g9RM30CFvBS0j3i0U4ETL7ePLvbBM4qAUS77k4MVVTlLIcQhouSifRdTeiqoQ56HYiwkM4yZuqA0Yh1PkLYAqL4VxLLr4qJ3GyJ1tmD+bsg9YuwN5Amk1226s2QjZHA9x1NHwbdpXg6nrWD1yoCtmYEb3L9I08mp3AXNdyCTKxUcDSPm6VFohHuwooZpMfo8Z7nwlUpG+c9v8TGk7AFZLW9dkS6dNtYgTANjsRTBYBFX3qJlqqBvWc8q/pAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38350700014)(921020)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cH4oWOPFj8ac8PTmdwVaP9LFdjwBSLzCNjfY+he0td18jaq6Y6pytrJUDERa?=
 =?us-ascii?Q?BfGve0pBM/G0vkF55LvoKPR7C7L6xUsMv5eocC9IOaeisi9NYS1hpZ244WW4?=
 =?us-ascii?Q?9eV8LHb5x34znrkCmDcHUP3vdNZ6fIAbpNAffb4UcJwITESmgD0qnjOgXn69?=
 =?us-ascii?Q?+bvrjkRniEux9EgHSxCSNNtDLpj9Nhny4Npnczqqqt8bGEnpjr+rtdI3Nfja?=
 =?us-ascii?Q?J3VhCKVB3qBnJbguRh0IJyAjqsTaZVOrb1wI/Sre9mZ7W5VFONgc949y/PRU?=
 =?us-ascii?Q?lnFbm5lFG6svFNa4GmZ2og16vGNbK6J8qslRUlv3mRl5XP3O1PADalfzjpze?=
 =?us-ascii?Q?nWkORBap0xq3lgEPET+bxeTqSdY5X07NFD9bsGn1+L+Lzzig0f+x3Q5R+sIc?=
 =?us-ascii?Q?M3wYf4Ra6R9AeVSoPeZBfvZKc6LGhIBavbpkFdj30LcAYkbBV5Wwa/RxCmcy?=
 =?us-ascii?Q?5QYe9zjxl5GA39xhL7xEa/cbOTPcjxOHlkVbwKt0T6MPwINYr7bcenYUR8tK?=
 =?us-ascii?Q?jnF2XIg9+BCHEvOSvRkHv5yG6lm2wlDtg3K/7K+RpU18jD7118Qu1rwyEC8R?=
 =?us-ascii?Q?SQkwtVFJ9aQy/OzOuPV+tH9WUEpqFynxepo1ErHj0O82Yp6lIFOQcBaDu7q+?=
 =?us-ascii?Q?9zxgQtIY7TWHt2LcP+9gS8QEtVFFxa29XEgR4UdKIrcGtosMKn1NVBhu8Woa?=
 =?us-ascii?Q?p24q8QFvwYCy6ks29sdv+xg4At3eYhBvuyI0yITTumYtdLEirjkkBCU+gx0O?=
 =?us-ascii?Q?0tjlN+79g6a61VRuEjVhzULe0OJR+gM6JjTCPStZRblPEtMAJqWGYAv3klbS?=
 =?us-ascii?Q?mjcZe0E2G6XOKBTP8AXowb/daoVM8IgHLVauodHFEGYVnBmO18pJfht2ww5k?=
 =?us-ascii?Q?v85324IGr7fcHSoF2JNXAqrMTxaCPbqWJ8FofxijxSHE7LJ5vSKZ2FNA4qgC?=
 =?us-ascii?Q?hCdrOJCKyy64UFL8X+rZy+WGdWzyZOXH6QQTrg8UJNhCdt03CY2yBeVVcH6R?=
 =?us-ascii?Q?yQB6IlYsk0gEaREHtcsuoqJEq4ag0TnwQAo157r0u5OhwGc8P+IlDhUm1En8?=
 =?us-ascii?Q?6p2J6PsSTPJIKR1h6r/V4BQM3vHGLakTtwqfKYLLCa3mag4WHmpYLveNFL3v?=
 =?us-ascii?Q?tvvqLO8S2ZUXk/LPK0BtKt/9IdY1WaaQPcglCbqvSVHOSRx1XPBxiOrQWfuY?=
 =?us-ascii?Q?Bo+A2m2gJx77HsllV77vqHXUU1E+IIc89yooaJwiZG05bGiCj4O5NKZvfYbW?=
 =?us-ascii?Q?bkrgPaArwZT9ngv2qKbzmavbVe+PEKQbQx9PdlGUWQWwmpfp2C+gIdPvrs13?=
 =?us-ascii?Q?ZdUpO1cpb1GqxabjJxj8IcLGTlh33moMrSXG0j7E71xt85fseGGxZhNQljzw?=
 =?us-ascii?Q?ct5T6Rj/YcXdNQ5H0CY/Ynva+10XZ2iRS0KLKZE59sHVkRhqox8Wzgj9LNT/?=
 =?us-ascii?Q?NL9RIY1zq3Pxuj4p+7n69X6KFZFkdAGdKU7Rf3tJMpJabY9PiJJfZH+qG1Dh?=
 =?us-ascii?Q?LzJz3rVogMrY1aO6qzdGGhR15FXKQ3TPqVgIxNb6DcXrqJ2w4mm0hsTcR4rI?=
 =?us-ascii?Q?nhvpnmvb5/dRwpjVYoeWaApiqI/0WmDdoyS4QLliasSKqB6PNByotkMXXtnu?=
 =?us-ascii?Q?rVC5P8sq0V2qGO+93WBa5N3s+TgHg34/D+IRVUnZPq4k93Vw1VpEA9IqyMns?=
 =?us-ascii?Q?/2ztTyQPcSCxLuSfNhkO9Mp0l9mYUUX+slMCIKPuVg7F1wYxPEak72wIIxDL?=
 =?us-ascii?Q?roWskg+y9nR/tHluzDFjVhlhonHseU4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb96261-f201-48e5-5ff9-08deb53868bf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 23:51:41.4296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmhtV+ClajN7+5yNzWzAa1DgVsBN/MJpKFs9K/dtY/7rj6cAdnpiRpXGYEDoe9VBy2NEvrm6rlugJkfft6CL9hFUDoj9aAWWtFOEPD+Jr5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5802
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

