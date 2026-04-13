Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B58F531D6
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 21:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ACBA841D5;
	Mon, 13 Apr 2026 23:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="UhKsC4wE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B37584207; Mon, 13 Apr 2026 23:16:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A88841CD
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 23:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vguSLsvGlHAqTR2+LLBIOFPbsBysRNPPliRBbsEnEo0DVJvYnlXzK3y0cGlFans0w+DrVVjKoFyALWmxgnzzMW2WxSnpzlaCcFfXUMWWnUZaMkoHSNDKB1gg/VJOL+3Kt3fDB3BvRZsO+oo9iMz6SUeJEPN6dtjRvNYN2JWWQupn4r7eG8eMjqw1VzziAm6usoyNFhSlSYEobAh073P/cEG1GOvjBXcaf+20iLU7a4iI4E4Rc95bfGJzOdsgx+3VPZtbdZKsJQhgs2zUs8q53uzBoZakf1TiJ9gJceMOTkxcgLvW15iCsfTv46KsNSpv9KetDLRwGqMZQYFLm+fUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hU9t60ABmL+q7R9naHxLKdLwxjq7mnIK5+Q825c4+bc=;
 b=A4WBDonw4iznDqCisEgNZrI9ZGrmRZPuO4t1iWzcCwB2G4jS681C/ikyh+jMx7dKUekD0lC6e0IapSG4ILGgKn+a2YpgsfteoizXSxnopUqEbQwaHeuEARSoW9UQ6F+ZsCfZTF0eZsX1KvaIrIs3Un9e17PwOueHXCyN4TSQgCXptLUd0Vuq9Od0G0+xQ77RsZueGW3hz7wXG+wcrdNtMc+vp0SXMdW9WSxt/tLdTLUQP1ENIKFaNFpLGBcRA0mQ61yqow2DerS9XI3PRd3M17uu692VAc2fzhG8zjQxcbqnGcT+bQCGB6QhHDhOG3Oifx/4boXNu/QKw8/jVe2TuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU9t60ABmL+q7R9naHxLKdLwxjq7mnIK5+Q825c4+bc=;
 b=UhKsC4wEhQGa8kS53OtStuGyeVZMi8tvvTo9dhpI5C+TrClOgB0csgLgkhrESwpz5uazi0RXtRAdA6lD+IvKjxBbD/1okpg4dZASDv1yB4rMkcK0aLftSqPmhm452sS5rGqbVyVv0dKu6JTUFOzivLQHnZ2kmTrC9vyEpA3wLAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAWPR10MB7198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f1::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 21:16:31 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 21:16:30 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Heinrich
 Schuchardt <xypron.glpk@gmx.de>,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Ion Agorria <ion@agorria.com>,  Patrice
 Chotard <patrice.chotard@foss.st.com>,  Sughosh Ganu
 <sughosh.ganu@arm.com>,  Svyatoslav Ryhel <clamor95@gmail.com>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v4 2/2] kbuild: Use if_changed for font and splash
 .incbin rules
In-Reply-To: <20260413131541.2091541-2-sjg@chromium.org> (Simon Glass's
 message of "Mon, 13 Apr 2026 07:15:38 -0600")
References: <20260413131541.2091541-1-sjg@chromium.org>
 <20260413131541.2091541-2-sjg@chromium.org>
