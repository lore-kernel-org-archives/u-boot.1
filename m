Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81013C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 14:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A2B876DD;
	Wed,  3 Jan 2024 15:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n4qcJvGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F43386F39; Wed,  3 Jan 2024 15:13:07 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B81E8766D
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 15:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f7da00237so54781536d6.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704291181; x=1704895981; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NiXHRTmq2jl4WTC8zU0ctIPb6bzG3KDiJWEex3Dd9s8=;
 b=n4qcJvGm5bgasjrXAPVdw9W4Wx1KjBUBN3Dd1veTwaHb4ff+MTxzo8418Hr2UgR4fb
 gk/4eBFxB/++EpUtKaBnzgFStHJ90yOSQvV0Kkm32QT+yPRxq0lOl6Aakgeh0xjRu8Kv
 wA8brwlLw6k5PA0sjlmRcDeM9ZFElMHgXWKjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704291181; x=1704895981;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NiXHRTmq2jl4WTC8zU0ctIPb6bzG3KDiJWEex3Dd9s8=;
 b=IhNtwEpdTZs/NIn2pGuQOhY4o0qW/P6W6nbw/k7lESVn08JEaly3pr9lT2fHC58LWV
 DttNjdIf5g5fepSfFlg+FpNt1OsPDr5Jewj9FPNy0oV0uVXE6c9ZgfIChHy+IRq8/gIL
 lwjxwPk+wD2jkdOSgfjmioh/vINNG0C9Vc6SzVDTG5U2WsWHSHoOaioPIp/PcKfJ6K/L
 p3IJVcDTfM47IZFTelg+iO+O0lXIHPyYaRP89l5hdiqr3yT0ba9bUro5B2edKKQp1qww
 S1aZWa5Ji5MPHTuEdUht63pvRFsqnUPfP5ivSRzQ/AK1uGLaCgVwFjseBvhG9puygrfa
 7qsA==
X-Gm-Message-State: AOJu0Yz+uml86ID9KgYGzOb/3n42yYeUJI2BM7Ys4NO0LTj3pSpky4xe
 C9jHkrPHH779/8UgutAppARN3EP+s6ZI/XW2x4RK+EIVnDE=
X-Google-Smtp-Source: AGHT+IF8QuIkPNd9+nltGEZMnFQvJWzH2uGYcfxqRpY7tYL8cFjInAi4hribF1Z0AbW6ouNrPsXGVg==
X-Received: by 2002:a05:6214:2a4d:b0:67f:709e:c6b2 with SMTP id
 jf13-20020a0562142a4d00b0067f709ec6b2mr22974853qvb.10.1704291181453; 
 Wed, 03 Jan 2024 06:13:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 w6-20020a0cef86000000b0067f77ca8d18sm10960153qvr.96.2024.01.03.06.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 06:13:01 -0800 (PST)
Date: Wed, 3 Jan 2024 09:12:59 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01-rc6 released
Message-ID: <20240103141259.GI1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TLTgimOVLkxcxUQU"
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


--TLTgimOVLkxcxUQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's a day late since it was already a day off schedule, so here's
v2024.01-rc6. The final release is on Monday, January 8th. If there's
some sort of boot regression you know of, please speak up.

In terms of a changelog,=20
git log --merges v2024.01-rc5..v2024.01-rc6
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

Thanks all!

--=20
Tom

--TLTgimOVLkxcxUQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVa2sACgkQFHw5/5Y0
tyxrQwwApe281NaHNIoP/3mpI6pVDiugM4VgCPFQem2VOyJRytwuWARcpAn51HN4
09Ubpm27bCYixL1ZNAqUg6ZNbsWZ7fE5aZfCHzCWpCgb0xOZxBKUkCuzyjzvhoRo
Ap5dyBeU+7h5hFgcCxJ9klADaWbVbCUuo+t7qbMonVDB2U2+o9YMiyNJr+YmR5ra
htRZOlBtizT7FVW4wenHgt/pyusTAMrS922JZh2V+DBAE2gVb2rFJDcUmwV1Nbk1
d614h8RCiw0F82+S5darsLJKIiL57jjCrjc1LlhxxCsZRw6ZeY0nhpPqUqIxTERV
liH+SQbQIdiIBuVVL4lldTP+K1VldJ85fU0KJXf08nOpQOWERrk2mStxarZoz83x
4cDxdYCECZm6+Pmc182u0nobHfcZ5im8KciiDVMvK0lWznfvsD/Q5013ZlIy+oOn
YFROj2Y+rh338lSzTC7tMSM1EOyfPE/2yPGeU8zO7Qi2yBxcmVvDG7tAUwrTFAXh
bbBD9XnR
=pikQ
-----END PGP SIGNATURE-----

--TLTgimOVLkxcxUQU--
