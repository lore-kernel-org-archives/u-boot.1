Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4B606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pUtWjLHF;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=4LQFWVOO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD7AE80D4A;
	Sun, 22 Nov 2026 18:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnnGJuAtFMUk; Sun, 22 Nov 2026 18:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90BAD80D45
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795372050;
	b=SRjGqcCJEHKEjotmVAjWF7wzpxfmOHq2DoPysmLER30oho+ctvUdu68GZwgNHP2IKDkT
	 JCxXhlr2LRaGWdWtOPNcMNi5l9ZRCwVN/czjVx+Tu3TEPvsLoLkvvP6BFCSJGc5NOHGPd
	 qEwGRGRvM/oavAV0PphoBfP0q6y9pX+wAhPJ1edqa8vJUCul1Mc9rbMOgBMt38sAep07R
	 7b5JOtx6vDeQBy7htlyeuF5HBFxgKWKX3KsOFWQXXz8KHaLnU7iMvXyB2sHtfVyzevp9l
	 ikV78yMMiDVGE4HIU5r9MJbNtfBito5MU++lf54BuZzV/lZ91KAwusLptzDhRn+l6Mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795372050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fYomWgE/MX45RyZYESLrD0ps9iU8ehBBO7vNH6CXj2s=;
	b=p3XvxdSnNnLakNpw/kkzsZMe6EJZabFRxBV74RptEcZIidSgZEG/innPkNXsu6ip6OUq
	 UJ3jw0V8HC8U2Du/Jeh7EpaR32mw/bkjRRwGeJXodT+MdXW1qB6F7iQkfwHvfDYjlm+KJ
	 kyly0PwTPooY0hnbN9Q3j1Jw09JklopHmPqJK6w3h85xO5jJhcKZ+8V3N0Y9otACGhuQ/
	 U0JfhHF/CoxIyNuzW4DL0m0KJ2lPQT24ejIOd/h4VsS4Rm+T6bNwGhSNkLa3oAd0c4J1z
	 91GCvariu3DaYlYRxgNBw/TNA4pfc5Zuar49PF9A/CFXFUqHWhso9ia9Xls3mFtmWDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=4LQFWVOO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795372050;
	bh=fYomWgE/MX45RyZYESLrD0ps9iU8ehBBO7vNH6CXj2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pUtWjLHFrYkpjrK/AnBtRE6THDAIrg8tw9wClkjQxC2lrZw61hXbcy6AUMxQpUGyF
	 dDL3VhSTAS3ey5kG+e3x67Ye0f5ow8zpgzp0BHFSdeFPVvmpV7iSFuVDRiaRr8Nu+F
	 sK35gkmGAw3yP+AlvAiyCHo2lsqaQcNphUdKzQuhVelAGCKmSBiU8pXu89/ASo9s3O
	 puJCHSqJ3155mB/4SMnW4TGSlD3nMPN5SKNo4KX/AbYrw13KqyPb0xe7GHFyE0+UYN
	 nWlghEvSeyzYl1Xwp6XKKA4B8bs8DplnHsNrpReg5qZlh6FjwwK6Yye8SEAX9mSb0e
	 NOrj2LqQXO3yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90BAD80D45;
	Sun, 22 Nov 2026 18:27:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C9EB81AB
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFAEA80D45
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LTve8mFYc92k for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 18:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44BC580D44
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4LQFWVOO
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44BC580D44
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 18:27:27 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c515319dd89so270010866b.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1795372046; x=1795976846;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fYomWgE/MX45RyZYESLrD0ps9iU8ehBBO7vNH6CXj2s=;
 b=4LQFWVOOy79BLtY0CiVu9BCIbIta7Qbm6Rhj8czYnQeMEezzeBr6ZrnZqjERPOarIf
 GBfeyE7BkkPhM1XSML0UHMEeK1cHtyUQBiYNA8e1XDbqCF5gr2OanqknH8Qq7x2P5sZj
 tXiCjT1U0A7SGD3+Tjhb8XlyFzYDD0ymts5Mce5SSZLNaq53kZK0AsewBqxqV545b38Z
 ex06pMLdwPdwSKSaAVpkMvXyACcC6ZjmAjaBGkxCJCS+fhMEHPJ8mnEBxYpS81AsLYk6
 d8a7zIYFRzOjbSSkOc4mLoQraTf7VYVUDwCkHuJkNBlAsTmTUdtqMHi7mpgljn1TgUdO
 7l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795372046; x=1795976846;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fYomWgE/MX45RyZYESLrD0ps9iU8ehBBO7vNH6CXj2s=;
 b=SOdUKtFlTDZHvtJqiaaZNtkZNMbtZvRDRn4JWVLg/NDHsAUberLLtAwoErqtVy/rdO
 nSooKTVfOGi2r356Dpnn4CDhGLwcUEEg0VCfaCMrxVg6bdBz8qlTcbne14xx5hxAyMjG
 2nqJ8Gh0NDyHPIQ1WIAfqquBylOMeUDH8ge+9PeFkbnW+jexwKNEBboVaGPvwzx7Nui7
 V+0nh72fGz5w2mZwy4gkWxCsu9kJBrAxiLVGeAqLvlkE6CV/9Uw5+1nT2Ahc9aLm2/GN
 Fb06vB6U5bt88dcySpfdYWrt6KeBoFutAjak+jjnpMQTEM2pxFAGhpDZ1hIqFfODjnYm
 GL4A==
