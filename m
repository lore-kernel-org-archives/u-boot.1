Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84B7C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2870283726;
	Wed,  9 Apr 2025 14:36:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rskyy4BI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2993E8373B; Wed,  9 Apr 2025 14:36:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E23FE836EE
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 74F1A43961;
 Wed,  9 Apr 2025 12:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7D7C4CEE7;
 Wed,  9 Apr 2025 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744202198;
 bh=jbDSq8rQ5HGJvplaNfUl4+7XvNJ2fC4J+P/z9Xzjs9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rskyy4BIVtVecbUlVlJQwBROvshMjKpO0DGLZdE+waUdvXZV1MhoTU5iRkdSRz0QT
 TdflGJ9RN9NYabkcH/Wgd+p0qx1BNXK0N9o94jU5jfEUfMrjmvHlwSKZYxndfmkcTB
 sRXBa/J74TP1Lu0qwZeFJzGKV5EsUzPa/744aIGdWRcE7d8Oj52cRBDD2kWOnNGwdP
 tH11i3ZpP9pHVxbwh89UfaZ6+2FRAE6mIn9e8N/ofv+Snd+6D/szkLjNctO5yD3nkv
 xTToOaED901qinVw8ilYQU/3yQIVKNbVo1jQEFWKpyOEr0RdnxTmgaB5/S049993GJ
 YgQMCg16vrzhw==
Date: Wed, 9 Apr 2025 18:06:33 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] qcom_defconfig: Disable MMC HS200 mode support
Message-ID: <Z_Zp0WHNFFBzi0y6@sumit-X1>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-3-sumit.garg@kernel.org>
 <510b1e90-bf1e-4a7b-8a86-c8fbaf485fb6@linaro.org>
 <Z_SmE-gQzzs5HJqi@sumit-X1>
 <179cca81-d835-4966-b992-361bc1d08d03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179cca81-d835-4966-b992-361bc1d08d03@linaro.org>
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

On Tue, Apr 08, 2025 at 02:13:55PM +0200, Caleb Connolly wrote:
> 
> 
> On 4/8/25 06:29, Sumit Garg wrote:
> > On Mon, Apr 07, 2025 at 04:30:44PM +0200, Caleb Connolly wrote:
> > > 
> > > 
> > > On 4/7/25 15:28, Sumit Garg wrote:
> > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > 
> > > > Currently the msm_sdhci doesn't yet support DLL configurations which are
> > > > required to enable bus speeds greater that 100MHz. So disable HS200 mode
> > > > support as of now as it requires bus speeds of 200MHz.
> > > > 
> > > > This should fix eMMC issues reported on RB1.
> > > 
> > > This fixes the write corruption issues? Nice find!!
> > 
> > Yeah, thanks.
> > 
> > > 
> > > Is this a problem on ALL Qualcomm platforms? the sdcard seems to work fine
> > > on other boards, would this reduce their performance?
> > 
> > Yes this problem should affect all Qualcomm platforms but it hasn't been
> > seen there as mostly SD cards available don't support HS200 mode. The SD
> > cards usually works in high speed mode whose performance remains
> > unaffected by this change. It only affects RB1/RB2 as eMMC flash on
> > these support HS200 mode but the U-Boot driver currently is incapable of
> > supporting that.
> 
> Ok awesome. Could you include this info in the commit message? Then

Sure, I can expand the commit message.

> 
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>

Thanks.

-Sumit
