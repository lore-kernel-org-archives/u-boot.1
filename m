Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D17C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 13:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0C5C60B14;
	Thu, 10 Sep 2026 13:13:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3wwKKq6wQPV; Thu, 10 Sep 2026 13:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12F266087A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789045994;
	b=SwCOQBneT1w6EBMW5+NQYXJ9WRAmkKve9xv4jKKa360OgbV60v2fop02ZrCLz0h+++8T
	 H089w4jVprC6U6hSuWjmowC/NdK00lGfu9n6Q+fphi2AfuQ0Ke0rrVnZEhfO2GWQc/RFB
	 sCTzVRZ2m3/g4yJCZofpnjP7qX7vJNYTPfxjlMR5dCwYS3YEWkN7qSeWB/7O9uqpsalIF
	 dHlzgxQjs1Z4+eIjRgdGbQA5vcYAuw4VZlCrkMu3Pkdxioi+OoDig2E+FL+h2Ool2sfT5
	 vRYRczHpt+bNTYj2QW3Qi80AVkweMSxG1eCcngEZ0IC6QpTM3WuN0QbhriUhQst9iOQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789045994;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kaW76ay1nHmdlRWpZA7gPcKbNehORpL6JVj0OUDDOkw=;
	b=HxjttA5DHzblqdq8+n2yqB6E39E9e/vdlwKO+Lw70dYRAO24M7H7BMTRPp6zOohUjp9k
	 bxRYec6Te3atbw4Xs2wayAw2RDQh9c7a5cvKLQFgQcQA55BmN0qtzP3PJcLXKdTf6x4q6
	 kQXTYrwbNW2/XvEVtoJzssoTv8iMxZ33vl5BHerh2GIYRIrl1YDA5y336/eZF9vwBuIyS
	 vMIgxk3IVxAZSxjlBOp4KwW+PrwRMONY9MYUwGjgobfCxZeQZte34+Uk2b3JD6wdrwvTf
	 ywrmLmfPfdbts3I3AxPIANGeDdLz+APTRQH22j2/Di6Vp4B4i8sEUzmyUNAxJE+WLwQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789045994;
	bh=kaW76ay1nHmdlRWpZA7gPcKbNehORpL6JVj0OUDDOkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+W/e71V+6Y2l6/sn0tU4CQAoRlp5QhiIiKmSPYEzfIut0kqAFxyjdaBiuPmbmXne
	 BYVXUP7lsOcwndM9w9lGvreqtQUPiIHaHFD/mq88vq7q8PweJUnzHGmbJVDFot2WFu
	 10Covqiu6OMWad3lTzT7m1D9f6a9EtXjzj/z07RoJuqeGCbta4vi55/2UKxGK0YoDG
	 m4b/W/iFKcIAyV6ofocOYKurScJqyjRD0OlxAc56lH8p2Ut2+5IHX/xoBf0yWufg1O
	 4jmo+rB8aJtsWv1n+TCpgEQzAtCrFN+NRLEGMFoYhPZEP0+A1o44ucTDtQnH+qVGug
	 ohWVHTT/lV7bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12F266087A;
	Thu, 10 Sep 2026 13:13:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E052B769
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:13:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C50BC80849
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:13:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upHNfokGSP0n for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 13:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AA31D80845
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789045992;
 b=RDkgR9pcWwnwQ0HFmKo2XWu8VNBCSxM1S92WCeR5wIi7NWdwdZT1QFJqS/JoufV6RP6V
 DtyR7v0SGygegqza1sWTGTUtPX7tCMnk089lKCgU2NmXAbaksR3CM8N/UrlGn/xTUjabQ
 k9qMelvmlQSvtZGEfi9ORqoz5ztzkifwYOdUVl6qAtoI41U2PMVoq+UTPGPodMtLYVMz0
 GPw6o9RivwLuXbg2iOaowq6Uo/mXH8t8YFgJoFAl/m6ljhklZ7ztO0nU04VJQ9VleU7Ym
 QNoUtRJ4L+HJpmLGdPotJM7GMMvsJoQuVpyDAmdm9BJuP88e3pA+JOUDqUecSiJWO8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789045992;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=kaW76ay1nHmdlRWpZA7gPcKbNehORpL6JVj0OUDDOkw=;
 b=NddIhzXo686c6+u2SnF6R4OUF1s4ApJRxjg3qbQvOIEiAP79aRL6p4asbePwBdl0+5MS
 ObSaVaTvum9Iu4TFDfVk6LkJxJAZp0x2BMxDEOyfKcQvqTDCjivUVQIjh/Y0xyopGoCdm
 m6svA0V1tObutm5FOIJ2XKzKOzV6fQ6M3628I+J9qAUXLSvLpPTLA2RDJtP2we9qg3EfE
 +Mzui+AP2+BUaK3F6DCkW0RGAyCid4BWnctIw0QDXRIORP2S2XoR0MfgRksFDH78rIwl1
 ffX18jheQ+Xh1SFxGKeesxpj7tbcatwYYny7Xa1WLBrzQvfm+zriVBf8U01kWBI+Ryw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tJ2Lmn8a; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=tJ2Lmn8a
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA31D80845
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 13:13:10 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso1438395f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789045989; x=1789650789;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kaW76ay1nHmdlRWpZA7gPcKbNehORpL6JVj0OUDDOkw=;
 b=tJ2Lmn8a32lMDRGgm1coBbJI4ItDduGGQqF07xkGQL9ykVjNM4jmmIjiFWkFmCcdwC
 mDyV192Oh7PpWeaiGVbJFLC5zHwWlZ4SnqPh19QBGG+Z2EljCXhQ6fismI8ECxqdRVPr
 JsclxRa7qlFapwobci/YQODk228VIK6AgTJu4Tp2wUXe6R5Ex42UNZGwave4371vDtI9
 acUHO2TjXdPigZbUODMzMoMCpCfMSsFIdQSWhc2mjkieqeOcDKkrIrtPAhoJ2SDPr1Lf
 6m0wjRF1JOvPpGt4eDH4x4tLpntDLKfnfzLxudWFxhds/mHx057jwtCCAXIbqcFuhe36
 ICEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789045989; x=1789650789;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kaW76ay1nHmdlRWpZA7gPcKbNehORpL6JVj0OUDDOkw=;
 b=JqPYZ4CKtzAPt8gRDF1JHxUyvbmBLG1aSaityc9e54jSp6nDBaj9N77iO1ZuXbsbfL
 ChAdrGMHwkmaSPnbUwfHHyrIVmEMRKHXZXGhQI2/6v7GEH3QIxEW78jcyL2xkOR2TSTP
 bFZFC5t/2a+oZMCzNRRaYRMak7HII5q/vARiQAmTA+G7Ks1qBmsXQVsReyU4LQiPCi16
 i7EJs5keaw9ns7UfGv7hbuwVEh6x5leDrdYEmalG2UGIS+qr+2FXTKZe1wWbCYmvqrAf
 Aa/exFvrLz3X453Sb7OrBCsZjrRqs/bjJqbtwWBC5+pFo42/F8Cy7vE5+Duq7W2HQ58H
 v3ww==
