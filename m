Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB010BA437
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 08:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BF2D83DA7;
	Fri, 27 Mar 2026 09:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Vjxtfo+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78BCA83DBF; Fri, 27 Mar 2026 09:12:44 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE23683C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 09:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3J/FhXanE6UfHrXMdU7XV3u8PQ3+frXP6kxwdhc+CZENl4TZBQQcTxn7PQG3m6G305aKBoNV7lKNy7Xvn1+HNN3epME/9fEbhURhoNFKw5ECcHN4Wi5Qw6p9NSSI3WU6VH3k0wFxfzwaVt4iRIQZNAlofYk131yaD7qg8WzHYAY+OABktCP6svo6ow2fVJDM0MaESaw0N7DWUuTc3hvcSqpoY167hGSAx7BHB1tJv6BQ8plEaG9d22d1bWeUp6qYIrar109+RaCCQMjn+stcma/bDenAikfpXeNX8w5cTusZF6en/1HJQlzp5tAi9NHVrLAymyTPTB4H0PCbaOOsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drrFiBhuj47GgdRTn5HphU2pamQdYUzJtszqbpQJTMg=;
 b=Oy4XgRvTu7kpHUYJvBu/dLnwTvDG2RoDbjezTSIFFwyWYax/QfvINRGh2Advb5h1ZyIWVGjF+vI/6i6SNz09dt4DKKumcjAM6Uc0XvCc4LjS/pJ/DdhdWnnqToyearg0fRJnyeK9sTS4e2GdjJ45aZUaRWR+y6iSByRRqe2rhm8fR/iWN3EztablZ0P2pQjuIjZ+Djl6fxv5RJwv6LH4xo5kya6KF4OPuZs5MbqDG7K/HaW2KaG0XOmZmOIi5DI6eQVFFldSH1MSmja4K6sfmIWYhK+3cZqG2z5qmBj+i6NSzdmAw2JC+d1W4KbzJVQHloUC5KhOquJ9gGbVukDlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drrFiBhuj47GgdRTn5HphU2pamQdYUzJtszqbpQJTMg=;
 b=Vjxtfo+F7vYpjGgOQmm2+8ZdfnFCBrvjTFBx8I4kCTGYhcyOhBA98UesAA60ZGxdic7EbhF4x58PakEAWAEwPcwhn8UVr5rW8ZM2S3szpZt7hd89mixyWcyXhIJGRnioMzFHDaQ4/x0xvMh/qvq7ykcY1JSzHefp5coIieidb3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB8PR10MB3529.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 08:12:37 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 08:12:37 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Heinrich
 Schuchardt <xypron.glpk@gmx.de>,  Ion Agorria <ion@agorria.com>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/2] kbuild: Use relative paths in generated .incbin
 directives
In-Reply-To: <20260326115500.955388-2-sjg@chromium.org> (Simon Glass's message
 of "Thu, 26 Mar 2026 05:54:57 -0600")
References: <20260326115500.955388-1-sjg@chromium.org>
 <20260326115500.955388-2-sjg@chromium.org>
