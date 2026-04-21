Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1E3F327B0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067BD8431E;
	Tue, 21 Apr 2026 10:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="XvqEpFJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA1B8433B; Tue, 21 Apr 2026 10:34:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934D784258
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nihlXciYVJzDA5E8ZQp7cgUKmO99V4uEqm98kmW9ayXqnmkp2Is2erHYRE1eTDxpr2lw589gnMBtEFsIhdCsbwJCWDTP2LpHfRhcjiS8OlhHgI1CTrNcny8Ucjb3y06zLWFAjW+xgBxOozh7OiqsTfNRzageT8LdH0Tb9mLk1zKGE+eygHnw0jrkPKKDBSCqup02CP1/D5aIeYb8YJTm0vV4gwL2/Mnej/tOha0ASsAlNyWFwrFqnNI/PkDZvrLroWL+L3g1wH6qvhs5yd3JA2a1cJpIkMCwpQUojjsRck4e3uKzLHRuUvNSRwNaziw2BvN+jffY2qM5QNOegJDxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hOxIi3fvnM9QzM2ZEQOO+fTFSlwiwh6EgcxkXx40z4=;
 b=BunBL8g9zJZ9XgsWofsKW4V9M74K5tQPe5ZZfO1lm5rHrJO+dCt/za/WXMWJCvcaY/gQhxlN3uSmr8HWpsSkH4AvydKzFMNV5v6VKBmE3xJUoVf2+jo6a3LNUyTk91ResITncsRrK6ziAPqx2ULf7Q84bIKmWlE1DJeAOTfJB0c51Cb9PCH+5Y87SyH5EAg/kP/FaYzy1PL07Jn8lzRHelVKuc8A16JGtdqzFN6naPAkJYJ+JTaNwnE54Ix225fPu1kdT63eniT5H5eCJfbqURJ9n4AUAhctjXcuikp9Xw2o1EHlpea1iRbkRH+2hpoavdmI3XItIBNLjKFoy03SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hOxIi3fvnM9QzM2ZEQOO+fTFSlwiwh6EgcxkXx40z4=;
 b=XvqEpFJNEDNUne6h2EFa+usv4EQAxeHv+sjkBHzb509PlG0PvtvdCMaAOgBXlXwu8Pz+guzEUZnNQlAPj+uKYdhAPxhY4odqJiZ4FxrmUvu4NxePz0T/USykUfTqo1kXXLNxyBUSzu7SeumYFMKYaPQl9iU/4mqANlP4b8IMCHzeD7eiQjvcljfg7N36pWblxaQRMqaDtapl1CYtoXA/+c4iBw4SaD5Xu8wMYBe7ZRSKEbfFSSkPDNxjwpSOLc6Tg6AETVJ47Q7SPJFf6EOFzVDop9gJROvlZCtjjHf/OPYACc0r2d8sygcMp1J63At0hHwMVI8P6mRUAlzks/4vwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM7PR03MB6231.eurprd03.prod.outlook.com (2603:10a6:20b:142::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 08:34:03 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:34:03 +0000
Date: Tue, 21 Apr 2026 10:34:01 +0200
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
Message-ID: <aec2eSBfuDD8GyM3@mt.com>
References: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
 <61daa047-74f0-4a76-a61f-de54ca4b716e@baylibre.com>
 <ec9b6639-00a0-4fc4-aee4-f57f9cb26a5b@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9b6639-00a0-4fc4-aee4-f57f9cb26a5b@baylibre.com>
X-ClientProxiedBy: ZR0P278CA0201.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM7PR03MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: d89aff40-fac9-4b00-561a-08de9f80be7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GINMBgiI8g4pwyhtM5jV/kib+egi8+ZOUXYYAI4BO4Qx4UgY+MUjtnaY7UKLmEnfJ36fb+6xTsCJ8EUwdsZiMqz2FMgj/6LdmVBGMWyYVJd11k7WfOeMT+dXqcWCANB+Bfs29Lm7OSNxnTuzf/cf5m1g/C9NFd1zz8Km7N25UbIjYU+xG0GMHC7oSr4k0E2ZEph8ICW3autn2mZCfcnxOlCMGx5GozcZ4QaNvWRQzO7xoOsOGuyqAiqY4F9c3+E5nrJXmw13MBgegPiho/h9O/c3ZLmzs0WmBtj8N41RJtriEr99xb2GE4S9MObWrr6m3/Z7vlgy9u49RL2SucM1hV89Yz98apoS+41MygVWKIkI4WXCBj2cUguE8STrzQ985Zq0qQroTpY6ZeY07VKXqDG9bpWAHV55puzxLVTSkALuNrpl1o8httGqQ/4ldfFEu8Qf+gA1AG5jDFRHUoC0lLVOUd76Ydgc1MzVLW8jZ0wnwp0EbSaxWH28766i4gvA6Vlo3yufdguvf15gp2Kyz+AAYZloJBUUEvhuRmKIwpZSGgoQhnzpui+7rsFE11lbr5HjQQQQj/f5LpFjGhZW+XN2xYxuBBi02zY0v/p3TD/EUO+jUiv4+xeVHkNHJxKF/K+fFP0HP3ZPK4J2CFf7Nnl4q+HnKVVCiWUANHmZnGYSY+N8z4Q/x7mF4RsqG3bnm8GBXp/wHKbzuz2KWvVDKXSntMldku9iFp5YdmD26Rml7eTsn5pGfV+R9Quks9jJXTnUr0OiNXYX6F4N3ZyoPqhqzRhPDHCYwIVxrFaVM1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mT4DrpthG9IyOsMZAhiokKkJSNI+VnagoS5h2Molt4Krfj0rbMDJFWC/+4ud?=
 =?us-ascii?Q?07fLIT3MJUAclKKXaH9Q2NZrMs7y/wpMcoGCxPj6NqT8RX46CdCmQppGenJE?=
 =?us-ascii?Q?X8Rest04fxYKufblzstI5uii2rrp6Y/2WN74vuQysVNYFHxOxzpwt0ArMTIc?=
 =?us-ascii?Q?t/2ZA555H4kcPS5Pop1YArsmGLhyYT8bQapWgSH27ACDtyWO4gluC45i1BM1?=
 =?us-ascii?Q?1iTtkNW+ci2UY0sNjETx7UEU5rd4YjJrgLqpobcxv/TOPbgLrXzZQkr1VtVJ?=
 =?us-ascii?Q?5XFFLNukAJBKx0dcMEsQlGFXFuk4DhSTOeyT3vpJ2OhrbzPQeMSjUUzKpAGi?=
 =?us-ascii?Q?IgknsQgiuS9gnVRqxBD80T48j2y+4uV2iv7NqWSfjDOhIfqaKURkJzxnCwKJ?=
 =?us-ascii?Q?8Pm1OttitGIuU7rYrR+USrGNAhiLH+MoC2rS25+Me3Uzv20An9gpUTQtyWrG?=
 =?us-ascii?Q?Muf01HZHNHNm9os41tAgs9Mc9poWkJo7AqbTvnxL7wSCtdZQkgfaoi36MjYx?=
 =?us-ascii?Q?5CUmpMIHCou5+E6D2RDoNZkLDalWFcnpXF8ElArdYDVltjTAM7SluKsiEG7q?=
 =?us-ascii?Q?7bp+vVm8NU+26jSXlpDzG3sYjIUGuoiemxwnmLZ/DBRJi0hJFe9De3sn8vk0?=
 =?us-ascii?Q?zR4dkZSE7Dge9/DksJqwheyavxWv42eTwZ41gplwPj3X+17SRFFp0b9L2UKL?=
 =?us-ascii?Q?PeF0BBiKm/lq2rY30uhArC1Ixckcu1XJIKh6cuivc/pSm1HZfORvb86JWfAk?=
 =?us-ascii?Q?NCcVDpkDpyUjO2KCoRPGa3pidqvKl2KjtWloUwqQttDddHj6ZvJA4n+xbNZT?=
 =?us-ascii?Q?D7ZqjozPaJGgGC2vH0weV5ggIZSwMpKhKg7qSeVcMRn6RBy/41kDZTDwU6j2?=
 =?us-ascii?Q?6Q4DOxjzc3EeNTvnFzp4x1tYOkqDt3gGtrt8jfFLMeyPGbPQ0yeM2sMt/Ak5?=
 =?us-ascii?Q?Q2yr7qQH8QmCXMjN7hIIqtvNSnU+SQEXLIv80X80wzP8R0TC7W2H/halZkD4?=
 =?us-ascii?Q?cbWRUPawBZ+u65dMF47uz1/oRHTh/RIRdjKVEwZOtaeCIQeVV6uZMODoq+ZO?=
 =?us-ascii?Q?FFkz4pM2Rl1JNe/Vq2dG+3OwPzipyWnmP7PtXIWYdCByYWpCil1jpxH0cydT?=
 =?us-ascii?Q?8NvAYB4z5sNBehvKy+2vIx+RWNRx3cdweI+Czfc84gtMdl4OFfz9OhG46ByW?=
 =?us-ascii?Q?kKndsEYMp/0Dv53p4ZguoGTVddiqUkqIdAZb3TJqphkdy/xshx3ziZQP8sP3?=
 =?us-ascii?Q?krpyV+48PJE1TQ7Plqi7uJM5PYeNN2UilEql6tG0j6oGuDn6yJO6DAsSKJol?=
 =?us-ascii?Q?7JP74TNqLLXAK1hUU9I1twycTYqluwpHORcHA/JTlDRLcH+kNXj5C9NcTI1p?=
 =?us-ascii?Q?gdUuFi+NFqsoatgVL3O/EbuMJMGVlBREL+tVXuQmv0WTOCo1idjxKAgLQEKP?=
 =?us-ascii?Q?huZHGeJlAywcXo86FA7hIrq9gEnBBtqYnm9BsO0K34YM6KX+yAurjrJR1kxx?=
 =?us-ascii?Q?KMwyICQrYWF3BsiJJ6dB+UOkLAy40QAae5egRqT7bCV/YfURKlFGcXJZ/2qy?=
 =?us-ascii?Q?M4BxbV0ccVRCmTy9LXZF9ZjHzjdZ1ne9Vkv5j07trCgzTZMXf55L1tRXJmJd?=
 =?us-ascii?Q?VJZ66U8/WNdyprmX64g+zFkc6uv3EU8BWkck4Z7tofRhloIgKmjNbP1LndFQ?=
 =?us-ascii?Q?pUMB9WP5slUktnvL8v5XqiPX14vbWlU6pCqpuEGfFDx+8QQ7fZP0n4WIl91Q?=
 =?us-ascii?Q?GE1zAQpr4A=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89aff40-fac9-4b00-561a-08de9f80be7e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:34:03.6414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLmPmVgXw9gduYfwWW0aQDgk2pWxnd3mv5kDon94vBJYhovj7Ji8zjAMhW3nDyyBHF6Ydn/h8qy4RAABqWSDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6231
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

On Mon, Apr 20, 2026 at 05:58:45PM -0500, David Lechner wrote:

Hello David,

> On 4/20/26 5:15 PM, David Lechner wrote:
> > On 4/20/26 3:38 AM, Wojciech Dubowik wrote:
> >> Some distros are using gnutls library without pkcs11 support
> >> and linking of mkeficapsule will fail. Add disable pkcs11
> >> option with default set to no so distros can control this
> >> feature with config option.
> >>
> >> Suggested-by: Tom Rini <trini@konsulko.com>
> >> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> >> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> >> ---
> >> Changes in v2:
> >> - make use of stderr more consistent
> >> - add missing ifndef around pkcs11 deinit functions
> >> ---
> >>  tools/Kconfig        |  8 ++++++++
> >>  tools/Makefile       |  3 +++
> >>  tools/mkeficapsule.c | 17 ++++++++++++++++-
> >>  3 files changed, 27 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/Kconfig b/tools/Kconfig
> >> index ef33295b8ecd..ccc878595d3b 100644
> >> --- a/tools/Kconfig
> >> +++ b/tools/Kconfig
> >> @@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
> >>  	  optionally sign that file. If you want to enable UEFI capsule
> >>  	  update feature on your target, you certainly need this.
> >>  
> >> +config MKEFICAPSULE_DISABLE_PKCS11
> > 
> > Options that disable something instead of enabling it are confusing.
> > Can we make this MKEFICAPSULE_PKCS11 instead and invert the logic?
> > 
> >> +	bool "Disable pkcs11 support"
> >> +	depends on TOOLS_MKEFICAPSULE
> >> +	default n
> > 
> > I think it would be more convenient if we did not require PKS11 by
> > default. Otherwise, everyone using Open Embedded that doesn't have
> > the "p11-kit" PACKAGECONFIG option set for GnuTLS set (which is the
> > default) is going to get a build failure and have to research this
> > and find the option and modify their config to fix the build.
> > 
> > It seems like it would be better to make people who actually need
> > PKCS11 possibly get an error by default instead and enable the
> > option. This is pure speculation on my part, but it seems like
> > this would be the smaller group.
> > 
> Or maybe we could avoid the config option altogether and do something
> with `pkg-config --libs gnutls --print-requires-private` at build time
> to detect if `p11-kit-1` is used by gnutls or not?
I will have a look into it and your previous proposal. I guess from 
discussions that this feature is quite urgent.

Regards,
Wojtek
