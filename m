Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D0FCFA773
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F7E88B0A;
	Fri,  4 Oct 2024 14:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sA59mwSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B26B88B78; Fri,  4 Oct 2024 14:43:13 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71A6588AFF
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so17883405e9.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728045790; x=1728650590; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=soc+Vx70ja8GTV/MYfzfale+0qPGEW+X+vmjgZMqoNo=;
 b=sA59mwSlN6ENcCsIjxLpt76DZ6B/SPnqQQTh/ufgnKUN9BGE8kXO79D5dyC7nu4MbH
 E3Desr8gY6ia9hkPT7zlwI6I738avF52r0TfuYYwdfu9Vzjkn0e4x56egsZOhka5YaRL
 N5Mve1iD86dCTgav8GY6Omd8ht5Du98cbW+weRwYWLGobBA7qZg2o3MtpkKLN7Uw7qmq
 lC6dFrNd+mEdxHpdFtb7MIObGb4Pw4zawVfO0nwzsAOx1ED2PTmQ9aS9coUQllPIm9Nw
 B2/4Lf3hkfWWQfwJx6Uwn1L3griI2BCN0l7/C31f/JeCWk78UCQhFbCTejan0YnRvtXd
 cTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728045790; x=1728650590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=soc+Vx70ja8GTV/MYfzfale+0qPGEW+X+vmjgZMqoNo=;
 b=KVe35CklkpB/XsgtmprZv1ImcKNjPLM/Yh9h0h0wHgOYo2fsij17Fh6ZvkrfkWeKqz
 1kcvj9GQdxzaO4TQZ94Gjhx2kuvIvzHMhkbDe+fg4bGRZ59Rxv2rP6r79B6P16yEO0Ti
 cALosFQNQK0L6bdEBwUiETEtUQZmKZeFijOddcCWwb/B7Vff5wfwN7DrGhCyzkUJhOxm
 iGSVv4ytrTCK6cCRll+X7d33m2UbRJ1UDtys+5we9A4faxgQW/x+zWUt1ChrII7emb5l
 fAH6x6C/fYbKxuxd23lcLgaNeW2WKjwEXlouhRntImKW0c74VME7lR7EJw2zQdzThJYg
 /Xkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb4zgWiqqWrD8/9X2x5pyd8r9YGut7WvZxH3wKw1heaN50mNt0J3FqX5yMEbPBtsXKIqCyNmA=@lists.denx.de
X-Gm-Message-State: AOJu0YwZBeqK322i+pnVuCMfAztar6YDI3hPtlaiV3WOrhFBEgR3dT/x
 ZJJJpWxGiMJsZnEbXYwHU5ZB1XlXiF18WBa5i78DRRu6LJiOZrayaN8Y9HJCEug=
X-Google-Smtp-Source: AGHT+IFhROAWt7YKAI3XmUFyv/c4ukf897TBzJ+3feSdlDIFMXzKHivg2+/UfDdipm23CFQ/Sbh80w==
X-Received: by 2002:a05:600c:4f86:b0:42c:b3e5:f68c with SMTP id
 5b1f17b1804b1-42f85aa6caamr18097735e9.4.1728045789876; 
 Fri, 04 Oct 2024 05:43:09 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d80esm14815385e9.19.2024.10.04.05.43.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 05:43:09 -0700 (PDT)
Message-ID: <6485a86a-2d52-48c3-96f5-514f2b21b4a0@linaro.org>
Date: Fri, 4 Oct 2024 14:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Qualcomm smartphone support
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
 <172788075725.935801.3270533991443988203.b4-ty@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <172788075725.935801.3270533991443988203.b4-ty@linaro.org>
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



On 02/10/2024 16:52, Caleb Connolly wrote:
> 
> On Sat, 31 Aug 2024 17:48:50 +0100, Caleb Connolly wrote:
>> Improve support for running U-Boot on Qualcomm smartphones, with:
>>
>> * A boot menu which can be entered by holding power during boot
>> * Hang on panic (so errors can be read on the display)
>> * Serial gadget which can be enabled by holding volume down or via
>>    boot menu
>>
>> [...]
> 
> Applied, thanks!

This was a bit pre-emptive, resending this series to get acks from Tom 
and Simon.
> 
> [1/4] board/qualcomm: introduce phone config
>        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/bcb278fbc218
> [2/4] cli_hush: run bootmenu on retry
>        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/963c141c3195
> [3/4] bootretry: check for bootretry variable changes
>        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c2147f6b396f
> [4/4] doc: board/qualcomm: describe phone support and bringup
>        https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/12901f5bff70
> 
> Best regards,

-- 
// Caleb (they/them)

