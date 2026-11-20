Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56D606A331
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oudre273;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oRrfCY9I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2E3C816FC;
	Fri, 20 Nov 2026 16:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXoCUUef7CAF; Fri, 20 Nov 2026 16:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EF9C1816F9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795191370;
	b=Ue7BM3DYQivmyfXIX+ANsssI8zUCVRxgJNkEOXtkyoBAEWaIiSpHMpJ9mB9ROht2EOkJ
	 qhHyj1aaKSXckMSlmh/UEhcesp71bcVzacaftR5JbPgBWm8/x5tIw76WHr3/EdcmxW/kp
	 1r380IhSX+RB+r8xXwS2mccYPxoTWuXklBAlijsO57QEwhCeUqnygHe6k93UrPcPodxx8
	 Qj0JXRp8VXpcZ77yB8GOrtfMWakopT1KPMvz94LLm0ltJmxoAVKGa/WUFDWpncJy2uq6X
	 bM81NITC3F3vJPo8CDUuEXhhX59ZXrQq0UsO7v2XECc/JbJd7SEvksTX9GQLGFhIgYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795191370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vYuB+ymiv6p9mSWh2apJn4kI326rbna8Ejd0lmAYVbQ=;
	b=CtAetvAGGOfjdx6xpNaEwz7shudrt6F+uLI+k6bw9M2lQwnanOghs7XFUT71kyyPkMNI
	 ITDITRzzePqlGdtLwW3Z3leA0AQg2OvouNtpTuzQZY8iNygfcL3xcdFnXRjJCRFLt4mF/
	 UNTyNy8p5lQUMupeRHgYHH3KCYB+6FEq/Xuq/nwy7zNoEczEdkgBAB+9gswHUn/1TjY/b
	 pdpoHBkrKgSkQS61mXqph+YoaoKlIYdRB92tOBPnRFZQLSZyl927Cgu3pTEsDmnMAaE7t
	 xu7pkQ3q9gs/Pj7qAf2sbFd9Ly5vSBo9GxvGgHuczt98gzqlDyCqkBL8hM+XcFsbXjA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795191370;
	bh=vYuB+ymiv6p9mSWh2apJn4kI326rbna8Ejd0lmAYVbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oudre2739KRAWCTh/Q45lmNQTKcZOcHHpqANt8qy4lw53O0bRO/Y3uK2+/A2pCxHR
	 N0zdid/W07GWix46EjhOLQC8LN23KTP04Bx4IkDBZxpU28OOsBVMhsN0ZIKamJD1RQ
	 0PZzPhPekRK+Z9kq5txKkrLxzY82b4Y/hz+01xnw+5qZL3HipJ4g9M7vsrdFua13uR
	 GSsgCUgvPRhPoyrcBYJaTVz6n2mG/IxMVfEJabsxsf7pAIeJGisa42cyZAG9mLepJ1
	 9O5Ldn/GD6/hDWF/LuNv28L2T+zvQB9glXQ2R+vwqTuGRYXp8WSnlgF0e5dw8/c1+N
	 plaSs/U61WXQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF9C1816F9;
	Fri, 20 Nov 2026 16:16:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23A84E22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1594F606CE
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7i6hAzpDf9Q1 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:16:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52FE56064A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oRrfCY9I
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52FE56064A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:16:07 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-845788309b4so578226a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795191367; x=1795796167;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vYuB+ymiv6p9mSWh2apJn4kI326rbna8Ejd0lmAYVbQ=;
 b=oRrfCY9I2gnLaLDu5k+y1Pyzylsr1y9wFPiwtpIe8xo4GaUlV2K8zWTrD30LGvZ6xq
 9nqBW9bAuU+kJxaLH/iVHssjFRCkQaDBxIrA3FpRptArWM5+bLxyvu5EybSDQBBgy7tW
 3SyCNeUiVd2rwSDkyzFityfRsifFJSsv7m7mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795191367; x=1795796167;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vYuB+ymiv6p9mSWh2apJn4kI326rbna8Ejd0lmAYVbQ=;
 b=Tn99Xj1km4oUDdGvs9cDyZm68U1gnmJohYtxizTBWLEu8Qm7tzSOIMA9Ca+khDlcW9
 /A9fxEoVvDe7fN8/L6CPSyAr/j9peJ8lBR34JLC+dhVUcTVTCJbuqurQGyBZ1EvnWFlk
 xinUWR3hJEE61bV2ntMBV8lZEi5GdfAxdrA7ran+NQzlTH5JJXRVyQrWak75LY/wKide
 FbTQBmNSjQNTLb/KH3btROkil5hrOsQCteD72GDczKPkXbedJzq5YSDHXQLuCEdCgcCS
 QtwjRlvu4UfH8fiw78QBl1BXXmDrPJ10mD+D+iUVU9oLGsbDyRcF5pkSKMUaXUdKvOsN
 OVEQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF8eDRafvC/Mm/BIia8ayNe5xgHSMW8A+CQmHk/SICCjfluSwuVhbwWhSQUyPGmgOJq15CRcxQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8frkqyJcuMmKajkePB8UqoS6uINAQ7ZYvWzB7SPLG4sk1CzdhX
 hlpBMtEteIh+GQkKlSK69lyyOXhGMxxswBj93i8n/pRK4TOAYRw7Jm75gnarUAuIhECkqGxbyZj
 DQkWwa7YxUA==
