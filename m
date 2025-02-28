Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE72C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 06:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9C58083E;
	Fri, 28 Feb 2025 07:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QJ5O+AQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754EC808B6; Fri, 28 Feb 2025 07:08:40 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FCF3801FB
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 07:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so1421576276.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 22:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740722916; x=1741327716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=737rVt/eHGBKxkLWis48FbjDe9JPbGUdhkW5AYwcGrU=;
 b=QJ5O+AQGBBmHkop5lFNj9dk3RzSpNMdtJ0UsXV++lIWyireGAfslLIh2lTPS6yvl0d
 uy0IcsZALztEjA5iltDQeR8kSMKhcmYvp3mkLtOAAG9xoJXOsePYVPNTH57oqpW44Ial
 Ku6oT4cxcO1wJGqUczvsOn27OrNTuc07BKBE8HiwouwDO1z1/wly6eUnlV9JDjkP+d/M
 HPjP17cjC/jrN15+rfxk2OIK2ak25wDxQz0Iu1iRGSf+eWuWORd49ro8vrykPIs5e14x
 WWCXSWbBfvz82GoEwazOHUqSPTD/NVrp3Se8qlgJ2ozH/EoJwZzadPyp67GvkpLDWOBt
 cq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740722916; x=1741327716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=737rVt/eHGBKxkLWis48FbjDe9JPbGUdhkW5AYwcGrU=;
 b=Mow6UlXrrW6ZDnjjd2BMelBRURQ7oByNO+tMiad/8q62eM5mlxCFNGNdjaCjBtiRrs
 aYVXi0VGE2aUslQYyemW0ovBJttLhGcQcOgWGSiuXUsSqXHALCQy9S5dXMc3RjRZ7Y2w
 6YYdvWIxU9TpZKFLiCbdOKrcEcO8uBOv8nR6AVtpSvTe7InKuWdHSBVHXv+vMWEYhxcj
 MPvvA2eUYw/fEoe7V78/c0dQSlw5IhA83rpbXRNmoCSM9FooLcEtJeSwrEtNjdCFiBFK
 Lvh96sUP9Gevi6aR6XunKgOjRJzv9z+dA2Rryph5sqsCxrEDOlekMT1vtJp6MjO90iwU
 VVQg==
X-Gm-Message-State: AOJu0YxWZidHafDL3WJ3Uxxkea+ZYQliF0omcIAXeGDM0bP1iapStH2g
 MiyvZAAsaXsayk/IhH0WicB7piG1ImgBtqxjsG5TF3baVF1rmtvkXjB5fuezRmLig5Gy/5pxayg
 2nqil4+5qGGunQy1GtquQCeN8qflCghjgPbQSwg==
X-Gm-Gg: ASbGncvImH3i6YJnzewgisvpqxNWYlSS9vZ2dzrw+aK2rbcqMYjpaGr5BvOVVTZUucb
 g4DqIOC98oU7yk9YQE47OJdIpG0ntt+GNiuLvqZpcVb0ospSo1r6qWKNmPo92GiVRM+pMmxBEI3
 JLgFzHSCKuaTsoqbtgjig+T7y5wN8=
X-Google-Smtp-Source: AGHT+IEy7fzrXhb+ILfiJ6/3xSRDSpwvoBNkree/nuDXIJL32sQb6TZNcUpS175MCMlTP9R4FeKo5688kOrB5zjgnIE=
X-Received: by 2002:a05:6902:cc6:b0:e58:305f:440b with SMTP id
 3f1490d57ef6-e60b2e8b5b9mr1942040276.7.1740722916214; Thu, 27 Feb 2025
 22:08:36 -0800 (PST)
MIME-Version: 1.0
References: <20250227111519.45787-1-sughosh.ganu@linaro.org>
 <20250227111519.45787-5-sughosh.ganu@linaro.org>
In-Reply-To: <20250227111519.45787-5-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 08:08:00 +0200
X-Gm-Features: AQ5f1JoEYdfXVOOHZPgPqXDg2UwPVpdvjMEFqO0oAFa13uFsbgnc7lprm48L8DQ
Message-ID: <CAC_iWjJr1-REwjREusspUq=dY6inxJPoOX=HGDxFUWzF7+33hA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] blkmap: store type of blkmap slice in
 corresponding structure
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 27 Feb 2025 at 13:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add information about the type of blkmap slice as an attribute in the
> corresponding slice structure. Put information in the blkmap slice
> structure to identify if it is associated with a memory or linear
> mapped device. Which can then be used to take specific action based on
> the type of the blkmap slice.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V4:
> * Use BIT() based macros instead of enum
> * Change the name of the field from type to attr as it would contain
>   attributes other than the type of the slice
>
>  drivers/block/blkmap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 34eed1380dc..453510cca62 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -16,6 +16,10 @@
>
>  struct blkmap;
>
> +/* Attributes of blkmap slice */
> +#define BLKMAP_SLICE_LINEAR    BIT(0)
> +#define BLKMAP_SLICE_MEM       BIT(1)
> +
>  /**
>   * struct blkmap_slice - Region mapped to a blkmap
>   *
> @@ -25,12 +29,14 @@ struct blkmap;
>   * @node: List node used to associate this slice with a blkmap
>   * @blknr: Start block number of the mapping
>   * @blkcnt: Number of blocks covered by this mapping
> + * @attr: Attributes of blkmap slice
>   */
>  struct blkmap_slice {
>         struct list_head node;
>
>         lbaint_t blknr;
>         lbaint_t blkcnt;
> +       uint     attr;
>
>         /**
>          * @read: - Read from slice
> @@ -169,6 +175,7 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                 .slice = {
>                         .blknr = blknr,
>                         .blkcnt = blkcnt,
> +                       .attr = BLKMAP_SLICE_LINEAR,
>
>                         .read = blkmap_linear_read,
>                         .write = blkmap_linear_write,
> @@ -248,6 +255,7 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>                 .slice = {
>                         .blknr = blknr,
>                         .blkcnt = blkcnt,
> +                       .attr = BLKMAP_SLICE_MEM,
>
>                         .read = blkmap_mem_read,
>                         .write = blkmap_mem_write,
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
