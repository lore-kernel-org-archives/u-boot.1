Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDE3CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E69B660765;
	Mon, 19 Oct 2026 09:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6fiCuDyWOAk; Mon, 19 Oct 2026 09:15:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0D29B607A3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401310;
	b=ANighZIFcSoHE4RpIW6zK8zSlJFgRP7qL7+7lMuN96Lt/NYyp/U+SgdeGSFqHrdZ40xV
	 DNE4e1K+5sbsToq4GJ754b3rVvBkMYCXWiyawo0J7KbgFhH8WaoWbQsZXwCx7V0SKOdEh
	 feSCA6aZbENQ1S0xvU9zCcAJHl9bRLrZJfFogc/b23H2WCbnWzlTaDEUy0isie0i6lCcF
	 tfwFE5RqqqqSPqdvSjrpiU/a2H2GXGXoJ0Y9MIHV3E5tsMbjxSafSHeKZ8LYe6DbUHhs2
	 rGWRUh16EpeeUTkqi+Ev4jYpgTKngORwcQn4S20bTHuH4Z+CwHXcSpeMeAEihdx9Z+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kaot47ltSDQTGLncLc1W1/Wo+z+SFWAYcUfNmmcu0ec=;
	b=PGZc69xdTXif1JuhiW3KXkGJxS6BVyKFaKgBBvOKokSqp7rbJpQoMsv679DWgLmRrcJX
	 dBbvfSlj3eqMJaPdDzIcQHWSDAQsjuRbqYYL4sRWAADUM++Uwcy87jwnqrYQr8RKkzpiL
	 bsMovGde9uGXG3V3OYPpkOteMpquVTNMua20eN6g68/7o0Crvd6ulvbt44PvbKXpILl85
	 Jt2GuODeXYVwsj98gU9eWpWcoCFOg5FBDmkbBoBag8HWXggrT4iLSIHuWnfTyZwdBmEKc
	 c4FvGY9GBKZmh6341kATpFZJLRTUy3vMk7KixbruKQCiC08amsIgG1ZsptUr5rKCTjg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401310;
	bh=kaot47ltSDQTGLncLc1W1/Wo+z+SFWAYcUfNmmcu0ec=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RFRVI9yrghfv+oCx0aoGYgT7zPUDFJKc0fKaLgMr1mfGSDuKf2YJA8ozfaw2GqYDn
	 919wbdaLtvyc9Jw17mXDZd6AKVIffbTeJHyhDSwqwSI9NbKirWj6TNIlHgmY3jfqKP
	 8UTYUfDClBf8miTIJecmDiP5+zd4CTTXMYJ8MDGbraFDIB7sPYYswWbzOeWPXKTOHw
	 MIDXp8k3SNOuxv9KQmFvdODrCfk0z2n58LoXrBAtewnFwnEcOTzhmuDRaCd3bKZojU
	 YfB/tTvWSdwDyHaPT2MY7lJvsG8fiRMjOzb7aDDkZ7AiiDnWc4sa8/jFoGtejVMKVn
	 Sb6NwGjzDMgqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D29B607A3;
	Mon, 19 Oct 2026 09:15:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E17EF1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7C3180FB7
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id itr43NyiKfgV for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:15:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9327980F6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401308;
 b=j819GtFcrd/d/AVt9X9YN95sJjpRAfXr7OkMrtMG9POOiPKi2GV3sxkwd3HZ71iGvVl+
 fcFzi/WmJyZEEYaoDh/NNDC5+qDU7KmtLq8n/d6xoiUCuuAb9KcIdsTbThRQhUkShnsQa
 eeTmd/rEcglL8Bz8W4hAFRbKkxH6rNdIFP+zevQZjx1r2N6CKQX+fzRq2B9dPMfTuhq6x
 gL0jt3dld6M88qDy4ptqBCiA2pFZeFg8GF2Zt2yxyP39JHlfW9ojTE+lLNgxieq8mYDRd
 NqBHT/mL8CKb5b6xd6ZMdpHOAPyHqHT+hiJBmjqdSuvKou/gooGocpInuRQOMsluKGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401308;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=kaot47ltSDQTGLncLc1W1/Wo+z+SFWAYcUfNmmcu0ec=;
 b=OFsoVtBNAenft9Pvg+0BRzJVS201Z9d/YP0k5U5ILMzzffx+oKkNthyrpQNWDy0jjaW8
 jlC8AhWCd4UzqPQVyAT82gBdsjSgT0iSECER8D9AXnUvd5WBvpeERgRWvGE+bygjfEzFV
 f8ZHIwXyAIRfMMu1YBJ/DPj/szXHNSVFabmATX02FPZfqE4tA26sY6q0yFyI5uyT03iQK
 /LQwA9/JGtz2iTZDid8ZGyv8Y3c97D3rP1M9+Ew+UP9UggVpgB5RtRSuANuXkvaZhgPkO
 R+NpJhGxNP08ywQ5Oc7sQAtSfpt4i0+9riEkUGDxlhH6zWNf3xDqgJL8GihcvKbP1uQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=C7KsNODk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=C7KsNODk
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9327980F6C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:15:06 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso2520015a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401305; cv=none;
 d=google.com; s=arc-20260327;
 b=D7EBKeCQX37kUHwLLVe/Lw5SVwV3D2rxoy5ZORayrn6itnhz7EgqcknLjXimU37yn2
 3jwU53ULP+PevloFTP79pSLeP3CTuRb7/3uysWjhFxkHhiFZ/zlzkPZDwSueSeQQG+tk
 FgtOXfEEGt2i5ujs+w4nlMNY60/2hconAxEpXSYWIEXNQR0xTfQhETIxQfNgLggLhipv
 9OH3LgpOxtCHOcxBoR5C/UE3A+yF2fpHmzc452bIYQ0rG3kwzstpYtopaHhtQI23L1tc
 3dzLM3OFL9gBLj4zkXxyp2KHXMBO65FXUvlxZeQdhYXcCzWWwjLRhAEnEhECO4nFhOhW
 mJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=kaot47ltSDQTGLncLc1W1/Wo+z+SFWAYcUfNmmcu0ec=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=mjCB3eOz2xztH3zbE9csUqZIp3Jgx7gTpBoDOsFSZwGkyumGQcKI2n5CKE4NaBSPiW
 EhUaiOMaCIyR7sexK9bUW51/Jxe34bgnCUWlXtmgfl3vur3h1ST9ygcvaoiUSlKiq9lw
 McRcCaniNl02fPSVCE++FvhJej5pqMGyA/0yXLbloFJYoMAEo3qv+z2mCiMfycv0FrcH
 mjm33n6OXVx+s/D4OKDaansxVkJzUzFQP6lZjnQ+9eKuVLInsa/tf9NIp4f730s/Jycu
 xGQ4mzFx/bq/5iWsNFE31OZo048kIH440vlflWLUbHrfASnMuue7WXgJZUOejaMv/zi2
 Gg5g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401305; x=1793006105;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kaot47ltSDQTGLncLc1W1/Wo+z+SFWAYcUfNmmcu0ec=;
 b=C7KsNODke2hNBeRxgsMEuTXkDlQWMS2Ht1k5Dbvi0NzGKr0odqTI8pFCsD3HG88hTp
 lx1pGXmvi8TgSODh0Jytk77YD+n+AZM4ubARlrxiSaRH5E11ksD/cg6HS8vjx154y3JA
 wpJS7bIcF7Lpn4fN8VcxussnBpS4Ez50xbzxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401305; x=1793006105;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kaot47ltSDQTGLncLc1W1/Wo+z+SFWAYcUfNmmcu0ec=;
 b=jEK5GKCWDcpV3WZ24UKfbD8M5MmAcr6wqsnI0p7716oU8uoG9j+xgCzLHGLgTw2tcI
 thoe6tCiVkbNQVOiyGFqnUXdIa0+Kw6cYkJY43oJnIkt9zfbhZjESpiQwFGl1MSmFES5
 8i7BYmr4j3QvjUn9lHLrSefYY2KWv5YYsZyP8HusPaRJmXQu3dKyhvn00d0EEEvTeZox
 bT9CzBInUvT/j17XVnI5OEeiISnLdQzt8m7I3pBF2fjKjOaEPh0Zcc607uzFYKcr70Bh
 7GXleThPWU+Y42P3rMJVK0FIlBM//B2s+ulc8FcvnizSVNp7sDBbFM0A8mHeiZRMSi1H
 Ne4g==
