Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W/KZ1E5J;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=OthgRXdM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F4BD80DBA;
	Fri, 23 Oct 2026 12:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ZXrPXX1lhsE; Fri, 23 Oct 2026 12:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4197880C1E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792757664;
	b=StnRBWTrc52Nxk9BxO6OV1bU4RlVJXgHXmdofIhBIk9eWj+BfBiXbmlIYQRpUhGUlUBL
	 BEOIIZL0MCc8J8GM8EUphNWjqiuk/lFkax80SQn+otSYRlGp4pdwQ3sKM4vlwpltMb4f4
	 9o0shRYyc01ng7clKzRWJVzOMXYIK1V0nstcKtxWpJzsUMmpWwzc2pNjZ76T7VX0hJt2B
	 Frx9kAOQuB9n3+3/ezZsVg1EVZBakzxSGClhgwqy8wIdBLAnirfBiUxM2XjfaNWJzw3ZP
	 25KP+vQtGQDC+KujXarzQZmUURcSOhYPo0LzaEHpIaJX/YR/3CmpCxaV7BExhiKqthw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792757664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4294MmsFuaFACignADA3tXAYTapwAn88rxz0UEG+Vc0=;
	b=LPLFO8n0hr/bghd0CaHp8ify6ipWWZ28Yi9LtvGfBCoairuwU5PNvJUDjCFX+2LHeUKd
	 PL0rXpLdSMyavaoFpJotUaeEWqYDX+PWkdPj5e+454Hz/5+RuWmJSNSngPbGRqDbRW34H
	 m/UiBXnfiwY2kxskn97JkHvoXuyPP4Qi/4pOvoEc16PePHvmo6X2pdHoShoZMynY8XjxP
	 JsIZfMP/zdIT52paq4nJhpTXvFcNmgktUkWwx2fN/fLuC6y7YYsLLK5PwPy3wiQ65p0vk
	 QrlR2pExKr7ue8I3gkIxp7tX8hgve+nKPLCky+map6T6OFRq1PkuMOgB8MoouwVNPHQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792757664;
	bh=4294MmsFuaFACignADA3tXAYTapwAn88rxz0UEG+Vc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/KZ1E5JyqzCwjYphW7I3xSQL5Cph4Xi7Qot9fJTOS9VvS089gy9C3ZmPQz8VS3Ta
	 s8soNqLjvqyW3FnJnDGjwj5Q4d7hXm06UCxuYweGbosVx2ubIvm0MajyIYeNHxJI+4
	 Gqfvet6gg980WZ9Kl7rOj3OoM36LKS//hyBhYpGvYR0bZh9LvWyZCFD6kV/9gVFXSa
	 x0woC+IQOMRpM3jkigaeq9tp+fU1GbhlDuc2HNtzPPdYfXnzQmnF7dX3QgQ0RAwxB8
	 Uz9HTKulkovt1/jw3j2BuQuwbyzwZN8vcNU/cw5ofy7Zv3J+yzMUDl0rQ3+XwfLdo1
	 9fnYSZ7Ujp3Xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4197880C1E;
	Fri, 23 Oct 2026 12:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC9F63C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92EC36068A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5TSREqPBxCA for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 12:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 75BAF6067E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792757662;
 b=P7E40GU0rNkXpmQGxXHi1ifEmjigWrcIwsQ4dlVO0IVH5WeGypgqULX9Fq/FZHlXHv4E
 qyOfhb43NVqx7luEVEbawF2fkqzTiGHDFexFP96P39zA2MHir4Y98ySvOqWyXo6RfQbhc
 FtBxScCLfake2Z6hYF+TYjxBzdwCn1aes8fGwmHBYzBsclp2j5vmzH3L2JsepPm1s2zKB
 6lY6VdvEEVQ7JTwn2NQ0a7LLB1JX974VgmJzVilrhShnr5ZiigKADYlVwQOTqhYkYYz1y
 GvdYdGlYHkyS0X0CV36nAASjnvx+GPnfUw6aW1o/nmVET6lk4LqnQPUt1f28ccTylVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792757662;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=4294MmsFuaFACignADA3tXAYTapwAn88rxz0UEG+Vc0=;
 b=Yo5xwiW/66j3tXvT4iQankMXcrVGfCgiecud5h5/QBKO7xCHZYs5u4j3q5M6PTGmoBFa
 CzL2gVpX6UV8l6ud85TADW1EQTQ3OYuRy74xO0qqs0MEohYgB4VBuuykKgudo8BZvqqqM
 qtIQr1bSpYprLeqkq3b5hMW/KSvgMub37xZXzApecTrK4Om64jph9piX5oEVC7cAGMArP
 sDDnMIoEqx3jAIYa6fvVFLJa2dgRWjLaYG7r6FgqEa90KBwxPp2HcTdJ771UuKfy6MJfL
 h36IgTANv2qMEp0JpOwDfVibg0MynFCMsVs8TApNIF2rrt2WCj6Wu7tOe/2RjiwaAYQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OthgRXdM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OthgRXdM
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 75BAF6067E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:14:22 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso115989066b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 05:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792757660; cv=none;
 d=google.com; s=arc-20260327;
 b=LE/SKJcG2o8FNEO7cUb/YKJQqkrh/Px/XsONksf88bo8THk5ZB8wIOloZATYOIBnZk
 GDMR/Fe38Oap2zUXmRLBRTexgwZhdKI9n6xFexBZRW3S1FmGWIuJlTtuChe4Fti/4cyp
 e6jnQc5h/jXKNM/T0O2riB0Aq1SfMXUKe9vy5daYtzU4vQJMK6oNyM3P1MxvtFs3AYk6
 y60CbvyiueA7Hp0maZtdGBmgYoAkhLtivLycifZ1AvFyet2FD4DXrApHkks90HRpuLmX
 b7XElnVWYfpHQuL5AvUw/ZPLtazG9d0X6hwD+u9lZn7EgvciFgv9aoYYJZQ/HLsyODlE
 0SMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4294MmsFuaFACignADA3tXAYTapwAn88rxz0UEG+Vc0=;
 fh=ouj7yG5RJPg/WiVv3XF2zEVHs1SG5w8KOW2lWWpzQOA=;
 b=nQ6Ub7dyfj3LnFIZ9P1OM8fEwOHUAbGT8zdSFpTCjOH29Ztjeiz9wgwA1hK18/7VYh
 vyX4EFtmWl6F+8mZW9Tp3pcqUBhxQ+2voZ3UHJG/ZkRCx0IVhyARczZbtoI4jB0iGCqL
 IJaULq9pswqFbfUJAr0+jFr3v6QiN3uZo1WF+NmUymUdcA714T3kmpWixCppm/U8aIz+
 9oPRJOJ0nkHI3L24+PFoXsbAt1kS9WfavZnxsvicJOiS9x59rVLHNtSkGnL/qLE0JKIL
 OkSItijam35iKvHX/GDbdyT4cVZHzgef6sqCoEMaTOk26M5ekMun54f7zxRgjuN0WZAe
 UWxg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792757660; x=1793362460;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4294MmsFuaFACignADA3tXAYTapwAn88rxz0UEG+Vc0=;
 b=OthgRXdMy81w7BpBoIj5cbY/+nYn4UVDIZ+aHqHS+ET+Z1XMI5QdqV+zDcoWJKzlij
 cvpYXL8SouOaqhCSRYT3TXeApxJdZWjdwdy3Y5FAR1NNlj6UTWLXDfTEivZ9WuiPAgh2
 O8p1OuriBJzKSVzA5Kk1gGs09nBMTtCiGpdgww0W0fF6xbyp4LEiukkTBwOUxgFCtju4
 MO6CcQFbwsNbx6U+eN2DOB19oliGZ/tFAyuwAhnTPXNURwkZHPZz4EoMUJnrWXyWY+oi
 7Snj6K5KwlUEcyqdH+FUEa8pNwM/QhM1UVnf4b5UzXFxMKfnhg0RpuvPKuMrft46qiH9
 P0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792757660; x=1793362460;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4294MmsFuaFACignADA3tXAYTapwAn88rxz0UEG+Vc0=;
 b=db6RfDmdCDQp9wj+kMlAdXyHgeY7Reop7XOkE3ECNOTCoYGzF1UHiryeJceajHOf/Y
 ttLBF+7kGNAh05o07uCzLuCnnodQBYLGuc8+8+cWy1TlrWFJZZ8+x79UniwSIvZG0p8g
 seVnbdBqfNRdbecwoPDCP7TDu+EkDdXDk+VH+FANR/qz3PCVaxzyOxs15HcmdiTXVnAV
 CZBvqWMKJWGB+xA7k1iXZRpn5d5beOkRforhRw/PLM/peNNogCan0U7QlmSgbJl7DXcS
 SibvctnyyqCwA2YHfxyrE/dwC1ahtHMbO6LBC7QclMd1tJSaaHkPnYoP4vbx2h7QQP+z
 3KGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwFjUqChkZ2vNcFIBE/orEXLRKwH4lPBZID0fEwwVQL2bW1rDc8za/CA61tNXFVnjitE5H9Dc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJLrYmCyGUhRttwis8+b+0PCmlp9rxyl2LnyUgOiZqrWIU07vKg
 vq0Oe7rWIDXbDMVhePnihDtgVIhF0BO2uMdRvTDxEukLEnF05CEkWOcc6hxovfRGOXWDNh4/bLQ
 qUjXOJM6mQa7wXyHQftKgLha958LVQ5TycfjrsZ0KvczlNind3/WMaahxEep5
