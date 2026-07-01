Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B501EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 13:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169208056B;
	Wed,  1 Jul 2026 15:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KeGugy3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B283584BC8; Wed,  1 Jul 2026 15:29:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4AA484B92
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 15:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 975863FA67
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782912567;
 bh=kGHdKy5Dnge7ck0XlSBHQ75Zeg8T+HFtvoGMzRMyhLc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KeGugy3NgGzQhhcVISiN34QXB5OJuEH8gOlC7tRsd7ETHVP/vFUKGn/E2dNyO+Aeb
 ZmWRLLZgnVGQdKVuCUFiPi0swp1EDFuA2f/TMp+VxWKSf2qz4+QkINqge37vGriwQ0
 jE4rWdqNXaQDQX1SM6uH+I1kOk1PIA24SEKNU9uF4jbclScJZrQbJLmYob/IBo8wzs
 9PI1huk+O1Ia6SfwVEgN4jKx4k1Bg6dBSBUN1tK3G4bj0suG04WQE9wrl8yPBrFYCz
 TvGcDaqcWMblrfnTR+IYMkq727ECDuEhJerPh5qLEPux2l6V7fqHP+BQdgQp03pvVI
 W/4Y08nTpd58Qn8JFoiYJLfYOycbpbxwu9ZON+XOu0KEqnL2HmVKWAvRqVeYn5eFEy
 8TZtKcp4nOtX2NyBddl44DmEJZeqvjXXAgU+pyao6PAbJRc05GIPjDZs5mzYSFbUIx
 VYmvn9AJ+gnqVGWow9oyYotEnfpNA22EAMacNpIvJPfT2Zc+vuAGEMN+Cop67ZYoLG
 OsvEfqm/fq4Sb/Gm7wQbq0R+mxE76+89m7CRrUiZBAV7FZ2Vwd/Ye/1z9Vjvz76GgI
 Z9dTLBbeasJc6K07YAse4ckbzMNngjLp1est9gDUxse/N0ea0iOBgn6vdPWYQ2ZImi
 0yarzyzR+bL97h0AnVUIc9ZY=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so355512f8f.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 06:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782912567; x=1783517367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kGHdKy5Dnge7ck0XlSBHQ75Zeg8T+HFtvoGMzRMyhLc=;
 b=PXcSGOpwIYqrL258x03yDFacRjFmfZcscSNafIbQJys0I7P9Ig1EkdFuRkE+cal6uB
 QJm0TuHInnhaOvU46H6oct//vpTlbJ9QLhGo5GaIH/x4LZg93ZVNV5c8svKQLZ97FGet
 k+ObXT2IKZSuel9zsdjVkGnTwwxpACmvzV9tj4UKtTKgJ5QAlCekh9gQK9kJCr6WSYjt
 MijfwFTZd9lKVEi6aN9PbHJlwqrY2DpkBFsaoub2Oj2y03IafJMn9CqViHY5VAjARtf9
 w0iftaGEg40hjlgiVSPltb0Cv5WOfSLqzAzxXKhyRAe0tVON6qVjJTYn3ieT7U9nk7NT
 db4g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+hapS/IkQWLRfS5TP83ZYmyedNxHwTj3DqfkdnSj3jF1BfgDfNYV1QCEswUnSzRHIWpqzTGw=@lists.denx.de
X-Gm-Message-State: AOJu0YyWyJx9OMsqzgiGsLduPsYis6bX7HCwCZwqkazeH/8v7RyA2jyJ
 JlfUWYxbmDQ7qWBVR7HDQsB6WTyzSIUdm3vDetXTbiukMOifvdUzpCpEUQM7MCdeoLrY1q/bHCp
 drJqVjRdfdackTJoy9a4cjrB4vs6PJvJBuQ5PvvG7E4ZD3f+Q+N8xJXuo9qqgefqkPHjlUKQ=
X-Gm-Gg: AfdE7ckQfTjbRyl1vrYyIZnVprw1J1AJXs+DwFuhAj3B/B4XiNigqBdcIs5YfmFTs7j
 DCZVsr5un+YZJ1Vy6sMK3SlSD2C14Tx1N2WblWtwKGZuGtV/QqniJy5OqdOubZuFabfdS7lN2kl
 8CET7KwguFY7+GDr/wgO6Oy/P2DnxOr8MB3ubIXgd/ZuYAzJxrRYueW7OlMopRunUMyxyy8TujY
 M3q/HqglDPmTuYahbBpcPCB9G+yuy7uvS1OG2g0xdo1C/xSoFnZs4ARo95Ov1gaVeHdUm9LRQGH
 nKVwtB4Um0Lv0s6RfDHrlTwJqPPje6WHzelBFEQkfEZ07Hu7XIXseR6t4ZWSmsMU2QFUrrfU0/t
 AXFIODo0KSmwSfWO/54TD+3GMbhlt2HVCdaZDUUHMm5Dvwb8A+pfPWln+kQ51ANkl0AXBeNpdmW
 mI4Nfc8pNE4di8AGU3SUMqcYc4qNOJccFPEg==
X-Received: by 2002:a05:6000:29d7:b0:472:8343:7f5f with SMTP id
 ffacd0b85a97d-4775918fd72mr2062834f8f.34.1782912567254; 
 Wed, 01 Jul 2026 06:29:27 -0700 (PDT)
X-Received: by 2002:a05:6000:29d7:b0:472:8343:7f5f with SMTP id
 ffacd0b85a97d-4775918fd72mr2062808f8f.34.1782912566850; 
 Wed, 01 Jul 2026 06:29:26 -0700 (PDT)
Received: from ?IPV6:2a02:3035:62b:1f48:a6af:3a48:9d50:5eca?
 ([2a02:3035:62b:1f48:a6af:3a48:9d50:5eca])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf98sm13142773f8f.22.2026.07.01.06.29.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 06:29:26 -0700 (PDT)
Message-ID: <837c7f40-fa2e-4fd5-a889-4c07b6b779d7@canonical.com>
Date: Wed, 1 Jul 2026 15:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] efi_loader: use pointers in efi_acpi_register()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-2-heinrich.schuchardt@canonical.com>
 <CAFLszTg0C6cQDVWYbSPRJxjCwFhH3oa4yCPb8tJa4h7Akd=aXA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTg0C6cQDVWYbSPRJxjCwFhH3oa4yCPb8tJa4h7Akd=aXA@mail.gmail.com>
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

On 7/1/26 13:59, Simon Glass wrote:
> Hi Heinrich,
> 
> On 2026-06-28T08:27:58, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> efi_loader: use pointers in efi_acpi_register()
>>
>> Both efi_add_memory_map() and efi_install_configuration_table() expect
>> pointers and not virtual sandbox addresses.
>>
>> We need to convert the virtual sandbox addresses in efi_acpi_register() to
>> pointers in memory before using them.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> lib/efi_loader/efi_acpi.c | 35 +++++++++++++++++++++--------------
>>   1 file changed, 21 insertions(+), 14 deletions(-)
> 
> I think you missed a few things from the v2 review.
> 
> Regards,
> Simon

Which ones?

Best regards

Heinrich