X-Forwarded-Encrypted: i=1;
 AKwUvByLRu3KlVMFUo5jCN+afnPe3Bxkp7ZWhbeXfgbnXwC2GYv8BgNCwk4bMkm8Bt99/ZF8A6NP9RE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kr6TEzMrheFU1J6v7PocKL7/jYiW3MwrmJmz/ELjOcp7Cqac1P
 Xl3Y11TFZJJTGaUCReyrksrNZfEKmB80P2zSaY4A4R/r/lLTzIFygVcBt8iyqvXNt9dAU4p0kxO
 BjC38
X-Gm-Gg: AYBFou2Pr60cDD4Sq4ZRc+8BM6NEjAVb5ZXT9V3ZYRC7Y82S+q+wUgpPuM31tmZU5xE
 fPLHzgebjrvlb6vhn8ULGMDJngVWgFz9L8AInj909vhHlznq60XPbYML1o86ef9kQvqfQspH2mu
 TqQHqecCWHsy9BLdD2sX9TS+WTrwPSUDzv/aoRHy4Vs1w5EzCJibohJN5dEV8tkGXMUqaELsvh2
 YfyJfv4bBYPXh1Gd3+gABWuIo8in0fO5/wjWU6fVjd0mEAt7Q0Irh0ODIt4J+pQYnZ0aDQCtAUN
 PtWbtWX4rIK0UYcEcqHPMQbIE2QUz0t5qBuacHFpOfzlkcroriAEQ23WtmR9XgoLH3G+MhWxKGn
 6pNBRIBc4UsUo3wEyLKdK6wJa4pPa4tpBQr92XEc3/XnnfLhO+xkQEX4AAOJpXJ73ooQPzTyZo5
 58dIwW1lozF+crf1RSTPuPdboPk6mbsLkZGPDojJm6BYNH7/B418CJsx5K5HM+yEbnncA/zyyue
 GnU2Yv1veF5
X-Received: by 2002:a5d:5d83:0:b0:485:b148:aa2a with SMTP id
 ffacd0b85a97d-485b148ac34mr14335088f8f.23.1789045988715; 
 Thu, 10 Sep 2026 06:13:08 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.114])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d312ca0sm53695881f8f.4.2026.09.10.06.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 06:13:06 -0700 (PDT)
Message-ID: <26abc75d-6d6b-4b29-b806-8514762f1f01@linaro.org>
Date: Thu, 10 Sep 2026 15:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: board/qualcomm: Fix kconfig formatting
To: Petr Vorel <petr.vorel@gmail.com>, u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260909183222.220855-1-petr.vorel@gmail.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260909183222.220855-1-petr.vorel@gmail.com>
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

Hi Petr,

Thanks for this!

On 9/9/26 20:32, Petr Vorel wrote:
> Fixes: d9252fcde12 ("doc: board/qualcomm: document generic targets")
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   doc/board/qualcomm/debugging.rst | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
> index 42821f6546c..fb6b0d397e4 100644
> --- a/doc/board/qualcomm/debugging.rst
> +++ b/doc/board/qualcomm/debugging.rst
> @@ -18,6 +18,8 @@ Newer boards (SDM845 and newer, those with GENI SE UART)
>   
>   Open ``configs/qcom_defconfig`` and add the following snippet to the bottom:
>   
> +.. code-block:: kconfig
> +
>   	CONFIG_BAUDRATE=115200
>   
>   	# Uncomment to enable UART pre-relocation
> @@ -42,6 +44,8 @@ Older boards (db410c and db820c)
>   
>   Open ``configs/dragonboard<BOARD>_defconfig``
>   
> +.. code-block:: kconfig
> +
>   	CONFIG_DEBUG_UART=y
>   	CONFIG_DEBUG_UART_ANNOUNCE=y
>   	# db410c - 0x78b0000
> @@ -56,4 +60,3 @@ Open ``configs/dragonboard<BOARD>_defconfig``
>   	CONFIG_LOG_MAX_LEVEL=9
>   	CONFIG_LOG_DEFAULT_LEVEL=9
>   	CONFIG_LOGLEVEL=9
> -

