Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DD9CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 01:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E7984150;
	Mon, 18 May 2026 03:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Kj8DOc5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4139184664; Mon, 18 May 2026 03:01:02 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B6183AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 03:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9O5Du6FU7PKNFjjW5QnzDC+s2yY/uQz31tN4TMxqGIca89twvvRf9H/ZPNwZf9jCS6doTstCEvIRObtxq2xtjJLRLsaZShKnQmc5KTXnyN6vrrE0VyIq/oC/9Ffj5z5VCJs/oNYLYTdKNVvdRn6mRtt9H/W68YKhLWeEZAyAmEsngOvIfeBcgWwGeQmfQsJFPkXz6tsSPgA9LYjpkfZDU3LptJS6+NrCwPsEZ5yJiKWFTNllwh6BoO1Xa6OO1jS+HiK1t4B2IcgL/Lwg00fBV2X6ZHH85ZIdKU32iiI5UaEXSSSudzK+yv0R0kyacwsgtRGj/FT4VJ6Hrx8gB3xxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSr6GV93VipWr5hk7sqLMElRYLeA0a+IsAPODubuxOU=;
 b=vp635Y5ZfNUlioLzy2dNT+zS383PNq1cMDoQqHD9GlHGgWwduBijqgKUWR5tyP9Vuiskzn98846omM2tBm9V6FT6UfqVIbXbVylTh8NqnDWxPyARO78tw6qbr29zhLJ9+Adfo8NKhL59wStAk02NIIn43p62N7CicVl4v5xwuf49sirF5ao3GSIdfbo+w4rdCsNS11nYxgt1G/POUWKxUexkFyRRB9VbVwQDEzKbv+vhxrcXthUN+9lnp2+HyhSKC8UhDWI0DuW4yD2UZa7xML2ErT/ncBzq2T2/LsAN23kK8ZQe7HdnQnwTeA3qy1MJXcvWYqNdD8O0rxK3YbGGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSr6GV93VipWr5hk7sqLMElRYLeA0a+IsAPODubuxOU=;
 b=Kj8DOc5tlRjjuRlJnEP574p2TGa+v7d+qNqwF6Yk1XJhg1pJVumMtOtEaWVdE1R7ADRh7+i/vfxwEpFR+oFQZhVy7jDjwLM5oTFuDh1qQ8VeOK3DA+0x7dpP9ck9tSJivfq/HV5O1KehQHdLob27UnFR3zM4MuWrJrK9b2N1jjYoQPdJ9AGEUDy7yK/gAVESRu8knT52S71NP4G7Oc4SKBUR+t0M8M9wCE5tR01kD/sZv7Kck7EcTzJoylrUqEmOvT5pLipuBwf5T/JTk+k9z3cvAnC7fo6VKXZ07j2dt3vWGdyf9C6qARJydHANdvOI+xfjSBQr2fEvyvwHu85tig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB9272.eurprd04.prod.outlook.com (2603:10a6:102:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 01:00:55 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 01:00:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/4] iMX8M: Covert to OF_UPSTREAM 2nd part
Date: Mon, 18 May 2026 10:18:09 +0800
Message-Id: <20260518-imx8m-of-upstream-2-v1-0-05c0b996c883@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJ2CmoC/x3MQQqAIBBA0avErBtISZOuEi3SxpqFJVoRRHdPW
 r7F/w9kSkwZ+uqBRBdn3rcCUVfg1mlbCHkuBtlI3SjRIYfbBNw9njEfiaaAErvWWVKavDUWShk
 Teb7/6zC+7weva3nZZQAAAA==
