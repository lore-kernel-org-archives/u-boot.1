Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D099C87FC9
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 11:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C84882D06;
	Mon, 28 Jul 2025 13:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="GE3220GC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277ED82F14; Mon, 28 Jul 2025 13:12:40 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF78A82C65
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 13:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 20E8614804EB; Mon, 28 Jul 2025 13:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1753701156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=A2NzCQXTwMCpZpZIwRbLjHEAXd+2XLnyuP5UHvCLLaE=;
 b=GE3220GCbTq+LHerXJJ/sqq1AjxrUtFmVZtQpac8go0YWgZ043pMJMFPoc9PPc5P8wKcsr
 ZI09DMdtKAZPEovcvkNDEy8anvDl305dM4S8u50mS5Mhz0j9kBmzF6rTFrWfGrbIdgfyis
 GjwV51efnz1ZRxe21i7qxLeDdHn7xPbGpnZ2HYq5SXDZw30NOLa0X2JuMe7qjX5J8+Kv8h
 hM8hn6jDAfNF51vDKRW0vrwAbBhQF59saaNE47JDMIj2wB+FGTmuLsfdjWeWOOH4JypU6W
 FUyqmVMSGyqF576jiPHs0xk/ajMeZfc857Y0MbPD7YLRiSOfxyGg+yLy7RSK0Q==
Date: Mon, 28 Jul 2025 13:12:26 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/3] fpga: Remove ancient ACEX1K support
Message-ID: <20250728-asparagus-cobweb-1301489095eb@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1753686468.git.michal.simek@amd.com>
 <20fe425910b6266a2bf0555bda67f60c1dd3aa61.1753686468.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20fe425910b6266a2bf0555bda67f60c1dd3aa61.1753686468.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Mon, Jul 28, 2025 at 09:07:53AM +0200 schrieb Michal Simek:
> Coverity (CID 583149) reports issue on code which is not enabled by any
> real platform that's why remove it completely.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Alexander Dahl <ada@thorsis.com>

> ---
> 
> Changes in v2:
> - Get EP2/EP3/EP4 sizes back even they are not used by any code today

Thanks. :-)

Greets
Alex

