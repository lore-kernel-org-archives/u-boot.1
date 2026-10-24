Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB6606A31D
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tsdxGJbY;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=couqCD33
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AADEB81785;
	Sat, 24 Oct 2026 13:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9R5A24kDOFC; Sat, 24 Oct 2026 13:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 40924819F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847050;
	b=Dnd5OtZK5tXwhQnMFEcuztYgVNgLrYitXgIVyOh0gNywgQIW+ZoGHyKsksLw27JQ4JTE
	 bL6e4Y9klqlWD5rmytxR9IHUlRk2vUdmM4os7iuREk5TJm/8anp4kNjjfYgBnsVaihDPD
	 Ve6dKACbH/sQ76pXiDQiHxmpNTSDL0nkHlQbkAD107sMGG/7duE9rxl8FgCflsV/OZ13P
	 VsdDgr2rsvTH+d2lPRG6zY5dv+GfqBbDYu1TD/0bk3gB/SMtjRCUlf1eY+cvLQrzHE8Ic
	 5O81WlH+YkPT0h5d7DvFLPwkAEtX8nC8Egh+piDSU3uIVjtAcqRlleYXnfihcAEzfew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YU54itRBEfNJNHGg/1vp3s50F24XdboJltyllhxHi70=;
	b=Yym1XupHAvxzPCZD7CTpZ7w/gOnPfUUOf4xtp5W67mdbmgzLm6nVbbvDyXdBVDUAQYWO
	 72WZjnjefklnqiNdXUs23LuAN0kiGtNHb9JlMD1aaErVBAdgQ2/mPERPTJlgHMt3+GLXg
	 IefWVtmfhkyczBseCj94bXn+QuMbGYVhjMxR8i+N7gDubiWpV6fRpElRVDPBOEJ9hZN9D
	 VSRDTEuCAQzhVrxmw9l7ufLylVU1UigrWbf8Q6kA0p7jds1WHroxKfA8eYd95uRr0nSjO
	 yl8jY3CwflknLoAWFfO5jjxF1XkTebBtuzJCn6OD0x5aJfROW/0B9AFGPnQ0Kh/txJQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847050;
	bh=YU54itRBEfNJNHGg/1vp3s50F24XdboJltyllhxHi70=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsdxGJbYjk2elqnqsPeLE9ImqxUCBSvnQTSGTmwIkjwPV55jTll3JL2KyqSOvmdUx
	 eBInZ+dvFx4nsQVhFKL7wHEIXYsaO8e7tZc4nZ99QUhm2hOTSVnwW/KAfmChph2XHh
	 lXBA1sToMrZ9TuF4PseO19kdJJnlsCKhQnS094vRcTSvsuioO6Tzn6PkM6N32L/yYY
	 Pvx4CtF1HX7Jz1Prg1Z+wAxTZmRZMgSj0SMIonK6TLyqo47HUQtihMSYyDEMn1rU2r
	 73dbZcsa8oFmDvVFIKW6c6CWcltOtqcqSkMifLyADmgiLzH44hXXZmh+O9JdgMrmsS
	 S3/7zyuKHPgsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40924819F3;
	Sat, 24 Oct 2026 13:04:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 21DEE2C7
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07D3440ADB
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Msdag1EUrrHs for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:02:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 416FB40AB8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825324;
 b=AIBenYM8h/ik2TOolNx0jHUeohbgZjDNXaSt55SJqnaiu+b9GUFjuBt8cVHLay9eK0Ar
 70DBSDbME8kafik6Pxa7AxglcFmiyU3rfLjrOGIgFCMRgJIFQfAbn7VdYftPGg0rkrVtn
 4ouCqVp+8fXf3YRLh/DByoqGbnGguHW1CaZHEHpownKij5yP9u4oYEthe0KpBL5eKHDeI
 N/nYLKM+D2v/3tfjeER6tIw8SkFQKO7TNsFjg0+iZVG3mL98xKXruc/2yS11zO379owET
 R07cEzRlbA4b3z7qgk777xt8q3gM+P0YOXZJeTKqn9P/kvnP8xdDr1zxuJw7kERZ+Jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825324;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YU54itRBEfNJNHGg/1vp3s50F24XdboJltyllhxHi70=;
 b=ta8kpus+mYrcjDy/TwR0xHlyHYqTAV8iJjpDOeYcp7q9+Df/QEw6cuTb20Aiaa2lwW/3
 jRPv6pa6i/24+UTV0c56tAuswiyIx5MQloynjhrY+LtTqGLW0mDb86rElvD6j5pKWPMJc
 LCjEAVXQLBu8wQADomKDYIkVKCcP0b4gcYtiV7gzmZXqi4jQsu8XvVMErXYN5lOCr/ISJ
 uc3pzFKIQ5ObzGoKs/DIDJXT8pOPCCDSbR4tWAHnhuL389Smal4lwZOmlCa7ZTr/ApfUX
 dqirGNBJ6PCmj0aTANFQ3t+d4mz4PRwY3vvwuBx3EynNXdER0NThDvBTnasa5Nan8vA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=couqCD33; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=couqCD33
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 416FB40AB8
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:02:03 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e5fb79ce82so9988735ad.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825323; cv=none;
 d=google.com; s=arc-20260327;
 b=F1nW6zq4Bt+4AXdclY71eA/pGtQ+SiPbXEBFVLgMr4rzul1HUcnj7WfED3aTb+92yv
 ZH3EliSQ6fzcqjnT6NLznVbmesZODqQ1z9l6LTPedIO3gMi3MqCHW7xYxsrmJNcxfAfH
 n0GaPLNsuE11FFSTk7W0zf4jbWNoFHFDtiphqpaTZoADoKpIyRdsRtuabO+F+p+KZfGk
 RvG+UIJqTbiZ56G83FTHxuHduJZgpx/J34n8SxFnpadN0GfZpGjxiUAscUXQTTOrG3un
 h1aBVlzOkQ+cRGk2PeBeRnUG+txpK19auy2J6G1HgyycuyW7inVFaY2IwwI6iM5cye4L
 3QnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YU54itRBEfNJNHGg/1vp3s50F24XdboJltyllhxHi70=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=XHsRI2s/D5gAFXMSde9BlkdyFJqYxAOA0Yli6sII9g/Vm9Vy0vyKXl+wnan/Y2LZ3A
 VwREbH3XxuaD53vpFPa9dNMor29ZbvDPDEof6ESnufib2Wu/ZTyMN+J7F8cKKz0Vpxo1
 H8Ioaioh2vNC38zmrZTP8EPsR94V7Ezvg7ZlzR21XA8FuEXciC/y1y8NJdB1l+Ghl7k+
 38pWSxOK6MiQtc1cTNcmJ+9Oem0PFxcPIJEKsChGnxvZzk9fY8xkAe7HuEmDLPGgDkbf
 tvjPB7QTJEufetkrKR/eNpBpZqavtn4jhDrbr46ePQJRGlEP7yi0rV7Hf2/rwLr8Ce3l
 JcuQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825323; x=1793430123;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YU54itRBEfNJNHGg/1vp3s50F24XdboJltyllhxHi70=;
 b=couqCD33neHzztlLib4LAH9uJQzamzbi8cJpSR2bT3MnNCu4LoBmssRs9SxcNtYk6+
 x2A+trdyNrjAp+CKY1kD4oFUspdparsZiZ0/EzeMvRM0/zkQjB2j/WrKNeqg5v7/uA1d
 eia4Vo4oCeul6OF7+0qJE4x5NJvfoPxVLkwW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825323; x=1793430123;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YU54itRBEfNJNHGg/1vp3s50F24XdboJltyllhxHi70=;
 b=tQ0+bBMq4nGPGBCUKZqTVrrAbQUlAAhLGUWoUwn3fl0Y1mM5hZw92GPnfjnQaVrUoX
 eIY7H4RqVInmyk6e2WHLHrUymkOzu0EnVY2SRh997zIkNEvzoE4cl5wQaGDqWewbWLQ8
 3LuwAZtTbkCkzfhe5azM6TUcn1e3DB/JtRGO1p/lUmUejn/V0esMIRM7X3wl6+qWxODD
 lbI/8VDAlqjtZEtKIN3IU2UR0rGCojRmDGm14xXq9DRw10XydYVRy4kct8ZxRU5GeTah
 G1VOVZWNlOO7ATk0ujDlNfYh9yp/ewXyMhwT5Bdjio9rQgYfiWvkSlmV9Id79+vbh07g
 2SSg==
