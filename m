Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA88E9DE43
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 07:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3364839D5;
	Thu,  9 Apr 2026 09:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kBvRiNdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6065483CF5; Thu,  9 Apr 2026 09:01:30 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF51D83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 09:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0Bhuc2gwK7M8CXRLXUpInE7Zn/Um7MAksMThZVD1BSXeoSVs4T8zwkxHjmPLFr1nz4GjrdA2Bj4uk+g34wADFM5Ct243pYHG8JUIPpLYv/xWkG9680PgS7Yorepl466Tp/QTRx5W4Owk0YiICYgABwsF5vAgjOritVZartZ1Tv8O78Nzm3ugAZM7BpxFilduiqLVhoo84EwWU6RVk8dxOak4ap0wBPAYlhgEdOraV1I9CnSnuR7I9gQi50XJaqCBJybH3C6c1bah6tnfXDmDfhAiCEcgP2/Y+wUN+R07pIoVwkjAxv2s9VShnngiZgswKtMykHidFJc+iWsvaXc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztk0rthI9ccNZtZLn+Tg8lPB2bWByfis1mNxNYRllug=;
 b=grsuoqQOqQPvpI4WhU79ROHK104GhPHLJvrLwUklQhgwOqduV/TDPJmBfKH/W2/hTxWSk3/084ZbA0CnuKsG7VL1+mu29OnymHdmo3BFcFO+paFNF38kYTrnBB4B/+z6f+sIrjGxZpzXgZKIFlrYZrwH7ZJLxStDChXK9DfHczTUkP75zck5AvXm6tnHKKwI5i7uPfS2NXNZhmj52Ba8Y7pc8Lb9fOBNrCIw5vORo0M+5ZJaQ4KO+4PUosd7A0d4p5QhYoLgTFNQtrlex5dOP9PKmJ5JFxgdVbP5mlj81zzi+8mweyqHCf0f0JIjYWX5s6q/0VM080xHFEkJiVtKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztk0rthI9ccNZtZLn+Tg8lPB2bWByfis1mNxNYRllug=;
 b=kBvRiNdYUbInmcRItiSTBQRpH4kS5NJ0Nf1DFspnsr80lvJ88F4w8vniwXEa3fOe1NFvd7+ZhZAVlBX+vBxt6nrvnka55XTS9YPd1Mv69cbUSCAhqr38oAqKJZAk5suH8fGdCy2k6mAcDKJdRdsMN0RJgoDlRNW4BhVrWx3Vo58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DB9PR10MB5571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 07:01:24 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 07:01:24 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Heinrich
 Schuchardt <xypron.glpk@gmx.de>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Ion Agorria <ion@agorria.com>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Patrice Chotard
 <patrice.chotard@foss.st.com>,  Sughosh Ganu <sughosh.ganu@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] kbuild: Use if_changed for font and splash
 .incbin rules
In-Reply-To: <20260405104224.530051-2-sjg@chromium.org> (Simon Glass's message
 of "Sun, 5 Apr 2026 04:42:21 -0600")
References: <20260405104224.530051-1-sjg@chromium.org>
 <20260405104224.530051-2-sjg@chromium.org>
