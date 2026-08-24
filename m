Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF72C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 18:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D51B405AE;
	Mon, 24 Aug 2026 18:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hbkr5WUpOeju; Mon, 24 Aug 2026 18:17:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787595426;
	bh=yEWLvcjSeHTaUdhJ6l4hSmt1tPNMPF8ZaX4IwyrRY2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jcDP2gnpLHqm297vEMJICmxEnkzNaRT99vfcO/E5zj60tGr9Uur73UjcdkMnwdatS
	 1vlodmoBe57qdqILA7Bm0NakJX+q8NjZQgUStfVbdcJTTTNEyyyBBjJdDy0k9/uuHY
	 8PJ7d49Fi8QcF9vj0yw3M3ZtGaWMsdr9t/JJlXskegmsXd0fa/4KoEn1NbK9zWNVQe
	 j6bm29E/dU+w2MDqfAtHF17Z4/QY7MA25W/3IuQRyLv+ooylQyHGXs04LZYMdu9iCh
	 6toR6ZXOvZ6JKnObvBXId85274NyKdO0cjLIf4bLABbVqItOYlH9R3Ipllf1QfdqSb
	 Y3xPNLBjmV1bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 422EE4057A;
	Mon, 24 Aug 2026 18:17:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B8A44B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:17:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18CC660627
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:17:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSBOeNOuJSYF for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:17:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::;
 helo=mail-oa2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=l9wGlvTS
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5AF6760618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:17:02 +0000 (UTC)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-451e8472960so2511780fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787595421; x=1788200221;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yEWLvcjSeHTaUdhJ6l4hSmt1tPNMPF8ZaX4IwyrRY2k=;
 b=l9wGlvTSSV69QqRLryKRJftQAyTfN5yCnmdUQ54oilvPABxU2Pvq7pVzipWB07ArCz
 eOcn1ANxHB6FiLDpTLl0GlC5c4V1FKpuWout1JFu3LQ6ICGOpctD6w0BLv1Xu1dVmyiR
 qTA9HsxddBnWqNYCBQZ15SXpUuLSKdrvrZoqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787595421; x=1788200221;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yEWLvcjSeHTaUdhJ6l4hSmt1tPNMPF8ZaX4IwyrRY2k=;
 b=Ak6HIaZAnruuo9ixT4J0EVo0SkGzJ4Ji1Pvy5LkAxs5xkCsWLHbfLNLNXEQfarcn0D
 1kqZAp3fwTciCEPl4gQwusPqYl6THFZioKPWyAk0/6b9v5FfD2ROLPgmRTEGeQyhSclq
 zaPkog90fcYjRO9pz7ls+3k5CudzeDMvl7mOLAdpQbgti7FFLqDPSkOAAfL0JhXFlM10
 ofN/YZrkHeYOJkToETbxy7ubKitqUME3We70pQRV+cC8D6i+HHt5vnnnfnsBYeRMdaZF
 rSnY3gfBY07VogN/s/x1oZIzDfiTiwcoPOOM1D0wqW9L3oWl2Dw/Qdj4vgN4uiyj34w+
 Pl6A==
X-Gm-Message-State: AFuF++lw4gm1A/Xa+2Mv8qgQWgO5WkfqeARH9Xev2T7uKKJwOCD6ukvj
 Ik9TIwmxKN+E2G4JrAH22Qn/iQOQy/NQbRijvkGpLUraywVVPRUORx36dVbA+yDIqK0=
