Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC018CA5FF1
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 10:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9E3C4054E;
	Wed,  7 Oct 2026 10:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWNTCQXssWXG; Wed,  7 Oct 2026 10:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7B16F4062C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791367465;
	b=Agn2CZP/TH0twsmeKhzYX7BkrfM1aRHFACmEM4DHB1onQt7M4AyrE3QlkB8L8a414XRN
	 0Bp2xSUzhPpNtDHTcETAF0KAPL7BKmxTCi060LNjdS8P9vjQXc7O7uNxgum1mwwhsKPvX
	 qS6hAXrcoL4HR/Pw2FqIsppm7XLhAsvD3J+m8nFhjwJi9VAsYDUYvBu6lRPWE/T7cGgVy
	 juOaugT5MT2VsEem721NuujdTdKXCprP+Sc6hSJstKjsnHf4fE1g02r3/yGDdGwfXF7T7
	 +Zn151VQNf9oWKS0TxFtXkcuPwucpsswyL/ZcmtVJkdgECJQeXFmz0SQJGOu1xQ24oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791367465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=V4uc4VsRyjqiC7lLEo0RPZD9NdPWkfovZAheKG2O138=;
	b=F4k3Zom2pUcqqHYUNfERaqVhhXTMVAoY0C24rwsCp676JOw2cETwUK5msGS40YyBAifk
	 sDTpFy+oo9/NDJ5ejiABBILnVOgVi4V0kDJFzRNoIORxGngIWYcSSHH29NkyYIkAbBpHp
	 O3V0uulZaU2g01a3KJxBsDrUI36TYBXPwBPkc/nrMnDmqYAVOxHwAFR6G10d0+Nkk4hEG
	 eEOWXFeHwvRDXnDHQ3eYM3Ihes1X7Y62EUWAEc0Hu4XvncU4VOiVroQUtXVk45ugFaiu6
	 zn/dt6IRDHfG6S+t4jae01l+3Miw7s6MB/d7MgLeHMyXzI+KUSJ3HaFek/Xs4J1k4YA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791367465;
	bh=V4uc4VsRyjqiC7lLEo0RPZD9NdPWkfovZAheKG2O138=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z8QWcKW4VDITPVa73O2l19uIt2kFGcVvDwAqZypaBo7sFeO4merKVmAhDTe1xTXmn
	 Ip44PUH7Y/J+uQUHRYAii3imj8sSbvl4pQGIoygvH7+Ri5f9l2FcaXB7ykO774hbrI
	 7o17Pk47YMTGwFfXbvrMsOVYTRgCVBJYZEVF6K7XjTiQe62gtNTpoOb1VJ928CPZj2
	 RPfld5S2mV/+pa1nDCQ5iK/5yM7AEYAjrif4itduFA6Sc3QEztGTJIlpsLEwjsGvH8
	 gch98ZWe+a5QQEVxLIKtNjttHqctQAYt5AH2+hK6F6ekqvzaC11GtqErpO5tjG6To+
	 hM76HEdgAtNuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B16F4062C;
	Wed,  7 Oct 2026 10:04:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EB4E317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C53D4021E
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MstabVvhRQij for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 09:59:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8C77A40057
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791367183;
 b=EbsVBAeNHgT1Fr/RdXJL4FH66E3KxJ+ZrmFcVeJv3SvWJGyx4emqCSTqAmgj+lGiaD5e
 v0wJaMEA3PyKb8a3Ye3ktXwZ6nIHhpSzZjIyIqLeX+uBzjaHIFT1E7wb6NsRWA3OT1vYE
 Tj51aKwaoeMGkd4ImgwZAqCJd5/uHySBUuQVajpNFsNCZG3k/gtW0svoZcVT8YyAbUA94
 NB8+ItlupWKWEvWD6XGDQ9dhF2TgumieZne/AFWqEUogeG7FpX19kYpjjm9UMt0/cbLmn
 0JqKBfSqiSfeXDy9AY7u9ivo6jkMAEYsqnjPMldl6ds/yNkL8sayqWPuqVvTKPan5/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791367183;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=V4uc4VsRyjqiC7lLEo0RPZD9NdPWkfovZAheKG2O138=;
 b=BWv4veym0HBHlVv9AoAgqbUWyJeq867Wwp6qxzoCOdYJgXicLEV0tOaJF89IsFm75ePG
 e7PYeSogBY21N0nIbF8AFzr8m+2VQxm+DsurS84+4MuDezdfAHPEEsXNF+yOrRNg7rrm0
 9xEOBZ1gSLg8kSVjCC2x/8473XYaEeQJAStSK3HU/Sq/V88bD434a8su4enaYpTcQHF0n
 O8CscvjuRVGUBen7cFUwQpxIAYGJPm+RM9j1duYxsa1NFdNyeTkrtHHbFNo5P3K2WAgDW
 JbcUq1KjsXlCy12bQbc/X8FnizntuOlEH625ebLYQU7GPevZXnkbfQGTL0NBIP6VDvA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aKxwoom+; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=aKxwoom+
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C77A40057
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791367159;
 bh=V4uc4VsRyjqiC7lLEo0RPZD9NdPWkfovZAheKG2O138=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aKxwoom+WUWYdip/kn97aMfI1D7y5IqzlvO+F8VGXCoQwvroPlUKFYNEOGkLwBkcA
 bkzzWLo0Bn1NUTIYUYk3KbRJBNqeJl5lpIZRASy2lkv8SmWZwDhe1Ul8PTqlPyZUib
 TWIBPSNzDDkfguPsN06ZkH/2fvAIM2PSSu+Psqc2WT8SgbNrFMx4Y2WGZ30GcJiVNy
 rBDZ8nr1pdY+u+VzfKLNi6bEfMngoJloVYPIXB+VUqNFTaEpfuEq9lbY3RNlGRLRj8
 QeguR7EYU5wKIjAyd0qsMnKl9Iatb1PQYF9+wZT2C1oxjCb7rcy6PXAxVpNFp73ctr
 7MZ8zVk4suTxg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2CFFAB2203DA;
 Wed,  7 Oct 2026 11:59:17 +0200 (CEST)
Message-ID: <d70529bc-8b19-4ec1-9d03-97a96f06d687@freeshell.de>
Date: Wed, 7 Oct 2026 02:59:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] riscv: dts: spacemit: k3: add binman node
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20261007-00-basic-spacemit-k3-v4-0-c44d09937088@kernel.org>
 <20261007-00-basic-spacemit-k3-v4-2-c44d09937088@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261007-00-basic-spacemit-k3-v4-2-c44d09937088@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/6/26 22:11, Yixun Lan wrote:
> SpacemiT K3 follow the standard riscv binman layout, which has opensbi
> and U-Boot proper, so include the common binman dtsi file.
> 
> Reviewed-by: E Shattow <e@freeshell.de>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  arch/riscv/dts/spacemit-k3-binman.dtsi | 6 ++++++
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/dts/spacemit-k3-binman.dtsi b/arch/riscv/dts/spacemit-k3-binman.dtsi
> new file mode 100644
> index 00000000000..f1c1c3ee6fd
> --- /dev/null
> +++ b/arch/riscv/dts/spacemit-k3-binman.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#include "binman.dtsi"
> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> new file mode 100644
> index 00000000000..352e85e7de8
> --- /dev/null
> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> + */
> +
> +#include "spacemit-k3-binman.dtsi"
> 

Thanks Yixun for preparing this,

Reviewed-by: E Shattow <e@freeshell.de>
