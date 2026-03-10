Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F71FCC9D6
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 07:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 001D283981;
	Tue, 10 Mar 2026 08:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="kvHBRZ8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B2E883BC8; Tue, 10 Mar 2026 08:51:37 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2DC983952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id D2CA92147B;
 Tue, 10 Mar 2026 08:51:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1773129094;
 bh=EFFBJMMbB8TRe+03jcmCol2PxOY8yU4KUf+PDzv5KSc=; h=From:To:Subject;
 b=kvHBRZ8Zf6ckhOBxH75bpWqPe0hBVVQHWLzpXUXhbz5wKXPNz2NYSgBRRZBv0J8he
 ZmiNWNQ3pnX6o4zIZqoqV9qf+b+Re+NuIOYEbBJ9dcZic+3xxcU5ilVASM+e9aTbs9
 WVHVejcGwja6/PB2Q/Hr7YSzrR8oN8jyg1zFbDUmOnI9Co5Y884OlmHFdw7yFyvgoY
 IIJsWUuD8KehK0jY8k3TmKD7iChF6NCiloOTInnzSq29562IPcfTNQeQDBrTdcn7h+
 uLdmbnu2PlvsftsPUaAkZ4Kk70XVGFwrjrAyEC0Bnpxrd6ZX36diuGYoFmu3ImaZH4
 4fF2AeYtTX3PQ==
Date: Tue, 10 Mar 2026 08:51:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] DDR configuration refactor and 16GB dual-rank
 support
Message-ID: <20260310075129.GA16485@francesco-nb>
References: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309155342.145432-1-ghidoliemanuele@gmail.com>
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

On Mon, Mar 09, 2026 at 04:53:06PM +0100, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> This series refactors the DDR configuration handling for the
> Toradex Aquila AM69 board and adds support for a 16GB dual-rank
> memory configuration, while changing the HW_CFG pins value to
> DDR configurations mapping.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

