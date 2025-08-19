Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E862DCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 11:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126A282E05;
	Tue, 19 Aug 2025 13:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NtIJIYkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 762AF82E37; Tue, 19 Aug 2025 13:05:40 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF0C80FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 13:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTIo3rmHGTmCLEj6CcIYav1vrHP/ZX8V393LXOyE7SmpyjaEavrZgew2Ozd0PTU7QumlHweaD7+MJmZWk8T/eBwCd5jj6z0glj7KVVUDpCyYarIII7aPloosUC49IR31+VunyPuRNoHg7Zc0Bv61U8LbnH8btU11+oyregUuULnqqzei7k2O/x3aMs61Srt7/rILIbCzqL9jekUuoqo5enIaeHC4nf82uBM6DGZDOWH01rY3MXfGSbA/AU2f1164/e3t0wv51Odos736QMITdyXaTfv9BQx7K7x13sf7Wf9LRp/6s6hqwIdcQ/AfEg9PZ5HiqYuCllsGd0cyG0hHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhZfo6YsB6NFwnS3x9T/ufWI4T2Kkjx3KE/A2EoByws=;
 b=nlZnE65EVCHY9VaMU8IETHnya1Dq+odMzPQuMg6g6Q6uSyYIdb3DCNVbcCczkDlq2emGTGwpvNC8oiVoq9jb+KaraLVKq2CSw8i4sqP1pRvcDoEXOGL/tbjIcAoM7DqJcoaYsUtywwtB+BdVSSTV6H4Hgb13HlRg8W6x6KRRjGAZ2KFIkJ/k6xzew55ZxU45Z0oYSvBtbxJFNiQZJ/HotDVmSp/WeVCcryD/9yJPPdah2twUMFhRFMlXlggh6mSDXxixe3STS7YGmiY2SC8x662LhxRZV/yozMncy3Aw3/OMArBXfuOuj9UBwV9LFJvDaYDe0tYtjqyk1RjHOMnJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhZfo6YsB6NFwnS3x9T/ufWI4T2Kkjx3KE/A2EoByws=;
 b=NtIJIYkDVDa7VobcV73oO4sY8B37ONandObQiQk1bpV4qRXeWrSuzA1srZ95EAJaZpwjiNGVk6e2BIsbOB5g1Oa5hRmMLoMVi9O2TJOnX9ONmc9S6Ym9xqcoddg/h0KJSXSg6F8k1Lxg1eXZzRu88sl5f0PWWO3lGVMcbV+h9YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB7307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:05:34 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 11:05:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Sascha Silbe <sascha-pgp@silbe.org>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
In-Reply-To: <20250818165119.3193853-1-trini@konsulko.com> (Tom Rini's message
 of "Mon, 18 Aug 2025 10:51:19 -0600")
