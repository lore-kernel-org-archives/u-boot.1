Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BC9CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 23:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F3D835AA;
	Tue, 30 Sep 2025 01:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="g5yi4UTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39CAF8359F; Tue, 30 Sep 2025 01:09:34 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23331834E1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 01:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cbH2L1CLFz9tG1;
 Tue, 30 Sep 2025 01:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759187370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RMO5ZhpKo/lzAIc42WO52Gpa36vLWuZLSeRaIY1g9aU=;
 b=g5yi4UTSQRH21aIz0YZUueGN6tyELZZTDkLw+O9FuC57EwfV7M9iJwzyXD65z9tObfcpDE
 Hmt9NCERX83X1/T84b9L4lj/bIuTyFkLy42JF1Khwz89Z8NEPMdy6puMBWglLBUyUTXrkT
 uZ0Q9ScftOQBCo06Xojj4bi5ostGFi7zqJCyAvl6+rPw1e4Sgq8FILmqHbhsIL64tqigMT
 xRKtcIZhRdVSB+iAqf4lLeUS0crxUP1CzJwcUqNqQ/aTe8JEfNSPy3pZFxNRD5w3zzNEvs
 2Xlsb8xeqXV4Vf/Rur7Qb1xW4+EK/EZcb95rIYWND6sk8xzy/iqjZq0MApVumg==
Message-ID: <71e1cdae-5020-494d-9bef-d9eecf2fe61d@mailbox.org>
Date: Tue, 30 Sep 2025 01:05:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: atmel: Add missing null check
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
References: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250929-atmel_usba_udc-v1-1-e1426271e12a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6db6e73689c19d2a87e
X-MBO-RS-META: nrfwdj1k9nytmhwhrescbszrrps3q59m
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

On 9/29/25 6:25 PM, Andrew Goodbody wrote:
> Add in the missing null check for udc->driver that is present at other
> points in the function before it is dereferenced.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
