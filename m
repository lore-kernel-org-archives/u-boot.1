Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02680CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 09:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C677888B2;
	Mon,  7 Oct 2024 11:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PPMCD7kU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D2188D33; Mon,  7 Oct 2024 11:00:10 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB11888B2
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 11:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99422929b2so202855366b.0
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728291607; x=1728896407; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iOfD0wsC3+w30mtKcsr9flwgN/37VeqIUUtRgySBCFM=;
 b=PPMCD7kUPoJyZdS0frlrjSJd9EStZ2irmwdmXJdG+3hpSpVVPRW00VXmjOeRF8Xzqd
 xiHOKWM9+Ym4QTTPTv8VW579zqkb6zu19Z0M5Due/SVspoYou1RY47vFJd/PtLI5PBOF
 4G4PsL/wofYNeeOFPzyXZ+0zFbLUNSuvjPLF8FSeqKiBuI+FkWLo2ZhSznxT/7iYl3qf
 cwRq2TJIgeeaZoelj9Q8jjfN9HeVwi/6gXNjucxkkIfboVzIursVSXVjFhonJ++MjFEM
 jAhvw7Jz4oDyMCDtnatzaKwOGFGtOLTzIYlKqthCU/Q4+IhoI1vcy/RslEI3yfSVcPcp
 O/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728291607; x=1728896407;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iOfD0wsC3+w30mtKcsr9flwgN/37VeqIUUtRgySBCFM=;
 b=H2pCYk91zcnSkrvbdS6zAOq4vgdTrP3ys/5GQuEhHzQ1sAzODzzrKhG63LV05btt6U
 VNx4ZD62tqlQX97TNlk61Agp1k3GlC2lCxWTwT09l7lbDpc++9jX1lZhtpX3lb1xr8a8
 3/0srZSV0OW9LRAJ3m0Uwoz99l8HT/X2O4gd6wPm0Mqw4twZfs5Z7+ZuFWTKOpB9mNqw
 FJL6cW6aplmINL2ibqm+sD6+X4kpByW24KhRzRD/uoLqT/Ttk0UlIxQO3D7zTDBpXrFi
 F5WFz+oaFTLB045TghQi+jKV1viYRhpQrDDeATnl6PRPpJrDAzXnWS863zskrFWsdgud
 aKKA==
X-Gm-Message-State: AOJu0YxFhPH89qD/mlaNPohu/HBaqlop34nst/dxtMKSLuRJKjtYSTA0
 +rpoQzi7Ol1Zh2z7Tpal9qgok9kDsM2cy04Zhx+E1Jsd2Ua9VeeN/up9y6jOCDg=
X-Google-Smtp-Source: AGHT+IGgeRGS64gdi1GTvTpQlRKcbOKZAp/+cDoFct4BDg2lOELltsHzq5/eVgOJR2eGW8WDFC2iAQ==
X-Received: by 2002:a17:907:7da4:b0:a99:41e4:4a80 with SMTP id
 a640c23a62f3a-a9941e45074mr692118166b.32.1728291607242; 
 Mon, 07 Oct 2024 02:00:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75?
 ([2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a996167411csm12675066b.14.2024.10.07.02.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 02:00:06 -0700 (PDT)
Message-ID: <1db50d22-8de3-4fb0-9490-60a42cb5e241@linaro.org>
Date: Mon, 7 Oct 2024 11:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 25/29] CI: add qemu_arm64_lwip to the test matrix
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>, Simon Glass <sjg@chromium.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <b7cc4bc4d5aea1310401c107f7836a9eadd6a493.1727968902.git.jerome.forissier@linaro.org>
 <20241004182535.GG4737@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241004182535.GG4737@bill-the-cat>
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



On 10/4/24 20:25, Tom Rini wrote:
> On Thu, Oct 03, 2024 at 05:46:29PM +0200, Jerome Forissier wrote:
>> Build and run qemu_arm64_lwip_defconfig in CI. This tests the lightweight
>> IP (lwIP) implementation of the dhcp, tftpboot and ping commands.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  .azure-pipelines.yml | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> This should be in .gitlab-ci.yml too.

Updated in v12.

> Generally it's close enough to get
> without testing (and using the linter if needed), but I'm sure Ilias can
> push something through the tpm tree for testing if you want, and we
> should get you added to source.denx.de (please go sign up) and access to
> the -net tree, really, anyhow.

I have registered on source.denx.de.

Thanks Tom,
-- 
Jerome
