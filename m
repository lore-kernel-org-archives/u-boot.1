Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA42FC5ACB3
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12AC874CF;
	Thu, 16 Nov 2023 16:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OUqe0xO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F0AA87483; Thu, 16 Nov 2023 16:44:25 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C83B487465
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cc537ed54so5379611cf.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149457; x=1700754257; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a66gKTNFiw1i9kCQlrbOyy56eWhNMlLs3HS4DZyFVVQ=;
 b=OUqe0xO/eifp0DJvKZksX7h9oACO/3ZbCJhlwRXliR2jotgWBKLRdDPeluliWHT9d/
 0fFZQJi7znSHakCWE0IvDvExaGu6/9a5hF2dG8wAwoHc0tAZ6mQAxc+JJgEZLtcMJh2Z
 6z7cDZkawBgLPxqp+lDHQ0kViiq0D6I7oOPBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149457; x=1700754257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a66gKTNFiw1i9kCQlrbOyy56eWhNMlLs3HS4DZyFVVQ=;
 b=vB/cxcUDywTeDR5gdY81ylEYra14g8lA4YTMabqEfbdkkNLQ0PYJTn6fDxshd2ELgN
 /OOO1LTuE0kym2RpyhTfOJSghByw9aMmePt6GrDX0YoIaNeGN6XaQ4jw+01ozeaNHF9R
 ZebAoA7DqLL2vBu+BNAICkwfKFmhXBtny6ZkxB57B8t1I7TzyGReDoybpg1MtgcIdE48
 UuCrJo3DBW+EO5BytkWbwHgk8LBdBqFe56ZEld5lP2IDmvv5TTVZCfOx78QC7zEW0eoo
 AdCKpuD6mUvs34XcGc9yLetOS/b0pdMHXadXiDyb3JBseyzCxLZOfx1gE2fqtFkticAI
 pkPA==
X-Gm-Message-State: AOJu0YxWHeFJT5EQSPQJgLmWOoJa1d7dVijRhlxV0Eb2H5FW2tNIBLmK
 zXzclfsMgV8zZ48Gk5vlMw0aew==
X-Google-Smtp-Source: AGHT+IF+Az7PW/kBGxf1VCiWFc4AJ2rlU4z4UZC0Wudx/PM+bEY/rJxN4xX8AMpuPcVLk3tGKQC/Og==
X-Received: by 2002:ad4:4eee:0:b0:671:560f:32fa with SMTP id
 dv14-20020ad44eee000000b00671560f32famr11974706qvb.40.1700149457643; 
 Thu, 16 Nov 2023 07:44:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 py17-20020a05620a879100b00767d6ec578csm4384204qkn.20.2023.11.16.07.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:44:17 -0800 (PST)
Date: Thu, 16 Nov 2023 10:44:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 14/32] bootm: Adjust position of unmap_sysmem() in
 boot_get_kernel()
Message-ID: <20231116154415.GN6601@bill-the-cat>
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-15-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="doBhOn2cgWfVvGUS"
Content-Disposition: inline
In-Reply-To: <20231116041043.362055-15-sjg@chromium.org>
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


--doBhOn2cgWfVvGUS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:10:14PM -0700, Simon Glass wrote:

> These unmaps should happen regardless of the return value. Move them
> before the 'return' statement.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--doBhOn2cgWfVvGUS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOM8ACgkQFHw5/5Y0
tyzH3Qv/eIWkVaqMpkbnZw4dw445Seir8sp+9hr70iLbnfVFhI8gAjO8IkV5ue0j
/ruFx9W9Xcy9U1Br+stD96mygyOKma6Adp5IJWv1ossiwF1o13CWSfTFdO29JQaV
DFvkeog8VejAxREkFVRunUG3mkvd0jOlhxxJ7nUo4e3TgcCxVjzHXJzQzNEBNjyd
7CtVxMhI5YKYHcp13XCbGyFv8jbjPHq+Gp14GtpRX32WedO7EzuUIhj3C4S0ZeaQ
gXhq8qsXjsvliOeQQsKthmONSvovpm88junULyFPQ5Ymt7fdkycJ3mJH0ty4QKB/
hXg26DPR39B5QAAQvbEmeSK7nozgyx3ZLyMyhhrvSojmH6KinKVAtcgFJGVHOM4q
xXKWyHM86zhL3sgkhaAEMd7P6DcT50ci8WvTwWTIQwUu/XwALyOZarsQO8Y8J9aU
Zm9g5upCKJ7Qnt5e4b90wSrj9yA18DCN5oPRlzkdBEj8urCO3sSpNxXvoPea96zN
RCdFDBEu
=LeHQ
-----END PGP SIGNATURE-----

--doBhOn2cgWfVvGUS--
