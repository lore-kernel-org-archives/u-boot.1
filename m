Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E627CC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 14:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8D7820DE;
	Thu,  3 Apr 2025 16:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cuDMF2bf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19DA5820FE; Thu,  3 Apr 2025 16:29:42 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0792D810E8
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 16:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso10110745e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743690579; x=1744295379; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yj2y7GjjsR/RB2BqH1hFFjFm94CpU9QxU0ray/aLSOs=;
 b=cuDMF2bfsqZ2g7g/JdQJQirAi7vBnNERYj5VsYGfAovPctY+D47ayF8eWOzdFbjnLG
 x62b1tmZJlJAvfX7f6NpvXIazK7SMgqnD1SEAuCNQmChI2vSH0Dp2tUlq7oMEc4ZPf61
 4/qmMfRfYMBcLkyOxb8ZZ+9r1uTglDtTpPIq6/MbVI/Xo3UBSSUWk+ZDz62r4UE/Tt0M
 C71O6Od0Elp9Fzs0yPLIOe5hD3PKvRw0hliYPJAOVg2znvjO/h1VHnQe4ML+nhaWMwLk
 sia8B9l3rcJ5eFJOPoX33USlksAcAtHfIQB1rwbOo4wH6P1ijDBYi30XZPto5i8+29kj
 WkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743690579; x=1744295379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yj2y7GjjsR/RB2BqH1hFFjFm94CpU9QxU0ray/aLSOs=;
 b=piLlcAJQHwffvo67Qg6F2PfoWXxbp6ilnsCIs9AA9exX8kJWrgdcuPi7czo0eFWa6T
 0j8PmRE/FTH24nVM0pV4NX0sfhZ8JvloMV1CljQcDE3oymSGmRXHyml7bmwQHNibvOXO
 pj/zuzQn/30SIAYe3HpBKmBOfD18+hgsRgIjpsJxVKkOqYxCVT1kKfD0mJTEtlgoD+nR
 gnU5PB0S/2RFdUc067x/6cuz0NjA1g42cbDpfY45+U3pDy9DFwOQMBMKvGvXLCWCu0Bu
 J0I5Di6DprfLebxlO7NLAP14YLIKlchBHUjA6+C9YSQ25E8HF3yHjPfiCu2F2SJ+kptK
 FrxA==
X-Gm-Message-State: AOJu0YzC4drsTtdE2SeBFRKSB0f8eS3Jd/SdA8IvDQ/1L8+wVRQNT/0P
 0Pqb1Fvyp6Stap7AAahN8uCFQEfc0KAfVHdgUs1KsPStLDnv1W1GW92T1n2NQyL6oBuyS9Hf10R
 g
X-Gm-Gg: ASbGnctyvSRvfRnVDW+D7hBwgj3Chv/1pOqh/K2l0+8XnQ7lKCBLjSR2M/BRslyW958
 OeAuq6IPPwtOTf3pDW87D5jsPhxFEXR/omHYik1HlwonjHm+uH06oWg19tmth/q2oira/Wi9Do+
 VPFeBhm7GXPZJ96cXgLhs/usteMhKGTlKkzgp2FlGEu+cXecR9jJyihFNZFk/cH9e5YAHklYjbp
 GKavZljliZqLw0qcv3Xs2/eYiXLb2a2jlGnY3Gp7Nx+GQH6n5RIY9Sb0ilarzVUeE9D+5CEQBuU
 DOfLXDtgYRuHcz8NNQDCEjC3cCV8hAEHZIIkAgtfvi0QqLKJRI7qzsCN5GfMKVM=
X-Google-Smtp-Source: AGHT+IHSsV5lSBV12cKcB3Rn9/wlzlP6fUxn+K6+rYSpQe+vAVGeF3rQONl61hgzIRaUwQ0Xq2MoIw==
X-Received: by 2002:a05:6000:40e0:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-39c1211d5b0mr17220130f8f.53.1743690579479; 
 Thu, 03 Apr 2025 07:29:39 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d943sm1966710f8f.74.2025.04.03.07.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 07:29:39 -0700 (PDT)
Message-ID: <fc8a2397-9571-4830-bf61-1f57e5349229@linaro.org>
Date: Thu, 3 Apr 2025 17:29:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sama5d27: Replacing at91bootstrap with U-Boot SPL
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, Alexander Dahl <ada@thorsis.com>,
 admin@hifiphile.com, artur@conclusive.pl
References: <CAOMZO5CYsDA3fqdt9UZVFmcTttB4q-_=X5vqQocDpn2-ORSikQ@mail.gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <CAOMZO5CYsDA3fqdt9UZVFmcTttB4q-_=X5vqQocDpn2-ORSikQ@mail.gmail.com>
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



On 4/3/25 17:17, Fabio Estevam wrote:
> Hi,
> 
> Booting top of tree U-Boot from the SD card on a sama5d27_wlsom1_ek
> board works when  AT91 Bootstrap is used.
> 
> Now, I want to replace AT91 Bootstrap with U-Boot SPL.
> 
> I copied spl/boot.bin to the VFAT partition of the SD card, and I only
> got this storm of the following messages:
> 
> Could not initialize timer (err -96)
> 
> Could not initialize timer (err -96)
> 
> Could not initialize timer (err -96)
> 
> Could not initialize timer (err -96)
> 
> Could not initialize timer (err -96)
> 
> Would you happen to have any suggestions on how to fix this error and
> boot sama5d27 using U-Boot SPL?
> 
> Thanks,
> 
> Fabio Estevam

First thing that comes to my mind is that there are no timer devices
available. IIRC when you build u-boot, you get a separate DT for the
SPL, in which only some of the devices are present. My feeling is that
the timer is not there. Can you check ?
Devices that are in different boot stages have a property in DT bootph-*

Eugen
