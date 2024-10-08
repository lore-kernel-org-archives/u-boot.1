Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED81ECED25F
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451A088D15;
	Tue,  8 Oct 2024 06:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728362248;
	bh=mj35ubIgAYXGxLEVfh3kHt16bBpWkeUlCI8XvR+h31s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=b70zgJGPvaHsdrbvnVL57fjkiLkHGYw35A23j4s7iBuN2LPrwxig+VgFyKEOtjKq4
	 Mcc3JVKA/BM6QHueDwBxMrgjRRvf8Lzk/jsqmvVkC8sw7CUzLLkYFWmdl7S0Ex8RCE
	 kKRCYvhxoEEouzivPuxBktczZ3/5RbvZjwvgprAUUHJAAYYtFjYtey+2LfJBu4N/1n
	 iNNtyXvpDmjBTeuJihy1E/lRX3MGBf695hA+VQdpjSgQ0MsVUYnOXWvfuzpI1b9DGS
	 1skUQb3SxZ0HfmXlvG5roNlUpADUEOyxQ06yF6SY4ovN6hqpmyMLdo9LbKz7/lvnsP
	 McXVxTMIVxTYA==
Received: from [192.168.1.107] (82-131-157-225.pool.digikabel.hu
 [82.131.157.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 359B3881A2;
 Tue,  8 Oct 2024 06:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728362246;
 bh=mj35ubIgAYXGxLEVfh3kHt16bBpWkeUlCI8XvR+h31s=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=f5YFhUiiv1PespxpJpb/ema0tsaE4BzrrTMxKiceXmVX8bCHlh8Ivz4tAI75Rxg+r
 QSHoXzeC3FPIhF82RrKd2rc11Tgyev1qEeczWYgIX6J28YjM6vOSvq8TBbs1Awky+M
 +z5oVsVMoE8pGD9YujI8Rkph652oE5NI3WNxSqanXml/Yef7XmFhCJF/LUSV9Vz9NJ
 sLWg9EGid/WicVKuxy3MVz6fTIjgnhqS+bw+/YFwxTlb3P/82P2ylXvOA4v+eGnY09
 z0JvFfa5+pt5YCh4NhWsNWdBk2uXnX6JTyn9Ia7qqtE3j+AKoBFZ+IeGNx8mohLNZU
 HZoROjuJSzrRg==
Message-ID: <29042d19-5572-7801-8b89-f32a4ae8c8c6@denx.de>
Date: Tue, 8 Oct 2024 06:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] sandbox: dts: Add missing sandbox,emul phandle to
 sandbox-pmic
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241005143356.10069-1-marex@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241005143356.10069-1-marex@denx.de>
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

Hello Marek,

On 05.10.24 16:33, Marek Vasut wrote:
> This phandle was missing in the sandbox DT, add it, otherwise sandbox-i2c
> driver cannot look up the emulator via i2c_emul_find(). This fixes the
> following i2c_emul_find() error:
> 
> "
> $ ./u-boot -Dc ""
> ...
>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>    sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>         out_set_value() PMIC write failed: -5
>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>    sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>         out_set_value() PMIC write failed: -5
> ...
> "
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/sandbox/dts/sandbox_pmic.dtsi | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
