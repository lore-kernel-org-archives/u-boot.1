Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AA8C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 13:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA88E80BAD;
	Wed, 12 Feb 2025 14:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CB8FBoyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B82180BAE; Wed, 12 Feb 2025 14:38:03 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E0F8043C
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5deb1b8e1bcso1178587a12.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 05:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739367479; x=1739972279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bfm7SFFIl5h1bex7nbIl560kdZJdDyfjVtyknKzi4so=;
 b=CB8FBoyhdrScDtvbQYgO6IvLH551Y10e9lcRvD24s/02/nsFxrZc8cMCj45zSIYTdY
 JtW7tQLy0ugr6FKOXkMYu3K8I4yPDp8WvO3Cbivx45SdeyxFY8bMWCI9brWX/8nbRpi2
 02z0eSdSJPeeq6gWdHo49IAOijYpUC7PBtZO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739367479; x=1739972279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bfm7SFFIl5h1bex7nbIl560kdZJdDyfjVtyknKzi4so=;
 b=dJDKE2vNFFihSg712M9Tj4Ffjtb7xo5ilateZI3MYahSTYh+xthua9gvx+157hKFdU
 wrpKQmc18FJUTLR1yS2x+rM2OribwkjgFhaYXeFRidfS9Ku91gUD8t4tRtkyy4Aoc3zv
 gMNylKIspv+azLBg2stQQNvBaAL92ioGys5qUG5PciUYdVlRyZ+kspnIBJgO4FCCqB7P
 R3VJ5OHTS36WEuoK+t5wy+D8/TBYN5n0ZLTb0T0BAkTw2cT8lNJJJEIKWXgGU6umPMWR
 eCZofQwL7TnFcx4nSuOVbse4JKw66p8JXfqXvUkByCPLF4o/FW4ELSkGL8sDSa4N2Tu7
 k85w==
X-Gm-Message-State: AOJu0YxVD3QPLAIPCvOqxS5CMPzU8Au913E5JS4pnlL62sc3/4R3+Bx/
 g3Vi+/nwyU2156LUCb41j6o1BzZT0mYa1neFeHncvd1Y7RT/9ZBzVQYsKYj+HTBxrOpftJ2TP1/
 XzNRff0O3pcsb0IldG464JuH4T0F3NDzRYX3r
X-Gm-Gg: ASbGncu1g0uFO1i4/sjqGhi6c+3gs5zWbC2B3QRJDSeZP2/fMw8PgbwAAsWxNK8wh7z
 PWbdXZbS/lGKgi854PRRKluZSpCDfQgAXIWg3shOXAvJLxKu3zhASlmK0ITVEBVUG41TyobXqBQ
 JxzYB/3bGn+EKbp/avCIEIaNE3rwhngw==
X-Google-Smtp-Source: AGHT+IEwTqS3QoijXngS6aes3ghTCwLdlaR3VImSlQ4ebTeR7ST2htqgoBxu1RUQ+MA7KS36SWF1cDz7AKiLd+Q4K70=
X-Received: by 2002:a05:6402:1ec9:b0:5dc:ea35:8eae with SMTP id
 4fb4d7f45d1cf-5deadd9d3a7mr2964651a12.17.1739367479420; Wed, 12 Feb 2025
 05:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-3-m-shah@ti.com>
In-Reply-To: <20250212091820.213895-3-m-shah@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Feb 2025 06:37:47 -0700
X-Gm-Features: AWEUYZmvrJ9uNJGupz_Xt9h0n9HD2u7HTqHXDLxCFmwNVrbk7osokenVq1r9cqg
Message-ID: <CAFLszTiktZ8q54vD2Eswg2zvz2NJNZZnZgZeM91_Jcr5q-7nPg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2 v1] drivers: core: lists.c: Bind drivers using
 bootph* property in subnodes
To: Moteen Shah <m-shah@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, m-chawdhry@ti.com, 
 n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
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

Hi Moteen,

