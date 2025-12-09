Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEE2D3B7F6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15D41838A0;
	Tue,  9 Dec 2025 22:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GeHuOlSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E389283C5A; Tue,  9 Dec 2025 22:32:52 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611D483655
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso5850774a12.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 13:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765315968; x=1765920768; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQKiAbOZAjqW0gFzeFbfPQkSThRHCCxda7bqA+bODRE=;
 b=GeHuOlSGOiY+58FdPUrJnm0HtrWUTFWW7Prdu6HNxejdX11mKEMVBsQ3T7Unc+CxQi
 vsTrP0vWoYBFNnanHMyY32iv2ikWurQgBtitMUOsCUGETsvhq9BMJLbh6dY7BU09N7na
 cEx9bZlVpSTdVX3gvyigl0iC1ovup7SWuCQobBsQbUKEjJWwdJgZY2j3c+w0BudkdPzW
 gwOBXG+5yj9guQo8Zmk8Uhmrj9Jpodb9nBQXk/BJbEg4pX7asMaqBPZ3sL6VnKjWLFW7
 3rRPF/mR4c4Ay1maaJXdbALnweCa9QIZpwzrOig3c+jWQLaJ10Kkm0jFsBUVwJizPfh2
 rIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765315968; x=1765920768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQKiAbOZAjqW0gFzeFbfPQkSThRHCCxda7bqA+bODRE=;
 b=ox9cpFInFVB1I6f1M/WAjwqs0/KrkwoWDGHan/80kBDdAp9WY1eykmxqZP0CC3G6GO
 8OWQhJYZkvzwzpyHv2KtvwyQJuVDFUDz0lnds9SpmCM1kjoRuuX3soH/cZ3i2GHIVGxJ
 EDQg6fuArEiBbD9Ere2JlYkKOm1zxw7UVormsgjcMNydu5QJHtnElZaooHoAQlYhOM+p
 Hcoo4RNAIAmH8wFXIOgzoxh+aNo96TQ5/ipIHWttU3vMS6uAv0TDceIdLBYm30KTlUlc
 0Uyr1C3XO32GiqMpFhzail2Rv5annXKCJAsUwPWH6zU8T9SY4EuD0gxSHAzWzNU1FcRQ
 GqmA==
X-Gm-Message-State: AOJu0YwQsr7CZuHQ0cEya15LSg2yw+QUiZ8RFMAVbWSrV3TRDMKanz+f
 XpaMFJSwrasUNqYlSKINa55NBb1YO2Tb08fd/CXli2qnycL1zMfhcK5Ib9Z+7KAAQ7JD+Bhf1qJ
 +UPqGF6nv5rFmSWbdEMqRL/fUSPdQT30SrIer8N30+w==
X-Gm-Gg: AY/fxX5oL716Z72pQDq6G67OaV4hlNCUlk00hUxTVgI/PZwhikjNj3LJtA1L5EFvsbJ
 1AASf+27fz8QdIfLC8dWTArxYVkN1WP8zWWxjnmUvnn2G2V1llKtcnaQeN/W93iSphemnoVDdMF
 FMvVDKtzkYxO5xLcaHCqhMbAOT9jt1XyDsCCD5mpmQ0hSpGjNaKGg18AbGiIbyrttiaTyVoCo26
 qqeOqnsU7BDOWgYMVEKo0xeEfzFVnDpWy4zaydv4yWGZ7j8ILP9hjDP5C1hz16WPJLgvztxQXNb
 h6vnm+qe
X-Google-Smtp-Source: AGHT+IGko2BWvSH0fIBuKAvETdSLHKXw0H6w1M+rE17VauR1bTXt54Pv4whiIe/FplWQHWogJUD+81qQxClW0zE5Brc=
X-Received: by 2002:a05:693c:6215:b0:2a4:3592:cf77 with SMTP id
 5a478bee46e88-2ac05540c45mr353077eec.27.1765315968266; Tue, 09 Dec 2025
 13:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
 <3d0a90ad-f5aa-4a2b-89c6-1f9dbb8e1c60@seco.com>
In-Reply-To: <3d0a90ad-f5aa-4a2b-89c6-1f9dbb8e1c60@seco.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 9 Dec 2025 16:32:38 -0500
X-Gm-Features: AQt7F2qKi9N2NTR-JfdjdpEMYFW-5gltpMGYoQNNlV6GdNvi7fpSMgeKEcabluM
Message-ID: <CANp-EDZKunW1O3KCE9zcyNw2vLzLuFRgceWn=He6NCFXWbPHkQ@mail.gmail.com>
Subject: Re: [PATCH] spi: designware: Allow disabling designware driver in SPL
To: Sean Anderson <sean.anderson@seco.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Sean,

On Mon, Dec 8, 2025 at 5:55=E2=80=AFPM Sean Anderson <sean.anderson@seco.co=
m> wrote:
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 2afb15fff1e..94054ba39b0 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -223,6 +223,14 @@ config DESIGNWARE_SPI
> >         access the SPI NOR flash on platforms embedding this Designware
> >         IP core.
> >
> > +config SPL_DESIGNWARE_SPI
> > +     bool "Designware SPI driver in SPL"
> > +     depends on SPL
> > +     default y
> > +     help
> > +       Enable the Designware SPI driver during SPL.
> > +       See the help of DESIGNWARE_SPI for details.
> > +
>
> In addition to Tom's comment this should probably be moved out of the
> SPI/DM_SPI if/endif and made to depend on SPL_DM_SPI.

Ack for Tom's change, but I am puzzled by your request to move it out
of the existing ifdev. I would think that we'd want the two options to
appear next to each other when running 'menuconfig'.

While I admit that adding SPL- and perhaps TPL- prefixed symbols is a
bit messy, it seems to be how it has been done elsewhere. For example
drivers/clk/Kconfig has quite a few such cases.

Regards,
Ralph
