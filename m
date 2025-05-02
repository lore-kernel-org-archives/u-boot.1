Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F104C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 09:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 950878070C;
	Fri,  2 May 2025 11:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VGh1HUcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0543281F7E; Fri,  2 May 2025 11:26:18 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C70A803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 11:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1324198f8f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746177975; x=1746782775; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1QTO4l/bkPBcKEQt0dTTlA/Mf60P4DCNYrSguZLf8E=;
 b=VGh1HUcj0q4EWelkoXMRRD8Mrn+aE/jUnlhtKu13gTALP2K7VDqbC5RDMACh44Sah0
 XE3ESmH3WVdS7i9MH1OGouuh3psPTWCDST/QA+VChGYjfMb2jP/J45/RGDPLlliQjfol
 bI2ryjE5YXjIQh8+BXgoXKiLzxX8Xlyuyxp75mLWmxokKgOZZWvdDZWobx5prgwPygHT
 dEkKsAGuHxUbEABFKBQGGKzaSjBXJ8G+ZYg4eO59p71YOfnN66DA6NbV1ylS9sgrdfcW
 dC2pw3qMUuePD3JUuPTdMdW5rzVpDggVmSo0XHPu+aHOv5UzT9/KbHDpcnQYNBQV0Dii
 VIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746177975; x=1746782775;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O1QTO4l/bkPBcKEQt0dTTlA/Mf60P4DCNYrSguZLf8E=;
 b=e2i41TThyxWbr3Tkw2FKD/nm6Wzm6o0gz9e9X0YrHWzFiMBkAT2cZxJJuQoW1f4xbg
 G7KHMiabfKV9j2Bc1xxV32RMkelDxWhT/B6Qz85sYzUnyscQ4pbARa4cQkpIPh3xvwmH
 fI+TUmbTdY6X67NjYN08uU3C+LLO2XsL7i+Q7WLxWTZRP5F9b8PxTba9a5edR66r96Nz
 0L+nJrqFzuIGzyrjU0G4SAjfcruYPiQADZXr1N7tQevAlyqkaaYO76yE/VcLfMcqnt7X
 nZ0i04GKJPMBWCy3ydNU9B7RkNCRJGatiKdHZgg3g0hJv+Qxzn8BAdmMBcm/S+x5eioK
 JdYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7ISB/LNzpD1z2nxrQL1GkxInweQSkzSj35MC3MBCBFgfFDldlxSA9ZaKKamVO3KcUMzC2zus=@lists.denx.de
X-Gm-Message-State: AOJu0YyLb9gzaOJ1VAS5+QriQOljNK9TiolixXJcYZ8uLd8B2jU7a617
 fFVTkgu0PNZ97UD82vSM1IJStDvkg3z1CcTOdFxKaS3iL4Uu8kWYE/uY7PfWpzY=
X-Gm-Gg: ASbGncs4Y9CjkVpaZGfasCULhe47BhzjRIzKfrd8MA34OyL4FQLFK3k/QQYhLRteIgX
 8cmLMRxsF1M53qR8fftGFsMGzf4T3I9xVfzb2Orwu/5vw9QR7YxI6s1mh2Tu8iX01FY2EGdjOkh
 HrEff8GXOXD6UNTnnSymwugf0KipaJnf9dIPGuoSiC9Ykr2TkIcA/K7oUfGnALMZUxkACmSRc5Q
 g7QY6pBuGCqfsQpI+H9VVs4E5GiqwKxwiTJ+KaJ3WqFn8yCkb91Im7UqiLvlY3MNmFMNMm+k0d6
 S4rvL+GajB8NEVmkfOaZPSdAhrUVpr96Jrroq1K2KCIGUTuU
X-Google-Smtp-Source: AGHT+IGzOiccdX2MUCkBBhSwlH7K5SD2yAb8MHjykT8asBqdPIKKZpHdbXN7UDpTceEFBqMTqpR4Pw==
X-Received: by 2002:a5d:64a3:0:b0:3a0:8acc:4c5 with SMTP id
 ffacd0b85a97d-3a099ad27afmr1548676f8f.9.1746177974875; 
 Fri, 02 May 2025 02:26:14 -0700 (PDT)
Received: from localhost ([46.198.180.244]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0cefsm1631716f8f.15.2025.05.02.02.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 02:26:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 May 2025 12:26:13 +0300
Message-Id: <D9LKFIJWJXPD.CC0AEM1DDT61@linaro.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Tuomas Tynkkynen"
 <tuomas.tynkkynen@iki.fi>, "Patrick Rudolph"
 <patrick.rudolph@9elements.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, <u-boot@lists.denx.de>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Heinrich Schuchardt" <heinrich.schuchardt@canonical.com>, "Simon Glass"
 <sjg@chromium.org>
X-Mailer: aerc 0.20.0
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

On Mon Apr 21, 2025 at 7:25 PM EEST, Heinrich Schuchardt wrote:
> The EFI boot manager bootmeth does not require variable BootOrder to be
> preexisting. It creates this variable.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootmeth_efi_mgr.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> index 42b8863815e..1669cbed5bd 100644
> --- a/boot/bootmeth_efi_mgr.c
> +++ b/boot/bootmeth_efi_mgr.c
> @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev, struct =
bootflow_iter *iter)
>
>  static int efi_mgr_read_bootflow(struct udevice *dev, struct bootflow *b=
flow)
>  {
> -	struct efi_mgr_priv *priv =3D dev_get_priv(dev);
> -	efi_status_t ret;
> -	efi_uintn_t size;
> -	u16 *bootorder;
> -
> -	if (priv->fake_dev) {
> -		bflow->state =3D BOOTFLOWST_READY;
> -		return 0;
> -	}

This only seems to be used by sandbox AFAICT. So I think we should remove t=
he
struct members and functions as well with this change

> +	int ret

ret;

>
>  	ret =3D efi_init_obj_list();
>  	if (ret)
>  		return log_msg_ret("init", ret);
>
> -	/* Enable this method if the "BootOrder" UEFI exists. */
> -	bootorder =3D efi_get_var(u"BootOrder", &efi_global_variable_guid,
> -				&size);
> -	if (bootorder) {
> -		free(bootorder);
> -		bflow->state =3D BOOTFLOWST_READY;
> -		return 0;
> -	}
> +	bflow->state =3D BOOTFLOWST_READY;
>
> -	return -EINVAL;
> +	return 0;
>  }
>
>  static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow=
,

Other than that it looks correct

Cheers
/Ilias
