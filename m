Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E579E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DCA89380;
	Tue, 10 Dec 2024 14:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y6d1VzNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDDA89497; Tue, 10 Dec 2024 14:48:17 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C21E89248
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 14:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-467725245a2so9171781cf.3
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 05:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733838494; x=1734443294; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=94DJ+m39cnA5J7JhmEXztAufiU0F/Wj3Mgwwa0gc+kk=;
 b=Y6d1VzNu7Zs59wg9d1JEXFwZLGBBtbE84sTf/Ut94CJEvX2DOJMjdNlAw4ZM/oG0/B
 ds8ZrfLCrtLw9FLiNIeQALWrV0bJFVwE6QnDtsTRf/RcTtY9OskoYsLG2wf+xcpCcrnk
 tMtnETuMufoNSf2QIDgiNpL7gVCES0+0GlsLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733838494; x=1734443294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94DJ+m39cnA5J7JhmEXztAufiU0F/Wj3Mgwwa0gc+kk=;
 b=KjGs+9Jo7e7dHCnvrzts5hJqlVc0tqV8kZgtNHVU2/3aU+g3HnItsaB6EfVbmWwNZj
 KwzC1+fnhmtFpGBv9hjlkl9Fzv8OuOnvO1KXT2x9eVOKCnzw4zG/Jco8W4L49GXsUzpC
 A+Tl8M+4ZlKr52FmzYMYK4w1PUwBYWL9joHf5b2tt8/td5BxvFe+KWQleMJFXh0jk+XA
 boZlBibA0Uf18dcON9/2F1L+YhqgSZy73NQYUfDRfbBhpGsmObR3NR3ReuRNcWiViQ3i
 FUjWNekcKposbCv6zB9X4Ry7t3zJXzyi5M6UNavpzdLf/KpYx8AdWJsvcCCkERVNx1tj
 Dsbw==
X-Gm-Message-State: AOJu0YyQhlDa21Bu4T8rsDKEABoZrL8rPjKP4zcgUukbO0r/22RQJo3C
 b6gi215DpeXh6y430FOWoomwC/fUsUoaiE3Z7SDbeCkhHdHPxV8YlGFqhWMlY3Q=
X-Gm-Gg: ASbGncsBSDS8UbKSEi9R17+ep+5uu8rOpoJY4euZPQJ235S/Xe1QrosVthw4PvRcWoK
 TOPLzhgRQT2LXE4u5FAJ+jkntNyVZaB8/mYfDh+KvYRl8Kf6UFKzqRDkRHo0QfklPxuL7xIGqKb
 hmMuCZE8yCLEJw1VffyWIaY3TX2QRf62zWpcYBSG7iLa46bhDZdSlueUmHr6DJKE+TC+lqNyati
 cyHQlJuksmED68YaJjpkxwItgWca+IUiI5q+1LSt2Egn3YOyh7lDg==
X-Google-Smtp-Source: AGHT+IHCB6h2x8TESYQsckFzjnzT6pa0orWqoUT0Y7Vrdr3D5U7TT5ZTCp4CFcDcG2o1fNrCndR4Yg==
X-Received: by 2002:ac8:5809:0:b0:464:c8f2:e553 with SMTP id
 d75a77b69052e-46771ff36c4mr73197411cf.42.1733838493990; 
 Tue, 10 Dec 2024 05:48:13 -0800 (PST)
Received: from bill-the-cat ([187.144.82.216])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467842a1338sm2553851cf.38.2024.12.10.05.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 05:48:13 -0800 (PST)
Date: Tue, 10 Dec 2024 07:48:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [RFC PATCH] common: board: Simply array with function pointers
 with CONFIG_IS_ENABLED
Message-ID: <20241210134808.GB2457179@bill-the-cat>
References: <9786c6124c959ca230dd2c23e8da794680f09867.1733837980.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6ZtKUQmDw1GGOcqf"
Content-Disposition: inline
In-Reply-To: <9786c6124c959ca230dd2c23e8da794680f09867.1733837980.git.michal.simek@amd.com>
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


--6ZtKUQmDw1GGOcqf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 02:39:42PM +0100, Michal Simek wrote:

> Convert all simple cases where current ifdef is used with using
> CONFIG_IS_ENABLED.
> The change doesn't have impact on code size and it is only cleaning up
> description.
>=20
> Checkpatch is reporting issue:
> space required after that ',' (ctx:VxB)
>=20
> When space is there another warning is coming up:
> space prohibited before that close parenthesis ')'
>=20
> but there is no way how to fix it that's why leave it like it is.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Thanks for doing the cleanup.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6ZtKUQmDw1GGOcqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdYRpUACgkQFHw5/5Y0
tywzIgv+LUnQG29OYoeVAk6p2Yjl/RODXFDMnkka22khpYkRl7tm8euL56BfaOGL
pg6YM3knEt2mEON7MvF9N6wAb8iHtsuHYMIDDGcso8tRUdf3J4JGHOwRIAKPrCan
9a9TyYF/HnVh2/EGqAUsXpJ/8XsEfBjRY6ZwUiESzrlf82wbKjYY5YfvedOUDPn5
LwdTbaShmQn2Ce1+YXPubD9ukm0F0ID6R9hlUx4MBztXC88fpMDrOF/P6leqvd28
P69pLTndw7SD2mxSbbJ27IVasR8ZC5xFNdWmhXI1s0xejGA72+KObT6Akj9hCyrH
lTnCgKnZec4qRFc7aXawpc5NmIjZf3DwQmoTbN8/qkEuQFqn+tbfeXRCYPk79jHp
mqCXO/tNsjlp+Q3ITOvPgAvs97JNJuvz1dSIwnOhLxCzc5r6mM00Caug7Qi6mVcE
+ycwVvX+vOd6+W5VRgIMD9Yesj/4n7fLFuIQSqZx8DWUL+yCYWACOPQSwsFYPWga
aP3EDQCo
=BL6B
-----END PGP SIGNATURE-----

--6ZtKUQmDw1GGOcqf--
