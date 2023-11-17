Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84312C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC84686F7C;
	Fri, 17 Nov 2023 12:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="AC7aXXOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F409874CC; Fri, 17 Nov 2023 12:38:38 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1402F8700F
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYSQRg8gPIWmj9+BW3wS5g+i5A/em4cfMmxT5jsdOYO2NvOWMTtt23S081LHGDZ+WgugwgkKvGxGil3FgMgwPYVEARYPeE9q9SrChHbUnsfd4MtLWBYupv0psuRlv8S6r9WlIv1anv2hZC6RogNaT7nG+uoLjDjgCHdNiE9QL7QcP7BiDM2crIjIkJdcR5Urm+bgg/7nzfGcMMBGX6Pp+6DQcyLU2OAQk4nezQ0Z0OVCKlTNKMXg1JqL3ZV7ZcJCWmP6QCzGDiu6FFEQEF9kgvPasi9b/wSHi39LwHjhnYQ+/KgOkNv8dp++yGrSo6kfkKi951AS6lyFzHIS5l+Ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXFu3YiUcWPoo760f09aohTJrzgxZNux8JAr4QqwshY=;
 b=UKlH5ze2N0RHkm1/cqMoOxTSeV0R8/UASThi7e9AMSvWzI7pQmn2/nTPqijtoSMy7mV0VlVj+QlgoJAjDD6DVD3Z+O/cpOhXn2nBMy8g9K2JyLIWgGcEPjlSr+pPKtBWwoGzmBXSj6L4pVLjJLNawgZ4oVzjsh5AxGW3vjCoKiq6fe0rkWNJUajgqLIZcgCq9faLgQYImJft02n7v22s83DXnegCgrW6ppK0J+5hv29WXQeMTJah2D/IG6louueNVxRyiCptDO3K1StTUbGZOuCHswzwcFEnqINNq8oewgmrlxpyXVSY3onVHq8igWjnIIhul7ksw/H6FbRFun1r5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXFu3YiUcWPoo760f09aohTJrzgxZNux8JAr4QqwshY=;
 b=AC7aXXOmRpVeyC9FpmDTqJEeGijsGZOEofNMFLJCPuDT1IEzx5KhlwrgzrhWq/e7cKZAK48IHq4sYhQObyGb1LDt3mkRQly3PWy9fbMLp7nCtKW/Sx+5kyZzSkmVJOx/ZpubS9LxpPHrm+WrwLcIVV/fHBwC5WONHVpX/OCdiao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 11:38:20 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:38:20 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 0/6] some LED patches