X-Gm-Gg: AYBFou1+hyFzu22btOV2FIRx1WUB3hclMrAaJmP56Xh64gCxWu7P5yEW9rnL+ULqN8h
 cI50u3N3nJANI9fh1x5IKRmaGaBa2O6KCKJV0LNtXRik8gp4x5uQwI0GXvoLTS+Siu/MsQTlgaA
 KNTFWe7fPIP7plS4Sms635bJWyPeBkKgq36LfqXPqfLU+iFnFROcru6Jxhs4Zc4pEO+Em1RoXzX
 hiNgxEbTXQ0vylU8MbNtxk2jXf2HAN3LEGwytJtwLZ7bn45r5YKWtsDNxQM2PEw0iq54Ybh4ngR
 CN68oaJdE3wUaf5Tfkp0S13jrB5mUxoQpmZB5LPx7YmYWUDhiXfT4QbuQfrzVqjRwpQFfQGAlwz
 041IDrp2T5l/Vi3xQxqmw6Wrf+MBrjWx8T/rdkC81BILNKZZqwpDxA18IETWVVIVxKiWxR5NAnM
 MsnkWddFwHdklxx6O6ka9nFsnfRp1KvfcZ6CO9xrM6nRI1TGuLLYyXejorUQReiju+fh4Y3WOTv
 ohxdf0YqVwVw1evhqfp7SW4mJ7eXE2Gx85xlSrGnKFxORhqTxhJhu0d4XjXAPNDii6QLJTeuxWU
 +r4jrWcmgM4La973oUtyVtEhvp1sawaRlMJPFoC96qMNB0/eIt6xeb2ugEJx35pS1y/6EVye3YD
 xZ3HWczK1XkF/YrUhQFGMPm+tEL4SGy5MmDwCRXlbRpyTA5kXD/t005niMHgzU9KL155VjnYoud
 48NKvW9n1Li9HBzo5N9vgreqgRhvNMgWdeGFSkrWYWB0lJXYuvkWcK8Q==
X-Received: by 2002:a05:6830:b14:b0:81e:a323:f3bc with SMTP id
 46e09a7af769-86315963eaemr4046193a34.13.1795191366814; 
 Fri, 20 Nov 2026 08:16:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6d33sm2311621a34.18.2026.11.20.08.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:16:06 -0800 (PST)
Date: Fri, 20 Nov 2026 10:16:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: Re: [PATCH v3 04/14] powerpc: lib: Add 64-bit division to the
 private libgcc
Message-ID: <20261120161603.GE3176972@bill-the-cat>
References: <4B9B6E83-2EA9-4663-8A98-73BB63A713D0@linux.dev>
 <20261120090854.4425-1-pepe.schlehofer@gmail.com>
 <F019A142-D66C-4402-A174-AC9B1BF960CB@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P5Rky2ZllvFFNjiA"
Content-Disposition: inline
In-Reply-To: <F019A142-D66C-4402-A174-AC9B1BF960CB@linux.dev>
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


--P5Rky2ZllvFFNjiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 04:04:10PM +0000, Bradley Morgan wrote:
> On 20 November 2026 09:08:54 GMT, Josef Schlehofer
> <pepe.schlehofer@gmail.com> wrote:
> >Hi Bradley,
> >
> >On 19. 11. 26 19:55, Bradley Morgan wrote:
> >> Well, Christophe has the concern, he can assess, also mind answering my
> >> question about the user?
> >
> >Tom asked to update the common code, so v4 will convert the callers and
> >drop this patch.
>=20
> Oof.. (also please don't keep doing new threads, it's a pain)
>=20
> >
> >As for usec2ticks() in arch/powerpc/lib/time.c, a 64-bit implementation
> >would divide by the constant 1000000. With a constant divisor, do_div()
> >uses reciprocal multiplication, and lldiv() relies on the same
> >implementation, as does usec_to_tick() in lib/time.c. GCC 14 at -Os
> >compiles this without any call to a division helper.
> >
> >However, the overflow described in the comment is in the 32-bit tick
> >count itself, not in an intermediate calculation. Fixing it would
> >therefore require usec2ticks() to return 64-bit tick counts and
> >wait_ticks() to accept them as well.
>=20
> hmm. any way overflow could be stopped?

The question is, is it an overflow we might ever encounter?

--=20
Tom

--P5Rky2ZllvFFNjiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawByQAAKCRAr4qD1Cr/k
Cpy1AQC8U/4TCV1PB2hj6OJ9vzEU9RkKAT/FidN2dQc4ylgM2AEAgVVvzQKCwsq/
1V6ANyoo9E+2SSRXrG4wQM082zI9hwc=
=6xkA
-----END PGP SIGNATURE-----

--P5Rky2ZllvFFNjiA--
