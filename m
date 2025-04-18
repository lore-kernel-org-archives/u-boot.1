Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68923C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED6882C8A;
	Fri, 18 Apr 2025 13:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HZthVCXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE2982CFD; Fri, 18 Apr 2025 13:25:03 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096B182C15
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B412C26051;
 Fri, 18 Apr 2025 13:25:00 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wNyIbVlXS_Hj; Fri, 18 Apr 2025 13:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744975500; bh=RFVpcYgdtnnuAsikahYj29RcTp1TYs2lIWnduMUg67I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HZthVCXvY53LNeqesceiULEQ0X4Fbv1Izbm4fSKEtKBXEI1374zYkeLa+rEq1ROSq
 Py6cIOdTPY9c7YXhE900xR/g75LZCAqhChM9q41MnCKz/rX0YXohzA0DPE8II61hmG
 OcwNIPmeuxFfP58dRsuECc1DE++bCTegG873ZJudP7JFH1sq+wvw1V7Ik9q5BVx+xe
 HEAyaOhqZ0co3m6AVvCnxZp/oFceKzRDLheuCopO2HcNNjzmxD+I/KnTveWg79ahVC
 7mwiZp0uZ+LVhU8mf8T5kRwVCBFsMkV8mmGcbWzZQw7KCvIwq27PDALX//QqK9lddo
 /rUB7pxElS/Wg==
Date: Fri, 18 Apr 2025 11:24:50 +0000
From: Yao Zi <ziyao@disroot.org>
To: ant.v.moryakov@gmail.com, u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: Re: [PATCH] tools: Fix handle leak in mmap_fdt function
Message-ID: <aAI2gj_PAi8zr9F-@pie.lan>
References: <20250418081526.11327-1-ant.v.moryakov@gmail.com>
 <20250418081526.11327-2-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418081526.11327-2-ant.v.moryakov@gmail.com>
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

On Fri, Apr 18, 2025 at 11:15:23AM +0300, ant.v.moryakov@gmail.com wrote:
> From: Maks Mishin <maks.mishinFZ@gmail.com>
> 
> The handle 'ptr' is created at fit_common.c:91 by calling 
> function 'mmap' and lost at fit_common.c:127: 
> Added call of free for `ptr` if ptr != MAP_FAILED.

First, why do you free() a mmapped memory chunk? This really sounds
unreasonable to me.

Second, you don't validate ptr before freeing it actually. It's possible
to branch to label "err" before ptr is initialized, thus you must guard
the free in case of garbage data in ptr (or just initialize ptr to NULL).

> Trigger was found by the Svace static analyzer.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tools/fit_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/fit_common.c b/tools/fit_common.c
> index d1cde16c1c..135e105929 100644
> --- a/tools/fit_common.c
> +++ b/tools/fit_common.c
> @@ -123,6 +123,7 @@ err:
>  		close(fd);
>  	if (delete_on_error)
>  		unlink(fname);
> +	free(ptr);
>  
>  	return -1;
>  }
> -- 
> 2.34.1

Thanks,
Yao Zi
