Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03299FEFB54
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 14:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 503B483E8E;
	Fri, 27 Feb 2026 15:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k26RlXiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBEC83E96; Fri, 27 Feb 2026 15:49:16 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CCDF83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d19d3c7208so1225243a34.0
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 06:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772203752; x=1772808552; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2gGlrMIY8kY5H3+oDWcyfaz0zbIZbnXUR/s3W8WUKDw=;
 b=k26RlXiOcb/RGlilqMi//EEH92gvr5EY7XLLzcMYXwgcMGHXxU18e9skSK4yUxGoLf
 ISKO7RnRsLpn8FTBDmf9UVk0Hniqweem07vJ1SGKUOrf0w5Ipl2qNhDGKqFzP4AKvrIU
 VEvcjjZ428RjZbdHR2sg+8NUf5c83fG9h9ggM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772203752; x=1772808552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gGlrMIY8kY5H3+oDWcyfaz0zbIZbnXUR/s3W8WUKDw=;
 b=aEs8h4/IPbBHm8fST0DAfuepENPxMISz6woIY71Fs92TRJFPZoRX3vDtKA5xvtgn0O
 Op477wEWm9H/AkntIi9GEN9qZEE8wxGjClIPdRv1GF+yr9+kwq0m82tIWAIuojpEBmXf
 AnqX05yx9ZuGiYjMOLOtLcTVdc/XcaHlSHm+EfYNAn4U5GZ1rq259Re/3olQnkeJkP4V
 VDjhC1LU+Kjzw3WQOIChoeQHr4J60aLKcdILBPRWqQQkygarqaO7Ntp0rMajaaN77Wzl
 I5z6TH764L2yd6iH/RdJUXN+AAF9uDZujlfljtZz2xOXgbI9jOuK8BbCOt7opNwFiuHK
 B5kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB1lGS/hFacivtkp6QHcGymMcPOiM3AvkDoA3C2YSFx91FY3zT/2dAfIGmSEs4w78rKMQZWKw=@lists.denx.de
X-Gm-Message-State: AOJu0YxKyGIgzO+wJALAeMyrJ/5sgT4Flt+N6M6c1B4FyLREQSwBhth+
 /hQ6FRJQg6HuDK/kycNzWbJecSY/j8r1dBeF3R89sC3wgVGE6cjs3wtP96fHPHq+uSmKPlIQkl/
 QLGHD0ro=
X-Gm-Gg: ATEYQzxjNGHtE5F27T2W5RcGo2vz53jxe+xXziB7ZqsBT3pQ7Nzk7g+IoX2g3leWCQ7
 OaM3l6Uz3ak31fzgDYevt3pnAgkzu3DM/jFG4Mm+AnAEGqWUNEZ0HPMVgS6sejWi0DglS5oEzZ5
 ssIIB5jnHh6SjDo/ePAJ8P+9F602rSrKpjXiiH2aGgtXPneGPoX9amVVOi+lsbXA8NzM/yciXcl
 RUpIihombBHn3ShNnf+aeNknwKLWwReCrviukrER87tPewR4RFBiLjFJjv45e2JrFfsUztVN6og
 Zw2LM2yHFu8xejJEt7+nOX1BMCtmJ0DzVmskcyoU+pGmf+QLTcxO8KABZd2JKUMAtywS8qUhXib
 o34M4ubf5egiQTiWL4MOMx4nF5X0xeF4XNOEA7p6wRBjqCeeFD+VtgMYqGhiLUdEHFNmVAmQGbZ
 NzWr8t3T21ZSyKXJFHooVzfpV1Q2gys3T+WuSZOUWCF6OgOgaPy4T4TBzqp1aKaIWfNZJRKONH0
 q3lppwhDxoKuj0pvk8jF2orTZQ7i7jLJZZ0CaK0Am4fpsxEYWuXTNrbOj/MNQ==
X-Received: by 2002:a05:6830:660d:b0:7cf:dd63:3d52 with SMTP id
 46e09a7af769-7d591bcc432mr2157152a34.18.1772203751747; 
 Fri, 27 Feb 2026 06:49:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d5866269a8sm4398805a34.13.2026.02.27.06.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:49:11 -0800 (PST)
Date: Fri, 27 Feb 2026 08:49:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, nd@arm.com
Subject: Re: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
Message-ID: <20260227144909.GR1593142@bill-the-cat>
References: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
 <45e3b935-6e0a-471f-b87f-6c03edd4f237@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0rFxX0Y/QHCLk7y7"
Content-Disposition: inline
In-Reply-To: <45e3b935-6e0a-471f-b87f-6c03edd4f237@arm.com>
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


--0rFxX0Y/QHCLk7y7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 11:03:32AM +0100, Jerome Forissier wrote:
> Hi Heinrich,
>=20
> On 25/02/2026 07:14, Heinrich Schuchardt wrote:
> > For enabling the clock driver we use symbol CONFIG_CLK.
> > Select this symbol for the HiSilicon Fast Ethernet Controller driver.
> >=20
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> > @Jerome
> >=20
> > I could not find any usage of the drivers.
> > Should they be removed?
>=20
> You mean no defconfig enables them? It could be that some project
> downstream depends on them though. But do we care if we don't build them
> upstream? Tom, what do you think?

In this case, there never was a "DM_CLK" symbol, even for driver model
using CLK, it should just have been CLK to start with.

--=20
Tom

--0rFxX0Y/QHCLk7y7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaGu3gAKCRAr4qD1Cr/k
CjRkAP4hOiZPxvlXuB7OlFCCMKs3jqpEcvkibL2R7R82DseoSQEAqaVB3T66CP2E
uFkqM+4AJY8995sWtJlCWo5rPdI2JQE=
=MbV3
-----END PGP SIGNATURE-----

--0rFxX0Y/QHCLk7y7--
