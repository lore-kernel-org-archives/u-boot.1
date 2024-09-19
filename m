Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29961CF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63A9891BB;
	Thu, 19 Sep 2024 16:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EGkA//wh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C80F989297; Thu, 19 Sep 2024 16:20:44 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEFE688F44
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6EDBD3F594
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726755641;
 bh=mUJY2SGbYXeNux1uFcnxrVeT5bwCq8KVEHq5BVMWvAs=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=EGkA//whKLiOFNwxUvDso5Cpq3PsbeTF5czHQPVmgJoPSDAOktzwq438KOOmDt56U
 1mcketCSDf1BVNtzJA5dx9xIsT0nc6Uuwk5HOCMLEUohV/8QsFE8Qp51aPi7YuGmXy
 QSbbgGsSoxnlzMpFAvG/yYbVgD/EC5MLB5rcX279BR6l4l2BSvrAfcLjZob/R+Bl55
 ZwuMWR8jILsR5taKcT5KOP92eCDjhnSJ/t3fPKLgZ9yCfqjsy9mLMZiwv4WfWhGNgt
 YhASps0sN0OXsJBKh/hv3kzDpME2et5f3PAk3iv9iAmYTuYzpZHjwCLVfVVJBOZ0UL
 ih3YbTGdZGFHA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42caf073db8so7353645e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755639; x=1727360439;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUJY2SGbYXeNux1uFcnxrVeT5bwCq8KVEHq5BVMWvAs=;
 b=nU+HF5axEWQI0q7Z8bsghL+RHzz3VXvMIr8f9ebsF/bGAPM3re24kHHqES6VZ4tpae
 pxN0KUQLwhreExiTbevukks4rx4oMYAqkp2BtP4ZZ4m/IAY8OUXJUu5Xumx0KJxvWFvP
 oUMjddFuMdpU7jcOfW81exRzHFVEcMmmmNw9YlTqnY9pRnUhrdoKp5zC4lXCEuPPV+Cn
 aMdkKp3gpogx6hWVn2sImzOm4c0WlBVgIrp5k24dSWY+6Zm6ZkQv8mHQQ750dlfWP6GW
 /WLelIaE8TxWudkl1UH+kkr6Tr3Gv21JSbS/MNh/jKbs8LxwyC78iCEZdJ+I077CXI/3
 lb4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmDRkwttk4ybCsvCf04jdzdqh/RxGW+UzHJlgmRSPEO9ZfSsuvDnxge5oW4EVfIK0ba+PFr6U=@lists.denx.de
X-Gm-Message-State: AOJu0YzJYPs+kScPaYULcAXtiha3z542eePBVd9R2UxBPt6ImmALsLh4
 fJSlK5D1jUadk0afHvX7NGL+VO+Yiif819sVliijN93iJBoa3YIMQtMqvOI9NBCNmW+ekm8sB94
 mwmj/1J7uihvds3ImeY22e3lajcSEj+RSRzey7I/apY5BwpH4a+EC+CNb/wrr8wt2mMs=
X-Received: by 2002:a05:600c:3b26:b0:42c:e0da:f13e with SMTP id
 5b1f17b1804b1-42ce0daf92fmr157277785e9.18.1726755639471; 
 Thu, 19 Sep 2024 07:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkCZpBpd7lmzxbkTAvkEkQd4HT8lm6QvjEIgPs4VL172U8m7TLj/RURWOk527sGcUkFDA/rg==
X-Received: by 2002:a05:600c:3b26:b0:42c:e0da:f13e with SMTP id
 5b1f17b1804b1-42ce0daf92fmr157277545e9.18.1726755639005; 
 Thu, 19 Sep 2024 07:20:39 -0700 (PDT)
Received: from [192.168.103.101]
 (dynamic-046-114-110-162.46.114.pool.telefonica.de. [46.114.110.162])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e75440657sm23022655e9.20.2024.09.19.07.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 07:20:37 -0700 (PDT)
Message-ID: <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
Date: Thu, 19 Sep 2024 16:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
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

On 19.09.24 16:10, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> For measured be boot we must avoid any volatile values in the device-tree.
>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> 
> Could you explain a bit why this is, and where this is checked?
>>
>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.

Measured boot relies on creating hashes of artifacts and writing these 
to TPM. If the hashes don't match the OS will either warn or refuse to 
boot. The device-tree is one of the artifacts that are measured.

If we have random values in /chosen, measured boot will fail.

When an EFI RNG protocol is provided by the firmware, GRUB and the 
kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.

Best regards

Heinrich

>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   include/efi_loader.h          |  2 +-
>>   lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
>>   lib/efi_loader/efi_helper.c   |  2 +-
>>   3 files changed, 12 insertions(+), 7 deletions(-)
> 
> [..]
> 
> Regards,
> Simon

