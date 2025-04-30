Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65E0C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7C18215E;
	Wed, 30 Apr 2025 16:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uP/Wt1EZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142BF8215F; Wed, 30 Apr 2025 16:56:31 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A968210F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 20A87A4AD85;
 Wed, 30 Apr 2025 14:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488B2C4CEEB;
 Wed, 30 Apr 2025 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746024987;
 bh=QRzY6e53uVxzIEoPED15KOUBrmWCq4haAV0MqUZ+ExM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=uP/Wt1EZaj67wyiEobKR9eUDAwGpItwoWYxSyQd10orI2I259GLMN/DmcbYwlNYqx
 6UYbdQd3ZESmkMqOx16b4KvJKRr9NH044iXssJJxlfudL8epDct5R7hCf2STR5o3cQ
 QjLHEFw4tH+XJoj64a1oT8tWrP6ZCcpU0cz34nazygzsee2+JTWXcrVwT1bNB0500A
 Dc4dT6XQbW9b6EEosv8aVTyiPdkvZkze4q3UYUdj2UR4qjUgTVhF87oLsD68StP4fN
 8i1lmFjJBifpGH5cz1q+s1h+sFun2cQLuVTCI1doyeOmaMlOLbZUPDnmf8mucEcETM
 qyh6Xc/sZt+ng==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 mkorpershoek@kernel.org, Zone.Niuzh@hotmail.com
Subject: Re: [PATCH v2 1/1] bootm: improve error message when gzip
 decompression buffer is too small
In-Reply-To: <20250430022325.156922-1-aristo.chen@canonical.com>
References: <20250428060757.125596-1-aristo.chen@canonical.com>
 <20250430022325.156922-1-aristo.chen@canonical.com>
Date: Wed, 30 Apr 2025 16:56:25 +0200
Message-ID: <87r019r946.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Aristo,

Thank you for the patch.

On mer., avril 30, 2025 at 10:23, Aristo Chen <jj251510319013@gmail.com> wrote:

> Currently, when decompressing a gzip-compressed image during bootm, a
> generic error such as "inflate() returned -5" is shown when the buffer is
> too small. However, it is not immediately clear that this is caused by
> CONFIG_SYS_BOOTM_LEN being too small.
>
> This patch improves error handling by:
> - Detecting Z_BUF_ERROR (-5) returned from the inflate() call
> - Suggesting the user to increase CONFIG_SYS_BOOTM_LEN when applicable
> - Preserving the original return code from zunzip() instead of overwriting
>   it with -1
>
> By providing clearer hints when decompression fails due to insufficient
> buffer size, this change helps users diagnose and fix boot failures more
> easily.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/bootm.c | 4 +++-
>  lib/gunzip.c | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index f5cbb10f0d1..f6aa32746b7 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -34,6 +34,7 @@
>  
>  #include <bootm.h>
>  #include <image.h>
> +#include <u-boot/zlib.h>
>  
>  #define MAX_CMDLINE_SIZE	SZ_4K
>  
> @@ -578,7 +579,8 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
>  	if (ret == -ENOSYS)
>  		return BOOTM_ERR_UNIMPLEMENTED;
>  
> -	if (uncomp_size >= buf_size)
> +	if ((comp_type == IH_COMP_GZIP && ret == Z_BUF_ERROR) ||
> +	    uncomp_size >= buf_size)
>  		printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
>  	else
>  		printf("%s: uncompress error %d\n", name, ret);
> diff --git a/lib/gunzip.c b/lib/gunzip.c
> index 52007715bda..a05dcde9a75 100644
> --- a/lib/gunzip.c
> +++ b/lib/gunzip.c
> @@ -299,7 +299,7 @@ __rcode int zunzip(void *dst, int dstlen, unsigned char *src,
>  		if (stoponerr == 1 && r != Z_STREAM_END &&
>  		    (s.avail_in == 0 || s.avail_out == 0 || r != Z_BUF_ERROR)) {
>  			printf("Error: inflate() returned %d\n", r);
> -			err = -1;
> +			err = r;
>  			break;
>  		}
>  	} while (r == Z_BUF_ERROR);
> -- 
> 2.34.1
