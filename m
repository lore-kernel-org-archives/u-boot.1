Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8C0C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 14:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 686F38837C;
	Mon, 22 Apr 2024 16:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Mc9YaMQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F1C88380; Mon, 22 Apr 2024 16:52:20 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8826A88360
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 16:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6eb75c202dbso2553748a34.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1713797537; x=1714402337; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEfWW+N7zNY4Xsaj/ZpNhxwHDV/YKjep3TTj4P18UBQ=;
 b=Mc9YaMQ5MQPC40ZMelcE0f83N1KFSoKnCH8k6tj9aynyV4DkWzYYE2ZZ0gVbiKZHWv
 G+nG6VMukumoCWNfSbZ8/Iqgx/7g6HpnuLvYgxVA0zIGboV8J5RutWnII18d4eIB2/hU
 zEv7TuOD8svq4gT5LicpEVidQIcqfzFfzSsvtZXcBdJoZ7sVx7MqFUUFffcY/Zz5bgXf
 VlYvjAQ+oatSM9JTKysub5clyxaKYpB0Zsx8NSpwTYkx/k2uK0QcqfHGwioU13QLGTmI
 pj8KZUomjbK0KDwLUfAzwXSyAGhKjC90wyQT+uQ+hbZTTDqKGRgOsAQ2wUxjUhCLQM74
 A1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713797537; x=1714402337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MEfWW+N7zNY4Xsaj/ZpNhxwHDV/YKjep3TTj4P18UBQ=;
 b=rvTiJzmgqa+0t68E8p83vr8qoqs1rMj2+ZYtaJGxEvcAN1LdrFsGlUjz7gowFGU8Rc
 q9FpZl07b+B+uQgQyKo5GQ3po3msNVQIaPMEvPwIqO8vZbdsQeOTNwz6aA7vOMs/65ZU
 iYvSuYGtsxsqRdFGn1iwB7aS9yMcgcsGN+YnHpYTl9pbcs0Bl0EfiUcTAegfcPiqEwZY
 wvyAjKTwC/1KsvMaW5P8QuFNzIeS0EvOGEB3EfAD34E5YoPjLBR8kDqJCLptA1+FS3VT
 iJCgfzuZ9vyljpjY7C5ZTmIt9YhPmAOMZrmsOmAxKAHoP9NjX29FkrpIakQ19cZVZTp+
 hqnA==
X-Gm-Message-State: AOJu0YzpIWG0ZPiCDI4hBIOKtUYhE/CQ40JuzRNi1KBV1ZvT7W0zBbCa
 S6Bxo5CdgS++zB65GOTRihO42u4yA+TFPGAcdMxO5JNOS3QDG9Hvb3J9EevDP5UTd2LGCiLTe8r
 ap9HE2ZjvzjprFQqHVmmgOpPbpqgzg8D4yAkfyw==
X-Google-Smtp-Source: AGHT+IH4xaJhxBmqti88W0BLr9c8MYQf2Spbjj796GNzKMPsMYMnn28vxalqaKkzU81/jQEJ+L/a1F4wSERKFPWu1Fs=
X-Received: by 2002:a05:6870:2896:b0:22e:9a3a:14c3 with SMTP id
 gy22-20020a056870289600b0022e9a3a14c3mr12412721oab.17.1713797537267; Mon, 22
 Apr 2024 07:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240421204839.2129998-1-igor.opaniuk@gmail.com>
In-Reply-To: <20240421204839.2129998-1-igor.opaniuk@gmail.com>
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Date: Mon, 22 Apr 2024 17:52:01 +0300
Message-ID: <CAOF=9AsvMrgHAUo8trn0TxcMD60xfC=+JemsPuoe_ektVHSsnA@mail.gmail.com>
Subject: Re: [PATCH v1] tee: sandbox: check for buffer size
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, jens.wiklander@linaro.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Sun, Apr 21, 2024 at 11:48=E2=80=AFPM Igor Opaniuk <igor.opaniuk@gmail.c=
om> wrote:
>
> Add additional check for buffer size when reading out persistent
> storage value and provide back actual value size.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
Reviewed-by: Oleksandr Suvorov <cryosay@gmail.com>

> ---
>
>  drivers/tee/sandbox.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index 8ad7c09efdd..86b16a3bb8d 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -174,7 +174,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u3=
2 func, uint num_params,
>         uint slot;
>         u64 val;
>         char *value;
> -       u32 value_sz;
> +       u32 value_sz, tmp_sz;
>
>         switch (func) {
>         case TA_AVB_CMD_READ_ROLLBACK_INDEX:
> @@ -267,8 +267,12 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u=
32 func, uint num_params,
>                 if (!ep)
>                         return TEE_ERROR_ITEM_NOT_FOUND;
>
> -               value_sz =3D strlen(ep->data) + 1;
> -               memcpy(value, ep->data, value_sz);
> +               tmp_sz =3D strlen(ep->data) + 1;
> +               if (value_sz < tmp_sz)
> +                       return TEE_ERROR_SHORT_BUFFER;
> +
> +               memcpy(value, ep->data, tmp_sz);
> +               params[1].u.memref.size =3D tmp_sz;
>
>                 return TEE_SUCCESS;
>         case TA_AVB_CMD_WRITE_PERSIST_VALUE:
> --
> 2.34.1
>


--=20
Best regards,

Oleksandr Suvorov
Software Engineer
T: +380 63 8489656
E: oleksandr.suvorov@foundries.io
W: www.foundries.io
