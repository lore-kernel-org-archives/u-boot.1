Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB88FE6ADD9
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 02:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E330893D7;
	Sat, 23 Nov 2024 03:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ys4Unm5x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFC70898A5; Sat, 23 Nov 2024 03:42:49 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3420B8981A
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 03:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-460d1145cd8so18587371cf.3
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 18:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732329766; x=1732934566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lJRNlMT0ZuPeTG8hfn0rzPnI0AwshtRyW95j3sNfWCY=;
 b=Ys4Unm5x7d/I2hTSyWz4a4bgmKD2VbJsHlSUhiruPRgooRW/iaMr4mf0atb8HhnZ8m
 nyVd31kgKeYm2eVPkLmVnWgDMiOjN9YOuHO6yvczs/yqtxP3ezNk7gdolj0S0fuRr5QT
 8Bbgc6taMgb/ohijV+w1kHmBBPynXebgPrI6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732329766; x=1732934566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJRNlMT0ZuPeTG8hfn0rzPnI0AwshtRyW95j3sNfWCY=;
 b=PvMaCbJe5m0bh0LYM5LoZIlZgrlVwlgWjyjtHr1DJqqYxRh8ThQZiMivOdqf5ULjUv
 Sl8LztTEWiVovvQB8auy478IPkLDBVCpyLkheExdv+jofpeknqihyvkC/uuf8uVkkd77
 +UcUESNmEHfcA+eyuWmvD/cQVoxZUibpHnlxCTaW50WMVbM05kPsdulDhr7YtY2ED/Ch
 0a7hx5++Y+9vj8RKkAX+bk8LcJPP0CNAI1sTf4Z1mBYn+GfcHg+2B0m0zebZ6bwMnEnO
 L64YGn+ZbFqoO+tRAQMRoRyJ8ROwFFfDNc9ZIg4PhyQRokp1xLC3eTRHQ2/xInEtkPi+
 S8+A==
X-Gm-Message-State: AOJu0YzsROP094N16Ja7QAudPO3MPYx9cWn6ZbxoQt3X8boTNPKe+f4F
 jXiaXhoEA8rGwZLgQWIg5/mdy99B5ZH87jsFdsRvcbwa0QpVVhQBNN6b9LEk/oA=
X-Gm-Gg: ASbGncvHwHlRQwBFlTTqxvielUDWvYrcsjCpx7vedlzhm9h4tQX8DK6ztYFspunyMym
 FTSs1Xp8C12bLDoC/zpE3l9/2mr9dk7lMmHynYuUY7WN9AsIIkvb5oJX20gN5BOa3MLxSEmj4qH
 FcGDL9jwcI2WDxKYRGB4yEF4hK5ZVl0NQjxd2xWqR7F/T1xF1E3gEzy/etdOk9W/EpPF5ovhfAh
 BhHl8kdVg+EZqijrEToMX9qSdcBQsBTHRDtvMcXi5gGz/Buhw==
X-Google-Smtp-Source: AGHT+IHSl4EbZJKgvvBWsTwEx4KvveDRAqahsQ8PSqo9+NVeW6+TMatXLg53/tMxlH5iL1eQPt5TlQ==
X-Received: by 2002:a05:622a:191c:b0:463:1577:2419 with SMTP id
 d75a77b69052e-4653d5a4471mr78468421cf.22.1732329766092; 
 Fri, 22 Nov 2024 18:42:46 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4653c3d6fcfsm19322451cf.6.2024.11.22.18.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 18:42:45 -0800 (PST)
Date: Fri, 22 Nov 2024 20:42:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] net: lwip: fix dhcp_loop()
Message-ID: <20241123024242.GX3600562@bill-the-cat>
References: <20241122123558.74702-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XZHPynxcMCeNz5PU"
Content-Disposition: inline
In-Reply-To: <20241122123558.74702-1-jerome.forissier@linaro.org>
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


--XZHPynxcMCeNz5PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 01:35:29PM +0100, Jerome Forissier wrote:

> The local variables ipstr, maskstr and gwstr in static function
> dhcp_loop() cannot be pointers to read-only data, since they may be
> written to in case the device index is > 0. Therefore make them char
> arrays allocated on the stack.
>=20
> Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--XZHPynxcMCeNz5PU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdBQSIACgkQFHw5/5Y0
tyyl6wv/TOKR6uMWJOkA7MeTSFBR6Wf8U1DRqiePAXLO/g3h+0c8pf3gjjiYUbfx
5qFhW9NMjCJH9YX/zfSxGp8UB/EJMf15qqWjURREwIQiFg1WHFR6JGebF4hnXB0k
LVWzMlZ5rku0lVbFuFNI3dCzMMZvdQMzbuVNI0oV7tgtss2QFV/9a3fz+v8cXYxO
lKd08bBIKe0YTSXMyhM3k9yYLNsK2ywpbKMg1pmMr3coW7PGvPWY83pJahyx5sCc
O35S1+JzZzO2g7tV0fL0zklZ4YQa+sWA7uZmbs93EnJBYKEkoFJVk1dHAH8GqmYs
iMZxUwaOFDy3ivHRP564CZkGYbwvdYt8htj9Pqm87G1hws/Psqm8gC+gfMFTh115
mE1WjEzmRno0bcKkXipqKnscbBcF0gLwR6APO5KaHGVtKnlvcj0F9HHesk9LndKJ
7IpyAMcPCDubI69FtVzHv7Cmz+uxUFCOJuOB6WbEC0v/+h1GT9YeqQsjQvVsDaqP
qyaN4PVp
=fQQr
-----END PGP SIGNATURE-----

--XZHPynxcMCeNz5PU--
