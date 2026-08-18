Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE31C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 20:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77F8C80E50;
	Tue, 18 Aug 2026 20:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pwspsrHgAVp; Tue, 18 Aug 2026 20:41:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787085695;
	bh=AA4fusxLPF5y+cJjoqSiiZVk3vldDD4bvQxtBGW2Jb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNvRNi1wykk4qP4lEjmq6QyTq1tmYIGrctQ4/XTwOx/0YPI9H/oYqmRlw16YVWlzT
	 tpOze7quCmybXJi69w8V++Mz0amjMHvwdBPrcceTZB++2OOh07qktr8SJ1e9HDLb6X
	 JREoyBvtsblKqGhH50xdqe+5dLUGbhRRrSuztkfTyiCD9E7wSqR5G6SnAC+GimRCJi
	 bZm4dMiSrDkfclv/8v4SesBQjVm1tvMyvJZVpiYcI28nfXJEJ3AArIPM1qx9tY+D/6
	 bS23724IBNN/yNQQJ8vmR89Td93FfeXnww4A+SYGFG/YVg/ciY4LzceFI4SBuOUgIM
	 jfOPbVijzgjqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 904A280C92;
	Tue, 18 Aug 2026 20:41:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E29E2B2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FF5240581
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wxd0onIKwesz for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 20:41:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Esnw2uBf
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50275405C2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:41:32 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a4c6081f9fso134456b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787085692; x=1787690492;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AA4fusxLPF5y+cJjoqSiiZVk3vldDD4bvQxtBGW2Jb4=;
 b=Esnw2uBfbxUPujWxVszTNKKlDgmB+GwGeGYLC68s5x8PJpSD5989R4zj1eEsCdXbos
 dyuO0Ns04ywMBW7hu3PZPN+2HEFzLwHZ9E6ZxM0yklKkqOAfzVsYedBzAFJtGPfZEPFe
 AR7/YQnJq6hR32NaC7G8QQdIVweGnWjSBBQFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787085692; x=1787690492;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AA4fusxLPF5y+cJjoqSiiZVk3vldDD4bvQxtBGW2Jb4=;
 b=TGzBfb2GNzXVrcfO0mM9c7Ni9Q36xY0temrwM40E9SlFc4BUwpp9dsXK3CSmKuxpsk
 0rwkCqVzSHwsViRNcbAHHaF8NvTk8TDZ7zoqTAfC0rI3jwjaQ6Mmh1DQXAHdDnOBsA80
 7ahBjtW8jQW/Y4x3y4v7f8Mq0NJdzuWZusXfJl/o+opk5dmMJsoEVQW3CgzE/LuxXWSW
 zn1BuwmabOoAxjGshb8RRraNGZiybUZybt3mYidTSZL/fEfyQTYWVuzwqe3rqlOhUFHU
 tmfYehCipPAt459Ksya1iJkdF1/TuUbVmh4NGUmWPTcjYtZqX4Puuf9XUbQ54XMUkofE
 /+yg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKO4OKGNZtKIA7B3UOpDe+cRPb0gmMYMo8mdg5skUQhwc/xZiOurp/1BXICvaPwh7qBZva62Y=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzPqLjOkZZq0nL1JaAvvKpX36yVUB5TA147Tcmdz70RcialU8k+
 acGhDSvXRpiY2boMShenBCkIpVWWvMJ9eLbRo7lRV8Do8WcXTOmcNZXuuevdGHlbj8E=
X-Gm-Gg: AR+sD1345DHZVojj1hE4jFNpm7rvJyE4tdhkoNsru7ge4OtB7Bh2zbY7sw4uUY7D3RT
 IFxG+lg4f/bN45p9fjBWjlUafjjwN4ZOROrDDZXzRaSkOQO8CXwzaOqONDuvOUhbifL0PkQR8LD
 XB/OQ8CoeG0pmcfc/smXckLRlgto9uVp96gbKxLX/Wn8StfsUaNMppbLbhtTb5a3lag4d5PZn4/
 RxL/tS1oOrKNqZcnwArrCRmmu+DFMd/1beANQ0xX2mfOJcbTJCjzQlqueDJ25xzS42xIQn2IuX4
 e7+bokNnRK7ZXu0iKhGMsHoX+WjXPWtQBMQjICTPTlqTSZvLEvYAzw2P/DKGESPxmbjIFVRDWSw
 2DXUsOM4StSgEiIY97bkCM4AKgbxIXrlvzL2ZmBralaSHNtArThYAO2b/cXpv7amhxeFFRrb4fJ
 byKLws5HCi/fKUSRsoXdP6i7muxypEXJ4bqxeNHZVGe9K8Ry+3fgcM3Xsl4RMWB6fOPX7viH768
 1G/DSTy2SsfUCO6CjCogz+rXpQbQc4madJVh+LydBUZAT2PesaJTKuOuOe8Ek6rLb/RIZ1bmu5F
 6ySyMKG8Vg==
X-Received: by 2002:a05:6808:5385:b0:4a4:da68:9434 with SMTP id
 5614622812f47-4b2b90e9c7emr379781b6e.14.1787085691991; 
 Tue, 18 Aug 2026 13:41:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b290ad5073sm4323652b6e.8.2026.08.18.13.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:41:31 -0700 (PDT)
Date: Tue, 18 Aug 2026 14:41:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Gokul Praveen <g-praveen@ti.com>
Cc: n-francis@ti.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/3] No-SPL Boot Support
Message-ID: <20260818204129.GD523975@bill-the-cat>
References: <20260818115322.101705-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jjfoN99ZKvJI2Eya"
Content-Disposition: inline
In-Reply-To: <20260818115322.101705-1-g-praveen@ti.com>
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


--jjfoN99ZKvJI2Eya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 05:23:19PM +0530, Gokul Praveen wrote:

> No-SPL Mode is a boot approach that bypasses
> the A72 SPL while retaining U-Boot in the boot flow.=20
> This mode provides faster boot times compared to normal boot=20
> while maintaining U-Boot's flexibility for kernel loading=20
> and system configuration..
>=20
> v2<=3D=3D> v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * Updated the naming convention used from "semi-falcon" to "no-spl".
> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-pravee=
n@ti.com/
>=20
> Boot logs link :
> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c

Content-wise, this is fine. Naming wise, in v1 you explained that "No
SPL" (as I partly suggested) isn't right, because it's just the Cortex-A
SPL stage being skipped. So please, work on figuring out a better name
for this flow internally. Or be sure that everyone is really happy with
"no spl" being the name for the flow where you're skipping SPL on the
Cortex-A side, but still having it on the Cortex-R side. Thanks.

--=20
Tom

--jjfoN99ZKvJI2Eya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoTDdQAKCRAr4qD1Cr/k
CmTuAP9s1NSxUJEqudl3EjJ2HZSfBqqNBZqYJ5Aki952huYmaAD/UbBk1HdYsV6D
Yxu90F1wNN5i4gSlbPuofDL5geho1wQ=
=p85r
-----END PGP SIGNATURE-----

--jjfoN99ZKvJI2Eya--
