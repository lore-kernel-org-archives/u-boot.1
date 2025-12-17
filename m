Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2F4D6407A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1827783B86;
	Wed, 17 Dec 2025 13:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rSmR66pN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BCA583B32; Wed, 17 Dec 2025 13:47:13 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D404839FA
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:47:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa0n/FVE6wjprC4ONBuzK5fo8H4XGLYdo9V/QPYHGpT4L+xNfNJFPw6MacdmD2880QYHzgajXEhJHjq/klJ7KFz/mHo6gvY1fqEtMH1U6jd12qYl0g0DgP/ocLaZEB4CqWsQgIYc8GT4kBAKp3rohA3xwJncpsbUKsbZ7WrV7cYFrubk3xz9SIclVW2lQbX9+ey/kPOPoY3KP2ZxMHWALo87+nEBxsZkhaXG8KPBdJXgXljjMxOnv4J0cBfDzmLM8N9t6l9E5Ew22HVT5OpzTS6OHMf47VCYt6+1XPp455IqaliNbeY9LkD0z9YfQ8ywjhqYVLSRyobscEMgja1CgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojxxVNa5JQxPqRHCU2N+huPv8Tjsr4w1iC6sf5Q9Y6k=;
 b=Q0gAlk2DQ7yaIZTgixyKexBZkNWJgXH5ehBeuOCKq3k9Ni3JP2+VAxzsW5u/UoSPa3M+oYdrnDlSAG/NCqB86wjZwVW2V7OjD2VgLIaBQl8ATqLsyQy4pXnb6I3Akcav4gIsYeLL/QftfFScsgMJmD0+FDiyZzlP06T/7/72TYvd+a2wOhTOKcaxcIDdYh3ySwdcZgefAo1vl/RJ1aJsPujHWqE82dc5Hh2MHlxYW5jDavoyu8MqvAqOEevnGlh6NitXsNE2Sdo06Kd+FftuumBtqSOPFzW5+c/dLeQbFDMc85WOr0oENmEyCSLGVaYO5p0y7LhQmupXh6H5xcCGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojxxVNa5JQxPqRHCU2N+huPv8Tjsr4w1iC6sf5Q9Y6k=;
 b=rSmR66pN8Fm2YVVo2Yivol/ld9uqkcjKtNcgl/4GpsS7DZg1GEoJEwBjtyrovgccL3li2PqmOr2wreWPhoTVyHyAF2iCO2KBjvlYWKNq282ykQd/6Lxnh1V4WU/aaB6+9IaS9VoRa1nlVgRSU9xcrii4376MjC/4k1p8F+WGBqo8VNAdZNAcmfqRiMkuW6cVOUHM/5QJpWcBaboeJAHF+nMB/39Pj7ryD2sEH79P/Q+S1Ko/D+UJ9Lt5hja6QbyPkK14XsnTQDSQ77tfdE2kfVyxRRnBe/X/ge5X7TUNrp+XoMHEoA3qK+5h1qQ2woLeinu9PB0WSo0nS4ku0m6tOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7627.eurprd04.prod.outlook.com (2603:10a6:10:208::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:47:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 12:47:07 +0000
Date: Wed, 17 Dec 2025 22:00:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [GIT PULL] please pull scmi-master-2025-12-17
Message-ID: <aUK3gznUWeKoLi_j@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SGAP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::25)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: cb76b9db-52b0-4ed9-2e73-08de3d6a6335
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vHBCi6RILGZqW9pD14S/lAHvm2aNFDqKLdKh429cU64eTmWSPnLp8VK9zzwg?=
 =?us-ascii?Q?gdmM2OYjyt5ZLnlmu6lYx0YYYofGt7SjIvnt0vUKIzB/OEqvphfVYOIQNuij?=
 =?us-ascii?Q?n805rsXLb38mgBUYpfxcVYsagVz8jQwtLCq8QnXCHA47m9gBKHcvULdkvy8v?=
 =?us-ascii?Q?ghxL26/w8R92OomyGEb/phORcuSW1rl0xJurvStRg0y1VQwU/9RAuKLZN69D?=
 =?us-ascii?Q?/p5VwzwZDwnvQNFUf5cWwid3Rs6GjvQlvHYiBcDk1r53Q8sVU4l2tvyuGQBI?=
 =?us-ascii?Q?iOIC9uQTJkhblzmsgBOfeeVLjlvxPAQsk4V+3bGNso7snmfLnthTA5DVnvuz?=
 =?us-ascii?Q?BOAkUi0BvOYvp+T/hZfblfJRqQKPtdeTxJq5ivBwR8CyZj9v8q9XnQs7zpgd?=
 =?us-ascii?Q?+zVnzvLM0tvDVR695KRRVoZ++28ADzbbwEKp6f7KK8kkwqAkdoTBOm/jO86t?=
 =?us-ascii?Q?twMPYsGqms9FXJwxGqWvMKWx/PGKRfQm87bgEdM43SNVo2/Xv32FjEVrwgMP?=
 =?us-ascii?Q?XSE7h1FqTk2NC7wnQHXp86BK6gh1Fu0cXNRPcIPSV9mSPJF75SJPgAj/iNCb?=
 =?us-ascii?Q?UI69VjHMQsa8tus+214f5AmgvivqCJO4H4Qwe5KhtKO5GkQjCWy56IwgeN7P?=
 =?us-ascii?Q?kACqWR/byodQ8lD0KEtTCUSjp/H8RrJ70XglzUw0zfqbFApwynS2kdCYrN7M?=
 =?us-ascii?Q?e5ZxAx/UNDu3mxxwCPlYjW8JJ/3djfYkKT7Sp3YOqPoM7X5Pw8TFl1ABofeJ?=
 =?us-ascii?Q?5196MDaedvfOjR/C7/eD2MotITkHqdeTOiNeIfySgc0pij9eT8qFn6sujkuL?=
 =?us-ascii?Q?m8a/ZUvIbh2pC+w+7KCARsggHQN+zR94Ou7k+OgCA/Xd62/JcNeNlHJJxdvI?=
 =?us-ascii?Q?ZXqaEjOZIYwQpwfU5kfKOlOJypkm2XM13QULMtaWuyhNbutH6otqV1KCtPH+?=
 =?us-ascii?Q?RgUQ/F9kVR7dUEEwu55SJvrp1I4G0Rx4cC94qJFm5N9dwrZ82G3as/lAicdB?=
 =?us-ascii?Q?RIx3CBntVXWdIhJfrw8nteMmqgILysuwgcfXS9CekkFqvalvPf47p5PIRI9Z?=
 =?us-ascii?Q?g6m8+zKDtDJ+iOi0ImR0/JqZAhK2NdV3NJ/0D4hIZddjqyrjDjM6d9Cg7i6a?=
 =?us-ascii?Q?MEeot467owq7GFMtUF3OqtRVAT6hnlGai7JUTYyywOayEU2n05PeWQ03q0w3?=
 =?us-ascii?Q?Wm4Mxpw0u6p5UvJ8j1EAzx1kKfuXgBtMAXHCJhWxnUE9mxwRlDxrybsBYXmG?=
 =?us-ascii?Q?DLppaeHRvbcrighm0/nouTXlr/0AIsFXAWzT2mNOsP9HaNqt0o/ryjMPkCNc?=
 =?us-ascii?Q?9qnvMko9zowtKbqTmvyQINPDozlPgj1ReiYEF2Hk02Y63xUEMHIpyscf0z2N?=
 =?us-ascii?Q?OkkLJxeVNJtxxSvS4FE/S9s4hIDHXo9zZQJcNI2emgPdqt7TDsDy4tdzI8vO?=
 =?us-ascii?Q?kmbHq2yFw0q6fjCIwWwT1wdoHoQfvKOJiZL0PMmwFCIUxm2IDKELN4joqQcr?=
 =?us-ascii?Q?OMtDVhe4Ov3sDcxyDpzAFJckoReB+JzIR5eY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LaNFlTywXrJk9qwdxLpIkg8K2z/QgW3krcfxa+OopVqbLMqbBT9dUS6p/i+P?=
 =?us-ascii?Q?2uw8OkEQsZWrZoa6rKEgEh8kZ6d2AFBa2lEGk2xFu7XDrMgERa3OJKmLFTPm?=
 =?us-ascii?Q?CzyO218Tbk5wP6kVNdMTNpXM+yyreHv/rDEUTmDcBJ1/i2NuZUwshYXM0NB6?=
 =?us-ascii?Q?4fRIvXDn+FC7Jzk8kXL3dlxZ0vdvESvTNOejFCBdNV8hsoD6aJfmNFJVh6Fn?=
 =?us-ascii?Q?m6K+xYn0O8FlLtog/j1Rpkxe0kECXDU8uiKXJC68ouwoQ5+8zjAV1060fzWB?=
 =?us-ascii?Q?uQndKpTZzTEOZnho7M9kTb5HRwJMzcFHYiTic0qawuQhpGX7jZvQDtHzps5f?=
 =?us-ascii?Q?4LeIZuHRFBUQSkXSdj/ATDm/FGIX+DWKvc5Y4Jrxt3OmKu2THpgCAGI/jBDk?=
 =?us-ascii?Q?QHCDvgzVYFuTz31DfrBQyFJeYalKQWXqRyDRB9LxbOZjICQgEVcOryWUmuOW?=
 =?us-ascii?Q?ws2LDMymSUd/hTVZy4FMMOI3px2+BnsVV2cT5PPOCpx6ZFSh3TfoODZ5Zlpy?=
 =?us-ascii?Q?RVxebtreWgwGuwfCJQDD0phDBQV2TxAjb8bhgxeeUxdd71qJCpDEtYDkc7Kb?=
 =?us-ascii?Q?sAGWa9jA8IyyC8I0n6538CtSA08LKa+5W9fUVtQq0OXjqjy4oZPF8LcPB6q1?=
 =?us-ascii?Q?O7qFWhng7KL90Q7m6Pa5NlFfm8U1s+4BwPWjZTNJN50Ux+6eHiJAAND6x60s?=
 =?us-ascii?Q?Ys+KLeBVqvt6Yd6ksKQkTXzJkk1vMvzNyyuKzsJyInsRf9fiy1dYcSgs89np?=
 =?us-ascii?Q?cluCU7+NEVuMmJdgA9/Z4Gu4ltnVCOoy5AEgNqrca5wKFvXTY0wAMS7PZn39?=
 =?us-ascii?Q?6wxyTCuf71E2fNKBgkt6/irlUHmnmZUIP77ftQvB70/tgxCWf1PqerTOc8wL?=
 =?us-ascii?Q?Ew6WJozYYAQZrHiM3y0meUk+VEZUcpzDndFLW+R9/t0su9pYqQSamHwCu20R?=
 =?us-ascii?Q?Oo0IT6SybRhq7VEslrULIlM7qgt5xU8MwQsjAjDjxun+DJQjW2lRGiJclvjj?=
 =?us-ascii?Q?PBbKyvLWtxKsoRRJc4jbIMAOzpp2CsObhp0K2gPBMiQD8De+vvYXnLefS8EO?=
 =?us-ascii?Q?AjC/9RSwxj5WOinRLXQQLGFQOvjMXduc4USE9Plzu7vsfTdwCy3/iH7pPUw3?=
 =?us-ascii?Q?TNVsHFcwWWUuYy33mzGOZanWE0xsaMPAjrDO85cbTRamvPJWeqACEOqAlg51?=
 =?us-ascii?Q?lQ6EsA4Urw+ZT8wNQXvqavalr82cypVb0pwHMrU5nU57Ebf1Wu8s3UtWBqHM?=
 =?us-ascii?Q?ruymkJXoJ7EXA8E0JXULFu5shf091gp4cOB6i5IPlo7dw75F52IhTidQBZql?=
 =?us-ascii?Q?P2obQXTsRDiOQ/o5o/Gdgp6Gmn1tsdURyIy5rq5W0twtn8l349mMXs+mFPGH?=
 =?us-ascii?Q?PnIyUgZnmkz6f/4T7jfivm9Fxaijq8doDeamvnQCoA+otVCVUAID0/GiEfQH?=
 =?us-ascii?Q?MVw+KtUWOjYcqvh47rQBDYS2OWrJ04cbLbunljVrUpISF9PKKCaaIWwtgqUF?=
 =?us-ascii?Q?c0pzyhM/KXRIOlS+V/pxik4MSdjeyO7THjO1eCknO5p1JB071b/AqFtDQWXS?=
 =?us-ascii?Q?9ydKcF081pdOgp8amhkVC1dVxzauEIdRx/ITT+yC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb76b9db-52b0-4ed9-2e73-08de3d6a6335
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:47:07.4579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXTWx0OxtR3X8z2xkN+GUPG1L3OtmRYLLrJEKmwRNv6o1z5IHtFrw5/JzfpL5sRIifTKzkH4ioeBXfNk+Xy2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7627
X-Mailman-Approved-At: Wed, 17 Dec 2025 13:57:17 +0100
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

Please pull scmi-master-2025-12-17 scmi clk fixes for master.

---------------------------------------------------------
Fix non-CCF priv initialization in scmi_clk_gate()
Fix typo in scmi_clk_get_attibute()
Remove duplicated scmi_generic_protocol_version() request
---------------------------------------------------------

CI:
https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/28770

Thanks,
Peng

The following changes since commit 47b50fb1125c539d80ed3e7f739c02c6486e1b52:

  cmd: part: Fix part argument description for `part number` (2025-12-16 11:14:53 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/scmi-master-2025-12-17

for you to fetch changes up to c3c30da46fb7aa31de428bcbb96c973493d70695:

  clk: scmi: Remove duplicated scmi_generic_protocol_version() request (2025-12-17 16:36:32 +0800)

----------------------------------------------------------------
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)
