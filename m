Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E384C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 11:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF7787620;
	Wed, 20 Dec 2023 12:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+dDyGRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D4D876A8; Wed, 20 Dec 2023 12:49:56 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5306087620
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ca5b616de0so995887a12.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 03:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703072992; x=1703677792; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0L+bG1O8AoEgDQQHL0RYZ3BSxL/2VQ996vRZUVUicA=;
 b=U+dDyGRuORzcY/wDKzGVVrqZuGZqAycH9gknWuR1kHEmXsTzvSr6L7EtUjqGt7Adzs
 vqK7rISSvwuWUgjeVdBruGuPfa7hlIR/45zOGcCl9szFXSfNjXcJG1fgjLK06RIZ5lkz
 Pr7AZ+mNnfCq5dpQ3/2gHROQgdSTbqyKhspEKTeHgpItjrV4hZDwzvhGxUmR6Nl/2cMK
 1mL4VQ4ZqAeybZT/cNDA3Eg3+65olQjWmYP3taVeCEW36vQTrzbukmMJUsajP4DaYW9i
 9BBtD2DjHdU42DuYU8JVyA9Tcd4hUsqREhDKJ6izLnkDFCWZsjaMpX4Y7o8e0JqdlY/4
 TZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703072992; x=1703677792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0L+bG1O8AoEgDQQHL0RYZ3BSxL/2VQ996vRZUVUicA=;
 b=aCSUaH/8nAOY54IgxuKqOy3eIUibj3xDULDnFDCtx7M4piPfs1yVJw8wKxjhIu5D+U
 AJkxHvUKjM1EB98eRAtlh7Yrh27q0BEzJLXzpGMUUG9HfiUl4SnaEozDZBROCgqQVq1r
 SrOAEBkCSTJFcu9B1HjLjXkXJOFqfYBhdPLCcO9P1UAcCTQ6ZB7y+5a2anxMW4+sx8LI
 61v/wKsr3mr8J+2+xHFcFKeVCbg1u0kCzeAQ+UI/f06hBOY8kWowWiPOsmlKUrA7UUX3
 qw30RwoytzdjT6hjUdEo6CJZ9u5yT3lbOwgR27aSVv0A0JQjjlTf7sGuty03klKPaxrS
 9SOw==
X-Gm-Message-State: AOJu0YymCSAa0UR4Ihx9HwCBld2l77/oq6tfZi9EY9VrvMPKIotS/uM3
 ENF4P2AIP9A0MvKjNyoYeChMlM9hwRoDkk8JtJU=
X-Google-Smtp-Source: AGHT+IHZmTxuwshyRKSfa4BJfdp+2/Xh1cKKpg0jn6PKyKBlbHjTbjec9ZhYP9VQOdywLAUw8JkarKIJFR2QjV3mEBs=
X-Received: by 2002:a05:6a20:3c8d:b0:189:f553:6cd2 with SMTP id
 b13-20020a056a203c8d00b00189f5536cd2mr43390791pzj.3.1703072992669; Wed, 20
 Dec 2023 03:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20231220103811.228515-1-andrejs.cainikovs@gmail.com>
 <20231220103811.228515-4-andrejs.cainikovs@gmail.com>
 <CAOMZO5ChYdS=V16TUjh1bevHXoTybRWk+uX4ir9Y9T7zzEvV7g@mail.gmail.com>
 <ZYLQX+WzAlITahTH@francesco-nb.int.toradex.com>
 <CAOMZO5AxX+RTBwpZ+DE-rT5gtYB=pv-tWesMx3NGcheiCL5ReQ@mail.gmail.com>
 <ZYLTuGyzppSLh81A@francesco-nb.int.toradex.com>
In-Reply-To: <ZYLTuGyzppSLh81A@francesco-nb.int.toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 20 Dec 2023 08:49:40 -0300
Message-ID: <CAOMZO5AU6DNFDtJBtc1m4c33yD5Wi4tiwt3ZayNJHkr50Srh1g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] colibri-imx8x: configure usb hub to bypass mode
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>, u-boot@lists.denx.de, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

On Wed, Dec 20, 2023 at 8:45=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> Understood. Yes, this is some real work that someone should take up.
> Just doing the sync will likely break everything now.

Exactly.

> At the moment the situation with i.MX8QXP/i.MX8QM is not as good as
> i.MX8M* neither in U-Boot nor in Linux :-/

The NXP folks are on Cc here, so hopefully they could help improving this.

Thanks
