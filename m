Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCAFCCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5555A838AE;
	Thu, 30 Oct 2025 17:41:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SuxqrepZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6169E838BB; Thu, 30 Oct 2025 17:41:43 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ABC68334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-378f010bf18so23614991fa.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761842501; x=1762447301; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9Gm1FfBHT5SUXAQks4xymyXBJvgdv/IrEb7pjwU9lQ=;
 b=SuxqrepZuk6pxwRUT4BRxcgqux/g2H/XEPOFlTaJZ95sQZxMgzz+qqUD40TjQW1c9X
 zIuCk5zp7O0ZAXOZVBsiinGdqNVab9vqfDHt2/AfPwtVnfWge5rQf18o/1PtkCODlDcy
 0oBpku/s9YqHw71odBDyC9IrYDba8LoN3XUKX8f4452kMQ4w6bh9g03hpYoGWZi2LGds
 ZRK8Os309C+iYRQ+Yh4B6ZGD8UROg9jvv/nZpgU8NmGl4iz3pfpwuvCWlodQH8aQ0kjT
 oiGeEKHUhoafhhj/oB4ASP8c+3gq7ex8mwrxr7RC2N0KTQEQrO+2pN6IWX/+U7XgOEQ9
 YD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842501; x=1762447301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9Gm1FfBHT5SUXAQks4xymyXBJvgdv/IrEb7pjwU9lQ=;
 b=FBXi2QZQTjdzzlSLkkru3Swp993lCyeP8jlwaTxM263iz8T3b49l1MK8/+zI7NSKMw
 nnl1MXWyWC73ZEuF/DJ8FHFCE1kNZQ4SgVF6gMlgNTgDnQEQ1Pr5nLVHEnhRdTcVtohq
 11RNRA01WHBHmtoAJuwFQZ1G8872qRoQepy7lNZZhYL5pxlo3inBPTA2UFzD7fyq96e2
 vh7o0i48435AtA5ulFT6/QANeX5nmkRbLlzXhsLZxTiictY8oZox0yXfW09QzEoQiD0+
 PzQDmNsVqOqKpzdg/VTIQ7w76SdT3ZdmaG7cYyxxIAISBcXlC3HtDguS5ZUecKX55TMV
 VuFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk8tCz7uqURydl32W41SqWUOhoAyfl7Yp0uE6wWHrOoQ/7/cOMCH0XVdRz2iUu9zF/D7j59ro=@lists.denx.de
X-Gm-Message-State: AOJu0Ywa1zGP6+pOnPG3h0EsWrrNTJMM8UN3ALBrZGyZqFV64q6GrJxG
 yckZsoV38+7fSVjidOn9+QbQ9H98ptitotjpbsbhytE/yFyOjgkHv7ozgPh7Fthab/Xs25mhLRM
 YqfXizkDG68Go6QNSlPsBF/EOMnscOAEK4WOq
X-Gm-Gg: ASbGncuT1PIPW7Kb8F1b5646F3xNwyzj/Eu8tqdLDBgckXiAgwc8kF8REtRfC0wSslV
 bGX9YS5D3p0LfHhnOjVZzXGG70feZjy2QrS3Es44vd2LajoIgalRW2aUdkF5z1dSuMnuXikHeU3
 Bp6Nt+OqxPPPl79kfE9yKIOsUTakdZ6nWwb6x4LKwEiPY3fBD1ViRXonh0bvJn1cx/ZPgDkLaoB
 xgJy0G46wi8gXc0AwlgfWDgFCLUZrp/JHgJveT31WCsFiu/USFMpcHfTSmtSHbwJ1vtHxnBFg==
X-Google-Smtp-Source: AGHT+IERWPWW2YkEyK0MVekqvI1fpN9NeuplZVU6IBQKJ4dbvdG07G5Pfl0RJ8Qtms1omgPBB2oYO0A0VlTOY+xXsOs=
X-Received: by 2002:a2e:bcc4:0:b0:37a:d20:3215 with SMTP id
 38308e7fff4ca-37a18d96619mr1710991fa.6.1761842500451; Thu, 30 Oct 2025
 09:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Any4akaDeRNwxqhcdy_gjxQVHC3aao6sDDxqALxNsp9Q@mail.gmail.com>
 <CAOMZO5ANeCogTO+dyq9GSu7XGeW+H3OZ2CXCEsguhcrQLJwNrg@mail.gmail.com>
 <CAOf5uw=rMZZs7m2mUMV-DCw=C1d_R7uWAqzpWfYOM4TXY9Sm6A@mail.gmail.com>
In-Reply-To: <CAOf5uw=rMZZs7m2mUMV-DCw=C1d_R7uWAqzpWfYOM4TXY9Sm6A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 13:41:27 -0300
X-Gm-Features: AWmQ_bkGpCStEeGNf708_29cnp68GGWbQkExHlmx9pKqH4aC_Ek8c4IyejfqJ9Y
Message-ID: <CAOMZO5BxaAcr5BF+D1KB9hjddv4AmG3f5pzRM5edDUHBSCz1Pw@mail.gmail.com>
Subject: Re: vexpress_fvp test.py CI errors
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>
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

On Thu, Oct 30, 2025 at 1:39=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> ! _pytest.outcomes.Exit: Lab failure: Marking connection bad - no
> other tests will run !
>
> Did you try to rerun from that stage?

Yes, I tried to rerun it several times. It always fails.
