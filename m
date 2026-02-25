Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9E3EFD23D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 11:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B4883AA9;
	Wed, 25 Feb 2026 12:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DKX/BhJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4F283E62; Wed, 25 Feb 2026 12:00:18 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 644F88366F
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:00:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0DE223FB6B
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772017216;
 bh=j+KKGmAFPsCZzqTqRgLv6I1T4fH+0EOjDQcuD0MRsCY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=DKX/BhJGgsmc2M12K0Q5oZioljR2aA9o4afxBpfCgpWnf8pFMkvznp8ppb7j/AIwI
 FKDYfoo+DxIs+Uxmnzu8sJHUfkzbKIiGkm9Novu9muLBHJs2rekNNc6311pVdP2ajV
 xsAxVsBLmod3VDZFd4drG46Cmi59FCZxe2kn4oaT2vJSCZOmFkORHhYT/3nJrTl+uq
 uhvprk06QLEHP64+XZxqT4NWVaI7+i7MJwj/d2rzOWBXxdMUZLUhDSW4RX+DaGZMDq
 R5Kb5w4vIPnV+mDaDRzIx4B4iw/PlCfPQBCHLxUPIoDbSELQsIOYpdb/B4rjAZsBkg
 Jv+/NJ09YcfAot+4f6uiodL+Cr4F62a0cbks8H9fH3nH1OppdFKAD4FUKnBYT1z9X9
 6tPSN/tEEpXUnP7IolN7viomY5ez3Ow5ZcN4sPXQW/Zd1d3yy7xAZ3pJjOs+U/DInB
 fO7Y0R3dqUmdFjV0EHpfVvEjzvwZi8F7XyrEZsIfGEze29w+qnmXTLjc3llxHeXs1E
 e05n/DpHBX2z40h3/QYokku9M4MQS3LKMQP+s2n4RNZHaosQzC/gCne9MiufEEncKp
 33O+IlEkGAAMyc0nzWJg9lzecpOPxN3t3RCES39qqf4DrsMD6at9o0zBqSuU3PwDet
 cOfshJXLQQsYhS6hIzxUnnJU=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4398fed3552so449477f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772017215; x=1772622015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j+KKGmAFPsCZzqTqRgLv6I1T4fH+0EOjDQcuD0MRsCY=;
 b=W0SU6nGtAjyre55xw8HRw129jvmIQpm8Y7d2LklsVqyMEj7IxCP3ggBTNs+yc0P2iV
 DH9h0znYsFQyJp0P0KGDKnJemuVpDF349a4fPN3vKJ5Sis9m3OLMPDSPBjN7UTrnZ/jB
 EE6OV+GDZoC/Q38KViznyIGFVdjW+C32ntxpOyw1Yd8LTnKRJVFv65ogqngPRgdqqm26
 mftc9ksvmnCgKBVHjFhNikn/lNigDSvZFkPiiETdImjvq4RzcBuMfEjW/7xBdZ+KTT4V
 KbwMzgTINa9bbMFnylZ1rxIHDnjQNAeK4cgw2iQ+MYex3Mkf4FBUuDHMpLzMWvDRR+6Y
 mtOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvMuZi9wQaBG6h1jUv+Y3Z3zR8Z1ZO5aGP0H9qCLDfBVjhi/K3a66GfHGt1pMYNP/0eLGU58s=@lists.denx.de
X-Gm-Message-State: AOJu0YwwoD/thaSUpRX0iRLkGNc622q3+sOPY5km4OvrgnPdKLYm0ag/
 3qz/DIlMy2p/Y9TlpTy2SedeWxa6XE925kLnRAJkmyhN4+kbYOoJdIh89UWm4XTULx8p1p9BBbG
 fkKF52C0a0DuZCf8RFipPjqH5UqzzJr8eVapnGPaAJpvEUdcHpikT+7LPoALX4URrdyRwc58=
X-Gm-Gg: ATEYQzy64wpQMNzXyuylKPWqQZg6dD7Z8YRkzJrstu1MAyJHloac5zkcPYhnBZF1OE2
 vxfW1/S2nFYZl2WUDZStRHfDUGgNrjS+TIuweP2ZXuDMLUZAaQEUGaEnjSWNrROZ313z3PxrDad
 /e7bUPh0ucv4WddZZTX5VABuRd5cxTito2avcMw3el/KQsR+HIQpw6msuJA1wqA5a9PJGO+jWNa
 IvGz+0M19uEUQS/U0ohwzbyMJsTrRG0sv76RyxZ4Nm61fwe8/GHmF/TeHWhKz+UfqhwYUXK608+
 WSH+SmIByiCpNaP5Ukzr9gjY9cntd0w5valM7vr5MBgL1edg2k3Hu8zPKoozHcAQ0jkwlRDLn2K
 564rr4ktoE+7Imio39qZH/W4GFxkqwmkTgEeTRMjh8smaOGAKw3BeY1Y2MyBEUjvTwitSQvrHVa
 dApPgfOeFefCIY/WfxUMT2a0DXlBbVF9AzY11js6eSU34m7ClXDLg=
X-Received: by 2002:a5d:584c:0:b0:430:f3ab:56af with SMTP id
 ffacd0b85a97d-4396f182a38mr30121602f8f.48.1772017215423; 
 Wed, 25 Feb 2026 03:00:15 -0800 (PST)
X-Received: by 2002:a5d:584c:0:b0:430:f3ab:56af with SMTP id
 ffacd0b85a97d-4396f182a38mr30121511f8f.48.1772017214644; 
 Wed, 25 Feb 2026 03:00:14 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff6dsm35333545f8f.25.2026.02.25.03.00.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 03:00:14 -0800 (PST)
Message-ID: <6d35ccaf-3276-435f-b953-8023985f31f3@canonical.com>
Date: Wed, 25 Feb 2026 12:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't
 exist
To: Conor Dooley <conor@kernel.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
 <20260225-bagpipe-jellied-de21366481df@spud>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260225-bagpipe-jellied-de21366481df@spud>
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

On 2/25/26 11:40, Conor Dooley wrote:
> On Wed, Feb 25, 2026 at 11:28:31AM +0100, Heinrich Schuchardt wrote:
>> Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_CLINT.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/cpu/mpfs/Kconfig | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
>> index bcf1ede818b..8054313d182 100644
>> --- a/arch/riscv/cpu/mpfs/Kconfig
>> +++ b/arch/riscv/cpu/mpfs/Kconfig
>> @@ -6,8 +6,6 @@ config MICROCHIP_MPFS
>>   	imply CPU
>>   	imply CPU_RISCV
>>   	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
>> -	imply SIFIVE_CLINT if RISCV_MMODE
>> -	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
> 
> Is this correct? Does it not mean that I just didn't update these to
> match the rename done in 9675d920278 ("riscv: Rename SiFive CLINT to
> RISC-V ALINT")? My original patch I think predates that rename, so I
> probably just sent it on without testing these since we don't use SPL
> or U-Boot in M-Mode. If the generic CPU wants them in these scenarios,
> then we do too, so the renamed versions are probably a better fit?
> 
>>   	imply CMD_CPU
>>   	imply SPL_CPU
>>   	imply SPL_OPENSBI
>> -- 
>> 2.51.0
>>

MPFS boards neither use SPL nor do they run main U-Boot in M-mode.
(SPL_)ACLINT seems irrelevant here.

Best regards

Heinrich
