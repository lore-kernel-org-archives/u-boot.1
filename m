Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D7CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97E3A60743;
	Mon, 19 Oct 2026 09:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bs-xcY2vDipb; Mon, 19 Oct 2026 09:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E29C605D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401223;
	b=oFHO5efa/iXLWFi4aBW8W5YaMrlcpuGi2TCTz482Zri5Uau4WACef4SSN5gz7yjuB4e7
	 5oCs3Znyb2DXzziKGU1ZTiSO0Ej6OpP8GKUuiBzmP34k+qgkq4kvArzDY1BC3ODSkeU7S
	 CObr+U4mlY4BqziJ7VUZEvtFUWmlqHmpRm2PCIfpOdzFNgD3xZZRh9yS/CSc1wlQoqQs2
	 wGWW847cbjVy5FTc2iw+d/rdZVZgGupfWxjwtYx6cNX/zaUYzInsqluLI4lxIrJ+okPVd
	 A5qnH8frY5Z68l1XLxi5Zu5uKOvZqvJNujD0KckXDIWKbe/nBiue+V2BGrTmuVPQT3Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p5ntJpDYQUo1vinFJ4kf1aqo3C8FcukyxyykGYS5yHE=;
	b=WKWO0Ps315IVP4kAA+EwQGzzDanjk5dhTyrIwvEjpVFexmyL6/D1WlMwnYtdfJPmKCnP
	 bS4eO+Nl/5enSalbBJDUBeR2Tpj8zjP12RdpRAf59hNO1U6nc9XG+IY/k8aMazTCapppR
	 8UXL3cug0LUrb9+pyRov5oYzcmrL9D8INDv+JfQxGl9186eoK/dQM3f03HQ4UCPUHAoL9
	 Nzms3y/pQkOoGmYZjSREVprWRl+IXBd9Gms7NmaSAR16fZfeffkbjkf/4uF694sEP5ID9
	 l4scaLRQoXbDXrUws31g/Pz1Ks392bAmwxvzCy8dWe6a1QvFRjiWgIaaHVQtnIOcD/g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401223;
	bh=p5ntJpDYQUo1vinFJ4kf1aqo3C8FcukyxyykGYS5yHE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OwDtT4EH4dqr3VnbCoWd0dKL0e0l46S8hwCbeJfXj9vSMe9c8gRzwaF9YCv8mv9z8
	 mWeIDrH9lnkACMPrsRYR9uyuQpC1RSZa/Os5iz32UaaRw91qLb2zBzQp9bXN2p3Jwk
	 Yc82njKOdbBPhp39bVGEvx0gAteGkxnmAZIU59Hji4XxISMxPw5hk2fYI+QsvkAFr2
	 R32/RqYyJJppIIpwrDrAvryifv/jn3VmJmxBrZqXDu+3GCiG6w1NkUTT3wEp9I6jd3
	 wRzfpmJDGyeg8/fH8zuWLh3vg98ChgUcy6QaFw0/xuOKujMBHdYJshNmcmTy8UsZmW
	 keg6Acu0gwTKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E29C605D4;
	Mon, 19 Oct 2026 09:13:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDAFC23F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF50C40708
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i4S9Zq8iQ3kL for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DE70406FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401221;
 b=j1pivAORSkn9VTpSi1wGz/RMXLfoZFFEFjIn8LdINBW/XkNM5ZJuWPUIf+ZgDGsHGjtr
 FYVkNiWjkexwaHpendjHjwBVAs7oY6FBWBLQ8HuaoZ72lS114Td/rXi9Vrr8K1/8Bej4Y
 ypUiLrUrsrqkyMD3A4PipzhEh9BnspWh13i8cT4ZqpMptLg5qyg8gLfDsqjYg7Z9/iBsm
 KP0slp0mLPK3Y3pQd9Wmb10zvxQqe9OmDzFdJY3mwk7bMgyvIxrpeN+FaXztIA1vV1fJf
 TRcT9NqU5gNH+SBf26g8vxKzYmGsy31Ut/bjPq6V7mR0nt3zw+w8ZFy5MYE5BleFByg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401221;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=p5ntJpDYQUo1vinFJ4kf1aqo3C8FcukyxyykGYS5yHE=;
 b=MQzN3sxbyXlOXte9KLXWcbuciJIifvivg3WWBmYOwh6Z8UIRVl3u+alcvc1pAF5DtNW2
 liCnX84ta4BvgsNP9gN99f6aZ6Ru3uewPgpZuCHkuq8u+Dy04m1+S0N45L2O4umuLhnBp
 jXlE6Sfikgpmi21e0R5WGC/IxHP+lzsuXjYI6qlF7+zBCv233Y6AS7AJjpSThjCE6chfS
 koIYwShS7DkXeZ8rJ1Zm/jBY+IDyTOeydVyWGOXhznYgg/zMzwxvtwXzKjPO44xvqvMc9
 SwmjtPaF4Lu5tUJmJxlqW+0cuvcXP+O8Qj5NoTEgaC7gCh0mGoTt0/Jn69tocBKnLLw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Vpk8GOL4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Vpk8GOL4
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9DE70406FA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:13:39 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso3047159a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401218; cv=none;
 d=google.com; s=arc-20260327;
 b=EMhL/+ESmBG+x7fZ5mGhjIwQKWvMK8JKgohGLFVkzl1jWNoEm/4aSTyGai157OXLkz
 pXMkiLbmCnZaz2kcNrXBLF5vh+V3m0KeBNx/78BL+cV7krlDsDKoHr9BfhoV3WUTi7cY
 ekmCPcPfYDGkJoEf74zXOEOkslGzV1Ys3CJaqDTm/vI1JUbC3ou4bKqnPTSD9f+bVSWs
 DpuJRLF0CXO60kIPyYDguXQI2BSQx31IKrb5VepKrLyRulbUdHTXJJ8Hmznv50Oi97kl
 dMhq/8XNAUKiWPtbIvvhWG0wKNoihru3YyLnA9LCcKVsfbw9jG4BN2CQ+tkCU9u+qX4b
 nbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=p5ntJpDYQUo1vinFJ4kf1aqo3C8FcukyxyykGYS5yHE=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=jhF86H7aDjG5mOv200oU8VA43AsNz3GdYWz9TEfbx9Td0i9H8yup12Yk+hMpWwBdk2
 vXI49Ux6rI/pf0h1XVAF9TI+M5BU1o31oVeP8vvVTafL8UfmrgyGqB8UDjUt+THQ6HA6
 PZrWHcPIYz0G1OxqG7HjVyiUrSmbQLXVuvoenfPAAD3ueUMegSYdU1pTmRffrjX7WJBI
 wqGHN6VcGfqBmYtGZ8uzL70pOzyYxhXQo0/9nud9ffiVb2Kl0mq7rb2Q1u2JPvWrUH4/
 20g9iUUuDR8CD71NREwjuxkSJGUqhUmrhmT9K+sVNnWSQ1DbV6DV9sYSTS61QpvILD7w
 3TWA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401218; x=1793006018;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p5ntJpDYQUo1vinFJ4kf1aqo3C8FcukyxyykGYS5yHE=;
 b=Vpk8GOL4yueyY4Y0+F4EGpyYlLJqjkA1vDPmb2a6lkA20C9lGys9Szy50mnGTvpCDG
 pfwWuqrgM1SnGn3oJUR2AYa7GoLulV4pKAzMnF7OGoLRkWjcVjgv8mM6XCTjn+2i0Z1D
 vLN/w3ns1OyKKUfZ1e/pczEselNZnDaaGO1dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401218; x=1793006018;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p5ntJpDYQUo1vinFJ4kf1aqo3C8FcukyxyykGYS5yHE=;
 b=JuYCnFTbSKDOMZC9JdqHNBWAo2vRBhDWF3OxKdI1M3LnZzVoMN6QZZ1P2GZhGPDXYI
 pmtyJMhzIkTVudKuv0ZQpb6vi7hQrd9OfBxFG85yZb/ex6vSnPR9Xub6uuFUVH9Xkikm
 9IzA3pN+fRoBkSJhGH2T8xlNcIexXqn/crpur+WkQh0X19FLPtvkhRwT4BpxDlAwAJ6j
 WhE7AWl8XU16cSqkfZr5xdwfZKMNZvdb3y7ikcve+HOdF5eIWYA/6VaqJ0Px3G1fhxYO
 /VogmeSDL2I8vqJKCRpWx0OnMqSdLGx8aocnl7El8CK6fV69Oc9q7yvQNj50iJpX14uh
 l2NQ==
