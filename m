Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A834C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5875D881A6;
	Sat,  4 May 2024 00:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XzwuYQL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04342807EC; Sat,  4 May 2024 00:21:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65E3881C8
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ee68823724so87747a34.1
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774868; x=1715379668; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HAgQyh33xNh+8z4qe+JHZ2ewvUdzCjpyr3QIBg4foFw=;
 b=XzwuYQL5S59ZBi2/qjiFxoqG+HGO+6ghEv2hIUp3fQ763dfWUcS/yhq5p584G39yyo
 geCBm5/CjMoI39XsMZrLj2R7db5dy5EPGu+cAXucqfQSJ3a78k+hr6x6vanRRjqCL7r2
 ql/V00M0ogp3bQlAU3w0wzF/r6GHberiysW14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774868; x=1715379668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAgQyh33xNh+8z4qe+JHZ2ewvUdzCjpyr3QIBg4foFw=;
 b=M9eJYkX1VhCOdaBCTbTWabdA57T8COakYJl75D0B1+nVIbb1FXCCILTUaCjLdILZsY
 do7XNUS/ZHcLPR6zwVnXr9u+9SYgMZHqUfNDagYLdDZeGenEqTBM+m4jcQZOalBRCQ7y
 cuxN9dKl6hb7A4XJCV8HN2lgP1Qh4st6WGM3Qzlb/v2VNQS4FzCN97utJOPE8MjRetR9
 b8M4Ri1x5kBq169D1ML9TkCKd72TNeNKmsP6FiUdOEiOyLV/VW8V+Mz+30cWv7TaoUqe
 jXsXaAmDKTf9XnxlNMKmVQ370j3TOj/VNyauyXksCZOySOiMBpX7kcMsCrRT8IN+JNqX
 R4sQ==
X-Gm-Message-State: AOJu0YxbwB2cnUeQw/pbPtWvO4Onazq4uG1OkUS0qeB0RsOBQeXMeWl6
 iVumPAxhHzpEJ/b0H5UYcjJncE0blkpIAEYFcm5frKuOJOs9tGSS0I1u4/BkHAXYvVtvoUaQnBU
 h2So=
X-Google-Smtp-Source: AGHT+IG23cmt9KWUJdm17fMqyainieTEwAKQuRQV7AS+AwgbIsCh9hHHyTLgbJGU6/QxXh8S36G3SQ==
X-Received: by 2002:a05:6830:1d61:b0:6ee:1d67:bbe9 with SMTP id
 l1-20020a0568301d6100b006ee1d67bbe9mr4431683oti.11.1714774868681; 
 Fri, 03 May 2024 15:21:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05620a0bc700b0078d76c1178esm1588668qki.119.2024.05.03.15.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:08 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] binman: Fix typo in mkimage etype description
Message-ID: <20240503222105.GD2568172@bill-the-cat>
References: <20240425225452.496150-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ml7PGoRzNiwZl9eE"
Content-Disposition: inline
In-Reply-To: <20240425225452.496150-1-marex@denx.de>
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


--ml7PGoRzNiwZl9eE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 12:54:08AM +0200, Marek Vasut wrote:

> Fix a typo, no functional change.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ml7PGoRzNiwZl9eE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y1EACgkQFHw5/5Y0
tywVMAwAh/dmUp/WfLQUgwpghAFb3KdmvLGrdauuoEOKWUmbcXH3pO2rwpGQ7Kyz
nho/blYArxIbUoTJqRLgV/JGz1867F+7CYC79etfklSpaHwQHxzsOerT6XhQZMSJ
jvR0za7ZZyrt6yi2asg/hDs94kMTi1lpaf46gXO7uO7U78+X35zasLEKUy2226y3
vdx+tcCTvu7FG2FBZOuomBpOkogYpu9+m06s14V+bVAifT+N92KmBG/O7F6jKyKn
qqcEkuiQf+AEuZPg9KvsAbmQARNtTsmpQaQJ5LSrHYvV4OBqH9D9RlqRkHRfGD/A
7mI7dXMqomsqkcKuB3jbk3SPMP5kiQmF7klZ6tUXbrHWMPpNYMDLUnfKv264o1r6
IOwzLtI3dL8KlcrIPsooOhUiXswMjcMpitVswI5v7ab+M8Na/nmbiGY4yJ7cBeC6
sxCWs0yMvZtOK0OCQeSB4Q5WNHCXWp4JZQ1o1bhrkBWp710l8oNmuJ81egbs9kMf
MHwM4iMi
=4WcH
-----END PGP SIGNATURE-----

--ml7PGoRzNiwZl9eE--
