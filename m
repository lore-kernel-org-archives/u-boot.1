Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614F6CF2568
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 13:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95DD88B23;
	Sat, 12 Oct 2024 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zXOdTsKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47ECB88B8F; Sat, 12 Oct 2024 15:41:55 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E0488A3C
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 15:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a99b1f43aceso353768266b.0
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728740512; x=1729345312; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j9kLP2nb2ZUlu6MySSK8n1nLANbLDImpre3zdTj/23E=;
 b=zXOdTsKvg4qzFkYqQ+gzkCsiLV6Cg/66fKtDhuRU28itlpSkCoNBOB1IRZsFOin+FI
 fNBYQoJz84XfaJaVtMAKQMffxZnxnlHnBsPzsbRDfuTWPFGHPNCGpuo7eNXgfdlSyNsJ
 GGsBeht/cFEEUbggDAbqO7AtFIXLKXuV7oJhaI/4wMCYGS3FOnkp7uyi8twzijAFcEo3
 VmsydtkvzhUMhoIFM4EW1MbRF6IW7EiwZoXsijnwwV+E2Uqe0K2Lm06Iv0O4Ux9Kp5PZ
 kqC2zbkzWQdTrSVJuEXw81l1/x31AqID2WTDYQmVPra9LwMIKJnbdeM6yzUbkJJrKagE
 HGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728740512; x=1729345312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j9kLP2nb2ZUlu6MySSK8n1nLANbLDImpre3zdTj/23E=;
 b=rvmFSOWMdn6v0BmStfGjlVTmg/GWbpl/ZKZyCiYq/bJS84Sw3gWYVvvwG+9CxDFzVN
 S5PIwbuFfC7T/Hfbm7kJ/JlTcTZoqwpgA34jcT/dieaIaY+go4jn2d/6j4lJTVjmVzBE
 E25zBAHuWTXuVXl88vP/WICiWFRLerl0zKh9f3rnuukOij+XHBc/wwyRmoN6PsaEiyI8
 CmxewjMbNRRW0bz6+3y8Li75vbAY9jeQK6vMF+6MN4iBPZ62BYym52YpamUdBHJUHGDy
 YUZg3+wnSxYAw8YVu0m9AqjYJkEEvLvBPEdRnFt3dpfgpo7xulvduNBJaTc3XksRZj7y
 AC1w==
X-Gm-Message-State: AOJu0Yz0SdkIPwtNXCqT23JnSFOESftdfDLmeXeXz2wC5Neom5TblF9Q
 91AijudNE8rL6cUKoG8jB9VSWYxVe18CXSj74deSxB7qENOd1ZutF/7cqylA4i8=
X-Google-Smtp-Source: AGHT+IG5J3/ZSoSM54+Fhe94d+cr0a0GpTe3oG51aeg42MKzsr/TK6Y2g/ZJ/NEhnoyFcg+F8sBZSw==
X-Received: by 2002:a17:907:3601:b0:a99:5f45:cb69 with SMTP id
 a640c23a62f3a-a99b8775bd7mr487521766b.4.1728740512448; 
 Sat, 12 Oct 2024 06:41:52 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm61260666b.102.2024.10.12.06.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2024 06:41:51 -0700 (PDT)
Message-ID: <23512193-9b47-4845-8fa9-e27ee054e412@linaro.org>
Date: Sat, 12 Oct 2024 15:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ufs: add support for Qualcomm UFS Controller
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
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



On 10/09/2024 11:50, Neil Armstrong wrote:
> This iass Add Support for the Host Controller driver for UFS HC
> present on Qualcomm Snapdragon SoCs.
> 
> It adds 2 ops to allow more control on the UFS device.
>          
> It has been successfully tested on SDM845, SM8250, SM8550 ant SM8650 SoCs.
> 
> It builds-depends on the following serie:
> https://lore.kernel.org/all/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org/
> 
> And at runtime it depends on:
> https://lore.kernel.org/all/20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Tested on the RB3 Gen 2 with
lore.kernel.org/u-boot/20241012132251.1840147-1-caleb.connolly@linaro.org

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> #rb3gen2
> ---
> Bhupesh Sharma (1):
>        ufs: Add Support for Qualcomm UFS HC driver
> 
> Neil Armstrong (3):
>        ufs: add device_reset callback
>        ufs: add get_max_pwr_mode callback
>        ufs: allow UFSHCI version 4.0
> 
>   drivers/ufs/Kconfig    |   7 +
>   drivers/ufs/Makefile   |   1 +
>   drivers/ufs/ufs-qcom.c | 670 +++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs-qcom.h | 147 +++++++++++
>   drivers/ufs/ufs.c      |  13 +-
>   drivers/ufs/ufs.h      |  21 ++
>   drivers/ufs/unipro.h   |   6 +
>   7 files changed, 863 insertions(+), 2 deletions(-)
> ---
> base-commit: 7725e4eb07c03ca0842b0a7ed425af28e1b8ed37
> change-id: 20240910-topic-ufs-qcom-controller-4b2905610963
> 
> Best regards,

-- 
// Caleb (they/them)

