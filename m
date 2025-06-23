Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18573C77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 14:43:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74EDA82E05;
	Mon, 23 Jun 2025 16:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y/cEFzin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEAB682E25; Mon, 23 Jun 2025 16:43:15 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B185D82DA1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-40a4de175a3so2953345b6e.0
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750689792; x=1751294592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2tvNNyEM+EgDUccOf5+rE0YC2F5EnUjLWlGZRhd9Or8=;
 b=Y/cEFzinR0mDdKpc0VD6gv9wE+o77B8v4GwX/f2VuYfP2KJwPl1VNmB6joQfQbqwA4
 RUVyF8gFxEQnNYqi1nkGoteeoeFrEt24b0wntIU/PqXHgDDpDxz9ySlpmhNIkvgvCyw/
 jw7Kz4syyP2kcVIQAArqUd7dmApU9JipXHsR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750689792; x=1751294592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tvNNyEM+EgDUccOf5+rE0YC2F5EnUjLWlGZRhd9Or8=;
 b=EeYbg6WdZfXiQaMbJlQwl8rt6oXiFWXSt/BC6AXOy2vgaddojbESMkVvjrG7pcUhG5
 IPFElYUDYDJ045UL99//uz5y7hyRTaiad3nRr2HbLxk9DWaGFHq9HSJubvnB+Za98/oE
 pyKzRXkV9SBiDT3ML8+pCnlPqTpLQrovCPQOGDv5QQ4Vs1YY4uZ2ZnVIYDulqmeS3kuW
 AqirpGk52rYULET3OAXP7tDvOK/KIzLBK5ymbmc/D1kpx86YZ76sUB/p5zPOkvuVw6jk
 CxXY2FRrUw8v7NYS4Htf2ixBMWD4+EU4E4SCQi6zMc0C1P4HrM/agm/0h/LLQOukUq/3
 j5TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX65NjLfOM3ilHrRpUvXJxa8r9f9kw6rTeUH4VLqLKpz6iMm5CDt4qY/tvXWCa4Qo2gp0V7b9c=@lists.denx.de
X-Gm-Message-State: AOJu0YzQhu5FkD7X0SmksQiQ0lOdvWhcEpcotYbQd8k1iO6dii1ncLeu
 pmrL+lv8XiSaNt75gqSfVep4+OtG76QB4ee6IUeJV7brUDGkEs5nLowQ32fgxbEOUEc=
X-Gm-Gg: ASbGncstOWNEva9YbEtW/DGO9wPHcobt/j2163dBzJUYuP9Kx9F96kYMNkGQ/++OpNB
 pZQ89ZZlHENkYmTQSqBSROPYB0ggQpaLH6L7A/dXTGI9/sGEk3o/ojEG5CA3/FoffX3dQg12UvL
 0TeltYl6J9fsvDBotTAelpfAyaC1QnIxdVjCUdW6f0GARhnM/QjWFRHnrF5/TOhbFYvUoQM4u2R
 KLz3A3C1UJIoHmojk0BNIuWBAU4EQEnBxC2UOv/k+/ctCd0ivZkATX3lk2TnXnyLvquv6ViIxe+
 PFlAe1An3iuxgzQNQ2NJWnU6u3wrdfYD1U2Rc/5BKwRgM/9kfqfGwt31rBs4YXJBwTZyKLYxa+y
 qKXUQVY7i/bhd++Fv6B/4pN0A+6Vb+mPdUg==
X-Google-Smtp-Source: AGHT+IFo1DNV0SKGNb9Ssm8luZ1ENImmAClxD+h8PzbdNyL0laEfSP8LbKK+Rowe0a/BL0m/RiS0Jw==
X-Received: by 2002:a05:6808:2110:b0:409:373:bb32 with SMTP id
 5614622812f47-40ac6e2f6b8mr9299714b6e.0.1750689792362; 
 Mon, 23 Jun 2025 07:43:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90b1b83asm1445114a34.24.2025.06.23.07.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 07:43:11 -0700 (PDT)
Date: Mon, 23 Jun 2025 08:43:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 venkatesh.abbarapu@amd.com, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
Message-ID: <20250623144309.GB4003484@bill-the-cat>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-7-raymond.mao@linaro.org>
 <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
 <CAEfUkUL5L6YVbWtZrjitKuRPbs_3-=nr4i_1xtppi6CcXhhv1w@mail.gmail.com>
 <c6e4593f-fab1-417a-ac50-a4b0218793d3@amd.com>
 <CAEfUkUK5jhtFbYSF6m1grpwmd94+jhbq8v=7sVZAeHCs9yEUpQ@mail.gmail.com>
 <1dcdd0c7-0160-4790-b7a9-ee01d6531100@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sJzd58+CTN+pg9iC"
Content-Disposition: inline
In-Reply-To: <1dcdd0c7-0160-4790-b7a9-ee01d6531100@amd.com>
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


--sJzd58+CTN+pg9iC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:58:04AM +0200, Michal Simek wrote:
> Hi Raymond,
>=20
> > > > > Isn't it also worth to check if existing CONTROL_FDT has enough s=
pace inside
> > > > > that new overlay can fit there before resizing it?
> > > > By default each entry only contains the actual size since bloblist
> > > > (aka transfer list) is designed as a compact data structure and the=
re
> > > > should not be a waiver for CONTROL_FDT to carry additional spare
> > > > spaces.
> > >=20
> > > Right but you can build dtb via dtc -S/-p to add additional padding. =
It means
> > > dtb will be bigger which goes to TL and should be possible to fit ove=
rlay there.
> > >=20
> > Yes, a developer knows exactly how big the merged DT should be...but
> > it is only DT specific and not a common case for applying other blob
> > data.
> > Maybe I can add a DT Kconfig for skipping resizing for the use case
> > you mentioned if all reviewers agree.
>=20
> What I am saying is free space calculation should start with looking at f=
ree
> space in base DTB. If it is enough (with pad) do nothing. If there is not
> enough space then call your code.

And we can configure free space at our build time now too.

--=20
Tom

--sJzd58+CTN+pg9iC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhZZ/kACgkQFHw5/5Y0
tywYxQv/Q6lGf/A+3KbZJZ99AFmjESP3RfZ8FmbLRnLDpC1bxwUk7OasAv58S5sX
slNdeK+54taUdU2uS4En972Ns3YFm1vA5iOhLkuxDbzjPADznLDPSjqNMxAxJmwd
C1FtLMHXQR7y9e9C+5i28zF8BgGaDN+GFkJx1O8OpjontLlIJizah454Taz6UaNM
xTKzmxhJhEWCgCGNKEF7hpcCRnnWRO9upg8QB2haAuM6ALeCoBZee7UwOI+/b7+q
QMuUur90ymfzI8XGakPuiJdFfYhD5EGL+b4gN6t8MalsHABZMhnuGx9E64IWNkes
l5tBWqu+BwysZBUzJubPkh6kl4d+LYeHlko+ys7hifeQaHixFFraJQeM4ZMH7a+S
/ZRSMnxf6AtHuhJJxQ5qVJjSGCPfn+R0fIOP4fAr0aC90ROsRAlZemWIq9VudjTq
TEf2pUWdIJkWygIAptnIfgS+kRi6bGI+QvnRwYQTB3rPECbxrwDnceJ80p5zn3tu
yusFdcg1
=vuqO
-----END PGP SIGNATURE-----

--sJzd58+CTN+pg9iC--
