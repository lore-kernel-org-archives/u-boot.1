Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7CCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C54C5406F9;
	Mon, 19 Oct 2026 08:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gGjvNLQ9R1j2; Mon, 19 Oct 2026 08:15:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00089406B2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397746;
	b=ZHWTnmVUKVx04t9mcE4G3L/cKt5BG9vNzdNrpGnquREj60Wap6/A1iDAqdTTexIXs0Pv
	 /kKyWHuLmHXqLo2i2Z/IaZ/cU1sledWTMJjH7Sa3XSfDVRT/PTXNIxX6msKmBgdkr/1vq
	 BPF/4tazBvgRNx7DP+EMdXJ8ZkG0DwaiP3dQcZtPul8O2EE0nmJ3ZhfyaEhXMX0jjQf3n
	 JK/zdBEuotIqeY3o5zH94XwY65lCAR7PGhbvo/xC6E5Hz+XeEiuoPr8WC/thNsww6hANg
	 bCT7f0LYDYSgrjXlawYOrVmEzGiKVeNqwNgAMy3jrSAPWdf13ZPqRlfDrOh21HGG1OA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792397746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x/YG6Iq+jNWDi0kzFdcFYop74M9bY68b/6pfx91gG0Y=;
	b=MKrD41RmFnSDR1CKKYjkStiR7axsLswVeMo93J3+ojpcBrQ//tEukr//xin+elcebqaR
	 U1RChSyHMZSRTvCVknlAlS9QGQiAvp7RxR/m8/YBW0COwO4SzvYGWHYMkDBQVSGkM1Hab
	 Aw1XIrrxOvbWJd0F72fn+it9f0oOic9St38Cnplv3nCjfpqeXTk7dm09Igw6AvP1g76uL
	 iQWnNLyanJCiDEpx2g6vwxUOYgWMMU9gxMs+GbfcWMuDijO0lLPgV9mCSHYTL3IYplSgD
	 Dh+vF8WtNs/f8UD6NOlQVrMzn2903P91EIs0TrWmoEHO1ZR78LN3EL9JZMJwHpAEHSQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792397746;
	bh=x/YG6Iq+jNWDi0kzFdcFYop74M9bY68b/6pfx91gG0Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+7CvI+f/BzG/jf1zML6TQah0ewllGpI14hBUJ+ZWFRK528+xOfUoFJDz6rt95zRm
	 LP3Z1qlm7vMb0pbN+guULRVLBqK4g6FNfXE7y/FzhUSv3a+uXh/Kc/b9RKFYMVl3vm
	 VAfPaYIu9VNo2+LfQ+Kj6+hDsRzgLU1si6C+zTEO/HIUSKfIxGldWL7Bz/olX8EDdn
	 +GiRdi3Mx9CvtwGF3DLYG8ywgA7+5TyFD21KUQQ13h+qCTSqJiuVYiRRKkP0U+nIku
	 ZXkMdwWfiPCse/R6teIHwmnqhvCWWIRO+UkQ+8ik+oJJ49BsRClcYK/0tkbOq4XUDy
	 G5CQ5suhPjaxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00089406B2;
	Mon, 19 Oct 2026 08:15:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 26CDF2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1877760612
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:15:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJ6-lg-yfXRl for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:15:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E711605F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792397743;
 b=S+mR/jvHc2ZiCw84CfoD6gLK4AABVFUY7dh0WML042LTxJLtEi5K6e2NoXaMPQv98Ukg
 4OjjUSjEyojDAZufdLFHopOaGRUrWjRxxmO60TsEhEyiG+dH1kkJPBFxt5sW1sQVf/Lsk
 9SZ1aSb/s0WVPKs7sHAZRWZoZJkUoNekUcxq2yy94hyledNYjFvKegOjesQ9yEdrFf30R
 B5bIiOelZla5MaJ1y/tmmo4j5vYVmYT7PyBP1NmPxfV64ZvSBSocHH6bcsP0mulMWcQ6i
 Q8KxJz+Jf4A/AdbBVhC7Rp0Rtoz2THOlaPP6q89zVZIRc5gWj/23OI7DCm2Ti0yXngA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792397743;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=x/YG6Iq+jNWDi0kzFdcFYop74M9bY68b/6pfx91gG0Y=;
 b=jhcxDD1YrM2l7aEaMxyWoVr2tBHS+zD9B0YSYFRWzI6K/RnjdQQNjZoScpejTrplqAOD
 3mR5iDDaVxQwNyWO6IKZBahwMbZVV2ljBEUQubBlBxCsAAI2GWEJb0DNm/JmAhOGuJvCH
 zf8Hz2nEML8ps/V8cDwxgXN3ETCce7U9IE+rBIovr28CZceB4khGPzv1d0lXbWTotbb90
 iRu7lUeLZKbJXi1f0HZWenUWpOLEt8oJqR/2TlG/2FPLb0dGjfO8Ec4SrmHJ6KCjhEaxg
 seNHTGHxFvKgIZzGDpge3gEEA0vyTvl/peYNTJKp3PH0OfjvPUKyGy6z/Flvd4YkLHg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yPcQtA0s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=yPcQtA0s
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E711605F8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:15:42 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5bc18f54abbso1444585e87.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:15:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792397740; cv=none;
 d=google.com; s=arc-20260327;
 b=eeWowUC3EajR9B/4pQHwYT6r9+hU4JtPIDuX8JwDP19TDRyUGj3l4IhkJ8pbCf763V
 zhWwQUyWlUIb1ANHxuGZByEo65y6oyE//2FZ4RUH0Ns3LBB6A0Tal728ze/io8qEs8WT
 vGyImRrQ4e6SYbBGfqcrLP+AeVbq8aWmyUKK9KISM1v8S+sRRF3C9rmnv9nBHBHNIXdM
 ffo0SG7m5HFdcw/bUDdH3aat06giboJGG3Abr8vcwbljKe9eTb/mf1tfcjwDXV14cWG1
 TP7xByELKQqdrE+RwPNWZcTwDa1BDfVKl8geqqL2CMJws2hnbQUa9xp8LhDjpBKLkG7H
 SPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x/YG6Iq+jNWDi0kzFdcFYop74M9bY68b/6pfx91gG0Y=;
 fh=4E0ChzIQASbtp/3i1h7XJw8RtL93veoqv11e8FvGqBo=;
 b=oABNSNvHlxRqms2RBq/04xaP859LkIXiC4bFvsmvfbS92QIJxzH3GuoopPoMNQ3ZiI
 pnOw3tSBKw8Z7HqXPUG5t2G3DrTxhohNuTELCkqwBYtw8aHOhxtVpY5O8toB9E7X8Ir7
 OU/Mg7ev8Qv/fVmSkBW8FKaXCTJM5terTUzC1S/tt2oRmK+2PH5DTQ7oUsJtu35a0Qan
 TImsI/JiAxXLAOF1a3OadvADYtyfp3fumAehwMHZgBIwsM8UqUUWrwQV5dH8KHxcpKww
 6LEvOz3AQSUEzPPZe1zWT5vKlQTJ3gqLPlvYyoRXSC1Aycjsaija/ztZ5v3FE5ffouW5
 /ATg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792397740; x=1793002540;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x/YG6Iq+jNWDi0kzFdcFYop74M9bY68b/6pfx91gG0Y=;
 b=yPcQtA0smAtC8/hZo2CoaABpinPhz2tzQ8FX5pPWU0qvmZFzxhXnzsGh7v4M8OvDbw
 e4fyFdxabnQN7GjDQUpUG0F/ffG9ECecirqoMaFdflPPpDFP2pDSXnZMiiXNdsSB8fhN
 wEVmHSb6evhRstSMcyjF0mWqGHai2N5LxdHJORkh/NM8pybpGQyvJa3Rci2OEBU2v1l9
 3RDSUbh6p1h9JiQBB9OXm4w79vQxYQConPuc5aeTHEfRFYsyCiI6kZ5TuGBXkgJS1L+c
 R2+a1aXSPoYVgKAFXLsAINoXTYTu8/U79D90In+6Fgoqg3b5lk1JCU2sz+M3COrjlRZC
 M9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792397740; x=1793002540;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x/YG6Iq+jNWDi0kzFdcFYop74M9bY68b/6pfx91gG0Y=;
 b=A8DsLC1E6i9giXKY0AAC84G6pJggfhEYKcEWeNW4+qTwSoGH/TrRGwkOsh9yeCdeoO
 3njJtupR1gU62tlRHLxetAnvqEfiq18oIb/a7rMgUO6TxpK3ock/TQj18Zkqpq8YCrA1
 o/yUYonTEpBFud6d/Qr9R3M0wLPqmWy/Vsf5HVKE6ctY+gjZ8fY1wDHpMarYD273moBO
 wdSnqt81uY+UuzcDHVN3shLuBoqm3t+cZzjCqKrvteugFh96MLOJUQ9l674aBJvoq60l
 z4rAK9dJ0Go7HCNzAKlz4W4bpENV2uz/etrbSCBfh76BORETUh4L8/0V4iIP/PDIbVzJ
 U1pg==