References: <20250818165119.3193853-1-trini@konsulko.com>
Date: Tue, 19 Aug 2025 13:05:27 +0200
Message-ID: <87jz2z372g.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::16) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ef23c9-1118-454a-0c67-08dddf10519e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/IacTYwOEirmN7KXE2jHhm0Tt85DgYeunLuilRVfDqCbtu1nHnvZKtFHS6n?=
 =?us-ascii?Q?qfvtPeQ1dsh1vhJrH22RdIss0GjNxLJixdhB876L/GKJ+rru4IrYvSVwp50Q?=
 =?us-ascii?Q?HSU7ml6Bgoh632jGTqN3LQsTIH9+mLzljNEucHv54HxjaX/tNV5v0OXbRRsT?=
 =?us-ascii?Q?Rg5T8tDIAbiK1T8iTTcqpDolzhJGJdAPdpVuQ2t7kmhxnkrLnuTlpP5yVTyP?=
 =?us-ascii?Q?NgLPoEynvfsmFS60Wctye67ckok0qY6dmPeIWlp+O7+7zztclAJ7zwweoZue?=
 =?us-ascii?Q?Slh5VtaviRLiUom20jZNkBTAc4V1XWond5fm1Vus8nC8NxpBMMTJ6qZsQ9Wr?=
 =?us-ascii?Q?s8XMfUZiZNHcwAQXVWFOWH6jXLktjUujSKWDrmx1+QCbC3ejmLOdGaE502Xc?=
 =?us-ascii?Q?Hf+0mXSdk3nbdhwRRD7jgX2Sw0D7zJMg7sqVgPsXp3bNyfmOCHXRS7kTAhA7?=
 =?us-ascii?Q?v3TPGcxFrxNE65lUIGqPQq3dUaufPDXOiKMlIGRWoivaGzp+jd75YGfJcP2Y?=
 =?us-ascii?Q?ae1WVcXBkelEsE6iNuW0A+JG4YtdG5mZ3eqXmQsBrgfyQTqhkvmrVjq9epbh?=
 =?us-ascii?Q?KS1rBfRQ5oO1iha8dnlBq/5hAQ7JxwL5Ub8VUJ62hSs6J7aGzLju4gCixM1m?=
 =?us-ascii?Q?mpWqJ6Xv8C+m3GDEIPYGvu4v1Z5ExWRls+6RY6ja86UJlNvqOz65aXHhLNl9?=
 =?us-ascii?Q?U4o4wEHv1v3lJlDqtZYuKQftd/xNfxo4hSsh7fKYuwbeLC84rfji7y66Fdzi?=
 =?us-ascii?Q?23ShtJFW2swvXLXyamaEIdjlrVplesOPllfH6CgYVRGRIwvzm9SIE7RXooTf?=
 =?us-ascii?Q?bG1Qui1rp89FFhQ1pYuS3KaGx33s9XAcBHNzoib7eej4+s/RjWd00PPlpFSl?=
 =?us-ascii?Q?FXEyPJUi1pTgBMYAJHKtGGvqS3nRPn3yy9zRTLT8HlYoD0UsqXQb3kSNxMEF?=
 =?us-ascii?Q?5w1Jz7Cf/8/SCA80jfnWM3f6RkcPkruGsSiXM8kFFRAOTE2xbgKsYovFD3pN?=
 =?us-ascii?Q?zhAxiJI1rPlCOhtxIB3bHo92YNt/Dk1IPWo1aSq/gS1jVJXWFMWsEm2GpynJ?=
 =?us-ascii?Q?MQob1HV3y70c2YYyMb6lR4vPPAidObRhVWt3MFp8RpE+wwct6RrjVsNmcUwf?=
 =?us-ascii?Q?HYWRnRujiMNKh2GGnctMqmDgblQ1y2xXzH0SUe/NLaidaYSRCo3YKzzFvIJE?=
 =?us-ascii?Q?lU1bn3b1FIkBkeX7OaH/S83fePfAHVRsMrNupL8dXDcOabq3Z312OT5luef6?=
 =?us-ascii?Q?DVXx5D19eBv0VJnpUgxPHVf3hI/1qgBrkf96qi+xjuOeTc6/ylU8DIE1GENB?=
 =?us-ascii?Q?RiYBfI0BGGoexzZMCgmxmR8LGKELRiPfM0kuaKed8eH4SfXliycawwi5gE8N?=
 =?us-ascii?Q?EBBBT6QPrujJ/SqUknwCBFNGd9/I220hqi/V0U57KkieC5QMTpB4CYC+Rxy8?=
 =?us-ascii?Q?pebKdYK6vSNTXxo17ORqxi73YbJfNZsjOu2N71fTsVvXN8FGQdK3ag=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uV0QW5rUmJa5dAGZuKibLNTx0DjA0OatFcrzLUyPsXiQFdFNr0dYIhGVPADr?=
 =?us-ascii?Q?lbPiwGSDR+AKjmUVs7FkDowpDU+8xctzZe31ix9h2qy52pnMDyecNdYJA0Jg?=
 =?us-ascii?Q?KQq8AkNyaXnpUGcCzJX36uJrjzxY6rq0OWE6Zif2MJgzT53VDTYuxdL5D/dt?=
 =?us-ascii?Q?I3JYyIPIFRFPE/my6tWUJb9FNHqfEsQnWTMe2YHP34+EACgwl7yGx7QFjHqJ?=
 =?us-ascii?Q?/EWht3eusLUDc1ccOLV2kfL4YRwQC0zAIWNyXvaQiitgGlwAkvcBKC2oyWF1?=
 =?us-ascii?Q?1Xu5C5IxbthFbh7lz74vrNL9SWMAuO/C10L2dy+BHKo/hg1X2NP25KLXlQmw?=
 =?us-ascii?Q?A9dDIbTlTGX2hFQqwt6itKeabUlUScYRpEFFjYYOSuaN1nw7wS0lUIRNcWIB?=
 =?us-ascii?Q?kDj/OJhc9DQXp/0sFr2DWv9+ZKygB1XQYzS6GTYLokOpDL1A+65RvN5hT1rC?=
 =?us-ascii?Q?GbADYseYVZm+uB9Cfs9uU/OB1BbdWfi8h/seBnx8W0lbIGhFO7qHc5oz8SVG?=
 =?us-ascii?Q?BRB9b/1F/E3mXv9lnsEO5Ac9uv1glP11Kib/9UoqpNbv37L0FWWoPERsc4+c?=
 =?us-ascii?Q?6dq4r+uYMA5sWN5pjCe0ME73GByhOBiAe/4h6zw5S+x21P8n5uolZeFLAAFF?=
 =?us-ascii?Q?whbDlFIrhsmjapyTYglw6c4/vlvr/7g7A0fxK+oelpsKwWEMWGXMv+VG+MaI?=
 =?us-ascii?Q?1I5ofIvsIw6tTmz02c7I/Pd2u7V88fGvmJ0wQRp4aqNpXl+b/z55gMaaqc/S?=
 =?us-ascii?Q?MIs7m9Jwtc2/g5PF6+p+5iJTtDFx63NRZmB3yXHZXALUgifnIiIZhXJKFtwg?=
 =?us-ascii?Q?Ugdk78ClrrJRUdE1JSa22uMmea6JvuiWCUGUDK+n65kQaaObs+5UX8m+RYcJ?=
 =?us-ascii?Q?XEMUENoelp2m/B1tF/wJvCf41BSWcHY4z6+9j2lR4QGcJHf1T5Oe6YHJVhqW?=
 =?us-ascii?Q?NPsiillSbVPbTPjEYcFmaVcL+wkBSA66r4itZF+9Mor8vPIK/I9TJ9E/+Kj2?=
 =?us-ascii?Q?+21uCIcwVg3t1ffL6qKcrpvyPwkKiEKzbhVhjZPOqFSu6rMIAWCcOdRMg8UK?=
 =?us-ascii?Q?Mo42o9pTH7Ig0HSKv2ItdeD+18LZverxueLyxo+MSlvSa8xSeSZgKcLlJq6O?=
 =?us-ascii?Q?saokB0tJVmwvR/lim0QQAxjco50nMOnZHiUKCCIzK3XUrAgLYQkDkmskynSJ?=
 =?us-ascii?Q?TgQxuSKfQMuSAxHO5inFtQhFGdzNhmqiVZrQUPKud52ih83fW9lU51lXL7Ar?=
 =?us-ascii?Q?FFRVp1OQ3XkmdTw6Dmm/4KnNWCHGSJIikYvwLQl3WZ+/bTlT3Ucw3ITNjztj?=
 =?us-ascii?Q?Pna6gJTU4rj4BDa5wyk0Tq+yLV6iyECP0yPlCmzjAdxguHFGLST7GwWWdQa5?=
 =?us-ascii?Q?nwl9QtbxioSqQXjqOHzd3Mk7IVy9mZb7SMZojEfg+7nqoHxLAu672XEoVOWY?=
 =?us-ascii?Q?YqhzLKs+oUOwSxS9VkT7i1Sjv6uvTr/l/6b7FNwWzDwlDcyckzJGTIpuMsxK?=
 =?us-ascii?Q?6BGv5imvc9kHd5Or3rLcIJNao4bdpiU9Ssf1w7p9VlSB35Dm67qY72Towv/z?=
 =?us-ascii?Q?pgh2usDR82oBdSbSqRdmpcD2z4Klmg0cKJdlxnXUEqPN0AGSoATXu2lEbSQK?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ef23c9-1118-454a-0c67-08dddf10519e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:05:33.9969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvQZlxyRlOdQ5/XRcsDC1Hq5Wg1JI2zWXzLwQK8s+guWkyXnzn7d9G6yeMhe/3JxYt8GMoo3CfzBf0Rspp8oQrtKYS4X5108jwKku2lBYQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7307
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

