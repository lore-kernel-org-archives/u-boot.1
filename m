Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568D606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wlt9QE5N;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=4eGF1LVS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 315586079A;
	Tue, 20 Oct 2026 18:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qtl08JbTiewN; Tue, 20 Oct 2026 18:01:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D6206075D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519285;
	b=DjYAxVsGhHzdw1uBwzjRpdZWOgILaR1Hrpsr4JKsZl0MJEBSZenMBLCp2AXgdjBY2NWb
	 A9X6xixks2otpwQHkHiqiv0B/etXVkaJAe/ibc7UQ5eQkudhE9WlDSpwkk7SkaUjeY1Ca
	 BNZOyprOv+MATrg42TrT4PSJjOjX3crUaSFOvuEYg5VkUWxaJ2UWvuomjxV5zqigDnTLW
	 ktTdPuBSATyqiXUy7rTef4fdfZIK3c+AJBHauSQeWXblbA5nx67D8iS85cdSxhpedV/sN
	 589A1OV+qEvgeCN+XXchDw3AIi8U5QqmLqk4UFuuFUazxSeU1ltPaUa2M31bzzOaQ/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792519285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jki0rZVpIQHfTNzIzZ8WPLJs15NrhED+MsMHQGaHlsM=;
	b=MjleeKusQSH8/calDrIFOqwQnLWjhap+dK3wUiXt1ssECT/PeyviZIyfTU3+v7+vHq4Q
	 M1wvBbqvC48o46ED16lKW3wV1rIEtI9z21T5AWv8kJg6KT41sdR3pwuFirmD2Wv9YRyCu
	 4OUk9dHqiwOF9g0+36Ye+d6ZKVqWCchfXh3un/sqjzq/3Kd/ETpOnOryAVfrFlTscEvIE
	 Z+lWvAneGgm/yHj9HaFigPeFdul8A609DTak1BKLL31xyOhmFhTYnzoRs+0KyvoVJ3fOT
	 ns5jAQNk5/R/s4IxxLDIRRCM+5W9CLv9GlgbPoTAnseAtFvvnNK/YVwSBocoJPWwVIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792519285;
	bh=jki0rZVpIQHfTNzIzZ8WPLJs15NrhED+MsMHQGaHlsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wlt9QE5NTwByX5fRLWb8w3SBr9kS5dmrwjk9R8MxfqKwII0mWFqpqFQ+XgzC8CL+E
	 ZJMPNWnitsEJOIQKy+ouMWl1Rk6OzVn3tFxMdGsa0QmSHx4i6TR5WnrB3YxY/j4hL7
	 441tIYaV+uOgPVNpvhK4J93c31CMVPAolSmD1rC9RPEfdqpZHi+016wBIAwYrUG6Fg
	 X7UiMrssk6cdlRqA60shkOfBjwxm249FB0eAEhKLzgelqE0etrLU0YkCcMrKG5aWIw
	 NW9Y5Ci3Zy+z2t4HpqiYaSodjle2tFCvrd+wz8xQRCbJpSldgVwiQcAAl8RREwjnLW
	 r5sYTEyS1Ii7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D6206075D;
	Tue, 20 Oct 2026 18:01:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF92A3A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:01:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D59F14016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:01:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGSQiQ3drcb4 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 18:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E7A6B40060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519278;
 b=WLWosA3hqG2w1WNsfkpTy9ssBY/qDH24LHWwHlPKmteEukNkcjfaLHh9CXSYd6uixf6B
 D1n2xC6qaPpoIwse+JDB/PIcU9MM0vXHVatz6hIuQgO0uftOHd47PPVfHN7FrnUD0r9K+
 dQEJ3jarpp6LLbSDP7zsuHLE/IbvKg0hpJ6M/dbYMoWXZsKCMMQ59qA1VFPu3uCEIOgmF
 f8vPfKp2zfwzcvW8SBhhaS/zkC9eXG+ATrFy289M+ftxsJvgJE03pKejvc2gqrKUGkiWD
 YuBfiqOW/3oW1mwIvw8KeEeV2DBWW+alBgrlMTsZR7A9bC39itx7g0B+Jvmc/VzOGDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792519278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=jki0rZVpIQHfTNzIzZ8WPLJs15NrhED+MsMHQGaHlsM=;
 b=jBFk5yExIzun+sfLiSnfKRShyH0VUQpcarR+dYuJD3yc8FGFGwe0xvre1eUBMtdkmBax
 901SNc0e6N8LD9clni3W3qOWHBHhTXyUVePsYxBf56J8AwzCoUbmj8qklkPzya6GXMojk
 KYEQi25zhveAbsQWsD6iC4+tLmwPC3eE2WZVxox9Aw6+ODfgumWhJzq3t/j94RYQoUWQA
 GhMumoyF22QdjICD0bTtoStEIR4jp72WHMuw+bMuKHwYQXXZybI181KB4ej/T6rV/ByzL
 GQSruwFBO3Plr5QwAbyLqWEU4irbYhvWg9rbc74jNaOQyPwPnInzaKYbIMcrlmzrWXw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4eGF1LVS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4eGF1LVS
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7A6B40060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 18:01:17 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so4228462a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 11:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519275; cv=none;
 d=google.com; s=arc-20260327;
 b=rPxZ/PUBrPk+iKpWDN9KVLztt3IUmUgGUZFLriNKEDX2X5XsaEz493yX2NSWS/7Exz
 GejPMME0VmA8f+E1/Gzytgbdw0ruHttVzbaCv7C7UlyIkevKDrYzUj3lZnKkJDWxb7zL
 E9tkvWXE1SR2zAcnYgPyd3cDz2abNk5xM7TruK6Y037u6TuF3KvMUzo1XNnRzMmbuWdq
 k0dJ6PblxD6Gke6FRK6S353gLMu6Gj78axP87Ssws9A1HoUyVtlg/J/XPN+deZvjBvjc
 POF/qFrh+yesZdETdQtWhXnYZjKdFdpubHZKNpg0dMzuumhZ5OhjfeZRejim4+1WVZ3E
 Ohsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jki0rZVpIQHfTNzIzZ8WPLJs15NrhED+MsMHQGaHlsM=;
 fh=b1HhqqtG3fvJp2PXOgPblI9YMnwvJDd5vnbI1iU+qR4=;
 b=lGIvshJ9jOzDugVlfBRq3I8Jkju90gr4kP6k/ElSmgky8BZ2RMh4ltsi/erYbS7bdR
 1qMoiEAN8RHzRm9+JfGQNVAOeIKQSiYUM52N+QQcflqR0XTZwf4OC6r8GcBIiFwHPEL3
 Il6A/i3oInTiGO2wxpOdHXoXUVY2OFJFSa1qidaIlbB9DZ7mtXg35gk4UK4h64k7OzyB
 eTiy+OvfSevesA6FWVQHvyfVgCxM1JjbTlusKLzDs3j57ssHTAKjlfXej3tsCCmqXmZk
 ZJLzEq6O9Xge5S5aHBOLCcXzP0KtNM3c7LyRmAIOaKwNQz9/CDgL6o2DyZFxFp9H6Qfk
 9BvA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792519275; x=1793124075;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jki0rZVpIQHfTNzIzZ8WPLJs15NrhED+MsMHQGaHlsM=;
 b=4eGF1LVSd4MB13ue6c7vEb+LKUZ2oeeSnoyc9byuKHoInhPzf1LJNvUaH/MlC/oTEg
 IyGY00crRlL8Zi6LVONX3W1dBXM7jjFNldA7HDgZH5i9BXDh+2QH1AVM+Ab70yGsxEtU
 r5R35LocNabs5f3evt5WiHmbOs7agv2kiDnkJptwpLMeKgjvjLhrvtPr4ZuAWk2khQmC
 ZYtPh527c8Ko/Pba8WX9X3E90f1a0m/MHuqtvZp1aoN1ZbMMkKNs0Ch7KNU6LOn9dClh
 EcQISwInixFreHL9k6ow6fnOojlA8bm3XM30iaIExKy0wIQhIF4Lq7ipHzYECVFWsS4G
 cbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519275; x=1793124075;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jki0rZVpIQHfTNzIzZ8WPLJs15NrhED+MsMHQGaHlsM=;
 b=k6SihTVSowILlAur2z+aOmgzZgvrPQInVJKsIf6Ve8UZeDWgaW+q1W+4WVdfjJR2hB
 2rqp7sJSMhpRlBkrIJ+QE5P0SBjnvE2t22tHdbjUbEBCsWIXnb5gQqRC/r8+XPrr1Yzk
 RNSZYwHS4SqyBGxcIXoxYRd7002Aq4cV1QW0XRwZ4Z5WgJKc3b8Ww0Gxdk+gvtE9BuWj
 FmiXb0nlCIqdQvI6hTOrnGp2tBU9Hrl3LFbQI011L25uU4E6IoKkXmWvE99Eyf6qMgzW
 hYmeF0qCg4cQq1/vWmmcu1H2SWVm0lI+lUysRrHajfWTdvZrMP70al1twGi70/dc/3rl
 y0fg==