X-Change-ID: 20260517-imx8m-of-upstream-2-74cbe56efb8b
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA4PR04MB9272:EE_
X-MS-Office365-Filtering-Correlation-Id: d880ff97-8e04-4056-a317-08deb478ea43
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|18002099003|56012099003|38350700014|11063799003;
X-Microsoft-Antispam-Message-Info: /c18NMsNcupwX0moRMKNq8EZZR2PgQspR05HYzjBVFwIqn3gyxc/HuUpkP9qKKrI3tf/sW9PkQsrA+vlejMz5VtdgP2ige5jCzYGmzxhA5OnfP1BOGoVT3H57eDo+xJLmAG27mecKgxPZfAZVXoD3u+d3vlh7TV7D24unv3uod5mX3CBekkALyHOBzb8490chkyHBNexdN3V3Kv012JymQ9c9zRPBHr90YNox2H0R5UcZwn714cdAaWQsOXLL1ed//L0IEYRFXLrGlIipuzhJTmh1WnYuggUjp2Uu2CNhRIrl15+OAC6bwZ2j5YDkudjNHejEqYR6MzTwK4CACAQd/m6zEWARkRkDRuGMOyTUG5ArL0q7ATGYWSjXl5ICSZm92rNAo2bxHRgs58IUp1cqfhxEdqWUWr1erJW6HvkhtkWRMAm25jdEo2yehDAcSIqB6DXu/UafV4Jq0h03F8naShMz97Qw5wxiCHiJSS0PeO+NeaSSrkdmKRVrGXklgWvWQ6J2WT402NXrXFwAu+KNczCtc2iG202Uh4m6/Q0NEVcdLOfydUn5mtbhj8vHz4Xql8HenuMibDG5l+4JKTq0r43Dsz+69iRjqFPXX+0S5uoSwMpktnR8Hwr9kRmKQeTj7+R/sd7PToqAZNddL4TcCgiJ+OuJMEc+WJTkbXyhO4+8FVC+rDcErGIdx/rrArEjpgJBZxRP0Hd8wnZgy7k/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(18002099003)(56012099003)(38350700014)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lmQmRBU1dtbnpCS2VQOENLTEhFZFBaRlp4Qmt0U3VuVEdHaUY5VkE5L2Nw?=
 =?utf-8?B?ZXUza0VXRFU0ak5DR3o2RnQvVlE5TmY5NWpocm04MWpvVGRjVWgwakFLMTI3?=
 =?utf-8?B?a3NzWTh0VkZpZ2t6UHZiS0Vxa0hDMHBldExZNDdNTWp2N1hwbm1ya2tJaFdN?=
 =?utf-8?B?OFlmOXZiN2Rlb1JmZ2trVVVrQ1VvM3diUjNmWjd5SXNVUDlaLzRRcUxaUms3?=
 =?utf-8?B?d29aUTNFM3BIcm5zanVlZzRyMy9NUGkvQWJ3UUEzeHFkNmF4a0V1SUthTUN0?=
 =?utf-8?B?Y2k3OG9xeUdscGVUc0s5UlU4SjVITkd3eFpoazNEUDVHS29XQmF2TUlmc1g2?=
 =?utf-8?B?RHgvNm5zOEJlSktrZnYxR043SUlpVFc5M2pZdHdTZ2NGMjZ1TjhJQTRDOXJv?=
 =?utf-8?B?dmdscThPYis4Nmx2SWZCRktDby8xcUVYaTRPbE1jU1FBSUg5U29HcVBlRXlI?=
 =?utf-8?B?OGJqdi9Cc2ZPNkRCa1l6bUg1M1dYbVVvaWFYL1JUR0RLSHpTZ0o1dVBraUli?=
 =?utf-8?B?RXlsL3hXVUpCNlJQelM0VDNyS256K2pNK2FHd3B0dERrYUh5R3BBMENnNE04?=
 =?utf-8?B?MVJkZzNzQ2t6YTA2Wk1OcEJFVUxFUHROeGJTMGhvTlFnMXUzcUR6YXVlczEw?=
 =?utf-8?B?bUJHd1YvWmF4OGtCTndsZFBIejRFMzJBcVYzZzRwRXhQRjduNnB3bTkwdHpk?=
 =?utf-8?B?eW1GdStVZVA3YXZxT2xtNVBLSllJTU5PNU80MksvTDgrMEVVVmZRTU9GNFF4?=
 =?utf-8?B?NlpOa280cGJiQStMeTJYTDdZdjFUYStNdVR2eFVZcER2clJuU3VSWlRKNlFF?=
 =?utf-8?B?M3Y1RkRTaGlTb2VKYTZFeDZ0ajk4RWVDUE5XK0YxeERXaU1VSDc4Z1A3bHZP?=
 =?utf-8?B?WEQrNDc1ckNyNFZjUml2c2s4S2M2a1NlcjBVajZ2NEx5U2tqZUcySCt5S0ti?=
 =?utf-8?B?TllLUzFsOEN4NUZyQnpBUWNNVDRvQ0dRMjNoN0taenYvM1NhR1hOcEw1MVJC?=
 =?utf-8?B?OERvQUlTZGJoR2xXbEtGckJ2TEVuVXFpTDN2MWVVeHArUUxjS0tjZ2dwQUs1?=
 =?utf-8?B?YWxXTlpxR0ZQYmRCc3habVpxYVQyUEtzWUZIN0xrME9JTnhmZ05MNUtudW9t?=
 =?utf-8?B?V2dxY2taQUx5TlZTR1dLU2JSNjBScklyNzBrc0xjQmlGdC9tbm5YVkRjeVI4?=
 =?utf-8?B?RzBRUXVSVys1aG1mcU1BNHlOMzR3VmRpUm5UMVAyb21WY3RNNFR1c3kyREM2?=
 =?utf-8?B?Vm5jNHdkdnJoeVFyVTBUQW81ZWNUMENySVcrSldNNEtmK3BJdUNYS2p2TGoy?=
 =?utf-8?B?NzBpNWoxMm85THBaU2xlTHhuQWhZRWlBOVQ5QTk0Zk94Mnk2NFd0MThoc1Ay?=
 =?utf-8?B?SmhscXJQNDJvZ1hvYWRIdnNpM25QKzBHRURGQml1SDVuTmVNaUxzQ1htVFJJ?=
 =?utf-8?B?MzFqUkpkZStKZkR2dkJ2N0NGbitTU0MyWUZTNitVN3BoemlEbXpERThRQWxY?=
 =?utf-8?B?VG5VRWZsYThKdVc5d1RlYlk3NGFNVWw1U0tScmxFY25JOEN1eitrcXJlT3o4?=
 =?utf-8?B?VGttakNIaktzK3NEMGV2M2VXVGxpOUs4N2QyWStZQkg2ekdiQnRwQ3VqZ21m?=
 =?utf-8?B?Uk52dXowRWhlM1RlT2ZBSEh6aFVLQi9MRHYrb1Z4L2dYdERyQ09tZHVpakp4?=
 =?utf-8?B?RjBtWXZrN216ZmU1Wm5iTXRMK1JBV3M5WVBmbTAxNDF4cVY5ZC9ZWERQQmdu?=
 =?utf-8?B?Q2hvazNKcHVhNVRoekpRcDhSMXV4RTFldzBFbmI5b2MvdUh3aHBuZFVnMVFq?=
 =?utf-8?B?bytQaUx1R1ZVNExNTzM0OFNRL2ovSWRYOUx6U29FbXBheHZQN2RMeWZGK05s?=
 =?utf-8?B?aHVqb1ZaazkzQjJ3citUOVVJZzRwZndvdURtM1E2QW5wNitXMkhzd1BXRXV0?=
 =?utf-8?B?b3hHcngyU3JadlRTczE5MmhXekpuRXVaWFpiSzFjcGJSUUFhVjV3VFNxelNE?=
 =?utf-8?B?VFRZUWdDbjE5alZsSWs1WCtpNENBTFErWU04M2dyTXlCMFB5WERCeWtlVjNz?=
 =?utf-8?B?a2dxVHhoUFJqbHE0S3VSdm1maDJBOFhlaGtBOFpQK2Y3ZmVSR042UU5iWnFB?=
 =?utf-8?B?Q1N1b3o5clBlaXRWQTYwT3M2THR6QWpFT21UWFRiMnhqM0psOVZZWjVYY1pZ?=
 =?utf-8?B?bURLVjh0bjdvYUtjTGN1T2djQklTeXgza1dpRnFacjI2NkYya3JvVG5Xc0di?=
 =?utf-8?B?UG5VZWN5dkJlajVkazYzSmJ3eGRvMmZXUCs0amJ1K3Q0a1h4anBMbGZsRkxR?=
 =?utf-8?B?VEpKU3FsMzFELzY5WXZKSWJrTjRseWhuK3kvSnpHMXFoTU5UU1puZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d880ff97-8e04-4056-a317-08deb478ea43
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 01:00:55.3670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNYLTB4+LpNgVZmrzTELwehxsoc8JfiKWBqN2/iqLUK/rIHg/Av2gwdslAR3ly9A0fy4OpdWguT3V7wDvRgGVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9272
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