On Mon, Aug 18 2025, Tom Rini <trini@konsulko.com> wrote:

> At this time there are still major Linux distributions which by default
> boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> DISTRO_DEFAULTS to ensure these platforms can still boot.
>
> Fixes: d780965927d4 ("Drop the special am335x_boneblack_vboot target")
> Reported-by: Sascha Silbe <sascha-pgp@silbe.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  boot/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2ff6f0037384..a6fc46ff4f5f 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1163,6 +1163,7 @@ config DISTRO_DEFAULTS
>  	select CMD_SYSBOOT
>  	select HUSH_PARSER
>  	select SYS_LONGHELP
> +	select LEGACY_IMAGE_FORMAT
>  	help

No objections, but I wonder if this, and all the others, would be better
of being "imply" instead of "select". After all, DISTRO_DEFAULTS is
mostly a convenience symbol that turns on other commonly needed/useful symbols,
not something that is absolute required when turning on some
"DISTRO_DEFAULTS feature".

That would allow a defconfig file to set DISTRO_DEFAULTS, but still
explicitly disable things like LEGACY_IMAGE_FORMAT. And it's actually
somewhat hard to migrate away from having that set if it's select'ed by
DISTRO_DEFAULTS - one would have to deselect that, but then manually
ensure that all the previously select'ed items were set explicitly.

Rasmus
