Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853ACFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 17:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1687842FC;
	Sat, 25 Apr 2026 19:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=e-labworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=e-labworks-com.20251104.gappssmtp.com header.i=@e-labworks-com.20251104.gappssmtp.com header.b="iAe5St+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF9784308; Sat, 25 Apr 2026 19:54:51 +0200 (CEST)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5681D841DF
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=e-labworks.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=sergio.prado@e-labworks.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-12dbd0f7ecaso1712362c88.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777139687; cv=none;
 d=google.com; s=arc-20240605;
 b=DKYT/2kAeNdIbTnI4VYYMaX+e5kLXOEhNrdlzBty48508TeUQJ17CkmFbGtFDYR512
 E6XXiUePQ8hyrUATGfqsBuf9RW6QAI9ZdignRdGRJDNbNuNKfMphywstALrURhQEqYgj
 AV66fbpBMR1CPEmhffpA+/q/Sw2HOydu2IJ0SiU3E5fUtPzpeL/lv0WP+kULXcXwBqw0
 nWj/PO2N3M2w//3I4gjdieiyX3asUQX2PF/COEaEUJQHX+Rl3b0kdH34KNCTdKalr8ef
 5xD81dZ0D95Ov/YgFTyHAVo0br5HyiOURHIAG91A8bAVQDXAQnwLM+OfeV8fnYGuJDh9
 EgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/M2YMPDz3KpXeny3+2Pcgu/c9pUJWFDi6q63z/p+07w=;
 fh=McFpimHY6bIsIE5qOYgv8xLs+kIZjYvKN90K+mlCE3I=;
 b=iXdHASzCG7oyy6/RwVmHofUugt5cA7eSeUHhSLkXyIbOw7BNyimT3f7mPbruUhQHV8
 bb4bqWS6604btdqAHPqgo9r0RWBuiqgnq2tkJjdCoLqf6Q/bdEl1KmLY61jx/A7glDrJ
 41n/ykEy8IZj4sWVZJEonnSzW4apSm1DxFlhZudmIJXk9niP7MBvvAhx5iciGnADp/lL
 SC/F18LKGSm6Sm+3IjZaDA3flkYwaz6kq1mOoU5yq0wJ41OtToFUG8J/GtHeJOdKlw+F
 Iofm4LnWCJ9vtk2GIHOEpZKSeq5ZApfvGFIc5kePzBQ3ckNE6SfbMhvO2d/KNk2ThZRj
 FaxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=e-labworks-com.20251104.gappssmtp.com; s=20251104; t=1777139687; x=1777744487;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/M2YMPDz3KpXeny3+2Pcgu/c9pUJWFDi6q63z/p+07w=;
 b=iAe5St+KyfeESvNiO13khPfBTEAM69kmfp1rStg+Tbd9DuIbh7uTCKp0G5XKg4St7j
 ZVPcyQn5gWs185vl88NSBI8Z0feWgOPZueqmHEhFYZlZmJA1yfyFhbL5jEpeEaH+eUT6
 QymvKLERYyBKDEOgBll3OIFR/K263y/Rs9Qzvman93tmgA4b6qKUpgQ/qQe7wXDq2fb8
 cSr+Ry/QJvzaAXlPECEn1mhJny79sgTIcCnmPLng6M4n5A18SQyQTBiS+Nc37si0VuCd
 k0Tr94yrJjOBjgKLghhlR72I2L0OsPkQOYYra42ckMEE6BEDm2/tQGOAVCSImRHlCK4X
 lGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139687; x=1777744487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/M2YMPDz3KpXeny3+2Pcgu/c9pUJWFDi6q63z/p+07w=;
 b=qyx6YR56d8uNkzkvaIzpn07CKfRLwBPIhJDzyHYnHE+O5689x8WXQmeAPZYY+8/NqE
 ruBmqhLfDxMphZWC5AU1TsjvSWx6z86ch8XX0ZFxuuIAwMeKmtzsyWjvA58FV8uQBii1
 bcowNXfDtf6ZvdEJNWgRjMOXjCdbFjvJrbwcbPm7sdLw3gDhxThAAWfZTbdnGkjq8ImQ
 3p+BYiU8mhhrTF0sXMsnFeE/b4ycoWY4/jWmUTPB0MZ8bDZU/YCIQQW/paxahziNv1Cf
 cO3Ep0TwGoY/aIEIGPMW4mgjjXgIfPB7bDL/MGormAZWquW8SdtnRpnz/yFGxOJm4nX4
 nN2w==
X-Gm-Message-State: AOJu0Yw3w3UlI9GZOy1EouqhYKuQqBGTBEN7KFHLh5AI8EbBUJRqDoMA
 iEpJy3bFf9LYJWvPagRaHzxD1/6IhDnLRROXsImHquLyIPtesoTpqkL3A5hEkuIMiV1HDraXzJ8
 7I6Q+yop0XFFmMy8VmwIzBgAoSp0bBsFbIJwpy5xZHywowse4lqjUGujOEydS
