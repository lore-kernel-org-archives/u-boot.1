Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68F6C5AD7B
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 18:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 461FC406A7;
	Mon, 10 Aug 2026 18:18:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pds3zEGJUJmM; Mon, 10 Aug 2026 18:18:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D25A740696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786385935;
	bh=08l2Fcz+5a1vh0lKbO9Y0BEXY6qnqfqry+sjMiZuCsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oacmCIk3i9xcMnKY76rYCD082517gx7UTcUjBO+4mckLYHub/rE038EsngvX8vp7V
	 iNDoW0dGVE+XtVx5VaSaDGAi02ckWzQxclHpwod2a9QUp/hi58p4UvR6MYzBllnFP1
	 gGxC86uZu7QxKJ3YtwnOrTiAVm1DEwTerpgsqddXH14nR6DhZRP7PI/XnQDJaaKNmo
	 yeG+gEjlP2/UZxX1NbkcR1hBM09q9PK6GbsX4hoYhi3f9YTJC7jQlq9AriXZ1Ub4HY
	 FSZSfExgA9DFU307FVkAXIfwOSYK64aIDUwjI79Hx1Ze6iSKY13ochryf48T2MYX1Z
	 4TjZf75YnzgLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D25A740696;
	Mon, 10 Aug 2026 18:18:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF75024E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 18:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B196F40191
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 18:18:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id srXeC1O9-Haj for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 18:18:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D2A3E40180
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2A3E40180
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2A3E40180
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 18:18:52 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7f0167e59a3so1140870a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 11:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786385932; x=1786990732;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=08l2Fcz+5a1vh0lKbO9Y0BEXY6qnqfqry+sjMiZuCsU=;
 b=WqiMjg7FVSG+PYvZgcXfBF7QfWoCiMRKeqbpt1WSksbDqjn6MQyvLqbzElPSPwy1iI
 QoEPQNT6dYYD5U4H5Y1ZuPUm44k8c0+MhNWH5f1T2mUPeewwLs4//xSgiLfkwYmtCjFo
 BOo2/zIshXLa+nBIiQoUr6gcMza6A5JgcbQly7BSD1eVvC3pAR1USc73jjafOApde/JF
 fbVVMoMNii0ngPODpt42UdW4c/RQkfbPR+wvHf1FMM9ZC1KHa3GSSIm7YSKoEAlivXdX
 G7rFLaX0UlfZw37sNWOG7nI2f43OQmcYiPzC46lJUBrj4T9x2sQIxZ0eVoNOFVwZCp92
 OIsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGS1t1bCrvKaB8biaVZO6Ndqjy38dFwV3br6WGBYIRG34zfolMgVDw3pHA62qAX/2Jz3SPEMM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxukmblC8pP+Af6NcGtn2As7k2Z0n8HfOvzFzQf9HHwOiZed5Wb
 +AS2f+3nQXigaXQotEYkyaIs++x32qMEieUPLBdHtl6hubJh/W95oDx8Net2S1AaZg0=
X-Gm-Gg: AR+sD10aCVwYIUK9TrgOf79pv739UQFy2wNscCu0SueHwD9+5x853B4sfDdKkQos7Tf
 qMZ7ar4g3wogmAfRSphb4fYGkNk4vRNl2iXe025YJ+5pmVzKs/kCllZDgm4vTuAGw/bH4Q8Xqdv
 WqDCh9dRprWaCGmVNwkFccNk+LAZDCo7E8bH1QWpgXip/JUMmQFxlSaT7iBOSKwR9sna5y9NJvT
 bAHcDGNy3TpyASZekCnCBRQKOviTLsWYhjaoH+JEQpZdnJ+RO+hGK0ir0FuSctQoBFpSsZ7GfUP
 pbM8R9A5RYfwftxPOF4pXhL6wRp1AQ+5BfhAD5L61fC0XoxAExmIeeAe+aXWuK9k3dwEY91YKuG
 n3aLMdqVWrpdFt5C983pzmKMBtvstom/qWGBQEVvQIuDkW6wu7uTRTqvYj1MLH0gTAJZVgx8Md1
 bFShZ7O4gEL4fifYBEFfitGYWqheQ1d6AystiNFNVtl8gVs3XkKPlHbO1MyxHUAGtbV1WbEv/By
 I1RatT3KMp/a7WlyBQZJMWuNzBvFx+jW0IPdxp7JvEAT6T3JSceJNIOXwsaAGYGVeic0rdK9QvG
 p5ifQXenOA==
X-Received: by 2002:a05:6808:6f88:b0:495:fa73:2e44 with SMTP id
 5614622812f47-4b1ab9fe7eamr12688244b6e.15.1786385931717; 
 Mon, 10 Aug 2026 11:18:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1af688c1asm6974160b6e.17.2026.08.10.11.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 11:18:50 -0700 (PDT)
Date: Mon, 10 Aug 2026 12:18:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] mtd: cfi: Replace env_get_f() with env_get_yesno()
Message-ID: <20260810181848.GD1160436@bill-the-cat>
References: <20260803231755.374057-1-marek.vasut+renesas@mailbox.org>
 <cfca4027-3c8a-41d6-a8c5-602994df4822@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ToXsyeqnoHOTFfu3"
Content-Disposition: inline
In-Reply-To: <cfca4027-3c8a-41d6-a8c5-602994df4822@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786385932; x=1786990732;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=08l2Fcz+5a1vh0lKbO9Y0BEXY6qnqfqry+sjMiZuCsU=;
 b=TlnTF/nHM56YmOxMwUWSXSqOSiMnjX0IrTrPs191gQRRqm1bqKp093Yf7Ar6/Cq07L
 SEwV44NVn+yT7YZt12tQ99PREtZDww7LbV+q4mASyNnp+GM0U4IS20cSqLmyJrL988IH
 IfJQ/CoLoUxFsNhnpXLMIwMSbFfJZlqe/cToo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TlnTF/nH
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--ToXsyeqnoHOTFfu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 10:28:57AM +0200, Stefan Roese wrote:
> On 8/4/26 01:17, Marek Vasut wrote:
> > Simplify the code, replace env_get_f() with env_get_yesno(). The
> > env_get_yesno() internally calls env_get() which may fall back to
> > env_get_f() if the environment access is not initialized yet.
> >=20
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Stefan Roese <stefan.roese@mailbox.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: u-boot@lists.u-boot-project.org
>=20
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
>=20
> @Tom, could you please pull this directly. AFAIU, we did not create
> the cfi-flash custodian repo in the new infrastructure. I don't see a
> real need for it, as CFI flash is just very rarely used nowadays.

OK, I can do that.

--=20
Tom

--ToXsyeqnoHOTFfu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanoWCAAKCRAr4qD1Cr/k
Cnv2APwJO/eSGjNnybvjeEJfiKRuVxs17XpI3XbTsHe6X0l+pwEAj6Wl4XTtvSGj
c3OQlOvAi331wdTp5je1aL72z0Gf1gc=
=TQJt
-----END PGP SIGNATURE-----

--ToXsyeqnoHOTFfu3--
