Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E79C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:48:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9867381E60;
	Sat, 29 Mar 2025 00:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GpUzyOx7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB7B81ECD; Sat, 29 Mar 2025 00:48:04 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 879DB81DED
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so346874666b.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205680; x=1743810480; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AcgcdD6HvF3YO6QPBLXJpAZJzayVlPWDd9VJYCHtQso=;
 b=GpUzyOx7gTKIHSF1vdiCk2WIJVS72b3Pz9sVOpSbxJ2qy7cuMFFMmxftCxdV/ZOZJZ
 zgOkljdXi9lPt/V6P1n5tJ5SOdHDQbOmy5N/XNurI4QdGKOEtaAtoRFmYSGBoIQEaq0u
 O7kx1+VPq+lu0kfMyutAgr+3qZeiWhF7sr8+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205680; x=1743810480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AcgcdD6HvF3YO6QPBLXJpAZJzayVlPWDd9VJYCHtQso=;
 b=Wqy812StI5L9WT47Zz4N5zEAOiGC2DtO5g/pSaXvjjrWN7Zp1F3Wyr4J5ELC1UgXZ9
 YvlVoSnQSCvb5OlDIGp+8goL6x9IFxTT0M8VnO5XBaNPKqypUffvscufvn7fIeh/5vLV
 r9BIuIdIXp/RNIhn9XMWcfPzVBuNgeip8xwOnUgps8wQAgmEiVV2rFPiXDeb/x5KfqHm
 EGofyhwhW8e5dOnr9EJxlkSRdRd/i3eJsnmfVXbCQfiC44d4NEZA22S0n7b9DArbbhS2
 J4ICCZw0MFsQ1+Bmlqp1wXd8HT1oCdcdrt/h5nX9V2I2LP2nb4S1f63qhADiG3+Ej7OK
 2pYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQThTN28Yy4mePBZwfpR+nE5+Xh5Z2svXhJ4Y53JAaJF02edrHdUB+O2i9tyymWXRBH+hlyYA=@lists.denx.de
X-Gm-Message-State: AOJu0YyXc6qTgiDtqlWUDlqPEmz0KZqXDolhexep6YTHOD8FWs1ZJ6Bm
 I1i3NMRvE6cvzwm2VFP1Cp2/vg7bhMneHQcZAcsTQGyHmW46wGKx51zXxj/tcnKNn9nWqos5s3S
 WiU4tRGxwx7EjBXcZSA//rXDkOQad2LrNdTET94a3bDqy2lY=
X-Gm-Gg: ASbGnctkpgTmuLleGaV82OmFCGizbVYttIlHTHHNFqOerl2vzy9nHp//c5TG+IKEiUw
 BIxOaZYb8BCdFRG2UjOFKS0gyWqHWE/85RivUZF6+DhKEKD6Cr3yMkPbv1GPEROZpa2QC4pHbL/
 ftgGsXP0n7aXqYLycgP07VF7JSLc+YxzlQonk/Pg==
X-Google-Smtp-Source: AGHT+IHCLFQFOZtd3HCgyPHmvlHebc6SSXWIr4/OI1WzfODgvbeE3XnVr4q9eApFl0LQ8X9zX6/nXwtLEn2Y7M8i9Og=
X-Received: by 2002:a17:907:3e1d:b0:ac3:8537:903c with SMTP id
 a640c23a62f3a-ac738bc07d7mr77690666b.37.1743205679863; Fri, 28 Mar 2025
 16:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <ac62affe-7c37-4f35-915b-79d1acdd8ab8@cherry.de>
In-Reply-To: <ac62affe-7c37-4f35-915b-79d1acdd8ab8@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:47:47 +0000
X-Gm-Features: AQ5f1JqoYZsZZrNDRmR5h80UFl8yxwel8UA7MLahexv-krZ4gTm1V7lP0Z2eTk0
Message-ID: <CAFLszTi-oH2oyNVFiOKp8ciF2FKNtJsx_HiMXs1QHNn41R=eeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de, trini@konsulko.com, 
 alpernebiyasak@gmail.com, m-chawdhry@ti.com, n-francis@ti.com, 
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

Hi Quentin,

On Fri, 28 Mar 2025 at 14:46, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Moteen,
>
> On 3/27/25 9:06 AM, Moteen Shah wrote:
> > Add a function to scan through all the nodes in the device-tree
> > recusively for bootph-* property. If found, propagate it to all
> > of its parent nodes up the hierarchy.
> >
> > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > ---
> >   tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
> >   1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/binman/control.py b/tools/binman/control.py
> > index e73c598298c..e739949d366 100644
> > --- a/tools/binman/control.py
> > +++ b/tools/binman/control.py
> > @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
> >           if node.name.startswith('template'):
> >               node.Delete()
> >
> > +def prop_bootph_to_parent(node, prop, dtb):
> > +    """Propagates bootph-* property to all the parent
> > +    nodes up the hierarchy
> > +    """
> > +    parent = node.parent
> > +    if parent == None or parent.props.get(prop):
> > +       return
> > +
> > +    while parent:
> > +        parent.AddEmptyProp(prop, 0)
> > +        parent = parent.parent
> > +
> > +def scan_and_prop_bootph(node, dtb):
> > +    """Scan the device tree and set the bootph-* property if its present
> > +    in subnode
> > +
> > +    This is used to set the bootph-* property in the parent node if a
> > +    "bootph-*" property is found in any of the subnodes of the parent
> > +    node.
> > +    """
> > +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
> > +
>
> This should only be done for U-Boot proper DTB I believe, otherwise
> it'll cause FDT size increase for TPL/SPL/VPL/whatever where we may be
> extremely size-constrained. Furthermore, TPL/SPL/VPL should not need
> this since they get a subset of the actual full DTB (see
> scripts/Makefile.lib and fdtgrep_props), only containing the DT node
> that are relevant for the stage in question. The only exception I can
> think of right now is if we use bloblist or any other mechanism having
> the full DT passed from stage to stage.
>
> Maybe the solution is to have it as part of
> tools/binman/etype/u_boot_dtb.py only?

The location of this code is where it is handling the U-Boot device
tree, so it won't affect xPL versions.

But it is possible to add a check for this into the test.

>
> Also, I imagine we want to support this for systems which do not use
> binman (yet?)?

Nope, sorry :-) They can enable binman if they want this.

Regards,
Simon
