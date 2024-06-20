Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F695C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 08:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A0F88378;
	Thu, 20 Jun 2024 10:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="T55NL8A7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A83883A6; Thu, 20 Jun 2024 10:51:16 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1FC88361
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 10:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso80052766b.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1718873473; x=1719478273;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MoXbwbQXc7bqKekEBY7eoxtuOAm8nhtF9UN3YwNklro=;
 b=T55NL8A71sZXrfuecRFEjnE8QJDqmgzOCsIxru56VQ8WO7K3HXFYZr8zKS1o1QFVhR
 T2S0kIG54BJucwQZpGwt/hZcJSWyNMAxgXIpSHcSBoM0QJjGLthA4nzbECnS+ELEPHnW
 SsKAj3zXdyyIedKZgr/3qCEzDmrHnwcWnGXAXoi8sJZqL/z5AeHlwlif9ky68gG6tofU
 tFqd1NopDgjj/B+iieyJPV0nKvqM10bqsGxCm75lOf2bnb9E4XvGJKBpGaFsLehjKcYR
 24MorWM4Yc556DT7W8jsSdh9jdJWpyloOLQC2FU4MTvSVOK5wi9DuFl6jojL9WbG9rXL
 rg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718873473; x=1719478273;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MoXbwbQXc7bqKekEBY7eoxtuOAm8nhtF9UN3YwNklro=;
 b=SXRy0xVUIk11Lk9+0nhgP4/cp5spvJrO20qdlQhAc4vWyaiHVZMmGk9zKwbCb1jkZw
 ON7S38PhM0gXQ31cOnBSQyaAE5kHXkfoUAPmGyD3X0okCWMs1SiBo5qLlCTWTjemTMtN
 8qqZFnqNkahJ4UOkgcCVaDllrUi/I+waLmSGkuIizSMu0E7JEnNsPv0w7KFjuJslBrtd
 UXM/xlfZePEjquy4It+j4YmhblVrEPO57EcTXKPcXpmCT0FbKNaSPmdyRRX2jNL8JOpp
 cO+97wIH11vhmQ8VEmPNTCGZKSG6TQBFzp1183tDFWTVFvc/VE58th/aKEaY1m3LKUhn
 vD4A==
X-Gm-Message-State: AOJu0YxzWD+0WlMWUJo9+P68VS69m8KGjX+HuIktlXha1EeoYgTb48un
 hJcu6y3AtEqavQzqg/CmFuvIG8PdRfciHaleQz8ZRDgqhXJw/B5EV8QyI3Z/QpKjvf5TTaupfqL
 ZZQ==
X-Google-Smtp-Source: AGHT+IG9Do8lR5kH9A2UwfCtL//TGEZW2KMGYxddPMCjEupbWPKCDYgSq9mbPn3fz9urRoNJ5Q1F9g==
X-Received: by 2002:a17:906:4acf:b0:a6f:1590:ab06 with SMTP id
 a640c23a62f3a-a6fab615d8dmr295963666b.31.1718873473013; 
 Thu, 20 Jun 2024 01:51:13 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da40easm742286366b.26.2024.06.20.01.51.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 01:51:12 -0700 (PDT)
Message-ID: <b1be9094-da16-46b2-bac8-f23c802af4bc@monstr.eu>
Date: Thu, 20 Jun 2024 10:51:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
From: Michal Simek <monstr@monstr.eu>
To: u-boot@lists.denx.de, git@xilinx.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
Content-Language: en-US
In-Reply-To: <cover.1714138688.git.michal.simek@amd.com>
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

Hi,

On 4/26/24 15:38, Michal Simek wrote:
> Hi,
> 
> currently only DT way is supported and it is added directly to lib/smbios.c
> but I think DT and env is only one way how information can be found that's
> why this series is improving handling with using sysinfo driver which can
> be platform specific.
> At the end of day DT should be taken from smbios.c and put to sysinfo DT
> driver instead of implementing it directly in this generic file.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (3):
>    xilinx: Enable SMBIOS command
>    lib: smbios: Let detect the system via sysinfo
>    lib: smbios: Detect system properties via SYSINFO IDs
> 
>   configs/xilinx_versal_net_virt_defconfig |  1 +
>   configs/xilinx_versal_virt_defconfig     |  1 +
>   configs/xilinx_zynqmp_kria_defconfig     |  1 +
>   configs/xilinx_zynqmp_virt_defconfig     |  1 +
>   include/sysinfo.h                        |  9 +++++
>   lib/smbios.c                             | 42 +++++++++++++++++++-----
>   6 files changed, 46 insertions(+), 9 deletions(-)
> 

Heinrich/Tom: Can you please take this series to your tree?
Feel free to take also 1/3 which is my branch but can go with it too.

Thanks,
Michal
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
