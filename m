Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A01C5DF9B
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 15:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 636EB40637;
	Mon, 24 Aug 2026 15:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dOtXQtNoYft3; Mon, 24 Aug 2026 15:09:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787584184;
	bh=fsrkEDKISZnYBVh0GkBewf4ATmIvjQNCXkCO+3bj9jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xsiM/nuA3GJY4GnFFNfP3QD9HuuyOVulH6FEoSJUP+uL6LZr/NF49wlF5o8Dy/MUz
	 pbqULwFuSUb5JU6wcLwqFblgs5WF4kFyMR9qoYBqnqEfBuBUcMY5p2QW9f2iV0j3X/
	 CZsZPBQ877ZkrR7UjUMYwnGvxT5j6WInIwBFniXKvPUCJv8OLcgHCru9Qfm1BPo3IZ
	 +4UL/1GXZBqsJYbHdOTaJvrNEXBjE+xNfrCPH4zM3mqces8551hVUcsAX69Q7LUvsF
	 QofHtN54PtJ3cP8bxu7QcUxPl0/geP529ACUEj0bDw/8dmbmdE6tTeOJG3DGHMiCMr
	 VqDi9yX4m6myg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B7DD404D0;
	Mon, 24 Aug 2026 15:09:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 248EE396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BAAD40068
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2NuNc9vX0hyN for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:09:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=EyEdbZbn
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E605240029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:09:41 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ee4399c423so3322594a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787584180; x=1788188980;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fsrkEDKISZnYBVh0GkBewf4ATmIvjQNCXkCO+3bj9jY=;
 b=EyEdbZbno2+0vAOUSSXRx8c+Zo0HIvjh2bIEp3/sgdG0QP9QInt6Ofokofb9c1Lb/U
 z5OSGOaoDy/p3fZPpqsouLUf/cL6kCDFVtOUeGMR103QPdmTCLRJAWJeylGF2BP/zCJa
 /LsdorEd1SeiATondbcJ3if8RAu5UcA0hnYsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584180; x=1788188980;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fsrkEDKISZnYBVh0GkBewf4ATmIvjQNCXkCO+3bj9jY=;
 b=CYYv0+no4rf+T56acMID8IiNF1A/Hw84e87rBVZDYEKX6DM3MZOgpqNzkOwBqH/Nto
 MdbtwtCVQgvLm7yV+KzdsyBvI8Jj5/GnIcK0jHfRQE5A03qPPrkuwZ1YdCyInKhfgD/x
 9+f+OLQW7+eg22bl4izJ3IOaFZMyBPG5Em5i89QH8T7WOzchm2itxzjGc4XNCmaesHkt
 hYCCylgiH2/OIAv5mNCotwi41CKwK8o6KMISUftLXsE6mDkcyNBkfMsU3yBPSJRPmHKw
 B/3YpI4V8wLg8TkS/+gTcJYQlrChDBYkOhYCiZbjevLkYvgzmxRYujMNy3+9mCtLwh5P
 l4MA==
X-Gm-Message-State: AFuF++kpFcDJvw/9Y0qxNCuKJAIgX/lICuZGS53gPi30YWmVyhd2n03U
 qAjYiknkgnilkkTqWjwLDt5Ppd41OpS1mv+6YzshziA2S08EEvjOEkfMEuaCBGi+oi+Ua6gbbpx
 587Q3NO6BZYRp
X-Gm-Gg: AR+sD134MEC6srY0/ISXo4Aja0sg2SPgokeTpUTa7qSfZwEANSs1yvSkLPnwwYYf44m
 +Fp/y3H9PdYHMRCLyC8ZcyiRjrLCpccbasOCxmGVq+IXoJKjysc1nVRo3Q5BCAydZqTWWe74Osf
 tlwU0tGnKk3N6dvqJA+gX1grJkJzMnB2pDTQTXRBnP+/GjaK1vQ/DPtQQfRvZhNnP7+TLTC3TXm
 8iaFXsFi4UOGm5QocHViw+MEJCq+Zw1zU2oXTCN4N8CRW4RntP0rqvjkf62bpucxXGwv0nLpyo9
 Z8UpLH9NFiq1z2F9so7S5L5EHlDKLRct1tvtGlC6mWYhtlQUYW4QFucZuLQzZpe4gVxth6Gq34n
 sCMt3wTDVt115hgNu9jZiEz1sDujNAI5Er49Kd/N0ZS9sfsYVMdfmzEj5QZQXzpNzcfU+KZ1O2H
 ZeALRXMcWNBD+RvimUFtJrSBoP5l7kPB6P4el+bBUL0bxiBaQvlJqV1ois7raF/+IdIa87rGVLW
 sjHSpTBzwVHXRCWoxgZ1SXX7l5jfSF8svQTrreOc9wr05BWwNpX1h8rGr4pIB4F3WuKo2PRIJ2W
 OrycTjH+SGMd8xAIGtYY
X-Received: by 2002:a05:6820:610:b0:6b1:6738:f5a8 with SMTP id
 006d021491bc7-6b167391e59mr20133581eaf.20.1787584180276; 
 Mon, 24 Aug 2026 08:09:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fae8e1fsm4347327a34.1.2026.08.24.08.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:09:39 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:09:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Suraj Kakade <suraj.hanumantkakade@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com,
 padmarao.begari@amd.com, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Message-ID: <20260824150937.GD523975@bill-the-cat>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qc2zhO+ywbp+gBa3"
Content-Disposition: inline
In-Reply-To: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
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


--qc2zhO+ywbp+gBa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 10:17:18AM +0530, Suraj Kakade wrote:

> cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> path) in the HOSTCC command. With a long $(srctree) that command is
> too large for /bin/sh -c and Make fails with "Argument list too
> long" while building a .dtb.
>=20
> Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> HOSTCC/CPP so the shell command stays short.
>=20
> This change requires GNU Make >=3D 4.0, since $(file ...) is not
> supported by Make 3.x.
>=20
> Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFI=
G_OF_UPSTREAM")
> Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>

The linux kernel, and so Kbuild, says that 4.0 is the minimum version of
GNU make required, so that is true for us as well, so this is fine.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--qc2zhO+ywbp+gBa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoxeqQAKCRAr4qD1Cr/k
Cms7AP953O3kyciiKLQLDJHQwhT67J0CPqf75PJ9JB7i2OHMEAEAvzqN4gKvDMe2
J1MP+PcYRc3jn47Fbx66IPxbr7JI/g4=
=yuOq
-----END PGP SIGNATURE-----

--qc2zhO+ywbp+gBa3--
