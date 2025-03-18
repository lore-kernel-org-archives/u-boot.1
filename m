Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF2CC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 12:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C46280F4C;
	Tue, 18 Mar 2025 13:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S08gewwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C6A81026; Tue, 18 Mar 2025 13:51:55 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3EBF800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 13:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso22242815e9.2
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742302312; x=1742907112; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SX5zRTXEpdRDTNAgerv1TqjtEomL7GS+Od1WueKMBaM=;
 b=S08gewwpYTqdWhIxYuSHGngK0X6pp1JEWdKVdc3dBr4/dtUVdz47cfBw5LsT6+EDBa
 U5PcJD0HOS2s5Z+iiRkc9I6TKZLEbl6uxL8/03yJtoK9ZvxAKjAtrCUGa0+94gAde7zp
 tEydD0Dmheqiyu4t9ZmXa/IyIRF8GQVsnYbm+XBX08+9F0zgbGSm0aHy2rGs9zWoI1IE
 KUypgo1LlfHdRb45R1/iI8nNmsmIpM2q4lPyQYCorRfL8WjfxnLkV3quikHk9CWqCXCy
 1E3v8EEAFC9GNRpQuT9OjQ7pSP30Uo84Bu0zVUF7YKYEYtc5DwOM0hyokDIsICY+MX6H
 +f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742302312; x=1742907112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SX5zRTXEpdRDTNAgerv1TqjtEomL7GS+Od1WueKMBaM=;
 b=cmc3l2sv8YFJVbaF9bKPcSqAFKVfG4U2AOU6/WsTunFDtpWLG5JkVSfq/XPnvCPdBS
 bdXfkaga+t7BV78E2G6mD+NGrxOI1XCdYg08f1CX/ccVz/cVzu6KIZCqQ0uX4FU7Z9Ei
 lxE8wpMwzIGShuT7548aGb+rZWR6pYfJD6ntRMrmkdPCtKjU0ifEpTaiYHb4r8rm65au
 zm7cGkml453bC5lF4DTPjqr4jGQ1YbmREoLL85evmCl5IaZONtRYiYNKiDW1Ear3cIOg
 7Mm9smIk7O+NhhG/BCX/b9f8BtL41FNK8x9OZ3vA2DB4NG89NgFUTI2E+WU/vEEo4Wan
 7r+w==
X-Gm-Message-State: AOJu0YwhBLV1uRspWS9m830h/vpBz+FwC4H2Jo6jyYIuUiis1pKqR/U8
 jx3j4ts5YJjUWc6pCVBUXcV1jWKmtycDoPt9FZApdibeoeZiCPHcZCcGkcTDbhc=
X-Gm-Gg: ASbGncuwdduYIH5ipt5LX8M3Y/k+sBt5zHw5jFbMILkJw7WUkgDiOn9s5+wMACe4VJw
 +8h6xTrh7fjDj3ivwOlBKPldsGug5l0ZSmMKxaynhwSuQ1SqVq0BSEcsXOnMbigq6SWGDpfkZFF
 Ggnim3urftN5rfELuWVraDEar/TO50L8RnzOVkqVLUHp5VKkisA7x0Elyng88FtRfTSDib9JUKy
 vULpI4m+V7n76oHPXS384chdFEmSUJMbGSrczVm9dcE+/+X/rV3BdZBiMGnNWtIs27X+doVkGpr
 Lq25f2IB/Ulr+IS9j2uZW7t9pPmpDPjpFluL3Ga1jhrMb4UGmwWbWPI=
X-Google-Smtp-Source: AGHT+IF727mhQphfmq9mPEgb+/y938wSs/5Ek6ESPl6CHuUAXIY5pkDQ5MWym80YTEXSP0Z+ARzK/Q==
X-Received: by 2002:a05:600c:b8d:b0:43d:db5:7af8 with SMTP id
 5b1f17b1804b1-43d3b9d27a3mr20792775e9.21.1742302312241; 
 Tue, 18 Mar 2025 05:51:52 -0700 (PDT)
Received: from [10.100.0.2] ([45.84.137.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975febsm18494342f8f.59.2025.03.18.05.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 05:51:52 -0700 (PDT)
Message-ID: <913699e0-816a-4b69-921d-d4ead3e3bf0b@linaro.org>
Date: Tue, 18 Mar 2025 13:51:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] arm: add initjmp()
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
 <20250318104659.1114340-3-jerome.forissier@linaro.org>
 <CAOMZO5DRxYEgL7aW4s86i9GBWCZTwTQKQWLw8d-SrrvHmKF-wg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAOMZO5DRxYEgL7aW4s86i9GBWCZTwTQKQWLw8d-SrrvHmKF-wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Fabio,

On 3/18/25 13:28, Fabio Estevam wrote:
> On Tue, Mar 18, 2025 at 7:47 AM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Implement initjmp() for Arm.
> 
> Please improve the commit log by explaining the motivation for adding
> initjmp() for Arm.

The motivation is described in "[PATCH v4 01/14] arch: introduce initjmp()
and Kconfig symbol HAVE_INITJMP" [1]. Do you think a few words should be
repeated for each and every platform (currently: arm, riscv, sandbox)?

[1] https://lists.denx.de/pipermail/u-boot/2025-March/583830.html

Thanks,
-- 
Jerome
