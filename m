Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C22C38150
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 15:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FA7888FD;
	Thu,  4 Jul 2024 17:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L1U2EIkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3837E88916; Thu,  4 Jul 2024 17:17:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B3388926
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 17:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a724598cfe3so74614766b.1
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720106235; x=1720711035; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=usyKFC8Xc5iU1zn9ow5cZELWLMA9wCCu4Dh9JHCpke8=;
 b=L1U2EIkvGt/p+qHDTkfAbxasXWd21IaHhHEaRL1xEddIpScvXaaw7Zz1emHZSFjP4C
 jM4/O5U7bd6+Pk38XwW/zcuZVWlobKAIeFs0YgyEdhXChjBWTFjX2iG8Rh7ZYXsMDwZp
 cnlq+GEIURg0m4bvERZIKnBPn2zHfRV6r414KMQQAzR4wJvB7UpBYYr1439TBc0T9+H7
 Ig03ADmW8rlyIOOQEZhp2ya/YowHmFsoFL3QbadZb5LCVdw/T1bl+XgSRdS7Y+oo0ePh
 rdF4legWz8Ifqt02F3g8FRXI4C8MTKLXqW+TrLperyEnuWOIoqTO6n04hJ+fZyS5UY9Z
 9W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720106235; x=1720711035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=usyKFC8Xc5iU1zn9ow5cZELWLMA9wCCu4Dh9JHCpke8=;
 b=sB2IM/7oav6O+ZFjMoh8iE7CWE5JxwfVKEfOL66iTSXmrkXDcLsjCREiKfAk1Dqslp
 CSBQOSS3772IcJnmOaoTjn0d8iux0IQF4thkkL6o28C39mGhLECaKD2TO7548j/YTvt9
 Y8PYXL55gM6iGhYNpas5sg3ZeoWJb8lc+uhP+8KMx2b2KREiPF64TpzhyDOvgU3VpFBj
 vXBVCct8hWQOhfgz0hDsB2wnz+9FH8AWbF/FSi2RLTrNZTam3mrgAJD6cNNVbte7jByr
 xT7WL54htTUCOjU0zsryRO5H7LjvPr+K/SL6hlrGiwOsUBmvdDPLSKuEmAG6dZal3O/g
 SuwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3JJnK2UMLinxGl15qYz5D4f96czobiJXenkm+xUp5eblOun/poY3/Tfdtvnxf/GLPCDMy99PLRLcxye65ZQ8inTCT4w==
X-Gm-Message-State: AOJu0YxLqXKaS4PVzznD9eNJixzlEHYQt/NLQFD/FbaCBv9mDjiPaoRS
 +kGfCgMC7i4UdDwOGlIY5MsL1zQjOOdmHBCP1MhvpFEcHmskz1pY1H+ROVpSqFM=
X-Google-Smtp-Source: AGHT+IEtUkbqQ1eENtQAkJbyG4kMM2R4YgjVan+WUubBgCmC+juVIKe2SV7OwquNKZ8AzykGKLxzzw==
X-Received: by 2002:a17:907:969e:b0:a5c:eafb:5288 with SMTP id
 a640c23a62f3a-a77ba46f87dmr177623166b.31.1720106234670; 
 Thu, 04 Jul 2024 08:17:14 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::18f8? ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a752d634721sm328637666b.105.2024.07.04.08.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 08:17:14 -0700 (PDT)
Message-ID: <972fadc0-1334-43bf-9c67-409de01b14c0@linaro.org>
Date: Thu, 4 Jul 2024 17:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] video: Improve syncing performance with cyclic
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nikhil M Jain
 <n-jain1@ti.com>, Ondrej Jirman <megi@xff.cz>,
 Peter Robinson <pbrobinson@gmail.com>, Randolph <randolph@andestech.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>, Ying Sun <sunying@nj.iscas.ac.cn>
References: <20240704074859.2956745-1-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
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

Hi Simon,

On 04/07/2024 09:48, Simon Glass wrote:
> Now that U-Boot has a background-processing feature, it is possible to
> reduce the amount of 'foreground' syncing of the display. At present
> this happens quite often.
> 
> Foreground syncing blocks all other processing, sometimes for 10ms or
> more. When pasting commands into U-Boot over the UART, this typically
> result in characters being dropped. For example, on rpi_4 it isn't
> possible to paste in more than 35 characters before things fail. This
> makes updating the environment or entering long commands very painful
> over the console, since text must be pasted in chunks, or the
> vidconsole device must be dropped from stdout.

I'm not intimately familiar with U-Boots event loop, but to me this 
sounds more like a bug in the console code. I can confirm this issue 
appears on Qualcomm platforms with the GENI serial driver, I tried 
enabling CONFIG_SERIAL_RX_BUFFER and it seemed to help significantly 
(though there were still a few dropped characters when pasting).

Of note, the USB ACM serial driver doesn't seem to have any issues here, 
presumably since it isn't restricted by the baud rate.

If there is an abort, does this approach still ensure that it gets 
printed properly on the video console?

Kind regards,
> 
> This series introduces background syncing, enabled by default for
> boards which use video. The sync rates for foreground and background
> are configurable.
> 
> With this series it is possible to paste in any amount of text to the
> command line. Some sandbox-specific workarounds can now be removed and
> sandbox video (./u-boot -Dl) is significantly more responsive.
> 
> This obviously increases code size, since it enables a subsystem not
> normally used by default. However it only applies to boards which have
> VIDEO enabled, which are presumably less worried about memory space
> since the video code is fairly large.
> 
> Also it is possible to disable CMD_CYCLIC and reduce the growth to:
> 
>     aarch64: (for 1/1 boards) all +1081.0 rodata +65.0 text +1016.0
>         arm: (for 1/1 boards) all +945.0 rodata +65.0 text +880.0
> 
> Without that, the increase doubles.
> 
> It is of course possible to disable CYCLIC and still use VIDEO but this
> reverts to the current behaviour
> 
> Changes in v3:
> - Drop inclusion of kconfig.h in cyclic.h
> - Adapt to new cyclic API
> 
> Changes in v2:
> - Add an SPL_CYCLIC symbol
> - Add a lot more explanation about the header files
> - Expand help for CONFIG_VIDEO
> - Fix 'groth' and 'work-around' typos in cover letter
> 
> Simon Glass (5):
>    cyclic: Add a symbol for SPL
>    video: Move last_sync to private data
>    video: Use cyclic to handle video sync
>    sandbox: Increase cyclic CPU-time limit
>    sandbox: Drop video-sync in serial driver
> 
>   common/Kconfig                    |  9 ++++++
>   common/Makefile                   |  2 +-
>   drivers/serial/sandbox.c          |  2 --
>   drivers/video/Kconfig             | 35 +++++++++++++++++++++
>   drivers/video/video-uclass.c      | 52 +++++++++++++++++++++++++------
>   drivers/watchdog/Kconfig          |  1 +
>   include/asm-generic/global_data.h |  2 +-
>   include/cyclic.h                  |  5 +--
>   include/video.h                   |  2 ++
>   9 files changed, 95 insertions(+), 15 deletions(-)
> 

-- 
// Caleb (they/them)
