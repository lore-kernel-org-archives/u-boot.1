Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EFBC531F8
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 16:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26F3540A8E;
	Thu, 23 Jul 2026 16:46:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HfZvH81hK0Y4; Thu, 23 Jul 2026 16:46:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DCBE40A87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784825201;
	bh=ezvpw6fR33Plnz1d213Kwa4T6n3dB5WzMqDieg96tnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I/Y+sqDIarkXhfbx6Z+uYz6uhkHSzr1m2UwecNtFt5mwYoIBKE5tVVBxGLl6RzcWI
	 rKotRQexaKVh4HYBnL728PU9R34wjxIat25l8MGVKrr9ki6bSBeLmrcX8WPsJXoCuy
	 OZuB9/VfuO22xErfU1XR0X6nrdFxfyYiKODGoRCGF5jCw2WEOAGX8JgxMw4wS4ajjx
	 VmfmGN/Jkf6zKlRwH8MYDHKoTQ7SKC1ju4Egk8wz2RaNVCePt5VZoblyDNozdY2z2f
	 FAQ/z0E5Z4UL5M7grQS5lNvEfXa/BZYDQEUK7jd2syS5QKfTrfqx58Sa/rO6wzFyZy
	 rCKhfmZTRjOmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DCBE40A87;
	Thu, 23 Jul 2026 16:46:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60F1336E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 52FE240A87
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:46:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FrCoUijFeFC for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 16:46:39 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1E1CC40A7B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E1CC40A7B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E1CC40A7B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 16:46:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD020800AE; Thu, 23 Jul 2026 18:46:36 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F6C80287
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 18:46:32 +0200 (CEST)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so545444a34.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 09:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784825190; x=1785429990;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ezvpw6fR33Plnz1d213Kwa4T6n3dB5WzMqDieg96tnA=;
 b=Z4Cdc2TZBdCtrDpf6bsTEeo5MHqvVPsNiIK/vWquESXP+P/wAKmI21DdGJ+7ywOvq1
 +BTYngNY4GovFGY7DZzzGYKP92ESNhMSlcZv1ZGJMIUDcA+tcxVnFDTesGhwiCenHAgX
 tZVILm8Snxx2kKPkY2J8sT0AsOzdM+2zLHlFKHYPX0NwCfKUApnZyLQO+B5tcUdfSDzY
 GQanwezccX/bKxgCueynMVeUGWSMs+8mgT8vU7tMtO1o2HF+QCsB5qt1QGvkRDnE6ECn
 Oly4cU9/M2Im7qBYmaCBHym6UZchY51uTJbUMMWeBZOMRyKJuy4vI/nO/Rq0+WAIkNV6
 YTug==
X-Gm-Message-State: AOJu0YzfShtVR7geghLwG4rONSbI/EPrrkKt4YYH2ybtYMBguyTJ3cRD
 Aw/GrEgjBzGMWF62Tnl8TMtwgJM22dreLlcJxUeH5vB/kkHOQ3BPTBlJdMOjcFZh0s4=
X-Gm-Gg: AR+sD13AN77v5v+HfOdSK8ninmt8bBDAHflPTBGvH6sZR9BHQCjfC3FFMwI/GTmWjBI
 DxHBlBNqT9CdRB0ppTH94HMnOeN/c+QHjh0Et5Mu8MI4D0vvMzLAIaJZzpUnQpplB+VJyVt/CRU
 hCUvuBidQraOO7ANJgtiYzCfOGCuQhdZjLLA1CQbYrnMV6gADQfc8g6Bh8yvS8S+mvPS0Pfrjh0
 1k+B67ppgJGzx/SlwYwkdipQ7eZ7mgYRMuTRkCjabDAxAq9WOTs9RTNSg/snRZNkxfQ0mE81RJ6
 b5vKYhv3HyGfXUAiwsWxlOmrciilrEEX9c7fDtU4M6I0omId5bR0od+4hNxSEav9egME4kZa+NW
 soGa/z4JVCfF1pwZcHZvagsWtA7ZLlzgJjCTFhUXZ0SgNFdmPmuOU5F36RkG+BedzkOjCR5VFak
 o0CL7+MFK5Aku5c6M2y3LZktmjFVjM6y4cwi3poZrjdaFIV7VztkeC6i8lEpWh3IARP3fyzlFea
 AjIS4poRJilzbEOqPnllTqbGTM=
