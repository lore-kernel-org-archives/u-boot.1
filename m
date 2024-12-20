Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35450E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16071803A9;
	Fri, 20 Dec 2024 18:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YjX1JLCj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABE4D80381; Fri, 20 Dec 2024 18:37:09 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31410803DC
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aabfb33aff8so393824066b.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734716227; x=1735321027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8R5ob/eAwMO+zND5/MLZoje5ZrquACi2kSDtTWi7z/o=;
 b=YjX1JLCjg1MZC6LKbI0PD4IfbNBwBHGtp8JRzF7bCUZsCQDhaXn+W93hE8JyL0F18I
 pxp7EoZ0h8Lk4UokWmo1mfGugt5fHMDGekt0NjuFU+8KwLN2qQiPr+883dfj/H1hzOPQ
 R8YXdGj3qGSf5JMyb70BDllBal+PnvEkd1+b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734716227; x=1735321027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8R5ob/eAwMO+zND5/MLZoje5ZrquACi2kSDtTWi7z/o=;
 b=s3sSl8S9ArOtfh4/n+vhyGm/nvIkemd8Vnm5y158rZ5kkDGpc0lZ5hd7UMnJNTgMKS
 RHCn5iap8utJeN/WvMTWRCyjIRtC12YrfOlbj4Lr/t3TfwuvECh4uafw5Z99myb40EkD
 CEPgax0N/7PSRlYKTjPbPrFyNdb3txQuDTlJVXrGZQZ2/m8GQNIwXxxyiAxv+KH1Oxdk
 ebQJPZF9aTAC0CSpfbo9UFQsJIRTG45b/zj+8CY7RD8gQJuFrE/dT2jPY3IzgQpbLZV1
 /QWqMXBaNnNG8/jHZDqqfl6LvEpeXIvVotBUVXoS/eKa1JFCEFvEb12zrMSHhXyRjBFM
 KQhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0I4bgR2C/6H8pBBTVqDoyHONkZ2GKsjW5hx0RXa6bQ4R7+6WpRn1Yy1Bh3tUO/3zoOw75prc=@lists.denx.de
X-Gm-Message-State: AOJu0YxfkpuWjEJcyKE8FsxbBwOE7J0Mls9q67tHLpaEemTytlNUQv0T
 ZdfNxNLmftD+MEdOWgfBg/J1R5Wqc+0O8iV2mZiSQkyd8wNjZAddkTAad0UuSBuEyJckHwkm0vJ
 o4z1zB4eiCH160eaoUkHR/dgU0dBiwbX8t7HD
X-Gm-Gg: ASbGncv5IFwzFF7PfLX9olR4dgMD77ja9dBZ/YmLz6rn5RgJVjguYLMgY5at6V5+qX+
 9j6uIyzH3nYsdqBiDod+6oTgRF9+pOqoFX4ChDug=
X-Google-Smtp-Source: AGHT+IHmDfFCdxd/w2ZDLbFyHKVXIX3vdq3XuyhMSSKC364mgslc9L4p83JzxoIttQJu2DTvvvP6VxAhajtrJYxfQb0=
X-Received: by 2002:a17:906:f5aa:b0:aa5:53d4:8876 with SMTP id
 a640c23a62f3a-aac08228224mr723894266b.20.1734716226536; Fri, 20 Dec 2024
 09:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-14-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-14-ba81dfd8e369@oss.nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Dec 2024 10:36:52 -0700
Message-ID: <CAFLszTjnsGe2Q6jcj3EFqCnOv8z=vVkNW-QUtURvTyvHY+cNCQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/17] binman: add a new entry type for packing DDR PHY
 firmware images
To: Alice Guo <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Thu, 19 Dec 2024 at 19:56, Alice Guo <alice.guo@oss.nxp.com> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> i.MX95 needs to combine DDR PHY firmware images and their byte counts
> together, so add a new entry type nxp-append-ddrfw for this requirement.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  tools/binman/entries.rst               | 14 ++++++
>  tools/binman/etype/nxp_append_ddrfw.py | 78 ++++++++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
>

Please note that you should create a test[1] for any new Binman etype.

You can see the current work on this[2], which failed apparently due
to a bug in the 'cst' tool.

> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 83068ba6d39d9a5b586312fd4a062b0da31eb595..061bd2f1da9812d36c90b1fb10a919667e36ceaa 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -1658,6 +1658,20 @@ Properties / Entry arguments:
>
>
>
> +.. _etype_nxp_append_ddrfw:
> +
> +Entry: nxp-append-ddrfw: pack NXP LPDDR firmware
> +---------------------------------------------------
> +
> +Properties / Entry arguments:
> +    - oei_m33_ddr_image - M33 DDR IMAGE
> +    - lpddr_imem - Synopsys LPDDR PHY firmware
> +    - lpddr_dmem - Synopsys LPDDR PHY firmware
> +    - lpddr_imem_qb - Synopsys LPDDR quick boot firmware
> +    - lpddr_dmem_qb - Synopsys LPDDR quick boot firmware
> +
> +
> +
>  .. _etype_opensbi:
>
>  Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
> diff --git a/tools/binman/etype/nxp_append_ddrfw.py b/tools/binman/etype/nxp_append_ddrfw.py
> new file mode 100644
> index 0000000000000000000000000000000000000000..bc23a7611eaf823651a8fcbc9898c9140c277d7f
> --- /dev/null
> +++ b/tools/binman/etype/nxp_append_ddrfw.py
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright 2024 NXP
> +
> +from binman.etype.section import Entry_section
> +from dtoc import fdt_util
> +import os
> +
> +class Entry_nxp_append_ddrfw(Entry_section):
> +    """NXP M33 OEI DDRFW

Here you should describe the entry type so people know what it is for.
Is the word 'append' needed in the name?

> +
> +    Properties / Entry arguments:
> +        - oei_m33_ddr_image: M33 DDR IMAGE
> +        - lpddr_imem: Synopsys LPDDR PHY firmware
> +        - lpddr_dmem: Synopsys LPDDR PHY firmware
> +        - lpddr_imem_qb: Synopsys LPDDR quick boot firmware
> +        - lpddr_dmem_qb: Synopsys LPDDR quick boot firmware

It isn't clear what these things are. Please add a bit more detail
about how to get these things and what they are.

From what I can tell, I think you should add each of these as a new
etype. See for example Entry_intel_fsp_m.

Then in your image description you specify how these are packed together.

> +    """
> +
> +    def __init__(self, section, etype, node):
> +        super().__init__(section, etype, node)
> +        self.required_props = ['oei_m33_ddr_image', 'lpddr_imem', 'lpddr_dmem',
> +                               'lpddr_imem_qb', 'lpddr_dmem_qb']

