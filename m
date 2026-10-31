Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB49606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gDlLJngF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FhhYQT3Q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D0F480F45;
	Sat, 31 Oct 2026 14:18:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hSVJ0qUB7DCV; Sat, 31 Oct 2026 14:18:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8425180F27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793456283;
	b=AbLSzDNPHvwXePWsTG/ys2M8G46N+ilodBUqd6YGn8W7RGfVvP+qcNEaPVYWiZoMiFuk
	 6jKeTyd0NeL2AffNURQUv11h69I0nuKy0dx+AOnFfIYI6oqll4p3KsGeW/R8wb7hIWOgY
	 mGJ+qX8HXq+pmeNeNRSk2wRDtqviU1mloowp6sw8Kyw3kBu7kg6rdGoEu/HtIEeTusGho
	 u1hS/va/B9ipriOaZtmt0BiNYGiJU0pB4LCHxmuqYxGlr5eBldFO34SDgpxqqHVUQxSlm
	 4GLBPFjvgRd0wtpLsne8xzlWPhXMQAHBwRlnvKEVv8dK+OY7vj82GHxDQ3kQWljCqYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793456283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oxJVCaQHe0pjVXhg616rVweZOpMCEqrJwpoAs7KWyF8=;
	b=gP6kANgUsUpHN2RGWnAUXF44r/KMAWi51agj5yxC9fpgbBDYpDdFoahxio6JJBoonFrp
	 knxYHcEyc0H+K1EjGXwY0OOQdic9jnoGM01B/D5w2XEV2RuTXTwT5zn5+9PbfvoipgFgE
	 BZUOpam4NOMvxOAYmIx5qT0juvtKxvCIGzZOzHBSWWGwfFbjgEjvR9BD6WChsMEt8lADl
	 YeD8zaKbkFeyTmn2ggK5L1XuBXoUB+7odKnniAqDVT2a1z+cYrenHdEbKmuscEjxfUvPf
	 +r+vf7PfN5Lyi3c6s/kl/PY2s01mHL1OijAukHNvMODtnrrByPllmOIAFoJH2nsG1Nw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793456283;
	bh=oxJVCaQHe0pjVXhg616rVweZOpMCEqrJwpoAs7KWyF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gDlLJngFe6sIDi59EusqjNVHl1uK72uEYYcNfk4VKUGCH0gsW5uQWU2YDRs+aX2XZ
	 0V5U/5s0MlKMdqgNfHUAQzi49jUjKIJEtBh8/p3/zt7xD8IHaLJdA05V+4oQwGWN3B
	 y5+Ais9XKvcOVGVve4dESBqTyuoqywNJpPRB3rLp9SsZ6BfxuIc9fcl9ufaT3l8QUf
	 DU2JOoShjGn4dK9KnwAxeSmLW3NBYoaKKvheK4+5GzfffazWIu9ewGkehhursBhNQy
	 d+HMBG7u6Rp0jqxOzLHSBF/Kc3lyPeLAUUVfdq/7LgKvnA4GzV573R1nrnED8yTC23
	 XpDEyKNGupCGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8425180F27;
	Sat, 31 Oct 2026 14:18:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB99D411
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:18:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD9BE40060
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:18:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RCjNg_70zTdV for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:18:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 04D9540049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793456281;
 b=bBaNll/Y+SuVL8/y4anDfA1QAAr+e8lM9v6cswXa9oS3zy7J8r7SHHccOVpb4lEfqa9g
 BwU87LAijuawtMZeQMX7JkWDjqqm7oDQfBNBO/APiqaGghBTM4JQi9SkgebzY5qjNDeXn
 cmCFfIqqWSml+/ZP25Chsy+iBV7SYzyzjvtBXq5+4E6kRXOBlItW+stPCqghOWjTsK0B0
 nxyWk8VdGEnI0JFQnJgaQLvmIcQpf2PGuuh3Iqa06VBbv8n0HWjYn5DGLlnYQ2L0gXuls
 4eUQqBs00htbz8EoVfnlbYg08wwEQaS2rxZvLV2EQRKUaLX/QV3RwkQ0e1v9KqwsQXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793456281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=oxJVCaQHe0pjVXhg616rVweZOpMCEqrJwpoAs7KWyF8=;
 b=aEV78x5jA/0cg4AQCodY9fJ5gtNPnTIqahWGVv8o/Iex1Tjnh5mS/DvCjeuHz7+jXW+5
 JOQsWecG473UqVJ0D0z2aYbu1my2tLAcTpcfse8H0omSdOPt+eLTudo2GRVl9psNGEmGI
 DsHpU4OBTWvgxLpUSxTApN6GTCCmG2iMkctzE9RUPIDM41qIjp5p97+aYXubRzuQ8tZjf
 0YM+XnGUYa2SNO+6Or43QxzVR+/p3s3HeCbw3VBiNH9zOVZdnz0vp524FblK1X03Wj7q/
 KwZd5AwUqm0KG9HFZogWy3HqUEpLJbhQfW9k/qSSNzHsSZmqPrkQVmniWUPV7elow5Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FhhYQT3Q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FhhYQT3Q
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04D9540049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:18:00 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-8241a56cd70so1146557a34.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793456279; x=1794061079;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oxJVCaQHe0pjVXhg616rVweZOpMCEqrJwpoAs7KWyF8=;
 b=FhhYQT3QZImQjIxfIARUlKB8HuNaDNQshQcb1abPPXhaywPYzQtadpTdQ9f3jlmMwF
 A3XHsGpqqO6XCc3dCkhv/9arhOn/GZGRJQcqpakvLctwwCPAuoFRuv6BIa0F5UFekE6R
 pNOi5k52OQTKWOfuj5W7Mq69MNvAJ7xNR1DqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793456279; x=1794061079;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oxJVCaQHe0pjVXhg616rVweZOpMCEqrJwpoAs7KWyF8=;
 b=mXtlGey4sq/npqVZoR2i4I9AvjzVrZRrH2yo37CrTUr8XF9/YU5DzZeXWvkswqI4Lv
 pHc/HWlJ3F3X3/gyv2IGbS0iaj9ezN1BtkY35WqKOkgdvMG+DSuhVrQpOqdQb3t5FzYr
 YGk2EbtVKeybbAvHQgFSnd2Pab2keNecMG8oOTZjTr7sB/fFGQTWGoGYF/lZEsPIW7no
 W75XsBxDLaMdm9Y/p0f8APYe1uzkaRlBfADZhPmmsRUdvRqwKwprHwggCpGV+z3rk2dg
 QxVTWKXSuwpZDfDjnlovGfJ2Oq43B4C0UwmVMKzF5NjBcjeEmSwuHpPm4ggmRVmtM/Zp
 M5OA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8dnodusH12iNXP3VRyYBildZS4oDKdeNVJAEMzeSzOiHdq6OLLNhU6a8Y8HXS/X+u04FqCbM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIU2rF+QfB46IAelQbvdSAc2WNGK1tzVioDAppvFSlb/dup2T1l
 DffNrFKycnv9ERwyw4B41gHXY4X0vMHZJvCjsTyEygX8y/eIM89p0QBK8OdFYMRyhnQ=
