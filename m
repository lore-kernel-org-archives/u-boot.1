Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020E6C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 07:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B39881C8;
	Wed, 15 May 2024 09:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715756583;
	bh=IWet0IX+A4dvjHZnLOvJ2JzYYFBIiA/Q+ZlGpRs16RU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGmgh3DAE3tFko3fuECpnleQp7+J7WGGX0lJRf6JOkZdGdGWYPwYk2IQ7KEJGggoS
	 rZkn4jIrBWPJPSqpzaCsoLJ6m8Ebzhupllq/vxRp6xJNI1u4u13mwxzBfM9TrJ1+uK
	 4akuqwFarLcdsvEF0ADAS2qQCW3eHVlTOe6XvLr2NTakI83H49q9asawfxswVgfvHa
	 EMIAVpS1lnLGn8qssqikemdNm6tqyvI2BZ0cF7rf+nlyUGIHTZrFeQvcCWUsGM7M4F
	 8DAz63SRCmURXZQ8AqqwEmF50jEQnWB6FkoFRLZ8zFMOiFnOktuZ93yTZYj6bJ2EAq
	 bQEubSUH5lniA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AB01B878AA;
 Wed, 15 May 2024 09:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715756582;
 bh=IWet0IX+A4dvjHZnLOvJ2JzYYFBIiA/Q+ZlGpRs16RU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=0IJzrRTNQ/ZFEe726L5CxNpRMhA6RBWdg+bPQKf8ukW7HFzCKFvmz0oRPFdvaM2Kz
 d+G9H0U5nk80mgi88H7lOqVFQ6w903beFGW7TYLO4pNzQTgUjVK9I5eCnmrJThVJe7
 zSrhT3DumCE4M+EpN5wJfjyHRxzMXrnPN3y7yo2NDVBEm1nKItr3d1CeXWJqyrZPCg
 wbb5j1l/Hi0X54IhBzu3U44bqIzrmYIjaFbLb8G8V7V2te9RoO67rw28uxJh//VIaC
 PfHiH0dj/CfYIL3xOdhuaKDhjVYUPW5rFLfvmpH2FrPRxnCunPBJ+M+jqMm5bxG1N+
 k6zxufXFz2n0g==
Message-ID: <bcd69266-07a2-4296-be76-f18b471a2f19@denx.de>
Date: Wed, 15 May 2024 08:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: remove not used variable in usb_ether_curr_dev
To: Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
References: <20240515062442.9667-1-hs@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240515062442.9667-1-hs@denx.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/15/24 8:24 AM, Heiko Schocher wrote:
> grepping for usb_ether_curr_dev in u-boot source code shows
> 
> $ grep -r usb_ether_curr_dev .
> ./cmd/usb.c:static int __maybe_unused usb_ether_curr_dev = -1; /* current ethernet device */
> $
> 
> only declared but never used, so it can safely
> removed from code.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>
