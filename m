Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA28C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2C68813F;
	Mon, 15 Apr 2024 09:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQ1aQozo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8B888159; Mon, 15 Apr 2024 09:00:47 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07594880D6
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f00f24f761so51469b3a.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713164443; x=1713769243; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BrJSQ9iIOkVa+czHVOeHxvu0VcPB3KEXB7agGwxpcGs=;
 b=eQ1aQozoNSkdp9mtD7b5u5fWxGtLcnK0uNGrhokBXXzUJ9E4qHsNMXM8FUj3X7RVli
 ctnVeB/7pMhjjcPR9tWt+s1TzT7WJpjOM5SXYGU8SxnHiz/05ypDjFCXJqMPPeJTpVxr
 gJoQLz4yOzARyeoYB9Ie8tQiq+hkf/fWdCH2ASXT1pGej6W3Vn7LMM4WLdq1Ic0Xlcx6
 cjZybOoo/KhxWhiCbiwXly4GRJaE596n0H9g+uhvvJC8DY22j0X4Ae6MsrbeHIRxiFVK
 69uYMPMQ1PIXznoTsulvfHFXl4eE0USUmrNEUWc/dVIMUSjAo+pwaBSMnvavJMph/0VD
 NDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713164443; x=1713769243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BrJSQ9iIOkVa+czHVOeHxvu0VcPB3KEXB7agGwxpcGs=;
 b=M3xAAE2Ch6G/6okBLPNN41d+h7f3w5jLKGG5e3xP1RnoJSCL4c5na4NyJQXXGCYXxy
 41EUJeAKNIW8qUipplXEeMYBvU4BC0uFUKzpA7+SDNnhEWUkvqyXnGhURqzR+apHBv3Q
 rVNJlvwFm18sI7+XlK380CaxKEow6ZbjbU8RcBEAj0G5w1801YG+pqEjOS/IrOoahm8w
 DjC6EB5Gcq/u3hGhuUKs2sIG9I2LZS7kIS2AFK8NInk4aWQLN9jaWzGgCBo+fUFQNwkF
 ut5IWUP2Hav3qyb8BCGBosipURMB5bn/ahPlVB5JutqnrmWx3YrlyuDNqnL2u1PZIfYh
 lcFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAQn4ep3xScm661VNKRzMTlrLDKVXoF4B1cuSXoWDImU2hjkgsDDLlr0sz4VXV7XxM6Y/76tubKa1xqK8AAt3I1WjAVQ==
X-Gm-Message-State: AOJu0Yyg+0EnJTLcIROIp1TGaecnDw69WWGkXTnM5ZIDwFfgWpltk73z
 z/A+haUKd7hhTP90Y2JJrbeqrvLR03MfodpT0psJ1AF+WloY+VE5
X-Google-Smtp-Source: AGHT+IEW+rG8P08KUPk6raJMibu3iuH5jC0AKxzw5mtOYeMVBL6dNn55tq5OVUia2frWkITVWdNi1w==
X-Received: by 2002:a05:6a00:244e:b0:6ed:1012:9565 with SMTP id
 d14-20020a056a00244e00b006ed10129565mr9916834pfj.15.1713164443424; 
 Mon, 15 Apr 2024 00:00:43 -0700 (PDT)
Received: from [192.168.0.8] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d3-20020a056a00198300b006e6c6a50e5esm6532001pfl.34.2024.04.15.00.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 00:00:43 -0700 (PDT)
Message-ID: <a73ad287-be2c-44ea-bba9-d8e2e3d8c3b2@gmail.com>
Date: Mon, 15 Apr 2024 16:00:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
To: Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <a2e2d0ea-3a4c-4425-a28b-5422cf9f342a@linaro.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <a2e2d0ea-3a4c-4425-a28b-5422cf9f342a@linaro.org>
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

On 4/15/2024 3:56 PM, Tudor Ambarus wrote:
> 
> 
> On 4/15/24 05:33, tkuw584924@gmail.com wrote:
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> This series is equivalent to the one for Linux MTD submitted by
>> Pratyush Yadav.
>>
>> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*
> 
> Ah, I see you specified it here. I'd argue it's better to mention it in
> the commit message itself, it spares people searching on the ml archive.

Noted, thanks!
