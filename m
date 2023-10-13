Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E70ACDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 19:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6454186E22;
	Fri, 13 Oct 2023 21:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DFF86961; Fri, 13 Oct 2023 21:44:31 +0200 (CEST)
Received: from mx1.tinet.cat (mx1.tinet.cat [195.77.216.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8DF86E47
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 21:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1697226253-163e7b54be1112d0001-4l7tJC
Received: from smtp01.tinet.cat (smtp01.tinet.org [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id dsr4nop8dMQfXFzK;
 Fri, 13 Oct 2023 21:44:13 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp01.tinet.org[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (191.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.191])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 3EEE0605DE45;
 Fri, 13 Oct 2023 21:44:13 +0200 (CEST)
Date: Fri, 13 Oct 2023 21:44:01 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [SPAM] [PATCH 20/26] test: spl: Add functions to create images
Message-ID: <ZSmeAWkQl1f2F-JS@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [SPAM] [PATCH 20/26] test: spl: Add functions to create
 images
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-21-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012015626.3487451-21-seanga2@gmail.com>
X-Barracuda-Connect: smtp01.tinet.org[195.77.216.131]
X-Barracuda-Start-Time: 1697226253
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2270
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4912 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.115354
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
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

El Wed, Oct 11, 2023 at 09:56:20PM -0400, Sean Anderson deia:
> This add some basic functions to create images, and a test for said
> functions. This is not intended to be a test of the image parsing
> functions, but rather a framework for creating minimal images for testing
> load methods. That said, it does do an OK job at finding bugs in the image
> parsing directly.
> 
> Since we have two methods for loading/parsing FIT images, add LOAD_FIT_FULL
> as a separate CI run.
> 
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
>  .azure-pipelines.yml             |   4 +
>  .gitlab-ci.yml                   |   7 +
>  arch/sandbox/cpu/u-boot-spl.lds  |   2 +
>  configs/sandbox_noinst_defconfig |   6 +
>  configs/sandbox_spl_defconfig    |   6 +
>  include/test/spl.h               | 117 ++++++++++
>  test/image/spl_load.c            | 352 +++++++++++++++++++++++++++++++
>  test/image/spl_load_os.c         |   5 +-
>  8 files changed, 495 insertions(+), 4 deletions(-)
>  create mode 100644 include/test/spl.h
>
[...]
> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> index 1a57bf846d2..ca3777cab37 100644
> --- a/test/image/spl_load.c
> +++ b/test/image/spl_load.c
> @@ -4,7 +4,15 @@
>   */
>  
>  #include <common.h>
> +#include <image.h>
> +#include <imx_container.h>
>  #include <mapmem.h>
> +#include <memalign.h>
> +#include <rand.h>
> +#include <spl.h>
> +#include <test/spl.h>
> +#include <test/ut.h>
> +#include <u-boot/crc.h>
>  
>  int board_fit_config_name_match(const char *name)
>  {
> @@ -15,3 +23,347 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
>  {
>  	return map_sysmem(0x100000, 0);
>  }
> +
> +/* Try to reuse the load buffer to conserve memory */
> +void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> +{
> +	static void *buf;
> +	static size_t size;
> +	static bool invalid = true;
> +
> +	if (invalid || size < sectors * bl_len) {
> +		if (!invalid)
> +			free(buf);
> +		buf = malloc_cache_aligned(sectors * bl_len);
> +		invalid = false;

Should size be updated here or am I being thick ?
                size = ALIGN(sectors * bl_len, ARCH_DMA_MINALIGN);
		
> +	}
> +	return buf;
> +}
> +
