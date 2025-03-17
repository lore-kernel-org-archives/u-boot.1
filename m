Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1459CC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 13:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4801680107;
	Mon, 17 Mar 2025 14:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cxKx8chh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386BF8081A; Mon, 17 Mar 2025 14:46:05 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126F6800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 14:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ff0c9d1761so38537527b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742219162; x=1742823962; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FhmO1chrD32a1ctorSIx+MpBjZD0vYH3RyzrNiP1nnY=;
 b=cxKx8chhmFzzOvVyeWRvCH+WEbBluZgyhFAOb4Q+AB8w+u4vgb4e9XijcQ2A2yWmSS
 PEGG7jfPSqU/ykytVTNsXgWbZ358stLTaIQTKX+TErv9QLePwKzd8NL0yWFFs47484xf
 Q5kJ2uPvBGhpk4MYjApYV2aI2F29h52Qy0AhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742219162; x=1742823962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhmO1chrD32a1ctorSIx+MpBjZD0vYH3RyzrNiP1nnY=;
 b=j9dzJ5Eub6ylljx9eel2ef+oS9W6hpZOhwTHd7x4YC5F/BYnJwJEI1GYQn+Jv7RlxN
 vWmTqlsHmeqhlw9VIBpIqPT7GlnFWedeAfqpKgmJbGo3v/Nvz34lmAg0N/UaJURPQbrF
 0kp049TYn7VPWRobg8rboxfSbPot/ehcGkifgja5Voy7r/b159XsH3CB6YG2VLncvTk2
 JeggBntKYRxGB0k0cnuKIUvRZFIOsqVF4nq1aWBWou4yjwhI+0Jqas++VG28D6ICiMuq
 IRBLT2CfZp8C/kM5MizVbrw5dmFH2840I9blZQqG8s7OOHLDqKe339q9wxuXV4xE28dt
 lt/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgnkgDUz4YFvUWcFV3C39bxpjqGhlp4X+Syg5gzjRY3QRGN35xjgtqpO+MyjKYiq5jqduzJZI=@lists.denx.de
X-Gm-Message-State: AOJu0YwJIlMeO+0LQJiNBndEWzVO+B4gXmddc8mZVbCWXBKKOngTzYou
 OhCnhbCYtaR+qw4Zl6GQdTJ2pbSLbkovsDmbA0XZJiDuIr3SjFWergvIU7Wp9XQ=
X-Gm-Gg: ASbGncv0AVLm87/LjBVclBz5e2YAQzjdF0V25AzHSc1eAhl8kWRCcgys1wJXHyqo37Z
 nw+AUBwHHVX72Rxmt9d4swV97kpImEvrqUw49qlmJjhH7p4uJv6DL+jI43sZegJVYTS93GFEGEw
 OZ3nOnRnHKl06igEPGTmODL9uGeeI4C4W1INVZtS7wGq3eIhlHYg+mStyBq/O/k4oCnHMde90na
 zt2r5n0K3f4CMAP/eAW6zUqw/ko/7c8K+MsYBc+aQtvXAAFVrgf8XJhPCAb1Cx5O19HTdJnH/5x
 rZOYS8l1UgYDnS0wnvzdjej6D2q0PA0P85d6uRsv3QN16CzCq3I68vk=
X-Google-Smtp-Source: AGHT+IEv7NlPKPaxtjMAsqWC8FMLnv+DpN6IHcq+UB47Ab/JkqGPf41PErmB95XsWbjRoBisow0cRg==
X-Received: by 2002:a05:690c:4c0d:b0:6fb:91a9:94da with SMTP id
 00721157ae682-6ff45e452e9mr154395087b3.5.1742219161914; 
 Mon, 17 Mar 2025 06:46:01 -0700 (PDT)
Received: from bill-the-cat ([187.192.128.10])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff32c7a735sm22013397b3.81.2025.03.17.06.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 06:46:01 -0700 (PDT)
Date: Mon, 17 Mar 2025 07:45:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 0/6] MSM8916: Bring secondary cores online with spin-table
Message-ID: <20250317134558.GM2640854@bill-the-cat>
References: <20250128-msm8916-smp-support-v1-0-39587f18cf0c@samcday.com>
 <b72d521f-6df5-4ab1-a00d-65ab7dc14ac6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ixlARAwDjb8O/k80"
Content-Disposition: inline
In-Reply-To: <b72d521f-6df5-4ab1-a00d-65ab7dc14ac6@linaro.org>
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


--ixlARAwDjb8O/k80
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 01:13:22PM +0000, Caleb Connolly wrote:
> Hi Sam,
>=20
> Can you re-send this without all the prerequisite-patch-id tags? b4 is
> desperately trying to apply ~140 patches from some old next branch to my
> tree and tbh im not sure how to make it stop.

You can use --merge-base HEAD to override that I think. If not I think
it's worth asking tools@kernel.org because that sounds like a bug to me.

--=20
Tom

--ixlARAwDjb8O/k80
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYJ5YACgkQFHw5/5Y0
tyyKdgv/Q7Xl0vMQkMv/7kDWggMe8DqDZpF/6EU5ikOhzS5Dz+j/rPgQ81JFIO64
W6r1iJwhHXMDoUu3FEX1xAJl4bF3gQkZmZF2UxjJdDVoG2Uj45hTs8x5GZHI+YXB
J3xkz4Ue1LMWcacUUvNtHr/DPMF+IJnL6IcqEmjbLzSTuKdrHo1mGzc6GWvDA+bW
rhnuYyZc9jzEPDAEMGccwWypVDQq776zFPH4r1gahIi1OyF84E7wtD3UNgENQvoA
clhnDej5/G3vqWsFOS9HhLicgL0lcaz0rcMct6xCXJBbPe21DZ8nXelIYM5JJqik
9crUJy+yA57EQ6jt8KQOHMGlBK23yUaLP0fFB43tOKNUkAIwGPAmOyZhZoG9UIdq
0mvOanEUkbIJMrXmNqA+gfuf5R/E+3wR5IaE1jwpMKum9tmeWMOsArJgQswT4wnv
8Nlbb9hmVEWbA+K6UANpR1SvXxfzx5vbXihai68zZBenfZVhf3YzTqZ0Zz0r+uUa
QTK8zcyc
=xGpo
-----END PGP SIGNATURE-----

--ixlARAwDjb8O/k80--
