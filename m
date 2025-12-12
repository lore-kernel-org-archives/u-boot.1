Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8D4D4922D
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2187A839A5;
	Fri, 12 Dec 2025 15:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HsqUcdQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B000C839B7; Fri, 12 Dec 2025 15:42:04 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71ADB839A5
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so9554875e9.1
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765550509; x=1766155309; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dTbgyAenyNeHCI3wGPABDggtBRK3KkKWBJD5rE4n/xU=;
 b=HsqUcdQQzw0CUvOJcY19EGMvsC1pK6TiIYOVtZXK9/ShiJWwgi0XW2zYCw75bPqFiJ
 XpF5/jGRrMCFmdP6wmdbJlobVBBApeAsC5S4q2LMNv3SSRUwao2ixPyFs0OIlLIgrk6B
 q18c58hnFwOGVKO8AR6T6nKRbvHfa262HBE1XqaxNdZyjnxvLAQqIKf5rhR65eEJjV9j
 q/cMGzn/PnPLG3XubZnxmD74xl+QDOI9JOJzvqX57UvHbBPB3qubpZlo6PaiGUIuI7Ni
 t75OhX9chIWU9y9fmJkE7HEswh+lKf64MgGjpUKuMNkhN0wkL2Y3l+wgGSERYSzxR2Ki
 LlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765550509; x=1766155309;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dTbgyAenyNeHCI3wGPABDggtBRK3KkKWBJD5rE4n/xU=;
 b=FAglLxd8K+ALqn+0w69dne8OAVrQ83nki5pzLtiFlNRv9CY3OTVmi0rVVRrwYswcmh
 1Pbg5io5REE2E9vuz5tdSx51jzfrisSadTZ0VIGPNby/bzLbES6B76xKMOHLeyE47AOQ
 EelSbnZeskltfz97Ft7ebiokRA2XFjtqSn00/sO/KqqsjZvAwwlFDdqMiu1IaQlqw4jB
 u8W0sL53bgajy5XcfdQ6c5pfTH8nW0XxMPJI3l/of2i8UtaK8I2nJ+ilz8GUhECZScyW
 OmMzef1uQX+3UKyx4Hj6EhvpE/yRnr0CThByi87gr0ICnxGFzdUQMLeyRx2Kga4Lrthn
 Rwcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUuLIfGQMOxOwPx09j64GBb1/c0Tb2h4M0rWhHoW8EfjFpVhSFx/LM0MZXMAbV6w7UXPqDj9E=@lists.denx.de
X-Gm-Message-State: AOJu0YxydGEwb9foazGD7LTS4/1cbTdFNzTCyV4WwTIfhttqHVtduSS0
 STWHj0lWjUWI0fzPypx6aM5nxzHUkHNrEGYAmh3ZS9r9vRROAKDNtYyIfIw+wxj56NQ=
X-Gm-Gg: AY/fxX5MAg/UqwMHCMu5CeJis8CeOnyyYUJqB5tLGuOvmQW0SQ1e9uJweK9KKgHM5+S
 ROd91QYOB+9Rrs4AAH8GGUf1NZXVGZFVpaVpk0c8qkVADm6TtUx8EIffSYeWrcsdxV+S1s+8pmq
 nJ8M03f2LhRDHOGmvFvLmZj7H6ExvHcX+8q4EjQMwQY0dN5NrFbjB9vWpv07Md+7IJjZ+4ScO1+
 9BIUVqwzjYiHN9ilh0SsWnE+FG4/oSgypiTOnybFypK7oM8Qrntozwut3XXhy6NHaI3aO2kqFGx
 p/kqOlq9iifhmh9JnwxSJ2nAiTL4hpFAItG2OInD9mi8hN5eQ6EDCXTWk1+5r5Z9JMByhW9qFjB
 38dW9Lif4cDB3BUh4h94SF+Nqd0yWXiSp10Qz0YrWyQRD7GSc8lh+xnd5srszMlt2THa96MNM1t
 HNccb0HjfAZTYB7RqcC/WjMGiATtExb1xDeCD4tQ4BpMoiEbkJnhtUjY4xEtkGe1l3IQ==
X-Google-Smtp-Source: AGHT+IFQPQarhXrnd3t6hiQlLBrh4GEKJJ/ZROc3/dmC+CfaBErPlPEJQjjfwkLNWwF5JTIrXhmuFw==
X-Received: by 2002:a05:6000:2382:b0:42b:383d:9c8e with SMTP id
 ffacd0b85a97d-42fb46e2ba1mr2541861f8f.41.1765550508754; 
 Fri, 12 Dec 2025 06:41:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b1f1sm12467320f8f.39.2025.12.12.06.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 06:41:48 -0800 (PST)
Message-ID: <e7afa685-5558-45c7-8a47-33821928ca69@linaro.org>
Date: Fri, 12 Dec 2025 15:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] configs: qemu_arm64_lwip_defconfig: enable CMD_NFS
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
 <20251212-lwip_nfs-v2-6-9cb5a60520d8@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-6-9cb5a60520d8@linaro.org>
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

On 12/12/25 12:32, Andrew Goodbody wrote:
> Enable NFS command so that it gets built by CI and can be tested more
> easily.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index e8f976efaf7a1b2e3804a012a235f42f1c05d40c..a974970c3d32bc34eadead34976392349bbf9e33 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -5,6 +5,7 @@ CONFIG_ARCH_QEMU=y
>  
>  CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
> +CONFIG_CMD_NFS=y
>  CONFIG_CMD_SNTP=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
> 

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
