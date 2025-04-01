Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA62C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197F481EC0;
	Tue,  1 Apr 2025 17:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b2kg+r8g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF19A81F0B; Tue,  1 Apr 2025 17:42:27 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2C3C81DE3
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac34257295dso42050866b.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522144; x=1744126944; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FgJ9n4niVEpCgr+G8lCJwuHuV1anVOb4SNsVo80sHNc=;
 b=b2kg+r8g96397Ch3db04CF3WTJkvUdacTn+JR4LhP5tHYZPD2EODCP7MN6G9jfcco7
 k87Mz8c81897qfB89AJ1i5ic9EMckdNvJUjJY3tIPij0pZDVBSmeVD1x51a5paVFV2q5
 Y5QKT4gJ/L+nxTsUSTYrylx7CnyokP6JAKL/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522144; x=1744126944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FgJ9n4niVEpCgr+G8lCJwuHuV1anVOb4SNsVo80sHNc=;
 b=vZJHG6T/lS2T02zRL36wtzjHNZyCRWKZOEk0BX4Cp0Z74+5xmND4+cqFwNGm18eoiB
 gb50SY94hhkaiir/XDOrA2ViRSefUDYTmctVENNike177h+HtjHakEQ+PrpYJpvJkShC
 begfg/jZ3eXLZHexLOh9mZSgjibclDpcfHTpZsfvrPRrYKFJvMODmJdJc8eaAgiTCD8s
 /rX2HLKBRO1CT0UgIwzkVm3Y0r7X4uif4DcSpq8iIPtt7Y27TmohOykeN3mjyjgrfGU8
 Zfxf08c181j3KdjJflsD7NWqdBJbhKno5VO3LTBDDwfjdZIVb5TctWCVQQ0aYvSmuyCM
 1YBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDPzee5nk+ID/rmp8+WBw3Xz0581qC89c+RoZ9be8db2d7mWigXrcX8EQa+1mNPWiyHNhy+oA=@lists.denx.de
X-Gm-Message-State: AOJu0YwYt8qtye6EXqifoq8nkwlXxsM815PKG3h9cI4m+yObWRrisA6F
 iNW5SY2A3PT+8X70Me7awQ6rUdQrbC+hrTdOLYIyDM9AhqWL/D6zEOV/CIZCQA7ecyfzyBNDn0M
 ST4lO/OHmOUEA+QWUx6ry6U/CC299W0FtOrmJ
X-Gm-Gg: ASbGncvso8wigk1JzSgyGueMSfed8Ce8mUkQiY9oF5GAAG+ofexabROkDOYzyEGegfT
 4w70VbP6C1MHEHOmzaLNfAic+uARsfwsf06jm/uF+MRIw8zyJw+HpxmIyCl7pv8R1g7Or9O3RFB
 G8rPEnFEu5qOPLV3XQkWefdd1LVjr+
X-Google-Smtp-Source: AGHT+IEjWua9Nz9O4Z3XbqyedS3tRNWCzX4LRteryeH5ifkbtOw7Lc0n1lJ00rz3yyLdytqFtgztZwujrDyDjtKvLXs=
X-Received: by 2002:a17:907:9491:b0:ac6:b639:5a1c with SMTP id
 a640c23a62f3a-ac738a4bcedmr1220155566b.22.1743522143767; Tue, 01 Apr 2025
 08:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <ac62affe-7c37-4f35-915b-79d1acdd8ab8@cherry.de>
 <20250401050356.hqcksshomlgjeyno@uda0497581-HP>
In-Reply-To: <20250401050356.hqcksshomlgjeyno@uda0497581-HP>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:42:12 +1300
X-Gm-Features: AQ5f1JogVR2RdtLMRZRp_7xfF4FsMjIEck_w82YcV5ziL0QDMAQJ0t1snMC3rsc
Message-ID: <CAFLszThKdxESi=SCLOy02aau5zyDsF36meyiCMrw4vhM6JDCtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Moteen Shah <m-shah@ti.com>,
 u-boot@lists.denx.de, 
 trini@konsulko.com, alpernebiyasak@gmail.com, n-francis@ti.com, 
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

Hi Manorit,

On Tue, 1 Apr 2025 at 18:04, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Quentin,
>
> On 15:46-20250328, Quentin Schulz wrote:
> > Hi Moteen,
> >
> > On 3/27/25 9:06 AM, Moteen Shah wrote:
> > > Add a function to scan through all the nodes in the device-tree
> > > recusively for bootph-* property. If found, propagate it to all
> > > of its parent nodes up the hierarchy.
> > >
> > > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > > ---
> > >   tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 34 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/binman/control.py b/tools/binman/control.py
> > > index e73c598298c..e739949d366 100644
> > > --- a/tools/binman/control.py
> > > +++ b/tools/binman/control.py
> > > @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
> > >           if node.name.startswith('template'):
> > >               node.Delete()
> > > +def prop_bootph_to_parent(node, prop, dtb):
> > > +    """Propagates bootph-* property to all the parent
> > > +    nodes up the hierarchy
> > > +    """
> > > +    parent = node.parent
> > > +    if parent == None or parent.props.get(prop):
> > > +       return
> > > +
> > > +    while parent:
> > > +        parent.AddEmptyProp(prop, 0)
> > > +        parent = parent.parent
> > > +
> > > +def scan_and_prop_bootph(node, dtb):
> > > +    """Scan the device tree and set the bootph-* property if its present
> > > +    in subnode
> > > +
> > > +    This is used to set the bootph-* property in the parent node if a
> > > +    "bootph-*" property is found in any of the subnodes of the parent
> > > +    node.
> > > +    """
> > > +    bootph_prop = ['bootph-all', 'bootph-some-ram', 'bootph-pre-ram', 'bootph-pre-sram']
> > > +
> >
> > This should only be done for U-Boot proper DTB I believe, otherwise it'll
> > cause FDT size increase for TPL/SPL/VPL/whatever where we may be extremely
> > size-constrained. Furthermore, TPL/SPL/VPL should not need this since they
> > get a subset of the actual full DTB (see scripts/Makefile.lib and
> > fdtgrep_props), only containing the DT node that are relevant for the stage
> > in question. The only exception I can think of right now is if we use
> > bloblist or any other mechanism having the full DT passed from stage to
> > stage.
> >
> > Maybe the solution is to have it as part of tools/binman/etype/u_boot_dtb.py
> > only?
> >
> > Also, I imagine we want to support this for systems which do not use binman
> > (yet?)?
>
> I think if we really want to unblock platforms that are facing this then
> maybe the v1 of this patchset along with the v2 can be merged. ( keeping
> v1 config as disabled by default for now ). This can help the platforms
> wanting to fix this issue without binman by enabling that config in
> their defconfig ( ofcourse with a boot time penalty which would force them to
> migrate to binman ). Though not sure if this is the right way to go
> about it but just a suggestion.

Yes that seems like a good idea to me.

Regards,
Simon
