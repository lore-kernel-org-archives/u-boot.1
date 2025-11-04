Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C8CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 17:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD40808AF;
	Tue,  4 Nov 2025 18:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QqMRTYc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D398144A; Tue,  4 Nov 2025 18:05:33 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E988003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 18:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c28ff7a42eso1841009a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 09:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762275930; x=1762880730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nRvqL4KshhNZoWl9aaE924emPJ/IMSDRJOoAXIcMGxI=;
 b=QqMRTYc0+QBoStpOL2o6TSN0HJW5LTI7rinMhO8fip33T4lJEDBD2wW6q8HxCKc4N9
 +R+06YdqBCtjLYl30y9Aox2HpskweWKjPCJ2WnCaRLtPhM0nRp7PEHcbT9pdyXju3sov
 Zuq8EtaVirDyWef/bE1XlponKhlvbuo0mojdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762275930; x=1762880730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRvqL4KshhNZoWl9aaE924emPJ/IMSDRJOoAXIcMGxI=;
 b=vkmCpYGc/HgPyPNnVH2S3cd45k0TXqhYUhafGDjDMlAkaQ2xCln7QSAK0/Y1FQk4Hb
 ebyrFp5i5mkWrW9tPrfECGsbaSx0oiH4M9xir2EGRAebbNlSMNHdsOznxL4vjlf2krsi
 oDGp4DV3E+UPKBXAFZUSK1CrymJ6xEL+m63ujxlWu/FtL7Lzj1nPcRWeLfiKVSAcoDC5
 Ub5MWlqiyNLdCdNdLUVJIFjfJzvIL15+yxK60P2/uHYugIOfTUj8Jx5N2l/rrqfznyXT
 Lcd3bGoRu0svrA/4YNDDcpkCadkk4r/QKf1KDdviszxT0QcRZkOYYEAY4sDUu4MrpW3R
 nl7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOX4ei36PmW+kOW8s0oWGftru9YVPB9Vqt01IGL8Depi3EqDP9N3ZNev0CAgsJKolO0uvPIGk=@lists.denx.de
X-Gm-Message-State: AOJu0YyDdWnHy43naRqCGxaqekiicMfMLJSfQViGG48pIsMAUUIGH0lY
 Y9QploPguqsuQzVduBCMEuUrC+MZ0X4RmzWVWYQhgjfbGR/yS4nI/7L1p1Ez8zaV63c=
X-Gm-Gg: ASbGncu3TbAMUuZkvsWsjbdUBG8YsTK2+kymwdtd+nE5QvvMR098Fc49B0qPXpehLWB
 kzCAcFeLOcZxIybfMk9yF+qur4NgNrjxJAPkshysQQSZS9P32s77sKh7CoPh5z5TJRHyFgyHUIG
 JM55U/iPkaB+wAcDuwCUZhD8jf/HoeDZUMFVdkdAyt+C0R1+tY9T8NrijAMPIt3Nc1UZWgNPgAe
 Bi9c84npawLsI2jsS4nSuRDY1dsF2UgV/e0Vkqq6LhwidJiKh9b4nArRQMtMfaxEUB6yFeTf2sE
 LyH4WGqhiUDPtO4/21mZ1hA42lAIW/BxKPvX6aDiBrU234StZy0B/anckGcnGNnfJP5GDfgdcNT
 6PFALuZupiHru0ApUrHPuBJ+4XhBohEwZvbVIygdJbbrZpwboXzNcL8xp2hhVoR68fdd83A5U10
 TtRhPFehzJbztzniFp9r2+P8kxqPOI2frCzKbdOPywL8u6jVJkKQ==
X-Google-Smtp-Source: AGHT+IEpDPCwPh8CxYuN1EamMXn3pAzhsqipE3FRuInn4fCPEK+G5sh9enap9fuINPCerCht/wSpww==
X-Received: by 2002:a05:6830:7302:b0:7c5:3e5f:ee83 with SMTP id
 46e09a7af769-7c6d142cf20mr185770a34.19.1762275929388; 
 Tue, 04 Nov 2025 09:05:29 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c251128esm1151195a34.31.2025.11.04.09.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 09:05:26 -0800 (PST)
Date: Tue, 4 Nov 2025 11:05:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [RESEND PATCH v5 0/5] Enable Firmware Handoff CI test on
 qemu_arm64
Message-ID: <20251104170523.GD6688@bill-the-cat>
References: <20251021181703.598342-1-raymond.mao@linaro.org>
 <745a1137-08ad-4365-9712-35a45b9ed6fd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N75Znc+zwhsOAf+H"
Content-Disposition: inline
In-Reply-To: <745a1137-08ad-4365-9712-35a45b9ed6fd@gmail.com>
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


--N75Znc+zwhsOAf+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2025 at 10:13:28PM -0500, Raymond Mao wrote:

> Hi Tom,
>=20
> Is this series ready to merge or any improvements are needed?

I'll give this a test today.

--=20
Tom

--N75Znc+zwhsOAf+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQoyUwAKCRAr4qD1Cr/k
Cr9sAPsHk2hH6GjVs0oVvuCBy3JdIAYWr5chfhN3r4nIMq5iTQEA+OiUynHi8DOM
DKPlH9bX0nyjH3u/PbtcA+ggU0PsMwE=
=3L+/
-----END PGP SIGNATURE-----

--N75Znc+zwhsOAf+H--
