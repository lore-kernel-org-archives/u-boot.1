Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E61C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 15:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F238295C;
	Sat, 10 May 2025 17:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JHdgQHjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0714A82A33; Sat, 10 May 2025 17:31:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E5182952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 17:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c8d5=X3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1746891105;
 bh=IawsK8F03mTMamO9ChZM2BfRlGKnL9eLXaIbt0SrjY0=;
 b=JHdgQHjJ+UqPPBEBAmWv4ntJH61SMBbP+igbRDYkFZZppiAWHqsfIxQMuWrbjggv7HUB1EPHD
 14FQSpNuR+OKDDkg1KNcpueByBMhp+biYZQkjX8hrdV90m9z253WSeL4tR0V9h/oZWFcJDOoMZW
 ql2H6F+FA8RSVU/Lw3+lDaD/ckRU7QOrKbhfB4qKDovAmhUygPjfutJfSJmwMoYlNZNMVjXycIH
 9XG3RX1jrxF1IIBMKAU9sVDddDV4wy5BHRlPz87l4OqBVt1Eq/XqSiZe1rjNDIOsSwgPbzlW4wd
 7f7fDCMuMDu3sSqP0Eb3C/vXxAcgtO3zZClkeFK92tMw==
X-Forward-Email-ID: 681f715d5b0e4d7e6a25ad5b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3ae0c43b-8b6f-43c3-89d3-5773bef5ed23@kwiboo.se>
Date: Sat, 10 May 2025 17:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/22] fdt: Redo devicetree setup
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Evgeny Bachinin
 <EABachinin@salutedevices.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510134253.1581164-5-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250510134253.1581164-5-sjg@chromium.org>
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

Hi Simon,

On 2025-05-10 15:42, Simon Glass wrote:
> The existing logic for handling receiving a devicetree from a previous
> phase is quite complicated. Simplify it in preparation for introducing
> standard passage.
> 
> Add a Kconfig called OF_PASSAGE which indicates that the devicetree
> must come from standard passage.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v4:
> - Drop now-unused label
> 
> Changes in v3:
> - Add new patch to redo how a devicetree is set up
> 
>  dts/Kconfig  |  8 ++++++++
>  lib/fdtdec.c | 35 ++++++-----------------------------
>  2 files changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/dts/Kconfig b/dts/Kconfig
> index c544f948a15..57101bddabb 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -159,6 +159,14 @@ config OF_EMBED
>  	  and development only and is not recommended for production devices.
>  	  Boards in the mainline U-Boot tree should not use it.
>  
> +config OF_PASSAGE
> +	bool "DTB is provided by a standard passage, in a bloblist"
> +	help
> +	  Select this to read the devicetree using the standard passage
> +	  mechanism, i.e. from a previous phase in bloblist using arch-specific
> +	  register conventions. If enabled, the previous phase must provide
> +	  the devicetree, or U-Boot will not function correctly.
> +
>  endchoice
>  
>  config OF_INITIAL_DTB_READONLY
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index c38738b48c7..8559616873b 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1689,35 +1689,13 @@ void fdtdec_setup_embed(void)
>  
>  int fdtdec_setup(void)
>  {
> -	int ret = -ENOENT;
> -
> -	/*
> -	 * If allowing a bloblist, check that first. There was discussion about
> -	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
> -	 *
> -	 * The necessary test is whether the previous phase passed a bloblist,
> -	 * not whether this phase creates one.
> -	 */
> -	if (CONFIG_IS_ENABLED(BLOBLIST) &&
> -	    (xpl_prev_phase() != PHASE_TPL ||
> -	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> -		ret = bloblist_maybe_init();
> -		if (!ret) {
> -			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> -			if (gd->fdt_blob) {
> -				gd->fdt_src = FDTSRC_BLOBLIST;
> -				log_debug("Devicetree is in bloblist at %p\n",
> -					  gd->fdt_blob);
> -				goto setup_fdt;
> -			} else {
> -				log_debug("No FDT found in bloblist\n");
> -				ret = -ENOENT;
> -			}
> -		}
> -	}
> +	int ret;
>  
> -	/* Otherwise, the devicetree is typically appended to U-Boot */
> -	if (ret) {
> +	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {

This looks wrong, should possible be OF_PASSAGE ?

Also looks like there is more patches in need of a correction to use
OF_PASSAGE instead of OF_BLOBLIST in commit message and/or patch content
in this series.

Regards,
Jonas

> +		printf("Previous phase failed to provide standard passage\n");
> +		return -ENOENT;
> +	} else {
> +		/* The devicetree is typically appended to U-Boot */
>  		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
>  			gd->fdt_blob = fdt_find_separate();
>  			gd->fdt_src = FDTSRC_SEPARATE;
> @@ -1752,7 +1730,6 @@ int fdtdec_setup(void)
>  		}
>  	}
>  
> -setup_fdt:
>  	if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
>  		setup_multi_dtb_fit();
>  

