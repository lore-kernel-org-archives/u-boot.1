Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546EACFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 15:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CA9845D2;
	Fri, 28 Nov 2025 16:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QQRobMe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A0D845D2; Fri, 28 Nov 2025 16:31:37 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA69845C0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 16:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c78d30649aso1454773a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764343894; x=1764948694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v2u/0O+6ZlqskFsmsAWuTfyOnml8Qcic5yaLMeIlUiA=;
 b=QQRobMe6Qg8ythn8ViiFDd/UrNa3a/gx0dNZwqAixXpGkrdTKSYgB69oYmvJ+qgRMX
 HztvBsF+xReSkPjMAuN+s0JlAoIHqJdSSOA+J9zLYjePIuzdWa7ABUczGZGOkSCZt9qr
 w9XUMxmOhVE6OfmWx2OlC8LBEgw3oX33YTN7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764343894; x=1764948694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2u/0O+6ZlqskFsmsAWuTfyOnml8Qcic5yaLMeIlUiA=;
 b=dmbHlCGBT+Z5Z4dkaOEc6M5ei9QETmtcj8Ss6F6NznXhPatP+WHz/XRXesRV8GOD4+
 oSJUI2QjKl8SIJTShXNnIG5rFT4qJffIdjFsdd9EeHxXLfo+3AqEYG2JR6kmBA+xH4kE
 SV9FfNak4Y9VUpptg7fDGw5UpNs3ycq5IGKi+KfKKO5RakdcxVoNUtqSN3tTCiQoIqj1
 AnmDDo4Hx+RgXvlRMhY8RTzuzVmsTD2vBhmOqHJ1j5GPYyc1jhxlPKmwnWJiwPz1KNN9
 K5M2kAqKOPmme/0ISxHTQv7vRzeOq6LDMSrX5JXWyiLQBBGTKUaoduGpOFtojHpw1zr8
 KzxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7qwto9G8jBi1Im0mShoLsDJ1aesZIwQo8LEtT/sDmNpOPBiZGM/qncEpsto/KwioX1WvgKwU=@lists.denx.de
X-Gm-Message-State: AOJu0YwO44oC+HxnuCriuPVK4kkdLLnNZRMMo7+E8RxDx8fCGeXI3phv
 1dME5sFBzzN8dIv2VlurW8WGE1/9pZUnWNBC+rFDgD66uF1wNkeotN2rRuh0c5QYjwg=
X-Gm-Gg: ASbGncsPl9yPjrw1sa2SUkaE/1SjHEyB8aN2+DehbBO1Pq//mQAdukC18I1rBM5Ux8v
 MA4SrZkuLwJ1faQlkLCwRwaibSxqoAFPF+xy4DL3jcCYrN0JzYzaZV2/p72C1rXOIXbqsU5ju3v
 /+43w6UF/nDziOQRFb7mc9X15Zs7gQbfVHpJl5FN8x2HTW0mTBHyUJS20pNJWW5RhA4xfiHnhnz
 s9PbJlaMZx/gAGdggF5ebFsk27r2gmlTNUU+mEnQjEczO+ae8ihYpYv4mICeZzzEuQUY+hoHk5W
 ilPheEfLxL8wqLPR+pOFVEjF0uC2krb1iAZurfhZFks7+0W1GCSXQQFKNcqgOPGot7JOFOCivZa
 xNDN+H9bQCaMX0xcdm4fEy8uPRgK7JIzgw4jh0yQHmVh0hFeOlWW/u/oLL8RxarVCMMMgVC3qAh
 IxO5VwZB24i1aFgZZnEV3sWjwJKmiLTi1Yy0lrlUyAxHmyue1rWw==
X-Google-Smtp-Source: AGHT+IFJEZAJuomE59LABN6KUEuYyh6D8Zes6NPs7l1vC3uKdMd2ckNUUXeChAOZnKi2AypbGvahOQ==
X-Received: by 2002:a05:6830:2647:b0:7c7:18e:913a with SMTP id
 46e09a7af769-7c799071e43mr13924171a34.19.1764343894293; 
 Fri, 28 Nov 2025 07:31:34 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d7ba2sm1683308a34.5.2025.11.28.07.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 07:31:33 -0800 (PST)
Date: Fri, 28 Nov 2025 09:31:30 -0600
From: Tom Rini <trini@konsulko.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: Re: [PATCH v1 2/8] arm: Fix "file truncated" linker errors from
 empty built-in.a in SPL/TPL/VPL builds
Message-ID: <20251128153130.GC2125796@bill-the-cat>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-3-alif.zakuan.yuslaimi@altera.com>
 <3e4de604-292d-4232-893d-db43e29b469c@mailbox.org>
 <19c33d9d-4cab-4add-9dff-f3b9e051f146@altera.com>
 <3b219e15-5513-4474-aae9-9d9a8abeb61e@mailbox.org>
 <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lKfwPbtWAZrGTog7"
Content-Disposition: inline
In-Reply-To: <f13e8fd9-9705-46ec-a2c4-9fc4c6a63e38@altera.com>
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


--lKfwPbtWAZrGTog7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:11:53AM +0800, Yuslaimi, Alif Zakuan wrote:
>=20
>=20
> On 27/11/2025 11:09 pm, Marek Vasut wrote:
> > [CAUTION: This email is from outside your organization. Unless you trust
> > the sender, do not click on links or open attachments as it may be a
> > fraudulent email attempting to steal your information and/or compromise
> > your computer.]
> >=20
> > On 11/27/25 3:12 AM, Yuslaimi, Alif Zakuan wrote:
> >=20
> > Hello everyone,
> >=20
> > > I already have the referenced commit in my test branch, and I can
> > > confirm that the same compilation error still appears on CycloneV when
> > > certain directories produce no SPL objects.
> > >=20
> > > The existing fix ensures that built-in.o is always present, but it do=
es
> > > not prevent ar from generating empty built-in.a archives, which older
> > > ARM 32-bit linkers (such as CycloneV toolchains) reject as =E2=80=9Cf=
ile
> > > truncated=E2=80=9D.
> >=20
> > Which toolchain is this ?
> >=20
>=20
> I am using Linaro arm-linux-gnueabihf GCC 7.5.0 to compile our SoC32 devi=
ces
> - CycloneV and Arria10

Ilias, do you recall the solution to this problem from when it came up
on IRC a few weeks ago?

--=20
Tom

--lKfwPbtWAZrGTog7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSnATgAKCRAr4qD1Cr/k
Cjn6AQCw8jcBrzxllkW3c245Alnjai3W4mY3yE+oJkPOQC9ksQD8C2Sss9lC+1A8
uJOagbv2S4i0TmKI8BmWqk/R+zgxpgc=
=lcxs
-----END PGP SIGNATURE-----

--lKfwPbtWAZrGTog7--
