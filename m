Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C97FD45F9
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 02:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212C783C54;
	Thu, 26 Feb 2026 03:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vLCaBgVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA9A83D1A; Thu, 26 Feb 2026 03:29:46 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D89083642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 03:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7VJzU1BvCoD7v+zrj5fRsppnHSXgW7x3XNtMZI6TWRg7WQ6ABtFilqSzru6c06FD5VKpKnQAdkyNurfbH9t24hsmAlKTbXcdhk+cFzMYykZf3P1/xrLkxPrcJnejJ6QBVAVv2BX/gXJ8sAiRRHLqkcNT2WWm1fjAqjDXsY/fAHKkgrZeYlC9qv5Ir8ZhEowW72rFudhyo+3tCCprCZ7c6ZYjo+HuFyJqLCcGWKRg7scyU72z4lmrW3CWKl4+HKj8FgWLyOBkDrltsiRVkYmx7VQSuN5KQngFdB8b1uv+a65TNohjCaajexQeB+PKItj7BUQ3UTRerPhIhs94rrx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Ssj9ouRzLRg5nj4z06UTnY4ZTbxXDzffT+5vb8xps=;
 b=EfR/4BJaKOfLtYoFRU3IxIjCaHDdghkcLfOxRY/7FA4+vwnL3zCK1Lss4bMrSuDAH0a2Zywr67t/VaKC8GZqV2T1wjiVvSyjs3MbKGeVa12OviOyOoX7ro5xDdK6qeZ2pdBkbKO7bqyP2gM4F7m+LJB5fDgmsU7sdIRNeIBjik0308Z1ttFMvOkhHj+U+ZDuWykk/u4ukkEnyPYJWBLm0sfPlyM/8R/vE4FA/wn8Mh/KwbumHNwhxARE2gftjPRZf01Wo6bD/UeWDXk6lTpDN4IG/dhSyq+2VJxL/nYIUI/LNaLxPUMho2+QvTqnsaKLsiOyW1JIqI74npKufnTiUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Ssj9ouRzLRg5nj4z06UTnY4ZTbxXDzffT+5vb8xps=;
 b=vLCaBgVG6frhxwYaFNZ+OLBPDPPfYOu1RUSy1tK9i+9C/TfOx3LDrHOW4bfHZqmWzaFawwcweLK58MPJIp9LNzQtDFssMoRkyqlNJlxC805oip60RNbFzQBS9Rl6Q88VJTrbVrewXoptl+vE5IMpdorssvQ2Hm/m5bi1+hPOj79wE1f9pgOYH6R6kYHDsjGnjJMH2RMYJugq7RZ1m7MeHIL6zm5JwM8veM/qSU3MMPRfsuHLBB/quWvd/DziRCfIs1jV/vddE9f4rzbyuFU5OhBJ1duYt7fcJBBx/+ouRZiTuFf7FgsPEP3yR9QVSo74MSRYYPBmh1a9NOIgkVobHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 02:29:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 02:29:42 +0000
