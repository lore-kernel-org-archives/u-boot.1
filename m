Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55EAC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B728891F;
	Mon, 15 Jul 2024 15:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oWvURvUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5452B8891E; Mon, 15 Jul 2024 15:32:00 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442DA8892C
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b73f7b855bso26601836d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050317; x=1721655117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rfGlxC5XW46MnWAwaqM+wQOOmD1acPejd/yMaJA/g9c=;
 b=oWvURvUKPM5a/MpWlplW49ZvV86/o7IItAqbMZKTOz3sXkOXEYWrJkiexCXbKVQHU+
 3u0eusrWQspSufeqy4y4diDbiH4evCatNToSrRwEEamTUT1I8S+NCk1+6nfzcfgx+c5E
 NcimMZmoMAnq2WEsHdBQFbcQsvE7YufYOJpro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050317; x=1721655117;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rfGlxC5XW46MnWAwaqM+wQOOmD1acPejd/yMaJA/g9c=;
 b=quMdQ69xN5Y4C76yxOJLaeigL3D183obwfDWxH83uAdZY8ybisndbnxjiW0E0BHEDE
 IrIhSizNqr60WhvtJRZOWMuZMmIoD9sqR6fiNb2W1N8pyNJ27Cb1CXtaL2gnfISYK2LD
 Cwym+YTp7CyhgUJErUKEMls9g8+LeoyTZyaaGN0XaYc9aDEdIzfCjpoycz4BxxJgPjO2
 NtKBYqlFkHBdCTvVT5mqK0vz7rdbGlbqdm3iipEYlQnBabkNhFKCLX+W2Gmhwk+fBA87
 rIEAMEzK01rR/0X8SGrZTRU7r3Ie60BE2npZOIQl7ULlSmw+0PeKnTqqL3H95i1dWq07
 LFMA==
X-Gm-Message-State: AOJu0Yw4hFx8B/Fg1CoVWVyg2UqleQFufhYAOZ2Iw5coOjHfqZrVfRQn
 YSm1Qcp1Rz2ffJZnpRxc8X6eWLfQrQQApXRKb8btrzeXbd2iD3KVERKrqOksQILDWEFrUpt3/0a
 WN7crsT+Xr/SWL3lfh0RABIq9cYOVCSm6/ZFb
X-Google-Smtp-Source: AGHT+IFD7LoYisFm1XCEbQlr7rhRDJm6u3aqovfJKWOPw6Li7lfujLu3aN3+L0wZF92xUPaiJUQNlOuqpVnss5LXcXU=
X-Received: by 2002:a05:6214:410d:b0:6b7:4398:594c with SMTP id
 6a1803df08f44-6b743985d1cmr182883236d6.38.1721050317286; Mon, 15 Jul 2024
 06:31:57 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 08:31:56 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThrC2DnGw1PBh09Bx7PYvfuLXcM2yUNpeBYiub6ebRsOQ@mail.gmail.com>
References: <CAFLszThrC2DnGw1PBh09Bx7PYvfuLXcM2yUNpeBYiub6ebRsOQ@mail.gmail.com>
 <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-2-seanga2@gmail.com>
Date: Mon, 15 Jul 2024 08:31:56 -0500
X-Google-Sender-Auth: YLsPN9y7XBCg_HzdSPaeI642BcU
Message-ID: <CAFLszTiVrznOrrW0Ld8JVxU3Bh0-Q_jLCiGkiea3crkm7uu-zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] patman: Fix tests if add_maintainers is set to False
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>
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

On Fri, 19 Apr 2024 at 03:36, Sean Anderson <seanga2@gmail.com> wrote:
>
> If add_maintainers is set to False in the user's ~/.patman config, it will
> cause the custom_get_maintainer_script to fail since that test expects
> maintainers to be added. Set add_maintainer to True in the .patman config
> to prevent this.
>
> Fixes: 8c042fb7f9f ("patman: add '--get-maintainer-script' argument")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  tools/patman/func_test.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
