Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F91ACAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 14:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AADA809A5;
	Mon,  8 Sep 2025 16:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wyIY33/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818FC83106; Mon,  8 Sep 2025 16:21:44 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8C5C80077
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 16:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b04271cfc3eso610275166b.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757341301; x=1757946101; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MepRDTpHqsngoaBvwHrGr8xpIC3LP1GAZ6rFsICMahM=;
 b=wyIY33/8nvXTKfVJeNFJ7gqfaRokMatwHp1ooHzW01X6MMbtsH+nyUuxbr2eZFGcGy
 RMbPqDfBWDvLBpxVqOjZvYQI6/rDSe/u0dUCyEIWVYmJ3O4Y7w8cch3R7U/v9y37w3h8
 OtH9wnwC5DuxOZZeM5aP+xAPllesia6PpD4E+YfIbQM+VOnbmEDqtmMK4A269ImgUHWg
 VsjlLNwU/v1g0yIpQJ87KxEEdRwh2mIUGQuiYYyBxSufFnaW2sGJyy0DyJDAAbS+8eNR
 cvA+mCwkgnh8zD6ooKl2qeymvVhc+10GHPGcZsu7MoWumUvinoqgJOSDEf0JW82Akrz5
 u+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757341301; x=1757946101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MepRDTpHqsngoaBvwHrGr8xpIC3LP1GAZ6rFsICMahM=;
 b=ZoZ1tRZXUo2Ma87YZX1PpWPd4FcVbmPZ6W3nNE2U39MuFEb192iqYIe2LY+AVtGlD1
 zRmp6uZJMF/no26jP2UMnoIHQUo/ncVlQzrlk13bLhM+bjiUIocx39wR7abnr6TDEF8T
 LnQQWm0TioUogNsJSY7XcG6hvw7n4e9ig+c1jI7fOIU6KD70PdR0+T7YxGX+g3nwIrj/
 8oRZiDe06JIY2TN1zVctpLBJe7pvyf1T1Q6D3iuJ3FBpbYKDRQM2iaBrYzzT3l5hE15C
 ssuTf7omn64cQChuWxu+HmVswO6Awqd2DMMp2VjdCqulTpVGqkdylfHRkeGlGryDrDY9
 OGjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/qr1TGhRpindE+gMIMJPTt+sTSTH391kmFbNw6j903Ck7j+HFz86oKf8x0DBeOx9FeLL96MQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyedy/segtq/mvotOADCcSzzlXyKlsOVw9Wr7/mmsV3FGWHy+9A
 gjuGM37LzJbU+W6wZgKDUSnNnqUOGFpwBgRhu6/UO6kepKjmABlyY2XXgG+FfueXDR8=
X-Gm-Gg: ASbGnct4B9NSsssIZ/3bPCt9L4ET79+tbGtc87jFoXuMV8znKA5agu8XSRQRooXr2nU
 GBD55ggklD4xGaV9RudzL7WoVMvlY10CqyGCS2WLoMWLLGnnYFGQnoNFGnhFHgM3CGeD9sh8OSO
 8Mv+ne9hQHXNwWB161J0hXrrxjfrpAGNOmee9FZnewH9CDIAK+LZjHSAbH7+VFGlz7yJfBMbPOZ
 iHDKLnxEa8fU4pen630Z1QW/6RJvkBU4VzU4dcijw7RZBPiGuagJmxHtTXxgSHIeF5RouAp5diI
 Hf4p13UkTd/qCsalWQOjcoLv5xT/N9QBQP6+z2zJkXeG5W7XTfxEm3wL1Ij1mBkETf4iRouyvIP
 afuCEm4EeaYsHMybSGagWC3IHnJ8n/Ux8j1nAmYENkcxLijYefVGORNatbsPJ0j68IwbGgLNN02
 6Nr/8gjXhV40U8WNZRNp+gwns=
X-Google-Smtp-Source: AGHT+IE5sU+2haUYTYxD848n7T8Ip6kiSPmcOk25rfo0pbrKC4OamK0saHHmIad7UMfK4ao6aQrFCQ==
X-Received: by 2002:a17:907:6093:b0:b04:5e57:6d0d with SMTP id
 a640c23a62f3a-b04b1714547mr827388466b.50.1757341301062; 
 Mon, 08 Sep 2025 07:21:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:dbbf:dd29:d7ea:be02?
 ([2a01:e0a:3cb:7bb0:dbbf:dd29:d7ea:be02])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b041800e89esm2052288266b.30.2025.09.08.07.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 07:21:40 -0700 (PDT)
Message-ID: <e0c32dde-f265-42b5-ba4d-29a3deaa7eaf@linaro.org>
Date: Mon, 8 Sep 2025 16:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LWIP buffer alignment
To: Tim Harvey <tharvey@gateworks.com>, u-boot <u-boot@lists.denx.de>
References: <CAJ+vNU38CyNjp96wH5m4FH022WxHghaASxU-gG=Uuc=ni7fYPQ@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAJ+vNU38CyNjp96wH5m4FH022WxHghaASxU-gG=Uuc=ni7fYPQ@mail.gmail.com>
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

Hi Tim,

On 9/5/25 19:45, Tim Harvey wrote:
> Hi Jerome,
> 
> I'm working with a board that has an IMX ENETC MAC on it
> drivers/net/fsl_enetc.c and when configured for LWIP it fails and
> warns about RX buffers not being 64B aligned:
> WARNING at drivers/net/fsl_enetc.c:776/enetc_setup_rx_bdr()!
> 
> I tried changing MEM_ALIGNMENT to 64 in lib/lwip/u-boot/lwipopts.h but
> that did not align the buffers to 64B. Where are the lwip buffers
> created and do you have any suggestions for working around this?

The LwIP RX buffers are created in net-lwip.c. See eth_init_rings().
You might have PKTSIZE_ALIGN and/or PKTALIGN set wrongly.

Regards,
-- 
Jerome

> 
> Best Regards,
> 
> Tim
