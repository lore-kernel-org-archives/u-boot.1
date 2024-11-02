Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670D0E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 17:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676AD89083;
	Sat,  2 Nov 2024 18:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KodXMdgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC03189085; Sat,  2 Nov 2024 18:35:47 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3D689082
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 18:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso5118697a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730568944; x=1731173744; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/jFCEU+LAi5cML/5JfEb6v4/kgINJu1vtQL9Z2+wuVA=;
 b=KodXMdggnsm7HkWZXmd2yGoSrfRcMqiDijqJv1KDsX0xs5xd3jCrn2uA6tLba4dRPg
 MtN6XUz1W1L7wTgpep0s7r+HrlCoCQ/oS6LuSvERh8mgQbJ/D8UvaEIgGsMsV1YqoBIX
 hOqgj0tqrh1KkTnllBMNH2KKirwwfGe3j8VPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730568944; x=1731173744;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/jFCEU+LAi5cML/5JfEb6v4/kgINJu1vtQL9Z2+wuVA=;
 b=cxIP7wc1/iyti17HXjLDaWe2V6l8n/msyCsI/swLbAABwragWt7jmKVY3WdDWooWyY
 IhadaLYKUIMUts3qVo7jBrX5p/tYhZfZZGFMG7CZUK90ML3zeqnxvsS+fz6vIAR1pZ51
 D7rOHrAISCsZ6Kl08X4vDrNUHJ3qFp49eV4pD0PCnrJaDUazrQfsJY4bUccrISM2hUvK
 fGVUk5SQcxk5fwhWhUTdfpaOT/E4y1zmlWgdSZidl3ub+m8TG3/1Nj7e0G6t6wmwJ1Ky
 zl5PnHTgCuPs6S2m7jfM2LynZlF+0CQhsEPp5mkoqRnQJU50pzVHUbi8qqUEaa44BzPs
 Qhgw==
X-Gm-Message-State: AOJu0YyCS/MEXJIttaKAgzb6M1YfZBJUwWyUQvMo5OvMhIrlVUTwQOLs
 chxoysvU4HUotnh/JQ/PjX4f2ELGsy9XpQJ52qnMau8D0r9PGFH2SaXwhDVTe01TLEnKu+rsjB3
 B9UPmDUrNDJpiFl3n5I+3rs7Zrl+iRkZOcjCCCQahwBEYpA942rjy
X-Google-Smtp-Source: AGHT+IHDNn8cc/NGCRNxqQRPxXI2W3WGGedC/pLX+ZTXzjkwmni2P0kPFbG7dL1ffXzq29hBr5poBeBwOM2rUhPy0Ms=
X-Received: by 2002:a17:907:318e:b0:a9a:478:2ee3 with SMTP id
 a640c23a62f3a-a9e50b57ba0mr1096357466b.40.1730568943724; Sat, 02 Nov 2024
 10:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
In-Reply-To: <20241017232531.726559-6-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Nov 2024 11:35:31 -0600
Message-ID: <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Andre,

On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:
>
> Drop support for distroboot and move to using bootstd instead.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Convert the other DISTRO_DEFAULTS in the Kconfig too
>
>  arch/arm/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Could this series be applied, please?

Regards,
Simon
