Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF73E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 10:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C795380050;
	Sun, 15 Dec 2024 11:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I1bwXZVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F808005B; Sun, 15 Dec 2024 11:30:39 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D25F8004F
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 11:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddmIMLZROtK0qs/MYYQ4j3XcVmcmtILFGGfFypjhxd5MtEZoB3yCYKLSjxowuO69E3wkE4QHakJ8WK19y+HlThNMLbbzXyIIVo9T5JU0MLduykq3CAUo50aypjGtcfOGX0kARTuHzOfJNwhAs81DZsZ5D3I2FIwiFLww40o1POojo6z8GZJoJ9KBCFl9nTPX9NqJmXgEjTtNeH0tQi+jCyKuBqeNY2dujya1GqYf5OL1MGpAlQ9HwStiq4AXRGsO5//c+/goCCQNDUsqT6wcAFOQ48f+wyfSHPbac3Ri0mNHw/5PAlUiB09IHSSTdWHxZDVnqZmbFmPcBsluk3RE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zh2n+GRITel6PuN8f8/SYbEgAhV46ERUdIuBGmP8/cY=;
 b=y+YwSzDbpgPv3PX/0Fl7vEWnM15obJFRmZby3njiqj2krSHCEpIJCT8wFROyb4v9xQJn5AYvVwiD5Yt/Zn1zvuPJWt0FvuRAZyNoY+SGXCTyl28C52cVI/cHCUUZa9y7qC9bHofK8tOhsvrcJwM7h0cM5JomFu2hChTJgvE/lAFti3YgLp47aFCdJodicNTlFualkvnYNIxdeHv+mQW9E8VdzBlWo3yQkicxncEwx6neVckfpHPZNpomFgEw9NqEDnRG50VW9GAs7RMH9wtoAvyu22VhBxLdmZaIFrEY1ovyvM9v3f/b1kLmlDsQhk6yot93Xjy+Bd7U9cJxGyxwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh2n+GRITel6PuN8f8/SYbEgAhV46ERUdIuBGmP8/cY=;
 b=I1bwXZVXoV6JVF0+apyyyOGB95r4wvxQ62mDLs3jcP+AYwNqDI5k0y1DKCu3PiUt9SC0WKd7IbCOjhgsR+3TyfV4m0WtgOWWDC/guczXesS4Y1diaCPdVsoReaY3182SRS7XVAkHAxiZkHRPDXlXYCRdInz0uAf/9FedraMl2eQhSOamn/6TxTel72UIzMBNaU2L/gnlAwKwuEnRplbrjUSeQqD7g6plD/eW2ZkUSsQWIXsxLT6O9yyQp9D4HqicZ9e9tLySKn/wr6zdxrwwuDw1wqTfIPAFPtBydLTr0RCX6ERSICwl0QVwcFCfbiBsdueFSAyXL3aJz4v+kwmf3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7765.eurprd04.prod.outlook.com (2603:10a6:20b:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 10:30:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 10:30:34 +0000
Date: Sun, 15 Dec 2024 19:35:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] please pull fsl-qoriq-2024-12-15
Message-ID: <20241215113558.GB20989@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: JH0PR01CA0089.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: fec4d89e-77d8-43ef-c8e4-08dd1cf381e3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uwN080uTDh4Bi8LAUnOakT2r/Z2KZ9Ty6UnNSlYq+V6GJan0g9eIpRLNhSUn?=
 =?us-ascii?Q?Bl0AKNgO1Bd0eBtXMropn5zyBfqbwScuYnMwguiQNV6/PiJ4HUGjvwCimpDw?=
 =?us-ascii?Q?IzB1nPSnDvX+VNvCw7OVzed2hnCxAOdimcqwuekHGAmb9YhGdm9zAxAF4P4j?=
 =?us-ascii?Q?+nQ7VJqLCbDs+5hY0lIltAefAQGG8N+vXWfkLtvv0VT2tiQxTVM1UPfdN8I9?=
 =?us-ascii?Q?2As+Id+czQ1c3DNQJL2evbMSS1pxm30JcoEppAAeHoN7b8VDL+xMjy5+68tm?=
 =?us-ascii?Q?ml+pNeXycg4fjj+cYiz+IkrGSHdrS3M9hSNXFqo1smqFaan1zPY2+Wvadmrg?=
 =?us-ascii?Q?AoNW/OzpW51uI56aWCdy0DuslVL+mDKVnK95kR6+Yux3rpO5ZWNDoVouL4lO?=
 =?us-ascii?Q?KgJNWk1FUJg2uWnhD/amZGVx4f+4mfKtASP+ktEz8xVZ5cJjMY0xnNCZ0/3j?=
 =?us-ascii?Q?eX2nBIMijJOlK7fRyceYRKltpq5yOTBXqGH5gNRpTIkwUTOop8ZlF+CyLpjK?=
 =?us-ascii?Q?8TMs79a0HBdZImukmRRgGufkuY8hjEh+cWWxg5Lbs+WzcQvHH2Gpvamkd3Us?=
 =?us-ascii?Q?vp8nnZHXsXadZrHSdhz2uQWTH2ap2TlLO6wN6uWs/Uki31zuetgqYyaMTxFq?=
 =?us-ascii?Q?VwGAypLvlEb/uEaAetRG3RPHwViGwSFwgyyD0kNuVZz1O1kqwfWrV1sCav4p?=
 =?us-ascii?Q?63b6N+e8njlajPXUx+dCKuFdLzJK4Po2Jgre161PqjE1vU0e0tz8Gj9kNNnz?=
 =?us-ascii?Q?oBR8cXPJH6pazziEQ2QAjZ7gLV/4rfCv17WxyMHzoZHcnoNjbdjiearuGsWF?=
 =?us-ascii?Q?xZXv3BDxeyW2aCH336Ufu8MG88JaeT5VEF8W5IzMFmxf4F3p7UdcPZVHOyn9?=
 =?us-ascii?Q?Kb8C71ANBM8HuTa22blQGeRgNQBrhq4j43O0R7UyW/1jxKbikedZWzNZpGjQ?=
 =?us-ascii?Q?GcrT/btXvz2fs4kj7IHg7A2RaKPPfFfv6lLqLw/VAh90afjE/79/S4/Kg3pt?=
 =?us-ascii?Q?ISeyE3nbS1YEimsi3GyjsRrVX6TJcHLDd+JX+dUW7Sm7ZUoWaRIYDWgHDnyC?=
 =?us-ascii?Q?s9bXr4/Go1guJRRnDq8FxjJ0SnTutNJC6KLb0TIc9qPm7lMymrg2fCn26gBY?=
 =?us-ascii?Q?YOtRgqq4wyJGHhWoXvxoPCxZi3q1kXaKtbbq9Yx1W1mYOv2WGLB9VsebC5vK?=
 =?us-ascii?Q?RVORZ4vgiTaYmGYHgbOmIwJFPO94njMTCrGToi0QyrXvp3x1YZ6YhWci8+cK?=
 =?us-ascii?Q?6CH3u16muLcsPV32TjIfuZzD4iXIwmRk5KT47Ad8wMn/vLmieJJN1/abwSTM?=
 =?us-ascii?Q?JWHeLWfIyZCUz3wguqE/dd6cRIPMnbjnlqtnkzSN9ajQNTn00A0zP7M8Pv77?=
 =?us-ascii?Q?+KS0/ZBbFIfXD6M8W55JM33pYaxw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ToQaOu7WH4tVkDSGFo2wTWasVgDtCQ05RrxyQ2KDPB3HgD846bPf8fukbt/k?=
 =?us-ascii?Q?Zunh49X2bhj1EP6ChbHuFESQ121RJ6RUa3Y49IqCPQOEf1JGSDGSs+2NyKKD?=
 =?us-ascii?Q?LssrbgdZPeBEm95nClecl/1Z3duQfwJxYkEBFaBfPIXjmeLi+2V/DdVgD9+m?=
 =?us-ascii?Q?gk/YyD+gxBhSOxKDuEQPg0C9XNZYIxL6Z1gPlnqjAxeiLXaW/FkHsbZFJrj+?=
 =?us-ascii?Q?aD4Z0Ch0fRxu3Z8PomGefSZ/oGks8BK/fOfMitdZC4ZRLvQdtrneBFKanFxP?=
 =?us-ascii?Q?3uPhNybkU6SA55NhfNMWqa4E1JD0ee4aYxR0tkKsYFULO66pGcQwmu18so6S?=
 =?us-ascii?Q?r9O/H8YiWjZyP0Kr1LILxdkPSgsWwX6i69AEGnJ93c21t1gzrDXry7BFUrmQ?=
 =?us-ascii?Q?JVQvdop7+V4+m3BcvtuIl2HfNkL2tfZlWn2ZhA4iOatIIYcS5QxChz13rRdy?=
 =?us-ascii?Q?OHvse61+ASs935qM7jnAwpL9dh7f7XtQBNZslD/glfTzZXQ8i1+8VVKWH8+w?=
 =?us-ascii?Q?ubeCqCD8mWvdgI0zLstr2Z020sgPeb+Aoxq3SBnzHLrlhc/axACfG7HlFg6m?=
 =?us-ascii?Q?8T6DN1Sd8R9c7/p/jPUS/XHMhNuUHWWICqCn/npOUXQOkYVyc/zHCvTPXTLA?=
 =?us-ascii?Q?2Awy7WAPX0uiXQMXLlQGtuGdaSnOeNhDG6rm+JWcfz1XRj6+mYNaTlxCJ8Zf?=
 =?us-ascii?Q?3wpMRws4IJIfNin0fxZgCmRjxpRFvtRcVtQIlubbl8BJuHwSv7n9sLSN/T8a?=
 =?us-ascii?Q?/nBCFMF+G51KQW2c5ukf4f9wdC8lLJ70SIYq26KZvY5gOqsIuaYT/Hx4Z0yK?=
 =?us-ascii?Q?qLMusj122C5w2wtFxg2ynlp2qKKnkFt1AZ3U4ZrH1CTxwu3lw3Ma9Nbm5OXy?=
 =?us-ascii?Q?sMVlpgUQXaIYiUqLJZFx/WFp94zVSDBFtuBSGSdJtxZwZ0KhPeA03/RoUfx5?=
 =?us-ascii?Q?dnjVGoY+CgUwdXW7uIsIWl5ERb9lNEbM2YDUcM/vTzmSB7skFgBcF+EMk7oW?=
 =?us-ascii?Q?iuOke1oD2Qr+BDrviVepTMfwdxg4ITMou3Ow0r8Yx9Kn95UjFnI4s9+AZp7K?=
 =?us-ascii?Q?H+ZInh1XHl2C4UKRAHVwZP2HpVN/efHWILH+YaDrq1q64DUcCe+hLiKT2pvN?=
 =?us-ascii?Q?YXCphIhWyjPkmrEUoH2j1e8eKHfet4A6VsDg0nn9xfDwZWEHNV6uERCgaQOp?=
 =?us-ascii?Q?HUCca/bnQtR0DL+WfrJ7Dnh5Fxp220L5nIlH1QLiqyqAAozyGqzGMlACVj6A?=
 =?us-ascii?Q?/Wg+B04XF8byiNf0zOwR82+o8kTN/PX/p+NB1o/KYUtOAR10BdJWd5n3+Rv5?=
 =?us-ascii?Q?p6fyJnm66sON7pC4+sTACb8/Kn2SQcPKY9T/OIK/Eq3QY1E464ntQyymhiwM?=
 =?us-ascii?Q?x6kiNdIEb0h8nCyb/DLLQYynzWmmZk5t1CpDFtuXdn2vpW96IF7UdsliuZUd?=
 =?us-ascii?Q?Y70SrrVEr7INnYxqm9JgEPu/1WsDPgIIFywop56SsiHwMjYjVLZbrjjFDt8t?=
 =?us-ascii?Q?2UEJcYXaV6TDCvywx5+oTZ3zvecHCAE0EZQbV6wjL1xJXMMbsMn6HKhVcERp?=
 =?us-ascii?Q?T++Y52nYJ8kLWgucJ4E3Mkrpju+ZggZEiUqmahBF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec4d89e-77d8-43ef-c8e4-08dd1cf381e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 10:30:34.1418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsb0wX2r5UwOSb/miyizrd4bJgoqUNgtYJzyBfx1G16f7d17SH83+khZZp1dVQIPQRhsRItntWF/GD/s3DT7YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7765
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

