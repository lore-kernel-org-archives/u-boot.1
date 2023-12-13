Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57669C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 15:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4C387633;
	Wed, 13 Dec 2023 16:38:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="aZY9JN1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C41874FB; Wed, 13 Dec 2023 16:38:21 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F11387633
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 16:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Wed, 13 Dec 2023 16:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702481896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=euu2zaNDziFFDMS9KGfE3Y0+ma3WEsvs+wEO8T/oDvg=;
 b=aZY9JN1r9Wy1TfhhXSCSIicROD2J0W+rvdKLTBo32RuVdd8DIbqJX6ji5LNT1wHD6R8jPV
 1oHc3Vg6v6tuqLtkbcNWe/oD4+ZFZvRb3R/lW5p0vOmjrovDtzIvO+ZWkDpma3O7dVNLTX
 gTcegO6TBESphs+zNt4UEqMMe95iGAJeEMjb1iVGGq/DOnu6X4WGOOabG6xR/5ku9WqW2A
 B5CQ2Tz36JOHwPlAgSGcwiccBTrQQkriyVZuwTEEiRunZAzUALGK0pov/Z9PpKQ27hHctG
 pw14UMoDUJiI5fxkK6G/gdjmA3mnmHbytcssz/4iHt9s0NJ1wsqjAUnA8U63yg==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Stefan Eichenberger <eichest@gmail.com>,
 Steven Lawrance <steven.lawrance@softathome.com>,
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Subject: Re: [PATCH v1 2/2] tools: fix build without LIBCRYPTO support
Message-ID: <13471813.uLZWGnKmhe@ada-pc>
Mail-Followup-To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Mamta Shukla <mamta.shukla@leica-geosystems.com>,
 Mark Kettenis <kettenis@openbsd.org>,
 Mikhail Ilin <ilin.mikhail.ol@gmail.com>,
 Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Stefan Eichenberger <eichest@gmail.com>,
 Steven Lawrance <steven.lawrance@softathome.com>,
 Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
References: <20230121154743.667253-1-paulerwan.rio@gmail.com>
 <20230121154743.667253-3-paulerwan.rio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121154743.667253-3-paulerwan.rio@gmail.com>
X-KMail-Identity: 600738659
X-KMail-Transport: 2015100914
X-KMail-Link-Message: 46901
X-KMail-Link-Type: reply
X-KMail-Identity-Name: Alexander Dahl (thorsis, en)
X-KMail-Transport-Name: thorsis.com
X-Clacks-Overhead: GNU Terry Pratchett
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

Am Samstag, 21. Januar 2023, 16:47:42 CET schrieb Paul-Erwan Rio:
> Commit <cb9faa6f98ae56d70d59505dad290dd3d381cb7b> introduced a
> target-independent configuration to build crypto features in host tools.
> 
> But since commit <2c21256b27d70b5950bd059330cdab027fb6ab7e>, the build
> without OpenSSL is broken, due to FIT signature/encryption features. Add
> missing conditional compilation tokens to fix this.
> 
> Signed-off-by: Paul-Erwan Rio <paulerwan.rio@gmail.com>

I applied your patch to my v2023.10 based tree and it fails to build
(just using one board as example here, it is not the only one
failing).

    % buildman -o ~/build/u-boot/buildman -Pr -a '~CONFIG_TOOLS_LIBCRYPTO' sama5d27_som1_ek_mmc
    Building current source for 2 boards (2 threads, 8 jobs per thread)
           arm:  +   sama5d27_som1_ek_mmc1      
    +tools/image-host.c:17:10: fatal error: openssl/pem.h: Datei oder Verzeichnis nicht gefunden
    +   17 | #include <openssl/pem.h>
    +      |          ^~~~~~~~~~~~~~~
    +compilation terminated.
    +make[2]: *** [scripts/Makefile.host:112: tools/image-host.o] Fehler 1
    +make[1]: *** [Makefile:1857: tools] Fehler 2
    +make: *** [Makefile:177: sub-make] Error 2
           arm:  +   sama5d27_som1_ek_mmc                  
    +tools/image-host.c:17:10: fatal error: openssl/pem.h: Datei oder Verzeichnis nicht gefunden
    +   17 | #include <openssl/pem.h>
    +      |          ^~~~~~~~~~~~~~~
    +compilation terminated.
    +make[2]: *** [scripts/Makefile.host:112: tools/image-host.o] Fehler 1
    +make[1]: *** [Makefile:1857: tools] Fehler 2
    +make: *** [Makefile:177: sub-make] Error 2
        0    0    2 /2              sama5d27_som1_ek_mmc
    Completed: 2 total built, 2 newly), duration 0:00:01, rate 2.00

