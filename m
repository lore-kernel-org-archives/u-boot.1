Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98144CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB0D847C5;
	Tue, 19 May 2026 15:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kjSBDmCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809FE8482F; Tue, 19 May 2026 15:59:20 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A16846F1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzOFDqC8In8I9cl+/2D6h8DzB4L3r8TT3u6ciO4+nZdwz6byKdqlli+WrFmCmmOKnZPDXYVYL/dvzSZu198+YArTb+NSve5K4SKTnvtyuuhl6pU0v+0uPqn+RmSqiWe1bxh3b+qiJx/kLZyqyJnBX6Uj4qugIshlfvqnFZ7wpvG1dc6MjjtXE3pAI/21IfyAYEAIOTJhy0AB7ib92OmHmpLyo/mo3bdFMk24iQrq18z45pjhMk5YAykSzqumiPlautx3cvhK+0kx8mJjttaC7mwwqCqOFa0XrRYBlU7kCLRW9xeOuQ/4fusHMB/XIuwR2zxfVbdQ8KgLAqi4/pSgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyHgTWvokfM9D/qeAc5Q59CqFM3sLgu+S+cyFZVdi9Q=;
 b=XIPXyVWFhVjGR0/kxtBcWZ8Vrsytsq2QTjR0J3TVH9c/nbRlo8qDppavwhXEkK5nsAjSjDrS7hwtkW8KoLIBO0HxlX2QOs2+vdNCXnCJKUPWGDr/V2CpJTxR/E+YUwXneG35KAtEoXuYpIPf9qgvlTDfWwgLLngtB6cl+RJK4jk8bZVOZcx3TpJrsLmTkczxzNSIodT5VawVSc5mlF2+uGBCSjGGI5faFMVK2jps/4AO2oRJvQYeSHqsQe8Y9EfQanB38uEVxSlYDVqzhPzZdj901CTZmCai6gX57235ZcHAl9v2fzxeAstplPy91hJ0jnk7Kn9T7DWv35n6gwJlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyHgTWvokfM9D/qeAc5Q59CqFM3sLgu+S+cyFZVdi9Q=;
 b=kjSBDmCeQty9lsl5a732Iqu483kJ22CCmHTBZSjolRxG45/HVgZAqLnwADRT+3f1u0rTVK9uwwK0rw8XVZXJWrrcZcRHrGM/FPAjjWzRUeHwkemlHvJte0A8jX84Eoid0taHnGCZqxZm1oESWMMXW+78YcdvM1c9KTR3yqdIKhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB9PR10MB8074.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ef::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 13:59:06 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:59:06 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/2] image-board.c: exempt gd->fdt_blob from
 fit_check_format() check
