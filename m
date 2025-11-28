Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DE2CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:44:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD41D84513;
	Fri, 28 Nov 2025 15:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A78dCUsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759D284564; Fri, 28 Nov 2025 15:44:50 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260BE83BC4
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-640a3317b89so2975326a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764341086; x=1764945886; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOfKEWhYLa/93hDNiMUI7MXq4M3+aCGRZy67ctClsm8=;
 b=A78dCUsN6fqIq9LwK+TNIzt2O7CUr2BIsqQ08yShaUptZybEPegO+eG6Wjn11/VRHl
 WrsIoHIuaIoWZUch0wjVagMt4e6GGta2DZwx8EYADTyPkpUWYru4AxqUSxDdyXCTHqER
 GceY49pGQmKzjsNxJzP665BlzwB72KkTmH4RWJrnc3kUk4NwRnhi62/FL1E7PqWBm5M2
 omAT3tb0hRc7ZQQ3PdXmSs8FbJw/beBN1SzIZ9P2AVVqIMElibAKO7S1RTGiCvoR5at7
 OtVBN30hFOiW9xiT7ZE8DN5FaVUeFXRtDIj9UuIQzic5dkd/yJzsjwIrLwT7wxkT8248
 oqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764341086; x=1764945886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qOfKEWhYLa/93hDNiMUI7MXq4M3+aCGRZy67ctClsm8=;
 b=urjoOIdqzihmulX3xErdAEBpgBkfmzUYCY0etxfxDfCvQOfARkX1dg/jYrUHsEBu6X
 EIkemNnuQF4gSB56gxjx8YcaNaWYQyGwycY2Wb1bRfnHYHt36KmCAZSROfV/FXSKwpS5
 gIxdSjZmIiX8WA58tZ/P7MdQEx21jkp3tMNECcoC1Cc++qyJOA3/i0AdwJXV4ctgFaOY
 YqreX1jSNYe4cqokVm343iddr9Q5kmKhXfxIqbBFDIAKKNg80kfmlo69xvkZDE17m/u6
 JITK/xUspBLZAetnN3AhuiWkl3eBWKZAgv6GVQJWT1BGZsvN0QYYF0u+G4G/zg0VpbWS
 7/mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5ZsUr9ffS9cNyKmwWwxsJE6kxn5DKCkVKBY24GoydH4H4RP/tCjtCaQHGFziQg8YOLlxwglg=@lists.denx.de
X-Gm-Message-State: AOJu0YzlSLaFofxORkvQd4JVnJZnjrgEs42LZ2QbJaJeAfQoDsKTPIu/
 2EyR4/bP6NTya0ZRpOn696DxL721PPsYy0Uf0ljuquF+bF//tk5njk+QPKe44gUkE0kjrZwgmSN
 EMSyRkATDIw/BxL1EmDNkur52kpaRPYI=
X-Gm-Gg: ASbGncsfLyImpn3DGs3KCpS+vH89TawHO0SKsYoLGWwciVRokF0BxuAvaLocZsUiYcn
 OjnmYQOpiT32rfi1fkYNwt59nsALD4p1Nfl2IQcHQhiSmFXkfVOjVyOr6sIUaux+9MBlEcL87zR
 tUJTHXEkhIoDWNmQ+z8Y1P/18Q7Yp/G7Oq8R6PbqMQWfDHke/mb5kI/EuWagYOp8PTdCBVlK6Fs
 rhLIf9OstawHPoBnvStjlsROTuxsg4FbiwPnYf9qOGWD18W4tQ9UxrI/tkwir8f3rtHSHCMPEdD
 sjPm+hjKadldD3lkWcRLLSHTttjNwN5daIGnWkksI5rK442pP+Sva5wubJ5Z+XDxGktSCLEInHt
 VEPbuHQH1bBKfYYHL70o8qTsMJQREQxGpMA0al9weOteRMYrSvADmt1KA7iD5vqLS
X-Google-Smtp-Source: AGHT+IEIPsLulj+I5xBeeEvWFpRkyKAUeLNiaeqF/zZ5p+3yVqBFJLauEt5gB7VYZGeYbMFfNI5cGOOyhHajaMLG3RI=
X-Received: by 2002:a05:6402:5203:b0:643:c8b:8d61 with SMTP id
 4fb4d7f45d1cf-645eafad307mr15078839a12.0.1764341086010; Fri, 28 Nov 2025
 06:44:46 -0800 (PST)
MIME-Version: 1.0
References: <20251105163553.15F2A227AAC@verein.lst.de>
 <20251105164435.A409F227AB0@verein.lst.de>
In-Reply-To: <20251105164435.A409F227AB0@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Nov 2025 14:44:34 +0000
X-Gm-Features: AWmQ_bll2EKh88pL5lwGixdK2Ji5OmFEA5uFkX7EehA11D3vYLbLkF3AFwZbWik
Message-ID: <CALeDE9PA43V3_GB0051_ZPze9YhRXqhg6GD7Do=VJYMT6SmvoQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/4] Fix #cells lookup in of_get_dma_range
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Huan Zhou <me@per1cycle.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 5 Nov 2025 at 16:44, Torsten Duwe <duwe@lst.de> wrote:
>
> of_get_dma_range uses (of_bus *)->count_cells to look up the
> #cells for addresses and sizes. It tries to do so for the current
> device node and for the parent tree. count_cells defaults to
> of_bus_default_count_cells, which _starts_ looking at the parent
> node already, and then upwards. The correct way is to use
> of_simple_*_cells for the current node, and count_cells(dev) for
> the parent tree.
>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

