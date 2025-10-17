Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD1ECCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 19:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43A883881;
	Fri, 17 Oct 2025 21:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FWQgPS3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6883683881; Fri, 17 Oct 2025 21:53:44 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B634783829
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 21:53:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1156504fac.1
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760730820; x=1761335620; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fpOmm0GbQMbaPLnqyGzWlLKw7ZUWIQhccNu7LWpgEgM=;
 b=FWQgPS3ysRf1Sbidq851M0xPNXSpVLvgt27hkEVnQH/MU2/sT8poeZRMnvoz82OJfb
 OvCJdISS17BTwNsRxiYRXiIYgcbsC8wALUQq+lrE6L/nQb81IGtZWN4oXwm01ShGNsjW
 xYPS7LejnBO5WiowsTl9QYiRLnMInR+Wmzz+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760730820; x=1761335620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpOmm0GbQMbaPLnqyGzWlLKw7ZUWIQhccNu7LWpgEgM=;
 b=iyckvN4SvDsITSB4FDoecPpYsffc59Tw2hlSAzDk2/3S+X8YCo5QQq0HBpl+9UXr7d
 VB6kQYqjA8kS7OadDy4ugn2xRBqWzlpKOYec2GOxfziTc4srFWGsmyMUr8rKQt/+mHdY
 tzh6CiAPKwFsoMdMsnCAYxxjnpNS/9yN5XN8gmc5QlTzEKncsz8kdleOuyOoEOOrrekk
 rxT4S8SX3xqJjVRifp7FBlgWLVcS9NWQVAPO5eMBN+48pUk3WMdEg0fNF+CVjG2VTKup
 hdoZWxCA+x/zd2PTKGxZBeQwvwfqW5ReZfx75pN7w0dqrFzvOe0rMsv3dnvGNaD+Gbn5
 TNeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2SLlTQoo1XEvfZa2FS8nXjfcerwjdY83RxN3PYJS66D5bSAbMAo/qXult6OV4ok1XHZdXOf8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywicp8Y0STplwefCHzQ/INmPRDNWOrI8hz5GLaI/XAWbxx+s1I8
 cVeXAQOp+vSuZ7byZFCNcAaZygbPRM17/dJboicQ9xZ0yx2Q+bhAATHcK+UcKs4eX0+okx1+Isd
 mlDy7kxg=
X-Gm-Gg: ASbGncuY30FCLy706uZ+1i4eMkEu+2NHZahxOmokxZtFFpOySIpSoAF3gcW3SiXh28i
 5ZISWui1Y3ivOSshE5qJV3kqvvoyl2lu1oMBAl54hLfDoufVFu4fm/xV8cJkoHvHxFSCAhPQxH3
 BXTkB+ODlvN/aFBc0lj2ZQb0ReidUxrQxfAHrPonNlFoDaDNFtQieXw6JQ9tar2r4Hjm3zivQLM
 0KO5xOGpC3GJdlQV28YbmtpNHagn2ZSP4Xw2JxnjCZqKN5lQTITSoMVU3CZO7rNT1uB7OqUQ+p7
 l7Ro7gd2AxAwk3mIcnDZhRtgPgDYYW7979bKpmV012jYX88LormPxalk1UlGJ7Grdjn2+v4n06G
 bVsgJhjU2xQ27s80eyVxdPBksv2vRz7DS97nsuTeu8dJSPKvREQM4dZyTREs0rABweJmQ83DEle
 gWnxAik5hdhz5PXt3iSUoUlRwMbaDGTY5NrEVn4SM0UmVSgHIuug==
X-Google-Smtp-Source: AGHT+IFX28i2lQkMiwn6zLbvv5zkMQN9HO1fylsrpfI94V9z181VAFCfHKu6jdWtbeRlGjBnLCCymg==
X-Received: by 2002:a05:6870:255:b0:368:e03:c3d5 with SMTP id
 586e51a60fabf-3c98d0fb311mr2183912fac.38.1760730820404; 
 Fri, 17 Oct 2025 12:53:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af4426b5sm136933fac.25.2025.10.17.12.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 12:53:39 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:53:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
Message-ID: <20251017195337.GH6688@bill-the-cat>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <20251015162858.GA669557@bill-the-cat>
 <632340c9-6a6d-4f46-b731-e766f8517f7d@seco.com>
 <2b8c5ccf-5ed8-4ea2-a149-e37f9ed8943f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UUbWXbajHCstKdBU"
Content-Disposition: inline
In-Reply-To: <2b8c5ccf-5ed8-4ea2-a149-e37f9ed8943f@canonical.com>
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


--UUbWXbajHCstKdBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 08:00:19PM +0200, Heinrich Schuchardt wrote:
> On 10/17/25 19:08, Sean Anderson wrote:
> > On 10/15/25 12:28, Tom Rini wrote:
> > > On Thu, Oct 02, 2025 at 10:36:07AM -0400, Sean Anderson wrote:
> > > > On 10/2/25 05:52, Heinrich Schuchardt wrote:
> > > > > On 10/2/25 11:39, Andrew Goodbody wrote:
> > > > > > After calling a function that can return an error, the test to =
detect
> > > > > > that error should use the return value not a different variable=
=2E Fix it.
> > > > > >=20
> > > > > > This issue was found by Smatch.
> > > > > >=20
> > > > >=20
> > > > > Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
> > > > >=20
> > > > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > > > ---
> > > > > >    fs/semihostingfs.c | 2 +-
> > > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> > > > > > index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b03=
5545b34b31df58e2d65de7db9 100644
> > > > > > --- a/fs/semihostingfs.c
> > > > > > +++ b/fs/semihostingfs.c
> > > > > > @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filenam=
e, loff_t pos, void *buffer,
> > > > > >        }
> > > > > >        if (!maxsize) {
> > > > > >            size =3D smh_flen(fd);
> > > > > > -        if (ret < 0) {
> > > > > > +        if (size < 0) {
> > > > >=20
> > > > > The ARM specification (https://cas5-0-urlprotect.trendmicro.com:4=
43/wis/clicktime/v1/query?url=3Dhttps%3a%2f%2fdeveloper.arm.com%2fdocumenta=
tion%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d=
%2d0x0c%2d&umid=3Df17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=3D1759398729&aut=
h=3Dd807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8f=
a50ef84918) has:
> > > > >=20
> > > > > SYS_FLEN (0x0C)
> > > > >=20
> > > > > Returns the length of a specified file.
> > > > > On exit, R0 contains:
> > > > >      the current length of the file object, if the call is succes=
sful
> > > > >      -1 if an error occurs.
> > > > >=20
> > > > > Please, consider that the file length on 32bit systems may exceed=
 2^31 You must not consider this as an error.
> > > > >=20
> > > > > %s/if (size < 0)/if (size =3D=3D -1L)/
> > > >=20
> > > > This cannot occur because on a 32-bit system SYS_FLEN only returns
> > > > 32-bits of information. The host must detect files that exceed 2 Gi=
B in
> > > > size and return -1 (simulating EOVERFLOW).
> > >=20
> > > OK, but this is for 64-bit systems too, isn't it?
> > >=20
> >=20
> > Sorry, I worded that poorly. What I mean is that the spec says
> >=20
> > | On exit, R0 contains:
> > |     the current length of the file object, if the call is successful
> > |     -1 if an error occurs.
> >=20
> > which implies that R0 is a signed integer (otherwise they would have
>=20
> The only thing that is certain here is that the register will be filled w=
ith
> (unsigned long)-1L if an error occurs and that any other value is not an
> error.
>=20
> Everything else is your personal interpretation which does not match the
> existing implementation by Linaro in QEMU.
>=20
> > specified 0xffffffff or 0xffffffffffffffff as the error value). So
> > negative values (other than -1) indicate a negative file size (or are
> > unspecified).
> >=20
> > However, both OpenOCD and QEMU just take the return from stat(2) and
> > copy it into R0. With a 32-bit host there is no problem since stat(2)
> > will itself fail for files over 2 GiB. With a 32-bit target, this
> > produces erroneous values for files larger than 4 GiB. Files sizes
> > between 2 and 4 GiB could be recovered, but I don't think we should do
> > that. On a 64-bit target, there is again no ambiguity (at least until 8
>=20
> You still don't provide any reason why you don't want to support files in
> the range [2 GiB, 4GiB[ on a 32 bit system.
>=20
> Instead of restricting U-Boot we should add a fix in QEMU to report an er=
ror
> if the filesize exceeds ULONG_MAX - 1.
>=20
> This is the only way we can ensure that a 5 GiB file is not reported as 1
> GiB in U-Boot as we see it today.

I think this means that at best the specification is ambiguous, so it's
important to see what all, or at least the most common, implementations
of the spec have done, and then what changes are needed and where.

--=20
Tom

--UUbWXbajHCstKdBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPKewQAKCRAr4qD1Cr/k
CgV7AP9QkfM2cLo0ycDO1aQmj805p4T+mrwm86zm/Wr3OxzNkgD3eNq/w9QRDgNk
evAeL/toK9M0Eqg0HoxZMCD0Vhe+AA==
=oNS3
-----END PGP SIGNATURE-----

--UUbWXbajHCstKdBU--
