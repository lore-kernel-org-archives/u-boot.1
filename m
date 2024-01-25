Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569E7C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 11:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC696871A6;
	Thu, 25 Jan 2024 12:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="nGj0Rtkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B953A87527; Thu, 25 Jan 2024 12:02:22 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A9E87168
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 6A130224D2;
 Thu, 25 Jan 2024 12:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1706180539;
 bh=jvDQvq9jrMENWMyw6Qks7tlN2gmfJ8dbI+L347wesQw=; h=From:To:Subject;
 b=nGj0RtkrVXef7OxdARr/7J8lcMVoIdeELeeev24eB8cJLtiLGthvlP3OMKBbOUH9p
 7EmXjHp7UvCLPsMGeTxGy8B6VqDcEiqB16gCaCcKTOKAqs7uhyN3N9256Htb6hbyOq
 y2P+gRhN2ITvMvor7148YPaOA7lkjRStLKTfiZqujMw+KtwTz2+rjc/ASVcfLAJJ1t
 f5InJySm1psbLNwDrwC+iFLL1YVvGsVnmfCesMvsqGsLEXRS7vU3H8KjyvvIPbtn5M
 WqwUrpjoxAbnx5vBq5gCao7NazW5ffOloG7CeBjbmlxtiC2rV+rdGE8TaNEX6qu5q6
 lFWCIXoaWzSdQ==
Date: Thu, 25 Jan 2024 12:02:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] toradex: tdx-cfg-block: Add new apalis and colibri pid
Message-ID: <20240125110214.GA12545@francesco-nb>
References: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122200930.673447-1-jpaulo.silvagoncalves@gmail.com>
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

On Mon, Jan 22, 2024 at 05:09:30PM -0300, Joao Paulo Goncalves wrote:
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> 
> Add new apalis imx6 and colibri imx6/imx7 products IDs.
> 
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> ---
>  board/toradex/common/tdx-cfg-block.c | 9 +++++++++
>  board/toradex/common/tdx-cfg-block.h | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/tdx-cfg-block.c
> index 7187e1ba377..7affc290395 100644
> --- a/board/toradex/common/tdx-cfg-block.c
> +++ b/board/toradex/common/tdx-cfg-block.c
> @@ -147,6 +147,15 @@ const struct toradex_som toradex_modules[] = {
>  	[74] = { "Verdin AM62 Dual 1GB IT",              TARGET_IS_ENABLED(VERDIN_AM62_A53) },
>  	[75] = { "Verdin AM62 Dual 1GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
>  	[76] = { "Verdin AM62 Quad 2GB WB IT",           TARGET_IS_ENABLED(VERDIN_AM62_A53) },
> +	[77] = { "Colibri iMX6S 256MB",                  TARGET_IS_ENABLED(COLIBRI_IMX6)    },
> +	[78] = { "Colibri iMX6S 256MB IT",               TARGET_IS_ENABLED(COLIBRI_IMX6)    },
> +	[79] = { "Colibri iMX6DL 512MB",                 TARGET_IS_ENABLED(COLIBRI_IMX6)    },	
there is some trailing space here at the end of the line.

Fabio, can you fix this up before applying?

Francesco

