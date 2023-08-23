Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A49C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6429F86434;
	Wed, 23 Aug 2023 22:44:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692823489;
	bh=UFgWzFZanX6xJYt3NLVXzYVfE4jMRlvsUN5l2IuJGYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eF83xj+oE8oWBeXsAYgdnHWV7sHaDpTiyrCmJRQ6iLuTJXqpOd9XuNU7FVL61uiJW
	 yf7PbvTCrQDmwPgyrPYSI7wNJqZdmKR0R183Qjx5DQtvgyiV6W2IOUPAb59THA0/wr
	 2CZ6UDfZNYMjqQgbsa/g8HOAkd19/qCSd5uxJj0x4StxWFLBK0Tg0ZcJvKp//Q/ext
	 cFmk2PASaI3cPrjRCGFolNkgKxvWCBmu8ku44T+RfAiUx2cPGGVmT9IRTVCZiJnwIZ
	 kzi+3oQbkjW797+LKDENzDRhxBU6jHJNJTksWPQKoC1/Bspi/o5HRIpCHePDJdJKSU
	 23wQ36yrPrJ5A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 89ABD86432;
 Wed, 23 Aug 2023 22:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692823488;
 bh=UFgWzFZanX6xJYt3NLVXzYVfE4jMRlvsUN5l2IuJGYw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AKUH8gInS3TBKcqBGBECPyEYK1WyC57cfo8wli6EmbDr4pYZjexo+e6z3K9H/I23e
 2NSnPEKsgDHr2LWdFuFnc85W6xmM6mhTC7RY/mgUsqgQbK8oxhdpD4wdAVBgLc22sy
 nioBZJnHSMvfpoYOurV1L2SSvBFWYlT3i0stM1jKDzh+I8xl91PHACWyRlQHidkXI3
 LoAOxXsAAFWb+m2qUUTk5z5WUpmZvH/fYKnWxHQuICeeEK3f8DdhtPxjZrQj9nYMeu
 La6YWpBE9r9VmydW2LpN9gHrJkDKExB9dzTzYhoTO0FckgBs8kXPSP/8X4/+LQK3uA
 VAcfFAeJlL7cg==
Message-ID: <a64baf05-e96e-d12a-6ab5-a7139680c6d6@denx.de>
Date: Wed, 23 Aug 2023 20:03:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] usb: xhci: Define 'XHCI_MAX_HALT_USEC' macro only once
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com,
 bmeng.cn@gmail.com
References: <20230823154123.859927-1-bhupesh.sharma@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823154123.859927-1-bhupesh.sharma@linaro.org>
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

On 8/23/23 17:41, Bhupesh Sharma wrote:
> Right now xhci header file defines XHCI_MAX_HALT_USEC macro
> twice. Fix the same.
> 
> Cc: Bin Meng <bmeng.cn@gmail.com>

This Cc: ^ stufff

> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---

Should go here , below the ---

and then add another --- and the diffstat, i.e. this:

Commit
Message
Blah blah
Blah

Signed-of-by:...
---
Cc: Foo User <blah@example.com>
Cc: Another User ...
---
Changelog/Diffstat/patch

>   include/usb/xhci.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/usb/xhci.h b/include/usb/xhci.h
> index 4a4ac10229..958c94bfa7 100644
> --- a/include/usb/xhci.h
> +++ b/include/usb/xhci.h
> @@ -1136,8 +1136,6 @@ void xhci_hcd_stop(int index);
>   /*************************************************************
>   	EXTENDED CAPABILITY DEFINITIONS
>   *************************************************************/
> -/* Up to 16 ms to halt an HC */
> -#define XHCI_MAX_HALT_USEC	(16*1000)
>   /* HC not running - set to 1 when run/stop bit is cleared. */
>   #define XHCI_STS_HALT		(1 << 0)

Reviewed-by: Marek Vasut <marex@denx.de>

The patch is obviously correct, fix up the CC list and send a V2 please.

btw if you include the --- in commit message, git will retain the Cc: 
list below --- too.