X-Gm-Message-State: AFq9FYL882rjqDX4W/ARlzp1JJccLxETewW64ep9EFaIezkSGHS/ilN7
 oGtvmth78VbMrAFrHCSxibQmIqmqWE6mkyI1zbrv67Jcnctvbxcg+kn02nJhv6YS6u0n1rHVQs/
 kmMsTPsN7eg4vu2wBrE1fBb4oaaAn/kSmkfW03Sl7hg==
X-Gm-Gg: AYBFou2SsAu2fquIrSsAei2iuRepSEALTim/Z7A62OHibCpc8nxczamKBWInqzcC8FV
 FcAvExH54VqqKBDEfYetT8iespCgsMUtRJWsiWXTn1qeKQ2co63GI+rSysgPG61pTNmxQLONC7/
 z4tzINXTslM7USwjft7i1HqU/z0z+EYt4MFdIedy7mty5aRwz5U0njkRP4uO24XXNxd5C6ADaSa
 dRKaxaT03akWirTAYXfVTYxQLDqnQ4EcSmWps+1L8uNZ8ejdyGgf8QyoLR8BkyzaLlW1oMMM/An
 C1Z4Zr+22ni5TNSut/iULQubHhNlyuOzrlcyZBblcjTcV6FyFDLV4Z3GsEkFsk1v8Pn+E6RQnBI
 /PrIamFWdoBqS4MhQCX45EfSV2nOuveRgVauCM97s+9EBX4Khjr2ZGeXQBKGS2xyxLsNgDVmqmF
 Oh4uYwK0cnu7kf