X-Gm-Gg: AYBFou1WMl2WzSOuueyWSI1ey/53XiAYzU5dowqKHg3pN+PJTWZm+jtguvF+5vyJ7AR
 Gy2pS8QBAeQzgROf4bcG8R99/iZRluGvMPnqmJqCE1+f7fAWtDqlQJDU75kP+6Ea1kLPue4tIEz
 WmEbJfdmlmeiazXbivqujO1vgywredt2JHuy++hxbSqCVFk3p1rI2051CmKNfWTpwDy9zVFEp1P
 Dv6mssoAJiQDB08GFozgAlpjJULBmgX0imFT/jSfDDMBpeCJ+Jh9JYeIt3VDShg9fqx/OKGNy2N
 ldl+8dNfbkDMH4s9rRgOE9K03z9KHWVERFySjyV1fmRCduBr50s5+wHo3KszJHffjF7kRYzxSFn
 JtCrF1cjzFTBaxa66fMLhFznVHa7uWvsizdaK/bTfgNUSZyziC+REYmEdfOPT3Tn01cRscAhWMB
 V3QjeBS0ho/IwQQx2qTnoWctglYO7jP12QHPdUm86v8/WC2FX5ElvgvG6OvyLhxTem3caNybuBM
 iIKSbij9RcxoxGWhcfKHnqdPM+z4H/BRxgAOCZfT0HRBy1/BZEDivXhfrEvBsnsWWRoSb1d8Eu2
 P3qjmuetEHmdrojhwwVnTAnXMBDsaiCZ8VFO6kA/XfaxRU0wjSarN/Cll28KQklJ51ePlYtT61a
 m9aEDyptH/foBXBytFAWWYOAl1NLMB5ZffavBNn5ff7ubqvQOkxSPNuwuDKm1/yaQCxhFOPIhrK
 yi/YKIYCzIu6X0p2g+2VlJms0vTDg74TE=
