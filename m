Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FBC27C52
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 00:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA1F88428;
	Fri,  7 Jun 2024 02:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="affYx/JL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CDBB88176; Fri,  7 Jun 2024 02:38:25 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EEFF87E1D
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 02:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2508934c50aso765884fac.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717720701; x=1718325501; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/Kkt9NSWDQQNCxzqqpmO2RIKbr17sJhxZVrRnmGj7KI=;
 b=affYx/JLEZaRfG+KOwCwq3bP1SuFE1pBDil1k6SE9Zu4DYQam4SUS43wu9M5uwgNM9
 FObzMx9MCFpa9NLDLdXWPudbsvw1AyqtyMGUS7O+cl1vORzv3YicxgHWuhDr/nNJDPSL
 EHevATtbpj+klejLJsrUTT60VizJqOBA3IfG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717720701; x=1718325501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Kkt9NSWDQQNCxzqqpmO2RIKbr17sJhxZVrRnmGj7KI=;
 b=ezOfrMXbddLp8moj9JOScgIS0bNNrxJeeevKNxR0VmZEt6zMzaI+/ekNJGINmPZ8TO
 hSJnfVTTgCUBZX52l7aWAqjDu1nGtZesxp6CbI5k7SxvvF4jRhzoi4evUdUCHvqteKdj
 /OQKJTbj7KbMwu2EfZ1ZN0Pzma6kSM3w/oivcC/XuoJabI4B/Upn7bBls9//KINs0onp
 0pXqK4S1Q0zQ/vI/uznxT97Qw/Pw2Ut9kH26X8CULXUUjtrHtMy6Uxx9EeaMqbmwLxz+
 I0W9sp0/c3zCbY/zSsHpcJo30b+yuVQe+YUrpTTeKP/eUZ1W9akfK5IMGUYSuH7TXj4j
 8qTA==
X-Gm-Message-State: AOJu0YwHdzW+nFk2kbHb0uLurR1xNjoqgwasUU3baSc75pJdzZmYUyHA
 tXIlxMymIerQq95l3Fj+CWxjuHV9dZfsFtHc9CWD7DPzvQ69jJfXVJ/8MtXfFh4=
X-Google-Smtp-Source: AGHT+IEkAm1SznPjBu+FyVXXkhXOQUvOSmNi0Q86M6S+G6aH7xTlXGc8gvJkB8zK+kNTyaZgv0fdBA==
X-Received: by 2002:a05:6870:9125:b0:24f:d75b:6180 with SMTP id
 586e51a60fabf-254648079a3mr1146731fac.44.1717720701019; 
 Thu, 06 Jun 2024 17:38:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447ecc748sm630495fac.29.2024.06.06.17.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 17:38:20 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:38:18 -0600
From: Tom Rini <trini@konsulko.com>
To: pm88hpxmdxke@disengage.co
Cc: u-boot@lists.denx.de, support@glinet.biz, marketing@gl-inet.com,
 lwn@lwn.net
Subject: Re: Possible license violation
Message-ID: <20240607003818.GH68077@bill-the-cat>
References: <1869186491.466723.1717719348267@smtp2.opayq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QimlS/9u+NalhjvO"
Content-Disposition: inline
In-Reply-To: <1869186491.466723.1717719348267@smtp2.opayq.com>
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


--QimlS/9u+NalhjvO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 08:15:24PM -0400, pm88hpxmdxke@disengage.co wrote:
>=20
>        =20
>=20
>        =20
>             I think this is huge misunderstanding.They just don=E2=80=99t=
 want users to brick devices:After agent reply, no complaintshttps://forum.=
gl-inet.com/t/uboot-for-gl-mt3000-beryl-ax/41760/13Nice company, sorry for =
fuss>             HiI am copying this message to you and GL team.Regarding =
license violation:U-boot=E2=80=99s license requires Gl.iNet to provide the =
source-code for U-boot (including any modifications they made) to anybody t=
hat asks for it.=C2=A0So=E2=80=A6GL team refused to send source code nor .b=
in file. I wanted to inspect it for possible backdoors but still they are r=
efusing.=E2=80=9C If you choose to provide source through a written offer, =
then anybody who requests the source from you is entitled to receive it.If =
you commercially distribute binaries not accompanied with source code, the =
GPL says you must provide a written offer to distribute the source code lat=
er. When users non-commercially redistribute the binaries they received fro=
m you, they must pass along a copy of this written offer. This means that p=
eople who did not get the binaries directly from you can still receive copi=
es of the source code, along with the written offer.The reason we require t=
he offer to be valid for any third party is so that people who receive the =
binaries indirectly in that way can order the source code from you.=E2=80=
=9Dhttps://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.htmlhttps://git=
hub.com/u-boot/u-bootSo I am sending this message to you to check this situ=
ation. They probably will not send it to you.Also please use web mail (not =
business domain) as they can sent it to you through it to hide the fact of =
licensing violation. For example send request from Gmail.=C2=A0Please take =
measures.=C2=A0 It is certainly very disappointing to hear GL.iNET is not f=
ollowing the clear license terms of software they are using.  --  Tom =20

Ah, yes, I see the sources are available at:
https://github.com/gl-inet/uboot-for-qca95xx/tree/master/src

--=20
Tom

--QimlS/9u+NalhjvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZiVnYACgkQFHw5/5Y0
tyzq7Av/R5eF9j7EuDiAGNK06hVj+KMJlMi/USS1jSxaNTrS43UcrfXIp1MLhHgR
ty4VvQYoYL98sLukaFuUgL42+8yuRHvVqgOdJGFysWRtVRiUZsZ2RiEb8l1nrHGx
NfYDM+SfgHOzgQftn482x7uL9tNCCS0jhO5YqfDmsqSYRB820SqAITt1c73qxPhs
wId/C4JtYBCrkolRCm1UCV0fSnI0bZQqVXKVmiPuZWF2cSRAdzK1HDN99oLrWEtf
8vRKkADaFglZs1GyVCwJyuAj+636MtlEffYRc50qq4Wf8M22umfZo3TU+944L0O8
TJeqcwcaxfGUywRKVOsnAT8KQyNpl3tPkwULa1NTrND0W1PbmB7EU0brxRTTVvYR
BtxfwoX15NX0L4wYwhZR0ATYJrwPyS9PcZ2FmnZIzMGAzu+vgjWsLGzUbdxTF6JX
XVx6PQwx132qgrhCQ2cF/tXIcEPK4XmRhIN69ZwdPEgACtM+Lf6uol3VJ4VNIj3l
GhQ6yMI8
=xVpR
-----END PGP SIGNATURE-----

--QimlS/9u+NalhjvO--
