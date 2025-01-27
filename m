Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8C8C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A38812C8;
	Mon, 27 Jan 2025 22:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738015107;
	bh=jyGSooHg+999aO0h1ObG9r54mTqbUrCL3iuYyErxsOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EpQRQcui5s9znTt4FlvriY+OxqLlKy+SKaRV0A6YeM53Gay9VbG/HitUqi5mO9a+k
	 98h2jgFkREhU4W0DsfpNSxHszcGPFBR+ucTkM77bB1cyZ3wHKEmGCLZix2lXPLlDCe
	 3FKQzM9hS4mk3gS1fMcwmPVMAjrF0UJ3UTEj4VSfmpzJr6mn23ebVxvF4VvXZYXPmi
	 K0F6RgYupKLlyp9zoUHFpJYgqVp2H6kiyYCltIqqkEYThZn36pc/1vHkeUfiBy/Hlv
	 EeWVYeSwj41CXAYaYA9F/64XIurDV9q+hd4CjkavTwIDdvIOGladJF30O0Al+jANU0
	 l0Gy/q89IYhpA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C153D81761; Mon, 27 Jan 2025 22:58:25 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E0F812BB
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KCpi9a/l"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE1B3103802C0; Mon, 27 Jan 2025 22:58:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738015102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyGSooHg+999aO0h1ObG9r54mTqbUrCL3iuYyErxsOI=;
 b=KCpi9a/lmaj2wQOt41oks9dGsCyQM5s7cmchGj5MPAgkqil+LRhV/1PAPmjImFeStH7/3o
 qFb+F0ySdnOKNSANAw7xxnFsDyYYgM0eX+WYgP3K1CeUPAXLXjWybCat/mPCV/gXIc8caj
 Nj1hdlAfQI6AOLmpGvjC4YNv6u9uP+2Gg6fPuiapINEEqDGttoMzkezAO7qOcHeMbSSZRm
 ECPEHi/huaqZfjvIkaprX7ytFT9hOqg+vUK0rEDYX6jUlRlCgVDFhXK67n51eHMNAUNXQP
 CXObBsF8uTME8BWHY5HuVSMz3scoRw4ONFO2Xw/q4s9E8EKSnAjJ9XmL0QEYjA==
Message-ID: <ff8c7554-a03b-4423-8692-13c7c278095e@denx.de>
Date: Mon, 27 Jan 2025 22:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: Fix NULLPTR dereference when serial# is unset
To: Michael Ferolito <michaelsunn101@gmail.com>, u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>, Lukasz Majewski <l.majewski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
References: <20250127210741.820819-1-michaelsunn101@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250127210741.820819-1-michaelsunn101@gmail.com>
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

On 1/27/25 10:07 PM, Michael Ferolito wrote:
> The current behaviour of this function will dereference a null pointer
> if the serial# environment variable is unset. This was discovered on a
> board where U-Boot did not have access to the first 256MB of ram,
> resulting in a board crash.
> In the event that U-Boot has full access to memory, it will still read
> from address 0, which is probably not optimal.
> This simple check is enough to fix it.
How does one trigger this problem ?
