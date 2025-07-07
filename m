Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660F5C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67AEE831BE;
	Mon,  7 Jul 2025 17:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ILEZAyD/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BG0u/0GN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0CF831D7; Mon,  7 Jul 2025 17:52:27 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FC5830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 17:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bbTJm64bNz9t9p;
 Mon,  7 Jul 2025 17:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYnZWBd5ZS1XFIAWF19sSeARIR9VayXF+kTLrNlU/sk=;
 b=ILEZAyD/gCbUO8eC9tNtTWAZhI1KR7l4b1ZQd8gMVC+va8Tl5jZGa5HHl9aXle08yPSf9v
 tafUBSbygA4xvid2BG7q+4t//XggKhgfKjtFZ/r3qs7NrOwDW71CSDcbAUvhHuF9HRGzjw
 8pX1/1XN5nRDzxdqFYqTQr9H3srBVadA61CRXAZcTH23WrdnIqQlHbXclyookPiT+dBU0E
 v3DeW/TT3sjh0nAtJe9F/56hiTcgrT8KyMdEj7/U6Vs1/BhcK9Bxz3OZWZ4wYDPlPE+zLM
 MBw3DKxMYAxp8sKMQNdvlLYx0T4lBLz6XAR+CMxyUxmTkeXHyhGH5t6pnZ+mDQ==
Message-ID: <d99d2f0f-cb41-4e60-87c5-570dcc16d359@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751903543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mYnZWBd5ZS1XFIAWF19sSeARIR9VayXF+kTLrNlU/sk=;
 b=BG0u/0GNVjg+WNkcqOE3NOfmenjMlI7MvVSHHHqC2iKXdJyGUq1rlUAhYZrP4mirBTxbi3
 YB7nK2ryFb2CMtSEI1eQe7IV6mn512BrBlzy3jKlywHinAqwqegibD57BZxa53d5/S1Jqi
 GnIxJHyesk6rM/SKfE1/drQRf+bQ/wbaN0kgbNhSe0fHsk++MOMJe1eNmMXS+J4T/5xHZW
 BFiJEk9tI7RePK4GhdCpcVAkqZBbisx+IoFp7u3cSeelKVJWzTxGPqPkDvQiwCLwpXHeE9
 lHrU0WPnRuBGtPnAcv4Z5dqDE/Hf2lyXe8WcqCbDiOXWvCjmG3ensY4l3EuJlQ==
Date: Mon, 7 Jul 2025 17:50:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 9/9] ARM: renesas: Add RZ/A2 RZA2MBTC board support
To: Magnus Damm <damm@opensource.se>, u-boot@lists.denx.de
Cc: Chris.Brandt@renesas.com, marek.vasut+renesas@mailbox.org,
 geert+renesas@glider.be
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180138513.86839.112101475183122753.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <175180138513.86839.112101475183122753.sendpatchset@1.0.0.127.in-addr.arpa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b57137eb7ecae47eddb
X-MBO-RS-META: 3aurukthstxu8kpwpypbhjdz6k4so18o
X-Rspamd-Queue-Id: 4bbTJm64bNz9t9p
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

On 7/6/25 1:29 PM, Magnus Damm wrote:

[...]

> --- 0013/Makefile
> +++ work/Makefile	2025-07-05 19:47:10.480068691 +0900
> @@ -868,9 +868,11 @@ c_flags := $(KBUILD_CFLAGS) $(cpp_flags)
>   # U-Boot objects....order is important (i.e. start must be first)
>   
>   HAVE_VENDOR_COMMON_LIB = $(if $(wildcard $(srctree)/board/$(VENDOR)/common/Makefile),y,n)
> +HAVE_SOC_COMMON_LIB = $(if $(wildcard $(srctree)/board/$(SOC)/common/Makefile),y,n)
>   
>   libs-$(CONFIG_API) += api/
>   libs-$(HAVE_VENDOR_COMMON_LIB) += board/$(VENDOR)/common/
> +libs-$(HAVE_SOC_COMMON_LIB) += board/$(SOC)/common/

Separate patch please .

>   libs-y += boot/
>   libs-$(CONFIG_CMDLINE) += cmd/
>   libs-y += common/

[...]

-- 
Best regards,
Marek Vasut
