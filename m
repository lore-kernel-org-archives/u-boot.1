Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DC606A31D
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0EqCx/di;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FQSw8PJv
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECE1B40631;
	Mon, 19 Oct 2026 18:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YA7_oe8FBUD0; Mon, 19 Oct 2026 18:19:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1221C4054B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792433991;
	b=npJRUebzSa5kMym60F9wckFf5+k05NTaqXsdn0V2qS8ul1yYJAkpabxCwLKYPrE0EeAS
	 VsiZpiNGKqNQrtT6hG8AyteE7jJ9RhrfT0rSxfv0SNGFJQkG7nTwr/lWoSkVAbE/MK/76
	 rAay+/3Kf1nuVP/QVjd/VnHyKholtNp8amOwpVRfswBvtt8EcWK4QwYA0Ek0s3rGx2Pu0
	 7KsThs0Vg3GSoqM7dqtu7BS4toMQ3O3BABtoik7Xxz9FGjx6ItQzoAY4NvVpjPm0CB84z
	 JPJ33B9qXYuplJ0fU25s/1rwTyvfv9aoHB+Vg6IAx9w8Xgawg4OWgsSyT5YdI5TVUzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792433991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oPq/JNDLfThitxblMFwT4kTolJ2B8k6EE+c7WZ7DE5A=;
	b=NBF545jrIAgrkfu249vyPdhBMx0zufB5MvoHsMuZ4mygH1bXoFVAUJPE57mmyPWOCdlb
	 Aj5c/M8M0l5qq7AmKTb2Dwv7p52Op72+f929rEeSV3w8EF3VeLkDLiZjRX+qcGbtAYWBs
	 355ElY9v/tBdz74EhizuNBCLOiv8LKSicCriCreI78WiJGOPcm5ANs9/SAfVfacNQfDgo
	 j9RHCeVRZskdeaXgD97qFdywNf6OId7ZvvlZSChZ/D5YEJ5pKuz3jqQslzyN0qfS0wke0
	 195w6afaytU3TbeiE/doTWXag0L/gaopZnyg6ichpbPnJvjcY3JXWJojEHAY0TJ2uvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=FQSw8PJv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792433991;
	bh=oPq/JNDLfThitxblMFwT4kTolJ2B8k6EE+c7WZ7DE5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0EqCx/diRXf9pe4Q5WT87YcmvysOjIX37yXqro/+G0y4GJolULB2iA4JLxbFdzS+4
	 XOHeFqXoCgVx/K7AoIbK+rpRk1MzIb+VggEQeQV0u14JuclQosU+Val35qNFiofIrm
	 fld+GeEVuKQuFFIfic0GCnbNq2/KhwVOXiJq/62Q1LadrhLqNtJNzOCe21zbIXgPih
	 8BiM55SBfO1/mpTkjx9fiooorpI5x6At2PzUe2bTVLVEWQbrU3VmSJvNml72kSIvYs
	 QoZq9kq90PjZJv3XroKk0jn7w1Zhp96ZBKm+roy7Z5xQ3yXfHV72k6NuzLX1Bg2pXs
	 KayVdvmA5l9gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1221C4054B;
	Mon, 19 Oct 2026 18:19:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24446279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 087D24054B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tW14oqkpYslx for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 18:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0EB3740541
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792433988;
 b=nd0mArl+oYVkPfzznxp2sFbdQHbehtZ9SbS05quAekhtdKBUuMM9nfpVSJCB9Fsb0iiS
 D4Pk0O1Llmp9k1PlyyJOlkXyDfH4nU3OgrEQ2YPkU9ovHLZFthzGA+0/sMxBVhhcuqPYk
 sJE+Wdo7e8oRroG8xif7Bj4fCxp7DMTz5P+g+faouf5F9dBbvBunFxPxVxDkzL4JrI3V4
 Y/m7JqLX0WX/GwOMVQgmu5ezlEvm85R9mvNbhhV56uS2SU1m5lEkoXU8yayGEq4pxyV37
 fwM5SnODnoitYX+Hm7xlMgv2XnB0Ha8PVVUnmypnwv+mZcEYYioxIFc1P8QEBncrwAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792433988;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=oPq/JNDLfThitxblMFwT4kTolJ2B8k6EE+c7WZ7DE5A=;
 b=IOZfCvRj7DBtO6aj2sRgkSNd9PAjcgrXxyrDd1Vcse/4ytxfOTZjGqkjf1HDlqk3XmJl
 ZN5j/ewr6oHFYY+uiGv+78s38O55ZMYGvXEieykGOS8XGvM8ZeY5/R6pPe5rNM2dUZQlJ
 p5t5dyUJeM5xsuIpZxq9N0KJ4Q2d015cMZjA0HTVTg7uVuWUl/liQSx6OuNoNaMq4sBYy
 +/GOgee6U+ejRakbFNEmwtanpwMnBi7dzvfiq8wZTNAnJexorQR9uv8ESzAO2QksU1yaA
 Ku8yPFK/oC4qCGLtzI2MS4CtGZ97F214Ig/uVPO92J9aoAvo5WcVukDcytbyR4fDFcg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FQSw8PJv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FQSw8PJv
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EB3740541
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:19:47 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-70073621339so1487089eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792433987; x=1793038787;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oPq/JNDLfThitxblMFwT4kTolJ2B8k6EE+c7WZ7DE5A=;
 b=FQSw8PJvWWGrZ4b4o2aDLV8mpbNCuLqHo8PEQQ7c7ifdT2LzI9MQcDQwH16WYvL+Sd
 0gWI1gdRJ9B/BeOGhIwZqr1w2BlI4m5aKKpWbjSf2kn8WM5e8eqbGdX1Io96XDuY82mJ
 MUK8qu6USJKM8RnQWtr9ApE6HkWDtKoT0LyVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792433987; x=1793038787;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oPq/JNDLfThitxblMFwT4kTolJ2B8k6EE+c7WZ7DE5A=;
 b=j2gn//c4oX1bEtnyu3d8TvbHXKDlqhOx6FE/JOerUJDaucIhA5otbBkgPGFu9a157U
 Xvp2Y6w4gGHbh44GTk2Uhqk3AMDNCdZsBSfpuPHMKNhR3R6OuLkfxfsWixY/4y+bzLpN
 l3Q66jYWlqkocxUelIvZP2nAUIEJz2WVX83YqvTZiQD1pjeX4fjtPOhKxcY7h0sShFds
 YK2nF41rSE4koO3856s2f/qT7sU2nRStcb93QQ7Uttv5hR6sJjd0kSvbBl2/oQw6VP8T
 vSX9pQ2IbvPxosWZizbgXVrop6aDhGZyzaasuemGOXGgf4wJHDSHxJJyNhRp8hjm3t3g
 ZC5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZPrKS1rF3Vw3juuVvA33SSezHKeHP77NDQxvLj8uDlxqtzaWpuVpMGjctcbBUj7Qm+oEEujo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJGrA60tE3Lb27FdDKJAufVl7G8ck31zLVoDjCNoSwdbdEg88tW
 as/W7vC4TyvZCgIUDSjLrNjAsIHkgDTmQf4GXp4JoeHWA72zmNCQydYQdIt1Hz417ME=
