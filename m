Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC2CA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 21:41:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07BDB811F8;
	Wed, 30 Sep 2026 21:41:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2KPykKGCaD4M; Wed, 30 Sep 2026 21:41:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 496E7811E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790804511;
	b=ECvkvSnk7+gJVrt1DVuJnQjesFBsUJ2wRctwxn0MzOUgCOR91hczJqMwyq8cCQ7oFizW
	 S+fQ8CQT+g2+DT9bm192bx5h28a0bFD1YoJKVgiM2RdFgOKm0bYNBCkeEUknVmi5sMcN6
	 0HLdp3ow2FuodLBttBaOer7JyFZDZG8xYaO5SAvagoAOKfrnqYJF2GPJRKLR3/2B8ekJi
	 X0RSXv5ndghMwdjaM38202JtzSOIW8IHZXh5O3UvD0azcqehLRuqbNKSTuMfrNb05uc8O
	 0GQ5tt5KNzQ9RaU9sIRUW4eGvO0NBALmnIdyQOz+gWKOahzqbABIvLyravXRbMMluAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790804511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8KZjej6h/4evqB+uKCcFJb49aAeh4yi28J5RGAV1nPY=;
	b=PnICRsqp3UAwlvU/vjZomeXMl98xLz6gUuksj62OPl35cH/B0XKEGb6hx8qbSeD5pxBn
	 CFyV3vpRI+uomy7qd/qoyd7Q6F1C28RhxNOn7tihlQtw1cmqXpPFp9LAJHft5ZelMI4f3
	 q0v7cwhZj3qTfbqpXMW+cEbctJQHxsZBnU2l1Rl4F6hYJVbKYQU+TmIsh2KRmxWoqTEh7
	 loTOEqPHL72A8J+2xfoJwVCF0s51ylhsJK4ywVVxEQydRnNi5mDc0z7+GVqMiGmzcAjKP
	 Nu6Uk0NvQS7fZrF1ylJTeMYEbLYhuLGfyOMMP1GciKE/43vMIYjepkZck7XJcj+q9+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790804511;
	bh=8KZjej6h/4evqB+uKCcFJb49aAeh4yi28J5RGAV1nPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0mGedlSPK88Mi/5wMPFiYkrLDotf+z2X1FGKp2AXCQf99lzGzwZDINg6gW0PaXHyL
	 FXyvCdpH6l0SlqAwkIDVAz1RhkBGmpucgk2K0cXr/VVHlOmhjrPA858w37S2oWJKcG
	 1OMNSH40RMGd8CdhUGPbYBkqnmsfTCtJEGMA5fP5razzYIxxBYsZoL/bnuDoUBflMh
	 T4x+S8AE0vnFu8ga9alHkTui7W+jZk6QHlCcRAincUBLMhc1qkRct+pb1bZgdIQKBF
	 i6+pQbA7cdaL4dUVAfLLSa5kao5C4YJQIob/lJSCntxeCEULUeyDUm37TNA+ezSsQF
	 C1fpWdjyTyAyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 496E7811E2;
	Wed, 30 Sep 2026 21:41:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA83814C
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 21:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0E6D401ED
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 21:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fjrmVZHw-xUA for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 21:41:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0C10E400D6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790804509;
 b=cQdIcOx/mTlscIy2Y8riXVaPthkXYCJ5unw/e6DhBOAKz7XekBPCi8Bp7CgRhsa7esYB
 Ko9p4EM7WIh+d9WklSxFm2LXUTsiGClHMe3NlDtjPLiyWfvh41lEWKmyXfvhICNC8KXbA
 oQn6/Vx/CQYD6fgzHWxNQ/tCnrRP6Ql4pATsOG+gQwjdvDCl6786qSp2Jp/KqFlM+3z3G
 JsU7myG+oJ8Sl/2Z75V8vQwON1Wopm6YsMGXBytviJb45gOeh2pXlFEQogcY4vbPemHLh
 qj1cGUCGLAzl3wpb+mh8VstnjtkGeQ9YHye1f/rFs+nXHHa1WCGrfLc75SdXWjro+Qw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790804509;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=8KZjej6h/4evqB+uKCcFJb49aAeh4yi28J5RGAV1nPY=;
 b=WckuObleGzkey8Mi6RkbDXtp87m9dDntnuLemdnsYIj0m7if1M5ZIMabBDEXiHaoPMs8
 xXIFU8MPBhY1J/cTI/M49MZ6WfwkKKdRFxvdeLeYsyuvBbSVt+HLPRT5oUVNklg84yjgv
 D+OUSx1cT+oXIXyA3fTmgFg7CRw1N1R4r65hfotKv9kelzzzbLTzZ3Mu6qhMe3qifUOjn
 ZV+jTG02c3kIC09mep/BVd4ZQ5F57PE8ZZcYWty6BKmt8y7QO0Ukaxx89CUEFmOsAcCoW
 TYCcmATCCObjhWvbwbV7cDFHinBjBwstk4WCl3OnRzYOkkK066auPp2EqiL56j0y+xg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I2AskxxK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=I2AskxxK
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0C10E400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 21:41:48 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso3657a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790804507; x=1791409307;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8KZjej6h/4evqB+uKCcFJb49aAeh4yi28J5RGAV1nPY=;
 b=I2AskxxK9bbn7KsCX0AAgbKO4DL3/DkJlcxR7+KRlBw3reUF6wqTUUzTD1whLeo86t
 FHj+hxYBhKgs1Jk7+l1hiWFwaWZuM9xGGjXFTblblKKtnmvxuAZdbxCJi7jFnbj4n1I2
 P1wMteOS8RdKcO+7YIzy6e7rd4QtatIN4UJTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790804507; x=1791409307;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8KZjej6h/4evqB+uKCcFJb49aAeh4yi28J5RGAV1nPY=;
 b=r9Nbj6JoLPY7Egcp3PHITBjV8i6jcCDGVUPscqYh0B+xog7vS6oEpwSQlM2+MEfNuR
 34+Z7u4G1gxyWZp0kSbZIFPKnmxUzZ4OEzQV5PBlpytyY2FjX7IdCN6rcxes4dTLJE1l
 7sfiIGJGZO0D/PoVKts7zHpe3nyh29EDpR1fmv3GUzyYrYq3IfJh3FSdm9w/9PBVy8i3
 tsPUgDIg7Ip+j5RJKBviBcKlV/Za/0CiFqb3ycf97hV3zgcgAX1a2KjTVKc7jjV30QNz
 xy6f9eKNMad/ztOn2up2rLSRQ+qnM8rJG3e6pQKwFaZEVcX6yVgWkLAc0tJ7F8tsmQMo
 5lbA==
