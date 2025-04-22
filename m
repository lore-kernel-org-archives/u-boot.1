Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2529CC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9595580F6B;
	Tue, 22 Apr 2025 17:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745335216;
	bh=AySP9NTq1tiZpjMihg1e5ZXyjk1MJF5o8UtEUGzwtkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Nfz4egiZCneObB3keR8QRo3iluUsO/QyWsBmszbEmDOW3eXwnh7j5g1u9rs6mhk/j
	 tQsUPmbzvUWX80WUlxugzVTicW98OqTYEtuCSTle/Fs81/k1H/76zGPFjVeL/fPP7h
	 uaJQ+SS7tl9U2NrDlg/TEy12xTkm57sTKnIWlRZEJM+KGRUeYWGFSnBUWfkijzl4mW
	 RIe9VxSMKJd0pMKM95iEZMdgA4CA9+kY/s9IFKAQHlu7ow1h44pYvZVSLEP/Psb4O0
	 riNbguWY8RyayI4VEIeiZUGLRQIfIArZ72WFAsmRhIbq4WeX59gA12vxgj0tzMcEJu
	 dVOfcRZJ7z/CQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFEDD80F6B; Tue, 22 Apr 2025 17:20:14 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA8681FDE
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="W65kAc4t"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 319F41039EF31; 
 Tue, 22 Apr 2025 17:20:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745335212;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=AySP9NTq1tiZpjMihg1e5ZXyjk1MJF5o8UtEUGzwtkU=;
 b=W65kAc4t5lnwGzS1NSayfhzH4J0ye1SOu7C9OJQucRNvfssYllrtB+Zm507yekOpl3XrZD
 fVHaHwPJ0+5tde6qJv/6Q1Z6PXvHKPpvCYVyqDmZIFxIVOeHFdO2PpQiLTLAuMxuFdRtyc
 8ZtdTJzSXk0AAp4+P6t9kZSxyaDn/PpNvRuZESXJwBZG/pZlDPgh1II6KzMyUKmn/Dujaz
 //6Ic2ZWVI+nexD4hv5oFWnHalqPknrnZ5Xv45j7cLo5R2sPkdliD7fUsCrMnnZfJjH0Lk
 rXNsr6RaCBZRSo2QN7ryPTJGlHAEda3Erc6hPllVgfBYuvdqOLRvTSunEkitmQ==
Message-ID: <32bfcf54-bc7f-1c09-08ef-07da301169ff@denx.de>
Date: Tue, 22 Apr 2025 17:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] i2c: mediatek: add missing empty entry at end of
 mkt_i2c_ids[]
Content-Language: en-US
To: Martin Schiller <ms@dev.tdt.de>, u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, ansuelsmth@gmail.com
References: <20250416062919.1355568-1-ms@dev.tdt.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250416062919.1355568-1-ms@dev.tdt.de>
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

Hello Amrtin,

On 16.04.25 08:29, Martin Schiller wrote:
> This adds the missing empty entry at the end of mtk_i2c_ids[].
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>   drivers/i2c/mtk_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-i2c master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
