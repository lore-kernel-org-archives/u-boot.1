Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA43606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BVmCpni0;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=jnjeMtn5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81BDE80FAF;
	Mon,  9 Nov 2026 15:41:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bxsB2nq78c2; Mon,  9 Nov 2026 15:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6BFA380F77
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794238894;
	b=XSytjzeo8HBuyKqyOPPbwkFFeE5PGRi+pTjwbcBct756vr4Hpq7ELrvJNa+8hykKeM2E
	 xyOverpC+F+Y5u4+n3w5kznKQWRdn1IHBhOxQKkigglLE53ummXL1ssILww+QeWRrWdxB
	 3XrX6fSE/YZ+1jojfcZr6VUN1SmdAgiEciEXbR0LrVlviTGpOXlB7+F+B66UPhL893eBh
	 wnXu+9/AgZK03uYHUA6Tca+dPrEZ1uvgsnckgnHnwMCwRSH3VBFbwXSILfs44Az4lXCJY
	 aFZ+EEQ9YpdhSDr6OefSQi/Gd1kmaQQBEXhDW/DULVZqE3FN7hsCsWGy+HU6wdve8eA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794238894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YiRoibmKqTGp1cquFsDtadQS7RrCTyZtWASpBIFO9Tk=;
	b=hdxGCwyHz4GOCKB44DDGN2oKetcQv2tUq4MZWQnrU8yrp8RqFxugjvwP9PuW4jZNx5HR
	 Tk8Dqtl13E9D2a/tirPUDfB8o5/TgVC0EjH/6TAUFe8zus+Q3lXLZJfd4rLPcbuTJXgzP
	 jjFvlBGk4DEpuRV/KdQlonJ5+KAHhEDErUAk130CNkZ1Qmck7kZ4SshbuinCucZpCfK2P
	 /vqqMtO0wQiJltJLqYyTmZlbyyU3/2NZhsOvGH8fBnK15fA7fvc7fNILzVyIvvGLLKYja
	 TUHCk0w47TSt6r+th/CgwsD9UB4D/qk57G1sK+UmQSsNFdqsClYu0vCUIV3skC9deaA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794238894;
	bh=YiRoibmKqTGp1cquFsDtadQS7RrCTyZtWASpBIFO9Tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BVmCpni0kyfvDQY7mBRgjXOoalGLEifQ1MFgXRrnzw5v9Uy1D+JU1XogRAUMPoltl
	 lcmyscoEGQWESOFSd/p8JtCHV5w1aPUZtczxm4aavht7Ms8yPb8s2/1jaDuCKSNU6Z
	 sEQz1czTxQonu7mn0fjGvS4MzyDzavuFHgFOFrQJt92NhIxYzX9rpRfqKs2onjhWS2
	 OlKym7L/n+rG4dOwwE34V+Tj2aB0QVhuWXdNsPHbxNkBtoBPZ2bvTLe/udU+gp1nLF
	 rAwdOoLSu5yNANl+uUOvCT7I2qqqhSbvCakOVDdOTYq+rzLCAGtXfXTYjheolo9fXC
	 DKLZ10nuYQa8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BFA380F77;
	Mon,  9 Nov 2026 15:41:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91AB9235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 779956074D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9qRUlJCJE4Ot for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:10:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1D55C6072A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=jnjeMtn5
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D55C6072A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:10:48 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c434376dbebso163577166b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1794233446; x=1794838246;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YiRoibmKqTGp1cquFsDtadQS7RrCTyZtWASpBIFO9Tk=;
 b=jnjeMtn5q+MgV/RBfwGTVG6XX2GqCXX+kkFu6EwLbOKuGjzQCN/r/nzqEM4aFhS7PM
 jX2jyBGE0Yc8h6ayUF9zIZB1WYLeJr3/Wh63JPAKlHOIu/cg58KVhhCCymcf2PzSF/u3
 ykIJxNpGdJJtPPJVYcLSXMHDLluREu+Xgv7zT2cXnJoMsJkTOhe6IEffcsk+4BBbwEbV
 duxNM5C7cIE9wzD3L4kvYrA4Ww2x4notrr6SsItceepQ+zIyJEdrSwxWJvNGkfCUjE4P
 8mxcONwGLk2LXLal5LE2vXuE+h90q3txfNaUdboI/uxVlu5AKtR8xmC5QRADixwnMlZN
 UzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794233446; x=1794838246;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YiRoibmKqTGp1cquFsDtadQS7RrCTyZtWASpBIFO9Tk=;
 b=rlqfitVpCGsPpxaHIxrB7UXPv6lIO2sD25oPLxKziFDtSEMThWFXTcp3cTLgjBJq0x
 eY8yEt6PpjIYCgXyyfCZRk1IWa7ZZ4gi150qTcKIU2jSheK3CJZx4JukMLNRD/5dSRHe
 j36GH1GaFeTIWxmfVtaUJzZPtHTVaRQfaegxZuAyOvBfgAfRfnhnRoXLalSv+8BnfpRV
 aKAXjKERJRouQK1o0SBNdlYdSjwVb80WXt/zoxKLkXisKBKOUj0omuIAl1w5bN7oufSx
 n33VAmuzhl5Bek2SbLj6FySJYdj7XK9DNrLaGPodf6aQRihtzLugza0l15Przi25sdg7
 tvvA==
