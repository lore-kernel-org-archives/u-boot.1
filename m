Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D74C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 13:18:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F141E40AB1;
	Thu, 10 Sep 2026 13:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Up1silP2LEGW; Thu, 10 Sep 2026 13:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 29F0040A8F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789046289;
	b=Rlj8xddwNx8lQHZ7+hd5r1tTsPtsqicDyuZc2Jhs2iylKS2CUH7wLlvM4B49i2WVW9pr
	 0EzEqgnE1xzPTJ8t0ZX4J65hRQ+IXNOfrlCQ/ZxagF/D9C8A4kvrOB9yYoalhAX0iJNeu
	 Cl0hu9u/qrUmWBXjlXxkOX7YPhTmpbG4Hr/zc6qO4AfByv2puayMZ9iaVTp4GDT7Q5FFq
	 GJ7MS22iobQsADNrNAruxKE1CbJ87JSU94lQqifpL4tMde5OhfKZ+1742lpLI55nWA+xC
	 oT0Yi8KO4gBzYsoaeBzGCfBUYi7Hw4R7oYabNxQGTd9LVzsybej510oROM0SiHXg0WA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789046289;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wcZKuDBBHssq6YnLOMIgfECxnGETcCVYl7q6MHo1auA=;
	b=igjBTH96sJVwqZBHU89YdpJ0Cx/KZWU08dX+VEv3ioQCX0Du0mw5sZ9BcLY9Sz1ObtBq
	 waeMehaY+N6F4SOO+mxY/7pi7SKcIE0I0vO4lGoOl3X8rpYInAMmRHPEby5AmGGeA5Eqf
	 9FCusuB5RcC8g6UHrGJLD4AHcWPo0dbpUm41CXgsYcjpiuzqKLClgpmy06vn/SLyAr17L
	 Ml26EN7CdAiYpupSaTFX/o2xLjCiwHwv+Q+OFTLJEyvjJtVVAxb0nW5x0gK/BqsESdlMb
	 phU7SHGY5fBBT9Dg88N5TK5U3dJVBZj/tvqloo3F437E/83pXUG8DB712mDC+MsgvXQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789046289;
	bh=wcZKuDBBHssq6YnLOMIgfECxnGETcCVYl7q6MHo1auA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJcJfCTM9Z2Mssm8d2LciI6Yli9EgEdMuakVUMVRJt5KBJn/u/SqZyMqhutSN+ttg
	 ZUzAUqqhICGgcZtjnjxsjOX2USMiBn444Csni4YYvHtURW2aoQgC6hGUjjjXJumjmA
	 gTA9wBe2UjwVG5/jVV9Qk85OYSZ0Svzkku64OwHyPJO49oUVZltFF+F4/+TQ6XfY6a
	 X21xWTc53tOPknK8Ixai5Yg0DLnHb9HfGneFj7xUVcaHNxbojqA1svR9XYTygqoSKA
	 yULxgnDe5ZJ+JSC1Iak8oqlpn6GEakREGc6t/EONqSPSpvoACCJludKayQDbIYuVZw
	 dfhSwJlH3jLvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 29F0040A8F;
	Thu, 10 Sep 2026 13:18:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6695D769
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:18:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57F0980D49
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:18:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oWYqMln_EWyO for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 13:18:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 40F0980E6B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789046286;
 b=ebWBtn3fQRPOJYSSp9R5KOdD3NgUKbPEUOlIOi8n+gWbI3iMtf9trnGfNX0RI8JnFE5X
 S9syiN+HoiPWXluH6qon/W4FIuxROtUX/jMoctbjNQ8xeq4EkpVehhAwbo2x9D1VtLRZ6
 YEITQa1HzVitpohD6zhW9YPCnmCXgaxn66643IWC44opegw+fE1dSPWHqRVWz7elFglHH
 +cc2oRAQ/c6yM6yZuMeGBIN6WXYX+PasGOWaJykhoJ9/0gZOmAYF1wp1M5ytj6EwoapAT
 UyZvjiPM6zirqPoEzmbPtCdNthDUtUMvfA68aWjX0Uho1YCesScBRSftTQN2yTF4ANg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789046286;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=wcZKuDBBHssq6YnLOMIgfECxnGETcCVYl7q6MHo1auA=;
 b=AUiunH87AQZ+5cAV/Hgkf2vMtYRjdrLg8nq5WmU8JuC3BFtaK7vDTw4vov5l3t3zGo7k
 TBdXBumLhNlrXVv37DIRpDQ4+qGj9GiZOYKB0eaEVIJBrBOL9OI+1tKGu/fVCDV5K8cG6
 6Gp/MKNO3YTX4XIjwRGGBa8QraHfnJwyoCBX10gFI2fMAFYJMyFZfFC1Uj7RBpXVUyQ0+
 gnltrUYz8XrfLIsg715ymcn1g9TYTZaKjDtxzuOfu7lUKPBFKrStRYA0VjsPkbhvlxY1a
 zpoJA2BjgXwORXvzUpnkMuFBjWJanvDi7BirYdl9C2MqlzhsBVYquEbCmFYnTEsezHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BYlZUWTk; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BYlZUWTk
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 40F0980E6B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:18:01 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so7333015e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789046280; x=1789651080;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wcZKuDBBHssq6YnLOMIgfECxnGETcCVYl7q6MHo1auA=;
 b=BYlZUWTkn2/Ofa0JnoBawCuV7CXDJecITT+UiN28AscmdxttZ4XJKvAjA5rJT8D/hX
 zHargGZjElod6TswQqbSzwqBTDqMRdVi+PY1CWEIW5T/At3m2g9oq6EfxtFNoe+ZgbfE
 eU3u3Z0HbmMo1dxVeTFJNERWbtqWQHamSCcPu29RYjz3Ki8f2K+EUZ9tF401MBGyYKkF
 hLAeV1TnO5d7PYud2XCYBQs3o1j6v4MoMfr9pdMKiNHxd5gSui51hX2uBv9/wTKjm7LK
 6ZybompBTsZPzVuenPHH+p8eO2EonQXJTjNhNquzK0N8jA6rXZP9x8dZHJ6C46KUK3Ng
 dxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046280; x=1789651080;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wcZKuDBBHssq6YnLOMIgfECxnGETcCVYl7q6MHo1auA=;
 b=tO5ECYqukCsQ6qJ3Fz7Xiw7+KMRuph24fbGq6SUfkPmx15A/4j/9XTRz94yOZmQDaK
 W1Jj1zI3AzJD3baJ7wLkGXO3yHwv/uOYnEx583iXO4Ij6fpByHnt/QdlJVKrBspUwQgz
 90/hloSOLNjikz05gTekmBCHcWO0h8Uxw9moM17krYbc6iXl6dy55TfrcsU/3ySESTID
 54zEUYukxvB95F9Y7C5AakuOKGKTo/beVGCcdlK36BGkRrTVV1pnDpBHJtCEkq2QE+T7
 Ewwd5Gls9JTz10iYn3eYGFmaBFvdsUjhlLCkhSzcRZxSBKDF0FLMSzZb8T22LliK+jW0
 jlrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbTnukNhqyiow+7cCulgITngAhtj2MnTWBF8kUQ8TTFiVzNE81VDzbsMovJlBG67FBm4lGXI0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l0HAILpKaQ5Odg6t4fo+c6TLXgQGT3CeTMhK/IBMx6xVnmuslU
 lUNnLVDwCEqVC4ow+PxsxTKhR75Vfu8k1TjCVDp1+1opCxkEJ6L5HoM+ls8WBUm+PdI=
