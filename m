Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13BCC35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 23:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5401810FE;
	Sun, 23 Mar 2025 00:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742686069;
	bh=U/YFMLHztChrHKt1ifDHc0UZrHVwxfkguOB2QbHw0WM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GV6+dG38DrPHHSaVnyxNDroDpBM02GPFd684kp84Y1x381Ezynd6urQiSATwvX1qx
	 81CQrHK/VSQ8CbJQY78jf/Q0IMfkvuC/501NTBeSCFP03Vx4WnCvtfjkJwO7WRMzNJ
	 IoO0B8fXkf8KV5+F8qVSbvMib+j1EyVnvUkaye9yVbPXqIXEZLXH/TXxZldSB0xCKT
	 uLCRZV1nnQ7dhVOs2bQhSjWnHsiDsmPnLHrKnKPqsFLJp8OrSljuO4olXEGx3FvvYx
	 S/5x+k7GLw2cBGqxQ/fwDRpRH6+lc8ZsorWH09OxTVh6g1+GpbUJZzoKqt1xMm7WYg
	 mtqSLZgNbfHqA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B280D8197D; Sun, 23 Mar 2025 00:27:48 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA2E80C93
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 00:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VH9MJFjf"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 58A1E102E64C6; Sun, 23 Mar 2025 00:27:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742686065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=U/YFMLHztChrHKt1ifDHc0UZrHVwxfkguOB2QbHw0WM=;
 b=VH9MJFjfnYtkkW0jBxfJvTmzHJ/3aMTP/4ABRWGA28a5wMt3fHKoZamQzuxt68NMAWB4n5
 i/Ndl7lfVW+UsHSDbjV1Cum7G5XI+FVbx/wdiqJ5U3q2N57vJAEMNyAvd0aOGo4yJ0Pw+P
 5mSZlqDzSArK5L4ZqPeKWBixrQVrwuHTKwTKnVNXxG7bp9OkV5fGEGrN3+zGFMz3NOT9Fp
 uVYlYONHIrf5d+h1MbDDUJn8w0LLnKH4/73j0KT3k4E0EJJVAdQJCYxe+de/e1mjgZj1Hd
 8UUCGQOzVsgcPUP57mwRpy3xL9APjNv4hhvoJb3ti7+ABW3PFZdcZLptEuBh3Q==
Message-ID: <f5ae3cd8-cf24-4620-81ff-10cf8d946c27@denx.de>
Date: Sat, 22 Mar 2025 23:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: atmel: Add SAM9X60 support
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
References: <20250322205625.1330306-1-admin@hifiphile.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250322205625.1330306-1-admin@hifiphile.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/22/25 9:56 PM, Zixun LI wrote:
> Add compatible "microchip,sam9x60-udc" and device tree binding.
> Compared to SAM9X5 the only difference is the DPRAM memory from the
> USB High Speed Device Port (UDPHS) hardware block was increased,
> so we can reuse the same endpoint data.
> 
> Tested on SAM9X60-Curiosity board with nfs and ums commands.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