X-Received: by 2002:a05:6830:6a96:b0:7e9:e860:6e7 with SMTP id
 46e09a7af769-7ee4427cb22mr2003973a34.30.1784825190216; 
 Thu, 23 Jul 2026 09:46:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ee29a8d094sm3978872a34.0.2026.07.23.09.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:46:29 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:46:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: u-boot@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 u-boot-custodians@lists.denx.de
Subject: Re: [ANN] Updating branching scheme to use "main"
Message-ID: <20260723164627.GC749385@bill-the-cat>
References: <20260708161945.GU749385@bill-the-cat>
 <6Gj1Y6OOdIdgCJf5wjWfs05a4oMBaE4SbAq1kA4kDy9JfVvj0hy8nMNW8pmrEqonR_dM4pL5L1HaSINcbciAWA==@protonmail.internalid>
 <20260719182219.GX749385@bill-the-cat>
 <87qzkuqfvr.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sHmQibJ/W5bKMB0y"
Content-Disposition: inline
In-Reply-To: <87qzkuqfvr.fsf@rasmusvillemoes.dk>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784825190; x=1785429990; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ezvpw6fR33Plnz1d213Kwa4T6n3dB5WzMqDieg96tnA=;
 b=QCxlFWahSMQd6fr9L+O0m65mwDTCs/0KXpOAjg0tjpiySdXW1yNhUPajcNYHRrZlhT
 omgOI6qvGHZLbFj6XEsleUcFmO7wrWYxEUblna9HESv65ry75rMiGAuUtiLXEDzveGzF
 4COoQNXXCEa3uBlabfPo2C1x6rrAR6VOLzUNw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=QCxlFWah
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QCxlFWah";
 dkim-atps=neutral
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


--sHmQibJ/W5bKMB0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:17:28AM +0200, Rasmus Villemoes wrote:
> On Sun, Jul 19 2026, "Tom Rini" <trini@konsulko.com> wrote:
>=20
> > On Wed, Jul 08, 2026 at 10:19:45AM -0600, Tom Rini wrote:
> >
> >> Hey all,
> >>=20
> >> As part of migrating from source.denx.de and over to
> >> git.u-boot-project.org, I think it's time to change the branching sche=
me
> >> from master or next to main or next. Since we'll be changing the URLs,=
 I
> >> don't think we need to (and I'm not sure we can automatically) have a
> >> period where both exist. Thanks!
> >
> > This is now in effect. The "main" branch on
> > https://git.u-boot-project.org/u-boot/u-boot is up to date, and the
> > "master" branch (per Marek's suggestion) is on v2026.07. The GitHub,
> > Gitlab.com and also source.denx.de repositories match this.
>=20
> Tip: If, like me, you are heavily relying on tab-completion, you will
> now experience that
>=20
>   git log up<TAB>m<TAB>
>=20
> no longer tab-completes to upstream/master, nor, as it now should,
> upstream/main, because both exist, so it only ends up showing
> "upstream/ma".
>=20
> You can easily configure git to ignore the "master" branch on the
> upstream remote. First, delete the current remote-tracking branch:
>=20
>   git branch --remote --delete upstream/master
>=20
> Then in your repository's .git/config, make sure the remote.upstream
> section is something like
>=20
> [remote "upstream"]
> 	url =3D https://git.u-boot-project.org/u-boot/u-boot.git
> 	fetch =3D +refs/heads/*:refs/remotes/upstream/*
> 	fetch =3D ^refs/heads/master
>=20
> i.e. add the negative refspec '^refs/heads/master'. Then "git remote
> update", "git fetch upstream" and similar won't create that
> remote-tracking branch again.
>=20
> (Of course, replace "upstream" by "origin" or whatever your remote name
> is for the upstream repository.)

That's a good tip, thank you! It should probably get put in a doc
somewhere for others to reference. I'll try and remember that as part of
also needing to likely update some other docs.

--=20
Tom

--sHmQibJ/W5bKMB0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamJFXwAKCRAr4qD1Cr/k
ChDOAP9q6H8UvGHWuSwiGUGykQAKT9UNoHv+3T1R1+PhKOCfKQEAnPqP1mAdPvKj
iG739ivAAW10Hy43Vbr1+NAcQjA8fQI=
=9BcD
-----END PGP SIGNATURE-----

--sHmQibJ/W5bKMB0y--