In-Reply-To: <CAFLszThVY6D15HF2vy-xDQ-t=oROkG8j32DrtqzW=bpr3q6WOw@mail.gmail.com>
 (Simon Glass's message of "Fri, 15 May 2026 07:06:07 -0600")
References: <20260512161631.284143-1-ravi@prevas.dk>
 <20260512161631.284143-2-ravi@prevas.dk>
 <CAFLszThVY6D15HF2vy-xDQ-t=oROkG8j32DrtqzW=bpr3q6WOw@mail.gmail.com>
Date: Tue, 19 May 2026 15:59:05 +0200
Message-ID: <877bozec0m.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0013.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:2::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB9PR10MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 05aedda6-b607-423b-a398-08deb5aecaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|3023799003|4143699003|18002099003|56012099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: 5zxQ4+/y2fcWwKT8vamd2fWVJiBAMHrfcBjobiCNrs80UHdnC4VX3CZqquL8oN2pY3p/rOIJ4nWO8i12bFIRrWHx/Px849tKpKxvsmUkFgFqjxN9ioN9756Va6vkLIul+cby3dRRskUlXfXtesZxzjA3t2+4Zgana2wYNhWSVBehke/p7ddfI0afodXeeSYR658rWB51qYrDnsy4oraGYhXaKnPlpQj6RQB+v5929NW43QAriKwKzet1hj9EqpwahnwV/9y56pdFyG6qSjUPBCY03yDZDD1BJB13+dE1I3RnSybaPId2L43zFB+EKYbl0kx8q2bJQE6BD+gNPcWVsmQJkQl5sujl56HCPg79sZKFs99iG9qCTHLFJngc6NNiD9i7L+kbz9XzPtU/Vm/f82PqkmSdIW8YreRp4VqpreI03EBNkb94lCDHEEiGf/JqcdUPWpgPBYaHefJNgzEqCH3axq5H/0JgzlQyZTLZmyj7IfKtKgZPD/WAkeclh7tL5g4kp7Ck/kuRsoc/NDYvfHNadC/IMsv4m3OR8jBklWqhGNZsCkPL3BW6oMJnMKXMVVpSs3rgWVRDXbpFKZcPaN34Q3gE738zR5RX8yK6HPJ9Fu6iGyuxhYlLDUSKe8bL09IzCvq1cRynL/sU0QqzRmlsJ4OXxUvibAMszbBVskE8c1CWwWwizLNDGixGkwMs6OetJvqAdBVkzeYD1oSz7qcK7OIAWjkYVMYVUIIyafYGURrsoRsC/9S2e62VehLa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(3023799003)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vhWSX5R5KNN47vbt6C6QP7YaFc7Iz/VXXMdAPEmXgO04zrrouMPHvK135tn?=
 =?us-ascii?Q?cAB1Agwtn3z6Mv5BCuGh6XhME7ui4ZtA8/xcmWk/TmrUr6ahGwhi/9aRFkWV?=
 =?us-ascii?Q?RnbFXB7wrqeDwR/1BX7ecvlgT92Tkp/Q9oNfwo0iqUZ38jpenE/t6Z+53rZ4?=
 =?us-ascii?Q?DBUeiCSzMac9W+EO1FYnYrY1Mt4x8Mlk/n4/SwI12xqV/uNqg42vDTVL4BaR?=
 =?us-ascii?Q?VR13xre0JDidvuXeBFPKTfJHwzJhLqTmOxRDNz5Tm2lRUGnaHr8VQ4r+Q+Yn?=
 =?us-ascii?Q?PE5jJ2nHL8JtcNfmyl5n5PEtZjP0r5PbbnWsSPrqQpEOLk/0TXv8sMK2RuU8?=
 =?us-ascii?Q?zRlehj3JaXJc8KWH+cOSruxOijSu0ulRotLGYN7ITErimRXdyRiFqkfpNHEm?=
 =?us-ascii?Q?gIe1lfTgGtguH71bx3KGaEeNh/Rh7r6Th4g9xe6EC1/B6qawbgPXIgYtr7v9?=
 =?us-ascii?Q?cQtMI1N7olaQ6KWnYTAtqb/BML0Eut+MS07RPPdtByrZ5+6KJqh018gi2Laf?=
 =?us-ascii?Q?hEEJKBTT//h7E1x5QKloBwpjXUiSFX8KQBnsS7EAKL1/xjf4JhpMDMb9blgJ?=
 =?us-ascii?Q?DCPt4c+8uyg42pWL+XQFe/CybJIrM2tJeuM8fIK3rlhQ6Ld/KDizOe0VpCvU?=
 =?us-ascii?Q?bWbnBoPfl9IBY6DRtvItwck5wxoRIRbS9OwemNaEcLylybCBPNhtjrdWECXU?=
 =?us-ascii?Q?0KmH6ptNhhGBu7cNl67yTO7pcSWeeQm95qOTJ4srjS9PJ9ijKuAzz+5ZSzcN?=
 =?us-ascii?Q?WaFe7BSm3zxEq21TTtodNkvkpWUjmfaStkUw/6DhLFW4x0DQBnAM4FuGQiJp?=
 =?us-ascii?Q?WnYH22X0wtDOn9oLSei+IaaRvCLnSMBuLZnCZXTH/CPps2Bm0XskjByi55iw?=
 =?us-ascii?Q?NBVuQxLqSN1riYB70T4FfNKsW1Myanky1PiZ7aiZaVqZXfaATbqwDn+A0j94?=
 =?us-ascii?Q?S2JYPEfGOqpiO3dtn9nqnn2gTg1jGM5qTNjTRmYkzQ+sbpXlJT10dtgWaqQS?=
 =?us-ascii?Q?TX80c2uYEVG9WmDFEdz0FhjE71i6dcvtwbqi75tD4PBQFRuyy6rWzJ67ugm+?=
 =?us-ascii?Q?zoxg6dWuF1RUwRm3fmU+/OgiC70JHHLb4g7yIZv+BsONu5XIWuI9CV6pHAHx?=
 =?us-ascii?Q?6DFSh5/0w8dY9TMGiZ3IqDOJjZusTZ3eiB+4duHy8uDLtE2Z/64Fna3redzL?=
 =?us-ascii?Q?rUR8oXF4EQ1uY54rPlyPwiHpyH2+N7JCp9fGvS/MuTrU0JCLB0ixU3LsIW8v?=
 =?us-ascii?Q?/Nz5YOIYMSCG4MXMBOvforK+6hrqdb9tP33VhJrkYELrOrdCH8ftfPV5nuni?=
 =?us-ascii?Q?o0lOo+alk5GKeMXcIsntbHzplYhavnj0tRfFYmTgUYrvZRBHZfMp3FCxSq5O?=
 =?us-ascii?Q?Vy90XWflnlf0PS+h714UR1dNmhYfm2H/HKuToqV5dZc8N+NeH+UvvfkjaHES?=
 =?us-ascii?Q?Ps0iYPQRHI9zNLy3EstGM6s2cKFsJ/5iSK02N9HhvDyOuTdsstJR/dcjcirR?=
 =?us-ascii?Q?W+UUUNsBPiVgnLdNGGlvn42Yq4zBGNlsEqYqqvDKNF6cgfjy5qHt4jnJk6hE?=
 =?us-ascii?Q?Vnio305KejzNkpUz+AGEithEXw56c7USOGNf9yqiZbbK9xMPSOmdSJYC6Ifo?=
 =?us-ascii?Q?cMpOVi4GVVBerDdoExG+px8C/dR08i9qhef5vhZxwvs8Tmir/8YrryrRHT84?=
 =?us-ascii?Q?AgZFicFfM5vn5PyE3H2neMoJgznKQgsMO+t+mqgqDYoNyOdd2T1dDvf2A2mX?=
 =?us-ascii?Q?zE62W1xJXLAEwIuexhWPKAT6GW4LAds=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 05aedda6-b607-423b-a398-08deb5aecaba
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:59:06.4537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hpj6MkyU+bLClbc85w2q/srU1Rm4xoO/yXB1SsIJcsfeQdtCCXs58TTDJrvMLiUx7aI+iGA+oej03C2XOMiCu5ZkTXtlciLBn0Tz8MBWnFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8074
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

On Fri, May 15 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-12T16:16:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>> image-board.c: exempt gd->fdt_blob from fit_check_format() check
>>
>> Having scripts embedded one way or the other in the U-Boot binary
>> means they are automatically verified/trusted by whatever mechanism
>> verifies U-Boot.
>>
>> Writing those scripts in the built-in environment leads to
>> backslatitis and missing or wrong quoting and is generally not very
>> readable or maintainable.
>>
>> Maintaining scripts in external files allows one
>> to have both syntax highlighting and to some extent apply shellcheck
>> on it (though U-Boot's shell is of course not quite POSIX sh, so some
>> '#shellcheck disable' directives are needed). Getting those into the
>> U-Boot binary is then a matter of having a suitable .dtsi file such as
>>
>> / {
>>         images {
>>                 default = 'boot';
>>                 boot {
>> [...]
>>
>> boot/image-board.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Makes sense, and a nice feature.
>
>> diff --git a/boot/image-board.c b/boot/image-board.c
>> @@ -1037,7 +1037,7 @@ int image_locate_script(void *buf, int size, const char *fit_uname,
>>                       goto exit_image_format;
>>               } else {
>>                       fit_hdr = buf;
>> -                     if (fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
>> +                     if (fit_hdr != gd->fdt_blob && fit_check_format(fit_hdr, IMAGE_SIZE_INVAL)) {
>>                               puts("Bad FIT image format\n");
>>                               return 1;
>>                       }
>
> Please add a code comment explaining why the control DTB is exempt - a
> future reader running git blame will be puzzled by the pointer
> comparison. Something like 'gd->fdt_blob has already been validated by
> the bootloader and is by definition trusted, so we skip the strict FIT
> format checks (no description/timestamp, presence of unit-addresses,
> ...) for that buffer'.

Yes, I agree this was too terse, it was mostly to demonstrate how little
was actually needed to enable this use case.

> Would it be cleaner to push the trusted-FIT notion into
> fit_check_format() itself (e.g. a sibling fit_check_format_trusted()
> that skips the strict-format / no-@ pieces)? The pointer-equality test
> works but feels out of place in image_locate_script(), and the same
> need will likely show up the next time someone wants to
> source-from-DTB elsewhere, such as an FPGA image. What do you think?

Yes, I agree it's cleaner to do the exemption inside
fit_check_format(). I do want to exclude the timestamp/description
sanity checks, as I don't really like to have to add such properties at
the top level to the control DTB just to satisfy those sanity checks - I
only mentioned that it would be possible to do so.

As for a comment, I'm not sure that's needed as much in v2 now that the
check is

	if (CONFIG_IS_ENABLED(CONTROL_DTB_AS_FIT) && fit == gd_fdt_blob())
		return 0;

and git blame would show the added config option and the reference to
the documentation.

I've added that after the basic fdt_check_header(fit), which really
should never fail for the control DTB, but if it does, it's better that
we don't continue trying to parse it as a FIT.


Rasmus
