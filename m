Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ACFC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 17:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C8E882B5;
	Sun, 19 May 2024 19:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FuyOS/gv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE9088093; Sun, 19 May 2024 19:58:20 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999D688093
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 19:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so904286266b.1
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716141498; x=1716746298; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xxsjFFi7laulX32frmk5ky0PlsMDtnC9zEBzBioaaKA=;
 b=FuyOS/gvYjgFb4mlk+mW5nfkiLcQBGS/BWZxAtf7++sqE9YjPCYj3PANSspYHEiO1c
 ur4TfjDiYlW0TYzwQlCH1f7Lb862wd0YuM5n4RddpXwZJUnJrXhSK7DIeVnyNeD7CPJc
 48VRmt8aN8PpsRsPCeZ9om0t56NuiiT4qZFKlX8fNhG4MFtOZOEMDeu8/v1GmEV4X28n
 gczIPzK17NwI8aYmluQVqee9CUddxBck9ifDha1QOlyEniUuMsJPZoj1ECB6c3aw5YLp
 g63MpdBKugM81KeomgFePNisz9a/+0OyYYnFA7mbykGLnr7djjBnLIjDYVufNCGdOx+g
 IPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716141498; x=1716746298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxsjFFi7laulX32frmk5ky0PlsMDtnC9zEBzBioaaKA=;
 b=sOjjy87WSvau/jHhNU5IDMMiwMiiXWUvcgV3Sd1z3NkvqMnN1mcVRfXOgYWjYNiPQz
 eAMiUptbUtSqVPOevYks4tvhtui3LGT1y8aOdbzEvDzLAJ4ndm90wZOHsuuU3+llT8l3
 SRCyV9Qh10GeT2f/H80Fir63aWndd20W61pOu4JzINS55FrXTwBkA9gZL48CvBSVLxSS
 4lDjGURFE2o6eqP9voHtclBDeve/HbYzZbyyOKKRLpI1DcMAWIWvl2bUdzBeBHBg0Zhj
 xwvziQcpxmd0ZiSFa2rsr8qrs5MZCE8YEH5dpqUFArTcUkau/fZ62Kj9VUolGWq4awkK
 uCtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA2OhOikENcME1RVzY3A1RBoo6iEzfpXH3nL5gWQAPvAqc5GF2v2MqN5FmnyUT0Bz9Ji/PalIBoFvUkqbbHMZnUi+tzw==
X-Gm-Message-State: AOJu0YzfSLv7/pJ+mRb9luFvDYJY86zovXJg69lpCcnTpT4yty/e3ZPK
 qdZOTn4QGH5HLvfERoMGvkwhktZLig2PrtctnDb8JPFQCYD16Ovq
X-Google-Smtp-Source: AGHT+IGAaoPMfOXHZ4x1Q4vqcVpWzMqM4udHIa5CXzEXbXn8acAm/XZZ2/2ExFuKYJXSCstG+K3J1A==
X-Received: by 2002:a17:906:2dd7:b0:a5a:8cc0:8c23 with SMTP id
 a640c23a62f3a-a5d5ecdc937mr377043466b.27.1716141498105; 
 Sun, 19 May 2024 10:58:18 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a178a9d81sm1367006766b.83.2024.05.19.10.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 10:58:17 -0700 (PDT)
Message-ID: <55dc9e12-cf6c-4f9e-a064-3e2f54d9e339@gmail.com>
Date: Sun, 19 May 2024 19:58:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] pci: Enable PCI_MAP_SYSTEM_MEMORY when
 ARCH_MAP_SYSMEM is not set
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-3-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-3-1ea7d23f4a1d@flygoat.com>
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> For MIPS we are always looking gd->dram in virtual address so
> PCI_MAP_SYSTEM_MEMORY should always be enabled.
> 
> If in future we ever want to make it physical we have to set
> ARCH_MAP_SYSMEM.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   drivers/pci/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
