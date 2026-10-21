Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA97606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CIA+yJYT;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=N0wyrbvr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 949936178F;
	Wed, 21 Oct 2026 18:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cVnkcaiQeVdJ; Wed, 21 Oct 2026 18:22:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CC46D6121E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792606901;
	b=FmflQoynQT1w3aUhPAG4p5Mfjb3+f83sfyR3CgJPRwgcZzR280P4vxy5/aZ+hX8C5VeR
	 wzdDSkvIs77yUVw44V0SedGCmL7lvC3tbCAUgnEWb4kt2sjqifzk6RHHZC2bQ6gsmNoQg
	 +beGEt8FJsV9pYjV/SrTjzgp+v1b+2IIeSH85vvF5Q5IPsMsRgDPijT7NyzEMjcU/6Dr9
	 09WZ6GW/WFNmANb2012hmjcZQGCQYcX9rOQjG5AHEF+0YSdN7d8SY8+Z6/PoJ9DbTUdDf
	 /MBz/AjpxYhGqVsXkGTJcJUqYu1aIvN6HXoCgLbTjmu2a7uFsv91XNbzyqbbkqG2i2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792606901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uxroTNz5SFP6CEtabhqLqlcEEZqeZzXVslCAmuazvD4=;
	b=oWdP8EhXaH6EOHJE4QbUtxHkaX8WKNexDnVz9612qPkYizdwQHv60nxER4Lp38/ENPFy
	 0C+MjZwF7eGkLjTVArah1/punj/3ojliGNC07tyUe216cNhH60s7ec2C+mxID2nzJ1bcU
	 Yg089yVqY69/Z+aQ1QovuaIKLg/UG/aIjhdAeY2YV40veNy2dHSWhaVHAcJdBR+jEzkYc
	 JtHWBSAQySD0sLzCmoaizL8Q0dibsFc4Y8NEJAW2VK332SgxIgqShL25SK508K58RDbtI
	 YRoZ+fjbHMPLQe1hZ8wP1qOGOW8Ab6KPnxJ3zjSxFnlDqsbLdCPA2i7NWo2lh/qK1SA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792606900;
	bh=uxroTNz5SFP6CEtabhqLqlcEEZqeZzXVslCAmuazvD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CIA+yJYTc/Men3SvKejD9niby/vs1+r1TPLM/iZ6hKZBL/YZ1kzGFz28YvKyqHbYn
	 XfxAIs9wJkHMDujS8T6ops1QUD5YyRzJNqvEWy66vmsiC6+fLu7CVAQVSm13KAZwpN
	 lkxrxJgObQtH7HfBmpnbjT4o+seVSy4dUy4siBQa8plYxCAkIhjhRj5kbLYvelwu/h
	 GX2kyncV5da+lH/+gu1g+3QHMmY/g9PBzvSw7qSDYMk9lpVmERDmo3YFL6zc9g9yqU
	 BI/cOM+yBuLfYh6au0tI9PPHMUbGKH+agUmTRK/UWyG1krucZmV0ZwD2jiQSIY2spS
	 QktqKBxe/CJag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC46D6121E;
	Wed, 21 Oct 2026 18:21:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 503EF95C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41BFF408FB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHfcITQbtFMS for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 18:21:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66A19408D7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792606898;
 b=BLTbGmFw+zO6lNhTqH7g4CjRLjGOOWvc5Y0AJOUUEhnuQBrKO7uX/nD5MWFSmBF+xmDV
 foDm+ggMDq+9dvS0UCPX/UaZPuWjhF97PQnVllJgybGxWDSHI9db11v3aKdL1t4whSi66
 XLRSNKxTERv0QSgUnkn3HDXw4NE7uET/1sjgIyPUc1/5s5umVGuQf/aDeRsONx6tv9c20
 4gLTboFeRuI+pPD4kC4XxInziECRa7JafGsDZiy7epKPEfA76qUOwkZaEtZqejXp7ah9K
 5x5jFr0Be3b4MIroz4nu0gx0VO3yUCgwx28oqNZxs61r05eBL1+gxeuvliKvoi33Uvg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792606898;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=uxroTNz5SFP6CEtabhqLqlcEEZqeZzXVslCAmuazvD4=;
 b=kgxKNBE5FpUCETZxdeRVm9vB7qoGiJ+vRm2vfImxTTE5fiUQru+1Lr1mS3QTpldoJF5a
 wVCtjxtzxiOZXJh64B1q2Z1a2sZigYoeRvbBAYHj97NfqZD3tPank+KmM8dmGuXNwGXPe
 pNhCKoEXHf7kgZB11sVKG9O6xSfM+53muSh8Xr7MvI5iZTh8+WVQFwsOXE9anR3Nl3yNt
 NnJQnZyq9cvm2t1eDih8LVWDEvLApNx0c7WaIJVtuKf8wFsnzDxWWyOoELPou9q5XheT0
 pzdk5L0yb5IqLYvpnHFyNGkMea3OsSaO5NYgg2iLxLhZCQl95S5a22M7UcMmI8WqgOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N0wyrbvr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=N0wyrbvr
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66A19408D7
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:21:37 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6dde81a6820so710160eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792606897; x=1793211697;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uxroTNz5SFP6CEtabhqLqlcEEZqeZzXVslCAmuazvD4=;
 b=N0wyrbvrtqXoTeFPsuzFEXGxmG42O99kLEpGy5r23k2Di4m6qTB4CE9IFGgJ5jOowD
 8/VUvFXBc4a3joH/PXSiqBic+cBulQB/b41OylnOIaSLY9Pr4bxy4YGlCm6bxV2MDHNS
 lDimOcQ/d8yqyxgy9gQabOTJl8CTcjmKiv/qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606897; x=1793211697;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uxroTNz5SFP6CEtabhqLqlcEEZqeZzXVslCAmuazvD4=;
 b=gFpgLCiAjiEPQWSlMynpFIg91Ukd+ZruVeVyR6e7LWsTXbVvh9E/ZTHPkNxIGOElRk
 50xm1UZwAcbmnRPO7GTu1FA4AeSPDI5TXbK5CiScdwToOYmXeD7ck6BmReFWxcjYDdT7
 nxGaNyiG8AKnmfsqSI8f48KtrfbPQ/lL4zi+NeEybex0l3FBpeeJO82twcc5582KXz2t
 vL1qeE+cKkAUE0cJlEe2YBBkB4V1iW6zqXqIz8WGaVKALA+N4tkEY22AZB+XQgvfnivf
 rG4h/vLmONMB5P6GjLnzEuJfgmWb4RhIemLkiovFz68Cy0/29Rn55ssqjyoFQDUhuOhc
 zwXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQ+3zJBDyLi5yhq395NnhRoJd1+Z9jqEKuNHAHQCzsyrx0P9j2/K7RjrB4R+BkxrUOpBzz+Zg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLLu3R0MIZkazc+nE7cpLAhK4VjOgNWm7cjUEzleV+9/04RixMB
 1fpuH+xpAxFC2n1srCEW7tmeLpatWhn10ynBqhOD6jZb5yoz65wr6jP20oLWgUmgWtQ=
