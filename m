Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A46C5DF97
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 22:48:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC26281304;
	Fri, 21 Aug 2026 22:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DeS3lk0CiQv3; Fri, 21 Aug 2026 22:48:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787352536;
	bh=dHOoLek2jlE8CIjvFLAxJR1xaFgqb4sqf6AGJoVq+hI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HKNkJOKkCDQ9+Mq5IYoFKh0UoSngyQ69FQ/o9/gNkuOMXBnMhSt8xeY/4lFWFlH8B
	 qFs4ABikHUfWhF+3UuVUAkZkia5p0q5ZitTLx+RkapgCZtTao/MvyX/mwaWOXfshRe
	 3LjfHsPeG6qHyu3mCUP2HMCy9CwMQjbsD6I+kF40e1ojiGAw+6aRY4jbxlv3JU6j8t
	 OIixr41WitSBayWexf+QKgY0yDNNq+3LQ13+sOyKEg2IFSA43Rleb8x92Uvn1AKGLt
	 whSxfhhN1RVA/r4KBSeZsEBtafZM8spO4Kidzn5UajRJZtEoNBjJDMIPYuGjTf77gu
	 YOSNhS5U78e2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C426781305;
	Fri, 21 Aug 2026 22:48:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE2DE93F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 22:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB0BA40A17
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 22:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdCeSAkIyWin for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 22:48:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=662c=gp=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=jWQq5Fxa
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ADFFD409F6
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 22:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787352531;
 bh=dHOoLek2jlE8CIjvFLAxJR1xaFgqb4sqf6AGJoVq+hI=;
 b=jWQq5FxaQsO2PpmMauUkTcXWxo+UtNPfchSzY85hBneSu7FXAxOcLe63BJumJeEQQzzq/XIox
 u8npj9BZXgLCDMz1nf7cFSvxH7bQIImLpP4yeAgBAjTiUiObhlfQs3maZNpi+m3+dUiTONRNjyc
 +kiIkKjOVinfv/tZR21sAtsYH0cUYLmy5tg9x5fpKIHuyw4aUh0dCR/cMcHCYoRzqT7Ibxnp3Db
 WXvek5t6seuwy/xfkIc1yrFLtg6gnvFzVhKlGzUH7TdOCXtrfahjPzwM9Bcahoxyz2aOv7tk+5p
 lKHsseJWs8G0hkZtlyYybJQcKjy2Jl73vlOU2Gvc+62Q==
X-Forward-Email-ID: 6a88d5d040966528a4e704b4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <66a3267d-1980-4b86-be3a-791707373554@kwiboo.se>
Date: Sat, 22 Aug 2026 00:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/8] image-fit-sig: Optionally require signatures
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260813061009.26344-1-ludwig.nussel@siemens.com>
 <20260813080943.v8.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260813080943.v8.4.6d1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Ludwig,

