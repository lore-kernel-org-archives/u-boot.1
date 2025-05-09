Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205F8C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 14:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4857382905;
	Fri,  9 May 2025 16:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cHfs/AkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A82C82935; Fri,  9 May 2025 16:37:26 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125FC8283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 16:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72fffa03ac6so1694165a34.3
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746801443; x=1747406243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yltqQ/My5bbfv28EME8VbYCmrujCJostKkItlacnT5g=;
 b=cHfs/AkCht36i19/FmAVwMvXCcVXp6QSb0dhakfteoLMp/mziWZ2JYVZk78hFUidW5
 2Qd7uAT+lAx29MR5xOGDjIbAQ/QZd3SuxZiU+3gj/KCkoBujIrhcblHG6qgXQNrPZOx3
 h6CYAnDYAVrAzYyinhLXc6eK2I+kx4gQ6NVk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746801443; x=1747406243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yltqQ/My5bbfv28EME8VbYCmrujCJostKkItlacnT5g=;
 b=eXYL5+AJmyw8e26NTAPfjs9hDMw1CyuPUBK+uJSW9Wel6ZUTX1169rDK0zWxQrsI2I
 ii8lsP/C3rVleIbI5MD7LXh9fqCpB9PqZMSU6BcGjF4Eh5Q0vaeywFuyH5kAO6cRcXAM
 /h7HeHI/FhrU+gHIYWAUXmhCnIvvyiXaGPgMXTel/38jwQKi5hX8y+peauul7A/gMqyt
 g0933uiPE+OLqKdQvRxdcHkN/jlDszXRyR8UJUVikP3611lXnoLCgdNduF/RJI5L0rkd
 rUu2a9jjPpZUsFFFTX8rhqw3A/hPgRze6dWwsC7O61027oqIY7sOhwl2ulbm2h41CVZw
 +CRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaSw8+31N5U6tDbd9PfIlyV8yMAu8V/IE9OzpOLLPXkS3XjOrcHfuyXVoHH7tRrXxyQjFWjOc=@lists.denx.de
X-Gm-Message-State: AOJu0YxIO5+isweZdLBkJQoR7EG7S9tXlf5hf0CO/JYnXrV0F5C6xfqQ
 tNcizV74DxxuJwOEWp5/kYsEDYkwo2rT2+PKcA+x3KM0K8S2E4dj7KML5sa2Zvo=
X-Gm-Gg: ASbGnctf+JRF8nAGi3AfLK/xoz3+jH/gq4ZhRnAbD8aDMAV6T/yOY5t7W/sg1hJrR15
 ba9hDJ9WoGZ2YIrIG6eDUm8DcZ0gHAVKFQ+VaysXmg0N3wOW+gVR+RNTyLvLx7DlzkTmkXkP2Dq
 TkaCGinLkhy4ceXoIX4hTVxDxdVNtiA1O9RQU4VrkFJVMMExws9kDIlQ7pP7SC5yDWwzoHKbtLZ
 QF4o23NdaeTGZA4zcDH1vsuaLmEWlRPPwL3LnuPCA70+3MOEJjWkUtsyYqHjfUjPXFGisrkG6qk
 Omy+imSmjXVW0eCJ5OE8z9nM5PR8coDJs8XBo629DUCd90A9ecjeL7MUFCWLh9d1xgejvaIBcea
 /vw==
X-Google-Smtp-Source: AGHT+IH1eeqyp/7reK+E45SDJW2l83mBm3PuZOICwdPfM0GDwBcdPW2Enel9Nn6YaDhpgRoAPB3/jA==
X-Received: by 2002:a05:6830:6017:b0:72c:320b:fc8c with SMTP id
 46e09a7af769-73226ab0a0dmr3259208a34.21.1746801442772; 
 Fri, 09 May 2025 07:37:22 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-732265cd9a9sm548681a34.53.2025.05.09.07.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 07:37:21 -0700 (PDT)
Date: Fri, 9 May 2025 08:37:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 1/1] x86: cpu: Describe board final hooks in the header
Message-ID: <20250509143719.GG603748@bill-the-cat>
References: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
 <CAFLszTgmcg+EdhDjiuSgtYR1kwgsTwEBvhC+LZNqB9ypx8ev7w@mail.gmail.com>
 <aB36rz9tajyRZEzh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6CrN1aG+sIJ77bqI"
Content-Disposition: inline
In-Reply-To: <aB36rz9tajyRZEzh@smile.fi.intel.com>
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


--6CrN1aG+sIJ77bqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 03:53:03PM +0300, Andy Shevchenko wrote:
> On Sat, Oct 19, 2024 at 05:51:00AM -0600, Simon Glass wrote:
> > On Fri, 18 Oct 2024 at 09:56, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The new two declarations board_final_init() and board_final_cleanup()
> > > need a description. Add it here.
> > >
> > > Suggested-by: Simon Glass <sjg@chromium.org>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  arch/x86/include/asm/cpu.h | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> What's the status of this?

I haven't heard from Bin in a while, so I guess I should go and pickup
the outstanding patches. Thanks for the reminder.

--=20
Tom

--6CrN1aG+sIJ77bqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgeExsACgkQFHw5/5Y0
tyw3ggv/SonM429AIy7e9HUyq7/8daa8LFX3aSLUnqUX1Cz1lgWbysny34Po/s7f
vvBqA8DIGfP/2/TVAyIA/UAEdoWiNIa0T5xn41UYrWeO5A44Fw+k+QUK5nsgBvii
Nq4acbx0jq4JCxZ/8/pmJZRy9e9Z2lSdoX3WHhVxbmUHTkRp7VdaW0klIjwwfnx1
wG4Y05TDHtM5cy0XXsqgzUqBHUAZAmQXCBs/jQyTrw2IVH2tPUSX+4o/b4SQ+N8U
MJ8ADSrGG+9Yq6v2GEt6eukCcW6hZPQ4htSFK77vInEhjCWU+QUg1jHuIUMDJ76v
elgJlPo/UuZYTONICHvxft9CEUXoiwknp5CJ0ejnT51u//OGpw5sId+stdrsVNAy
dAzDaLZDdNzAo2+6M8QVW3boiVprnkGtiIHZmuYFPBpE0W72aR2uJc2kg4eCFQNS
0C+QKbBwwrIMS/NFADFab/LdBccLCsH3YRK3pWxczIHWSj8REegVe2j2dojPf/fo
5oTQkAON
=pTVJ
-----END PGP SIGNATURE-----

--6CrN1aG+sIJ77bqI--
