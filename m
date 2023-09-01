Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98839CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200358669D;
	Fri,  1 Sep 2023 08:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="f82udiJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994E38669D; Fri,  1 Sep 2023 08:16:59 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0975805C5
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693549011; x=1694153811; i=xypron.glpk@gmx.de;
 bh=jI0CnpWYYOtpxjZL6ojL5UBUl2jeeXiokzq+5vcf3PM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=f82udiJpdbEzoFhCoSwfnjfiPg0maeHCBb6RDz8BeKPDnTI3O1viSPuQnqbdUi4hszvpido
 fWJToLoumHQRSs/bhprYkTrXMs/TCiV2A+RClZXfXPnyJVdjfxpIG0H0lu6lmFDAkXZfu/5Q/
 owVL2g6RnaTxa4uba8wLLGZx0RaZYqTXpPyecQu33LkNtDN5tHJ1r1+2G6yR3r6/kAtXexhgl
 /Sl9DW4StMp94jnk8xU+VACqG0v0jPpSgmkqYP+UXO+cYtIG/0NQmH8FQiEiEv1hnbuqairns
 v5tuOPE5yA/SxevOtVRuVzUlz/7EZEhhVMSBoDWRN3MZzycSjJLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1pnZnd3pTH-00u0f6; Fri, 01
 Sep 2023 08:16:51 +0200
Message-ID: <94edeb15-f260-4c88-9527-e58065a470f0@gmx.de>
Date: Fri, 1 Sep 2023 08:17:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] lmb: Rename interior piece to area
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230901011357.2482203-1-sjg@chromium.org>
 <20230901011357.2482203-3-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230901011357.2482203-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WBPXhcCOe1QaeBKZ2l234z3OJ/yqc5cYzimfOF9Z//sNDXN/OSf
 gOSa/8hHA9lhVHHCZ7dBFlKpEKEcXxjKAHttv8I6EXzAlQrtIiGbfzzunkGk9VMBLVOU+vP
 rfUmMsMuzsAbFHdESA22Jjaz9biwwTBV0wI2BXtArDyhJTDXnyCjzKcVtdJ2zXE8ZmKvJQt
 wekHBw/XhxGA0zF3xifuw==
UI-OutboundReport: notjunk:1;M01:P0:CXMmNT9tHc0=;3Bw1bE9YenNBZsTJW+6ShAHXMCr
 QBb7QRYA/3MY1bDpp1gSGyk0dNssROcWMGU7x9P99AgszbiUMqG1gnnHWB9d6KZJ57cWFMymD
 uQK163RJu3KnJvSSvtnPjbFE8EdEgtdBfvVGg4dXpUbsGuwaLwONfcNqFXNLeiibWlOz95Iuu
 6Aypa+xCeKAo6TxashLjsdTdhquJYr+R5d50/6r8bRY2i+iEcg+ktS19UshFou+IlIwy4JYEf
 0W60uTnbO/FIr2KpK5uTCjB/U8ZyfsiVd63omLJrmfR4HyN4yIHDZSsvP8724ne+lh+OVKkPx
 wxr53RKfbpSYIo/gFFF0Z+7aDCFU9LZbba96KImKytcLtNVtlxEgZCLM590ZXjuk9tcbjB/t1
 XUSyS1kYyjzJMINuUDaeJMkDW4p9xTEoh3m5YeJGUIOT1OO4FkAvPaOW3N65gPPWVHcBNQtmr
 i1sqgqUb2+kUrTigIPdeIRhvyL6q/I9KFRPWvcGHxKcOBNwhKzMxRE5Cqkf5YWQPvmrkcdWNj
 qpkY3dQeimBQc6HiuBOX7KhjiQ/eNRyoH0vtKAtKWrsDsT3S8MxCveBRYo4DSYKuwMOFJGpVT
 cDVTlO1MJVRr4UF8whcnhRBM8xZOkKjSZytjvzv9fSJKuojsGVBEcmdMnofFPZPM86LVcpa93
 NJ5OeL5P/yhYajvASWg20tQHyr4XNWcBQnEfUkTT2FC43YiDYyJJPF3IgmENiyu8Y7I2mf+IB
 KvxsVB1IW5lqI36QZeLIyeNNe7hzjpegVh/pwlbD6jy4sCXMzU5CGgv1G6/XmmXdhN6bNom7m
 0U9zWa/CKFgja7yZ6p16Lk+5nMgmW/N4Z9jLBreQGOVWtXRzXk1j3C3rvXG7IHVbp9FDDgNsd
 P3oGtf3NU+NJTyU+vmsP2lLX7VraJrAnx+a7L+AJGf6CzCJvR+i31/FG6Ha35bjzcP7bmpv67
 ti/qubYWsXs8/b0fqeuBYhIxmqA=
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

On 9/1/23 03:13, Simon Glass wrote:
> The lmb data structures use the word 'region' to describe the region in
> which the allocations happen, as well as the individual allocations in
> that region. The interior structure is called lmb_property but is
> described as a region.
>
> This is quite confusing. One of the reviewers in v1 asked why we are usi=
ng
> a property to describe a region!

We currently have:

struct lmb_region - Description of a set of region.
struct lmb_property - Description of one region.

The word 'region' implies that it is contiguous, while 'region set'
implies that its members might not be contiguous.

Calling a set region is what starts the confusion.

Your patch is creating new confusion by calling a member of "a set of
regions" "area".

Please, rename as follows:

lmb_region -> lmb_region_set
lmb_property -> lmb_region

The comments below are only valid if you stick with area which I
strongly discourage.

>
> It seems better to adopt the word 'area' for the internal pieces, since =
an
> area is smaller than a region.
>
> As a first step to improve this, rename struct lmb_property to lmb_area.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>   include/lmb.h  | 12 ++++++------
>   test/lib/lmb.c |  2 +-
>   2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 231b68b27d91..4b7664f22c1d 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -23,13 +23,13 @@ enum lmb_flags {
>   };
>
>   /**
> - * struct lmb_property - Description of one region.
> + * struct lmb_area - Description of one region.

%s/region/memory area/

For struct lmb_area we need a long text explaining what it describes.

>    *
>    * @base:	Base address of the region.
>    * @size:	Size of the region
>    * @flags:	memory region attributes
>    */
> -struct lmb_property {
> +struct lmb_area {
>   	phys_addr_t base;
>   	phys_size_t size;
>   	enum lmb_flags flags;
> @@ -64,9 +64,9 @@ struct lmb_region {
>   	unsigned long cnt;
>   	unsigned long max;
>   #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)

%s/MAX_REGIONS/MAX_AREAS/

> -	struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
> +	struct lmb_area region[CONFIG_LMB_MAX_REGIONS];

This is really confusing: An area called region and indexed by something
related to regions not areas.

>   #else
> -	struct lmb_property *region;
> +	struct lmb_area *region;

ditto

Best regards

Heinrich

>   #endif
>   };
>
> @@ -87,8 +87,8 @@ struct lmb {
>   	struct lmb_region memory;
>   	struct lmb_region reserved;
>   #if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> -	struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> -	struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> +	struct lmb_area memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> +	struct lmb_area reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
>   #endif
>   };
>
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index 162887503588..59b140fde4ce 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -12,7 +12,7 @@
>   #include <test/test.h>
>   #include <test/ut.h>
>
> -static inline bool lmb_is_nomap(struct lmb_property *m)
> +static inline bool lmb_is_nomap(struct lmb_area *m)
>   {
>   	return m->flags & LMB_NOMAP;
>   }

