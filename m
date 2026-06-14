Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC963CD8CA8
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 22:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF01184704;
	Mon, 15 Jun 2026 00:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fD8AVQSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADC08484C; Mon, 15 Jun 2026 00:08:45 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF47846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso23350515e9.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781474923; x=1782079723; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GCp7ba/ZXTGpxuinkLR8QNqksxXKRrUOKmDolR+9aYY=;
 b=fD8AVQSFnhu5gYtihSaCw89iY8/XJ8d5F4RjczirwZuS6ojXLzhkzFlE7KbqpoN6si
 QYjDx2OjmnskF9eKjugC0fH4nUbpfxW5ptg1slIWvfCnAJX9bMbTa+XjTG1/+zpEdbi7
 FnLrkUltzowWCPcWllxtRLQPOlRzB7iYLppoUE06JQ9GDd6Ig4KvT7h/2xNpp8i104DA
 /hB6sy3qFJLE6FiYiIk06X7/V9TAtM+KOee2CARkHcVIYFV59k+z4yHwhljiZZ3UvIxo
 cmAZSoe67t9c0XLN1MzDrO2CXmT2X94qhgb7SBvK2MxsiK1G60vFqgNKsG785ukOb+MM
 wICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781474923; x=1782079723;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GCp7ba/ZXTGpxuinkLR8QNqksxXKRrUOKmDolR+9aYY=;
 b=ELCeK+l+SA4gyuV7rSULdUReNbqLX7vzqwW8v/i4vN52mjKJ7N3vyuCuxwmm1oSSpE
 JIBAH1l/T6HC5u8l4r8sa/sRGeeUVph9g0tkvRWUDGzK+7U5WWGIL7afOntPF0zGe9yV
 UgFoDdVYo1NRPLijB2lEz0y3c7ywKu5ckCTchxzXe1OqlebUw168i6/tmYUc/7IdSZR8
 FPhN5Hr1qoAjYTyNTqU2BhV97UHHUfwg7G3viTJgWRprftfZCYBYNiWu71TL9rNnGclw
 /HCEIeAYDeKybMSdszJGzK7/i6FQ2IylLwxfKe+z/Hunk9cJanxiHkqdSr1c5KBFh3TY
 Rb0Q==
X-Gm-Message-State: AOJu0YwovkrftY2jJCSCIebQjfRco974Up7ibuT6XCPVMik19XEiBdur
 lRkUlVcgmxmxt5cdZexWcU/LQvCyHjXTbU0yl2qQJL9LOgh9FpbsbUGG
X-Gm-Gg: Acq92OGsn/6k6ErsQWCD8Qdkb6ocxpgSv9bgsA+UEHFJbK7G7TEMjiql24VXchV9+qL
 PsCsuWEvU0u5OcbT9JgayNZkJzet+ln2jSwiQslxL4EixGeMds7sJRpH/NhxrJto4IDj44mDptc
 yEMxrVDtXKX2ipYp79jKVZFms9dKL4vFwwl0aFhqUungs2zpz4IPobXh+kSnM4Q8NEankJ0WrWx
 YbzjOM64wOQH17MUG3Uq7+Qo1ZE2zmj8xTpBkHR+Gmipn/fqbSaiShtDBhKTg39YexCx1PY6d29
 4JYlovl5DnLOT/PD5XZfe+OgQIm6oUsjqrvtaKYxS6gUxz1slrXcoVGW+fF5OE4rygCZW5lUr1s
 xtgFyohps9Dp9bZ8I4URiyEG9TVYfiu3DGmXQGTRoOoKAV9broitQBRlwaWotuKm5HIet2cOB4/
 pdgUT7anHW26DrJWRGSVc967ANwPQ0KwI/q21H4SgvepBuhHy7YIAyat85CKCp9GztLUEfWaVpI
 hpFX7c=
X-Received: by 2002:a05:600c:4745:b0:490:bd66:e523 with SMTP id
 5b1f17b1804b1-492200c04a9mr102074895e9.20.1781474922891; 
 Sun, 14 Jun 2026 15:08:42 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net
 ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm4466363f8f.23.2026.06.14.15.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 15:08:42 -0700 (PDT)
Message-ID: <95c289a3e64993c54b1e21737a74e794f90b9c13.camel@gmail.com>
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, =?ISO-8859-1?Q?Andr=E9?= Przywara
 <andre.przywara@arm.com>, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Mon, 15 Jun 2026 00:08:54 +0200
In-Reply-To: <ai8X0ovb5V1zTJR9@collins>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
 <ai6yjsgw-3hnNgNM@collins>
 <b0ff98144d34468c133cd62935afc546135b47ec.camel@gmail.com>
 <ai8X0ovb5V1zTJR9@collins>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
MIME-Version: 1.0
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

Hi Paul,

On Sun, 2026-06-14 at 23:06 +0200, Paul Kocialkowski wrote:
> > > But another thing we do overwrite current is the cpu idle states, whi=
ch
> > > are added by fdt_add_cpu_idle_states in tf-a. These are only set when=
 the
> > > SCP firmware is available (which is checked at run-time) and they are
> > > never propagated to the final device-tree. Including the definitions
> > > statically would result in cpu idle calls done even without the SCP
> > > firmware, which would probably fail (although maybe some states can
> > > still be supported).
> >=20
> > Do you refer to some unmerged code? Didn't find it in the current TF-A
> > sources...
>=20
> fdt_add_cpu_idle_states is in common/fdt_fixup.c and it is called by the
> common allwinner code in plat/allwinner/common/sunxi_prepare_dtb.c based
> on the sunxi_psci_is_scpi check (which currently always returns false
> for A133).

sorry, I misunderstood you initially, I though there are some data structur=
es
of the SCP firmware which are being overwritten by Linux, but it turns out,
you refer to idle-states node and compatible =3D "arm,idle-state" subnodes.=
..
But contrary to /reserved-memory nodes for TF-A, these are fixed for a SoC
model, even if you'd like to load SCP firmware at a different address, righ=
t?

It looks to me that all other machines/SoCs do define this stuff statically
in the Linux DT.

I have a feeling, that idle-states node is more like a "contract" or an API
between FW and Linux and is supposed to change less frequently, while loadi=
ng
TF-A to a completely different address would be transparent to Linux, as lo=
ng
as we properly copy /reserved-memory nodes.

--=20
Alexander Sverdlin.
