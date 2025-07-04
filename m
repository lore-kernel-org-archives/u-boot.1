Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD94C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 22:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D64582A76;
	Sat,  5 Jul 2025 00:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="0rbHXQIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AEFA82AF6; Sat,  5 Jul 2025 00:12:41 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEB582063
 for <u-boot@lists.denx.de>; Sat,  5 Jul 2025 00:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id DD7031FB2B;
 Sat,  5 Jul 2025 00:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1751667158;
 bh=dXbqQP+tsG+Msh7TzJLwZRBynbqOZGxmP3c3ALpqpWA=; h=From:To:Subject;
 b=0rbHXQIR1irVXVY42R+nyYLCVC5bhxoQyPJPmOIQifrroITYz0TKqV0aj8UIAP7AI
 92kFsIYazs4ZR6lZeWs8lEv0KvRL35e4LTmEsrYXobHMULduu0ARJm6NWnDN37zWxR
 J8nnYg4rA+Fzewmv69lK0GwbqI+SwINv9yidCdG5WvbYNjLYMsC+fTX2P4l6B1GpSC
 V/bh2/vFItLURzFz5FhNfylxHgZzIkYgcgLZ5s4d0aLeOD7rXLGCjidTgzgj5Bgelb
 689SbyHczi1MKGEF0uHA9c2VG0BXauZmxGWlSBtFfH6/JkHhHaqdsa6EF9HAeBqfJe
 b/nGrytEu+53g==
Date: Sat, 5 Jul 2025 00:12:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 1/2] toradex: Switch from ARCH_MISC_INIT to MISC_INIT_R
 in some cases
Message-ID: <20250704221232.GA16479@francesco-nb>
References: <20250704214542.3418805-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704214542.3418805-1-trini@konsulko.com>
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

On Fri, Jul 04, 2025 at 03:45:41PM -0600, Tom Rini wrote:
> The hook arch_misc_init was not intended to be used for per-board hooks.
> This can be done with misc_init_r instead, which is what follows
> immediately after arch_misc_init. Switch a few platforms.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

