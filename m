Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C15C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB35582982;
	Mon, 28 Apr 2025 23:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QRaCIpWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B158C8277D; Mon, 28 Apr 2025 23:40:46 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A48482132
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7304efb4b3bso2925948a34.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876443; x=1746481243; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/V7sLmp5Bo5S8ix4TYd7RWRE42yOIoyI1rYXIcxMqrM=;
 b=QRaCIpWJ6/Q44kLeixn6zIQd4Xf2uV++ShH9hIFbpXhk8FNrgDDFcSCYpmU69KT8Hp
 zn1m8vedynXNo6veUcL2cui1L2SoDMkPF35kefXx/GZYVCrBkT0dOENinmCPuYHMFvXY
 /7LP+Q0VfCqsW8SLETqVWAErVEXlk8QeoO54I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876443; x=1746481243;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/V7sLmp5Bo5S8ix4TYd7RWRE42yOIoyI1rYXIcxMqrM=;
 b=uyGp6D2dFWFXoeWm52KcwCkN+l5vya+hrJmkNu8d1OOKhZpLSmDQae+52I7OKBrD5r
 lFVdr5qTnggpEdPGLpgvGE4KBghQjba0SqGuK+VcouxMcjvmdNKl06sAPBoIhzX7ja5K
 De7facUYYVtWsJJ4XEZ/qC0raSGfN8CjYUiZiy23H80gJbo8IbkmxR1Gc1L8AathvHlT
 I7nDvA614AxL5igYbm+2ZpevExuvZOSM/gq/enJaY/FXMRoU05LA0zvS4aYMCsyRKvss
 rxKj6YnuWNx5okskTgy232a/dfNV94TzGEBo9BT5syC7CDCog8B7E91oEMB3vMB5UV5Z
 GjpA==
X-Gm-Message-State: AOJu0YxtDAZOfSzwo+JUbhtQRmtqqJUj6926mto8UAAgvDfjd9taANv+
 X/eeQRkPbGsMRJQhdzJrP38a8TWx86uXjjEERESzgKN3aS+vXxDXRBHb0VEBuPJq9NP0WDB6FdZ
 Z
X-Gm-Gg: ASbGncsSVSnLMSloKdxVxikD84UPxIPX7Ezo1JhjR6eVfB4o4ACgDDL+CD0v6IZySzF
 SztheoyYR1jYfjuTnfgDc/SUyeHePVUfJ2bRD56ef/biY90i/BhNgUZ+t06hI2NxQtUP7pyxmT9
 cysk1wbDnOqzKAqTDYLcG/G5iwuiSgtA8E9wpmNGypXXr2DQCPnIvSx1CA8lghXMhBbVexxUd7g
 0Bqu1mFqWlVT1VXhJu8VnZrzWKQJlT1plrCt+UgvIXKb5g3MPk1PCr5wnTC7Fa5spu4VN6s2m2e
 R8Gg5RIEQK/TFRqNG6K98x0NEZBNr+Q7UtTSw31/4Bk7is0X2uU4128OhMEfj2dNJgaURu/phxO
 PvA==
X-Google-Smtp-Source: AGHT+IFQQxFBfl73Np+oBraPZvc/Tej3Frp5sLcZytmF14UD3GMbPn6MsUTMkr6AujgEg5HOVMdmxQ==
X-Received: by 2002:a05:6830:4708:b0:72b:a175:2f1d with SMTP id
 46e09a7af769-7308a5a340emr218187a34.23.1745876442923; 
 Mon, 28 Apr 2025 14:40:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b0f963dsm6723a34.1.2025.04.28.14.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:40:42 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:40:40 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: Missing UTHREAD doc annotations
Message-ID: <20250428214040.GH5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z3o6Zedx01tOt9gW"
Content-Disposition: inline
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


--z3o6Zedx01tOt9gW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

As part of manually building the docs before doing -rc1, I saw the
following:
=2E/include/uthread.h:56: warning: cannot understand function prototype:
'enum uthread_mutex_state '
=2E/include/uthread.h:64: warning: cannot understand function prototype:
'struct uthread_mutex '
=2E/include/uthread.h:56: warning: cannot understand function prototype:
'enum uthread_mutex_state '
=2E/include/uthread.h:64: warning: cannot understand function prototype:
'struct uthread_mutex '

Which should be fixed. I also noticed that with KDOC_WERROR=3D1 this did
not fail and still produced an exit status of 0 which is why it was
merged and not noticed until now.

--=20
Tom

--z3o6Zedx01tOt9gW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP9dgACgkQFHw5/5Y0
tyyD2Qv7BJlrMG17wAIyL80m3/nUMp1iUK2nt9Oa47D7IcZqtKiYOUEAMBLuaT0z
lcOdqoekPt74S6Rn+FS+Ps1AWAwVn4ec6olj41CU8SUfVgtthT20SDwwgvif7DrY
U0EEt80hQwx8QNZMoklfHTCAkjlbusuZ0jdsJYffJXQ6wIJPKrz6k/Zs5qMlJAHK
UMsSLbUqOjEgNtGQtEKgyQyB7lcnGG8jIinecl8ZlhUX88GCgb6XAxVVNvbhm2LG
+OAd0NaehI+pt7/GGmBqtJiJzTSeoC9V4DbbEv03iiCltGg3/I3gObkZRdnzHjAA
XgdN78oZAySTBEX84hDfwnL2+sWXBoc65/Sir5rmLCw4sB5AS+l8pLdm1lgVNpiY
s6i/qjzCM42Bwpxp525xpKg+XM3O5RyEGMLKbHIfqvQUGQGDlqddJ8Ps0XPTu3BP
5pq+Lg3Wt8Rio3Zhl/4OMn0QswlIve3ZvwqQH2Qq8N/z7PwH5q0rdC6/WuxglGfx
sNKLRkri
=TalS
-----END PGP SIGNATURE-----

--z3o6Zedx01tOt9gW--