On Wed, 12 Feb 2025 at 02:18, Moteen Shah <m-shah@ti.com> wrote:
>
> Add a function to scan through all the subnodes of a given node
> recusively for bootph* property. If found, propagate it to all
> of its parent node up the hierarchy so as to bind the respective
> drivers of the nodes in the pre-relocation stage.
>
> The current model skips the node if there is no bootph* found in
> it, even if the property is present in one of the subnodes. The
> issue is tracked in [0].
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
>
> References:
> [0] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/21
>
> ---
>  drivers/core/lists.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index c7be504b6fc..5be556ea951 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -17,6 +17,7 @@
>  #include <dm/platdata.h>
>  #include <dm/uclass.h>
>  #include <dm/util.h>
> +#include <fdt_support.h>
>  #include <fdtdec.h>
>  #include <linux/compiler.h>
>
> @@ -196,6 +197,80 @@ static int driver_check_compatible(const struct udevice_id *of_match,
>         return -ENOENT;
>  }
>
> +/**
> + * scan_and_prop_bootph() - Check if a driver matches a compatible string
> + *
> + * @param of_node:     Parent node for child traversal
> + * @param fdt: Blob to use

We stopped using @param, so just @of_node now

Document return

> + */
> +static int scan_and_prop_bootph(ofnode node, void *fdt)
> +{
> +       static int bootph_index = -1;
> +       static const char * const bootph_props[] = {
> +               "bootph-all",
> +               "bootph-some-ram",
> +               "bootph-pre-ram",
> +               "bootph-pre-sram",

Since this is pre-relocation, you should only need the first two. But
there is ofnode_pre_reloc() which you can call.

BTW ofnode_pre_reloc() has the checks you have here. I'm not sure if
this code can be dropped?:

/*
* In regular builds individual spl and tpl handling both
* count as handled pre-relocation for later second init.
*/
if (ofnode_read_bool(node, "bootph-pre-ram") ||
    ofnode_read_bool(node, "bootph-pre-sram"))
return gd->flags & GD_FLG_RELOC;


> +       };
> +       int offset;
> +       int ret = -ENOENT;
> +       ofnode subnode;
> +
> +       /* Note the index where bootph-* was found and return success */
> +       for (int i = 0; i < ARRAY_SIZE(bootph_props); i++) {
> +               if (ofnode_read_bool(node, bootph_props[i])) {
> +                       bootph_index = i;
> +                       return 0;
> +               }
> +       }
> +
> +       ofnode_for_each_subnode(subnode, node) {
> +               if (!ofnode_valid(subnode))
> +                       continue;
> +
> +               ret = scan_and_prop_bootph(subnode, fdt);
> +               if (ret != -ENOENT && ret)
> +                       return ret;
> +
> +               /*
> +                * Break the search if bootph-* is found in any of the subnodes.
> +                * Breaking the loop early helps in avoiding unnecessary traversal
> +                * of the sibling node given that bootph-* has been found in previous
> +                * sibling node.
> +                */
> +               if (!ret)
> +                       break;
> +       }
> +
> +       /* If no bootph-* found then return no such entry */
> +       if (ret)
> +               return -ENOENT;
> +
> +       if (bootph_index != -1) {
> +               offset = ofnode_to_offset(node);
> +               if (offset < 0) {
> +                       log_err("Failed to get offset %d\n", offset);
> +                       return -EINVAL;
> +               }
> +
> +               ret = fdt_increase_size(fdt, 32);
> +               if (ret) {
> +                       log_err("Cannot increase FDT size!\n");
> +                       return ret;
> +               }
> +
> +               ret = fdt_setprop_empty(fdt, offset, bootph_props[bootph_index]);

I don't believe you need to actually add the property. It costs time
and I don't believe anything else will read it. You should just need
to return a value indicating whether the tag was found.

> +               if (ret) {
> +                       log_err("Failed to add bootph prop to node:%s ret=%d\n",
> +                               ofnode_get_name(node), ret);
> +                       return ret;
> +               }
> +               bootph_index = -1;
> +       }
> +
> +       return ret;
> +}
> +
>  int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>                    struct driver *drv, bool pre_reloc_only)
>  {
> @@ -205,6 +280,7 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>         struct driver *entry;
>         struct udevice *dev;
>         bool found = false;
> +       void *fdt = (void *)gd->fdt_blob;

Could you drop this var? I am hoping you don't need to change the devicetree.

>         const char *name, *compat_list, *compat;
>         int compat_length, i;
>         int result = 0;
> @@ -256,8 +332,16 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>                 if (pre_reloc_only) {
>                         if (!ofnode_pre_reloc(node) &&
>                             !(entry->flags & DM_FLAG_PRE_RELOC)) {
> -                               log_debug("Skipping device pre-relocation\n");
> -                               return 0;
> +                               if (IS_ENABLED(CONFIG_BIND_FROM_CHILD_BOOTPH)) {
> +                                       ret = scan_and_prop_bootph(node, fdt);
> +                                       if (ret) {
> +                                               log_debug("Skipping device pre-relocation\n");
> +                                               return 0;
> +                                       }
> +                               } else {
> +                                       log_debug("Skipping device pre-relocation\n");
> +                                       return 0;
> +                               }

Can you either use a bool or combine the statements so there is only
one log_debug() ?

if (!IS_ENABLED(CONFIG_BIND_FROM_CHILD_BOOTPH) ||
   scan_and_prop_bootph(node, fdt)) {
     log_debug...

>                         }
>                 }
>
> --
> 2.34.1
>

Please also add a test for this, probably to test/dm/test-fdt.c

Did you look at doing this in Binman?

Regards,
Simon
