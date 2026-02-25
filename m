Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20715FD3776
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 17:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9548C82A9E;
	Wed, 25 Feb 2026 18:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ay3gi3F3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6862A83AA9; Wed, 25 Feb 2026 18:56:07 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7F18003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 18:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 40E833F7D1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772042165;
 bh=tiEa+4yIMKfan08davoxfhoenEYMZUwxvIj51L/3GMk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ay3gi3F3u1frZRvKFYNUb8WVZNV1MHYbxpmDOo/EhEA0X1bjoSjph+p3d4PPyp3PH
 3A8sO8hoj+nkWLHfxkfxFqhqTQZmIv0XPaClzwariO7PruYhrvk87azog4gnOFTbYQ
 c9y/wwGreuxdYVlz2NomZaeKrowgKovemoJgbZk/YTqDtpJO8gutpiM8c7rrqXtWfi
 X+wgoYqf9FXTjW0GNlI3Pq8s8a9xoWyOyQgQKodpff/Ry+UdNXW1IMSixUlIcxj6rC
 oTJG0Rmo7iTLUb+U+PolqEiowc9ZPigGVjviKz62/XOVL+9hiDBOHo1qQa+US0STGR
 Oic0H8HbTVR7t3nKwsDIX7ywa+u7KG5fQeTwddMbPglBXZR7QQVtCmRLGJ5FPqODMM
 q0BucLKNwgFK6pDkitf6zka8sDjSNuIeE7qQdSu8OVast6fPaR88OXNaemybb5aY3d
 FgNb9S846iR6c6iLI5gk9q4Ejjlav4xPUlOXsPmZxlp2XB/+H0bjqw3dCrS1yWoOX0
 +ui/CH+QLWUgCMQqgN6UymTtWN8ptnJouvA6RIgbtXbVQ1vNGQsd0Tuwx4r5B5lCmr
 FcVdK/vMjjkKuTWNBLB8h4AHMBhFrPSN3qtg0+Zw8/SJG2fE8FdR8d0zNlTpkWgGb5
 7C/ERlUSMavUvQyLkKzUg9QI=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48069a43217so381815e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772042165; x=1772646965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tiEa+4yIMKfan08davoxfhoenEYMZUwxvIj51L/3GMk=;
 b=FAOmt3TWTQ9f2ptj0Lae2qi+TBUCB6/HPDhK1wsJ+KztnxcoGx9fVPWp0aZEpzi//L
 3EcrKqEW8jPZgX13bLxeVmzsgVdcyUiP+gGQVn4QPTxwguFS8L34s2PGSrD8iQlf3otE
 sW38lwVuFUYUTYgLTVhHHG6TV/L0q53JKiwKFZ+A6G2ZEuiLuzEkRdyIEJa4CP1mExoL
 6aEzGeyWUmBqzO8izjGq6d+jOgxL95igvIIlXTwmE7SPXr1LHYxdfxoZ0CIANUpunU7b
 eIWEBNLv2PMHPehjWOprtphquc9K+2byGes78mzQsXCeoJ4De1iRp/qKOSR+Tzj/k3LO
 2/6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQygGgQBItw7wkXKc1oBRWyXJJau4h23jaQ7vLjWLz56dLG4GyA23w2b7iCxTmjPULwFOJvgw=@lists.denx.de
X-Gm-Message-State: AOJu0YyM6ASgZxESFM5Me/vQMvuRF7UzE82xmYcTHxzVBzlzaSF7hcNT
 Tx5lIrgVinqmN1VpEj6nCTu++sBFzPS1+3sb8o3r2Dg925mgSx0V9qRsEUvsrq7UFzGNzI9LDwk
 cYeLY+InhWFFBQok7BaZ8oKFzWloDXQ7amNnLBUGKXn9WPu7Liybrzwq5bxFEMXHvrYKR4c0=
X-Gm-Gg: ATEYQzyBb/bMmEYGqGBSEQd+JHldsHVIUC2iLvMZ2H2GqbGCAvYOlpZmCZ8Yklagm7z
 KFl/9EuEFgBm8MGSmNZefO7UzUvBIB92wDzf16y3pzBV27lcAUts2GPzCWyUh39DWJkkQ6arNbj
 RGHlfwHfDOxxKVirK30LXkYB/wqXEgwBvXXNUo04SJbBFLkkZU4MUaAEPCiRmHJ//ARB+BS2U+K
 gz2xfWzGP3S7mHnMTCbPeXsa0J0e1++bv+693gsW2Ee9xQ6euOU/0Q0AQ9KynsdSF5VnQqMr39Z
 hq6UarCqEu+cW4o7kYXdW2OtSDsmMLilojSXmT236Fuilc65u0hgzJEYkbVL3tlGss5IAukOwxV
 yi35VpOWlfD7HKGyp7OOy7wJ1HbixdoX7A8z6wDjD5vQcKOP3XwQlbw9tpPJyCj6hRPuqB7/6cZ
 iBFhFkNAIWObBAeJo1KzIcRc/buS1v+zE+CF298slZ1u/ZPxeuGe4=
X-Received: by 2002:a05:600c:3155:b0:480:1c53:2085 with SMTP id
 5b1f17b1804b1-483c2197fc3mr24356585e9.19.1772042164762; 
 Wed, 25 Feb 2026 09:56:04 -0800 (PST)
X-Received: by 2002:a05:600c:3155:b0:480:1c53:2085 with SMTP id
 5b1f17b1804b1-483c2197fc3mr24355995e9.19.1772042164203; 
 Wed, 25 Feb 2026 09:56:04 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd72bd66sm79612675e9.11.2026.02.25.09.56.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 09:56:03 -0800 (PST)
Message-ID: <dc71a2ba-fe57-47dd-b010-409856c11f4a@canonical.com>
Date: Wed, 25 Feb 2026 18:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: don't imply non-existent CONFIG_IP_DYN.
To: Conor Dooley <conor@kernel.org>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 E Shattow <e@freeshell.de>, Bin Meng <bmeng.cn@gmail.com>,
 Lukas Auer <lukas.auer@aisec.fraunhofer.de>, u-boot@lists.denx.de
References: <20260225095414.45365-1-heinrich.schuchardt@canonical.com>
 <20260225-hurling-onto-c4dfac50d31e@spud>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225-hurling-onto-c4dfac50d31e@spud>
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

On 2/25/26 11:42, Conor Dooley wrote:
> On Wed, Feb 25, 2026 at 10:54:14AM +0100, Heinrich Schuchardt wrote:
>> The symbol CONFIG_IP_DYN does not exist, but multiple contributors
>> copied an imply statement.
>>
>> Remove the imply IP_DYN statements.
>>
>> Fixes: 3fda0262c33f ("riscv: Add SiFive FU540 board support")
> 
> Should this not also be
> Fixes: 64413e1b7ca ("riscv: Add Microchip MPFS Icicle Kit support")
> Fixes: 70415e1e528 ("board: sifive: add HiFive Unmatched board support")
> Fixes: 6f902b85b6e ("board: starfive: Add Kconfig for StarFive VisionFive v2 Board")
> ?
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   board/microchip/mpfs_generic/Kconfig | 1 -
>>   board/sifive/unleashed/Kconfig       | 1 -
>>   board/sifive/unmatched/Kconfig       | 1 -
>>   board/starfive/visionfive2/Kconfig   | 1 -


Thank your for reviewing and for the additional Fixes tags. Patchwork 
and b4 pick these up. So no need for v2 I guess.

Best regards

Heinrich
