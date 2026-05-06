Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ABDCD3424
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 06:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19837846DB;
	Wed,  6 May 2026 08:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="o0HPJgzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F7F84807; Wed,  6 May 2026 08:12:59 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D4A38468B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 08:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (unknown [185.12.129.183])
 by mail11.truemail.it (Postfix) with ESMTPA id AFC331F9E9;
 Wed,  6 May 2026 08:12:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778047975;
 bh=d4uJ29mN+kluVkAT1E1mmSx9n8w0lkP8z97JouI8Gz8=; h=From:To:Subject;
 b=o0HPJgzsxbLexYdopWlT1s/1JVV5tAonZix5AGEak0jFI7scp8tuFdjgkE21tJZcF
 nOXh+Cof1j0wL+k75m2fBIG/LULNbP6bVvzi9Tp4TnqrIVfncqBR1y7syMjZznIUmE
 TRSUBa7HEb5w/4fDr22V2XF/10kdQKQsa97//iZ95fPo13LbIeh+aHyRQ9JzUc3x1U
 7Fa46ZovSZgQw9lvhhVtDXmLHT1KPM1vUeCm9VMVEaUIID/ZT49jK9Pp1HXF/ZMnYN
 MluU7s/IVX9NTXpqv46pcwQRN/Wve3I6VYolrfxQGDsBiqMAPq+nI+k53IKhaJyGad
 6MmFLO+Hfvk1w==
Date: Wed, 6 May 2026 08:12:49 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Franz Schnyder <franz.schnyder@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
Message-ID: <20260506061220.GA14171@francesco-nb>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
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

On Tue, May 05, 2026 at 06:36:24PM +0200, Ernest Van Hoecke wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add nodes to the binman configuration to create single binaries that
> combine tiboot3-am69-*-aquila.bin, tispl.bin and u-boot.img into
> firmware-aquila-am69-*.bin, with the proper offsets.
> 
> These binaries can be used to flash U-Boot via a single binary of three,
> as it is done now.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

