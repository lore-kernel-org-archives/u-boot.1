Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65FFC021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 19:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062BE809D0;
	Wed, 12 Feb 2025 20:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H71vRS18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A667E80BAE; Wed, 12 Feb 2025 20:07:58 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FEF3807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 20:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5de849a0b6cso339a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 11:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739387276; x=1739992076; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zFzpbmyNWZCuo4+NXjy12y0rGA61JKaxPhS6+/VYua0=;
 b=H71vRS18tBDQVl6B8hYXoxrtXkNA7lHJ8ZFsO8yS3/RChgRjKmrhvp653BC/n4OSQZ
 e3+BCyr4MMRJX77eWGUdttJdhnxfvwpTpbu5R30ba3yTdxHBTMlZnhj5GYVUXpdNLW1b
 M7LGLG4hLOFBx9hAbJQHcE8NQEwHos/kacZ2Q538YwdT7hg7ollG+wmHBaSSyPx805GK
 QAzDMKvkYxXlkX45GD0SGx0DexyPJIg2Y11qzhfE8cWqQhA2nofYtSMnbL5kgEc8zkWJ
 JkUGlBwYdKA8Q/3F4yeM8pv5LiqncKOHB8xgKbK9E3VpNGjDNEgfIvHzPpnFj+aOsXeW
 AJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739387276; x=1739992076;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFzpbmyNWZCuo4+NXjy12y0rGA61JKaxPhS6+/VYua0=;
 b=NcgDXRc1O+PzXHPdysP+6npz3BQ93Qm6WUJ5XFxIJXOdDwXR/TgDF4c+U+CLZHX90t
 +H7j5HX14XkIENatM8yt8khKEhSb8dN/3PAPky7qbi9Kjm8UmJ80w1bwdMR5eRj53Vu1
 g0KzheMwEr9IbIULSV5Mgab5kR5mt1wE2sCOCH+ilXVO18jLMSWeJQ1FkTYOPxVAv7EL
 YdClIHseGKWBLCfFV9qihgixcXGpwCx3F1rtXrI9cNXNyM6cX218uDddU0JDVY9l8S9Y
 Q1gajxI4D0uYsSuPZ/gv0uULvEpHSPFE8qgDM63sgz+WPTydEPqPlUAZhhv3dhoG+D4Z
 cENw==
X-Gm-Message-State: AOJu0YyzVtU7w8PNEbEhmTuJ307CWbaCLwi5aCuFJBPrFY/KVB8Qv5Ya
 P/AC/+imbuh2DWjTXScH4G9a2l5zK5jj+Phdbs27XgPkq7DhSSMnWljZZcGo5sVIQgbiNxoRPqP
 45/riqw==
X-Gm-Gg: ASbGnctz52X4GLb0s6e9UuKsQhqcDYOf/feAi1c5mWRfw6TuPeTR/RAMJEukYWffYZV
 6aZH9JLFWrBs2f/tSEe7AfhKmm7lVb5aoSf+2M+hNl8oGe+dXKPO1lyXHSlRTj7PrDfEgxUgGoh
 qx4bZgyQ9b0KnLiis2hz5XhKPYvWeUs4/ug8u5I1Rc1PTJxS0spTvRk63YZJmJkphkWqcuCl+CX
 IECfb282NS4uhiQTFiNjZGoHpBngxbVE/KBx308lA8nTkgefkY48AsRhiLkY2TVSLd8H7A/zf8k
 zCDz6BKVVqeCy5golXOEbvBd39E+aA6zrqD8f0PtUsXaNGF12zi7/NONXwqLBBxw1p6G
X-Google-Smtp-Source: AGHT+IHpCgeLyr/QVK3F1VuJWxCBQV3gBakSP5aPbaVrb6Lc3MNbohjIPJmvDljtGlNuJjxuBDICeA==
X-Received: by 2002:a05:6402:5285:b0:5dc:7725:a0c7 with SMTP id
 4fb4d7f45d1cf-5dec9d32331mr403793a12.3.1739387275707; 
 Wed, 12 Feb 2025 11:07:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:bd0:e26f:4297:3d26?
 ([2a01:e0a:3cb:7bb0:bd0:e26f:4297:3d26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dec93c8128sm201892a12.42.2025.02.12.11.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 11:07:55 -0800 (PST)
Message-ID: <ba4d02fa-e5c4-4686-a851-f2bc9b0d8fa6@linaro.org>
Date: Wed, 12 Feb 2025 20:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please pull u-boot-net-20250212
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <7caf7a0a-c2ed-420c-afc7-620ab11461b5@linaro.org>
 <20250212183851.GR1233568@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250212183851.GR1233568@bill-the-cat>
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



On 2/12/25 19:38, Tom Rini wrote:
> On Wed, Feb 12, 2025 at 02:54:37PM +0100, Jerome Forissier wrote:
> 
>> Hi Tom,
>>
>> The following changes since commit 3da1864b1f2fc3cf2b4eaa1849bcafa669ff674c:
>>
>>   configs: Resync with savedefconfig (2025-02-11 09:57:33 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ u-boot-net-20250212
> 
> Did that tag get pushed? I had to look around and found the commit
> mentioned but not the tag/branch.

Oops! I forgot to push it indeed, sorry.
 
>> for you to fetch changes up to 893e32848f00e71eacdda2f7bfc32aa303f7a01f:
>>
>>   net: Kconfig: depend on DM_RNG for WGET_HTTPS (2025-02-12 10:25:14 +0100)
>>
>> CI OK: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/24577
> 
> One more small thing, I think when applying patches you had it add your
> signed-off-by too, which isn't how things work here (but is how the
> kernel works), which lead to checkpatch.pl noting duplicate
> signatures, which I fixed.

OK, noted for next time. Thanks!

> With that said, applied to u-boot/master,
> thanks!

-- 
Jerome
