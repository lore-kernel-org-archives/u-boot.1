Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916C4C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 22:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C552E878F4;
	Tue, 27 Feb 2024 23:07:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vnDRcdNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA3887FFE; Tue, 27 Feb 2024 23:07:57 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4578744F
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 23:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from [192.168.123.161] (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 362923F304; 
 Tue, 27 Feb 2024 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709071675;
 bh=dHLrKZLgoZKHq6qS2DzS9ICSxQei5HSG1eAkTsPIfP0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=vnDRcdNOT2+5BjBwv/dfktHP7W4cQnQyzsi9y1smB5xn8cBXf6q9yRyK2MDAAY35W
 5Z9OC44zjPkOxrzsNfHwLNN5dvLfHzXDhb6lyWfk5LGKd8H1jtkCb1udq30ZearvjH
 JP24rkZ0BnFIoBQsNSlzwQWXKTGCGSxhK7RNjmsDa7OyrJLOwDcJeDHHE8RYBnzAHA
 AYSoO3qhuuF7FC/HjF5FJCePwUWbD0atvIAY7o9K00FUJrPSl2Jyxv3EgJ2Ks/VMwA
 qff1Qbadz8atjbnZvWoTXZQJUTXCk025xVzkeefsPqsIbBuHJz9br9fCy9Wr3i+Dfz
 AYx2/3CagA01A==
Message-ID: <7508709a-378d-40d9-8afb-a9c4b9666001@canonical.com>
Date: Tue, 27 Feb 2024 23:08:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pylibfdt: Fix "invalid escape sequence '\w'" in setup.py
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Florian Schmaus <flo@geekplace.eu>,
 u-boot@lists.denx.de
References: <20240220135248.1277809-1-trini@konsulko.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240220135248.1277809-1-trini@konsulko.com>
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

On 2/20/24 14:52, Tom Rini wrote:
> From: Florian Schmaus <flo@geekplace.eu>
> 
> Once u-boot's build system invokes
> 
> python3 scripts/dtc/pylibfdt/setup.py --quiet build_ext --inplace
> 
> it may fail with
> 
> scripts/dtc/pylibfdt/setup.py:40: SyntaxWarning: invalid escape sequence '\w'
>    RE_KEY_VALUE = re.compile('(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
> 
> depending on the used Python version.
> 
> Explicitly mark the regex string as raw string to avoid the warning.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   scripts/dtc/pylibfdt/setup.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/pylibfdt/setup.py b/scripts/dtc/pylibfdt/setup.py
> index 8baae08770ca..c6fe5a6a446f 100755
> --- a/scripts/dtc/pylibfdt/setup.py
> +++ b/scripts/dtc/pylibfdt/setup.py
> @@ -37,7 +37,7 @@
>       long_description = fh.read()
>   
>   # Decodes a Makefile assignment line into key and value (and plus for +=)
> -RE_KEY_VALUE = re.compile('(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
> +RE_KEY_VALUE = re.compile(r'(?P<key>\w+) *(?P<plus>[+])?= *(?P<value>.*)$')
>   
>   def get_top_builddir():
>       if '--top-builddir' in sys.argv:

