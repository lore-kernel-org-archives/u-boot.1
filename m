Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94808CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AE4860765;
	Mon, 19 Oct 2026 09:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I1TXHBry4bZC; Mon, 19 Oct 2026 09:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 87C4060747
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401229;
	b=TbnyNoqWf1c1Is18Khy9bdGDmrElqCNfrJosGS89UM1eNWAK+XwWb1HUQh8ujHmB8RVW
	 gw8NLG1dQDPzMpnkqtV+02PzJnH7WF1/ZDJjSdLtFMQsMRgWTmwUkjCAceDhWe3odrfvt
	 KSUQ0xUSx/y0lkyzi0KLXqmkVLZ4uxv6thw8Y7qAJZsah7Vx4F0+cixpYH8BJ+GGzkGMq
	 264Aiy50qMbWc9wDgo5q0F83lBMDFYEuEuhdlSngKIZloHMvqRlK8NuxHtb1TS5e9bA2p
	 BtbTRWDL5HxMoXpAFc6w5Vs+LIwzA/0AEt9zB11GNuat9HoAgWjAHIuBbLGVknjbSGA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rIrsKvEAOfI3UAeBGE/mdO3Q2SKU8XVbPa7gOaFnqgs=;
	b=Q6SK47ZNKt1JLxmPfu5S6haB9Ppb2i/Xfrp1w/i8731B9NeIBYKLFcprLhmvuF0YkwCh
	 SzOLyXIeFeNnJ2dhFUu94+bSF0QN9GJ8LjozMBRv/bASbZPtUU/il4drkwW9c1kZ8KDid
	 Xqc05CwZDQHUGLxRk34z8pMhQYz6uXqZOBQSDqV8ZGaoPJhe2/Dik11toDFgfmYPOez4e
	 w580am1LpacIprWT0WkaHV9K6SlaD5mhRp5g01rMsl4drXH3Q3ZTZX3szesXsPajlcEa8
	 qc/6Kq2GFnPkp0MfpHs+52XosiyJi26oiHuo60QrQxK098dBHBevKYKl/SxYia+f6lQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401229;
	bh=rIrsKvEAOfI3UAeBGE/mdO3Q2SKU8XVbPa7gOaFnqgs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kPWhEQrON7zctHhueEcI+gfqfcSFb+o6r/kYQ+Fr6T6+JlmvQM2psTAsltZEHSK9g
	 UJK68poDJbsEieIOiLinWsPzy1t6ziwP24WpOR2P/ZKkTt5vqKlUrSGZ0UCBVngBCI
	 uCkRbntJzOtAlt5hjZEYIo+6iIUrKgUvtTI4Fq75uaKuJcg4jaflcAzZWGHOm7aHeF
	 Sxu76NHG738WTU2SzIxA9CLPQ7aPXrgChfD7CjaS7QKv997soSyc3Lgcdvc8MGXJwA
	 6hmfrNPM31CKqXwkP599xUA4jYeR1G1oXozS3lVYa4UjsWs8Vxf46+RBm4uXlRj1+N
	 KFq7QsUdiSVaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87C4060747;
	Mon, 19 Oct 2026 09:13:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A797623F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DAED4018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PfAw10lt17pE for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8675840062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401225;
 b=Ju6Dj8brlDE0RLkI47M1rea+TRsgVGP/spPRHzQE8ZrdO6p7NcwvstSGESK72AU0Bi+P
 6aglHn1imSo4z0FoOxKiyiya7CXsMj8TpcgwSM0SHTJvhkEORa1OH//4lQSbiaVYbqRfX
 +Sa3AIjylOUwGlDcP7jVxP5jURndeMGKJV6cFmx4FdmhvxmM5aNbFNOT/zbLQ3ZotrFnD
 J3BxZ5nLFaqv9l5PPNb1njKq1CloSCiyVnqilu8DTzgwwZ9+Higl2PaZEcWJ0kfajAxUw
 0qbcSS2GHoyp1iJg5LgoIJNpcl6qEUvr/D2eIOGuL4ivl9AFJRjN15i0Zr5QsBFh46Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=rIrsKvEAOfI3UAeBGE/mdO3Q2SKU8XVbPa7gOaFnqgs=;
 b=C8//s9UkyeHzsNsITSjR+EpmRf5xa3Mc5j990Fg2/H+hAwynd01qSj77qsqOH/y7vlkn
 N5ouFkv5qbIXt3SSa3BAz7GxP0ZbI8b+nDAIovIrpTQJKZXCvhEA+r5O794van377NJh5
 gTWp92NiyTWIE9HOIPAlF1hrDDcdmRhtLIuN5zuWDil6oO4AY0G/PXC9brdPoXuRLiCnG
 bDE71bzSA2kykUGCycxLeytpvbfh7La9cZY8NqBiANhQSwxGgFcv6UOnWw2SEMkDdTvcJ
 48inb/OLQNSyct/SDS4iXnZTS26SA/5hYQzwMArcnqig+izSId+rW2lxGodN9XOsn7w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NUWojT2+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=NUWojT2+
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8675840062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:44 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so2882320a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401223; cv=none;
 d=google.com; s=arc-20260327;
 b=bpJHay3YhQ/qgyHO43CEdY5n5GhCpy4UNe1YQsTAq/X3zaGUcUAL9s0PNaRV9qaSOv
 k0CN2K9ypwgz6FUkhJLFPzDBN4PWiVwPRIJbvKUFPr/wDBvYgIl1V3Art+HtsH7aLk61
 a4qLGYYfuuYvrYbN/1+MQpxxeyqGoThp8brRn7NQXvVIRKPSaxE7TMjdWpSzZZUo9Ex2
 4b64FMyDH54oKvWJgw4+lhUwmeX5AXFZPcTF5w1w6NPs6Iehq7mmvQ9/xc5OCZrb5LuL
 wSZChCSv+lY8unAnSHcAOTHFOFCjeCQuMcloFYx22RvqlXE6Y2/FCX64+XZNUoXfxRdw
 XFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=rIrsKvEAOfI3UAeBGE/mdO3Q2SKU8XVbPa7gOaFnqgs=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=pYKN0ec5Y50gae1NsLAOSNvFWkqMNM47QVLt6Emuq0aUj7lQPSg04b38q+uEB2feek
 2Rit3mWWiIfxeaE0wHquZNieVJ9PBczfgoNhhzmrRXxBcaih4n68ee6j8jWNUu77JrJM
 PY0o22JVcApqEbUs1kmF5jTprSzy3UvA3pVsSRTZhTdT7RunLQJcpQBw9KklG51ePb9G
 kC6pbQS8G8TjyUsYzUPYqEaL+sqaXlfhjkZMERYrVoiUXzYDKhImGaZ9SfA+UJgIEZOh
 qNeqsD6mGPK/qQ92UdaKBBOpybqXuEX+nGpR43NQVOYzSnHzM04SezCBOg1aP7KUC7ST
 eSyg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401223; x=1793006023;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rIrsKvEAOfI3UAeBGE/mdO3Q2SKU8XVbPa7gOaFnqgs=;
 b=NUWojT2+HZcIs48A6ukVMroPsF5J2fAwc8ylIW4G717Sr5/yizZHpn7s8mnj16Tflp
 77u3nsvnCBUqYPyddQJmMqJ69BrY3lrFuyzq1qGvxFubjQrgZq/WiOcBiIW5/l6LRSWx
 eDqSYXqKCuQ8VRsxWj7dQSK8VSltwvD3VjgOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401223; x=1793006023;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rIrsKvEAOfI3UAeBGE/mdO3Q2SKU8XVbPa7gOaFnqgs=;
 b=MjqWtO9Go0bElYQLYDnUe2d3crC6vzbCVvpyiHn7Bfs7PTAR9aRGtNTyHeP8j6LJcW
 pEBb1g+KzlUuyG+xF7UGCpehA/2v5VYF9G7oeYvd5iUf/BbYUmEu2xhFN/1vTqXGWW5o
 04RLC5/jsCVdJtp4TUdjYAhIZPuY2XjjOqeN5umIOIUzQ9q56gEBaGozjT1cCoEt7Qvc
 M+N/0ltw3boxhXQ2eNNRgbhwwuiHRHL2xKf4PHA9Xt97QUXiX6FlpViiObamFviuRIJ/
 LHIgt7uhRXvR3eEKXFUu3A4mMOBuZ3aHxtheEBIUZnS2lzqcMSzTZ3glL4KSrGYFnOz2
 I1Lw==
