Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21123C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 16:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6E58327A;
	Mon, 21 Jul 2025 18:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HEHhpP/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E43D83290; Mon, 21 Jul 2025 18:30:14 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CCA883214
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 18:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prabhakar.csengg@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso22589895e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753115411; x=1753720211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/8b8+T3sJ6qSfnjVjLwz//KX+Zttw/a0d6psdVKJHE=;
 b=HEHhpP/ZrHGwl0/XETkKp2EYpp5U9OTksW02Ozi6gIOPHRGeTjqFfnRXrmdys/fm80
 9sgp8udE7gR0NFgOmUyxHL1ndD9Oze22POVfhSKX4Eo1ky80ViW8F5EIRz0n1GhkiXlD
 CY1VqaXC98ifaIBF6d9p29+jGw4YX6xOQ6GTv3tr4Dnk1vhXFaLXRPXTLel140ZFqTgQ
 KRGX2gzqFRVv6AhN3jRfB26T/Ex7Q5zUjQsnV6ZhkyfEP0fvfogXWIfswgm9pM4uYIOE
 FHaJZpkcJFtvaEny5usivlX2tXdEcCHUNTS9wsU6TXur/zcclfVfbKwgTR/X9Cse9cWJ
 b2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753115411; x=1753720211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/8b8+T3sJ6qSfnjVjLwz//KX+Zttw/a0d6psdVKJHE=;
 b=VikyJYNwQncyQP+oDrPZyAU+lJ0SkXd57wQAipCxph33ARJAEw9o37KUuco5sSmDvK
 odddH8EXWABy48TGwnI/vAxRQsQfJn46kjNpqen9iPg1vayWo8NKEMnAHPzPYe9GXqA3
 LtVNePyy1FlVxqJwBIXh7FRch2NK0cSsOPc+6u7iLrxoFwZNBDyqInDw4Ix2n4NWh+QG
 38qEwKDj9kQh4iAUD/dJnAPeD/ReMrkYuQYIEFT7WdKDAR7yG4+7gBnmuhOOODxvGNGs
 Zaoxm/CAnvYRNHpg+PBfDVWzzMs7dg2pQVOLgszZXEfYch8OQZMI0CYizb01Q0esAP1i
 QkIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAr+1zj1/lcGP9PGAHmUU7BIp8uSweSAXK5PxLM9TTvMf1xCXRyrGYEVZOQqEzKpZassKnAk0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw19sk4kKbFvn5ZS/7UjQLruFvSi72/WruzywaEcpZVNUUsqB+s
 6G5hicARWFh155qqBb8kdMu6w8PBsk1kbvplRNVszCBUSXl9lBiAP7NJ34xqwImkFA3V0SFIJiL
 0Ik1uT60Mz8x2UjxgYP8RFNLlTHKxKiQ=
X-Gm-Gg: ASbGncvVn4IMuBzg/TIvzlkOzFofHK8JsiwAzBppwIV6SDwGEKj3OYk5eUxZ8ySjGTK
 uafEDof8fC+KOIO5j3Mn7so8tYeQpECkz9mZeJiP84INAb2gCuoY0Re2RUgwBiTLIN/byMcjl2L
 iSq+oNKN8RbMZc2HhiXpAUj3B0c3X/kdahIeOss+I87ILyAU3Zo/wwUut76x12dZ9z5946n6NWO
 U+F60x5CynBoiaqECc=
X-Google-Smtp-Source: AGHT+IF+VVD2e4H/DvUxG5nET6Pwx1NRkif6VrEoPXLzpSLV2Hr3+YeDEFhKJtEb4JlhKY2hdJWFiYhItH2lj5ifpYo=
X-Received: by 2002:a05:6000:2203:b0:3a5:2beb:7493 with SMTP id
 ffacd0b85a97d-3b613e601d5mr14983610f8f.9.1753115411093; Mon, 21 Jul 2025
 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250717105259.96548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <644a3540-9606-4b99-be80-5249cdb5d53a@mailbox.org>
In-Reply-To: <644a3540-9606-4b99-be80-5249cdb5d53a@mailbox.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 21 Jul 2025 17:29:44 +0100
X-Gm-Features: Ac12FXxMBau53Ai4olwz7JffjoRttx-lOkcpzXejKR1oCh6SESM4DyoImUSt-zc
Message-ID: <CA+V-a8ueB2SuovqkdMgURPwNKcDrzji2-eq+DOXJJwE1Lp59xg@mail.gmail.com>
Subject: Re: [PATCH v2] configs: Remove redundant CONFIG_TEXT_BASE assignments
 for Renesas defconfigs
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Adam Ford <aford173@gmail.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Chris Paterson <chris.paterson2@renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Marek,

On Sun, Jul 20, 2025 at 9:50=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 7/17/25 12:52 PM, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The Renesas board defconfigs explicitly set CONFIG_TEXT_BASE=3D0x500000=
00,
> > however U-Boot's POSITION_INDEPENDENT=3Dy build default already places =
text
> > at 0x0. These hardcoded overrides are therefore unnecessary and will be
> > pruned automatically in upcoming resyncs.
> >
> > Remove the CONFIG_TEXT_BASE lines from the following defconfigs:
> >    - hihope_rzg2_defconfig
> >    - r8a77970_eagle_defconfig
> >    - r8a77970_v3msk_defconfig
> >    - r8a77990_ebisu_defconfig
> >    - r8a77995_draak_defconfig
> >    - renesas_rzg2l_smarc_defconfig
> >    - rz2_beacon_defconfig
> >    - silinux_ek874_defconfig
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Instead of setting CONFIG_TEXT_BASE=3D0x0, removed the line entirely
> >    as it is redundant and will be pruned in future resyncs.
> > - Updated commit message to clarify the reason for removal.
> > - Included renesas_rzg2l_smarc_defconfig
> > ---
> >   configs/hihope_rzg2_defconfig         | 1 -
> >   configs/r8a77970_eagle_defconfig      | 1 -
> >   configs/r8a77970_v3msk_defconfig      | 1 -
> >   configs/r8a77990_ebisu_defconfig      | 1 -
> >   configs/r8a77995_draak_defconfig      | 1 -
> >   configs/renesas_rzg2l_smarc_defconfig | 1 -
> >   configs/rzg2_beacon_defconfig         | 1 -
> >   configs/silinux_ek874_defconfig       | 1 -
> >   8 files changed, 8 deletions(-)
> What about r8a779a0_falcon_defconfig , does that need update too ?
Agreed, this needs an update too (the script which I ran only checked
for CONFIG_RCAR_GEN4). I'll send a v3 with `r8a779a0_falcon_defconfig`

Cheers,
Prabhakar