X-Gm-Gg: AYBFou2cpKIOtD5unA+arMuMX9lv15KikS7n9rSbcxBlCdp5I7V/5mYSVa/vjzx2ZAb
 QfHKYIkb4fudzNVqBuWtdD/M0sZkTCu/sCoeYbIsXwmUgDrA/oCa1EMU/1lRA3+wbYVbw3yMY3T
 s4rBXqlLEw9bzdW/n76wPXxRQ7qbqxf+mWZVfENVP/BxqBjjGCe8w/vwhhIxW0RanO0XqU+6pYX
 AXhnZNBYmhSjCktmXAoVlyGAYww2chugaiQUmrhg9JlShD0iGasovFGSZiqOEeB/lmPMCLRf9/w
 SINMsz9r6lYfrlnxapt0l5zxi2ERYz+wtDsCQkHRhc/KzkEAQK5xE64sgnP8G6uS2U3HlAbBixH
 4qkTeDG/UGX9ib3PMgb8YA5etZVO8RsvshjkSaNQ94lHCjB9VNBGSEzqbqB5wDpdiB6xPj1dUgo
 FVruda6LM56wv0XGFR5kokhjo/LYrCBVQN6wfG98NgSrBoYZ6l+QagQ7jfdVAJlhxr8vRYIHUbH
 yxXorxzcHVg
X-Received: by 2002:a05:600c:8b66:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49d2590a991mr68408835e9.18.1789046279855; 
 Thu, 10 Sep 2026 06:17:59 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ab73c2bsm49674090f8f.22.2026.09.10.06.17.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 06:17:58 -0700 (PDT)
Message-ID: <6769b901-29fc-4c9d-b72d-7b2389bd2cb0@linaro.org>
Date: Thu, 10 Sep 2026 15:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] configs: add qcom_sm8550_defconfig and debug
 fragment
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
 <20260910-ipq5210-v2-2-d209f7dc0fc5@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260910-ipq5210-v2-2-d209f7dc0fc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/10/26 12:29, Varadarajan Narayanan wrote:
> Add a defconfig for running on sm5650 as the first stage bootloader and
> associated debug config fragment.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   configs/qcom_sm8550_defconfig | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
> new file mode 100644
> index 00000000000..30d11f36eb3
> --- /dev/null
> +++ b/configs/qcom_sm8550_defconfig
> @@ -0,0 +1,15 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCM6490 dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0xa7000000
> +CONFIG_REMAKE_ELF=y

CONFIG_QCOM_GENERATE_MBN??> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
> 

