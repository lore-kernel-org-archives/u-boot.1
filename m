Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBD6C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F50887A16;
	Wed, 25 Oct 2023 01:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TQosWIVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB5F8748C; Wed, 25 Oct 2023 01:16:27 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF99874BF
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7c7262d5eso51748157b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189371; x=1698794171; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9KrvMxy7lGN4fLMqso1CSPcnm4qEMafpP6wzxjRS8VU=;
 b=TQosWIValOkTghmfOP8ro0Vzja/ftlNbp/KbfAChuTKylpK+477pWD5Mun8XzfdiDR
 ZZ35TnPUN0SKVoGDVHRwJkIdtO5zVrXhH4VZ3JMHieNqjWpE62gmN9eD1y0L4lvBEp0G
 RmZnfru69j115Z4nu1SHwVa9+5IpxzBrfAiTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189371; x=1698794171;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KrvMxy7lGN4fLMqso1CSPcnm4qEMafpP6wzxjRS8VU=;
 b=nHmPs1IKtgLtcnqZOq2tJZvyVXqqwJXYkhN6GZR9Hv0cFPPxShXo+mqYeBFHjJUWO4
 5K7jxWJX+1LOO0/E15XtgC8MheEyVfxvSgAyC/Flr3yJsztgR5ECsLPKtRExjmjsxEqn
 7GOwtI0YD1zIXV1pz2cLpFOecvmZ12kHcmBd22VdBj70Deh8pTtXv6y269pd+TFp7byy
 CXA9rkRh/r9EY2fSVbyEScfpCYa04FoV4X9g5VzgVzGGMMY+zhQKZTQ/lkNTqqSDy1bz
 bd+fwsVSzwqHRwC1TP1KgsvRhDYz6nK+ckXkVIozM14ZHG80YYttXXo8RPU4cTkcvfy+
 Hgig==
X-Gm-Message-State: AOJu0YyTgRlWLCovfbeKkTF4nsukbjPl/l727ukXW3ZtIp+NcGCOz44r
 Up37M3vHfsl3fiYgTGFdCKgKb4+lwQYU387wgzN54g==
X-Google-Smtp-Source: AGHT+IGGvbF4uUWcUgxYhkVYFjW3o3fysmWHsTEMrfVG1FRTebY2qIc3ixuy+MQ7DVBRwBpTDDOPQw==
X-Received: by 2002:a81:48d4:0:b0:5a7:b723:8fa3 with SMTP id
 v203-20020a8148d4000000b005a7b7238fa3mr14614619ywa.26.1698189371520; 
 Tue, 24 Oct 2023 16:16:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 g142-20020a0ddd94000000b005a8073e2062sm4527435ywe.33.2023.10.24.16.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:16:11 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:16:09 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: Re: [PATCH 6/7] mips: Remove common.h usage
Message-ID: <20231024231609.GT496310@bill-the-cat>
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-6-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qyBwtF1PuvSuABwJ"
Content-Disposition: inline
In-Reply-To: <20231012230359.2005249-6-trini@konsulko.com>
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


--qyBwtF1PuvSuABwJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 07:03:58PM -0400, Tom Rini wrote:

> We can remove common.h from most cases of the code here, and only a few
> places need an additional header instead.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--qyBwtF1PuvSuABwJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UDkACgkQFHw5/5Y0
tyxV6AwAiNVvyhjQWz22Kv9I0lWALZ4oqdK0P4rA+W2c5VDvnRd1trysC1w8wJHs
NQ319/pwaCzeWesSteMJSnuzKKbqkca3Gg2HIobii+nFC/lb/8rJmRSHhWOEz2jP
gBHMubPBgJ++9qS4QnPzxxPq1kpOciqN4KuYy/qxx2XFLoAkEParRrHUPD6Rd+Jj
x2L3xTVa3UrFM1nQRZ07DbklOTJJqKg/HgzzeyZ7oM9mIr+VwLCb1ySLjZZpZGfj
tHuFSINF/xBPDQ48FnWqCCK6tgpo4rqznSkMb+ut7QDvvZb0/6pSeowx+OixR4ZR
rbk9mw8Ajc7YSnjxDh9h6+7+Iau/iJj3pY0BVS5BTEuQ46GSDFcyjLFvxmFp63QB
4kq4YcGHAZi1UtpRYdkkp0wv3dhTPgG6x+lufUOuDhcnWcPUmV0BS0s/kRU/5FKj
gCmjWwvpnAFRVCL+yvRedq3Xp0yLh4re7Am4goHjUF/zuE73qUsV7u/hl2m7nuyW
H9PF6vU6
=WQOd
-----END PGP SIGNATURE-----

--qyBwtF1PuvSuABwJ--
