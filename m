Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714E0C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD563826AA;
	Sat, 10 May 2025 13:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Au4OuUiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B68D8283E; Sat, 10 May 2025 13:24:59 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3428A8210D
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:24:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fcac09313cso2259706a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876295; x=1747481095; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nZ1OiSKhRN3ypYebhtqcrj9BLimYRGHT73hwhHyG0jU=;
 b=Au4OuUiJJylZlwBqUG9gDfPbjWCfjruSv5q3jt7eWApqyW18Dm9ex28my8TAKN4ZVm
 vn13h0cV9VYYI+QnrK9eqIEiRHP6hueWpbeu6mPbE7WoQ6V97x7ArrQKdg8E8P2FyTue
 CvVn3PNIlexoQNIup/kZ3dgUGTgPXlzzNWQes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876295; x=1747481095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZ1OiSKhRN3ypYebhtqcrj9BLimYRGHT73hwhHyG0jU=;
 b=hSb287kfA0tCIAwzzgOcxBdIuESvWmQy5F9qUnxtQlIxKOr/ZLngnOFeUgd322Fyw+
 3LGEZLU6RmD8DLgXMVFGV1JqRh4nLUoqGrcdStLZWQt33+fZxQrT9m8q6TXmZ7LyDjDP
 ToleOsdfcyQZGEBVFnvofuuSZes6ZTiqoaSgZ2yQjwR4QrfUHlKP8T7/Ixkv2A/QsH3H
 fl0pRkQgbt5jP7MgKlJI+46hEWOktHVvSyG+g1rnj58kKdeRouadC5imUre0Q2INx+DU
 84OhXPF99tjtfQ4dxiEA9U+0U/tcZt/4H4xqUmkCEe0kAxTLOAfv732Wn/GCGPI2Jrbm
 eTQQ==
X-Gm-Message-State: AOJu0Yw8oo7bIk1RoHe3aARHD50Qn5sGH2/wzjd4TofGc9OOI0b8a4bK
 ipQGfHuvJprxa9iOFEgLx8N5EabbQ6zUtZBb0evTGR/z1I1ZhGFbawBDQhAXiKAgBjo5Tz7qghJ
 TlgJIHh2ZmdkwgAIcjwa0Yecnmy8x3dTVkP6bonv3Pphk8AaABm36vSC9Cw==
X-Gm-Gg: ASbGncuZ/rlmn9JQegWxw3Or5RU5/4B7Clrdf4+tNEXIswJDyw2ZVxAnD5Yy8HFFmvD
 1wfjc1I8tFxp7qB61gBkug3os7DxHJXnLCV0jD8UT3HWmly9wNa2dTIqAkKzDMLR8p2cUegAe5Z
 +lstVUcoFzWJCIxHZbMVHhBe/QNrtrLTIvFA==
X-Google-Smtp-Source: AGHT+IGwDZ+sHkaUkL89/0b5IY1cl+V9CTqoSgqwN1AyjyOM72eLH7SrppIUOWmdJUhWsaVxSXpkHbxFRtPaQzfEk54=
X-Received: by 2002:a17:907:9450:b0:ad2:40ee:5e29 with SMTP id
 a640c23a62f3a-ad240ee6075mr71186066b.10.1746876295341; Sat, 10 May 2025
 04:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250423123009.779628-1-sjg@chromium.org>
 <20250423123009.779628-3-sjg@chromium.org>
 <8e4b59f2-687a-4f02-a779-960c79b7de59@ti.com>
 <7a2231bb-0b87-42fa-a466-390004c93697@ti.com>
