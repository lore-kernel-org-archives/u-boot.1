Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A442FC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CFE806FE;
	Wed,  5 Feb 2025 17:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738771594;
	bh=ybLoXEivlghzvmKDVKorRRk8lh3AfXxMmaAdeST6hyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UE9VQ4lvMl8vj3o2nmBR4CqJ2O8M8mT3EsOzAyfLzvkCJsBw+IUc/x/h5ilwNUDkV
	 XCDTKMiPbZTr4i1MByoqLBngcqkMfkol8VYBRuI2S+OzYikHn1xOEE7XMriuNg7bbO
	 xpRaiUHPKmLXlOPLqcG3pPe/ChGXBBgq6Y1oeXiUbnqQanr+iHI87ZEW6Inx0EkWG1
	 fMU93etA9L+mI8sAF0ZQ8bQMC4Bnl0m8bsQetaL2fG3m7fDpZiuKVVV7pJUfMyDs74
	 T91e0hye0gWY8dtjw9U2u+5R2kkP5k5LW7PRTvB4SCBvCUtk8BjwwQXBPi4DxptbdP
	 IYn9fAJdiUadw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69CC8070F; Wed,  5 Feb 2025 17:06:32 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6FEE80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Z05KZitz"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48912102070FC; Wed,  5 Feb 2025 17:06:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738771589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybLoXEivlghzvmKDVKorRRk8lh3AfXxMmaAdeST6hyI=;
 b=Z05KZitzMfJj/uW/3DEV8i7HtcTE+vG43nJMqzEW2KpkyJRIlmi0dUwY8aGyFD8Qngsv4y
 mVuI5b6E98ccsM4NSUD0GBeXtt4P3Nz81c3Rsl6cIUDVe2nQkJ7y8CV7wZGAIGVCZXZ0iB
 W4UmgZXvFepdQNxNL0JDD0gy2BbR1j0eAcL6a+5XZVyY5TPkiaIQWFxrNMmw/Ax1g9WhgB
 G883mtVcgClY4sXHqF0BdcnkH5rWyq7wKLWPzoFRTTcxB1Bq/gE4kHvXLL7NqvqQ1kR9MB
 WS9oS/EWoJxZ+gBlVKJ+40ymZi0R3r/wXrq0QjjBLS93JV9qGf4J5NkPwxhQ2g==
Message-ID: <caa036ec-af2a-4971-adb0-3fe7b566d91c@denx.de>
Date: Wed, 5 Feb 2025 16:30:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: usb: Fix format string for fstype command
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Love Kumar <love.kumar@amd.com>, Tom Rini <trini@konsulko.com>
References: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
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

On 2/5/25 2:04 PM, Andrew Goodbody wrote:
> USB tests on ext partitions can fail with the following output
> 
> test/py/tests/test_usb.py:245: in test_usb_part
>      'fstype usb %d:%d' % i, part_id
> E   TypeError: not enough arguments for format string
> 
> So add brackets around the format string arguments to prevent the
> error.
> 
> Fixes: a730947974e3 ("test/py: usb: Distinguish b/w ext2/ext4 partitions")
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
