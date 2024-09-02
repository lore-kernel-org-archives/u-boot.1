Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F1ECD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 20:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BAC88C41;
	Mon,  2 Sep 2024 22:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ihgObFTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C00F88C41; Mon,  2 Sep 2024 22:09:03 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1869D88498
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 22:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso20008196d6.2
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725307738; x=1725912538; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ENXvbpTAWpIXoqCYw2Unb2JiiUPx1rBJlAFMMec/5gE=;
 b=ihgObFTvXKaxg6Mf2MKYB630MP6mMqdW5f1IxMh0dHKOj9BroJXyU75y4rr2JbfkWU
 jlYSLNkzgjd4jvzuYPqk7Pq8AMwIdAQzlrMhUEqMKmx90ta96l5sAteZGVjXyDl+L5uL
 8PJSGXxmaEvdT0vq2tMtfWsfMfNo1MzlcSz0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725307738; x=1725912538;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENXvbpTAWpIXoqCYw2Unb2JiiUPx1rBJlAFMMec/5gE=;
 b=ZXjr/OuhIXEYVH2cl+Qab8rvUj2++DFq361arkar00jI1rBD2W99SuCNiKRwH+oeb9
 vtNX1A6+eXktTKVQme2YeAPaglQjMqBPBt5tEJjQ8hrU1+tyQDT6uOdXoWdmvT8peS6f
 QRqfyv5DxS7Q+M6guiVExCaMr2CG7CeIZS4biZAQRCWMW2vtGzfe1618aIWE65vNMUYY
 uL6vaHAga19uB44uu/N3Os+m57tbSLiZpJFtIneQ1sGsvl5o75muGUMvd6HMaTKqaRjs
 xWguIK1EA/X/V92/HbYR9byVS29fvWFWECoOmu6mpGnSTKGHHQGCKUHbX+Gnnj8b13MG
 pteQ==
X-Gm-Message-State: AOJu0YzVGSHJmcIpALJTqi2bFIyiRAj2ZJM2ZYTtHPtXk74DavK2vVcg
 TdyRBTZgNg2Me1KkYqWangUtr6XDhRIhYdFdpTBl/OOiF1OC4XSgThgkKolMQ8WmslcUSUrHccn
 7
X-Google-Smtp-Source: AGHT+IE3sX9UlybjNbCb9fVIVuBPqr25Sl5xOBrqLzgQ12xg5O0HIVKy77FfhaXvq6R/1qoOGKVoPw==
X-Received: by 2002:a05:6214:2dc7:b0:6c3:4736:17d1 with SMTP id
 6a1803df08f44-6c355e65a14mr98963526d6.10.1725307737823; 
 Mon, 02 Sep 2024 13:08:57 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c36e798771sm6934606d6.68.2024.09.02.13.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 13:08:57 -0700 (PDT)
Date: Mon, 2 Sep 2024 14:08:54 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10-rc4 released
Message-ID: <20240902200854.GE2479150@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qDOE9oYQuZc7nwm/"
Content-Disposition: inline
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


--qDOE9oYQuZc7nwm/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc4. Things have been and I am optimistic
will remain fairly quiet moving forward.

In terms of a changelog,=20
git log --merges v2024.10-rc3..v2024.10-rc4
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Monday, October 7th, 2024.
Thanks all!

--=20
Tom

--qDOE9oYQuZc7nwm/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbWG1YACgkQFHw5/5Y0
tyxqxQv/SeolYd4MrGjRRPhGqZBWUkZh5Feudr8lGRbukGT+VqFMzZiCTTAcpqlw
a5pfuWNRv4iZsheyt2bKXedYtvMaOKvkZLdx6nehgHweBBob0eiZZc4d6H1FOV2D
KNdJZzxs6zwN+m/jc/5P2/WoANIMOyTtoHY6o5JNU7eyJxM+i46NI6EaqHOoN93f
u3DU/biKNnfRoGSfR0J5sW3R4myT3ls860XdlTCDIBN4VomAhPAmXPKfOISQssGA
DVXZh5gRV09nXT+ZU5XdurC4oHm4xEUffxAIC2/DJ0niWIK1qPbi8dTxaqmdBYad
3gBpej+9PfmrdsxTRXIsnNbB97HbCSpT+sJuVSklwTZeooBIPyzDu1P6VOWOVThK
umfBseL8c7PpP6RIkQCQQ1ZuFMq3/ltjJMF8tOAQL57smIsigm46Ir2WWC1s/P7j
1zVJTC3oucPRDDYrZJFi1myyhSG4AT1mabOEKJuRXLVIER8s4PfA1sXoCLvzaTvD
wMq0QhZK
=N2/m
-----END PGP SIGNATURE-----

--qDOE9oYQuZc7nwm/--
