Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A307AC61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 17:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 536B041208;
	Wed,  2 Sep 2026 17:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDwR7KQSwgI6; Wed,  2 Sep 2026 17:05:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788368675;
	bh=1JkppuDYxA21Cw1NjvXEbEPO2e8SVArjI1rKmsHux1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpVUiUm0vsoaaToo9DRuqd5jl6Y7/wixi2xTLbO2l7jUvBY1saN1usdO5buTfNWaD
	 tlixgMCAKLEVR+fz5zk7OnZtBlFxMZ69wPOIlQqL5it482gHLSkqkU+lIGQT4Mnmtm
	 G7W1icopJ8IN1ggIf72OigKkLKIFQPA68aheZ5rCQLQWdoc295FEQUFd88GMt2Jci9
	 6EJ5a0ldLdipkvshcKHCRDlfoCwJorz0M6otcSlyw8HP/On5O7dBF0DYEdD7KAPb6B
	 DkDqg0z9zWL6wYcHST89lngRiH4mGT35munDipFLAvPMsQYXenZQhtq/9oU6cSSDMF
	 2IY2lvZQFviKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C966429F0;
	Wed,  2 Sep 2026 17:04:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 997C1498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B33B4046D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:04:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3TEJDjbPWnIq for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 17:04:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=S+Mzn9mk
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 82FCC4039F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 17:04:21 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-46af2e2654cso688984fac.2
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788368661; x=1788973461;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1JkppuDYxA21Cw1NjvXEbEPO2e8SVArjI1rKmsHux1k=;
 b=S+Mzn9mkmKeh3dX60oJcckK2ILZnXwBf5sClVUkpR74wsg4a3bSc46m92QIfbXdv04
 2l5lqInnZZKd+nU/lXBKbrrCMUnisyeq9N6INUHfEWp7uBfRGBftI61nyV03PlGS9Vrt
 83+6cK9Pn9/+n7r1eqgoLtS7xbwYat3dk48p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788368661; x=1788973461;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1JkppuDYxA21Cw1NjvXEbEPO2e8SVArjI1rKmsHux1k=;
 b=OrwFuyyUXaqLZBHvGKxGMN8UK6/3SM40cekR5J51e6FFJF2zOG62V7JmP0OqEZTE0x
 LEXzprjI/MPz8pcZmWLhVBlJh0P49ON9rpPbmTuYkLOeGNC3q4gHFLVobGrnwwdkGN4E
 eZPrX/DFauLM5xRUKjzuv4nJ7AncO2+khsAvjgKtWC9fVDvi/zdoo+JNMm6s/ZxCpMJE
 9wc7d/D0WYwTQiATC/I3li4D607uwTmIzz+kavAQvrgO3XXCK3jGgt+AIlOBlMvQDDiq
 sHL3F3QdO0FccE7oWR9Io/KdlDR4OPpfgKWwVO/tuT/Jt9Olm5+n4pMcGIo1TdRCqX/A
 jVmg==
X-Gm-Message-State: AFuF++kT66ZTftfqZ+tygiGML6RWg7wY3AO676m3ECAPpcWAnlfVKKue
 4SGG7Q2OPr+ef8W+rqKGxkHvygAn4RYeP+f0LwexG8OR+MG5R3fpJR7t3FAIyJbfySo=
X-Gm-Gg: AR+sD13zokL+KifjnvJHRit/CPipBNGRSGD578qkqeHKBm+G125aDtEIlVmNdQRPuRM
 2luVz6Z9WbuKt4Xc/4A5s+Ik78kJzdee/YRzBXvrSCoSGKEr++3iRXDEtwYLjrCExA1QOeY9Q1/
 f5prn3IO1ZGt9RE6uq6/GvKV33JcGkAUNxrxQd6CPODopULIPfnzftDIn5ywq3t48Ld8Dpqo+GR
 szWmA8lFXSReMjfxBtnGIsVa85JAlUa/wvqeRyZmc5YWF09bp2DfK+usnwJ4uFWK0IenFIlebyX
 qbyiWPZcQeELQhrgYeRtAp3pDVRDfS4nMcES6SmXZte9R3WLbRRqkbfO3km+E8PtrY9FWstVkTg
 SsXhodUuAKnJ8XhQDMg8vFbI8Ja8CKz28e32kJ9THAqUgQMV+Q48v3NXHzUh5tQr3jqTPyguEol
 T1bRzYSB4Nbfb8Yr1ADEAwvdUEtwpHh35CDJFjASzQT+0UWodOfA82019f4j3wqe0uDzjcuROLo
 6n3A2E6l6ZEhD+PHMDNdhuUzyfvJvDQJbgSM0sKyla0JAE1fMUU27NQ1NIQgHcxqm2u8mFzLpVv
 qsUdCSDZFQfQ1pfJKEBl
X-Received: by 2002:a05:6870:b48b:b0:464:c314:ddc2 with SMTP id
 586e51a60fabf-46f87ec4f9amr5195444fac.8.1788368660754; 
 Wed, 02 Sep 2026 10:04:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f330822basm4277783fac.15.2026.09.02.10.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 10:04:19 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:04:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] u-boot-config/domain-map: Add Qualcomm domains
Message-ID: <20260902170417.GF1764417@bill-the-cat>
References: <20260902164006.1719873-1-balaji.selvanathan@oss.qualcomm.com>
 <20260902164546.GE1764417@bill-the-cat>
 <8a5d64ce-6e25-4d1b-9d24-f2995f22222a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kG04BplXFfRK1GEZ"
Content-Disposition: inline
In-Reply-To: <8a5d64ce-6e25-4d1b-9d24-f2995f22222a@oss.qualcomm.com>
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


--kG04BplXFfRK1GEZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 10:31:01PM +0530, Balaji Selvanathan wrote:
> Hi Tom,
>=20
> On 9/2/2026 10:15 PM, Tom Rini wrote:
> > On Wed, Sep 02, 2026 at 10:10:06PM +0530, Balaji Selvanathan wrote:
> >=20
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.co=
m>
> > > ---
> > >   u-boot-config/domain-map | 3 +++
> > >   1 file changed, 3 insertions(+)
> > Thanks for the patch. Do you need me to re-generate any of the old
> > statistics pages with this, or just use it moving forward?
>=20
> Shall we regenerate for v2026.07, if thats okay?

Sure, that's easy. Going back to v2022.10 would be a little annoying
(oldest qualcomm commit I see), but just one is no problem.

--=20
Tom

--kG04BplXFfRK1GEZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaphXDQAKCRAr4qD1Cr/k
Cp/qAP9uF0iclLIcMK8KgmH/28TdcpFHaXJZO4mHBJdJv7llNQEA9dbPZNnGxyIG
RV3eAlonUz4q0iixFQ4Ok1vh3nNo8wY=
=xu1t
-----END PGP SIGNATURE-----

--kG04BplXFfRK1GEZ--
