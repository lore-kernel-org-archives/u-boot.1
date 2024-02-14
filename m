Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8913EC48BC1
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 20:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E6A87D59;
	Wed, 14 Feb 2024 21:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hellion.org.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B531C87DEC; Wed, 14 Feb 2024 14:53:04 +0100 (CET)
Received: from benson.vs.mythic-beasts.com (benson.vs.mythic-beasts.com
 [IPv6:2a00:1098:86:101::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4DD87CEC;
 Wed, 14 Feb 2024 14:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=hellion.org.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ijc@hellion.org.uk
Received: from cmbg-18-b2-v4wan-169768-cust68.vm17.cable.virginm.net
 ([81.101.144.69] helo=[192.168.2.211])
 by benson.vs.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ijc@hellion.org.uk>)
 id 1raFh2-00AY3O-RL; Wed, 14 Feb 2024 13:52:56 +0000
Message-ID: <827145b922239467c9fb520839d25384c1a57c0e.camel@hellion.org.uk>
Subject: Re: [PATCH v5 08/11] doc: devicetree: Updates for
 devicetree-rebasing subtree
From: Ian Campbell <ijc@hellion.org.uk>
To: Sumit Garg <sumit.garg@linaro.org>, Paul Barker
 <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com,  ilias.apalodimas@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de,  michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk,  peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de,  mibodhi@gmail.com, bb@ti.com,
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com, 
 andre.przywara@arm.com
Date: Wed, 14 Feb 2024 13:52:55 +0000
In-Reply-To: <CAFA6WYOdYK4vAibGEQ9SnNCGMv00AKYkzZu+capfW9E4y=cFHA@mail.gmail.com>
References: <20240202130534.1051438-1-sumit.garg@linaro.org>
 <20240202130534.1051438-9-sumit.garg@linaro.org>
 <518d87fc-457e-4d77-ba66-9e3a5aa15279@bp.renesas.com>
 <CAFA6WYOdYK4vAibGEQ9SnNCGMv00AKYkzZu+capfW9E4y=cFHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 14 Feb 2024 21:11:33 +0100
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

On Wed, 2024-02-14 at 19:02 +0530, Sumit Garg wrote:
>=20
> >=20
> > Also, is devicetree-rebasing a "forked copy"? A fork would imply some
> > difference from upstream. I would guess this is more like a mirror.
>=20
> AFAIK, it's a mirror from upstream with a different directory
> (Makefile) structure. Ian may clarify further as to how this mirror is
> kept updated.

It's not really a mirror nor a fork, I guess it is something in
between.

It's a rewritten tree which extracts the DTS bits only from the kernel
source into a standalone source repo. It's produced using "git filter-
branch", all the scripting to do so is at:

https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebas=
ing.git/tree/scripts

The conversion state is part of
https://github.com/ijc/devicetree-conversion-state-v3/, that repo
contains all of upstream Linux commits too, since the branches there
track the most recently converted inputs to support incremental
updates.

There's also the filter-map branch which maintains the state needed to
not have to redo the conversion every time (which from scratch took
days last time...)

Ian
