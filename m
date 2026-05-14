Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A8CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 13:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE85980F0E;
	Thu, 14 May 2026 15:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IdME/lQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E4F80F0E; Thu, 14 May 2026 15:51:31 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B22898039B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 15:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so2997337fac.3
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778766687; x=1779371487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KfnaEnd3kJUuun1v0Vje7g53aAqTc9wm0EqeA4D4wn4=;
 b=IdME/lQj88lOj65HyLwvKtMN08Td7Ka0jBaeVYAN7EM+ANzr3cCFZfSDQ6TMcNmUJR
 dXVpiWBhbvBDvs5zAMX4gavcWpIAurgUwqg/9qYNy46FfORXcGZ9CzzlY0SNpbsCSM3i
 RaEH+T4+Ub+oCOLqL3FYUGcnevvY4r1aoxmys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766687; x=1779371487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KfnaEnd3kJUuun1v0Vje7g53aAqTc9wm0EqeA4D4wn4=;
 b=m8TYuSIIE5/EOSdqMXhP9RS+Pklj8gL9+KfgnLnrbip/2nySzJZEaXMIWjv5N9grCD
 JY49gFytrb6bENopGZviNtwiHsqZptNKs7VXQSmRfYA2FaksTNgnc443HWf4IRWUNce3
 GC6UVYGCFJW2oukWk43L1X7D+yBy1khO3V+xpQAAvBTaG3X1LXprtkmnZja/XItzKH7E
 0+4aXatbY8e4CvSX1s3mvOfqhljARo8NgK90Nt3lMG1bzdpomH3fzQRvtf7qiMhVifTj
 dy/amgY662K/PMQ6pkuKQ9I3Iw56CrS9I8jGHoVi9DwrK5OGgIIBWbS8XmWCwJHVX9Mk
 RqSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7Fgvjkz033Opu3Z220sehopZEzAuP3EUQEiUL7rl6eR888xVDCZaMwaL6BEMICyn+DeLBOI4=@lists.denx.de
X-Gm-Message-State: AOJu0YyBS9q9S2gXrghB5wQwN8ssT2U70if4KeK+mYN7R8iPsomf2J3Y
 jrNPH4re6kwan+mETtheN6NEs3q0G0+NCmgGPRMCxdzwzggQYxW4t1ur9eT07+xylNA=
X-Gm-Gg: Acq92OHSchvGesAogxKfVwursCGYqSUKaz6DuFotdr/UV1xoCTowvvCPQRd6pio8r9s
 QrJO2rFM4t0jR/909fnCh0rUB2UYngHG6PzuNjU4+GMi8e2kNiwjwSntf8Z6JR/a+oi8M0NG+u1
 W44BZ3ANXNofs/qYVGdLHGc+ikazKmNxg9XY8XXf52paKnx8kpdU+hu0SZhl+GwANfHbZcWXQ71
 9rf6ejvVGCfAEBK4cb47czntFp4ycuGHIs1S8Zvf7myTFuuICCetPDYws4eqFlD5m0xPhFja1ov
 GHB/Mx5crq6VvEe69xEJ6eQdi1S0I7Uo4pgUO5qh/v3qh3x75b1bmWyui9Yyq7qR6dN7IsLViRo
 v4IgAEVw/0TX7WcqAwde2GZKl7G65Wd+UjFjQiym4/InZ737OGMkmf21Qsjm8r90nvQ+sVp49B8
 u0QS0toBMy/rui06gHBlPeilV+o2suLc/+gXVQT7rzajjHLNACKea9f7o2k8WLQWKj5HaJUW5KT
 JB1QenFRx+e5vtG0F5r1xWlfOvYN9EPjTl/jjS/wKKaqpwS2AJ8CkK6cnN6Ug==
X-Received: by 2002:a05:6870:2d3:b0:424:6bf4:314e with SMTP id
 586e51a60fabf-439ce34673amr4224018fac.18.1778766687327; 
 Thu, 14 May 2026 06:51:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc4d8027sm1994476fac.10.2026.05.14.06.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:51:26 -0700 (PDT)
Date: Thu, 14 May 2026 07:51:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v6 0/8] Add virtio-mmio support to m68k virt machine
Message-ID: <20260514135124.GW1858239@bill-the-cat>
References: <20260505074948.2603870-1-daniel@thingy.jp>
 <20260508192952.GA1948090@bill-the-cat>
 <CAFr9PXnAt2y9-yRqmTdUmn9CHQHZ3HjJ=MWeW6Mi4MxHRx9ivw@mail.gmail.com>
 <20260511150038.GH1858239@bill-the-cat>
 <CAFr9PXkTm2ufq9cbkQQ+gPhORq-prhSf6GQP1cpjFk65+7TJKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BCIlL9Mh4Q/uyyjB"
Content-Disposition: inline
In-Reply-To: <CAFr9PXkTm2ufq9cbkQQ+gPhORq-prhSf6GQP1cpjFk65+7TJKQ@mail.gmail.com>
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


--BCIlL9Mh4Q/uyyjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 09:35:49PM +0900, Daniel Palmer wrote:
> Hi Tom,
>=20
> On Tue, 12 May 2026 at 00:00, Tom Rini <trini@konsulko.com> wrote:
> > > I didn't realise I could trigger a pipeline run so thanks for the
> > > information. Anyhow, I triggered a run for v6 and it completed and I
> > > couldn't actually find where the error in the result. I triggered it
> > > again for the v7 and it passed too. Is there something I should check
> > > before I send it again? The run is here:
> > > https://github.com/u-boot/u-boot/pull/964/checks
> >
> > That's very strange. I just re-checked v6 and still get:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1446347 and both Azure and
> > Gitlab run the job the same way. Can you trigger it locally with
> > allyesconfig ?
>=20
> Before adding a new patch to fix the issue, building allyesconfig
> locally gave me the same error as your CI pipeline had and that went
> away when I fixed it.

Ah good, thanks.

--=20
Tom

--BCIlL9Mh4Q/uyyjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagXTWAAKCRAr4qD1Cr/k
CiS7AP9reQuorTx/ayFCmDrlFWEugSatYgnhKADECR9DM4catQEAh/Z8ocfOet9f
cn3SsC7sCPiVQY2hsYTNP1SWBvxGng4=
=cgoJ
-----END PGP SIGNATURE-----

--BCIlL9Mh4Q/uyyjB--
