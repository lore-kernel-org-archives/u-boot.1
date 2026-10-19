Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8697CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95F9D606CF;
	Mon, 19 Oct 2026 09:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwB79MnwAN0H; Mon, 19 Oct 2026 09:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BEACB605CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401295;
	b=EhfRTposW3zZCdIcdGzn4YT2yku9eH94F20MnUESR7n0sACmCOrqnf7k7/XMDj4Tih0/
	 thbCmoVoG+VaxeatlDBODFB5ndwZsogSBag6Xu9OyhjoJb7DCdNqeMCjJJfW39YiqPTSL
	 G5D0SPYAHM9nfcI1NvMjM+bHUPeEXMkp0O2M7fG3dGRu48Ujk+qEtCvkjsE48oVUlFpo8
	 W62O1f9s1JufPLgwZAzEUNlT4tJQHntzJpGNPUXJuyUIojeByJ15VzOnU1gZXabOEvKtq
	 d1kXgBVbPo3Ny1z5kBc2NUmCyJHWlIlrePFCIVvfjBdXKHxoVBYIS7GWIZWllu9+Ufg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rZqXfU1QljNld1LM4hLkW4+Xlkl3iJgSQHagevoTnBg=;
	b=DQdTaRDEOdplDT2H3V7RsJi0C749w1WhCvcpUXEGucs3o7LaQfipUhBHxXqWoZ0xZFXk
	 kt3A+O+K4W/yaH69QjYh4GXRS6DgigIXK/m2nqY5aIJHgXEeHCCeXbZglbRlrTGs058vh
	 gFTlAVIZuHWa45p/br6TSwCMHnEdgy1vnjZQhBwKuyLSCwJ25AsKbYNT6N15UpqIyg26O
	 5Qe2lg4HaLpJ6kRGCZhns0ErpmKLEsFczvHlc64Cfx3I7DCYjX2xkD4OAkkSWk8AgaII5
	 ywxhlupC3oAS7DMi0XW2XtO+u0Tnd8e6GPBdGLwEY7NAknIiJvmZHboJCZeILK6bNJw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401295;
	bh=rZqXfU1QljNld1LM4hLkW4+Xlkl3iJgSQHagevoTnBg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W/5/fOJjHHpj6kOVyZLFWu3aHtjvNiRtZ/E2QwvwmvpVClH6D2IGpzBM5Oyeuh03X
	 uoYsvsKnT2VZIF2IrXKm9+J3hOFTC2zzP05DnmacARt/8D9u7p/whCht5thzqTwokC
	 PcZbvE2p8F/H7RT3TL0AKYHw+Gvv+0mfX6eWhwrSVAShmjkw+HU5y6K3wbqDuRrTdt
	 VKNXRLEprTQdrY3Zurm2kZ1t6ILQCz913vIXrNMxhvAv7uMV2031HnOxVfXbn2QVCw
	 WKrQfdxmo7TQENykovyGasK4eJotRq9c0Qd+Y4I4DCYXziwz38/gc3YigRdhFA3Gut
	 m8j8o1eFkH02A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEACB605CB;
	Mon, 19 Oct 2026 09:14:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7786E1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 692B680FF5
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8IfLQxhJh1rv for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 61BB680A9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401293;
 b=o12FycTj5TBECnecbXxk72jMB/QdUYmYDaJgr6PdNd5jYUsmRg0DX6ChBGxYBo9dZNeJ
 oODL9Nzjg4OqX4Wl9Q2LXlsKzJ0FhcbbvHzjRJY3erN/S6Js/fGLpRY3AR3iv5b5TUOXb
 PgwKhyLfv+Af9z3igPKHGkd6jX9krBp6KcHRN6RygX5UE1D4RlxNT332wht2UL+u14xRz
 c59crNKHEp2gsWWFkKYdVxCyIqngqx7B6X0yJXZC3mxAp3V0ogyurq1tqW1WaSWYdv0wz
 XVxkSNuJiVDDmtgXpqGGDKB3/GewvzqTlLZ/Lb4s4UWntKlBljDV/Ei87YEmXCCS3Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401293;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding;
 bh=rZqXfU1QljNld1LM4hLkW4+Xlkl3iJgSQHagevoTnBg=;
 b=J7u4f84fOywAKdDLzaiWPddodkU+9bBSuQZ8A1uWQ7VlCOXwC/gTDp3z3QIPh2gdvmf0
 0wGcSZNCI4RPyHkh1F1TFBBZSnqABTNUwh/6sNKsKxNDQcjuckHdhGNffmwMeA9b9Rf3k
 49+dMCeUT276IzpvuuntjvMWBoONeivj7K8xlxwTTtH1gpz/r/Awi0DOtTlDo3O3wC0H8
 4ZMOnbUE3tSJEfzDoQibTPQFxIL4pBp8Vl2pWe02/4RXAfFDxSeHlfx5l7Q4eaclGFs/h
 HwfNNGBipw9iqTo/6lQcx8uvT/d3NyyqLpUJ2Dqe811NjXCyl5c3SNPO/n3KWG5eIuw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TIGJbsPB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=TIGJbsPB
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61BB680A9F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:52 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b1f4d8e09aso2637470a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401291; cv=none;
 d=google.com; s=arc-20260327;
 b=rpcVITI6TK8Bg+t20s00+m3CmZ0B0gN3dWKirKziQyQnHEXcHUlfP7Fip6r2wYd1Er
 Z2GAVhfI80TmP+H/sIhgn6di+OxjWoMitvGfPXHB5w8zUm3GzLt/Tc4HQYSUQECX3jfN
 NNt/Jb1/va/X/Y/elJ7nPBelo2HgoR+4yWS3CJSqsMx95d7Tvf3ktnXMU5x9M9G/TRQB
 Q7qn3L6OdowKMQLOtynDgqZaSH2tl/I0f+kNhO2iTFV1Hh9mg6AHP01BnsfrDRDItpz+
 AHEN/yddmBwxhCFPENY8tHmyYvRue41VyCndzx0jjoay36RRURB1Jd19cQnGhNv/7myu
 5SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=rZqXfU1QljNld1LM4hLkW4+Xlkl3iJgSQHagevoTnBg=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=Xl9PGBBHdxI9B5GF947nvxTmbeoX1WdP3gCIsjf4cpy/YhninE2np4Ofn+fjum0iKS
 Y5cuBECIUqwI8bjFZ9L3XkbrGw7I3J5b+GjqEnULLTux1DNxJZN1boi+woOvoOsObJwl
 UPUNssz5Wmi4u/Y9HmtAd4B6GUNyOFrIZlhQOkqlgv7e729dUfspARXxyHGF23VJXuQY
 oK2iciZSeqDzjA26ktOXcgGwoavAbhOFOBtpmP2f/hhyvJ2rn0Qn67c7fGCGlWJcRdXK
 PxTjz62zQ/hwsHSHDcBAnu8pZJYqUZJof5Ei9r9Dr/HLM+aFNVIGDbEjyl5MKzn784mx
 meVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401291; x=1793006091;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rZqXfU1QljNld1LM4hLkW4+Xlkl3iJgSQHagevoTnBg=;
 b=TIGJbsPB4ImicQ+mz+HJicADMQ/QoJ6tOD/pTLgHGtJJ39md2Cd44YYpBzw4HC9IP/
 h3dM38i1NwcKmO9qTxRt8TFoUMwoWyAxelGv05QDU2uflS0pMj8aDB2BCKjQeupagXpj
 TQKhRh1q2v6MGMRyC5J0g54muVOZfLEkN8i/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401291; x=1793006091;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rZqXfU1QljNld1LM4hLkW4+Xlkl3iJgSQHagevoTnBg=;
 b=gI3pX0d6ZRnzhf981sVo0XXW6tq3H0q2llJTe0T3fsxaM+X3okv780rJxRNRbGc0K/
 kI+AKzOSIJiVJQWYKSr/mM8XAkrSrX/VRUHc4d+54Wy9T9H0hnaqnE2xQWmFo2UYdi+7
 XyzEwX1N4/cPhgKlkH71ci9wq0N8UCEpL2/JVRt55nxK6yhknhWTkPdqa1iS1JWbuy85
 IXC3pMHivnczHVjHA0LfE1jBa4DUH8cANc59/jbAh252NqSFwAbf+wdMGVs0q0FDqTDm
 hYOBsxvoR8DoCIqXNuQBnQwkrOwbwadB3avP8E+vbTUU3W6RSRzpLN8wqDi2uWg6u2JY
 J7+A==
