Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158B1C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 11:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72BC8884D5;
	Tue, 28 May 2024 13:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="a3na2h7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A615884A9; Tue, 28 May 2024 13:13:48 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABBB884BC
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 13:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i408BU3CbhvjXZMWWW+0hfEtYvKpcouS+DCnu3xEAIU49uXFbu/tBTlHy4RJl/szgqmJ8jFndiSj8EyOKBlkIxHYBafFwvD1s3oygcIakwJwCyWm8DKdjE70nrms6yXXm2Keni+RiDY1ycCq5BAwU9bEUZ9b6fe3lFnhQg6JJ/6LprVUQEkxPIH9Scjj05DTrUJTkYaXKdZZ5hgxcuiibo8qj6Dt/nWr4uVMpsCiI0ACpO43HNYwgBBc2/GhqdX7uzkO/jZnO7vtrLpUmsj/4UNOhrfatZC5SB85OjjNTX/uvQlzv63I4bzhb43jkQX9fl99zF13LoGLAjq0zIRwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S82znkxlQVa2L7tkzFkJ9AGMaWDV4J14SKGHKfatmWU=;
 b=XpctFNlc3giprA1wckr6vbsF7nLZhsEiHlFBQt90QFGYGxEHEtyRvd9nw4sWfl0LKEp+n1BKVdTLxMDFaPYwZS+bumFxdrUerh+qBDniHyc+xCypd76jXFJ2f/M9yhqMSI7/NfHmFuIouZeeXioeYWKRFgKF+K9IG2HP6rEhOSKnAhCKj/aUfyxmNIYA63/ISj/NaXLghadjywlmzIDxg54VUuU2wqcjGzHHhThmstGZCLmIdaN9Nwm3xk2I76RAvj8mp3nSt+SCOjgefKsbzPzNxvGSs84MASzlSHQmE+qX04aw+7NDE2NYGbXXf5pAteRK2dVLComVGgoM25B3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S82znkxlQVa2L7tkzFkJ9AGMaWDV4J14SKGHKfatmWU=;
 b=a3na2h7NxI17LtfneknycR5MgIsXDsj+oA3Q5NNwa8cHIObORPeAPh0r3Op3R5PnNOOftnZD9XGELWICsuOz7x8qaW8hmQAMFFB/rMrQ0VJutl+NSU6MEit1fVbQZCUwKECQ7DMHBIHffegapFDUcj2uaFOuY70k3jfLjh14c64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB7079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 11:13:36 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 11:13:36 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huan Wang <alison.wang@nxp.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 0/7] watchdog_reset cleanup
