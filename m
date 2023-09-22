Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15B7CE7A81
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2868286B37;
	Sat, 23 Sep 2023 00:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WhyrJEsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5342E86B10; Sat, 23 Sep 2023 00:26:43 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D50F86B09
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59e77e4f707so35879617b3.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695421600; x=1696026400; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3IeZwwcrkgMVOOjERhrn2Y5BoeTXo0/x/FPePlQIW1c=;
 b=WhyrJEsv7+Q+TPDf1r+5WfJz1l2yXiAyuKNdawgA1VRTgDVdE7mrzWtCpznnjK4PaC
 hTydQX7JihH2unZ+Ms5ANCodlVboxNMu9HYlz2ZjFg1PsiicFRqKYGrwf/NtIQnGkNkq
 lkNTRKd5AB+QHL9QadKtto/nXWPgwXatlazSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695421600; x=1696026400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IeZwwcrkgMVOOjERhrn2Y5BoeTXo0/x/FPePlQIW1c=;
 b=bfu/6cWDOdImoZ6sLnw7BNyjJ2s+YuO29ctmOAgE5FFPkq7wgIwJ2a4wpk8bjS+Bdo
 EGIA17m6TNtld9Cmh4GzylW7ooKz/DFWF22/kBpQLGf6ijICEycd3St3aJafQS4fdFO1
 gXyAxUMfaAyoEoCdwbIZsdGp2HTJgeMr5b3nOLH5WxpI0Q1woU/cn9GP1WozZ5YK6jCs
 TSCgWyrwocgDDU1XDspCi9M71nnxioR5vi0jXUGry0YB+W+OGEqh4ZdJIW/0lEncvXOr
 qh4ESNCQJLgxx2ACpnmLnf1DHh7HAYwq8w0Dmj49xMJ8D0JuEtR53vsK/E0gLz+X4CCh
 iE+Q==
X-Gm-Message-State: AOJu0YyZMhiDNOmENUqtMvb32rDa8EevLfVy7OSRNIvxr7ZcmlkMCGcf
 BFy8+sbmGVtcm3vGseeLKbSPuA==
X-Google-Smtp-Source: AGHT+IFxYDSC6YzqreFuQPWx1ucs3rPx1hNYC/3IFK12jBVF4fPsY+Kfpdqv4bFh7yWJFwrAPHricw==
X-Received: by 2002:a81:8484:0:b0:56f:fbc6:3b0 with SMTP id
 u126-20020a818484000000b0056ffbc603b0mr1045277ywf.14.1695421600082; 
 Fri, 22 Sep 2023 15:26:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c83a-32d9-8f81-ed72.res6.spectrum.com.
 [2603:6081:7b00:6400:c83a:32d9:8f81:ed72])
 by smtp.gmail.com with ESMTPSA id
 l129-20020a0de287000000b0059bebb7e5fcsm1128527ywe.5.2023.09.22.15.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 15:26:39 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:26:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Ryosuke Saito <ryosuke.saito@linaro.org>
Cc: jaswinder.singh@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, masahisa.kojima@linaro.org, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] net: sni_netsec: Add workaround for timeout error
Message-ID: <20230922222637.GF305624@bill-the-cat>
References: <20230803145648.1023981-1-ryosuke.saito@linaro.org>
 <20230803145648.1023981-2-ryosuke.saito@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ytHBsm2toDjiwkPP"
Content-Disposition: inline
In-Reply-To: <20230803145648.1023981-2-ryosuke.saito@linaro.org>
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


--ytHBsm2toDjiwkPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 11:56:48PM +0900, Ryosuke Saito wrote:

> The NETSEC GMAC occasionally falls into a weird state where
> MAC_REG_DESC_SOFT_RST has never been cleared and shows errors like the
> below when networking commands are issued:
>=20
>     =3D> ping 192.168.1.1
>     ethernet@522d0000 Waiting for PHY auto negotiation to complete... done
>     netsec_wait_while_busy: timeout
>     Using ethernet@522d0000 device
>=20
>     ARP Retry count exceeded; starting again
>     ping failed; host 192.168.1.1 is not alive
>=20
> It happens on not only 'ping' but also 'dhcp', 'tftp' and so on.
>=20
> Luckily, restarting the NETSEC GMAC and trying again seems to fix the
> problematic state. So first ensure that we haven't entered the state by
> checking MAC_REG_DESC_SOFT_RST to be cleared; otherwise, restarting
> NETSEC/PHY and trying again would work as a workaround.
>=20
> Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> Tested-By: Masahisa Kojima <masahisa.kojima@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--ytHBsm2toDjiwkPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUOFJ0ACgkQFHw5/5Y0
tyxcigv/RNSlxgc4gb5ZCPxkSxXO6hRc8kNsxVS0qMyYeeKMsPNSK1RSByTiysc+
TQDksGDrCyDNjU7lUPj+f8SyqhPkrsGO9H5+A6k9HKlWJ7lQBvwF1RdrGG1zBr6Y
weCZQC5fBkSvZD+KYModxiOfmQ26Tx7iJ2UqAk9pDZSFakXMOwgc9PJt1xxDIczW
SUslkLSxLJasG3/X6Qr1EsK03IWUAtrgTIYZC1yswoSQSmfpoq/PfeyyPp5VAuXw
3lQOCeAaqq7PboyjdwTYwDaJTC5i6NQfCg8B2ryEQIiPpoQ6kJ0+g1FxfEc6vXAM
glLSdE8Dn9ipAwP6BkZyvozSDw64OvAzyQQtEEvvqKb6OLn+6M9YnIIQdoXriYnq
opcvWNyIYDoQ+Is/3NMUkhCqF5JYtmphngp7ht7rqLeVmOKwt5k1b4lGM3lGb1vO
5pPYvb0dNEhOPXaq6l+s5arhbbAL6AKumnGKUEZAdBLNwvyPAPHA011YjY5zEljI
7LAYvhXD
=fytc
-----END PGP SIGNATURE-----

--ytHBsm2toDjiwkPP--
