Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCD6C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0146888DE6;
	Wed, 24 Apr 2024 10:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="TjE1CXV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65FD88B5C; Wed, 24 Apr 2024 10:23:53 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C7388DE6
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkBmJbfN1lCkSxWWxkzlCfaXwIfWavos6ET0BpE2HRQflZzerciCDQ6XSxgVvE6wPqizNyPWhUytzv90/b65lOjx0M7p7VFrcLnK0th/RVCNMd5/5re1nMykPzlFZ/4cFZJyZywlNhGCTy7DZiaakOUAtC1I0NaW0/8Hr55uOuPAaSiyoxkCZDK1z7ZzjJ79XOQvl2pQJYqozktfeMaILchyou6odWqxA5hJh6YBaslu+zRWzxKhIFUCrdYiIDDkAShlWtChUR3g+fZFpucqHL1xOJCmqx9sdz+p07A8Euw2OqsgOB7udVf5BPjXek56072QtZv43bDEpSu0y0pJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf6TdYsU5J3M6+q50jA0Q8y7d1RMR6S6EHkjonnprDY=;
 b=iTkPfgMJfmCtAv0VftO2IWnC19nwcJS9/Rk+ba8+MC/hkVewBH9a4Xi0cRpyGN856rmIII5PKPHyp06oN50nQdMvRLOB66YxHhcgKQaNv1s5tGc19PyGgYfHC/pPfsQ1S6rqJmkYm/Np8XiqGaMmwH0ha9W8gt1JpDOMpQIHUO+FaoNrtJgFXK5GlJnQcTrYxQ24LXUcrvA5svBxXWoGc2D0VT8QD9UpQhQsiQJUXthKuDcyMePy1c7DvysrzVPKD9cqYY8UrP5xv+96dw7XsSLkZrJTNOMe0s3DrpAjtFZ7yrtIGpE20jjlv27Wc0qQCPA4sOWgZZ1tUkbHqiQT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf6TdYsU5J3M6+q50jA0Q8y7d1RMR6S6EHkjonnprDY=;
 b=TjE1CXV5j1KcwctiJ4p9zfuXSaJQ6tdJ2WCClq1GwwnBCVSvA2/MFQta+VMwvpLh5nFYc6Rw0asjcjYMxrxDK56SkayAjyyZMqhs4aqVGWFkMRAvZx4SF0L70ot0nuDsb1W3PWhObBrUBMpILrHGvBDVb7eWJcNK3vf6G24MH0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB5985.eurprd08.prod.outlook.com (2603:10a6:20b:286::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:23:50 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:23:50 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Stefan Herbrechtsmeier <Stefan.Herbrechtsmeier@weidmueller.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 0/1] mmc: zynq_sdhci: Only evaluate card-stable signal
 if card was detected
