Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C16E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BCD38036B;
	Wed,  8 Jan 2025 15:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zWWQeFz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17269805E9; Wed,  8 Jan 2025 15:46:11 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558DE8001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so2449203466b.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736347561; x=1736952361; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cDayWFs0GZlNkDWPf8XDevSShYcrt+6lVhqLHyHa4E8=;
 b=zWWQeFz1DtY8QnQRdVzScWZBIfBNrON/8KpuwWr/ONtDlx8a7kZK9LULmiEz5Jw5vJ
 efdpousWdKdBbmRgz7JMLS7UdtsF8364976ub2lMePNxkuLcqu1gp9vuRoR07YV3UJlY
 536K52MB1LES6OJO+oT2SnDwyeZi+4KPiH50AwoOLs+QLfReQ0MgDWS7P/43Sgok2Ew9
 W89MLMjHGoF7JP1esajFgUOHG6V9CuiU6E0fODOMItRxVcpriteldaZYnzR08WrV9lpd
 f4c9Ml7cObhQZ+FM5XpkjaeErxLrM/ql6+gH0h4SuyBKrJePusRC/897IUkUGoXPz7T7
 IRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736347561; x=1736952361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cDayWFs0GZlNkDWPf8XDevSShYcrt+6lVhqLHyHa4E8=;
 b=ciQescJNigvQLjffa43ghkTxihRz27QyEcImi/k6yoULeF8OrmsG0SbrklASGSDqVu
 4A/BmjrqUjjAf1xA74fucgeaDJ+v5ZkrDN36LR6LABx7sOr8CsAnMCZ1ve5frDwABrIU
 9FNrp0ta6SIvyuxfl3w2OWyJpqT8Gqg6fKQHec8B7+jBw4uq4dQ+e/RBskN4sTlSNMXj
 7y3oXV1TJSbZd7cq7p0toQS7HobEKIRwc/Ej5P5Dnri6Lvts0LBi6R+UOtrFO6KtgSvj
 aotH862W57qDwk0uSmoRA7DSkjJKLrJKEkSoGiAYYt4vw6vPhP7/j95OWtV3LK4iwTl4
 89Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwwIWkazrZCJiL+VvVox2r+oW+ShrEk2rPOClWc0+t8gAjetn1RmvhYqnDYf/ji3Mafx/6LHg=@lists.denx.de
X-Gm-Message-State: AOJu0YyEUnviyWrnaWNF3IyJ6X4WGLywAtiopmTg2VIVZWBRYuVPJDWb
 CKyWMymyVOynztUjO7xXboH7CbJrpii9S5aW9KxG+vj18Ozpra6ebjZEkjAqQpI=
X-Gm-Gg: ASbGncuSGOemM33RlDiOGKrMP6bc50KSDQU+dF0IrRPEU8T7k7ho6NRKCztdiWBfze0
 LxHzjc9nGxj1+7OL9eJW7rJvNYgzHfaEZ7VAvbdicpPbz3Eu6xr0lUhj+Vhl0VU/2ze6DQZnpol
 TZDpHP+aN5bK55zQ+xeuCj0M1slYY3apu2A+KYR+iYK6tCMhBulwQxVwImgXm2pd93L7/W7fhHq
 47wGhQs2n6ZwnQ/uEIn7GNHXLnsovXFpMwt5xB9JN9eNwQcAi/8qSvy61UxPZ2wfXVqFPHTIDoH
 wIttmA0dlq6NA0mmKoi+B/uRDXuYxzKv2QsKCi0=
X-Google-Smtp-Source: AGHT+IHZGQfpD9ghiDtPMQ8pjtTFbTFD3NyMkivu88aT/tcUD/rSm4ltNb9r6BJrQe1eTTx/xfxOkQ==
X-Received: by 2002:a17:907:94c8:b0:aaf:7321:f05a with SMTP id
 a640c23a62f3a-ab2abc6e773mr265796766b.46.1736347560611; 
 Wed, 08 Jan 2025 06:46:00 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0eae4345sm2501376066b.84.2025.01.08.06.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 06:45:59 -0800 (PST)
Message-ID: <32d21fa8-9ce7-4c16-b7fc-d45203f58de7@linaro.org>
Date: Wed, 8 Jan 2025 15:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] soc: qcom: import smem from Linux 6.11-rc2
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-5-b7852c11b67c@linaro.org>
 <CAFLszThqZzZYyQ5utstK1RO-nHbvfEELDmunsCZAgQbHqp=bnw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszThqZzZYyQ5utstK1RO-nHbvfEELDmunsCZAgQbHqp=bnw@mail.gmail.com>
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



On 07/01/2025 16:30, Simon Glass wrote:
> On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Import the SMEM driver from Linux.
> 
> Which version / commit hash?

It's mentioned in the subject line, I took it from the tag.
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/soc/qcom/smem.c    | 1279 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/soc/qcom/smem.h    |   20 +
>>  include/soc/qcom/socinfo.h |  111 ++++
>>  3 files changed, 1410 insertions(+)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

-- 
// Caleb (they/them)

