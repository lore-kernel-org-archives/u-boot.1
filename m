Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A83FC6170
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 18:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B86088DDC;
	Fri, 13 Sep 2024 20:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gav3Hcxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7609E88DDC; Fri, 13 Sep 2024 20:27:48 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED64E88DD9
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 20:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7a9ab721058so315113585a.1
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726252065; x=1726856865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nc9ipNcf+GFXINqUOtpfj+9lLHUAu7S0gwC3bKK9uKM=;
 b=Gav3HcxfVs2W+RpqafPdKwOEe8tAFe92oeEuowyZVZCOPLEMsKzuapGbJrj0HZs2fi
 zRLivfPcXFm7NgKnFYvrh372TH53V3rG8JHlEeOe+UHGkqorYfENjkKClLaPK73ayj0u
 63ScdcchQU4QM6HAczG75jbW5en1kC0lvL23M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726252065; x=1726856865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nc9ipNcf+GFXINqUOtpfj+9lLHUAu7S0gwC3bKK9uKM=;
 b=puRP1fvwhQt9Z1JqUkEf6U+tz+47a9RxN/f0I4eSYuHh+QH3G7zBwpVwduz431xqd3
 Qn9iyVHS5ADdYqFSs3VoSnxyMnDAED4/jOV36yvmGTZkKyW9zQ788bj+hDoR2VQFpfob
 DRqKzFqRqkJt4A7RTMz923O6kcuEvQ633c+o7OUgyPjaxSx6laXs5vPQuQIlqDMdSYAL
 cyuH+bnWWxb+Nl0dk8OomdGINbJRWOgE7err6rb5Q9SucMLeJlnDlQ32MFkWcnX7C2Ui
 3NS2eqoknvAaDRUJi/JNjqsrRsNqpLxDLGrelYpfR58MIpNieY9DxpCMBqeg2FTQlnor
 F7/w==
X-Gm-Message-State: AOJu0Yy4rtEAQtdyC2S3X8Yl4QiuJY4/8sCISabm4l0sASLieKkMQha7
 S3A70Lyy8QbglLyPxWUCy+T5ceq5QneAb6EDxhvjzoGGuSAHArBsiYffwL8LgfQ=
X-Google-Smtp-Source: AGHT+IE3qWckqCylHAWmYFKwQpRn9cciQecqDEchAb5PRpfGhXHscDv+4y0r9OZ8XtWXL1CoaAYQyQ==
X-Received: by 2002:a05:6214:450f:b0:6c5:5095:3f02 with SMTP id
 6a1803df08f44-6c573aab98bmr136888046d6.1.1726252064722; 
 Fri, 13 Sep 2024 11:27:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53477c9c2sm70618516d6.130.2024.09.13.11.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 11:27:44 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:27:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [NEXT] Pull request efi-next-20241024
Message-ID: <20240913182741.GY4252@bill-the-cat>
References: <a472f57d-a67b-4590-8b4c-334e998e992e@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="r7v4eZtmxwJv20FA"
Content-Disposition: inline
In-Reply-To: <a472f57d-a67b-4590-8b4c-334e998e992e@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--r7v4eZtmxwJv20FA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 03:48:11PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 78d898eec080b02059c8dc09318b8761044fea=
85:
>=20
>   Merge patch series "phycore-am62/4: Add more boot sources"
> (2024-09-10 14:56:12 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-next-20241024
>=20
> for you to fetch changes up to 7de51622a2cf901e888d703a7bea33ad16645d3b:
>=20
>   efi_loader: Put back copyright message (2024-09-12 17:36:27 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22326
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--r7v4eZtmxwJv20FA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbkhB0ACgkQFHw5/5Y0
tyxdcwv/W0TTHg0eeWkosrXo8YWUgPHmQX695EZBEzHQ4/WGsyVJ8NcQMw7W3B+y
KQozJpKrIurrMOgRsh/OTz5fJqXFLQzbWjgpRc+igFnDzZxizIYk+fvcFw7wPN1g
VR6e+MPIGJisIoUhtf/36HjJiTTXZspZ3JYUGLr/OcylLZzIq+WR/o4fHaEluVgg
00DjGjbFf1vQJ/Xi8XDLTf4jlUYcH6RivzCnzmRNrygnG9JzR6SvPQggiDzFBU64
9b7tfUq/XlRS1KuDLHqIH9xxml+GTLZtgENQnuiKgwUNwXNszXQ5Hv+kURT2oP2j
3ev00UbQv7z0AbrBXp7v/N5j2x3ML0rwHQtUkmmtzQ97q0E5MttZ+iVLNajJJ0Qf
do0bETyGcXD+Z5md19HITxyT8vupTFrXEPeVi7HYJwClzzylO+LLl5uK1z+PQ7hM
mCgPjIEHo3Rcv/3GeRjqNZ2voAjnd11pcfgHLlQnD/M5PoXBVfcfU8gEOPeo8dIl
NN5v0+0e
=wiWq
-----END PGP SIGNATURE-----

--r7v4eZtmxwJv20FA--
