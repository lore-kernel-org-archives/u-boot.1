Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21BDCD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 12:01:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6DC84874;
	Thu, 18 Jun 2026 14:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uFzLqTkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DA8849A4; Thu, 18 Jun 2026 14:01:00 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 111EB8056B
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 14:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c0840dc2859so12495666b.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781784058; x=1782388858; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hr18yYg4tEmCyMZ1dTiXRDzUpaPT11n6f4HnHpvLcEw=;
 b=uFzLqTkRYxkbpnalVEU4l6HKrPlr8XgA9QFvaVI5Q6EjVuid5myekAEZGyQgsBNZRI
 8tRDD5NQpnOpUY5VVuWtERVHCIbF/0NmDpjDd2rL9F/mX0E78rWjbkgzCKKsPRXb7qBi
 E/tg37VzAtTMJeQ83UgJTU7E0BHV0x9FX7u0fhzXaPFiJPbbvC0VFTMoioKQaorZF4bM
 fN0RPHuDw9V2zGOVSV8z8AzZWeNZKPNGLrlWw95ZKJrzU5NOxJodXCUy7cUPEvHBP5YR
 zoGV5B8tDYIU4J0RZknhzN4vPmTRhPXekN8udQy0zhVV/7vhNBA3ZdQtAY8jmlnXsi09
 iaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781784058; x=1782388858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hr18yYg4tEmCyMZ1dTiXRDzUpaPT11n6f4HnHpvLcEw=;
 b=o9dnHPfV8A3I+WMZKkCwwLuvYZtuH+j4UfufC9VasBo3dRmXuMIu6gjkqN0Ebv77A0
 qcDhCuUhwuHyEVzHaTskBP01S2TIs2U06/rgKk1LfuxSV0OTxKMYUc8u79h2CFVtfiM0
 oY0EoBQsctSiCHj1LSk52OtuNpTdic5OeK5m8BTBPwgQZ7LrWcFASB2ZZ/M9mCJeBIMn
 Qxk/3J9JRCnctitMb5tab2MYumFhy7OhdBGWsbStr9GfIZCv8Yh6/ckwdOEVpKUiX1Ep
 AQTBcBbRdQ7csy5i6lKTUzI2JgZMXkQpKdi3hztwk7Zv9TRwW8gWci2v7N3/5b7mKeti
 VqYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aLeAY5gCXvErrbq79ONrabWGlm+B4u/q+141sdL8jfDhc+BL82FlbbxStNMopkBRUii4ycsQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyEf2R0rFPf04qru31UlygU3/Aa/y9FWia6koTcIVVLrCbqTv/0
 /qxWSJMFSPNo/cFd92cw7njp5xWofzKfSKcFb/SLg3j3ZrEveiMYQv0Eo13wUPcfJgs=
X-Gm-Gg: AfdE7ckc9/Fbdiwig7IYZWAoAAlO8H7/DpEYWfjQGgChDyqZbjYPuHFxKNxhoBk0WiE
 P3VKhixozKSGNbxEqVj0D4G8psUqM3zY8rkD7YesvmJuyySe2fP5+8Iu42ASdzAcHnKABnemNxt
 31fMRQNqFApV3wWMKy+v3rgu3NU92DMGz5T4Xubhj19Miy54fhFn84lIGaoqO+8drr7zt70eqw3
 wcL2Kh/O+OCYZbCXamdjTLKySPz5ltaudJDtJWQ65gHwjWkq4/AlKYmhFBzYGQAA+i3VzwjA7AF
 Ehu24gM776dR798QuRHZyBHZt8aMj8FSXqqvRwej7lr9t9H87TvKwm5pASQctKx1XXqypvqhUk1
 x3+1gvhhauYG1peThRm9tyaB8vTB4mjVxSdpl0N4cmkvLmz5mmj3tvtNv+fSQwKYs4ia1cTnxig
 geMVIdgHVKgS31QkSXT5aOWbK4FIjV0ljKFgWfVGQkEfQA6uv44DTz
X-Received: by 2002:a17:906:2090:b0:c05:abc0:dc7c with SMTP id
 a640c23a62f3a-c05abc0dd02mr506401266b.40.1781784056915; 
 Thu, 18 Jun 2026 05:00:56 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb8b1bb64sm967130166b.52.2026.06.18.05.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 05:00:56 -0700 (PDT)
Message-ID: <e1fa3df2-ff4f-4c18-bdd6-703d9da850c1@linaro.org>
Date: Thu, 18 Jun 2026 14:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: msm_geni: fix clock rate return type truncation
Content-Language: en-US
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <6wv2gjh4bkxttxxriqx25k43qkeg2sraknwaffxahcyqxedfm5@uuxaorwsolbm>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <6wv2gjh4bkxttxxriqx25k43qkeg2sraknwaffxahcyqxedfm5@uuxaorwsolbm>
Content-Type: text/plain; charset=UTF-8
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



On 07/06/2026 17:41, Naveen Kumar Chaudhary wrote:
> get_clk_cfg() and get_clk_div_rate() return 'int' but operate on
> 'unsigned long' clock frequencies. If a supported frequency exceeds
> INT_MAX, the return value gets silently truncated or sign-extended,
> causing the caller to misinterpret valid clock rates.
> 
> Change both functions to return 'unsigned long' to match the data type
> they actually operate on. This matches the callers accepted data types
> as well.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/serial/serial_msm_geni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 3dca581f68f..9de193355e4 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -109,7 +109,7 @@ unsigned long root_freq[] = {7372800,  14745600, 19200000, 29491200,
>   *
>   * Return: frequency, supported by clock supplier, multiple of clk_freq.
>   */
> -static int get_clk_cfg(unsigned long clk_freq)
> +static unsigned long get_clk_cfg(unsigned long clk_freq)
>  {
>  	for (int i = 0; i < ARRAY_SIZE(root_freq); i++) {
>  		if (!(root_freq[i] % clk_freq))
> @@ -130,7 +130,7 @@ static int get_clk_cfg(unsigned long clk_freq)
>   *
>   * Return: frequency, supported by clock supplier, multiple of clk_freq.
>   */
> -static int get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
> +static unsigned long get_clk_div_rate(u32 baud, u64 sampling_rate, u32 *clk_div)
>  {
>  	unsigned long ser_clk;
>  	unsigned long desired_clk;

-- 
// Casey (she/her)

