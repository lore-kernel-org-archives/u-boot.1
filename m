Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E97D58CAB
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 03:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96A43840AE;
	Mon, 23 Mar 2026 04:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AJSaXVND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB382840F1; Mon, 23 Mar 2026 04:17:54 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BEF68408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 04:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpIzjnCAeYqIQTSrAa0hTsBzRQYH7v2AKpmqhbBom2wLpDfSkDS1rAHOyvCpvBp7X0xBzEQMzaeoILEPnAXoYv90Zd23tK0U9THO26leY8T4WEdcX2bI2KzxlZfzfHjbYlDBqPO6EW6ZB5Zo58EVaB42/zXVVSHyf1O3s/YPw3Vx7Yf2HKnD6Dupu+iA4gRGeFiTneW99vFXffRuEFvTi9scscLACfPbW4OuMqG+zJEXYxcaH3FOXwvOez+YX3NtjqQSyQ9Zt1vr/jnWEUP67BGdKQE7TF2aJchcGAcoHKSIt+ELthJYjeNSzg14kRPiN41kc4OwTg2/VsfsBt3gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXRQYDTTUXJqcmUl1jakrH8xdIb7/bc2khf+5h1T3/w=;
 b=Cv5W85el+RShNsBN2LFSAUWKAekOEJlQ3BXKEJ6jMjMBH2F6OpSGN1r9RzgZg1E3Mm0qJQJG+YrhsMEKN/KO+OoUdZd3wKl1pE7yQ5WfP9MVO2iruGsiNTk68VYHf1o0jumhUiNGelydyczAUmzltbvgBCfFz4kjhg7aLmUqw2bMpctYtNeLqvnJ+eVDKTbgCT5dY5nAv0pQe7uHDMOJcjBhqPd2L9pcbH9O2oNnpJpAJ2X6gGrq8bLgiKGUsi9Rng9G1cPx/p7d+8TFRthig5LDHps65FredT57MjeHv6Se2yhQfFzvnUoj+G7DhIrp6NM22edtWLvBYlFX+BPM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXRQYDTTUXJqcmUl1jakrH8xdIb7/bc2khf+5h1T3/w=;
 b=AJSaXVNDxI/1Gar/gmTrjXjemFbm4qtiZ9B3hor9PGeyrUM8ner+R+MbY3lajWR7IE5f7ef40EmjERZPhNpf7m4wa9y/rnAgzaUgSdO39aWRdgzKoE5806PQyDmqrIq91rz/rmAJAxg1PF/X0HLovb9qh1rVnVW0RnTmdA6wCgooI7rKwJQY1e/7WNM3ru7Ftja1BuuRZ/IV6TfIuBN+v7ywqd1rOcO2XhAsb+RqIdkt70hhguFG6Lib2tmT563Ov+oGAR04Yt3t+B/KmJFypgu+aSFOmKaZOhkJX3z1coiShPQVgqwAHH+VE/fTpUNqmGHGflrEZU9fX/brSjyXDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11522.eurprd04.prod.outlook.com (2603:10a6:150:286::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 03:17:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:17:26 +0000
Date: Mon, 23 Mar 2026 12:33:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [GIT PULL] Please pull mmc-next-2026-03-23
Message-ID: <acDCbfaY5P83pvA9@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11522:EE_
X-MS-Office365-Filtering-Correlation-Id: e88ba2b9-5359-488e-dd21-08de888ab552
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4hDoWe6mBu16UmQ2aKAYfXjCS0xGcPO7fNjl159aRtyuyVmwhpbgYlWMsHZoq/4lSbBdpd37iB+aKFMlRBTlzhRZoaXh4BfGozk2LFeGpkjOhBviHIzqWHpjarCwfZgvSE1pQbatO1Q76XRcGoiaTZSN8fll2tbRTMyZrio+0bsohAdlZM3GZJqjRYieShU+plXIUOUT8K1Lnu/inqn0aGlU1MQFS9/JSnYdYJ1XOnepLRZmvy6hklXbcAQuLFWDvuAb8J/EVPvTgOTtMdjivoD2+fqkFw/3rMPwFPJqkmFy8WLPBqT9BDN8xt0ftkxomuMXRvTXRDItOMF7qCnxfavF11gB6qIA7o1OWd1OLRLR4xyxdnh6ZrZ8b2YefnWPl7+vyLm+ZlHlr805ls+tQBPS/oONKExHtKQPD05+YDtO5nX0a0nExpkx1BsWCpHEs30reYDeUgSrYlAZqqZXf61FUPzEVO8uMPX25UUGghy1AI5eU5MfAh5hC0tI76me8WB+UPvtdu+FcPMSLtX4yf4weXN8CSxQthXONLFj5303K6SfYoCOpH9XH8MvSEzc01Dgz4e2QSL/sg+tqfmvKLSGuzZbs7erDY9yrS6yXOvdy5kZ2Vx17Ei/3e9rOlddY/czLdNqRD7xhXN/7poA0+8mCgfCpWGjEJBKb09b9NBXZ0Djmvf9CJMFDya5hnOrw0Ax4LDYcPRtfnWFHkRM8ep2fSr3MBXPGXmNMcZyb+KFiHR9an5eoflBn+CZbec7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HbB+KS89MWVXl6FlHRAaFvpJMG7z+CI171JhMMCZR9oz+rqK6drLPX4RR+H7?=
 =?us-ascii?Q?ouLN5QJgFHxOCYKWwBIfFTeGWCCJmQXUEHTA6FF/0zWE3zUcdjGYvfgFJZKx?=
 =?us-ascii?Q?CpZ6kGA1d1WiGuhInth7wljMsXPaa1hvd9/oWUwCWcPneyHX0hd5922As+pQ?=
 =?us-ascii?Q?ARZMUZCB9qzd1X6nETygRRc6LcBCYWb6XZhUL3I9EpR2vJgbkHO5HMEh4LE4?=
 =?us-ascii?Q?Aa+dgu+3I1wG3566Lo8ejofxO8pU3ddOhOvTaZeyI6j+TJ3WjSe4ju8+eDXK?=
 =?us-ascii?Q?hsYt29qwbLXbQzOy81LUNrHsmcMFRvY9rPBJXvfcZP+r8FE+oOt4+3q/eXNu?=
 =?us-ascii?Q?btFbhFx2ei+61pY1hTA9YCsPZSzk84x8y5O5Ij9Dodni7ka0Ub4YErYstMoA?=
 =?us-ascii?Q?QFA43sfNE1IYtp0A0GLZgaADBcFHlu7rZIc4r+pJji5YDLYqpbg/PlIlGAjl?=
 =?us-ascii?Q?FI8e52IabkKuWMOMhz5y6IkGF5WSxtRqxQi/gcftLhi7P6Q80XmJFyqXfJIo?=
 =?us-ascii?Q?5yiDOgKLEm7UNGshglMJC3stdUKEsRib0euCIl7bZrcigZu5ax0YqPcfZs/m?=
 =?us-ascii?Q?RkYsjxuzfON1V4P58pfymmFoGi8DsR7J80dYN7dUx7rP5Vy0GAyIVpBd4/fB?=
 =?us-ascii?Q?3G2Ux3jCI9Xdhu3uE5FTxtsZ2GjUshIHDvOwvp1HDfoZ4qYbeb/RPkehhykR?=
 =?us-ascii?Q?2wt4VvZzRvsov4e4N/1BLBlh0866eperOF7QvcSwhQe/8fwnekPKAYuuWJxs?=
 =?us-ascii?Q?ldYUwZHTmGUQmRzK31lVoJLNAAWJTI8O/QbTemVZDDnSBo4D0KFOydoNgLNv?=
 =?us-ascii?Q?p5Vu+3/8qkSSYF/4dnJTZtHivvVlPos/N1wRorn0OmNBZM3NP1QhIeExOmBJ?=
 =?us-ascii?Q?6RsQAKNE5tSpOQsQIZsSYnJBieGo4uXYznxNEYGtlfKiFWvwtgRIWSvKwRRv?=
 =?us-ascii?Q?CtXdC30mfAa88mnlDuFgMGQxGG5rjiRhX+I1uzLOxe36q0ZADkZAvZaxXKtW?=
 =?us-ascii?Q?z3iN1wl4Wj1o4wdRlEfEUYYKzUtBBUgiU/nFrz1OvLdv7Zwe8iqVzx4R1G2S?=
 =?us-ascii?Q?y4UVi6CRzhLM5kMcA7eFBH76jZtIQS/zlxJ7ZzzCZn59oflRbkFx0L94m+aj?=
 =?us-ascii?Q?bQXcK1bbmQhPheF/8N7L/yOIyE/9rPE44CebHyDts2/maaijiaTYfGAQNg2S?=
 =?us-ascii?Q?yqFdoScO8vw5YE2MCJqStpW7C0S/dhPUm3lzCYzG1Eu7gR0hmlJJ8vu2fuxN?=
 =?us-ascii?Q?LDpPzESx5fulMwg+QWZ3NUa+sO17zr32AwPKp2kNURzkBXnUtPH778cjfK5G?=
 =?us-ascii?Q?k7LJEzQ+ClKhcY31xrHRbFsN6n7/D7SgTr4zaf1YI29RqfJr8xA/dzOawmhi?=
 =?us-ascii?Q?OLZ6XOzE8IFoJ/wut9iGdFgyKM9X/O8+Za38hMyvOE/+drm40W3hOrJ3bBCV?=
 =?us-ascii?Q?qk/ph9LONL9ghBybZCBpitDfihuKeEEWTQ+4tb6xaZtxtPj2eT3y/DiBBsl+?=
 =?us-ascii?Q?kIayu+/BU0anfowydb/bBA6WloM9KfkNd8AKti8B+0i7b37j04g9a9OD1e0M?=
 =?us-ascii?Q?TU58k32RIqOGkHWb5zp/PymKtmDSdPJbU3gBNVD26/s7ieHfqsGT0pzMizuw?=
 =?us-ascii?Q?EheYtWa8256C13kElJ4Myt/Gn/WzW5pce9y91pwCtGUkh8wu/hiMSiEoaxeP?=
 =?us-ascii?Q?M4L6YxoEjoW0+wYx6rXNTISi5s8ceoHBqiEnl0mVKc4KV3T2qihptMpZninF?=
 =?us-ascii?Q?vSRmokeT5g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88ba2b9-5359-488e-dd21-08de888ab552
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:17:26.4152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3GU6GY3/ugVx6tpGznLLJTqT3OlHGnjbD4IpJ3aanihuzfv5id/q5w46bKVML+bBTQS8S1Qxsd5w4yRzmLshg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11522
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

Hi Tom,

Please pull mmc-next-2026-03-23 for next

-----------------------------------------------
Add missing quote in error message in regulator
Support for emmc 5.1b specification
-----------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/29613

Thanks,
Peng

The following changes since commit eb00c710508d09b2a3b9aca75dd18280f1304703:

  Merge patch series "bootm: Clean up arch-specific, pre-OS clean-up" (2026-03-18 18:36:50 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-03-23

for you to fetch changes up to 9936e1083dd8c45cd10e7497bd83933b28096dcf:

  dm: regulator: fix missing quote in error message (2026-03-23 11:28:01 +0800)

----------------------------------------------------------------
David Lechner (1):
      dm: regulator: fix missing quote in error message

han xu (1):
      mmc: add support for emmc 5.1b specification

 drivers/mmc/mmc.c                          | 3 ++-
 drivers/power/regulator/regulator-uclass.c | 2 +-
 include/mmc.h                              | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)
