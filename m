Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAC4D2ECF6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 23:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8376839D5;
	Tue, 20 Jan 2026 00:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6AE839DF; Tue, 20 Jan 2026 00:10:55 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2D61D8389A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 00:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C61011476;
 Mon, 19 Jan 2026 15:10:44 -0800 (PST)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422C53F632;
 Mon, 19 Jan 2026 15:10:50 -0800 (PST)
Date: Tue, 20 Jan 2026 00:09:44 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Bohdan Chubuk <chbgdn@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Hans de Goede
 <hdegoede@redhat.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] sunxi: avoid double vendor prefix when
 CONFIG_OF_UPSTREAM is enabled
Message-ID: <20260120000944.57460885@ryzen.lan>
In-Reply-To: <20251123204346.1847095-1-chbgdn@gmail.com>
References: <20251123204346.1847095-1-chbgdn@gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 23 Nov 2025 22:43:46 +0200
Bohdan Chubuk <chbgdn@gmail.com> wrote:

Hi Bohdan,

thanks for the patch!

> When CONFIG_OF_UPSTREAM is enabled, the device tree name provided by SPL
> already includes the vendor directory (e.g., "allwinner/board-name").
> 
> The existing logic in misc_init_r() unconditionally prepends "allwinner/"
> for ARM64 builds, resulting in an incorrect path like
> "allwinner/allwinner/board-name.dtb".
> 
> This patch modifies the logic to only prepend the vendor prefix if
> CONFIG_OF_UPSTREAM is NOT enabled. This ensures compatibility with both
> legacy builds and the new upstream devicetree structure.

Weird, I thought we already fixed that.
Anyway, looks good to me, will take it. Just fixing up the one nit
below.

> 
> Signed-off-by: Bohdan Chubuk <chbgdn@gmail.com>
> ---
>  board/sunxi/board.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index 2929bc17f08..c68b51d370d 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -834,7 +834,10 @@ int misc_init_r(void)
>  	/* Set fdtfile to match the FIT configuration chosen in SPL. */
>  	spl_dt_name = get_spl_dt_name();
>  	if (spl_dt_name) {
> -		char *prefix = IS_ENABLED(CONFIG_ARM64) ? "allwinner/" : "";
> +		const char *prefix = "";
> +
> +		if (IS_ENABLED(CONFIG_ARM64) && !IS_ENABLED(CONFIG_OF_UPSTREAM))
> +			prefix = "allwinner/";
>  		char str[64];

We should keep variable declarations together, so moving this.
Will fix this while committing.

Cheers,
Andre

>  
>  		snprintf(str, sizeof(str), "%s%s.dtb", prefix, spl_dt_name);

