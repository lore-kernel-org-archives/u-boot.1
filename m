Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60385C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 15:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75CA3878C9;
	Wed, 10 Jan 2024 16:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gq7TaJcJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58418797B; Wed, 10 Jan 2024 16:41:18 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA5C878E7
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 16:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-429b7910697so3875861cf.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704901275; x=1705506075; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9SArZp9pMAmgP2iEITMdp9D0gjBrKMnw6hOYYl6CohA=;
 b=gq7TaJcJiHVdU1oHYoH1+yGA/XGmLNNEMqt2Gn4Aqv/kC3bQdrBwYf6aguyKGb1luD
 P15A16YitEDBB0upnYxwLe1Gt1vA4+Y6m7dstHQzA3IqrHzpWl96d6k9iHNbfTrLmk3K
 jGp4QCPw9lppVWVOh2feyJAvy6fVRyjpH6CxmnH6kIpZlXV1lnPsT+LEq42rXOJm8oHK
 ZrtGquRKKWIoiYJPCHztTAuvl6f7J6N8h0a9t9iOv5QHLlC0j8v1S0HgRT0UnA8w+ptI
 GzSYDg+ybGvYdcc9UEf4vy6JahIeBKQOZp2MFK/cWtKETRmwu5lzn7UEMTI8b3LfQTjW
 +Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704901275; x=1705506075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9SArZp9pMAmgP2iEITMdp9D0gjBrKMnw6hOYYl6CohA=;
 b=YLhJaWhLekjB3iBTrr4p/8fd1WPhzz1Fwg/lq/N5EeAGYwEgizij4L+Ge5hl3cbMQJ
 NDFOzz1prwOZznlYJEOhXbrWCCFLOQbTmOGUR4bPNl7rI7aGsASifLus9TnxiXsFiY04
 cBFvEU6o1ls/LALWt3bTdkgfM4y8zluwrXNce2bALjIXha/rFvmwDr0gY80Tbn6K77hi
 zgmSyaylripZBK00K5KP+Y2empcwCI+NkB05VC8brVuvXAyHH7zw4ryx77OP4DgV8uQc
 6ZxFzRUaLLEwm4suTzBmuMj8ZDSnaa72u45EXJjj7EG6hKXQEbUo2i5R290VTmpFoH4c
 BjAg==
X-Gm-Message-State: AOJu0YzR+xwCRYPTjPL/skJ3tSdIzWDgdKXwrp8boGVBDAfswl3JiSGu
 4taWCFfK3UgYOFHc0ki0/x0=
X-Google-Smtp-Source: AGHT+IHZqgJt+HI64+jyhpA8MyD8T46LfOUm21Sl0Nem7wr+EP2h4Ws2Oz47LANOlmNJnLLRH2PucA==
X-Received: by 2002:ac8:7d0f:0:b0:429:b8cc:8697 with SMTP id
 g15-20020ac87d0f000000b00429b8cc8697mr391469qtb.36.1704901275531; 
 Wed, 10 Jan 2024 07:41:15 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ge8-20020a05622a5c8800b00429bd898838sm85494qtb.47.2024.01.10.07.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:41:15 -0800 (PST)
Message-ID: <fb51d65c-7fc4-d303-a09e-4b5aa69407cb@gmail.com>
Date: Wed, 10 Jan 2024 10:41:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] clk: meson: add Hardware Clock measure driver
Content-Language: en-US
To: neil.armstrong@linaro.org, u-boot-amlogic@groups.io,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de
References: <17A1E40D16C3C77A.26427@groups.io>
 <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <829ca7ca-0da6-468c-a70c-d0bb35a57fa9@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/10/24 04:23, Neil Armstrong wrote:
> Hi Sean,
> 
> On 18/12/2023 10:47, Neil Armstrong via groups.io wrote:
>> Amlogic SoCs embeds an hardware clock measure block, port it
>> from Linux and implement it as a UCLK_CLK with only the dump
>> op and fail-only xlate.
>>
>> Based on the Linux driver introduced in [1].
>>
>> [1] commit 2b45ebef39a2 ("soc: amlogic: Add Meson Clock Measure driver").
>>
>> Reviewed-by: Sean Anderson <seanga2@gmail.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Should I take this via the amlogic tree ?

If you like.

I will be doing a PR sometime before the merge window ends.

--Sean
