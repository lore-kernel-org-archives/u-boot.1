Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8343DCD484E
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010DB80F0E;
	Tue, 12 May 2026 08:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="cmuCwXPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B0F83015; Tue, 12 May 2026 08:41:18 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E8180398
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 574631F8CC;
 Tue, 12 May 2026 08:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778568075;
 bh=JMrWqmonwAOEosZxzCVqlpvccpjMnQC09wIHdhXnlJM=; h=From:To:Subject;
 b=cmuCwXPFv8blUh4DiU92CkzpzKEEDKyzBbS8PKOBdy2rTC7oPeaSu5NkILp+9TYoP
 gA8RJsPDAr+4o88sL97CIfa39FSffofY5VYoFcEJ+kXSnJb3mWoHydohjB+xaeEAeM
 POzQ/e7hyJp5jG8x2NGvjYX5LND59xntm9nGvlgBRiVeuILEJK9daiSewclc4AjqD7
 aWjjCyX9MWqzy+gyzzFKUV+MiNq/HEmPUgU95+ppKv3MFK7E7WoBRNeYrpJac/D3/r
 fEVL35gSswfMp9tEEgRjZwOWVvRAa3aC1tA+ks0sxDnYP8bxSAA1p3aLuNRjyZWHN5
 QqDcRux85tcXA==
Date: Tue, 12 May 2026 08:41:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Ji Luo <ji.luo@nxp.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/4] nxp: imx9: rename get_reset_reason() ->
 print_reset_reason()
Message-ID: <20260512064111.GA5820@francesco-nb>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-3-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511201235.1066697-3-alexander.sverdlin@siemens.com>
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

On Mon, May 11, 2026 at 10:12:31PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Rename get_reset_reason() into print_reset_reason() as the latter better
> describes the functionality. get_reset_reason() can now be a global symbol
> providing a reset reason as string.
> 
> No change in behaviour expected.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  arch/arm/include/asm/arch-imx9/sys_proto.h | 2 +-
>  arch/arm/mach-imx/imx9/scmi/soc.c          | 2 +-
>  board/nxp/imx94_evk/spl.c                  | 2 +-
>  board/nxp/imx95_evk/spl.c                  | 2 +-
>  board/toradex/smarc-imx95/spl.c            | 2 +-

It's more than just these boards

$ ack --cc -l get_reset_reason board
board/toradex/verdin-imx95/spl.c
board/toradex/smarc-imx95/spl.c
board/nxp/imx952_evk/spl.c
board/nxp/imx94_evk/spl.c
board/nxp/imx95_evk/spl.c

Francesco