X-Gm-Message-State: AFq9FYI4Bv9ngsogUgIgRZOWG9sxbYLJl5H6yD80HahpwEcHNLFjf93n
 iquX0/E/LWNHTcaLlm/IvSF9gkS9c0uygiMuD8DMIoajlYYCyltozFDpuVwTV33vlGBcBkvk1YC
 tj/qhgKjr9jm9jOtQAMss5mDctrR62xHHJoVLJ2NB
X-Gm-Gg: AYBFou0QYcU1WQKw+hywe7fvnKbf1ir7zIguj7OwSPfd8H4DuNfQt/zmZ/UsBdrgVvP
 JoEY5QP/6pGXIcXLWgl3hT+2k4DR9nmbAQ9t7FxyWTsj/o0Z/C3k+MM5t2He0YF+TlVrGYyICRk
 VkLkVS/fzBhH61M37LHcblW+Btz0HLw3Yk3/IoHCH1+thEAMBECgVHibMKCl3zUC4Z/xpihXEs7
 FQiVf38neNbLdOdAGz4p289AVruUH/6iN1bwItxlXSSTYLNIwdHgeTyQJMcJGXOWni4oNb+ty+X
 8kj3dW0sb+xEGzrNN87TgqSz4ljc5V+E5uDp4xuYpwsaXMvSO9gPyw3lVNew5sWL
