Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E72CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 10:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEF883145;
	Wed, 27 Aug 2025 12:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p0++hl1V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E88F83192; Wed, 27 Aug 2025 12:42:14 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6668B8304F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 12:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b5c12dd87so31846805e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756291331; x=1756896131; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nCX5xzgKnY2N1hFee6OfsXpxLI8P6kW2iq7IFbKyTsU=;
 b=p0++hl1Va+6BwD6U0sn1UXrZtW9EfFEk+VAZffYOiYBoRvlNwJIXibG66ePzYmB6Nc
 WxWtzX36E1A5x+uQH9KbSDepgyUDEONOQiEKO8OmgnVEThxhq5IunlzJK/RgsnYV33pF
 6UxfowUZP+q8htV3t7YYZE7X5WAymecwfX+SU2QlRzJUXsYoFTegiWTMSTAzNpo6q2wz
 tkoxnnigvK7MPdT9BtikiUt5PafBc0sNv+kXYpOLGMy+S6aI5713khuK/6hPmuyCQY5R
 M/mqhQh2T3T/6Ch5sbRblf7nBBZVLeHdXkmTwshW0tIdMXlpdx54uopIVW6MjWLAgG//
 xE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756291331; x=1756896131;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCX5xzgKnY2N1hFee6OfsXpxLI8P6kW2iq7IFbKyTsU=;
 b=A6tC/TRYwqcFKxbDjcg62wtieclsuDrnjpgIPjQvZPWwQT+Pwc4YFnxpTZY3nc7L+d
 5jLaBWBbSBgtsu9QoRfkiS3XGZKSZw8VuHufpTvCwfzv47fREX3sZP9CLN4mIaZ5Tbly
 kBXFmclzzBVelaBpqDSDt+86hUZrJamYCyAU/DloLKrlzpkEVHLjes6iwLvXWLKGLal1
 +M8zsEvO8dcUb51G2j90pxXE7AoCZhzMRDd+zrczWhs0ctib9JPDcByNRxSqp01z7frZ
 pL0hK0tWw9zU1GB6l7mNCWKgeJgT0hCQFEDd45Zx3YE3pEzPGRCzjfkvjmEBqNfsA1w+
 vRYQ==
X-Gm-Message-State: AOJu0YxWFTtX8ciTuKumMVFWsxR2SiXPleExfFkgJthWRaPOBbXu25Jc
 JAM1eCQwVBlG0a9X31p5g3a0ai8vA3EAz5MS7UFCofVfavqHb9l39tQv8AVuCKVIu90=
X-Gm-Gg: ASbGnctjxvjMcAlV8aDXhCzbbZMd67yvJMYjuUrTX1Dwp08ZllDk8GgBb1YkxMIRid9
 xgI/fDd71au9IxcXnCtzsrKGLJ97i3fo0zf+JxT6hvFosSZ2PPRsFEWM/jQWKQ7vj1kBCsH3Oxm
 xm3QMZjUFcM6tK+b2XspKp2vqy8G7EM9tqFEiOU/adaA8kbgHvNu6dP63/ok7o/w9ZsW8foHmCF
 zJ8WhMOfaPm1h2C2qIbNAya9vvKX/dvIdAs+c1EtSMHjFwhcNuU1CblDseB2QsQ13WQKLOiImp+
 DU51mJIRHyViHgXtWYvjdxvRJK7UnVKQAcTtvHmZv1S/agxTQ5jy0cEGSNe98qNcGxje9y7fllz
 XZJwBjb7St2G2DAu2eTtmL0fycGlHGv0LWy88usgYTWx//U8qNwUAqtBoS4SEQ4HJqAcjY6H8ka
 S6
X-Google-Smtp-Source: AGHT+IHNBvy+KZcJ4KI+2aC14V/v7WWq6DGUpf9q7n6ioQraPEbuEDEMMHn7jiK0wnFyEV8R21TwHA==
X-Received: by 2002:a05:600c:450b:b0:45b:6de3:6402 with SMTP id
 5b1f17b1804b1-45b72e50594mr9285855e9.32.1756291331291; 
 Wed, 27 Aug 2025 03:42:11 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd6f.dip0.t-ipconnect.de. [79.195.221.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd3d2c5cd6sm767574f8f.61.2025.08.27.03.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 03:42:10 -0700 (PDT)
Message-ID: <a82c3fb6-f10e-473d-953e-e1b551617d06@linaro.org>
Date: Wed, 27 Aug 2025 12:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk/stub: add sc7180-rpmh clock
To: Jens Reidel <adrian@mainlining.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Julius Lehmann <lehmanju@devpi.de>
Cc: u-boot@lists.denx.de
References: <20250826231752.60633-1-adrian@mainlining.org>
From: Casey Connolly <casey.connolly@linaro.org>
Content-Language: en-US
In-Reply-To: <20250826231752.60633-1-adrian@mainlining.org>
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



On 27/08/2025 01:17, Jens Reidel wrote:
> Stub the RPMh clock controller on SC7180.
> 
> Signed-off-by: Jens Reidel <adrian@mainlining.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks!> ---
>  drivers/clk/clk-stub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5f5aca41d5b..23670c2f442 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -51,6 +51,7 @@ static struct clk_ops stub_clk_ops = {
>  static const struct udevice_id stub_clk_ids[] = {
>  	{ .compatible = "qcom,rpmcc" },
>  	{ .compatible = "qcom,sdm845-rpmh-clk" },
> +	{ .compatible = "qcom,sc7180-rpmh-clk" },
>  	{ .compatible = "qcom,sc7280-rpmh-clk" },
>  	{ .compatible = "qcom,sm8150-rpmh-clk" },
>  	{ .compatible = "qcom,sm8250-rpmh-clk" },

-- 
// Casey (she/her)

