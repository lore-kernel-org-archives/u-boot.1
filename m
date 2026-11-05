Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB28606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MMnn0qZ3;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=q5XSB1PI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97F22408D7;
	Thu,  5 Nov 2026 21:23:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIvWjgGwfii8; Thu,  5 Nov 2026 21:23:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F5A240829
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793913832;
	b=gLFbOOgv6fUFPrLPTtoa2qyiL8F7aUBjRiv4UnF3uRh3et40L/JJ5z7lVndDGokK4wDa
	 Yi3k9ztdDhm82h5zRKGQ90G1MkuYrDgW9KwrRFrmz20uaBcYhLNp4e8uIsJa82sSZ7ha0
	 vkqwVgL2tiSYJW7Z90ewxPWgOC/cwgiHo9GBGfU17ddq62y6UgAiWXSqWPgjwE2LkW5tt
	 KeP/RCSPWNmZe8InB6hFFZgrs5yF+yNb4S9/wR9kYX0OxKqgU/T7xRWx69qjgGV9hOShk
	 ZbTE8JMTFyOVZzAXnX+wJJ3hQGFZHoRW3QyDwUPVtDZWIfPD43ti3KiKg0G2kTeCG1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793913832;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TPOfMurcfNhyM1wWa+DiWQ45dLxObusiX+UvQHx1Xpw=;
	b=stq0c/9+20Wgog48GFBKW3Pglu6AMXzOu6pp2+Z/+SfNFip6Ekk3KNaISsRFi2VyLBSE
	 ioNG58zCL2BNeLVWEI9Ea65/oUwB8GI8ZZAnwsCEXkjf91E7bp4R7/M9tHRcxjoeu+JI3
	 3cU0TScMdi5T7cmYWoZ1zVAwHktBE/erShis+OtlGrF16iVJ1gp0rPZBkM6APW5k8te1P
	 Tc+uwSTTG8bmTGp6FLH+GDoT8N7naiqq7UrUVoodKpXmogylhfEqKlDerSp9O2mX2aXp3
	 1FD9gUMKFVPFOKztjnVGT6NmpKqArastmIJ3mMhesS3oFJD7Xim2si/rPlpIxcjtw8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793913832;
	bh=TPOfMurcfNhyM1wWa+DiWQ45dLxObusiX+UvQHx1Xpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MMnn0qZ3G+IHzj/mRmpp9IJKpTOH25j/H9tSmkXmoI2ocwgiyfH0Ax9G0xp5bXl/9
	 PGiaxRVrSVJvESvyTukqcAd+VljXwOQKXAlSyctKAeAbC5K0A0fRuTSb8z478IaUvb
	 QKz9t3CM9/AJBoUoN01hRoUiQF9JtsWHnGjHEHomk298YgyCxihvHho7j5WijR28ED
	 4biNCNOQkeIjMZ84xOi6werxlXVoIygAV1eBwDnrd9Up1UL8+cYAZfbBAPVtL5JMrB
	 5ibKS3GnEn0C5LkdjDca8+3xWPLJqHRyTPP3m/2UjTIQERtRUY0wNGXTu9eMHQKnyi
	 r/QjU9krfLaRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F5A240829;
	Thu,  5 Nov 2026 21:23:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E11CFC6
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 21:23:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F0BB81067
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 21:23:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7rj2Lgd7lkra for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 21:23:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 484CF81064
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=q5XSB1PI
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 484CF81064
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 21:23:49 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-539edfadfa9so1013191b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 13:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793913829; x=1794518629;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TPOfMurcfNhyM1wWa+DiWQ45dLxObusiX+UvQHx1Xpw=;
 b=q5XSB1PI5IeAuLRH4e4iz29JwdJd09jiDVF3+Wj52YzLSIz1fYB0inZ172HiMPlsCQ
 VpMWqMUdvCW+HoQOsW8AUDpSshUFmIlnd7dNI487dAmWymiWU1Ztzuq9wB+BdmBysdf0
 /K00xILhPmLzy1WpcN4ZGoRoAFcEreXmcpLCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793913829; x=1794518629;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TPOfMurcfNhyM1wWa+DiWQ45dLxObusiX+UvQHx1Xpw=;
 b=Uga5pcA6RtA0+aeX6pJoVJSo5SYMtuvKqhmx4P7ee3QGVNqgiijHobAp//Y5Rk197T
 Zh2tcwOMds2X0b9Um67CA0yQo/XkKdjPaYdwDwuvSQpbvtAbEAWRo2Tb/npTcmMJJNg4
 W0yaixAF8nYtfFjXyhOsWr7WXqbekDkDNMuhB+SG5y88BlB9gTPcAm9DQyDm6HdurcLi
 CpVlfyPSXMMHBnSwOLY4R5uBLzJQGcN5oBxuEdWQalIRXir5EYYNwtIllsYo0QuUj3p9
 g4IdAVdftFwdsDbhZXW/LvEdtI0hCKk+tXG8r7nsPr/T6bQIrq04Ax055+7uryWJf4DR
 vGbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5kb21Lr0YXrPvaKNg+NIlOK4LWNzxZqwVfpBmJwY0ite0bD+1rJlnFI3J6EX2WjtdRtRk0rU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/d8VUKCsJyyEpNuvFPe4XmoSgdbaYO6YiHoFkotDRk2DACLlOu
 B5tt7hbOejFqHlz4EjylAZZL7oZp3vBkoY9Gs7Flhcftv5Ntaqb5kFrYl+g8OaK/dvA=
