Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAC2C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 20:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55F782AB2;
	Sat,  5 Apr 2025 22:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kohlschutter.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kohlschuetter-com.20230601.gappssmtp.com header.i=@kohlschuetter-com.20230601.gappssmtp.com header.b="hm3xyjgt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D625582ABA; Sat,  5 Apr 2025 22:51:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A8D82AAF
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 22:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=kohlschutter.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christian@kohlschuetter.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e673822f76so5121389a12.2
 for <u-boot@lists.denx.de>; Sat, 05 Apr 2025 13:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kohlschuetter-com.20230601.gappssmtp.com; s=20230601; t=1743886298;
 x=1744491098; darn=lists.denx.de; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhAQLpNO1qFnQHZie267L7anyiP+BDeOvGfcIaC3Srs=;
 b=hm3xyjgtP1rwASPj/sM9qKegI1lZwsPqCbz7W+qkBkkJXBr7kF5YZQEXMulT9XTsVb
 lfBv27t3nu/Q5JePEMT98nkulHsXP1GjXEXExRX5mrUBNwzLwYoCoAFfew3XTV8nPoLQ
 aRXyaGSgrs6HlUqEl5cKYxp2DgSwyUyRNYMgS+TYpv/o7HqEz8IBZyN+WIXXj1AeK9vJ
 aG5vDA2nlg+4SNMRRP0nAma0q51MGWOPj/yvYwVe/aS13ulcp9MsoDha0Hg2p8EsgwPz
 iWvJgMeEpgmGr110W0PyGMM2KpoirP+u34dFstGveE2o5n8LQeea6SoGptZ9Y3FkGHOV
 p6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743886298; x=1744491098;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhAQLpNO1qFnQHZie267L7anyiP+BDeOvGfcIaC3Srs=;
 b=oVJNODLDavc4MwJVjCjQOvKaVeBzy8ltKQC3naiUNJWkldKqiQ7gML3sCqANDuQO7y
 drfcdVBzCGjvKGtSlqRHXkM3V7+J0p+qLvAgwDSSZyoVmacNgx03FLkeX76Yhk7Q2BTA
 dQKf7v4aeWyVrKrtZKE7WhqGIjEChZOn5sIiN/IMBnqUmjzGD/3MwxgXPyHy78GM5f1U
 z0xzfRjI86kVpaCuttHitssNm8d4shekTjOZnTqJS5Rx7oeVfgC4HqDHu4UukZ+ipb8Z
 S5vJ1QRFLbzYkb35UkV2a04yWZBHmlnxfIQLq+m46B5+cqAcNyEuiOxnzqaVxt1SIIfI
 AxPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBT2Nr0Y83UQna5ZN+NrnjFde9uq5DA3+fADyi8EpOFNBXQ/N6pTGq2k8MyMDeoS6EEhPaDgQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxrtWD06RlMIq9UYoac07VKe0REPMMIz5iO2le6JrLY/or9iPVw
 0XljTe65ndjrXRTNRE/Pug8gDtoHQG/XswWKKrzAl7RejfXSvrqJQ1970Aw28qc=
X-Gm-Gg: ASbGncsk5gJJAbR6HY2xUhNgeww41UI9CZw33pBI6gubOmQmOuJTYJVIGHfawuhDvX0
 1Kgoj0uUl0ID6ZxfHwOrFrowx62CfGYLL6rojBzKPMCKb67OpBeJGPXceFhr/au2i/E3fk+cPJH
 +Alk3zIbNi4n0Bm+ajVPSZlxfcEImjTPFfO52FH3MuTJbX/w/Fq5cz2oj4qZ/RFYL2dDGoiW1HU
 ZN81VKrLCq70Vt20tBtDZEfTRDYcG2sxFj8qEGpFWQhIJvmQOZ+dI4h3jwQYbSRUaYenVZ6lEBA
 HZkA0xuDD1F4ap9szX6MCKnDp1BgQHpoIkGVKmJCqIRm6FFrbz1ABx9fX9MQ36VAne4MVZr46rM
 k+Zw=
X-Google-Smtp-Source: AGHT+IGqvWUGXN/78BV/KppUw+d5Unaby9UTXDvIWoOM5rmdps2vyUnpEtfIO/sLCmajqToF4OiZdg==
X-Received: by 2002:a17:907:2d2b:b0:ac2:fd70:dda3 with SMTP id
 a640c23a62f3a-ac7d6d73905mr569168866b.35.1743886297548; 
 Sat, 05 Apr 2025 13:51:37 -0700 (PDT)
