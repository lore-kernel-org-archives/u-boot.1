Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ACEC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 22:59:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51CFE60670;
	Mon, 24 Aug 2026 22:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id idmujl7p3g-r; Mon, 24 Aug 2026 22:59:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787612368;
	bh=iY2DH8+HkxMWWgWkU8KrLclZjK/WQOyCEQNKlzwrgJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rlrGS3HwtPod3uBbz9uh41XXIwmr3daEYv1R0jQQcQEqv0heX9CNLSOgLTPbsS5zC
	 Yos0sE+KFJ3EfJPBH7Nh2QbQe05uMhoKkJR5euGWocJFX1+m/szYLVT9QGg5MZVLbP
	 0/Bx55ZZW6vHGUJNRmnW96xZdJZ/8SvcapaPKEPcLRe4MhypYVp6B8MjzkV8ORzr3r
	 DRROdRXGGIhn51mtaaXhPN/vdiqNwIbDBUvet7w4hUeFxStm5dYw/rnMQSHULYj7GR
	 8CQO5Ny201X0rce6uPBxWajM5En9G6ROdk8u720C39FmRTWlDakUKuP9y4lI2cmkS4
	 cSXopoJr3gTfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22DD36063A;
	Mon, 24 Aug 2026 22:59:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B045386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 22:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4E8160614
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 22:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lk9j12zzvPmH for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 22:59:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::a;
 helo=mail-oi2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=m2hWZmB+
Received: from mail-oi2-x0a.google.com (mail-oi2-x0a.google.com
 [IPv6:2607:f8b0:4864:32::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3214F60608
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 22:59:25 +0000 (UTC)
Received: by mail-oi2-x0a.google.com with SMTP id
 46e09a7af769-7e9fdad388fso1413518a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787612364; x=1788217164;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iY2DH8+HkxMWWgWkU8KrLclZjK/WQOyCEQNKlzwrgJk=;
 b=m2hWZmB+OQn+3Jjg+pqBKWiMNT2NVISdOv9nhnEL6uBvgdtQIN06hjTerK72UGoT8F
 TJ7ZLU11h0tnYs8eebqO76PxtxBs4trMsuWsrOgv9tWLwMhVeBRXcn+mr1NEhZIgSAyd
 ruJy7r3dLWJ5lCaN9MmWGRmAvPTkjSFSxCwHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787612364; x=1788217164;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iY2DH8+HkxMWWgWkU8KrLclZjK/WQOyCEQNKlzwrgJk=;
 b=CdNgRxqJVe43QuZrDjZLze1gbSd6VzxYYUu/mICsa8psJexFsCyKCz5t3ZFrQgpiPw
 7HIcj19iBdKltoBfYC6fejV5c2vODhnnxTQMK5+DzGjqPJsgkZEjFXES6qvY2OKchXc2
 wuYSUUz9PYN5ZOzNSRqLZTF9ypdXeFTH7NRI1L1l9iuApRGWOTC70h6VdpXcl6QpSM6S
 m7tmC8NG7mmIqHQbO/XbfXb+8Pqw5S/BuT7AODbUDetr07I7LDAUbMzJSa12RZwLqC26
 /7bPlRfMaiul6mm3yNd/Xko/GoPLXkOzSFpATUwzLRo4lWJlHNiOFSvGzF1ETj9naME/
 ymrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rql0LnK93yq10df3Y4pcIyXI7WBFrnWBtPkx6EgN7PU/mxGKQnVI9Bj3bqprgC7qTJVh1U2pPw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1R/0JgMqp0ct0NTvaoXQLNPKqWYYn5/FNbhb3/Jqso4AZJW50
 +UypFa40Pco4O43LBE/qKy5BUVivbw3ca0CDX/l6dFfM3J/mpAlwJmI4aeCFhJBugKs=
X-Gm-Gg: AR+sD12mvfSZzzo4CT7F3qsbKPYo5+TN2XX/OxhyihS+29vx1KNayiycrsUJQS5g1xc
 +ZJoxMSRDll6bBIgz9fk9j8PTpeEdf3CvKJ1CmUq+pFb2rZgEMiiKhXDSCJNexB2hUFuD57aoNd
 vntR1+QoM/g29Dsa1BG1CAnkNygp/TQLbak3nVPOf79VmiBl6g0rHdvo1QaWrDrg+TS+2bz/Var
 o5vcbaGp1u9qsJOrL2YMnm2DJyR5EwkUIuuKNzXciwEzl2r0K+djlJyezzR5ezlfAu1kc7P2Npk
 c16Z2tG/9kDCYhh8k4ZJsOQTBuLSghSaSAyvW2LgPZmaKF75uMpGx4SqRlUKuH3WvrHCNo7YpeR
 qLxIU0DxhicfH3BUEZ1O1OJacBNv4UORAwbNv5stU4UA+WvJzW6AXMfw70J3wZJ/7Jpc2GcueRR
 9XK62vvOu3SFJV4ep24kAuyUKVCbeC7+0oIHTy8PIhrCVN2JLZk4HEtoYG8nlad3pvX4W6Nn84i
 /Rth+lTxNcLoI37te8L812ve6ecJWxTdAoRSyx4J5TOUI1xL7DsGGzTl2k9UNB3csKyoOmrKvd0
 b+K0l2V1ZA==
X-Received: by 2002:a05:6830:3488:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7f4765cdc10mr22852540a34.15.1787612364453; 
 Mon, 24 Aug 2026 15:59:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc4f35csm5561991a34.13.2026.08.24.15.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 15:59:23 -0700 (PDT)
Date: Mon, 24 Aug 2026 16:59:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Weijie Gao <weijie.gao@mediatek.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>,
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: Re: [PATCH 0/9] boot: add imagemap on-demand image loading from
 storage
Message-ID: <20260824225920.GO523975@bill-the-cat>
References: <cover.1787272661.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="752XJ1IvXv/nXZ3x"
Content-Disposition: inline
In-Reply-To: <cover.1787272661.git.daniel@makrotopia.org>
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


--752XJ1IvXv/nXZ3x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 08:12:43PM +0100, Daniel Golle wrote:

> This series adds "imagemap", a small layer for reading FIT images
> directly from storage on demand instead of copying the whole image
> into RAM first. It keeps a translation table of the byte ranges
> already loaded, so a header probe, signature verification and the
> final load can reuse a single read, and it hooks transparently into
> fit_image_load() so all existing verification and decompression paths
> run unchanged for both RAM- and storage-backed images.

As I was looking at the patches, I saw at least one checkpatch.pl
alignment place to fix, so please cover those in v2.

Conceptually, I'm OK with this. I need to throw the series at a world
build before/after and see what the fallout is on not-enabled platforms.
I'm assuming that once this gets where I can throw Coverity at it, it
will complain about a few things too.

Before posting v2, please throw this though CI too, I'm pretty sure I
saw a documentation style problem that would blow up there. Thanks!

--=20
Tom

--752XJ1IvXv/nXZ3x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaozMyAAKCRAr4qD1Cr/k
CkUjAP9gBZ8KH4P/8o3iqQEvKaAJG//6BFsseY5/ZhNEI4FKMwD9GF9+ntjwOdA6
fp/h2hH8EjPWcwkZwhTBgnR6y7WhMA4=
=0riB
-----END PGP SIGNATURE-----

--752XJ1IvXv/nXZ3x--
