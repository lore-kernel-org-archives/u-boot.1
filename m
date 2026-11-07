Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFA606D803
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gL8vrmf2;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=njkGnHOh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F22B80FBC;
	Sat,  7 Nov 2026 14:49:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 94Du2x2NY3Iy; Sat,  7 Nov 2026 14:49:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C400980FDE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062973;
	b=WNUbPPCzYuuV6DeQZLepFtkwdXwZg3h57TZ0B4WaQXxdunoeZnEzEbTuIv/dDidRzyFG
	 +NES6HzbZ61sOWUhjrHKC+b19VcmHFaR8CyAT3y7T+j8AAsNSN6tPd4S1VDi8dYGfkOvv
	 yZL4jGTpqg7xsuE6o/ym5uSW9W3rQFBhUxeUnMdDy1WkibHMiGbX92y/XnS0zMIL7pzv9
	 KOZBg9cQD0wyxwFOly/SDns7ejzm8+hjhkm9GbQQgUzvIJg9nEeF4iyL9rKbGf9PGP8MN
	 CstpLx21s1SelRNZQNM+tDin3YrmGiHR0+ShN0QIMgGjffIjbQUlr2DREIPQ5W0xd6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pKf2QBwc3PZQu+S94uRLHRydOMtoMzWSwHIfPc2d6O4=;
	b=CJxz9ePIjiNARt6FLHBhNKqbxEkY6yPPD+GUV65ZIczxphfs8RkqvzS7Qh09oQ0Dc9/u
	 dNByYAT7bWcOSAL8Dbh66klLKpwv51LcfLZCbXYSLbkRKUnVAwayzMWI+HNxHeCjCcsaZ
	 wHGVbx+IL5kq1MGBdAK7zOy7/u7WH8EjBWNyPt15UYOijarwYXbwj4ZFIQ3ZxrG9g6+wi
	 SP+FB32ir4mz7fIgYRINNT0Ox+r/wBauN6efYRLe/5avg3Z42I7Mzzog1emcxDSXCSe5N
	 +rbD8CLZ1VQVqcnnes7fOkxclQHDXMmx1YdgUJ9nO5tkSnwPO0tiudxOl9cpFTWYCyQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=njkGnHOh;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062972;
	bh=pKf2QBwc3PZQu+S94uRLHRydOMtoMzWSwHIfPc2d6O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gL8vrmf2qVbdlkf4uKWflq+8tpB9ftXlV1MocfHa6rdCN2R6XRcfdKP43/c46OOW9
	 nHVZOji4YyEG4kyZ9fdf1B+M6oitS1yQeTHXaj+Yw3lu1gv+2Yx2GYRcmi8ShiBnLB
	 429bPNSvcMP+O33hjR6QguX4HaRWmdqyhzn4lpO9wT8tWVQUt3FI0eW+3oy0YwGe/i
	 tzlhSOQ1SbOVKiY25K6eENh3GUV0+scEP0qOAj3b0pBtaYyOeyQpZAOVN7vE4+LvC2
	 hw9fL4FJaUTu+0k9HBRxt428EKa4ljD3mzZBhcPUNqynTtCwXaBUoUc/B5ouPsqvto
	 Mt4yFlEOxEfmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C400980FDE;
	Sat,  7 Nov 2026 14:49:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE2861E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF73280FBC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2nQKNUsiZLqp for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:49:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9CFD80FDE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=njkGnHOh
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9CFD80FDE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:49:29 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-567d0212e7cso446330b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794062968; x=1794667768;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pKf2QBwc3PZQu+S94uRLHRydOMtoMzWSwHIfPc2d6O4=;
 b=njkGnHOhTP/YqXi6R5eAlnmTpiSQHPDH2/4HGpWA0mrR6sWoPhMoiwieyw4VdpKJVE
 b1tHI0iUMZ+hbyOSHgA3W1fEP2naD4mlGy1peY3Qpo+qhvspq1yGMarEYz6cBkgHiFC2
 X7stqzb8TJD2IFJEx6y24iRKpoVqS/EiVC5bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062968; x=1794667768;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pKf2QBwc3PZQu+S94uRLHRydOMtoMzWSwHIfPc2d6O4=;
 b=ThJDTNAFyWQI68yFanzIqWa1Vzr7m59W7w9lRr3cVbsCDDieSokMS7lWhtrx2jYSqh
 WML534eiK1NKXk3/N/TnU2XCSGzBz8/kj0aS05bG/rpNHIsJQ46hlOvET9D/lVQ4i6jt
 yZbyQsMm63hvc6sfnzEt1Ctm4nR0GUg5Ncak1fAGL6PJQ44bOwZ+ZeCo2Q6J9vcuOlka
 tRF80aHSfL44e+Yw8TnlzgS7z9zy5pcz7pvHaEnBZ0pjtHnAvZvN+H4Gzbl/xTaH8hZB
 vuSjQ0b0JeO3RtNjG4gBJSeMY43u4GEQNY/4HUckW+zmHtrdkG6Hjj5qqpm7XMEO3+oO
 hUdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxBMq8QeXKQM/TZfiL9IHXJK2jGUmCK+mEjouy6dcc4iHBcSHxl8h5PwR4kUW1Zp7zQi9SwDU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+Fk9iqrs8DjM4tjlnX9UFiNjidyAk3EWY71KZPrBjj/KxgNS2t
 tW/hPYXlXdDVmh2lIMVgvnvubxb2K1KfjpTVnd4mVnVMHHx9cKiGfaYJXFUOtFKmUJhRxQp7kH0
 BgHBiCNSJr8sT3F8=
