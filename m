Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6878CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C368687824;
	Wed, 13 Dec 2023 21:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TEOwI7CY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408A58783D; Wed, 13 Dec 2023 21:40:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 388348781A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso76660095e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702500039; x=1703104839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xB95cjcdvIB06Yg29C3hAE8VaRY/V7IPKGYsxWUKUN8=;
 b=TEOwI7CYebIqQG2U0jby8ygH33XmaaO3DSdHH9H45Mg4N7+qW79QLPnVqUohrhvZCH
 JYdO22W46TpIL4OEcUdxmX3kyHbqD4ZwwOLXK4C5fBK6gyAI/zIbGXA6MJt/RElj05Wf
 3x5w0iAnJ9sNtK51vfyZ7Zh5XQKt18lsQlRIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500039; x=1703104839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xB95cjcdvIB06Yg29C3hAE8VaRY/V7IPKGYsxWUKUN8=;
 b=T+EBjT/FTijoxyK4pLxxUxQjm//dsXEECs7NfCVkT9T6CLH9Mf0o3ji7WqbE+JwteP
 r+W6D7Es7RwFtE4sf3+DpmKAWql7giQ0xckp0UU4G7QpKzXqLI4T8HhMSgHkHeLrTvbD
 wRFfnqH8/17bpjOEAsOS8kskOeQ63yLngUuFjNG1SNClDqnEyHQ+Zngl3E75dWLz1WbP
 gGywhBLMzB8KIzfJ4m51UWNMoeso+SSaIsM1NQ6fnFAVpC3+UVmT1rL/B8bR8zOOvYJZ
 KXwxusWF2LOdJ6MR+gmOlP3Zw5qehdXJBNQIuDncXu/16gS1yqsHS+k8Ewh+Zfmqr2am
 6jpQ==
X-Gm-Message-State: AOJu0YxoIYD40/kT02cihAXq3imUbjJ5z0+qcSX9SlaSUuxgk0R9Em8L
 FJg6QW5wPg/1hi3m6bqivLw/+MCbeoMb9Oih9JRIOA==
X-Google-Smtp-Source: AGHT+IFf01tsqT39jhrONWT5jVLyMQfvPaJG9aTR5bwqSSTKoYXSU5/W7ItUD8YJ4BGv20gK6Qn99poruF1tVP7SwCI=
X-Received: by 2002:a05:600c:4fd6:b0:401:bdd7:49ae with SMTP id
 o22-20020a05600c4fd600b00401bdd749aemr3856446wmq.18.1702500039429; Wed, 13
 Dec 2023 12:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20231123131003.238105-1-dario.binacchi@amarulasolutions.com>
 <CAOf5uwmqVaUoD0HayhVkyPL+qNe+n2ZoV8PyjJzHmskBm2TKYQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmqVaUoD0HayhVkyPL+qNe+n2ZoV8PyjJzHmskBm2TKYQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 13:40:28 -0700
Message-ID: <CAPnjgZ3EhqRX3RkAuW7nWK-UbWRK-3DLhZ2GYtR=V0shVxenHA@mail.gmail.com>
Subject: Re: [PATCH] binman: doc: fix typo
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
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

On Thu, 23 Nov 2023 at 06:13, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Thu, Nov 23, 2023 at 2:10=E2=80=AFPM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > s/use set/set/
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  tools/binman/binman.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >

Applied to u-boot-dm/next, thanks!
