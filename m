Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FFBCA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8596640A41;
	Thu,  1 Oct 2026 17:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ln5E8_E_igwW; Thu,  1 Oct 2026 17:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF9CF40A2C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875673;
	b=XUGYZmPehClCVX8W5q6bgdFAGqYH8dUfnbeHUI2Glj4hdO2XBQFWKxVPJYalb1/YxKaL
	 htdCLtZfggPR7JK47sTqC9gluQNMPsRYcWcKCizGoIQW87MPJpR5Rs9sxqnLqzZxgKpEZ
	 rx+KKLfQFdrfCglHeKE9KAuwmAuD80tFsvMDv4rooC2D6OZAZGD2wLZ94Ii6EuqR3bRun
	 jqJvP0THhR3ZnjOEWPbA8sgHPQ49XWd5EwH7wL4mCX8b1xnbsapmfEgOVHOdSHFycw4VQ
	 LoZUXfNGWlVSxY/eVzcbtXN2dzzxa+kGfeYBQ0kQSCFzcXeopXTAX06GzlXF85wsb5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o8HvZ00oYvBU0KgBzdLSUMulc4V5siITFWYwpvLQYbE=;
	b=Q4iDUi0w8eKGXH6TmEXOZc4elj0pS7JhtGLmIPCyCkUEfTdX55DqS5AKIDEBmSxPwLFh
	 6aW5EQzjDr3mVZrJeUMHH3Q57T5EIWRJF4DYXYcy4Y8bqdmo2RZZkHZ7oADxWa5fsNZKo
	 t75FTqLymMvcy8bUetsquJrez1BpbD4r+VuXPjLidmSuswV6iiFu65TOeEGsmj0o9Y9bP
	 ebjIf0hOb/VfiStUUzuRsKUypf4RtWujlYPzBgAax5KHMqUOtRGLONZRPh6tfrjRDGeUZ
	 qqEC/UrYB7lBoKGVo+QOJrG1cUD6WkmkhKTSqx0MtmNsRk52npjJ8E9xbYHVwvKLx1w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875673;
	bh=o8HvZ00oYvBU0KgBzdLSUMulc4V5siITFWYwpvLQYbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nWran2Hru+4nutS8f/gRJGYm/jCKrd0druYX6KRVVNg8iqbz3WcwYAiBlzhQG/Fcx
	 cdDmncf88vPMrQ8To+beVKAPYrwcqDnsehNi9G/uWZNuPyskqo7nvH9J9BZUuQhL8N
	 XVCRrXbEazCdNHEpfuKlAhP/VhzfzDSQ2ZqRXPBv51DxRsKaOpSkTRl9CrnT7mPQy2
	 uxeAy9ry0PLhXnfbdeidCHvYJwUJRxt7GvZdEFkRy6vE+A1oMhqNdoC3aNNJNm5d+p
	 T3diCwsPvo/OprcVT6CBXn3V6KyRci4isD09IeUZfmOykg900GvR2RvTWkxnnm7hKd
	 LVcsBdwbJjMuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF9CF40A2C;
	Thu,  1 Oct 2026 17:27:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0A4832F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 92259607ED
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:27:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMACD17GL2gc for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:27:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BD1C2607EB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790875671;
 b=oB9dqCYooCwsCisapEZzK7hYecXQKr6HupkXng1YR7O5LjvyPVQJPISFbrUmQ3Ef6789
 vbzHhZkvzEc1b2VL5ZBBNyWsGdVzQOu5NV6D3m7y7UVku/THDg27hQvRE8RLJXT415+XM
 wR/w5qzG25aA40gqdRbc4JBLWfWpuuAPIZWLn7AQVJceoJh9quqCdk3pQPfWJC7DKnvJI
 JcbCdgitOsiD0qsGp+wpxLhkKD4Ytj/jSlIB4y6Qc08K9k1++u2/7CHVtWxnFy7252KhR
 Ws7lUZrUBfSPVNFNqj73IVi0ZIPHKkaopKLwnZiL1zJVMpk0C6/nrSz9UW6WxE4avoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875671;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=o8HvZ00oYvBU0KgBzdLSUMulc4V5siITFWYwpvLQYbE=;
 b=HdrJfR3Mge2cBSeWf5WQ41WZVH9vAAMrXWuP0y0CVUsy8ISUXUhsazUwj1ZsIRFZr5lK
 DpE0GApFdPKko3A25qwUbDNnPwGuEAfOiOH5z3MBO7WABqFDYfguqVpsBfPd33Drk50tZ
 8EQd8wWTIwmNHx4cfVxMH/ZazVBvPEVBlkO9QooKpmAFpVLtPSLeBmoHko+r9+kdwW0KN
 TRzNexaeDNZKw97qK0WHd7j+9+w3s51N55BOA+6uMsLes+UHRbg/KATMcZY4ua/wIASXx
 IuXKkQi01lf9ELL5OaHi0jC7dAMs6Asf2i7wh7ym2VV/oGHQG5zZwRRbVueaXX288bQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KXpLWqYF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=KXpLWqYF
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD1C2607EB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:27:50 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6c8f6a53fabso2416340eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790875669; x=1791480469;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o8HvZ00oYvBU0KgBzdLSUMulc4V5siITFWYwpvLQYbE=;
 b=KXpLWqYFdq45YUFRt3hDrOmE579ePyZXy1ciESTCpGEox8t62iG3qgUgEg7mQu+zBj
 hCznokLFjm68qwXvKLzET0GhdJg5eT5vr+f+SJa7FnUd98Vd/niOWrRzAZ3Yfs3Sx4Xn
 S6/jSiiVlFxlbMuyXjaP1uWiqHNKRVN9+2NAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875669; x=1791480469;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o8HvZ00oYvBU0KgBzdLSUMulc4V5siITFWYwpvLQYbE=;
 b=iHLLGPBKKLcrSnYn1umKhRsdRwB/1c51fGMZlL8yvNEd1w2xkCZWbPaYUK5A5OJ1UE
 ZI/OF5sA4kTA8y2PCkxU449sE8QH1E3lqu2bM9pjg9hVh3V8wEcPipAnm2Kje+/yUc/x
 iQP/QHylWWIXNqjtIwt5JtJTZeWSkQwEmjD8wWgPmDTHomqv9Rtfi0PipjAqkGgjSE75
 asx8EVkPy5XQoJ/XlD3OO711CXbfrewfpFKALaBeI09qAxCudiBZ+HPGn8mfckrpAFnK
 nta23EvkooFmD+nQF2r3Ygw8kfkZSw0WYJz/AQ6re1WXqu0hM5k5orldHOa11a0SL35b
 kmrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlWT+4pM5Btk/eIvxt1Ob4HbZJIrMxsZw+8299K1o3iUMTC9p9bLo+JZ+DnxUbepeKJMILVuY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kOEn4rMWtETCz52cZA5pQxvVq0s9OzZiYOhQa33ea3X5H28Xw7
 TG5u1+U6rZ7nvP+iF6Kpnt2BKHsUemA82VgSu/K/pNqY8o+/ikt8ryXy6x0uzVR9ehAqcc79nM8
 XLh54F8Uv15kS
