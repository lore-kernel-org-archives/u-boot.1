Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B78C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EA2482C2F;
	Wed, 18 Jun 2025 09:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EdTF/UQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2533782C2F; Wed, 18 Jun 2025 09:32:29 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0AEC82BCD
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-60867565fb5so11707790a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750231945; x=1750836745; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GtQPppxhjpMR6/fuByP92G2HBljzabma++U8Jb/IH2U=;
 b=EdTF/UQy617XQow5/FFfM42S4CKn8Q61peBIHkm3rItDCwluGHI+QT5mFWfw6EyBVD
 u+xmTscYBdJ5vgEwFe8QnNcnVit+xZ5XNW6lvR8XYw8dRGhNbhs1yEHOBOlCQVszJe0Y
 7ouBIPBpCSd+Wi/h31BSU0oPopRIsNcZF5w6g9Ok5bJPJdeZGtkJ9l0ttuU/1lyt7rRk
 SbV10h8eeNDotGMa4Ef0kjYD4StiftitfpmEJ4C8l/BIcuMsk4uQY7YWOp3qq9MeSTyq
 A/Pn8xgTU5HQTnNqej+AEJlflkjbG1mriFJPHOnb94V9PIcWZD1AQ0WILghveP8ZqiJ+
 H/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750231945; x=1750836745;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtQPppxhjpMR6/fuByP92G2HBljzabma++U8Jb/IH2U=;
 b=V/HvXWgo8NMPSdoVxvqqNfFQBff1JMWCbGpJiat/F3E+YgZphbvkEA3E0DlvI/Srg8
 wIIzG2XfwQavoBADDdpxJceekggR5kGWz78nD7VAEyTthLwOtcoGGEkONYsZyevjUJKS
 cmRFwAIL0uEvNfqFhrIz7dD+c8ZGd/s6h2kKuggf5BOeQXgGD71R//LTfzW0U8uJdhz8
 sESQfANUg64v6QmRGX5KfcjAjOY5R8rBdKrWGt00GF3xbLBAi1PWYpRvkVoXAR/2pVS4
 d0nPx4r28UeV1M3fzHT838u0jeUJP/wH4Uyd2FQH11jM32pA4/fAYG1oP4hIfsQwM46v
 hPYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwafFPFHQzKOG0G5xG7jaiA7uUz/VoTiW6fzgBhmjHJcN8vNQ9gWoa4AHWQDLga74on5H3u3w=@lists.denx.de
X-Gm-Message-State: AOJu0YwMGy/W9oB2ixiKYI+YML9M1+7B1YFh2Goc7KqUXfbj2/S3kTIo
 xH7oVnX5NF0yg/I0UXcIS1atkDty5ANugeXBBYhSqBKA3potYABccMn4SfJf8oAc+zM=
X-Gm-Gg: ASbGncus/x4CX/6pPEA2/Z1ZDlzodMtH1mUC96neAno4X3tzjov8KoiGEJis7gVb3k5
 lsgvuNolLdw8cyc6J9wv5I7XiBWaC7nX67d4CHkK7grlqza1giyPb0wb6KfHzgD8VDboNaud9f1
 uZq6JLpY4Fq8+p5dic0DSq4Un8S4aIdYjkiakvIJaQk5QfMrNSv/YkA+7QnlEeSn/x9xhdHdgcq
 iQdP1WTXerkkD5js+1G3aKKTIgDKOQtvseacNI3oCL6DIqOXCXA5HRkolkVy/MMk4HfI51oQ/Jk
 PMPQyrYmxW6X5tWmvOuwz5xpvfoABAFFXYyFDPNlNLmvBlgpo9bBkYsWWy7vkDYyuPzhlg==
X-Google-Smtp-Source: AGHT+IEC+9/ovZzewLd7krJmF+rcjKRf8cYMWRkHEpRAD95/YhpobDwIMSo6MEOceyfRy9sIzGJpfQ==
X-Received: by 2002:a17:907:1b22:b0:ade:6e3:7c4 with SMTP id
 a640c23a62f3a-adfad3349eemr1433357866b.23.1750231945432; 
 Wed, 18 Jun 2025 00:32:25 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec89009b9sm1014353766b.97.2025.06.18.00.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 00:32:25 -0700 (PDT)
Message-ID: <7a12e642-e6b4-4882-bead-cb20515adb63@linaro.org>
Date: Wed, 18 Jun 2025 10:32:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/9] board: sam9x75_curiosity: Add support for sam9x75
 curiosity
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 Lukasz Majewski <lukma@denx.de>, seanga2@gmail.com, sjg@chromium.org,
 Oliver.Gaskell@analog.com, malysagreg@gmail.com,
 nathan.morrison@timesys.com, mkorpershoek@kernel.org,
 robert.marko@sartura.hr, jerome.forissier@linaro.org,
 sebastian.reichel@collabora.com, duje.mihanovic@skole.hr,
 sumit.garg@kernel.org, patrice.chotard@foss.st.com,
 nicolas.ferre@microchip.com, u-boot@lists.denx.de
References: <20250603050556.80851-1-manikandan.m@microchip.com>
 <20250603050556.80851-9-manikandan.m@microchip.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250603050556.80851-9-manikandan.m@microchip.com>
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



On 6/3/25 08:05, Manikandan Muralidharan wrote:
> Add board specific functions for sam9x75 curiosity
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