In-Reply-To: <7a2231bb-0b87-42fa-a466-390004c93697@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:24:43 +0200
X-Gm-Features: AX0GCFvN7AotABR53Sg35z2fG9rdJLDTP07uTCzr_SGq4smiTh5GhPQ3OmRCNn8
Message-ID: <CAFLszTgZFT8_orQqsDx33DTdsuc-JoaGrzXCbVB6yb9iwBnNoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] wip: binman: Move processing after templates
To: Moteen Shah <m-shah@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, 9 May 2025 at 08:10, Moteen Shah <m-shah@ti.com> wrote:
>
> Hey Simon,
> A gentle ping on this.
>
> Regards,
> Moteen
>
> On 28/04/25 16:53, Moteen Shah wrote:
> > Hey Simon,
> > Thanks for the suggestions and review.
> >
> > On 23/04/25 17:59, Simon Glass wrote:
> >> Do the bootph processing after templates are handled, since templates
> >> can change the tree structure quite a bit.
> >>
> >> Also avoid changing the u-boot.dtb file since that is an input to Binman
> >>
> >> Add some other suggested code tweaks:
> >> - Only sync the dtb if something changed
> >> - add more comments
> >>
> >> Note: This patch is just for illustration; please just combine it into
> >> your existing work.
> >>
> >> Signed-off-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >>   tools/binman/control.py | 70 +++++++++++++++++++++++++++--------------
> >>   1 file changed, 46 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/tools/binman/control.py b/tools/binman/control.py
> >> index b703bdf482e..6b7c5507513 100644
> >> --- a/tools/binman/control.py
> >> +++ b/tools/binman/control.py
> >> @@ -530,34 +530,55 @@ def _RemoveTemplates(parent):
> >>       for node in del_nodes:
> >>           node.Delete()
> >>   -def prop_bootph_to_parent(node, prop):
> >> -    """Propagates bootph-* property to all the parent
> >> -    nodes up the hierarchy
> >> -    """
> >> -    parent = node.parent
> >> -    if parent == None or parent.props.get(prop):
> >> -       return
> >> +def propagate_bootph(node, prop):
> >> +    """Propagate bootph-* property to all the parent nodes up the
> >> hierarchy
> >> +
> >> +    Args:
> >> +        node (fdt.Node): Node to propagate the property to
> >> +        prop (str): Property to propagate
> >>   -    while parent:
> >> -        parent.AddEmptyProp(prop, 0)
> >> -        parent = parent.parent
> >> +    Return:
> >> +        True if any change was made, else False
> >> +    """
> >> +    changed = False
> >> +    while node:
> >> +        if prop not in node.props:
> >> +            node.AddEmptyProp(prop, 0)
> >> +            changed = True
> >> +        node = node.parent
> >> +    return changed
> >>     def scan_and_prop_bootph(node):
> >> -    """Scan the device tree and set the bootph-* property if its
> >> present
> >> -    in subnode
> >> +    """Propagate bootph properties from children to parents
> >> +
> >> +    The bootph schema indicates that bootph nodes in children should
> >> be implied
> >> +    in their parents, all the way up the hierarchy. This is
> >> expensive to
> >> +    implement in U-Boot before relocation, so this function explicitly
> >> +    propagates these bootph properties upwards.
> >>         This is used to set the bootph-* property in the parent node
> >> if a
> >> -    "bootph-*" property is found in any of the subnodes of the parent
> >> -    node.
> >> +    "bootph-*" property is found in any of the parent's subnodes.
> >> +
> >> +    Args:
> >> +        node (fdt.Node): Node to propagate the property to
> >> +        prop (str): Property name to propagate
> >> +
> >> +    Return:
> >> +        True if any change was made, else False
> >> +
> >>       """
> >> -    bootph_prop = ['bootph-all', 'bootph-some-ram',
> >> 'bootph-pre-ram', 'bootph-pre-sram']
> >> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram',
> >> +                   'bootph-pre-sram']
> >>   -    for props in bootph_prop:
> >> -        if node.props.get(props):
> >> -            prop_bootph_to_parent(node, props)
> >> +    changed = False
> >> +    for prop in bootph_prop:
> >> +        if prop in node.props:
> >> +            changed |= propagate_bootph(node.parent, prop)
> >>         for subnode in node.subnodes:
> >> -       scan_and_prop_bootph(subnode)
> >> +        changed |= scan_and_prop_bootph(subnode)
> >> +    return changed
> >> +
> >>     def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt,
> >> use_expanded, indir):
> >>       """Prepare the images to be processed and select the device tree
> >> @@ -573,7 +594,7 @@ def PrepareImagesAndDtbs(dtb_fname,
> >> select_images, update_fdt, use_expanded, ind
> >>           dtb_fname: Filename of the device tree file to use (.dts or
> >> .dtb)
> >>           selected_images: List of images to output, or None for all
> >>           update_fdt: True to update the FDT wth entry offsets, etc.
> >> -        use_expanded: True to use expanded versions of entries, if
> >> available.
> >> +        use_expanded: True to use expanded versions osf entries, if
> >> available.
> >>               So if 'u-boot' is called for, we use 'u-boot-expanded'
> >> instead. This
> >>               is needed if update_fdt is True (although tests may
> >> disable it)
> >>           indir: List of directories where input files can be found
> >> @@ -596,10 +617,8 @@ def PrepareImagesAndDtbs(dtb_fname,
> >> select_images, update_fdt, use_expanded, ind
> >>           indir = []
> >>       dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
> >>       fname = tools.get_output_filename('u-boot.dtb.out')
> >> -    dtb = fdt.FdtScan(dtb_fname)
> >> -    scan_and_prop_bootph(dtb.GetRoot())
> >> -    dtb.Sync(True)
> >> -    tools.write_file(dtb_fname, dtb.GetContents())
> >> +    tools.write_file(fname, tools.read_file(dtb_fname))
> >> +    dtb = fdt.FdtScan(fname)
> >>         node = _FindBinmanNode(dtb)
> >>       if not node:
> >> @@ -620,6 +639,9 @@ def PrepareImagesAndDtbs(dtb_fname,
> >> select_images, update_fdt, use_expanded, ind
> >>           fname = tools.get_output_filename('u-boot.dtb.tmpl2')
> >>           tools.write_file(fname, dtb.GetContents())
> >>   +    if scan_and_prop_bootph(dtb.GetRoot()):
> >> +        dtb.Sync(True)
> >> +
> >
> > I applied the suggested changes, u-boot.dtb.out does shows the
> > bootph-* being propagated on reverse compiling, but
> > on reverse compiling u-boot.dtb I cannot see the same behavior. I
> > think we might have to make an explicit call to sync
> > the two of them somehow because the dtb.Sync() here as per my
> > understanding is syncing the changes done back to
> > u-boot.dtb.out.
> >
> > Any pointers on how I can make the changes reflect in u-boot.dtb
> > without doing this:
> >
> > tools.write_file(dtb_fname, dtb.GetContents())

But why do you need to do that? It is the 'output' dtb which should be
packaged in the image. The 'u-boot.dtb' file is an input to binman,
not an output from it..

> >
> >
> > Regards,
> > Moteen
> >>       images = _ReadImageDesc(node, use_expanded)
> >>         if select_images:

Regards,
Simon