Addressed the conflicts and included imx8mm-phg and imx8mp-msc-sm2s in
this patchset.

Convert the remaining boards as described at [1]

[1] https://lore.kernel.org/all/CAOMZO5A4fxHXk++4Ha6hpw+=saE30B2OxmFtkHzpzsi704Ysfw@mail.gmail.com/#t

Checked the board dts, but I not have the board to test, best effort on
this patchset. I would appreciate board maintainers to help test.

Patchset is based on Tom's origin/next with u-boot-imx-next-20260515 applied
at my local.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (4):
      imx8mm: icore-mx8mm: Switch to OF_UPSTREAM
      imx8mp: icore-mx8mp-edimm2.2: Switch to OF_UPSTREAM
      imx8mm: pgh: Switch to OF_UPSTREAM
      imx8mp: msc-sm2s: Switch to OF_UPSTREAM

 arch/arm/dts/Makefile                              |   7 +-
 arch/arm/dts/imx8mm-icore-mx8mm-ctouch2.dts        |  96 ---
 arch/arm/dts/imx8mm-icore-mx8mm-edimm2.2.dts       |  96 ---
 arch/arm/dts/imx8mm-icore-mx8mm.dtsi               | 232 ------
 arch/arm/dts/imx8mm-phg.dts                        | 266 -------
 arch/arm/dts/imx8mm-tqma8mqml.dtsi                 | 341 ---------
 arch/arm/dts/imx8mp-icore-mx8mp-edimm2.2.dts       | 175 -----
 arch/arm/dts/imx8mp-icore-mx8mp.dtsi               | 186 -----
 ...u-boot.dtsi => imx8mp-msc-sm2s-ep1-u-boot.dtsi} |   0
 arch/arm/dts/imx8mp-msc-sm2s.dts                   | 820 ---------------------
 arch/arm/mach-imx/imx8m/Kconfig                    |   4 +
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig       |   2 +-
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig      |   2 +-
 configs/imx8mm_phg_defconfig                       |   5 +-
 configs/imx8mp-icore-mx8mp-edimm2.2_defconfig      |   2 +-
 configs/msc_sm2s_imx8mp_defconfig                  |   2 +-
 16 files changed, 13 insertions(+), 2223 deletions(-)
---
base-commit: 3321f4cc0cfe4fe2be987a7c771a5e19be380706
change-id: 20260517-imx8m-of-upstream-2-74cbe56efb8b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

