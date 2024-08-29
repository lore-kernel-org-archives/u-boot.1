Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D50C87FC3
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 16:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F96688CA1;
	Thu, 29 Aug 2024 18:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KuEr76I+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E814888CD9; Thu, 29 Aug 2024 18:59:12 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9CE88950
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf6beda038so5148926d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724950750; x=1725555550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v8b1T5OYHtwqovIG+9WKkGxpH9tbL7WCtSSdQBzi3Po=;
 b=KuEr76I+1zh8m5veUZvmqt09t6BazAc6rw52KBQDvBuIpDzf5qg2GVGuxNdfU97kdG
 /6K3RQeTNIBBSF6YBr5T22FcfEKNlIXL8FrUDA9dOeT9J6BUXDHfYWdcVDhTcErzq+A3
 Ue9FAFKPBtZ7FhQLc49XzhCH0/YSIwi77OOtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950750; x=1725555550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v8b1T5OYHtwqovIG+9WKkGxpH9tbL7WCtSSdQBzi3Po=;
 b=IDWY+DSpsrvHKxrAICjBLOk4DfI2/ctwphEmdkVSOp5FEV+1qvRFD3+YQzZ4xakguA
 fh1vBU0/lHB3gh/UjxI6z04z1AmLf9tGTwUvpmnGJqbkhDq5gtoH0qR9tENeZNn+yPDO
 66x1klTb3UP5uZ9gsQOYE0iPCQDTsg99uQJAgXdvdncijb4n21KsgxD6n4dTdmZLxZkb
 f2i4BXxTtiG/ShbeqeUxNg9up2PjnBcP74WtfJay7UcPY+NJHRYk4L1ikdNyJwM6clch
 i2JEaEMSTF3JOH4u++y1XKtH8Kiu19jcAqKhJP1iUTTtPOEOyCZgWYYScyQlT8KMKxkr
 ZMGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKSSPo05BGsigAtcr7zXmH/ZCLxtBs/er4ecNLA1fUFIuKcXENa40hTPCyyAKeZkoTp7zZqe8=@lists.denx.de
X-Gm-Message-State: AOJu0YwY1pN6lPY6wwjO85iLWbEjnqzSS5+EQWAx2U/PfyrHIKNmrEXP
 //jyGl8tlhSTZS7PdWWJ/czyURP4yhYJFC5Ra26grkFL2ZshKORJQv1M+x6wHJDelmWMOlu4Qtj
 2
X-Google-Smtp-Source: AGHT+IFK3c/aB/wUBizabEBU56e2+JEJmkAHS9QPkpM1vlKOgTVeVASvEoTVvXLtv3RTv0o6v5RXZA==
X-Received: by 2002:a05:6214:4906:b0:6c3:3de5:c70a with SMTP id
 6a1803df08f44-6c33e5e830bmr42723116d6.9.1724950749532; 
 Thu, 29 Aug 2024 09:59:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340cae4d7sm6771866d6.124.2024.08.29.09.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 09:59:08 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:59:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
Message-ID: <20240829165906.GG2479150@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7F9CHbtUhXyf5Wm1"
Content-Disposition: inline
In-Reply-To: <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
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


--7F9CHbtUhXyf5Wm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> Hi Neil,
>=20
> On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> >
> > On 29/08/2024 00:08, Simon Glass wrote:
> > > Send the Labgrid quit characters to ask it to exit gracefully. This
> > > typically allows it to power off the board being used.
> >
> > Sending those characters every time could collide with other CI systems,
> > I don't think it's a good idea.
>=20
> What systems are you thinking about and what sort of collision would occu=
r?
>=20
> What do you suggest instead?

Why do we need this at all? Did I miss where we send picocom the
disconnect nicely key-combination?

--=20
Tom

--7F9CHbtUhXyf5Wm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQqNMACgkQFHw5/5Y0
tyxuEwv/Th5G/JEaG3lXaDuAqMvyGgUxrS0EmkrwSsNe3KXeQeyVfQBZO342ZdFE
fN+BRlqS1bq2wbLzu+RaekeljJbHA5TkRgDNXvsx2e8EKaXASnSEbXxDrgPYDSSy
i0xspNJZ8RlDX2+Vezz84dLFhiTadRYvfzJpTvWztwu0RdV4XA3dDw6K1gvZ2EbE
diMSGLo7jmJ33D8fburC2J5zWhA7kefm5PUYglwx5FuJaz/Meo4v122RlHueSP6Z
y2946U5MrmrOFRWR5/G9o7rrRxCu4PlZDZ35Jl24Zn3H1eEpVE6baKzDTw2QkUTe
Of9c7R/JuYQd4Z4FeN0GKNSDuLwuJDoTrXylpWQQt2D2Q8fQvL17VYSbl9q5xVEI
RHYbNdK7FWQ3/YMKlNuwX2J56XruGzZ7K36b+4K+sWvh/WC8FuXekrGsvrJgTKmd
OCEKGXJQJWNqmHs3Xsc04JkcnuF+bAPZqQ49SZuOSL2sTdIYXMijvRWJdCRzUyRc
4aIhm7QS
=94Nm
-----END PGP SIGNATURE-----

--7F9CHbtUhXyf5Wm1--