There can't be the same person sign off and review, were the reviews
on the public list?

> ---
>
> Here is the original, very detailed analysis and explanation

It would likely be useful to make this more succinct and put the most
useful bits of it in the commit, in documentation or something
similar.

> [edited] :
>
> According to the Section 2.3.9 of the Device Tree specification[0]
> the format of the value of the dma-ranges property is an arbitrary
> number of triplets of (child-bus-address,
> parent-bus-address, length).
> Where:
> * The child-bus-address is a physical address within the child bus=E2=80=
=99
>   address space. The number of cells to represent the address depends on
>   the bus and can be determined from the #address-cells of this node
>   (the node in which the dma-ranges property appears).
> * The parent-bus-address is a physical address within the parent bus=E2=
=80=99
>   address space. The number of cells to represent the parent address
>   is bus dependent and can be determined from the #address-cells
>   property of the node that defines the parent=E2=80=99s address space.
> * The length specifies the size of the range in the child=E2=80=99s addre=
ss
>   space. The number of cells to represent the size can be determined
>   from the #size-cells of this node (the node in which the dma-ranges
>   property appears)
>
> This description matches comments in the of_addr source code. But the
> actual implementation does not match the specification.
> 'of_match_bus' returns address-cells and size-cells of the parent
> device. That's why the following calls were used to receive addr_cells
> and size_cells of the current device:
> - of_simple_addr_cells
> - of_simple_size_cells
>
> This fix was tested on RPI5 board with both device types: directly
> connected (e.g Serial) and connected over PCIe (e.g ethernet).
>
> For example when dma_ranges are parsing the following device tree
> structure:
> / {
>         pcie2: {
>                 #address-cells =3D <3>;
>                 #size-cells =3D <2>;
>                 // 64GB system RAM space at PCIe 10_00000000
>                 dma-ranges =3D
>                            <0x02000000 0x00 0x00000000
>                             0x1f 0x00000000
>                             0x00 0x00400000>,
>                            <0x43000000 0x10 0x00000000
>                             0x00 0x00000000
>                             0x10 0x00000000>;
>                 rp1: {
>                         #address-cells =3D <2>;
>                         #size-cells =3D <2>;
>                         dma-ranges =3D
>                         // inbound RP1 1x_xxxxxxxx -> PCIe 1x_xxxxxxxx
>                           <0x10 0x00000000
>                           0x43000000 0x10 0x00000000
>                           0x10 0x00000000>,
>
>                         // inbound RP1 c0_40xxxxxx -> PCIe 00_00xxxxxx
>                           <0xc0 0x40000000
>                           0x02000000 0x0 0x00000000
>                           0x0 0x00400000>,
>
>                         // inbound RP1 0x_xxxxxxxx -> PCIe 1x_xxxxxxxx
>                           <0x00 0x00000000
>                           0x02000000 0x10 0x00000000
>                           0x10 0x00000000>;
>                 };
>         };
> };
>
> So when we parse ranges on rp1, #address-cells of the rp1 node should
> be taken into account.
> In the provided example we have the following format:
> pcie2:
>    #addres-cells =3D <0x3>;
>    #size-cells =3D <0x2>;
>    dma-ranges =3D < addr_hi addr_mid addr_lo
>                   trans_addr_hi trans_addr_lo
>                   size_hi size_lo>;
>
> rp1:
>    #addres-cells =3D <0x2>;
>    #size-cells =3D <0x2>;
>    dma-ranges =3D < addr_hi addr_lo
>                   trans_addr_hi trans_addr_mid trans_addr_lo
>                   size_hi size_lo>;
>
> of_get_dma_range searches for the first dev with dma_ranges
> and then executes of_match_bus which follows by count_cells call
> for both device and parent.
>
> count_cells returns #address-cells for the parent device to
> the caller.
> So in the provided example address cells should be 2 for rp1,
> but we get 3 when using count_cells.
> This breaks address translation and is fixed in the provided patch
> by using the of_simple_addr_cells call, which will return correct
> address-cells for the node. This matches the requirements of the
> device-tree specification.
>
> [0] https://readthedocs.org/projects/devicetree-specification/downloads/p=
df/latest/
>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

There's more sign offs?

> ---
>  drivers/core/of_addr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/core/of_addr.c b/drivers/core/of_addr.c
> index 250dd175b55..823a4d70a6b 100644
> --- a/drivers/core/of_addr.c
> +++ b/drivers/core/of_addr.c
> @@ -374,16 +374,16 @@ int of_get_dma_range(const struct device_node *dev,=
 phys_addr_t *cpu,
>         }
>
>         /* Get the address sizes both for the bus and its parent */
> -       bus_node =3D of_match_bus((struct device_node*)dev);
> -       bus_node->count_cells(dev, &na, &ns);
> +       na =3D of_simple_addr_cells(dev);
> +       ns =3D of_simple_size_cells(dev);
>         if (!OF_CHECK_COUNTS(na, ns)) {
>                 printf("Bad cell count for %s\n", of_node_full_name(dev))=
;
>                 ret =3D -EINVAL;
>                 goto out_parent;
>         }
>
> -       bus_node =3D of_match_bus(parent);
> -       bus_node->count_cells(parent, &pna, &pns);
> +       bus_node =3D of_match_bus((struct device_node *)dev);
> +       bus_node->count_cells(dev, &pna, &pns);
>         if (!OF_CHECK_COUNTS(pna, pns)) {
>                 printf("Bad cell count for %s\n", of_node_full_name(paren=
t));
>                 ret =3D -EINVAL;
> --
> 2.51.0
>
