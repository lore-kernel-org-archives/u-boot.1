Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EDE606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FysdI6qZ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=PDWM/g4n
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0864440804;
	Tue, 27 Oct 2026 17:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOPCVDucvt_H; Tue, 27 Oct 2026 17:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0075A407D3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793122621;
	b=p2jco8kJB6pcgZ1YPTlnEPmd7TWusAAja7OKfjdGquyaZzeKo+PLeHQ7GL0yNhE1fvEl
	 aLHfWbnZbKz5PzbusFq3xVa0l9TF9FDMTY8vfHBy594qn/DQAvYoxb8d/CECEZmzB/XZ8
	 81v8IZrk/IzZw5URBm0FWCZpgmPe+X44Ck9RL8u6wJzkDbR8BAJy3BN2TO1x41iGRszf+
	 bvClnVpyAhG4L1PKMgQg5wNAqEb6b9Z1SnAZbrsogrRT0EWJcOs8QDnLFWNQGUcso9+jc
	 754X7DSlgtaDt49woSWl2iPVIuGYy1wUDX1MKJxStt3IIFlMnb1pHVRfwLGj8wJuwOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793122621;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2N165dpo2pySgAatjslO/6/HZtgbtVp8vg1h4Hjy+KI=;
	b=eyII5mxmUl2BTFRgZJINW+eJnkFO1NZ0R/iL8Mp13FweRKxK9pB8gTXdEzlcqmB+ploS
	 sPeXbe/A3YCc+5++7z/7mIEYaqfIG2RE6i6Q4tpyJJSYyXuIOPBAdWRwgp4CRCf/y+gyo
	 +OGPx9EFoEP1TJFkvW6NkamgWJWIglNQ1fVjzW3MyXt4K/ML7w1fFT5Ua+KRzdemcwWCa
	 1ePZWpzLT7pmW4iWavyKSDpQdRfyDo5ok63tKVRMhNk3a+QF/cNEoL3hm1cuzaYvbc6vY
	 6+lIfDB5itEQzyTAYZY4ysjAZtzmOfFfC2t/n6i21bt3JAxpK/y8kN0es1xYRUKVPlQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793122621;
	bh=2N165dpo2pySgAatjslO/6/HZtgbtVp8vg1h4Hjy+KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FysdI6qZXeb1FdocPHTmNBhb/3uZ200K8QBmiZ4bhYh0nSE8ZfiWcCPCWYl9vzzpO
	 0jTm6ldBv9pN5JbAP9SbZhW+sbcVAnNppfE62fiCG1UhLdTY3J1F51leFpyJMpMoW2
	 70u0RUALJc/0PklReeIklQCLopsg5v7fKX4tbW4KHErzThRswudKrVjYDm0TliSmLO
	 HdNs/lDWrIJqshbJz0ZjEGebj3SuvlTEnalnXvjlutxhuFb6gwGEFpXzz34tMCArH3
	 PfLLaTNhOxxebwMGGGGfLQDN0NHYVE+E9YEjvBb0oiKWgG7J59aTUa/q4pIT+GltUp
	 rauRJOfqz+M/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0075A407D3;
	Tue, 27 Oct 2026 17:37:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA91672
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D128D401A0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zl25VmyzXURb for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:36:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 108E94006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793122617;
 b=mLNDCQDNs+KEMR7bVivdGOuwfy92c/pfNu2eRK7dgYVFZ9yte3k9r9lSTRUQOQyxRwoZ
 RMWG515tIVLjC1SgxQQZH/0yupgb5z+6ssz3cxnKVqUn9nbDy+n5gPrC4au3qqhv25p3b
 b0B/WaIKhoc+yCUgJcdbQ7KXc7/EdvfakeR8v/znBNdUhE5S48hXW92S9wRentiq/0WcK
 tnG2dURaSXegCOUGID5+1d5fjqrw9vyrUR0tUFN3GdD4S2cbn/VGJ1HnTtfLbStuTCd2s
 FktY34jANPhUYHPFucVsqrCbioMY6gJpIXfNPMACga+2isRV3FflOSn3ED/YiK0YgRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793122617;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2N165dpo2pySgAatjslO/6/HZtgbtVp8vg1h4Hjy+KI=;
 b=oibdpuzVvZjzQfGCD3mPDP4fxamrIiPcm6q3iFXHdeSpdoAG63D+ggC+jikPUoV0mlgy
 E2SJ/0Zv0hioSRA2aLSAbSNzG2J0Jg1gl+h7QnoFQ8fusZcuNlHH9miWCRn0hqGTaDXys
 k+0nfoIMhDN1lMmAnD02xHqMF7kprZ0jKTwIO6F3NM1l83OeMoPs+LVY+HZz+4VOHiQyL
 kPrQKthF8dFRBN9QC7GcefwxXDk79wNXFQQF7PSKyXGIIQUQQCsdfQ0Q4bREe5t/jLvJm
 xumyL6AixG3ZXr/wK/erXv6kcTICVtoU/Y/OPElLp5HilNDQcq+vFod6P3+d5lUPVLQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="PDWM/g4n"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=PDWM/g4n
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 108E94006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:36:56 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-702f1150a16so43507eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793122615; x=1793727415;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2N165dpo2pySgAatjslO/6/HZtgbtVp8vg1h4Hjy+KI=;
 b=PDWM/g4nd7AsaUs7bBmuNEr4I4ugyXGzX5ngWFFtIiRi/mekvf/3nGRhgABJNkENEQ
 JKIRSK0wvZcCPBE1Y7i5G3wJARsczeYGEhR0j06CSqSTnLWjic8wcPZR2t4V1j7bV0Fz
 SzrOadYiIHVtGrXphgqZ2p5DRXidY1zwA6AaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793122615; x=1793727415;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2N165dpo2pySgAatjslO/6/HZtgbtVp8vg1h4Hjy+KI=;
 b=SPVty71dNHjwppI8XJH+mPjE3fjX+5lVniQ81zd3sZ8OsmJ06t0czJ41qc7Hivl9sO
 wMr5QGR7Os94VbsvilBaXo/wskz8ncOMYKQ2RAATg9CmeTeKUP5Q/NfYEnnHUSNmhjCx
 gViQBQNpprxWZ4yxhsW0N9atWGkw59w8iPGnYHOgPmIYuf1ndRbMSSI3q03lhe/YhZva
 ASSg+924sdrd9f/dTnTJzHnkWskno6WnupkmBZ9LERoitEi5c4g31aMEaw0M88tFPuEO
 weCHd+zT+9mMeoxRyDcLKl/2wzW9m4WA9kB1YGFZAriA/Pse+2DMC47xxI+yt8Sx8orD
 IhOQ==