Date: Fri, 27 Mar 2026 09:12:35 +0100
Message-ID: <87cy0plmh8.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF000167FD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::67b) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB8PR10MB3529:EE_
X-MS-Office365-Filtering-Correlation-Id: a677b3d3-24ff-4201-5fbb-08de8bd89bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|52116014|366016|56012099003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MMuQZ0IpNznk+lKlqBLmvjXjNxEwqRr+hjkjcZE5BZSC2SC1DNr5TPv7GctTifoqcHc1MAckXb0+y6AYOV960qE6TXiPiWLTCZgdK5i731bpijRBSv/2YT6HrW4wLcv0KPTOz2JguhCspEP9hxcqTrMJAWfxGsAJhoGbKcAYX875Q3AMo/RV3I30kms7Od0rJ9MOdyODGy9z8O+m1umgpJ0b2HQSq06sKZfcMMSNNmJR7416/XMV5rCrM8OaXwXSTHk5NjTxwN9kldj+7CPRC2edygjc/TtYVMqQBSMy3Wzl3B2FIm/KY9hks+vAS5VJtKX2u/O62Vs2KclUUAbiuBX1PEihmd0lqLlAP+q9A5jtGQTCohFTjHFGZC8FM/vQE6ubq/A3LqLTzPWHbdo1yysDuhfUS85xRDY8i4i+WOE3/hOxp9XEOenKRJemSk6XU19oyZh3nVVy/ivaBK8ESNkPlkwuayU9JyiUj/gni8PWFEEUT9Oa0Nqd8ILtyC9IbFDnXvrbmsCH/6JaWpj42TSNFy2yzXpsm8FsNa8t+8kG4l5eXpg0i7wbBHwiH1xOUAWHez8w6lZSy/MWHWe6TwpOCj7kbxv+MBW+fBI+fsRrlwJtZas1vVOr3XEx3PQ4xtChbrCh7BlTKnyF4MKdgr+TSX+ZW1znjnxUHrSAta8wFABlAgPNRgk1p+d3hTb/GJYK0udkMAHJEAhvIWZrXDB4eaPCkT+AC675GF6THKg+RnTABrelNKoaUQm24I6A/TPsMNvypxNS9dU8D3QcFSONPWXFSSfFJqm8DKFtJwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(56012099003)(38350700014)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S+hhz7s8enOkA2A7hdAyTqNWB6v3HiQRZFpD3DYb2qAGuR+8Gbmq9zyRDuMd?=
 =?us-ascii?Q?BS8kxSEwg9qezNCC+QrUbbE9toyfoVTOkc51r6+91+NcrCEdad5YXfFaqoSC?=
 =?us-ascii?Q?p9AAtRICjvCWmSu7iRumSd4CanAmkBGDafV1WkAexOzhVty4g/W9Y43ELi68?=
 =?us-ascii?Q?ftAM62hBOc+qXuvnXsgOPDG7WQu/OYNeW8B4Nu0lFdp89b5z9B7WZCCSYlXV?=
 =?us-ascii?Q?vgtcTJOZT3FoJCzJPjg6b7JnjIx29B1p7j3dRzk99vOfBwvQuzn+xnVFEE2c?=
 =?us-ascii?Q?qEMcsF9WvycwzI5v1wJfcmjKvK2VYD+4xtQfwkhPasSXcXO4RIt8D0iS9kBh?=
 =?us-ascii?Q?u6XWqyRK4JwzpwR1XS3pSTL78K7+4nmzGCbSodJkzx3W+DzVi4GV9JluA4kO?=
 =?us-ascii?Q?CQ8KeLKUeOeT1xK35JhZ7b96KUIrj2WdSGhwt1ocWZlm7qOzPFW8M4aKPqFx?=
 =?us-ascii?Q?3RXoL2Etp7eLOBOs+8xMQJ+abqTzvFOjHoCQ9EHXFstBuYGd6pfLYyoWF4JF?=
 =?us-ascii?Q?m6r6+N+PFp4IBeKdu/lpgvqIydVZcJ36JafW93+F2zuNIoNq88xrTACV13uu?=
 =?us-ascii?Q?GhM35R1Pf+wsWdACjusRK0S7Aawwj7mCmRfnAFTenHPa+O1x8esHPQ+aauGa?=
 =?us-ascii?Q?z6piAonZ3cwYC/KSev8ifIS/LFrb1C3z9naF6uTGzSx5y5VSnT7wUrg9DSaV?=
 =?us-ascii?Q?HuNnGyZ1UY6S73OSYhO3B4DY82JqkxtiqI2Aft5ktC/DREcq4Rzvb2vKUwHz?=
 =?us-ascii?Q?WjiiYPjY0Aw1AW3tEJhX8Y72BbocDerW7hue7vVTNOPqAL6+L49HA6M6d/Xx?=
 =?us-ascii?Q?MJY0fZQW6cofHY717rc9+unf/BmQFxSAH5txJj9cX6yeRDmv4hE0B8Dt1U2S?=
 =?us-ascii?Q?+mQXvCHdQ93+24ddPj8oKSXExvK/PyfAkh+QEavQBrb91tI5B3qEYNkwsF3N?=
 =?us-ascii?Q?WQggWISLI5Vxm3aK1ZWp22jQGOvxy2u3Cw188Rj+KYFCYlUZeuAZDcftaI0H?=
 =?us-ascii?Q?q//K4KfN9iHs4PfhiND5rW7cqSj1uBGlBnQcLBjiKeK4ht/sEcWsm2ovMPGB?=
 =?us-ascii?Q?ypNdGXGGnNCzqgVIlm9bkjnPhzkN2BWg/xwLqZ2KovCeuSfIlZJOAegLcFyf?=
 =?us-ascii?Q?jOB/PIT+wPXtQkMlApIQwGyRYz/j/t6aAYDZJrpqCOAI/XYdRp1dJ55ynneD?=
 =?us-ascii?Q?qRPEbenhkCHG8sHgnWvzOmoA/dFRJ4rqOjyQTqdixrWgd4+xUImudf8GSSgk?=
 =?us-ascii?Q?272LWJKNNiNZQP3QWdSv3qEe08fuP6cm0sfOnsc8QWyGcbwKAFigt4ZUpeQO?=
 =?us-ascii?Q?+oHegCitB8s0aXrTRLc1bBUee643hnQ0vn/Eh8wKmjjaJHeD5nVrfVNIZASP?=
 =?us-ascii?Q?JatvKh5gu6fQLBVbc3x4zfWvAl1tCdi5ThSKs2md03vPcCChZU0MttZ1wlsg?=
 =?us-ascii?Q?drklV8/tpjI3AHQV7y+dAA9byf5Ltz+pRyj3LT+KxLVTL9iYWaTEtABJiRLC?=
 =?us-ascii?Q?wjEwH/2FZp3Q2PBdQB1aC3RvrRsTtLAIPe/5fEEwdEM+eers8GTSPHlrMr9i?=
 =?us-ascii?Q?mJ2AgphajZxgyAvSM4CKpeC7loLFlA967QDShH+0gQyYizlBc6/07N+dciUv?=
 =?us-ascii?Q?2ogTbZmUhV06aVPda8sSHbDHXHX8vLQLfzw/+1cvyiVGpcHxSMYCCAbx6O+1?=
 =?us-ascii?Q?AGP/j/F8xpGo7OrOe2gvQN8oJXDooMjyNG9iDrYecn9T8V87dUFle59Zypce?=
 =?us-ascii?Q?xwJw3tKyA6VaeUJYOY78qV7mK6ETy/A=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: a677b3d3-24ff-4201-5fbb-08de8bd89bb0
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 08:12:37.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tj2kw3C+YJfn7WCZ4VYChCQzIk4GH5j2plQjrzYgPhDTx6Kwb8B8tlC9J+YwOZ9Ylh95PMZ4V4MWCkVuFJ2SkBcK7pwd/goTcK4dVGANUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3529
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