Date: Thu, 26 Feb 2026 11:44:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull fsl-qoriq-next-2026-02-25
Message-ID: <aZ_BtG4flBy7oN-N@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 80eb4091-84a7-40a3-dec8-08de74dee5b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|19092799006|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: I7pPLct8zFy7hxeGnIWUxbUsgEGLsrsbTJ2dnfEngZd0D2dxuw3rLxsGHrgS+2EWqYdx16GiBR98QrNwjwKBWjO65BaJlk+qcKfxdZKfULssmYVnFopY+h5FYtBZuJseFbbm5HWhkFl3u9ttGaSCYxyHdXYKSryiMKBGp4GRqO+Wj0vlIvYwcD0rdEBph/bzCh0x08uhrsIVVcBePXRu67Qk5lhy+CMo0Jnc1pieMVOLdXr8D5IYm5EWdcinuOd/Dgf+ZqP0PoEVM5lo0dTPmhPfT5AtwsObzXXJufYDPSFxjDFNbkL8bxsHVZZ1LGkvvCsfJc7oVdAwtdZ5MSVzXSfiGgGM5osl5aPlEsamt628mKY0vqkMhl9njSE2c0SHEVQK8TiItVhtGBTCTBswkXRetvjT3bncheC9OA1/iXLbcn8LyHS+8I/0jUHFXPiLKNR5GngdOzm5Q3ual1sSxsElrCk/NL8BE7SgT+HKGRGSbG7cG5aZKdpVwRJ0SoRiwc82rgABJgcoZr+QFfWjpwSQ5jlU3CtLMzAsA7SHI2gmo4uttJvXd4mE4VHRPHHYLlKEIbmrZI4QHY73D/d+WOXINlMqJtGpGwnzb6L+Blg50aJo27pHKPD1+1hg4mVEykxH5zraq8vJWPEaO7wYQ8KC/HYe0aD5MQQFDkJOBn9erSJDNzyWWXSvWG7cBzvclL26BQfX9+a5ifRNZUegHAitffGYjpr5Et4mlggJ3jHUkhG+WBj5YIvol4wOQWwa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iZ+uYgIPcb6F3poO1Ll5oUdVFuJHNoKvFJTMNQPnELvmqkdXMHSrJEtuidz?=
 =?us-ascii?Q?eJIkhYrNcAPTuXSIKINGwnCUPrTD9eklqU7NTeyKfckcHlQoPgt2+N9D1lu0?=
 =?us-ascii?Q?YQi4RSSP3mBU3pjTysZK0e+Yn1PYWUEpPGLv+J/c9Z+DxAPCYlPE+3XIo6GY?=
 =?us-ascii?Q?tpsnFd326bClYeofMkJDMWJnee2Y6J+hq8ht1K9rr+/RUhbSd1qs0xRDoKzI?=
 =?us-ascii?Q?TolOsqj4+ukPJz/q5sNnNm3Mq+sY6BvCpzNFu8lELWpwejKqiOXHx71S9COd?=
 =?us-ascii?Q?7HAePlWq7P1aoLCjDdoj5OWkKWN81sOlk4rbXJBD8GoHm2syG0GAlHYM5iE0?=
 =?us-ascii?Q?tdL3HAQ9LVGsXi+tswNxwCeeF9JXBTj66F6Mo8jYnGsje+dnErngKYDrKFJF?=
 =?us-ascii?Q?Jw2iWqydH2rm4GQKq04yrzkcZ4HiDYOo5ZRD0nklg1tEgVJSpM0EcNE9FORG?=
 =?us-ascii?Q?1SBXx8SmwHrhjrl/sgHf2bUJ8dyO/gEkkKjc8U52izbm3gWvOy8b1rYWVBJx?=
 =?us-ascii?Q?6j5WvDdjS+LrrekxTOvDtVaCDTM9ooEHqp2+In5QbqESjM4BcckqYP7RH+AW?=
 =?us-ascii?Q?W+yHeRP9StA2ZL6qf+dDN5kTzrZkVPVGpW9KcIwCOnR7wC68pM45dc+KOz+l?=
 =?us-ascii?Q?V4lwlTYrrmupTrx9hhphqlNiq7WRqH5u5WwrzWHpTrHujWU6KErdfXYopHnh?=
 =?us-ascii?Q?it9GRgg+0jcXy7m3z7R4SKnic9oneXqDEcT8sMAyv7XPQhk0GksQbvxyQLqF?=
 =?us-ascii?Q?vgrgBOkzgAnLMrRI8iov6wOHN3H/LdZCqAzs5EfgcDoSTEMxwrseKWTRMFnO?=
 =?us-ascii?Q?nPaL6BczMawr1IQ+QP/upGXLxYMEoTweqG5+84kblt86gynOGzdONWvAkpnc?=
 =?us-ascii?Q?gS0xLnlkX4DsUT1ut+GThutj4PD/nvKt/u4V/3Srvivt5CUyA6Zi4cgWaQtC?=
 =?us-ascii?Q?Y675VuX+edWmn88AR+QS1Xs/EUpUIr7xFK60GFGCDeb+tsp8WA9xEiE0U+97?=
 =?us-ascii?Q?uk/dbVZvoCzBPLq5oJVasvmAMGRTBdwf3PS8vz4OQkHu9fcyyEDLwUpkJ3yF?=
 =?us-ascii?Q?TbtnrJI4En3u5qYBm8cO4+b64zaWGvHdLiEEs2DkzfQAZNcy0VW0LLELCQht?=
 =?us-ascii?Q?92HfL0W8+K6TMpG5xKUVbYotJMzQW19FQ1YIERCGOPryFNsipCJZJmSFXbPk?=
 =?us-ascii?Q?K87fbQRrvjU0cDvYrgbIH+TEleRzxJ838aDnoyPMzqBrTtoodkOmy/tsUy9/?=
 =?us-ascii?Q?1OFkrfC6ARLN/cNgr7fuZexUNBR7FtI9H6TCTM5vGHGy5V8ZcjGLoakuUnes?=
 =?us-ascii?Q?zaouj7mEv9G7LvCfA2/62UYGQTiOvb7nugNsbzhm/pMkr6FSVF7Uqt2wGhWm?=
 =?us-ascii?Q?P20rS7LOu8xU8do2um2KZlR+QsPebwyegrctahkavLTFPxfloAeE3rjEND9R?=
 =?us-ascii?Q?Jya2fSswXbomH4nzIOX13V+fKQ319/J8vBIqWqbf1GyUDYnI24zeOKPDlV/h?=
 =?us-ascii?Q?cvnNz5ynvRE/w5L0HRvzUKH8khKF/It8SBg9BhPau6YC2yDk1S9HoTA5qdDf?=
 =?us-ascii?Q?Lqgstj73v/LuM06simQB+q2sLgqO2uBuU1fiJvOR3633Oypk06U8AEra6J/U?=
 =?us-ascii?Q?uQigXwoADvPCKn7HtotWK4d7IoNSplcK7f225bRao0Bj7YivUUOgfDRk2T42?=
 =?us-ascii?Q?EM69U8WXvnW9acxtYAdiEt3HdxcN9vftAYEzOVRH5osWQ35aBHAjvPow+PVG?=
 =?us-ascii?Q?3Apu1ENyhg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eb4091-84a7-40a3-dec8-08de74dee5b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 02:29:42.0593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNZKvy3FEydvjViYqrfwkzYprrW4doENQVjDbis7YqUoL3RobWNwsynsuNSOMGyhJF1WnP74DYazg99cY3pwRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
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

Please pull fsl-qoriq-next-2026-02-25

--------------------------------------------
For SCMI, Power Domain and IOMMU,
validate device tree node before continuing,
to avoid boot failure.
--------------------------------------------

CI: https://github.com/u-boot/u-boot/pull/874

Thanks,
Peng

The following changes since commit 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715:

  board: Correct usage of fdtfile=CONFIG_DEFAULT_FDT_FILE (2026-02-23 15:30:34 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-next-2026-02-25

for you to fetch changes up to 52e57859dfaff2d729c9f2b03cf9d994b9731bad:

  iommu: Validate device tree node in dev_iommu_enable (2026-02-25 22:21:03 +0800)

----------------------------------------------------------------
Peng Fan (3):
      firmware: scmi: Validate device tree node before setup channel
      power: domain: Validate device tree node in dev_power_domain_ctrl
      iommu: Validate device tree node in dev_iommu_enable

 drivers/firmware/scmi/mailbox_agent.c      | 2 +-
 drivers/firmware/scmi/optee_agent.c        | 3 ++-
 drivers/iommu/iommu-uclass.c               | 3 +++
 drivers/power/domain/power-domain-uclass.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)
