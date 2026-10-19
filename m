Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4268606A319
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=baTc8Lm7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=p5sMZTJz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B87760726;
	Mon, 19 Oct 2026 18:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vbam3mHSiTvb; Mon, 19 Oct 2026 18:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CBB1C60730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792434053;
	b=qJJe7nobuavu272YGOxc+LYcFHzHopBDJXB2CK5ADz5lsdGZsLJ+NGKm+2w7rjCFBmy9
	 1K3WxotRclGfpNwbulaOreFJiEnz2Op2+RQPiWgUBnnmv0pwcaPDhQ836gtmwMxJmGRY5
	 8eBxxB+FTxJjzcxahUT2WSjjh5NETbrnyOOVovNuUlGzZ/vW+h4+XwlbxEDqsc8064EfD
	 E8n/7Bte/TAoxdEbmIJv/r6j0dxOrxsR23HFdD3SEBqBOMsTaWc5XJAJxcV5/iCoA424/
	 KLCD6BsOlgW0tVnYWHJ+a3k1PayFfYZx9l5UQLMwD9x8YIZ2x+hhLCKzkZjyIA37hCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792434053;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MWtIAM+CGsQtufqHSWtSTvL/tDhbLofYSmwBX6CDOkc=;
	b=bbmmSgi2kfOQhCs3ecagG0wNvB70qmr+7mDlQQgE5KC0hQWa48c377U2ZYq9V1wCKic1
	 fjvgE8wiWl+cyFKymzJd8zrM5MMYyQgo9qQTjOYtZvS8RcrDUO5k3DRqu5H1VhtXKeNet
	 FqcVwRIi7VLkQn9CIK06omS9Ld+aZaWdRs5DK8ellAyTiTjW+Hp/HbvRElFKSxhbNrTwx
	 +C0tpkfvIOSuCgI+m/RPX6WXFupRpgP3LEUBlYtsl0KGWppfWVExdpjmSnfdtqLLzZxnb
	 goDBhzbhzKrBroFWUlkKpewyfFvemQpwLYqXhhREQ+2MJNHbz903V+z8lQTJz/qPRRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792434052;
	bh=MWtIAM+CGsQtufqHSWtSTvL/tDhbLofYSmwBX6CDOkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=baTc8Lm7VJWt6iL6xAYg5CQoG593/c0E0B+SoabvODH7hOjk/7jKq5rou0obImpfg
	 E9oLM1wnefZFDNmP0AP097NxzedDulTOveBmNUSeMI/zo+/z3mc/GAL2khq2FmZD4j
	 GgZYtvWJ4NXpHNZbFPjIOcFyzMsue0ERza0q/mykylvhQP5BZ4Mz+jrNVC6UFyHJCJ
	 VXNWikL5X1qwc0i/4hfYBMftGSHpyDdGo2xKYhN8nbyPbGFpYMVvX6IXCwZrGWmz4l
	 T/Kwif7R+S2yyqVzcOSA+L5OCAVdj/G3t3eosOPGNolXjdJYhWqIFjPDoggh3+UVef
	 tLiYZXuUy0jqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBB1C60730;
	Mon, 19 Oct 2026 18:20:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ABDF279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0BC73400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:20:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YhQnrPzbqvi for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 18:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1C2D44008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792434050;
 b=hB6MxlGVU+FLmKprOUWSNb82H6j5CNaB2sSRC7jeH3AUDfR3z4flnmiejX6SpICSvlJw
 EN05a+RK9o09ZMkCxo8PIsJQpn9ISzcMx1bsy2Q8D99FZCXo0kdJyTWuGv38SDq3YEt5q
 NRtdbsP0w+48Vs8DXOyIV3irAbJbT09xHpoz24IjmWXun7KBjUyiy7TajaDRKzPE5zqpM
 ZejuCOyeaD3KffWodRoShkat32zqpob+xH7Z6QLojxffpUiCBjBHWuVBQSxQBXaZ/RYPA
 NCY3x05gl22Ngd6+xhlhq7NOPu4KXLYhb1ZQcsbmdqAwY+qy/nwksFdaHEfgp5E0KAg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792434050;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=MWtIAM+CGsQtufqHSWtSTvL/tDhbLofYSmwBX6CDOkc=;
 b=L97YTA9+KoLOge1KYhNKkj0Qjcj6lKJu7qq+ewnZnnuOIhsBq1o9g1sAkzfV0AvVOu5I
 dws20h4NZ02vw0YFHpcpa756h3jwfa7uD6B3FyFHIsZv+b3CyRi71ldVeWh+gnNRiyJya
 QyuYi63Igru3QmCHkGFtSff45qYEdsRvWgxntL4CJiYNg/fJWCCOJfHgq3Y8/hjoCge9H
 vDXEmkEEPE5G15Q9+/PoRZ/Z7O3RfvaceQl5iOkXrjCCKzxcZiEzLMVR8/xHsVdw1e//i
 sS4bIhS/tnYN6Z2CoM6bP1EzEVEfUanIuwZquziv+8dkVC9gb+LPV4jTjmILeqkAKuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=p5sMZTJz; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=p5sMZTJz
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C2D44008C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:20:49 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-475920b9ca2so658491fac.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792434049; x=1793038849;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MWtIAM+CGsQtufqHSWtSTvL/tDhbLofYSmwBX6CDOkc=;
 b=p5sMZTJz2tzltutAUgu0NRfsACywNhQwtrTd7aqt3X9BksY8Pes/uHNCU7wSCVYiEs
 DN9bzqn0CyhjZUHjKurO0nXui/vAakkgQZ/QjICDG1L+51T45RYPH2zEce0Zk7H7rC23
 0KOhkHItchhPFzpFvcz0LcLWA5UjLGjDfTKKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434049; x=1793038849;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MWtIAM+CGsQtufqHSWtSTvL/tDhbLofYSmwBX6CDOkc=;
 b=sA0svGEGXkLZinL+ry/8SUYZh5fdQvgoFt+wzbjEjJddD/ZvfEn8mI4PUiCqefVbd7
 XAQ3Qsh+DBeQouVb7ToC/fZjaRJAL4lpmwj6mjOo6Fl6V8W3wUR13xLjo5uBErnTGhhv
 8Q5dxldLr7DC+N7kvj257UebmbYJkVY4R4x5NM/PrQCF5mUJ3cu8Xw4eYDmUxLkNS51z
 e3PS6g2rz2ddviDuvUskB04AQ7wQWnNHyciar/HTVnH7977wYUdQGoqkSvjfifAS/gin
 BhyQNfYDX69PHlMlns4FQivg8uyrIosCwbiIG3Oieazr7itRNwuvbCgLeNLX86tFelWw
 O7PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzla+c5+nuQbE2VD83gZRPZGYFzs3VY6O42lbcqkIFMlWZVgM8Mimd8l5PAnXnTwDRBZRGMNco=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ74c5Q0+V6DuGtU0/ySsVrkdhcUl6rJEWfqcfCPVeP87L3oULh
 BNaxq4lCQ7Lzkj8+A2rXVBIMfkpztM6dfDgYPn7HK5chTz0dRmMJiN9zEjPr9O4saqY=
