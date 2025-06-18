Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC91C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F34282CFA;
	Wed, 18 Jun 2025 15:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="HLB4wWtJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E3482BCD; Wed, 18 Jun 2025 13:11:27 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0829582B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 13:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-607c2b96b29so13300948a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750245084; x=1750849884; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8KV4Ldq7Q4VfopwhQQAZEUQf1mYlRVOGVGvwY767cM=;
 b=HLB4wWtJwM6r4Mu99E0WsHy10oJx26mVAbyySQMjNos0P9e8etl+BTsIXwLsunMojx
 kIpAykZj003P463ui+DXl7Ub8zTDdzcZSRsxB+uask+nJRTp3N9dus12pPJ/GcxBxFam
 mnlxjkruVGGRdG8a6OklZ9RoBLvEsEGverhPwjKRalFjPd/B4gq6Je0LbFFDrWh4X69v
 MkPYMLBivokQtWGRlo0Eiq8KLQ0Zn72l7XpejmQ/UR///udDF2RQYIwvFxEpcbkTlqoB
 JDlT4t36asD0petDNES7U5FLknE4TcmgYUWprh/YrSBXPEs0U6HDXgXAF9IaEDgHsn81
 VZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750245084; x=1750849884;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h8KV4Ldq7Q4VfopwhQQAZEUQf1mYlRVOGVGvwY767cM=;
 b=ivFLJvYb7/oBGWePNIpHjiC8oVRKhuPuT7XjZZgX3izPrM3sTpmU08TD5WLv8hf+Sz
 LxuARTC7qSwgd29v+1EsY8R7jImXOdOKtYHEKST15SkBxt2TgT5oPozSTfXXLTnTPdFz
 FtyzmGCL1+EJb8DwfZdA+7PybBWLqyZ5XRdSxrYIhZ1JY50CpnofTrQGbmkjPjkLc3GM
 8O3pQ0t8gjfAVmiZOXBpQDoG5xqyDXFM6LmR5c/llrpZmUsgPuhxgYnsgtFH4GTWAjHI
 oe0rPSrEl5m5KCs1T7BKXdTTWMWQAB6ocqR8q1DSvGMPHmfX+i+soMTd9powsRW13VPW
 icrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO8ZMX3qQ9FowfqtyU0PtyFo21JmzkHNm2tEMAQtYYf200YuTdZnOHysmMaa22+vuOuILe+yU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/0g0TmtvPX9IBw6o9augxBU/mYD+W1+kPHUVaQmqJSrrI3GtT
 N4iNs9jvL3IVq7SzL3RM4wyeuEK8PTid9kcC0UhOJSbpNpv+ZmYV6zG770p6ZPph6js=
X-Gm-Gg: ASbGncsFEv71Qs/83mVQyoPN15qZiPx1JtlhtW8PwGwjdKbU05Ad/wPei24FXoD+Jy1
 wocQdX4mE0SRtiLbPZ7NRU7IMKqycI5YOtEv7JSc+V/HCMnRg0Rrpoe7jLgt79NSlCdidpIp9zx
 S3AM1/0SDfFoORP44w4uZxF/KXggVcsVXTrZNRbObpd8SEHNQ6EEZa6mF0D1dZ800b0cu/xLcb4
 3m+GZSG1p/Bz3bvoHkqy8r6ns0IZqWcn5Aoee8+ArpmhGZXOTnHFZN1PF7Enw0BUt42oqJnrefh
 3IZqVEhh9Oj5dPJGonwbDpN/Jn+PASMe8zC5wn816xhrtKeGpRlCHyZGfFE593ScT8A89EeLR0U
 GSQP8OhXkNUyhOUBJvbRfJ6M/g8v/roQ=
X-Google-Smtp-Source: AGHT+IEQIp0nIVIgRN/iDGspnT9OMgVi+WwCgBhQra1gnRvQCYDKON8E2aM95aGrjUIGZD/DfKIS7w==
X-Received: by 2002:a05:6402:42d6:b0:608:47e7:508 with SMTP id
 4fb4d7f45d1cf-608d0890a94mr15671632a12.13.1750245084388; 
 Wed, 18 Jun 2025 04:11:24 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b4ae4d18sm9236945a12.76.2025.06.18.04.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 04:11:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2025 13:11:23 +0200
Message-Id: <DAPM3N6M8HZK.3139OVRBRU92O@fairphone.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Alexey Minnekhanov" <alexeymin@minlexx.ru>,
 "Sean Anderson" <seanga2@gmail.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Sumit Garg" <sumit.garg@kernel.org>, "Tom
 Rini" <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
 <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
 <267f957f-f74d-40f9-a65a-da00ea12810c@minlexx.ru>
 <DAL7BBN0YH1Y.1HOHC7JM44TFF@fairphone.com>
 <6857eb08-c3d8-4a02-b8c0-b608977ffea1@linaro.org>
 <DAONZND9ACD3.35GQ47V0IVE46@fairphone.com>
In-Reply-To: <DAONZND9ACD3.35GQ47V0IVE46@fairphone.com>
X-Mailman-Approved-At: Wed, 18 Jun 2025 15:50:29 +0200
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

On Tue Jun 17, 2025 at 10:27 AM CEST, Luca Weiss wrote:
> On Fri Jun 13, 2025 at 6:55 PM CEST, Casey Connolly wrote:
>>
>>
>> On 6/13/25 08:45, Luca Weiss wrote:
>>> On Thu Jun 12, 2025 at 5:49 PM CEST, Alexey Minnekhanov wrote:
>>>> On 11.06.2025 15:08, Luca Weiss wrote:
>>>>> Update the variable name to sm8250_gcc_data as it's in the sc7280
>>>>> driver.
>>>>
>>>> Hi!
>>>> But why are you mentioning sc7280 here, while fixing clock-sm8250.c ?
>>>=20
>>> Copy paste from the other patch :'(
>>>=20
>>> Will fix, thanks for spotting!
>>
>> I'll fix this while applying, np (already picked this patch up...)
>
> Thank you!

Quick process question, how do I find out if a patch has been
accepted/applied? Am I supposed to check patchwork, or are there
b4-ty-style emails for it?

I'm trying to keep track of patches in my inbox that are still
outstanding with labels, so it's basically about when I can mark it as
accepted.

Regards
Luca

>
>>
>> Thanks>
>>>>
>>>>> ---
>>>>>    drivers/clk/qcom/clock-sm8250.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock=
-sm8250.c
>>>>
>>>>
>>>> ---
>>>> Regards,
>>>> Alexey Minnekhanov
>>>=20