X-Gm-Gg: AYBFou2ZYUl560r3ZRFU8VRKnb9XOL83StNgHxt+bEJ0mItJBDgNV5Z9vOU80mWAEbo
 dmdY3V5y5jig4J/Qz6tZWy5JNBRXPSHjczsGMZLb8ls02q/o1qGPGbKfQrFrnt17kPTjo5tHtG+
 PGQwV58L89CI+mucaDhY6ahhGbtOHVYABdc6klEHND6cEisntD08KrqsCO9HZZyCp0cWt20Rpb0
 xboH2b7kckuzZrt+H/LU+LDYlFEq8ylF0dKCVciHjEU6qWnvj26+9pdKk0xq2yt2Cpk6Ae6Kzgc
 v9NIuJYe2I2wsedadwsBo3Y7tEzDOE91j1MNZX9GH2O5lWilapgDlJdiTl/RHcD3OKSmi34xYrM
 tRXegfztJTbw5iE8ery7UFaikEZqv1y4nbj4t+48kWJ/6qfAS69vcrrjzbsF3HMbsuVtT0TNSO1
 Of2j4yj8EHzyuxIoRJmMlgZgUA/vXfEtPgdWpeKiDZF362DS3kNHwtZR8mUT1wdTvEd77W5x3Es
 Sa2N2KMWGeMgjdqWQthEq9mmphEREyJYZBjHPjLCm7RFRF5kXXLijDgN26cqvVXyqb6cp9P2I4N
 TAA5XydtPASYXWI9ITR9NfwW57d4HLoKITrrTArSLTPOZWBKm+wvhGm5pwm+2oF7353+lI5xlEj
 0
X-Received: by 2002:a05:6820:1515:b0:6f6:3762:5f9b with SMTP id
 006d021491bc7-70940f78b5bmr1907226eaf.67.1792606896935; 
 Wed, 21 Oct 2026 11:21:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d611b9f0sm2617109fac.3.2026.10.21.11.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:21:36 -0700 (PDT)
Date: Wed, 21 Oct 2026 12:21:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: suraj.hanumantkakade@amd.com, u-boot@lists.u-boot-project.org,
 michal.simek@amd.com
Subject: Re: [PATCH RFC] scripts: pass dtc cpp flags via a GCC response file
Message-ID: <20261021182134.GI3275858@bill-the-cat>
References: <20260824044729.708287-1-suraj.hanumantkakade@amd.com>
 <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LjUx4i985w36cIZt"
Content-Disposition: inline
In-Reply-To: <CAFLszTiJnwq2M+LxQ-Mp3-2hwQQ1xegni7fydb2rdVHVxas11g@mail.gmail.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--LjUx4i985w36cIZt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 12:43:16PM +0000, Simon Glass wrote:
> Hi Suraj,
>=20
> On 2026-08-24T04:47:18, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:

Simon, please fix your tooling so you stop replying to very old patches.
This is on version 3, which was posted less than a week ago.

--=20
Tom

--LjUx4i985w36cIZt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatkCqgAKCRAr4qD1Cr/k
ClZCAP4yK5/uF2CBFNTkXII0FH1s7rttEuK6gLdb4ywWyE928AD/Uf0Js8uUu7bY
1j4uxFWuDKCjAQNqK7VUhclPVm3I6wg=
=bLM5
-----END PGP SIGNATURE-----

--LjUx4i985w36cIZt--
