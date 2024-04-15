Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1541AC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A5E881A5;
	Mon, 15 Apr 2024 14:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DB8FQJ0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1952788179; Mon, 15 Apr 2024 08:53:06 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A68D88169
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-516f2e0edb7so3379477e87.1
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713163983; x=1713768783; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RECJEbP/Q/4a28c9rYDOEZXH2g5g9zRUBYcBlrwjgD8=;
 b=DB8FQJ0L2ue9RShhrD6caUYbvqJIaqTWh9+Es6qw0IFU/Yjvg6K8RkbIeOxa3X7S0x
 ptvet0oGm7D14juaW9QMQ+dfZNV+exRHprrAXbDU7L1fwXCrp8Y6HdWffDxVsy/jctLe
 7VFY1Myc+0C6Sj0X5YPn/Zu7d3XMDDIr+xCABpeFgXQsfGaeeLr1semh0xtR6vIInaOQ
 4s2m1LdLUhvLZDtOAf5abi1ycSMlHerq8mAOj/gKAaKxVCKbEd+6pwSFXNFyXw9uF571
 LLLZQU/R03ET088MfkLDK+L/QgynVPyWz6rNVh3XOh1mJZMHXmVH2jZ/RnjlsE8p9P5J
 NOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713163983; x=1713768783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RECJEbP/Q/4a28c9rYDOEZXH2g5g9zRUBYcBlrwjgD8=;
 b=S2Kb+trPwgZ7Ud3EID+9bvnGJfaxnk9TfTtDppipbv2756oLjKtEgUCiQGdWwnDmFY
 mQcqQDWST0M8VRXxPrkTN27Ocq1HjMYreoBzSHtK8HQiHs/JTBnPKP84bBhb7ErAUp43
 AgwRJNYfKOdLJYj+mS/DTolhm8vqz8DnAfaXPBcLziHP2WZNmOz87RGv2Ghcbr7YVWRo
 o1wm9um/3tFy3fUPvDuc4SaQFM7OV8T11F1C4sBEzG2Tg/vnZKIuqFeQkiYjK0VeyEpn
 cb2INTdOJdcPG52UDBFlhwNYQGSudS6Dlmj8n9EmXyH28EIG8OMKHXrgS1yRJOJssIc9
 oNxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL1iEsnaHySrsShXwh7wW6/hiFkrck6P3x+qNbrJIw0ARwhvwrWGaOSDNw5au+nA2CPDtPplp49W0OK0qJfL/RC7aLSQ==
X-Gm-Message-State: AOJu0Yz5qObz3GlXeiCsbXYhkvv/HfvIlzXpEnJMXZhYQ4ooQSLcJ11N
 aNOVk3NyNz5gomje1mBKtvGVzrcX2lV75PN3f7AYrY4ZXUuRUxwU9zKlwPp9j1g=
X-Google-Smtp-Source: AGHT+IE3WEYNmxIWq83ufd46HzmxCKlhIKeIbKtu34LZqaqSSxOQkoTxtf5C/sI3PhBMoAF4SkBAGA==
X-Received: by 2002:ac2:518c:0:b0:515:c0ca:d9e6 with SMTP id
 u12-20020ac2518c000000b00515c0cad9e6mr5615255lfi.38.1713163983289; 
 Sun, 14 Apr 2024 23:53:03 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004182cd07133sm7445892wmq.3.2024.04.14.23.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 23:53:02 -0700 (PDT)
Message-ID: <5784f429-1eb1-439e-bccb-b96ab0219625@linaro.org>
Date: Mon, 15 Apr 2024 07:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mtd: spi-nor: Allow flashes to specify MTD writesize
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 d-gole@ti.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1713154967.git.Takahiro.Kuwano@infineon.com>
 <16e3ddf31a406f6aa4dd8e8267ef5d2a329678ea.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <16e3ddf31a406f6aa4dd8e8267ef5d2a329678ea.1713154967.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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

Hi, Takahiro!


On 4/15/24 05:33, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> Some flashes like the Infineon SEMPER NOR flash family use ECC. Under
> this ECC scheme, multi-pass writes to an ECC block is not allowed.
> In other words, once data is programmed to an ECC block, it can't be
> programmed again without erasing it first.
> 
> Upper layers like file systems need to be given this information so they
> do not cause error conditions on the flash by attempting multi-pass
> programming. This can be done by setting 'writesize' in 'struct
> mtd_info'.
> 
> Set the default to 1 but allow flashes to modify it in fixup hooks. If
> more flashes show up with this constraint in the future it might be
> worth it to add it to 'struct flash_info', but for now increasing its
> size is not worth it.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Please specify when a patch follows linux upstream. This follows the
following upstream linux commit:

afd473e85827 ("mtd: spi-nor: core: Allow flashes to specify MTD writesize")

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
