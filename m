Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4040BE92722
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 05:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA8883A8C;
	Tue, 30 Dec 2025 06:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=metanoiacomm.onmicrosoft.com header.i=@metanoiacomm.onmicrosoft.com header.b="Q/vOUUw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ADA183F39; Tue, 30 Dec 2025 04:03:41 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A931983E21
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 04:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jun.chang@metanoia-comm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVgU/LZUHKJgGgtij8Vch5pvXMlGChMCkxc1KLvZhYEr/vB+vYixX8fLUwXSUJOG5hTkO3TlFBPmtvJa1EBau34jIKYg/Z+7SWUwB3a5krgb1jHE9cGH8FSlvKp5Sx/f0KD2rOfOeEIgJIoPSIKQIuNSA1lUFOY95ZcjGkavsrIPdzeoWpSopf1Y8I4tWjfUr5cFHSwsA+8xATNHJPrlSwHZx3DtC2X6t9WQmdzp0sgqt92NvksWHndruLMkiqOQzfsyY7KUlX8kD2LhkE4z9m38/E3gKgqk6W4KFsdF/FShIylr7VoKNKTabkU2BQoFx8Ax7lD8eotYrCWU5ET4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYcTzmW5QdLAsw8/MXv7Cc3aTSTYCwdMpJo6MhgtU8s=;
 b=WhuvABWGelLHKgNe3Qf7DN/VSxFkNRtbwVDCXFJALNk8wgq4HyuFADmJv9sFwPZ15va99/9O2AOf14Jnoy3JGWnllxg7Xf4tlAsw9WOd3o+44d6ho5Z55KfCciTuzVlunH9VEq90CoIu5pa0h8+NoO+W6kIKJR6gwoensgoPucC9b/ezy1/spbqQy6NzvrMNs2cevJ88MwdJObs2xbKDYvBPysgWBbUkaQ9qA2o0Eitpbwmf1bOenCU/4lOLH5/+RVCuKvw3f/e9Y36Rg8chzIUGIwlmAy6N5YDQvJlwudCStHfZD7pt0KBV4t8Az9kFco5zL65UHk8423n1vkYugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metanoia-comm.com; dmarc=pass action=none
 header.from=metanoia-comm.com; dkim=pass header.d=metanoia-comm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metanoiacomm.onmicrosoft.com; s=selector1-metanoiacomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYcTzmW5QdLAsw8/MXv7Cc3aTSTYCwdMpJo6MhgtU8s=;
 b=Q/vOUUw+5abRuWYbYCoRkw8NDydKmCoBOF6ho8yIG0o9A/qfctItQk/SrfeYO+arqVa3huY0KGsrM5WJvdpXoonLiwUqgjGLipXuKsuzwown9wMexQJ8fJgwCuWu3xxepHCdGepaUjzen2DLqj0AJ+jpShiKCO2jE2KDffJtM34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=metanoia-comm.com;
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com (2603:1096:405:8f::6)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 03:03:35 +0000
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639]) by TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 03:03:35 +0000
From: Jun Chang <jun.chang@metanoia-comm.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jun Chang <jun.chang@metanoia-comm.com>
Subject: [PATCH 0/1] Add initial support for Metanoia MT5824 EVB
Date: Tue, 30 Dec 2025 11:03:27 +0800
Message-ID: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To TYSPR06MB7207.apcprd06.prod.outlook.com
 (2603:1096:405:8f::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7207:EE_|TY0PR06MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: ccba1a30-c8f9-4226-d3cd-08de4750057a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6F3m8iskcuO6YwG34ThMn0NCAg8WzCdjcLQv2YxQs4jxc+B/S8Iideu63y0X?=
 =?us-ascii?Q?GNNazC5WtN3YLoKmoOpbeF7tx3cL918O1/FNCiThFIICy8/bIVTrCWbJYVzj?=
 =?us-ascii?Q?uD+VD8vRZijl9rjPwz40dvEd0tW7NP2kaHwVxc9IVx853IxTCjg1x+dnk8yD?=
 =?us-ascii?Q?5FT1sKKRlLmAIj7VN81LuK8pvK0L8mY2F+db15xvvRY8cIuKbyx4b7hjf5sT?=
 =?us-ascii?Q?S3zZqK9MuzbV/YBTsS90c+iphOy9IV9p16Mm+TCZXGzj2sO+trwrOQwXdP8c?=
 =?us-ascii?Q?7WkJYvLdMARLH9iecSDMA/aHmVBeohUAaCsAX5qvC0a7t8TfYUBq2PW5bJNT?=
 =?us-ascii?Q?DwjLnIAjiZpUbnxqEHi1ek0YBZcJXvrnGR8zdd7o5nRTFHoNbel1Q/STVw1v?=
 =?us-ascii?Q?mCEzJdbtJP2ygsoo4tCN/zdh62VyigBZIaVKg0dRhc3VKAdYKdIhVzJImJ2R?=
 =?us-ascii?Q?+SUUErTt0cc4VVQXXxvWKzEmyrn2UCVX+eJcLTF6f/azXX3RJsiaqwfYWl6x?=
 =?us-ascii?Q?fmgHi2gwZYKWVFEfK/+6SSPV6WR4Z+Y8QC49RrsbTK3sjJZ1hoG7FcfDG66X?=
 =?us-ascii?Q?/pj8IHATKHts5S2ZpnEwNy6SxujTmAFh1Hc+Bs3XBozi3XImiPfuMtDoTb5o?=
 =?us-ascii?Q?v+pSBYbmWhYZLHgJieFH0vS9/hx1cOAyLkxOujFGKTupxtf/dMm58l+Vscyo?=
 =?us-ascii?Q?oRb/XuRCo6pB0hwcQoGCSus4/b9urrq6WTD6Wlk9nToKydux/Sc7lwOQF7Ar?=
 =?us-ascii?Q?6f4p29eF2nCeyfG8iRyAkZT6qKcVTc4W+zGIueOss7OZaSZpU1P7ut81/P11?=
 =?us-ascii?Q?pNovc3hHFdv+FuB4UeLL1O3hEK4g+T2s9OpeRPs96tYG0lmfIcLqu6f/0SdF?=
 =?us-ascii?Q?KadCHZ0bwEl9V8uq8fcjzDh0D0cW2x5hungjU8KoQWfavXmES8y5d+zKDmpn?=
 =?us-ascii?Q?bfJD+teSsEwB7AMd2x6p8F4KFMUoS5AVAy1smPnrSMRqSUWi1gI8A487bSp+?=
 =?us-ascii?Q?RuxK4Ive4hS+VtWKFrp65EVzwjhf+HqtkXoa0Jr+urBNCWpQv4+iDsMPaRbB?=
 =?us-ascii?Q?aK9ghgz07ZHcP4LyTUUW89ed2tJlCg2R8i7DmLK6byNI/bl4SuEIDNQOl6Xo?=
 =?us-ascii?Q?VUTdQsIRCeRcU+wbRapYts2u57F9irGlx744duDn1qkkJ1UcEdQAHdZPLRjH?=
 =?us-ascii?Q?pIVwvNI7cfc9Ev2M8IOXpDkLJ+8YHcrgx4PvLmWh4gZLrScPpTkENjGDsEkG?=
 =?us-ascii?Q?s+kTjPR0ze1S46jvYDHT9WAimKfJscAFojcQUEcr1qhcYitvchwpUYLH4xPy?=
 =?us-ascii?Q?2ucs9aGbLLXCNAkTEinbZKg2WS+Wku1xCHm1zO6ZHrpy50Uj9GD8vDiGDrlX?=
 =?us-ascii?Q?G5Zjq0SlOewOvfCc3j7lb+u04mjt+Q6ubw5D15nLzEy7CothshbjwfaEmcqc?=
 =?us-ascii?Q?Xd8g63MQrw5pmhIVp5urT2hsOW3Mfq8uT7mMN/6PPn7IHk0st8tIRiS1NleJ?=
 =?us-ascii?Q?Gbi1QfDnzz7uDZCdE8+WUmvttW9nwskNuWwM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYSPR06MB7207.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3/FeeHH7Fh9PR0L6hR3psAzkFXrQmf4ji2w2xiUViA3tTHXxqTp4hSBaPNb?=
 =?us-ascii?Q?H4p1nSwTY7qvZRVFW79iYJqoxN9ixA33AplRpz4LCA/QJsFfgLU8hdUqm1W7?=
 =?us-ascii?Q?vZBvMoyTbbgVvyfD+XyTElNXeLd4eoRdi481VP71qPKi1/GBmNoQ+/6GhANq?=
 =?us-ascii?Q?LhZDKCGm2C6sVbAEWPT95x0i8Fl3HQekqNZdQj2P8mBEkhwJ3x7NEx/tKq69?=
 =?us-ascii?Q?IHeSzGDK3z2R/JVzE5GempUxrzUyUGDzdh6zWPKmGufSvOjyA/Lye8MoQWeB?=
 =?us-ascii?Q?+k9xVMQUtudvHAWNjvV19+a/52dBK+6i2ZyhmGl0YNFl7sxiJrUdWGq82Eue?=
 =?us-ascii?Q?ABZi4K/i42l1BB4wPpPAPdMn9nUurh8RhkJVbT899TFQmMz6lwwnBm2Hp81n?=
 =?us-ascii?Q?HlHveHpJfGFwDhkxLKzTsnTNzhMmidUok68I5Uqoq9T7coKlXJktM9ekCG97?=
 =?us-ascii?Q?5sYdc/b2KpZVRyt5GiICuIVTrTS+nSdhEs3fkg3qdG3lfb29iORvrm7r+aNV?=
 =?us-ascii?Q?P3b1OADW/KEgSo7qbBWzfGSQyeUjtwI8S4zIKmZ7jS1krotCdGnMn1BPYtNA?=
 =?us-ascii?Q?anR6i3D+ZXxhOQ4FhnObmkp8yMv3vryqMv+y/4F9CvAjG6a8G/DAwho388yz?=
 =?us-ascii?Q?fN+9j8+6EEbEcWgBD3H4uJLT7jvg5DRaXJ0wYVVBnmMecuHnRTN7n8Ed/VA5?=
 =?us-ascii?Q?xLxw6TWvzIxihUoit1KXt5D2+YOpv5lI4YgNlq0RndGxZFmi9O7Om/Qnsz27?=
 =?us-ascii?Q?GwXdE/dGHlrY7rcSQNZycLYPPcrgEITyKQNWbRZ9LjBnNB0vD415e0kkfdFU?=
 =?us-ascii?Q?gS7S4DA3t7BFvTic5jWC+OHR7ry+leZn0Q+icg7HXGVrAlhzFPnZEufiyzNI?=
 =?us-ascii?Q?36DjueicHFAmK/aU3+1FLL/V0YtvWQ2Be1tz5MKsaYaKq3rE9DPBwsPKwkF/?=
 =?us-ascii?Q?fij8Tx6gtE5WcN8ei8iRxuAuKjX6SWTa+N8LUmulGurRbbarOy2Ckz1KmDPn?=
 =?us-ascii?Q?ZJuIq8b0fx67G9/toolxMgdexSOe6s6C8QJMUpe+k0euF/0ej/o4KXcCOeDA?=
 =?us-ascii?Q?/44zIiqfdFbuwzENtH8BEpqmU+3W62nTGITTQRMvJ2tqC8Y8QIS2OAHej34P?=
 =?us-ascii?Q?ffXZokm75ojACAwcskk03m87cU+EgcYccipo+tO+kgR+kcdZbm31hh8Fr0zq?=
 =?us-ascii?Q?5ZbfpLX8/BYIUnkFyNrI6jINxMCQIzE13Y/C4pB8MtUJcd66g5ysDAHkhhtc?=
 =?us-ascii?Q?ocLeZUwWFg0mIVK+hJNjRR9Kk8izK7fYulHhE2G4WIP7W+IKei//Bulkv3UN?=
 =?us-ascii?Q?LnNyqk4/X9fgmVJdQt9g9Bq8GGB3jWWDl/QbaWwDh6NXO8OEqrXwXAOH4kZE?=
 =?us-ascii?Q?KTy7GjGr9sp/EBlRgvc9S11VuCR6IAvbVnz6EdQbMy5BXboS7GbpYkDo8OoI?=
 =?us-ascii?Q?nkQVLYfxxRvFZOud8/IHuZVQF250ugZ4H0mGSnKBoNDFTbX4U0ybeoObK/r5?=
 =?us-ascii?Q?Ai+8Uv4NdEZrCJA6l9BENztZSGVXKjbXgcS8tqdgiL6ugszimKpFeVZFFAh5?=
 =?us-ascii?Q?mkcgo9/KWr8j1cLsO1+7lWbSaQIWaN0ash0kpcieOA1bYOPUs1G7kKYGir9I?=
 =?us-ascii?Q?EDffJQaL6uiE3gFHE49QgCVwi2IQRgepNMEIN4A38MhhYooL7pS7VlJ/Snhe?=
 =?us-ascii?Q?pIdnvRBZR4gizhlpl3Tb5IVLIw8e38Bmwzgnux1A5+/Nqg1UNo4x33GNvXwD?=
 =?us-ascii?Q?RV0zXDvd0uubvIa5cFDTnTmbBkYWHaE=3D?=
X-OriginatorOrg: metanoia-comm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba1a30-c8f9-4226-d3cd-08de4750057a
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7207.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 03:03:34.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31a25295-9a4d-4cf7-b9ce-e250507bb0c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLMQZzFpSxog+aTEsY0rBMIvpEu7r0K4JFIzgE1rzjPnny6Q+4SPZdTMyKDjrynJUvHLYSphCQtN9+/PeeGpEDkErsf5WqW2tWdvdyOnILw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
X-Mailman-Approved-At: Tue, 30 Dec 2025 06:30:25 +0100
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

- Add RISC-V target for MT5824
- Add board defconfig and DTS for MT5824 EVB
- Add SPL and U-Boot board support for MT5824 EVB
- Add DDR init for MT5824 EVB

Jun Chang (1):
  board: mt5824: Add initial support for Metanoia MT5824 EVB

 arch/riscv/Kconfig                    |   4 +
 arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
 board/metanoia/mt5824/Kconfig         |  49 ++++
 board/metanoia/mt5824/MAINTAINERS     |   7 +
 board/metanoia/mt5824/Makefile        |   7 +
 board/metanoia/mt5824/lpddr4.h        |  91 +++++++
 board/metanoia/mt5824/lpddr4_helper.c | 352 ++++++++++++++++++++++++++
 board/metanoia/mt5824/lpddr4_init.c   | 115 +++++++++
 board/metanoia/mt5824/mt5824.c        | 188 ++++++++++++++
 board/metanoia/mt5824/mt5824.h        |  21 ++
 board/metanoia/mt5824/mt5824_ddr.c    |  54 ++++
 board/metanoia/mt5824/mt5824_ddr.h    |  12 +
 board/metanoia/mt5824/mt5824_spl.c    | 141 +++++++++++
 configs/mt5824_evb_defconfig          |  61 +++++
 include/configs/mt5824.h              | 130 ++++++++++
 15 files changed, 1464 insertions(+)
 create mode 100644 arch/riscv/dts/mt5824-evb.dts
 create mode 100644 board/metanoia/mt5824/Kconfig
 create mode 100644 board/metanoia/mt5824/MAINTAINERS
 create mode 100644 board/metanoia/mt5824/Makefile
 create mode 100644 board/metanoia/mt5824/lpddr4.h
 create mode 100644 board/metanoia/mt5824/lpddr4_helper.c
 create mode 100644 board/metanoia/mt5824/lpddr4_init.c
 create mode 100644 board/metanoia/mt5824/mt5824.c
 create mode 100644 board/metanoia/mt5824/mt5824.h
 create mode 100644 board/metanoia/mt5824/mt5824_ddr.c
 create mode 100644 board/metanoia/mt5824/mt5824_ddr.h
 create mode 100644 board/metanoia/mt5824/mt5824_spl.c
 create mode 100644 configs/mt5824_evb_defconfig
 create mode 100644 include/configs/mt5824.h

-- 
2.43.0

