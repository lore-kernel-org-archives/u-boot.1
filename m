Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB06CF649D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 09:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E2A88CF1;
	Mon, 30 Sep 2024 11:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="lUN342xP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D360388915; Mon, 30 Sep 2024 11:54:34 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B1588D6B
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX1NAR7tUeZzTBXY+Qr63I2DaMmUESRzvqkEtNBU07L92/xHFCxSy1wD3pYu1nN1K2gn96NiIVrBf8s18iZ7psD+F6OowNafLPsbTMMLfBbZhngMuh//oQm1VDwhhK4JIqzA6rgttxPwGj9N6ob2zxXz3T76p91guFp1Z+rxv1GkvieN6ByKU+5t+hFQ5zHdVtEpW7kbbSWiZtioS7/PGgmOsTrW/nzaGrnM1A21p4xNHwkuO8aA+KGcyoSSGhHEYRUfR1KvTU74GnoVQXr23Fq0tUOnXcJzUOV9Ad1CsFIu+jgfsJoQ16HL0QOJHoHOTkGFknAGzGVg2HrxEvcJbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb6RDIpoW1vyEvxfiX+wEwp8XvO2JtUkZ+IZhR4Ivbc=;
 b=BLXv3rtA7R6yRwziRWh23UdkSI+BJBB9f9HdEn6bjFRWRYoXeSXbt3fQMSaib6FLDTzRnQqmu4pz+1n/rGeH5RsVdfUEdliVFT6On2EacQhp/stZpge7XuKakeaeNGnhaQK0rIwvNKkbN1EzrUQ2DR1uM/R/FdWlGuav4chTEBKY3KRyKKh6b7oEqr+GS26jWw1Y/iYyUL93k+KwBj5HD7i1f5BREmYE4tbdVAvTNoSbPIJ9gojJNvRl12f0KYf3zhURoAnO5i7OE8dTMJxwEn9nN1pflww2+xJuxEMzUuBDcJ9vRfP5lrOfAWx2444ABjkgGVhoQo295a26bnCW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb6RDIpoW1vyEvxfiX+wEwp8XvO2JtUkZ+IZhR4Ivbc=;
 b=lUN342xPHuJk4DM0i16zMTfrWDktCiwYumZazxeXztBuf1QE7xSb98So47hGAOvJplMfN5wA3s+CibSXLde5EbaEWjG5BCE4wyNYgaSsrhVz7aL1ObwSVNhC6hyPlB8W7GBx4E9b6vIgMhfiFaXowVqycjr51hNuF42Cj+7rmiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB8736.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Mon, 30 Sep
 2024 09:54:28 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 09:54:27 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>,  Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,  u-boot@lists.denx.de
