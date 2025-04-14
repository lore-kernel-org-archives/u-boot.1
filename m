Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FEBC369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 18:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C770803DF;
	Mon, 14 Apr 2025 20:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLso91y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E86C80584; Mon, 14 Apr 2025 20:48:31 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 248B2803CC
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 20:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso889251466b.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 11:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744656507; x=1745261307; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dZEfpf4uDzKnPhVK/U06SlK7uewSCRsIkynMuyq8+1I=;
 b=QLso91y/CEeqcqec12Dv6nIyyH55EUZ7QOAF9XdpSAF0oWMFmpKJoeaS7HLR+1MvgI
 9z03nhhQwzMzO1SnVFzgdaI5bplXVndzOvnpAbU2kjhO/+psGMsKooxDYGdbMlH4IPHf
 eQ+GPrajy65+rgEivh2s06RXo3CProlmNXCfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744656507; x=1745261307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZEfpf4uDzKnPhVK/U06SlK7uewSCRsIkynMuyq8+1I=;
 b=lluNId5DjoHcPN7CcBf51UBK+wGHhqe7K3NZvl4kLVTEdQpbntKvTAM4+VJ0vqe/5M
 T6rk8CsNdSkVjcpEXR9ZHcEi+TmewA9oT3hXaRHlV3TJvf5lGC6hMYtMy4x5zmFqLyFp
 o2pyOR/A/XnDzqY/857b9Zl8XKK6Xug5sT98kLuGd/ZY172X3+Cm2xiUS9BeZdjzLfsa
 AzC2FByoioLD3tygL3hqMwtGsL7+7+qEjRN9LLyVn+uAptVe1X0kytK2TMvq0VJhwXRu
 CBSMzU4j2cN+YItOi7/rf5r6zkCqOVX+Eg8tOhKrxMkZxSOjWjv5BZrBmckMuJSCq56W
 4WXg==
X-Gm-Message-State: AOJu0Yxe9Sj7Ok0boV2P7XTzmxMqJqjoY5WUsR0q2EYGsAKdM1tYg3lI
 S6U3cZ+J80MInaOF8FFBGWU5b14kqn8MrtxLZ9KU1ISyaRgqE4X3as9mC2jyRzYgyiIPB5aknFj
 boJMXxgIrfcbzt5SM5Saq8rpNPIeGGT/TYD3I
X-Gm-Gg: ASbGnctJhYBpcM8Ad9c8bPPwmj2I6+yY0s9wi4aWlMcjso8cyhE14YACEBpsbzL3guS
 4jLkwVpDY7sFcOlYls+zNjC+24oTkEa3VqCAcqnqHpCRhnz59nOuTFJsMsI3fSydV8KnZqbM/s9
 5KRoHyWlXzS9ecAl5VjkT+xNUzR6f1zdqDJQ==
X-Google-Smtp-Source: AGHT+IGAvbFw6aoRBbJYl984Wk0MlWkDBwjOHMeOxsNGozmZ0L948HyKFwoSnrqwVWAJHFyCnQEYvtBk6Q7h+MsHC5w=
X-Received: by 2002:a17:906:3e87:b0:aca:d48f:4d48 with SMTP id
 a640c23a62f3a-acad48f4effmr868721766b.60.1744656507110; Mon, 14 Apr 2025
 11:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <CAFLszTjB+HuX68tmTrLP=gbbpzt0kJr22137cSLiedx6bh6PVw@mail.gmail.com>
 <3d2c894b-11f1-462c-b9f5-8d3f45dc0b61@ti.com>
 <CAFLszThs5W+=tFpUsCE0Qi5mvuymtsHF57jeLpV9KUQfGXBXnA@mail.gmail.com>
 <3287617e-3b6a-4387-90d4-7bbfc810f9c7@ti.com>
 <ec117e91-7b13-4ca9-8509-3075d7071427@ti.com>