X-Received: by 2002:a05:6830:4c02:b0:81f:8a6d:7b52 with SMTP id
 46e09a7af769-85d365ce7ffmr4471808a34.24.1793456279078; 
 Sat, 31 Oct 2026 07:17:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354cd9bbsm4319386a34.16.2026.10.31.07.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 07:17:58 -0700 (PDT)
Date: Sat, 31 Oct 2026 08:17:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: ekovsky@redhat.com, Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, mark.kettenis@xs4all.nl,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Bastian <bst@pengutronix.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
Message-ID: <20261031141755.GN3309461@bill-the-cat>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <CAFLszTg9qSuGq9CHuQWBmGRqQVxT5yMbf267p+eNXNByFy61ng@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gpsWW3qH1XXL+9TF"
Content-Disposition: inline
In-Reply-To: <CAFLszTg9qSuGq9CHuQWBmGRqQVxT5yMbf267p+eNXNByFy61ng@mail.gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--gpsWW3qH1XXL+9TF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 07:11:51AM -0700, Simon Glass wrote:
> Hi Eddie,
>=20
> On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:
>=20
> > This series adds support for the OpenSSL Provider API while continuing
> > to support the existing Engine API on distros shipping older releases of
> > OpenSSL. Build dependencies for local development and CI are also
> > updated, while the final patch adds support for using hardware tokens
> > with the Provider API.
>=20
> One thing I'd like to check before this series goes in. The provider
> path does not accept the same command line as the engine path. -k must
> be the full 'pkcs11:' URI, the key-name-hint is ignored and -N is
> silently dropped (see my comments on patches 1 and 3). So the same
> mkimage command works on one host and fails on another, depending on
> the OpenSSL version. It would be worth keeping the existing command
> line working with the provider if you can.
>=20
> > The changes have been tested with the FIT signature verification vboot
> > tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> > tests pass with both the legacy Engine library installed and with the
> > Provider API.
>=20
> Just to check, none of the vboot tests use an engine or a pkcs11
> token? If that's right, these 30-odd tests only cover the PEM-file
> path, and nothing uses the pkcs11-provider package that the Dockerfile
> change adds to CI. Since you already tested with SoftHSM, please can
> you add a test which signs with a SoftHSM token? That would give the
> CI package a purpose and would have caught the gap between patches 1
> and 3.

Can you please catch up on emails before replying with a bunch of
feedback. Quentin has already replied stressing that we need to go with
just fixing the build issues for now and dealing with all of the other
stuff, of which he has already provided feedback, but will summarize
again, as a follow-up.

--=20
Tom

--gpsWW3qH1XXL+9TF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauX4kwAKCRAr4qD1Cr/k
CiW0AP9GjZzNg/RnDJkuO4CuIy50riRqBDFu/b7sE/zaFAEKswD/WRig+WLc14B/
tO15/h0Vz58aEbI2z9R6YKlpMbtn5QI=
=erY+
-----END PGP SIGNATURE-----

--gpsWW3qH1XXL+9TF--
