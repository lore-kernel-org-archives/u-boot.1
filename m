Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38218CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 12:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFA63837F2;
	Mon,  6 Oct 2025 14:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nhivxqPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977A3835B3; Mon,  6 Oct 2025 14:12:36 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A0C802C1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 14:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b54a74f9150so4136157a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759752753; x=1760357553; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=puVoqYStGefsqEVUdTH1SBRxpM1DAKOonRANqNTHhW4=;
 b=nhivxqPaJ524Tb6GlUcHBOrrJyA7pbCmy7I/Z/Uhak+W5ssKgx/AngGAfO5Ye5F2nw
 3ZWJvaYGK1CGb3QN0sE2j0ZUm+UtRNrZ88cWHnMPEuq2f91If/0/kYUNatUAs2AF8+F4
 s6Oh8Tddjy8XAwO953K3WFgdxBrKxspAWpD+M0XlWk6D2AX3yBRpwlfvEGKBLdZ+PIeK
 5F1FtojMH7kZMFJscY3OSlM7900MkLBQGX/v+6K14vkU6JPIiZHeAHgP7JsazaDvhpPQ
 xiOKJpbaY15tlzSj3wUhYKUl/DwT4o2Ig19/gZMknuCEhY3zpqnLTT7gaADlDF9sY+yV
 wl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759752753; x=1760357553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=puVoqYStGefsqEVUdTH1SBRxpM1DAKOonRANqNTHhW4=;
 b=fs0+6ozpDfWegmtyP0RCzwAAhwleLEzCj8mXxvmMfwtUKE51OTcG0x7EjyxVPF9zXt
 9YUqg6Q0d/clalBCXoCh2BIVQhP3uVdiIy6M6LdzcbXvsFN2T3+ORN5xoh+AKgrhvOVa
 OrdvUszh3+Lr1sxPn8MoShoIACwyoCq2yJqRur9a72Gwtj2wB9uy0dCg3UzPAIRWT/5S
 wLenlNf/HTwKNlNl9vazGOjqTJuwupzl2WNMnZYJIsbc5nvjy+6AqA6wQGYgWK/uqN2q
 pOuFieWi1G9pf9y4di9vd8ab2K8715ERyDNyeJl8GWA10+QLRokHFejRAGae2StF6/aT
 DqoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzmdEDe4Xt1c331ofytkhRCb8IpAByNP2ePrNG04uhE6776Xztt5k4ElFGTMZjeyyvXAn2XWw=@lists.denx.de
X-Gm-Message-State: AOJu0YzhH/G89Tw9eftK3AgMWsTRXrjphbNR2Gfmg8Mcp66jMgKzWuPy
 N4Kch77Gn1HA2ga8ZlFLDanFs3EV0uVkoaPaBIgz//KxYEzj2wKcm3Ei
X-Gm-Gg: ASbGncuXR6/wHAN06V2Esic5QII4RPbxrbYAY1JWrUbuY79H3FJald1B5yggdmwU4An
 F+KulWG+dfvMdds2HPIRFvYwLxs49d6Z4rsAFljhaJ/UT8ay3Gpq0GwzmI/0S8SqDEack2QtLib
 9yVCdfwfHfkZJtQJp3WiYgWG6tOMOjW3JeI2KTg7gnI2CKTmwT9I1vMbVGjZ6QPMJnwSIkaYiYr
 v4S+Wr+mNdNL4GOLD5my/c0yXsmf+hRX97W+C7M29zPyH5Msf2/IXycvmJEZlS3vFNrVuIDfkjd
 iiPLDqFMzclCxtfJ58edz2y8I8wVZHTO8/TiYZno1lQ1PtJ2ar1l1WEzmy4nnBxGG6t+JoicQdA
 dgDXXN8UXgp0k2stx41Wh4lPPaLf2x36M7ue2HQphouGc5RbFVcKXCR6LwgwOIhS4JZjfjMFa5w
 I0OFopPbCf2FGff6i9jXrowz4N4LW/BJ4=
X-Google-Smtp-Source: AGHT+IH60hZ4a/9Ci2WmfqRfoDuFvRKW8+bNj255eUGiqFbpZeqDMxEDBJpvOgY0Q6JXB7wBGEbBOw==
X-Received: by 2002:a17:902:e801:b0:269:ba8b:8476 with SMTP id
 d9443c01a7336-28e9a6a20efmr158068315ad.56.1759752752840; 
 Mon, 06 Oct 2025 05:12:32 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1b87e7sm132104515ad.82.2025.10.06.05.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 05:12:32 -0700 (PDT)
Message-ID: <c6df59fb-0aef-409a-b3e5-59cb0b7fa44c@gmail.com>
Date: Mon, 6 Oct 2025 20:12:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot, v1, 1/1] net: phy: add paged PHY register accessors
To: Marek Vasut <marek.vasut@mailbox.org>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006044405.30376-1-lucienzx159@gmail.com>
 <4fa8531c-e6c2-4a3a-b284-86c5bdd94530@mailbox.org>
 <251a26cf-fef4-4d20-a278-881ca31ddb97@gmail.com>
 <bbf07b05-f842-493f-acf0-5d1f08be26d1@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <bbf07b05-f842-493f-acf0-5d1f08be26d1@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Oct 2025 14:52:24 +0200
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

Hi Marek

Marek Vasut 於 2025/10/6 下午 08:06 寫道:
> On 10/6/25 1:59 PM, Lucien.Jheng wrote:
>
> Hi,
>
>> Marek Vasut 於 2025/10/6 下午 04:18 寫道:
>>> On 10/6/25 6:44 AM, Lucien.Jheng wrote:
>>>> Synchronize paged PHY helpers with Linux v4.16.
>>>
>>> Why such an old version , current LTS is 6.12 ?
>>>
>> I just meant to say that this patch was initially included in this 
>> commit. I'll adjust the wording here.
>>
>> For the next version, I will write the commit message: "Synchronize 
>> paged PHY helpers with Linux v6.16."
>
> If you are synchronizing the headers with 6.16 fully (btw. 6.17 is 
> out) then sure. If you are pulling in single patch from older kernel 
> version, then refer to that kernel version. (I am a bit tired today, I 
> hope it makes sense)
>
Thank you very much for the thorough explanation.
>>>> linux commit
>>>> COMMIT 78ffc4acceff48522b92d8fbf8f4a0ffe78838b2
>>>> TITLE: net-phy-add-paged-phy-register-accessors.patch
>>>
>>> Please use the standard abbreviated format with 12+ letters SHA and 
>>> commit subject -- example: e37de002fac3 ("Prepare v2025.07")
>>>
>> OK, got it.
>>> [...]
>
>
