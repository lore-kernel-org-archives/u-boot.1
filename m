Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B743C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D6E807FE;
	Fri, 24 Jan 2025 15:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730158;
	bh=eLEyj0FLniFF3WeZSyYJdC7+2MK8Hpg8q1DK/TWdi1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=e5pvyHtYe7F3nOnzuIfTPoIqIPwVZt4ywvEvZsBp13GZbqhMV+3uhibU8vv+IJhIn
	 Z+1tn/uONevqwYKsy5/o496cbvppRC/Z/UEZ0+eonjGhI/sSsozntfkmKbIEv0DhYC
	 lJpXWbaoqhew1v7VseFvkeHz7Fh4maCWFfGItduNmFV0nguijKYQE5iC9+xgBe+EYL
	 HdYnNZ9o2OSQfuRf+BUXS3nFCQHp8YndKZR20YXi2sLmbeBdXAALJSMb5rqFkR/SjK
	 /GHY0DKh82Y8hNVofVO3lbjlYJuqOQla1zee/wgibPqt6kkT70nY5b7j3oxGw8nl2X
	 oGTBZCh4UKCbA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B0980817; Fri, 24 Jan 2025 15:49:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D969E807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="aMfCIuJ4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7028C10408F83; Fri, 24 Jan 2025 15:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730153; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLEyj0FLniFF3WeZSyYJdC7+2MK8Hpg8q1DK/TWdi1o=;
 b=aMfCIuJ4NvKOR0oa28XUSE+jNbxyOxH7scE8e62Tck722MPJ56PMyWNwzTyvdZrVCIfnUl
 Ee5Rq2YZvDPA6XpY8uRgV6Rex3iCf13OMJCUxRV7fWcazDUjFGrZu322xmSLzOfa9Z+XFX
 si9TrVOWJ+Af3mNeI0Jy7TNG9wSJApVHXr4r0whcMNQMoq74m1AZYsnp0xo0qnBBD7+ZJU
 s0IQ3BwubMiYugDRYrFt0OrZfgV2DX7SLXA+5I9EeO4fuIQ1YjQj6G6T+x+EFTQ+mRpe/K
 wXOAxb0yruY/bYQBtIJwu/racskaUyYAdxmwgV9QPqtH8m7gmQF/5UBYNdpQ6g==
Message-ID: <84eb6282-e78c-612e-d610-5fab9745aecc@denx.de>
Date: Fri, 24 Jan 2025 15:49:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: Remove unnecessary assignment
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Michal,

On 24.01.25 14:17, Michal Simek wrote:
> Variable self assignment has been found by clang. But Linux kernel already
> fixed this problem by commit 2a068daf5742 ("ubifs: Remove unnecessary
> assignment") and commit ae4c8081eb77 ("ubifs: remove unnecessary
> assignment").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   fs/ubifs/recovery.c | 1 -
>   fs/ubifs/scan.c     | 1 -
>   2 files changed, 2 deletions(-)

Thanks! Yep, ubi/ubifs code base is old...

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