Date: Fri, 17 Nov 2023 12:38:05 +0100
Message-Id: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA93.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3664:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9b7968-a3c6-42df-6404-08dbe761b2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99346qXMUsQ/CAD7S9dHXpDVYtUPqDF1JUz1Imf6eIhB1F8NP8oqmnuLnAHEuFHpFl+amToxy/NCC9vQgF3Ko/ySNIc+1qLU+vAa+n3kueFVBalgFp08G1EnhntIBXTttm6C3+ckivMmOuKKgNZaKxPJodQBiT+AKEqafmy3qMlE4j7tZUDT7mFnQarVPdeLt2bKgKL5/Fo8fybZpfLVYsGH/FdAWmUJblHQRAv28pCLGGRE7jt3avifqQG5EIwyZcGCRmPMuxzGrlOFrtw7LHjtihJGdh2PUH88ToZDhoFOBcvlQ95NZHVSa/NF4yyomNWZOifwjuMSKl1f5YDDEdZhQbMBow/v4GVTvrizeBpFIV3cZR4o+2yW17Jf83QtvnjaCl/JZHepegA/GzWjoLw8b6TsdBi3CrWxadxqOay8THfCPbZGSlrxgQIPs4CBpphesLP+LYtuwyQ0TFMrLzcZ2cxvrFN+EaCMERR7EZUyoO+rDUaKp+5Yu+lQZsKLir+/2pjQrR1v+QhfeIIDqso3tpvTWokOTmFV3+Z/+pRQwOVTvGgpJLgGZKUOIXSuBeF4j2GZKoSwX7oPW2EuQhnxLzfLjFPU5c5X9/JHfXZQoKmKHFW1RO/xPGIdLtpB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(52116002)(6506007)(6512007)(36756003)(6486002)(41300700001)(8976002)(8936002)(6666004)(107886003)(5660300002)(86362001)(1076003)(8676002)(4326008)(38100700002)(26005)(2906002)(44832011)(83380400001)(66476007)(66556008)(54906003)(66946007)(478600001)(6916009)(316002)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERa57LatEZi2GHxziCuPrbwNiyZhMo6kQlv4MaBOMw86ui0NiZ6zl9cQdZtB?=
 =?us-ascii?Q?1W9/vCPxtT6cw+No8VFw6lhYFFB9lr1FuiXu+R5/hYkisvFXZ8GuhUKAw7J1?=
 =?us-ascii?Q?YeEtWRO1y5FQhhfhB05W/WeYZ/Lki7JXqSD3Qst473iUOvSedkK42kkNpJRg?=
 =?us-ascii?Q?l32CxL/3yzCR+35WFZOUYwSUvZtJ5TtVgK3hd9CoGkwlD5n7v+eGb0ha6wCC?=
 =?us-ascii?Q?A3Fhe8lmEEwrMJHHTuvqAjqB7kgHibwK10R25CXRiEII1VOy+mkptl2+H7Wf?=
 =?us-ascii?Q?bdQHx6hoaJChk3mKibmRYfMGRiAFIne/tYOenqwE0ZCS2L6LOoH1VFQ0oc+h?=
 =?us-ascii?Q?C+JoDXwzKGHN62fNgfAF4xKbvqclNMnC3o59F9/0wWre1EPU8rWEZIO8rj17?=
 =?us-ascii?Q?gtGHYp+lBQcsRfpePsuvhmpsv+8b5/pELT0CdD2WRDonaY1xPTOmF71NMRr/?=
 =?us-ascii?Q?sJsvFRjSDNg8g0EhxdmJHa9IYLqPyfLFKGYXVgwwmoM8YBVZ8rvhnnAWrwSW?=
 =?us-ascii?Q?a6dq/80xVuWyVDaS3HrP5GDvSxomIfdMnr7/rIoiy4iSE0lAiFMPgMGPR4ne?=
 =?us-ascii?Q?GsH1nJP9OgfkmtWYGis/nxhFRnsDldvNKeYS0KX8U5UDOSDlv/t03GcjMqK5?=
 =?us-ascii?Q?F9BkscreAMiHCI/LMYRwH7RCc8AdtFkP8QcUz14SUwePgKzQ3vSJkIKjni7F?=
 =?us-ascii?Q?UZ50yYb9QZye2hq3bpJUgh65gIl/Z6hHY/rv366bQTa+J7JCnru64uYz5Dio?=
 =?us-ascii?Q?LfkR+sef3QVMmQ8qHHyqZTGULUL7HKPK0jTCillEf80mz/V1NQn0KXcCCnLj?=
 =?us-ascii?Q?4ue2R0UF/JJJGa+zhsmPd7e/uwGOmad1DDsdDH2leQGaW/y49odM9CzK7aPP?=
 =?us-ascii?Q?RyGPU0B8aMANcLhd362IYkK1uJtFSXNbwzZZmaAzqqOmWogW1qMtpSh9U2dK?=
 =?us-ascii?Q?XZ/nQva4UwX682Afez1j5HUqvKujkwW4+fhcZJI4QAhRjK1cJ87LvMxTI2tP?=
 =?us-ascii?Q?BNPh5p9hlkAWsd0Dk+WuOesmGy5jpp0tQvekjTB4plb1NW783o9hpO7q8Ek9?=
 =?us-ascii?Q?58oz1dePeoK+aPKtuQ5Sj/bvHNhSH0j6Wbe1F5HmPcd5qYl5tgH1Xfs/XZNA?=
 =?us-ascii?Q?R2ZWcy2eOABxTTKf7Pmrxdm3Ztq17294qkmv6FOcnjVhGyRlocmf/mUmVh3T?=
 =?us-ascii?Q?IokZMerK7KfpZsO0T1S6TVNZtPFGkn7Bn9Gq1Wp6TzzQR4skUMWz2rZ+jd1Y?=
 =?us-ascii?Q?xxMUWKiz7PlSZ4bWQ7BqgQvKtjVNPSfTdvYk+O3g+1VsqrzHXTSPcHRVrwDW?=
 =?us-ascii?Q?gdmxnHbxpmBmgJSpPz3nqWb/XEt6AWY5gkgRrVqBna8LSdFnAo86bTa283gp?=
 =?us-ascii?Q?W6dAOFSwTTLFNWquHHYaTM3js8UZGmyrpGgykEYqMnynx4IPwNrtfkNiQ6uR?=
 =?us-ascii?Q?8crzh+RYkFhyMtnsXTLA5zv+8pycCMdpCfNltyeE4Pe94x4mdRFVDK2ynxZy?=
 =?us-ascii?Q?720U0JOhtIvuSGFMiHjgdr6dFwV1gekmcYejrvPOd9B5m8fmi2C/y5x/7K7+?=
 =?us-ascii?Q?HwobYNSxx0D47W7zUjeGL1gFd/VA99tw2dB1nlDp6xTaRZyJ66q1q0gfdJ69?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9b7968-a3c6-42df-6404-08dbe761b2db
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 11:38:20.2803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX/i1RL4PbnP+RJVS7uq2g8+Ahpt4aYS3eWlzF4O+rhenPqrdshXyK2gApKd8gc2f0BCchxIPotImeartJJRPNjaSZ1rDqszlj55AN2GmFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664
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