X-Gm-Message-State: AFq9FYLBfPW37pGW5gQ2TwuuAaZs/+OETLxrmYeCDEupvIECLWzy5emJ
 zksLUqn74CV+1vUtoOfQViv2AkaMMY5KaFmzozD7wpFfHpCxEi8vUEXzRqSzf2WeDxJgp+FJJ99
 n/NuNmdbbhp0JIDkWjdWfFaI0MgTRiiD84qJaFAf/
X-Gm-Gg: AYBFou2yvTbYlu648d0+G6Xw1GvyqmQs7z4fOtvs2lITOcApOLt44jhV6OiEnF8bvkg
 dmfNeqwEyIfSg92IhIYRCn+D57fLRQzHAmUEAzbfBj4vNP3bl2D8Ddb/FtdImptqNV+4+Ky48le
 JgFAMAoxEH7c/yJRZoZx8f7huR8YM3642IMvOU7Uhln6OgT9oduCShrfI3QRer5aaXIjNkUT7+m
 TKd5HZYUfcsBv6WVyiOEkwQhzNS8g4fl/FEAw3JXULaDXHGAghYfGX2zlCq3E02stB1eXsyvTZM
 xwCtAxdeq/irdNLNZNbrhEYGYohh0GWD5HRBBqyqCpAH6NEy/V+9Sg==