Date: Thu, 09 Apr 2026 09:01:22 +0200
Message-ID: <874ilkpqgt.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF0002399D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::196) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DB9PR10MB5571:EE_
X-MS-Office365-Filtering-Correlation-Id: fed256b5-5aff-43d2-ab7b-08de9605d014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: VflrtuucgsnGrLl3t2yfLUXmOhoI4E5E/Sr8HSOXkj7tcQUfj8B/pHKzfXKVD0foag7WGN8kazNKx2dzzKVlNZoqG22K/mpVIWjTu4NgWtpDIK+VN2SUM5Wj+CLzZjnZ8gXl5ievkrPK3nxovrGtsUhsYh00hZg1GJ3TcTJmpInRNfIGBSk+C6nv3cLUPVOannyVLTLOde0ZUJvJV9IXE+gWz+yyPu4RSFEhiU8nibDvvSMrDmvcdicApVEcTNRD5/qbG+njMtDGcf4pQPp7NwcrXOzckeR+O1u85tC0s3cSq3GernMJVpLftQjhRUwfRHZjbvPQMLOPt7ey+PcszesNMdmY7rB7TUHZMX3B1gOUWbOQXxorddhJoynUkdY8jrHtPZGbHs5c2eB+lsJpP9bAYKuF0OUJmZ+QkTAV4zQsa7LbZCoQDpXD0A694LuTT8Nk08PnCZO4T8ml7MUvYkCBHxcN3QOVYiBoI6Z/pa/qQEMwpD+hEToleXc5v/X9aRPfrb+7gFcxdM8N3ene0ZuMaJ6jQvUEhmavbhffz9VeK0xJH7gMKJ2hH7a72GrJ8RYFQvMvUwWxGPv5gUmSjf4YvmhrQDNZHGK9au+MBGb//+W650FsOhhpwB+svnhuCnbpG733mkQOTvxXfj2BWl3OWh01+Mio2mazg+YSeflxRt6V0g3dEzgJD3z7cId52mmpB2PlpJatM/4BPf9lsbdx3P6XqpG+vCxnPJtckzF1qUDVQQGEWR4z3Mf1HRJDNP9Y/BjH5JthfWoT92PYCY/L45dBJ17/bT5pOj/gwNE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CeFwozf7sP/T4Aw+ONQMEQ4wM8kghWQ4hp9cM9gwNwB0p2BbmLsFlKtfWQIx?=
 =?us-ascii?Q?62EPVpxwcXuyeOOFNbzP4zz1GKkaRn/zHPoKacEwoqQYt85j6MX0zhsfjJTx?=
 =?us-ascii?Q?aKAO2WTKHEddPuB2aLpUddqE/wSVgRG1YCrZyc7+bB+jRJTCrFvfgZ6uD1Sg?=
 =?us-ascii?Q?cwrVPBhVVsFesDdEzVKgxACkJZ9xJkBcjdkuVmBwaZ2aic8tah4txbrQcEJ0?=
 =?us-ascii?Q?Gq5hG712gfP/dqCz7ex9SLK0CUu4L/8mwiKfdhIPwD/ZrcBvJtRM/4KvQy/0?=
 =?us-ascii?Q?UMGNt0ubJzPXzQZmPptWO0eU3acRSRW398Oytry+GnG28csO2CETTzruL7xX?=
 =?us-ascii?Q?U7PjgxpRlLcXSGabjwaxWIY9NTMc8TMKGHsZ7VqEsx6DU6b/IrVmR+0Rkr/C?=
 =?us-ascii?Q?jDACgzWNojbVUO5v1YxXCQLqV6fQQLFbPgjhYo4HPYbuIuJE1cHFEXr7RtbN?=
 =?us-ascii?Q?7gzbgA6Lyn+BrRE20jCpVXFS08EhU8gLFxJ7AdcNrRO9udx1w/zpKUZPyRuW?=
 =?us-ascii?Q?nGInvmGPzEvZ1EAbc/PaYnsDfHeU37/aKC05arotAgM6jPrC2HYTa9Km2XVe?=
 =?us-ascii?Q?oLxROPqgj2+++U/GaLdvN9Cgzgzpi8vnFR1Gv/E4fXYXlL6qTssuLId7szk1?=
 =?us-ascii?Q?Mc1d5q4aX+if/zBEykxlqYGULAJYE1/Kz7bftktPOULr+rcTSeTPn8oNnCnM?=
 =?us-ascii?Q?hvDu7vViDN+0QuYWNRgeB3MJ/u/9peA+Ops6NGE44ZaYLBhc/AtTjdp0XYry?=
 =?us-ascii?Q?4e7j1bH3B3UYReNP6M2JA+WvRfetJw36/tq9ezKbxph7eejbqtGpKWCvgWFa?=
 =?us-ascii?Q?pCdCq0wtMBFXjeAySkcSGwXcCVAbqwXU0aLcZgGBBMnxNVu3Scv2WSbVIoV3?=
 =?us-ascii?Q?aH6ZHmS/HrCAAneM4gSsdAWyJE8llxeDEwoOZUf1yqzCv0uEmFNN1WVANnNr?=
 =?us-ascii?Q?5YT1ZuP5xXHhl2ZnmsUPNTTHCtFPJcwmIlMz8Ue4JcPA33VrCy+cHG65YsLQ?=
 =?us-ascii?Q?XL/vEZm1z2/jAC3qv+9kimAg7qL/brs4tg4Gn3lUaTMRzSYC6IePz5koUpQO?=
 =?us-ascii?Q?7HkA0XiqyQtZs9KplHc3o7r2klt+Tv0AiOYo3T9vk71NOC0TQzzTNtihBfvx?=
 =?us-ascii?Q?51HlQ2gHsnJxj8Zug6cDsXwl6TnaBP2i2sANps8w4bS8CeGCmpqc83mfF9Ko?=
 =?us-ascii?Q?h7CY3T1KBR8lxt75wgxmwlqYkSpKnYs1l91k8mDp5kLkwALzZzdpvTgMGGHi?=
 =?us-ascii?Q?WGVQCQC42jWqmwibwjKTzS9xHzo7JPzqIQAPVUgXuR9bQQmEv6pWa3Y8AmXZ?=
 =?us-ascii?Q?DEWIapdV6O2It0y9ShKztsbeLljBIOV4JcJs7OSi9y66VIRFfSdGxnUQsQnL?=
 =?us-ascii?Q?O1FTyPf86lInHzJnvPfgwVH7C26ST8GrGxKw/8hQnXFhKOozmhQ6guc5kmgn?=
 =?us-ascii?Q?VYYfgF/q5aB4ml9sPMcRe04r2P/Ojx2AhOxNTUIbqnoXtesynfKFLaNdGUB4?=
 =?us-ascii?Q?09H0gMx7NZ9bPcAa84Ar4F1KW3VsHDuRFZTYtAVp4OwCfglZHHq6KNU0wGyD?=
 =?us-ascii?Q?BDGMkJhSKGZFPkqus43bQZpvO3++LePBlqblvs8Ps+p+vFKw9pxFz5UlI3Yv?=
 =?us-ascii?Q?HSmsVMe/BMQBnb5ovzcWlGmLmLKfg/qx63EPeUr45WClns+YCDbv6PqtkL9J?=
 =?us-ascii?Q?CNX76XZknxu1c7u4tdC4/WBKIUYbWopSPzf6vkBo741ELOb22Zqlg0bMyKOi?=
 =?us-ascii?Q?VRCTnJ/kGH4eO5cBZ3twVM5E4PaSiYg=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fed256b5-5aff-43d2-ab7b-08de9605d014
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:01:24.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNRwHsyeu863Hj8RdPbVMii4NXm+gWEqQp/Fydm+D3PhL0koTM6NO/2V4oI7b9Nd9KUzPrMJQ/TvLKpve5nGkxH6GZSMKluCzrQHi4vQkjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5571
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