X-Gm-Gg: AYBFou1l3MRXcOlecinY8k/lImyV5CZhxJ71L+j5c5J0q3sBca7sMC5/QS+0GvH6zNu
 EAs21s3qe0WQMtq/FWvdwaXaKSq9yoWWRqjsyHVLNp80imGL7lEctObSXlQUtynIPQZlxTXlS2D
 38QM2y8hVbAIGO5BbAa6jEyeuzFwCBMjdJSbJPt+wAtt6B6yX3ktm4WxHGTm8bacX/V5rKyWiBU
 PPUaLoAkhfC7P3n1xbvt1EMxwLoYmuEuh3RleKbMdJoyOYA2efSkHd6J+vchrjoCRnsomw7kAlo
 lH9pSDxpc8hl3KgOZR6Inlpvz0CsCTDXoXR3Gznpj4NcsoyjAKFlU15LM+BDK04eM4Sr9k5F47e
 ZvVfsko4cnGpk64330kdKAm0VSbdww2zCVPLVcQ6tiMjTklMsqnojdLCKqA+HruOkqZzYZOOqzO
 XYyVbsoyaJIb0YsgEbe+t+iOSJcA8G0umfBbPngOw0xfrkcqDvzQEOn2y/EFQozywPaWSfIlcc8
 GJpFjmhzLTSQE+lrI1tStzDMlTi5KuhK1rGWI41cxjhS02AmItFTzbANqhARvOWfX20VpWmhAYv
 4O/rOr8HByJz3XXCvgc=
X-Received: by 2002:a05:6808:3a0e:b0:4e0:1d24:cec0 with SMTP id
 5614622812f47-53cc25c19b5mr6332449b6e.8.1792434048759; 
 Mon, 19 Oct 2026 11:20:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-54b5b40a06fsm927555b6e.10.2026.10.19.11.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:48 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:20:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 Alexey Charkov <alchark@flipper.net>, Anton Ivanov <anton@binarly.io>,
 Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v10 0/7] Improve FIT signature handling
Message-ID: <20261019182045.GE720525@bill-the-cat>
References: <20260923114940.349985-1-ludwig.nussel@siemens.com>
 <CAFLszTiM+-BsYPjaw7aD7xfzU+3kK-BO9mkYKrtXpjPOv4SjcA@mail.gmail.com>
 <11fb0589-8ef2-4870-8490-077389ce9e53@siemens.com>
 <20261012144457.GB3722450@bill-the-cat>
 <44849c78-b187-4a20-bf2c-0eebaf8a2e9b@siemens.com>
 <20261013150127.GA4042005@bill-the-cat>
 <6f29a66d-1425-4229-a762-2dbc02fd0dd1@siemens.com>
 <20261015152041.GC259661@bill-the-cat>
 <54fc1de2-ac78-4ab6-86ab-13779fd35286@siemens.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dEkOBjak39XPH/7c"
