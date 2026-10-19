Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1726CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 996E180D7F;
	Mon, 19 Oct 2026 13:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NR4cMn5b5pF; Mon, 19 Oct 2026 13:24:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3869180DB3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416242;
	b=n5jp2dtaZcfhPSvjvYgqCKCjtIUg1XGVbZHVegcWZqqpoPG8BcwXV+SftDnHGHfdVV1m
	 cKB2cb1odWiB6AkgSQbYiDpnfaSHKx1KzoUNj3jK1z/TF3M4d8ywA4DADjlfzVfu2jN7C
	 CigWsIhwZ40oLltP0JHH8agjdE5eq+pMVwPIIZhbys+9VtftSSnFSYiHpQYxgHQ1BKmfD
	 nf8JGJJKtu5K0L5uNlWBu378Nyz3q3HcLW0pAGmTrzGFzDokZguUeUU9Yi3fzTM2YiWbE
	 Xgf1AIr3KT9slRxRx13K6XxBcbt5CxXrVacHtvmmkmwEktMEuWUR1tkL3loL1MHKP8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uI3EfTz6isn8x5wmrLktrCF+MY2UI1AchJSPhP3zWRs=;
	b=PSCx2D6Vjx6z0rl/5i5GF0x0flrpLP1G4cQDv2bnJpnfHoy345rwtH2+tEyDdA64LH2Y
	 txN+Igo4RJmrXqb54i2AKcJIjrmeNI9u4UDwilMl2aGOf+OGWT89c1qGPKtTEfequ29uf
	 xxIJ2N6zdy3C9zSiXhMR09I4/0G1RjbBoz6abLPoHTklVzfehoM9StJD4Y9++nbS3RJBe
	 bGrthKJQ9h1PqnROwO6zEygT9S693wh79Dy+lvi+WG2M+feU3415YokpqQaLx1D5dYXvF
	 Y1GUnVQ2XqZJtwI0VZ6gOYI0WuPXCi1lTnR+8s0IfGmwpz6S3HckNW+VxzWlDNc6Jcg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416242;
	bh=uI3EfTz6isn8x5wmrLktrCF+MY2UI1AchJSPhP3zWRs=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YMVGMiw+J1SjYaPnB94PWlvY6/xJ2VvKv/5ikTz/26VRLZmKYWWa3p0BKy3TMWNZh
	 aSTE1fxts61wH3jreeDDb4XdyGrSmHMOn3jfsr6lN3BB6vNVztNKn99ttsaVKW+TwJ
	 YevxtmXvs/05H0yae/JLXRNrLYho0YAmEwi/QEL5d03mtPoFYwOsaIE8OLf+3yo4+y
	 GRpyzgeNcFXFaMryu+t/pxaa1d9atgyPsH9PiRgWIU+v00HKGi+nBuGyl8O2RewU/J
	 ZUzxxW7wCn0gwRGpqTMle112o2BTZF1qsMaDD1erNsCzlZV7LZ/eKPHjJfmmaPR4Cs
	 aDhuU6UmYGc/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3869180DB3;
	Mon, 19 Oct 2026 13:24:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EF10F263
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4F4F406E0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-lEzi7XOiOB for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0C0E2406AE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402302;
 b=gzqfnZwXf9Yg0JoFZNH98PP+48fvlRRdrHczUUyEas6avNlj66UfGCYTQSyuFtYfuVhT
 7GjWbC6unq7NNOgLebDMip9186JKGJgfPLFTq5UO1ucP8R0rgj+vt/qk1M87yo1kovnoF
 3KhHKAy1mGeN0hImIFUu7jjreV8EBYQj32iO19b1TEAcAfwzt2D4uaidNOcdnWIl593FX
 TMwJn4l3D5OA5iFYYvKrY5Onpaan4bIISWxaQ37PIycnGRP+97WatO5Gg99W6WVPXzJDO
 8Fc7uGbbau5g0c/nPMkhQSVoTZ7FFzUvkuMqWH/JNd50Z0v0wnuBtpwsoQffW8kHBzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402302;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=uI3EfTz6isn8x5wmrLktrCF+MY2UI1AchJSPhP3zWRs=;
 b=FAjwhS328DKL9s6jVwx6Ai/Uf81C3lGDDdSUQBzcmhmvL2W+ohu6YZTwdWcC5pII6t38
 Y8JT2TVLmg3O8dEv41ldu9FuKs1BoRJnigVPVv/2YJ6vvtVjKLkMAOZIvEkkWWm2tT6GJ
 /56m1bu0hl/qzdidxPXqYWDV/baai+XYM0Efqj0BOqm36Hs2T1iEIvkpmZyeakCFrMJX+
 1YDOr11PrTSaQv2zjQChFz/B9KLSO9s5M1kalzNakSFXF6ph79poTFP8qqcWkz46eFeUI
 h5JP+hhct/YZknISHi2yvDkcg7lZihDkFmO0iKM4L17aSWvT52hvzTOasW0jtL0tNfg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ZZo+9v+i; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ZZo+9v+i
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0C0E2406AE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:31:41 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so1164574a91.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792402301; cv=none;
 d=google.com; s=arc-20260327;
 b=hZH7DPKBa+2vFlxDtxK5vTkM30PQ5vg5J4ysowB5BDdi1h0T3+EGsegI/RyMOCqhpc
 RsW1qy5b1o1PFr71ULrRV5TawvzPq2gDWRSG/kHb2zTFIr7aoOfQCtASJxQulKg1T4JR
 9U83GhQrR2TchtXZB6gHAz2mllipPSrbSiomy5EO1oQ8bpXf0XWGZwDz3rbWLvxCNKnD
 Vz8AExoBewKP/eRvMwoYGtuQg2xDfO/mdnBUcq6XjqvPlXGZQdVZVn42F8XcRaRxdrZR
 LKaDg4xlhySzGHdTzy5FygsYEXQZyqtls5/rtrWaS/6tU7VbBgUc+w5BWAgZodjE13in
 N2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=uI3EfTz6isn8x5wmrLktrCF+MY2UI1AchJSPhP3zWRs=;
 fh=kzHromRD267o7dz7ED52fLWUKZ4ea6gnDSHFORdnZ8s=;
 b=fzChoM/8u5SKDM1htDjWclRDPyT2/YtUcunvUFTPXH/ij9kUnZoEAiqv54Z+A314X4
 WsLPMHcT+yJHMixoSXiYHDpikiDhspZrO6g1EaACnMXx2uNNSIgTvy+zckbsbwK77ral
 SfzzoJ/pK8DP450vowWnbc2WwNWXJypMaSVXvWdqdl+VjhuXScmo8pd+bbd4I8H12qlU
 tYngEYaXFCM4AdNRQY77SAQxVssauBzhLqquAEDEtilWjDIrKkrha3AiyeNNPZ0FgXZt
 kT4Vrc1I8C3jwh5Mo2a2jlcqXlIOkY4ukYsA19smJzKQ+4VyzODtFsLaZtS25LTvZ+0y
 UWLA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792402301; x=1793007101;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uI3EfTz6isn8x5wmrLktrCF+MY2UI1AchJSPhP3zWRs=;
 b=ZZo+9v+i6Rjd2DbbnNlafIZSBKOJ9pve6AYaryqoeA6rEmd6seuhCUZPJcHvKnxxgy
 yiL2/3D9wE2oEjq9w20k70spO5WxDw2IWrA5xgvV+oLNhnrmzg1+yNbniabhOf6Wr/hW
 sjLQUHm9he+zTnf778UcYbbmCDxJw13PRRHAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402301; x=1793007101;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uI3EfTz6isn8x5wmrLktrCF+MY2UI1AchJSPhP3zWRs=;
 b=qpOND4UjG4ww7ZLyJGIL8sxsnpCj3Mms3hOCPTjHJIYxI1xPrewyA6ge53KqrL1eWz
 xqOgb4YnzoFsvg3TKlEtD0pX1d5J4S+YcRm6PFPP+k7ZFFEilyaXLQvYwvdtAiuZNt6g
 duASMK0wR6Lp38Yen8lDBwh2KBL9bPCkjf0qcQhaAenFcUKHJ+PBCiVBLZnlXUWoK2WT
 xM9k8a7oZmXQmh8Wc8PqKRi3hiNZCjPnPupY9tHiFNFY7doS2dwxLv5k1X1L++FaA89U
 4BE1uxxefkcfRVjFmpX26MVFh5mT5rhjt3hK7iUWBl6BfBF3SFymwk5AdYFe3VbgPbS1
 2/0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx75cfJFX31cKvLkpzN51N+KCDPcje5RtQplfdq8pSwsNwygx85eREUJPaCgffVNYHCjIQcZRo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJQkfhWZ40mpjyVswn0UjdthyG3KC1hI2PrZM/gp16KTcLkebY0
 zGPnw0Bb64/aI7Ypy6uOVm2SqD+GlS8WxELCO/AOMnCPx2ofTRKepvXoJbhys6wFKiw+Ln0FB2O
 aUbSBBeFRwSGMKmJ0lNktZUBxa/1I5ox5n4T5L+a6