I wanted to add support for ti,lp5562, and found an old submission
from Doug. While trying to modify that to work in current U-Boot, I
found a problem with the "move label handling to core" patches.

Patch 1 is a prerequisite for the ti,lp5562 driver, which turned out
to be needed by Christian as well.

Patch 2 is an attempt at (quick-)fixing the mentioned "move label
handling to core" problem. The real fix consists of changing remaining
drivers to not bind the same driver to the top node as to the child
nodes, but I can't test those other drivers.

Patch 3 introduces a helper which should allow removing some
boilerplate in most individual drivers, and 4,5 apply that in the gpio
and pwm drivers. Converting remaining drivers is trivial, but left out
for now.

Finally patch 6 is the reworked lp5562 driver. While I've changed it
to match existing DT bindings (with the goal of making it work with
our .dts that is known to work with the linux driver), most of the
logic is unchanged from Doug's original patch, so he is still listed
as author.

Changes in v2: Interchange order of patches 1 and 2, add a few R-bs,
and try to trim down the commit message in patch 2.

Doug Zobel (1):
  led: add TI LP5562 LED driver

Rasmus Villemoes (5):
  led-uclass: honour ->label field populated by driver's own .bind
  led-uclass: do not create fallback label for top-level node
  led: introduce led_bind_generic()
  led: led_gpio: use led_bind_generic() helper
  led: led_pwm: use led_bind_generic() helper

 doc/device-tree-bindings/leds/leds-lp5562.txt |  63 ++
 drivers/led/Kconfig                           |   8 +
 drivers/led/Makefile                          |   1 +
 drivers/led/led-uclass.c                      |  22 +-
 drivers/led/led_gpio.c                        |  15 +-
 drivers/led/led_lp5562.c                      | 578 ++++++++++++++++++
 drivers/led/led_pwm.c                         |  14 +-
 include/led.h                                 |   8 +
 8 files changed, 681 insertions(+), 28 deletions(-)
 create mode 100644 doc/device-tree-bindings/leds/leds-lp5562.txt
 create mode 100644 drivers/led/led_lp5562.c

-- 
2.40.1.1.g1c60b9335d

