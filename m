Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E442E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 07:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8516786B3C;
	Mon,  9 Oct 2023 09:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fdMKCEDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BFB86A2B; Mon,  9 Oct 2023 09:59:25 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0744381FA8
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 09:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5347e657a11so6981549a12.2
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696838362; x=1697443162; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4OaWtuTBE0/2ixd8H6B0WsGu5C5pAnfa5bJUt2w1PeM=;
 b=fdMKCEDl22ZHLPZC6GOyZC2+ixF6B8HbDby33RQIMfQZL0XJINOOmcCNMfz/WLLf78
 Vq2SR2VXkCXuMWVo+ThUzWwi/Z8C5GLaYrpPL3t3GTLnxUtQqi/v6h8VZEvk132SemHP
 jJGF3Xmxx3wmhkI++gTplCLHezs8/WVctxe/eSH5PcrDkN7ZT7USRwPVEWqnfr1MUIfm
 FQtnjAQQSqeSJ5YrAi/m4W4l41W8Zm4z0Lv47DNslqYFjfFfECCjqJeQSkDyICafoFPk
 o6/6TNx2EsMXMn2GiiR9ofUH7uTAuoJc6WrPNc6kW2Oow+dz/oMh5qZb97fQGzytLFIX
 HI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696838362; x=1697443162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OaWtuTBE0/2ixd8H6B0WsGu5C5pAnfa5bJUt2w1PeM=;
 b=Or0rY/obqaFfC/mzJUdvqcafCvV+dqI9VSuHDgmTsUWudvX/Src5QotNKI98HaQ2xW
 NcequFsm5ra+QKunWlnoSPtFinV4hOACnPOKCt08ctsKGoK+jFKkzByTwjtfEmjYArr1
 r0ShrpyIHBrOAZ2sGMxLPhpUl7EZauurQMS6TOmwP1svB0CMRDwFZCO+CWAdjVBwC6fr
 8MuSUZmCWzZpgAzd14hSYITCHrh5KnBmeS+3cT6dgvzJ7oaFyficSF3a5kr2OPV8r1TE
 ggwdNccclEA95/nxFd+edd70WJaGGAEs7G1wlOvkXZ5iqGo8HnhoeL1UNVv7qZ+X7Lod
 PEng==
X-Gm-Message-State: AOJu0YzmytDAl5QBCCLZ6lNJYg9CUU4+sxQUJ89rlMHJpqVeI3mxBIRF
 utifOdlgKLLWlpP53CPxUeJINiTxOG7K4cKkmrEOUg==
X-Google-Smtp-Source: AGHT+IGbFBYXo4zQZpuJrjUzmnP8Ap2b1ly6IrDMIhxgS3ul9DKHeYAWYuQeNk2IgLK3OEtccfY2sK7Hv2Ls284wEHE=
X-Received: by 2002:aa7:dcd5:0:b0:524:547b:59eb with SMTP id
 w21-20020aa7dcd5000000b00524547b59ebmr10701795edu.15.1696838362444; Mon, 09
 Oct 2023 00:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-6-sughosh.ganu@linaro.org>
 <CAPnjgZ38v8ObWRDRB0mnyzpfJf_8wK8ChjTMzpRC387MKhgXwQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ38v8ObWRDRB0mnyzpfJf_8wK8ChjTMzpRC387MKhgXwQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 9 Oct 2023 13:29:11 +0530
Message-ID: <CADg8p96cPTPPzZ02BOdwDnNtRHOUiGmXgCcWxCHrjSWC_UwsdQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] binman: capsule: Add support for generating EFI empty
 capsules
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

hi Simon,

On Sun, 8 Oct 2023 at 04:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sugosh,
>
> On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add support in binman for generating EFI empty capsules. These
> > capsules are used in the FWU A/B update feature. Also add test cases
> > in binman for the corresponding code coverage.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  tools/binman/etype/efi_empty_capsule.py       | 91 +++++++++++++++++++
> >  tools/binman/ftest.py                         | 52 +++++++++++
> >  tools/binman/test/319_capsule_accept.dts      | 16 ++++
> >  tools/binman/test/320_capsule_revert.dts      | 14 +++
> >  .../test/321_capsule_accept_missing_guid.dts  | 14 +++
> >  .../binman/test/322_capsule_accept_revert.dts | 17 ++++
> >  6 files changed, 204 insertions(+)
> >  create mode 100644 tools/binman/etype/efi_empty_capsule.py
> >  create mode 100644 tools/binman/test/319_capsule_accept.dts
> >  create mode 100644 tools/binman/test/320_capsule_revert.dts
> >  create mode 100644 tools/binman/test/321_capsule_accept_missing_guid.dts
> >  create mode 100644 tools/binman/test/322_capsule_accept_revert.dts
> >
> > diff --git a/tools/binman/etype/efi_empty_capsule.py b/tools/binman/etype/efi_empty_capsule.py
> > new file mode 100644
> > index 0000000000..d2c781627b
> > --- /dev/null
> > +++ b/tools/binman/etype/efi_empty_capsule.py
> > @@ -0,0 +1,91 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (c) 2023 Linaro Limited
> > +#
> > +# Entry-type module for producing an empty  EFI capsule
> > +#
> > +
> > +import os
> > +
> > +from binman.entry import Entry
> > +from binman.etype.section import Entry_section
> > +from dtoc import fdt_util
> > +from u_boot_pylib import tools
> > +
> > +class Entry_efi_empty_capsule(Entry_section):
>
> Do you think this could subclass Entry_efi_capsule? They seem to do
> similar things. You could call generate_capsule() or
> generate_empty_capsule(). depending on whether any data is present
> (and perhaps require an operation if no data).
>
> I'm not sure about this, just an idea.

