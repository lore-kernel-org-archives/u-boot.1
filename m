Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059ADEED608
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 13:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1629C88FA4;
	Thu, 12 Sep 2024 15:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Mil/EeXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DF788FC1; Thu, 12 Sep 2024 15:41:47 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B6B088FA1
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 15:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHEY5UCA5ctsLQL9CpbGbSIhGZ+eDdCu/mysEtQqsd0Ds3s35WTaAaAWndzDQ0h+7QDtfef7WsFVE9864CQYfnViXwfub0a8BQKlm+6gaoqePKSEOPfp/aygrwXPsu7iL6PvQrJvTOnT3NF4h1TppwF3knvc4DgdEIKH3XkqP9fIorQIGRhIw517HJ4bubY/x8E+ug1+xPYd2c5+QoZci6tpZpPyT6joZZl1Q99RdQD30obnP0k0PT9l2q1ThAdtvoXWR0tLfOA7K47Yu9PXAhpCNGB4GK+eGWMptxxKyXxa9cqukL9jWHQSnEUohvogZuGbFVg4Aaj8lKDjPF/tyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptqGqmXAz9V5xEINM3Hj/CdALzOe1lsLRSHTjBw6Sp4=;
 b=UIUHrzR2apSwjtx5G5pJMV2nJE0TAs20Hw41ZO7tTjgqvvK4xr9tazXvnkg8nKOeoq6dZUYd6W4uT+CuRZrVS59bJwspcwwCBtq5//gVm6RbJl0YVKIRuIBa5bLXCvpOmHfG7CBrkSm4TDd1bBhNb6Wfk8cMxCt5kFzS5CuwseXnD9DRPvaqbnWLguWcegml15G0KBFignHlUe1cLQLSF4mRecGVYTIRGWUK1pxBz+jKru4KSiXpfHOgRZMcIDc3Oqgz/HzZjRhpui3tYKJPGfK/qKDY02A/K1V1asEHb1PnK5xAE8S9q4952IiPT/KTVa3kC5nrThcMbVayswetUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptqGqmXAz9V5xEINM3Hj/CdALzOe1lsLRSHTjBw6Sp4=;
 b=Mil/EeXoSBdsLB+zacdEJDrAGhb2yigZjJVtwMVRyLHWt0JJ8WK1uugyKg+Irj45b7wR4WrUSVeQoihZkIMDcS0tXG1PnYOHPwFEsTUfvGvs3U72fijxbD4LPnYJWSglWYSGjQfPjgqRJSFP/2ZJQWqmmo5UjQN1YgfhwmbDpMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7674.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 13:41:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 13:41:42 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Marek Vasut <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 0/3] env: mmc: fix use of two separate partitions with proper
 type GUID
