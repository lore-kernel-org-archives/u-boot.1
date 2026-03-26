Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A56109C038
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 07:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9113583F86;
	Thu, 26 Mar 2026 08:36:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SXeBogYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B48A83F00; Thu, 26 Mar 2026 08:36:19 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A351283F00
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoT66NdA/SacRzktL6OWdT7MFureEnU3vCkR1Fr6c1yNK4NfIqS96skFcuOh9WXjWXBTiSDuBC5RDfnx0PTO2plobgWV35hLhgbWDwsHeA0EN+D5AluPCMX7ZTo2V2cy5V2ir+hDPzc2yymdACbE7s4jtYmLp2cD4fJAYrlCzFJI0gQSsskk4Shl3/C5/cdQOJmqn79WL4FPWpF+7GQtUB0u+67TKbVNzi5UtexW7mHElY9odTRZg+8z/cM42VDMiCSvm0wmSwJ6EowULti664U3NZEO0mY6OLhTzEh50Kd5yrnfM65HZ6VsLUhtyIc4dwrfpej/wI1xfEtR72Z7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMpOcKUxLSYp7+jn6j/cAWLeQB7/Qs9A8HuaSXNyRwk=;
 b=EkxRMRBpn1wk1JdTIbpwaYIcKKDd7wE1egqfFUvhzvJMdN6wOggbeYAhWITKY5o1FIKtyWaWIGmz/W/BgCWxkeFZjEqTsf86h9foXFPIXW6jDxcVHFKP7V9SnMCfps+mYALzag32hhGTRes+Jupz7opADv5IReijyHYtQ/hKxtTUt/e6lDEjXcaC96A/TK6TyTBVKlOMGu4uWf56COuBxedQi5Pfuqlt8I9sIXp1juaZKCxOvAl2fD1WKL9KKBAbsQKK56TQQ+egJ8bX31Uv0qVfjCy2OhbCUSwiPVcG2q55QEhX3KB5AtbQ72PwQ0M16NqvSbH/HlcnZLDNMwYkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMpOcKUxLSYp7+jn6j/cAWLeQB7/Qs9A8HuaSXNyRwk=;
 b=SXeBogYkKs6wNCt4H2qhgrp8GgvIuaGXCKk6hNmVH0z0gzbWneqZ1ZBhK1EDGwGzM04lAuXTIqdiGWwqaE+kY0fO27iV4qY67I+V3iQe/R+KzA/QY+aZCttOZy/iyhPxtX0RbwQGxBkV67WEn1SPYRxX9mVgXU1UTH7QVYCXA60TIK5AN2U0vDCNH93DFyZsBPBsgRXWDnsbw9GpgUxeFQl70O8H7bsW1AEjllg5ttDxftGXqtxzI7nyEIiTkJqG1Hx9R6loXs62I66Ilup226fAIqT89wPkGrgtGo19syzp7OFN2Qun7TpSaGi9dAzaqaoYGwJ2W1fboO6SY9gEyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:36:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 07:35:52 +0000