Date: Mon, 13 Apr 2026 23:16:30 +0200
Message-ID: <87ik9umuhd.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAWPR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: d2575f81-4295-426c-facc-08de99a1eebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WUOgrP8pViLaHXz494e0J5ljaFceHlx7UxmHzG5AWsLvOceIZR3E29lBGMTTv+Aon+9qkA2OxjOwDYw403umWhNaAmSjyzRg53wckmXrk5Y15uVPJXlh9RLucewZZbpBymBm02Tk5GlrzfGyWT2A3lPnB9KjQSxAVx9rW2yNd5fiauM8grV2vBZxCqq6BkPFPhWHmSuGyuHP4Ao/TdufkY2Oh7RWzBI+uUWmDig6qtGStqAL9rJNxW9SeD69wDtKnEzC6bSkw4S5Nw2w6JxUTe1B4pkfufsG7tD6SNMxQBEKuAin3XZvBvXNETU3nA2LnQdv65ZWDxgHCBBfIN1H0FqmfjDFoq6Bwg0UgL/XZZl40Nq0DjcXDHHe2gdDAq7i1onvvltlG3tI2Jk5FkHymnzIVZQKv+s9QeC4bNUhOhLBagADIKKQOgM8P2BVL/5mtCPgMvKscbNV4lyWyffsnJBzzPE/i8NbuqVUCtsEPkdCFtCwE5gVgvUu6An7mHUq44n5LULVFvGBey+w/cO/1520mQDT8RhmAnp/E5AskHyeobBDRUl9hUS6qmPL9NCw72RVDQ30K6wTuH+01rwbImjlybszwVfujqHn/5oA+OmbGS4KYPxR7aTSnIrD5M3AVrkpmhICuKi+jvygylAmIfCUrPk/msA9Xrl8zT+RHt+cbjurPcifLUcZFF/hFMKnzDvPdgcYT/dhoCXekP+iHyNAzlH6ZRRtHQxH06ezE1ctDXgMA5X2LUogrdjZQ+oY64A39to9zitya8q5KJ+emNVI9wGguUujt9CNbagxiwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vXCnwTLGJsAgJHnqtFvlnaP5+j6UkWK+hW6Lr3+tx0UIrAdx/yjHm8UpU7+4?=
 =?us-ascii?Q?HygYknPTye3sTbOUC9oxBR7mEZ6fAAVfaDkZqX/pUKl4pkKv96rNME4PYgmh?=
 =?us-ascii?Q?5xWLCsCuVP8wlYhkq82AcrRQfxe0CTysFL0FAgaqtc/DnF9ubvygK0dhSVr6?=
 =?us-ascii?Q?HTceiNy+7sqhHU78O3O2zYDunRCT2Fcw5Cq/xKdPtTo0blPhA0ORjmxTaAAa?=
 =?us-ascii?Q?fSXTDF/ygT76rYNFuRazzirNSU1ruMJ+hsJ2jxp1z4EQHGWeORjAYM39wiNm?=
 =?us-ascii?Q?ah1kcNAy688H/rFVL5UlHknqBzoaQD+Z/xPSNG46k00bQHawl71qTNXncqSv?=
 =?us-ascii?Q?W4fHA24ZlIcqUPsYA5zTBKozr5/to2Liz6Bm8deb4g0OoEEigVsVMoq/PK8i?=
 =?us-ascii?Q?i7mfthefwRokLtcuum9NZ/3ZRD/Bc1MOnMLK610V3bKmKP53/ha2xSm5abQc?=
 =?us-ascii?Q?mYLYF8ebE9UAChGK3bSe0OW0Vl9dhuAkEeckmeHwz6WKD6Tp1RvrgAVSbH1q?=
 =?us-ascii?Q?Uv95yTd2h7+8Y9pPVfVNlth0Ynv6JXzLRQYwUXbZu2mRmAFEgGOkA7IVPLMB?=
 =?us-ascii?Q?YUmlEuyz7BYjASLh6mdV1F/YF66NTNCFR+y2xC+EDHbrKwK87wp/fsHVG2pI?=
 =?us-ascii?Q?zsDBd5nHAnjWHMAP1iRjlikDbJZCxMUj+xbsVbnZJmloIfzFt6IqiXd2I2Zb?=
 =?us-ascii?Q?w2sq3v8WP5nwWFG2eLMn5ConQITkU/7/V8peZC8oAqMtAmbcLjPUJwkuOO6h?=
 =?us-ascii?Q?lXlc0IHjAIUMcByPY2Si9a41+TVn68jY+zwbuJo2TtVNLDL4ymXZwIf6oSZ/?=
 =?us-ascii?Q?hQXVHY7wd5FBvw1GQw9JVYSx4biXiEKWV8+xeYHzMZu4lMtFaTDsgMIPFoOe?=
 =?us-ascii?Q?Shq9IZj0MoCKee5CdAWb6klpmOSdQl4PYtggtdY9cBNZXm5KbJ1CnSgwtPtX?=
 =?us-ascii?Q?im3jQVYIlMbOs8JnizLGNiBah9mlw/iSNAK28tVu1TiZpU6bsh80uIOwBjQp?=
 =?us-ascii?Q?kpuVNyZIT5PeYVhsBe8NRLIj+VVVa8r3EkMOzpcVzgKXQXZXq+OeREayW0WY?=
 =?us-ascii?Q?V/wZLWm0j81OOEhDrpjqPuZ/XxD0eCp3Ho/xSDylsvEL6yt1NWB5q7oUj9cF?=
 =?us-ascii?Q?U1cIttHZLlHV06DLch2+QYCROPDgilf9jD+tWBsrJL7vhUcA9u5iY9ZDV5a6?=
 =?us-ascii?Q?VlTwNsKPiCY9Dl9zyzv168qwyB7/rNaHJs5RgR4H3n+WibHkwe6/OKx/4l8A?=
 =?us-ascii?Q?BHNqPRb9xPlsrzyDi7uNUsD6/ICu4JqAQmGm/6Yjq/00WMCHWMGYnzkp/TKO?=
 =?us-ascii?Q?KLMBh4NIerV+ufPZnsze8hn/fW/qPe97z+1V25FFo0iibcXhMiYTIdGM/BUr?=
 =?us-ascii?Q?3IgwKsuMulTfgRVJdpnVFXy9jdyBs9CaQPZTNpkla6e5xBo6Mjor1rc8VAHz?=
 =?us-ascii?Q?QOBdARQMQwH8ZKqigeiUdI6B0nMTu/rSgjGIA0bod60ScQfiDu6x7BojeEOb?=
 =?us-ascii?Q?lVPp8xDqTFJCn3WQZhmdY5Uzn8k0pJQJZprR+k4aHClqHp8IZT88rhHIxibb?=
 =?us-ascii?Q?vRYTQs5PaGiPSAaSXXxi4+AotG2dc/hqSHMhY36ElgFbD3vFiGVHxSQVTooR?=
 =?us-ascii?Q?TCx0r0AV0WS1RO/b0t0x2h7qI1BObbVzWd0t1+10xM/GjcXWW+G9f36WGoaD?=
 =?us-ascii?Q?5og/iC9F8ZHgm1MYReAl6lNDEfKegBPr+k7cQgkbUTf9y83aSSPJqu0fFNT8?=
 =?us-ascii?Q?fpOT4Nva6Eg8LgTPaqdM0dWYp4OsNF4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d2575f81-4295-426c-facc-08de99a1eebb
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 21:16:30.8254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ury25EG3ce7YUlDHATHHeDI5Lt5OMXJdmqhGCXOwfjj54t+a+dW5rjMwOX6fFB/OkAQnTv121hkt9DgDhNG9+TT08v9SzwQul2ceL5f1Ee0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7198
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

On Mon, Apr 13 2026, Simon Glass <sjg@chromium.org> wrote:

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
> The intermediate_targets entries stay in scripts/Makefile.build rather
> than moving to scripts/Makefile.lib-u-boot, because that file is
> included before intermediate_targets is defined and 'targets' is ':=',
> so a '$(call intermediate_targets, ...)' inside it would expand to
> empty and silently drop the entries. To keep the upstream block
> untouched, the U-Boot additions go in a separate 'targets +=' block
> immediately below.
>
> Suggested-by: Rasmus Villemoes <ravi@prevas.dk>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Rasmus Villemoes <ravi@prevas.dk>