On Thu, Mar 26 2026, Simon Glass <sjg@chromium.org> wrote:

> The generated .S files for fonts and splash screens use .incbin with the
> full prerequisite path. When building with O= this bakes an absolute
> path into the .S file. If the build directory is later used on a
> different machine (e.g. in a container), the assembler cannot find the
> source file.

I must be missing something, because I can't see how this can be a
problem, while all the other absolute paths to the source dir that go
into files generated in the build directory is not. For example, there's
a top-level "source -> /path/to/u-boot" symlink created, and as far as I
can tell, all the .foo.o.cmd files end up full of such references as
well, e.g. $BUILD/lib/.vsprintf.o.cmd contains

source_lib/vsprintf.o := /path/to/u-boot/lib/vsprintf.c

Also, in practice, I'd expect the .o file to be generated from the .S
file immediately, so make should never even invoke the assembler to
build the .o from the .S that has a "stale" reference to the source dir
- though you can of course explicitly make the .S file in one container,
then try to do the full build in another, which would IMO be solidly in
"don't do that then" land.

So can you show me an actual sequence of commands and container
invocations where building a u-boot configuration without any of these
font files in play works, but those absolute paths in the generated .S
files breaks? I.e., which paths are the source and build dirs mapped to
in the two containers, how and where do you invoke make (make O=... in
the source tree or just make in the build dir?), etc.

Rasmus