X-Gm-Gg: AYBFou3DEwNqOZX5YIa9C7zP5mEBtmjaSX94v55YIF5FePccaK7pxkFSXUIVIhwBJB+
 4K4nZ9Q3KTN7DQIkwSQt26bRWSrwY7vLKC2CZQvQEo+5c7F1F5jOb/o3O2xrk8Mbkv+3A56Zots
 uENpuMsCe8POmb/GkqeuCSawm5LhTC89nl9Wevsx34uZS0xboLEUpVL/fGF3UxL+luLdqxX0gYI
 SsSEi1+9n9yLLZtE4GvKRtoacjijCC5VesJSWocbUDD5cqqmvcNhJWTXz3UUEl9v46moduM4/aZ
 nbQ4dx2YkJPqzA34s0cKiWNWiyV1zbpZRq8iryxETfonLdjIfnNAbGWsl9fHgrgBnD459Gw9+35
 4Jj2tuTGApJDTV3Z0ODzYcib5EARkWeCKWUk0xuHvPrH4gbnT6CnooKnahzsTkNf/2oWgCW5vek
 +BX8+xPTT3LrmiBMjtStBZayZiLlSXEuDe+Xw14kuoUjBeQx7GEH7iDInIPCwcjs+xsfijd8Pdi
 f93Ppmcs80sPfmjyIl+8n/RZEHgtOLIyxikxzQra9na7F7HyhROmFoKrLU+CIg2Vnnv0XvbOGdR
 n5tU9ofZUXXSUCuOX8w=
X-Received: by 2002:a05:6820:1694:b0:6d3:abd1:9b8d with SMTP id
 006d021491bc7-6ddbc6142a7mr2779069eaf.51.1790875669160; 
 Thu, 01 Oct 2026 10:27:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8227a06d935sm473098a34.17.2026.10.01.10.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:27:48 -0700 (PDT)
Date: Thu, 1 Oct 2026 11:27:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 michael.haener@siemens.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Message-ID: <20261001172745.GO858934@bill-the-cat>
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
 <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
 <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H87Fr0OcRmtGNBVH"
Content-Disposition: inline
In-Reply-To: <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--H87Fr0OcRmtGNBVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 05:03:31PM +0100, Simon Glass wrote:
> Hi Ilias,
>=20
> On Thu, 1 Oct 2026 at 09:41, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi all,
> >
> > Any reason why we can't add this directly to the uclass probe instead?
> > According to our docs, the probe is supposed to 'make a device ready
> > for use'.
>=20
> IIRC we talked about that a few years ago. Probing a device is
> supposed to get ready for using the hardware, so we typically have a
> separate operation to actually talk to it and get it into a particular
> state - otherwise just probing the device would take quite a while (it
> also means that TPM cannot be used for certain things after init()
> unless the board is reset!). The same approach is used by the
> keyboard, for example.
>=20
> But given that this keeps coming up, we could perhaps provide DM
> support for this sort of thing - it's not obvious the best way to do
> it in a generic way, though. We could have a DM flag and perhaps send
> an event that the TPM uclass picks up on?

I'll let Ilias weigh in here, but I feel like maybe we've just been
treating TPM wrong and it should just be on-probe.

--=20
Tom

--H87Fr0OcRmtGNBVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar6YDgAKCRAr4qD1Cr/k
CsicAPwOBq0UXk1fORkxf6KA1d30zz3qe/PVq77IVXhlnFdUwQD+MFvvz8BvCiw8
BSkzRNLwJI7mCpKSY30GuEZQkeEmhws=
=rGL2
-----END PGP SIGNATURE-----

--H87Fr0OcRmtGNBVH--
