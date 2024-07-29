Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F8C3DA7E
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:22:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 999F98888F;
	Mon, 29 Jul 2024 18:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gzQ5g+j+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFA288852; Mon, 29 Jul 2024 18:19:38 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52FBC88837
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso24725356d6.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269975; x=1722874775; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f41jIIBE7MjfktqVnNTnJRFlYrvrGosiQ9YkQL49wzM=;
 b=gzQ5g+j+eOh2PVqU7s+fU2pJMPCSDastTTp7ul4q9r+itzaFoP621xxhB6/CyV2YH9
 xlXwUee3uzBo2kh1zxVu/9LOmEm7ZDc9FguHNxfXF5AmpLJAeRrgXwGD93OendSiJnN7
 H08d19SBjfk8OkDhH2UAEDfXh64/Ag//QKPlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269975; x=1722874775;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f41jIIBE7MjfktqVnNTnJRFlYrvrGosiQ9YkQL49wzM=;
 b=Z1kdYqtMHtA4AJprbeD2ZjbBIjXFlOpHKFR9C66aBXkngBDC6+3hwBdxAg/Whutlzv
 Wf7rMmC0Q5w3jnwmgGJZ/qysV62SKthbny0cZsDVPZxE7vwQDcg/h80umayeGGHINs2N
 wyqkudki+yEH8d66Z57eE/UO7KynGR1C+fcQddWO1j8G+9KmHCN+f1++/g9lqRpmirjJ
 0tqC1AQSTrFYa94g/epo0DHhF2o3DhyQFdiUVqBupUi2iSLKlUgRf6Z49lZFBiVLvGe+
 +CJ65iJwOcOUBFwy/tMGHT0g2bBsa/SN9D4OLuQ/yH/V2rIqnnhWWzuQe5UfkvV9F2pi
 GGpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKvOFxfNrwnaMYIEnh1YjLwdFJ0IdQD9aQWnzBPa1yt4A24W5ptlGj7NPcI7vdoS0UbCbglOir2w0q8DpY6GVBu5L97A==
X-Gm-Message-State: AOJu0Yxc5BBz3hbw1Ni/Au/NWhFFgRo6t9VNHp/lBPLwCBCGFXCtVtgL
 T4k7XNFgJmgLPqJOV31qq0/1ZIFaO8m6YXNWHFYNPbm550bCJJkVnZrlNBxSpPor6V6o9NLaMGG
 KRMWgo9b4EpmNOTTvIkAHyMt6qyNMuwzJ/iGG
X-Google-Smtp-Source: AGHT+IGHDlYaE5rFWyCXD+2bVT2a4UoBDH581ZC6K9KspWkvwq916pJ7f2sJwt0ueswzF+6wvNBjAlu7NC30hLZMYGY=
X-Received: by 2002:a05:6214:2502:b0:6b2:b4d2:984d with SMTP id
 6a1803df08f44-6bb559b814fmr141997826d6.15.1722269975280; Mon, 29 Jul 2024
 09:19:35 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-6-sjg@chromium.org>
References: <20240720104950.2730773-6-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:34 -0700
X-Google-Sender-Auth: kOAyeCIRVsFVHchL283kdlgTB-U
Message-ID: <CAFLszTgCDJODJA+3QyCkC9xRNPkiR3ee9+j85EwMVfyMZKNcug@mail.gmail.com>
Subject: Re: [PATCH 05/20] binman: Move problem-checking code into a function
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This has become quite long, so move it into a separate function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/control.py | 78 ++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 32 deletions(-)

Applied to u-boot-dm, thanks!
