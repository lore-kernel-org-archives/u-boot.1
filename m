Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56462C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E7C87883;
	Wed, 13 Dec 2023 21:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P5WZdp76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940308785B; Wed, 13 Dec 2023 21:39:17 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B9487867
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a22f59c6ae6so180384966b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ToR2fK00KDbaoTny980w2bNbQeePJSjAI90gyJXtDmg=;
 b=P5WZdp76oxQa/OFWyvUNs6yl4ZP1LnrDJYexCnyV5DeC54p6ogUH0XyAFsTZP1a9EA
 cnklEA/KaPcqKmfEA/kj4xAiHJR0YBhv1kraxF70WxE30pj5gZXehzloyX1d1BuM4h1J
 iRBVOKU0StGvuvW0IcZHVq6rtc7b+KDRRTQlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ToR2fK00KDbaoTny980w2bNbQeePJSjAI90gyJXtDmg=;
 b=UVif16GQ7RHj++u2YCKsgqPWeDue5o3anZJA03/MykeUpQ6QJIx+9iayw/cmx/msXC
 mOKFOCgn9No7mqxvnvRuiJE+X/wPUYGdcqQ0aC0dMSP+SQRfPS+sdJEDyFzxNPlD0qvl
 5k5H47CbaU+GNu5xQPSt77bLwOPr0UOo83PPBbpoQfCsWeEVIvrinNtLg86lY2ga6sw5
 CVLwONG++r0zjJryl04vauMoeq3cTKOiwvSopqfefpg/F2YgCUlgvwUTUrIdh0IHVRNx
 6AxNBgUF20FWcUNSL7LzL+1vluYJtsWHv4tgEHlTg9WwtxhlIwzaFIA8GwXk71D8ulc+
 Q7zw==
X-Gm-Message-State: AOJu0Yx+/stRmYCavH0KFbrUnzQz7okOXsB1xhJVkIjrgmTXSoydv8b5
 11op5MHNy4uqmx+kD4e4/ADv1fNvhH44QOk2ulFZxg==
X-Google-Smtp-Source: AGHT+IEgM5tYITMRTHj+BCxEOufKgWePAbkqb+435RcHBd8WBvFOIV2QIFcwYDhpBeC+DSuNwb/2lA/Llj7uGn9h4R8=
X-Received: by 2002:a17:907:76d5:b0:a18:e9f:91a6 with SMTP id
 kf21-20020a17090776d500b00a180e9f91a6mr2325530ejc.16.1702499952339; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:04 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <c3ca5d33-be3c-43fe-a14e-2d6146a629c2@ti.com>
References: <c3ca5d33-be3c-43fe-a14e-2d6146a629c2@ti.com>
 <20231205094220.2301360-1-n-francis@ti.com>
 <20231205094220.2301360-2-n-francis@ti.com>
 <CAPnjgZ0J2GLhVEdfPR78kP6d=T8Yk3wMCTTODc4x+7jzf5N-sw@mail.gmail.com>
Date: Wed, 13 Dec 2023 12:39:04 -0800
X-Google-Sender-Auth: 5AkRJPJ3RefvdPuXmdBXKdGuGXo
Message-ID: <CAPnjgZ1baMAVpqfkey5e-DcPT5EF7ahApCQ52d4yaBQWKrkAOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] binman: etype: dm: Add entry type for TI DM
To: Neha Malcom Francis <n-francis@ti.com>
Cc: marcel.ziswiler@toradex.com, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, hs@denx.de, christophe.leroy@csgroup.eu, 
 mr.bossman075@gmail.com, afd@ti.com, m-chawdhry@ti.com, kamlesh@ti.com, 
 nm@ti.com, c-shilwant@ti.com, u-kumar1@ti.com, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,

On 06/12/23 09:24, Simon Glass wrote:
> On Tue, 5 Dec 2023 at 02:42, Neha Malcom Francis <n-francis@ti.com> wrote:
>>
>> K3 devices introduces the concept of centralized power, resource and
>> security management to System Firmware. This is to overcome challenges
>> by the traditional approach that implements system control functions on
>> each of the processing units.
>>
>> The software interface for System Firmware is split into TIFS and DM. DM
>> (Device Manager) is responsible for resource and power management from
>> secure and non-secure hosts. This additional binary is necessary for
>> specific platforms' ROM boot images and is to be packaged into tispl.bin
>>
>> Add an entry for DM. The entry can be used for the packaging of
>> tispl.bin by binman along with ATF and TEE.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Reviewed-by: Andrew Davis <afd@ti.com>
>> ---
>>   Makefile                        |  1 +
>>   tools/binman/entries.rst        | 14 ++++++++++++++
>>   tools/binman/etype/ti_dm.py     | 22 ++++++++++++++++++++++
>>   tools/binman/ftest.py           |  7 +++++++
>>   tools/binman/test/225_ti_dm.dts | 13 +++++++++++++
>>   5 files changed, 57 insertions(+)
>>   create mode 100644 tools/binman/etype/ti_dm.py
>>   create mode 100644 tools/binman/test/225_ti_dm.dts
>>
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Is there a doc/ update somewhere about TI_DM ?
>

Yes, it's patch 3/3 in this series.

> Regards,
> Simon

-- 
Thanking You
Neha Malcom Francis

Applied to u-boot-dm/next, thanks!
