Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE11C5DF8C
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 04:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6FB83A41;
	Sat, 21 Feb 2026 05:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mkhQGloh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FF983A5E; Sat, 21 Feb 2026 05:48:45 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62C983936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 05:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fHvlD62RJz9v9f;
 Sat, 21 Feb 2026 05:48:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771649320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bc/H0xDmG2C1VP77y46An6DeFx0reRUk9Aivgwk4fig=;
 b=mkhQGloh2Gdf3aCRd3U5aQMK/T32dVmqWnEQg18ZA5WtiFbqZF64NjpnZcazw7Bo9S5hC+
 lEWV8ABVMVMS6pZdUaCGDSMpJP4a5rTw/CkvapK4ZPNKdWQa7vjjeC78HWwXGJLUHYjyyo
 9YsBuhdvWwJJk0YWqx8CGN/WpkxhsBiC8D6RmV+n50FwNnjsfbi9fhM31J0Wv2QgLOcGYg
 9mAHHfRbcgjh9ffin0EDkXN3MawzBoK8e3BZPvjMQRK36JT8Qgb4G7CjwJB0sDN4iQS7bc
 y5gc9cLQMjkuoENnT8QdjJkfY5DkuRRM7H2LxZKUeSk0oPp5vOPK1oxyWSXmcw==
Message-ID: <c9179461-cc40-49b6-ab10-086f4e5c1eda@mailbox.org>
Date: Fri, 20 Feb 2026 22:54:23 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: Fix USB read configuration error on some devices
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
References: <20260220044709.1065540-1-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260220044709.1065540-1-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: m1yxetgufyx1ksb6icubbchxos93azhh
X-MBO-RS-ID: c0db8ab2c2f9576ca82
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

On 2/20/26 5:47 AM, Ronan Dalton wrote:
> The following error sometimes occurs on PNY USB sticks:
> 
>    => usb start
>    starting USB...
>    USB XHCI 1.00
>    WARN endpoint is halted
>    WARN endpoint is halted
>    usb_new_device: Cannot read configuration, skipping device 154b:6000
>    Bus usb3@500000: 1 USB Device(s) found
>           scanning usb for storage devices... 0 Storage Device(s) found
> 
> Note that this USB stick works correctly in Linux but not in u-boot.
> 
> Work around this quirk by adding a small delay before calling
> usb_get_configuration_no, which it would fail in otherwise (with the
> error code -EINVAL).
> 
> Signed-off-by: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>
Does the following also make the USB stick work ?

=> setenv usb_pgood_delay 2000
=> usb reset

?