X-Gm-Message-State: AFq9FYL4sOK+s0BVBX+b+urO3QOGOA4pvbYOl6MkSSWOHjfsrpcbOw1v
 0FKSlxb6L+FC8pc2rhC+eP8qlW4rltGjMQuGzolHg15cykVNotlu89XCoA+1Lh2z4+v3sCYTNwe
 a/+iU+8UBvNQUOqPAbesqgu79tgqtbIoEplJHWCi0
X-Gm-Gg: AYBFou2VI+/gEQywvLxH2S9c0dewv04fss3POBiCv52Bp08P5F128rKt5NerVYNr4OI
 8W1iHaEc2keReic3Ts3cX4mDEEKPW41FeVpBsVDhx53ZlmTZHZODJItTUC5oMAgwg6QtJ54vr5u
 +aRng1Q5aQZGxr3BfSaYzIiTsOzwpd7wWlwjk1Wa90bZ3pB8HiKEC9CZjkUsQqrsECt8/jcN1cT
 RvLeBWz6sU4i9EHdeKEnQdHxCn6qjeP33v2XM5bOtyFTJXOkgv0V+6AVYFaTAj8AZrIAID2+olk
 M7QnwhL0Oq+QfFP9sux1hUPpD5HnYKffXDGt3AJZcpxnOKaIuYqbAw==