Okay, let me try this out. If it is getting too confusing or unclear,
I will keep the two entry types separate.

>
> > +    """Generate EFI empty capsules
> > +
> > +    The parameters needed for generation of the empty capsules can
> > +    be provided as properties in the entry.
> > +
> > +    Properties / Entry arguments:
> > +    - image-guid: Image GUID which will be used for identifying the
> > +      updatable image on the board. Mandatory for accept capsule.
> > +    - accept-capsule - Boolean property to generate an accept capsule.
> > +      image-type-id
> > +    - revert-capsule - Boolean property to generate a revert capsule
> > +
> > +    For more details on the description of the capsule format, and the capsule
> > +    update functionality, refer Section 8.5 and Chapter 23 in the `UEFI
> > +    specification`_. For more information on the empty capsule, refer the
> > +    sections 2.3.2 and 2.3.3 in the `Dependable Boot specification`_.
> > +
> > +    A typical accept empty capsule entry node would then look something like this
> > +
> > +    empty-capsule {
> > +            type = "efi-empty-capsule";
> > +            /* Image GUID for testing capsule update */
> > +            image-type-id = SANDBOX_UBOOT_IMAGE_GUID;
> > +            accept-capsule;
> > +    };
> > +
> > +    A typical revert empty capsule entry node would then look something like this
> > +
> > +    empty-capsule {
> > +            type = "efi-empty-capsule";
> > +            revert-capsule;
> > +    };
> > +
> > +    The empty capsules do not have any input payload image.
> > +
> > +    .. _`UEFI specification`: https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> > +    .. _`Dependable Boot specification`: https://git.codelinaro.org/linaro/dependable-boot/mbfw/uploads/6f7ddfe3be24e18d4319e108a758d02e/mbfw.pdf
> > +    """
> > +    def __init__(self, section, etype, node):
> > +        super().__init__(section, etype, node)
> > +        self.accept = 0
> > +        self.revert = 0
> > +
> > +    def ReadNode(self):
> > +        super().ReadNode()
> > +
> > +        self.image_guid = fdt_util.GetString(self._node, 'image-guid')
> > +        self.accept = fdt_util.GetBool(self._node, 'accept-capsule')
> > +        self.revert = fdt_util.GetBool(self._node, 'revert-capsule')
>
> Perhaps it should be
>
> operation = "accept" / "revert" ?
>
> Using two conflicting bools is not great.

Will change

