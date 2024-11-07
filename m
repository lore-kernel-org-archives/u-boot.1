Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4916D43361
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 14:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5575689274;
	Thu,  7 Nov 2024 15:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGJYILlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC1F89270; Thu,  7 Nov 2024 15:09:55 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A228A89277
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 15:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6ea11b32ab4so7556917b3.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 06:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730988592; x=1731593392; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjkUQQdiBWtCkBoe0sRlWhBeUR/OOBEu8N5+nFn1NB0=;
 b=RGJYILlbVZ7mnhqTwf058iz4qIVK3YaptHuuEFiQwgfK/9b6YHRsvNFgU0xwdkxEJP
 3KM785GmwV3LyruC3FQdVmYFmvgdD1kF8nc4m+JeT/oiw/as7ij31J1EIlEAwcUZmHk4
 QfN/8Ot5rVErniFE/nFow99RVUP+rIBt77hHbq3cDwjlrKGzCrxuYATjuV6xgAfY8+k8
 2j7SNmAgINzNLAtAmDsPzHU4v09PUjQGXWAYxTp8Lr/sNTGy5am3zSqN7Oa04GPNQSDk
 PavY0HDOcBoRjZCKN/fixtNpra9NaY1lS8/MgIRjSGuD7dQnqz6fa+4qbQ9IxgAruNs1
 tNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730988592; x=1731593392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjkUQQdiBWtCkBoe0sRlWhBeUR/OOBEu8N5+nFn1NB0=;
 b=gFtRP9CRCnukZHMEIEIVMqSL451SoGtwIXB0ha2yGLrdSFhkuuEd3gCd1XwYf0eRFj
 EOFaJKg4W38Kea1leZzjSSzGdw+VRZVlnvW8hVZJQ7lvmCTW7DYt33kQJDNgHTHT5SMP
 cezvFNS9qlC6mf2b+gMI3fTyUx/82hoFg0Z5ohvQ3BDoAtl3Y2DmA2s0Kxj41yr7hJXb
 S0qPOONA8KGxBEDXaWZR76VlaPkqZj1hmw+PcVc8RiKm9GyZY9ytSawP8E4APh9jxea6
 CZrbjFdFME2UVqK8rLIPVfQFWLQYll7YuFqibEe7lhWhkWVavXBjXs6UQyts+Ptd9oNu
 1AFg==
X-Gm-Message-State: AOJu0YxRmf3tAjXfVqrCYmBwRFEqvbg8EGsC2/eGjCmK4zIWTmmsRd1x
 nne6rGVZnd4DDobHcuBiJz4fF0I45KXrZuNfzJCdPjQixc3tdztYbLFezy65mWOi4H5u1shtJHa
 q3T3p7WT7CGn+Ggw9P29JffmZnv0Lwti3R754zg==
X-Google-Smtp-Source: AGHT+IFkF7s9J8IuAV71Fv/ij7FZjkJXTkBXop+vgZOG87YMylrY1hE3/mptgqlcBY2oNNzllMisEmKfE4nPARzElAQ=
X-Received: by 2002:a05:690c:7409:b0:652:e900:550a with SMTP id
 00721157ae682-6eadb1051aemr930017b3.19.1730988592520; Thu, 07 Nov 2024
 06:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20241106210348.218507-1-dregan@broadcom.com>
 <20241106210348.218507-2-dregan@broadcom.com>
In-Reply-To: <20241106210348.218507-2-dregan@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Nov 2024 15:09:40 +0100
Message-ID: <CACRpkdZnfR_nXSTNr3ELsbTQDKW_889Lkg8ZEex7mNQx0VJnyQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] mtd: nand: brcmnand: remove device specific nand
 driver files
To: david regan <dregan@broadcom.com>
Cc: u-boot <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, David Regan <dregan@mail.com>,
 Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Wed, Nov 6, 2024 at 10:03=E2=80=AFPM david regan <dregan@broadcom.com> w=
rote:

> These device specific nand driver files can be removed because
> they are now replaced by a common driver bcmbca_nand.c
>
> Signed-off-by: david regan <dregan@broadcom.com>

I believe you!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
