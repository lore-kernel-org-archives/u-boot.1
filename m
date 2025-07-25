Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8FDC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 10:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69F5838FA;
	Fri, 25 Jul 2025 12:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mm9TZFyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EF18391A; Fri, 25 Jul 2025 12:26:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902BF838F0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45611a6a706so9686755e9.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753439157; x=1754043957; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LX4DONskVa/cTeFtYXmQe1uaA7iDxnew3iUcWsIEfak=;
 b=Mm9TZFyYhq8idhJ7aT+OcEWC4bg+W1LPJFxC4t6zp5ao7af0hty/rja8LqoYWjv6+B
 Ou+50c7lRcnTwAihqqijSq/Hd9xP/uw4TdS66QVWCSUashqS1oTwbPLSwHBhWgkq/GZ7
 wyRgbkkD0PARugCDzDfxmUJEeBNs3zfExrCUgZ++pQpre3MI4v8c5K7sJGu9cUccGMAB
 mQkKI1KHPdwznjAeA7hKYlDSRN57axEVlELsAvCN4xiFGr5IRzL1cU/svUieVR1v2WB3
 Q5TkLsDLIeqgr4Zw3IFm8PMANvkbrU8WP6vT6+BByEr1SRRpyuMr4fhLfZYo8ZCsFh/8
 60RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753439157; x=1754043957;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LX4DONskVa/cTeFtYXmQe1uaA7iDxnew3iUcWsIEfak=;
 b=DN2pe1YRypquZuexz/ey3nMgMhZh6dtKasNTwoKXuq22/CVIJAK3AOkEHD5896WHSI
 SRaOlZdLFjer709xRyVCsWePm19QvbZbPMYcDRkKK9tIfWRCc9tamBBxPqitTa7XqvuJ
 SxnVF02kG5ZbYRs/Q65Pz9TY3gyfeNiTvczHjXBwp2nqShftBSop2Hb9aZ2XAxz+Cg7U
 XJE6mlejOcOy3SK/jZlAnssRF1tmPVOzT4jDzl1I4cCq2mEl/rnzsiVCXfkhq3JC4TpH
 tlIkegtFrokQ/k/SPOJ7qkOc0n+1PxjTFv+api2repdPgsQAzbNB90DwfBvWBFQbuchq
 ykGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVKTgsmJ724JecZ3Ml51qodZ5zPG04X7k30DQjARNR8bfP84XVfO5KMe2C5dt1/YhNrXwKrN0=@lists.denx.de
X-Gm-Message-State: AOJu0YwIeO/hoi1SvCvAN9B6uwzSMBUC/h7Bw/H5DHOrxe4dh8AAyTtF
 sBzOtF5cGpl0Sm15E2H6c/gIAwXcIcSvszOrrx0lsHcwEhaM6KqVok6ns8kWqIo6DWogltoJ3RD
 h5ApG
X-Gm-Gg: ASbGncsrBW5hfGkaHSqDWNcvDuMqf4DVRarAggJiVuyx1Vn8EdT1eyhfK254KMb6pFR
 p5V3pZRGvSPPp1gQA9QY7XFgKIC0ow3W0KE5M8ISVBMYhrzOvidK4vBIHLdpt39QQKiyokbDYTJ
 L0qU5926J7XJG6d/dA1SlumsECQBmif0gqG4iYdeE60s/Zcel2olubySsOA01WOZcvu2F7MA4DE
 caM13XDJJWuGx/QaDFri/V7504vnwcL4hsJWEj1pWo8BkgGf5THmNJF6LsLYAndcLGU+nDRHepw
 LeDJIZ+g2yISru9QspF8YeAEt/OLWX9+05c6moX0VZZMB1ykbMRCyKB0DKy/FQQgdHa4H3GpCwA
 6qXWsIli4US1cOy/WoVHS81A/+c6ZbmLfdFlMHMVWUTEQPzSHVVwzAN6xr6oPth9qNUsuU7qEnA
 pCFQqhSikcsA==
X-Google-Smtp-Source: AGHT+IEIZODAmFgNvJSGPXB1Rp5lKUbaM2/HdqxPXvsZDRtGt6vO0ZhSv/3zLjHbvxaOwARe2qzArQ==
X-Received: by 2002:a05:600c:4f87:b0:456:133f:a02d with SMTP id
 5b1f17b1804b1-4587644278emr14122975e9.17.1753439156909; 
 Fri, 25 Jul 2025 03:25:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748?
 ([2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705ce781sm48770715e9.31.2025.07.25.03.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 03:25:56 -0700 (PDT)
Message-ID: <4e615e60-f9f1-4700-87a5-620bbe1ccb05@linaro.org>
Date: Fri, 25 Jul 2025 11:25:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Michal Simek <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Smatch report in drivers/fpga/socfpga_arria10.c
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

Smatch is reporting this issue

drivers/fpga/socfpga_arria10.c:536 get_rbf_image_info() warn: ignoring 
unreachable code.

Looking at the code, that for loop is a bit strange and I am not sure 
what was intended here. Could you please take a look?

Thanks,
Andrew