Subject: Re: [PATCH] cmd/mem.c: fix undefined behavior in mem cmp
In-Reply-To: <73723830-60be-4968-bb88-f518e493361f@cherry.de> (Quentin
 Schulz's message of "Mon, 30 Sep 2024 10:38:35 +0200")
References: <20240927-cmd-mem-undefined-v1-1-56fa57d0927b@cherry.de>
 <87bk09kjsd.fsf@prevas.dk>
 <73723830-60be-4968-bb88-f518e493361f@cherry.de>
Date: Mon, 30 Sep 2024 11:54:29 +0200
Message-ID: <8734lhlb56.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b91499-383b-4a6f-6318-08dce135df59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?POBN39wLkKL7EjDNabvEaQjJzqr8c8ERwRYEVbVSGzsLbKUZrdkiUH3wKUYK?=
 =?us-ascii?Q?8Yxd6q6FRzH/Z25o2vjnJzO/BtUsAjWeoT7Yw3M3UCRBLAHs8U0fS0F8GImj?=
 =?us-ascii?Q?Chnqa4ZmPB/vFUCNpSocSiQZ4OtFznKSc7gUXkL6zPF7YLxDqmA4tycNYFRo?=
 =?us-ascii?Q?NZJTiBL1odqUey/ZaQ1GoD3CIzPQUKsG73nbiHOuEXe3Ksg+FEn+qcqa+7MF?=
 =?us-ascii?Q?dQc/LcshPM0N/KVpduMGxuTtRh18Lg8VO84qPRjmRPBd+H5CMTnSB+q7cp5F?=
 =?us-ascii?Q?8BSYc0bg/sPAUWCir16zkwxw5Ps0jeu48AzsX08BPRCgOwlw40WngLlgvjuN?=
 =?us-ascii?Q?yZjDjKJTzmjBVjkqQ3RFUnV1SMIsDx+yz/Wy8lIFCf6Yi3YWH9xoLy55LMnp?=
 =?us-ascii?Q?JXlD4LJuAMqAs9cWIDzkscjT3iqj8xXVzf+yAUfW3ETgBDbU+Ds+ih897OvN?=
 =?us-ascii?Q?zkjolMYpyyvshqyyfcAnKCAr1oXLxweG9t6w2JDwQ9m51jjKdlaFj32euXVQ?=
 =?us-ascii?Q?U8rwQrUHkDOCWqDuhYPVz7EK2VFLtIAKqMpespkpPmHVjGJ85XmnSGWxL8lw?=
 =?us-ascii?Q?+amCzFc54e2lzBrNMO0pAXLme5Jg28X70TqyM2aCEuLke5mvkBn8zwdKh9v1?=
 =?us-ascii?Q?b0/rAHVgUOot56e9xfzt/leg93+ZlSBZV9BlHSP4y26FrUweucrPTyvLkpyw?=
 =?us-ascii?Q?uqSy5HSA75S02O9ZT8IWMxUO3SchpI3hGdzvnfCVGWrEzWhGdMrki+kJ580B?=
 =?us-ascii?Q?Vuau/xS6giM9iap7pq57TjGLHY6OnfxvcFS05+MrDztegpMJf+kWualOyUQ3?=
 =?us-ascii?Q?iVYvDGuJRUUHsN+j0QO8mH1FMkXr/YIHC3/JFFA7oL8j07MKH1w6BaGih9s1?=
 =?us-ascii?Q?wO7r5p3XCVD4OJv2a7cMFNunCKHy+xkz0/J+LN1AUW1lchf296tipAjQvLXG?=
 =?us-ascii?Q?1S/eNgrVuVOsFXObnimQ7VlpBn+5Lhp2chaD/MfgIpmYeAZhJzFFBIUKpSTf?=
 =?us-ascii?Q?m6nyGq13I0/rGwrIwZtBs/R93unlfzkuRWq+Ui37XGqGncBuB2Mf+7tYTye/?=
 =?us-ascii?Q?fO5tVn6qfyIAo5iOt9PnBzQ7cWUV8TOmPj5e7U7ov3BJ8sxBwwlGcNrgkcXx?=
 =?us-ascii?Q?cXgMSsmRQNuFrKZRFccSXHmgz/6r+xYyP+wCAJGqb3N6xR4sKbjxrO2AP2uk?=
 =?us-ascii?Q?OUnvMFQZ7zbDNAbEOje2Zi0qhvNEzCgBOzH2zVjRwN5HPYSVX+/X8OhF+az5?=
 =?us-ascii?Q?hBn96htOqfKfxpQzor+P8PrO9zEfTBTldBpQzUe52Ized1u/Go4TJFRpisAY?=
 =?us-ascii?Q?WmtUBC8bRpisnVT98+r9OfZ9JHZtIk9bJ9LEgo/5N4vi8Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y9zNuY9uIiaIBgkPTh/L/cN2gH55bzstdLKFfvZbEkWLWBsipBcytJZ8aL0E?=
 =?us-ascii?Q?8hTSyubZ4QA8vlmh3otdtx/k6PDgY9ZdPjvxtlZSejIKrbOwlfoB4zRzGOS4?=
 =?us-ascii?Q?rJlRcs/GnjNIv4bCxnHoD4DwXlPZvUpDScgnrIQMoJCfrRFHlNvCHWIvIEuq?=
 =?us-ascii?Q?E1AT4cn5N+7nvvj+/szymxdTLGJf13ttidvwh4VP8fD3MYs4wK31FROcHakQ?=
 =?us-ascii?Q?WxgY/QxGDM+i/AMPI3wiydIv/0ZHfGMQ5gCAP1qVDY9e92XlCJuu6jljEabk?=
 =?us-ascii?Q?5JhDMIf+FI62SkADO04zPMcDnvFiRiVW+2R2dljCixxZjjtdjeZAPAJK0zN3?=
 =?us-ascii?Q?BwJZfKnGQWLkhLVkSRNwvfbtI5DzF8pHJaDVlXA7qE/2rRoPlUuUACOTNA3b?=
 =?us-ascii?Q?Ii1li/ah87wUC12HBGMzJDftSwkwDGobNy4b6/dDMSEk7GWmi1+bi6oLkWOk?=
 =?us-ascii?Q?dRHSCljsBdy5Kr/pmOv/G1251swYSJwW5VFvY8vYESa/3I8nS5I/AyouL7is?=
 =?us-ascii?Q?JcSp1Ct4P8VqNvWOS7dSwJL6K/U81ykiEtw6hrwiC7M7gKrD/ty0WW3MS6gz?=
 =?us-ascii?Q?XEhiducvLprVjYqpFu9ypLuwP4goeiK+v4BzNj51vp4Sv6vkiC6dj/BZ/1qn?=
 =?us-ascii?Q?bNFVDLu5LOewFmu5u7WuhbXjKePEj5hS6lrY0vuGVnAOr61Y8nj2fHSlGuQC?=
 =?us-ascii?Q?CVTYTgJ327wHd9mcZSYi08dWjQpEryrw/SvDgZGkz/gdAjLBha7d+VjbBxcr?=
 =?us-ascii?Q?h7Oqc5Ae3viOsKnNRaOqMhMC3ZKxUysEDo017NxRxb1zLFRwI6Io1t5T+pIN?=
 =?us-ascii?Q?0RPz+h/RieYGbHh9XbvzLrdosf0ZipKoVKRPy9T7eDcCFMNcvNofvAw53CE+?=
 =?us-ascii?Q?dxzbCOYYqUabc4/jLw4hdjO99XVgBptAIclsqWeC2li5gLvvxzWqIM91tOzm?=
 =?us-ascii?Q?jgWmDXehrqSBlTCH2WQlA/CNMUGoAXR5lMqul+gEKRoNIiJdgodEZFlqls5t?=
 =?us-ascii?Q?qQyyxdulR/A0iir5mi8vp/EUfeofDwdrAVkWZ8TWPoPs7XcnG2L1+SuMDynT?=
 =?us-ascii?Q?UZdVYOrIqIWqBLvnzJ0WaJSr8sf+k4PptEP/0AnWkcACD34YNBRL7HHp5hnf?=
 =?us-ascii?Q?v0zTG/CCc8kb5KpFdAofKr0DQYtXGpxW4Mfv8A3mCMukaAHUsKMuHSgDI0OW?=
 =?us-ascii?Q?Cv/Tgm0xyLdcEvsQbwN7YnH6YaP8wKj9mB5EWj/fxql/FarLIvW1xO5ggPY+?=
 =?us-ascii?Q?qnOrhjm6FvMY6dqT/xEt2cSyT/kmlHA+C2IdhsjGBtLeYGHZ7vCm+tXe8bll?=
 =?us-ascii?Q?tzlQyN5KIYNf0ujLOJoC4HdzbU+LYhYb7Z36bsbVgzgq8PWzlGexBxiPXi3D?=
 =?us-ascii?Q?hvA2C54ZeyJ3JurCo1Rc6pD6oMeVbA+Dm9AV66cEW87JtzhxKa+/7OMmL4nq?=
 =?us-ascii?Q?v+KkCEl/u+q1OHOoQCr6LfM1z43vd9oEy4SpGRVfsttOqvlfof4JA/PmVojj?=
 =?us-ascii?Q?1ssep0Ibvey4PgBsK1uacIlBN5n0WvyYdPqe/+/B83MDuIzYtvUF7oJ1sv4J?=
 =?us-ascii?Q?Za0k+pRbqP7hcrNSYMAqnhybgI5Hr0mTreObSZ0bfMvI6KQyZIT6kI4Ubn5t?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b91499-383b-4a6f-6318-08dce135df59
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:54:27.8211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmggx7ziuBbgSW4Mwb8zjkLRukW788KVDT1zrSRGG+g01yNrFSZmiPqprlzaUPau7erkLbAt1SGBUPAecfzY1L1Il80fihz2k0okaEhED24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8736
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

Quentin Schulz <quentin.schulz@cherry.de> writes:

> Hi Rasmus,
>
> On 9/27/24 8:56 PM, Rasmus Villemoes wrote:
>> Quentin Schulz <foss+uboot@0leil.net> writes:
>> 
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> My linter complains that "When using void pointers in calculations, the
>>> behaviour is undefined".
>>>
>>> GCC does say that "In GNU C, addition and subtraction operations are
>>> supported on pointers to void"[1] but this hints at this only being
>>> supported in the GNU flavor of C. And I assume U-Boot may want to be
>>> compiled with clang/llvm?
>>>
>>> Let's fix that warning by casting the void pointer to a u8 pointer since
>>> the size variable unit is byte.
>>>
>>> [1] https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html
>>>
>> No, let's please not. Try enabling -Wpointer-arith and see how much
>> churn that would require all over the tree (doing it in this one place
>> would be pointless), and all the casts would make the code much much
>> harder to read.
>> 
>
> That alone is not a justification.
>
>> We do rely on lots of gcc extensions, and Clang has documented that it
>> "aims to support a broad range of GCC extensions". Arithmetic on void is
>> one of them, and that's not going to go away.
>> 
>
> But this very well could/is.
>
> 1) is there a way to tell Clang that we want to follow this GNU
> extension for that case?

