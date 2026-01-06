Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF17ECEFD01
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1458983F01;
	Tue,  6 Jan 2026 21:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="gg0UVwNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B53783FEE; Tue,  6 Jan 2026 21:39:55 +0100 (CET)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AB883D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <0d0bd91a-506d-4bc9-ae84-364cb98b2b71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767731992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwHTBKks4XdNImd8oy5itddfEyZA+dIviiWx1xiGJXQ=;
 b=gg0UVwNmS1c/uJmT/+5lc5DUQ8OIPos57ACZpct8E0ddruo+N9FyzWFMVR57JsHvrbI71o
 /pmyW/4VXEq/UO2s71LHFFT8XLMhI9nKaRwlTC/dpuUOUMBc8zU967xAEju7eJG2TwzqrK
 8g8Jy0j1OX85DEX1eYvQgf9cMmybOSc=
Date: Tue, 6 Jan 2026 15:39:48 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/Makefile.autoconf: use abs_srctree for
 out-of-tree symlink
To: David Lechner <dlechner@baylibre.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260105-mtk-fix-build-after-kconfig-change-v1-1-7185a081f7c0@baylibre.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20260105-mtk-fix-build-after-kconfig-change-v1-1-7185a081f7c0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 1/5/26 15:35, David Lechner wrote:
> Replace usage of $(srctree) with $(abs_srctree) when creating a symlink
> to include/asm/arch in out of tree builds.
> 
> When building_out_of_srctree is true, $(srctree) is just "..", so the
> created symlink was broken, for example:
> 
>     build-mt8365_evk/include/asm/arch -> ../arch/arm/include/asm/arch-mediatek
> 
> Which would resolve to a non-existent path:
> 
>     build-mt8365_evk/include/asm/arch/arm/include/asm/arch-mediatek
> 
> To fix, we need to use the absolute path to the source tree since we
> don't know where the build tree is located relative to the source tree.
> 
> Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  scripts/Makefile.autoconf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> index e3c88badb52..47c49a018bf 100644
> --- a/scripts/Makefile.autoconf
> +++ b/scripts/Makefile.autoconf
> @@ -138,7 +138,7 @@ ifdef building_out_of_srctree
>  	else									\
>  		dest=arch/$(ARCH)/include/asm/arch-$(if $(SOC),$(SOC),$(CPU));	\
>  	fi;									\
> -	ln -fsn $(srctree)/$$dest include/asm/arch
> +	ln -fsn $(abs_srctree)/$$dest include/asm/arch
>  else
>  	$(Q)if [ -d arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
>  		dest=../../mach-$(SOC)/include/mach;			\
> 
> ---
> base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
> change-id: 20260105-mtk-fix-build-after-kconfig-change-922538479a96
> 
> Best regards,

Tested-by: Sean Anderson <sean.anderson@linux.dev>