X-Gm-Message-State: AFq9FYJr0pItOMjpLNOtkGbTDytNu7rSqpWCpSK9GL1SgTA8yX/mgrrz
 z13HAMsjNENdxO7bJEECiy6oyToep7Dd7yam9XfgffBSNF3w1KnexKJsplLyZLvHGSLW3sBzfvq
 yUDW3dZzabHD+fAo5vvNMCR7G2LNgRCpjOne2AJRd
X-Gm-Gg: AYBFou03TlX2Akn3t49hmfRT928CnH/asjU1Cd1xvc97YyWg6JQ4Ct7Ufzt/jgX4mAf
 Pu9nRRhQPfeQmUPC/CO6X3TWBvXyNVkWu2IGr/xWany72Ov2UrBZIFZnKM8YEv1eRgbTtmFqN3c
 vyyXiffi3ryxPYWrlpCDeFo5akrbI+9R/FMwS9PEFYedlH0cenUnG0E0maU4gbDrCFzpUTgrB5M
 Djrz3CTAsZRyUximpmavHLkUqZ5Amb7h0flaM9v0Be82jIXc30HQL9yLD3u0n2I+J/qh2r6q5j5
 7QewLyejNN2Lvk2b2z+32KoqTLCln/EXX2ZDtLdAhAlFkM+syVL9tuRCez8TLl2PBJcGl+QHgIT
 EQP/lb5/eNC2BRArqfA2ad4RBLsgdjUbL58s=