X-Gm-Gg: AYBFou3ZIijYiur5D7zuX3U8WhkIZDwguiQLI21xo31GzNcNw4R1vu30i3sPEoQGp56
 a3y0arBcVrtxCpWSF81YJGMCxBjeF81yL13Xqv68nscqe1mIb+JPQa0YYcOf5etW1PA5zPnKsVF
 zxKUTV+2LuPVvZQif3eAxwL1KbVjR8w9Yd5XazaIMca8fTZV3R4jy/VUH7qDa0gtBe/FCPY9amC
 9N/tlfFMSzF2dzSKQ6fMzbuH58Jfnm/Zu+gnADXS8T1ALf9tE5HDwH5C3qJMKnOI6ube6bXotuY
 KNu7F95FJVyyRKQo6DflHugNdhYcsyzTRrBSv5NhMsaRwqgLOpCOgphU2apo+bQNSueaFYjEMVV
 0PKZt9isUDX+zmHN1gm31EZ9aaTOjvA9JVJV5A4BPTVYZY7Rp2CQOZIWKi6+BNLbsLXrqIyLF9O
 nMxqcEuAIUTFHqbEaEkv4VfemV3knFQR9FgqjZOhVWqbQ6glaEj7NBSawHhRAQ4KrpWJZVWVdcN
 Q0M3EoPW8nmyD55GKKlTaJYKrqCjuB6ah25j3vob274tCyrtyNmzFeqC12YoVktfNiOZkXRPl/F
 sacIynwMdt4B+xTY8mM=