Date: Tue, 28 May 2024 13:13:18 +0200
Message-Id: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: b929df69-93f3-4a79-4b84-08dc7f073767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|366007|52116005|376005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HRfZYnG77Weu+e4PEp58qUd7Rp0gL7TxlTkF17tJQ8hwaA5Ec1quwFC8dJ3B?=
 =?us-ascii?Q?b02XI/4yI+CoT2X6wmTOwcd8Eo9BteuUBGZMss4F17xB3SGQz7/0JDcLV/qf?=
 =?us-ascii?Q?kxDwFzVLiU7LELQak3K1Ls73eclFOQQB7fc/juPlcQv7LnQZuyEBgi5M8788?=
 =?us-ascii?Q?sL+1Z2YVTdwUPgkgP0pnAN0nXOqdkZIXkwylrxwICDaUEg/Km5lHR9lIYpfi?=
 =?us-ascii?Q?YTRE2N7fc45Fk0QQ7jyy8SxSNCZ72mLvBYnZp2dVNs6GqH7DAR9NBS3cqJz1?=
 =?us-ascii?Q?PJ4y++sZnj975XPJ0etbf5XDRY/IE4D4QdLWNWBdgGhBpZXWOjH1qs21v9ph?=
 =?us-ascii?Q?lNwPrqcYElmqLY3HGLyzWnpUqrtvx7/AtSLoAHDTA1FXgFevhjQsXXNyeJZV?=
 =?us-ascii?Q?M25JIxrgCv+Kc7AJDpp/yjSf4Gm3ofhAxTpBNUZvT/RHgov46MwGL8oNKlwT?=
 =?us-ascii?Q?jD2pdIzzcGp4TNAqevt64XVA5nys1/wB+Jln5WvpP/VJkV4c9kpCvomqbbRx?=
 =?us-ascii?Q?Jjz4tM6Ce0Xq6Zmkbqw88UoN7cOh9EW7Gx45Kd0dEBJTqMUxNtQh+GJ8Plym?=
 =?us-ascii?Q?1dPdtoGex7F1OELwsWjuuB8ALGwer3RYee7ZjsLuAtxi3/qeq3LG1JkGfZF4?=
 =?us-ascii?Q?26j7yNnD57RNqUkVo96/U4IuDO1DblP1S31/ZfF9KRLGT/4yuFHCZ4cCDOdz?=
 =?us-ascii?Q?ik7su/vwk+3jY3RuOWdEbU0/RRPzQZQEiyAVfkDD2EAhj3XwwKDO4A9ChR3d?=
 =?us-ascii?Q?iT8r4z9F0FbUnFMwgIbv1KpwwclzGhtYDSlq2/TbvNR5SWWgfeaNS8weIWu1?=
 =?us-ascii?Q?ar8eovdrhN5JVPPkNjQAZDiZDKcZCRJj5mgVRxC+sIM9yvxXlGRVhzom7S5b?=
 =?us-ascii?Q?LMsxWizsAk2WyXOHB5IOqgQywry+6Bm45BQwgv7qxZUZ9Km6Uu3Ekrlowj1R?=
 =?us-ascii?Q?ULUFHxJ2JEVNIWJw8W8R6zfiOO7Y5vxQewVZVu1XFlM5nbnvkSfk4x+gLMwL?=
 =?us-ascii?Q?S4ZRkvfUu8dzQxuWQAJ4eV/2g7z4LGa6+Jsen4qXAF6GOX73d0w/bE3WX1WC?=
 =?us-ascii?Q?g+k07nStLb2xI51wJ9OsNoLnTIgvLi0jrFCHsDgXU8SmGvS9Rk6b0ak9HT9v?=
 =?us-ascii?Q?vnawcYb75aw6sAoALFDM6hH0LCVilbG7mnpi3qMk/paEJ002nU8ke/l3KVfP?=
 =?us-ascii?Q?05nGrSZ/yDFcHgasBSTcaSHLTS5Rbz+OxbW/LmRJz300wtmCi220xglcpjNf?=
 =?us-ascii?Q?KTWOvcgPR7ilZpA0ZdYkkF+s5nER/amszFVowY02d4si7EOKRGK9ubpxn2XN?=
 =?us-ascii?Q?78iIR/EUqSjgbQdAQ+KvprINhq/GYw58xfL3doqxmVaCZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9jr9N+f+gVGKUWhZujwDIkpehd//2N8UB079bBgXzb5fTM/UK+MPGznQZekf?=
 =?us-ascii?Q?W3b4+uaPba9i65MBGn66wbc28ccXL2wAzJ7/+fH/b0R6m8P3fOC94w6S1F8O?=
 =?us-ascii?Q?u36H0Effdoz6pvtS6GSIMH4AZbYELnEJ+XO+54oQLAaqWw1SCi9VTALCnX1B?=
 =?us-ascii?Q?o6Ak/UKJt7Rnnwsk61+mwNI16a9BG7JztoPkvzwgSoOrt6YY4lE16Akv1eaI?=
 =?us-ascii?Q?wSWqepuCyLu30pJ6auED86hgQppQFVD5EUbW/OIi8SAqqZMQs+m8pYaTxT67?=
 =?us-ascii?Q?gzHT9MJArwMT1zW+ij2Xhhp5oZ71Ha031/aZAoREyKKIHnlCWLbW4YVBYqMU?=
 =?us-ascii?Q?fksYLbIqWJ3+HZI+3ZLrjDf+CynN3tvVjM1bt9Rf4ZAH4nHuzcnFHlc9cm7M?=
 =?us-ascii?Q?8mf5EjsXQxHQvo0eAt6PPOU3ScZKy9I+GhvfkXjtiyyHxXSMZufooTfRGEQw?=
 =?us-ascii?Q?sso+92wdwdrjlWlOZlaPKTj3UXrl1rGsxiVXS276bY39IEwRDbw0GxbubuIm?=
 =?us-ascii?Q?dBH5fI7STFxL0KsxbVt2E7k5KQrXzu+5oJMf+AgkFl72ytBfcKyjlNCxYt6E?=
 =?us-ascii?Q?bpYy9XFuyqoAUhb+IjuPcirFIJ1yNzMSx58Egth6WZ2efwiJku1nSjoUKByA?=
 =?us-ascii?Q?WoVxUu5wjbnlmjrronxR9mCZ38X+Udxkb035ZPbmNBu4zDHnVDn+0em+TQRq?=
 =?us-ascii?Q?0MB6s8yFkuGTnkpno1ZjKlUXcAqSycJUQOeilHJ9KQfhv8B5ZxEyAvmCgh4Y?=
 =?us-ascii?Q?xmpLZq+cSAgwijpZULgTjVLQYUpxVfOdmqEYfoBZe92k98mKrWDkPl0KLEvj?=
 =?us-ascii?Q?ZHyMUP4K4NkJjU3zmYv/dcYVoxNKuEsbrbfwUXeQITa+IiUNwnQ/jzf7BNCe?=
 =?us-ascii?Q?pJn2oPcVm50ywo1y7Zi0DOwmbzFO2H3L0f10eFwcDhwG/Yi9l2KtO+6Eh1vI?=
 =?us-ascii?Q?q2frQK3fkuhhjbEAsflOx2PfZSwQq6PZZfZWPv5oBZqMxsGRb0+zQRZIjegs?=
 =?us-ascii?Q?lNyetR/7ShGBAPCsYE85jbcVL4wq3KbSFzrP2gguR6+HYHpN7AoINiz4yUcT?=
 =?us-ascii?Q?6JQQIqFoqsOxXFeJNhgmMgdIUOEgAEGNwpaM5uBgliaKukCYtu7lK9dKKJy9?=
 =?us-ascii?Q?3NYPqcG1EInR/D7HK7y/1H1D0QFuYGnJROOz2acoae6v13y1NbS2bey/0pG2?=
 =?us-ascii?Q?BtneYO82UVms91Ixr0+ZHw/Suq758xDUdLbQrOEqUajUF89F7H7qWA6nHvOc?=
 =?us-ascii?Q?NAJDwfOLaSfU+vY4hUaREX12a43UAJkxGeVtG8afd9NB/bSjbq343Si7cdLr?=
 =?us-ascii?Q?iMtogBOYrq3G8yefLucm6Wgp535apBu3qyv0t93JDP6vWD+gH96uQW2nEUOv?=
 =?us-ascii?Q?SQWEfHajOOyeMuG1i5NdiY+o3zJ0M1mA6Q5E/GKEh7xmVw6VcSnRJsSo3Hrn?=
 =?us-ascii?Q?Jl0i07aWxTHAx5PMhdSXWrs91zpSZofpEgSZUVAJSpuOWsHtyeZD7jKRpwz6?=
 =?us-ascii?Q?mkxN3+g9260lcRJIcelaNOsy4CUAArWjMhonILuOtnor1SnNjA8aux7YSogL?=
 =?us-ascii?Q?h6UVB0u0ialHz/57JGeHcpu8pELkByGBTwwbfpYT1SU+EkaACUxZa9me1TDy?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b929df69-93f3-4a79-4b84-08dc7f073767
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 11:13:35.2666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y64ANa+vDD506O4PS+Ba7r/cztyeRxILjGC5IMftZhQRjldkpV7GpM9PUJo5McwswZs05gYsxY/ypdmeokRd1f9OWofapco7BE8kP1fF7q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7079
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

