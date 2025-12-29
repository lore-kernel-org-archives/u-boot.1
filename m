Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A51FE8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 10:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C888F83D07;
	Mon, 29 Dec 2025 11:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HeL3+JsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B64283D8A; Mon, 29 Dec 2025 11:26:16 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C7483B82
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-37b96cbd875so74196391fa.3
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 02:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767003973; x=1767608773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7KEWu0y5K+AU/Okhb8Z2BaPpBgncvjG5bAefs6XHBx4=;
 b=HeL3+JsB2L40349Mq+esErpFWO5AD28I2TT3Y4Ikuadbt4/a12VW7i4mMUSK35VZTh
 +Vkw8xgFE+l3ifLENrelcGssNqXMTjA+VF+T/8nlBcTIM4D+MqwYlVFv0IdrHvb+yjV7
 wfbiY+tSD1KAKUBo/Dzhy4xvzuWHqYmCpEnkaxlrUjqnG9t/PAQsmBfPUYoqutUY5Tfh
 +nRmH/I0kdwZz7dzmNeiNA9wE6pXBHEwvv95ENOzf/vleMlcQvtQzIDa18Tc+x9M7j/e
 vufQb13uwnExMm2IuGyMcp1zs34BNBJTsPtHUHC4dd62C0NskFiYvjQpLesdbBTJxBMh
 tq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767003973; x=1767608773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KEWu0y5K+AU/Okhb8Z2BaPpBgncvjG5bAefs6XHBx4=;
 b=G/ub7EYUChBEwpxBo4YF3zk8QfpXHvv4ns1+yphXTKre58fF4qaDJzbeERGHp4x0Do
 7RIOsQP7IZaBYZhj4Cw3P9szYeu/fOlsetw0RhasM6p9VUgedt+9Zc6lvaVN/dhT2OR8
 bd1Xqc9ynUbGuZLX61qZpHaubqaOKGbPC2bANM9hIQscMyj5xnfboMcCymHcWfMCRh/5
 SGdHhPeYn7xALBm6jglrt6KH5DJRrh2KoR6stIXXsOP6glLgQrFxE759PW7G2h63TdrM
 o2lpCA7cM9S902U1Pu4bVuub5cmBrfr5ot6P11F604cIdHRgLeRq4JQWrJJgy3atLrlU
 JD9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWelCp9DC/iG572/qrquWxW59rhRvubTlx5pT5hdXmbCGJOxpZpjDCZvbCWWdmEtwzAm0Xp9YQ=@lists.denx.de
X-Gm-Message-State: AOJu0YywHjbnWjB97BSdheQu85Sup9chwUpiJi1RADB9iQBvV55iJzFq
 FYgTX7YiBd1xDbDnO6BoQ0PEr+WtY62d3xTy1aQjMpbGoXyPKJW+jbPxrWtiuTvvlJfqaJqMBS8
 ruPyGwezV4OoGNGg4ya61s+75cjCo1qk=
X-Gm-Gg: AY/fxX5bG0qHjXzg5vCFaziMXWJZe2b95s6oaOBZjoofpSbcnhHpUqhRT9NfQFSUaf7
 TWfPc3yP9tkVFIQQ5sfzeoi2jpMcaNUwIsKICM40jEg2zt+peXfFvtT8tZU6SAFjNWZTthblfEY
 mC3P7fKY9uhCq6O454Byqk3xR6+c28kzPCIFIVKQvoAZz8r8Jbco1jfL7N73ZMmhFWsx2LZUGdz
 zVAcQVql1pZwKDC+zsPd3Ew0fL/ir64FUH3VWWddCtnIVRrcIMizn9pd7vCtrJsWW30kKmhjDsd
 skgSfQBhLec82duJAHsdJmPoMbc=
X-Google-Smtp-Source: AGHT+IHKg9cTEcceFQIYKnP4YKxUEU3Bk6usLEENdXhfhsRrjI2euy0TJcIaBxHUlIW4t7V77wYNIqMPh1rBe+fT5xI=
X-Received: by 2002:a2e:b895:0:b0:372:8cc8:fc3d with SMTP id
 38308e7fff4ca-38121552cc3mr96212641fa.1.1767003972903; Mon, 29 Dec 2025
 02:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
 <dc6ddbfe-df79-4dcf-90e3-76068e5a5e40@kwiboo.se>
In-Reply-To: <dc6ddbfe-df79-4dcf-90e3-76068e5a5e40@kwiboo.se>
From: Aaron Griffith <aargri@gmail.com>
Date: Mon, 29 Dec 2025 05:26:01 -0500
X-Gm-Features: AQt7F2rFv-Vx_upKZdnaEy5pIECDFfI9-YH6gUt3jitWHTy4c_XkR4GL-Cz_peY
Message-ID: <CAPcvo0S-ft94KFN6f2ZPr5KEMoEmATcFkTQk8O6PjFkJn3Ak0g@mail.gmail.com>
Subject: Re: [PATCH 0/5] rockchip: sdram: allow reading memory info from TPL
 on non-ARM64
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello Jonas!

On Mon, Dec 29, 2025 at 4:49=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
> [..]
>
> Is there anything useful encoded in the RK ATAGS that we need on any
> other SoC ? (with the goal of using mainline TF-A and/or OP-TEE)

Not that I know of. I must admit, I'm new to this codebase and so I'm
mostly looking at what code already exists and what the Rockchip fork
does to try and synthesize a solution. The Rockchip fork reads this
info, and it was a simple change, so that felt like the right path.

> Nice!, please also see my rk3506 branch [2] for a mainline u-boot branch
> that is mostly just waiting on upstream Linux support before being sent
> out. Should have good support for most Luckfox Lyra variants and the
> ArmSoM Forge1.

Oh, fantastic! I started working on this as a way to learn my way
around U-boot, but I've been learning that adding RK3506 support might
have been ambitious. What I have boots just fine and I learned a lot,
but... more experience here is definitely for the best.

(Your link [2] to your rk3506 branch is a 403 for me. Is that temporary,
or..?)

I'm happy to either continue with these patches if they seem useful
for any other reason, or to drop them if not. RK3506 is the only
reason I had for them myself.

Thanks,
 -Aaron