X-Gm-Gg: AYBFou3UwZmvd/lTNgWIZjvuuUgyipKgwON2eQnIvryrKW57ulIDIQKQVlbG/woEcHL
 3kzI837vpfgacGI01LarVyJfegQAttEZLW1WC8/Q30vvHkf55EXAlDhLI/lORStLBWoySSLjAdA
 IQBb1JUGjNJbrktB9mOLOyA4fop2ExX0lHQ9OTXRvx/pb8LHnovasJYXp2ziTOXhHZ7bULJ4MOb
 SnRwqTaN60q+i9xywUeVgs5ZHcGozgrSrUJ8lOoNeArpWfUVWtqtwurUEz2Z36KOqjxVSct+u7A
 qWGXKF6JurJ10L+/gKqEHhVQMU6DnWef5NwBb5nmqZspuUkgulX3HQ==
X-Received: by 2002:a17:90b:1a85:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3acef5ae3f8mr6935064a91.58.1792402300731; Mon, 19 Oct 2026
 02:31:40 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:31:34 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 02:30:33 -0700
MIME-Version: 1.0
In-Reply-To: <20261016-submit-ce-series-v2-v9-6-c24e64daafe9@gmail.com>
References: <20261016-submit-ce-series-v2-v9-0-c24e64daafe9@gmail.com>
 <20261016-submit-ce-series-v2-v9-6-c24e64daafe9@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 02:31:34 -0700
