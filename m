Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEC0CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 10:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50B1F80FA1;
	Tue, 19 Aug 2025 12:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UW5r+VFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DE4182998; Tue, 19 Aug 2025 12:55:04 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFD4802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso28555765e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 03:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755600900; x=1756205700; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/VTGcSBzdzRzQ17zz05BcxiLnihWf7i4AMyEGw+pCI=;
 b=UW5r+VFLLDFhklVH62qGH+ELeNMp8/BI8hszlouQPDXj3sUPiQANii1pAoAziQ34vC
 RwBfYFAKFOvGn8bV5CwosYhtLd9VqlGrRxcTfgrA+L4z41ybbn0RA7GxWTp8BCxXRKQg
 8RTicY838u/nvqy+XkbhAqM6srbG8AGCvxqsezIwy2l6s3KZzXq9FmBxO3jPakE8gviO
 m6Pe/CjRiI/BX5sx74Vk7z6FYDjmyW0EJF3GdKf61BbW9u2xjp+QJMrDPON7EsIR4GOD
 mlbRv0YJoXRjTTy1I2Bqh8c9M5CrveNeL5qELnhlt49jKxftlnjJondAyhjVNAeZylnx
 iozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755600900; x=1756205700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a/VTGcSBzdzRzQ17zz05BcxiLnihWf7i4AMyEGw+pCI=;
 b=K8zRIGZbOL5x7prjtBQoqG4KuLdrDVqfio91uz5emxb9f3RXV+xfVOoJD93gENhd9H
 9QRG8LBkuM+NeiU0GSFXZ0yRHtbqev223BLivWrwhxhE7h18/u20zLxl7NrdL7Hd1QN+
 8q43Orlx36EvtHEkqkj9BY4dxWVc8FsYnWzzVSpdWczfCLNjfRvTNkuAi7qtxmBNYyyY
 c9O0hYmhEniu5bJ3xlOPmVdjJHDhqa9bFQHZMtRfHn2Ce9C5Hau/m3mifYWi0Sxq14q/
 eBkiKpJQCutzHOdpXr8gLOSsY6zBQPk1IWPITIWxaGggqCOFj69baaCzALDIb+FuwQkm
 /K+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY648t8XI91C9I3MBNF703KCdyqbJPYaxfgr8tGMUvdHi7wnWaL0nVmY6qfEfjn5QZGhWWnEo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjt81QW4O8OAtVlWuVY2rnOxWKipAaoNXIKauaJr4KzhITL79h
 jOFiAUjgHJkJi7kLK2RttGXSQeT+2X+0254nRIr1+0c6+0uWYHfRRPcyjJZgsAJJBlc=
X-Gm-Gg: ASbGncsNsHeI3BoA+IOYwcsjVzUwBkoqDRt9LMHEg0dttL28j6+e1HkP/fsXSWen3CY
 QX9aaBh25vCNnVh0NX5TKEcNoVwlWIH6ZJbljinkQX1gx3/jQpA1ZdLnEnydaZRk+wIcOrYfNdJ
 FkxTqKUcdi2Epw9vRM2hIWXmvkxLCfRmOKxY5Mw3uQNqNWsdMoOeniYYpqWuwOtOrg5Ord/M8CE
 ZpsU8BQtvifqjonS6/txXMI/aCOJJQ/Dp90dh3B7Sc7DRHX53TbYCy0xXeZh4xmEUddptvJY8LI
 7froQ/vuDrynBhrQJCrwnudj/m7d9mLWlVV/s/3Y92OlcBLI/DXru6Pn1otE40BQxg4MZs45ztH
 MrgjUSpwbDVRqbscY2F0g7h1YrL1g6xAA77Sp2pMcU8V2FBaZV2FjGBRYvjT1HQ/rcOPCZx+jFM
 IIDJmbtqu2jA==
X-Google-Smtp-Source: AGHT+IGu3G4iMNtpeSCd4OVBiKSd8JuKUTVSJRf/xhl/N5Vy07CQm8PPrpEzKlsHaisfrwLXxumfdg==
X-Received: by 2002:a05:600c:4fc7:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45b43dc5099mr22631325e9.10.1755600899992; 
 Tue, 19 Aug 2025 03:54:59 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:fd2d:e2d:29ec:13cf?
 ([2a0a:ef40:f9e:3c01:fd2d:e2d:29ec:13cf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074d439adsm3276356f8f.21.2025.08.19.03.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 03:54:59 -0700 (PDT)
Message-ID: <1d78f5dd-d9d8-406e-be21-ea5759a2381a@linaro.org>
Date: Tue, 19 Aug 2025 11:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: axi_emac: Fix timeout test
To: Michal Simek <michal.simek@amd.com>, Anand Moon <linux.amoon@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
 <CANAwSgRvnJcZ71eNRCf+9G2NJjq8CxzV43h6w-cGEsmHLGGz+A@mail.gmail.com>
 <b61eb3a3-1c86-4d03-9a80-642ef64f71a6@amd.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <b61eb3a3-1c86-4d03-9a80-642ef64f71a6@amd.com>
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

On 18/08/2025 14:17, Michal Simek wrote:
> 
> 
> On 8/18/25 13:40, Anand Moon wrote:
>> Hi Andrew,
>>
>> On Mon, 18 Aug 2025 at 14:54, Andrew Goodbody
>> <andrew.goodbody@linaro.org> wrote:
>>>
>>> The timeout test in axi_dma_init is not correct due to the
>>> post-decrement used on the timeout variable which will mean timeout is
>>> not 0 if the timeout occurs. Make the timeout variable an int instead of
>>> a u32 and then test for timeout being -1.
>>>
>>> This issue was found by Smatch.
>>>
>> You can use read_poll_timeout instead of a while loop timeout?
> he could use it but then this should be split to two reads because two 
> conditions are checked and not sure if it is worth to do it.
> 
> Thanks,
> Michal

I would rather not expand the scope of this patch beyond fixing the 
reported issue.

Thanks,
Andrew
