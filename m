Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7833DCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B3C848E7;
	Mon, 25 May 2026 17:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+BveD13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91F684908; Mon, 25 May 2026 17:44:38 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EFF84859
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-56f70865797so6106821e0c.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723875; cv=none;
 d=google.com; s=arc-20240605;
 b=GFGM0guBsxieRg9D5On7ao5Z+eql1UqKZcHj/VAaJ9/JaPUi2izyNkxGLJLunbrxrL
 FFFu1Gg9gPLxYnFuRsTkACdMfJmrGTXVT2BcZo8Bqe5aV7ZdC02giP6SDAGvhYEGWq+7
 00CYBerPsFtuqbaFvl9ToUR3KPGSAGmejEECV7F/4V5VS1mVarYHZk2lXJ3w4Ov9Yhsi
 J1uqDZgItLztnSp/lQ7iZJfBjDDr9FCJxTPT8CwycoE+N8ZG+W0iaHb+Lhp6PWNE37lX
 3K8ig0CAg9P5q2NIhwS6ekOqkjPvDbVFyASXhirbwGQhuA9uv1G0Ntvjqk8hRmpsS5Do
 AA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BG/wJppE7oVn9y71LAEVB9/edzdR2GIXZcZwHS4Vp9A=;
 fh=G94wVGRPVH+l5FTc6G/Q2qY7GNfVCEUEgIyEWxQXMq8=;
 b=TMzHDubCUdyPEmwnmujWJpI5BKcqiqrM+eOjelnBfRGcSJ2fDOi8J2osMHue9x9N8l
 1a50B4qkqj4IL0wcosBFKS/QbuxltGgBg2sXBpBJ7Y4mGMaqHp178ari73QKanh74tkf
 qxwdeS3UBNuplkhQrZxVeWjZ9SzWZAmDChR/zp6Yz/8ksWTwliAK2HyNBv1oy62G/FIr
 U6QvJ6ZKu5Fkvt5GXC44UZ9ZVoVo0er4DeIiTfOCvDkWq/L5Eo7tEcn+lON+aTz79shj
 vv3BaFUv3Gp2I1BNG1JGiDrYMnq9JhupdlooMy7xOmQ/wOtgcnZfeaFGvyhd2HYCL372
 Jq+w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779723875; x=1780328675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BG/wJppE7oVn9y71LAEVB9/edzdR2GIXZcZwHS4Vp9A=;
 b=U+BveD131W3G2rdCRCiEsmehVSdpJggyGOC1sV8MdHEwIAhjmXXyBlSJIvPuWq5/Tj
 GTFu6c6exxsWipI6G852Tkh1zY+PaLwFEEGzf9NE69qP48gDZ6c7t0C40YQYcI/+Z0R6
 xbdijN3qAnL167KoMGof/sWjWLE4qotweGpS71juJIxCJQE7wHZB6bbKk4K4TlZ5noEQ
 2099H3Es4wR9ulf4N/drDqBeVJOC35WTy/1iMvRFtJpm4SbuNNf3ncwzm8zbex6rYEx8
 hj8G4/7yiqWRWlX60cwAb3FDKqQ48pDFUPunAXA3oJyIHa9YmkZT4nAZ7e3GLQpZgqvl
 DzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723875; x=1780328675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BG/wJppE7oVn9y71LAEVB9/edzdR2GIXZcZwHS4Vp9A=;
 b=GL7NUMt9eWu0JVsxiOQKQJGD8OBYTPZOsPD/TqZ9UhKa2s90ZtCNpUnKlTg2TOYc1e
 mr9vX3epSGj0YOs5xsMy7B5BgwPa5IqAwz8xNstt47a6VnGWa2H164xGjWpm6iu6NWeS
 t0qsxw5/4WRwbk2mpM2DjSFVoUpHLUrIfAMFupuxYq5bdp04Qt4QENkb1ZGHdB6JFuF+
 DxWAKavHD93RlOKhoV/gmSf1YQIlhmPy4u8gHKZBtly0PHdInwhOWVUR23zmzAjUvGjJ
 qi+/gJGh3jhZK/YPrNvHYZhGZulHkWIb6GDvajxUi08hSCmtf8hGFFPllsiOlicVBIh8
 IJIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9R8IZL35oBfFg5egCzelW0kYJRoA6rHea8cg6sHtuWTTA31g+79DGXCfup8W2dp+XOnONTD0Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+IQncmOYAZBp5hjllozFwsqMRN1yCLy30kyeg3c2l41YUfxil
 DWwDwonqgcmCg/PyazIY5MqXEwWaqPm7MGqrKWFemQadnrFagFzTeZ1y3LijVmfs2B5qe7e0U6s
 ut2iqWgFhPlVIyURUNoKoBec7rFnLnFI=