X-Gm-Message-State: AFq9FYKvJQLWbhXBijAelrBNxCPz+pAwANyFsSR7sQhqjSN4XQDnNVm1
 4pLqGc4vkRvrUMHwjbZc/qwEZ9zc5BH/4JVwE4K35cirsJ/HpP2vaAYb7VvXhSMrYeDj4LjQhab
 Wf9OuMtlT30vqcVYHck7HPbIpjN3lE6/KPvUoUUouqxNpU6GGNX64Yhntmg==
X-Gm-Gg: AYBFou3OGz65a5Xn+QEV57nhJ7xmGrOCm0v8/zr0rSwpAmf/LrU9Pa7ceRDS+ETQm8+
 tcfY8HZgnW1o4FN8YMKuEmzDPrX5dr/kYxoNG6tAjKcgGwdVSx4/uKig3ZgtlVg2JC6IBfNkqIh
 Fu/SLDNdz595gSMwj2h4KavqrOofBtcz1T6Wr5fGTGeUtSjASD+932YioB+wXr6JzgWwlkbOx5y
 EsNYGpJBEDe3946XVEzV2xUxiIwlE/nYrnb+utAkg6E6hb+Uhf3+je86denvDm8bOTvl++m4z3p
 oFdZElVcyNLspmlK/vHWtEFSfa9b5pFZ3bkR1N9k2kFRELi6ZJL6t+NqnDap6iAc9ewEUSC9/Sg
 mwOzyN7atWzSN