X-Gm-Message-State: AFq9FYL6+D/IiNCdt6t6zkfECFnQ5drOJ3lDm2gfagSIoL+O11PL0YkQ
 tW9bqBF3FB5lf2KhkZDb28oWq1bCNb/X/H8Ahigpv9K5FlKFd5jwOlq4sAOzN/pW+QIIHKeagYY
 MGQJucpK8GOqpVPs=
X-Gm-Gg: AYBFou30coKhoPNEzZfdAv4BLqeqfMW58ntYqMLehEXhvkm2kf4Aq/zhYhuVjryd89s
 POYGBmsae+KFZwYr9Zk/4IjVa2UdZC/3MnWiy5jqKGKY7GF4CPdq1aSKSzQWPlV5BIliLNZPemy
 MjMbSoIO+rQwF+d72PcLQ221gFuwPdfvVopDVEjOl88JYIhZj+QiorAEFOrq0KjneyVC7QSO4YH
 3ICIJdbHt0lF1BhFtRw+0M9TxpQPKQMHt4HaIZ07dXEx23HgD5SkW/vqy8ZK5/MYZzY1XdoZMAj
 8XBV4ZHfsaHNg7mxCRFvBb5ug2lTzk4vFzdKowSj9pY93g2AnXaVVsvedoAZLMevI/1CRw6EBGz
 kTkWpXNDr67GuY9AYefokNVRz75g788fGyezkkjRuIbQ1rlNuSthaxsvQfx//h0FShDUAQkFQz2
 SsVR8GBjUyrguSCj4w6nAAczV/xxEifzgE6njADLx+RyofeK9gMbHg/iEU9Dj87Wrvuh1Z0i4j0
 rNgUQ/AJrj3DuVlYi1fj6DMayHgTTS0s39g1aaInmYwmkXDE6aVw2MPL3Rw0Zd5nBnHyuX2AMu3
 Ff+cLviLLiTWra2z/Nqqaueoaqxp9Bc8E+HJoLqhOPFJsZMo4NAZoapkDxEwU8SgcyEelVQSTfw
 LuFqXP+jPK4IyUGVWM16iXhftbtc0P0T5Ob+vRZ4f9xZrXjgXY6fcHp6pIA==
X-Received: by 2002:a05:6820:258d:b0:6de:3bb0:aa5a with SMTP id
 006d021491bc7-70ba0f810c9mr4662491eaf.81.1793122615594; 
 Tue, 27 Oct 2026 10:36:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e267e73sm10947351eaf.11.2026.10.27.10.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:36:55 -0700 (PDT)