X-Received: by 2002:a05:6402:42c6:b0:6b3:b90c:1ed6 with SMTP id
 4fb4d7f45d1cf-6b3b90c20c8mr3255478a12.10.1792401290767; Mon, 19 Oct 2026
 02:14:50 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:14:47 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:07:39 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-8-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-8-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:14:47 -0700
X-Gm-Features: AclHuK__vV085FV6XsSP-oT48-Pcs6ZaRDDMXHXxIsqMinGlQ9uvzqBiAyWXsYY
Message-ID: <CAFLszTh-V8Ohq-g62gOb4NLx0RA4+osy7=CsZszVX_+iH=xVNQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] test: expo: Test setting the background colour
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
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

Hi Petr,

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> test: expo: Test setting the background colour
>
> Add expo_bg_rgb() to check that expo_set_bg_rgb() records the colour and
> that rendering leaves the video device's own background colour as it was.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/boot/expo.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -944,3 +944,36 @@ static int expo_menu_header(struct unit_test_state *=
uts)
> +	ut_assert(!exp->has_bg_rgb);
> +	expo_set_bg_rgb(exp, 0x0d1117);
> +	ut_assert(exp->has_bg_rgb);
> +	ut_asserteq(0x0d1117, exp->bg_rgb);
> +
> +	/* rendering uses the colour but leaves the video device's alone */
> +	ut_assertok(expo_render(exp));
> +	ut_asserteq(old_bg, vid_priv->colour_bg);

This only verifies the setter and that colour_bg is restored. The main
thing the user cares about - that the framebuffer was actually cleared
to 0x0d1117 - is not checked. Please add a video_compress_fb() check
(as expo_render_image does), ideally one render without
expo_set_bg_rgb() and one with, so the fill colour taking effect is
visible in the test.

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -944,3 +944,36 @@ static int expo_menu_header(struct unit_test_state *=
uts)
> +	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
> +	ut_assert(scene_new(exp, SCENE_NAME1, SCENE1, &scn) > 0);

The commit for 7/14 also mentions that the background colour is
applied as the text background while rendering. With an empty scene
that path is never exercised, so a text object in the scene (and a
corresponding compress_fb check) would be worth adding to cover it.

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -944,3 +944,36 @@ static int expo_menu_header(struct unit_test_state *=
uts)
> +	expo_destroy(exp);
> +
> +	return 0;
> +}
> +BOOTSTD_TEST(expo_bg_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

Neighbouring tests wrap the body with ut_check_free() /
ut_check_delta(start_mem) =E2=80=94 please add the same here so a leak in
expo_set_bg_rgb() or the render path would be caught.

Regards,
Simon
