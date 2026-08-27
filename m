Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2762C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 20:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9E866081C;
	Thu, 27 Aug 2026 20:55:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxVTHO1orC7n; Thu, 27 Aug 2026 20:55:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787864122;
	bh=Dp/DcVzccOQkQG9NmxhzJe0hBKQIspHsc2tliKoeNkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZkKR0MacFOt/lqC78HU0yuu1osbPI4potaO9DERFr202hH6x0JWbloatgaLuJG+i
	 89LufnU87v5QXCuZUJNCWjGFlB4iV6uW8MjRP/dkga7LFDnODtUChehvzXBSN5U7Xx
	 r8ERK/VfQt1QfKhhre5BG345EAQpHiADw4IVxypwnYgq8+7MzJ8EjR5HMN2z+gWdFz
	 RcLRu5a+TGFofTbgDYIVZQ+Xag9zGp58LTyfn0HvlNfysugZu2LUDg/DaRBHfyY6H4
	 0/VF2mEvOw2nnB+kuZPY9rvpJcy1p0InOUYx8Vry8KFja0u8DSyQCF1F2wYwyh0P76
	 AsHHxlA0zJXow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E79D7607EC;
	Thu, 27 Aug 2026 20:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2360C465
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0915C80EEC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:55:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hx-p-5asy_IL for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 20:55:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Nh17tfUT
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D9B580EEB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:55:18 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-451e1066971so139320fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787864117; x=1788468917;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dp/DcVzccOQkQG9NmxhzJe0hBKQIspHsc2tliKoeNkU=;
 b=Nh17tfUTFMcZX95bQrhPTiFUMqYdPqM65RmZVIDuVrLT117bXiKQkrpVvA5n63z46G
 WrF9t2cvdFanTyp5HqXIktZqFcimrNPL7rVcCTrsHs9CKJASwiFYzF/OmZmI3li3U4aG
 /Xk60XeiG7njoDV9a7QCWil6rTKfb7Bs6iPXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787864117; x=1788468917;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dp/DcVzccOQkQG9NmxhzJe0hBKQIspHsc2tliKoeNkU=;
 b=pH21BeSE3ykToQraitcGmHKSdWLT+MaKak3/GjsLkgk/de8liPbAj4knNuFIDfNjE8
 zX/40sRFKi4aoZgSBpvF0779/99+2slfmhZwtvqfpLShnGzHqEuS97GgP2O/JWdwnZbj
 60BEZLJ4GBMfGX8svsTI+6Ht06ZkmY8+D9t8A5eZeS3zbJ4lVmA7bEh/MjZh0gBOvyoX
 K6PEv7MHN5jNexumDDrc32UVul5+AJIlMq1zFIkJK/p5snDdh6Oirc6Ft0fD3/O78GGP
 0kT808la1/6O+wag+pej9hmB5YWmZzP787ffBJna/Ok19q4sRIRHGJbssLienfRwiCcm
 VH+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFOSGovOOpB1pUjod69O1vLmJRpD4T8+pVLJtcY8ppJdajy2twqk59s9KNm3dcaadlRyoE5yU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k90K4qmEFuspT6yOjjr1/16SgfS4H92u1DOrMOk1OdwvwN5IL7
 Bgq1jJ+Ls+q5XkENzGQ3mY32olx6qRt5jhMik9xY91GSkqMKBEh27JA4vadERBQKVtE=
X-Gm-Gg: AR+sD13BsEYJTQxmzRObuzc/rhtk52yCH2b4Zbk0qDVRYleNhLfM6BrwTkvGjXDoHea
 xmeg9opPfh7n2XPc5AAoO26vBNHfqU8cJRRXZB6h2k3xdcTplNkmo1ud7EKqY24YxA2tXQLIF5s
 h19eHTPesf0l7ph6zgy7ZMWU6Ad0XQ6obPwVCceDtgTaKpDeECYQaAJaMyiHi1lW7HF1s0p+iRR
 o0enq8CW7fyX6RYbX23C/Hwv1nbsdgp6GLpNrOP0xjQx5+j6wONQ3P5NExJD32Dn/5lollSRAq5
 VMc+bznl/jq4ldwd1M6q6KuVD/Ihmjo65lMFiOMdq+TBfMLqNYuHwL3RV2s051r/fJXNjaLUI7/
 fYGl4dsW9/53z5x3eoQVZ4XYSz5z1unpm11LN/6e96HUUwt0f/dx2MQqxqpHlCkIYe27DOSZsyf
 LJaPhJC2lmosMMnpFuCsfOfURHOH1+w553W4L7wuvFSqIMldMWAA43dFwzgE1/NYYBosh7NIt2Z
 TJ9x3BaxFSoSzy6pJ6G6cVoSAXLniokx6RLYukqhe+1mh62osn6MhPHZcvM22JrDJIyNglvk1iP
 riL5LZ4svA==
X-Received: by 2002:a05:6870:75ca:b0:448:c1f5:90f7 with SMTP id
 586e51a60fabf-46837894e34mr2346203fac.19.1787864117372; 
 Thu, 27 Aug 2026 13:55:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46738ddee6asm2907182fac.11.2026.08.27.13.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 13:55:16 -0700 (PDT)
Date: Thu, 27 Aug 2026 14:55:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Simon Glass <sjg@chromium.org>, Raymond Mao <raymondmaoca@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: merge software ecdsa support
Message-ID: <20260827205514.GF3959812@bill-the-cat>
References: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
 <20260806200154.GA165443@bill-the-cat>
 <7655d8b5-af60-4ef5-9ef5-18419e12d3b6@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sIMKBuqJMaBY3VuX"
Content-Disposition: inline
In-Reply-To: <7655d8b5-af60-4ef5-9ef5-18419e12d3b6@softathome.com>
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


--sIMKBuqJMaBY3VuX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 04:59:26PM +0200, Philippe Reynes wrote:
> Hi Tom,
>=20
> Sorry for this late answer, I was off.
>=20
> Le 06/08/2026 =E0 22:01, Tom Rini a =E9crit=A0:
> > On Tue, Aug 04, 2026 at 04:29:47PM +0200, Philippe Reynes wrote:
> >=20
> > > Hi Tom, Simon and Raymond,
> > >=20
> > > Do you think the support of software ecdsa may be integrated in the n=
ext
> > > release 2026.10 please ?
> > > https://patchwork.ozlabs.org/project/uboot/cover/20260601134310.24524=
54-1-philippe.reynes@softathome.com/
> > At a glance, it looks like the feedback I gave a while ago about having
> > it be enabled by default in some config (likely sandbox) so that it's
> > actively tested and compiled hasn't been addressed yet?
> The options ECDSA_MBEDTLS and ECDSA_VERIFY_MBEDTLS are enable by default =
on
> sandbox.
> Do you want that I enable those options on other configs too ?

Well, from the reading of the cover letter, it sounds like this isn't
enabled and tested by default, you have to do additional work. Is that
not true, and the cover is wrong? If so, please do a v9 based on current
next, with a corrected cover. Thanks!

--=20
Tom

--sIMKBuqJMaBY3VuX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapCkLwAKCRAr4qD1Cr/k
CpxSAPwNEsyvzSxrQ7BizJKqyQ6Xn77phJc49IdvyM8uJErf7gD+Nr9G2D1BvGFi
oC41KYJp9GMXBUzPuEs1yOG1l7oW3ws=
=2A7u
-----END PGP SIGNATURE-----

--sIMKBuqJMaBY3VuX--
