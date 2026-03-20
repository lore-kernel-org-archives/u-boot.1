Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D04109316C
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 08:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B416E83CF5;
	Fri, 20 Mar 2026 09:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t+rf0H63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7826183D71; Fri, 20 Mar 2026 09:20:39 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6270E83CF3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 09:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso2664123a12.2
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 01:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773994837; cv=none;
 d=google.com; s=arc-20240605;
 b=il+Km+RAztKHuTITV8q/kYklBd/DWVzhoEMJnU2tYxZnSiEDUaxP11EJz83x/jA0rf
 PeNvhdEkAxag8xSLLh6m2Mt8P8oe0qd0hHfVBnPRalENAxCALqNyzj8VnnQ3ccdbnMOi
 GQx1sQRDIilIKwmrysHjBrBC/oblb8O2RCqGNdj7165Qc0yVAfZh25BU9qgCiOMkZ/Og
 FYGtmm1lkwWz4LOgaAxwkiiGMjis6dC8+rz9n7lp0Z4ihAHdMG29e5srCg3jtV0j8WlR
 0mj8Bzhm/vQ9XfScBudpsErKtB8lSIiqEMeE5jiL6yoEa3KUC5sC7PAXQOL4Vy4XvGBe
 htYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FcTWLEkSdfFWEQJnD2WHlJ5cvYovz/MEHRYFWH0Dx8c=;
 fh=NK0xDmK3EyQhz0z3XGhvRcngjspySignhP1BVLqVFyI=;
 b=c2VhbGN/mswaZ6pz6qG/ymyk0fbdD0L4S0oZK4mshbEJ9Qf0IEL0j7Id0UYezqB2w1
 ixban01iDtvp+Xv9PXoHzzZc66qnAM30qOeIyn2tmBmdAMPKWPddm3Jq2ME4fvwiUcrt
 WeRZfTs+rSBKlTgvWhZ7SbMzq/dUuakeV7xuf9BPJ1SU2qONe1WpMTc/lIPuE15pKeqY
 oyxLFYmPT+vqFg2DyZNuq923Vv9V4p7b1ICxUexqvvimYdHaywMSd+shyNe7DhF7TNV5
 hA0PFBHri6d3Y4sfw6oNvpxz3RtX/4Tg+aFNpnZJrYjv/uYWHOsx5HGNMHPJlWf28amo
 1JdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773994837; x=1774599637;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcTWLEkSdfFWEQJnD2WHlJ5cvYovz/MEHRYFWH0Dx8c=;
 b=t+rf0H63MxAP22+esOeTP2g9lEPuo48veMvV7gUoCwKp6vkI6GIyBreI52TyeKGKzK
 SMO0hFHeeqyk4Z4wRzRyRJaBiTgbPCYcARjZVVTIYXF1AYymWzMQgeXmJ+I8h+G9YUWs
 vvpuip/eOXUD/sZOEKYnjGjTEFAiH/WTh9GxCKWHhe8uwjrrjeiy6azcB08CyBwXa1CJ
 peZZFh72akvHcYgo/gucVMsFb2rtZt0b6gha6FJTAH2w/+4jo1lZwvCiovAN24VwM9ur
 PiSMDevB3SrDnwKlxpft+908TR1w4wARDPtwWpQQ3RZncji8Fkb6LNjPcHgkxKJh3Hck
 DxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773994837; x=1774599637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FcTWLEkSdfFWEQJnD2WHlJ5cvYovz/MEHRYFWH0Dx8c=;
 b=RuqyCCt9YjRjL749vqIC2Ae8mwN8TvHXonnGx40Z+qPg0dWjagYt/nUoIY7cmDScTG
 wIQmMx5iqwg3bQU2Ck8EYkfy+P/FUNestNh3RUBgKE+MfA0cBu6/zeQftsmD0VmSByEl
 ZAnqyst+gZoOF00oSFwwzNoZK1JA8MzZtxS82uMyMRc+I53rze2oMM6VDVryl/YGxh39
 Zc7XCnI7DhetexuOQMD0/X9ypULQHHkxxlhrxdbiSK8kZz1QvzXxcC6lRHfNEBxkmiYb
 OplJvs2nvt0MnB9DgK32/j/q1CBW7rabqpsRjQqv56byTikC0wHlwDNRhqFbfUKZzem1
 oyZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN8A8ebWNEdRrdu3qNNA++6PMiBydv/Vfa5+Lg0eAwzhbXDqmBiX2B0ZKEkyKmvqm5sj3aP8g=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2m2A6sp9QkUeaWS4UmhJqjcQx2PrgdZa3DTiX++EUoO7+gMou
 aEBlk5nCyFSxdbDU6LJZBsEN9R8GqUVJ7Kb1lvmR69Yb8z7WjmTMXVC2Fk6qrZvjNaiVJMJjC3/
 QlFFz+c85ol7NpkOzMzvo+ldiqGRB+Tqhysg46Rzq/WGooffZzUoV9wOo+g==
