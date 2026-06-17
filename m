Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04A8CD98F2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 15:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D34484833;
	Wed, 17 Jun 2026 17:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WXXSYQ0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D08848EB; Wed, 17 Jun 2026 17:07:26 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD09846B0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 17:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so43492735e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708843; x=1782313643; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M4kMg99vyUMcHCY4P77cHcEjP/FIp+sBvZYnwTD5Nek=;
 b=WXXSYQ0l9QCjdGvIKJ9YJm90F2XE2CdOVU49D49oTBNM95ibVDCArHfQKdjukDJ+HC
 MAzD1cS7xayffrkkc1BJMvzPrc/cr468AsW8B8rvImFueBEQEFh8deAotn5cN5GwCUgc
 lf1U6QPi/5RsglALUpo0GWYwAT7PTqZwyD8tJWAsrl2m4e7uvDe3eCO4RMot1d3Vq2ij
 mc+ZAGg3jR89WCpLYbqv58MLUBHZsu9WIDBRP7Pch+G6WSE/HI6Rob3nPFL1T72EpweH
 jZfuOptZq9sJCc6uUW/Kl26v/UYSqVCennHb0d9t72XOGpuGWYUgePTDflgGEWiTuzD7
 SinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708843; x=1782313643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4kMg99vyUMcHCY4P77cHcEjP/FIp+sBvZYnwTD5Nek=;
 b=Qh7WbOyP6ZSLi2Eih2jJ1FQ7EFUsrmJJ77iiqIhT/F/4UKfUW56QAlZOiD0eCh6eNq
 ctjOLDwYYTpoq6JRXAMnXz9TFjmImgz9q2liH+qzUKJRY9hOlnEQ2oZ9CO7hBb3FMal8
 OuImV2HNNkrsmptyJ5JN2J9BjG2jzqI2b6qA5d+we8jKgK0xBHCIiQ6ZTzk+Pp0Z2IJS
 UCwFqO2Zy96hrNworUv5ydxvc2ozCs6Y/pqu1zNtctjYENzM1go2N0LkOvGxugqPvIsA
 BmYDMS8d9Fm8E1LA7p9TxSj4PwqZmvy8jQ9KJEGLMSCXLDvTl8WXQwkLx+s7c1W+WU/8
 zcWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oMUIrpLt9pDBQAFz4RyNMUEjzS744FGIrSwDMTg/prHdNRz0MCwQDB79sxwUg/e0p/CeHW/I=@lists.denx.de
X-Gm-Message-State: AOJu0YyOy7yCsaHoXSWh62lJm3tdecvTwLNGqOr3GNK/r49F8JSO/ozb
 FJItaz+yYUquMQjY3SyIpYXNY2F0+BxQ9xEePPzQeBibILmRXnFVb0MHyQJ899fTYlE=
X-Gm-Gg: Acq92OHWD66DmpeioQOjeHcrJJ45FBl755wf4+07r0K3WCzc2VoaUKd2F865VYTRsy3
 5X7F506yg5J6hP26ULYspG3MuZHoYmQZrPpzkbgmI7tQZGXJVxAyyKRx4TWU+p9AWRa9Y1mceh4
 VwMLLEUHnvMQgGI5B5zKNZw4gVFGPdjrcTMFtdtIOgkIaHeKjONZrxTpsjUX6dxQo1hd5Z3TAtU
 k0MtW0bdEJie9WPNyk8NpQOXWQRyQ+5KCzgU9H/8tmRYOt7Fiq0MD6v2BmcmaIpi6WM8m7W2Jsv
 oD2oCe1m0JrACxUW6AM+Qrz5WnbI4dE1mEN17DsyXXPpjIH3jgA886lZlrZPgFYdPdFe/P+8aG/
 w9klfr72nU9BZIG5qlTZn7yLKUgOQRjqyEz0mafw5P00soHfHy+OlOh8PouqFCbW8tFFCOXZ3HY
 ydcoR7aOYLtsqNz0WqySzCE4YwkdlBBMrM7nN9S652IjdkH48xKLBbMQZWml1o1q0=
X-Received: by 2002:a05:600c:820d:b0:490:4b89:5361 with SMTP id
 5b1f17b1804b1-4923678873cmr23562695e9.7.1781708842902; 
 Wed, 17 Jun 2026 08:07:22 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619a041986sm29969427f8f.23.2026.06.17.08.07.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:07:22 -0700 (PDT)
Message-ID: <095e2faf-1f06-4139-bd9b-1d278b60ddff@linaro.org>
Date: Wed, 17 Jun 2026 17:07:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
Content-Language: en-US
To: u-boot-qcom@groups.io,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
 <tgqh8m.i5334p2b63jo@postmarketos.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <tgqh8m.i5334p2b63jo@postmarketos.org>
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



On 16/06/2026 18:42, Ferass El Hafidi via groups.io wrote:
> Hi,
> 
> On Tue, 16 Jun 2026 12:26, "Casey Connolly via groups.io"
> <casey.connolly=linaro.org@groups.io> wrote:
>> Hi Balaji,
>>
>> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>>> This series adds support for running U-Boot in snagboot mode on
>>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>
>> You didn't respond to my reply on v2 of this series.
>>>
>>> Snagboot is an open-source, scriptable flashing framework that provides
>>> an alternative to the proprietary Firehose protocol for device
>>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>>> and execute bootloaders. However, instead of using the proprietary
>>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>>> standard fastboot protocol for device flashing.
>>
>> Glad to have some more info here. Please also add a doc page with this
>> information as well as a list of supported platforms.
>>
> 
> I suppose they are talking about this snagboot: https://github.com/
> bootlin/snagboot
> 
> But what's confusing me is there is no mention of any Qualcomm board,
> nor any PR to add support for it. Is that in some downstream tree
> somewhere? (to be clear I'm just someone interested in understanding
> this better, snagboot is a very cool project that already supports
> plenty of SoCs and it's great if it has or will have qcom support)

ah yep, there's a fork here
https://github.com/qualcomm-linux/snagboot/tree/qcom-next

Balaji: it would be great if you would include context like this in the
cover letter.

Kind regards,

> 
> Best regards,
> Ferass
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#3922): https://groups.io/g/u-boot-qcom/message/3922
> Mute This Topic: https://groups.io/mt/119832159/8413174
> Group Owner: u-boot-qcom+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-qcom/
> leave/13197796/8413174/1557304080/xyzzy [casey.connolly@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

-- 
// Casey (she/her)