X-Gm-Gg: Acq92OH6BGMddfkula9UyzNH0JGVs8pjLopl7VmVhVg/wYZ/xek15EEmSYdwbzDp+8h
 AllkwZVh9i6Ev0xuyNBlcmtCwqk41DNWdQFOmxjHVykAf0uiIpw8SG2oF3kbepQ7ryW1vRyCCNn
 ESOsAhm2ezmvqdnN1/cdIJ/Fmftq8Xg64myxlvn+Dcn9xEUhdejLcT0FeXAyjRZIUrrBzp2iwJK
 rhSqp/bY6kgRiKW/7YBeD6LKFCSd6Hm2UrsGrPpJOVJmoFrC4PT5qjiossq0ODXG41RbNSzhAxE
 Ix8MxZ4odJiibwUiEUU=
X-Received: by 2002:a05:6122:4896:b0:575:27de:3eab with SMTP id
 71dfb90a1353d-5866347ff44mr8395062e0c.9.1779723875440; Mon, 25 May 2026
 08:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
 <20260525135241.88348-14-philippe.reynes@softathome.com>
In-Reply-To: <20260525135241.88348-14-philippe.reynes@softathome.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Mon, 25 May 2026 11:44:24 -0400
X-Gm-Features: AVHnY4Ic3aIhbtc4-32Iq0g0N9p4gZwwqdcklKtWKobkjJk4k4oL-gvJj-OUBRI
Message-ID: <CAMDkj5z9R_iiAc+8ycQj5DMRii8J75mLqzbLOmL5K64w_QnPww@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] tools: preload_check_sign: add support of ecdsa
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, trini@konsulko.com, 
 simon.glass@canonical.com, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

Hi Philippe,

On Mon, May 25, 2026 at 9:52=E2=80=AFAM Philippe Reynes
<philippe.reynes@softathome.com> wrote:
>
> right now, the tool preload_check_sign may only
> checks an image with a pre-load header with rsa.
> We add the support of pre-load header with ecdsa.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
> v3:
> - initial version
> v4:
> - free key to avoid mem leak
> - fix error management (set ret before goto out)
> v5:
> - add include ec.h, evp.h, err.h and image.h
> v6:
> - no change
>
>  tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>

Looks good to me. Thanks!
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>


> diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
> index ebead459273..d94f0509e74 100644
> --- a/tools/preload_check_sign.c
> +++ b/tools/preload_check_sign.c
> @@ -8,9 +8,13 @@
>   * complete file. The tool preload_check_sign allows to verify and authe=
nticate
>   * a file starting with a preload header.
>   */
> +
> +#define OPENSSL_API_COMPAT 0x10101000L
> +
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <openssl/pem.h>
> +#include <openssl/ec.h>
>  #include <openssl/evp.h>
>  #include <openssl/err.h>
>  #include <image.h>
> @@ -144,6 +148,32 @@ int main(int argc, char **argv)
>         info.sig_info.key      =3D info.key;
>         info.sig_info.keylen   =3D info.key_len;
>
> +       /* For ecdsa key, we have to update some values */
> +       if (EVP_PKEY_id(pkey) =3D=3D EVP_PKEY_EC) {
> +               EC_KEY *ecdsa_key;
> +               const EC_GROUP *group;
> +
> +               ecdsa_key =3D EVP_PKEY_get1_EC_KEY(pkey);
> +               if (!ecdsa_key) {
> +                       fprintf(stderr, "Can not extract ECDSA key\n");
> +                       ret =3D EXIT_FAILURE;
> +                       goto out;
> +               }
> +
> +               group =3D EC_KEY_get0_group(ecdsa_key);
> +               if (!group) {
> +                       fprintf(stderr, "Can not extract ECDSA group\n");
> +                       EC_KEY_free(ecdsa_key);
> +                       ret =3D EXIT_FAILURE;
> +                       goto out;
> +               }
> +
> +               info.sig_info.keyfile  =3D keyfile;
> +               info.sig_size          =3D (EC_GROUP_order_bits(group) + =
7) / 8 * 2;
> +
> +               EC_KEY_free(ecdsa_key);
> +       }
> +
>         /* Check the signature */
>         image_pre_load_sig_set_info(&info);
>         ret =3D image_pre_load_sig((ulong)buffer);
> --
> 2.43.0
>