X-Gm-Gg: AR+sD13YSoThBSQg9ZS7/ZmxAgalU5HzF2jZlifTokSND0A5dnpYMbl80UiybJFy9Eq
 sUIddP8dekCB1oPuXEdS0TfUNQjTABITYhssHIL0KiWLLTu7g/o2VJ1643D0rSiZBddp+3ervKw
 Coo5b3CXrXI5rgeX3w7A82ApClAHEMXJF01w74j8ST/T+cVJGeX2AJIz34BILOvj+i6YZqft3Zh
 szpUjYK4cX+lLvadLXHecwO9HTEv4xbywgzAx0HCnFNGQ00GO+ZQJhrn3XQUHAfxlZVVgfrkmZq
 A8x0P09W2BaXg9dRHNsY0eb2oXvyzZMa6omvStfaIZPZtX8ZIzmNqvCmvt88n+yHVsqcBlQhKnH
 BdGFq7Tzz27PJkWmUcVOnXS/H1+PcoC125CioXD2qreCKh4HibwG0Qev0pxosTdOwwFhzMgV2Wk
 roj7YOdspastTsk+wsdYQ5BXX6iMs5mmMq59qaUDCMpNRgCFCv7wjNKAoWBnQk/bajTG4cvGfEb
 3UrP7U0NG7KKuyZKvCeHmJQIwO83KUTFg3c1ujL196SwdikOR6X+coKHahxkraqTEM+JTCxu41D
 7k5OP3Y/NA==
X-Received: by 2002:a05:6870:4585:b0:45e:edc5:f469 with SMTP id
 586e51a60fabf-46350f048bfmr28230984fac.2.1787595421474; 
 Mon, 24 Aug 2026 11:17:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463834af092sm6068533fac.10.2026.08.24.11.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:17:00 -0700 (PDT)
Date: Mon, 24 Aug 2026 12:16:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org,
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>,
 Brandon Maier <brandon.maier@gmail.com>,
 Francesco Valla <francesco@valla.it>,
 Simon Glass <sjg@chromium.org>, Rob Herring <robh@kernel.org>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>,
 Brandon Maier <brandon.maier@collins.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 00/17] pylibfdt: Update the U-Boot version with changes
 from upstream dtc
Message-ID: <20260824181658.GL523975@bill-the-cat>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iBnIgU2+sP/bx8i1"
Content-Disposition: inline
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--iBnIgU2+sP/bx8i1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 05:12:57PM +0400, Alexey Charkov wrote:

> U-Boot's copy of the libfdt Python bindings in
> scripts/dtc/pylibfdt/libfdt.i_shipped was last synced wholesale in 2019,
> by commit 903fe17aa8c8 ("pylibfdt: Sync up with upstream"), against dtc
> commit 430419c28100. Since then it has only picked up individual fixes,
> so it has drifted a long way behind dtc, which is now at v1.8.1-19.
>=20
> Tom asked for an audit of the divergence when reviewing the FdtSw growth
> patch [1]; this is the result. Bring in every missing change from upstream
> as an individual commit, referencing its upstream sibling.=20
>=20
> This adds: hasprop() and setprop_bool(), get_path(),
> Property.as_stringlist() and the as_*int*_list() accessors,
> address_cells()/size_cells(), add_mem_rsv()/del_mem_rsv(), geometric FdtSw
> buffer growth, a missing Py_INCREF on the Py_None returned by the
> fdt_getprop() typemap, correct get_mem_rsv() results on current Python,
> and the SWIG 4.3+ return-value compatibility shim.
>=20
> Not included is dtc commit 5008d1d6a356 ("pylibfdt: Replace removed SWIG
> Python 2 compatibility macros"), which already landed independently as
> commit 527115ef6783 ("pylibfdt: Replace removed SWIG Python 2
> compatibility macros").
>=20
> The first two patches are preparatory: they take the parts of two upstream
> commits that earlier partial imports left behind, so the rest apply
> verbatim. The last patch adds test coverage, since none of these bindings
> have an in-tree caller yet and dtc's own tests for them live in
> tests/pylibfdt_tests.py, which U-Boot does not carry.

Thanks for doing this update.

--=20
Tom

--iBnIgU2+sP/bx8i1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoyKlgAKCRAr4qD1Cr/k
CrA9AQCLGz9HEqhxZ++KhkLsXp1WMPRLAMTMNRvk6oUR7EPtggEApeslaLGDESWg
f1KzWIS34m4S/v+kxBR/zMLzce4fQw8=
=nxHX
-----END PGP SIGNATURE-----

--iBnIgU2+sP/bx8i1--
