Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBEBC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 19:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E138187250;
	Tue, 21 Nov 2023 20:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aRmNpyvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499C98749C; Tue, 21 Nov 2023 20:01:23 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B07786FB2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 20:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-778925998cbso381106685a.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700593280; x=1701198080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pYp+WCfepNJ9VKK7UWF92C8Vi4+sgL/nlB/nYVp7QXA=;
 b=aRmNpyvvyg5GdMRvrl2kLO5Vh32u+FbiKD9W8jjJev5kbmU0T0DTSNan25uAg3oGqM
 YgFzhm8v0bJK+jqfVimwdJSf20C0p8ETfuAcVu98QY7EQ2XKKkdQexeQEEmfw2O7DKpM
 Oqq78IbidjTXSY78FzdR/4JOl25FQg+WAxO4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700593280; x=1701198080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYp+WCfepNJ9VKK7UWF92C8Vi4+sgL/nlB/nYVp7QXA=;
 b=Y65yRorNnfHwOS0lnlPAyXs0/OUSSsFZHmh8xEvWOl/K0ZhQ+c3cKnx9TiTikoRgnA
 kv6xLZpDY8m7PuD81Lj74wbbhkA6nzPObhPMBCdN3FU06nXJbt1wBOI2WsLP3QptmQKB
 exPdOF19whN4b6q7VdjAXXn4I9xazJeGXruijK/nBFRuWmWPggCGTuweasmCTno6Im5O
 EeDsx+N7Z/h4tjUBbaiVUWCmahIWoW0qI5ORyWAL0C3x4StkqF7NhUuDJLz4cJ+vzx6K
 65eU5sNS8lFPCRfyOoJqSdegFbhyzoHeAP6MGGP7NLfQGmF4ubR+Z1dcWirHqVcRFzfI
 eSQw==
X-Gm-Message-State: AOJu0YzlWzayvHY1g0T59sc2o59hjhfZKEqCgGzwD3T3rYMLAXa0gbRi
 k/fASRBcqbR4pr9lPqDezLqppw==
X-Google-Smtp-Source: AGHT+IHv/eKklqsT5fYBT/XDgO7R1tdBLVy0oOmBnD0/F+KFyPZxhpKtWnmV0FVgt+OfspyxPDnJVw==
X-Received: by 2002:a05:620a:6405:b0:77b:e887:9cc5 with SMTP id
 pz5-20020a05620a640500b0077be8879cc5mr14251869qkn.26.1700593279851; 
 Tue, 21 Nov 2023 11:01:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 dt17-20020a05620a479100b0076c96e571f3sm3850982qkb.26.2023.11.21.11.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 11:01:19 -0800 (PST)
Date: Tue, 21 Nov 2023 14:01:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/7] acpi: carve out qfw_acpi.c
Message-ID: <20231121190117.GB2513409@bill-the-cat>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tisuyjoO6DJx3R5E"
Content-Disposition: inline
In-Reply-To: <20231121152740.24783-3-heinrich.schuchardt@canonical.com>
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


--tisuyjoO6DJx3R5E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 04:27:35PM +0100, Heinrich Schuchardt wrote:

> Move the code related to copying tables from QEMU to a separate code
> module.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tisuyjoO6DJx3R5E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVc/nwACgkQFHw5/5Y0
tyyJtQv8DJTriVkIBF+2lnHkkGfqaDyoaBRGO9EFR639nnWZ35gQkeHWlmYCTuw4
bam1DSfaESP5BVaL3qtovumgrWO6HNu6dufMJOY8WYg+lTvpPy+JlMXPUNB7ljMA
IEWTf+Rqee+F50dKGym+8LycLOFaFj1Ti4Lt/9VDiMyRQUzfQSVANLjzuRYCIbgQ
CiQgFFbGLS3yY8bmDGLwLFgiQbkfKIJxWmXitnFi6lG6Tqbz726Y939OvHv1C6K7
uma4koZ0zUY+9f+pgiuMuDaflFMBvw0oJlhlCFZGp1S5JqdhWdQ1ZieSbPL52XAN
GqHmAzIqtHbkfNuZIjSl64fLkV7tCBJOIkHjzrr9HZGJlKm1MI5bSSnkUnBdoayE
h1VA7JaLeZAy9C6ewXkjAGNttszRl29rx1avSyyyIqy6VyRwmv3aWvIyhLv91tee
k1u19FNlhit+wRDRKDhOJCWCbz77n0tO8Loa7DS4JSRNwGafyEwPCgCYaZYV4IgG
olWGcx7M
=zy6D
-----END PGP SIGNATURE-----

--tisuyjoO6DJx3R5E--
