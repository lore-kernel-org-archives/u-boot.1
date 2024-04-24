Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1D3C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72FA7883A6;
	Wed, 24 Apr 2024 09:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="vnZDt+aI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5287488DB7; Wed, 24 Apr 2024 09:43:55 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0704.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F4C87E96
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgnyvW/EWHv92K+9dwloDVxI1USKiXrOxtE1K7yEliAA9oLq7yN5XPnfkjaVXy7xkRoaDlFp9dPbCdJTQODn0XNB44f6fdtLYtZNl4+oodGnNC4+v7uBRjoE41YaV/7PPb61L4Z4hl1oHtfj02EW0IO6Yq+s8haRRobY612SQiq0JPNymSVEG1vqtZyrUOqm63i/4QbplgCiu5UXgn5LtcpY4N7H7xUcDgfjyhzc45ZE7z9iNLvjB0V9S0S1vOfFzdxQBVVgyaH9XtPCCWByPuAVYMWQH5AwFiSpAJN4WW/kPOH7+WFEIfThvTvJXQEte1lubjE1AT3/bl+8N0DW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V/8GAhwbhhs3sciOqd++tNn2+zDTcSlg/x0YcdSBlI=;
 b=dk24apXVuUmbvuISRQDKxmuLhN/Mg6FDlX/Wkti5Sn6pq1GedKjlPl0MTXmCTxYkm+VHRFA2vMB56cWwWeqoipybfr0IYl62EIJW0d88pw9yeLZ/PUtdNgPSdZ6RAW6PzAPsQoK2EK4HfqAN9y+2dF1+oF9GU+F0yaNkPFdIUI3BR3Zu6pxEXgCHdYiDypMZFGoO3ZswOsUwMnc2LCP8ap3nJJbrdGQpbcHJjfUutWu9IRev+8XIzdYgawjeaX7kRpAn1d+KdGTohDZcc9HocmSP1gPi3OQqqu+LjmGPFuMZ9o6X1f2Yy7gL8264g2RS831VMvtacMWIhGcYB2B04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V/8GAhwbhhs3sciOqd++tNn2+zDTcSlg/x0YcdSBlI=;
 b=vnZDt+aI6PD2ERweBN5bNinINyb2zzWm4xY/yo8Bem06bNQVCHY1FkwscJi69jV7zCOeWMVsvIvFT/eVZyARfKG5AuDgkkfPf3D1oGy5L4U9oiwxvTbIg8dkt59k3D/bqyuWJJ0nA8vvKpWKg13OTeL3BIx0YVy52GmMcNQYNyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM8PR08MB5844.eurprd08.prod.outlook.com (2603:10a6:20b:1d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:43:48 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:43:48 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Atish Patra <atishp@atishpatra.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Nylon Chen <nylon.chen@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/2] riscv: Rename spl_soc_init() to spl_dram_init()