Please pull fsl-qoriq-2024-12-15 for v2025.01

-----------------------
Use strcat to replace sprintf for t208xqds
Fix bootefi for board ls1028a
Various fixes to sl28 board 
-----------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/23856

Thanks,
Peng

The following changes since commit 88bd5701efdc48048e030d91c2633048f0f753a0:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-usb (2024-12-12 09:50:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-2024-12-15

for you to fetch changes up to c71aaaf6a896589c97e6ebb45c85f577d435c1e5:

  board: freescale: Replace invalid usage of sprintf by strcat (2024-12-15 10:08:07 +0800)

----------------------------------------------------------------
Francois Berder (1):
      board: freescale: Replace invalid usage of sprintf by strcat

Michael Walle (5):
      board: sl28: fix linking with disabled watchdog
      board: sl28: increase SPL_SYS_MALLOC_SIZE
      board: sl28: fix network on variant 3
      doc: board: sl28: fix table
      board: sl28: fix USB0

Wei Ming Chen (1):
      configs: ls1028a: Fix bootefi issue on Layerscape ls1028ardb platform

 arch/arm/dts/fsl-ls1028a-kontron-sl28-u-boot.dtsi |  4 ++++
 board/freescale/t208xqds/eth_t208xqds.c           | 40 ++++++++++++++++++++--------------------
 board/kontron/sl28/sl28.c                         |  3 ++-
 board/kontron/sl28/spl.c                          |  3 ++-
 configs/kontron_sl28_defconfig                    |  3 ++-
 configs/ls1028ardb_tfa_defconfig                  |  1 +
 doc/board/kontron/sl28.rst                        | 14 ++++++++------
 include/configs/ls1028ardb.h                      |  1 +
 8 files changed, 40 insertions(+), 29 deletions(-)