Properties should use hyphens rather than underscores, to fit with
devicetree usage.

> +
> +    def ReadNode(self):
> +        super().ReadNode()
> +        self.oei_m33_ddr_image = fdt_util.GetString(self._node, 'oei_m33_ddr_image')

This looks like an output file. Binman handles this side of things and
you should not have etypes writing out files themselves.

> +        self.lpddr_imem = fdt_util.GetString(self._node, 'lpddr_imem')
> +        self.lpddr_dmem = fdt_util.GetString(self._node, 'lpddr_dmem')
> +        self.lpddr_imem_qb = fdt_util.GetString(self._node, 'lpddr_imem_qb')
> +        self.lpddr_dmem_qb = fdt_util.GetString(self._node, 'lpddr_dmem_qb')
> +        self.ReadEntries()
> +
> +    def BuildSectionData(self, required):
> +        u_boot_path = os.path.abspath('.')
> +
> +        oei_m33_ddr_image_path = os.path.join(u_boot_path, self.oei_m33_ddr_image)


> +        lpddr_imem_path = os.path.join(u_boot_path, self.lpddr_imem)
> +        lpddr_dmem_path = os.path.join(u_boot_path, self.lpddr_dmem)
> +        lpddr_imem_qb_path = os.path.join(u_boot_path, self.lpddr_imem_qb)
> +        lpddr_dmem_qb_path = os.path.join(u_boot_path, self.lpddr_dmem_qb)

> +
> +        if (not (os.path.exists(oei_m33_ddr_image_path) and
> +            os.path.exists(lpddr_imem_path) and os.path.exists(lpddr_dmem_path) and
> +            os.path.exists(lpddr_imem_qb_path) and os.path.exists(lpddr_dmem_qb_path))):
> +            print("Please check if there are any external blobs that do not exist.")
> +            return b''

Missing blobs are handled automatically by Binman.[3]
> +
> +        lpddr_imem_size = os.path.getsize(lpddr_imem_path)
> +        lpddr_dmem_size = os.path.getsize(lpddr_dmem_path)
> +        lpddr_imem_qb_size = os.path.getsize(lpddr_imem_qb_path)
> +        lpddr_dmem_qb_size = os.path.getsize(lpddr_dmem_qb_path)
> +
> +        with open(oei_m33_ddr_image_path, 'rb') as file:
> +            oei_m33_ddr_image = file.read()

oei_m33_ddr_image = tools.read_file(oei_m33_ddr_image_path)

> +
> +        length = len(oei_m33_ddr_image)
> +        if (length % 4 != 0):
> +            oei_m33_ddr_image += bytes(4 - length % 4)

Binman handles alignment automatically. It just needs to be in the description

It seems that this etype is putting some files together with a little header.

> +
> +        fw_header = lpddr_imem_size.to_bytes(4, 'little') + lpddr_dmem_size.to_bytes(4, 'little')
> +        with open(lpddr_imem_path, 'rb') as file:
> +            lpddr_imem = file.read()
> +        with open(lpddr_dmem_path, 'rb') as file:
> +            lpddr_dmem = file.read()
> +
> +        fw_header_qb = lpddr_imem_qb_size.to_bytes(4, 'little') + lpddr_dmem_qb_size.to_bytes(4, 'little')
> +        with open(lpddr_imem_qb_path, 'rb') as file:
> +            lpddr_imem_qb = file.read()
> +        with open(lpddr_dmem_qb_path, 'rb') as file:
> +            lpddr_dmem_qb = file.read()
> +
> +        data = oei_m33_ddr_image + fw_header + lpddr_imem + lpddr_dmem + fw_header_qb + lpddr_imem_qb + lpddr_dmem_qb

So ddr-image should be its own etype (probably just a one-line thing like fsp-s

The next bit is a fw_header plus two blobs, so that should be in an
'lpddr' etype

The final bit is qb (?) which should be in a 'qb' etype, or some better name.


> +        length = len(data)
> +        if (length % 8 != 0):
> +            data += bytes(8 - length % 8)

In the end you will have very little code and an image description like:

oei-m33-ddr {
   align-size = <4>;
};
imx-lpddr {
   align-size = <4>;
  imx-lpddr-imem {
   };
   imx-lpddr-dmem {
   };
};
imx-lpddr-qb {
   align-size = <4>;
   imx-lpddr-imem-qb {
   };
   imx-lpddr-dmem-qb {
   };
};

Please let me know if you need help with any of this.

> +
> +        return data
>
> --
> 2.34.1
>

Regards,
SImon


[1] https://docs.u-boot.org/en/latest/develop/binman_tests.html
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=430428&state=*
[3] https://docs.u-boot.org/en/latest/develop/package/binman.html#external-blobs