X-Gm-Gg: AYBFou2ijKQ0h3pG/Lcee9Ogvx3J2/TdWFz/+Hpc1GeF2eIAMXgczNyQB6Nn8PXzwRd
 dpwvQRBr3I4PplQ5krf6Gj7fklGNZrbgU/0Gp3MO0RhmHq5/DIpdp5PhHf22r/Ix8JYNv3W6zDg
 QbqvjCRuppiU3mgx5bvcK7beQ4QGGFbqeunVlH9wlJsWHjcPEgk5gshKI8LOUiucci0+c4gK279
 GhG9EtvFUsXQxeAsbGE0LIHxTbnFQdGCBQwQmltujWN0UkHWY5BEqu413zqzQalMiwCDJPMfM+u
 drnvKBAs+9bVYNtDiAcj+3z8yc9Ge/XN0qxij3AkgHBDt3nsR9jNaA9YBzv6J8AaoU3AO4xyApu
 XOpw4WcGIUFRRfpiK9QrrMEis5FlmonmXFJr6SROmZBnvzwRH9GFwszHqc9BYMtZi6IDsWvotRG
 VYWLQatcWx546y1n0=
X-Received: by 2002:a17:907:6096:b0:c40:6ed9:b962 with SMTP id
 a640c23a62f3a-c46a9024046mr336898666b.26.1792757660264; Fri, 23 Oct 2026
 05:14:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021-rk3576-load-addr-v1-1-2b38b39044ac@flipper.net>
