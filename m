Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F7C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D8687980;
	Fri, 12 Jan 2024 16:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PKizOuIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FCCC879CE; Fri, 12 Jan 2024 16:58:54 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E028797C
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705075131;
 bh=1F8ElsSjkxhkDPdrspQRtyJCcZL/KptGCCy+iaibU1U=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=PKizOuIjBkXATr9kdki0c9+kHyK+eGdcxx0NN0eIWy1xP1B9ZxmuyKOzJQycphLn4
 XzbgGzyEbqzTtoeK+twmmWNSobQn9Esss7XRwdTmGRY/UnTr7xvFMrj06oZ4Og3qbR
 xqJhlmMxl0PGyzRq8Ykp+kW5HGxJ23Sk3ZdSTTuA3f/BF+7PeNUaP0PQGzEFG7zvMq
 BcK/OH0mmuxIzTLCcfyckj/GT/5eqLLyOI1k5Ah/fB3e+iZWPT19AVSxwkhwgQfTQc
 v3P0SSGpirQ1F2zBXc2TnP5PiVY66eW5tILKrFVLicz9eDMGAWwJo4+fFxEYoEI4Dd
 3crHo3Znt4Njw==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3DDAB3782036;
 Fri, 12 Jan 2024 15:58:51 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id C22CD9F0D258; Fri, 12 Jan 2024 16:58:50 +0100 (CET)
Message-ID: <b587fcaebed8b61285a901b468e3ccbddf7d06f2.camel@collabora.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn.welch@collabora.com>, Roger
 Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Dave Gerlach
 <d-gerlach@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Date: Fri, 12 Jan 2024 16:58:50 +0100
In-Reply-To: <20240112154006.eywtthszzbzz3uj5@makeshift>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <20240112123738.v76kpf6bfngtc2kr@zigzagged>
 <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
 <20240112131913.s6tc7wqgvjmflxpy@lyrically>
 <2bf954654a89c9e939dc27dca772fe57ea0077bf.camel@collabora.com>
 <20240112154006.eywtthszzbzz3uj5@makeshift>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Fri, 2024-01-12 at 09:40 -0600, Nishanth Menon wrote:
> On 16:06-20240112, Sjoerd Simons wrote:
> [...]
> > >=20
> > > I am starting to wonder if
> > > https://lore.kernel.org/u-boot/20231101170519.39627-1-afd@ti.com/
> > > will help us here.
> >=20
> > Yes absolutely that would be perfect. Can i suggest we land it as
> > is
> > for now ("fat monolithic config") and once those patches land i'm
> > happy
> > to split things up?=20
> >=20
>=20
> https://libera.irclog.whitequark.org/u-boot/2024-01-12#35590530=C2=A0I
> think
> Tom agrees in principle (and Simon already acked), so we could go
> down
> this road and refactor - I am always a bit squeamish about redoing
> work
> if the baseline changes or has a reasonable chance of change.. Just
> doing it once and cleanly is my preference.

Well lets see if this will land soonish then, that would be=C2=A0
amazing :)=C2=A0

And yes, no doubt, doing it right the first time makes sense. On the
other hand I'm wary about adding more and more blockers for this set.=20

--=20
Sjoerd Simons
Collabora Ltd.
