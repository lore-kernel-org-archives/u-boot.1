Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3CDC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F260B82C03;
	Wed, 11 Jun 2025 14:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="b84P9/C3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C490C82C4D; Wed, 11 Jun 2025 14:13:43 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CDBE82B63
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 4607a68f-46be-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 4607a68f-46be-11f0-beb8-005056992ed3;
 Wed, 11 Jun 2025 14:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=JNNWksvpup28uE6IEBYe6/G88BG61POTrbIKLy2t1es=;
 b=b84P9/C3o7C41yo8Iu2oUnmd60QW/lsFGFPbKRnZ7PEUTD5SWbU92829ryMrfOz/tGmbsaDMV5e7e
 x8rBRKVVmwdPJ521E5cEgqQbU+xwhWF0qVgUZYXbmpod5emhBNE/zzo/Lmip0sVcqsPrXNIVF2gNX0
 gYuM+yOTpsW3lQMfK9nn+UIymLjIUfZ7+gPZ2s9oV7Krua+SivdMaC2PD+cnU3jyxHdFlr5ZitbXZE
 CtnvJ0Ezz9pAldPpeI8+mXBVrQUkOjgRNCV3OSAnzn5QXY/mT3JTP3suZ75Fr5jtmt/TggbtqGj+qy
 B+PAdhKCBTMrxNExugGDung346TlbZw==
X-KPN-MID: 33|P6bSVfnigBSpTrWZzWaQuwVlZSEhEBKQPkFBBH6ylLlvsiBE6Hj7gYfZfjNXuYJ
 SfDcDJNx54c0D5fkJUqSsJ7lzJgfk+lvo+C+QcgH2xrg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|2iM83+J6ZN3iwyKwvkRLgvw7v4pYRJxGMzculAYElDNZQk2LlwQnKkgcweSKAz1
 GSdtGyOQn3Mf3z8xhQW5AbQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 82aaa0ac-46bd-11f0-9a2d-00505699772e;
 Wed, 11 Jun 2025 14:13:40 +0200 (CEST)
Date: Wed, 11 Jun 2025 14:13:40 +0200
Message-Id: <8734c679xn.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: trini@konsulko.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, casey.connolly@linaro.org
In-Reply-To: <20250610-b4-fdtfile-from-dt-v1-1-aec4df0fa53e@linaro.org>
 (message from Casey Connolly on Tue, 10 Jun 2025 18:23:33 +0200)
Subject: Re: [PATCH 1/3] dts/upstream: write fdtfile path to /chosen/fdtfile
References: <20250610-b4-fdtfile-from-dt-v1-0-aec4df0fa53e@linaro.org>
 <20250610-b4-fdtfile-from-dt-v1-1-aec4df0fa53e@linaro.org>
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

> From: Casey Connolly <casey.connolly@linaro.org>
> Date: Tue, 10 Jun 2025 18:23:33 +0200

Hi Casey,

> Since we're using the upstream file structure, we know at build time
> the path to each DTB that we build. These same paths are used relative
> to some (maybe version specific) dtb directory on the boot partition
> or ESP.
> 
> By recording this path at build time and embedding it into the
> devicetree, we can set the fdtfile environment variable with 100%
> certainty that it is correct.
> 
> Devicetree file names are already treated as stable kernel API upstream,
> since they are used by OS loaders extensively.

But when something similar was suggested some time ago, the Linux
kernel folks explicitly stated that the file names are ~*not*
considered to be ABI.

So I think this proposal should be discussed in a broader context,
probably on the devicetree-spec@vger.kernel.org mailing list.

> Embedding the path into the devicetree itself just simplifies the
> process and allows U-Boot or the OS loader to select a devicetree of a
> different version for the specific board that U-Boot is running on.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  scripts/Makefile.lib | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index e89a4a51b74ddccfd9f0a6463cdeded12eaa5235..1f95bda0597c14d2ee785eb8058d607a6c819a56 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -360,16 +360,31 @@ $(obj)/%.dtbo.S: $(obj)/%.dtbo
>  ifeq ($(CONFIG_OF_LIBFDT_OVERLAY),y)
>  DTC_FLAGS += -@
>  endif
>  
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := dts/upstream/src/arm64
> +else
> +dt_dir := dts/upstream/src/$(ARCH)
> +endif
> +
> +ifeq ($(CONFIG_OF_UPSTREAM),y)
> +# Embed the upstream path to the DTB into it as /chosen/fdtfile. This property is used
> +# at runtime to set the fdtfile variable
> +dt_extra_snippet = / { chosen { fdtfile = "$(subst $(dt_dir)/,,$@)"; }; };
> +else
> +dt_extra_snippet =
> +endif
> +
>  quiet_cmd_dtc = DTC     $@
>  # Modified for U-Boot
>  # Bring in any U-Boot-specific include at the end of the file
>  # And finally any custom .dtsi fragments specified with CONFIG_DEVICE_TREE_INCLUDES
>  cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>  	(cat $< > $(pre-tmp)); \
>  	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
>  	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
> +	[[ -z "$(dt_extra_snippet)" ]] || echo '$(dt_extra_snippet)' >> $(pre-tmp); \
>  	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
>  	$(DTC) -O dtb -o $@ -b 0 \
>  		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
>  		-d $(depfile).dtc.tmp $(dtc-tmp) || \
> 
> -- 
> 2.49.0
> 
> 
