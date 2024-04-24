Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEB9C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 00:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F0FA88D25;
	Wed, 24 Apr 2024 02:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sa/D4VHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CF288D26; Wed, 24 Apr 2024 02:58:10 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7A988D1D
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso36272461cf.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 17:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713920287; x=1714525087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WTqBVia6T+OPlZ/gIjyI5+1VQUhSd9u2Zzm8gv6au4k=;
 b=sa/D4VHEgE3Vp6TtPTOUkvxBKlj5/AvhymYZYAlCyEila8q/UchnF8ahCl5U75Eorc
 bxOWVrKZ3T01jjqw7QCXhJeeJZfz3Nwc4g+ddGh+NFDE7w8YNiZF4nMMdwXkJDR1t3lR
 t/YMuLn27Uy3DDsDQtceJ4Png/35SaoMWxf08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713920287; x=1714525087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTqBVia6T+OPlZ/gIjyI5+1VQUhSd9u2Zzm8gv6au4k=;
 b=HlZ/Tm0U7A95MZAHANwa8nF9hZqIwtIhgDtZaCzjgLr7vI0VFNGjRMq+aVOyDGKtPe
 lqdshXjzYql7SugT+yQc4KnykwYmSJKndPClwuN9+Us7fkhCrwyCKPjyF2IVcLWUDW5B
 6HP8P6g/flTqEQjP7TioFglCcek4yX8DJ3sRMl0UN+Vs+Fz7zHc49R58nTgRuORkwH6D
 hCHDymEBw0IdPS2U08tJK04wtL5sh32n3XKXugQNPWbJxtQLNXK4N/T7i7ASgX1hHEXp
 V6GcUmj0lKpZXmQRqPNSQI2h61QD/W+H1AAOr4dQdOM1RlWCJncpsONU2imelDJu//D0
 t5yA==
X-Gm-Message-State: AOJu0YwU2AV7u6e41HME0uKoW9zesDuNHwcOa6jwBeTE+9b1++efdQtq
 wxIQYTLnpVy26iNpYIhAMJmeLWvKgBs5ocAavzCp3yimK4td4rcS0tn+zJM9n0k=
X-Google-Smtp-Source: AGHT+IE6Q2YQSyoXnEHXt5Zi5jjFLdpe0u+bGVGSMTCW44NGmE7AJ8chnY+datZrj9i+opPCIOALcQ==
X-Received: by 2002:a05:622a:188a:b0:439:b456:14b with SMTP id
 v10-20020a05622a188a00b00439b456014bmr1070614qtc.47.1713920286959; 
 Tue, 23 Apr 2024 17:58:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 ic10-20020a05622a68ca00b00436510ddc5esm5642473qtb.34.2024.04.23.17.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 17:58:06 -0700 (PDT)
Date: Tue, 23 Apr 2024 18:58:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michael Walle <michael@walle.cc>
Subject: Re: [GIT PULL] please pull fsl-qoriq-2024-4-24
Message-ID: <20240424005802.GA1054907@bill-the-cat>
References: <DU0PR04MB9417C878C2E50F0425AEA54A88112@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3xFNsEv4JuCwo4xV"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417C878C2E50F0425AEA54A88112@DU0PR04MB9417.eurprd04.prod.outlook.com>
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


--3xFNsEv4JuCwo4xV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:34:08PM +0000, Peng Fan wrote:

> Hi Tom,
>=20
> Please pull fsl-qoriq-2024-4-24
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--3xFNsEv4JuCwo4xV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYoWRQACgkQFHw5/5Y0
tyyGpAv/dzblz63vIevji/o8Wvt0ypDOtLg/OXp9g9tz5Yd8HwYf1oji96rDjvhj
CbXCgRKz8CuYW8ZgXlQi9XSaQGYMEErCMdZtY4HVYKqT+IML+bKWPYD/rT1i2Xbh
xGU1SdANGNZdzkKS9ugFwH/3C51yzTDvkS9BJKwnbSIZB65R3JBNgiNEQ2QOFBL7
/u7L4sZI0KnGxso1/pGw6GuWaBL0G1N0Yxu/slAnvc+2Yji3hHUJplSH50C1e9wJ
dIbw3XHzW5A08iQ2YEgdh0wvJOmfQf8qTYE5PeBuBE8j98Jh288scOCpyVJ0gtBD
sPCmfsdgdkdbEERY8jerkirN3QZlpl/63NmmHpLWI7nI0mljgWMxh+7H0Y3Wlgue
cSq5LCmBFc7G1RjWztI8rEuTF22vKdMzChxBsdkDDnIVkSKno1hoBMYQXD+WsPW7
9YbR5jwxTyBlx4Sw4QlG/VKz+BIcqZ8RLmqMMpnctsgUTM7oAXVEyIsbr0TH7568
jiTJH81b
=EouN
-----END PGP SIGNATURE-----

--3xFNsEv4JuCwo4xV--