X-Received: by 2002:a05:6402:3216:b0:6ac:9a44:d412 with SMTP id
 4fb4d7f45d1cf-6b3a81a52e1mr4141047a12.7.1792401221051; Mon, 19 Oct 2026
 02:13:41 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:13:38 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:27:45 +0200
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-2-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-2-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:13:38 -0700
X-Gm-Features: AclHuK_2UlMM4Tc87CltJ6kCQmjwOX8bs8_MgQzOH7jV7h8Hyv8HEBH-_s2ok8Q
Message-ID: <CAFLszTghvtQ6xaMD3Kq-AH4S6qKTMd_=JHveVszC5bPV2b5+zw@mail.gmail.com>
Subject: Re: [PATCH 02/14] test: expo: Add a test for menu section headers
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
> test: expo: Add a test for menu section headers
>
> Check that up/down and the initial selection skip a SCENEMIF_HEADER item
> and that scene_menu_select_item() refuses it.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> test/boot/expo.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -67,6 +67,13 @@ enum {
>
>  	/* pointer to current item */
>  	POINTER_TEXT,
> +
> +	STR_ITEM3_LABEL,
> +	STR_ITEM4_LABEL,
> +	ITEM3,
> +	ITEM3_LABEL,
> +	ITEM4,
> +	ITEM4_LABEL,
>  };

Please slot these into the right sections of the enum rather than
appending them after POINTER_TEXT: STR_ITEM3_LABEL / STR_ITEM4_LABEL
belong with the other STR_ITEMn_* under /* strings */, and ITEM3/ITEM4
and their LABELs belong under /* menu items */ alongside ITEM1 and
ITEM2.

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -857,3 +864,68 @@ static int expo_test_build(struct unit_test_state *uts)
> +	/* nothing selectable above: the leading header gives no action */
> +	ut_assertok(expo_send_key(exp, BKEY_UP));
> +	ut_asserteq(-EAGAIN, expo_action_get(exp, &act));

It would be worth also exercising the symmetric case at the bottom
(BKEY_DOWN from ITEM4 with the trailing position producing no action)
and BKEY_SELECT when the current item is a header, so the "refuses it"
contract from patch 1 is pinned down from the key path too.

> diff --git a/test/boot/expo.c b/test/boot/expo.c
> @@ -857,3 +864,68 @@ static int expo_test_build(struct unit_test_state *uts)
> +	ut_assert(scene_menuitem(scn, OBJ_MENU, "hdr1", ITEM1, 0, ITEM1_LABEL,
> +				 0, 0, SCENEMIF_HEADER, NULL) > 0);

Just to check - scene_menu_find_key() in patch 1 now skips
SCENEMIF_HEADER items, but if a caller passes a non-zero key_id on a
header the item is silently created with it and the key never fires.
Worth either asserting that behaviour here or rejecting it in
scene_menuitem(). What do you think?

Regards,
Simon
