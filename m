Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC7610ED656
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 10:27:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918D283DA7;
	Fri, 27 Mar 2026 11:27:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OLTSbkFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF7883E7A; Fri, 27 Mar 2026 11:27:31 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE02283C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 11:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1z2EKLsVX9fAESorlnXwmugLb1C8mFB4Doyf173YGlREg7MX3jhd0wPITzuKMkRpBvbSrH3y1LSOsCeUYc173kqutMrctm7dTVyK1focbY/n4BjJHN21sSohVQ0RWAf71sNpNY6kiz1jC1/3+zW7iJNxJimWJf3lz+MdC4Ca3LiBnrjGcyvPd0woTwuB6E6Ua1c0xLPYeJcj9PzvdLKnMh6rQlZcgB7k4Ayr1MW8OoSevwy2iXAzy4zfKSx8Csn32FnNjCGeUUjLlAi17+vKv2xW+XlDNITvORqNF4KLEYMAPfHcfpddtj32G8KCDkQLhrg8uDz4b5ptv4IZ6P+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJvU2NkY8MLW7uje//B8b+6DAp3VKsR/a/XnFrzaOuI=;
 b=R49YqCWrLl6PIyXgc8VYFzvsDaW6rp8TdcbDsycQfDqnpwqDBbBzQaylxvQjIsH8CcVFGsuI1rz0GPmOJOGP2pUcz+wO7U3gHTO0Hm6J88ki0dgK9MEsWk/PzgfMm38CyRz7DdEwQAIyoQuC4Ed1+ey3ggJ9kRqhpBWSSESIwMqLrCnjTYdYnrT6qMAFLkmRUj647EK8wFxAWr08+NeVcEAPJnEsWNZreNAhHUYT5rrazGg/3q/oqla25ikHkZDV6w63qPfu+zLa1xrZR9FUBa82o03aIcFfM976kLUZzk/z9s2FUcmI+HojxKqvvXeGIAl4wL/h3krxTeBHBugKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJvU2NkY8MLW7uje//B8b+6DAp3VKsR/a/XnFrzaOuI=;
 b=OLTSbkFpEOlX37TBZcBihmp15d5eXEfWajT3HT/VUVifNi3e+AgiCFRYQ9O9A4+9po82iMzdqD5g3M3/Uyy4jA+QXn4WApWcPfOXqk1sQg5mNJ+pbOwafjt0msRRUdO5qJS6JF2R80pO3TXhoMjy0ry4teYhroqQpVNDnztLLhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DBAPR10MB4107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 27 Mar
 2026 10:27:25 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 10:27:24 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: <u-boot@lists.denx.de>,  Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>,  Ion Agorria <ion@agorria.com>,  "Miquel
 Raynal" <miquel.raynal@bootlin.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] kbuild: Use relative paths in generated .incbin
 directives