X-Gm-Gg: AYBFou11VWrkbqsrHvjb3RLAWMvhh+Y3JP8oWnH8bJusLnf7i5OOM+uqZeN0KhdLqiy
 xLZ+KWPgHqmWrcyH9735fCoGUTCAnxu3sUmBfTH/dpcyg4lrpBIjLBAX/LMkaM+FHzCCjTqkylJ
 SKtlQLLoLi42ht+PKRjfs021zUSt68+woEoVat3pSqkHS/63Au8WEFMp0MjoeCcR9sMAP2qKGxv
 pnLNdaGQ/JSsNDnaQyf1CjHLMlyitvtuSP8bEgEj5as2xUpkAr0RX6C092AvdKfAaO4XJiAsI2S
 FM/tloA5eDo+uouvwt/8vZi9HCVmofYdL3vpM8D4Bqbr40d/8OigkXjVayCKFBju80vWwmMRXLj
 S56iOcVuVTLr88craglGLX6Bx+58sPH5Uot6uxw3YaQ1TUmU8EuImQzkr5aAoFxcn8JxBmWJokg
 M8P4NcDFyO5aXmgXNNhvtQe0QZUGvz3aGUGL9Y2eHfbEtBKF1SSiSJY72Qq5BuaZB1+Z1cQMPbY
 9abxHI7Q2xflwrb+BDag5Yz53YW42tWC9HLcYhRwZak8fWThUwMNnj1+3Kfwevkthbw7ge2jbhE
 XjRXL0l1agdjsdKWURTSayHGeMtgA9Q4TOkV++csg8AZ2eQgsluGvF8oNy5gVXdShn/RAwVbgK5
 hC+sKB8gzcfWh6+aMakhpsIZnL5GtHObN3/CiuI93o4b9laET6zujiTAqrK9IeEfOpuE9AJIQsS
 xtdvO7ZG97ChJvYt0OI1Cnfr76BJZ8iQ==
X-Received: by 2002:a05:6808:1a03:b0:567:605a:b89b with SMTP id
 5614622812f47-567e14951a4mr286104b6e.64.1793913828848; 
 Thu, 05 Nov 2026 13:23:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9c7bbcesm5080798b6e.1.2026.11.05.13.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 13:23:48 -0800 (PST)
Date: Thu, 5 Nov 2026 15:23:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] remoteproc: Hide REMOTEPROC options in REMOTEPROC
 conditional
