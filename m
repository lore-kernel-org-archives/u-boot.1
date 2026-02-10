Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B004EA3F09
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 06:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA8C8341A;
	Tue, 10 Feb 2026 07:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="UueSRYFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE4E8388D; Tue, 10 Feb 2026 07:25:42 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA8D78309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6397C10EB94; Tue, 10 Feb 2026 07:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770704740;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BnZ4TELi4sfJSAGYnlWay9SyiZb41+dfmhOaB9Dl0fI=;
 b=UueSRYFgmwrLpN2Xwc7bYOitk1m/9YZFG3hR98oM5g31TQ7x9lZ2a5DCsnPzBs6w8BDuUy
 zG/muE4EOUWfajL65yPUavsv0PJQ+LaoVPazBQlIsD0yrVz34d8vWDaIDk1vFP9iQRxHbJ
 ZqjsmfWjFBkRjBTNhoNEG+akGfHw3OeeFtvUTa6UD1fSHgQ7kDO2MsgyWP0HRsMBVf0L8e
 tw/3SlRAJdkyYz0nB/P9WscacsrPuFhkkoD21aUsh+qksjBKQG0V7afe7RWVo+uz8mHOf6
 ZnsCwOqWy7tJVzGBB+uoHO3zDmP3ObKmWZbCuvivZ9YTyQQYb9gRGNflXEwIhQ==
Message-ID: <51f6ac6d-5fe8-e139-18f0-30ea4e43ac2a@nabladev.com>
Date: Tue, 10 Feb 2026 07:25:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] defconfigs: Remove default COFNIG_SPL_LDSCRIPT value
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
References: <20260205191631.3488262-1-trini@konsulko.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260205191631.3488262-1-trini@konsulko.com>
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

Hello Tom,

On 05.02.26 20:16, Tom Rini wrote:
> These three platforms set CONFIG_SPL_LDSCRIPT value to what the default
> value for the question is, once evaluated. Remove this unnecessary line.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> 
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>

Thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

for axm and taurus board.

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
