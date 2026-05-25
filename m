Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2DDCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8A8848C5;
	Tue, 26 May 2026 00:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wLVvHZMJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="saumCCBX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6E884903; Tue, 26 May 2026 00:51:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170F184859
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gPWMR5jx3z9v4q;
 Tue, 26 May 2026 00:51:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779749475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8T9qYpJ9cIYy+YzvCmcxwLhzrwBqF9uXoiQ9buRz1A=;
 b=wLVvHZMJmitCdz6E8FVbJLDBNRVV7hK0Qra98cw0O/NIkAUgmx2wsgiFOmxD6Bnn4wW5lw
 MLreISEUWh/xp1HlV7BYvq75OT/KCszSuIgVMNhm6qgnpSL2TwuPzB6IzoQTnSOVtVK+7g
 WrKfUEns6Df/bEI6cVQQdcfYU+PE1gN+8tE6byCimjiTGcdhjtu9bz9F0HyOBy7ArGEJU4
 inCyPRZjFEFGfA6eiMwOvjdiIiEqWP8HDUBnn2D0n/2mc+wvCpQxeQXNnqTdRee3Xs1fKG
 ZNj5usPBXuEb/qSyWxYqu4FEQjEiRRcVF0UxQGtR/NWHLxTY+L+or+c/vJzdBA==
Message-ID: <9d767059-9354-48b6-a303-c1dc9f835a96@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779749474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8T9qYpJ9cIYy+YzvCmcxwLhzrwBqF9uXoiQ9buRz1A=;
 b=saumCCBXQei/D9p5+/OV+y/J9YgxxvQZ/YgYOqBLUSwQAoJY30WEMFz7b1nh66It8Sdi36
 yRXtHP6qos915FzqsQleUP7cy7tgLPuUuPc2XXFbUwxG4SoOgUx3DTXrUwdXKflaIhE+Lg
 YQPqUTVOCNGtHvC/hFsehZ2ifwPig+MRIyiavj4YlE31P6PqCudCmqgK8nffKnrMa+Y5zV
 9yjWxfATtV72GIhAF71vEjLEizfcLiblwG32Gx/1iq9SDdfwxTJ43eRFFWklwuA7V4aPo5
 T7QyrCpCT/lkacdYbzTRNpZoyyWm7sLtWvi3N52g4n4EmKwHPQk8zqpQzTuClA==
Date: Tue, 26 May 2026 00:51:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drivers: serial: Fix dev_read_addr error check
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>,
 Tom Rini <trini@konsulko.com>
References: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <BESP194MB280584A431D400DDB6A9E2E2DA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 3aa1a66634ed1b4790e
X-MBO-RS-META: ibkbjkb9upg5py45tkpjpdnbcw8dt7qc
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

On 5/21/26 7:52 PM, Francois Berder wrote:
> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   drivers/serial/serial_sh.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> index bc205234e24..7debff6cb3a 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -257,7 +257,7 @@ static int sh_serial_of_to_plat(struct udevice *dev)
>   	int ret;
>   
>   	addr = dev_read_addr(dev);
> -	if (!addr)
> +	if (addr == FDT_ADDR_T_NONE)
>   		return -EINVAL;
>   
>   	plat->base = addr;

The change itself looks valid, thank you.

I will give it a try on real hardware and then apply it for v2026.07 
sometimes next week.