In-Reply-To: <87cy0plmh8.fsf@prevas.dk> (Rasmus Villemoes's message of "Fri,
 27 Mar 2026 09:12:35 +0100")
References: <20260326115500.955388-1-sjg@chromium.org>
 <20260326115500.955388-2-sjg@chromium.org> <87cy0plmh8.fsf@prevas.dk>
Date: Fri, 27 Mar 2026 11:27:23 +0100
Message-ID: <875x6hlg8k.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0006.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DBAPR10MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f5a423-f346-4ca5-01d1-08de8beb7005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9jT//izSb0rUf71JdMBr4bCTjAjdOOmD9REhKRGxC8tmp4kWPwMmzY6ZfnByztuv3VkCyPAqbT9CWSd+r9jmrbFtQfu9o/YXwLJ30qafKOp+atIigWotFUSB9QsQaXwkOSGemoXP+rqAv995Xm7x5iUppOau8H1DFNhM6exEgN40R5MIR89Gs04WRFBBL79+GZ5R7UCzy0ecUUakEBFZZRG/4AYL0AeEULPgEN4EsuGxlMPn462Nj9BLIHSefcE+zUOa/6/3QmsrpboYfmrN1OhooOjyIvCGKBmIAtnAMvDBdsM1gfjq1aVKvqaQ8+t9BOdQEJWeJowfqnFD6eQDFJWVbMHUZZf0idoftrMyG+7n/zRExgmY94BXBDiQUoUXUX0ukmEw8nFldNlqn6hB10F8gbBQp6tmS2Rkpn5I/Pb90sFj2DdZz6UffuSELA0scwJn56e0oVLAFPrGNzYpHK7JWCUd16HuXpyPMTsg+o5z2VZxdQErkHcJc0f6WlaXyzrNjH+kGxbRVkyDbpqY+EzPe/IaoBfeV+57uPLf3EGMAqB8igbLE9BNOXcYRQTIaQYcEIuWd9zJBdn2h1I/dm3Jn1+APHgSS+2leklEj1wluQ8sEedom89k8LuZGv77J0iHg5MU6bc3koS0YvuZIQQf8Xo/7yRT7/9Ged4F8YbeGqQE9JKwkTyufk9e8ptTPPzdj57WmLn0tMAgQm7zikaJ2x8FtoSv9pFxVO/LEFwQHtiC2CinU9VP829vwi7vKjak329wOzVXG9JVSBN0EwKkVSF42hIcbjvIsUhW8n0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uZ2YbM5MbQx2ifdm5SnJoWBdlgAOZt33Um6ic6vwLDAqHepxmR0guLXNGPyF?=
 =?us-ascii?Q?iRpadRWutYvqftJAmDCVqCsi512d6nL0tiKsEIgapI86b2q+11gXcPGa01fF?=
 =?us-ascii?Q?6wR1QNDmWNUq2WJajPPtjJgOiXjPz4PK/9M0R+6HL7myZD9jVMBYj94dg8Mj?=
 =?us-ascii?Q?7zACRU4M2cZlfnFnGHQ6uxpwpIepDH9zliV55bPLotL/RgcSmCYGm677duXu?=
 =?us-ascii?Q?DR8vu7Yyku9sSohVl5tpgfJAjjBWeEXxjRBr6Wzl3yXmlEFbcCakDsVhwydr?=
 =?us-ascii?Q?lU2tJ2+NpHQ7J1lPmqKHVrK0EeLQFhDxaYTO6Zj3n+DmkeUdLTvFxm1rSGuK?=
 =?us-ascii?Q?9l0tcsP3sKlKjLzaWi6Qz/b/Sl/zjX/woKEX0w7EZfsHiD4QNqdJDHf7a57F?=
 =?us-ascii?Q?CB0hgyfSrur287LoXKAnj27FtDNCouXtBDJwXSMumw2RXZb70ms5holhUs3H?=
 =?us-ascii?Q?nRQybUBLtsouvJugLGm08TkisLZre6nuVAiuls+puBE7J6STUzubYSJGW8+L?=
 =?us-ascii?Q?yiXW3MldUcvRbkkTyeXS5gUOrljqyEm+brPegieZMdaP2fyQ5jsfBX1SWkQA?=
 =?us-ascii?Q?PdH+AE+ubdXd+OMqjrFgrXI8nMNs3Cn6zNSJGC6txkwAyjCFDX/2ydgtVCf1?=
 =?us-ascii?Q?5grts+W2jAEWbFMV4BTslLy/6zOQmcg6KjM+eWRLcfvfht+XOEcbU+kyQXzP?=
 =?us-ascii?Q?j6hjqFULeyH4PmthGFqQn7U9TEXUm24Du6g2aQtzPQxEA74RkZPDO8lWotvv?=
 =?us-ascii?Q?O/Q5q9CPNDJE1kJGPUdwPC2hPyc94U/t3fEGJJgTG15GWk6peRWxXuL4dQ9m?=
 =?us-ascii?Q?aDi5169XrVMbpI6qXyFr0hYw6hPunPGH9S79TUJuFxllkmBNSMe7DfEoLfc8?=
 =?us-ascii?Q?DYZqogFVf2+diTKvJNtf/0r/Ha64oKd/Tz6N3e+FBksvljyrjfwtObrY49n/?=
 =?us-ascii?Q?jOzW5K1UT485NKJir2syVBjjh/FTGhK0AuFVg0eoW8hH51eD7Bu6Y4V2T7O5?=
 =?us-ascii?Q?qb9NoUsxObXY5NzQb7Mo0CZOPrr2L/zaOW53MlYLiJzCspC2NjG2j2g8ONsn?=
 =?us-ascii?Q?Txq/DWINJ9X/BSUSjgVDqkDh66R4Q4Zcd+Kgxp2B1C//T1yAqEyTc3KlmSRg?=
 =?us-ascii?Q?byM8Shug0DUy/Y3ir7xKKs+fv/lH/TNUaUa1wNOflW7fkR41weY29PJ4gPor?=
 =?us-ascii?Q?vCpvVv+BzvtaNKCstIIykFiGpr2f4aWogDuHpdTkbgnvKu2Hvd8R0sTfZjHp?=
 =?us-ascii?Q?1JThWqoKDT2SLkI7pZ3QcTIRk3rxpp1QUnTzl4DlNItWhNAw0I9psgHFh4hC?=
 =?us-ascii?Q?yPcIiQOV3sb2dQwY+i779TBv1q8gjPEr5UyJ3BdgMRcaDuVGuG9v/seQ4AR6?=
 =?us-ascii?Q?3AFCILGROFTLoeJOrrTqW3dsxcg1mpJ75FdQ8C/oPmoysomu5nyczrn7mNAg?=
 =?us-ascii?Q?iJsVcZ+h2un7R2lxmkH7PNpavUiua+RM+CrxD9ZNPR0mC7lofYPzDnvvGVR/?=
 =?us-ascii?Q?NZNVI9rTlRsZZDf1XV+tWm+ebSNbqRmsqTZthg5RF2xdEGTAsUH5VSSRQA0l?=
 =?us-ascii?Q?vH37WULoiOJZ58HFdGABs8cnEPiIoHcUqNoUsN7NZfbf5axGQ/EQanUdZoxQ?=
 =?us-ascii?Q?IsptVo2WyZUQDl2RoE5+P2POthmBfFuLelmmJhDxcYJusjluNdS7Kr6IB7SR?=
 =?us-ascii?Q?OegaYlIIVGZ3hh+xTFheldvYG99dgtNQydXS35fs+w3d1AVZi+dzuWP0i1Lb?=
 =?us-ascii?Q?jopj2w73zc9GFxwds3LO0pfvBXZz8hE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f5a423-f346-4ca5-01d1-08de8beb7005
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:27:24.8539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XF2/zw4ZuqAhNL8Lda/5LsaFni0lEaOnKnumI8/5vw09rM8fdrvStWtMnmKh1geK6VNlXE6zsGuDz8r4fzVdlJIFSR7KynW9kfSGsRHrMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4107
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

On Fri, Mar 27 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Thu, Mar 26 2026, Simon Glass <sjg@chromium.org> wrote:
>
>> The generated .S files for fonts and splash screens use .incbin with the
>> full prerequisite path. When building with O= this bakes an absolute
>> path into the .S file. If the build directory is later used on a
>> different machine (e.g. in a container), the assembler cannot find the
>> source file.
>
> I must be missing something, because I can't see how this can be a
> problem, while all the other absolute paths to the source dir that go
> into files generated in the build directory is not. For example, there's
> a top-level "source -> /path/to/u-boot" symlink created, and as far as I
> can tell, all the .foo.o.cmd files end up full of such references as
> well, e.g. $BUILD/lib/.vsprintf.o.cmd contains
>
> source_lib/vsprintf.o := /path/to/u-boot/lib/vsprintf.c

OK, I can sort-of reproduce, though I don't know if what I did is
representable for your use case. No containers involved, just moved the
source directory.

  # original source dir
  $ cd /tmp/u-boot 
  $ make O=/tmp/build sandbox_defconfig
  $ make O=/tmp/build -j7
  $ cd /tmp ; mv u-boot u-boot-new ; cd u-boot-new
  $ make O=/tmp/build -j7

This breaks as you describe, but most files simply get rebuilt due to
their .cmd files containing stale references to /tmp/u-boot/. Which
suggests that the bug is really the lack of a .S.cmd file describing how
the .S file was created in the first place.

This seems to be a better fix, which also causes the .S files to be
generated anew if one does some actual change to the rule:

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7386353e0cc..b2441080e7e 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -526,8 +526,8 @@ cmd_S_ttf=						\
 	echo '.balign 16';				\
 ) > $@
 
-$(obj)/%.S: $(src)/%.ttf
-	$(call cmd,S_ttf)
+$(obj)/%.S: $(src)/%.ttf FORCE
+	$(call if_changed,S_ttf)
 
 # Splash logos
 # ---------------------------------------------------------------------------
@@ -547,8 +547,8 @@ cmd_S_splash=						\
 	echo '.balign 16';				\
 ) > $@
 
-$(obj)/%.S: $(src)/%.bmp
-	$(call cmd,S_splash)
+$(obj)/%.S: $(src)/%.bmp FORCE
+	$(call if_changed,S_splash)
 
 # EFI applications
 # A Makefile target *.efi is built as EFI application.

See e.g. kernel commit a7f9241909 which did essentially the same change
to the .dtb -> .S rule back in 2018.

It still makes sense to put these rules in a u-boot specific makefile,
but this should avoid the need for each font .o file to need those
AFLAGS changes.

Rasmus
