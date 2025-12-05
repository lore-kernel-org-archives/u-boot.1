Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C6D2F7C6
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 09:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264C284083;
	Fri,  5 Dec 2025 10:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="d7RiDLxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C3B84148; Fri,  5 Dec 2025 10:07:26 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D6484047
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 10:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 627311FACE;
 Fri,  5 Dec 2025 10:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764925642;
 bh=cfME5AG15MG2eKDkPRqyoQo+Lh5jM85BslMx/pGaeZE=; h=From:To:Subject;
 b=d7RiDLxAV3RIyLx1Bqsbasv6yd5uq4YgJ3YC3m9zMUQesfCkEVQrAuzUB5LUwgcDX
 eDps9z3Rc/c1YcKD7dlG5WAYhQzayn85QZnryNh8UQfDiiIlr3/oaO45hFMtpL7gW0
 zARoWREXqyGA1eTsBZsb26zjCD/Itq8mnft1YnX7jW8JhG/S44im+5gEmd8d7HL/sF
 fiEK7nKZREo1PItBF87NAEmIZmc9EF6OVn1zXqTkiqikolvUhAxs2W7kvoqcYyJUXV
 QQ+9nv3ppBCBaSDvs7pIkMvHt+HSPSAVUFKiT0owu2KIh/nrQ6uq4pOWf0t+mSO1XJ
 IGv6XuO2QjfTQ==
Date: Fri, 5 Dec 2025 10:07:18 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] configs: apalis-imx8/colibri-imx8x: use default for
 SYS_MALLOC_F_LEN
Message-ID: <20251205090718.GA49509@francesco-nb>
References: <20251204164133.1677471-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204164133.1677471-1-max.oss.09@gmail.com>
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

On Thu, Dec 04, 2025 at 05:41:27PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> Drop setting an explicit value for SYS_MALLOC_F_LEN. This increases
> the available space to 0x10000.
> 
> While U-Boot works with the current setting of 0x4000 increasing the
> size for cmalloc helps if further space is required, e.g. when
> enabling more DM managed devices.

for the series

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

