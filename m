Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736EBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 14:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C176E88606;
	Mon, 29 Apr 2024 16:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rBOTfhUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0FA28862C; Mon, 29 Apr 2024 16:44:09 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E057883C0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41a1d2a7b81so31306665e9.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714401847; x=1715006647; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A2FhN7HRdbq9ewOnzICBM9zdVMI9FEEsvXoiSNzm0WY=;
 b=rBOTfhUZxmfUlF93Kzy8ZAVIhbChhMWJXjpz6eWwN3oX5dCOOVce1PO6gYooO0J/Hh
 ymzUTNpV+L54niYQAkbrX0IqbF1lNGFEyvhx75nLuy3YUCTgJA4VXc9fO63Fcq8z6cKV
 WHUlvqS2uRyN3VLtzcRHZOjtHGs95R5x4Az70l1ZOPMufDLgK9KpZEVziDmsLiIAL9Af
 yozKoV+P6u5I3G2Tkd/QWjB6qTrdbxSfhHqV/gOj4JfGEFw4JlMQ7yzhu64vrwqhROvt
 62tT6vVCEe7RTQ65i9uvU4oT/+Dk+wY7e+XquTLQq+1rj3T7H/eP9lemNZocgATGvtJ4
 2bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401847; x=1715006647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A2FhN7HRdbq9ewOnzICBM9zdVMI9FEEsvXoiSNzm0WY=;
 b=QKpcJU+DnZriTtj3NkfrubgcgimyGDo5z8f4tRAT9yTO6Py0k8j9B6AZEKxVVXJ45M
 r0iNbfzoWZlyapQ5LbP6uTv1hwflbFvhszPK32lROpYZT2BN115AmX11NKAp/l/M87JF
 OKGnsl2X1C9Z8hJ4RnZaZEqkHh6LXUBbajgq/Qlwm2uehyJAIcqd9mxka420arU+WbMb
 8SuamZP0Gm6uR8NR4wiR6HxKXUeM6/mpEjwZz01azWo8aW9R+apQyC6m0QpzkMCfmyzj
 GS9hVh/MedLHgGZ6lDkMP5FLFrVoY8PXgWTBhXeSkWYzKzGcGu/2adVuY/zs/LbgTuru
 quFg==
X-Gm-Message-State: AOJu0YyNM3mg1bfvkWfXiC1i5iC5/LhGuB9Hoqw4T5y5lUl+YC7tPF/l
 VNWsa4iC4W1gxwhMSRWQqH40q8jYuM42qiLZbU4eMOXXR98+4tTY5O44psCZvoE=
X-Google-Smtp-Source: AGHT+IFnr1hi4eFhY5YcdU1xTGjQKLXG8KZNGP+XBIV8s6+wIfR7S0Qn/be6D7NorN4reihgQAcLiQ==
X-Received: by 2002:a05:600c:474c:b0:41b:8041:53c2 with SMTP id
 w12-20020a05600c474c00b0041b804153c2mr9825471wmo.15.1714401846821; 
 Mon, 29 Apr 2024 07:44:06 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.100])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm8925830wmq.19.2024.04.29.07.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:44:05 -0700 (PDT)
Message-ID: <c1445ce3-a3cc-4155-999c-2ab1b1767e85@linaro.org>
Date: Mon, 29 Apr 2024 15:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mtd: ubi: Do not zero out EC and VID on ECC-ed NOR
 flashes
To: Pratyush Yadav <pratyush@kernel.org>, tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, vigneshr@ti.com,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
 <b92b89d130f8075cebf74bc02eb6efe41afc6d75.1714020303.git.Takahiro.Kuwano@infineon.com>
 <mafs0v840b6d3.fsf@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <mafs0v840b6d3.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 29 Apr 2024 16:45:09 +0200
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



On 4/29/24 15:17, Pratyush Yadav wrote:
> On Thu, Apr 25 2024, tkuw584924@gmail.com wrote:
> 
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> I wonder how authorship should work for such patches. Patches 1, 2, and
> 6 in this series are very close to what my patches did for Linux. So I
> wonder who should get authorship in this case: the person porting the
> patch or the person who wrote the original one. Same for patch 5 but
> that is still a little more changed from its Linux counterpart.
> 

I saw it's the one that ports the patch to u-boot even when it's a
1-to-1 match. I guess it's because u-boot has its own dedicated repo.

cut

>>
>> This patch replicates the following upstream linux commit:
>> f669e74be820 ("ubi: Do not zero out EC and VID on ECC-ed NOR flashes")

This paragraph shall give credit to the linux author and at the same
time help others review the changes.
