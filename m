Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC91E668A2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DAD89A2F;
	Mon, 25 Nov 2024 11:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="T7gj67kq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93FF289A32; Mon, 25 Nov 2024 11:48:09 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6382689365
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 80D8620150;
 Mon, 25 Nov 2024 11:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1732531686;
 bh=KiRx51mA7Pzpa5177CqWl2wiGPmSi8y82cWYrGsVG74=;
 h=Received:From:To:Subject;
 b=T7gj67kqNVoHl8Y9f2rMVlneBHBS7VNzaOdLV1cgd9o3rQ0IcfYc+qh5X7YBaAPPc
 FMdu6AeXKcS0IXtdVYZIZB6/gN8orASfYRId0PnmxNXEUm8vVL7GO1gSFgpCYp+cIL
 bLb9sUlfgfmxZ+EOFXi2eJgF//zw0YGH0wULPkuL12Txxzjn1wDkPigrH0Vm2QCLrA
 +U5eoZ+3P4KUaKWEC+q45GN3g6kI2QTa3WZVlX6hykp4dTMpeuAVErxtQDc18LOFKd
 9pNI+nJ8XUICExIT9UlXsaacP8Sed8p+3V4AaW6zdJxgHGNZIEvWIO9qqGyCZ56fEe
 DDoBaFoHOp69w==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 2AE177F996; Mon, 25 Nov 2024 11:48:06 +0100 (CET)
Date: Mon, 25 Nov 2024 11:48:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>, festevam@gmail.com
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 emanuele.ghidoli@toradex.com
Subject: Re: [PATCH v2] toradex: tdx-cfg-block: rework modules pid4 handling
Message-ID: <Z0RV5sl7uMzFXvW9@gaggiata.pivistrello.it>
References: <20241122182722.457366-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122182722.457366-1-ivitro@gmail.com>
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

+Fabio

since he is the one normally picking patches from board/toradex/.

On Fri, Nov 22, 2024 at 06:27:22PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The module pid4 currently corresponds to the index of the toradex_module
> array. If a new pid4 is introduced that does not follow the sequence of
> the previous entries, it will create a gap in the array.
> 
> To address this, embed pid4 within the toradex_som structure and
> implement a function to retrieve the index corresponding to pid4.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
> v1->v2:
>   - Fix incorrect PID4 print when creating config block in interactive mode.
> 
>  board/toradex/common/tdx-cfg-block.c | 207 ++++++++++++++-------------
>  board/toradex/common/tdx-cfg-block.h |   2 +
>  board/toradex/common/tdx-common.c    |   4 +-
>  3 files changed, 116 insertions(+), 97 deletions(-)
> 

...

> diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
> index a6b45cdab810..dd2d4b27cea7 100644
> --- a/board/toradex/common/tdx-common.c
> +++ b/board/toradex/common/tdx-common.c
> @@ -194,10 +194,12 @@ static int tdx_get_str(struct udevice *dev, int id, size_t size, char *val)
>  
>  	switch (id) {
>  	case SYSINFO_ID_BOARD_MODEL:
> +		int idx = get_toradex_modules_idx(tdx_hw_tag.prodid);
> +

this is not something you are generally allowed to do in C, not sure which C
variant U-Boot wants, but I would avoid it.

I do not personally mind it, would appreciate a comment from Fabio or some
other maintainer on this.

Assuming this is fine,

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

