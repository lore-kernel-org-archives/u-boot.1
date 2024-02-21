Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF50C48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 21:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 064318804C;
	Wed, 21 Feb 2024 22:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="d0gY7i4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3D7588026; Wed, 21 Feb 2024 22:17:15 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4918804C
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 22:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C894820AAE;
 Wed, 21 Feb 2024 22:17:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708550232;
 bh=Dckl5vIPavxRBE1Ql9JV6B4P8SzDPfN46KQ0Fdg4LLY=;
 h=Received:From:To:Subject;
 b=d0gY7i4bNJ52xL2LFLumVz+hoPwU946dYIDbQDAuv2P4DBBt+qJ38kjnYf9li7F9F
 Crpjy81K8Ur7DtDngDL6C80LBVyEQkyz7zWbrJcnU2+Qt/6pgyBtjBujteRX8Z3/ji
 lx9DA/ma12NbELvbwhKMQxbUaR5s0nFUsdviN7Z9iRctjAmSxlfKRvd9H8Ih+v9rou
 ruyox+1edad51aoUU6vvJ9bgQAv/7EzwuEoTneuD/vOQ86Xr1qKMMOpfxp2POg8knD
 WW5/p7KuWwrnAVvNqRmC54lbsQ4SVvmYRO4Mi2hFs7Jw/vavb5tu/nttcr1XB+0nmS
 36ZTsS7RNhFYQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id EDA807F9D7; Wed, 21 Feb 2024 22:16:54 +0100 (CET)
Date: Wed, 21 Feb 2024 22:16:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 5/7] toradex: common: Add sysinfo driver
Message-ID: <ZdZoRvUksKWGIdLQ@gaggiata.pivistrello.it>
References: <20240220182926.101161-1-francesco@dolcini.it>
 <20240220182926.101161-6-francesco@dolcini.it>
 <CAByghJZhJtL8m_DdQ0PthvEfT1r6GdZWij179BhBGOKhks59Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAByghJZhJtL8m_DdQ0PthvEfT1r6GdZWij179BhBGOKhks59Dg@mail.gmail.com>
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

On Wed, Feb 21, 2024 at 04:43:28PM +0100, Igor Opaniuk wrote:
> On Tue, Feb 20, 2024 at 7:31 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > +       sysinfo {
> > +               compatible = "toradex,sysinfo";
> > +       };
> > +
> Have you considered introducing some common *-u-boot.dtsi include
> and putting such nodes there just to avoid code duplication?

Yes, we discussed internally about this. In pratice it was a trade off between
one line with a well defined and transparent meaning with an opaque include, we
concluded that the current proposal is the best approach.

Francesco