X-Gm-Gg: AYBFou1lePLkcIvkmaZtEWN+472e+7I34Yu7rPBaRbgP0KlTzPTk0l9vlgJKr+hHAHS
 ejX7iTpTz+j1TyYcGzog0CWeYjZTNtu3VsBMbUSbc6yAEfPD9H4rYmAnOrlql79CskkeVc/mNcv
 dMiWS9jWDrxSF2iRBRJ5R2n4Xgt6+dSR/8TmoC1JFs5XPkVg1ANKpJ3Nai3jFeZKcWpvco2aRwm
 XnhCszZo2kyQITRv7v2QX6cdzmTMJ6ZjmfrhyJEccEqx1ZXtPPz8Rlfjpk1qMP+jB90yUGWdxKu
 60m6QGseZeFUEVXlp93Ft4OT3eW8bpzOLT/GcJFDlzasV7TEp2pN1rwJ75qn00f1IHo369KAxoF
 eEVe3OEG6tY/aw2KM7UmfSy+Acq3nPXn1tm9fVGWDBvUMArzHkb70vnD/aNVtuf4ypaPXMIJoSo
 8TucSEGyPjV5tmSFpjCCQZkLv50hjNLMqflLNCXlDPm0T+QQbN1m0BTs8TXzIDE0/BtwEzgnEUq
 tzMLvp7ijVndJQmCYcC5ABcrqST65Ty9SsSu0AttdP7qstY0Lz3WwKz/rHxkxNhHca5hfYTuNth
 0kGaJmlqT4yYGAAejTxjshNv2L7v72OoFLvX3WFxpwuvA6ACSVQ2C4tUFWAnVLrS1gT5AyQTwcb
 rQ4jblI73YdvUYU8mFxxk3GHscu34//opM862lJwcExnwndiLl4C0XH0L42hvmt+7gTsEpUPvGy
 KcpMZmSm8B6tHUPp993DGSvSj57N0Iyg==
X-Received: by 2002:a05:6808:1798:b0:4f5:e4ea:9ef2 with SMTP id
 5614622812f47-567e0fa2b80mr4044406b6e.3.1794062968286; 
 Sat, 07 Nov 2026 06:49:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567e7f9021esm4024752b6e.17.2026.11.07.06.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:49:27 -0800 (PST)
Date: Sat, 7 Nov 2026 08:49:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tomas Paukrt <tomaspaukrt@email.cz>, u-boot@lists.u-boot-project.org,
 Stefan Bosch <stefan_b@posteo.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] Kconfig: Imply MD5 and SHA1 instead of selecting them
Message-ID: <20261107144925.GI3741582@bill-the-cat>
References: <x6.ZqL8.6lacd1LQ7Dn.1gxhk0@seznam.cz>
 <C3623664-3DBA-4A82-8814-D20F387D3319@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="koOsVCgUR60Vmyxg"
Content-Disposition: inline
In-Reply-To: <C3623664-3DBA-4A82-8814-D20F387D3319@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--koOsVCgUR60Vmyxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 08:02:50AM +0100, Heinrich Schuchardt wrote:
> Am 7. November 2026 06:47:44 MEZ schrieb Tomas Paukrt <tomaspaukrt@email.=
cz>:
> >MD5 and SHA1 are no longer considered secure, but they cannot be
> >disabled on boards using FIT, image signature helpers or UUIDs,
> >because FIT, IMAGE_SIGN_INFO, SPL_IMAGE_SIGN_INFO, VPL_IMAGE_SIGN_INFO
> >and LIB_UUID select them. The code behind these options does not
> >require them, as the supported algorithms are looked up at runtime
> >and unsupported ones are rejected.
> >
> >Imply MD5 and SHA1 instead, so they stay enabled by default but can
> >be disabled by the user. This does not change the resulting
> >configuration of any defconfig.
> >
> >Select MD5 or SHA1 explicitly only for the code which calls them
> >directly and relied on the options above until now:
> >- bubt on Armada 3700 (sha1_*() for the TIM image header)
> >- zynq rsa command (md5_wd() for the boot image partitions)
> >- NanoPi2 board (md5_wd() for the MAC address generation)
> >- EFI capsule firmware (gen_v5_guid() for the dynamic image GUIDs)
>=20
> Thank you for raising the issue.
>=20
> NIST diallowed the usage of SHA1 for digital signatures in 2013.
>=20
> We need a plan to move away from insecure algorithms for security relevan=
t code.
>=20
> E.g. support for insecure algorithms for FIT should have a separate Kconf=
ig symbol and the build should show a warning text. (We once had such warni=
ngs during the migration to DM.)
>=20
> CONFIG_FIT should neither select nor imply support of insecure algorithms=
 for FIT verification. Instead make this a decision on defconfig level.
>=20
> The same for support in signing EFI images or capsules.
>=20
> We should consider NIST IR 8547=20
> (https://csrc.nist.gov/pubs/ir/8547/final) which has deprecation dates fo=
r further algorithms.

This is reasonable, but follow-up work I think.

--=20
Tom

--koOsVCgUR60Vmyxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau86dQAKCRAr4qD1Cr/k
CjJkAP93m01qKA+xcfvKUOxNM/zsSbNr4j2pZk4h8255Qx9X2wD+KdQLTKnjsmrZ
PrXJq4gJVFgtrY5UsCN5KkYDEa5l4Qo=
=rKsy
-----END PGP SIGNATURE-----

--koOsVCgUR60Vmyxg--
