Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B82C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 12:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB708675B;
	Tue, 15 Aug 2023 14:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692102242;
	bh=N9SKH6kLHb5trHCAIENZUT44dXFVrlQ3wnBt+jUsEAY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=hVTAm2FqtPiFM79XieycBQDGU9IO0RF/lZKrWBeLEfQOKdYHIJ++Gr8LgvXwZST4S
	 L9VfmQHSJ8kXba2QDcKf4s5gH3fcfl88oeTY2mvJiM3kWZCwb3AxMiWsGVt2WMafOU
	 ea0TTMmBpEdnObPjnNHwiuSmT9GnrEfgupWVdWEubJUobOCqNAq+U2laCC7MPOPQOj
	 zwEWfjoRN9lIyy+bOurzFhmgUQtQas/A/2qlUNaa9ghUQl/84BRm7yKGIqsOrfyT2L
	 6Nr3f3JIKa5FPRpu5U954qs/ofam5p1yrIm61Himcd7JKyKiSDWUQxd7iuE8Z6494+
	 qJGWXE5MJvCgA==
Received: from [192.168.1.107] (89-186-114-123.pool.digikabel.hu
 [89.186.114.123])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 40B8D86264;
 Tue, 15 Aug 2023 14:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692102240;
 bh=N9SKH6kLHb5trHCAIENZUT44dXFVrlQ3wnBt+jUsEAY=;
 h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
 b=NUZn4vJpMqTFy+cnko+dR5zpp2Ei5zR/JFZMVY4u53OvTnqZBCAttND9o69ZRusu1
 ILxUzW4TaTR0LUPiC8GANdDJty4GRkyGu29RBt+W1XOjcVFBYtHPKfrO4CBxtH51Mz
 +aBgoLv7doSn/a4KugRxVXzhlifXHfvJJRarT+nFW2ptItr1JeYnx8lJJ2Rj2YyGs/
 kI7PbzT4k4LvyUlBTnl0SAl5yTM4vGpNPvKCcNSMGzNaWFSWlqNvtPuL70bOmInXC1
 73vixACHoUkRIXGbA0UMk6xrYpPJwpFj0eUjdr8JeVsMwcfQUwl+n8IJ7LGBCj1gSR
 ROMQYyzXDYe5Q==
Subject: Re: [PATCH] cmd: ubi: Fix 'ubi list' command arguments parsing
To: Dmitry Dunaev <dunaev@tecon.ru>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>, u-boot@lists.denx.de
References: <20230712125821.41233-1-dunaev@tecon.ru>
From: Heiko Schocher <hs@denx.de>
Message-ID: <b4e2c8f9-5b72-373e-0130-b3d8e2dafb70@denx.de>
Date: Tue, 15 Aug 2023 14:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20230712125821.41233-1-dunaev@tecon.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dmitry,

On 12.07.23 14:58, Dmitry Dunaev wrote:
> This fixes allowed argc variable value for arguments parsing
> 
> Fixes: 6de1daf64b1 ("cmd: ubi: Add 'ubi list' command")
> Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> ---
>  cmd/ubi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-ubi master

thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