watchdog_reset is no more. That is, it is no longer called from
anywhere, so any leftover definitions are just dead weight, and
references in comments need to be updated.

I don't have access to any m68k, sh or powerpc boards. Only lightly
compile-tested.

Apart from the two sh4 patches, these are independent of each other
and can be applied individually.

Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Rasmus Villemoes (7):
  m68k: remove dead code
  wdt-uclass: watchdog_reset cleanup
  serial: ns16550: fix comment to mention schedule instead of
    watchdog_reset
  sh4: move reset_cpu() from watchdog.c to cpu.c
  sh4: remove watchdog.c file
  powerpc: mpc83xx: remove unused watchdog_reset() function
  powerpc: mpc85xx: remove dead watchdog-related code

 arch/m68k/cpu/mcf52x2/cpu.c    | 108 ---------------------------------
 arch/powerpc/cpu/mpc83xx/cpu.c |  15 -----
 arch/powerpc/cpu/mpc85xx/cpu.c |  31 ----------
 arch/sh/cpu/sh4/Makefile       |   2 +-
 arch/sh/cpu/sh4/cpu.c          |  10 +++
 arch/sh/cpu/sh4/watchdog.c     |  61 -------------------
 drivers/serial/ns16550.c       |   8 +--
 drivers/watchdog/wdt-uclass.c  |  19 +-----
 include/watchdog.h             |   3 -
 9 files changed, 17 insertions(+), 240 deletions(-)
 delete mode 100644 arch/sh/cpu/sh4/watchdog.c

-- 
2.40.1.1.g1c60b9335d

