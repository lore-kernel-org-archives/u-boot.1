Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D9ACA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDE1B869A4;
	Tue,  5 Sep 2023 20:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eiQ2iG2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8040281FA8; Tue,  5 Sep 2023 20:43:57 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651598698E
 for <U-Boot@lists.denx.de>; Tue,  5 Sep 2023 20:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59254e181a2so26903527b3.1
 for <U-Boot@lists.denx.de>; Tue, 05 Sep 2023 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693939433; x=1694544233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I3ym7mwShbxoxKollIXdbSrS0xCLX01rGr1NVV9LM5I=;
 b=eiQ2iG2irB4ITxr6s0laDXRnyLYC9uj6sxCg2N6ro4g4GXlUzm6z7EOoyr9XujQTZm
 2RArHdP5ZUnu0gQ0meKF1A8RN0sekAafob5unK1HVvE1qzLf6dr4tiWc/pHIT2Es3pGT
 eAmi6vEO3IHG7nzrMqx7ReUhZVg80YAbLECg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693939433; x=1694544233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3ym7mwShbxoxKollIXdbSrS0xCLX01rGr1NVV9LM5I=;
 b=I3Q95WGHar02CwvEp5nyQckvY3Owm2QXAk9NCoA3x5+BZEiM1QIj6c1AjCTlBPPEbC
 8QrM+gReimFPos4G06yn8caHIMOKC66pNKzf8lwslnIaUaeN2o20OwS8xWB9imAmzwca
 a4bSHmvnds8eG2uPjmdgcrBGY0QAn5R0spaMo7Wp7R6bzJUxBjWp22mkKMSSmd0oM1zb
 iSg2OOoaENyu92DgNTh4WHzNEBvGfqnxqFqfPuoATf0jLFLg/TnT/Zv1CvTHfMSfiu7s
 DtwTSW5FjthDeQDH6YpPEwdNrgFhErJI4izp8rYpNkYAXPhb2PH904q9oNy3/9C3rK/9
 wQyQ==
X-Gm-Message-State: AOJu0Yy6SFpvCjYEmHjx+am8PJPjEJWXKEQOwlw9l9X/6GjgOrwpRGkj
 DC1PWLrfXDyNf9RTk0ZxP3cJaZAK+tEdxNo3JW9/NA==
X-Google-Smtp-Source: AGHT+IGTruA2n03TkW7Y1ivmW/i/DB8oKSLG3YGkK6pK0AwrL3HcqFvr+zLqCp30f39Ea/kstMgDDQ==
X-Received: by 2002:a0d:eb48:0:b0:589:e4aa:7b67 with SMTP id
 u69-20020a0deb48000000b00589e4aa7b67mr15008220ywe.41.1693939433142; 
 Tue, 05 Sep 2023 11:43:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-51ef-a95e-1d1c-c7f8.res6.spectrum.com.
 [2603:6081:7b00:6400:51ef:a95e:1d1c:c7f8])
 by smtp.gmail.com with ESMTPSA id
 g127-20020a0ddd85000000b0059b17647dcbsm229724ywe.69.2023.09.05.11.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 11:43:52 -0700 (PDT)
Date: Tue, 5 Sep 2023 14:43:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Stefano Babic <sbabic@denx.de>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: Pull request: please pull u-boot-imx-20230905
Message-ID: <20230905184350.GN3101304@bill-the-cat>
References: <f0ca845c-890f-9360-7426-41dce4147a7e@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9kw4ybqzWwvwecrM"
Content-Disposition: inline
In-Reply-To: <f0ca845c-890f-9360-7426-41dce4147a7e@denx.de>
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


--9kw4ybqzWwvwecrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 09:56:31AM +0200, Stefano Babic wrote:

> Hi Tom,
>=20
> some fixes for the release, please pull from u-boot-imx, thanks !
>=20
> The following changes since commit 8999257f219d1e371c2fd66f255b8782897944=
d9:
>=20
>   Merge tag 'doc-2023-10-rc4-2' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-02 09:08:54
> -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git
> tags/u-boot-imx-20230905
>=20
> for you to fetch changes up to a79fca7b44d0dee96e14d31de5869b35b587283c:
>=20
>   thermal: imx_tmu: Increase the polling interval (2023-09-04 17:26:44
> +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--9kw4ybqzWwvwecrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT3duYACgkQFHw5/5Y0
tyzWigv/dtLY9hBJ9wi2qTAIw871NQYWwfWzVLiZzndGmSG+fDPPcg0kdUIycupl
yCWxY3bZdcZLbZXq6uBmo5lkNqsAJH+ImoK7RcRvR7m55NeSlzKZj2OPtMdw3JMt
fe5ojlG6D+EKDKXLR5TLaiasMS+3c1xsQmtjjLc8hIscOFFXfec5o6/N9DQ1vrUW
5iZZGUSVYiTzGviAsa+UXaKpYSpJEmmATvcNkpwup2BPwEB0CBSjU5WyRrYdSSAO
LalL7jbd0D9yjDr8Bv9+CJCw8d/9U8gPWeN62jxKzG5L21q2LDm63RMx+IoZhQqM
G0b1ElbfP0S7r/zNR8J8CfN+gG0Qs9VvhO3h8di8pPmMDld2pTcm6KmNilrkqQy9
jzBldO/PxXNYWR3KGeGNbCBJ1wI5GKaejy2DFLu6G71TN1BvlLQOoqf+T3wcY/uZ
Evu2/MFuGUZH/G3EIOwP8CUw+lwGf5qeHn/8KpazSPBDqrEfaU5r/PgGYF4sclNd
h2F2abZ0
=9vMW
-----END PGP SIGNATURE-----

--9kw4ybqzWwvwecrM--