> 
>  configs/sandbox_defconfig |   1 -
>  drivers/fpga/ACEX1K.c     | 245 --------------------------------------
>  drivers/fpga/Kconfig      |   6 -
>  drivers/fpga/Makefile     |   1 -
>  drivers/fpga/altera.c     |   5 +-
>  include/ACEX1K.h          |  32 -----
>  6 files changed, 1 insertion(+), 289 deletions(-)
>  delete mode 100644 drivers/fpga/ACEX1K.c
> 
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 0c030f4a7925..96546cc0bcfe 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -206,7 +206,6 @@ CONFIG_ARM_FFA_TRANSPORT=y
>  CONFIG_FPGA_ALTERA=y
>  CONFIG_FPGA_STRATIX_II=y
>  CONFIG_FPGA_STRATIX_V=y
> -CONFIG_FPGA_ACEX1K=y
>  CONFIG_FPGA_CYCLON2=y
>  CONFIG_FPGA_LATTICE=y
>  CONFIG_FPGA_XILINX=y
> diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
> deleted file mode 100644
> index e1514fc56d04..000000000000
> --- a/drivers/fpga/ACEX1K.c
> +++ /dev/null
> @@ -1,245 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * (C) Copyright 2003
> - * Steven Scholz, imc Measurement & Control, steven.scholz@imc-berlin.de
> - *
> - * (C) Copyright 2002
> - * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
> - */
> -
> -#define LOG_CATEGORY UCLASS_FPGA
> -
> -#include <config.h>		/* core U-Boot definitions */
> -#include <console.h>
> -#include <log.h>
> -#include <ACEX1K.h>		/* ACEX device family */
> -#include <linux/delay.h>
> -#include <time.h>
> -
> -/* Note: The assumption is that we cannot possibly run fast enough to
> - * overrun the device (the Slave Parallel mode can free run at 50MHz).
> - * If there is a need to operate slower, define CFG_FPGA_DELAY in
> - * the board config file to slow things down.
> - */
> -#ifndef CFG_FPGA_DELAY
> -#define CFG_FPGA_DELAY()
> -#endif
> -
> -#ifndef CFG_SYS_FPGA_WAIT
> -#define CFG_SYS_FPGA_WAIT CONFIG_SYS_HZ/10		/* 100 ms */
> -#endif
> -
> -static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize);
> -static int ACEX1K_ps_dump(Altera_desc *desc, const void *buf, size_t bsize);
> -/* static int ACEX1K_ps_info(Altera_desc *desc); */
> -
> -/* ------------------------------------------------------------------------- */
> -/* ACEX1K Generic Implementation */
> -int ACEX1K_load(Altera_desc *desc, const void *buf, size_t bsize)
> -{
> -	int ret_val = FPGA_FAIL;
> -
> -	switch (desc->iface) {
> -	case passive_serial:
> -		log_debug("Launching Passive Serial Loader\n");
> -		ret_val = ACEX1K_ps_load (desc, buf, bsize);
> -		break;
> -
> -		/* Add new interface types here */
> -
> -	default:
> -		printf ("%s: Unsupported interface type, %d\n",
> -				__FUNCTION__, desc->iface);
> -	}
> -
> -	return ret_val;
> -}
> -
> -int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize)
> -{
> -	int ret_val = FPGA_FAIL;
> -
> -	switch (desc->iface) {
> -	case passive_serial:
> -		log_debug("Launching Passive Serial Dump\n");
> -		ret_val = ACEX1K_ps_dump (desc, buf, bsize);
> -		break;
> -
> -		/* Add new interface types here */
> -
> -	default:
> -		printf ("%s: Unsupported interface type, %d\n",
> -				__FUNCTION__, desc->iface);
> -	}
> -
> -	return ret_val;
> -}
> -
> -int ACEX1K_info( Altera_desc *desc )
> -{
> -	return FPGA_SUCCESS;
> -}
> -
> -/* ------------------------------------------------------------------------- */
> -/* ACEX1K Passive Serial Generic Implementation                                  */
> -
> -static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize)
> -{
> -	int ret_val = FPGA_FAIL;	/* assume the worst */
> -	Altera_ACEX1K_Passive_Serial_fns *fn = desc->iface_fns;
> -	int i;
> -
> -	log_debug("start with interface functions @ 0x%p\n", fn);
> -
> -	if (fn) {
> -		size_t bytecount = 0;
> -		unsigned char *data = (unsigned char *) buf;
> -		int cookie = desc->cookie;	/* make a local copy */
> -		unsigned long ts;		/* timestamp */
> -
> -		log_debug("Function Table:\n"
> -			  "ptr:\t0x%p\n"
> -			  "struct: 0x%p\n"
> -			  "config:\t0x%p\n"
> -			  "status:\t0x%p\n"
> -			  "clk:\t0x%p\n"
> -			  "data:\t0x%p\n"
> -			  "done:\t0x%p\n\n",
> -			  &fn, fn, fn->config, fn->status,
> -			  fn->clk, fn->data, fn->done);
> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -		printf ("Loading FPGA Device %d...", cookie);
> -#endif
> -
> -		/*
> -		 * Run the pre configuration function if there is one.
> -		 */
> -		if (*fn->pre) {
> -			(*fn->pre) (cookie);
> -		}
> -
> -		/* Establish the initial state */
> -		(*fn->config) (true, true, cookie);	/* Assert nCONFIG */
> -
> -		udelay(2);		/* T_cfg > 2us	*/
> -
> -		/* nSTATUS should be asserted now */
> -		(*fn->done) (cookie);
> -		if ( !(*fn->status) (cookie) ) {
> -			puts ("** nSTATUS is not asserted.\n");
> -			(*fn->abort) (cookie);
> -			return FPGA_FAIL;
> -		}
> -
> -		(*fn->config) (false, true, cookie);	/* Deassert nCONFIG */
> -		udelay(2);		/* T_cf2st1 < 4us	*/
> -
> -		/* Wait for nSTATUS to be released (i.e. deasserted) */
> -		ts = get_timer (0);		/* get current time */
> -		do {
> -			CFG_FPGA_DELAY ();
> -			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
> -				puts ("** Timeout waiting for STATUS to go high.\n");
> -				(*fn->abort) (cookie);
> -				return FPGA_FAIL;
> -			}
> -			(*fn->done) (cookie);
> -		} while ((*fn->status) (cookie));
> -
> -		/* Get ready for the burn */
> -		CFG_FPGA_DELAY ();
> -
> -		/* Load the data */
> -		while (bytecount < bsize) {
> -			unsigned char val=0;
> -#ifdef CONFIG_SYS_FPGA_CHECK_CTRLC
> -			if (ctrlc ()) {
> -				(*fn->abort) (cookie);
> -				return FPGA_FAIL;
> -			}
> -#endif
> -			/* Altera detects an error if INIT goes low (active)
> -			   while DONE is low (inactive) */
> -#if 0 /* not yet implemented */
> -			if ((*fn->done) (cookie) == 0 && (*fn->init) (cookie)) {
> -				puts ("** CRC error during FPGA load.\n");
> -				(*fn->abort) (cookie);
> -				return (FPGA_FAIL);
> -			}
> -#endif
> -			val = data [bytecount ++ ];
> -			i = 8;
> -			do {
> -				/* Deassert the clock */
> -				(*fn->clk) (false, true, cookie);
> -				CFG_FPGA_DELAY ();
> -				/* Write data */
> -				(*fn->data) ((val & 0x01), true, cookie);
> -				CFG_FPGA_DELAY ();
> -				/* Assert the clock */
> -				(*fn->clk) (true, true, cookie);
> -				CFG_FPGA_DELAY ();
> -				val >>= 1;
> -				i --;
> -			} while (i > 0);
> -
> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -			if (bytecount % (bsize / 40) == 0)
> -				putc ('.');		/* let them know we are alive */
> -#endif
> -		}
> -
> -		CFG_FPGA_DELAY ();
> -
> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -		putc (' ');			/* terminate the dotted line */
> -#endif
> -
> -	/*
> -	 * Checking FPGA's CONF_DONE signal - correctly booted ?
> -	 */
> -
> -	if ( ! (*fn->done) (cookie) ) {
> -		puts ("** Booting failed! CONF_DONE is still deasserted.\n");
> -		(*fn->abort) (cookie);
> -		return (FPGA_FAIL);
> -	}
> -
> -	/*
> -	 * "DCLK must be clocked an additional 10 times fpr ACEX 1K..."
> -	 */
> -
> -	for (i = 0; i < 12; i++) {
> -		CFG_FPGA_DELAY ();
> -		(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
> -		CFG_FPGA_DELAY ();
> -		(*fn->clk) (false, true, cookie);	/* Deassert the clock pin */
> -	}
> -
> -	ret_val = FPGA_SUCCESS;
> -
> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
> -		if (ret_val == FPGA_SUCCESS) {
> -			puts ("Done.\n");
> -		}
> -		else {
> -			puts ("Fail.\n");
> -		}
> -#endif
> -	(*fn->post) (cookie);
> -
> -	} else {
> -		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
> -	}
> -
> -	return ret_val;
> -}
> -
> -static int ACEX1K_ps_dump(Altera_desc *desc, const void *buf, size_t bsize)
> -{
> -	/* Readback is only available through the Slave Parallel and         */
> -	/* boundary-scan interfaces.                                         */
> -	printf ("%s: Passive Serial Dumping is unavailable\n",
> -			__FUNCTION__);
> -	return FPGA_FAIL;
> -}
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 9456ca3149ae..18e7d7c99a9a 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -34,12 +34,6 @@ config FPGA_STRATIX_V
>  	help
>  	  Say Y here to enable the Altera Stratix V FPGA specific driver.
>  
> -config FPGA_ACEX1K
> -	bool "Enable Altera ACEX 1K driver"
> -	depends on FPGA_ALTERA
> -	help
> -	  Say Y here to enable the Altera ACEX 1K FPGA specific driver.
> -
>  config FPGA_CYCLON2
>  	bool "Enable Altera FPGA driver for Cyclone II"
>  	depends on FPGA_ALTERA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 610c168fc35c..6c779d5b5df6 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -17,7 +17,6 @@ obj-$(CONFIG_FPGA_XILINX) += xilinx.o
>  obj-$(CONFIG_FPGA_LATTICE) += ivm_core.o lattice.o
>  ifdef CONFIG_FPGA_ALTERA
>  obj-y += altera.o
> -obj-$(CONFIG_FPGA_ACEX1K) += ACEX1K.o
>  obj-$(CONFIG_FPGA_CYCLON2) += cyclon2.o
>  obj-$(CONFIG_FPGA_INTEL_SDM_MAILBOX) += intel_sdm_mb.o
>  obj-$(CONFIG_FPGA_STRATIX_II) += stratixII.o
> diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
> index 64fda3a307c7..4a9aa74357ec 100644
> --- a/drivers/fpga/altera.c
> +++ b/drivers/fpga/altera.c
> @@ -28,10 +28,7 @@ static const struct altera_fpga {
>  	int			(*dump)(Altera_desc *, const void *, size_t);
>  	int			(*info)(Altera_desc *);
>  } altera_fpga[] = {
> -#if defined(CONFIG_FPGA_ACEX1K)
> -	{ Altera_ACEX1K, "ACEX1K", ACEX1K_load, ACEX1K_dump, ACEX1K_info },
> -	{ Altera_CYC2,   "ACEX1K", ACEX1K_load, ACEX1K_dump, ACEX1K_info },
> -#elif defined(CONFIG_FPGA_CYCLON2)
> +#if defined(CONFIG_FPGA_CYCLON2)
>  	{ Altera_ACEX1K, "CycloneII", CYC2_load, CYC2_dump, CYC2_info },
>  	{ Altera_CYC2,   "CycloneII", CYC2_load, CYC2_dump, CYC2_info },
>  #endif
> diff --git a/include/ACEX1K.h b/include/ACEX1K.h
> index 7c5253c66cca..4d24545df2cb 100644
> --- a/include/ACEX1K.h
> +++ b/include/ACEX1K.h
> @@ -12,26 +12,10 @@
>  
>  #include <altera.h>
>  
> -extern int ACEX1K_load(Altera_desc *desc, const void *image, size_t size);
> -extern int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize);
> -extern int ACEX1K_info(Altera_desc *desc);
> -
>  extern int CYC2_load(Altera_desc *desc, const void *image, size_t size);
>  extern int CYC2_dump(Altera_desc *desc, const void *buf, size_t bsize);
>  extern int CYC2_info(Altera_desc *desc);
>  
> -/* Slave Serial Implementation function table */
> -typedef struct {
> -	Altera_pre_fn		pre;
> -	Altera_config_fn	config;
> -	Altera_clk_fn		clk;
> -	Altera_status_fn	status;
> -	Altera_done_fn		done;
> -	Altera_data_fn		data;
> -	Altera_abort_fn		abort;
> -	Altera_post_fn		post;
> -} Altera_ACEX1K_Passive_Serial_fns;
> -
>  /* Slave Serial Implementation function table */
>  typedef struct {
>  	Altera_pre_fn		pre;
> @@ -45,16 +29,6 @@ typedef struct {
>  
>  /* Device Image Sizes
>   *********************************************************************/
> -/* ACEX1K */
> -/* FIXME: Which size do we mean?
> - * Datasheet says 1337000/8=167125Bytes,
> - * Filesize of an *.rbf file is 166965 Bytes
> - */
> -#if 0
> -#define Altera_EP1K100_SIZE	1337000/8	/* 167125 Bytes */
> -#endif
> -#define Altera_EP1K100_SIZE	(166965*8)
> -
>  #define Altera_EP2C8_SIZE	247942
>  #define Altera_EP2C20_SIZE	586562
>  #define Altera_EP2C35_SIZE	883905
> @@ -70,10 +44,4 @@ typedef struct {
>  #define ALTERA_EP4CE75_SIZE	2495719		/* 19965752 Bits */
>  #define ALTERA_EP4CE115_SIZE	3571462		/* 28571696 Bits */
>  
> -/* Descriptor Macros
> - *********************************************************************/
> -/* ACEX1K devices */
> -#define Altera_EP1K100_DESC(iface, fn_table, cookie) \
> -{ Altera_ACEX1K, iface, Altera_EP1K100_SIZE, fn_table, cookie }
> -
>  #endif /* _ACEX1K_H_ */
> -- 
> 2.43.0
> 
