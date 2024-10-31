Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6667AD767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1B188B0C;
	Thu, 31 Oct 2024 18:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cU8R7zFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD2E588DF1; Thu, 31 Oct 2024 18:52:47 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B3E88A1C
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 18:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9aa8895facso183048366b.2
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397165; x=1731001965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1MicHTaHOg3rNOoHGe16M9V9TBJyKkakJfUJUqEjiZI=;
 b=cU8R7zFjq0zyEawN4V4G57HhOu6ZUPozkGHzeG9nXnsTKi2rpss75dVkAtR4hURO2n
 W9CizcYX4dRlVqnuxo5dvHuFmJ7X7lnHpLYIbWeZAXPusQwFpj92TZc/852sC5uTWCFN
 m8vRRKlC5Kz4iahb01VSaPoioUEEKcQtsnkAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397165; x=1731001965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MicHTaHOg3rNOoHGe16M9V9TBJyKkakJfUJUqEjiZI=;
 b=ffbucALuUTMxkZ6SO0+no38ZfvAr9dYdILzNZLx/Dk41cwpJsJWDPsqmen0U5jT4k8
 Lr5BggNCWi9HY/McYrkgLNCFJ/NxJAhtVZN8m6B94jD8h+VvavR60Td0avu/HHFg20zZ
 L9hBRHLdwBqcsN9u2CPmCDjmict5A648+EYeEuNFA638YSnUH2kYzXgpCpO8DtrNsiCx
 N1DJyf2jHUZdOyfrSxDiMwqSbTm4F1J0uwqIXdq4Esn60GOMFVaoBf7fESVGDHGpZ65/
 lm9Vtqhnozd8MCuC6D/gHlUS7VrjVHsWOGnAXtNjnOzX2SGQj9EEDe4Tk9f0slMypkR4
 zCwQ==
X-Gm-Message-State: AOJu0YxtW9g/Jgy4knntGSacByZahq4P1RXACC2tfaJuCZZFa/N7rmj1
 yKj/saKZJ2ZsXDjSc4EAgBE/qItdZma0YZQSThrShTIl8a4CHxyiycNzFzbo90ciwi+kfslLPbn
 C92sCB+3ceVkv8NctsJ37d7m8dPwGb3P4g1kh
X-Google-Smtp-Source: AGHT+IGBXi/uB/pxTUaq7WbM8ldDxIeAxPZGthBDQVfbo+p55ibSLthVH6woOJg1nvBwSRagoKncxcIhvin4OwOF45Q=
X-Received: by 2002:a17:906:dc95:b0:a99:fc6b:44f3 with SMTP id
 a640c23a62f3a-a9de61ce14amr1881757066b.44.1730397165366; Thu, 31 Oct 2024
 10:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-4-sjg@chromium.org>
 <20241029201400.GJ4959@bill-the-cat>
In-Reply-To: <20241029201400.GJ4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 18:52:33 +0100
Message-ID: <CAFLszTigOBUyyi9pxpnLpXwhiw5hJfGEb6QeZPh4jesc5x4Rzg@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] sandbox: Add a -N flag to control on-host
 behaviour
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Tue, 29 Oct 2024 at 21:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 29, 2024 at 08:22:11PM +0100, Simon Glass wrote:
>
> > Sandbox is its own architecture, but sometimes we want to mimic the host
> > architecture, e.g. when running an EFI app not built by U-Boot.
> >
> > Add a -N/--native flag which tells sandbox to reflect the architecture
> > of the host.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v8)
>
> I believe Heinrich asked that you invert the logic here and add a flag
> for when you need the unexpected behavior.

Yes, but that is not correct, unfortunately. The expected behaviour is
for CI to use the same filename for its efi apps, no matter what host
architecture it is happens to be running on.

The use case that Heinrich mentions seems to be broken on x86_64 now,
as I mentioned on the other thread, perhaps due to a recently
introduced bug in UEFI or QEMU. Just to be clear, this is not a
problem with sandbox. I suspect Heinrich will figure that out at some
point and then I will be able to try it too. I would also like to run
it on sandbox.

I hope to get an ARM machine running CI eventually, but I need to get
my lab running first.

Regards,
Simon
