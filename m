Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22936C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABE1581BF4;
	Thu, 24 Sep 2026 12:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X3r6TXZdKXBD; Thu, 24 Sep 2026 12:46:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A111381BB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253961;
	b=ArC9PkNlZaqoJBGEQjFVB3PMuTKRb8yNkuYzXJo65Sxhx4PgfFyNt924ifYSlO48yRHq
	 xMmSXMae4h1WqYWM9UVEiIqNMV7jL2sX2lfpRUHqBnSIjNCI1uYThMxAK0rPzDkhMKkYu
	 np6Wab9WeldnJKxAzJAu0VYvXgOwS6h8h6PuuUe3khNilcMMaihwMzjjEAoR7jfrJk67U
	 hy9AGD92YmaVF7+YtEbTyg5A30M0N37ublb89tRuDcdbOqOqZib9jlBiIcY2KDGXICwDf
	 z/oIluJdWAEIU/OwhMuCoAzbIXMF0uWSbFsIKEXjza9XlC92+AWx3me01lsUgDlXsNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YdWkj/PlRQ7gxuh+Y4pO+rJC2Vf4LWDME0Is4bSj8ng=;
	b=oA7iQOubYBKVtugH4J+XiB1lSqcvENMLdExpR2Ffjgqcp4pcJHivEeIe58tqUGljs4eT
	 Ga5o+GM3Ch6VSLvs/Jc/uDDCoQKlZ1jQuLTo0/4I+YXdFz/iM4i+wB9+Qlbi4pE4e9HRJ
	 F+hymTn0iCllov9Vz9M5ZwNqF68x1qNxDnoUK5iz1pzJtD7J7w1ssKJdx42QFn8ApaoDD
	 xSMT9Tq/cKTUsDNOQIROKhpT9i9fGDnJq/61g8acrUVO/SR1lejI94AkcQpflXl325amO
	 D34nTWGmNAgCKqoAwvTz0WkCZzhVmCSWfOLGQbNN//Yi47g/GHPq7rkcoPPekDgNMNQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253961;
	bh=YdWkj/PlRQ7gxuh+Y4pO+rJC2Vf4LWDME0Is4bSj8ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GbnLQZGfgGDW9CKEI/57KyAAgdqffhHodBLUgK65Sz/CYDZ2z8ZYOoiokDPpn0/iZ
	 QWpEo2MBPzTEuNLMIotzf0z4KJB8ZquwLEuoNAh/lIgmK7qvx5dqu01Z6ZPhc+eW9h
	 O5HrjuRuYAJdZ1FL93u96w7tKeRPhschINrPJeKJIqgkU+R8G5d9EfqVF6fiEPxXWP
	 aYMmlJ2TSIqJf7UwV0AUvpqbxKcWZJMJilLBR5jEg8+4i1Q/wmNVzqC/x+2v3IvF69
	 LuSnK7jzOKj7vRm1IY/9JrPTvWZIU1b36R1ghhRIX5fH2NvStsCmepUITRKnQpSYlQ
	 Dz60dh7Gh39sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A111381BB2;
	Thu, 24 Sep 2026 12:46:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89FED392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:45:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86A14607E4
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:45:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TbT_lz5fGrGt for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:45:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B9F8960699
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::21"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253958;
 b=e9a6GGXMmtmazGtRPr/DuZxkKw6/EM/x12A02jKRbyW5KXaMEGsUR61NC5MUqpOdGB2S
 8U5nxEAV/r+hDLAwcKXaZbMzHDkkRPtTA4ZoygCLwsGGhQx/WsAvLDG6DXbKsehKCYu5s
 tiLzUoo0A2boRPugH1YCfgdWgsqn+CWlki05OT1RuQKTVJRAT0fFuqlAfzi5b87NoeVQp
 CLQLjRxOLxtVT/zTdJ6Tptvf05cnlK3ui5Jnj5YBCHUPdWmYDQGT6p/FClITJbSoH4zFB
 FZGOoRfkXc7ffvWE5XYAKiF/4+Coq/NRt4MQb1guPFyGKMqvfRTqtpahPo1saUf0NQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253958;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=YdWkj/PlRQ7gxuh+Y4pO+rJC2Vf4LWDME0Is4bSj8ng=;
 b=OyBhmbQjhVZ4T8ijE9plt4VBvKymER7QBMAXt2pGYZptstJSTZDO82UxPQ3Nty7RHtvE
 3CephcGbDFC78VqAV2XYpFbvKuioj2jq2Gf9oQoDliCkAVgc+/2/VZOBTP8LY6Yf24l3W
 5hYX6kqqUVKie1HbPs37tv8WZp1EMYbDwRXdFVmEHMs5kLZCrKFDsoC60ErPOerdoOxlA
 Q3Gc/RZQH67+BeMdaxWigTqvZKOZz5u3OkA3CggfpkZwgETfUhA9Cu64OPV2M/X1VehiK
 NGLNVhigRIeuiUEv0xFNgkb62SAX39074xDmNVQXfC1iT3NThKJT0f0hQ4AkcEUTQmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y0fihGMw; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::21"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::21; helo=mail-oi2-x21.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Y0fihGMw
