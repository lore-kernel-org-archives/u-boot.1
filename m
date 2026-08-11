Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ED2C5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 15:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17BE380FB3;
	Tue, 11 Aug 2026 15:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBGAqFm-y3m5; Tue, 11 Aug 2026 15:19:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0E518108D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786461567;
	bh=b/v19eAphnbhaDQY35wmLtSGKI7Vu1szpksR3lTJYGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EltlCRrMXcPtYdCmYSfrWHTFcm9EuO9bb9GZw/0aqtJKAiKrhzraRkJ1jpocz+fVe
	 3r/xSDiUykr20VKCpjlBOjnkBj085J4C2DPOV1RODDPh14yJoQ9w9GxK3j5LMS1ZQl
	 KKJFLK4vmuCq6cCPtC5dM8FZ+9JlpxWQQJ863t14/iW2iwMv+rOpQfwowVyxrzw4hm
	 aeAqPGEo+KZA1MhK7Xr6qKo7QZEbWzUYJF+F+8m7VbwrZWT8PbdRgK5H9EghLa9NCH
	 N/tXxT/Ysh9+0JaV+vH1qs8GVgfS/AtbSYlrjJW+/Ya4D2Qt0UDyRtBEstdofVwGOh
	 WC0ZPMOXhqijg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E518108D;
	Tue, 11 Aug 2026 15:19:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 286DD49B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:19:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 041416062D
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:19:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJWln3xvjTlX for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 15:19:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 31EF9605FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31EF9605FF
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31EF9605FF
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 15:19:25 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7eb787dec99so29848a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 08:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461564; x=1787066364;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b/v19eAphnbhaDQY35wmLtSGKI7Vu1szpksR3lTJYGk=;
 b=L7y9GjU0bKIIB9PYQmNlnKsMD97uaZYn9Bom5MXYDo+0t7fAsNQgJ8DDaoZUKPp5bM
 znqEHJ8HdZ3O/axV9Ks+3aDLcN0wQabtIvsk5qSWCSMf6bm59z7VpNyyr9pzkwyogRVP
 kjQgzxqdau7KCrpG3jNWqnvpb8r6rsUcNGF5kM5oSgWbGdoQutcYJHqJ0i7y103Fu7b8
 OD8Uu1dZhg2OA1VsElpszx8zoxjRdqqee04WkgqiUm5ipCCpEVeDr7bjfxbE8gytS3Un
 omKJQNfDNlXSiKL+pxIAHuOvpaD9wUsFuWrnnlGgd59161/SO8d0rYEs32JUhjfdm/pU
 sg/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWTFLXu49V4nKxfQTMFhmecpaMLwFbscw/kTo5fihac0lImwogVlTZ0iwpT2sKMqV1g6W3MOs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywom0vup0TDRrHjsIBbkwaY6oUERhRAuHdyyBqeLKDpkY8tBycV
 +CN/Ia9Wl+1wMIpCoKJu+dZwU9eLEmRevzuKBwM8MrXEMiSvH+Br1Jq3maJUcEwfMZA=
X-Gm-Gg: AR+sD138nax3CbOkFhDcZ+qnH1DjoJwxxxJ3dQUQKE/3hVoq2Y4le7mBBxMZIa4LhfJ
 oKrOJQcpd8+3m4K9HwIVs6FN1Ol1VoxLJYw3YDxCovHeWXS228gPB9ZdrTuKn16aWtYfWCqugMH
 +mhmvswTk/KCz5U4uRq0ren7eyoOACHrbJZmOsS9f/F5AcfmQQuupZJRyYw9dL8CAu4GCRpeNFs
 I5QBV+dtxojL7XdhSmi+HE184joGtPrKq24gupCrX3pxEX1Lgv+2ENbAVqCNDGAeWDw28mxTntg
 hwoUhbetGJMnbBPLrKRIzyeZcKX+XoiyVkn0lEXkKsQm59ol4b2bNVTSHg3gdYfFbDqKrHqUi9c
 MvzpfAFkJl4pZRIJlVCH86PQAaAGXbXD/Sq+NXxxhrlRpkN3wf64/GC9eICAhUOEN4OQKrEezkV
 gfCvXorJpFQv99zxnIxRV49H3dPnA8yXO4nE6S3l3t9iCIGqtsv0Fuitnp9iBWW8inPSPodCO+Z
 DPbcjtMsHx+Nd/UB8VZ4OoeRHGt7cNYpJr2f7xX+tDMJCyq9RutjqchlA0A6H5eMB5K1hdBDHgH
 YnVbPv8mNQ==
X-Received: by 2002:a05:6830:2116:b0:7e6:f7fb:967f with SMTP id
 46e09a7af769-7f3a82048f9mr2832353a34.2.1786461564123; 
 Tue, 11 Aug 2026 08:19:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3b34266e4sm64434a34.23.2026.08.11.08.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:19:23 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:19:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/2] include: linux: Import hw_bitfield.h from Linux
 v6.18
Message-ID: <20260811151921.GA3044694@bill-the-cat>
References: <20260803184314.2240153-1-jonas@kwiboo.se>
 <20260803184314.2240153-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V2J5405huH6e1GKv"
Content-Disposition: inline
In-Reply-To: <20260803184314.2240153-2-jonas@kwiboo.se>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786461564; x=1787066364;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=b/v19eAphnbhaDQY35wmLtSGKI7Vu1szpksR3lTJYGk=;
 b=gWCAUlzMEcn8TZ2aJHLj4h17c9e2KsIqetgIK9JVS+1ZCPSx9WEyANQaB7XIMAJAoW
 I3TGd2kdk3GBI0OTRVZAsG/0p+M1xr3nP5K+g/afHS3CjBadcIWSgmNcHD+CWmVfugXw
 g3CTTlF7dTATwb4GIvZ2P6hb43zXLruCotJNg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gWCAUlzM
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--V2J5405huH6e1GKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2026 at 06:43:12PM +0000, Jonas Karlman wrote:

> Hardware of various vendors, but very notably Rockchip, often uses
> 32-bit registers where the upper 16-bit half of the register is a
> write-enable mask for the lower half.
>=20
> Add hw_bitfield.h with two macros: FIELD_PREP_WM16, and
> FIELD_PREP_WM16_CONST. The latter is a version that can be used in
> initializers, like FIELD_PREP_CONST.
>=20
> Import hw_bitfield.h from Linux commit 21368fcbb124 ("bitmap: introduce
> hardware-specific bitfield operations"), first introduced in v6.18-rc1.
>=20
> This contains two changes compared to the Linux version:
> - include of linux/limit.h was dropped
> - use of const_true() in FIELD_PREP_WM16_CONST() was dropped
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--V2J5405huH6e1GKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCans9cgAKCRAr4qD1Cr/k
ClbkAP4wJ/olYpS/5oP621ucPt7UM9yKywmkTDpgBBdQ1ETkKAD/SFK9LZos3LPQ
78+U6xDOudfAPC/pIF9kDvtUMIdkOgM=
=1Q0t
-----END PGP SIGNATURE-----

--V2J5405huH6e1GKv--