In-Reply-To: <20261021-rk3576-load-addr-v1-1-2b38b39044ac@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 23 Oct 2026 16:14:08 +0400
X-Gm-Features: AclHuK9gLlH2JToAYlq8kgCH2KN3nbT311BhAXAMCsxQCtct63qBSYctOA36Nhs
Message-ID: <CAKTNdwFNu=vG=k_1C9Nm9OkC8yUu-0Ln2Pbg811sFft9MJG55A@mail.gmail.com>
Subject: Re: [PATCH] configs: rk3576: Move SYS_LOAD_ADDR clear of the RAM boot
 FIT
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko@sntech.de>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 6:05=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
>
> SPL stages a compressed FIT image at SYS_LOAD_ADDR to verify and unpack
> it. When booting from RAM, as from Maskrom, the whole FIT already sits in
> DRAM at SPL_LOAD_FIT_ADDRESS (0x40200000), and a large FIT (e.g. carrying
> a Falcon mode kernel and an initramfs) runs well past 0x40c00800.
>
> Use 0x48000000 on every RK3576 board to avoid overlapping the source FIT
> with the destination address.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  configs/generic-rk3576_defconfig     | 2 +-
>  configs/nanopi-m5-rk3576_defconfig   | 2 +-
>  configs/nanopi-r76s-rk3576_defconfig | 2 +-
>  configs/omni3576-rk3576_defconfig    | 2 +-
>  configs/roc-pc-rk3576_defconfig      | 2 +-
>  configs/rock-4d-rk3576_defconfig     | 2 +-
>  configs/sige5-rk3576_defconfig       | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

I took Jonas' nudge in [1] and went looking for what it would take to
fix this uniformly across all RK SoCs utilizing the common stack
address based memory layout. I will send a v2 shortly with a slightly
different approach and offset that should work better across the board
- including tiny RK3506 boards with only 128MB RAM, which we'll
probably want to support in the same way once they land upstream.

[1] https://lore.kernel.org/u-boot/322a4e95-2c3d-4a84-8b57-3b078f9ffcde@kwi=
boo.se/

Best regards,
Alexey
