Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE19C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7878F80FB6;
	Wed, 26 Feb 2025 15:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HydhLiQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F57F80FBC; Wed, 26 Feb 2025 15:44:56 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8D9805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so46344805e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740581093; x=1741185893; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HPaj5iMMwSOxZdDWtxyLbH0pLtl5pmeUrCaWVhtTO7Q=;
 b=HydhLiQO20ocH7pTp9FYgr6OFtjqMmEhFEbsoiPoo9lPRrUq+taX1ZzcLP4NEDJQ9l
 44KLxPt96/RZmdIqUQZj/GCXMuvbfKs7AgYx8pTHYL+gpyYL9LPdT8uR9H0aM+AvelPb
 e5OmhVqK9cWpoWSS8j4aPrJHJWU9Lhh2HWxcow6bsHdVxeu8jKIvvVI61zPcJVJRG5iD
 EgkvAgNDKiVmAOh8972M7xICm+bbNyY6IPDBz9WKINozmlm8Czsc3MZboZhJXVYufhfr
 VsZqIYkVV3ixQgAVnjIuwP1Dk7vG59RkVQunXoC2xW1Ptl9TduN58uvbKq4rDSbdc1fC
 Petg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581093; x=1741185893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HPaj5iMMwSOxZdDWtxyLbH0pLtl5pmeUrCaWVhtTO7Q=;
 b=lXvH8sXD1n+JFhp1CIFhJXSL5cpxSesvrMuUQhjzIRS3edPxwYtZIEp/0f3RGTxqG3
 Pz8t9Pi/GIFx1Y5GdDd+1Z409wIoEsZ5dalsU+S8DnAtGWM29JeBpisycMCzaa3aP4iM
 gQkBEY56/5n7cy15c99XhBXtsm8BTB2MYpEoK433ahVycUEjQd9+9HUCzQq/InTyzHE3
 ZW82lmGwRbLXdNQoIuH1As7fPBvvtoOFFxYUHsE60NuivWlGM4MvL7J44oDwidE7q9Gw
 skAizL2R8yP/Dc1YAleYghXipUpIz2v3VvkCncAqx0E8T0P4YuQ7IKMYMuN2vsaVBC4B
 waXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqTcb9AI5PDc0Qi0/DRxxd5WIJT/nuMEIB1WiuEbtcAkMAmZcG/O5vFXs/qp7dViMu6zSqC7I=@lists.denx.de
X-Gm-Message-State: AOJu0Yyz/kMrMFDxPR8NFDIn2D0qNYsu09EMzHNBMS5y3626ZULKh/ds
 OjAhl20AX0iL8O4bVJrQncHvR7rrOrP1D9f6O+XR8d40zD78YkHyivUc2xJDbaA=
X-Gm-Gg: ASbGnctcIIb+scydXEFgTvxEdrcFmVMcbgryNrSnCKQpHMegfKvoNMmg9r86ijPJ3Dg
 xd/6/wqJvFoxjFJfRpch6mxMtr3egRjwabgAHpCwOG99c9CdgY5pJ8ESk+hQtuAEvtInVsruM2+
 fOQYPTmUptBZ9ibGlC9vpC6GDISgttDP0xVfrlY/P93Wh68UbVtvgNsM30vao2NR/119xj/vO60
 PzdSQEwgeFlrDwwDn5bd1awd5iY+T4G+4xBp7VnerHkHoPd96T0ASXlW/740kgBghT8W0e3wfYk
 4TXIkwlJUn3jOomKKEeDXY/C+WPGOZpkMGWNLjZp5u+wnnWhX2NQDWpb3CFWrQag/lJj7XSb13g
 NW4+texA=
X-Google-Smtp-Source: AGHT+IHeqL2gnGWe2Ul1/+RhkCbD/ZvDAUP/UmrJ5tZFIz5pJnRWToJPf0XHsFwCNy94CzgNyJW29A==
X-Received: by 2002:a5d:6dae:0:b0:38d:d946:db15 with SMTP id
 ffacd0b85a97d-38f70773086mr16700269f8f.5.1740581093664; 
 Wed, 26 Feb 2025 06:44:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2?
 ([2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390de3bcb14sm1194890f8f.40.2025.02.26.06.44.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 06:44:52 -0800 (PST)
Message-ID: <034c875c-0ed9-47d0-aebb-41413b5b1651@linaro.org>
Date: Wed, 26 Feb 2025 14:44:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rng: msm: support newer SoCs
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
 <9094cfe6-34ae-42cb-84c1-6965121d1a19@linaro.org>
 <20250226142134.GG2640854@bill-the-cat>
 <20250226142248.GH2640854@bill-the-cat>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250226142248.GH2640854@bill-the-cat>
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



On 2/26/25 14:22, Tom Rini wrote:
> On Wed, Feb 26, 2025 at 08:21:34AM -0600, Tom Rini wrote:
>> On Wed, Feb 26, 2025 at 02:07:28PM +0100, Neil Armstrong wrote:
>>> Hi,
>>>
>>> On 25/11/2024 18:12, Neil Armstrong wrote:
>>>> Add support for RNG on newer SoCs which shares the
>>>> RNG hardware between different Execution Environments (EE).
>>>>
>>>> Also enable it by default to fill KASL seed when running Linux.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>> Neil Armstrong (2):
>>>>         rng: msm: add support for newer Qualcomm hwrandom IPs
>>>>         configs: qcom_defconfig: enable RNG driver and command
>>>>
>>>>    configs/qcom_defconfig |  3 +++
>>>>    drivers/rng/msm_rng.c  | 13 ++++++++++++-
>>>>    2 files changed, 15 insertions(+), 1 deletion(-)
>>>> ---
>>>> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
>>>> change-id: 20241125-topic-sm8x50-rng-714cd0012391
>>>>
>>>> Best regards,
>>>
>>> Gentle ping, who's supposed to take this ?
>>
>> It's amlogic, you can pick it up.
> 
> Sigh, sorry, too early. Caleb usually sends the PR for Qualcomm but if
> the two of you agree you can also send one.

These are already upstream and marked accepted on patchwork afaict?

; g ls -1 a1efde55bbaf
a1efde55bbaf rng: msm: add support for newer Qualcomm hwrandom IPs

; g tag --contains a1efde55bbaf
v2025.04-rc1
v2025.04-rc2
v2025.04-rc3

Looks like it got missed on the thanks list (did i totally forget to run 
b4 ty?)

Kind regards,

> 

-- 
Caleb (they/them)

