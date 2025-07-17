Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DB4C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF9E8344E;
	Thu, 17 Jul 2025 18:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xut72jwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12DF83487; Thu, 17 Jul 2025 18:32:38 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F18A83477
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-555163cd09aso984622e87.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769956; x=1753374756; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vjn2pXL66dLvdyfPaW5XvisTYX+zgtPRUzqfBQ+7RNY=;
 b=Xut72jwnv7ByfkULDXgH/NF6d5qpBo1KS5SSZHo9r9leQVNPngYiYBjnoJB7nzolGQ
 9+d9pEi3zMdJ4QiBL48qSUGbzt/Kxwl/3Z1GOolKg2Vmf/JVXEZ6MMnsw9+Id7PPaME1
 +fP3dZc8rXZNZYY6I0V9mZCUsa07W6hDNa75yonCo9jGJOXMP0YPzeacY2c5MO2ESKAm
 GGymekank0JkGxvp2qLDCEKyuarRyTpiPo5XstHFNsLaX/DeVR7NEGQaKx38grD552Es
 RhkcS2eUelCWECGXOWt/nA7lkChcKjxkA4WuXlQ1843umoItewEuqPX6Gnewr47R/Zuj
 EGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769956; x=1753374756;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vjn2pXL66dLvdyfPaW5XvisTYX+zgtPRUzqfBQ+7RNY=;
 b=qFJYlatpUoS2m4S4NoUyyPSoAGyAGBAfV0Ptxx+VQy/49z/GwWfo+bVNwhIRdQmYhM
 uzhCwAAWxqNSos92okjs6yJg1MLJjcSVG1ApuQXMZAkzTRe5SSPlWK2r24qPMkIX9rFS
 7L3d2YZopGC4pAa8dpbwKb21TDYabx+K6V60+5NAmA2BrS+BIj9cnTtyiuZjeoLFANAI
 r3WjXHWGBw09CbPEyytZwBqft2DQO/VsuPADYhAcx1qU8Za0EIf/Uvsbvd3hQtCDRBPc
 CRpLf7L8+pcvWA5D6oDWZxLPhVkm3T2pnTQJZciwhP44OYK1uVD6og2hTn4I37xAZH/p
 3iUQ==
X-Gm-Message-State: AOJu0YzON3IegmTS7OdTK1n5YWQmam43ZH1mOXLeOt6U8KCQglMcu7ab
 Mls+RON4Aj50jtw+TBtQkpZAM4Q4ZOWFA8aLC0wOftsf2emblavbKgNmSbhR+N/Ksyu86HCoQ3u
 pW4e89cQTDxhzWrf2D8/ZTo/XtrL64pI=
X-Gm-Gg: ASbGnctEvzAl4x9tshr+aWTSbJcxlxtM0i5ZSdfFwYqLwbqvlSZ5/1vWulACn+dPyUV
 i+mMsl0K7z8dhzBdmf7UEQ9xbkOjZy6YoDyViuKe9JYfc4olPiT3EK+mpDcHgfb5HZEclGDsGLA
 LVzliNcN+3zcpcrDAoBsGYzHJor1pAK9RwjGH3PlriyErdoLnhxFK9yKHdPQCtkj4B2Dn+BZ7FE
 DUoFpvpxZwtDLN75zF2y9Xl8zmlFcLrOBfLrN+JZuaX0iI=
X-Google-Smtp-Source: AGHT+IGKoCSZyMolViwiz3kZQdUwnNJRIQX34e/kJBvq7jufc/dWOAH1iq5f9FRa98mVLdHJSWsNaz9WI8jyrjeMmbM=
X-Received: by 2002:a05:6512:3b25:b0:553:adab:88d8 with SMTP id
 2adb3069b0e04-55a296fd1e0mr1112482e87.34.1752769956047; Thu, 17 Jul 2025
 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250711152025.2225590-1-trini@konsulko.com>
In-Reply-To: <20250711152025.2225590-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:32:24 -0300
X-Gm-Features: Ac12FXxgXNqTohtRqW4fgMepQfhG5i-vsAfY4__eFljq_OgPF_GYD6HJcwvo5D0
Message-ID: <CAOMZO5BAranfCbUkSZXAfaScLzZ+c0BMK7G16VUpd30hz-exnw@mail.gmail.com>
Subject: Re: [PATCH] nxp: Move FSL_SEC_MON related options to arch/Kconfig.nxp
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, Jul 11, 2025 at 12:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> The options related to FSL_SEC_MON are part of the chain of trust
> related options and should be under that menu, so move it there.
> Furthermore we don't need to prompt for the driver itself but do need to
> allow for configuration of the monitor endianess.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied, thanks.
