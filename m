Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D61CD3442
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 19:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289D283AAD;
	Wed, 12 Nov 2025 20:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U4+kCf3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF9483CCF; Wed, 12 Nov 2025 16:29:44 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA91B83CB9
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 16:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7b18c6cc278so1246486b3a.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762961380; x=1763566180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xznR/ewHnySd8ZDOqf9lPBfaq50AU8WZfeuQhzt+Keo=;
 b=U4+kCf3g2hqbYfP5Z2ijeZ6dH5BfzfnMRmNfGoYs2+Go2Z244Fc/2lBdYw5soKz3qi
 LbWKJYTIO7iXj5OYYiZ4Uajc0yDYJvDgt7+s0ALQgRjMatLiGwtB1i5bcFjL9MFUND3c
 r3s1WOsexMiedsUXR7m89aXnLaER3Pp8KRWwFxZZ89+Vr0EVccHGgXQhduGAcsiqDrw3
 gfoH0MeeUDzqcb9WGfrlNdGY/FCX3pq/VxqxUVQ/wpeXR8BksmWB+3lo3xvCwL8HTLjq
 DW4872JhEdB49uB9J6Zd5YoDWG1lZ99MsPnmdJBkmMymRnz94qNpwmlaOvpIDjIzWH4J
 ++jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762961380; x=1763566180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xznR/ewHnySd8ZDOqf9lPBfaq50AU8WZfeuQhzt+Keo=;
 b=FI8oPMQp3HmWUdEVhev+aGW+SGfZJTrsFoLM0az8i++BT/2DuYg+pABOSYkwL1Ds3i
 mbNtx9SeIe1b5IwKEgaGIgz+xKPckV2KzEL1mvyb4MuqBKPPOJDjf2bs/0A2/pb1Q67l
 g5do8vCYJBNFq+adXSCUPJ0rngn+muGpHL+QrceB0bxGrYfRIZu+Ut+1vwoobS/03tRo
 VCnObdIJXTQYrgz4+skJE/WR/VDS/C6S1I5XYHmJfd0eTY6oIl5ngW32/A/p4uFsWEtS
 m5Km9ufIYmDHK6JEohxcIOe1EXKUTedms36C0UEzJ3lQ6WMS9IBH2XhHgCaN8b3pR2sx
 d/bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9BYR5MFjuzwf1V4sIhoxOiR1/NZpzXOA1GTLRrbHeUFFoe8kvXBDTwZSSBB5wTJOfH88e9rM=@lists.denx.de
X-Gm-Message-State: AOJu0YxYQTEVbGK6esZhXRZu56oXnqM7E93CsDtONMXQLohQ3LWSUfn5
 ESjlmJlxq/oP3S3k+Ime68Vp2yNAgixpE/jCeS3Obk1X4tB0hfrJuKph
X-Gm-Gg: ASbGnctKot90JN/Lt7WNVNPk2AZZULuGWcfr6mgWtXP56wGcLsV0hET6AqJT3p1NSnE
 iMIDCT8zPLWhOs88At9wy/lUj9CAlz2yEa1I+5QX/IyTp/Owi/jMpU+kRIgA1eIW1ksPh15flEe
 yEG+K3kGV+3cEdG4V34jfOTOUWbDTtzWIwcC1xdXoF9sfOZb1xwvHH80+7NsNZD7SoTmmjxPFhw
 wJcTAIBPaPq5Fj3gO2vvkWz96ONIZ0lGXB1vQA/+sl/qyU28Xb0zd12EeTgP5LAnc9bJQZ34xF7
 oZ8nMRmacihY51UYEqXeSLMFTA2HAG+39LMa59JTuKyAYeZKY/F7UEvEcjLOM83YDUhwPbDUX2M
 ipvaQm+DysofwZvheqBhQqSVfHOr1DWmLgIY3flRqt0h16xS4GP7IIoSdiWxa84/UP1t3j8r9Pq
 t+7dbA+xOzyP8shviSe5eq7X407lY60x7ezUOFZzwW7HJ+qephxTo1G9H25BEqgp4=
X-Google-Smtp-Source: AGHT+IGogYHxmDIt0gaL/jpuuuhyavGOuBYX9jBvDp7qpFCfhWpv/Fm5wwLFI1IJFzeFMs0A+HW90A==
X-Received: by 2002:a05:6a00:4b07:b0:7ab:653a:ca0e with SMTP id
 d2e1a72fcca58-7b7a4edd6b0mr3450482b3a.23.1762961380196; 
 Wed, 12 Nov 2025 07:29:40 -0800 (PST)
Received: from [10.137.36.250] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b0cc17b0c4sm19192991b3a.48.2025.11.12.07.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Nov 2025 07:29:39 -0800 (PST)
Message-ID: <c885b7b7-6c04-4cf6-9be9-671c350b8f67@gmail.com>
Date: Wed, 12 Nov 2025 23:29:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] [U-Boot, v6, 1/1]net: phy: Add the Airoha EN8811H PHY
 driver
To: Marek Vasut <marek.vasut@mailbox.org>, trini@konsulko.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 ansuelsmth@gmail.com, weijie.gao@mediatek.com, SkyLake.Huang@mediatek.com,
 romain.gantois@bootlin.com, s-vadapalli@ti.com, u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 ericwouds@gmail.com
References: <20251111000506.18366-1-lucienzx159@gmail.com>
 <d4dd9ecc-1ade-4a2d-85ee-979dbb31f57f@mailbox.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <d4dd9ecc-1ade-4a2d-85ee-979dbb31f57f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Nov 2025 20:05:47 +0100
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

Hi Marek

Marek Vasut 於 2025/11/11 上午 09:03 寫道:
> On 11/11/25 1:05 AM, Lucien.Jheng wrote:
>> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
>> 100/1000/2500 Mbps with auto negotiation only.
>>
>> The driver uses two firmware files, for which updated versions are 
>> added to
>> linux-firmware already.
>>
>> Locating the AIROHA FW within the filesystem at the designated partition
>> and path will trigger its automatic loading and writing to the PHY 
>> via MDIO.
>> If need board specific loading override,
>> please override the en8811h_read_fw function on board or architecture 
>> level.
>>
>> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
>> I have modified the relevant process to align with the U-Boot boot 
>> sequence.
>> and have validated this on Banana Pi BPI-R3 Mini.
>>
>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> Thank you !
Thank you for the detailed review !!!!
