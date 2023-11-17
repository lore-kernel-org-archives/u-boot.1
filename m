Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4EDC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0899874D0;
	Fri, 17 Nov 2023 20:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JopyHz78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E06C4874BA; Fri, 17 Nov 2023 20:42:21 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB0887446
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7788f513872so138263185a.1
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250131; x=1700854931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=leE1R3fCuh81oiT1OISrnOc15vg7EwTUYKGSl7c53RQ=;
 b=JopyHz78EhL35xbRZNmWLfVIyOQLBioIwsvVBYbQl0vYMRmYtJ47RPgyyyrYiNcozt
 X/MEy4vxgYRZNhZOzHBqKu0gbfxaklEjy0/anqZeJV9ou9pnrq6fQuFvTrtl2ryPH8vj
 xvq4tneHkAAMqgRvKGrFZ7pClix1q7XkMEiBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250131; x=1700854931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leE1R3fCuh81oiT1OISrnOc15vg7EwTUYKGSl7c53RQ=;
 b=Myb2z4mS8ZuBZCebLs1F3myax2Mtjz8Esf3RJblLiNrfAVDhcUAowdygiZsZEFM7uU
 svSj5aAuNFuL813KsdwMWkNSXRY86Qu5fKTTZP8CJf4rB3d3wUO5pjjhnXhk8Vx4+fej
 CaHYPDdrAZ4P9MYxfGZ4ZRunxTB28VMSNrRQMlReKigw2G45ODq5nAQQxbpd27OxbRlD
 UgDCWMQqRkm1N8pt3U8+ryuHEtLBPiGiCsW2VvborLa5WoX3ZF5bIEb7+7aLooI3D6II
 wGx63q2X9dn2MPRSxQX7SbiTMuXait20xJzryGL8FL1aPXO/Pd3YD1Rpog8ZMbgNSwpn
 NlAA==
X-Gm-Message-State: AOJu0Yw+gFVCI4qt6YTrYkQDMIXLLHQ/uLVMYGL3IROJCKLxx/t1YHT/
 YhlkFbDmngj1wHeuO0wBXaXAsr2Aa4Kopa33nTH8cA==
X-Google-Smtp-Source: AGHT+IGU4KOVq9F8uVrKuM26nz56G8iKUF3fbjqRYSamGgYjCnXxDGtVKU/TP1LEzxB9t1Fyhj7hyA==
X-Received: by 2002:a05:6214:4109:b0:671:7312:bf5 with SMTP id
 kc9-20020a056214410900b0067173120bf5mr84205qvb.17.1700250131670; 
 Fri, 17 Nov 2023 11:42:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 m16-20020ad44490000000b0065af366bdc1sm843058qvt.103.2023.11.17.11.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:11 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Chris Packham <judge.packham@gmail.com>
Cc: u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Will Deacon <willdeacon@google.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: Re: [PATCH 1/3] Revert "armv8: enable HAFDBS for other ELx when
 FEAT_HAFDBS is present"
Message-ID: <20231117194209.GU170968@bill-the-cat>
References: <20231027002409.430285-1-judge.packham@gmail.com>
 <20231027002409.430285-2-judge.packham@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VxncX7QtUb5/+tn4"
Content-Disposition: inline
In-Reply-To: <20231027002409.430285-2-judge.packham@gmail.com>
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


--VxncX7QtUb5/+tn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 01:23:52PM +1300, Chris Packham wrote:

> This reverts commit c1da6fdb5c239b432440721772d993e63cfdeb20. This is
> part of a series trying to make use of the arm64 hardware features for
> tracking dirty pages. Unfortunately this series causes problems for the
> AC5/AC5X SoCs. Having exhausted other options the consensus seems to be
> reverting this series is the best course of action.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--VxncX7QtUb5/+tn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwhEACgkQFHw5/5Y0
tyxMTAv+L5De/cmLoW/ppbMW6mttF/gK0qml0CpdCxd58Q9C/6i8DXSI0jOioT4s
DjByNJSZgp0RbAEuTkS6rZ2RuuFlhM3lFD7bJK4cvZwWxfajrLRTK+XiuXAzkQ36
76Ltzc52qGdgQBN7lnbqyoewdlPbHiCeaNMK+NBKVbq0Z7xqUMh+7ekd1iq4iVDM
/eiQIjvDKeH/Qmvi/Yq/sHskzZHptsuy3Ke10/t8e2tqSXCfrzcbA6/hCfwtIMrR
eTT1Js0up7EqRFgXbhx5bpLglDzVw2vsjSpF9DrPPav71JLQ8GBgvgsO2e+OxEzw
hF2P+33azPWKs4PCRKhtrflz0mUsSJuFFEfW2hLZ7JLGRQBHnVgDLQO5TS/Gx90E
HjGHlHMQJfazjk6ck1fI3FSNEa3d7KB2ZdPBXXxeluFeV/gSelYX9woe0yv6srvz
Qaj9nm23zPK0VxGEhHFbW27BR4Rg3XsNrvc4CzkkKjJAvxEYf2cLhYbBxhuUUtfM
+XmvT0kA
=O8f0
-----END PGP SIGNATURE-----

--VxncX7QtUb5/+tn4--
