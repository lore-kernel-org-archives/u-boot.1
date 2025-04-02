Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C09C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EFDC81FC6;
	Wed,  2 Apr 2025 21:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ksa6Xg98";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A748481E6C; Wed,  2 Apr 2025 21:22:37 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C42E681F66
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso24141666b.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743621754; x=1744226554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JhgomQ0jfOubK659Bq9FSWCc5wgCv0PmOunB8VVX+0w=;
 b=ksa6Xg98qvR0cKx/05gpKqKTDL/4UAl/KO9juse4Pvx5AWOteVbELCjwHmCtzZFrA0
 YONhSG0qDYtwra+mBTvVhuAQC5528k5DSWNxev98CmU+bKJSayaAKd0+MBHbRM2U34YP
 N9yOTUQFKH1ZA2DPooNHRXlf7ZFS0FI+N5Hcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743621754; x=1744226554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhgomQ0jfOubK659Bq9FSWCc5wgCv0PmOunB8VVX+0w=;
 b=lZuZl977Q0wn4Mrvzsa4Ate7I8Kl86X769ATmSz87HEECP5lGxKmJF+FsCHDV9QxRo
 5GKKTMR5Bun45syS3Zl4Uv0D+KRHQlGXtTOhzbT9/gwOJ1kx7puHgUDPsKdBCASuSbbr
 7lxbqBm1Aqmgbxl+/ZY2K9BJZYhxNPfyIKdzwusmKS8dF9JZQc9xVXgJFe9nS/r/S1gj
 Qjag5uXAh2tWS9UhP5/XgAqoiHLHb04un8XdZtC9RLC67r28WJmcXT52ZZmSBaZ4ua47
 mMzq/cp41lyg3h2JDGHPgeom6XxfepmlWcCnBHsLc+AIVBByRu1nEEVB4DfQTCp8Wbbu
 dWAQ==
X-Gm-Message-State: AOJu0Yz4wojF220yYLAKwYsaHi/RHnNmjkeCyaWLS9hzViD0IMbduSTS
 PtRW2cxdAiHkOFeQdnAO60Zii5sYAGuBNPnyExcEesmCRcC05CAf5CrOKfSLVREgE0m1AVEUv+P
 78UQu5JqQLWc3xkLEG2SotlzLEHvIgN34pAjE
X-Gm-Gg: ASbGncvWt8UgrxeKnlDA8rCHyfYYwuHSPSYP67l6yEV6fNjcXwQ9W3/AT0f2TYzVF+A
 DqfBf2likxL3V4Tqg5mkRKcpcSMTEw8rUGLg20G7tS7w1wcVv+RjOwo4IQOrk2eCAkvCN2g09Bb
 a0orQvBktxcmfyJHvxJhz3fwVW5b9s
X-Google-Smtp-Source: AGHT+IEOOu9h6GzdsFWyF8w7mSOBW15XxFC1GCAr6fnNa4wRlNXepsa/0kYEQYQ5bDQjRqmUCs9pJd2S2/uzUnoPPZM=
X-Received: by 2002:a17:907:3e14:b0:ac7:18e3:1b16 with SMTP id
 a640c23a62f3a-ac782b64c23mr778627466b.20.1743621753948; Wed, 02 Apr 2025
 12:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <CAFLszTjB+HuX68tmTrLP=gbbpzt0kJr22137cSLiedx6bh6PVw@mail.gmail.com>
 <3d2c894b-11f1-462c-b9f5-8d3f45dc0b61@ti.com>
In-Reply-To: <3d2c894b-11f1-462c-b9f5-8d3f45dc0b61@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 3 Apr 2025 08:22:22 +1300
X-Gm-Features: AQ5f1JpL7xdH0Xk-QVWDp_u2BSpZLX4fQfQeaaFYbntcA2050091UNTC_v16iho
Message-ID: <CAFLszThs5W+=tFpUsCE0Qi5mvuymtsHF57jeLpV9KUQfGXBXnA@mail.gmail.com>
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