>
> > +
> > +        if self.accept and not self.image_guid:
> > +            self.Raise('Image GUID needed for generating accept capsule')
> > +
> > +        if self.accept and self.revert:
> > +            self.Raise('Need to enable either Accept or Revert capsule')
> > +
> > +    def BuildSectionData(self, required):
> > +        def get_binman_test_guid(type_str):
> > +            TYPE_TO_GUID = {
> > +                'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
>
> Can you put this in a shared file somewhere, used by this and the
> efi_capsule.py module?

Okay. I will put this in a separate global function, and use it in the
other module.

>
> > +            }
> > +            return TYPE_TO_GUID[type_str]
> > +
> > +        uniq = self.GetUniqueName()
> > +        outfile = self._filename if self._filename else 'capsule.%s' % uniq
> > +        capsule_fname = tools.get_output_filename(outfile)
> > +        guid = self.image_guid
> > +        if self.image_guid == "binman-test":
> > +            guid = get_binman_test_guid('binman-test')
> > +
> > +        ret = self.mkeficapsule.generate_empty_capsule(self.accept, self.revert,
> > +                                                       guid, capsule_fname)
> > +        if ret is not None:
> > +            return tools.read_file(capsule_fname)
> > +
> > +    def AddBintools(self, btools):
> > +        self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index 2b8871ab7e..9286de28e4 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -126,6 +126,9 @@ FW_MGMT_GUID = '6DCBD5ED-E82D-4C44-BDA1-7194199AD92A'
> >  CAPSULE_IMAGE_GUID = '09D7CF52-0720-4710-91D1-08469B7FE9C8'
> >  # Windows cert GUID
> >  WIN_CERT_TYPE_EFI_GUID = '4AAFD29D-68DF-49EE-8AA9-347D375665A7'
> > +# Empty capsule GUIDs
> > +EMPTY_CAPSULE_ACCEPT_GUID = '0C996046-BCC0-4D04-85EC-E1FCEDF1C6F8'
> > +EMPTY_CAPSULE_REVERT_GUID = 'ACD58B4B-C0E8-475F-99B5-6B3F7E07AAF0'
> >
> >  class TestFunctional(unittest.TestCase):
> >      """Functional tests for binman
> > @@ -7283,6 +7286,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >
> >          self.assertEqual(payload_data_len, int(hdr['Payload Image Size']))
> >
> > +    def _CheckEmptyCapsule(self, data, accept_capsule=False):
> > +        if accept_capsule:
> > +            capsule_hdr_guid = EMPTY_CAPSULE_ACCEPT_GUID
> > +        else:
> > +            capsule_hdr_guid = EMPTY_CAPSULE_REVERT_GUID
> > +
> > +        hdr = self._GetCapsuleHeaders(data)
> > +
> > +        self.assertEqual(capsule_hdr_guid,
> > +                         hdr['EFI_CAPSULE_HDR.CAPSULE_GUID'])
> > +
> > +        if accept_capsule:
> > +            capsule_size = "0000002C"
> > +        else:
> > +            capsule_size = "0000001C"
> > +        self.assertEqual(capsule_size,
> > +                         hdr['EFI_CAPSULE_HDR.CAPSULE_IMAGE_SIZE'])
> > +
> > +        if accept_capsule:
> > +            self.assertEqual(CAPSULE_IMAGE_GUID, hdr['ACCEPT_IMAGE_GUID'])
> > +
> >      def testCapsuleGen(self):
> >          """Test generation of EFI capsule"""
> >          data = self._DoReadFile('311_capsule.dts')
> > @@ -7347,5 +7371,33 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >          self.assertIn("entry is missing properties: image-guid",
> >                        str(e.exception))
> >
> > +    def testCapsuleGenAcceptCapsule(self):
> > +        """Test generationg of accept EFI capsule"""
> > +        data = self._DoReadFile('319_capsule_accept.dts')
> > +
> > +        self._CheckEmptyCapsule(data, accept_capsule=True)
> > +
> > +    def testCapsuleGenRevertCapsule(self):
> > +        """Test generationg of revert EFI capsule"""
> > +        data = self._DoReadFile('320_capsule_revert.dts')
> > +
> > +        self._CheckEmptyCapsule(data)
> > +
> > +    def testCapsuleGenAcceptGuidMissing(self):
> > +        """Test that binman errors out on missing image GUID for accept capsule"""
> > +        with self.assertRaises(ValueError) as e:
> > +            self._DoReadFile('321_capsule_accept_missing_guid.dts')
> > +
> > +        self.assertIn("Image GUID needed for generating accept capsule",
> > +                      str(e.exception))
> > +
> > +    def testCapsuleGenAcceptOrRevert(self):
> > +        """Test that both accept and revert capsule are not specified"""
> > +        with self.assertRaises(ValueError) as e:
> > +            self._DoReadFile('322_capsule_accept_revert.dts')
> > +
> > +        self.assertIn("Need to enable either Accept or Revert capsule",
> > +                      str(e.exception))
> > +
> >  if __name__ == "__main__":
> >      unittest.main()
> > diff --git a/tools/binman/test/319_capsule_accept.dts b/tools/binman/test/319_capsule_accept.dts
> > new file mode 100644
> > index 0000000000..4d6c005019
> > --- /dev/null
> > +++ b/tools/binman/test/319_capsule_accept.dts
> > @@ -0,0 +1,16 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       binman {
> > +               efi-empty-capsule {
> > +                       /* Image GUID for testing capsule update */
> > +                       image-guid = "binman-test";
> > +                       accept-capsule;
> > +               };
> > +       };
> > +};
> > diff --git a/tools/binman/test/320_capsule_revert.dts b/tools/binman/test/320_capsule_revert.dts
> > new file mode 100644
> > index 0000000000..eeaa2793a5
> > --- /dev/null
> > +++ b/tools/binman/test/320_capsule_revert.dts
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       binman {
> > +               efi-empty-capsule {
> > +                       revert-capsule;
> > +               };
> > +       };
> > +};
> > diff --git a/tools/binman/test/321_capsule_accept_missing_guid.dts b/tools/binman/test/321_capsule_accept_missing_guid.dts
> > new file mode 100644
> > index 0000000000..6f7062e83e
> > --- /dev/null
> > +++ b/tools/binman/test/321_capsule_accept_missing_guid.dts
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
>
> I wonder if those two lines are needed? Perhaps it generates a warning?

Tbh, I just copied them from another file which I was using as a
reference when I introduced the capsule changes. I will check if
removing them causes any issues.

-sughosh

>
> > +
> > +       binman {
> > +               efi-empty-capsule {
> > +                       accept-capsule;
> > +               };
> > +       };
> > +};
> > diff --git a/tools/binman/test/322_capsule_accept_revert.dts b/tools/binman/test/322_capsule_accept_revert.dts
> > new file mode 100644
> > index 0000000000..c68e76a669
> > --- /dev/null
> > +++ b/tools/binman/test/322_capsule_accept_revert.dts
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       binman {
> > +               efi-empty-capsule {
> > +                       /* Image GUID for testing capsule update */
> > +                       image-guid = "binman-test";
> > +                       accept-capsule;
> > +                       revert-capsule;
> > +               };
> > +       };
> > +};
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