X-Gm-Gg: ATEYQzyOcOx/dVljJK9y9j8tXZE/E/QdlNnfSFm4NZsL3Wtm14BHnOe7FuGMPrjQJNY
 tPRzgXhPTgtNyuy632+BiWdi3EKCcUMBe7n/q6ox/aO/gjveMacNoHcEkqk5PFLz9w8Y/FhIadE
 OURGeUhWdXLtKs1kW9mwuFq20IcAUmlrCwRGYwXPkUzeIBtwE3MH0uOwWOm7CRBv3sMHavMzOMF
 J89ZYx3DmicBwubjd7qDPeaohRsYtkb5ahoofvzfWx+S8OcJglNJmZSvhkZifLcVvV/mKTN+eCX
 wbrhGfiKf6LcRMJ17K4aRAoJL/S0pkxt6/BPVOb2PZ1v4+CiM0RbpD3vU9uDKqukNdJPgte2WBl
 NoGL2DhdAYMRxIwkCIOpR6q9ZmQ==
X-Received: by 2002:a17:906:e86:b0:b97:f2b3:49b8 with SMTP id
 a640c23a62f3a-b982f4deef9mr110592866b.47.1773994836674; Fri, 20 Mar 2026
 01:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-regulator-fix-missing-quote-v1-1-839144d65db3@baylibre.com>
In-Reply-To: <20260319-regulator-fix-missing-quote-v1-1-839144d65db3@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 20 Mar 2026 09:20:28 +0100
X-Gm-Features: AaiRm51mukIwb8vE0XvrGhWVGmUC4dNJGZCPMfJGD9Ge9WGnqy0Ug8e8lnmShvw
Message-ID: <CAEHHSva=ux5KKD+io_f77cXz-YYMh-mqg4qWUJAtU0hyarVRKA@mail.gmail.com>
Subject: Re: [PATCH] dm: regulator: fix missing quote in error message
To: David Lechner <dlechner@baylibre.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le jeu. 19 mars 2026 =C3=A0 23:30, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Fix a missing closing quote in the error message when a regulator name
> is not unique.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/power/regulator/regulator-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/r=
egulator/regulator-uclass.c
> index 94c52cf555b..1c7f75a9338 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -449,7 +449,7 @@ static int regulator_post_bind(struct udevice *dev)
>         }
>
>         if (!regulator_name_is_unique(dev, uc_pdata->name)) {
> -               dev_err(dev, "'%s' has nonunique value: '%s\n",
> +               dev_err(dev, "'%s' has nonunique value: '%s'\n",
>                         property, uc_pdata->name);
>                 return -EINVAL;
>         }
>
> ---
> base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
> change-id: 20260319-regulator-fix-missing-quote-d69d54a69a8a
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Le mer. 11 mars 2026 =C3=A0 18:32, Tom Rini <trini@konsulko.com> a =C3=A9cr=
it :
>
> On Wed, Mar 11, 2026 at 09:52:49AM -0500, David Lechner wrote:
>
> > Add new MediaTek custodians and the new MediaTek custodian's git
> > repository to the MAINTAINERS file.
> >
> > Julien and I have volunteered to act as custodians for MediaTek since
> > we have been actively working on upstreaming MediaTek support for some
> > some time now.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

Thanks
Julien
