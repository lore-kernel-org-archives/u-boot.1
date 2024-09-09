Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48EBECE57B
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 08:46:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE76988D14;
	Mon,  9 Sep 2024 10:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="XR3HjOXN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A00B88D1C; Mon,  9 Sep 2024 10:46:27 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6419388C86
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 10:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UMMDxOB+bi10cRqHGDWrf7lq030e2T2DB74FeVsCHIB8xJV9Ifj+d/q6O75Xetqtdc+AiadcEvzg4ju97PLOGIxTZk8yJe3yT1v8zaW9KUOmHtGqWZna3tQyleJF49Uti+rDPJ3qBz/A68MDgf4WAwNJDw//e5leLljas5sJWd4CXg2UTFKRWtchLvswqZ+JsAMgeVHqfz16cv4ZaFtVyPx710ufN+IozTu7mIrjAQL0TE2Xw+0++yoJi9jv20Espl6Sk9A1tk3YmDs02oNQ9wKIrsREYTdK6zIzze7X1gS550Lje8yBKElV5yO/J7eqRdTerxatih5vPeB/HRNZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lWZkVQHaCD7qXJQ7h7zdGO4EChLNvWWc11LXT27ESI=;
 b=VNgGOA+ymYH2aOlqJWboVrG9NFy2V9XUGhIVWXAupm/jNghFopruCYKoV4RXmZ+sQSMm7lzpwOWhkF6pE1vclzpiWHiu67ksCO6yGoKm45K9oVPj3MJppdAuMtSn9JDbfBTi/KNEOc9Y2xUXkZdKBTF56ypQQ+zxZedsiocTsjNB3Z5DrJ3R50qM/ARCHRDwIV9V6nRDZwgyWG7zGaf/siPOqLnC0i2PzgecQna3W4ISVioMudp/C6aYSUU7POzXraHQFb+iKTDi9rcrQtuMoLcZ5gvrt6uWK4gMU/vAJjDiw1fYmDmqa+xm2ySirw1nyuLN6MbO4RhrrAHt61NmOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lWZkVQHaCD7qXJQ7h7zdGO4EChLNvWWc11LXT27ESI=;
 b=XR3HjOXNdaxFuJgFgDyuC7H5ZM9ZCF8MrZz0joCc6dYJ6DFCyezj63zZCWLJ+gMyQprxnRnBgmK4SeQXkxdo+AbhyooUb3prFjOtxTomxArH2oByQS8tRPrN0SySGx+SmBEi52OVkAHBYNoyUa6k08drupvrZHqEvZpcc5dbL7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV2PR10MB6115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 08:46:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 08:46:19 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,  Jaehoon Chung <jh80.chung@samsung.com>,  Peng Fan
 <peng.fan@nxp.com>,  Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
