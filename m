Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AEEC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16C888719;
	Wed, 14 Aug 2024 14:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ctfq4n9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE12889B8; Wed, 14 Aug 2024 14:21:59 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100698800C
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CBBA73F670
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1723638115;
 bh=JnYmLelbmDjF6or5Ts7TMdbmWpl9Zq48Sw1yTFzACpY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Ctfq4n9ib7jKahlYah6MjWDPBKTqn5yZzRIKYfK2TYYJtx2yFvBgMkcmmWChsRnDW
 letLtIHjVAc9ssLW4oNyHI+bXg8NdjEhg7+zknJCKRGOhcNIbWMFR7dHowMw1CXKK5
 yVASGIt0M9EmnCOAiOjx9OdJtj5B7cJiqNFifXOtoJhFoRu0lYjgoYkrlhyOnzASOK
 I++zgftJue+ta65yieYIuZtQNOSri1g8k+cyJWYUuw/tylZNCiuod4ZSwp5jJMUwoy
 6T76HGZR23y2xJDlQNyG8lD1VYpr1TOJNvdGapoGvxCUMbROWQg33IsL7rMaVYPqWH
 L6OeE4A/FhgdA==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-369bbbdb5a1so482932f8f.1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723638115; x=1724242915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JnYmLelbmDjF6or5Ts7TMdbmWpl9Zq48Sw1yTFzACpY=;
 b=E0egaPIyvO+WdpB7+CuGKoJfxEZa42k2IzmEQ4n8a+RDxw9YyC39BtwXjywYXkPsbb
 cjvkgstW8J02I7XkNWEpvL12bnT9exYuS++uzoQ646ZWH10Dgh21k8HmAnUjlO/mbfMg
 8XN81x6KWB8jO9LeLmQHq0ezZSwxCBYcevOf8rmvRL6Xark+V68aAiX3YgZZ1h2+m52W
 OpNvUYBrA3pdzLQwiW2oin6vjnBYY48qUpu2YN3fyI0DJ7RVLjSm9GZdUvcx3jNiYJ4T
 mAAG68goQbTHWeWKPKPELyj3WE1s2wrfutnRV2Q5KdzpmSgH1e2y2O9LQLJUpgQHrG6Z
 wU0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3MEUoT8tCR6lRX+y2p3xGXW7+q8QDsosJzLgo9zJe6/0VcyeKrlKAxnZP5Zu3FTcV6O+2Db1jMSDqQ8+XQMOrUmAkCg==
X-Gm-Message-State: AOJu0YwKDNxkK7SZQ7f2FpXMMor+M0DlZUanEMuKZyecvV/xnDSconoH
 b3dWKrV/wTx6b0ToiwobelwaHCRfrtVBk8cg+cl5u7Gf/Eaav6/8HWay2vItDoydRWEIRyr7v8Y
 Pu+7V82f7Ib5AzHsmLh0fZXru2uOgd/GUR9WTvDIjef7qYu6Dn9mrrPz0f4c+buGXJK4=
X-Received: by 2002:a5d:64ac:0:b0:36b:aa27:3f79 with SMTP id
 ffacd0b85a97d-3716e3ead20mr6428120f8f.4.1723638114918; 
 Wed, 14 Aug 2024 05:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu/Or+10uJXQYNzsW1KxPPgdcQkzsy2FE6kYxZOwmHrbGZ4Ngm8Hwsk21iDHDe5/O9kIokyg==
X-Received: by 2002:a5d:64ac:0:b0:36b:aa27:3f79 with SMTP id
 ffacd0b85a97d-3716e3ead20mr6428075f8f.4.1723638114419; 
 Wed, 14 Aug 2024 05:21:54 -0700 (PDT)
Received: from [192.168.103.101]
 (ip-178-202-041-098.um47.pools.vodafone-ip.de. [178.202.41.98])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3717e150b4fsm378453f8f.86.2024.08.14.05.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 05:21:54 -0700 (PDT)
Message-ID: <ff6c1356-38f0-4898-b464-d9b381cc7890@canonical.com>
Date: Wed, 14 Aug 2024 14:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools/mkeficapsule: correct printf codes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240814071422.54193-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjJ8iCYb0HyaGWq+yCwfPVk25MUsLjdTEjN+ctxdGnrR+Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJ8iCYb0HyaGWq+yCwfPVk25MUsLjdTEjN+ctxdGnrR+Q@mail.gmail.com>
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

On 14.08.24 13:40, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Wed, 14 Aug 2024 at 10:14, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> uint64_t is defined as unsigned long long on 32bit ARM.
>> Convert uint64_t values to unsigned long long and use %llX for printing.
> 
> Why do we need to convert? uint64_t is a fixed width type

Thank you for reviewing.

Including inttypes.h and using PRIX64 is probably a cleaner solution.

Best regards

Heinrich


> 
> Thanks
> /Ilias
>>
>>      tools/mkeficapsule.c: In function ‘dump_capsule_auth_header’:
>>      tools/mkeficapsule.c:694:66: warning: format ‘%lX’ expects argument of
>>      type ‘long unsigned int’, but argument 2 has type ‘uint64_t’
>>      {aka ‘long long unsigned int’} [-Wformat=]
>>      694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>>          |                                                      ~~~~^
>>          |                                                          |
>>          |                                                          long unsigned int
>>          |                                                      %08llX
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   tools/mkeficapsule.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
>> index f28008a0829..d346c217f09 100644
>> --- a/tools/mkeficapsule.c
>> +++ b/tools/mkeficapsule.c
>> @@ -691,8 +691,8 @@ static uint32_t dump_fmp_payload_header(
>>   static void dump_capsule_auth_header(
>>          struct efi_firmware_image_authentication *capsule_auth_hdr)
>>   {
>> -       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>> -              capsule_auth_hdr->monotonic_count);
>> +       printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08llX\n",
>> +              (unsigned long long)capsule_auth_hdr->monotonic_count);
>>          printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
>>                 capsule_auth_hdr->auth_info.hdr.dwLength);
>>          printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.wREVISION\t: %08X\n",
>> @@ -724,10 +724,10 @@ static void dump_fmp_capsule_image_header(
>>                 image_hdr->update_image_size);
>>          printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
>>                 image_hdr->update_vendor_code_size);
>> -       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
>> -              image_hdr->update_hardware_instance);
>> -       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
>> -              image_hdr->image_capsule_support);
>> +       printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08llX\n",
>> +              (unsigned long long)image_hdr->update_hardware_instance);
>> +       printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08llX\n",
>> +              (unsigned long long)image_hdr->image_capsule_support);
>>
>>          printf("--------\n");
>>          if (image_hdr->image_capsule_support & CAPSULE_SUPPORT_AUTHENTICATION) {
>> --
>> 2.45.2
>>

