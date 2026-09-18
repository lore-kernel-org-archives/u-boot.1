Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D3CC982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 23:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7684340CFD;
	Fri, 18 Sep 2026 23:11:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i_ohIWrJ0p7h; Fri, 18 Sep 2026 23:11:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A89D840CFE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789773061;
	b=mo/nBGeeHnr/qzWYEBA8EBUsCTmySmeEYb3b3Huca/JxJQ46NLUnTeyF/yhIxE4dk+DB
	 ovBRfezCLFd6bTURBurQqAwXzRlri5nwzB/yTCOmHEeR/0UtlegRohZcWF9p5F5ifx42W
	 yrJ0dyN7tJHI2oigOYtEkb+Spj/ZhTofIYGKcZNmKkGsDgcwEabPk9rIaME1HYta0+qLu
	 Ex05d+zV+dR7s0csjeGxXvmweIpx99GUet0/svR4Rb9xo3emgdiCA7s91a7bPUU1El2Wc
	 fdKEfOVax2xxD4ANFb8PM4mzSw7dJOuHeWpaVSppJlABlV6Fe3f9xZeAI0pUNp/ZKJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789773061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=37pTGA974k77NSWVx4ZeHjhuy5KE21KK9MZIUJWL+xA=;
	b=RlL30FyoQG8J63+EyIAmu6JsbKzKSZ5BDJ8VKcij/hAsjB8It1jgiYoL6XjYPLn413f4
	 pYxHn+hq0f26ZezLOIdZACTe0R0C3gkP6FOh9Q4xb7aCh38Xw3kkXGMs1KpG871s55ERc
	 uq2C7gvmJZ6X6I8RSgOCPLgNRYPCJzkBtW+H21I4fUleCUbMEbNWwtzW+RURTpwbe9u7u
	 7Zup8cZWOc2+g75rjDyVEeByF5Nh/kvSXJkkGJVmKie7DS/g7EsP4z9Q2n0FBnyX5JqkJ
	 AOnoocOEY9qlFZeTkRKq6WfnAFPBoTjlpCbi9l0WNWe+sfmA1sreckn4qLEvCjikKCA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789773061;
	bh=37pTGA974k77NSWVx4ZeHjhuy5KE21KK9MZIUJWL+xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ljhcx/lRaTl2Igqk5q9GhZOEjrKhWu5sL7NNUU9MfQPu3cszYe5PE0ZyE9B92x+Qg
	 jOx+Skoe/Z4RDU38OGECHAuHIVbmjEG/3XT9mgIA9nho14NeWIBkdhEoD5D33B5N8u
	 H/496vHRBCT94vF6UInLKoIQkRPtaJFJjJU76tbD1IBGzgfhvIuCYWTtSxh9c0pJE6
	 /0uxiBn7cJ5HtfQBenxzm7Xc1TeWwoOVNzbpTzhcA/02pdJHcfiwTG6c6mMeNAJdA1
	 unmBZ5J3y5PKcIVwI+cb480yIildu4V96T+f27+D9iq48F6SshtYCYGj2t+paVm9I/
	 nJBn/x6oE3jTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A89D840CFE;
	Fri, 18 Sep 2026 23:11:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D005D29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 23:11:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B63F7400AB
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 23:11:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uTdJ-70O1NK6 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 23:11:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 04FA640022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789773060;
 b=jvWaBEjZ8JYEW966Tvv4yV28sZngBbqRbRt4/nPHriTS0TcLx7MzmfWN/airFcy2xXro
 CQSQZKb14ItumAiEyXMFKURSG+8A9GF+gBdZegDXZyIY0JQdCfIAX/CAEJLviutTJSEqW
 nODLud/FQvJsnrTHcP8nmM72yxfU2ozjwFkXEiGcLsXAq0uy3W9QKOcVJSAuQHOjryZGH
 7UKAvNwXtv9rqqad/rd/NqLkE4t21shy80SPdSkd9M62xo5m8kWLx9guNBR/jS39ogMKy
 TjhqwyenEIPBsJN8vecKiMdHuiBeBjbOyf+EQHoFZ4DPVnSvhZq9RiltEkY2S4ff5xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789773060;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=37pTGA974k77NSWVx4ZeHjhuy5KE21KK9MZIUJWL+xA=;
 b=WEnmvRmDSz9/KNvB01Bi+e3ylQtjcTi+TwKedn5P4qggBXgGTgtmucdFducNr6QOY7An
 lvo8WAi8dNHi9HbPOzOGr0hP/ZBQgvib5aeil7ZL9W6DtMeyfAk+Bwx1a6mDhzPSfJrmg
 RJrVNOnHh5fGNWy039dRcb6N8Bs3g/if4e+qc5d+R/UEPuvGjSiXWahD3/Rh+CqZtps5E
 1innVlNfKF7bBkvwzeWyQtLZ8mYmG9IpQM3idpKTlhIeZDEw4z+z+S0L0oakvlsrq2Q98
 yTfLI1WjTFF/CpQV+/ZZuekBzLbm8npZ5DtkQ19dX9b0wOWIAPb+ftDmIbzkg8C5t1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hlJNio1Z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::f;
 helo=mail-oi2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hlJNio1Z
