Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4608EC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C9128125A;
	Fri, 14 Aug 2026 22:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eiQEq1dI9qjo; Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E2DE80C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747460;
	bh=yxEgSRcNG/qNsfbVVGljOr481ZO1Y5NLTO6/8wI/c0k=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0/AdXnkAxfHcuL8ILF5NksiL97HrWU+5r+F4kgfJYWMrTcKwgCHLYiCHLuRQQGqdr
	 MdsEkjle6RYgzltY/Hg5BFFlF+MmPPajwSvp3a47XhV7DuS46lC2VGQYiWUCsAF6ou
	 WnprLfycHv+bE4t4h8fVYv+R4m2/jQWgvHveeaEmsOPwJ5LBb0rLSueM1giJ4XnkMZ
	 d76OYpHJBuE35h8iRm7Qo0mbQiDVGjeT3QXmLZ4zCbisFhgbPrJ76nVttGJN7YiAzs
	 2McO5WiOYmkBRckhIaAx5Ye9vm6k4I+pbxbZK3fS92MCHfCbn7gcpbjLFJhjnw+zoQ
	 F4Hxumx+Jzv3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E2DE80C41;
	Fri, 14 Aug 2026 22:44:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1519A3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 075A640080
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I8pChGGpWN68 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F4C640180
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F4C640180
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F4C640180
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:17 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hMHMz069RzMlGk;
 Sat, 15 Aug 2026 00:44:15 +0200 (CEST)
Message-ID: <66e8000e-85d4-4820-9360-b1c480fb71d3@mailbox.org>
Date: Sat, 15 Aug 2026 00:22:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/8] board: schneider: rzn1-snarc: set serial number
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-1-56b6acef0439@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-v2-1-56b6acef0439@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kyjunqd5ecetjjpzs91cucuir9rk4qkg
X-MBO-RS-ID: 3660253b5482a0b20b7
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:38 PM, Ralph Siemsen wrote:

[...]

> +++ b/board/schneider/rzn1-snarc/rzn1.c
> @@ -1,11 +1,21 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> +#include <asm/io.h>
> +#include <configs/rzn1-snarc.h>
>   #include <dm.h>
> +#include <env.h>
> +#include <g_dnl.h>
>   #include <ram.h>
>   #include <asm/global_data.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +static inline uint32_t hosted_readl(uint32_t addr)

"inline" is not necessary, compiler will figure that out, drop it.

> +{
> +	/* No hypervisor yet, just do a direct read */
> +	return readl(addr);
> +}
> +
>   int board_init(void)
>   {
>   	gd->bd->bi_boot_params = gd->ram_base + 0x100;

[...]
