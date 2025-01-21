Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A84BC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 12:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8406180326;
	Tue, 21 Jan 2025 13:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U4jfIJGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B161805C5; Tue, 21 Jan 2025 13:00:20 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66250801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 13:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6adb4so11275062a12.1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737460817; x=1738065617; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f9d9tVRM0lFLBr1zd3VMMXTxA4STEBjPP9d+5WU/9Lw=;
 b=U4jfIJGSA+0ix6HPAAIrKKFRPRxADf3PcCdKEUGxTHDSIh7AjhStCD3KJ871QRuuSO
 Y4df1cLQzvq7uSqyJIdiY9YixBZkb8Mg8Arx2Gme+oHbyP/Kcf/9+T/cx+hXgGFj7FB/
 8QR7RQI7BentzfPcK/PZ9voaEkCsMspdiRWLBp4fXziOJqhVJsilLHRJknumUIH3Aiez
 tDmoG1GqTMprHpamP/2U6lIsD4zxlZvNQeCYIPD/N+JA+yllmpExH/94Y7e97bsS9H+j
 gihwfJP1Ck9ze8MQt5WOOWWHs8vgkl8XUZeLIWO/wql9KkEv54RBTDBnK6jfy+H5GxMZ
 7LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737460817; x=1738065617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9d9tVRM0lFLBr1zd3VMMXTxA4STEBjPP9d+5WU/9Lw=;
 b=tos5FjcwwRO/vSsulb4e0Cb2Y8AU291Uv4e6Ionw7I2x+LtSibXXQtkd67tfAs7wT+
 +IbD3Q/DphvHJblA6W4Rv26K4F89viwLgLn1Sd8WuSP28lBpCVEce/Il4OkCaOHYC7JD
 m4woKYIn0opZTk+q62KBGRlF7DC5MjGrzwMn3bMdOdaj9H3eqT5M/oEDLZuZX1nbOnWt
 7uZrQ7pzAh8d79k0WBIQUnGPUje/4rLmIKAti+5iSu/HRZe+IzxVY1GuaIsEkCtAXvqp
 uaKn6kz78RODbqXlJNeKsJFWpUVtxcKFMWZ1rkfjPMFElxKLFeyVSu1F0uJh/HTVSbfh
 R07Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3cKyMK40JZ6AfakAIeubiFnrrh0rv8lLBTjj/zDo8kviVyNZYh+h5SdnpjjmbIAbLOSQvcvg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0DP3v/kLtYg0Lu56/TEMdInZ1hka6k9Ji9CdHZDHTtuHSBwCT
 V8T/QF1Objimh3jI6fEBlyulRmqwafipNExXwL27hESkvrPzrPMgHE6/F4/irBc=
X-Gm-Gg: ASbGncu2g0fqlgdh3UUoB2dw2JsfaW/b6r5aVLGxBdxGjv05s5BvJ/PtZdlTMrJm9xW
 +qRa6aom78QjFmusPnHKt8tfGIRGr4xV6O1/dLeYHtxN0627huZvqQHa1NGTU4+s4IMPH0lUj1N
 4VuZkkc69fEKYno764SLxKgILr2HJoqttxSGzZvhGHoL14JmZyVrh/9cNpwRwmQytfiJiiFwwf0
 a/a0AaSwj3cU5g02jBqnz9YBD4zM4IkCQSuMj3/In0bKl+P4YrObxW4cazgkGUsRuNfYTmmGg9I
 B5E/0yyw56BAsYp9wWs0Ltfl6jSlQWQdvRAEUK5dO/VjihBsLkxb
X-Google-Smtp-Source: AGHT+IGjNoMHDLbv0oixwKkTowlov1Gbn2at7xqK4mBs70F7UNXFa94v4Hq6RCrgj0HBLf8JXJsPCw==
X-Received: by 2002:a17:907:7e91:b0:ab2:ea29:b6 with SMTP id
 a640c23a62f3a-ab38b37cf5amr1613095866b.35.1737460816744; 
 Tue, 21 Jan 2025 04:00:16 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c61276sm753055066b.13.2025.01.21.04.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 04:00:15 -0800 (PST)
Message-ID: <a33678e1-b4e2-43e2-b6de-55618bbb8579@linaro.org>
Date: Tue, 21 Jan 2025 13:00:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
 <20250117-clarify-probe-after-bind-v1-2-273f046ce5dd@linaro.org>
 <CAFLszTi_=S9m54DvKdjdNXf=zOhgg6tog8kcQ+dxjkjQ8BoP4Q@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTi_=S9m54DvKdjdNXf=zOhgg6tog8kcQ+dxjkjQ8BoP4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 18/01/2025 05:32, Simon Glass wrote:
> On Fri, 17 Jan 2025 at 00:29, Caleb Connolly <caleb.connolly@linaro.org
> <mailto:caleb.connolly@linaro.org>> wrote:
>>
>> Some drivers set DM_FLAG_PROBE_AFTER_BIND, this does nothing since it's
>> only every applied on a per-device basis.
>>
>> Remove the flags.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org
> <mailto:caleb.connolly@linaro.org>>
>> ---
>>  drivers/mailbox/zynqmp-ipi.c  | 1 -
>>  drivers/watchdog/da9063-wdt.c | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
>> index 713d93a200c4..851aa737c03e 100644
>> --- a/drivers/mailbox/zynqmp-ipi.c
>> +++ b/drivers/mailbox/zynqmp-ipi.c
>> @@ -269,6 +269,5 @@ U_BOOT_DRIVER(zynqmp_ipi) = {
>>         .name = "zynqmp_ipi",
>>         .id = UCLASS_NOP,
>>         .of_match = zynqmp_ipi_ids,
>>         .probe = zynqmp_ipi_probe,
>> -       .flags = DM_FLAG_PROBE_AFTER_BIND,
>>  };
>> diff --git a/drivers/watchdog/da9063-wdt.c b/drivers/watchdog/da9063-wdt.c
>> index b7216b578630..ec9bc0330114 100644
>> --- a/drivers/watchdog/da9063-wdt.c
>> +++ b/drivers/watchdog/da9063-wdt.c
>> @@ -144,6 +144,5 @@ U_BOOT_DRIVER(da9063_wdt) = {
>>         .name = "da9063-wdt",
>>         .id = UCLASS_WDT,
>>         .of_match = da9063_wdt_ids,
>>         .ops = &da9063_wdt_ops,
>> -       .flags = DM_FLAG_PROBE_AFTER_BIND,
>>  };
>>
>> --
>> 2.48.0
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
> 
> It is actually a bit unclear, since the comments for struct driver
> mention DM_FLAG_... for the flags.

Yep, some of the flags (most even?) can be applied to drivers and there
is no proper distinction between which apply to drivers and which to
devices.

DRIVER_FLAG_... and DEV_FLAG_... or something maybe better, something to
revisit in the future for sure.

Thx for the review

-- 
// Caleb (they/them)

