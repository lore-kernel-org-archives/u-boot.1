Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B144C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8A6842FC;
	Mon, 20 Jul 2026 10:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXmUQrcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9EE84659; Mon, 20 Jul 2026 10:35:45 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99292841F2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-51c2c8f43aaso90590371cf.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536541; cv=none;
 d=google.com; s=arc-20260327;
 b=OfKwiftsNpyrOHvUSHi48GMupqeAEt12sxMh4ZOcSESB7xmxQbdTpwtG2AjH643HkP
 PsDi/SL0tLuxCZbWX9GGtplc6VdA2U9cpmXk7pA6iien1jnFBVxIWG6UaNHRjSMdU6AB
 My4xiP5i9TPeSeE4qGuAWuzPux0U2V/PzufdlBCn0cbX+b6HVaj8C86Zj4wi79LXvoLA
 69Aj47X0V+I9riGVHAQ5zstSi9g4xr1YKF1w1abKhCzWjha8bmwYB4e3eX2TLR8bdRsi
 XC5cHC1202GyeDqHrg90uJoHM/WdwCqEFGCcoOm7/9x1cmx65BRt0YFxhM/VdZJIwpHh
 wUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
 fh=LVQOYipl/Ilh9QTWyj3CEXBwCYiBSVE5Gq2/Z2veUx0=;
 b=mGlmSzDMxNCvhjzJAa24n8ykveUXjWqGjMlBC+klHjt4WCSVupDYpIvcKIXMBbIOzU
 4vV1yX10mQWWAgplfWSFUoaUD5D37GVp1glaiS1hbifl/uEzIroIXIJn157ZdrEOJONM
 tHuZzdblCyBoe3GOe/nnkFzPZfNSuMhqBjlsawq0Bj32wf1wB3M62xZaTvT8fYeKehZF
 km4GlkKeqzYFVk/uM931MmBk0yzGo00KJelB9hTC1+1QQ0MThCdu436FMf1hX5aZN8cZ
 +Z2EFba6V8Qrv0lr8F9ZIEHEyNkMbbWuDfCVoPVGEZTAriGQQtTylAorgnwKJOoJl2CT
 4POQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784536541; x=1785141341; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
 b=GXmUQrcpZUeQDALaYtngYtEp2m7ZYJoQjJ2/9Y+FjeVhkzJDluLl1/Jd+q9yMzIN2v
 VeM0o2VzuIePuy1j6pGg7MqT+qUnSbq0sm+wyg8jPVmFsUdKTGwAl2sk2r+n1Vmb7BWQ
 iTLvIVh6a5GM/gemlj6aYjyb8Y34Uz9DV0Zu8+5LjXnirWiDGaFQlJA6QwaDjsN9Doxf
 bwkz04slC+5y1QWCGpQJHkaJqhc/YK/QQ1sisp/Od4fT6LHSkY6Y5g8RHb9OuRNKtJfh
 WhLRIIMcJ5/jZLGD+nY5dwl0dcT4xb8gWVH7vYHjBP9h9ISvCqSGCDoOgkqTy50t719W
 CDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536541; x=1785141341;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eMvmMIgH6II/eIaUo+EPp8VbxO06kOPl2E0PJOnzFF8=;
 b=Q2wFCozxkW9MjSEyyDAdBUuaCL4FHIeyu6Fl+qV9qIJlQusdE0W6U9B7meTQOgTIS7
 0PKbDQndPrzQ5N/mYwWRi2TyvavT4VTBnEnIoB5hYjG04UocjwLUqCpSVB+/UAvdaA1R
 lnfjzPUMMfipd2MUHAo6bwvDGuzqkzzISErWHFg5FohULlo03aD0zOZSxkBtw0MXuL+S
 OuieYQMNzJ7AAXLJ7ULXqYf+Mso9r3gyBYjllVNp+jHEfaWn2PsOuxULp/GuwF9jcIsG
 ykzUfLz5OZf8OztM59v/nWF0m7pKjvZsGIhukr223NTXzLlpTVUfl5SQV6RmhHWn8DgS
 uJHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpP5BDkcrgqhB61RPxXwfrgLkLPWXQBtYS1kuaLn5zCwdVtUDbHzo9IC+BF3ZFlw7HpnbFcy9o=@lists.denx.de