X-Forwarded-Encrypted: i=1;
 AL+hErGQwOM7pgTbawhEzGrmXN+crFb0tngomFWalGySo5bH1nxwe/dne/NpPHqm+2unveiy+ASo1LY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/U6C/7RXlkPehBcQF7+Dsn4hrh6IaETALTEQP1VM27IrxRy9/F
 d1rOSzIFmW3uQ7CNqnnVlYzuy2edWeVwQlUh2kvLBtiVZpOn1TsR+Xyj0Q1NBAwOUAWGHUfz77f
 ZMHfrHET2vxvi2MMYwsXb5yORpodrQdD9q8jn5s5loBNWysRHpmkH
X-Gm-Gg: AZFdTZeHX4e+E5GVmZWFOB7QiGLsn549MZgsah6nb46yXQZ6Rr0YmaThHFM/tv/yq/b
 YILy4+lrTzT1vUGGBRGVEioNaMHOBSMTN9VOz4SaxuFlUChoLou+2y/vwvE/S2SUtUYwjjNIB3/
 xF0yr7Q4Oz1+qy7ZDmhZLPQbXIlpzFekhPzNu4rdwSGrZdrkbhrFMfGax5cTVYO7I8yKnvdWmY+
 7eJa2JUCsvM/AybL4HbFHHXYza9ag7/a5fzp0u++s5QBwKdJ5Z8KtKeE+jRgIx/nqqrkiOdViHu
 1OozhdKglFCqJ7RRaDM6Hc6Y/+gEdsUL53XmkyobKGcv3F19hYNFAmfCqpJ4ilkhARp5r+Wf0+q
 M5LTHIZ4RvO+OGlWfPFMKAokuLaVL20mcGBLc7nmVZoPYQh9iFtNhb9OzA2spWRm+lm6W
X-Received: by 2002:a17:906:d328:b0:c3f:153a:865f with SMTP id
 a640c23a62f3a-c513ab0350cmr592017466b.40.1795372045806; Sun, 22 Nov 2026
 10:27:25 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023-rk3576-load-addr-v2-0-d2a42a1e90df@flipper.net>
 <CAKTNdwFiLosr+8DiXpsvLkVu77hgGC1VUcmBbcp9CGCK58qAnw@mail.gmail.com>
In-Reply-To: <CAKTNdwFiLosr+8DiXpsvLkVu77hgGC1VUcmBbcp9CGCK58qAnw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Sun, 22 Nov 2026 22:27:15 +0400
X-Gm-Features: Aa3M54pFG4WeGXKIYabhiTYi1ih28pbtBqCKvGKnEEn0jk9KxH-7CjqQSN3mpF8
Message-ID: <CAKTNdwG_6TOtGhgm7TbfLT=wf9HU76acdGzvGLABgXAKeQ+mvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rockchip: Use one memory layout for the default
 load addresses
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org, 
 Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Nov 9, 2026 at 6:10=E2=80=AFPM Alexey Charkov <alchark@flipper.net>=
 wrote:
