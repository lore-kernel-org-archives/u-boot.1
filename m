Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673AAC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 17:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D12987A80;
	Wed, 31 Jan 2024 18:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CyG5Odqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6473C87B5D; Wed, 31 Jan 2024 18:15:52 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CD2879F0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matthias.bgg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A70CD618CD;
 Wed, 31 Jan 2024 17:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB80CC433F1;
 Wed, 31 Jan 2024 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706721348;
 bh=teKEdDuDdTCQMq/T1NmoeahKWF0CQsfSfgfLN6vx/7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CyG5OdqepfyuEEfn/FGT3mgJv7vHNScXzXBGMfPMTSOF6bDV6NOvX4Zsqgh3HXj4M
 bxKnzEfqlQnfBtIUtHQ6NcGYOtScDsWEqdBRYoI/YMd7wpVE0rba3NQ7eLnGvV9AcS
 G6U0ttkGlidvi2ZdHptrl+Wal4pAnZtMyuHrUMoM/2neXYTS7tx29x40n4t+SciRtp
 9R/LrXE7tzRh0eaD90On5HNynrJsWrPo2aA/8Vapw/wFmVe/m6+oG+uSpklvBINY8w
 WENsswNg9sEAwLFvENHmmGM/t77YOzCtx7ydZ5Zo0QQ7YXoqrlPfW2pL6bfkopmQKP
 tBOE/Fq6n9Fng==
Date: Wed, 31 Jan 2024 18:15:43 +0100
From: Matthias Brugger <matthias.bgg@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/7] smbios: string table always needs two terminating
 NUL bytes
Message-ID: <ZbqAP_PL9lidp5ru@ziggy.stardust>
References: <20240129210453.31070-1-heinrich.schuchardt@canonical.com>
 <20240129210453.31070-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129210453.31070-5-heinrich.schuchardt@canonical.com>
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

On Mon, Jan 29, 2024 at 10:04:50PM +0100, Heinrich Schuchardt wrote:
> The string section of the different SMBIOS structures is always terminated
> by two NUL bytes even if there is no string at all. This is described in
> section 6.1.3 "Text string" of the SMBIOS 3.7.0 specification.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

I send the very same patch some years ago [1], unfortunately it got
somehow lost. Happy to see you trying to fix the same problem, so:
Reviewed-by: Matthias Brugger <mbrugger@suse.com>


[1] https://patchwork.ozlabs.org/project/uboot/patch/20210406090435.19357-1-matthias.bgg@kernel.org/ 

> ---
>  lib/smbios.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7bd9805fec0..81908e89610 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -311,6 +311,9 @@ int smbios_update_version(const char *version)
>   */
>  static int smbios_string_table_len(const struct smbios_ctx *ctx)
>  {
> +	/* If the structure contains no string it is followed by to NUL bytes */
> +	if (ctx->next_ptr == ctx->eos)
> +		return 2;
>  	/* Allow for the final \0 after all strings */
>  	return (ctx->next_ptr + 1) - ctx->eos;
>  }
> -- 
> 2.43.0