X-Received: by 2002:a17:90b:17c9:b0:3ab:9f89:e1b3 with SMTP id
 98e67ed59e1d1-3adeafc1f30mr1178444a91.40.1792825323343; Sat, 24 Oct 2026
 00:02:03 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:02:00 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:40 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-20-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-20-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:02:00 -0700
X-Gm-Features: AclHuK-TXHB8cyDGU0IbkNrQ-KXOHRDH2AiJW1f6tr2zPvbZSETC5h7A-h_3yIk
Message-ID: <CAFLszTiOofXj0HqXDU5CtOdHtBHQHdKSRV7vmTFf2ZyKap3Dxg@mail.gmail.com>
Subject: Re: [PATCH v3 20/23] boot: fit: Allow choosing how SPL's FIT payload
 is compressed
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> boot: fit: Allow choosing how SPL's FIT payload is compressed
>
> Platforms which build the FIT that SPL loads have no say in how the
> U-Boot proper payload inside it is compressed. The ones that compress at
> all infer the algorithm from whichever SPL decompressor happens to be
> enabled, so turning one on for an unrelated reason silently changes the
> image, and asking for a particular algorithm is impossible.
>
> Add a generic choice for it, covering every algorithm SPL can unpack,
> where each option enables the decompressor that provides it, alongside a
> companion compression level.
>
> Gate it on HAVE_SPL_FIT_COMPRESSION so it is only offered where it does
> something: a platform selects that once its image generation honours the
> resulting string. Until then the choice stays hidden and the string reads
> "none", so an image description may reference it unconditionally.
>
> Offer the level only for algorithms whose tools take one, so that a new
> algorithm has to opt in. Let 0 stand for passing none, which leaves a
> tool's own level 0 (gzip's 'store') out of reach, as binman rejects it
> [...]
>
>  boot/Kconfig | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -66,6 +66,15 @@ config BUTTON_CMD
> +	  Selected by platforms which build the FIT containing the U-Boot
> +	  proper by applying compression specified in SPL_FIT_UBOOT_COMP and
> +	  SPL_FIT_UBOOT_COMP_LEVEL. This in turn shows the selection for those
> +	  options in Kconfig, so that the user can configure any supported
> +	  compression without the platform itself duplicating the boilerplate.

This is a little hard to follow. Please can you make it more direct,
e.g. 'Select this if the platform's binman description compresses
U-Boot proper as set by SPL_FIT_UBOOT_COMP and
SPL_FIT_UBOOT_COMP_LEVEL. This makes those options visible.' The bit
about 'duplicating the boilerplate' can go, and 'the U-Boot proper'
should be 'U-Boot proper'.

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -347,6 +356,94 @@ config SPL_FIT_IMAGE_POST_PROCESS
> +choice
> +	prompt "Compression for U-Boot proper in the FIT that SPL loads"
> +	depends on SPL_FIT && HAVE_SPL_FIT_COMPRESSION
> +	default SPL_FIT_UBOOT_COMP_NONE

The decompression lives in spl_fit.c, which is only built with
SPL_LOAD_FIT; SPL_FIT on its own just provides the FIT library. So a
board with only SPL_FIT could pick gzip, link SPL_GZIP and get a
compressed image that nothing in SPL unpacks. I think this should
depend on SPL_LOAD_FIT, which selects SPL_FIT anyway.

The default line is not needed, since the first entry is the default.

Regards,
Simon
