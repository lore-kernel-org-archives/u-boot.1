Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AAEC021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 16:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F8F809D0;
	Wed, 12 Feb 2025 17:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hR3v/qBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42CF80BAE; Wed, 12 Feb 2025 17:05:22 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FDF8807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 17:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dd91c313bso2320931f8f.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739376319; x=1739981119; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZHy8YyLr+IRKiueuiIIVJzCji8JjyYDi7y4NBU6QsI=;
 b=hR3v/qBoDJRRoBaY6FsCnd6DFoNE4dLlxzujrWIViU8O3uHOsHjNd/SMGdLyAq0nQv
 lyd895rpQAgjRIiC66QSpqpsX3fGIdH41NmH/VgowY9+3qIk3V2oUCMnrkAloi7LctAR
 fkc1uGh1EVBrHlM+oNBc0K5vXgY8FS+LSeIwkNr0vNNCaqstAn2OTjD8a2NG0c+7Bmhx
 qMJ7aUDF4ouXV3Bmyp+tdOxmcBrHXlhmqRLkjy/5yjBdN3deEqycpa145BEYS1UuKGcJ
 Zki+Y4ZWRd3Vo2d91Q5PJB+WQRAKtiBxUbYQNDiNGPphulkIZpVa29ndj9yEu/8YXMHX
 8UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739376319; x=1739981119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZHy8YyLr+IRKiueuiIIVJzCji8JjyYDi7y4NBU6QsI=;
 b=EFXy0ZEsPfUJYg8xv3dI8L5FvEjhTfhpFq5m8LiHaLe990U++gtQuQddSZ0t4Du0xy
 Vwz9NNBitdFR5xjwPzt26zfmnJD85hkyQ7tX0L37JJ65Wzj2BjUM5xR28qhCx5HNys3e
 rq9FDlatEzhjcahIo92LqDfGUe1Lo7jSsIODoyeHtUgo2p5orO1ENKWLtCgRhtsl8V4a
 z7RRiczifjT4Di0bwMMTIJB6mXtBFAm+hvcO6h66/ax/zSdxbGIzBtW9Xo5bvoDgvR6A
 ct+g4L6ZmhWu1qvj0XIpMbMgaE4CtA8Ma4k/1e1VIP3esXgb+EgXtjIFxZQSDoOdQXWv
 2Zdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxItO1iwchWSj+OVkymVsACb5H8IXc4ys7kYZMpVsEQYelCFSgWJgfactjic3i9vMb9MxOoxI=@lists.denx.de
X-Gm-Message-State: AOJu0YzTvQzHxFNS/iDN+yb2X765k6wFsXxShnQ81Ej6P5i6MKkEA7Al
 YMgUgobP1s+bb+cQGnxJ3xqTGv0BU/ilXqLGJTu++c75Ng+XObEMDhcqrqPzn7w=
X-Gm-Gg: ASbGncvcoxdT+HcNY4rSk4pspQqOttTl1oyXrFPDuy65NvwvpTT7qHQlmG644ZlkCkc
 RtSenZ1ffD2FEU7+b504fbG6HzGx7sdb4h7lo7Qlt0ZlbiUfwb3OwOxhQyOxbmeMKuKJzGBP+RA
 EqdqwQX4Rzq5o2rVDdNEdZONKsctZHMA92kSdTdxCu6NOqvBRH7wUJu9TotEhGXJ9v8E9+Sm03N
 GbzCg2dQhLwLm+gPGcubadKJnHU4wjK4Nvs4AB+CBmZnrxR3nrHk6K4LKVyxm44KMU0gXQeyVra
 H0W3BRRcR3Hrhg2v6cRXHDJL8lau8i4UQw9tWAP4Kfab9SDt7a4x+F6ad4zIRI/F3ZgGEw==
X-Google-Smtp-Source: AGHT+IGYFPbDwHI6YdpiH1ZbPbZGiWkcqUzT/1VbbrEqYrt/IyJIO5YUYWNQYPiSkBLKDWiyogs0hA==
X-Received: by 2002:a5d:514e:0:b0:38d:c771:1a21 with SMTP id
 ffacd0b85a97d-38dea6047abmr2629615f8f.50.1739376319318; 
 Wed, 12 Feb 2025 08:05:19 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04cd94sm24143485e9.7.2025.02.12.08.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:05:18 -0800 (PST)
Message-ID: <33722cac-db85-4fed-9509-fad7bd53e7fb@linaro.org>
Date: Wed, 12 Feb 2025 16:05:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add initial support for IPQ9574 based boards
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250130053751.3148614-1-quic_varada@quicinc.com>
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

Hi Varadarajan,

On 1/30/25 05:37, Varadarajan Narayanan wrote:
> These patches introduce the initial support code needed
> for the QTI IPQ9574 SoC and RDP433 board.
> 
> 	SoC	: Qualcomm IPQ9574
> 	RAM	: 2GB DDR4
> 	Flash	: eMMC 8GB
> 	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz

Thanks for respinning these, this is a lot more palatable :P

Everything looks pretty good, just a few minor changes. However the lack 
of documentation worries me a little.

I'd appreciate it if you could add a document in the next revision 
describing how to build and flash U-Boot for these platforms. You can 
look at doc/board/qualcomm/rb3gen2.rst for reference.

That document should also briefly explain what the platform is, what 
variants exist, what RDP stands for, etc.

Robert: do you have anything to add here?

Kind regards,
> 
> Thanks
> Varada
> 
> v2: Have tried to address the issues raised in v1
>      * Use the upstream kernel dts itself
>      * Dropped linker script changes
>      * Break up the patches in clock, pinctrl and defconfig subsets
>      * Dropped ipq9574 specific files and use existing mach-snapdragon
>        infrastructure itself
>      * Dropped SMEM related changes. Will have them in a separate
>        series
>      * Use reset_get_by_index instead of reset_get_by_name
> 
> v1: https://lore.kernel.org/u-boot/20240226100807.1095607-1-quic_varada@quicinc.com/
> Varadarajan Narayanan (6):
>    dts: ipq9574-rdp433-u-boot: add override dtsi
>    clk/qcom: add initial clock driver for ipq9574
>    pinctrl: qcom: Add ipq9574 pinctrl driver
>    mmc: msm_sdhci: Reset clocks before reconfiguration
>    qcom_defconfig: enable ipq9574 clock & pinctrl driver
>    configs: add ipq9574_defconfig
> 
>   arch/arm/dts/ipq9574-rdp433-u-boot.dtsi |  19 ++
>   configs/ipq9574_defconfig               | 111 ++++++++++++
>   configs/qcom_defconfig                  |   2 +
>   drivers/clk/qcom/Kconfig                |   8 +
>   drivers/clk/qcom/Makefile               |   1 +
>   drivers/clk/qcom/clock-ipq9574.c        | 100 +++++++++++
>   drivers/clk/qcom/clock-qcom.h           |   1 +
>   drivers/mmc/msm_sdhci.c                 |  10 ++
>   drivers/pinctrl/qcom/Kconfig            |   7 +
>   drivers/pinctrl/qcom/Makefile           |   1 +
>   drivers/pinctrl/qcom/pinctrl-ipq9574.c  | 226 ++++++++++++++++++++++++
>   11 files changed, 486 insertions(+)
>   create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
>   create mode 100644 configs/ipq9574_defconfig
>   create mode 100644 drivers/clk/qcom/clock-ipq9574.c
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
> 
> 
> base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86

-- 
Caleb (they/them)