X-Gm-Message-State: AFuF++mNZFwwUfWMVj3WX3G7eK09UYjR+9olhE7GhtzNq4F6alwi6fXr
 bohChNkr630FwZO+G5RXpcSmkgPxprbEhOj0Hx06ASvZr3LMC8Vs5Pg+PA6QwKAFoiRGwUZ0Fk9
 KPJHkdAJHvD/xGNA=
X-Gm-Gg: AYBFou2z9UbO/lHoud0X1DM5p0jBjnXqQzwucClebcT3716e+BfR8GK06O/ea9C75do
 pDAh0d/nHb9m8c9LLkPY3hv5dwi1TUt8EuFxu5uxtY4Bm3ikjmkV0F5sn4NrcHwB7g5Nk+gmJFf
 836QmdA4kWKgwGfUj0nyyHxa8dcw+Uwqr3UU4i7nAmrDE7hUy4p7qhkBOxALOnzm+2yZMbkOUr7
 G1o5AY4UWszgb/svAa2kUKBWwQxMCa4ZIl+dQx2rjyv0tsEIjrH84piUmvZ5w1M9jMjWCIPpnb8
 g2fD5gdVm15qopRpbhx6QaaNNcF+0cR2q0ZYMEWa2p4SLWWVSZisZJaPTzUh6y1qsijYFw3742r
 senW0Cl6eK3TlWNDv7JaIa6v4VlIapMLeEeE/JmlFyKzpgmoQrAh+jpllhUMxG0tURcTwOVSaRf
 NlTlATfab2NYCUokIvKoEV/H4HR+xaaC2Sdt3zyA1PPaZogyH8D6rJ+YYQ61loIdhVQaz4AcnNi
 lciVKC56UPnzB/1FDmO+NnLnQJDD9bQMaapwpk1k9YoHWkaZOGcz3274WC5seWAMmLTKqDFzFJZ
 uioI5azwpxuYjf4p6pQ=
X-Received: by 2002:a05:6820:60c:b0:6de:1071:8b1f with SMTP id
 006d021491bc7-6de10719063mr16538eaf.55.1790804507405; 
 Wed, 30 Sep 2026 14:41:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8212aa1b208sm875512a34.14.2026.09.30.14.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 14:41:46 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:41:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] cmd: nand: add .part suffix to dump command and refactor
 parsing
Message-ID: <20260930214144.GA523899@bill-the-cat>
References: <20260914115418.405439-1-qianqiang.liu@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7p9EmDNXW6b6btCF"
Content-Disposition: inline
In-Reply-To: <20260914115418.405439-1-qianqiang.liu@163.com>
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


--7p9EmDNXW6b6btCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 07:54:18PM +0800, Qianqiang Liu wrote:

> Currently, the 'nand dump' command requires a raw hex offset. When
> inspecting partition headers or magic numbers, users must manually
> look up the physical offset via 'mtdparts' first. Furthermore, the
> command's suffix parsing (.oob, .ecc) relies on exhaustive strcmp()
> permutations, which is fragile and scales poorly when adding new flags.
>=20
> This patch introduces the '.part' suffix (e.g., 'nand dump.part <part>'),
> leveraging mtd_arg_off_size() to resolve the partition name to its
> physical offset to dump its first page.
>=20
> Additionally, the suffix parsing is refactored to use strstr(). This
> cleanly eliminates the hardcoded strcmp() combinations and inherently
> supports arbitrary ordering of suffixes (e.g., 'dump.part.oob',
> 'dump.ecc.part').
>=20
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>

Good idea, however, from scripts/checkpatch.pl:
CHECK: Comparison to NULL could be written "strstr"
#180: FILE: cmd/nand.c:708:
+		only_oob =3D (strstr(cmd, ".oob") !=3D NULL);

CHECK: Comparison to NULL could be written "strstr"
#181: FILE: cmd/nand.c:709:
+		ecc =3D (strstr(cmd, ".ecc") !=3D NULL);

CHECK: Comparison to NULL could be written "strstr"
#182: FILE: cmd/nand.c:710:
+		part =3D (strstr(cmd, ".part") !=3D NULL);

total: 0 errors, 0 warnings, 3 checks, 38 lines checked

Please fix, thanks.

--=20
Tom

--7p9EmDNXW6b6btCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCar2CFQAKCRAr4qD1Cr/k
Cj+wAP4g93I4VUWi+RMO2uOzXGx5d94yJc7hiBIlj2fAfnCcFgD+Lig6/wEOm6Qx
6+UrXEntejdiFA3gM/e6wYXCfFKR1AY=
=ISm+
-----END PGP SIGNATURE-----

--7p9EmDNXW6b6btCF--
