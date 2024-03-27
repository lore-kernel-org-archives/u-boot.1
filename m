Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497CEC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 11:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A52688085;
	Wed, 27 Mar 2024 12:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDXoM2yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D5308808F; Wed, 27 Mar 2024 12:52:45 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383068801A
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 12:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29d51cdde7eso1822042a91.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711540362; x=1712145162; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3ZRMKCIkCiebFE0YpJ7/sIRALCbX8aigzwlIVQ2l0g=;
 b=MDXoM2yoLuZJzz9JsbVz6vhWBlZCFIRl76vYL7pSP6ScX8LOWX+mS9330Cn9aKnzMk
 EU74ttt2sL+9zlPfAVT5Q27tTtDEWboVcbs+Ksr4mjda8ieCIILyJ/1gNQCgrDnV2aQc
 hE6i6XHNt/Nd8Ad+77os07Kr60pTN2aMefClJTJRwC/pN15vrB1gAYv+vr/WHZJl//p+
 FHb4IVhZ54900jAZw5JL7+p7vFKNRqfAwim7srVCcXae9QKyXp8r2YUrpV3hcyzy8PW2
 gBp46510546zEsKAwN2AGXhtt80r8bZ6/vigQTs8/B2uRmAQ+F8ahcMVRDsxxxbvZBbB
 X1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711540362; x=1712145162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3ZRMKCIkCiebFE0YpJ7/sIRALCbX8aigzwlIVQ2l0g=;
 b=DODJprbbMiFugt6kRGlmgW8PtTMbr5ckUV8Hn7u34tr6ZuZJFqa1A2DWiwPZe4B8x0
 89gcKtWpSTfRaFvD0zW0KS7qlXzOH0h5W4wVzsH2x95LPebKGN2LI3KoPSFD2GUrWYDK
 MZ5JdyFFI/PWgSP/FeuGxLnFHTLce1t0kUl6QFct/0sSCdm7ayp7c+JsDVJ+YT5+c7D4
 xQfymaoalsCva9R+geVVPDM98HmmaD+uVIkyDPxa6BHpBY2hCHcE9g2hbT3uAEjX41et
 XUZIgU8sCQ7fN//eKK0i3z/pXYF9AJ+qNgjWwWjQlDM5fnDY9Ws2Kw57rAAJEfLu5b0i
 89Tw==
X-Gm-Message-State: AOJu0Yw691COKeU3C48dBiTolXlQ6lpbkhcWg4nsZYU1JDkrvpaXNNKU
 wUiDMBuI5I9elRKsz4nyZBuEpwblz+sHoB7Vld+OUFqIYS/O7TT7erIHb84RMcQcBOMHVgPd9dT
 TOn2myOXEgg7MP6Qk0Xm5VyfQRI2Qychr
X-Google-Smtp-Source: AGHT+IGwLgamfQhiYxSdk/db5BSqftfB+uK2DjCZ6xsxtTNTkBbTReytCltArqVkaNaGQmepxci1BzY7mkv9Qq7FUp0=
X-Received: by 2002:a17:90a:b016:b0:2a0:2605:688f with SMTP id
 x22-20020a17090ab01600b002a02605688fmr11439016pjq.2.1711540361677; Wed, 27
 Mar 2024 04:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAH9NwWe1qEo5r0UmdRh9CqFxmJYfHRU1YxoW8b8vTQwDB-227A@mail.gmail.com>
 <CAOMZO5BUibOAqqdtJtjrGwgciJ984ayUu0nPVdLkR_YLOh9bHQ@mail.gmail.com>
 <CAH9NwWdfcOM-q-EBVeZBs7-PRkr87M+pn-dYTzMW5bW7KRTo8g@mail.gmail.com>
 <CAOMZO5C4L2ka3-0xnycwVOfmu2CGqg5b-h1zKERHsah4Mvg9rw@mail.gmail.com>
 <CAH9NwWcQaZ8biFYs6Utu5K10C-N3BVBmWfkL-9QAmBJusBdndw@mail.gmail.com>
In-Reply-To: <CAH9NwWcQaZ8biFYs6Utu5K10C-N3BVBmWfkL-9QAmBJusBdndw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 27 Mar 2024 08:52:30 -0300
Message-ID: <CAOMZO5C85WLQ_K6OeEFFruiKfh0cN5WTFbrsAMf=-WibtNNfSw@mail.gmail.com>
Subject: Re: mx6cuboxi: failes to detect model
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, jonas@kwiboo.se,
 josua@solid-run.com, 
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Christian,

On Wed, Mar 27, 2024 at 3:54=E2=80=AFAM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:

> It does help \o/

Ok, great!

> When you send out a proper patch feel free to add Tested-by: Christian
> Gmeiner <cgmeiner@igalia.com>

I have sent a more complete fix, so I have not included your Tested-by.

Please test the formal version and reply with your Tested-by tag.

> Time to look into the next broken thing on the device: network :)

If you still have issues with Ethernet, please share the details on a
new thread.