Date: Thu, 12 Sep 2024 15:41:38 +0200
Message-ID: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e17e2e-4b02-4f2c-4fca-08dcd330a2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B87S2EpfGZ8wxpZWGfkq5sNTHNJhrl5qxSD6JgCaI5mTIZoa/F4Kal7mqI/o?=
 =?us-ascii?Q?EIeiA72X1/QQ4SSHQt4A4zimAYQytWzxxYd0xJAyr/pjw0Z3cO9QJ9Zgs9fh?=
 =?us-ascii?Q?TJLBcuhvGOk0jQUITzt+hN91S+YLg0vJLOHr1DRPFGQTJ90ZpEPMgwr+FNRr?=
 =?us-ascii?Q?lElyPh4mC0Vw3UQdrixB2HVBAvi25N1xdC5cACxSrnsnf94qdVAW0XOsvIQ4?=
 =?us-ascii?Q?LiZTV6e88j+hsv1kPsZsDV8yDzrUfUgO2+/jeiwtR0YdNt6PuuG+GEL4WQjt?=
 =?us-ascii?Q?DE3qpv6isQJshPTWArpt+oz3Ibq341Gs30TiYXIgFt3l0hBIPsK3sK2iSz4X?=
 =?us-ascii?Q?19zX/KREaS8cw4ejUCuxBcFuml+bxZwL+H42LR+wjYLZedqe4RaSdaC5rsBe?=
 =?us-ascii?Q?7EI+oCLOGilN4lfB5BcvjaTR7mucS7e/8yK6K9bhcTlEZtvUwacQObpt0Hr2?=
 =?us-ascii?Q?WGQ5pA/QOFy5imv0iVfcCWzbdbut/LT4fD/qglUKh5LbG+LBIC9CoYgQicIh?=
 =?us-ascii?Q?2zEDkGADJ0stR5MOz0LwjKGJMw3Iu/TzMcaVxz6BLf260oZth26g3/vhA0Fk?=
 =?us-ascii?Q?019fUI2dgg1JyZ/le4xN3BHyZpWEIlVTEbDw9AbWR/r5qNQF6pvU1x2w+cr/?=
 =?us-ascii?Q?ntNClZMbpXvxtlL9NDlxeoWvy1Q/HKsfDbYPPZKo8cNhY1wkOcsGFu8rCXY/?=
 =?us-ascii?Q?+dA+y0R5bAO8tn8750L4/m+JXPBB+obuhCerjpYZoLPNOrJ3qDzhKGhYx/wZ?=
 =?us-ascii?Q?aS/JdVp7OxUwWoxqzwFaTDW3Zp4g1XVgWswChsh/Z3mWovEtQWyaRqY89VAI?=
 =?us-ascii?Q?OAbwdz1XL39xc6LCueq6O4tPnrxExEY9d8FS916PNyyEG+6ITUzon6IZu20U?=
 =?us-ascii?Q?kgM3hmOiJWL4DDBOplBWHbeqgBN+HIf7gaISlyFlsnSeEbfg1nt8Aw6g1MtG?=
 =?us-ascii?Q?7ysx3EvFVWQe3y4AVQBfyorS7FHDfb8CPV4eNucoK3gFwpmOJieF4+woA+YH?=
 =?us-ascii?Q?8McpwKvgUQwCwVsn90xRRDdIsrFG41JJYhJYRKJ2c4LrkuPAwx9tG16UVzEK?=
 =?us-ascii?Q?8VSU7W4v2x/zUL8ecCfedm86K6I9x4gi7e/e4UouTeazc6L5XGp8lpr/rJ8P?=
 =?us-ascii?Q?/sbbNlo4aH22woc53j/uKig4aNpBqJ7O3ogbyNZKmPCPDB8qlYfaidzRR7CQ?=
 =?us-ascii?Q?ulYQVxLQERuqsHnUw9hcoSFh8Vojqz4ieHI05VuiKZbSaqdICsMuy6Q2i0xe?=
 =?us-ascii?Q?NVxf7F8gCxQMRKpmwQ/meKthv1GeRkySKvbyKoVdVZ5yz9qDrSjy639Bx8d4?=
 =?us-ascii?Q?lDmb1qPuwZBT0fhn7Qs9DC5d4s8wnqtLmBjcQCeO3PMQ9l4JRHVEhnXg8k/5?=
 =?us-ascii?Q?D7X/1RSLRBRUS2FY+opvUY8voPPRCYQeColR1QFpu08gFji+BQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCDTPXIwRgXBTtWimmEuZn9XtM7cPwxG8MH0YKwyjpWHyHdatJNkuw9CD5Xh?=
 =?us-ascii?Q?CEFIpNF7sXzV3Azq9xffpotHQFd3t1XY307wrw/mpXgUGA1MeJ64QtBLJ0kb?=
 =?us-ascii?Q?16+4SATBcUfMVpz7v80PiD7WR4yE0ZLGyYPsMnTp9IDnmezCe+Zz0OVCeIqk?=
 =?us-ascii?Q?knKYh+QSLSIt+h/ushVe/DI3irmFLYrJLrSOt/HjKrMhZwcZhJlyU0so4FiF?=
 =?us-ascii?Q?gr+YhNYyzvU+ETRGpGtbged+hP59S/6NDtPs+mXe1er9V5+fuBqghlZGmSfV?=
 =?us-ascii?Q?1z5GxrSuqez/DXh3RT6MmnwW4lMUbE7wmg6qcNSMwpbSHeYOUivJQSv7fNZZ?=
 =?us-ascii?Q?V/QxXiP3t5dX4gOPbNf4Z4l4veci5qMZFg6lHimOEdKpVakpINQtQ0NYNfVb?=
 =?us-ascii?Q?Z1+IxI/WxiqWwxR6Cp4NwNwG3lzf+VqORz+U11eYeqILYANSqSxkpJzsKO1f?=
 =?us-ascii?Q?1+V3uVAsdB0zwlLt5v9zcuAk5j//fUhicIapRaa5d9lpYwXVcNF/dRulpeGv?=
 =?us-ascii?Q?IMvzLt0o8Rwl7Ffbd9mA/zVjAjQuTxR1+98+oDT74A/inZcAFA79cNfp5rXE?=
 =?us-ascii?Q?IP3XkLiBP2o/XdepDgceeE1ldFu+DmQHmQeEFJ7P7KTxjXaa10SaapzSiaL/?=
 =?us-ascii?Q?UGim0W9YrIuQf0wqFkH55bW74EBpYrmnnkotq1fFv+G9Ry3VJFTTI+sxHVAD?=
 =?us-ascii?Q?aYm3drmvJQa+McyjtCPAJGJG5GCShcNlflO9KhPafR9wM0U7Wtnuw7M7v1FN?=
 =?us-ascii?Q?X/vIEze/sYAIYC2jMzRKV4/cE7XkhuyF+Kl3HkSdgSMgFf7q/bTLtnA53GI7?=
 =?us-ascii?Q?0FIWa+C/442gTeXak9TY+9ZWqfVHGmCJxsC2hcYcWEYL738p779ODIGiQaOW?=
 =?us-ascii?Q?mWCGMc6j8HXsIhgMO3L97drS9pGulMSLmS/MGjK8YFL+0jYNe23t6egNe7al?=
 =?us-ascii?Q?i0SujkGfsF3RkInq6C4d0pkTOniHOPZDcTEqs+TsSI2N/WHMzOH+fp2Ycwz0?=
 =?us-ascii?Q?m2Wbs8gwgCEA+X1RIbknHXZLeBLMBgORFgn9X9J+A52fUM7osd9Y/a2qCD0M?=
 =?us-ascii?Q?wFPwTWvmfMld4LihEsjK7Evn8CMu8oscg4mjmebvBBXbmzcgp3khN+R1XkA7?=
 =?us-ascii?Q?VV+WLWC5sZFKSQ5OelWAw6Jwvk/1/X+q7Zrtq+GmpZZTHVUx6Q4l46dN4aV2?=
 =?us-ascii?Q?s6y2T5O0LCSGr4jUWFpvKXms8agu0xwsXL3jhxuWajNqLs6Hv/iadUac7z7f?=
 =?us-ascii?Q?JS7kUM9qbJ1yeTNRl958Xy6cdx0UksvUt4aBetVUhUTJAvisTnepODRndt3P?=
 =?us-ascii?Q?5vig+p21aiUNXa7Nxc3Jzz5aIkdnN4Pgx9lt7rvTiZexpKID277EHvJWlsRG?=
 =?us-ascii?Q?+dCuMxWdwrcMoj4SbRuN9Mj33ihHoOF8GtoO15K1plA33Szs8NVE616EVVo+?=
 =?us-ascii?Q?ZRR5+JAQhHZnQlQuP9/zYbmDMHEnT+rk30iJ1o1xscOQsXcQ+6jW++hNtt3Z?=
 =?us-ascii?Q?/gybRHuLVMDDSTOTsRq/gStYlJCLsmwzT0oX2JTA4utHRJvcKH8yEMNsqzKO?=
 =?us-ascii?Q?o+MxltE81zOvJkR9tiji/d0SoZ2CjQw2dvdpYVUcpV+cIehGcihMhSFM04Rp?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e17e2e-4b02-4f2c-4fca-08dcd330a2be
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 13:41:42.3077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCvygmrpl7Tg+1GBW0vApm/Ka1yz7sBe1+129Y7kNR1zmtAHfAzPjimF+qgwhML+YEKvUX+EnFUzcAMkim+bdjZSMwmd3gg0DgsPMaWbi00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7674
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

I always define a disk layout with two separate partitions for the two
copies of the U-Boot environment and, being the one who introduced the
type GUID for such partitions, of course also set those partitions'
type GUID appropriately.

This has worked just fine, but, it turns out, only because I've never
had CONFIG_PARTITION_TYPE_GUID enabled on any of my boards; I've
always just set the offsets of the two partitions via the config
variables CONFIG_ENV_OFFSET(,_REDUND).

I didn't even know that env/mmc.c had learnt to look for the env
partition based on the type GUID, or that that would overrule the
ENV_OFFSET config variables, until I experienced weird random
corruption while doing bringup for an stm32 board, where
PARTITION_TYPE_GUID is automatically set because it is select'ed by
CMD_STM32PROG.

These patches try to fix the code to fit my scheme, while not changing
anything for existing setups that use the two-copies-one-partition
scheme, other than complaining loudly if the system is misconfigured
and avoiding such random corruption of neighbouring partitions.

Rasmus Villemoes (3):
  env: mmc: refactor mmc_offset_try_partition()
  env: mmc: do not return an offset before the start of the partition
  env: mmc: rework mmc_env_partition_by_guid() to work with two separate
    partitions

 env/mmc.c | 95 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 18 deletions(-)

-- 
2.46.0

