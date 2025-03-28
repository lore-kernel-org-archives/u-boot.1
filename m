Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC16EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EF4805C8;
	Sat, 29 Mar 2025 00:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aygLIj28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29F7581DCD; Sat, 29 Mar 2025 00:47:56 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04E980079
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so395202166b.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205673; x=1743810473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=snZcye+AbgbJB700QLQjMATINs4iwBKAj1SwA+HlvFo=;
 b=aygLIj28VM4LM7vZw49eqQJkBu3MBIpIxdMamGP9TNu19pUcj/PgMkvqSxSKOsrEjU
 IusZ9ipCX1tiLpn3rBsnvMxWmh2h2hwMSG5+bJcn2Ut4mqRVnWHY+GSqVhW19e3EzPjX
 Em4MjOCDWKYXJNTE1Hj3JbnwJmRa6gHTpuqq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205673; x=1743810473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=snZcye+AbgbJB700QLQjMATINs4iwBKAj1SwA+HlvFo=;
 b=dogYO+8JpKrqqP0MSmeViCje0ATN+3zQk7crPc0VL4pWoaMxbiVB6EKjTsoQxE3abP
 R1ri9ewnEuAbaGq1C7HQWc0IHQcwNW07OSVY65DzWF1cGbTFdkt7khZSprYJfgNM4nBd
 xTnaWN5I4gIBdSRgspf9kKTbTrT9quHSlrXlni+sjgwMgpzKUNGGW9mnoolgQWWBgWjB
 SDp5f0BnevxMf0BuKSoB5IwGag7G0OF7MVUKRc3FVuHvrI0b+kL2eDPyCXfGgsPEcXHr
 pBfnVtDmJ9NjJR9IkdhvtzAcec4vEQ1TABYypWfMQoFEhh/7MJ6aJp39ctWlVLkXV0hB
 aPOw==
X-Gm-Message-State: AOJu0YzR5/nzWVP4leoLs6T57heVOVwOI+qZtfrZwVETiU/4g6htJOUl
 WCCBGxH6/hhpbuccdu6z8tMU2LcIDzlhcQ4Ge6UyDSWyst8URWtSlKH+tlh3RO/eHA5QYcuZLSc
 petzSjd5apJzi3KN08UvwYrwNtYGLsIorPMH7
X-Gm-Gg: ASbGnctbJ33mrKK4xtF+Wwl3Yv/O1abCMMiHQV18nrvk2Dzo4mFPcxKvp2+vb2BuStM
 SlNA2SsqailOAf0Sw/ZXJ+aEKsguE8Qr9L5F3u3Kfw5zrx9AvjdxLcwGFPOQ7i9CIsQyyfdElp+
 Knnf7uRfvlrGkPIw7IdCICET6g3xU=
X-Google-Smtp-Source: AGHT+IHHwjDmCamra3aK1Uan1SNiAhyX+ErCgt9QjGvK+jyUqvliMurN0rUMRwKEGATznrTTZJ3y9La494QAA2aIB5c=
X-Received: by 2002:a17:907:72d1:b0:ac6:f6e2:7703 with SMTP id
 a640c23a62f3a-ac7389ea43bmr65087266b.8.1743205673262; Fri, 28 Mar 2025
 16:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
In-Reply-To: <20250327080642.2269856-2-m-shah@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:47:41 +0000
X-Gm-Features: AQ5f1JoJ0uElp1rQTXt4efKqL2QFzKTkdSYX5gWoxAnN6b4ftOXF-AjC5jHOfiQ
Message-ID: <CAFLszTjB+HuX68tmTrLP=gbbpzt0kJr22137cSLiedx6bh6PVw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 quentin.schulz@cherry.de, m-chawdhry@ti.com, n-francis@ti.com, 
 vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
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

On Thu, 27 Mar 2025 at 08:06, Moteen Shah <m-shah@ti.com> wrote:
>
> Add a function to scan through all the nodes in the device-tree
> recusively for bootph-* property. If found, propagate it to all
> of its parent nodes up the hierarchy.
>
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/binman/control.py b/tools/binman/control.py
> index e73c598298c..e739949d366 100644
> --- a/tools/binman/control.py
> +++ b/tools/binman/control.py
> @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
>          if node.name.startswith('template'):
>              node.Delete()
>
> +def prop_bootph_to_parent(node, prop, dtb):

I think the 'prop_' is a bit confusing, since you are dealing with
properties! How about 'add_' as the prefix?

> +    """Propagates bootph-* property to all the parent
> +    nodes up the hierarchy

First line should be a summary

then blank line

then describe the args...you can see this if you look at a few other functions.

> +    """
> +    parent = node.parent
> +    if parent == None or parent.props.get(prop):

if not parent or ...

> +       return
> +
> +    while parent:
> +        parent.AddEmptyProp(prop, 0)
> +        parent = parent.parent
> +
> +def scan_and_prop_bootph(node, dtb):
> +    """Scan the device tree and set the bootph-* property if its present
> +    in subnode
> +
> +    This is used to set the bootph-* property in the parent node if a
> +    "bootph-*" property is found in any of the subnodes of the parent
> +    node.

comment style again

> +    """
> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']

From my understanding the only ones that matter are bootph-all and
bootph-some-ram, since the SPL ones are handled by fdtgrep.

> +
> +    for props in bootph_prop:

for prop

(since it is just one)

> +        if node.props.get(props):
> +            prop_bootph_to_parent(node, props, dtb)
> +
> +    for subnode in node.subnodes:
> +       scan_and_prop_bootph(subnode, dtb)
> +
>  def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
>      """Prepare the images to be processed and select the device tree
>
> @@ -563,7 +592,11 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
>          indir = []
>      dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
>      fname = tools.get_output_filename('u-boot.dtb.out')
> -    tools.write_file(fname, tools.read_file(dtb_fname))
> +    dtb = fdt.FdtScan(dtb_fname)
> +    scan_and_prop_bootph(dtb.GetRoot(), dtb)
> +    dtb.Sync(True)
> +    tools.write_file(dtb_fname, dtb.GetContents())
> +    tools.write_file(fname, dtb.GetContents())

You shouldn't write back to the file created by the build. Do you need this?

>      dtb = fdt.FdtScan(fname)
>
>      node = _FindBinmanNode(dtb)
> --
> 2.34.1
>

The code looks fine to me apart from the nits.

This addition needs a test - see ftest.py for some examples there. But
basically just create a dts that has some props in it, then check that
they got added.

I think testSimpleFitEncryptedData() could be a good example?

Regards,
Simon
