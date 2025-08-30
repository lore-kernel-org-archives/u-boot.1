Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73909CA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 05:10:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0933A83927;
	Sun, 31 Aug 2025 07:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBKqOpAz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C8E836B2; Sat, 30 Aug 2025 07:25:43 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB1C83487
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 07:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sidharthseela@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61cbfa1d820so5357060a12.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 22:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756531541; x=1757136341; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=km5OWROXE6h1DmtjhFZgnOZtkeTEMDAH8BjRGtNIIfs=;
 b=QBKqOpAzLtaF16cqAb3lYH8do87prX7YH7vVeRkeTfZy4tcQFGUK+jdu86QVUlHG7H
 3YfNWWtS0TU1CHnBUCS7ggx4X2ZqlcAGRwT3FazpAkPyknJIctiZ+xE8ciNAkkDa4K7T
 d9mEnHU+8cnWKSwxffAZwoo/ipvCVtLiH94i7qig6Eh9edWMKDa7eoCeWViVl1BMVyhF
 K6n020TVtrcVClsGQopJWJIbbIJcInc7Bwk9nCfHJ9Qy6J+QPBQzBayXsA2206EWqVxe
 Fej8veh65uxalcl5qZNTjaL6HRY83vF47L+3DRTaqsJ/JRvT575dsjsj8n5BPQI0XZQx
 BaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756531541; x=1757136341;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=km5OWROXE6h1DmtjhFZgnOZtkeTEMDAH8BjRGtNIIfs=;
 b=C6e01RtUihyZ1ilPD+JWY2pry5J9U6TAxpPTJiIbZnObfvRgcMc6/8tOLmix/kfQII
 mUxEkL3up67J9FfnoEnBGq5kw0KKc/TE5myTookz67yy9zfdPgpaUN9rlr4CtRe4HTuB
 45rtEy6JZ29YJHQ8EjDS0Gt+EAO/HNLmNPtOzpUQRS+tQ0PS64bzAQfQXcPXwEvbdeIs
 FeTQ1PzRZazAYqXUmGeo3/4ln1jBBsUGHA1m3lyYip2v3J0cVeiliK9LWN6jpczjarIr
 ElGdCrJ7JgzWBsHINt/v4FavcYCv/PBIhSFGGAI0U8vHvIOD2DnVZ69UMqke+8P2kof1
 RzmA==
X-Gm-Message-State: AOJu0Yzc1VqVA06SbJ0EGQD40OZtLQcGaLst5eQoYPlDZd7ZFnnsA8Kx
 kB0+/U3lik3uKi6mOkAp6htXZT3xVZKXMUSdRtrtCSnVxuyB7dcpVo4FooYlVSpf2pUatgztTRD
 ZxWVTVfNBqZzQYyFxvu1T6Q4BjK/YtdE=
X-Gm-Gg: ASbGncucgqAozb3fvbBRry2tjyQgBYPZqVcTNbsYQIZN1Y5+n0TxeOM74NYAPqSA/MU
 /vByaJGVvKXg1KaksTF+2ukypL62EiE+F4ZlN/i9oN2Nk0phusygresDm09z6igxk0jT+yAVAf8
 IXOQrLEE6weGCElAROseQpTzIpV8RAGy+5ejoExYLYPeTQCcejJyQXGih7kIEn/rgTMvGKGWtuQ
 PD5Xq0MsEFuyab3CXl1wcLBL5ZphQ==
X-Google-Smtp-Source: AGHT+IFbB/zyNl0woZ1Z2UAzwsOAb5miFCkQowEnHDosGNnUj5xj0CY4Y6ku/XwQ81LEWiLJKttam8bSoiZfZOferPI=
X-Received: by 2002:a17:906:a99:b0:b03:fa9e:4b68 with SMTP id
 a640c23a62f3a-b03fa9e4faemr20021466b.32.1756531540542; Fri, 29 Aug 2025
 22:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJE-K+AQucBKAUODYnw1xQkOKcXU17VgDVrGtzOEjTRtSTsmaw@mail.gmail.com>
 <20250829191830.GZ124814@bill-the-cat>
In-Reply-To: <20250829191830.GZ124814@bill-the-cat>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Sat, 30 Aug 2025 11:10:29 +0545
X-Gm-Features: Ac12FXxlA3qcEpqPTrO5wfuMTyEqhrYk9vdCeOsNE0vjG1g60QTxW3jNnHqCuus
Message-ID: <CAJE-K+CuH8w4HUN00hnbMPwMeuYEfeqERTh_5NM4=8URaakDbw@mail.gmail.com>
Subject: Re: Falcon on bb-black: SPL jumps to 'u-boot.img', although 'args'
 file exists.
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 31 Aug 2025 07:09:36 +0200
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

On Sat, Aug 30, 2025 at 1:03=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
> It's been quite a while since anyone took this specific path, yes.
> You'll likely need to instrument things with some printf statements to
> see what's going on, and then patches to code or documentation once
> you've got this working would be much appreciated.

Thankyou for replying, Tom. I hope to keep you updated, and would highly
appreciate feedback along the way.

--=20
Thanks,
Sidharth Seela
