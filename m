Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E1DD41D50
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 04:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D3028939E;
	Tue, 12 Nov 2024 05:24:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731385445;
	bh=XRQAgydHfGM05Uei58QBfABDxyNYIfApkaRq6hmZ7Lg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NUCJN978IEGajJn3T2BPiTQTIqFDvUL4ujHbvl+MxaWJlirSb0SckoouZb7+8xvWc
	 BE0v7mzQn0iJZEWZ7AcrFp1zwdeoVay2XA7a2oNwICibG+9y6qlUFAwoev+rIY1KOQ
	 5jBxrNAtcte+75P19TCa67+ozf3yYhXyvTE6zLSTVXY/Akg3T1XfvfQPkbGzdK+tUI
	 oWmxEwhQN5jzz01dh1LzuHFuj6pFTSG8B4oLpvAjP69jOJwqgfO4QXoniah9STwdgq
	 BXHbXC1WVo9R4cOeRUTZ3PuP9J5/ON9/kikXJBlnVa40yaz5QOaZVoIeXTroEjq12q
	 yMDCQQy83f6RQ==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6C7DD88CA2;
 Tue, 12 Nov 2024 05:24:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731385444;
 bh=XRQAgydHfGM05Uei58QBfABDxyNYIfApkaRq6hmZ7Lg=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=EXq35+yWEAs2v58MvBdA/BmH9/OHxo+yjKTStCe9yfryN6L6rRdizmPW3B6L2H5ys
 Piv1q7EK1i2H2Qy3ZuuYOFtiHQxCR7WRyS+ZC7/MWq9Ygy/jxB8glfOGWdcXdVxk8n
 MC7FuLcqPvLakp9y8FNRdacUZbO8l1IzylJhyIdmyOhI5cqXs9AX+cQrB8HSkweTuU
 UGHRvMYHlcsPDt0KTLXd203Jty5beojGgzw6hoLAiZcRlzo9R+F/b+RLAVbDcZ1fGc
 U/sJCd6w8mw2pSU4ukszbKrbLoeuRf2sAyQia+Fn1Si2yOCtlEz0Sc5CWAySWWkLLe
 WYNpLwD8OOSfw==
Message-ID: <41d9df66-e70f-d4ea-379a-b55d672f60de@denx.de>
Date: Tue, 12 Nov 2024 05:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] tools: imx8image: Add missing break for CMD_DCD_SKIP
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20241112023854.2289656-1-festevam@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241112023854.2289656-1-festevam@gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 12.11.24 03:38, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The CMD_DCD_SKIP case misses a break statement.
> 
> Add it.
> 
> Fixes: 254c00803b63 ("tools: imx8image: add possibility to skip dcd")
> Addresses-Coverity-ID: 514648: Control flow issues (MISSING_BREAK)
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   tools/imx8image.c | 1 +
>   1 file changed, 1 insertion(+)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

Hmm.. could we add this scan in our CI ?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