X-Gm-Message-State: AOJu0Yybo/GGi689fmQEpMeRlhvzC5m7IlNYuDcweqvdFemxYplveB4f
 vpDelijaWuAyjncFJ45WA5or/BwG/Asft26wpqmdA+M7wD+LWjNADnRK/njvjmPdLCVzjzSoFtQ
 Ck7n/n6/gxMWLF3IdsR7fQ0UihVRnfyc=
X-Gm-Gg: AfdE7clkOaeHb6K5oJ1CsfreL8/gRZ/5vyqCqdkkACxpbFNYTO6HIkTlgtrlzuqk6TN
 Aevq6EhuwFWJLOPcyTONu2vRvXZSNtl5IcdIxiQJuZLNZJTjpo8S7ky+tDyHMY68A4StdLR/N13
 i+dAzPYIRcyjFqM9+uFPQyzJkxuFYhm14lyZonWoyvxPgiPNOS4iCv/iiuCepdzvEx8NxWF5chy
 +p/uhwsFMDisucb/load8IIu/5T1oatc3MQdlDA6M9w7hBSeNclnBf+g5jFIZBCIn9FCAkYYCNl
 DBhE4oFNV+SuBZ+y+n272fRGljP3G+Mex5RXGNC6+ajq+z7owpYOTHisN/99lSub5cQ3HomAo31
 yXTH2gCP8z3H5eak0lzYputAzNPbZU6wy6mwhjHrlK1c2ix5Nz+1vBzq6
X-Received: by 2002:a05:622a:4188:b0:516:d781:589a with SMTP id
 d75a77b69052e-5213c201617mr125345921cf.22.1784536541369; Mon, 20 Jul 2026
 01:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-3-20ec1c334dd2@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 Jul 2026 09:35:28 +0100
X-Gm-Features: AUfX_mx49182u3JAUpcYkcvNhWyQzlcUapiueXfhLBn93hn5kKx81AD9SX1V_qA
Message-ID: <CALeDE9MdxKmGbkWstnNxnA5jRQ0rkmYjQbsxf_sRXeAL+yHAew@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] MAINTAINERS/README: Migrate mailing-list to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Heiko Stuebner <heiko@sntech.de>, David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
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

On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so update all references of list.denx.de to the new
> domain in the main README and MAINTAINERS files.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  MAINTAINERS                   | 2 +-
>  README                        | 4 ++--
>  tools/u_boot_pylib/gitutil.py | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e5b2a2e373c..177bc1fdc07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2022,7 +2022,7 @@ F:        test/py/tests/test_xxd/
>
>  THE REST
>  M:     Tom Rini <trini@konsulko.com>
> -L:     u-boot@lists.denx.de
> +L:     u-boot@lists.u-boot-project.org
>  Q:     http://patchwork.ozlabs.org/project/uboot/list/
>  S:     Maintained
>  T:     git https://source.denx.de/u-boot/u-boot.git
> diff --git a/README b/README
> index 472cf37d9cc..51e98d0f4cf 100644
> --- a/README
> +++ b/README
> @@ -45,9 +45,9 @@ Where to get help:
>
>  In case you have questions about, problems with or contributions for
>  U-Boot, you should send a message to the U-Boot mailing list at
> -<u-boot@lists.denx.de>. There is also an archive of previous traffic
> +<u-boot@lists.u-boot-project.org>. There is also an archive of previous traffic
>  on the mailing list - please search the archive before asking FAQ's.
> -Please see https://lists.denx.de/pipermail/u-boot and
> +Please see https://lists.u-boot-project.org/pipermail/u-boot and
>  https://marc.info/?l=u-boot

Should we also add a reference to https://lore.kernel.org/u-boot/ here?

>  Where to get source code:
> diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
> index 34b4dbb4839..59688aa7147 100644
> --- a/tools/u_boot_pylib/gitutil.py
> +++ b/tools/u_boot_pylib/gitutil.py
> @@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
>                    "Please add something like this to a commit\n"
>                    "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
>                    "Or do something like this\n"
> -                  "git config sendemail.to u-boot@lists.denx.de")
> +                  "git config sendemail.to u-boot@lists.u-boot-project.org")
>              return None
>      cc = build_email_list(list(set(series.get('cc')) - set(series.get('to'))),
>                            alias, '--cc', warn_on_error)
>
> --
> 2.34.1
>
