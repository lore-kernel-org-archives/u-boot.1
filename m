Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2707CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E861841C2;
	Mon,  8 Jun 2026 15:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYRkrht3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CE1684701; Mon,  8 Jun 2026 15:25:52 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38788801A9
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so8085669a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925150; cv=none;
 d=google.com; s=arc-20240605;
 b=TfYlVrF+uQ7ymsyj4R7hN5boNEksDNQLNjROqLNYpaRDvURN3LvxTXaCkEHXAWPCGi
 HEpScPsDN80b13GPL5XnX4zDveRESWHXB4YRwu5FQgTN+qAf6wCz4Zw5SDYVikZs25lq
 ggHW24GtGAVbc1qnzJy/PIGRCZMp5RX0OqdvheSfwTHngCEgJisTtgaUogiatQV/zIjS
 5vJt3u6IU2r0yAmrAjNDkpaaMrXC3YJudnMnXoeo17n6kXGCxs9K4fmjFtmd+p9oRNEb
 9HOa1rY75G8hCTNjTu/gnRd3iA9oIoZO0Vr3Si/3D2xe+MlUAsZ9RWnxPaY3sybHfdKZ
 9nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7JDss2dIcKsbXwvaTgyJ8M+qbJdtosf+Tv1QdBup0Kk=;
 fh=Odq9NGuM9IwpgVvl6kT7EijzuJ2AzFvZQNxDvfa4hmk=;
 b=jtomwAhh3TNfZN4BgQvby4M4ZjJH+wxJrX8qLohWJDIvE9v3r1oEKLDuxgzU6wi6Au
 O6snqtEPknXTmghOD4637Tef1YaUvFqdgsEQT63MUZzjgwkj5GCSuvvYVghff/a7zQZQ
 +d4LqdM0JJQqtO+RIry4WpjxoeqmoA4qY9f/kMnZkwQxlPAq2Ooq9ejqvP0HX2xatku3
 Y8DZY1PZBC3qkNevtHV/Rd//Ijk5aCQCivBOGcc6lpRBztEO5JX3yR3B6GNqFhLO+kzh
 A+rfvJLNXwsv9g3gyxgASdMptdx/575yTVhJHyeVuDAzgVycb8GQOf7ymgNxtoLI318w
 4Ujw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780925150; x=1781529950; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7JDss2dIcKsbXwvaTgyJ8M+qbJdtosf+Tv1QdBup0Kk=;
 b=YYRkrht3bMPQYBrMsN5xyqVdFSrQyBxilRqqMrLsG5Pe+5otv7mBG3x+68tcNwId6+
 K0JGuqOlkJxzrQlnbMgL5/lvvfxQsubY8EXGNOW/JqgLoBQ+uYG/nfU6DDAS3Y3DGQ9Y
 +N7sFQPt1RL3tt4/FXc+fI9cOkuZGqNd/1rck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780925150; x=1781529950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JDss2dIcKsbXwvaTgyJ8M+qbJdtosf+Tv1QdBup0Kk=;
 b=m+RPmZGQWO7uv0sVCi5fF9MgDlPHZZcVqwBbY090u4tGiarz5HQ13O0jRyYSNDy7gg
 b9s2/VNHnWu2qs7dABLNWExa/HiMp3ixOUZu0Lo0syuir5AgB3V7xcFHLWvq7JgO+4m4
 3GfzUMh/8quI5qwGIlwiMjibxrJexjGTAWPC5eWQCaHwqyGHLmKCDjMKr4IvLk8nI4hz
 Wb+NAQVH5JfFJQfetGCjQ65BCPj8+u4PAI9SBzv+QM2jzfT/44LdBMZ6Og5CjYDJ/Ktv
 +7BTsNRxwJsU4szqVs7JkiUoNuEO7tkxhV8AMU5EtFqd6H8aiM/w/el4Rmx2y/Oyq3gj
 uUWA==
X-Gm-Message-State: AOJu0YycrfJfqi3Y9x/i9Axyu3JjhUaITQS3AD4tCIwbAvF/GJg1qu8+
 Q+N1EaOKrl8VVVWpiOtNpjL98rP6onh8o4ZVuLD/qDVT8l2gYDQtxDlbqAuZldwHuj0i7zSPPsl
 m1EKfBa4/TySDNLWBr57psI059E0N+v2NLV0vrbbi
X-Gm-Gg: Acq92OENHPxaWQBPEWUSoMn3WdE2kvTQeOMX9MYnla4mCBjbwDgrOrMUqbPK+zzGaAH
 B+uB7xu/WPwQdifbPie/i/IDlQajYrYsZ607rdiIiYXG+gKftS3VOaTOVDbzL4pCrYqBgxTJT/H
 gkkne/tpaHgMcmy3DkhbiET0L4mSJKkH1CG5PLQpj5r0lO0gt1tBa+t/aTQskgQr5c78NBJ9b6t
 r5h/XjKtF5vT5G3BCD1ywBwTUTsIPtJUSijFOP4fkSA/zWLILWzSkfU/KH4kuB8NlQFLwVNsenM
 l1psYhLgkptjDOFe
X-Received: by 2002:a05:6402:2713:b0:689:bbd0:45b0 with SMTP id
 4fb4d7f45d1cf-68fa4c1fcf2mr6747127a12.9.1780925149694; Mon, 08 Jun 2026
 06:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-2-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-2-b8203682507f@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:25:37 -0600
X-Gm-Features: AVVi8Cc54yzHL9sn0IKLnhZEiB88mljNBz5J3w2YsZmq5DfSDnqBhwmAMw7oXfE
Message-ID: <CAFLszTgqnEt_b65DZU0zNa81V-njA+ACaDQ7E4t72k6dwD0tkA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] .gitignore: ignore binman-generated blobs
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
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

Hi Sam,

On 2026-06-07T23:37:09, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> .gitignore: ignore binman-generated blobs
>
> The new android_boot etype is causing these /comp*u-boot-nodtb artifacts
> to be generated, which aren't currently picked up by any ignore rules.
>
> Signed-off-by: Sam Day <me@samcday.com>
>
> .gitignore | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/.gitignore b/.gitignore
> @@ -84,6 +84,7 @@ fit-dtb.blob*
>  /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
>  /test/fdt_overlay/test-fdt-overlay.dtbo.S
>  capsule_esl_file
> +/comp.*.u-boot-nodtb

Hmmm yes binman drops intermediate files into the build dir...it would
be nice to have it write these into a subdirectory. One day we should
try to use a subdir instead, cleaning it up at the end. This is a
completely separate issue though.

Also worth mentioning in the commit message that this only affects
in-tree builds. BTW I almost never do in-tree builds.

Regards,
Simon