Same if I apply the whole series to master (this time with english
locale):

    % buildman -o ~/build/u-boot/buildman -Pr -a '~CONFIG_TOOLS_LIBCRYPTO' sama5d27_som1_ek_mmc
    Building current source for 2 boards (2 threads, 8 jobs per thread)
           arm:  +   sama5d27_som1_ek_mmc       
    +tools/image-host.c:17:10: fatal error: openssl/pem.h: No such file or directory
    +   17 | #include <openssl/pem.h>
    +      |          ^~~~~~~~~~~~~~~
    +compilation terminated.
    +make[2]: *** [scripts/Makefile.host:112: tools/image-host.o] Error 1
    +make[1]: *** [Makefile:1858: tools] Error 2
    +make: *** [Makefile:177: sub-make] Error 2
           arm:  +   sama5d27_som1_ek_mmc1                
    +tools/image-host.c:17:10: fatal error: openssl/pem.h: No such file or directory
    +   17 | #include <openssl/pem.h>
    +      |          ^~~~~~~~~~~~~~~
    +compilation terminated.
    +make[2]: *** [scripts/Makefile.host:112: tools/image-host.o] Error 1
    +make[1]: *** [Makefile:1858: tools] Error 2
    +make: *** [Makefile:177: sub-make] Error 2
        0    0    2 /2              sama5d27_som1_ek_mmc1
    Completed: 2 total built, 2 newly), duration 0:00:01, rate 2.00

Did you have time to look into this again?  Or maybe did you sent an
updated series I overlooked?

Greets
Alex

> ---
> 
>  include/image.h    | 2 +-
>  tools/Kconfig      | 1 +
>  tools/fit_image.c  | 2 +-
>  tools/image-host.c | 2 ++
>  tools/mkimage.c    | 5 +++--
>  5 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/image.h b/include/image.h
> index 7717a4c13d..6a616d15fb 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1388,7 +1388,7 @@ int calculate_hash(const void *data, int data_len,
> const char *algo, * device
>   */
>  #if defined(USE_HOSTCC)
> -# if defined(CONFIG_FIT_SIGNATURE)
> +# if CONFIG_IS_ENABLED(FIT_SIGNATURE)
>  #  define IMAGE_ENABLE_SIGN	1
>  #  define FIT_IMAGE_ENABLE_VERIFY	1
>  #  include <openssl/evp.h>
> diff --git a/tools/Kconfig b/tools/Kconfig
> index 539708f277..cfad26302c 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -46,6 +46,7 @@ config TOOLS_FIT_RSASSA_PSS
>  	  Support the rsassa-pss signature scheme in the tools builds
> 
>  config TOOLS_FIT_SIGNATURE
> +	depends on TOOLS_LIBCRYPTO
>  	def_bool y
>  	help
>  	  Enable signature verification of FIT uImages in the tools builds
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 8a18b1b0ba..148dc5df40 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -61,7 +61,7 @@ static int fit_add_file_data(struct image_tool_params
> *params, size_t size_inc, ret = fit_set_timestamp(ptr, 0, time);
>  	}
> 
> -	if (!ret)
> +	if (CONFIG_IS_ENABLED(FIT_SIGNATURE) && !ret)
>  		ret = fit_pre_load_data(params->keydir, dest_blob, ptr);
> 
>  	if (!ret) {
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 4a24dee815..d09a03bd76 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -1119,6 +1119,7 @@ static int fit_config_add_verification_data(const char
> *keydir, return 0;
>  }
> 
> +#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
>  /*
>   * 0) open file (open)
>   * 1) read certificate (PEM_read_X509)
> @@ -1227,6 +1228,7 @@ int fit_pre_load_data(const char *keydir, void
> *keydest, void *fit) out:
>  	return ret;
>  }
> +#endif
> 
>  int fit_cipher_data(const char *keydir, void *keydest, void *fit,
>  		    const char *comment, int require_keys,
> diff --git a/tools/mkimage.c b/tools/mkimage.c
> index 8306861ce5..866410934e 100644
> --- a/tools/mkimage.c
> +++ b/tools/mkimage.c
> @@ -115,7 +115,7 @@ static void usage(const char *msg)
>  		"          -B => align size in hex for FIT structure and 
header\n"
>  		"          -b => append the device tree binary to the 
FIT\n"
>  		"          -t => update the timestamp in the FIT\n");
> -#ifdef CONFIG_FIT_SIGNATURE
> +#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
>  	fprintf(stderr,
>  		"Signing / verified boot options: [-k keydir] [-K dtb] [ 
-c <comment>]
> [-p addr] [-r] [-N engine]\n" "          -k => set directory containing
> private keys\n"
> @@ -130,8 +130,9 @@ static void usage(const char *msg)
>  		"          -o => algorithm to use for signing\n");
>  #else
>  	fprintf(stderr,
> -		"Signing / verified boot not supported 
(CONFIG_FIT_SIGNATURE
> undefined)\n"); +		"Signing / verified boot not supported
> (CONFIG_TOOLS_FIT_SIGNATURE undefined)\n"); #endif
> +
>  	fprintf(stderr, "       %s -V ==> print version information and 
exit\n",
>  		params.cmdname);
>  	fprintf(stderr, "Use '-T list' to see a list of available image 
types\n");

