Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7106BFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8260C8455E;
	Sat, 25 Apr 2026 20:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sbD9iX86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F011084372; Sat, 25 Apr 2026 19:58:04 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B1D84099
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-60fbeeeaa7aso5175580137.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777139881; x=1777744681; darn=lists.denx.de;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1NjIXJNKW7DRbAcVeZ6ITMlfqiVJG/JIg5EWLoTUtcE=;
 b=sbD9iX86R7HvAm1JMHehR5rBqPvHs/2udc9Iyh4dP8jRZ3mFOexqGdRSdDBtHt9j1R
 CGhmOT9oRcTvjGbo+mlagalimNNRvJm+XDhp9YTy2Vv7/V6r0zblVbCJUtxPoV98ro/U
 pJwJpxOystFTdvvR3jdSu6AI6wDAU79OQ0RXHAX+1tntQKuaQWy66AD8jfp9mspvJTXK
 7Zodw5ygosGlWukODOZmVfW8MDpm6F33Y9RYmEMavgn6OKp8wD+Zgjl8tPLh4tmourje
 xyNcl8C1l7ZwH5u3gKduGRLg5YgWf56Rd+94tKVov0EPMyk5h4JzDVbnUG5juthzrpKc
 MPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777139881; x=1777744681;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1NjIXJNKW7DRbAcVeZ6ITMlfqiVJG/JIg5EWLoTUtcE=;
 b=UBgRD4h4o1MUYvMkrJ4eMWCwc5+VvAi9TM1DiH2rLyQeHWAIVhhMB4y6zSNs+b1Vta
 oCdjJgnKs7xsI0JsYGq9H9UtFbk0yaH53hww6I/JQsGdsNjUDCH2roYJMnPTK4jxDwVR
 85phHZQMdCBIvjy/p3Lu3ageXJ9qt1KFhak5kNmoF6NqTqj10OfEMw826WkdBTK/96kn
 mwDr9rJiSJKkC0d2H5mKd/rP7tlBdLS/lTZZtQNbPbvmQhQscMLrE1JoPw8XbqOVjWMd
 RCqNl9FTiYuUU4IkST9se9EK/7mLUizb0b8QM/SLwuumFDrW0YOUj0cu5TU0lgaNQ/VL
 V/dA==
X-Gm-Message-State: AOJu0YzlRPqHCInfCK13en9m6IqtJP4xgCRHOpmP683P1SKtRxYax79D
 JlT9xzKnnFZ8DgvgglR7PKBAZhJ/qN8b2dZUFnUD4GnoQo0mH1V1aZ3A79qRow==
X-Gm-Gg: AeBDievIXDCwyDK+5IHTg9ICxNyfKEqtNYKb8sxldgu5e7o+DdXeKJkqn5FlRViivar
 eEHUbCzyt5vMOZN49WMDDBxV5T0ri9hVVxWNcL+KPm0WGfTxXxK+K9qSTLDD0aNKeWl41IM6+fW
 MNjkyO8oSZ9KgbGlvfpIyD6Y58jjh4sRGqAkLUDulum8Ip0vY0CkogNe5vCQyIcL54zeiDbnztu
 VaFBsvEH/+GNoylP8Ln53HTNR9JuAXopeCF2OfGd5RGfgH9ufAJsEovTuQFjBNrh2UB8kZIOg1w
 eJYPTBLag7CvkmEuc79VO44rt0pwzewCfsPPkhfJm1xIUbDXV6ViJRC2wwV2xpYt0PWYY78F/5c
 Q7XqCEcxz9/XeIEeudo2NbVHrcWgbfi47UFd4RigasGozNtcfMuzczpmIHDcTIE6XZ3VY61qMkQ
 gUCATtVdSziDCxfSbSV1tyHXfBpJyrnw7HJuPWOC5yQQr9VsKYyaGxqpNVCoV3Q/DYwKzQunlsq
 E0C1WaawIbpBLtguozqmA==
X-Received: by 2002:a17:90b:388b:b0:35f:bd51:cf60 with SMTP id
 98e67ed59e1d1-361403c3168mr35133914a91.1.1777083506777; 
 Fri, 24 Apr 2026 19:18:26 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fb7b3aesm12779324a91.4.2026.04.24.19.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 19:18:26 -0700 (PDT)
Message-ID: <9b3f9140-8549-4693-9ff2-0b4db1ea320a@gmail.com>
Date: Sat, 25 Apr 2026 10:18:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,0/4] phy: add common PHY polarity properties support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <CAFLszTgMvRHfrEa8=-m+AszoKvxg-TshcH2qx4z--yN6ZwoQGg@mail.gmail.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <CAFLszTgMvRHfrEa8=-m+AszoKvxg-TshcH2qx4z--yN6ZwoQGg@mail.gmail.com>
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon

Simon Glass 於 2026/4/11 下午 10:37 寫道:
> Hi Lucien,
>
> On 2026-04-05T14:49:40, Lucien.Jheng<lucienzx159@gmail.com> wrote:
>
>> Patches 3-4 add sandbox DM unit tests for the new library
> Patches 3 and 4 have a bisection problem. Patch 3 adds test code
> referencing DT nodes like /phy-common-props-missing, but those nodes
> are only created in patch 4. Please can you squash patches 3 and 4
> together, or reorder so the DTS changes come first?
I will squash patch 3 and 4 together in the next patch.
>
>> Add obj-$(CONFIG_PHY_COMMON_PROPS) build entry in test/dm/Makefile
> I don't see an update to sandbox_defconfig to enable
> CONFIG_PHY_COMMON_PROPS for testing. Please can you add a patch to
> enable PHY_COMMON_PROPS in sandbox_defconfig, or imply it from
> SANDBOX?

I will update sandbox_defconfig in the next patch.

Thanks

>
> Regards,
> Simon