On Wed, 2 Apr 2025 at 22:01, Moteen Shah <m-shah@ti.com> wrote:
>
> Hey Simon,
>
> On 29/03/25 05:17, Simon Glass wrote:
> > Hi Moteen,
> >
> > On Thu, 27 Mar 2025 at 08:06, Moteen Shah <m-shah@ti.com> wrote:
> >> Add a function to scan through all the nodes in the device-tree
> >> recusively for bootph-* property. If found, propagate it to all
> >> of its parent nodes up the hierarchy.
> >>
> >> Signed-off-by: Moteen Shah <m-shah@ti.com>
> >> ---
> >>   tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
> >>   1 file changed, 34 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/binman/control.py b/tools/binman/control.py
> >> index e73c598298c..e739949d366 100644
> >> --- a/tools/binman/control.py
> >> +++ b/tools/binman/control.py
> >> @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
> >>           if node.name.startswith('template'):
> >>               node.Delete()
> >>
> >> +def prop_bootph_to_parent(node, prop, dtb):
> > I think the 'prop_' is a bit confusing, since you are dealing with
> > properties! How about 'add_' as the prefix?
>
> 'add_' should be more descriptive, will add that in v3.
>
> >
> >> +    """Propagates bootph-* property to all the parent
> >> +    nodes up the hierarchy
> > First line should be a summary
> >
> > then blank line
> >
> > then describe the args...you can see this if you look at a few other functions.
>
>
> Noted, will rectify in v3.
>
> >> +    """
> >> +    parent = node.parent
> >> +    if parent == None or parent.props.get(prop):
> > if not parent or ...
>
>
> Noted.
>
>
> >
> >> +       return
> >> +
> >> +    while parent:
> >> +        parent.AddEmptyProp(prop, 0)
> >> +        parent = parent.parent
> >> +
> >> +def scan_and_prop_bootph(node, dtb):
> >> +    """Scan the device tree and set the bootph-* property if its present
> >> +    in subnode
> >> +
> >> +    This is used to set the bootph-* property in the parent node if a
> >> +    "bootph-*" property is found in any of the subnodes of the parent
> >> +    node.
> > comment style again
> >
> >> +    """
> >> +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
> >  From my understanding the only ones that matter are bootph-all and
> > bootph-some-ram, since the SPL ones are handled by fdtgrep.
>
>
> Noted.
>
>
> >
> >> +
> >> +    for props in bootph_prop:
> > for prop
> >
> > (since it is just one)
> >
> >> +        if node.props.get(props):
> >> +            prop_bootph_to_parent(node, props, dtb)
> >> +
> >> +    for subnode in node.subnodes:
> >> +       scan_and_prop_bootph(subnode, dtb)
> >> +
> >>   def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
> >>       """Prepare the images to be processed and select the device tree
> >>
> >> @@ -563,7 +592,11 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
> >>           indir = []
> >>       dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
> >>       fname = tools.get_output_filename('u-boot.dtb.out')
> >> -    tools.write_file(fname, tools.read_file(dtb_fname))
> >> +    dtb = fdt.FdtScan(dtb_fname)
> >> +    scan_and_prop_bootph(dtb.GetRoot(), dtb)
> >> +    dtb.Sync(True)
> >> +    tools.write_file(dtb_fname, dtb.GetContents())
> >> +    tools.write_file(fname, dtb.GetContents())
> > You shouldn't write back to the file created by the build. Do you need this?
>
>
> Had the same thought, but the build fails in non clean builds[0]. Did a
> workaround[1] but then some essential template nodes ends up getting
> deleted from u-boot.dtb. Finally, had to write back to the file
> to resolve the issue.

Can you push a tree somewhere. This could be a bug that I could fix.

>
> >>       dtb = fdt.FdtScan(fname)
> >>
> >>       node = _FindBinmanNode(dtb)
> >> --
> >> 2.34.1
> >>
> > The code looks fine to me apart from the nits.
> >
> > This addition needs a test - see ftest.py for some examples there. But
> > basically just create a dts that has some props in it, then check that
> > they got added.
>
>
> Included a test as well in the patchset[3]. Do let me know if there are
> some changes required in it.

Somehow I'm not seeing that in patchwork. It looks good but please try
to keep lines <=80 cols.


>
> >
> > I think testSimpleFitEncryptedData() could be a good example?
> >
> > Regards,
> > Simon
>
> References:
> [0]
> https://gist.github.com/Jamm02/2478a4f1186f3ba4a8cd7dbf1fb11e2f#file-non-clean-build
> [1]
> https://gist.github.com/Jamm02/2478a4f1186f3ba4a8cd7dbf1fb11e2f#file-patch-tools-dtdoc-fdt-py
> [3] https://lore.kernel.org/u-boot/20250327080642.2269856-3-m-shah@ti.com/
>
> Thanks for the review.

Regards,
Simon
