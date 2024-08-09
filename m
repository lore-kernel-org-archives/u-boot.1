Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6A6C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 10:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D2388A2F;
	Fri,  9 Aug 2024 12:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jKd4eoyy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2AC88BB6; Fri,  9 Aug 2024 12:45:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CEA889F1
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 12:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723200313; x=1723805113; i=xypron.glpk@gmx.de;
 bh=CBRNF3Owarrii5wWAWS5f/e40OCtwvuaPPBWWojzjaI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jKd4eoyyy86OtwhDGgpVp01hwa5CP9XXKX1HsyjS/tPexcRgQcjc3fbr3U8W6k/Z
 w8LNdGnvjmuzrGzOMCQYBcOic1UfFFynFaoiTxYv51E09T21e7H/eI2sMlYZYMP7R
 OyN/bFEbqcMZG1C0KEopPKPetzVLnc9TZGFhIOhducWVAg3E4zdr9K3KAJgcOcho+
 NeDPHEB3y+C5amU1INmmQjK1zMNu/9pYrZTcKfvJdn1Y+hwxJhmCMgPmSfXGv6tBK
 XzmZHjU7NaltKelWOnnIyDaVcX8JDRxqebYfj/JmDs256ODsvOFpVyk+VuhaT7X47
 vaEQ9li4HTo0S30ItQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.170.249]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mw9Q6-1sJTK83c9M-00roG4; Fri, 09
 Aug 2024 12:45:13 +0200
Message-ID: <88cba98c-527c-49e0-b99a-eaaf071c302d@gmx.de>
Date: Fri, 9 Aug 2024 12:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ext4: Fix zalloc()
To: Richard Weinberger <richard@nod.at>
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com,
 marek.vasut+renesas@mailbox.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de
References: <20240809095430.3656-1-richard@nod.at>
 <20240809095430.3656-3-richard@nod.at>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240809095430.3656-3-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:94wYX5g48gOGLmBRUoZMAow1RKzBIvDCpw+yHxUEI4cc0mRKjji
 atx82AH7vaUZEMrtmAgjL8HEA8hxXfvj+cEkR7IiwTcjZvL7O7SOTV4BTLzmLaM9UhJmRVB
 3g6H+jVgx6k4lH8ICz42tUOBCs4SLRTAzXQJ6Epo1UvsaP07XerGC0fLKWmJfbei+jvT3u0
 T0V6vNBSiPHq7PBc0WJ2w==
UI-OutboundReport: notjunk:1;M01:P0:fglGP9ZhgZg=;fx9qDBzdk5g8TOkFXm8SQW5Wbwz
 +cq4DaLfR5YjUQH/y6mPfCKTUZyfN+fSTR6sCq1kmqDNEmziGhsLD+wktWFhmupaZSEuRomUg
 GdpT2Jj+khWPE/NVsJw6hFCckKuJwKY/Rh17vn0jR13FTWBUnnwMu4oj75Pnigq+ArJEYDtNu
 yVPH8sAbtbcPaTKWa8e2oa5yYQ2NoOuS0PakhsvRBWGciZoFOXWDt4uy3PUL/NVwoyIoqME6X
 LNd4jR9+aZoogGrCbmC/NTtYMHBe3YGnDwhj0nWWkxPY7kzQdSUF4FsZifKKwr2+6Gv7fuwAt
 suYBn7cI3580e2JlNDvBv7E54kWOmov2wAp4T2i02bJfQ6W/4mGDHLsNGU+Uq8UWfSBBdFGAi
 ssoAw6tkB/ooV8YQydamzj8Cqwvi+7nmCyERja0Rw/C3Fzrc6X8yYmQvKR1xcqn8JP9XOZ0n0
 j8nK3O4QsofAMcp+Qt0V70xZ6yz77Aa7crACfdr+yn3ucbQ/+4W9Wh3f850/oFxWWbBL7GX4l
 6Y6/ZeCLDj4MoMK0yrgp7z+M2LeAYpSPxccbSgiBoqD5vHIVsbR0gDt7VVVBM05mLcJXoXYSp
 KlfpbqZsXAlzakl8KZf2BJayrhsa0CP90mxrAxWdOGO5CQvfFi5ym/pGFDvXms0P/h9MhnzG6
 v+P4OpPcV13buc7kO/e9PqS1MHJRiv/4qKq+QQwgo6Gs/KrIVGj38vB2e7YIGVBlk2spUbcYh
 XH/tUZuyRAarcEYyaRRIY5egU8KUkoqEs/rB+Y4dddp8Y6RRnVXBnv8f6aEDePh0fGCJtFW1w
 OZIlqC4EkaL3aXPggLEKlJZA==
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

On 8/9/24 11:54, Richard Weinberger wrote:
> Currently, zalloc() calls uncondtionally memset(),
> if the allocation failes, memset() will write to a null pointer.
>
> Fix by using kzalloc().
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   fs/ext4/ext4_common.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
> index 84500e990a..346752092b 100644
> --- a/fs/ext4/ext4_common.h
> +++ b/fs/ext4/ext4_common.h
> @@ -24,6 +24,7 @@
>   #include <ext4fs.h>
>   #include <malloc.h>
>   #include <asm/cache.h>
> +#include <linux/compat.h>
>   #include <linux/errno.h>
>   #if defined(CONFIG_EXT4_WRITE)
>   #include "ext4_journal.h"
> @@ -43,9 +44,7 @@
>
>   static inline void *zalloc(size_t size)
>   {
> -	void *p =3D memalign(ARCH_DMA_MINALIGN, size);
> -	memset(p, 0, size);
> -	return p;
> +	return kzalloc(size, 0);
>   }
>
>   int ext4fs_read_inode(struct ext2_data *data, int ino,