>
> On Fri, Oct 23, 2026 at 6:36=E2=80=AFPM Alexey Charkov <alchark@flipper.n=
et> wrote:
> >
> > v1 moved SYS_LOAD_ADDR on RK3576 only. As Jonas pointed out, the other
> > SoCs using ROCKCHIP_COMMON_STACK_ADDR share the same DRAM layout, so th=
is
> > version gives all of them a common SYS_LOAD_ADDR default, and applies t=
he
> > same treatment to the default environment, which so far came in three
> > different variants.
> >
> > The resulting layout, as offsets from the start of DRAM:
> >
> >   0x00000000  SPL, then TF-A from 0x40000 (first 2 MiB reserved)
> >   0x00200000  SPL: RAM boot FIT (SPL_LOAD_FIT_ADDRESS)
> >               U-Boot: scriptaddr, pxefile_addr_r, fdt_addr_r,
> >                       fdtoverlay_addr_r
> >   0x00600000  U-Boot: kernel_addr_r
> >   0x00800000  SPL: U-Boot proper (TEXT_BASE)
> >   0x03b00000  SPL: stack, heap and BSS, up to 0x03f88000
> >   0x04000000  SYS_LOAD_ADDR (SPL staging buffer, U-Boot loadaddr)
> >   0x05000000  U-Boot: ramdisk_addr_r
> >   0x0b000000  U-Boot: kernel_comp_addr_r
> >
> > SPL stages the data of a GZIP or LZMA compressed FIT image at
> > SYS_LOAD_ADDR before unpacking it. On PX30, RK3328 and RK3399 the old
> > 0x800800 has sat inside U-Boot proper since TEXT_BASE moved to 8 MiB, s=
o
> > enabling SPL_GZIP or SPL_LZMA there makes SPL unpack U-Boot over its ow=
n
> > input. Elsewhere, the old values cap a RAM boot FIT at 6-10 MiB. 64 MiB
> > is the first round address above SPL's own memory, which already caps a
> > RAM boot FIT at some 57 MiB, and still leaves room to stage into on RK3=
506
> > boards with 128 MiB of DRAM.
> >
> > The environment layout keeps everything up to the ramdisk below U-Boot
> > proper relocated to the top of 128 MiB of DRAM, and keeps loadaddr out =
of
> > the windows the other addresses need. On larger boards that trades some
> > headroom: 74 MiB for the kernel in bootstd flows, which never use
> > loadaddr, and 96 MiB for the ramdisk, where most SoCs had 128 MiB and
> > unlimited respectively. As far as I can tell, this is the only way to
> > make the layout uniform across every board with the common memory
> > layout, the small RK3506 ones included. I'd like to follow up with an R=
FC
> > series that sizes the load windows at runtime from the available DRAM,
> > so that boards with more memory can again afford larger images.
> >
> > OP-TEE, when present, is a FIT loadable that SPL places at its link
> > address: 768 MiB into DRAM for upstream OP-TEE, clear of everything abo=
ve,
> > and 132 MiB for the rkbin binaries, which the default environment does =
not
> > account for, as before. The SPL staging buffer cannot reach either, sin=
ce
> > in the FITs binman generates the only compressed image, U-Boot proper (=
or
> > the kernel, with the Falcon mode series [1]), loads before any TEE.
> >
> > Tested with buildman on all 156 Rockchip boards, and on Flipper One rev=
.
> > F0B1C2 and F0B0C1 (RK3576), RAM booting from maskrom: BLS boot of a
> > compressed kernel through booti, a zstd compressed U-Boot proper, and
> > Falcon mode [1] with a zstd compressed kernel, both staged at
> > SYS_LOAD_ADDR.
> >
> > CI for this series: https://git.u-boot-project.org/u-boot/contributors/=
alchark/u-boot/-/pipelines/1708
> >
> > [1] https://patch.msgid.link/20260731-atf-falcon-v2-0-acb97c172993@flip=
per.net
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> > Changes in v2:
> > - Set SYS_LOAD_ADDR from a Kconfig default for every SoC with the commo=
n
> >   memory layout, instead of in each defconfig (Jonas)
> > - Move it to 64 MiB into DRAM (0x44000000 on RK3576, was 0x48000000)
> > - Add a shared default env memory layout for the same SoCs
> > - Link to v1: https://patch.msgid.link/20261021-rk3576-load-addr-v1-1-2=
b38b39044ac@flipper.net
> >
> > ---
> > Alexey Charkov (3):
> >       rockchip: Use a common SYS_LOAD_ADDR clear of SPL and the RAM boo=
t FIT
> >       rockchip: Define the env memory layout before rockchip-common.h
> >       rockchip: Share one default env memory layout between common-stac=
k SoCs
>
> Quentin, could you please give this series a look? It touches quite a
> few files, so it would be great to have it merged (if it looks okay)
> to minimize future conflicts.
>
> Jonas, your thoughts would be very much appreciated, too, given your
> extensive experience with all the different Rockchip SoCs.

Gentle ping. It's been a month with no reaction to this series, and it
would be great to get merged in order to unblock the other updates
I've been doing, starting with SPL decompression. As it is, a lot of
boards would fail to boot with decompression enabled due to overlaps
in the memory layout, which this series removes.

Best regards,
Alexey
