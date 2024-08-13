Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B20CC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9F188928;
	Tue, 13 Aug 2024 06:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522110;
	bh=DeFHTglaemcYA6F5tkFlVGAPbVIybSKbsVuhmq/OI+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=voog4NAuhwQmQfa5CACOD+OTauGdiKnnXs2CbAdPkt3EGhux4rz23FwP1ojoRZ6pw
	 TdiO98cZT6F2/Y7hxmvOf3P4CpEGPE4UynVujHWKEXAkj654451YGNQEE+Uj7ms3oG
	 2yujwRP1bTQK2GZi7eFHabdWUnzfMhTwnvU8tRsvgoXN9Gqz9flIJUdk2SlDgr6Bgx
	 LCFMAuK+4hEyRxW/J4eUL/uMJG7mH1HKoL6g3b7oIWZ6MN5/MhI6xxGYjio6WlVYWB
	 CQzr5u1+S/Efp1Z84Nr7r5+XEt7IpEBvHBaxv09tixcTMtHa7k2L20B70n75XhlcJk
	 XSfqxzR+44lFA==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7BF3B87E30;
 Tue, 13 Aug 2024 06:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522109;
 bh=DeFHTglaemcYA6F5tkFlVGAPbVIybSKbsVuhmq/OI+k=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=VtpKZUb0iGPbPkS8Z5REsDflSo2Xp5uYRrIo9inkL514NlYOExCmI+joKjJsfkbi7
 VZEYbzNywwbgWGZVh6mn8NTItFgGFmXJS2Ctxu2WGhHtyuwI3PU+rJZxgVpBCIC0ZG
 20MAsdVXPau+KmXfI+YjaLshmcE5gFqep6qBvl0+VVOKhzIvxFjntqrzXrHAin1rTB
 pkAkHPkMdbtJ9vU2qmnhPnMjGwniRa+TGOXK/AvUZBqgTwGeN0308mLf7qu0qtkTmw
 R4JBDH5q7442bNwCbVM7lIBqsQvSjd9611iBnOpKDrHSnYiMTUgTYD6s7XUBvtwi1/
 Qk1XVQlPl23Jg==
Message-ID: <240c47cb-ca78-3c5d-19b9-ff0857c0822e@denx.de>
Date: Tue, 13 Aug 2024 06:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 05/18] armv8: ls2085a: Drop CMD_DATE
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-6-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-6-sjg@chromium.org>
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

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> These boards use pre-driver model code and it is several years since the
> migration deadline. Disable the 'date' command so that this old code can
> be removed.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   configs/ls2080aqds_nand_defconfig | 1 -
>   configs/ls2080aqds_qspi_defconfig | 1 -
>   configs/ls2080ardb_nand_defconfig | 1 -
>   3 files changed, 3 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
