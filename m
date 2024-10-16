Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5889D1AD5A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474F488D5A;
	Wed, 16 Oct 2024 15:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DHNZKnxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E89888BC2; Wed, 16 Oct 2024 07:56:26 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B99E688B0C
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 07:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d3e8d923fso4217188f8f.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 22:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729058183; x=1729662983; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ivUSTxxF0ik5EngtLOdWwIkugmrRwQkkWFCH/cvN/tE=;
 b=DHNZKnxLGo7XDQLTK1n45O//UdQXozQp3NOismLwukORoMyvHyeWAlAhHTEKntQcnB
 FQDDdXpTPE3RAvyX/GFcUvT9+b/Zxkqoq2JFHN6q5h/8IQ06X3fYs4IlU4gackk57MAm
 MRirN50BTqfyORv27ustzwlTv2zu6+Wql642w/V/zB+LU6tKeh3NJEnFjRi9wlHyHrZ5
 d4wdkykagZggXN4Ginn0sgd9oUpohTdkrC+hRaz80TecnA9YqecOlJK/KWldYZInOjvn
 NM1dbbWsSGAePmpZKencwoHz/HqzmrVCGMS/SY3YzOwDjz5If0n0TzBjR1Zj26zCji9B
 +T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729058183; x=1729662983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivUSTxxF0ik5EngtLOdWwIkugmrRwQkkWFCH/cvN/tE=;
 b=wTWZDwm+09+GtPmSUyKrIrYBIFKUCwFQF2CC5OH78R61jQeAzkG51scWrXIludmDFS
 Uhqhd/fN5oDnD4+S8LJHM+9vw7wLqrPaGjDxLo0+8ms0TmGwsbeRYRPntc10+jXRcZfN
 9O/hyf0dUCjdGphPU2k7xm4x1N0GFmeYWVNUc8K49ssRfuyFHRKczl3YHDy81m9a9LDx
 dz8dWUWcTe6HmQax85s4ejy33Zc/kTngr1wJLKVKgrFPUa4mpPjLtBMfpB8Ij4e5nJwZ
 iUsqi8sVoyrGYsBNKXssuf+uSutiPixwOICcuPGkSrV7Jd4TZQhlHB8R7hZ/W5XEzaOi
 RNwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+g5S7p5ps2aKLYO9vITjmVUkS/YUSxmtPuWqBaEdMIIGKB4IZrOagDBcSq3W/M/Ro67EYJPo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxje1lljRFVz8XsliHPLiIKQsBguQMpBmv11bUJhIywDCGU0408
 LsIU9KSfCjgmfsUbCaEEfg5Ah/hKz826ARriaJfXbGwZaw47enLU9FwIlGBmNyU=
X-Google-Smtp-Source: AGHT+IGV2jwUkmiPqk8HwpI85y2niLQMBE7JlzlVHSP+uqwagDRu8WOcHNVoe4FOx4CVdBYQbTTwsA==
X-Received: by 2002:a5d:4244:0:b0:37c:cec2:23c6 with SMTP id
 ffacd0b85a97d-37d86d6fdfdmr1713345f8f.57.1729058183102; 
 Tue, 15 Oct 2024 22:56:23 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a124sm3370406f8f.17.2024.10.15.22.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 22:56:22 -0700 (PDT)
Message-ID: <9c105998-dd44-4bc0-bb28-f0bc1e739b64@linaro.org>
Date: Wed, 16 Oct 2024 06:56:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Pratyush Yadav <p.yadav@ti.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Joakim Tjernlund
 <joakim.tjernlund@infinera.com>, Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241016034725.GD6412@bill-the-cat>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241016034725.GD6412@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 15:33:18 +0200
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

+ Amit

ugh, the parallel/stacked SPI NOR thingy was applied in u-boot. We
rejected it in linux, this support shall be above SPI NOR. How about
reverting the support until we have an agreement in linux?

Or, if we want to still keep it until we come with a better approach, it
would be good if Amit (now in To:) fixes all the bugs introduced.
