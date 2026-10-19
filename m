Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48294CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13BA860752;
	Mon, 19 Oct 2026 09:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBMuSj-6HF-8; Mon, 19 Oct 2026 09:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43D1560762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401237;
	b=JGlHt+ItClzkf87LiU3AQV9F4NpuJUxdMUnEH2czC0DgSTGDuEc6JH0l3ElugBqsQjdN
	 7mjoTvbUNM/bB481t0RyL/Avcl8rVRYslwoNI3RQ2qNKN48lG748pDfJEKTLDQSNjSIeB
	 tzE1cSYOeuISJI5/yHfAv9hVpu93YEgHWvVZuOshtSczx0DsB/4Cw2QmtoQQvFqsu+NE8
	 bISZEVI3SQvOWi7QufqDgXHh3xtwIwvw3wExHu3pB/DCdQBFnGN7dCxE1RDhyq17p7bfw
	 oXk9gQKGMypQU+1UXyj127sYQUDOStu/BAxCTNuUFETngQi1g4+Xxwx+MI46DBYCbaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401237;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L0MUpeMvxVzGG3jBfhvswtbHhbWU56tO68mO7ec2d1U=;
	b=e0uOFzdvF7Ce61U57joGARTH7DzcvvneOh2M6aZd7tsLLLjBJqpFvvpe3ZjKoq0+Rp2y
	 gh/zxVqXLc+0etYNCU0D4MEvVr0eP/8V7N0dPev/HmbLa+3eoVSehf4ZdVEqDcvNkMS/J
	 x65OXlRGnamGElsrQhpdtepYhuWkd4RA/zLfwlGfFLzn+XfEG2h1dpe5Wn0+GsQw/f2As
	 VpLnvxZs8OEQr2atY6uZ1U3luHyVkLG17O5/9IOV4YrtX8d09Ydg21uzcQYlHU9QIyNoR
	 bGTghmK/r8Y0aTkTpqKnxsPEzP+fWdUAUa+CHAeZsR4bKpcu1rFz7iZor1a9wWxSIZw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401237;
	bh=L0MUpeMvxVzGG3jBfhvswtbHhbWU56tO68mO7ec2d1U=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFO++VKBxms/Y9kzzoH592RnbckHnp3LQNdMT6V+KPIiUw3sV8+Dv/2zXoIAxzS5F
	 +T3X0qVqeRQRbc2kz2YaeinJaJXX80ncSAorlusNauLr2fhP2FS68RMdQ7UGVdCr2C
	 3baXENssNICWK356IbVMnei+mqOfVKh1gUDkNnpi+GqQ9uXBQ+NhR9P64OgRuiqh37
	 W1Na3BeZ/hf2apLmvggM7oov9F8TY0FPmDrWCYPkEOWkfLYu95m3HcUvTxf2xnebjq
	 meFpYS9dqikRq28qVu6wrl1o7tbDDrTHvX7mO3IxjXDeLb1IML2LpW3d1RiT8zNZc8
	 Fh/sLPI5eaPlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43D1560762;
	Mon, 19 Oct 2026 09:13:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44DF62A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AA1C4056E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQo7Tq0bFjWS for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:13:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6ADCA4056C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401234;
 b=gJXHCr7OA6L7aJDLcO8erPiuJuY3dyYwgmdLp0n6M+/QgXwo+2EQ6zobSIfAyB8JmAS3
 d8AwSR47D8WKmxHh7oqIxcJB0+BrU1656sKIVlhMOR3QwN8Kegb0NoPu4PKc7prBobJBG
 +cqHV1Y7J/Mkp0FIlTUEPMdaqnD/5YOBaark4N2HgACtLpn2i30//wt9Qv4HNG8/Xuhzd
 UhCQQ8vzx+xx4/JmLWV6tcomDLxumAdZXBmbpI336L20q8hlu6YjSdrJr5jnXMHNm9iXn
 dIpioFQkD1FivkirXgIGG/nX989J6XRos8+AWNH7+KibxTrlD3Ka7Lrs0BTQsJ7x09g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401234;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=L0MUpeMvxVzGG3jBfhvswtbHhbWU56tO68mO7ec2d1U=;
 b=pnVaNeHK8nj5JUj3AEA5VHoUSGhPEb+TnhdF/q7V8AZhcyzN/+/B5TH2SXHAT7sZb5cO
 mx/XqZaX6z2c1xc5CWP90GGyHGZmjSGMIeA0iNLwAEkjidQPoUpq/aQj3977+9R52V2h1
 86mTS0WruM92imU2UA/p/+fvgTju4iJEUnpipNsJUYPaK+VHz72n/62KWbXFIvIYLCvnN
 tPCcDqOu7iqt1lyoLrgshP7DwzUjg7asU+ssOd42bZktUaIBiNaBSra7jqbw9U+FhoI5A
 RkUZVUbTddb4ugVsA65tJOZqir3IH4AISFceCA2jSZupH9mthzRbe5O3l/wcQnjJeCQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HnxIQtym; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=HnxIQtym
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6ADCA4056C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:53 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1000540a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401233; cv=none;
 d=google.com; s=arc-20260327;
 b=mjg9rbVPEKR63jvV4z1dZJdrtIaNBUTiUV1Bh60AWfaevJt60mQj2qd+jgHUO8pJLe
 ntKCWYmt63qsBiXhX/SfwGNlLws3gc7XqDozniZtKZNrQVkmSAvXfkjKTzTbIM2E2huu
 YFKr0sSp0+44O5p/Hh8l+ScPp9CLkWaJmMCLb2yXcQ9R2g+Qi54CLqhFEQxKzWx4O+0u
 V3ltYQbNw6v0TcRF5TYM9Wwn2ZTpCfyOs2GCSuRr3lU/0sEDqqVQnPf9WgT7onyLFZxF
 rHjsKqcOGnE2xqvjudJOOatptpSrohY5GAHVVmJUcPcSUe65kT2pk21qgho5uzpCGM8T
 AKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=L0MUpeMvxVzGG3jBfhvswtbHhbWU56tO68mO7ec2d1U=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=hVQLe/0mKRzmyMQFj5JHsfonItWYDr3D6lJWU8YJhvkCMncNxEDYcvkfjspPaACO4W
 iS5bLkrgflaY+VMZRtO6RURkzIDTLD/fP8JRN6F1u4bkuiCqZBLRdwZ0MbpvfsvSaIN3
 hZr5HNknYZa82xYQLtw2sobUlwuuoOYJmPo8fVJyGBTUoqytxVX8f9Jq63xGSqkfML1O
 bYWuMXfcP6UOjPrw/0sQxH+riJSWrTYH0Ri7sZldO1QJCzh024onP52z6LA769Xyj1eS
 d3pwm4rS2b/DwxCHNFZh4+flbbi1Ptrh7tTvclkj+rwc5RiQUPxXklQ9xXg2x3GaZzF/
 07Lw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401233; x=1793006033;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L0MUpeMvxVzGG3jBfhvswtbHhbWU56tO68mO7ec2d1U=;
 b=HnxIQtymiOw9CH3oNj3rTBIb9XI8E/NSe72fHnZpH6eOEn5B36UxkfBNP1A3SOLR+p
 R2BF5rHoD+QyhL2yh8NL06tX7kjP2iGGKgXEc7EuTfTN1OKadcN+Ucwr9PQvcFPi1tQU
 6JUE09QFcodaNQPaPYcbvNITo3YU6vNUld6yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401233; x=1793006033;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L0MUpeMvxVzGG3jBfhvswtbHhbWU56tO68mO7ec2d1U=;
 b=0/JWF/sHtVxU5yf6KT1regoc0R3ub4J64gi8rVFdRg35DfZuLi56JzR0qamtFkOVBN
 8ELAo3LSxATU0TP2eKX2H7DlD95CR3b9XSKbSjrsp/VF4b12aHE3WA2HA+wyc58I8A9J
 OPtXzcHAwNpBVvCCNf+wujTGbUkRzi4aF5IER53DfgRjHHsdsQuuPxBGwPUDYI139hhk
 tiTDpba7Ozi9y8kTHHfjwBr0QDRPDtNTUCnSqateQFaYF8erQ70RiXqir3ymtCFM6prd
 4h1GerrO4j2y8rubHKdqb3kyJWrdSCFfuynRntF3nDiYM/j0VF45JGz90E3f7/ChWFw3
 Kkfg==
