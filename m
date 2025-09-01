Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8056BCA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 07:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97AFB833AD;
	Mon,  1 Sep 2025 09:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="scnOh+Zs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01DB833E9; Mon,  1 Sep 2025 09:32:23 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09D0831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 09:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so783788066b.0
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756711940; x=1757316740; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9K5SNcGrojvRVRnsxYo2sXGurH8ixdsmW6eUxa0Uu0=;
 b=scnOh+Zs3junhhFLxnkalKmvNESDblxliyVAfuC9VdPtf31FVuo/+e5W4qHp/i8weu
 vvMjiVsKd58M4J8mdVHED6jyQTjZ1qQkmcESOdjrABXv4mN44UbSx9N3DvKg3KtULV1L
 TVxEbGD3MTJJcIWYu6EuMFzk6oJo2bzUWL1PQFIoUu+0GFJVu6cy0RdsvWRCt23GvkO8
 Bq/uD/Ehalg7TdatT6ZIswL2x9S7E2tdM31zx5BYsXvUO7amyIXoqGwyY2ZfJZH2qLPk
 uM3qzBOrJZFGgariQaXgDNlbq6PkY0mAP7YGFUlIGTl6uaKsftRO60rmzUozuI9UpCrR
 L1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756711940; x=1757316740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9K5SNcGrojvRVRnsxYo2sXGurH8ixdsmW6eUxa0Uu0=;
 b=Vd6hsv4HbCOaR7gh9PSKgQ4KM9VMjNg4KSQ9Wk/SY8sf1udsHHoPe0NeH9TrBdvSM5
 xBSeeLTfyhq4F9V3iAt5sh+TQAEwA9qTOMFT7yKY8bf8BgyVP8Ckk0e8rUnYjYY+55Px
 /Ww2HPz5TRgESv7ykLvNRoPePdXanA8qdMnR6cY/hpCgxxl6J2LBeg0qkDxVKgb7HITc
 3XNPRCeet0cPi72nxvRP2/T2IAeVXixo7H4mW3nP9c4yOvGOQFO5VvqO7Lwxtc9wWwKC
 hKFy1rN9cuyPELYwFfwvJOHTN79mJYjWIMidH/5mwqbrl9nrN6c2cWLrniyl2GB7KLJL
 wdVg==
X-Gm-Message-State: AOJu0Yw9La8vU/1uCt6MtfWFKHgwiWURg1eJTYp87wcphGdDkBMovMHO
 zl7BmUqXa5KhpnefH7lzNaBmALCZFeXI6ptgklDwmvdx2t2vJ8Bv0fAb8sP0q8r/7b8=
X-Gm-Gg: ASbGnct45S/nsE3OyC17O4mj153ameHj4Zmo6P+eRebBfeMC/oVitvvvVlYdd3SRdsw
 Yze9pSpJyNfjHTrGdvBJmXwNo9kFVjf2y17IxmU2O32ssPicBKPBFO22Q+7A00caFrm4WwnQAjT
 CUZ363SjhIPMweKXe6sK8bJlEMd1bXG8x1C6GB5lpF3yKFYKFmAA2gA95gmq4vnQ2Dcchj7Lx0O
 AdmGplbU715XGeJAS7YbMylYZ2NN+d05u971UnnXMRWwZaK2+IlcQvajI/aPNRxCxYOZ5hVtmC8
 IIBk/l3uXNDaDjZ7kXXGyXOpXgxBGmiOJ9uTXkIkGZOzqkwe2uY8TxJVeV0HPD9HgcIDtOxj2hb
 /OeD5Egu4N24TpBIWjq6iJ4nEeMQ/EvTf+4J1BZ9+lqFN3ghRX2d6L06sUvqS8S3zmniCdEa5sd
 zFh1On/CQJ5x4A
X-Google-Smtp-Source: AGHT+IElqPgAqopKDRG9npZEs27NOGtDXzuobUSfinhkcsFfmogXaZxdmiLK/7zVRg/2fEN62xHSUw==
X-Received: by 2002:a17:907:3fa0:b0:ae3:f524:b51 with SMTP id
 a640c23a62f3a-b01d8a2673bmr720088466b.10.1756711940085; 
 Mon, 01 Sep 2025 00:32:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:786b:7fab:13d3:677c?
 ([2a01:e0a:3cb:7bb0:786b:7fab:13d3:677c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0079183496sm551586266b.13.2025.09.01.00.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 00:32:19 -0700 (PDT)
Message-ID: <1d6f9df7-e89f-4ede-acd4-bb87b5ee1360@linaro.org>
Date: Mon, 1 Sep 2025 09:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: introduce CONFIG_DNS
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>, E Shattow <e@freeshell.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>
References: <20250718104852.724720-1-jerome.forissier@linaro.org>
 <20250827145550.GA644866@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250827145550.GA644866@bill-the-cat>
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

Hi Tom,

On 8/27/25 16:55, Tom Rini wrote:
> On Fri, Jul 18, 2025 at 12:48:48PM +0200, Jerome Forissier wrote:
> 
>> Introduce the DNS Kconfig symbol so that various network commands may
>> use host names without the dns command (CMD_DNS) being selected.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> CC: E Shattow <e@freeshell.de>
> 
> After talking with E Shattow on IRC, lets take this now for master to
> fix the regression

That patch was in my pull request net-20250818 [1] which you merged
into master the same day.

[1] https://lists.denx.de/pipermail/u-boot/2025-August/596830.html

> and in the next branch move forward with more
> aggressive renaming / correcting of Kconfig symbol names (and introduce
> as needed new splits between library functionality and cmd
> functionality, which in turn might also mean needing to move some
> argument validation out of cmd and in to library code). Thanks!

Sounds good.

Thanks,
-- 
Jerome
