Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6622C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D048829E;
	Thu,  6 Jun 2024 11:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GXxk0lsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A83DB88103; Thu,  6 Jun 2024 11:15:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA52888363
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42148c0cb1aso8723175e9.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717665355; x=1718270155; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C3Un/7+u97wgX8jKIijZJ27Sntxtfdr8/9f6q8v3PF8=;
 b=GXxk0lsf+/gmp46CbAib+K+tE2bnhCiR7EQGvU1/RqZxAssLd33RonGt0VTl9fJssY
 V/4KR8Vl8Wrlj7d+oqipsYU68J0Tl8bST5mVooO+1CbeZF7kFhIguf6gwZyY3qcb4rnA
 XGPxM4i2umywKePTxwv+lj7N7IaJ5vDCxWMOWRTNcx3aabNupWBPopInQw6hFA+iacSQ
 dwa4uN+b6slKYD9I5wP4olzdGPErFbWpBaJ2nj8at0K3R4/C7ZUPe04LyzjB+FWnMwYL
 uPusn/Vb+o2b5TGG56xka+2wH9Y1jKp87AEXNRmJBi8cG/V1jl5krVzNBUclVNH00XzY
 Du2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717665355; x=1718270155;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C3Un/7+u97wgX8jKIijZJ27Sntxtfdr8/9f6q8v3PF8=;
 b=O4zh9H4co2eaKRciwD0fTjq4ZFzIO5RTil6SjlPQDnOdYxD7tYifGx1sUjLCypsazU
 jerJR86xUk6qLkswe0nKGcQys55cTH24luaJlKgztHmKqP2sIzn6Ebx9wC67bL+soXXN
 g6UKRPaHZCNwLSUYHU+0y2C5GrfLCwHPhxmWvqfT4bNYFiiwSp7xTDa0T8yZWEVxamRL
 ghHu1muyooVCaoFhmfCIVwpZ7nY6D7lH20YrwPETmHn8GhY0yos2OpCLV/G4U8BiHerM
 kAyw5dMWyoY2s9EK0pfeF37TMJx+Gey0A9cr7bY0hKECy8/c7Ms3JUmgIGEo9pEQgXzr
 vgQQ==
X-Gm-Message-State: AOJu0YzsnkZlLfMGfPdhqivH/fZoSMRLDHfV1DJ/U6w0UJXmG14ev1rC
 XRUItcy81CzLrWBJWnyFiK7RKuIx9Jds16/tQpnNS//tUIPVRipYvgIkAdCn8Og=
X-Google-Smtp-Source: AGHT+IG4m21vHBQrnNevhSyE26jKsdLwem5Dkux0gRFEvu5jo04tMLpxivRLW4c7iwDyREGkM/RQfg==
X-Received: by 2002:a05:600c:41c3:b0:41f:ec3e:9797 with SMTP id
 5b1f17b1804b1-421562cf729mr37945525e9.16.1717665355044; 
 Thu, 06 Jun 2024 02:15:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07?
 ([2a01:e0a:3cb:7bb0:af73:f6a9:3d55:6f07])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102ab8sm49573115e9.18.2024.06.06.02.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 02:15:54 -0700 (PDT)
Message-ID: <5010e5bf-1059-4e14-a260-28f383ff7347@linaro.org>
Date: Thu, 6 Jun 2024 11:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527153447.GI2568172@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240527153447.GI2568172@bill-the-cat>
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



On 5/27/24 17:34, Tom Rini wrote:
> On Fri, May 24, 2024 at 06:19:54PM +0200, Jerome Forissier wrote:
> 
>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>> stack [2] [3] as an alternative to the current implementation in net/,
>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>> reasons for doing so are:
>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
>> has some additional lwIP and Mbed TLS patches to do so. With that it
>> becomes possible to fetch and launch a distro installer such as Debian
>> etc. directly from the U-Boot shell.
>> - Possibly benefit from additional features implemented in lwIP
>> - Less code to maintain in U-Boot
>>
>> The first patch introduces a new Kconfig symbol: NET_LWIP, which selects
>> the lwIP implementation instead of the current one (NET). Contrary to the
>> approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
>> simultaneously. The rationale is we want to start from a clean state and
>> not pull potentially duplicated functionality from both stacks. Note
>> however that a few files are still built in net/, they are the ones
>> related to ethernet device management and the ethernet bootflow.
>>
>> The second patch imports the lwIP code as a Git subtree under
>> lib/lwip/lwip. Some glue code is added under lib/lwip/u-boot.
> 
> For next time, please just make it a pre-req to run the git subtree
> command (and note it in the cover letter).
> 
> In more specific feedback, I tried this on a Pi 3, and:
> U-Boot> tftpboot 200000 EFI/arm64/helloworld.efi
> TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> Filename 'EFI/arm64/helloworld.efi'.
> Load address: 0x200000
> Loading:
> ....
> FAILED test/py/tests/test_efi_loader.py::test_efi_helloworld_net - u_boot_spawn.Timeout
> 
> So some amount of networking is working (that's a reasonable dhcp
> response it got), but tftp'ing a file fails.

Thanks for testing! This fails because I changed the command output. The
legacy command prints "Bytes transferred =" while the newer one prints
"%lu bytes transferred" plus throughput information. I will use the older
message in v3 because several tests as well as documentation would need
updating. We'll do that later if desired.

Thanks,
-- 
Jerome