X-Gm-Gg: AeBDieuafcUPwDeA/7C545Yfn/goebP5+uYZ18yFhYBoPxIhIV/uWWgR9lKwJ+4dNb1
 oOxCvGd2ZAd8OS0JtXBA724dTOOly9iLlkLK67/1aIWf7kiUAM/ve4x6Qa5xUbGnJOrxYQok/CN
 t65yPDGc6kBUbProWqqeYCOSUT6UszQ0i9sJZDXxgxRIifDcVdP6Ihx5b4wjM+Zz5QcIs/uiI6b
 gjq87CKeVY3+6epWr6ZGux7wrjONVi5z82UiwqWInxl/efLxJLcC5sRw2qesCzirpNC/5N2Ax0q
 dce7vmd6W6A0NDaHTbfO7DMYclBRAVLILqA8y0LzrVFmkGv8fg==
X-Received: by 2002:a05:7300:bc9a:b0:2d8:c521:c157 with SMTP id
 5a478bee46e88-2e478a2f0b7mr14117408eec.18.1776943016652; Thu, 23 Apr 2026
 04:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260421133646.2826728-1-sergio.prado@e-labworks.com>
 <CAFLszTivVH-DJCMY4BjywtWJqw6Ywt_Wt3wrFBZ_4m5vv7QK+w@mail.gmail.com>
In-Reply-To: <CAFLszTivVH-DJCMY4BjywtWJqw6Ywt_Wt3wrFBZ_4m5vv7QK+w@mail.gmail.com>
From: Sergio Prado <sergio.prado@e-labworks.com>
Date: Thu, 23 Apr 2026 08:16:40 -0300
X-Gm-Features: AQROBzAC9UOnikWjbB5ZqllkASnCv1H9o_d8yDwkpPgNLrSBrMw-8rS_uOgm4-w
Message-ID: <CANu7NGvD1xDBZw23cxxWDLCYiOVb=t6U-A=m5f1gRwGoim3Q+A@mail.gmail.com>
Subject: Re: [PATCH v2] binman: x509_cert: add PKCS#11/HSM signing support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, alpernebiyasak@gmail.com, 
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org, 
 sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com, bb@ti.com, 
 y.moog@phytec.de, afd@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

Thanks for reviewing,

Em ter., 21 de abr. de 2026 =C3=A0s 21:15, Simon Glass <sjg@chromium.org>
escreveu:
>
> Hi Sergio,
>
> On 2026-04-21T13:36:46, Sergio Prado <sergio.prado@e-labworks.com> wrote:
> > binman: x509_cert: add PKCS#11/HSM signing support
> >
> > Allow X509 certificates used for K3/TI secure boot to be signed via an
> > HSM using the PKCS#11 standard.

> > diff --git a/tools/binman/btool/openssl.py
b/tools/binman/btool/openssl.py
> > @@ -35,18 +36,83 @@ class Bintoolopenssl(bintool.Bintool):
> > +        if key_fname.startswith('pkcs11:'):
> > +            pin =3D os.environ.get('PKCS11_PIN')
> > +            if pin:
> > +                key_fname =3D f'{key_fname}?pin-value=3D{pin}'
>
> This assumes the URI has no existing query parameters. It might be
> worth using '&' instead of '?' if the URI already contains '?'

Good catch. Will do, and also add a test for this.

> > diff --git a/tools/binman/btool/openssl.py
b/tools/binman/btool/openssl.py
> > @@ -35,18 +36,83 @@ class Bintoolopenssl(bintool.Bintool):
> > +    def _run_cmd_pkcs11(self, pkcs11_module, *args):
> > +        if pkcs11_module:
> > +            os.environ['PKCS11_MODULE_PATH'] =3D pkcs11_module
> > +            os.environ['PKCS11_PROVIDER_MODULE'] =3D pkcs11_module
> > +        return self.run_cmd(*args)
>
> Setting os.environ directly pollutes the global environment. This
> could cause issues if binman signs multiple images with different
> module paths in a single run. It would be cleaner to pass the env to
> run_cmd() explicitly. What do you think?
> Also, the environment variables persist even if pkcs11_module is None
> on a subsequent call.

Makes sense. I will add an extra_env dict to run_cmd_result and run_cmd in
bintool.py to be merged into the subprocess environment for that invocation
only.

> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > @@ -6884,6 +6884,102 @@ fdt         fdtmap                Extract the
devicetree blob from the fdtmap
> > +    def testX509CertPkcs11(self):
> > +        """Test X509 certificate creation using a PKCS#11 URI instead
of a key file"""
> > +        PKCS11_URI =3D 'pkcs11:token=3Dtest;object=3Dmykey;type=3Dpriv=
ate'
> > +        PKCS11_MODULE =3D '/usr/lib/pkcs11/libsofthsm2.so'
> > +        original =3D bintool.Bintool.run_cmd
> > +
> > +        def fake_openssl(self_tool, *args, binary=3DFalse):
> > +            if self_tool.name !=3D 'openssl':
> > +                return original(self_tool, *args, binary=3Dbinary)
> > +            arg_list =3D list(args)
> > +            if arg_list =3D=3D ['list', '-providers']:
> > +                return 'pkcs11 provider'
> > +            if '-out' in arg_list:
> > +                tools.write_file(arg_list[arg_list.index('-out') + 1],
> > +                                 b'\x00' * 32)
> > +            return ''
>
> The test only confirms the code path runs without error. You could
> also add assertions that check the args contain '-provider pkcs11' and
> that PKCS11_URI is passed as the key argument.

Missed that. Thanks for pointing that out.

I will prepare and send v3.

Best regards,

Sergio Prado