Content-Disposition: inline
In-Reply-To: <54fc1de2-ac78-4ab6-86ab-13779fd35286@siemens.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--dEkOBjak39XPH/7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 02:02:25PM +0200, Ludwig Nussel wrote:
> On 10/15/26 17:20, Tom Rini wrote:
> > On Thu, Oct 15, 2026 at 03:55:03PM +0200, Ludwig Nussel wrote:
> > > On 10/13/26 17:01, Tom Rini wrote:
> > > > On Tue, Oct 13, 2026 at 08:47:48AM +0200, Ludwig Nussel wrote:
> > > > > On 10/12/26 16:44, Tom Rini wrote:
> > > > > > On Mon, Oct 12, 2026 at 02:26:55PM +0200, Ludwig Nussel wrote:
> > > > > > > [...]
> > > > > > >=20
> > > > > > > When I developed the patch OF_OMIT_DTB was "default". 68e6595=
3400 changed it
> > > > > > > to "def_bool". Would something like this make sense as a fix?
> > > > > > >=20
> > > > > > > --- a/dts/Kconfig
> > > > > > > +++ b/dts/Kconfig
> > > > > > > @@ -213,7 +213,8 @@ config OF_HAS_PRIOR_STAGE
> > > > > > >              disabled in the board's defconfig file.
> > > > > > >=20
> > > > > > >     config OF_OMIT_DTB
> > > > > > > -       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN
> > > > > > > +       def_bool y if OF_HAS_PRIOR_STAGE && !BINMAN && !ARCH_=
QEMU
> > > > > > > +       def_bool n if ARCH_QEMU
> > > > > > >            help
> > > > > > >              As a special case, avoid writing a device tree f=
ile u-boot.dtb
> > > > > > > when
> > > > > > >              building. Also don't include that file in u-boot=
=2Ebin
> > > > > >=20
> > > > > > No, because commit 68e65953400 was fixing how the symbol had be=
en
> > > > > > misused over time. I need to understand a bit better about what=
 you're
> > > > > > doing here next, so we can see the path forward. In commit 99df=
7f471551
> > > > > > ("arm: Drop unused dts files") we dropped the empty dts file th=
at was
> > > > > > being used to generate the dtb OF_OMIT_DTB required.
> > > > >=20
> > > > > Qemu provides it's own dt at a known address. Normally u-boot wou=
ld just use
> > > > > that. The purpose of the series is to make u-boot check fit config
> > > > > signatures though. In order to check signatures, u-boot needs the=
 trusted
> > > > > public keys in the dt. So in this scenario we need to merge u-boo=
t's dt with
> > > > > qemu's.
> > > > >=20
> > > > > Maybe a better fix would be to remove OF_HAS_PRIOR_STAGE from ARC=
H_QEMU?
> > > > > Looks like this atm:
> > > > >=20
> > > > > config ARCH_QEMU:
> > > > >          ...
> > > > >          imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> > > >=20
> > > > But then we would need to provide the whole device tree, yes? I thi=
nk
> > > > this ends up being a tricky case because we're on QEMU for this. We=
're
> > >=20
> > > I am not deep enough into the topic oversee all consequences. Somethi=
ng like
> > > this maybe?
> > >=20
> > >       -  imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
> > >=20
> > >       +  imply OF_BOARD if !TARGET_QEMU_ARM_SBSA
> > >=20
> > > How does one get u-boot signkeys to work on real hardware that provid=
es a
> > > device tree? Or is this just not a thing?
> >=20
> > It would either be in the device tree we're passed (OF_HAS_PRIOR_STAGE)
> > or bundled. QEMU is in the funny spot where it comes from the prior
> > stage.
> >=20
> > So that I'm clearer on the use case, is this about testing, or about
> > using QEMU with U-Boot in some other case?
>=20
> I'm using qemu with u-boot for development of course but the main use case
> is testing the entire OS in pipelines. The less software layers need an
> actual hardware the better after all.

Right, OK. And it's something where QEMU is good-enough to the real
hardware flow that you get useful information, very neat. I think with
what I suggested in the other email just now, there should be a path
forward for what you want to be able to test.

--=20
Tom

--dEkOBjak39XPH/7c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatZffQAKCRAr4qD1Cr/k
CjmdAQDWBjtGPW1kvSbCw0aaKkSSQjpZia42GUWKIZSXspQ77QD9GW5QVduImutW
0BGef2QZZNoeV/hFggrA1SdIQUSwYA4=
=g7B6
-----END PGP SIGNATURE-----

--dEkOBjak39XPH/7c--