Date: Wed, 24 Apr 2024 09:43:37 +0200
Message-Id: <20240424074339.210851-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM8PR08MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a3947e-ef78-4ff7-01a2-08dc64324734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tLF5td4AmIXjXNs+wA4nchk+Da1yb23p09E00Q1KRckXy5pXhei0bSTJ16ib?=
 =?us-ascii?Q?oDFDoNUB3jN6W+han/VFif0292FVeA/q8qPqxMwABfnW7XweJ8OkRiLtxakh?=
 =?us-ascii?Q?f0hZl6fQkxhaHHdTgSmW7KtKvUvzrgvyfFiIDGjcu0WGqAaR4QtwoI7GxGR8?=
 =?us-ascii?Q?PIbh9pdwAEA8cMoAFR6NvdS36MCAOKOFFU1nFmLA5x7v/snSZn8Mj73b2+5G?=
 =?us-ascii?Q?bd/s0ELWa976vSM64J6cmZIsQzWHr8OpMTGTFMAs5XtmBMPLxnu3+ARD/dK2?=
 =?us-ascii?Q?Uw7vKEJ9B/pWeK9ACOVsMa2dlZT7Ue6q2ogmsDFV+oliMpdo3+0J2edVb61W?=
 =?us-ascii?Q?5wIVVUDWKIofjAEIbQWQgiPqdbQjjIq7O8pzHufq86AMG9NXKEj0i9qSJIwv?=
 =?us-ascii?Q?5RqCpqzQg5zMhJ/setVKqCKl33t/uTYlJREx9gLl5baQFQvvE89ZVwtbypBH?=
 =?us-ascii?Q?fSfGmw8EHEhtp1bFsckAubTuqOyUs7/91T+Ekh2iGxZKOrLNztz5P3sm3SeL?=
 =?us-ascii?Q?NGA7xaWWrbmUC8Pi/L0/grR0O9O1f/v0HSMjWO5hWqJNdsex6sBmogZ5wzHB?=
 =?us-ascii?Q?a5hxZ7gxCGcVWn+pEZsdTLWW3fwE34E7431052CEuMk0/Hen4PaVCQmnDMzO?=
 =?us-ascii?Q?y8qH/vFjvM/NYGfQnHYokSHn56K1YZGISpxKotMzVQFmT8+mqg7KVj5uoVNU?=
 =?us-ascii?Q?WcH1nzE767tSmywqprEI+0FGJF02ABw8putVCTLJIsMukFrcISM4SipAyWtP?=
 =?us-ascii?Q?6rU8t2W9xvR0Dl2c6Lw/oIR1sC9NBy1RcO6sg8i8Rz8+794m5RJd/ijv+LgD?=
 =?us-ascii?Q?Wzvs6kzl7hGMpa5TlPKJMZc9V6EjfYxaonfuBf7embyM9AP+qdfVThuRHMWv?=
 =?us-ascii?Q?ku/dV4o1zSMbjwt1OmqxyZ1O7tbsB9sKDeIzcdJ4eLUfUGUGWSCP3fmR6bgG?=
 =?us-ascii?Q?9Az9KU/UJ8o8OgEluWFDCcyMBQE5PRQ88fpXNuMrhbZ5MynXvFkm8j3KZd21?=
 =?us-ascii?Q?fPIKYxCpy5mFBKU/Kw5fe3UavCPeYJcx0ieQB4xhvsO35vT1dGGhRVOO1vNd?=
 =?us-ascii?Q?qeRtyjsbV2f6mutx8fomO1EFYoZ2MGrPcbqTM6VI9GYk8iAgNZtiq1KhKKtl?=
 =?us-ascii?Q?drqs6JmC9PFu/RNJz1eqL2RWIr4wcn2giQQEu6nVuhPDDRxTijPuR6Vl4EB/?=
 =?us-ascii?Q?+lXP1a/S6QOZBvpu/EcSHQ5cGyJQ4hYUMcp7whj1Eq0VULnnaQj93jNWktq1?=
 =?us-ascii?Q?1PO1+k0XjlhnXa+KXa8ydzf/bu/2Gn9DQJOf59L8MpMRQiJ/HpALzkpv5jyY?=
 =?us-ascii?Q?f6vRKmAAkaC2ikXXN5TF4iGKI5rwlpCGOZPupagvJibOzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8powo7WfGqGuiLW/lOIQYCRzQyrSu7m3nXfPjrdUdsIBkhYHi9UvzF1X6FS?=
 =?us-ascii?Q?wVO3480isKLD35CBneE7ChIFSUh+tfkfEOdzQrz8JxrcnimLbdyBl2AeJ5p0?=
 =?us-ascii?Q?iEUT26sV0nuMmoj6V044Usvf/jYFGAZ/BFgULVJcT3yWXYxqvMNwNoQzI8Et?=
 =?us-ascii?Q?/ppiENkQ0mdDCMRcmDKMTWrx5QpHCRoGZU6RCVzLDzIQVX1F+Tr3wZemRx2U?=
 =?us-ascii?Q?kwc/CwJzPFWExqneiy6dAG7xdOLlaOrT0J137d2Lqy6ZA1CbQXSoT97xSGKB?=
 =?us-ascii?Q?PrE93MLv7/3hpQCiSKMmeZzQq+qF3r1xkpSHY57LObQAdT4wwgg3hv0YoW6q?=
 =?us-ascii?Q?XFD0f53nzNwaSbEfQf4y+4te37xLYvdM8yPATkd+hn3n2vihlv30p8hTEb4w?=
 =?us-ascii?Q?gY3YwzAyIlixNXQDtmYELnltf2t8Y8EuEWpQcYWlxEqt7QYpwZwF67gZ5SCo?=
 =?us-ascii?Q?30UyG0sKFAA3gmvAqn7pNsEokhWihK+nGR4hwJY88ugEkMTVQ3HepzF+cb4k?=
 =?us-ascii?Q?cmcPfHC8jqwv3hoeZ3qcmQVNq0Rn7Yt4PBB/DGHmjV46klUZ/9t1lGPc8H6u?=
 =?us-ascii?Q?3WayY2dR52zGUC2E/cJxfummigub+UeoIZ8AtOhNqChRjr2eRxuJTerjhouz?=
 =?us-ascii?Q?SHomPd/ddNbNqFRG0FyoGT8QgIpakgCcjLj18EDUzmMeUbrfqcZ8YLsh0pKw?=
 =?us-ascii?Q?Df5XaweTEoa+sOcil5pN/N1hKQHYQcch0MdrEp2SnmLPzCXR4jHr4I6e3OIO?=
 =?us-ascii?Q?4QOV7t18xjP/kHoze4WgbPi4lTpnJm6iSp852oRQEVddJ02/9K9+EMyGKGHP?=
 =?us-ascii?Q?HJK8TIBgV+7ZapmDffw84rosaDJTLVzB5JI9vs1KEYc5svjNJbXemVQ0dJCS?=
 =?us-ascii?Q?w9mGTmtgfmU/6e015ZmlfGEnJpKJTmxpN53Re2kk+9sHIXcI8Bx92fHlGNTb?=
 =?us-ascii?Q?LaGZEgV2az+bS0d9M715G9O2S3MrM08q3scPerb6eg7Rj5bC2mkOST7OW3EM?=
 =?us-ascii?Q?n9q02ie+4yglaSJhiiFcSjW81jX3tC/0NNGwdhM/oYL6JsRMLpaLjOF8BYwU?=
 =?us-ascii?Q?bkVPD3HUYxgy3wK+DkOFe0MWXGqFozFS4QRw/z0lPOFcQ2z8VtDlK1Wr522t?=
 =?us-ascii?Q?NO+vUd7AJ9ByP4G+YhfVnD44bNPJ8yisny0Ql8nzlC17+8jKjLESjR6fdx89?=
 =?us-ascii?Q?BiSS0vnyUo5BbIBiyxBEZDSacRHJqjdwxeJOlYJb8eNI2BE2BqF85rjC1cl/?=
 =?us-ascii?Q?eRxk5EzQdYK8U4R9jf8H08T9HpE2Xh+JTeLTNZ55cTql4VZ6Hc+7sY2oy1+b?=
 =?us-ascii?Q?FKUK3dE06HASmQQ1of4iYFeF7GILTqfzGw5WSTp6tK/+mzIK834cz0ULn/zW?=
 =?us-ascii?Q?qDkF4V7JZx1fygF9CLxdf2v6VweA8PXcbe7ziZE2gNaa8VgMIIdMw2Mis0mx?=
 =?us-ascii?Q?Zg77aPcTxZfbgkISUlTx3XBhvsKuw7aNDDAAHKZjXQ8jL7t9KxseX9v1dhJ3?=
 =?us-ascii?Q?v/UMTU6Wv2aQIUWAX6nUQefOif4c45B+EBD0KvbjpXt67++8CHQrx7w2NmrS?=
 =?us-ascii?Q?JQ0EiyCvhKBw0ynoZ7VL6eeDvIi8s1oVuuyBfzdSyOWmeopjm0SYJf33zOrQ?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a3947e-ef78-4ff7-01a2-08dc64324734
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:43:48.6743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRgkp5VwKM7NVKND9qpY+OHtXZiX2DPcvUaZMpAh7WUl27ImjPtOhgFqM7bESWm6eMEnTmMfXAhIj4VR+BxSZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5844
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This patch series renames spl_soc_init() to spl_dram_init() since the
purpose of the function is to initialization the DRAM on sifive/starfive
boards. spl_dram_init() is a commonly used function for this purpose.

Changes in v3:
 - Reorganize patches such that each patch can be built individually

Changes in v2:
 - capitalized acronym DRAM

Lukas Funke (2):
  board: sifive: Rename spl_soc_init() to spl_dram_init()
  board: starfive: Rename spl_soc_init() to spl_dram_init()

 arch/riscv/cpu/fu540/spl.c               | 2 +-
 arch/riscv/cpu/fu740/spl.c               | 2 +-
 arch/riscv/cpu/jh7110/spl.c              | 2 +-
 arch/riscv/include/asm/arch-fu540/spl.h  | 2 +-
 arch/riscv/include/asm/arch-fu740/spl.h  | 2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
 board/sifive/unleashed/spl.c             | 4 ++--
 board/sifive/unmatched/spl.c             | 4 ++--
 board/starfive/visionfive2/spl.c         | 4 ++--
 9 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.30.2

