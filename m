Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9FBCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 04:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031D18386B;
	Thu,  9 Oct 2025 06:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GBaPrBku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86138386B; Thu,  9 Oct 2025 06:14:21 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E549383869
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 06:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 842C31031CC; Thu,  9 Oct 2025 06:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759983259;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=GrLoHEESmuMIxdmuDU6JNZuS15fR5W5SItDO2uCPZvM=;
 b=GBaPrBkuqNmwSNTfNQffdkSRi/agibpeeziFH/H2x7etZioYT3naWn7Clxw2PirmSvcIF4
 J44K1ZfxWG8FxEfAIrcziVmorHeBuhzFrOT7G7Tom67huAnhX/qTX512DZalG33M7DWqHI
 fqdMVHFOq5ZG2H4aGLEkldEsTkWfLw6dsm9JMgG4IFfLWrYFaqXWeJ2+/tZhObgeyTi5cq
 73PKOLNSg0DvngehzZqd8L1lh74N1pkd8HXjmKN0c0BSuSD98ig26whmKA8rmy4MKwYSC+
 B+EEr2/pugwS4hGLc+jHGKpdJXq3HabtbYOoi6XrsMpNPDDxWs7uPGGPkqwJJQ==
Message-ID: <d71edb85-555f-8a4b-1552-6e930080509d@nabladev.com>
Date: Thu, 9 Oct 2025 06:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] fs: ubifs: Need to check return for being an error
 pointer
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Alexander Dahl <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20251003-fs_ubifs-v1-0-a48d4861670a@linaro.org>
 <20251003-fs_ubifs-v1-2-a48d4861670a@linaro.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251003-fs_ubifs-v1-2-a48d4861670a@linaro.org>
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

Hello Andrew,

On 03.10.25 12:42, Andrew Goodbody wrote:
> The return value from alloc_super can be an error pointer so the error
> check needs to detect this as well as checking the pointer for being
> NULL.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   fs/ubifs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-ubi

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
