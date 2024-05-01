Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5607C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 05:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6FF88ADA;
	Wed,  1 May 2024 07:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714540204;
	bh=lWb+WDT/isLYyRsrj/lPpCacqq4pWD04s54ykNetuRI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RTPws6HYB6zIV+elwB2Mds0yd06FqAtz/UmzSpm88UIE0nLZYXWzGSLKqXYxMfv7X
	 9FY0UCV/if8jvRiDGlKQJuwpOdvI2XcrxTCpuPB1ja33r36NYumtNAKM0Be+Jd5Iz4
	 eennwwryS+RzJZgyRo5M89Wmttz0GTAHeZB2nUb154CPnhEgu0XmRdFggqKkSvSJez
	 siQS6hiG7WXBEXHmzW9xQUmNvsTKadbGOZyckyGCFwnj16TCt8+rPc7/XSYRKo97kI
	 GkJIH/ZBFlLxQt8a3ES+B01SB4sAQ02TdcQUA5+c/2PB1OhlLZCf5S4PptSCR3rK15
	 lQZNoVdcrYFSQ==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BFC7588ACA;
 Wed,  1 May 2024 07:10:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714540202;
 bh=lWb+WDT/isLYyRsrj/lPpCacqq4pWD04s54ykNetuRI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=f58YW78MpDonOCsANIdSB6V4xumcx64TYZ88xABX1B2iPq5YtEkBaTQmZCUeOAQFJ
 JMaeHXBuk1BCeLnwbVQW8RHN4aX0p87scoVZWptQjwA2R5I4o+EbR/7HVK0Ht/DD61
 51nl92P64sMuXrt6GROE1ebt8bCZ5ov2zx2fCOgsNUG5zSHU5W1obcsOC+zzIjP1aY
 JNEuU4XjnRwLDgaJR/Z+PmNzFWPyNZqyk814bvIQYthI6gcTH3J2ya/AdMb+ql1s+2
 /xTbOxyKZh2TAyRyHuOZh+BldYHhBLbzYu+4R/2DL6nu5BYpfLwfc/+/y+aYbJHBJL
 X2x1xAoIz6QYQ==
Message-ID: <4ec0568e-373b-ee32-f12f-806ce456d4df@denx.de>
Date: Wed, 1 May 2024 07:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 078/149] board: keymile: Remove <common.h> and add needed
 includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>,
 Niel Fourie <lusus@denx.de>,
 Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>,
 Rainer Boschung <rainer.boschung@hitachienergy.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-78-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240501024316.1767971-78-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Tom,

On 01.05.24 04:42, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Niel Fourie <lusus@denx.de>
> Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@hitachienergy.com>
> Cc: Rainer Boschung <rainer.boschung@hitachienergy.com>
> ---
>   board/keymile/common/common.c       | 2 +-
>   board/keymile/common/ivm.c          | 3 ++-
>   board/keymile/common/qrio.c         | 2 +-
>   board/keymile/km83xx/km83xx.c       | 2 +-
>   board/keymile/pg-wcom-ls102xa/ddr.c | 2 +-
>   board/keymile/secu1/socfpga.c       | 1 -
>   6 files changed, 6 insertions(+), 6 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
