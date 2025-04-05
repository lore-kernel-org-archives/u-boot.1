Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4F1C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 07:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DC082A4B;
	Sat,  5 Apr 2025 09:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ipxe.org header.i=@ipxe.org header.b="EaN9XUdm";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="IJWWHu/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C6382A64; Sat,  5 Apr 2025 09:51:28 +0200 (CEST)
Received: from a7-18.smtp-out.eu-west-1.amazonses.com
 (a7-18.smtp-out.eu-west-1.amazonses.com [54.240.7.18])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B45382A46
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 09:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=0102019604eede49-7f6cdbbe-f77e-4b79-bc8f-3473ca9f33a6-000000@eu-west-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=fvumhlyyi2m7uxyrun4agiymlewwagjt; d=ipxe.org; t=1743839485;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=xQNM2E4C8RhyTYFsV9tsDJxJDBaXczUFZzSAFt06iDs=;
 b=EaN9XUdmG9NtBxFH6lgHHXDAhJkoiS0Z9fmHV8OPIIQstC8pf/eclrDZgNM9syne
 pwTLuBAwALhld4QtK3QRhW8Yfd6LCx4Kbz8W5VXEADmy21CSynAjVRNY8v5AP11Fjpg
 3P35juLgHVqejekYWGNx831qicp++ISDtULXBik6M5RtWR96f5GmZSqBtd9EnjIlPBm
 mzWw9WXdkzmQHBE1Dzp2pf3wZ8YNSy3+AA01KgYL1AHf1nP/fsGJiOBkxL9r6Ps2LL6
 hTC2wK2+RNeT4JUxynjyyxGK/g8PJVzzS5CHFQaNHXJ37mZsdk6FzW/sTh0nk7FSkLB
 kgBN1nP4ng==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1743839485;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=xQNM2E4C8RhyTYFsV9tsDJxJDBaXczUFZzSAFt06iDs=;
 b=IJWWHu/buq6A6fQZWQJJ1/9LSKPnBZehcAoVHFUgbQ0g37Xs9nD2vHwY/kpFayar
 RakaJ8+HG8M5GH/y0+dkOZoMhl2N4hxCVYh7J9JXz3KO73cI4QLYnNIRlNqfgOTlp3m
 9BENz/m10KSovAYU50lYymEcZyUpawhyIsDoqvng=
Message-ID: <0102019604eede49-7f6cdbbe-f77e-4b79-bc8f-3473ca9f33a6-000000@eu-west-1.amazonses.com>
Date: Sat, 5 Apr 2025 07:51:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: stop network in EXIT_BOOT_SERVICES
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, 
 =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= <christian@kohlschutter.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Michael Brown <mcb30@ipxe.org>
Autocrypt: addr=mcb30@ipxe.org; keydata=
 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
In-Reply-To: <20250405065812.33027-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.fspj4M/5bzJ9NLRzJP0PaxRwxrpZqiDQJ1IF94CF2TA=:AmazonSES
X-SES-Outgoing: 2025.04.05-54.240.7.18
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

On 05/04/2025 07:58, Heinrich Schuchardt wrote:
> It has been reported that memory corruption can occurred because network
> packages where received after EXIT_BOOT_SERVICES. See the thread
> starting at [1].
> 
> We try to remove all drivers when EXIT_BOOT_SERVICES is called. But
> 
> * Some network drivers don't call their own stop method when removed.
> * Some network drivers don't have a remove method.
> * Some devices have CONFIG_DM_DEVICE_REMOVE=n.
> 
> Let's call eth_halt() in EXIT_BOOT_SERVICES explicitly.

I don't have the affected hardware to test on, but the patch looks good 
to me.  Thank you for fixing this!

Reviewed-by: Michael Brown <mcb30@ipxe.org>

Thanks,

Michael

