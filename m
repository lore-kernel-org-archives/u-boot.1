Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F3C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 22:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D018187B;
	Mon, 27 Jan 2025 23:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUuENe1g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DEE981878; Mon, 27 Jan 2025 23:40:29 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD3D812BB
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 23:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6f1be1daeso543198885a.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738017625; x=1738622425; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JMXaecYd1iPgFRmsGKi02slPYGj6S7xT4uGUQqpKPUY=;
 b=nUuENe1gaq4sYHrPj4Gw7mV2HUdsViLL8/s48PtCVXIYGFPKsjRsacINwMNpLArbF1
 3I/niuzXADnykLuw0azBrV37qwFhY1MmhSNgTwM5If2afDQ3BDkAwW9iDpW9LMVSt/dC
 KNarJ1aw5M1JVKVqTb/DHFovKPCM5XsC7/89k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738017625; x=1738622425;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JMXaecYd1iPgFRmsGKi02slPYGj6S7xT4uGUQqpKPUY=;
 b=gWm/zdYe6xiWYz6O0116J1NtXnDDyb+H9dxUMH1PRXhfrWM7AsEgzb+BFtAYNHKu+w
 HEGMZxtx+Qkdg27MKC/kzklIGOpVnirlPBLWh3KlkVP85Osyg7k3ZPTkmfpX6lEpkdZ2
 GWldB/XI9RSoZEFw9qja9x6a44v7HuIKCnZ4aA4LFwHGtSB3w30FKAyMvlpm+wcOUqtp
 fgPHhfKbOvzVhl3emlTf/u8/NP+6fDe0O2gC6jiIofxXIHGDkvCGAxk0A3h6fhLVzTv0
 3ucj4F2TXEqkoFS5k5XfLaGmXIl4zmyMe7tbcvlyGpRAAvviWXJcjsadchoMfJVpoImY
 CVRg==
X-Gm-Message-State: AOJu0YxlJbpnjEClDsog7vMG6BT6kKbKw3QL1EmSv0cb8iKn+/9eO1WK
 XCPwc34yv24oJvmUbPdvzPn2BRAkJ61o5MFbvOGswNaS96p7qd2twOY0VBVbERu6JT1J4ZMvsV1
 H
X-Gm-Gg: ASbGnct4ja7SsrSJ0qKDcjKqtTipZPiTr8SxuRvRm0uFOF9cBX1rJVtyYIh7HXgXiCD
 Kr9BqdmLKA1jICrpRdlMc0rf5EqHWoBUFv/iO692Ix0KFBRO7YjAPClWaGnx9enxMgum46fb6W2
 YWk6O/R2kkuwD170gapt8g0SuKhJ+m5AMhok9CcE4A0ZZf0U7Gltkc5NC2SSxSmwRWQS6dK86I0
 TWoDkAWI/VEnAEHBrqI7TGcHDGt2oZEbCDGb3VxSmHCd4eweFisPRwxLDXtDpagBuLZQsKsl+XW
 jxmm
X-Google-Smtp-Source: AGHT+IGUxQmq/G7C9dqYRVrZVEKtIwrYUajAVJf4/kWZSSHa7+DIuyH5fsGy1d/i0/Ca/v/Gfubxjw==
X-Received: by 2002:a05:620a:4107:b0:7af:cf07:905b with SMTP id
 af79cd13be357-7be631e521dmr5801041585a.2.1738017625212; 
 Mon, 27 Jan 2025 14:40:25 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9ae97569sm435133785a.50.2025.01.27.14.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 14:40:24 -0800 (PST)
Date: Mon, 27 Jan 2025 16:40:21 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.04-rc1 released
Message-ID: <20250127224021.GH1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VQt5nlCgQ6IjMLgF"
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


--VQt5nlCgQ6IjMLgF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here's v2025.04-rc1. For a -rc1, I think we're
in fine enough shape. The next window won't open until after -rc2 so if
you have some outstanding patches that you think should be merged to
mainline for v2025.04 please speak up (or for custodians, send a pull
request).

As I mentioned elsewhere, I've scheduled a video call tomorrow at 9am
-0600 and the calendar link is:
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DN280N2=
tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhY=
mQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=3D89be7b813136bec06a83de4=
da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
and I also send the meeting invite via Google to the mailing list. I
plan to do these regularly, post release and depending on reception the
time can be adjusted or perhaps duplicate meetings held.

In terms of a changelog,=20
git log --merges v2025.01..v2025.04-rc1
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks and the final
release will be 07 April 2025.

Thanks all!

--=20
Tom

--VQt5nlCgQ6IjMLgF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeYC1UACgkQFHw5/5Y0
tyzjMgv9GlVSFVLGSi77bDx/2RHZ1TBeSZmm38VvAAuxKcsD7fCLPvyD9ZywF0hq
6WzBAcM1Cgiv/jXMNCAe8ehYIYCaugmpsTpqw0suCTo3x5NbiQMMmDDNgWcdH+y/
gTGzSGJWHv8mj00V9flTmNDZ5C6dXpeE1ovgu7Euv8BN/52YHfn1wkrE7ycDyRD1
z++ZnAIaTN5SW8hvkHcpD6UZyWgENOy1QXiIPa1pmqdryHhdCHg6D/FcD0a6CJNZ
NkUSXmYOjiObdtgUMuz8VbHcBeLgkX3FxiT/6lECSBwIPadXq9z2yg6zuINrdkjR
BgZNTR23tYaw16m9a7RKlLU/HJhbLRE6jTmMiTtq/iC5B1TAGWj9ogKbyihwar22
009LKWLNzi0qrBdhHBoDBhkA9UAxeqzQ4vjCs18F5fuIixFzOG2Yrfgvb5u6UxuG
eaI+cuq3feiA2KyHlhGX/DIGVvvTY/Ug+udtR0E+OzIidZvspVI2DWqYahgJ74lt
Zlt5KQbK
=kGTb
-----END PGP SIGNATURE-----

--VQt5nlCgQ6IjMLgF--
