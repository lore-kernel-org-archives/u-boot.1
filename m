Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC918CFA756
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07302889C3;
	Sat,  5 Oct 2024 18:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dj67Oy6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2BB88AFF; Sat,  5 Oct 2024 18:46:03 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98ED2889BD
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5398939d29eso3873200e87.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146761; x=1728751561; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orqiHSa9IjJjku6MXK9umkQJN0Jh1e59hSRTaxZHez0=;
 b=dj67Oy6z5COaxfdSGZe22a4p40rdtvtOyZi/mY6TCze8Wmek/62U6UlAiTqWkFguTL
 UpbBaBDAoRhiVgjQUgRX95yL7e0wwaKbN0DwAXcGi9l1k3tufELTtUj1dHUeo2twAQMM
 loNHLvIc5ga+StCV0Lv5w2p7V8ofHEBDAySd5ycgM8qhOWlc+1TupcmIbNmJkJZCqiK4
 TAeaWmpca3skLchZ3NlRWK4lvjLejRQCeISOWQGKLAVdq1D/3gtm1NhrAE2r0aHoJk2i
 1EzYX+cmVtoyEzXMSdbxIWJbxBI3TG27HlA5xGTrmay/GKsphPlRXOFLtEzPvbPLPQYz
 lcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146761; x=1728751561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orqiHSa9IjJjku6MXK9umkQJN0Jh1e59hSRTaxZHez0=;
 b=WQPfTOhQDd7Q/hOMRg5A3ThKB3RGJNakIUJkpCFDotq0oR23FRxWshkLfZTEfOjhka
 c4Nf7adkUnS0+iCP8xvTdVv19/N+uAAnukrIzT7gIUEfjmI6WVA51wXQPqBVDp+JT7y+
 Ml3Xy2DTjLhU0+NyZDQHgSYSPin143C7NaIblD6PgUbTzorHhJnRw8bScnoOf8PbJM8P
 toXWhrFbTfT/IvaGs0OryTxncTzxhrMFU2qjJkcQODOxAsOOkell+feekzBn0eRLULDC
 8oWlZ5fVUpF7rzCyO1fYUDZLvGlDFZwdbzW2b1jgGQTX/RKjdQajWT8D/xLZgdXcNkIa
 TUwA==
X-Gm-Message-State: AOJu0YxxKeTAAtHx4bD7oXo6R6kNWy7aD8SSMVEuIlMtDCJGzGel7r8w
 JPf/4CIt8G7IK4ouUPBK5MqeozcHaBlOWkb3LDda+yHcJ2GFBxV/K15ligL+ssrkyduTxhmkZmD
 YKUTzMKaaSDELo5AMIGBibW2XLMQ=
X-Google-Smtp-Source: AGHT+IHYySDXv2FQS0G25mE49oNFrFrqbIZtZJN7/vyS9NxE+yobuZHV8UFLTY++hSqLh198Rz063cvlGH2Mhj4uXQE=
X-Received: by 2002:a05:6512:3e17:b0:52f:c27b:d572 with SMTP id
 2adb3069b0e04-539ab9c7e88mr3503954e87.59.1728146760537; Sat, 05 Oct 2024
 09:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240925160738.85211-1-marex@denx.de>
In-Reply-To: <20240925160738.85211-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:45:48 -0300
Message-ID: <CAOMZO5DA+1S51RMKsVjfXo0Ef78pamBoAx1MKZfoH7z1ZVm5bw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mp: Add DH i.MX8MP DHCOM SoM on DRC02
 carrier board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Wed, Sep 25, 2024 at 1:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add support for DH electronics i.MX8MP DHCOM SoM on DRC02 carrier board.
> This system is populated with two ethernet ports, two CANs, RS485 and RS2=
32,
> USB, capacitive buttons and an OLED display.
>
> Matching Linux kernel patch has been posted:
> https://lore.kernel.org/imx/20240925160343.84388-2-marex@denx.de/
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.
