Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF50CEDD93
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 998FF891FC;
	Wed,  9 Oct 2024 15:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="eC335JDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9463891E6; Wed,  9 Oct 2024 15:34:47 +0200 (CEST)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1A8F891FC
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 15:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 7F1C7240EDD;
 Wed,  9 Oct 2024 15:34:44 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id D314224087A;
 Wed,  9 Oct 2024 15:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1728480882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h08xnNDbihJk6S0nSkxnn1G79bBYZ6fseMvpM4o5G3k=;
 b=eC335JDrZou3+EuVEEWneI7GznEWcdeCYBcRKZwsbZoikZPhV2lRQuk7VbPE3QKDBFM/LJ
 7mEnmXxVa1Tt6R9VTg1Qa3Ivn7E44p5IbDnxOk2/kTm8bUk9pPnTh1i6xLFzpU8VIVCsPd
 EjRgEbK9A1Fm73t/uF6XLUjZ1kd4uJ4PDRvWmEFaCIkOhjzEXZZhSsIw8iUnw5bbPzbdfb
 ny9CQ2Qg0fK1RzcKwZ6kyt1FBPpzJ6/Iuvr2cDii2unBFakJYT9ZZZavqgGJ35FF1aVb/l
 l5evGaGwYBb4lBDvek6KNk/ANo5FyTf9jI1FyF5FC8yPgGUGirFElbho8ej0Aw==
Received: from [IPV6:2003:cb:ef39:8710::193]
 (p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::193])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 93FE0240802;
 Wed,  9 Oct 2024 15:34:42 +0200 (CEST)
Message-ID: <efa678ca-97e8-4dc0-8969-eb97cc97c542@devpi.de>
Date: Wed, 9 Oct 2024 15:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: stub: add sm8150 compatible id
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de>
Content-Language: en-US
From: Julius Lehmann <lehmanju@devpi.de>
In-Reply-To: <20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 6b2ca4
X-Rspamd-UID: 1b3024
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

On 09.10.24 11:49, Julius Lehmann wrote:
> Add support for sm8150 clock controller to clk stub driver.
>
> ---
> Simple patch to extend the clk stub driver to support binding to sm8150 clock controllers.
>
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index ea817031fa6c0cc1ea21000273b5651be5d05e65..76df9e3aba0e664fdaab8431f7909dda52ceb795 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sm8150-rpmh-clk" }
crap, missed a "," here, will fix this in v2
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
>   	{ .compatible = "qcom,sm8650-rpmh-clk" },
>
> ---
> base-commit: d0f74bd417daf6492975ce346843ba0767caf51c
> change-id: 20241009-clk-stub-sm8150-b7a29e0f43ba
> prerequisite-message-id: 20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org
> prerequisite-patch-id: 01b791d83c26250b3ff485045b88d5889f911bb8
> prerequisite-patch-id: 66febbc73195c71535e2423d14f1ff6994ac36cd
>
> Best regards,