Received: from mail-oi2-x21.google.com (mail-oi2-x21.google.com
 [IPv6:2607:f8b0:4864:32::21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9F8960699
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:45:54 +0000 (UTC)
Received: by mail-oi2-x21.google.com with SMTP id
 46e09a7af769-8144632e066so1167252a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790253954; x=1790858754;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YdWkj/PlRQ7gxuh+Y4pO+rJC2Vf4LWDME0Is4bSj8ng=;
 b=Y0fihGMweXc98cn14WQ5mP7sdmh2yL+SYM7HytL58i+O4nvIJs3HwV5CUsTm9jE7YS
 xKMbGqttQSO3Fo86Wz5TLfJSUeBh5LA9JAjZcg/Vz39a7Tto9JyjjPA/yLlKiwD3+OBs
 nGqn+jb948CKTOuu3U82MaAyuqOUEPJUimknm3MAmauXSMMjzZ56ioRYfenBRrXvlF4z
 IeTruXVwMPzMIzaPEzzUa/jt947DO2+B7Hn0gkOPlocmIXKIEIlJ7rpaqhP/jXZ/JDFg
 VRbrEqS7SB/dByiccx8/0UxOKdZu/LmEoYhaHu3AmNPORd/PobZ3W8guO0QhROVZfTwO
 40zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790253954; x=1790858754;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YdWkj/PlRQ7gxuh+Y4pO+rJC2Vf4LWDME0Is4bSj8ng=;
 b=2fdb70d0VyE/xRPdzCi9OCf0BlYVQxa2OaN75rPkgEOyeJqfV51zropMl1RZUaFdGN
 1F/3WCGkydCZ2NEZqMkny3u3RBycV7y8f+sN8O11NhBmSJQcUE7EEbjCyGUBQcPBqcDR
 l7FASo6K/sLfDkk/UvCg+xVUzKTjuXMTT28GfagZ8aKaD3sqe9BId08d5rDjjDjZfT8l
 HrwPz4gPAsK1KneHqeI3BS0wybDU5V3E3dBdjZfjHz/VOIDe10Ns3fZlAvqKGhmfOn+s
 Sp+RuRlZ0pPSmRzy2+Xv+fkQ1AaVZfdqSWP9pVGPKjRBplQ5fXTGu4Ggp61fp73W0+pE
 /8Qg==
X-Gm-Message-State: AFuF++mK8AW8lqsR9Yy625p4li9UeaYctCBL1KVd0BdX362bdmNOkmrj
 SzcYmyWAUkYI4/H/00gall2JqLU8w8mieSTi5FEwkUGa21EAqoLjZ7lG1Ei/jL4tsJk=
X-Gm-Gg: AYBFou3AWZpfW3Cv8Sx9vIjl3Xl3JaOX7O6ir5DhHJOHdfjdNdUAPowLP9ECTVm182x
 GhFNY/U2lbWixpXIMCAfUDFKkVZQogaIxJLn66WnTbvJKmNwEdVNFECfaIyKA2DRc2YvUUwcl1s
 laW2pCe0U5r/y5VlrpMKXzwmI8ea535eWFVhcktffrHol3fAf0XF7AA8GMV6h2x94UgsCWEo0nE
 erBmKSdnGQJ9IOU7UpP03voNpZs5kS4K29/rzpJV8PqYm6eGv5GH2TBhQp/f8tcaLObA7joxc6c
 EsqC1pUepfQJlm59F2SsKKMwrorBuNYFZyVyFsQgmD3Ec2jkMkPuULuW8rt+PYoe0yH2gVSoZym
 2TIT4xxfaFf2YehvEEE5d2jfqn+UvpXgbQzuCSK1nqg+bK1BwTnY1xtQ8hJR+oRqbOTng8YFFUC
 7yXvW5zrWrb2VjDSiGGteBV9al2FII7k1aJRvQUnn46c1OrFk1s+DWvWbIWWYKDuxFktkm2s7Kk
 kWrrPX/8M85qwrNRjELQ2fWJczDb5IQ
X-Received: by 2002:a05:6830:d0b:b0:800:d883:9988 with SMTP id
 46e09a7af769-8177c6bbdfcmr2627190a34.0.1790253953810; 
 Thu, 24 Sep 2026 05:45:53 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-816044c858bsm6301849a34.19.2026.09.24.05.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:45:52 -0700 (PDT)
Date: Thu, 24 Sep 2026 09:45:41 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>,
 Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Chen-Yu Yeh <chenyou910331@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Kongyang Liu <seashell11234455@gmail.com>, 
 Leo Liang <leo.liang@sifive.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v4 08/11] riscv: milkv_duo_256m: Use upstream devicetree
Message-ID: <arUZwbtnDO9g3cUZ@hiagonb>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
 <20260922-milkv-duo-upstream-dts-v4-8-d45b74dfad36@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-8-d45b74dfad36@zohomail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Zhuxu,

On Tue, Sep 22, 2026 at 11:46:23PM +0800, Zhuxu Ran wrote:
> Switch Milk-V Duo 256M to the upstream SG2002 devicetree by enabling
> CONFIG_OF_UPSTREAM and selecting sophgo/sg2002-milkv-duo256m.
> 
> The upstream devicetree keeps the Ethernet MAC disabled. Add a U-Boot
> override to preserve the existing networking support when the optional
> IO board is attached.
> 
> Remove the local board devicetree and update the OpenSBI build
> instructions to use the upstream DTB.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  arch/riscv/dts/Makefile                         |  1 -
>  arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi | 16 +++++++++
>  arch/riscv/dts/sg2002-milkv-duo256m.dts         | 46 -------------------------
>  board/sophgo/milkv_duo_256m/MAINTAINERS         |  1 +
>  configs/milkv_duo_256m_defconfig                |  3 +-
>  doc/board/sophgo/milkv_duo_256m.rst             |  2 +-
>  6 files changed, 20 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
> index 8ba75fdb9f5..71c5c13d221 100644
> --- a/arch/riscv/dts/Makefile
> +++ b/arch/riscv/dts/Makefile
> @@ -5,7 +5,6 @@ dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
>  dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
>  dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
>  dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
> -dtb-$(CONFIG_TARGET_MILKV_DUO_256M) += sg2002-milkv-duo256m.dtb
>  dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
>  dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
>  dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
> diff --git a/arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi b/arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
> new file mode 100644
> index 00000000000..3872343636f
> --- /dev/null
> +++ b/arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
> + */
> +
> +/*
> + * The Ethernet signals are routed to the RJ45 connector on the optional
> + * IO Board. Keep Ethernet available in U-Boot when the IO Board is attached.
> + */
> +&gmac0 {
> +	status = "okay";
> +};
> +
> +&mdio {
> +	status = "okay";
> +};

I see that milkv_duo_256m_defconfig doesn't enable DM_MDIO, DM_MDIO_MUX
or MDIO_MUX_MMIOREG, so nothing binds to the mdio-mux node.

Note that the upstream gmac0 node uses phy-mode = "internal" and a
phy-handle into the mdio mux, while the old local DT used phy-mode =
"rmii".

Can you check this? Have you tested the ethernet port on Duo 256M?

> diff --git a/arch/riscv/dts/sg2002-milkv-duo256m.dts b/arch/riscv/dts/sg2002-milkv-duo256m.dts
> deleted file mode 100644
> index 4ad86ce39ec..00000000000
> --- a/arch/riscv/dts/sg2002-milkv-duo256m.dts
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> -/*
> - * Copyright (C) 2026 Hiago De Franco <hfranco@baylibre.com>
> - */
> -
> -/dts-v1/;
> -
> -#include "sg2002.dtsi"
> -
> -/ {
> -	model = "Milk-V Duo 256M";
> -	compatible = "milkv,duo256m", "sophgo,sg2002";
> -
> -	aliases {
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -		serial2 = &uart2;
> -		serial3 = &uart3;
> -		serial4 = &uart4;
> -	};
> -
> -	chosen {
> -		stdout-path = "serial0:115200n8";
> -	};
> -};
> -
> -&ethernet0 {
> -	status = "okay";
> -	phy-mode = "rmii";
> -};
> -
> -&osc {
> -	clock-frequency = <25000000>;
> -};
> -
> -&sdhci0 {
> -	status = "okay";
> -	bus-width = <4>;
> -	no-1-8-v;
> -	no-mmc;
> -	no-sdio;
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> diff --git a/board/sophgo/milkv_duo_256m/MAINTAINERS b/board/sophgo/milkv_duo_256m/MAINTAINERS
> index 929960e7251..3488db28145 100644
> --- a/board/sophgo/milkv_duo_256m/MAINTAINERS
> +++ b/board/sophgo/milkv_duo_256m/MAINTAINERS
> @@ -1,5 +1,6 @@
>  Milk-V Duo 256M
>  M:	Hiago De Franco <hfranco@baylibre.com>
>  S:	Maintained
> +F:	arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
>  F:	board/sophgo/milkv_duo_256m/
>  F:	configs/milkv_duo_256m_defconfig
> diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
> index 9d92eec6394..436bdb1549a 100644
> --- a/configs/milkv_duo_256m_defconfig
> +++ b/configs/milkv_duo_256m_defconfig
> @@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x8000
>  CONFIG_NR_DRAM_BANKS=1
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
> -CONFIG_DEFAULT_DEVICE_TREE="sg2002-milkv-duo256m"
> +CONFIG_DEFAULT_DEVICE_TREE="sophgo/sg2002-milkv-duo256m"
>  CONFIG_SYS_LOAD_ADDR=0x80080000
>  CONFIG_IDENT_STRING="milkv_duo_256m"
>  CONFIG_TARGET_MILKV_DUO_256M=y
> @@ -25,6 +25,7 @@ CONFIG_CMD_POWEROFF=y
>  CONFIG_CMD_EXT4_WRITE=y
>  # CONFIG_ISO_PARTITION is not set
>  # CONFIG_EFI_PARTITION is not set
> +CONFIG_OF_UPSTREAM=y
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_NET_RANDOM_ETHADDR=y
>  CONFIG_CLK_SOPHGO_CV1800B=y
> diff --git a/doc/board/sophgo/milkv_duo_256m.rst b/doc/board/sophgo/milkv_duo_256m.rst
> index 9e2cbddf4db..9562e6c48fd 100644
> --- a/doc/board/sophgo/milkv_duo_256m.rst
> +++ b/doc/board/sophgo/milkv_duo_256m.rst
> @@ -46,7 +46,7 @@ To run u-boot.bin on top of FSBL, follow these steps:
>  .. code-block:: console
>  
>     cd open-sbi
> -   PLATFORM=generic FW_FDT_PATH=../u-boot/arch/riscv/dts/sg2002-milkv-duo256m.dtb make
> +   PLATFORM=generic FW_FDT_PATH=../u-boot/dts/upstream/src/riscv/sophgo/sg2002-milkv-duo256m.dtb make
>  
>  This will generate build/platform/generic/firmware/fw_dynamic.bin.
>  
> 
> -- 
> 2.55.0

Regards,
-- 
Hiago