In-Reply-To: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org> (Marek
 Vasut's message of "Fri, 6 Sep 2024 19:10:42 +0200")
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
Date: Mon, 09 Sep 2024 10:46:21 +0200
Message-ID: <87wmjli59e.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV2PR10MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f12263-00be-487e-007e-08dcd0abdfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jD1320w0grPuRRlBdyS6Hst+JKWSCeXMzpLU6ITRJnykdhVEZ7WYvvD9LwTv?=
 =?us-ascii?Q?TfSnisW6e1j997X2SdrLlNRmRZDxInIp1SwT9xhPJDkhh1GApFoW7iQQYiv7?=
 =?us-ascii?Q?uumS/XncQZbHBJQENC8yHcl/jcaH/lrgTsTS3JuJFFEXnX6/xz1u+XD0DTxR?=
 =?us-ascii?Q?m/MGeZuHR1YwGqWlNnfqv4j+XpwstVkI3aP9HNFxFLJG+e/ZLzzmUdq4KKo2?=
 =?us-ascii?Q?y79F81ClWXA7leSRILUQgXbtUJHBfsbS4CM6kWmHTg4EF61I6xtglX6Lqmy0?=
 =?us-ascii?Q?NkjMrmSJPUuZ8utsHnfELrKoxifB10ufGLN2EvXonCsIJNxnEpmAi1EmIaBC?=
 =?us-ascii?Q?HM6up8JeHSpCMEDpJ2Z3KlPjeNQ702kL16OA4PZOI8dj1uii6PVxBMAiVEqg?=
 =?us-ascii?Q?xHJidvvYk9P+e9TPYSYpOSyxmSFRWM2sOpstJ/ZO9iGVYNgf9zMrO2ZxEPRC?=
 =?us-ascii?Q?eCRwj+1nDy4gXmwCRxmS0c6YHx8eGnnDESuQRNz3VziMgEtRG8RzXwmAVARH?=
 =?us-ascii?Q?AjcBtX1yQIggZeP0oLXsQrH02e4gGPijC0Eks9hSa+r3mg3RbjYQ1gnJ0yHC?=
 =?us-ascii?Q?CVFJjS0osy5jYvyMfXJJgbBwplWgX9Ma25rGmcFjKyV0jnU3VCdb3ylIZDXJ?=
 =?us-ascii?Q?dYL4KZkYM7cZHI7KoStr0ov/ze2gKN68PR9IPB/8rMK6aloO6+HPOG4ZpfBJ?=
 =?us-ascii?Q?BSA4IfskmgkyUvNedpb0zm9XjIlAGG9hwfOBLa5DjU3cBR7n+COTOGRVJjG2?=
 =?us-ascii?Q?D51MEJxLOqHc9hqTAC5kdHxEIzEOgTvZxjG6wg5gDg5mFFKM89q9wjd7WGZH?=
 =?us-ascii?Q?iBSSaQqbu3jvXag3Colh+O2hGdeQu20Pn/RViGOfomAS8YgJ4d0Iw9tooX26?=
 =?us-ascii?Q?+BdHxWGOl0LyaB/N3y0YK+Cnw3X51PjqbUqLjOcn88c+u+YTKdqbOSwmgucM?=
 =?us-ascii?Q?OSLW+mRFbNgiklhLgOk9Xo2R1c8ccTh5z7o8+GxFP1IE53oiXcNv+hZTHt+v?=
 =?us-ascii?Q?FzpGUMYdolAUNv2aBgDdMLCof3hEv0uzxz66owy9M1zrv3geH/pSBZdYDgSC?=
 =?us-ascii?Q?czlajkYfrHs5imhod7jpRWn46mnKzcTv483BSgYQ1PjFnGyK++7cxQpk/e3l?=
 =?us-ascii?Q?J+qx3671AuOZnAMe8JukXffrEd0DGAwh8IRtA3PZGh42zKJ1k7zrc1hWNt6r?=
 =?us-ascii?Q?n8sEfkk6ls/pqBMvU0aCPG+LCL77aS75JO3/oaM60fhkvOT6QBdc+xxT16Uj?=
 =?us-ascii?Q?UqGgQ8iWlmExOC2OCFRTFJWx4dIt18bWXkAqLGzaaBmCWZ+u1WfXGYT10H8o?=
 =?us-ascii?Q?FZrzSpsqa7t4rus/I/97MksS4fYa6/AbxnaKfNHaxTSdl/2D9xlYFSVS2u18?=
 =?us-ascii?Q?XaUESQOsLTlxp0geLBKSeqnO3WryIOEqzZr0wUJrR3lMjeHpUg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7HiIxGgYiM9Y+zU9Bd0vyPtfuQSVxu6mx6K3wHHCs5F3nEaBaUzz34uyglRg?=
 =?us-ascii?Q?7hBOXNgHk54spYzmxRLnfSsQZfQyVBxeAARu5NqGcMFLW0FpY+5PuCwFURqL?=
 =?us-ascii?Q?Nzyrv1alGeQkiRjErhLoBEOTkGR7MOrV4eUIMHvA913vzJIkx+rQgAiODidC?=
 =?us-ascii?Q?HB4mqvAiI6cv+ZqcGtusNscToezCEfqBYl60jg+NCorvFwJE/Oz9ps2ucSmw?=
 =?us-ascii?Q?VNRn7nS1QKzZX9AHILmiVF2YXA0WQHeKlbHYNMDTjaoQ7i4n54YhaZYaTTUe?=
 =?us-ascii?Q?VAFbB+KehRMJ1wN/Bd2uSm0tOB9TUoBjKc2AUSfGiadzjby8g81S3j9g4S7U?=
 =?us-ascii?Q?/yBKxQwT/MYqVX6yKTqbJVpclwUYcnA+g0Xq0/4/3pnSSu1E1Ul3jt8lMLpZ?=
 =?us-ascii?Q?FWLrDmBRMmmbw0Ws4IzVdUJ9V+assJlm+taycDzwijihQDbEDfO/yziVWdGa?=
 =?us-ascii?Q?smdvfHZhuJTqG7XQOTdaeIBI+R4fzD6oARLvnRlQMeyylDQ2LyrOPHe9V6j4?=
 =?us-ascii?Q?9B62d6yeqNs/NcJkxpR9z968RAnyng6xzBXLTqCGqhoV9CKN7SzTZTogRVgO?=
 =?us-ascii?Q?ix4umEou9o3Xf8/JQ/FA4P1p8YIsbuVpR583mzwS25e4UNaoyhHgRfEyBiMw?=
 =?us-ascii?Q?vR3b1EYSHwZobGcmeNM6Lu+283z7O+HK0loWyiuYqjgHss4OBWYAOQOZ8h5/?=
 =?us-ascii?Q?zi3OfuXI70PUiLS/eMymFxCv6F0VEmdFae6Y14qlnRbZ5Wxp9I1MGvor+TVQ?=
 =?us-ascii?Q?Zr2wPAoGFJG+EgB7T6+GlcPDLsAa17igf1dqzs/hWgEIDepER+sSyeKRUN1n?=
 =?us-ascii?Q?SfGJ1pk4/pyG+CQ4AbV0vofT+0QAPUIqxaP70vLwv0gs2hDZoaJQ4luGy5aX?=
 =?us-ascii?Q?b6abyinkgUk6LgTRHzBpR9YX0f49B9DVCdKxm7nBJG5PNtK3QBxq6krnLwZ3?=
 =?us-ascii?Q?pj7KtkV1CMKLQSL8HU6mrLRM5kFYmP9Yr3fXpMG5cuJWAbXu/SA4nKVMaVfn?=
 =?us-ascii?Q?KwJRZjhVUVjrz5nA8eIAIiVglW3NQE49K+AWpRReCELx8N8rnwQV9rx62ZKv?=
 =?us-ascii?Q?+rjXVO1NEU6ePFUvQuRLQZ3NkBJV1C5m8ZgAlqb5cBDqfDAhYND8eQwB+y/q?=
 =?us-ascii?Q?KUgwVlxWpo2LjFviQdK/rHc/zd7qedP0ShW+MrgvK9vekuBJDoVL1CJEZNnw?=
 =?us-ascii?Q?0t7zjLu0eJQhVw7dmJmMTykkhQ3wfN5Gf3NEG3lFbH/SWycK3rHwyVVqplmc?=
 =?us-ascii?Q?5LHUQqtu77aoku5/v7jJA5DbtSWJwIa4vZ0tiRYz4UUPpMzKpyOZ5jPHPism?=
 =?us-ascii?Q?FMC/PHp/tXyGH9OPBjooBtiSErW0J3bdz0ohL5c1VoM6pXt7SB8S0dkxz16O?=
 =?us-ascii?Q?S4NOzzXn861yF1vv4RU+1F4oHJYSS/fas+50jIGDnU8yutl3pYuBRt4jIkjn?=
 =?us-ascii?Q?KtWOuvG2ayvGWe5j1djktBNo7FGkNggBwQc2PKGTmHj8UmtMopgtuJVGhjyB?=
 =?us-ascii?Q?UvSoeZs78W5kygLCVbwCSA1/pfBS64d/NV2VTMseR6h4PpOOdQlM9/EsbpT/?=
 =?us-ascii?Q?UAxIfdP+hgk2hpIb8QXHrHC6S9TQHCXsc7KPSU8M7dE1iSfxbIPq/fh8LLif?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f12263-00be-487e-007e-08dcd0abdfd2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 08:46:19.4939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mz16t3OU9kjiaZuzrxkjAIpe3ZcFlwn8Gu/twKVXjJ/V5a7iXpV3yVuIVTKHctbYk3E/EK9h52BSJWmjGLcGqcPf4Gp00clSTWK15cXl4q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6115
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

Marek Vasut <marek.vasut+renesas@mailbox.org> writes:

> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: Move the cyclic registration/unregistration into mmc init/deinit
> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>     does not work with structure members
> V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
> V5: Rebase on u-boot/next
> V6: Rebase on u-boot/next
> ---
>  drivers/mmc/mmc.c | 25 +++++++++++++++++++++++++
>  include/mmc.h     |  3 +++
>  2 files changed, 28 insertions(+)
>

[rearranging hunks for easier reading]

> diff --git a/include/mmc.h b/include/mmc.h
> index f508cd15700..0044ff8bef7 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -14,6 +14,7 @@
>  #include <linux/sizes.h>
>  #include <linux/compiler.h>
>  #include <linux/dma-direction.h>
> +#include <cyclic.h>
>  #include <part.h>
>  
>  struct bd_info;
> @@ -757,6 +758,8 @@ struct mmc {
>  	bool hs400_tuning:1;
>  
>  	enum bus_mode user_speed_mode; /* input speed mode from user */
> +
> +	CONFIG_IS_ENABLED(CYCLIC, (struct cyclic_info cyclic));


I think that you can simplify this quite a lot by dropping all of the
the CONFIG_IS_ENABLED stuff. If CYCLIC is not enabled, struct
cyclic_info is an empty struct, so takes up no space, but it still
exists in struct mmc, allowing it to be referenced in C code that need
not be guarded.

>  };
>  
>  #if CONFIG_IS_ENABLED(DM_MMC)

> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 0b881f11b4a..c787ff6bc49 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -3039,6 +3039,20 @@ static int mmc_complete_init(struct mmc *mmc)
>  	return err;
>  }
>  
> +static void __maybe_unused mmc_cyclic_cd_poll(struct cyclic_info *c)
> +{

You can drop __maybe_unused.

> +	struct mmc *m = CONFIG_IS_ENABLED(CYCLIC, (container_of(c, struct mmc, cyclic)), (NULL));
> +

No need for the CONFIG_IS_ENABLED(), container_of works just fine when
the cyclic member exists unconditionally.

> +	if (!m->has_init)
> +		return;
> +

(I'd assume that in the !CYCLIC case the compiler might warn about this
unconditional NULL deref; that you avoid with the above.)

> +	if (mmc_getcd(m))
> +		return;
> +
> +	mmc_deinit(m);
> +	m->has_init = 0;
> +}
> +
>  int mmc_init(struct mmc *mmc)
>  {
>  	int err = 0;
> @@ -3061,6 +3075,14 @@ int mmc_init(struct mmc *mmc)
>  	if (err)
>  		pr_info("%s: %d, time %lu\n", __func__, err, get_timer(start));
>  
> +	if (CONFIG_IS_ENABLED(CYCLIC, (!mmc->cyclic.func), (NULL))) {
> +		/* Register cyclic function for card detect polling */
> +		CONFIG_IS_ENABLED(CYCLIC, (cyclic_register(&mmc->cyclic,
> +							   mmc_cyclic_cd_poll,
> +							   100 * 1000,
> +							   mmc->cfg->name)));
> +	}
> +

No need for any of the CONFIG_IS_ENABLED nesting. Just do
cyclic_register() - that's a no-op when !CYCLIC, and the compiler will
see the reference to mmc_cyclic_cd_poll, so not warn about it being
unused, yet also see that it is not actually called, so elide it from
the compiled code.

>  	return err;
>  }
>  
> @@ -3068,6 +3090,9 @@ int mmc_deinit(struct mmc *mmc)
>  {
>  	u32 caps_filtered;
>  
> +	if (CONFIG_IS_ENABLED(CYCLIC, (mmc->cyclic.func), (NULL)))
> +		CONFIG_IS_ENABLED(CYCLIC, (cyclic_unregister(&mmc->cyclic)));
> +

Again, just do cyclic_unregister() unconditionally.

Rasmus
