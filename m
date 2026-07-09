Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B14C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 06:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E1884AA2;
	Thu,  9 Jul 2026 08:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LLujyATk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BADE84AA3; Thu,  9 Jul 2026 08:14:06 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5579584A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 08:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9E9EF1193E2; Thu,  9 Jul 2026 08:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783577643;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=6AXguDBiGw3s0e2XnqyVSwnUB4gL+cDfOp33ntC92/E=;
 b=LLujyATkBXgoA0r7qQQC3mrpSiiGNuEUvJciynoiiZ7Xh8v15dU76wf9iq/3H66SIaVqW+
 eB7iF04K3ki+xHiFPlVuxDjx1SE5uOUmYeEMMPzVD4LKilrgyu8j7E0oXUDBGoc+qnST2V
 +LHhSRISRG0Q//+EJbXq3H30YGvxl0yr0yZXWl06oFWxvz51pwrXazk2wyrOQ9fsJqrXs/
 o9khw+Jx12JtaITugtgsiODcoQr1RJC6rpDv3/OOZNUrkes2Y9cOc9ZTtzKJY7E/JBFF3Z
 aSvMTHs/ORODj7swIhm5XBFtLNtWoSkY8iDRqY4wgykKOdeuLOTPLzGlzOqeJQ==
Message-ID: <429e58bc-741a-59ac-bd42-6d96483b2010@nabladev.com>
Date: Thu, 9 Jul 2026 08:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: fix ubifs_finddir() result check
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Collingbourne <peter@pcc.me.uk>, Tom Rini <trini@konsulko.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260609110040.1.Id466ecfe12f609ef0b8a6296fbc5d866a6bdac9e@changeid>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260609110040.1.Id466ecfe12f609ef0b8a6296fbc5d866a6bdac9e@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Patrick,

On 09.06.26 11:00, Patrick Delaunay wrote:
> ubifs_finddir() can return a negative error code (-ENOMEM or
> PTR_ERR(dent)) and returns 1 when the name is found in the directory.
> Fix the result check accordingly.
> 
> This fixes file existence detection (for "test -e") when U-Boot uses
> UBIFS through ops ubifs_exists(). Since this function is also called
> before other file operations, commands such as "load" could be executed
> on a non-existing file without reporting an error.
> 
> Fixes: 0cab29ff467e ("fs: ubifs: Fix and rework error handling in ubifs_finddir")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>   fs/ubifs/ubifs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-ubi.git

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
