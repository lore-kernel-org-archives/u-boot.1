Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696CCC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 10:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEFC883F5;
	Mon, 22 Apr 2024 12:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="enWjMgjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF06D88418; Mon, 22 Apr 2024 12:53:12 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF45F883A4
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-571b1434592so4556216a12.0
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713783190; x=1714387990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BtlDLg/anlJdQvnFulnSjCvjivWT5Esag+0sJrrLCZQ=;
 b=enWjMgjSjsbJrF4Wd4ik9sAfN9fel67VKm+JNlAjA/Jc/IUivDAs8PK+jW9JNUg58W
 A/4NlnDmhbKNgKnaCyfdHTHMdeBUDOyqCiRTQ9kSjDHYfGQh/Z8129clwsSgbDhOPTBp
 L37jHQ5pBBHSJC+Dkd7rZT8zlHm1wiAX/6JX4JgAGhPU08o8evTOeaPgq+2/PJUYCaV0
 bQNnmisnc2KXdFAQ3eLOnDTQZralOWOokG6qpSKj1CEYaMld9hoayRDsj68I+SQ+2iGy
 e52QmHrlQcExegqmMblK7h3783WxNnvlVNh4Ro18Dk/X3aQcxZMqTm26lAnu0U9Ecmao
 5vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713783190; x=1714387990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BtlDLg/anlJdQvnFulnSjCvjivWT5Esag+0sJrrLCZQ=;
 b=AzHkLTJ0b1SqdCcKpTqTykBEdwK27vH1xTtdxDYAncnRieGeNyFmQhHNcx1Gj7l7wI
 Zpd940bdkgVhXu2oBi94biJkf1uJG9LcLNt6bew4VdGdiwtVIDfLSImfENApXgS3lOLJ
 aDBoMVIKAYkiCupxZGZ4QF9b1k2ae5IOCYt7WGYKadauNoD+/Gg9nVNWIIAm5y5NvLnp
 8L5UFN9OnGqZn3mUypmi5sunYepkyGvjRlMuz29THngMCA1JzuXmqnSpK5p5a5UqITX6
 xQAWs20DxM5B+blt9S3TNmOCjO22TpU9L7qZnkY3tOA9c6tsO0f4QzXf7HHgHSHQDX5D
 trNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEys8SZFQoetRrLHIjCsgljbU6HKYowT0SNXiqq7AeMPrH330QqnlHY8NCtkI9Bv7OQ2G/cpcbUVl1FO9bu85GuY2/og==
X-Gm-Message-State: AOJu0YxKVmyvlUGtb/TQIYOyDA9ESshEezeLTIra9wXeN17+N9lngBt/
 95sUa+2io2Bd9NvNpBi94iJUXI7cLcPrP4UVhA83ki90A1YI3G8pDTrdOxpB8uk=
X-Google-Smtp-Source: AGHT+IHbYa/SjpxiOrXvlH5IAAVYRw3MQvr6Pl0wT2hORTGipg2VuVaQrkp4qbrcXHOtZP2+fXWqmw==
X-Received: by 2002:a17:906:c04e:b0:a52:42e4:96e5 with SMTP id
 bm14-20020a170906c04e00b00a5242e496e5mr5991898ejb.6.1713783190258; 
 Mon, 22 Apr 2024 03:53:10 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4716? ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a170906110600b00a5827d2f6f4sm102288eja.115.2024.04.22.03.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 03:53:09 -0700 (PDT)
Message-ID: <66f19871-1c7b-4b85-a924-42ee03c1f241@linaro.org>
Date: Mon, 22 Apr 2024 12:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: support USB 3.1 controllers
To: Marek Vasut <marex@denx.de>, Igor Prusov <ivprusov@salutedevices.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
References: <20240411160527.835767-1-caleb.connolly@linaro.org>
 <9793571e-fdb1-41d5-b967-948dabe9bc4a@denx.de>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <9793571e-fdb1-41d5-b967-948dabe9bc4a@denx.de>
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


On 21/04/2024 22:38, Marek Vasut wrote:
> On 4/11/24 6:05 PM, Caleb Connolly wrote:
>> The revision is different for these, add the additional check as in
>> xhci-dwc3 core_init code.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Is there a matching Linux kernel patch , or does Linux do some other 
> check ?

I just took this change from the xhci-dwc3 driver tbh... But I did some 
archeology and it seems the associated Linux patch would be 690fb3718a70 
("usb: dwc3: Support Synopsys USB 3.1 IP").

-- 
// Caleb (they/them)