Date: Thu, 26 Mar 2026 15:38:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mx6sxsabreauto: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-ID: <acTidgr4TK2mCyGK@shlinux89>
References: <20260325190041.3428742-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325190041.3428742-1-trini@konsulko.com>
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a462a70-5193-427d-f804-08de8b0a4f0e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: gEpnqgV0b11nBb21OI3f8zUwQNDB89exDoH7N3CcdD4dOJOEbNYhyRUimVnjuz0fvTsbYTOjJ49Gyyr09GmZjyHGPSMQBdy95A2X33M+WEq8V6QNrtJrE5mNFGpi8zE7gO2uhpXvieXa+qXWk1sI4HYj2ji3Q7AvIJFMMdzR7Gby7dq/dCSpRNPWlVX9CMSMRVRLAtimarcLT/gpGUe07/+WhdV2K8M2uQRHuvvy+wkw07urvLVXSQrG/9KGAZ1BQdrJMSjly5Kc6gyWCdRedtfIoC0RE1nzZ6sL+4VVUzTNRW8ufPLoGFh1JkZjd/PP/fhVfSe48BA+tSNAAeo6VW35jW8s4u2EY0B1wP5kqHi86J9JBtSHTX6WdVhFeDnTeOrMkylbFrG09uihwa0O3PGPNUEyWQ6ZW1/oflG3YKqixnzooxLREY8MAk6ciW2lTrI9wSo69f56e17M1pkTLq694Igftf2Izk024PmPNmXyllYfFO+ttSfQa2LC1GrGi+vCTGySvLhzuxoOryNYq/yBEaNmJzzdYX15+ANSWqDl8o5USVOqFrfKWCYInA27haFAxhWqPxJRxUzmr7homiJWsd4DqziS+3ynyoCxV9gO2ayzMl0Gge8wx9RNYoqTcYSvcosD9+zmEiQQWxXMo71Gy1pZra+y5/lyP2G9JwS+XqEtOkUwWmkFn+o6aN0n6XiQKH2lUgIlYNiFAC5NBNcaUBuvImNTwljyq2vLjWK6UVMSB1RWKYvb4B7oXTW+B1Ip9BzO9RKTL9C1bSjWUVM0IvdZRLkcksW8xmIFm7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Por5A1ov+hvLbhd7AgXGnORZagGcdSJgf5KwShJ51WTt9+vK+So5RvXu2KvO?=
 =?us-ascii?Q?unwkYSgTOEHV3Y3eGWIB4/kWEcSBiXB6I29SoBrUEdybmA2eFDlBEhk+dgtq?=
 =?us-ascii?Q?I8So3x82tfJzZynEKf0564Dg/glUCJDQAakKypZn33phl4iqluejFRs1L12e?=
 =?us-ascii?Q?RUfwsIvS+asULCfDMC7T+pH2XbaerZLVcGfsuevU8NNDZo0tXGFgYFQmuw3v?=
 =?us-ascii?Q?HtxVje2eLFsOXf97GwwvuB9B21Pxc0hMIC/d85S07hDFsAVjocHVrVAj/3MW?=
 =?us-ascii?Q?rPFEIwlQcD0ANoFSPvON9DjcVe/AWJIiLFOwqaqTPA4atGTCPW3bv9MDx+2t?=
 =?us-ascii?Q?UyVSJ+bTtOyDugPmO+DMJLw7bDex+NVBzaIc/vBV0Q0etyanB625agzcAFrb?=
 =?us-ascii?Q?WvwkCh2TmNiKizfexLDJruLOcfO3r7JOFbeLAZaUJsyHg4TN28ubLHbZoSyC?=
 =?us-ascii?Q?ZdOmj2+MwMqzz9NPIzlVHkFOzBNDypdkvMPmE5BX+1jxJZmO8uV+GBZN43MN?=
 =?us-ascii?Q?1rt61kYsivQwM6rWwJnU95ORrkjDXFasVuhtlgr+MtF9OFowMlyaQxZ9yc2d?=
 =?us-ascii?Q?Njb4GFAw6vkixbLardN3uwStm1f8uS3evPP3/R6sLO0pG9huQuMpAbbLMIjt?=
 =?us-ascii?Q?nrBqbIqmKTfMI1LDtynSoi+WIuvYsAO7iOgEkdxdT1Uw+zIbo8ZQ3B09AUVH?=
 =?us-ascii?Q?+3scT4KPKsdzt8vXeoSDui/IVz4HAq55oHgMWxkiDD7XOsSPNp4Xi4UGl67L?=
 =?us-ascii?Q?NO0MJpcrxtwb1unTqtkIAUFaA3xZUBHtP2nmmmd52dhHY9MuGfgQqZcXFKnr?=
 =?us-ascii?Q?tOp8LLXakWXvshc7q3lg5aWBjnm+BmMp5fK8LMKIBXTZEJwG3jeNKFypItQv?=
 =?us-ascii?Q?wJBefMLp1PlNabn+MSle+Ez/WGfJ2QSjMFtSsYc5oNJHuA2qp+22T/2uCR8c?=
 =?us-ascii?Q?uhwjf4XwtpGN9Ea6lT2jEdSy9IdoHhiSIJyPWDHCZgqTm68sc5GZEdGCUx95?=
 =?us-ascii?Q?fHS1sg9OKj6mtSGLECLYwYNEEb9Bc1+Ki/c0xUvP+2YIw8vekZUqepuDE6Hl?=
 =?us-ascii?Q?LbVcZzZsJqV+zd/nXc+dqNvUB8OyQms0PzjNhtF2SyjqfvwvuTaHnX+PCQ9X?=
 =?us-ascii?Q?3DbUcAPtjkdRPf1xDZAeeK1vWPNM3C34xvxqqTsyKhANJxgrDx4AZx7U2P7O?=
 =?us-ascii?Q?IdLvK1+boVl3x34/JTFJJdNrcC6iPBlCInafw1aNie5UDOy7fQK2ehnJeFBD?=
 =?us-ascii?Q?iRICm+NOSgWOSEYDUMbm5NLsZuVMCWAuCXderTbVlzzq/Nh/yRYMikFuMQgB?=
 =?us-ascii?Q?fABJ5PT2Bwf0xDt8g7b3nKZU32O7HrRkJdoxq9v5M6mQGmF8CoCTXJ1PNSOu?=
 =?us-ascii?Q?hUuABv3yUVcx6XM+4Fsl0fOD4QvPjEdFigyeAA4NCAKarwVXo3ykyxA+pjQ7?=
 =?us-ascii?Q?eS4F9Ja/dg7qesvc3TxH/IpW5sNZOEu4z6snULPYjVrfQXEGpJwhpcU82kN5?=
 =?us-ascii?Q?LnSpB56Q0oZRBR0nECtvy3uMcmwNFodyON/+4OsGqwhqD20NkXPGKTsPdYtb?=
 =?us-ascii?Q?+Mg/4o0bYy/M3LT40UMCxG74x0xA/gymGF4hQGAWGg/DoapI6Ypsl6c3/sNo?=
 =?us-ascii?Q?9qcvIuo2VgwSMjAjqMAoLa3lVNdKVeYmrIOBKt6XM8n2FIwcO3md7wQBS5xo?=
 =?us-ascii?Q?qlDQnoIvjQFglpxABw8BE6fTHA0LyxzSyD02AOGAtN0m6nCSOE92jFF9SXPr?=
 =?us-ascii?Q?YijSU9ceCQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a462a70-5193-427d-f804-08de8b0a4f0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:35:52.7674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WThzdp/MGxJCdX9YkXbj/R3kq7fOMuW3AoXMPFA5mUfk67qrxjnhBoh7qiLFqwANyjEtayLqqOBSTF2zX4iTsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950
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

On Wed, Mar 25, 2026 at 01:00:41PM -0600, Tom Rini wrote:
>This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
>do-nothing board_early_init_f function. Change to not enabling the
>option and so not needing an empty function.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