On 8/13/2026 8:09 AM, Ludwig Nussel via U-Boot wrote:
> If U-Boot is built with signature verification but no keys are
> included in the device tree, the boot would still continue.
> Introduce FIT_SIGNATURE_REQUIRED to avoid a fail-open setup.
> Defaults to off so existing setups are not affected; boards wanting
> fail-closed behaviour must enable it explicitly.
> 
> Consistently use log_err for errors in fit_config_verify_required_keys()
> while at it
> 
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Series-Changes: 7
> - mention CONFIG_FIT_REQUIRE_CONFIG_SIGS in documentation
> 
> ---
> 
> (no changes since v4)
> 
> Changes in v4:
> - reword Kconfig help text
> - rename option to FIT_REQUIRE_CONFIG_SIGS
> - introduce SPL_FIT_REQUIRE_CONFIG_SIGS
> 
> Changes in v3:
> - clarify error message when no keys were found
> - change printfs to log_err
> - reword Kconfig
> - keep FIT_SIGNATURE_REQUIRED off by default
> 
> Changes in v2:
> - introduce FIT_SIGNATURE_REQUIRED
> 
>  boot/Kconfig                | 22 ++++++++++++++++++++++
>  boot/image-fit-sig.c        | 22 ++++++++++++++--------
>  doc/usage/fit/signature.rst | 13 ++++++++++---
>  3 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index ae6f09a6ede..c36a403063e 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -124,6 +124,23 @@ config FIT_SIGNATURE
>  	  format support in this case, enable it using
>  	  CONFIG_LEGACY_IMAGE_FORMAT.
>  
> +config FIT_REQUIRE_CONFIG_SIGS
> +	bool "Require configuration signature verification of FIT uImages"
> +	depends on FIT_SIGNATURE
> +	help
> +	  This option requires that FIT uImages have configuration
> +	  nodes that are signed or boot will fail.
> +	  That means the U-Boot device tree must contain a
> +	  "/signature" node and at least one public key with
> +	  required="conf".
> +	  All configuration sections of a FIT file must be signed
> +	  using those keys based on "required-mode" policy.
> +	  The option is useful to avoid fail-open situations so it
> +	  is recommended to enable. The option currently defaults to
> +	  off to avoid breaking existing setups. Keep it off if you
> +	  need to reuse the same u-boot binary in setups without
> +	  keys or rely on image node only signatures.
> +
>  config FIT_SIGNATURE_MAX_SIZE
>  	hex "Max size of signed FIT structures"
>  	depends on FIT_SIGNATURE
> @@ -224,6 +241,11 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
>  	  device memory. Assure this size does not extend past expected storage
>  	  space.
>  
> +config SPL_FIT_REQUIRE_CONFIG_SIGS
> +	bool "Require signature verification of FIT firmware within SPL"
> +	depends on SPL_FIT_SIGNATURE
> +	select FIT_REQUIRE_CONFIG_SIGS
> +
>  config SPL_LOAD_FIT
>  	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
>  	depends on SPL
> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> index 433df20281f..dc38a2413b0 100644
> --- a/boot/image-fit-sig.c
> +++ b/boot/image-fit-sig.c
> @@ -632,15 +632,16 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>  	 * name root but different @ suffix to be equal
>  	 */
>  	if (strchr(name, '@')) {
> -		printf("Configuration node '%s' contains '@'\n", name);
> +		log_err("Configuration node '%s' contains '@'\n", name);
>  		return -EPERM;
>  	}
>  
>  	/* Work out what we need to verify */
>  	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
>  	if (key_node < 0) {
> -		debug("%s: No signature node found: %s\n", __func__,
> -		      fdt_strerror(key_node));
> +		log_err("No signature node found: %s\n", fdt_strerror(key_node));

This change is causing a verbose error messages on Rockchip where the
FIT_SIGNATURE feature it used to check image integrity during boot. The
config nodes is not expected to contain any signature, only hash(es) of
images.

With this series I now get following output, with a verbose error
message related to FDT_ERR_NOTFOUND:

  U-Boot SPL 2026.10-rc2-00527-g4110a512ca17 (Aug 21 2026 - 22:33:02 +0000)
  Trying to boot from RAM
  ## Checking hash(es) for config config-1 ... No signature node found: FDT_ERR_NOTFOUND
  OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  ## Checking hash(es) for Image u-boot ... sha256+ OK
  ## Checking hash(es) for Image fdt-1 ... sha256+ OK
  ## Checking hash(es) for Image atf-2 ... sha256+ OK
  ## Checking hash(es) for Image atf-3 ... sha256+ OK
  ## Checking hash(es) for Image atf-4 ... sha256+ OK

Prior to this series the output never printed any error message:

  Trying to boot from RAM
  ## Checking hash(es) for config config-1 ... OK
  ## Checking hash(es) for Image atf-1 ... sha256+ OK
  [...]

Regards,
Jonas

> +		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))
> +			return -EPERM;
>  		return 0;
>  	}
>  
> @@ -674,8 +675,8 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>  					    noffset);
>  		if (ret) {
>  			if (reqd_policy_all) {
> -				printf("Failed to verify required signature '%s'\n",
> -				       fit_get_name(key_blob, noffset, NULL));
> +				log_err("Failed to verify required signature '%s'\n",
> +					fit_get_name(key_blob, noffset, NULL));
>  				return ret;
>  			}
>  		} else {
> @@ -685,9 +686,14 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
>  		}
>  	}
>  
> -	if (reqd_sigs && !verified) {
> -		printf("Failed to verify 'any' of the required signature(s)\n");
> -		return -EPERM;
> +	if (!verified) {
> +		if (reqd_sigs) {
> +			log_err("Failed to verify 'any' of the required signature(s)\n");
> +			return -EPERM;
> +		} else if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
> +			log_err("No suitable keys found for configuration verification\n");
> +			return -EPERM;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
> index da08cc75c3a..73153c97367 100644
> --- a/doc/usage/fit/signature.rst
> +++ b/doc/usage/fit/signature.rst
> @@ -420,11 +420,14 @@ below examples::
>  
>  Enabling FIT Verification
>  -------------------------
> -In addition to the options to enable FIT itself, the following CONFIGs must
> -be enabled:
> +In addition to the options to enable FIT itself, the following
> +settings configure signature verification support:
>  
>  CONFIG_FIT_SIGNATURE
> -    enable signing and verification in FITs
> +    required to enable signing and verification in FITs
> +
> +CONFIG_FIT_REQUIRE_CONFIG_SIGS
> +    make signature verification mandatory
>  
>  CONFIG_RSA
>      enable RSA algorithm for signing
> @@ -436,6 +439,10 @@ WARNING: When relying on signed FIT images with required signature check
>  the legacy image format is default disabled by not defining
>  CONFIG_LEGACY_IMAGE_FORMAT
>  
> +WARNING: CONFIG_FIT_REQUIRE_CONFIG_SIGS is not set by default for
> +backwards compatibility. It is recommended to be turned on whenever
> +configuration signatures are used to avoid fail-open behavior
> +
>  
>  Testing
>  -------

