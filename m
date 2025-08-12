Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66624CA0EDB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 19:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5EA883071;
	Tue, 12 Aug 2025 21:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Xfvcxreo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B922B830A0; Tue, 12 Aug 2025 21:25:06 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B759A83020
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjWqLq0Swe5zlbTfbZTXygZjlYm7KNwx0CDL4OT7D0UU50zWCZ8oW0VI6jWddSNZV2py26DDUDaIfJ8Lj1mBVgea25NpPQq+SNLaf/2fGulDb+mB7EKrQBACW3IVvLGJMLLNqx52Avf7vk0DFp3dImvOKteoeZFlb+UhkFunnUTSNASmpJaDLqgPHHpVmCrZsgKeavPlbt9h3FEH82rvfqarZOUvxh71lMyUgE5sH0td1WAULXmED9OMFsNkoRD9sdsPMD0E51bMdpw9610SltqRFVFMFKX8OgO2mVaX3nqAx4VmcCDK0eKldErNTcZTB2xc4UXXrAnfhSI5A6oggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQIqf0XP6v0oA7poSKliSQIsqKhFDVB4jxVwezg0Ev4=;
 b=p25aC8eDUwkVXj/IwNtts8km6edxvNPZsfF7x/TX876UEVRmUanBOEiP/8/WGJMMHup+emCmTgS4U5u2oVnL60ZaG+EkLnQ5HffMIMOfcPEp978rH54YbMkV7jgzktk9PcfGs4Do11PqdI4Fc/uiS5n6SCvLy6wNXyDVc4BMCokn3j80wRmLwWmuiZcvi6gpLPvg0uONTYVy5bb9ldwiYxHpVZRekfd/4WUu7iQsO0s3OIdst6T0o+81Le7A47Z97yhXH6dhE+owJwmHWq8vDb9XniSBt45KMkybJcH4eCsWTAI/2qEdPa8ONaW/O+DR7ATpWKGWjXF77/HtyUFVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQIqf0XP6v0oA7poSKliSQIsqKhFDVB4jxVwezg0Ev4=;
 b=XfvcxreopTYJwC59AtEfNgpZhAmt2qsUsSPuCWZQsUjxCyYpOFQL8mQgp/x4n5c9i4AVd4LCGOgTfjarY9Fv66TPKsiatcSckS0rgND0dVjdHeraYnTiil2Yc1U6LyHkOFjTHi8ZGGtmpkEO6YCuCSLMsVjjzBBD/59qiNEdsa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB6633.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 19:24:38 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 19:24:38 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Mircea Carausu <mcarausu@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,  u-boot@lists.denx.de
Subject: Re: How to avoid the need to run 'env default' command on modified
 env variable
