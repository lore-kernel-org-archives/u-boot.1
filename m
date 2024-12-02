Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21F1D10DB5
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 08:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041B289447;
	Mon,  2 Dec 2024 09:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ft78nHcH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 812A989447; Mon,  2 Dec 2024 09:03:39 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B2288A1B
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 09:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a7ee3d60so27924265e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 00:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733126616; x=1733731416;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l3XGtClOtZf0YDGhKKJCUjM4Alt1LVseXH5SWqWUeWM=;
 b=Ft78nHcH2UcBFdeThyZ4vK05lcYCtl92gxhCWcA4iY/0AG3Al6ODhOsA46ZoSUWsg7
 qXS7xWlNk5J1pG4IlMLmnJaD0COlN2sk3PdfEncRi10PlS9rebokYamfL5xcmVQGe3ta
 nNzi9vq/yi9JDzCKrD/KFFVGlwFI3+bNR/oxhgPJ4uQI+QkT4xgdK1qUGJm8ghIDUeOx
 ghMGsvnVaIRR99MZJyf2bbojVjcafkp4wngTulPgN0k4M2P1q+NoFNmQ0RY3aberPVFM
 5Bd5hFuah3e7+biTb+2zHBLwugrzF7QMrnHF1Ew0WDk4j1QNu5tAvUMC+lPEoMknUNut
 NsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733126616; x=1733731416;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l3XGtClOtZf0YDGhKKJCUjM4Alt1LVseXH5SWqWUeWM=;
 b=uKziNBOKRhQ2BSOXfw3tkPo5c769oV8QUXMACMhqFBBoo7KeEGv/rgCHKFGUh5Y4nc
 JXOOeDx57sjVa5TyagXftib1jbjz/Z4QjDhH70L6zEgCzxpbJAnMPWDjwhughCzn40fs
 PawqC86n3BpDMLxB+/zj2L/gh1AvMZpXZy+pIJ3Uo/Y1TgiPeOwEWPF7GNC39n9y6zOW
 qwHk+WtfDVcPA9YnS8yjKERIwoWTxMD41XZGzk0O0wuBMaeOIL13RPQ/oN9ECGhJv+00
 EOqEanUgnF3kY7hkjdOpFT9IpczgWnLzHJ4E+IwiUcinR/T7vdHjO5T2jHqno1UKKaN+
 dvrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZH4YgHd5C0Y0Rr23oLSmTUN2TGHmUpoAHdRcm6AU7DBrf8m4SoaYGygZEIipoA1h+YvRZn3k=@lists.denx.de
X-Gm-Message-State: AOJu0YwXeDRigRhY3V+ADJkrPLOMTM+EioZEuHdjkOTdoMjfbqd0ddZ4
 hRGH/15JYQ1b1MiN4XYC+C4oOtMjLBJsz1C2OWKIYh5TcR2RL6NVxNiw5CDNBkY=
X-Gm-Gg: ASbGnctRiZ/YBfYehpwoaE32goSRXT6DamkZ7DnP4I4ARNxTEEA4VBUjDP+sQJp6knV
 CfGoSCibS8vLApCKuh3cdSBoNlv7cAQwA8lUi51DzWjbv82xTvIm5Kf4ldDDANlCBPr2Ocrvo91
 UX7EI75Xnzh6kwH5PYdkWBjI1FehqwluSr/qJ1SUYatrfwAedYdwpnIaFSNfge2ARGGkomqmBzs
 5Gf8RC+GteNN+zG/NTlc8wHBs7syFCmtdQp8w3C5q/gTDR1pZvL9foO2XMM0kXjMEJDjCIKdNjk
 2L9Cd02kKsupCJD3G1EISQ==
X-Google-Smtp-Source: AGHT+IFR0Hs2rbA1fVueAUXAm7yUMHHuQ4zebXcbpcK9IqLcg+P+W+sOKPZI0eskT3/hIYFAQEVNpg==
X-Received: by 2002:a05:600c:4fcc:b0:42c:b67b:816b with SMTP id
 5b1f17b1804b1-434afb8dea4mr146952975e9.1.1733126616547; 
 Mon, 02 Dec 2024 00:03:36 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:6c02:5262:b0c4:10bf?
 ([2001:861:d40:ed60:6c02:5262:b0c4:10bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa78120dsm173478445e9.24.2024.12.02.00.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 00:03:36 -0800 (PST)
Message-ID: <991937a4-9bcb-43f8-99d9-013d0c9d2dff@baylibre.com>
Date: Mon, 2 Dec 2024 09:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] boot: android: Add bootconfig support
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
 <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
 <CAFLszTgFBtQBiC_Hd9gjUJa26aFFXLGuuvJ5gVDLEaKH-SV-dg@mail.gmail.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <CAFLszTgFBtQBiC_Hd9gjUJa26aFFXLGuuvJ5gVDLEaKH-SV-dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

Le 30/11/2024 à 21:24, Simon Glass a écrit :
> Hi Guillaume,
>
> On Thu, 28 Nov 2024 at 03:15, Guillaume La Roque <glaroque@baylibre.com> wrote:
>> For android vendor boot image version 4 bootconfig is mandatory.[1]
>>
>> In the android_image_get_ramdisk function, after copying both vendor and
>> boot ramdisks, we extract all androidboot.* entries from the kernel
>> command line. These entries are added to the bootconfig section.
>> We then update the sizes of the ramdisk and bootconfig.
>> Finally, all androidboot.* entries are removed from the kernel command
>> line.
>>
>> [1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#vendor-boot-partition-v4
>> Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   boot/image-android.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
> I am not seeing any tests for this code. Can you please update the
> test to cover this?
i don't know if it's possible with test framework in uboot, to validate 
bootconfig raw partition is reading by android kernel. i don't really 
know how i can do this , if you can say me if it's something possible or 
not .

for kernel command line part is it possible to read it in test to check 
if we find some androidboot.* entry ?


Thanks.
Guillaume

>
> Regards,
> Simon


