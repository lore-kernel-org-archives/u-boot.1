Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBAC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F5088B2F;
	Tue,  6 Aug 2024 23:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LoGvoP/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F87F88B5F; Tue,  6 Aug 2024 23:51:53 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33CB6882EF
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cf93dc11c6so851953a91.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981107; x=1723585907; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmZqtnBTxnySPRuG5AFwIF8kGsB16qqfFtncO98vvUk=;
 b=LoGvoP/pwqf/U1JXp09lQcai0wwDVpNv6C6it6wlfYZvDN6VPmOPmlMl+Uz7bh+DJd
 48neR8k2G/b+tA/0r+3RBNeIim1elLRbcG76RloCnKExG8x/9u7OeuW30Dl9o0KV0SPF
 EEeqt9KJJdbc+HrGEnFVudIN6nnpnKn9oLkUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981107; x=1723585907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmZqtnBTxnySPRuG5AFwIF8kGsB16qqfFtncO98vvUk=;
 b=P/IgNDm/ObSQvO1oQtpR3uhjWgUAuZQNGeuwLB26iiBHGcD4+32MZ97H8VtsI+LIqf
 3cJ9RDR1voi3XhkEBL1k4uK9WPK89aWWK4mJGnLwgdJk/d35qvvu5Y3yAE46sOgth8NN
 +11oZ/+GRnk9FFCzMC+iQrHsgDnlS4Fb9nafZ9soo56QlnmqsMegnXFh5VJ4w4wS3vOs
 Ax24NSa/dLG/fU8VbTXyvKXSB/tc97gKciWLrJcm96kcezPrcOBE5j0OsALmKT4yQbuR
 ZqHZr0jVJdm9rwNQNxLGV3OxwWqoGJklAwAlhwVegxOLWtmWKGPbbuWTEnlBhHend7wO
 4wbQ==
X-Gm-Message-State: AOJu0YyFs8fUMk5d9+MpW53NBZyPlrFHdXcJBcMo3uhDxrHMP8IC0EjT
 2EsGgm7XCJXBkQb2EJkPQv8btAW3mIg4ygq1B7rty6d2Ek2SlbkIvbcCXn29mACeuOZn5zWOB9t
 7xwEzvBkyMxZWhyWBZWh7VxZxet5YHaPKS3p+6QSw6aXR3LY=
X-Google-Smtp-Source: AGHT+IGO4/mshqeulj7ob8tOGcRGYEjdiBbVkau4cXb5Pwc4T5WuOHYADtTMx4/HjOb0QDR+XP/2XSDEWxKpRgqBaj4=
X-Received: by 2002:a17:90a:ba82:b0:2c9:74cc:1c1b with SMTP id
 98e67ed59e1d1-2cff93c6029mr19573091a91.7.1722981106675; Tue, 06 Aug 2024
 14:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240805133520.1745316-1-paul.henrys_ext@softathome.com>
 <20240805133520.1745316-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20240805133520.1745316-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:51:27 -0600
Message-ID: <CAFLszTgWUi3vdX2TG=AeAi67tqqSEXfYgficpR9Xzr+1tsqyHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tools: binman: Add a property to pass a key
 directory to mkimage
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de
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

Hi Paul,

On Mon, 5 Aug 2024 at 07:35, Paul HENRYS <paul.henrys_ext@softathome.com> w=
rote:
>
> The property 'fit,keys-directory' can be added to the configuration file
> passed to binman to specify a directory where keys are stored and can be
> used by mkimage to sign and cipher data.

Environmental things like directories are best handled by binman
itself, e.g. with the --indir argument.

In this case it seems that you want a specific directory, rather than
finding the keys in one of many possible directories. So I suggest
adding a new entryarg for the FIT which lets you specify this key dir.

>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
>  tools/binman/btool/mkimage.py | 5 ++++-
>  tools/binman/entries.rst      | 3 +++
>  tools/binman/etype/fit.py     | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)

BTW when you change the fit docs you need to use 'binman entry-docs'
to regenerate the entries.rts file, in the same patch.

>
> diff --git a/tools/binman/btool/mkimage.py b/tools/binman/btool/mkimage.p=
y
> index 39a4c8c1432..dbcf8daac30 100644
> --- a/tools/binman/btool/mkimage.py
> +++ b/tools/binman/btool/mkimage.py
> @@ -22,7 +22,7 @@ class Bintoolmkimage(bintool.Bintool):
>
>      # pylint: disable=3DR0913
>      def run(self, reset_timestamp=3DFalse, output_fname=3DNone, external=
=3DFalse,
> -            pad=3DNone, align=3DNone):
> +            pad=3DNone, align=3DNone, keys_dir=3DNone):
>          """Run mkimage
>
>          Args:
> @@ -34,6 +34,7 @@ class Bintoolmkimage(bintool.Bintool):
>                  other things to be easily added later, if required, such=
 as
>                  signatures
>              align: Bytes to use for alignment of the FIT and its externa=
l data
> +            keys_dir: directory where keys are stored
>              version: True to get the mkimage version
>          """
>          args =3D []
> @@ -45,6 +46,8 @@ class Bintoolmkimage(bintool.Bintool):
>              args +=3D ['-B', f'{align:x}']
>          if reset_timestamp:
>              args.append('-t')
> +        if keys_dir:
> +            args +=3D ['-k', keys_dir]
>          if output_fname:
>              args +=3D ['-F', output_fname]
>          return self.run_cmd(*args)
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index 12482703782..eb33eb9eedf 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -864,6 +864,9 @@ The top-level 'fit' node supports the following speci=
al properties:
>
>              fit,fdt-list-dir =3D "arch/arm/dts
>
> +    fit,keys-directory
> +        Provides a directory where keys can be retrieved.
> +
>  Substitutions
>  ~~~~~~~~~~~~~
>
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index ee44e5a1cd6..d20906aab3b 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -96,6 +96,9 @@ class Entry_fit(Entry_section):
>
>                  fit,fdt-list-dir =3D "arch/arm/dts
>
> +        fit,keys-directory
> +            Provides a directory where keys can be retrieved.
> +
>      Substitutions
>      ~~~~~~~~~~~~~
>
> @@ -518,6 +521,9 @@ class Entry_fit(Entry_section):
>          align =3D self._fit_props.get('fit,align')
>          if align is not None:
>              args.update({'align': fdt_util.fdt32_to_cpu(align.value)})
> +        keys_dir =3D self._fit_props.get('fit,keys-directory')
> +        if keys_dir is not None:
> +            args.update({'keys_dir': keys_dir.value})
>          if self.mkimage.run(reset_timestamp=3DTrue, output_fname=3Doutpu=
t_fname,
>                              **args) is None:
>              if not self.GetAllowMissing():
> --
> 2.25.1
>
> -- This message and any attachments herein are confidential, intended sol=
ely for the addressees and are SoftAtHome=E2=80=99s ownership. Any unauthor=
ized use or dissemination is prohibited. If you are not the intended addres=
see of this message, please cancel it immediately and inform the sender.

Regards,
Simon