In-Reply-To: <CAMFYzVyLLzhH8u565AvTxBYL_5_g0WLjpaw8Pb61PytyxdTM5Q@mail.gmail.com>
 (Mircea Carausu's message of "Mon, 11 Aug 2025 09:46:16 -0700")
References: <CAMFYzVwEtRBndhOaog8wStZeBTZvei_gdZ8=6xM2y1=SU5R1cg@mail.gmail.com>
 <112df3eb-96b0-47bd-8fdf-258e25bfb390@cherry.de>
 <CAMFYzVyLLzhH8u565AvTxBYL_5_g0WLjpaw8Pb61PytyxdTM5Q@mail.gmail.com>
Date: Tue, 12 Aug 2025 21:24:36 +0200
Message-ID: <87349wuyvf.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0107.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f53fcb-3c87-49a1-295b-08ddd9d5e0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfdQTjrJdX2AIbeWZTsm9gsyAHLygMQCTB09oK+Q7lLW3Q37shdzbLjWukwA?=
 =?us-ascii?Q?Dezn2EtmNRW0Z243yLxsX8gdQv6hrZGDakaXifvvvDShNPHDKYyZuEWuIwBG?=
 =?us-ascii?Q?O9/qYhduws5r4o7DxaQ2Bw5mx+xuYvtTaniUuw3VPCU2cUneVXHLPjAEHtn6?=
 =?us-ascii?Q?i2JVSyGEaSGVrlJCnE74kARB5TfawsRSSPywpXBBwu6rP+ZmUozrfxQG22IP?=
 =?us-ascii?Q?EmHgr1qvaPdURp3Jkpfjhb9UzOrZx6stqj8Ec36LderHzoxibSHsyWCseIr9?=
 =?us-ascii?Q?s43709Iow7xfRwOBKDFCZGVQrQDBJ3PTmBKj9MvVZq9x01+20TSUnDcdg0EW?=
 =?us-ascii?Q?qq/NXPkYMCPhEmUJcqOIRUn5innwVP1AzhNkFt+KxzrFOcVzqN4pb0Kxnmct?=
 =?us-ascii?Q?px1pp70n+FRwk2GhHDlb4lEtpSjLYt0NolV8ooXNL2uEuW/dK4FkX3FBqLHW?=
 =?us-ascii?Q?p0IuhdGHd1oPuTVlg1dTkG2jiSiHB+gDOkgcpCFZm3bTgwijQ6y8gJSfHCla?=
 =?us-ascii?Q?N6K41aFqIGqklXrcpQhYZ0KpjT+v8t1Vfg1i/rAPuFqmEjMUXESzcDC9uLK8?=
 =?us-ascii?Q?WYaZCzxJp6Cmyag78e4o2mutZDJEAwvQLBSn1qFG5N6DLOhNnSHejf8pHhuc?=
 =?us-ascii?Q?RHfyI0zetKlNF1MYzOxkEWm2OftcCUIKfw0+GweMJEaitfAl1kVxlFZs2G2A?=
 =?us-ascii?Q?DmS/Mv9xfMpYEpUbhpoDJTYhwG8O/BO+z/yyfE60NF4bEF/TQ8OQHQ4se+Zp?=
 =?us-ascii?Q?elk2zE+pfplDECEwAZam7fJb3f4SM3P4VKecU0bs0oMcKOV1q+TNDGPJ6r1P?=
 =?us-ascii?Q?13IM5yEJiqm+XB5uPiqVd+ChYhA6C+XqzjuNtX1aWax+7t5hnTh2PgYl52FG?=
 =?us-ascii?Q?PS84JSqU8YkcJgctTRNgrH1G1Jh0WiohceBKjnbBGCFfGsSfdJUG7nv4BXq5?=
 =?us-ascii?Q?lwCHh8bLl4jlwh6dHUGr2i43zpMeMGsiOy86/WR3gWop1zd92hqTPZN8EEgb?=
 =?us-ascii?Q?27UbmyB/+8Umyfuu6HnuuVYefE+Ku0p/S2VBy6u2wmsxYMyyTWFdr4hBvjmY?=
 =?us-ascii?Q?dyMYkDnWi+sXDEdQUf33euE7xwNlV2WYe5ap7+lNABrDL5PVziKLDiIYjK4C?=
 =?us-ascii?Q?CyjGp2lLKtJwrhH+eyuuVcYkG2Kt1XcyDTf+1lBoOarD0fGU2pPRR9fmyLNd?=
 =?us-ascii?Q?Grhrt6cHGEMtjIs7IoEalWUUgiqThPjz95XXE8ounEMz3neMttEGBQpAwMEV?=
 =?us-ascii?Q?wD+MVRmXnhiHH+/4N/CorTP0lYZdcXrQ/Gy4s2+VgmfoWJ7w8x9eZ3F81F3X?=
 =?us-ascii?Q?lErSRepBNmfHMPin7t386iTAX2OhW6fmceNbbNlSOVORi5LKIEamxTyDAD2R?=
 =?us-ascii?Q?15BOZEQ5DAVgpjRg6OIyFXMTHVxIRQL0TqBHZpCcRg2a8X5dF7IPNxd7Nh8W?=
 =?us-ascii?Q?LemNUnfxLdo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a//GN72LVwjWWaRXd6e3c7nFtzm14J49M5B5xbuUyVQMWE2PPXq+nQ9jo5eJ?=
 =?us-ascii?Q?x8PTOEimOumflb28zeu5bdsU04VL/mR1wtZvfdMBkG76h2EQMP3ZTbLf8MoK?=
 =?us-ascii?Q?jMm8WRjxcKZeeT+02DuOcZaD2GkcER6Er1waWFt+tbL+rw2oWme+FogkIn7N?=
 =?us-ascii?Q?0RHu5At3Tjias12EGC2gvXbAydLxnffWKC0q0wQrn6tHZiSayiUy0g9mVam0?=
 =?us-ascii?Q?mAXkraMhvuC5IYb+KLH763KMimOVWAh+J2MLbfpkziEsvNGiJPy512D4sqyU?=
 =?us-ascii?Q?KsIvJki0lwq/HYvCfxK5XVL9oIpQ3mklhHh45kCexpz2gm8TzRujmzVpISq/?=
 =?us-ascii?Q?1fQrScvMB3yq2JGGLs/BHx70cD/kZ4CAB1fxHDdrawxg3E/k5R0U+lECScIN?=
 =?us-ascii?Q?WH8an6VJinbCybpbi5T1ZhICOcnctSUltijwiE/QRUG2nG/k/hkcfbXM8Mpc?=
 =?us-ascii?Q?bf9QbXp2pE+xLkkP5IG4MfBAMjOcg/h3XbLSToGrVxbaupAjjJaqZkgJ+J/G?=
 =?us-ascii?Q?4uyHI2gM2A+NXI7ZTTJ3pq/CoafWHZA4ZzGOA/wBN12PcvBO7YCMmckukFZe?=
 =?us-ascii?Q?tSE8k+a8t1/0lExTtrYr8PwcTcfEifSN5meZVmevNwlqlkjpJgpk7u0Xz3BQ?=
 =?us-ascii?Q?+rPREM/cH0nX8W7xLZy0vXRvEeIdvY45LJD0RRzKaWj4BPJitnxJ+5g8eD/k?=
 =?us-ascii?Q?UrlDJjrYgF9JDdXnoypPiTy48vmm8wVfQf0Iy4WHGU23oIPFjvebf+Fz6iF7?=
 =?us-ascii?Q?qlH1If4VlH1QbnhAp8VJkA1GU7cx/pJNJ2BLGHA8SUILe4mpVsOsKx7SdroI?=
 =?us-ascii?Q?LOzgpRw0kBKgmWuHIJ94CSuiMPtJmYoXIskvgiEvuXv+WfxVJvKfaGkopgWv?=
 =?us-ascii?Q?lh4cCDzBohv/fhhVIsAVgqubtHrBQn9OoCW+v9t4y9HIjqgA0XNDq9+dS5fC?=
 =?us-ascii?Q?7oBsWQHGF8ldfdgUssDUDxcJ0MUbGj9g2S2xAMxjfNYPHpkDCgxLlPh2uZzX?=
 =?us-ascii?Q?mhB1Dg4CgfiqZ6C0KXyTvB3Z6VIZ0d1ff2aA7SGlV/EYoWiVmilnDTrzEjWa?=
 =?us-ascii?Q?efRt82klDJVRizcRmTSmbplvWfGpStjyIZhjcL6F5R/LBhLGBhUNRPPX0Rab?=
 =?us-ascii?Q?3S82tIBJfiNN74nDDyOhmHIgQH/fjUyXo70cQW9NkkTILsGu3bSojVDha48d?=
 =?us-ascii?Q?78Y2DTE97P318wE0rh30WG9OBCedAh7YrxsC4OEPWS8mdaYvBghoHlFL3LQP?=
 =?us-ascii?Q?d/E28512jERBQt5a4efEE1CLF2c1BX/9lnorkLP5ai7jrgHPRWsHvFllAET+?=
 =?us-ascii?Q?lDamb99z98l06ntWp8niRbI6AmBcv9d22W+mZO8MFbEBMvtHI2n9+Hp539e7?=
 =?us-ascii?Q?HqvBWa13aspA/WDPU+N4uNlkO7n1nnoMh5IbJPvcinDWPXhEkT6Yuz7cR6cx?=
 =?us-ascii?Q?ugLwFdJW7RJ5x5CxmJochM9ctBDXPkiZn8FmxvJV8oV/eZf20P4qBb8aJOp2?=
 =?us-ascii?Q?ffy5lPhZ7n8pTT9CeSq14E2dtWpnLVvpl8BDhu+I2ZilBPMXZyd6f1c5GA+P?=
 =?us-ascii?Q?qr/mGDXWSWyT+GiQ8aE+8Wuj0R3h0ZxlVnMOOKWDnccwAsRVpHjy+p7qfXZd?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f53fcb-3c87-49a1-295b-08ddd9d5e0e2
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:24:38.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +p4v6/QTTFsRp7XqGOvZ+/Zy4Q7rKKiPEqfOfCN9ZwYih3aMeDr7nqvsyOfA+1RH5spCqX8nqp2y2VfmHm0W/vlDeXWYLnSh3KsLxBqPKDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6633
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

On Mon, Aug 11 2025, Mircea Carausu <mcarausu@gmail.com> wrote:

> Hi Quentin,
> Thank you for your reply.
> I wish it would be that simple:
> - as mentioned we are using RAUC for firmware upgrade (https://rauc.io/)
> and A/B partitions. RAUC needs some u-boot env variables to point to the
> active slot to load and it maintains a retry count.
> (all of this is implemented with help from u-boot env variables, which have
> to be writable).
> I thought of erasing the entire u-boot env or corrupting the CRC signature
> to force loading the defaults. I can do that from Linux also - prior to
> reboot.

You could/should have a post-install hook that takes care of updating the
U-Boot env after you've installed the new bootloader.

But, why are these "critical variables" _variables_ in the first place?
Can you explain what they are used for and how, and why the consuming
code in U-Boot reads them from the environment?

We also use RAUC, but we've mostly abandoned the use of the U-Boot
environment for the RAUC bookkeeping variables, as a writable
environment is fundamentally incompatible with secure boot. I.e., we
still use that for POC projects, but eventually we do something
else. So this problem is mostly moot for us (as our U-Boot env is static
and built-in), but we did use to have logic for updating it: We use the
DEFAULT_ENV_FILE mechanism for defining the whole environment in a text
file, and as part of generating that, we also generate a version of it
that can be used in such a post-install hook. Quoting from our Yocto
meta-data:

    # uboot-env.txt will be used below, and by the u-boot recipe
    # itself to create the built-in environment. For both mkenvimage
    # and u-boot's build system, it has to be in "var=value"
    # format.

    # An unset variable is indistinguishable from one with an empty
    # value, at least in the U-boot shell, so comment out definitions
    # of such variables. [*]

    sed -e 's/^\([^=]*=\)$/# \1/' ${S}/uboot.txt > ${S}/uboot-env.txt

    # Create version suitable as a "script" to fw_setenv: Replace
    # first = by a space.

    # When updating the bootloader, we do not replace the environment
    # with the vanilla environment from this recipe, as that would
    # wipe RAUC status and other things that should not get
    # removed. Instead, we run fw_setenv with uboot-env.update as -s
    # argument. The effect is that variables set in this environment
    # take effect, while those that are not mentioned here are
    # preserved (RAUC status, maybe eth address, device serial number,
    # etc.).

    # This is not perfect, but just a reasonable heuristic. In any
    # case, updating the bootloader should be handled with great care.

    # If a "run-time" variable should explicitly be deleted by the
    # update, assign an empty value. This is also the reason for [*]
    # above: If we had an empty definition of foobar in the original
    # environment, and the update has the same environment, fw_setenv
    # would react to the empty value for foobar by deleting it, so the
    # update wouldn't really be a no-op.

    sed -e 's/=/ /' ${S}/uboot.txt > ${S}/uboot-env.update

Rasmus
