Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5FC5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 20:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E142812E6;
	Fri, 21 Aug 2026 20:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HujAo-JH0Rud; Fri, 21 Aug 2026 20:05:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787342714;
	bh=Mwk7+gKdFjeHfT7wZ6zvLXBiJifW6XwOV7U2l3DSmEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifkeG9albkclgFc/d9tlPZRVlEB+3Gs52Gg4BiL/E88nU/CFxDO9if7ihr2Ys7T+6
	 /nSxBZFXFelDPkTiG2ux3o0/aOBemPCMQgA+WfkenZIKmSs8+zB0/KoB/LhpHVJ2gd
	 3oirotICS9CJSoucWtxjzR8mtNi3C0tbzXHsar/2WOIssG+YBQxwfgHmFEzM3xhyuZ
	 8hkWmQKinJl22yscVZ2bqpUzRap0clJL4pxkc51Eb1pDBC69Y4/kZk1aZG/cRSlV2l
	 RwPxlca0TO84ID/ic2KqbBIpvrdsZ937THQBHY/6YUkZ4uDfxaR98qR92BZqsQcsBo
	 RzsEIS+NR3CJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 98FC4812B5;
	Fri, 21 Aug 2026 20:05:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B1574B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20CD6812B5
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9ycecofu6TDA for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 20:05:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YxstCw91
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56A31812A1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 20:05:11 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so1786191a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 13:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787342710; x=1787947510;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mwk7+gKdFjeHfT7wZ6zvLXBiJifW6XwOV7U2l3DSmEs=;
 b=YxstCw91oRux5VLl5PL0a70C9p0UNZM49hh/bvwFYz86DFrE5NX4SUfXD9JjcGvFIg
 h3gwM6FMOYe9ZmIs8Q5NJktsBmBKtwbHH99dIZuMZ59bLwZDO85Uy8biPteNJknXiS9s
 ZdGdJVL57Cur7mQzroFCJyhqPJ5Q4dKEVUGhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787342710; x=1787947510;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mwk7+gKdFjeHfT7wZ6zvLXBiJifW6XwOV7U2l3DSmEs=;
 b=Qlsb1dlZYaBr/4sMzqWdlD94sr8eTeW/yjP9gMLQ4dmIlYwxtoWNAcRx+8p0T7+xZF
 /o7a7JkwFB0NW4Mq9FlGvUHPDhYcefO4AIOrrOqxkzOyz6RSX0ePNrW3tDw+E0OzVF+Y
 lpRZ6Yi8fRWfJzwHoJmZFXliCztZfig8bcVxJoaVoUZXgsdvwBPt7HiTXS3rTb5CyT8J
 nPH0KaiaM3Ja9+rZ7QOtaIJVI6lS32fPLe8k32mxPeC3RyBQQJ/vPTu3JoihhhNMrvMg
 GB4YWGAsnuga9YffgLgkrI52wLohBWBvzeGpvsslMM8NyBHR1vUIhAaFNN3/DyHckt2/
 8mLg==
X-Gm-Message-State: AOJu0YzX9CUnASrZ6dpZrPLP29x1utL5zMtXfVawfP9XWM5rrBX+7R7d
 bQV1vh+DR3lZa9uQuL/RDLOSHcbd0SoE9PDTfLHsOlUsTnBVMl/F+CpYYyRAFHzbD9I=
X-Gm-Gg: AR+sD13wi1iJNQA0q9vWSv6k2egOt+cXr/zPul12Eg5Kgl69tWBZj7SNvYe6BUkLaEb
 Qg9jeP0eJNNibneQpc1pzPWFDKGhwhvuVk27UoR/yyYJLmUqqPN7+Zy+cUgTzG0Dj9KDE5WaiYT
 e2Rqus1FMBiRBilBAn6+dBgE7Wb52JXFG+pu+0SDi7zcBa5W/vkAXz8xKKjhQID/W8H+9e9h5oL
 SObLeoHfoiJZA2XrILYhqO0fIv1n3ztm+BHFj2T+MqxneACugbWVA0hjIVf5zcsCsRK8O2MbAVn
 WiVvlxJPPc5ZvJJRUW47G28qFK/16oQrYWOR0Livy24DEHM/wYdRe6wZx8KAtVkq9K6Hc26FKmI
 MGH/E5xXkq/TqFyCrhqfzIx1mKdWpGLLMJedJWgasfwd7y0H1tXecmYEPFS5pJGd/EPNDW0qm7N
 6OlyGa450SR6XlV4mZW15fF7H3tEpwzl10Xfh/n6UZCHSfM/AYkEMTLg7jz2QpISEgG742S++9G
 bBeSrTYcu+Em187g6ynPx0VS6LBj+wPy9ClD10iuVTerJ24KdcWuRde8v9VBtuKA/Tb2axMw9zD
 xqi6VLYjkg==
X-Received: by 2002:a05:6830:67d5:b0:7d7:d524:bc88 with SMTP id
 46e09a7af769-7f46195a122mr10674413a34.10.1787342710564; 
 Fri, 21 Aug 2026 13:05:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f46e2722besm1366334a34.17.2026.08.21.13.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:05:09 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:05:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/2] MAINTAINERS: Cleanup non existing files
Message-ID: <20260821200507.GA3894128@bill-the-cat>
References: <cover.1786605072.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mPBG9JdEynw6MRpD"
Content-Disposition: inline
In-Reply-To: <cover.1786605072.git.michal.simek@amd.com>
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


--mPBG9JdEynw6MRpD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 09:11:15AM +0200, Michal Simek wrote:

> Hi,
>=20
> I found in my Microblaze fragment that cmd_mfsl.c doesn't exist but still
> it is recorded. That's why I wanted to check all entries and found that
> there are also other files which doesn't exist.
>=20
> Tom: maybe good to run it in a CI to make sure that we don't get out of
> sync.

Sounds like a good idea. I see between your posting and today another
bad entry has been added, I'll go take care of it.

--=20
Tom

--mPBG9JdEynw6MRpD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoivcAAKCRAr4qD1Cr/k
Cmt0AQD9uT4FZpfHL3/pi9RJ58Z4RHr/HNZUm0GHHOG/NscdUAD+PENWbyKjC4g2
NbAOLrLeN+U028Z2UKbksU5/iV79fQM=
=LOgA
-----END PGP SIGNATURE-----

--mPBG9JdEynw6MRpD--