X-Forwarded-Encrypted: i=1;
 AL+hErGgkSMgdS10bIMH+3wEFflmbRo4Y1FAFwo+uQ4pF1E6BA9rL1O41Y61gGo2vjqa8BwZh2Wc7Iw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+2wp18Jf02oUHGOBq5dxaWmVv0HGpJLsYZtM9jGNgItYp7mmVS
 EmoR5DEjLckFWUE46B5gicg1YVUH2fciwKzVfqVfihebVWjTh/uPVBVi3H+rGawcV4EaTXDUPRf
 zO2iTPC3kqg0MAABKoBiUsncq889fYXgzZAbpl++BcQ==
X-Gm-Gg: AYBFou0WcyEKNzYh3ZKClclk6WLJdfXucBQM24qkaw8UfoEpg00ZaOa0vlBBIELUZd4
 ZCe+ePgtVEosAPIXte/NlmEJsC9Lnt/kwO8k71TOJMnM3VEZOXiyh5GMtwO+3/I2vofIpHdhkT3
 LT8lq+KEsXn5IgcaFUZN5al/HBoKarMlUCFAAouoJ4g7pGikXwxayCLvHYVSyrd6DUorE7gVtYO
 3PAnbZMVrrekOUuKvaJKDz2YHbs7oRBexZQV86bYJ6fhoEAaZrSHEd6Zc9P7UYRk6lauioTkhgi
 8DB9wrmAxVm4aCRaBizCwvm9AqfYtmG8vZtRGbq74fP3ZdmpUXQC4gi6hLRGdC+vyBjrLPiNgX7
 bwqh/G/QNkGPwNLSnhcwT3yewksbhbB2QLncc1h3N2pNGUHqabjOi4r3EcuiUPo6mT6aM
X-Received: by 2002:a17:906:794f:b0:c46:ca2b:84ab with SMTP id
 a640c23a62f3a-c4d527845d5mr482243966b.13.1794233446348; Mon, 09 Nov 2026
 06:10:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
In-Reply-To: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 9 Nov 2026 18:10:34 +0400
X-Gm-Features: AclHuK_RwzmpAstVArk7hZTM8Hi8gVLY_6QJOn8xT24QUkBowsnZqjQlqSujrKs
Message-ID: <CAKTNdwFiLosr+8DiXpsvLkVu77hgGC1VUcmBbcp9CGCK58qAnw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rockchip: Use one memory layout for the default
 load addresses
To: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Coia Prant <coiaprant@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andy Yan <andyshrk@163.com>, 
 Liangbin Lian <jjm2473@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Tianling Shen <cnsztl@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Chukun Pan <amadeus@jmu.edu.cn>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Nick Xie <nick@khadas.com>, 
 Jiehui He <jiehui.he@foxmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 John Clark <inindev@gmail.com>, Deepak Das <deepakdas.linux@gmail.com>, 
 Alexandre Vicenzi <linux@alxd.me>, David Bauer <mail@david-bauer.net>, 
 Xiaobo Tian <peterwillcn@gmail.com>, Sebastian Kropatsch <seb-dev@mail.de>,
 Ilya Katsnelson <me@0upti.me>, 
 Niu Zhihong <zhihong@nzhnb.com>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@kernel.org>,
 Levin Du <djw@t-chip.com.cn>, 
 Fabio Estevam <festevam@nabladev.com>, Akash Gajjar <gajjar04akash@gmail.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>,
 Banglang Huang <banglang.huang@foxmail.com>, 
 Eugen Hristev <ehristev@kernel.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, 
 Jianfeng Liu <liujianfeng1994@gmail.com>, Lin Huang <hl@rock-chips.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Elon Zhang <zhangzj@rock-chips.com>, 
 Joshua Riek <jjriek@verizon.net>, Johan Jonker <jbx6244@gmail.com>,
 Torsten Duwe <duwe@lst.de>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:41:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 6:36=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> v1 moved SYS_LOAD_ADDR on RK3576 only. As Jonas pointed out, the other
