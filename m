Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4AAE9A031
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 18:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AFC83AC5;
	Tue, 17 Feb 2026 19:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOMViowt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF6D83B99; Tue, 17 Feb 2026 19:55:44 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A6183981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 19:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59e4993e00aso4106044e87.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:55:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771354542; cv=none;
 d=google.com; s=arc-20240605;
 b=NagoSYwZaDmU0xI+3o77qYVLyTHwfzOBCQWRpTdlAMXInR6th56SD2BQ94hQyyAjI5
 8iZqCudwQskiVtGEOvfqC1ShXk4Mn/ZnNVNZw9hUHe0uIBheqhllQRE6+F6irqxUUpXd
 iDmYKuhixB9aMfHUFfWTZXz7yww5A2NY3oVd7dKcyS2+eD+OaFOxPCGuIG/bgWoQq0v8
 2dD0hdSPQVj9ovwqhAHnmPNnYR8PeFXmna9PZmpaJ536Fu2MasNGbEaF8XR9wcRgOnl0
 gOdxIxxXHbXyncV7DOaArEGZRq9R97WijC38Slth/uCWyLXAAeUYoFf4tdBe4Nl4+PND
 ljuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q7EKimMi0HNazbd467RpAUYijCMd6j7C6BcNZP148io=;
 fh=ZgMNDchsqpLMzgmEoqnJ/eD53Ao35V1RCbp9Vx+SacU=;
 b=Q8QT+5wARaB3BfVhb3kJpnsNx70Rf4oH4IqusDnPiQ/qxmrkeN9ITGTm8jXcb5aaaJ
 ETtrFRz0WcdyKqwOvJdb1FnvMWxr0sS3fORg68dZsNzOk4b5I+hCqJZKVjdVAayobnaG
 1m3lJLRV3/a11auVjV2KrDjtPYn9v6XzYPp+9yiCOvvlBXtfrUNTj+a/SDB95JQ1Ukx7
 ujobBukfKOSU8kV8Zuzmdv/0cZzgRXnkIAOJ7YcRERdl7IpqSdH0ymAt7WlKlmoK2tZ9
 4Gkd+l+WowN5oYb1za3IU/e0/VYplwLYpdinuhEZhLmNqdtJlGWW7NSu5S2Pzv4Nsn0y
 DaRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771354542; x=1771959342; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7EKimMi0HNazbd467RpAUYijCMd6j7C6BcNZP148io=;
 b=OOMViowtSbcuIK85QJuiiWRUdYdgm0kn5TASaqKZ2DjEvOA1feCmGqo4NL7YYXJCNJ
 w+6A/LrD5Ot2Wu1WL3Mw7d8F7bxeysJWYSdyrZj4+xwOtWwqzzGl78pyZBc3DVze1PHZ
 9MDcXLsPx10UxxKWbim6Zr9Hs6/ZslT/rMWi3+ZobPtgrD8gp91PTEzbrixPqiyJo/fO
 GtfdRoL6puWomLg4Ot/VwWM70UUjIQgD1eEvFPIduQtbc+kb5CeNrXMAb7bQE8HVmLPj
 SHxYKZxle9MX8TOMnlVgaLjZ+pdK36uTpsehbh570EsUj2dxWTYcv9iibxInquhzwWPs
 8kTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771354542; x=1771959342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q7EKimMi0HNazbd467RpAUYijCMd6j7C6BcNZP148io=;
 b=Ep/zIopQb1EI5mtuWCKk4PsVCxx84NosFxhRmJZKmyRM4ZeLRS0ke1+7AFx19SbGmn
 tB69JhoQZ6Jd7jx8QyKrK+N9stH7DlHgPHUp2+0M4YvhQlxHjZFljQyHM6rWWi87T0wa
 3qap8uolG0zSvTkShGC76ZqalTTfVISbdxUnKjTeQHoIRDot0TlRb9E7UgJh1+kiyx6i
 t1+MAC1PRHynFWjbFcdrJs/U4O2ama6IftcvmwKIKRcaoGTqtScHKmG0GqdhykChZP7L
 REm5FhpjIl5Jpph0TpAqyqOeKwXAI7GPm1QhnDpYNX0uC2AR/UOWoYWDwNWIJzdHcxyJ
 d/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB+WfbAWBhnwcFVghg98kYzqceON+yMQJ576OxozuQoCKFwMNGLvMTShNQMK/OD/OVAKqF9o0=@lists.denx.de
X-Gm-Message-State: AOJu0YzqIcFRxQ3aoT98QXZR9Qd8LLpXwXkhhRTtUN0MTvoKqAcTLRYP
 xQb6OWIYKye5tTnUWJEPCgO6ija5aB07LIzuVl+mkaexl+VMccjrHH6WypMnIDyC0+CTReWNvNz
 9f6nwkG7lu+4kn52lu6YrnzNz3QOsoSI=
X-Gm-Gg: AZuq6aJ2ULGbVt/lLB7wBYpp7zvlkR6oOvLBzJmWg6kDIYM1BLGhFtf9LkHHO7aixtG
 0jQcAH9uZT7to5UHvx5Al3WCZ1/8USVPJhTOxXTMYr24GOTyO+fE6yG1bwVfiYYIwDorF1te0GC
 bHqBhbKVR3KrUVAVNyhXt+cq5hfTz15Vm74zEFcWHlog4+fP/h6TmTGy8AHIPIJyP8fS7zPFeIj
 ZpIlqBoG/xLNMpXVwPdMsbYjRkduRFD5MLXgCwXbLt5rGtgJrgNme8TWS4hF8YnptiQhf2AYmm6
 CMlqDbaSTGF1lozOGjzl56EpLIPvuN2sKBHbXm085pzki0DhE2OEcopEqov7Sg5Kolb/dMw=
X-Received: by 2002:a05:6512:401d:b0:59e:5df0:153e with SMTP id
 2adb3069b0e04-59f69c6c16fmr4797694e87.44.1771354541379; Tue, 17 Feb 2026
 10:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20260217103604.71029-1-hs@nabladev.com>
 <20260217103604.71029-3-hs@nabladev.com>
 <87h5rfk05t.fsf@kernel.org>
In-Reply-To: <87h5rfk05t.fsf@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Feb 2026 15:55:30 -0300
X-Gm-Features: AaiRm52OQBdSU7TG-nQs35NbOAUe_4jfAqu_wNTHTD9dwiAiWwJK3sTKzXL3h20
Message-ID: <CAOMZO5As4L3ZugNBQNRPkVdKMmodfutZ-3WT349mW5yaX+VE_g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arch: imx8qxp: Override weak fb_mmc_get_boot_offset
 function
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
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

Hi Mattijs,

On Tue, Feb 17, 2026 at 9:46=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:

> Fabio, Peng, can one of you please Acked-by: so that I can take this
> through my tree?

Feel free to take the series through your tree:

Acked-by: Fabio Estevam <festevam@gmail.com>

Thanks
