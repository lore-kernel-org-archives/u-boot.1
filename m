Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4AFC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 20:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E694188758;
	Tue,  2 Jul 2024 22:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fOUxRM/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AF988788; Tue,  2 Jul 2024 22:57:04 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B552B88758
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 22:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-701eea2095eso2755287a34.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719953821; x=1720558621; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ecn2K6Czg5q9hFRsVy4V220HxmBvEEHEG0BNC58I0AY=;
 b=fOUxRM/ldXiniu//hNJWbXfM9tzFdpRXLwN3Mih467MKx5Yco+C9m7pMkChAJ/eHJU
 u/vDRfQGxiVH54prPDUg0VOJE79WJb+cD/91JaqnM+1XYVSNEr7n+AWnr75aKMgWdKV0
 JT9wigSMhw7JrJVuXsU66mghg0x+nDk7rkb8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719953821; x=1720558621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecn2K6Czg5q9hFRsVy4V220HxmBvEEHEG0BNC58I0AY=;
 b=iNb1cKz99xc3t1F7jpp7eGK5GwM5nlRBEyciMpc6F9UXdknOm1iBK91S+Qv1imkwXn
 PQcT0BcY6ch0DqPAQWQNTAbcjLRKXwab8hf0VWe4ZtYWbx/Qs0KlNkSr2q5esA4lHmvb
 Mv452m076xgoKaKa39WkQ1uu5Dv3OSMoi1zl0H4urqEkgapfT6hcBe49t4Ty/5RL/AI2
 OL7FwSDIFTcyVnglYdjn1Ga7F4mvrbsyTnTmezT8UgCJ5CHXMJXKSzv/hwMIQrk95wIX
 42/LGQKmUXQQgacmHCju8pNmJv4j0HvR/hriWI7QTall7YFC7/rDtk7YLpdPdrdw7cKW
 MOEw==
X-Gm-Message-State: AOJu0YxNGlIBmlejTyQ7Ygl8smJv3s6FKdv2wMrFf9DAeT7s/OnTmXn4
 v16HwpKUX7Oc+Iu/xqdsyuEwVEdAewZV7r7UIyzlv/TzugKW9gV1+3AIjuTXziQ=
X-Google-Smtp-Source: AGHT+IH+cA4rrZYz9qSn8a7/cOohA3Z2tdINIAbO1Yz5Sud5XYoBi6XNvNP+ccWdyzHjlG2NfdVSmw==
X-Received: by 2002:a05:6870:5b9b:b0:254:bf41:de9d with SMTP id
 586e51a60fabf-25db35d9476mr8790610fac.48.1719953821365; 
 Tue, 02 Jul 2024 13:57:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d8e3842d8sm2388394fac.51.2024.07.02.13.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:57:00 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:56:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 02/29] mbedtls: Add script to update MbedTLS subtree
Message-ID: <20240702205658.GS38804@bill-the-cat>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-3-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6W6xyOOQmwiYfpxn"
Content-Disposition: inline
In-Reply-To: <20240702182325.2904421-3-raymond.mao@linaro.org>
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


--6W6xyOOQmwiYfpxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:22:38AM -0700, Raymond Mao wrote:

> lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
> commands.
> Usage from U-Boot top directory, run:
>=20
> $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
> $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Initial patch.
> Changes in v3
> - None.
> Changes in v4
> - Minor fix and move the script into tools dir.
>=20
>  tools/update-mbedtls-subtree.sh | 47 +++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100755 tools/update-mbedtls-subtree.sh

Given how amazingly close this is to dts/update-dts-subtree.sh and also
the lwIP version, can you and Jerome please co-ordinate on a short
series that you can then both depend on a pre-req that makes, I don't
know, tools/update-git-subtree.sh and that script takes upstream URI and
whatever else would be needed so that all 3 of our "update or
cherry-pick from a git subtree" scripts call that and are more or less
one line scripts themselves? Thanks.

--=20
Tom

--6W6xyOOQmwiYfpxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEaZMACgkQFHw5/5Y0
tyyxvwwAn0yJogon9w9iF+TllRW+EJIAnKjNmbWzGDTgIspr/ODelHnZW9hA/rD8
bfySWa5qBrFygZ+8kH19f+29m2Z0yS5Z/hvU6pJ8yGzxBiTVukDf35xYkM4CFcjt
S51lHsZb0ixXwqzJYycb59GJ3oqHjkXDc7yuKwScqm3R28N/gQ4WcwRbzsk9K9mI
mlCtLwhhMcSi5PUzF5ngUNcghMYVtkAtGINZupcBi7jXitnr+/44nBKI3ZtBrIKv
UHJkbh1zB8GOCt/9rYfJ7wF1n5nlx1a8GLo+91aFuBCyW2ge113LLmFz6XVvN/lc
d0el7GKn5WwiwJjluzq5JFyAg47vKF4zBA1bu6uIxy45HHD8q3/1X7B4c98OK0yG
9w3f+OjV3XFIRWDLhuKg03BOjtxasNq6nuYSxYHcYjjyDU06XOxLPlyNVy9Lo75m
FD2+gxKNgjwr8GH5Nyds2kSLMbxUgpBYIyc93Hpq37qTvMzn1pNceWppwwBgj56g
+hCePYdw
=w1oT
-----END PGP SIGNATURE-----

--6W6xyOOQmwiYfpxn--