Date: Wed, 24 Apr 2024 10:23:41 +0200
Message-Id: <20240424082343.212554-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: c651f92c-5029-4a59-562e-08dc6437ded6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LGMsSraIfV4/RMZrqXdZf0FjqBNYtcwxOKHD2sS9eeyHkpUuirxe1m+r/3Xv?=
 =?us-ascii?Q?Ju4iVgQKnD6gDM68T6BWBmqKjuHiLv2lgFOr7LMmw+MNsY3CZjJaOVWKmmmp?=
 =?us-ascii?Q?bi7aP83w8laUmYipvkuEWqZz4vAFw7CgKk7RyOPbuldgT4aQJVMfWQaUYf5e?=
 =?us-ascii?Q?qAkJN3k8JVGiLwiF4NR9kHRGMcgHpQRNKm284xSNvf32Ndw+YkcHSLmdkcY+?=
 =?us-ascii?Q?fu4P28oLe1xNjSjB/2S4/a+sug9v27n3A0AUz1uQ3CL+9Z54xEPNuMeU44HI?=
 =?us-ascii?Q?S4WdeWV5GzuOozxc383N7/Rg6V7IpO8KN8wRmNS5YG/zLSuJ7Hd71gHCLyVZ?=
 =?us-ascii?Q?SoXFCLmhaf7WfMBkX03KFUulvlxMdsjNysyX98aOBPb9EBE+QbDhr7ZAiDCE?=
 =?us-ascii?Q?9tUisPYfEyxEMNU4apxcLEH6amjwi1BBy1mgsV2PgMY0mhVGruvmV7lO7mGE?=
 =?us-ascii?Q?quCcVvN+NfP4AGiPnRo+vAe63qojP8v19WZ0yTbY9flVy6WBLCBeEY5zxdS8?=
 =?us-ascii?Q?fC1qATlpR8bqyJSsVf56Wi4rzaLbNymXrCWnSVHOZ3NgZWftCQ6Z7koH4yxF?=
 =?us-ascii?Q?qBQxXaTj110G9UtLfJ08iWxBLf0qOf5PB3+Q3o0B8RfFIlQQ2tzBPasCOR+j?=
 =?us-ascii?Q?OYK/WLk9qUq064zfUyARoqMjc0K/BosspaFlNVrG9DzyZi5lPMzP4ocWU0/M?=
 =?us-ascii?Q?FgeK/zTVMZRAzAHyoT1W+9JM09LzQrntDV9pYjJ1lciYcnDwBrrW8QU14ZeF?=
 =?us-ascii?Q?nKbAZfiF057MfpA85WzQtVQVPRJelmslKJJKOetxfsfqSbaHUYBTcy/85FV7?=
 =?us-ascii?Q?BE97s3L/inTNAV67tMDJaenEVk7+qHKhVgdqbKyak8H/wiFdfj6gyUjw2Ntg?=
 =?us-ascii?Q?lnn4fzGNq2Lkfenx3JaN/kuLCQGyySMCdZXb4io2XbFzr65G0QZ1gp4Zfkme?=
 =?us-ascii?Q?mRmDPwIeKZ7g6wmCOLF6+QVaDlp1t6Km1o08P31qxSQydORwhKgZT9brjY3/?=
 =?us-ascii?Q?o5MDYxh5Bm3mLaI7hZEw0f0aRMv3b2t53F17xoHLVSNMsjvjAbnO+YCmt5m0?=
 =?us-ascii?Q?xNJnd7OfgC9phupPJJceFJsSXRHWx+lYG0wMPypbwPYap5ZAyKxF72JcEQ80?=
 =?us-ascii?Q?Is4za7jgfN2Vz2wDc7v/kqvlvo1NzU9cvSn3qbe0yiDQ/CS91HC7zFOXASQN?=
 =?us-ascii?Q?JUFdWL2Kly7/mtJO7clzxdxaA9TV/r/AfvwkQe5tv2T52WNaqr9bqhlIO++F?=
 =?us-ascii?Q?ymjHL45PM3D+uNM44z33S/vFriRPJ/LC0njCuSjwpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fx+conecGkBmGkrRGiFNoKc5wamA00+V34oXxhYlEGZruwsvPZntHtvIAlLZ?=
 =?us-ascii?Q?Zp2ZeEO7zJOXrw1yrp4k7opS7CEaj6cmJAixa//ew8EgL5JUAovxHL/XrmaA?=
 =?us-ascii?Q?swnPXyW7cBpTzSld4ajkOo38V77tnu1PEWXD8TzFWdInBRQLADDk6LJQyxOj?=
 =?us-ascii?Q?mA2R+gIsVWIBzOnKx5V+AFKE2IA5bByjmY4xqHAJdIM5fZzJ/YWweUUjRW/Q?=
 =?us-ascii?Q?HT4zsg9owzL25hYYpdpYa+nnQW1ZcXW5lG/Tjauyc1lzSWZ82iLAe6tOAYL4?=
 =?us-ascii?Q?6CxevZcetgR/WOkFqrt7KfzRFfjcP/sEuNrVO8RFXmR/za33dfihoHaDs9aL?=
 =?us-ascii?Q?AMrQ+HatoKXPxaJpC9xkxvnOGE++Oa+iD0jw7FMQHf3TC3Pu+0prMtCgAeCc?=
 =?us-ascii?Q?7QQ1y5bN96eAhKYhBIywOQ7DznXiQEJGbg2G9LCRKalsCvFa1XZyryQVdJl4?=
 =?us-ascii?Q?YW08wr45Jeu3r4NKRLQt+mx+ihq3mPw40e4smYZfhLtDzSAcsAdR3oqkFJYG?=
 =?us-ascii?Q?JHDvC7ZbbEC7iX9L+pudR/FRedrUE9UGErtMVvpEvwnUexAQYGyDML+Abrh9?=
 =?us-ascii?Q?VqSKR1BdrcOoTWy1IIh5dFhLKLKRAzyDNOatWuKvqZQU7qFaAnAhZDW5VXiF?=
 =?us-ascii?Q?tSD0MGIkfp+SgZFz4mDnN/Epzj7honlcbTYTAdIvXZTeDIizwcvD6//ADbHc?=
 =?us-ascii?Q?esgNnnGUeLoNX1GW4zYWeAuAWH9jOFI1L0iqhLLGbE+ohJkwUx5XUvOMUcZ1?=
 =?us-ascii?Q?QWWAvNAaqhoWNsg1anLWhNzlp/DXC2c3x48CS8W9m8OSvPyaozk80vpHHuG8?=
 =?us-ascii?Q?XwLKVOi34IWJhdpkHPhVEAsPDR+k3aqU+j/LHl45+ooe8PYveXy4kDRfs1bm?=
 =?us-ascii?Q?NkB+HH/5wfgtBw93WgQHFXI+cVwCuci4cgqd059oClrVY2o1eJFDFJdQFvYS?=
 =?us-ascii?Q?52ekceQC7M9evCW9dWRNzsCs3jhY+xFs0oDEZX4ElKuBGLld+ZCOwpu3SUAs?=
 =?us-ascii?Q?b+TQxqXwzMYyDEnx/CsXkC4HoS7jJjrVF+oxZ+5H7oCt1NXKGS9rex96PfkJ?=
 =?us-ascii?Q?EKFTEaPxkWkgYmfsR5Pp4rLbM3ZHObv1ZyH/CqE79m/fiTA9wGJYDOykKJ64?=
 =?us-ascii?Q?i/iWBMJVL1m73Lqbb1Jfu4Tn4exXe+HdfmA2NHxi07xcBjHvVKP3hn1Xlza2?=
 =?us-ascii?Q?OKOexPYyx8kNI8gCULElzukiRaYyRqmqLCRfzpUhZUsBU9RicrXAhk7EmKSU?=
 =?us-ascii?Q?5y8Q92D8iAonMURJT/FzWylk9kqnz/QAHcvICwcI3V1gpaZFMkfcK4Jm1FGm?=
 =?us-ascii?Q?hyaLujz70N20etSBz5cPP3TYa5FbHB0urBj3l8UASu7wQ/LpG17Wqsl+ajRl?=
 =?us-ascii?Q?R9f89xKVH7Xj5Vk8Wa1mMtY5Pq4TpxxdiS4AS0moKoqFHYksz16mbPcPRgjt?=
 =?us-ascii?Q?/YUkXzrU+5Ma9e0zUb3VcYKaJEUkmozOsOnVzrcTfWoBroKQQFQjqf55ONZp?=
 =?us-ascii?Q?DvJbATMRg8ifAMigRmS5VuM/DXr5qQlogtUmuhgKvC5ZX0CwPXjZRUqyoQ8E?=
 =?us-ascii?Q?Jw/ISWM1dlGxizDD1oYi7DLRcV5TNDYbJvEkBDFBGjObAGjU/ZlwaHbanRU0?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c651f92c-5029-4a59-562e-08dc6437ded6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:23:50.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEcsesNofR6vGZwBqGazAdBKRj7eHDmcGWW/rZ/WdpR5gjczpvtt8LdxgcoltbIG3p8E+I51kBSxr0oxHqOEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5985
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


On ZynqMp there seems to be a dependency between the card-stable bit and
the card-detect bit. The card-stable bit is set *if and only if*
the card-detect bit was set before, indicating that the signal was
stable and reliable during card insertion.

If the card-detect bit is *not* evaluated the corresponding check leads
to a timeout indicating that the card-detect was not stable.

There was another patch that tried to mitigate this behaviour:

https://lore.kernel.org/u-boot/20230516142116.29996-1-stefan.herbrechtsmeier-oss@weidmueller.com/T/#m295a0158fe62da7289baa26bcd7272ad8598af56

However, the discussion stalled and the solution was not accepted. This
patch introduces another way to deal with the observed behaviour.



Lukas Funke (1):
  mmc: zynq_sdhci: Only evaluate card-stable signal if card was detected

 drivers/mmc/zynq_sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.30.2

