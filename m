Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA882CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 22:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA7483987;
	Thu,  9 Oct 2025 00:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sijHSuXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A741839B1; Thu,  9 Oct 2025 00:09:10 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB857838E3
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 00:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6500448067dso174245eaf.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759961346; x=1760566146; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L1C+iPEF3a60+RCALdGp6fHI5H20Vy4b7oNnUY3IPBc=;
 b=sijHSuXhRH+1DSf5Au629FspiUHkFW4A2YO+yfM4EZ15tYreGriio1Zp6YtbmdmKTh
 zJr2CG7wr/MZjqgyowuUd4bpQzowC4VChZpGADded24WCym1xJZmGIrxRa3N/SKVDQiZ
 nBmTZw+ASczGkFjgusoK3OewcJ17L/J7u0itU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759961346; x=1760566146;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L1C+iPEF3a60+RCALdGp6fHI5H20Vy4b7oNnUY3IPBc=;
 b=SfnezUSgAEqPZKkO0v/r0wK6flBVY5vsuN3FE9GMSWIPwH+galPMcVdRLZoc2IYKEE
 Ttc62/tLDnqNLZguAiuFDCPF+LTHlUs/qZybumKFf9cOAydVgjBVUNUvgT2DP8EUCQZY
 jaFGxzRcW5z54B0ylk1m68qoSvJ0LxjJ+2fZL+xexAaL42uyXp8lc8eK3NHrAVx0IP5W
 3IXZuh8c8l6hFUHHPpEOj0MSKOZXzQX87TKUxr9DrjfbFsdm35epg9zWhJZb9jpYI28g
 WF3cAgXgQSaalv4pcDRFIh2fS/j4bYvZjaXFVcrq0KwSSK3UedSY1WhQWvErstHRb2Fw
 gpfQ==
X-Gm-Message-State: AOJu0YxZb8a71nt1Qu6KZgRmgb6ZCZqfkPB/pbL8zTUYEG2MA/yXCGvd
 2cTuGB4EOQeiVbE/P+wtDIeH44q7kHSBQqcIFTl/z0lL05i1Fz3SqvmIfSdm2INfMzWjzrh+Bun
 /1ovzHaw=
X-Gm-Gg: ASbGnct1GIo5iBLtiRYyrGgfRJ1XdEV/l7e2qoPQcH0mKGneBnZf8NNonHaZAgzLz3T
 kImcEPgRol5QgzsUbxiN/YVXjQJnicwz6VhqrI3wX9vcZsj4Yw7OtMSCP2tOwyaFnZID7QMwQci
 NKLjSlukB8zwTmevxV2Mz9mDfUaLKrA+ZwT3xdodEtLsKSqGXzxAg1b+ICwKP86UdbMkd+NJgAj
 uqGhmJqQGY26Mp6HDlB3CXV42nhC1TtPDd1tjnBW2MtoYPnrsY3kiR+r3c7H6w0gRWPyFW6Cp50
 9Bv25MJHxJHjUJq+PLiay3eyx5fPMaZhl4wzgb3RxY2aXulMBIvbW6jjVt0sn43TFkgu02ZhCXZ
 j+qq0UEBgfD3wF4MbiJSNdu4ayPsbILjt2/8sDbWR2eVn7MfwqNfeCh8ZOqXF24pkn+Ez8nEgYi
 mk9eQijQuqLg==
X-Google-Smtp-Source: AGHT+IEz/8R+tElAUe9FWV9uScwVJeSXyL5Xnig69SzC6TIzSwXvwBEJJ6Vu9W98TxG0Wik5n39QVg==
X-Received: by 2002:a05:6870:d0c7:b0:35d:a9e2:fbde with SMTP id
 586e51a60fabf-3c0f51a5b6dmr3025856fac.3.1759961346603; 
 Wed, 08 Oct 2025 15:09:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e188f3dd9sm4283833eaf.3.2025.10.08.15.09.05
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 15:09:05 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:09:03 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Merge of v6.17-dts tag to dts/upstream
Message-ID: <20251008220903.GM298503@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wcKT3z72sm6rjnV0"
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


--wcKT3z72sm6rjnV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I've done the subtree update to v6.17-dts and CI looks fine, and so I've
pushed this out now.

--=20
Tom

--wcKT3z72sm6rjnV0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaObg/AAKCRAr4qD1Cr/k
CsUVAP97jwzoWFQg+4MwJVKw7zZQhk8FmnwjyS9A4z0FVmdOEwD9EXzMlC9y8e5A
OZD0GsMQ0U6sfhpASFAug/PVjnzLagk=
=Asut
-----END PGP SIGNATURE-----

--wcKT3z72sm6rjnV0--