X-Received: by 2002:a05:6402:460a:b0:6b3:d017:22ae with SMTP id
 4fb4d7f45d1cf-6b3d0173cbcmr1227290a12.39.1792401217680; Mon, 19 Oct 2026
 02:13:37 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 05:13:35 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 09:13:21 +0000
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 05:13:35 -0400
X-Gm-Features: AclHuK9kkzwz59CoopsMGBPyXKR_hd4wkJqbU_eRzTvH91efIDIY7hIAeJrMqAA
Message-ID: <CAFLszTiRCyOmmf_2LpJ452dBr9o19g0-B6SC8hseQkMVy5dRLw@mail.gmail.com>
Subject: Re: [PATCH 00/14] expo: Add menu section headers, wrap-around and
 colour control
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

> This series extends expo with a few things a menu-driven UI needs:

Very nice!

> expo: Allow a text object to have its own colour

The ordering is a little odd - this colour patch sits between the two
menu patches (section headers / wrap-around) and the rest of the
colour work. It would read more naturally if the two menu changes came
first as a group and the colour work followed as a second group, with
this one next to the RGB-text patch at the end.

> expo: Allow the highlight colours to be set

This patch quietly introduces a local rgb_to_colour() helper in
boot/scene.c and retrofits the open-coded video_rgb_to_colour() call
added in 'expo: Allow a box to have its own colour' to use it. It
would be cleaner to add the helper alongside video_rgb_to_colour() (or
just before the background-colour patch) so that the background, box
and RGB-text patches all use it from the start.

> doc/develop/expo.rst |   7 ++

The doc update only covers section headers and wrap-around. Since the
series adds five new colour entry points (scene_txt_set_colour(),
scene_txt_set_rgb(), scene_box_set_rgb(), expo_set_bg_rgb(),
expo_set_highlight_rgb()), it would be worth a short paragraph in
expo.rst to cover them too.

One more thing - I try to check that rendering looks right, so using
video_compress_fb() in more places would help that. Otherwise someone
might break your expectations with a later patch.

Regards,
Simon
