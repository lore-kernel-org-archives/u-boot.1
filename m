Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BAFCDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99D188F2A;
	Fri, 27 Sep 2024 00:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727389238;
	bh=qQdtIohOnVZnznPY5RWenU1yzPJ6C2j5fuvXlQvHmcE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fsIoPqwqaLDV+S1sFb8goevwOVy3XjteCWpJLd24h54qr7tdg+I5vny9QUQG7p3LO
	 FjNntYhVOQyOqIctHKhyxPY1gMJZr/H2ivXgBTOLfLlDz7tuPQWd+ZRXRydwsHWdxo
	 gKzrZTq0tVPFU61+8f2ZKScewed7OgHMAAOzpOz+LC7gMzbrJod+JgFrqi9xqQpQt6
	 Ley9VnoMmXlzEbLSz92zlg8vCXqfi9VvxD2rV6F2cRovuHGXjyL+T5YS1Lmfu9qghf
	 d9+LvHqYn+eZ+UOXYQ1YuSEqpYcJZTu64a9hPw55L1xSDDlJ2wEXX5IeFgEKUWB6YV
	 hNFhUK0FsZxlA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A0F3888F2A;
 Fri, 27 Sep 2024 00:20:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727389235;
 bh=qQdtIohOnVZnznPY5RWenU1yzPJ6C2j5fuvXlQvHmcE=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=KvDfGV+Txbxc5HKLiDpMyAenSAhDyurcnSk7STOM03lbdrXcSTxeOj8RDtRbbmDqL
 AUhRjAO+PrRM1I664E3rbyUzwtoPt9QSQ2g11suT27EbyF+HYiT+AGp6y0BT+1e0cy
 1h7P3lZjCtgena5mElL2YPotOj1xIomGyfGcQxO9mN2QzHGI92+wu0tUdaMsFxWHQY
 UJUFeKCzZP7extMuCjNHJRpPGUHvO+jyv/+xjV17NTHWDzWB+KZdG8mrJsKWWQYPub
 O5+wRiduCu/hXst6hmR921V5emPFZORGKMOpkU7BxQwTPjr+u1Wj5mK8JJw4DfkfhK
 WFS1fBcTVma9Q==
Message-ID: <25ee832c-5688-4a79-9c34-a2e34ec89a76@denx.de>
Date: Fri, 27 Sep 2024 00:20:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 15/15] binman: Make a start on an iMX8 test
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240826191143.426387-16-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
 <CAFLszTg2s_4LKkJP-OAwjdSqpygwhggOmSAkY376UWTk2LGxzQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTg2s_4LKkJP-OAwjdSqpygwhggOmSAkY376UWTk2LGxzQ@mail.gmail.com>
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

On 9/27/24 12:07 AM, Simon Glass wrote:
> This patch is for Marek, to provide a starting point.
> 
> To try it, use 'binman test -T' and see the missing coverage.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/etype/nxp_imx8mimage.py |  3 ++-
>   tools/binman/ftest.py                |  4 ++++
>   tools/binman/test/339_nxp_imx8.dts   | 17 +++++++++++++++++
>   3 files changed, 23 insertions(+), 1 deletion(-)
>   create mode 100644 tools/binman/test/339_nxp_imx8.dts
> 
> Applied to u-boot-dm/next, thanks!

Is this patch really supposed to be applied as-is ?
The commit message makes it seem like some RFC/Example code.