X-Gm-Features: AclHuK8EHcy8Ia8bhA2fdZI6ywBBSBWMVchHvH2Zxgt3lmB5m24VL2y_1TkrQbw
Message-ID: <CAFLszThm4v23LicFYC2T_knMzTmLnz_BFMNiLKSy12nKp8Hc3w@mail.gmail.com>
Subject: Re: [PATCH v9 06/17] crypto: aspeed: preserve Caliptra hash update
 boundaries
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.u-boot-project.org, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>,
 Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, Raymond Mao <raymondmaoca@gmail.com>,
 Yao Zi <me@ziyao.cc>, Philippe Reynes <philippe.reynes@softathome.com>,
 Petr Hodina <petr.hodina@protonmail.com>, 
 Michael Srba <Michael.Srba@seznam.cz>,
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@flipper.net>, 
 Lukasz Majewski <lukma@nabladev.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

On 2026-10-17T00:35:14, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: aspeed: preserve Caliptra hash update boundaries
>
> The Caliptra SHA accelerator consumes a stream of 32-bit DATAIN words.
> cptra_sha_update() pads every update to a word, so splitting an input at
> a non-word-aligned boundary inserts bytes into that stream. For example,
> one byte followed by three bytes does not hash the same data as a single
> four-byte update. This also affects one-shot hashing when watchdog chunks
> are not word-aligned.
>
> Keep a partial word in the context across updates and write it, padded,
> only at finish. Empty updates must not write DATAIN, since that would
> insert a word into an existing stream. An entirely empty message still
> needs one DATAIN write at finish to start the streaming state machine,
> with DLEN left at zero.
>
> Reject cumulative lengths which overflow the 32-bit DLEN register before
> changing the context or hardware. Share driver-local cleanup between
> finish and the one-shot update-error paths, zeroizing the engine and
> releasing its lock and context. Also free the allocated context when
> initial hardware-lock acquisition fails.
>
> Fixes: fca70d61817b ("drivers/crypto: aspeed: Add Caliptra SHA ACC support")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/aspeed/cptra_sha.c | 78 +++++++++++++++++++++++++--------------
>  1 file changed, 51 insertions(+), 27 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