X-Gm-Message-State: AFq9FYLncmJuQinJ4RPg2FrepDPpy+9IvNxJLVBS8nvleA/kvHPv8Aae
 pd4gNJk+ASyhUFAEk4M84z3S7MjsWFER0XjumXRypKQ61UUokPm7Q8AznB5BlzyQ9oPDGyXQSV7
 tFVWOS/0NelIZ6bBNYV2qUXjJqZzWucJLT/8+VTn1PjYdJbn0lGwLVw==
X-Gm-Gg: AYBFou1m1s3fEuJuHwCKqCehK1kNhyqOmKYINevavpEahFPNNXYISghuPmWyzSeQa15
 qSYgzHaytN5Xa/Z8QEC0Ai6BLVMSRW2penpvVY8bvCMnHoHhizenN7SbO9Sd1rQW9bP+v076Nou
 lPSmvDITXMGTYEKp/ujy2FpUgn9uSK5K9VsrCPuYMoR5kxlO7uzRQqfUjFNIr/RuZfDW+wK+t6C
 nnFwWrjLb3D42mgai93ft08lRJfZ9eRx7RYBsZaVqo6Jj7G/FZnB8o7LC9Tetjhx/YAoqqCRYmS
 OO4WBJ0sxoLHb+d7qyEUY4rUV8ihG81hge41bsjVWTR0A35bYrFSEULX+PituFxoUQ==
