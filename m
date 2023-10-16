Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A7ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1285386BA1;
	Mon, 16 Oct 2023 23:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PoP9Ee+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C93186BA1; Mon, 16 Oct 2023 23:32:03 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA13886D2D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7bbcc099fso63339847b3.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697491909; x=1698096709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ggYwYp61mwwtTQQhvYiw2VTx2Mxklba5VM3arC5pGwo=;
 b=PoP9Ee+PatJuUxQypDY9FUPULJBWZISF5Q9gEE9KvlNeuKsxsppUC+Y4kvE0SRT68p
 6wuliO8eai2VSENNTeCj0VJNzB11wFKq5DygcNk7YzKepnzxdMRfz/uHqH+dALyHTvdR
 Fi2SqGdHjIw5Obwcs1hwzgVAI/PwIveosbC2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697491909; x=1698096709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggYwYp61mwwtTQQhvYiw2VTx2Mxklba5VM3arC5pGwo=;
 b=Cap0QhK/cJ2OZc7CF0Ntlqnr+EancdrKDtfMurjrqRQKrcD1aEHW5lYnM+AHQyLqUa
 W+jObXsv8z/jS4+NGt6xZh21Lyp1q1RyrbNV/zfwDradYjF0v8Zr/euQX4kLlFlWy65f
 hvRwBC59nFmScYr1N00vqASW1V91BW8WWSEV1mRXl3KP2NUe6w/X/PqS8nBYevPcD5Sb
 iN2ffn9lWzywmBeUibuo9uL2Y146fnnD83RFMFKOaiMfxdCKfRJeiW0hA8mgJaz9fPwX
 TSytpFsZTn4DfGOMUyJrACF2pwTRk5OEIamthgvZfKivNhiljEpyJIPz8S5Gqo5NzYFL
 e7yA==
X-Gm-Message-State: AOJu0YwS9T7yHTYeqeXUh/9n427XOu6oWKReehEhyC3KrlQExjIfbkWq
 EmfDNMsa2x1Amj4RlpPE2WHNJvqZ6xgNGG7I6RfZzw==
X-Google-Smtp-Source: AGHT+IEfC6Pr2+KoMyB2zDXPvsb+wTEKE4oJHEt3u4BZ42qrrYb44jo9lPeI3CZ+HccmjbCQCYsP3Q==
X-Received: by 2002:a0d:d6d2:0:b0:5a7:b54a:e0db with SMTP id
 y201-20020a0dd6d2000000b005a7b54ae0dbmr409889ywd.10.1697491909569; 
 Mon, 16 Oct 2023 14:31:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 q128-20020a815c86000000b005a4da74b869sm28101ywb.139.2023.10.16.14.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 14:31:49 -0700 (PDT)
Date: Mon, 16 Oct 2023 17:31:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Knecht <rknecht@pm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/6] eeprom: starfive: re-implement mac command
Message-ID: <20231016213146.GK3119521@bill-the-cat>
References: <20230930120147.59482-1-heinrich.schuchardt@canonical.com>
 <20230930120147.59482-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yU/WoUQo4r4rfX+J"
Content-Disposition: inline
In-Reply-To: <20230930120147.59482-5-heinrich.schuchardt@canonical.com>
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


--yU/WoUQo4r4rfX+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 02:01:45PM +0200, Heinrich Schuchardt wrote:

> The different implementations of the mac command have board or vendor
> specific sub-commands.
>=20
> Add the command definition specific to the VisionFive 2 board.
>=20
> Don't call cmd_usage() directly but return CMD_RET_USAGE instead.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/master, thanks!

--=20
Tom

--yU/WoUQo4r4rfX+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtq8IACgkQFHw5/5Y0
tyw1Iwv7Bn1IkD4yKAbXBqYm6ZmIU/ADc4u0dlqKvJ30796pxW6e7OwYQYnaFhJC
XKVBJTbuYYByjzBPaqdXUVXuNFRDndzeX0AaLhsDAy1TXQvL83kZBnqYz25gQ2Rd
uXLs3Vp0WgLcFMW4Y55LdThtouXOH2fjwQJn4JNi4ssrHWeie6ilJeTg3S4DiMx7
/bVOVyt3BXd6XmY8TR6e+leUH6HTgz/I5c4C5Ugb+VsjVos6L3ROMioLGQ78BwHw
ok/C6JKhoz/qbDk7NtWkKFLT3fM4ULjS1sFR3+zg9i0jEP2NzBfaZhk9lNVb1r2F
gvoQ/HIJCEGArTNF7WMTozlTnNAPiwlGX8mQof4ZTlUtvgtqau36dQINaXlKC8l3
9HN5s81ATKIV8P30qHHZgN8W0YguyfSH7116X6gXjx0LxqZVFMaWvtDMAOroFRXT
7DGxwwLh05d5b5WmyFBiQw82227BkrqSaDOPywW3O+EfwSKCoL4p2H8F7Q/X7BPP
H62tQ7xB
=5K9f
-----END PGP SIGNATURE-----

--yU/WoUQo4r4rfX+J--
