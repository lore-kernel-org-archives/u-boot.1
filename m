Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AECFCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD45838E7;
	Tue,  4 Nov 2025 12:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTvC4vm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A9D1838EC; Tue,  4 Nov 2025 12:03:27 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BABE8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso6720760b3a.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 03:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762254203; x=1762859003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U5N86ctPoONd8mPls5A1KmbNUS/7KOmCsDHvGN5kWG8=;
 b=GTvC4vm3bPQTO5KmVMqn6XdIXSvBYijFB1o8Yad63tIw9EglzdAxRc8VXquYQzZ6JM
 2Qc+/TUSHWDViJDAO86Yp7zFnrfVgnzBTNvw+NPGQ1Q2uA+CODdPayh+cf9IYenvGm3W
 SnM4d8O5DTtDENYN9oooZvbuDWNPw8lO9M2WKgaP7I+AqwqBiuKNI0eLBBEMB6wQbke4
 xtJdf7i4Q4mEyKXX2tph+YQbjIHBCK1opmrZFQYHrFvmBS34L0qyE9KfIQ2MyWIisXBq
 5F/SkHz+IUGrLxkA3ZYud69IJR+UJcHHw0+0bSROwnwpIIbvBHobeL8YnP40DuT9lDdK
 BnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762254203; x=1762859003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U5N86ctPoONd8mPls5A1KmbNUS/7KOmCsDHvGN5kWG8=;
 b=V+ZJMl1K4VylKqJBDARdBYROloNh/DZirMLz2HsdfErWt3EyUFVGkk/TPC46H0i9aX
 kSoDcQCKYAvMVfdR+x4D/zMUhocNKjdAMEbziaTO8e557ZBm7Py+lOxfKbD12IGpcbCp
 io42HT/89yLvPNCzDBMYNt+LJ0YxJvbeohdvMkg831jonDEfl7dp/jnmVqaIHIRMmiqp
 TYY2XqojBsy1GdyF7DOh/vrMOm6d+bo75YC+f73+ye5ALngJGiZaXeCXUpnk6uD9sxC0
 CsYDQ/2LMaDnatWHiZygGMsp8qwzNiURN3u4P24vukAmDiJSCdZHiDzJBA3zSXLkNfX0
 /03Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNQo0U+6t/UaYtGyTWsKVO+KjJUI5sjdUPU1aSnWL7YwAuHpwklL/5PbCCIdqVYyLmsuBCajE=@lists.denx.de
X-Gm-Message-State: AOJu0YyKW6ABmTYJmgTMqFsL2weZJIwlAZBCT65yUC1aj+pk2IgeIWP/
 2L+bo2CXqm/FBleCXeOmb5vdHs2YFEaxy+sThn5eRuwajf/15oLt3E3w
X-Gm-Gg: ASbGncvKQirmzuwZfyEPJGxsS8sUESLS8k1Nq07NeIX5eknRgTG/A+ALfqrmsoTCFMI
 4QSBOdNGPi2pCF+0qZtL7uBnfG4wNy0dz+tL6D7aqABmAiF0Vy9g9EkYTVfe+s0hW45tio97MM4
 ++pSjAjzXFhGRTDFGDq3Jx8MuHDMSa7V7ELZUbpIejAIVRPPPxL5k+MYAiPJdVB6zqwCVYpPJ3v
 3gRz4fUPEtvnTMCIL9cI0znrsAaODEixVeGqkvzt8EWk74oGFkgsMg/of+5KWhJUTOkt9IZyQOC
 EBDXTFa7/qLbPrGyILao3HR/HULcv3lAI1K6gWtibkSgtjUf9dEb8r2Eq85h3JKe8o0AEz2ZLDU
 GFzD1O3lw2jWoEmsibUmou1xhpQqdSPYYkGBVkvKXJkTwg5Sv73pyH4dEHL881ms+Bh0liAA6yx
 p8YV6yDxZuvjkKJwQz3v9E64gfqQQOL8CXZq/xxmoLnxSOUQPKo6Z/HILjhlyqY24DSA/A0FWBJ
 5kpOZOqMpvpM8+g
X-Google-Smtp-Source: AGHT+IHU4LaqS/8lO8Xlni56UYy7FIMuVe5MeJT62ULeinWQrU/6tzrzmFt5erDz3XRwNIUZ4eV47Q==
X-Received: by 2002:a05:6a00:2d92:b0:7ac:87af:cf3c with SMTP id
 d2e1a72fcca58-7ac87afd057mr4415082b3a.8.1762254202880; 
 Tue, 04 Nov 2025 03:03:22 -0800 (PST)
Received: from sun-virtual-machine.localdomain
 (ec2-13-158-138-160.ap-northeast-1.compute.amazonaws.com. [13.158.138.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7acd6824811sm2528441b3a.64.2025.11.04.03.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 03:03:22 -0800 (PST)
From: Ssunk <ssunkkan@gmail.com>
To: marek.vasut@mailbox.org
Cc: Takahiro.Kuwano@infineon.com, jagan@amarulasolutions.com,
 pratyush@kernel.org, ssunkkan@gmail.com, trini@konsulko.com,
 tudor.ambarus@linaro.org, u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v2] spi-nor: add support for XM25QH01D
Date: Tue,  4 Nov 2025 19:03:07 +0800
Message-Id: <20251104110307.3993-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fda19051-7b72-4f11-aa8e-b8eb70ff04b7@mailbox.org>
References: <fda19051-7b72-4f11-aa8e-b8eb70ff04b7@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hello Marek,

>I'm sorry, my original suggestion was unclear.
>
>If you want to sort the whole XMC part list, then please do 2-patch 
>series, sort the list in patch 1/2 and then add the chip in 2/2 .

Thanks for the clarification!

Actually, I don’t intend to sort the whole XMC flash list — I only want to
add the new XM25QH01D entry. Would it be acceptable if I just place it in the
appropriate position without reordering the rest of the list?

Best regards,
Ssunk

>On 11/3/25 12:12 PM, Ssunk wrote:
>> Add support for the XMC XM25QH01D SPI NOR flash.
>> 
>> This device has 1Gbit (128MB) capacity, with 64KB sectors and
>> supports 4KB erase, dual and quad read modes, and 4-byte opcodes.
>> Datasheet link: https://www.xmcwh.com/uploads/958/XM25QH01D_Ver1.0.pdf
>> 
>> Changes in v2:
>> - Keep the list sorted of XMC
>> 
>> Signed-off-by: Ssunk <ssunkkan@gmail.com>
>> ---
>>   drivers/mtd/spi/spi-nor-ids.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
>> index 0383175beb5..03596d38e6e 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -595,13 +595,14 @@ const struct flash_info spi_nor_ids[] = {
>>   #endif
>>   #ifdef CONFIG_SPI_FLASH_XMC
>>   	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>> +	{ INFO("XM25QH01D", 0x204021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>   	{ INFO("XM25QH64A", 0x207017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("XM25QH64C", 0x204017, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("XM25QH128A", 0x207018, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> -	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>>   	{ INFO("XM25QH256C", 0x204019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> -	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>   	{ INFO("XM25QH512C", 0x204020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> +	{ INFO("XM25QU128C", 0x204118, 0, 64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>> +	{ INFO("XM25QU256C", 0x204119, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>   	{ INFO("XM25QU512C", 0x204120, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>I'm sorry, my original suggestion was unclear.
>
>If you want to sort the whole XMC part list, then please do 2-patch 
>series, sort the list in patch 1/2 and then add the chip in 2/2 .
