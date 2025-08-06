Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D84C87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B088839B5;
	Wed,  6 Aug 2025 07:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754459241;
	bh=vHwrTupSm9aYmNnKkV4uyB+K/BwZDkykMne6oq/yGCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aWYNZjQcAoEVxetmzK/vez6P2cZypTVP7R5aawENjwfnv/ELNlkY4KsP+Mtrvm0RL
	 iLVigtCKCm83MzoQjCJsVZGsN6co8sEX1MeqYnizJYUaGmL/ZW1vzlq8N92goejOlS
	 /+zVSsUfITCRfS6G5cw6dgRQG9xTCs2uBg1ZU32ioXR2RLy+VhqlceDUEI9FKVfCoL
	 T5FsRsvYQ1PNpAQmvezKXXbnWwKVNW3X32HywKGqWHceLZsOFeHFY0kgzE8KiXtONN
	 QiafB6704IsJv55CZwkxYldoIRuvPWzim6Pm3MyU6gHRwjBlnADs5sqjoxb1d3haR3
	 KbPbP/Tk70w0Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF25839AF; Wed,  6 Aug 2025 07:47:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDE6839AF
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 07:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eHG3c8nI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1A8861038C126; 
 Wed,  6 Aug 2025 07:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754459237;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=vHwrTupSm9aYmNnKkV4uyB+K/BwZDkykMne6oq/yGCs=;
 b=eHG3c8nIDQgvDphWSwgcS8WfUFXfPuKrpRdqMr/7Wp4ED8EACXG7AOZe5rsE3COIccVB7Q
 72x64ob0HTHzz3NznQ23FyRsQ76X+Njut7oLGAr8EYRa1DD74FW8AlhDKL0o55EM1fFc8L
 WnZ4PfGUpeEwZbVPnqL3rw9nKWt0QBJ+0ziGtQEeXYq9ytdkLf7XWuxATq4wTCueayXbc+
 8HTdGZR948/8Pk8PE6J8kjIIbJ97ZR19bBBTojqjhZV+jYp38J8cVeWY63LV0Wr+nBGA2a
 UdsabtKd7yi1GoqHbGZN0Od0tHe3hXula4Q4GN8jePsEPtb2MHCd3sQd0+5IPw==
Message-ID: <cf5041c5-4f3e-f5d4-cc9e-df3b4f75392d@denx.de>
Date: Wed, 6 Aug 2025 07:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: rcar_iic: Do not use unitialised variable
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250728-rcar_iic-v1-1-00dd08660421@linaro.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728-rcar_iic-v1-1-00dd08660421@linaro.org>
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

Hello Andrew,

On 28.07.25 17:04, Andrew Goodbody wrote:
> In rcar_iic_xfer if nmsgs == 0 the ret will not be assigned to. As ret
> will always be 0 if the for loop is entered, may as well just return 0.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/i2c/rcar_iic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