For that case? No. But we do -std=gnu11 which is understood by both
compilers and tells clang that we do use GNU extensions. I don't know
the clang internals, but I strongly suspect that that flag would make
sure that defaults for various warnings are set appropriately (that is,
not warning for something which is explicitly guaranteed to work in GNU
C).

> Is that the default?

In our build, yes. See CSTD_FLAG. But both gcc and clang default to some
-std=gnuXX, with the exact value of XX depending on compiler version.

> 2) do we document somewhere the GNU C extensions we use on the whole
> tree?

Not that I know of explicitly, but CSTD_FLAG=-std=gnu11 kind of
documents that gnu extensions are used.

Note that typeof() and inline asm() statements are also gnu extensions
that we make heavy use of, as are various __attribute__(()), statement
expressions (i.e. ({ stuff; }) ), omitting the middle expression in ?: ,
special handling of token paste ## after a comma, case ranges 'case LOW
... HIGH', etc. etc. 

>
> 3) is anyone aware of a way to silence some specific warnings at the
> project level so that clang takes care of it so that linters use those
> settings so we avoid people sending more commits for that "issue"?

I don't quite parse that sentence. Are you saying that your linter is
being invoked by clang, and you want clang to pass certain options to
the linter to disable certain warnings? I don't know how clang could
know that options those would be.

Rasmus


