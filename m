Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC91C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57AEF86776;
	Thu, 31 Aug 2023 18:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gPLy4c74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787D3866A0; Thu, 31 Aug 2023 18:26:47 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB758666B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-594ebdf7bceso11756727b3.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693499203; x=1694104003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+PgQrNDYOJwcP32XKwB3kzNiB+GJsRCroPT+iiL/yg=;
 b=gPLy4c74KaJPToriOuPNikJFyWb0Gq3yGDIyGRcyniDBAU2wtwX+iPNicEIktZnjuT
 fDNu28gKVXSpSK43q2AHAVCE/ErIxe7AeUQERr2HHs/9fh+eeyE+Fl4GQYVNiPyLFy69
 86q0TcLAAL9W8NDPgX/FtGcDtQ6NRvW6EJl0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693499203; x=1694104003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+PgQrNDYOJwcP32XKwB3kzNiB+GJsRCroPT+iiL/yg=;
 b=J7z/0BJ3xZkT/QbTIbNnKHlI6abwdaH/CI1O1zmLn428hXyM8PBMgY7aElCFpRsipm
 9+PmYLghDREelx8W9ICvzw51AubFacaS2twIeJSckETbmLqS4iilzAaqDn+3eqlExv6C
 Vp6ADnyWlZJS3/2H0wa+6H0li/Lim1iWsQj1JEd0bWWi1hu679pIZPmiuEcR9Fiiy0xc
 Q2JUBSADYCmVxc1Wn8hXNTTLJc9q48gk9yqZNDliXFvaazw6tlVrTXRoU+aYXLXEQaNE
 BQ7DDbOMxB0wUQWaGyQIF32+Uc1MypmzLVw62BvK9hnjNNFDsk2wNDYhPUqF89g+CCXP
 dODg==
X-Gm-Message-State: AOJu0YxCBpBcwv1j1yKA4EmhyfpTCM7vM4BGTpdkKIqPRQ+0snbkdsva
 Ss8rgMKTHeW2YWr9z0KkunrVxA==
X-Google-Smtp-Source: AGHT+IHgBdKbyJA8ASqj+UTlrbL3uTMt/0CoPXqcHcLIh5F5x1/12z7F0pyXmWc5Yw8zOWuaEZJhvg==
X-Received: by 2002:a81:7186:0:b0:592:984f:b7db with SMTP id
 m128-20020a817186000000b00592984fb7dbmr5934524ywc.24.1693499203527; 
 Thu, 31 Aug 2023 09:26:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 g191-20020a8152c8000000b0058fb9863fe7sm499993ywb.103.2023.08.31.09.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:26:43 -0700 (PDT)
Date: Thu, 31 Aug 2023 12:26:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 3/5] drivers/mtd/nvmxip: Print phys_addr_t without
 warnings on both 32bit and 64bit systems
Message-ID: <20230831162641.GG3101304@bill-the-cat>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
 <20230823001821.266578-3-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P0wL3GkS/KAkItPp"
Content-Disposition: inline
In-Reply-To: <20230823001821.266578-3-marek.vasut+renesas@mailbox.org>
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


--P0wL3GkS/KAkItPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:18:19AM +0200, Marek Vasut wrote:

> Cast the address such that it can be printed without warnings
> on both 32bit and 64bit systems. This really should use some
> better print formatter, but for the lack of it, do it this way.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--P0wL3GkS/KAkItPp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwv0EACgkQFHw5/5Y0
tywgnQv9Ev4JzKV6FxqYOaDCtVWMQ9cfWwcAhS4O6aA65BlI/2v38d+MrE6kSxWC
In7qm7JDTPF1qEeuAtAt5EDsnbxAeB+c+gBNCwO3MOLQTDmMqohwk1qlUrg/My+J
NR8BFftbEDb504Fa+cocSmzrTMy2PIBCYgUz/VzXDF+guqaN8pWGfLN5qPeFJ0KU
IyDAphOc9BtdQxtXB5Oq7E+OWOyn7GcRY0bWxuGg44MUBDCoPCbZ58S9alEZWmK9
F2NE5zzq9Pity3mCB1WZ1kXIlVMrXiH0f1/OZ+uVOWn9cfv5TtzWa5DhPjsEOhSM
IScmS1oeMCeFy+kK98GHQg/W3ICo108YYqqnSiUCRQ+lyOfR1c4XlKivH0Qulkr2
6C6mJGdQqOfZiBHAhgDHzilFE507b3v3CKjFKZQTx9NKEOBsjG84od9YOSv/kW2R
BvHsU/ptDnunpDRHlOkyv1iqhGK9nsQFeMMua+koXcj+oFf3zrduQOQqV73bpp9Q
dM8TfNl9
=1Aq+
-----END PGP SIGNATURE-----

--P0wL3GkS/KAkItPp--