Date: Tue, 27 Oct 2026 11:36:53 -0600
From: Tom Rini <trini@konsulko.com>
To: terry zhou <terryzhou05@gmail.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com
Subject: Re: [PATCH] net: preserve the driver error in eth_init()
Message-ID: <20261027173653.GH2177077@bill-the-cat>
References: <CAMPWMbrVO9-ZVYQu6Y0GSA37OXzTrg+nyZObyxQJKtJvBErmQw@mail.gmail.com>
 <20261026142950.GB624796@bill-the-cat>
 <CAMPWMbp4EBpAz0bfAVeRcMqBxJW8VMvchbP-qOzufws2hn-P5A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C0z9wDnpki5E/wKD"
Content-Disposition: inline
In-Reply-To: <CAMPWMbp4EBpAz0bfAVeRcMqBxJW8VMvchbP-qOzufws2hn-P5A@mail.gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--C0z9wDnpki5E/wKD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:06:35AM +0800, terry zhou wrote:

> Hi Tom=EF=BC=9A
>=20
> Yes, I checked that the base commit includes ff448fa9a1b8.
> I re-tested its change with and without my fix using downstream
> SDK U-Boot on VS640 and SL2610, rather than running the exact mainline
> base on hardware since these boards are not supported in mainline yet,
>=20
> We are now adding SL2610 into U-Boot, below is the first patch from
> Richard GENOUD <richard.genoud@bootlin.com>.
> But only few interfaces are ready in it:
> https://lore.kernel.org/all/afb22430-4cb1-42e8-9b22-5fc57eaf7625@bootlin.=
com/
>=20
> ff448fa9a1b8 sets eth_errno when device_active() is false. In the
> failures I reproduced, however, the device is active and the driver's
> start() callback fails. eth_start_udev() returns that error without
> updating eth_errno, which remains zero.
>=20
> With ff448fa9a1b8 alone, the diagnostics showed:
>   VS640:  start_ret=3D-5,   eth_errno=3D0, active=3D1
>   SL2610: start_ret=3D-110, eth_errno=3D0, active=3D1
>=20
> In both cases, eth_init() overwrote the error with zero, and DHCP
> continued with 17 BOOTP attempts before timing out. With my patch
> added, DHCP failed at initialization without entering the BOOTP retry
> loop.

Thanks for confirming.

>=20
> Thanks,
> Terry
>=20
>=20
> On Mon, Oct 26, 2026 at 10:29=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Mon, Oct 26, 2026 at 10:11:37AM +0100, Terry Zhou (Synaptics) wrote:
> >
> > > eth_init() overwrites the error from eth_start_udev() with eth_errno,
> > > which may still be zero after a successful device probe. This can
> > > report success even when no Ethernet device could be started, causing
> > > DHCP to enter the BOOTP retry loop instead of failing immediately.
> > >
> > > Preserve the return value from eth_start_udev() so that callers can
> > > detect the initialization failure.
> > >
> > > Signed-off-by: Terry Zhou (Synaptics) <terryzhou05@gmail.com>
> > > ---
> > > Validated using downstream SDK U-Boot on Synaptics VS640 and SL2610
> > > Without the fix, driver startup errors are followed by BOOTP retries.
> > > With the fix, DHCP fails without entering the BOOTP retry loop.
> > > DHCP succeeds with the cable connected.
> > >
> > >  net/eth-uclass.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> > > index 07ec59b97f0..18efbfeda71 100644
> > > --- a/net/eth-uclass.c
> > > +++ b/net/eth-uclass.c
> > > @@ -349,9 +349,7 @@ int eth_init(void)
> > >                       debug("Trying %s\n", current->name);
> > >
> > >                       ret =3D eth_start_udev(current);
> > > -                     if (ret < 0)
> > > -                             ret =3D eth_errno;
> > > -                     else
> > > +                     if (!ret)
> > >                               break;
> > >
> > >                       debug("FAIL\n");
> > >
> > > base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
> >
> > Did you re-validate this on your base-commit? The base-commit is after
> > ff448fa9a1b8 ("u-boot: fix error check in eth init") which I believe
> > evolved from a patch that looked like the above at first. Thanks.
> >
> > --
> > Tom

--=20
Tom

--C0z9wDnpki5E/wKD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauDhNAAKCRAr4qD1Cr/k
ClKyAP9t+lSvmrUP/792optDp0DZ5uJq0gQU6woWL/cwtXfpzQD9Fu2dIgykWcvb
ZqSmQrc2H92lSj8ITg+Lzru5yRsmjAM=
=PvKo
-----END PGP SIGNATURE-----

--C0z9wDnpki5E/wKD--
