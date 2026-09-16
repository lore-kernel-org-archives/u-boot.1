Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807D0C982C1
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 17:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4112B60640;
	Wed, 16 Sep 2026 17:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hkXrBiL3bZ2M; Wed, 16 Sep 2026 17:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8FF0E606B8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789578146;
	b=azktXJfO18Zu8ifudpdaaUUblrCEYulNsRDqPBoTX9DF7PY7xTy6vkIXD28aEoZ7A9Pf
	 xHtSjCkBR993VC8yowbbHjrjkKB/ldYCz/KImlisYbxtfssjm2jyAtE5vcdIK2kKn68v5
	 EvY/xBBCf/TckeG+Wml8GQoIvde4wF04idtSTjwQ3aDePSTJ5T2ZGYp/aRBnblF9MqpMf
	 OWIfWdIYSwZG4QbDb7e+JDm2FXhu3rIJIVE/iIsSjdiaCR0DP40jORkdryssyBCRGDSsw
	 MyvTZfGUr/vdWgwxD9qLign280n9h/lJbQ3wPyyrIUhiyU6+1XTAF/UQKz29O1VeE+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789578146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aVK3yTjFKTxZa5INKR/kzS8iaQ+SdSu65t/84C/ipJ4=;
	b=CmD3mAIh+f3shsPIerISPsrqImhgREbriDcVALwIBeCHBjow/RE/1cpKV+Ylt8ImO80a
	 eP86h+WP8+TBWpvOPfK9wN3IJV9FmmeyHCyboyn5xIiXcmfz+Yr4yuCJaDxq/p195+l3z
	 kTCRsd+FYBNkUjHBUqAr8zZPllmyEhrfo8/SUo50opOac2KU73NXO0dg26MoNVCgYEUgD
	 ZNukh/NqKPQUvRKXqzJyXQ/ju3hOw0LKl3tNugFePFUNdauwEybirhubyBxDxOxIn6zt6
	 zAMO/lpsOJrUvPZhhqy00gbAP0jJHw06/p6oeASinuPo/A4q6/k5uIjDST5ZNCBee8A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789578146;
	bh=aVK3yTjFKTxZa5INKR/kzS8iaQ+SdSu65t/84C/ipJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hKdFapL7Phlp5+n/E5QqYm2BJj8Q+qA0IDUryXo9aISC1sn6T5TOTv3I0hKMWbh7M
	 cQTz4ik9+8/1siNHlRJe1PLaB1UlNP3X0EF5kGKfb5fOYE7hvGR3AFSrwIn6ILGidg
	 ESZWQAhjUbS02DEC6VBCubgKXyZ+NmjxaLRofKmkPGljanwOofOcXm0GaZ3IBg2jy6
	 Lsb/DcOLtTJ+bqXpTH1ayiERrQztpKp8JmGKFl1cPlo6MJ9NtcM5J8IZ1joerAl7PJ
	 KnCB2GG/qQuhrqscInQpo68c51qnuesYQWJKE2GR7eRngFcQmSGoA8HGFboKq2bq1X
	 tddwmoVf9o/DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FF0E606B8;
	Wed, 16 Sep 2026 17:02:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EBA3493
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C75840308
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6IneAVYtmXl for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 17:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 62F7F400D2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789578144;
 b=QvPhDAKZJ3rDlrdpVEQSV1WeOn4gNvrRv/48JRHZ0DdO2rSE2yIvNBv7whqTlH/ClTMB
 CzB9+w+TazJDw9lrKJAIlPZ4B8K8ZltR2KLzBkxDaXKoHi9p5cU29yC7SS1AnMFplN6mO
 X2QfIJso1vR2F7+yJKuuzeJJPOxtEAomLld2yGM77dOulVDdCrsl5MCh55hSxXO1zUhU1
 3gZ80weOILyauDHEOLmWU1yUuhRJiH5ixo0wxchn4iWVRS9hU+nU/c5RJXkZo0W95mrLn
 qPZ/JIJaCgEhu3iL/PQ/00HOlR8nWE7R3HkgHWcwc3piZ62F21dd9xNw3XEU7P/rtvQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789578144;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=aVK3yTjFKTxZa5INKR/kzS8iaQ+SdSu65t/84C/ipJ4=;
 b=DGWh7MvXjDNgCRvw6CwKrhH90UWNgm6nHxNhXR3c5BwYe7nHckU7U6VuMmCL/1ro2/sH
 c6F4WVpvPP7OMEYYJs69fbJpDazv9ma6SEY0Lzg7moLc15LPPPC9BPfi/22uZP+YIuaF9
 qrryhuMu3Go92M7n+dVIfCzOjsflxF2ZUEnLNtAFxLEBmobhNO+6snmAymDAH+0MvnG1q
 uEc2j/NrmkN2sLWtlJ080RMuLzBXlcAR923YTIX1cu/zB4HOOjXb9UaSGjNnE81dvg8JD
 n8CLTMU+cAbBo7RYS7xaL7sm5l6XjBW89sy12o17gMKUBprLVFn3Cr+XbL8xRN10Rzg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XpLrrb7l; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2a; helo=mail-oo2-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XpLrrb7l