Received: from mail-oi2-x0f.google.com (mail-oi2-x0f.google.com
 [IPv6:2607:f8b0:4864:32::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04FA640022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 23:10:58 +0000 (UTC)
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d37f93so920705a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789773057; x=1790377857;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=37pTGA974k77NSWVx4ZeHjhuy5KE21KK9MZIUJWL+xA=;
 b=hlJNio1Z1edwHR6HmfGsgzy1MGyZLNosG973paegtAScD/KLzlHOOp0efjQaJCvo9P
 /zVO+mPvl6vkxAjgxGuCa5f9BZa/wl3VtkCgzsHYYveQpD0qb5tRG8f+xoTndI2GQDrW
 zxwSaBL/nCQOdWZcer2420UdvEJWR94cj8kPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789773057; x=1790377857;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=37pTGA974k77NSWVx4ZeHjhuy5KE21KK9MZIUJWL+xA=;
 b=aCLqF9UokGhW9cP7CSHmyAfCXiGxrSWzCMuirEA0237bB58W+5sQddqybsBdW8cyOJ
 DisvBe9aUnaKgXmxx2oeWs7ruJhtLmpiM2fh++iqODOFj4HqyzT/TBPj+3r/WkseujcG
 bHa3kbXzNs3RFXIW5F/JeYq/OnYo3PV1NyxSkBUZZ+s8EEUOQU7auEP+PQWThJVcCK03
 Q7D6oRUTMo9UFrlmw4UCylcOtRkoriRpctRiZHC3tsE9FhG2tzmAc0lzmVr0U+25LrYh
 uv111IsG7ZTV6Q1qI0b3xecUMTP7hXEW1sntJmX4pawfc1K1gyu8Hf2zvIdsZy9dp5na
 12rQ==
X-Gm-Message-State: AFuF++lsYRHPXpjTPkYFT4/9hHOH0gh2BPMT0/9XJxpBnpWgkVvl2PoD
 kgg1vjbUGN/XgJ03+f8LRUmADhoaLsh/yS3VefT5XO9nbN7kMv+EeL3WCzM0A8PEgqY=
X-Gm-Gg: AYBFou2eB9biyB3aZc+XkKKAAp7j6t5U3pGbyVY+SCZGBzjj617RpapuryuqHDw9ZPP
 qkmKh2qXaVUiY+gogtg3+vYu6DVMqoMTDVxwTXGRG3w8CZZljkWuwTfJvqPXTJMhTMdIf5VYbJc
 tdA0ue1peG6sOqoXNr2fHFf17FhhOyOK3TJgGbTQ6moDXI2YA6Lwn1CeCLS33FawHVb/un3ssdO
 XhscrDW+h/fCO3WsZ2A9Io+7AJoW3CIuLJOrZEvGzAt/GnexSbpvL5V/gt+32DjapzidFTlLkXI
 nwdfZhEdf1RFbZDt55ko9wGCRxHe/v7hUA7VFpPy9Cz4F+lVj7wMSW8awsptHYUG3Uh1IMaYUZj
 3P438TSexAwApQpm3Bzh0+Z7Fvdb9n+IfFJ3SZgjhlEPcVBkBTuw8nh2ZXpmnelbf9UBAETJKtg
 tuUt2KKEvvgQ59uth3PFuz2bpGlI3J523gtlT1zvOUrVjg4cJCLEz3N7VGvhSoUm5r16++I257k
 rkC7SzMuKL/3HxYUdf0E+/YComL8x8ESx+DfZWoenVskgqYv54Utpwozs8/v7J5QC5n/9AkLQ9U
 f+MK0kPhARgwMYRWBS8=
X-Received: by 2002:a05:6830:25c6:b0:7fa:5c49:524a with SMTP id
 46e09a7af769-80de2bd160cmr4323859a34.17.1789773057479; 
 Fri, 18 Sep 2026 16:10:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107e89fc00sm839338a34.21.2026.09.18.16.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 16:10:56 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:10:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: u-boot@lists.u-boot-project.org, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michael Walle <mwalle@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Marek Vasut <marex@nabladev.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Message-ID: <20260918231054.GX858934@bill-the-cat>
References: <20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qeFhUWbUrXSCO8Cs"
Content-Disposition: inline
In-Reply-To: <20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com>
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


--qeFhUWbUrXSCO8Cs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 02:40:48PM +0900, Takahiro Kuwano wrote:

> The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> specific fixups. The spi-nor-ids.c has single large ID database. There
> are many #ifdef directives in those files and that negatively affects
> readability and maintainability.
>=20
> This series, as the first step of cleanup, move SFDP logic, IDs, and
> fixups to newly source files. Reworking, renaming, and reformating
> existing code is not a scope of this series and further cleanup will be
> taken place in follow-up patches.
>=20
> Here is the code size impact when applying this series.
> Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> manufcaturers are enabled.

So this is a good idea, I took too long on picking up, sorry. Can you
please rebase on top of current next? I did the merge fixups easily
enough but drivers/mtd/spi/sandbox.c needs updating now.

--=20
Tom

--qeFhUWbUrXSCO8Cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq3E+gAKCRAr4qD1Cr/k
CnzlAQDIhi3wTo5p5iHBJgEGTqbqsBHum0vALAqWOLsYuXhEKQD/S9qDEzM/WMYI
CEuSkaNFpWalndsAVY5oG1SwCmDeRww=
=5N9v
-----END PGP SIGNATURE-----

--qeFhUWbUrXSCO8Cs--