Message-ID: <20261105212346.GS1164024@bill-the-cat>
References: <20261026221147.483695-1-marek.vasut+renesas@mailbox.org>
 <20261104142958.GA1112376@bill-the-cat>
 <ca84f075-5f13-4275-98df-5521b14b9c15@mailbox.org>
 <20261105144209.GL1164024@bill-the-cat>
 <CAC928HbGeoLQuHjiDN+qBU7A=wLa=EgM7xQMppv9LvFh5kV_xg@mail.gmail.com>
 <e6f06550-772f-426f-8b43-da13b58b0202@mailbox.org>
 <20261105194153.GP1164024@bill-the-cat>
 <05e08b26-3dcb-4491-bdbb-77c6fcd5e847@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/1CFVHpUldyGpY7B"
Content-Disposition: inline
In-Reply-To: <05e08b26-3dcb-4491-bdbb-77c6fcd5e847@mailbox.org>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--/1CFVHpUldyGpY7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 09:03:55PM +0100, Marek Vasut wrote:
> On 11/5/26 8:41 PM, Tom Rini wrote:
> > On Thu, Nov 05, 2026 at 08:10:26PM +0100, Marek Vasut wrote:
> > > On 11/5/26 7:51 PM, Massimo Pegorer wrote:
> > > > Hi,
> > > >=20
> > > > Il giorno gio 5 nov 2026 alle ore 15:42 Tom Rini <trini@konsulko.co=
m>
> > > > ha scritto:
> > > > >=20
> > > > > On Wed, Nov 04, 2026 at 06:33:21PM +0100, Marek Vasut wrote:
> > > > > > On 11/4/26 3:29 PM, Tom Rini wrote:
> > > > > > > On Mon, Oct 26, 2026 at 11:11:32PM +0100, Marek Vasut wrote:
> > > > > > >=20
> > > > > > > > Add conditional around REMOTEPROC menu entries, turn REMOTE=
PROC into
> > > > > > > > configurable boolean, and update all defconfigs and Kconfig=
s which
> > > > > > > > previously only selected REMOTEPROC driver to also select R=
EMOTEPROC
> > > > > > > > itself.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > > > > > ---
> > > > > > > > Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > > > > > > > Cc: MD Danish Anwar <danishanwar@ti.com>
> > > > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > > > > Cc: u-boot@lists.u-boot-project.org
> > > > > > >=20
> > > > > > > Unfortunately this misses some handful of at least TI K3 plat=
forms. I
> > > > > > > think using qconfig.py to confirm which configs have REMOTEPR=
OC set
> > > > > > > before / after, and that they match would make sorting that p=
art of the
> > > > > > > problem out easier. Do you have time to do that, or should I =
pick it up
> > > > > > > and do a v2? Thanks.
> > > > > > I can respin this, but do you know which platforms got missed ?
> > > > >=20
> > > > > I lost the list, sorry. It was a number of the r5 builds. Perhaps=
 some
> > > > > fragment got missed? But qconfig.py -f REMOTEPROC, with a db buil=
t with
> > > > > and without the patch will quickly show which oens it is.
> > > >=20
> > > > This is the result of comparing the two qoconfig.py outputs:
> > >=20
> > > u-boot$ git log --oneline HEAD~4..
> > > 1e29311663e (HEAD -> master) Revert "remoteproc: Hide REMOTEPROC opti=
ons in
> > > REMOTEPROC conditional"
> > > 97162e533ca remoteproc: Hide REMOTEPROC options in REMOTEPROC conditi=
onal
> > > df3b8e16e6d remoteproc: Make REMOTEPROC_MAX_FW_SIZE depend on REMOTEP=
ROC
> > > d1d45c926a5 (origin/main) Merge branch 'main' of
> > > https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv
> >=20
> > Wait, your new patch didn't just replace the old patch?
> Nope, it is two patches now, simple clean up one, and more extensive chan=
ge
> one.

Alright. I can't reproduce my failure either. That said, should I just
squash these two patches together, along with adding the fix for the
newly added TI rproc option and post v2, or do you want to? Thanks.

--=20
Tom

--/1CFVHpUldyGpY7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauzz3gAKCRAr4qD1Cr/k
CiezAQDAXfR9pKvd55pwPW0UQsGzGQD6X58EXqYN90RxHobnZQD9EI0jJHTXJB1t
15KUwDOegBtfYfOHeTEfbuZhOSALowY=
=ra+O
-----END PGP SIGNATURE-----

--/1CFVHpUldyGpY7B--