Received: from mail-oo2-x2a.google.com (mail-oo2-x2a.google.com
 [IPv6:2607:f8b0:4864:31::2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62F7F400D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 17:02:22 +0000 (UTC)
Received: by mail-oo2-x2a.google.com with SMTP id
 46e09a7af769-805bf8c2661so979297a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789578141; x=1790182941;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aVK3yTjFKTxZa5INKR/kzS8iaQ+SdSu65t/84C/ipJ4=;
 b=XpLrrb7lPg+eJnhxxJRMJugyPdOpKFNSjuIUkMTA/ROhXE4rq0zbvQS2wJqx78HW0H
 wodPHvgeDToMM0jZHgIjL60j+I5+q4LDlnA37tDbeLR2DvwjSTZPAQrAHBde/v2gaJgv
 +0s/SgAX7glfR78RGA3QsAIowRbDY0lhdjjNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578141; x=1790182941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aVK3yTjFKTxZa5INKR/kzS8iaQ+SdSu65t/84C/ipJ4=;
 b=1BYnx4XxtPu8MIbWZUonMoAR706ArcPW8RaXK912uKyWYJuh4SggnS7uSvZNpUf+ik
 Eyp72kX24gmXrGZlJXnsDzuZmD/+qTbDUbY4zgGZaiuVYgwtVIO265FxA6/7LjAA7OOU
 5iOlcZosNqstsrOHUiwmI++/XH6PRASbmSdhDnkHrjvW+Hfi2tHPS/U/Pyf1/KOflkS4
 giq5UZ03mKUwDIAnFx5iGlYkmkQRIEidyZok+XXjwJuAo73RTnzalyamycmoSlfNHVEX
 wOwpKZCKax13IMANgMl5KzNqPf7p+G069xcZzTM6NdIgOFnVyMGcWToz/34GDscLapUq
 GDtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwa895W/WVfytmyypHQ4sotv8iznKQAnG/yAOuYGYCPGl1Brjx50PZr2MUl3Y8FQUOuCZ1iMEQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kXfbEarCKT9MMwE1iC94+GPh2Qx7gJAnsNBNlPgy/iZSytnvGF
 TmSNDhZ8odh8FECIpEKzGFWNpJdWQ1vIWyG8Kqn914xHqRaLKAGejDUX11Tqv3+NZ659fqHB1Kl
 YZLfPwyNVj8nE
X-Gm-Gg: AYBFou2UyV1NbnMPUzegOFzdUv0IbKGXBgSsh9kNZvm+yGnU+Ugh0lprtU9o2DBDQns
 HpC5GjDqFbXiVENFyHhFa2GCy59lzZ2DK8o/rIaXEcVvbSeDPDDtmobEmsAx91g1nd4xJEZJDy+
 QY5c6stGpE78eqQ79vLI4bVJb3Mkwhs+/p86VOHaQez5jwWGaMOim5fIWhjDQZ4wUAhlb08sXXW
 5MmQoVZxeUAaPoZfLRoxnluKoWKZkL1kTZySxwEWp/eFWD39oE4acSgsj2D5TTfXg6PYbSemIcX
 y6iDyyIXznduz8jqZgCOaSWo17nWdgbjktgbKmh57ITtaexZ4FtU1kVVm1v5sMdGQ3qdSvikUp9
 Ua5H6jgShyalumNTtbT9PKVylEs2shCCx2GlZD8NPxi5e3QWiYvkeG524FbX+1hHi9R6Jw09kMS
 AF+gkyDYngFpkcGMnvIpo6PfbG10+iw/t5gUlEZfQ0l/fSL5Z4eflYBf/vHiz2gnG4eBmH99qNa
 jYF+P5UnQPZj31muhlfhAwUbYXkqYLi0RgcyIkLpIEE7xeSvZ2rrnOC3JDzL6XYMUAB+b8FqfQs
 NpcXUzIN8ev9rm74ETd7
X-Received: by 2002:a05:6830:6319:b0:7e9:adef:4fd4 with SMTP id
 46e09a7af769-80b2c6adf7emr3611331a34.11.1789578141137; 
 Wed, 16 Sep 2026 10:02:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80c476ca2b7sm422693a34.26.2026.09.16.10.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 10:02:20 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:02:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Eva Crystal <0xiviel@gmail.com>
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.u-boot-project.org
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
Message-ID: <20260916170218.GH858934@bill-the-cat>
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
 <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
 <20260915154140.GA858934@bill-the-cat>
 <0ec38395-d0a4-42d0-a3b0-0e98412c18eb@siemens.com>
 <20260915195033.GC858934@bill-the-cat>
 <CA+pz=k+EdBCCyna52pyygJXFW+nrBS7v2iRRw1yeQZAW6SLqcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LRfpJ88XETrovRjh"
Content-Disposition: inline
In-Reply-To: <CA+pz=k+EdBCCyna52pyygJXFW+nrBS7v2iRRw1yeQZAW6SLqcw@mail.gmail.com>
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


--LRfpJ88XETrovRjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:44:45PM +1200, Eva Crystal wrote:
> Tom asked me to base my image-gate series on v9, so I tried it. Two
> findings, both about v9 rather than my patches.
>=20
> v9 does not apply to current main (a44f46af0a). 1/8 is already
> upstream and 2/8-5/8 apply with -3, but 6/8 conflicts in
> fit_all_image_verify():
>=20
>   <<<<<<< HEAD
>                 if (!fit_image_verify(fit, noffset))
>                         return 0;
>                 printf("\n");
>   =3D=3D=3D=3D=3D=3D=3D
>                         if (!fit_image_verify(fit, noffset))
>                                 return 0;
>                         printf("OK\n");
>                 }
>=20
> Cause is 2c9b117aa4 ("boot/fit: use fdt_for_each_subnode() in
> image-fit.c", 2026-05-08), which dropped a nesting level. v9 was
> written against the older form. 7/8 and 8/8 are untested behind it.
>=20
> So: Tom, which base do you want for mine? Rebasing onto v9's own base
> commit moves me back onto the July tag, which is not submittable
> against main. I would rather wait for a v10 on current main than post
> a resolution of someone else's series.
>=20
> One other thing, Ludwig. v9's "restore debug message instead of error"
> walks the missing /signature report on the config gate back to
> debug(). My image-gate patch moves the same condition the other way,
> to log_warning() at default loglevel. No code conflict - different
> functions - but landed together the tree has two adjacent gates
> reading the same node, one silent and one not. With
> FIT_REQUIRE_CONFIG_SIGS=3Dy yours returns -EPERM having printed nothing.
> Happy to align with whatever you settled on; I just do not want the
> two to read as an accident.

You can wait for v10, thanks.

--=20
Tom

--LRfpJ88XETrovRjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqrLmgAKCRAr4qD1Cr/k
ClauAQC+fqNYofEzmlipO69AzMplu2jUWrgF+a7RdzWhtnme1wD/bgeaG9xxIYB5
ztbtRocRbYj+JW5fIlt3h+l8Ew90xAI=
=P8yK
-----END PGP SIGNATURE-----

--LRfpJ88XETrovRjh--