X-Received: by 2002:a05:6820:3381:20b0:6b7:8415:d790 with SMTP id
 006d021491bc7-70356fa1561mr4572267eaf.59.1792433986620; 
 Mon, 19 Oct 2026 11:19:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8487c3cdacdsm4286915a34.22.2026.10.19.11.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:19:46 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:19:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261019181943.GD720525@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <CAFLszThDcdt14Chi=UeO0i-gpzUvXMQR1Dd8c1ZVVk6Xgtvidg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0eaE680xzeJyyR9m"
Content-Disposition: inline
In-Reply-To: <CAFLszThDcdt14Chi=UeO0i-gpzUvXMQR1Dd8c1ZVVk6Xgtvidg@mail.gmail.com>
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


--0eaE680xzeJyyR9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 08:57:41AM -0400, Simon Glass wrote:
> Hi Tom,
>=20
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > But then we would need to provide the whole device tree, yes? I think
> > this ends up being a tricky case because we're on QEMU for this. We're
> > just checking the signatures on later loaded FIT images. Maybe the
> > series that adds SPL to QEMU could be helpful here, since we do have a
> > normal path there for applying an overlay to a device tree, I would
> > swear...
>=20
> Agreed, a whole DT is the wrong direction here: U-Boot cannot know
> QEMU's runtime shape (memory, CPUs, devices from -device) so it must
> keep using QEMU's DT at runtime.
>=20
> The merge code in patch 1 is already doing the right thing in
> principle: take a small built-in DT that only carries the signature
> nodes and merge it into QEMU's live DT. The remaining gap is just that
> OF_OMIT_DTB=3Dy means no built-in DT ever reaches the binary, so the
> merge is a no-op by default.
>=20
> So I think the fix is to arrange for a tiny signature-only DT (e.g.
> generated by binman from the keys, like the normal vboot flow) to be
> embedded when FIT_SIGNATURE is on, and leave OF_HAS_PRIOR_STAGE alone.
> An overlay fragment would work equally well and is probably cleaner,
> since the intent really is 'apply these extra nodes on top of what the
> prior stage gave us'. A test under test/py/tests covering the merge,
> perhaps using sandbox or the SPL-on-QEMU path, would catch future
> regressions where the merge silently early-exits again.

So as I kinda thought, we're in a funny spot here, because it's QEMU.
And so yes, going the overlay fragment path sounds like the right way
forward because that also should match what real hardware would look
like (we're given the tree by some prior stage and need to augment it).
We might need a little re-tweaking of the Kconfig logic (some new flag
to say we need to build overlays, and not fall back to "and now we try
and build a dtb for the board") is probably required.

> I can't help mention (again) that this would all be a lot simpler with:
>=20
> https://patchew.org/QEMU/20250405191352.2597585-1-sjg@chromium.org/
>=20
> ...if we were able to explain how U-Boot's use of the devicetree
> includes configuration information.

And I can't help mention (again) how unhelpful it is to bring up ideas
that were rejected for good reason.

--=20
Tom

--0eaE680xzeJyyR9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatZfOwAKCRAr4qD1Cr/k
CtDFAQD5NmhPmgIFa6nl3N9BJFNaRH0liWXsmkxB1ZgoYw2zTQD+MjInjaBlp0sW
YYEYGoLDF7aKGBWRM1rpEAolYLsHNQ4=
=AU19
-----END PGP SIGNATURE-----

--0eaE680xzeJyyR9m--