X-Received: by 2002:a05:6512:3f01:b0:5b8:eed6:4bfb with SMTP id
 2adb3069b0e04-5be50a74cd1mr2169282e87.47.1792397739564; Mon, 19 Oct 2026
 01:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <f492bf72faccb8ea1b91b77e2a28a9ca2caeb40a.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <f492bf72faccb8ea1b91b77e2a28a9ca2caeb40a.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:15:28 +0800
X-Gm-Features: AclHuK_baH6pS5jOqjJ3yqQleA7bc4E2BPPSv5mz84p0FzlGbidtXx_bSrmW3NI
Message-ID: <CAH22mJyBGC1pN93yuNX-utLOfw=vsq9METWngqwqJ52xaA4jag@mail.gmail.com>
Subject: Re: [PATCH 2/2] spacemit: k1: fall back to the other boot devices in
 SPL
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 3, 2026 at 5:31=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> spl_boot_device() derives the boot device from BootROM state: the SD
> API pointer the BootROM leaves in SRAM, the boot flag register, and the
> boot strap. Not every BootROM path is covered by that. On the OrangePi
> R2S, for example, the BootROM probes a card first ("try sd...") and only
> then loads the FSBL from eMMC, and on the OrangePi RV2 it falls back
> from the card to SPI NOR. If the detection names a device that holds no
> image, the SPL stops with "failed to boot from all boot devices".
>
> Provide board_boot_order(): the detected device first, then the other
> MMC controller and SPI NOR when this SPL can read them.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  board/spacemit/k1/spl.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
> index 96ee4449c4..cc0e26bb02 100644
> --- a/board/spacemit/k1/spl.c
> +++ b/board/spacemit/k1/spl.c
> @@ -498,6 +498,32 @@ u32 spl_boot_device(void)
>         return ret;
>  }
>
> +/*
> + * Try the device the BootROM booted from first, then the other storage
> + * this SPL can read. The boot-mode detection relies on BootROM state; i=
f
> + * it names a device that holds no image (the BootROM probed a card befo=
re
> + * falling back to eMMC, say), the SPL still finds U-Boot instead of
> + * stopping at "failed to boot from all boot devices".
> + */
> +void board_boot_order(u32 *spl_boot_list)
> +{
> +       u32 fallbacks[3];
> +       int i, n =3D 0, m =3D 0;
> +
> +       if (CONFIG_IS_ENABLED(MMC)) {
> +               fallbacks[m++] =3D BOOT_DEVICE_MMC1;
> +               fallbacks[m++] =3D BOOT_DEVICE_MMC2;
> +       }
> +       if (CONFIG_IS_ENABLED(SPI_LOAD))
> +               fallbacks[m++] =3D BOOT_DEVICE_SPI;
> +
> +       spl_boot_list[n++] =3D spl_boot_device();
> +       for (i =3D 0; i < m; i++)
> +               if (fallbacks[i] !=3D spl_boot_list[0])
> +                       spl_boot_list[n++] =3D fallbacks[i];
> +       spl_boot_list[n] =3D BOOT_DEVICE_NONE;
> +}
> +
>  void spl_board_init(void)
>  {
>  }
> --
> 2.55.0
>
>

Reviewed-by: Eric Chung <eric.chung@riscstar.com>