On Sun, Apr 05 2026, Simon Glass <sjg@chromium.org> wrote:

> The generated .S files for fonts and splash screens use .incbin with the
> full prerequisite path. When building with O= this bakes an absolute
> path into the .S file. If the build directory is later used on a
> different machine (e.g. in a container), the assembler cannot find the
> source file.
>
> Follow the existing DTB convention: rename the object targets to use
> compound suffixes (.ttf.o, .bmp.o), switch the pattern rules from
> direct $(call cmd,...) to FORCE + $(call if_changed,...), and register
> the new suffixes with intermediate_targets so that kbuild loads their
> .cmd files. This lets if_changed detect when the recorded command
> (including source paths) has changed and regenerate the .S file
> automatically.
>
> The EFI rule is left unchanged since its prerequisite is a generated
> file in the build directory, like the DTB and DTBO rules.
>
> Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Use if_changed with compound suffixes (.ttf.o, .bmp.o)
>
> Changes in v2:
> - Move U-Boot .incbin rules to Makefile.lib-u-boot first (previous patch)
> - Drop the EFI .incbin change since .efi files are generated, not source
> - Use per-file AFLAGS instead of modifying a_flags in Makefile.lib
>

> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index e625f99986e..067c38c4cdd 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -438,7 +438,9 @@ intermediate_targets = $(foreach sfx, $(2), \
>  targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
>  	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
>  	   $(call intermediate_targets, .lex.o, .lex.c) \
> -	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
> +	   $(call intermediate_targets, .tab.o, .tab.c .tab.h) \
> +	   $(call intermediate_targets, .ttf.o, .ttf.S) \
> +	   $(call intermediate_targets, .bmp.o, .bmp.S)

Do these extra lines need to go here, causing a conflict with the next
kbuild sync, or could one instead add

  targets += $(call intermediate_targets, .ttf.o, .ttf.S) \
             $(call intermediate_targets, .bmp.o, .bmp.S)

in the new Makefile.lib-u-boot? I think that would make more sense. But
there may be some ordering of makefile includes that makes that not
posssible.

At the very least, I think the additions to targets should go in a new
'targets +=', just to separate them a little better from upstream and
making it pure code addition instead of having to modify that last line
to add a continuation marker.

Rasmus
