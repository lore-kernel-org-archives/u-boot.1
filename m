Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CCEC5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 08:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8A2828F8;
	Sat,  7 Jun 2025 10:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="uBIHJEPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A770B82998; Sat,  7 Jun 2025 10:33:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40142826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 10:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=db21=YW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1749285196;
 bh=9cA2ftqaF7Ju/D8quu2wAA3cJt/xpZ4m/A85yMsDwR0=;
 b=uBIHJEPJ8jWx4ESRwQrQrEq9qYYZ3f0EpLK5h5uetTmaTzGdkkK2F/r5D4pCifWfOJhoDIOtO
 Je7zyzsIAcfhHTu5ruwrln3r9o/FFfx0mYv8wrA+Pp5BeDk99nKHL2eGd0dL6fZPBpkvbKnNfZ8
 xzVNHEHYMozeqDvdmX8nI120TjFLkB5ie9Fo/QXwe7GkKfvr7NKBYPb0yMY6ln83/I3Owz0mqsu
 Tsm+EalE1af0HBwRdQ2wBrlrY65MvoHy/fge84sZran6Zx+t5x4EyfzwJ9xRhYvNvNXG/MBDkdm
 tKcXtVIOGBET7NFRLHh2TRd7YW3+SXdy729V3YX12UBg==
X-Forward-Email-ID: 6843f949205d874ee6479ffa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <25bb722b-4205-4009-bf4c-3ed4cc32adbc@kwiboo.se>
Date: Sat, 7 Jun 2025 10:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] common/spl: improve error handling in spl_fit
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20250606205410.GC1382132@bill-the-cat>
 <20250606223109.502055-1-mikhail.kshevetskiy@iopsys.eu>
 <20250606223109.502055-4-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250606223109.502055-4-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Mikhail,

On 2025-06-07 00:31, Mikhail Kshevetskiy wrote:
> This fix a possible NULL pointer dereference.
> 
> There is also a risk of memory leaking within the same portion of code.
> The leak will happen if loaded image is bad or damaged. In this case
> u-boot-spl will try booting from the other available media. Unfortunately
> resources allocated for previous boot media will NOT be freed.
> 
> We can't fix that issue as the memory allocation mechanism used here
> is unknown. It can be different kinds of malloc() or something else.
> 
> To somewhat reduce memory consumption, one can try to reuse previously
> allocated memory as it's done in board_spl_fit_buffer_addr() from
> test/image/spl_load.c.
> 
> The corresponding comment was put to the code as well.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  common/spl/spl_fit.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> index 783bb84bdb5..438d1ecf124 100644
> --- a/common/spl/spl_fit.c
> +++ b/common/spl/spl_fit.c
> @@ -703,13 +703,29 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
>  	 */
>  	size = get_aligned_image_size(info, size, 0);
>  	buf = board_spl_fit_buffer_addr(size, size, 1);
> +	if (!buf)

Are we sure 0x0 is not a valid load address on all platforms? On what
platform are you seeing this being an issue on?

On e.g. Rockchip 0x0 is typically a valid DRAM address and could
theoretically be used as the load address in xPL, it is highly unlikely
because SPL is typically loaded to start of DRAM at 0x0.

> +		return -EIO;
>  
>  	count = info->read(info, offset, size, buf);
> +	if (!count) {
> +		/*
> +		 * The memory allocated by board_spl_fit_buffer_addr()
> +		 * should be freed. Unfortunately, we don't know what
> +		 * memory allocation mechanism was used, so we'll hope
> +		 * for the best and leave it as is.
> +		 *
> +		 * To somewhat reduce memory consumption, one can try
> +		 * to reuse previously allocated memory as it's done in
> +		 * board_spl_fit_buffer_addr() from test/image/spl_load.c
> +		 */

For platforms using SPL_SYS_MALLOC_SIMPLE this comment does not fully
make sense. With SPL_SYS_MALLOC_SIMPLE no allocated memory is re-used.

To my knowledge xPL is typically running with size constrains and memory
leaking and re-use of freed memory is typically not really an issue as
main purpose of xPL is to load and jump to next phase.

On what platform have you seen the need for this memory to be freed?

Regards,
Jonas

> +		return -EIO;
> +	}
> +
>  	ctx->fit = buf;
>  	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
>  	      offset, size, buf, count);
>  
> -	return (count == 0) ? -EIO : 0;
> +	return 0;
>  }
>  
>  static int spl_simple_fit_parse(struct spl_fit_info *ctx)