X-Gm-Message-State: AFq9FYKIVhATWs0U38xtxlTazYSDNEWCLFK6ggX2wJit9nxldpog1WCd
 VxnzDcFnwiDIyvLAEu74eujnyFhIp1ycqjq40rcDkEhGz8p0kXzYEM3hD7UmpchLYLGEPOyeX6f
 F9eCCXpy7ukuAWloShJzQ/fa2fp3Q42cLpqRWbibS
X-Gm-Gg: AYBFou3hGOPU8EvnC5usBGvMjTkvEhREVGo3DmEjN5u4FWFE0HB2/ZFSdeNto4m+p/y
 fYGiSruDPKgLqd7I4P8rnn16H8ckSf61aLojQB4ZeFE0S7jevUzP/FlVzDut3xoWoaEKHqkD3df
 jPtF7K8pThWSbeDcBb+taJRiFgEiXKN/dPitG3WJLt+2SW7jA83kZmGtQIAdvYJndVcee9Rxx9Q
 hlEw0JPt7G0tZQDZJ3UyC2vWnUGbX5sYCZr415lwPpmkB48Iu2v839IPv8/ChNirWIveme//fw4
 joKaOVppTC/4LbC321V3bsNXc9pCn36XVfpNEK/0KFidHghg6XZqUw==
X-Received: by 2002:a05:6402:4503:b0:6aa:ee54:9724 with SMTP id
 4fb4d7f45d1cf-6b3a81c128dmr3957207a12.16.1792401304774; Mon, 19 Oct 2026
 02:15:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:15:01 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 07:07:10 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-13-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-13-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:15:01 +0200
X-Gm-Features: AclHuK8U4fAJL508czKx5pB42yX4b1wDxKW00AMR2mnH3PpP1h_jZ5EmB3fCUrs
Message-ID: <CAFLszTiYkOZaYLevibQO+vstD77wdzdEzCxPXGaHx+V+rfc9aA@mail.gmail.com>
Subject: Re: [PATCH 13/14] expo: Allow a text object to have an RGB colour
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

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> expo: Allow a text object to have an RGB colour
>
> scene_txt_set_colour() is limited to the sixteen console colours. Add
> scene_txt_set_rgb() to draw a text object in any 0xRRGGBB colour.
>
> Similar to the console colours it is not used while the object
> is highlighted.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/scene.c   | 22 +++++++++++++++++++---
>  include/expo.h | 18 ++++++++++++++++++
>  2 files changed, 37 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