Received: from smtpclient.apple ([91.64.76.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c013f685sm479970766b.102.2025.04.05.13.51.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Apr 2025 13:51:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: =?utf-8?Q?Re=3A_U-Boot_interferes_with_initrd_binary_=E2=80=94_Re?=
 =?utf-8?Q?vert_=22efi=3A_Correct_smbios-table_installation=22_=3F?=
From: =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>
In-Reply-To: <d1bb7301-6006-444f-9586-59ed6f3ca7ee@linaro.org>
Date: Sat, 5 Apr 2025 22:51:36 +0200
Cc: Simon Glass <sjg@chromium.org>, trini@konsulko.com,
 Michael Brown <mcb30@ipxe.org>, u-boot@lists.denx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <D94AA922-63CB-416A-8FB0-9CD6BD6785CF@kohlschutter.com>
References: <C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com>
 <01020195ed33a587-cffad5a3-32c9-46b0-99ad-d2ba8f7813d1-000000@eu-west-1.amazonses.com>
 <F1B968E3-823A-4F6B-B39C-80AAE2961E9B@kohlschutter.com>
 <01020195f0df59d3-851c6ec3-9a49-4fab-b878-e11c6018b827-000000@eu-west-1.amazonses.com>
 <CAFLszTiRu3JtUw-z3LeHO9PKVZRuBW3L-WXm5vO0u6++-OdwAw@mail.gmail.com>
 <AED05ACC-AF9D-4A2E-90E3-7BDA597B2DB0@kohlschutter.com>
 <CAFLszTibROtKsE+LZ3cMXvj5MLBf=-6TP98UwxhPfh5eqQK+_g@mail.gmail.com>
 <68D651AB-8E9E-48B4-A062-9E688025F035@kohlschutter.com>
 <CAFLszTiJR3La6dwE6k5QbKMmtVpbq+VK9AYhkmeQSEhgozh1AA@mail.gmail.com>
 <d1bb7301-6006-444f-9586-59ed6f3ca7ee@linaro.org>
To: neil.armstrong@linaro.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)
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

On 4. Apr 2025, at 18:21, neil.armstrong@linaro.org wrote:
>=20
> Hi Christian
>=20
...
>=20
> could you test:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/drivers/net/dwmac_meson8b.c b/drivers/net/dwmac_meson8b.c
> index fde4aabbace..bf9c5e8f349 100644
> --- a/drivers/net/dwmac_meson8b.c
> +++ b/drivers/net/dwmac_meson8b.c
> @@ -145,6 +145,15 @@ static int dwmac_meson8b_probe(struct udevice =
*dev)
>        return designware_eth_probe(dev);
> }
>=20
> +static int dwmac_meson8b_remove(struct udevice *dev)
> +{
> +       struct dwmac_meson8b_plat *pdata =3D dev_get_plat(dev);
> +
> +       designware_eth_stop(dev);
> +
> +       return designware_eth_remove(dev);
> +}
> +
> static const struct udevice_id dwmac_meson8b_ids[] =3D {
>        { .compatible =3D "amlogic,meson-gxbb-dwmac", .data =3D =
(ulong)dwmac_setup_gx },
>        { .compatible =3D "amlogic,meson-g12a-dwmac", .data =3D =
(ulong)dwmac_setup_axg },
> @@ -158,6 +167,7 @@ U_BOOT_DRIVER(dwmac_meson8b) =3D {
>        .of_match       =3D dwmac_meson8b_ids,
>        .of_to_plat =3D dwmac_meson8b_of_to_plat,
>        .probe          =3D dwmac_meson8b_probe,
> +       .remove         =3D dwmac_meson8b_remove,
>        .ops            =3D &designware_eth_ops,
>        .priv_auto      =3D sizeof(struct dw_eth_dev),
>        .plat_auto      =3D sizeof(struct dwmac_meson8b_plat),
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D><=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Thanks,
> Neil

Hi Neil,

I had to make some changes to make it compile (expose =
"designware_eth_remove" in designware.c, it was "static").
Unfortunately, it did not make a difference (I still see ethernet =
activity impacting initrd).

Is there something missing for "struct dwmac_meson8b_plat *pdata =3D =
dev_get_plat(dev);" (result is currently unused)?

In the meantime, I've tried the patch from here
=
https://lore.kernel.org/all/20250405065812.33027-1-heinrich.schuchardt@can=
onical.com/=20
and it indeed fixes the problem I'm seeing.

The additional benefit is that it doesn't just apply to meson8b dwmac.

Is there perhaps an additional aspect that your fix would address?

Cheers,
Christian

