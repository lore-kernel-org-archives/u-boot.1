Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85422C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 23:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02EA588009;
	Fri,  7 Jun 2024 01:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VnqOU8Yz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AEE8880F4; Fri,  7 Jun 2024 01:53:11 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2776C88001
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 01:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d2128a5aefso40348b6e.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717717988; x=1718322788; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xph5HcQfgAr+M2UD853V8+pieh54waOq1cqaA8Zh/Yw=;
 b=VnqOU8YzIEAuvwTPaPq35O01wHGEsDYsHZAenluhjyHT8heFve8wSEa5uhwSH6uQKN
 njFCvh+R75ezeTLyfVbYO+axdn+7CsoIAa3FdVhwMUFvC5scUSWyf+f7u3dz8aPGSxwW
 LaTZNHi7/irag+Trvd454KhqYiVzixFzGoGhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717717988; x=1718322788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xph5HcQfgAr+M2UD853V8+pieh54waOq1cqaA8Zh/Yw=;
 b=vdjbbxmGoIAF2HMB9l1hjWBFskDuhdC8YNNj6jfVUKqR1B3coBXxV3Ri//vETw+e1r
 rpJ5Hwnn5y9wpSdR+iLk7hWivtQhSpdJkkkZSkmi2qTZg2GrwXxwwAOveWJC3za0y33a
 92ZInUNggDn9lk3RMFZOW/VoAWspaoQzZddwl/nt33YhtpbVsv5/gii8h4nmWTv+rZmf
 IY5P5yv5rdzwweByUOmr/Nx0B/N2mVJDKaV+8OUA/2jodPbj99TlqsDqaXgi+UysYCKZ
 RN1iPz+9C+L/l5ttaSrAYyrtwTQHsKFyeiEUKijSGi9cXNcgdO5U16dZSyK7i/dIixxr
 pUnw==
X-Gm-Message-State: AOJu0YzCXxFPHvO3DTadoYKV+7ZSX+Di2yBu737DlXeK0sTWNH1NnLnw
 e3d264yKHO2GNU6MQpqV7HD60+C4T10nsSqHjgkt8EkfdFskfQc9Cw0HAz4VwJk=
X-Google-Smtp-Source: AGHT+IHfnu/pgJvpEj9EQXtVzogODS9oH7p2ekE8/E4Zx5zkSBSyJbMBZpyoHYUb+G6rOny1RSR74Q==
X-Received: by 2002:a05:6808:1596:b0:3d1:d36b:379e with SMTP id
 5614622812f47-3d209c4aabamr1936302b6e.26.1717717987657; 
 Thu, 06 Jun 2024 16:53:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b6aa842sm448611b6e.34.2024.06.06.16.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 16:53:07 -0700 (PDT)
Date: Thu, 6 Jun 2024 17:53:04 -0600
From: Tom Rini <trini@konsulko.com>
To: pm88hpxmdxke@disengage.co
Cc: u-boot@lists.denx.de, support@glinet.biz, marketing@gl-inet.com,
 lwn@lwn.net
Subject: Re: Possible license violation
Message-ID: <20240606235304.GE68077@bill-the-cat>
References: <987500512.386867.1717541262207@smtp3.opayq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nU4ryAeNPbbjMXdp"
Content-Disposition: inline
In-Reply-To: <987500512.386867.1717541262207@smtp3.opayq.com>
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


--nU4ryAeNPbbjMXdp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 06:47:18PM -0400, pm88hpxmdxke@disengage.co wrote:

>             HiI am copying this message to you and GL team.Regarding lice=
nse violation:U-boot=E2=80=99s license requires Gl.iNet to provide the sour=
ce-code for U-boot (including any modifications they made) to anybody that =
asks for it.=C2=A0So=E2=80=A6GL team refused to send source code nor .bin f=
ile. I wanted to inspect it for possible backdoors but still they are refus=
ing.=E2=80=9C If you choose to provide source through a written offer, then=
 anybody who requests the source from you is entitled to receive it.If you =
commercially distribute binaries not accompanied with source code, the GPL =
says you must provide a written offer to distribute the source code later. =
When users non-commercially redistribute the binaries they received from yo=
u, they must pass along a copy of this written offer. This means that peopl=
e who did not get the binaries directly from you can still receive copies o=
f the source code, along with the written offer.The reason we require the o=
ffer to be valid for any third party is so that people who receive the bina=
ries indirectly in that way can order the source code from you.=E2=80=9Dhtt=
ps://www.gnu.org/licenses/old-licenses/gpl-2.0-faq.en.htmlhttps://github.co=
m/u-boot/u-bootSo I am sending this message to you to check this situation.=
 They probably will not send it to you.Also please use web mail (not busine=
ss domain) as they can sent it to you through it to hide the fact of licens=
ing violation. For example send request from Gmail.=C2=A0Please take measur=
es. =20

It is certainly very disappointing to hear GL.iNET is not following the
clear license terms of software they are using.

--=20
Tom

--nU4ryAeNPbbjMXdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZiS90ACgkQFHw5/5Y0
tyz2bwwArfn9TPI+NO2r/GSY5HcFUWYAcFvdZWJPsuE0D8SRGBd2/J6RpiAivFbA
3Nkeo+xtNnVLIYxnai6KYGt9SVpZh9GfzOzf+T4WMQO1g80AFmdUVgF1ZA+9DUvc
1fjJY2C4anML+iK0oJFVOR3JYRnbbng54n0G0mge8lUPRe2Q1U23Q6TgxxsrGg49
cNnl/JIDc3CaPkq/VB+OpFfV12f7ipuZSzxUg1KXSF6bC7URqmWAEtt8cN15UwgU
LA1/kJqleDS5bLcHqQg6FrJmv2yYa5Ig9dCYYtrtMtN5MEJUEnrW2IBx3Paw6GDG
TopHcuoivQJXhJIcjETXNGrWlew4J5JuTEfv/A1+nwnVGCpVErbvhKZYgJx+KMnK
Nvf3nKfyeW0GLSnaYFNodpBqXNcCjoma/XasuUYK+WpTTfKZTcKk10cf1lP3WNgU
pj6BSPYbqaboaHfobAt/mhs5JlqsdJ0N+f1A91IRIGVAlKdsGDTmhjJ3273yWsIC
qPfq2jiI
=88kr
-----END PGP SIGNATURE-----

--nU4ryAeNPbbjMXdp--
