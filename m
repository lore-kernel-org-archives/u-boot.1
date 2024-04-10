Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A13CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 12:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B606C85B66;
	Wed, 10 Apr 2024 14:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z7RCjZ/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DDE85B66; Wed, 10 Apr 2024 14:12:43 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFD2B8818E
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 14:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e32b439c5so1888092a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712751159; x=1713355959; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TO0XZHlQTt0j/NnKbqdBQp+GvJ0qsEbFLjjkflOwG3Y=;
 b=z7RCjZ/6OlGFkSBPKYanN2zPYOVG8Rjcxbb9dxuRUbAvbHSykITyux8u7SSnelQ8BP
 H5kg1UBk+Ybh4X83RrPCtYxV6gRGBX+mi5/vY0rT4bz5qzzCopQHdJJllo0Xk0i/3oBg
 P8fjC6GKYKNvgCPYUj24zmxoU9nALts2skKLVdZqqSOUIMVMnW88cibbA5WYTofvJDm+
 y6PMdb7kNs6NGat1IYofHcriBEHz/eWuavmWO5EcFfsaWB4YI9tEyqmIAS3ee3+4mibS
 A01yu2fAorPGubZvRJOKxAkgI/mEAUTI4V+5JVXK9LQMDHOiVpQ3UCJbZTWezoDhRL3y
 AacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712751159; x=1713355959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TO0XZHlQTt0j/NnKbqdBQp+GvJ0qsEbFLjjkflOwG3Y=;
 b=vSLNk1iTnxTFj6WMWkRPPwH+1kkLXH34d53u7F709EPTVWxgTJRfoOvQ44MAWB3eJQ
 oDpYhsY9YL1usGW+Gfs1rrfQoaKQagHMXE2ecTj1iIbYbZNLmreZOFi6l11AUXe2oJFb
 2IOl3GZcfyU+/Wr/OtlJhPEpMdzJzc9ONN3vqjZkBrqvizqepk7rT4ZP+LFZIbu5IrDS
 8ULqHF3hFmw6lLR8icFQxZBlf0ynW6VqvcRaUHrNuT2sjK3IjChbX//aFPsACg8Hx/Ck
 zo+RxSZPWGfnLwOFr9VRdIt4O7pnDoJYQ0AaqL9KjFIdj1K3vro+IGE6eHDizrlw7Lef
 B2zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNT1CZlSsOhkCMhmJorgcChOHfe4f9o0HdYPnSiBK0cgQp5NHGR1+1VdOxqn6pENTAZJ+ccwF3ECwcTPjtA4VN7OlTUw==
X-Gm-Message-State: AOJu0Yx+m4nIaNS+zZx7LPcjMMMAVUDPUWLPeYjMpXiYthXqr8clVUgl
 9i/A4gObDfDWiuWVSNrxfewClJ+Y9HEnU9ua/oFqvpLm/tr1NIEALA8HYHYYi0k=
X-Google-Smtp-Source: AGHT+IEm/kxHoYjqdw2XqCHSMENPIKYFPQCmdaYjlPTvoPamU+d1gRzquhQQebID+N4HJ4wDAk9PQA==
X-Received: by 2002:a50:8e52:0:b0:56e:2a05:a0e3 with SMTP id
 18-20020a508e52000000b0056e2a05a0e3mr2184866edx.21.1712751159330; 
 Wed, 10 Apr 2024 05:12:39 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::4716? ([2a02:8109:aa0d:be00::4716])
 by smtp.gmail.com with ESMTPSA id
 ds4-20020a0564021cc400b0056e78224d82sm1466697edb.81.2024.04.10.05.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 05:12:39 -0700 (PDT)
Message-ID: <8b64f88d-32b3-409a-a269-ec586823958c@linaro.org>
Date: Wed, 10 Apr 2024 14:12:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk/qcom: add driver for sm8250 GCC
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, u-boot@lists.denx.de
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
 <20240408-b4-qcom-rbx-soc-v1-3-2db1d3658660@linaro.org>
 <CAFA6WYPVefrREX6oU174E+o_eji73GcB8BGgXLJN3y=1sSTZnA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYPVefrREX6oU174E+o_eji73GcB8BGgXLJN3y=1sSTZnA@mail.gmail.com>
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

Hi Sumit,

>> +static const struct gate_clk sm8250_clks[] = {
>> +       GATE_CLK(GCC_AGGRE_UFS_CARD_AXI_CLK, 0x750cc, 0x00000001),
>> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, 0x00000001),
>> +       GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x0f080, 0x00000001),
>> +       GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x10080, 0x00000001),
>> +       GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x0f07c, 0x00000001),
>> +       GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x1007c, 0x00000001),
>> +       GATE_CLK(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x0b018, 0x00000001),
>> +       GATE_CLK(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x0b01c, 0x00000001),
>> +       GATE_CLK(GCC_QMIP_DISP_AHB_CLK, 0x0b020, 0x00000001),
>> +       GATE_CLK(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x0b010, 0x00000001),
>> +       GATE_CLK(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x0b014, 0x00000001),
> 
> This series has similar unused gates, resets etc. as in Neil's series.
> Let me leave it upto you folks to decide if we really need untested
> (without any relevant driver code) code paths to be added for Qcom
> platforms.

I don't see this as an issue for a few reasons:

1. it's useful documentation, if someone wants to do some bare metal 
hacking on Qualcomm platforms, these drivers are much simpler and easier 
to port than the Linux ones.
2. it's useful for debugging, I plan to upstream support for Qualcomm 
clock debugging facilities eventually, this makes it possible to dump 
all the clock states. While for now this is only useful inside of 
U-Boot, in the future we might look into ideas like installing U-Boot as 
the crashdump handler (so rather than dropping to the EDL crashdump mode 
we could launch U-Boot and interactively debug the board). Or maybe we 
investigate a mode where we make this code available via the EFI runtime 
to simplify kernel debugging (in which case we'd want to dump all 
clocks), or if we ever get a hypervisor stub in U-Boot we might want to 
do a similar thing.

I think calling this "untested" is a bit reductive, there's no negative 
impact on stability or readability by including these.

I hope this makes sense, even if we don't align on this fully.

Kind regards,

> 
> -Sumit
> 
-- 
// Caleb (they/them)
