Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E800CC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84BBF81273;
	Tue, 22 Apr 2025 17:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745335238;
	bh=9WA9Vz31a4OLEPjZolApoc9cN+ZmrX699T74/oUpl18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=QIx1/YGbEgpVy9XbnJTRttoexwiHgHwH9/ju7yMxu9FMNja3Un/Lv+aGi+AFsE7yJ
	 5aTMe3JeTI5yuuhavG2Ke9oa3azXmvkzqLGgjcZst6xsKl0XTvc46d2kvZVvCEpJHK
	 2p5ksYo4OJzf2hQRIdHbchbzrtWBQWW/2sYvJc3j8X3OlEXmASljrlGddcNOwsLX4P
	 DOvzBbhnKqqcdU/jh2gmYkwFE7XafzIBSamlO60L8tGSqRgiZqgzK2xgMgLX80B1ta
	 2t+V1QcPzmxQTXLpRc+v6/M5b8c/Lt2XTO9IbkKC8C2VvLvDJfCc14eRdnoG3+aISw
	 AlxjXGfbZ0yNQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE8381E25; Tue, 22 Apr 2025 17:20:38 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF5180F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CcG9/3ko"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 51C441039EF31; 
 Tue, 22 Apr 2025 17:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745335235;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=9WA9Vz31a4OLEPjZolApoc9cN+ZmrX699T74/oUpl18=;
 b=CcG9/3kogW9z0eqoRV12dZg+HUsH9ZoPLaTBdqMG2Y8wFumyJOo19YYY04TqwadjbmgS4l
 6NEzJOp0BP3ZQ8B6TKT9BEt9ObPa8xfe4YePvKKtNTVatpORkP5sZOW+QpvwP5y9wiJZQn
 OAxvaHtJYt92MYjfo5u2M0wSldll2CQGh8H6f3LZBNbSbX05z70kjh4mqoGhkXNjHv/N8B
 J9ahAPwDXxTQE+9BUKDPGzJhpz9sw8ogKyxFpgd/3P+UGtdbLcA0afaCS+WqrbhHrNmDBC
 3+xNfkicJiQqoxoogDM8MP0Weq6IgDYrY25SQ680Q45EtANet0ONWc8iTy0AEg==
Message-ID: <75236fde-cf22-254a-5631-64a37782c49c@denx.de>
Date: Tue, 22 Apr 2025 17:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] i2c: mediatek: remove duplicate entry in
 mt_i2c_regs_v1[]
Content-Language: en-US
To: Martin Schiller <ms@dev.tdt.de>, u-boot@lists.denx.de
Cc: ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, ansuelsmth@gmail.com
References: <20250416062919.1355568-1-ms@dev.tdt.de>
 <20250416062919.1355568-2-ms@dev.tdt.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250416062919.1355568-2-ms@dev.tdt.de>
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

Hello Martin,

On 16.04.25 08:29, Martin Schiller wrote:
> This removes a duplicate entry in mt_i2c_regs_v1[].
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>   drivers/i2c/mtk_i2c.c | 1 -
>   1 file changed, 1 deletion(-)

Applied to u-boot-i2c master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