> SoCs using ROCKCHIP_COMMON_STACK_ADDR share the same DRAM layout, so this
> version gives all of them a common SYS_LOAD_ADDR default, and applies the
> same treatment to the default environment, which so far came in three
> different variants.
>
> The resulting layout, as offsets from the start of DRAM:
>
>   0x00000000  SPL, then TF-A from 0x40000 (first 2 MiB reserved)
>   0x00200000  SPL: RAM boot FIT (SPL_LOAD_FIT_ADDRESS)
>               U-Boot: scriptaddr, pxefile_addr_r, fdt_addr_r,
>                       fdtoverlay_addr_r
>   0x00600000  U-Boot: kernel_addr_r
>   0x00800000  SPL: U-Boot proper (TEXT_BASE)
>   0x03b00000  SPL: stack, heap and BSS, up to 0x03f88000
>   0x04000000  SYS_LOAD_ADDR (SPL staging buffer, U-Boot loadaddr)
>   0x05000000  U-Boot: ramdisk_addr_r
>   0x0b000000  U-Boot: kernel_comp_addr_r
>
> SPL stages the data of a GZIP or LZMA compressed FIT image at
> SYS_LOAD_ADDR before unpacking it. On PX30, RK3328 and RK3399 the old
> 0x800800 has sat inside U-Boot proper since TEXT_BASE moved to 8 MiB, so
> enabling SPL_GZIP or SPL_LZMA there makes SPL unpack U-Boot over its own
> input. Elsewhere, the old values cap a RAM boot FIT at 6-10 MiB. 64 MiB
> is the first round address above SPL's own memory, which already caps a
> RAM boot FIT at some 57 MiB, and still leaves room to stage into on RK350=
6
> boards with 128 MiB of DRAM.
>
> The environment layout keeps everything up to the ramdisk below U-Boot
> proper relocated to the top of 128 MiB of DRAM, and keeps loadaddr out of
> the windows the other addresses need. On larger boards that trades some
> headroom: 74 MiB for the kernel in bootstd flows, which never use
> loadaddr, and 96 MiB for the ramdisk, where most SoCs had 128 MiB and
> unlimited respectively. As far as I can tell, this is the only way to
> make the layout uniform across every board with the common memory
> layout, the small RK3506 ones included. I'd like to follow up with an RFC
> series that sizes the load windows at runtime from the available DRAM,
> so that boards with more memory can again afford larger images.
>
> OP-TEE, when present, is a FIT loadable that SPL places at its link
> address: 768 MiB into DRAM for upstream OP-TEE, clear of everything above=
,
> and 132 MiB for the rkbin binaries, which the default environment does no=
t
> account for, as before. The SPL staging buffer cannot reach either, since
> in the FITs binman generates the only compressed image, U-Boot proper (or
> the kernel, with the Falcon mode series [1]), loads before any TEE.
>
> Tested with buildman on all 156 Rockchip boards, and on Flipper One rev.
> F0B1C2 and F0B0C1 (RK3576), RAM booting from maskrom: BLS boot of a
> compressed kernel through booti, a zstd compressed U-Boot proper, and
> Falcon mode [1] with a zstd compressed kernel, both staged at
> SYS_LOAD_ADDR.
>
> CI for this series: https://git.u-boot-project.org/u-boot/contributors/al=
chark/u-boot/-/pipelines/1708
>
> [1] https://patch.msgid.link/20260731-atf-falcon-v2-0-acb97c172993@flippe=
r.net
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v2:
> - Set SYS_LOAD_ADDR from a Kconfig default for every SoC with the common
>   memory layout, instead of in each defconfig (Jonas)
> - Move it to 64 MiB into DRAM (0x44000000 on RK3576, was 0x48000000)
> - Add a shared default env memory layout for the same SoCs
> - Link to v1: https://patch.msgid.link/20261021-rk3576-load-addr-v1-1-2b3=
8b39044ac@flipper.net
>
> ---
> Alexey Charkov (3):
>       rockchip: Use a common SYS_LOAD_ADDR clear of SPL and the RAM boot =
FIT
>       rockchip: Define the env memory layout before rockchip-common.h
>       rockchip: Share one default env memory layout between common-stack =
SoCs

Quentin, could you please give this series a look? It touches quite a
few files, so it would be great to have it merged (if it looks okay)
to minimize future conflicts.

Jonas, your thoughts would be very much appreciated, too, given your
extensive experience with all the different Rockchip SoCs.

Best regards,
Alexey