X-Received: by 2002:a17:90b:47:b0:3ac:8897:7b9f with SMTP id
 98e67ed59e1d1-3acef0f4821mr5503760a91.43.1792401233128; Mon, 19 Oct 2026
 02:13:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:13:47 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 03:55:57 -0500
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-3-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-3-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:13:47 -0700
X-Gm-Features: AclHuK9XXHX2uIvjsaei-IC0wtfJKm8mx6WQ74E6wACgzhsGYCwXBCr23zxQ0uM
Message-ID: <CAFLszThoz=NJD+xF-uq8wimKDhDMEOuaTbafX4Z6HTRYfCe7dA@mail.gmail.com>
Subject: Re: [PATCH 03/14] expo: Allow a text object to have its own colour
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
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

Hi Petr,

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> expo: Allow a text object to have its own colour
>
> Add scene_txt_set_colour() to draw a text object in a chosen foreground
> colour, on the normal background.
>
> The colour is not used while the object is highlighted which keeps
> the reverse-video bar.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/scene.c     | 22 +++++++++++++++++++++-
>  include/expo.h   | 17 +++++++++++++++++
>  test/boot/expo.c |  4 ++++
>  3 files changed, 42 insertions(+), 1 deletion(-)

> diff --git a/boot/scene.c b/boot/scene.c
> @@ -561,6 +575,12 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
>  		video_fill_part(dev, x - inset, y,
>  				obj->bbox.x1, obj->bbox.y1,
>  				vid_priv->colour_bg);
> +	} else if (gen->has_colour) {
> +		tinted = true;
> +		old.colour_fg = vid_priv->colour_fg;
> +		old.colour_bg = vid_priv->colour_bg;
> +		vid_priv->colour_fg = video_index_to_colour(vid_priv,
> +							    gen->colour);
> +	}

Please use vidconsole_push_colour() here rather than poking
vid_priv->colour_fg directly - the save/restore of 'old' is what that
helper exists to do, and the SCENEOF_POINT path above already uses it.
Something like vidconsole_push_colour(cons, gen->colour, back, &old)
keeps the layering intact and avoids a second code path that future
refactors have to remember.

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -898,6 +898,10 @@ static int expo_menu_header(struct unit_test_state *uts)
>  	ut_assert(scene_menuitem(scn, OBJ_MENU, "item4", ITEM4, 0, ITEM4_LABEL,
>  				 0, 0, 0, NULL) > 0);
>
> +	/* a header can be tinted; other IDs are not text objects */
> +	ut_assertok(scene_txt_set_colour(scn, ITEM1_LABEL, VID_LIGHT_BLUE));
> +	ut_asserteq(-ENOENT, scene_txt_set_colour(scn, OBJ_MENU, VID_RED));
> +

This only checks the two return values, piggy-backed onto the header
test. Patch 14 adds a dedicated test for scene_txt_set_rgb() but there
is no equivalent for scene_txt_set_colour() - a small test that
renders the object and verifies the chosen fg actually reaches the
framebuffer (as patch 14 does) would be consistent with the rest of
the series.

> diff --git a/include/expo.h b/include/expo.h
> @@ -352,6 +353,8 @@ struct scene_obj_img {
>   * @str_id: ID of the text string to display
>   * @font_name: Name of font (allocated by caller)
>   * @font_size: Nominal size of font in pixels
> + * @has_colour: true to draw the text in @colour instead of the default
> + * @colour: Foreground colour to use if @has_colour

Just to flag - by the end of the series this struct has
has_colour/colour and has_rgb/rgb, and scene_obj_box in patch 9 adds
yet another has_rgb/rgb pair. Would it be worth collapsing to a single
'colour_type' enum (NONE/INDEX/RGB) plus one value, so the "set rgb
overrides set_colour" rule becomes a plain assignment rather than two
flags with an implicit precedence rule in the renderer? What do you
think?

Regards,
Simon