In-Reply-To: <ec117e91-7b13-4ca9-8509-3075d7071427@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Apr 2025 12:48:15 -0600
X-Gm-Features: ATxdqUFYvbh0CEi1R18XCSlrnzfamh_QB9Y_7X_NOuehP8lwb1mUZFR_cITnDMU
Message-ID: <CAFLszTjD+Aofu8jLMyX4FPxatmt_SaRC8amf7rziNmNKECFrGQ@mail.gmail.com>
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

On Thu, 10 Apr 2025 at 05:39, Moteen Shah <m-shah@ti.com> wrote:
>
> Hey Simon,
>
> Is the problem discussed in the thread an actual bug or am I missing
> something in the implementation?
>
> Regards,
> Moteen
>
> On 03/04/25 11:51, Moteen Shah wrote:
> > Hey Simon,
> >
> > On 03/04/25 00:52, Simon Glass wrote:
> >> Hi Moteen,
> >>
> >> On Wed, 2 Apr 2025 at 22:01, Moteen Shah <m-shah@ti.com> wrote:
> >>> Hey Simon,
> >>>
> >>> On 29/03/25 05:17, Simon Glass wrote:
> >>>> Hi Moteen,
> >>>>
> >>>> On Thu, 27 Mar 2025 at 08:06, Moteen Shah <m-shah@ti.com> wrote:
> >>>>> Add a function to scan through all the nodes in the device-tree
> >>>>> recusively for bootph-* property. If found, propagate it to all
> >>>>> of its parent nodes up the hierarchy.
> >>>>>
> >>>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
> >>>>> ---
> >>>>>    tools/binman/control.py | 35 ++++++++++++++++++++++++++++++++++-
> >>>>>    1 file changed, 34 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/tools/binman/control.py b/tools/binman/control.py
> >>>>> index e73c598298c..e739949d366 100644
> >>>>> --- a/tools/binman/control.py
> >>>>> +++ b/tools/binman/control.py
> >>>>> @@ -526,6 +526,35 @@ def _RemoveTemplates(parent):
> >>>>>            if node.name.startswith('template'):
> >>>>>                node.Delete()
> >>>>>
> >>>>> +def prop_bootph_to_parent(node, prop, dtb):
> >>>> I think the 'prop_' is a bit confusing, since you are dealing with
> >>>> properties! How about 'add_' as the prefix?
> >>> 'add_' should be more descriptive, will add that in v3.
> >>>
> >>>>> +    """Propagates bootph-* property to all the parent
> >>>>> +    nodes up the hierarchy
> >>>> First line should be a summary
> >>>>
> >>>> then blank line
> >>>>
> >>>> then describe the args...you can see this if you look at a few
> >>>> other functions.
> >>>
> >>> Noted, will rectify in v3.
> >>>
> >>>>> +    """
> >>>>> +    parent = node.parent
> >>>>> +    if parent == None or parent.props.get(prop):
> >>>> if not parent or ...
> >>>
> >>> Noted.
> >>>
> >>>
> >>>>> +       return
> >>>>> +
> >>>>> +    while parent:
> >>>>> +        parent.AddEmptyProp(prop, 0)
> >>>>> +        parent = parent.parent
> >>>>> +
> >>>>> +def scan_and_prop_bootph(node, dtb):
> >>>>> +    """Scan the device tree and set the bootph-* property if its
> >>>>> present
> >>>>> +    in subnode
> >>>>> +
> >>>>> +    This is used to set the bootph-* property in the parent node
> >>>>> if a
> >>>>> +    "bootph-*" property is found in any of the subnodes of the
> >>>>> parent
> >>>>> +    node.
> >>>> comment style again
> >>>>
> >>>>> +    """
> >>>>> +    bootph_prop = ['bootph-all', 'bootph-some-ram',
> >>>>> 'bootph-pre-ram', 'bootph-pre-sram']
> >>>>   From my understanding the only ones that matter are bootph-all and
> >>>> bootph-some-ram, since the SPL ones are handled by fdtgrep.
> >>>
> >>> Noted.
> >>>
> >>>
> >>>>> +
> >>>>> +    for props in bootph_prop:
> >>>> for prop
> >>>>
> >>>> (since it is just one)
> >>>>
> >>>>> +        if node.props.get(props):
> >>>>> +            prop_bootph_to_parent(node, props, dtb)
> >>>>> +
> >>>>> +    for subnode in node.subnodes:
> >>>>> +       scan_and_prop_bootph(subnode, dtb)
> >>>>> +
> >>>>>    def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt,
> >>>>> use_expanded, indir):
> >>>>>        """Prepare the images to be processed and select the device
> >>>>> tree
> >>>>>
> >>>>> @@ -563,7 +592,11 @@ def PrepareImagesAndDtbs(dtb_fname,
> >>>>> select_images, update_fdt, use_expanded, ind
> >>>>>            indir = []
> >>>>>        dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
> >>>>>        fname = tools.get_output_filename('u-boot.dtb.out')
> >>>>> -    tools.write_file(fname, tools.read_file(dtb_fname))
> >>>>> +    dtb = fdt.FdtScan(dtb_fname)
> >>>>> +    scan_and_prop_bootph(dtb.GetRoot(), dtb)
> >>>>> +    dtb.Sync(True)
> >>>>> +    tools.write_file(dtb_fname, dtb.GetContents())
> >>>>> +    tools.write_file(fname, dtb.GetContents())
> >>>> You shouldn't write back to the file created by the build. Do you
> >>>> need this?
> >>>
> >>> Had the same thought, but the build fails in non clean builds[0]. Did a
> >>> workaround[1] but then some essential template nodes ends up getting
> >>> deleted from u-boot.dtb. Finally, had to write back to the file
> >>> to resolve the issue.
> >> Can you push a tree somewhere. This could be a bug that I could fix.
> >
> > You can use the tree here to recreate the non clean build issue
> > mentioned:
> > https://github.com/Jamm02/U-Boot-patchwork/tree/bootph-patch-test
> >
> >>
> >>>>>        dtb = fdt.FdtScan(fname)
> >>>>>
> >>>>>        node = _FindBinmanNode(dtb)
> >>>>> --
> >>>>> 2.34.1
> >>>>>
> >>>> The code looks fine to me apart from the nits.
> >>>>
> >>>> This addition needs a test - see ftest.py for some examples there. But
> >>>> basically just create a dts that has some props in it, then check that
> >>>> they got added.
> >>>
> >>> Included a test as well in the patchset[3]. Do let me know if there are
> >>> some changes required in it.
> >> Somehow I'm not seeing that in patchwork. It looks good but please try
> >> to keep lines <=80 cols.
> >
> >
> > Sure, will fix up in v3. Should I push a v3 or wait for you to fix the
> > issue discussed above?

I've finally got back to this, but I can't repeat it.

For me:

 crosfw j7200_evm_r5 -F
cmd: make -j32 'CROSS_COMPILE=/home/sglass/.buildman-toolchains/gcc-13.2.0-nolibc/arm-linux-gnueabi/bin/arm-linux-gnueabi-'
--no-print-directory 'HOSTSTRIP=true' 'QEMU_ARCH='
'KCONFIG_NOSILENTUPDATE=1' 'O=/tmp/b/j7200_evm_r5' -s 'BUILD_ROM=1'
all
Image 'tiboot3-j7200-hs-evm.bin' has faked external blobs and is
non-functional: ti-fs-firmware-j7200-hs-enc.bin
ti-fs-firmware-j7200-hs-cert.bin

Image 'tiboot3-j7200-hs-evm.bin' is missing optional external blobs
but is still functional: ti-fs-enc.bin sysfw-inner-cert

/binman/tiboot3-j7200-hs-evm.bin/ti-fs-enc.bin
(ti-sysfw/ti-fs-firmware-j7200-hs-enc.bin):
   Missing blob

/binman/tiboot3-j7200-hs-evm.bin/sysfw-inner-cert
(ti-sysfw/ti-fs-firmware-j7200-hs-cert.bin):
   Missing blob

Image 'tiboot3-j7200_sr2-hs-evm.bin' has faked external blobs and is
non-functional: ti-fs-firmware-j7200_sr2-hs-enc.bin
ti-fs-firmware-j7200_sr2-hs-cert.bin

Image 'tiboot3-j7200_sr2-hs-evm.bin' is missing optional external
blobs but is still functional: ti-fs-enc.bin sysfw-inner-cert

/binman/tiboot3-j7200_sr2-hs-evm.bin/ti-fs-enc.bin
(ti-sysfw/ti-fs-firmware-j7200_sr2-hs-enc.bin):
   Missing blob

/binman/tiboot3-j7200_sr2-hs-evm.bin/sysfw-inner-cert
(ti-sysfw/ti-fs-firmware-j7200_sr2-hs-cert.bin):
   Missing blob

Image 'tiboot3-j7200-hs-fs-evm.bin' has faked external blobs and is
non-functional: ti-fs-firmware-j7200-hs-fs-enc.bin
ti-fs-firmware-j7200-hs-fs-cert.bin

Image 'tiboot3-j7200-hs-fs-evm.bin' is missing optional external blobs
but is still functional: ti-fs-enc.bin sysfw-inner-cert

/binman/tiboot3-j7200-hs-fs-evm.bin/ti-fs-enc.bin
(ti-sysfw/ti-fs-firmware-j7200-hs-fs-enc.bin):
   Missing blob

/binman/tiboot3-j7200-hs-fs-evm.bin/sysfw-inner-cert
(ti-sysfw/ti-fs-firmware-j7200-hs-fs-cert.bin):
   Missing blob

Image 'tiboot3-j7200_sr2-hs-fs-evm.bin' has faked external blobs and
is non-functional: ti-fs-firmware-j7200_sr2-hs-fs-enc.bin
ti-fs-firmware-j7200_sr2-hs-fs-cert.bin

Image 'tiboot3-j7200_sr2-hs-fs-evm.bin' is missing optional external
blobs but is still functional: ti-fs-enc.bin sysfw-inner-cert

/binman/tiboot3-j7200_sr2-hs-fs-evm.bin/ti-fs-enc.bin
(ti-sysfw/ti-fs-firmware-j7200_sr2-hs-fs-enc.bin):
   Missing blob

/binman/tiboot3-j7200_sr2-hs-fs-evm.bin/sysfw-inner-cert
(ti-sysfw/ti-fs-firmware-j7200_sr2-hs-fs-cert.bin):
   Missing blob

Image 'tiboot3-j7200-gp-evm.bin' has faked external blobs and is
non-functional: ti-fs-firmware-j7200-gp.bin

Image 'tiboot3-j7200-gp-evm.bin' is missing optional external blobs
but is still functional: ti-fs-gp.bin

/binman/tiboot3-j7200-gp-evm.bin/ti-fs-gp.bin
(ti-sysfw/ti-fs-firmware-j7200-gp.bin):
   Missing blob

Some images are invalid
make[1]: *** [/scratch/sglass/cosarm/src/third_party/u-boot/files/Makefile:1135:
.binman_stamp] Error 103
make: *** [Makefile:177: sub-make] Error 2

I wonder if I need some blobs?

> >
> >>
> >>
> >>>> I think testSimpleFitEncryptedData() could be a good example?
> >>>>
> >>>> Regards,
> >>>> Simon
> >>> References:
> >>> [0]https://gist.github.com/Jamm02/2478a4f1186f3ba4a8cd7dbf1fb11e2f#file-non-clean-build
> >>>
> >>> [1]https://gist.github.com/Jamm02/2478a4f1186f3ba4a8cd7dbf1fb11e2f#file-patch-tools-dtdoc-fdt-py
> >>>
> >>> [3]https://lore.kernel.org/u-boot/20250327080642.2269856-3-m-shah@ti.com/
> >>>
> >>>
> >>> Thanks for the review.

Regards,
SImon