X-Received: by 2002:a17:907:c642:20b0:c41:a5da:1511 with SMTP id
 a640c23a62f3a-c41a5da279bmr584455066b.25.1792519275130; Tue, 20 Oct 2026
 11:01:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
 <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
In-Reply-To: <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 20 Oct 2026 22:01:04 +0400
X-Gm-Features: AclHuK-UGjEBucvlVeoN3NzSll0z54AynB4esHKxz5kJMvXSkqXRlDouQu9epyA
Message-ID: <CAKTNdwG22u_51cBLbu3wufBdB9ojSQqGMPMG58x-Nk7u_xC6sg@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On Tue, Oct 20, 2026 at 9:47=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Alexey,
>
> On 10/20/2026 6:41 PM, Alexey Charkov wrote:
> > No in-tree board picks a compression for U-Boot proper, so CI never
> > builds the compressed path of the Rockchip FIT, nor links zstd into an
> > arm64 SPL.
> >
> > Turn it on for the generic RK3576 image, at the highest level, which
> > shrinks the payload from 690KB to 296KB. The image is meant to boot fro=
m
> > whatever medium the board has, so this suits it, and its SPL heap and
> > SYS_LOAD_ADDR already leave the decompressor room to work.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  configs/generic-rk3576_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_=
defconfig
> > index 5e25653820c2..dec4364876b6 100644
> > --- a/configs/generic-rk3576_defconfig
> > +++ b/configs/generic-rk3576_defconfig
> > @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=3D0x2AD40000
> >  CONFIG_DEBUG_UART_CLOCK=3D24000000
> >  CONFIG_DEBUG_UART=3Dy
> >  # CONFIG_BOOTMETH_VBE is not set
> > +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=3Dy
> > +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=3D19
>
> I do not like this, it breaks consistency with the other RK generic
> targets, which are meant to be as lean and bare minimum as possible, not
> a playground for testing features, we have sandbox for that ;-)
>
> Please enable this feature on a real target, not a target meant for
> basic board bring up and recovery.

It is in fact quite helpful for recovery workflows, because it
massively reduces the size of the maskrom 0x472 payload, which as you
are well aware is quite a thorn in the backside, given the boot ROM
peculiarities. My reasoning is that the generic board build will be
much more likely used over maskrom than flashed to storage, unlike all
the other targets, so enabling compression here is pretty much a
no-regret move. As long as it works, of course, but that's what we
have tests for (and CI).

FWIW, I'm also using Zstd decompression in SPL on the Flipper One with
Falcon payloads, but it's not upstream yet.

Best regards,
Alexey
