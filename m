Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A3FCF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823F78926B;
	Thu, 19 Sep 2024 17:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="o3BzbiKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C788927A; Thu, 19 Sep 2024 17:36:41 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C66B589117
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D6D713F460
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726760198;
 bh=4JPBZA1x04yNUxkWMa0nx0gwI6ruQlNfAtc16nSBq1s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=o3BzbiKZV0nOnOcyevkYHNO3Cg3NkBJ1NSJWPJUSK2ap26vTC3YfEUazWI1EoLjPf
 o5E3H2MHlLBiPCzSDD0pPz3xHbVQbPPDshvLEfx/JdwroPEor7SH9n+wRKB+VMJ0oJ
 yYrlAjl/C3eN9mACgxKV5eeTxZibYnlPl195OiCXT/HOAh18KRpcnZVe5u/ZC2+rTH
 LhXH4RKWCYnDxXlPU0E116V0FOCBxLV3V4en4Gj+V2V7WaT9MZntTed1KrOjDE2kDm
 BbPMMq+TYzn2SUpr+UrHRVbVnbacq2qwHl3Oc67orPkykp3iQaK9rKewfBOhEr+zKM
 1n413X+89xwNw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb374f0cdso5384355e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726760198; x=1727364998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4JPBZA1x04yNUxkWMa0nx0gwI6ruQlNfAtc16nSBq1s=;
 b=h+p2UggtabTv3/0des2ELN8Z0b2hBdh4Ssduq3DsDRQ5v0YYJyLOFywFxmkUBeZro2
 KDtul2i/HtCdWod7Z94a5SxFvaM+o0h6xayDrhTf6TvT6qCQo9y3kiLDB/aATceZJqER
 Nw9r+hl6W/KiXKp4321tLiKH9gZZWsRIQ7aZqrAM87vXBsHcbfpMe1/A0IEMP+pzz5cD
 HeTfH9PcuxPKZgRln+zZYqSTI7MsGn3iDrWIC2wHfQgMDz22wjYM4+96NzywHYS8KJ98
 KE1eH8hBB0jUwECskak9SmyJEHAhaX6rOLLm//rtBLUh1Aa2rrPTr+s0RZke6xDMdGON
 56jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ZA4LgtPGOqlSfmt+EVrgRKTs7WkI6D9teSz1thb4ckK21So8ZxFeLq6vvr5sFYBGX/0RMLM=@lists.denx.de
X-Gm-Message-State: AOJu0YyCjGj8nUTPV1liBLFSopjbi3GI2z5/0lozvt71XHFhvTUueJPI
 oCoSG4m65SpDdPCD2hu7A4ZV3odOzBXl6yfKRUGqKBqfwUN7SgIOfwlmWjpB83vlUwG8n92IcFd
 4+Zz1Z0qrUUG0l1DJyrEoudAhKTf/1fOpsn6TJiJy1RJA/4wm6NJsCzyOVba639gX32E=
X-Received: by 2002:a05:600c:4f96:b0:42c:b7ae:4c97 with SMTP id
 5b1f17b1804b1-42e7446a877mr20144375e9.11.1726760197906; 
 Thu, 19 Sep 2024 08:36:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrxkxH1d4B6jIjRqI2dW9YXO/FV9BeQCFBv1eYbW6p8kNc5H1h5Z0VcFkZ3cbgwUUbvPRVRw==
X-Received: by 2002:a05:600c:4f96:b0:42c:b7ae:4c97 with SMTP id
 5b1f17b1804b1-42e7446a877mr20144265e9.11.1726760197469; 
 Thu, 19 Sep 2024 08:36:37 -0700 (PDT)
Received: from [192.168.103.101]
 (dynamic-046-114-110-162.46.114.pool.telefonica.de. [46.114.110.162])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e844dsm15104058f8f.40.2024.09.19.08.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 08:36:36 -0700 (PDT)
Message-ID: <c884a948-95d6-4c03-b609-6f8e850a6bd5@canonical.com>
Date: Thu, 19 Sep 2024 17:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
 <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
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

On 19.09.24 17:19, Simon Glass wrote:
> Hi,
> 
> On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>>
>>
>> On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> On 19.09.24 17:00, Simon Glass wrote:
>>>> Hi,
>>>>
>>>> On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> On 19.09.24 16:10, Simon Glass wrote:
>>>>>>> Hi Heinrich,
>>>>>>>
>>>>>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
>>>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>>>
>>>>>>>> For measured be boot we must avoid any volatile values in the device-tree.
>>>>>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
>>>>>>>
>>>>>>> Could you explain a bit why this is, and where this is checked?
>>>>>>>>
>>>>>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>>>>>>
>>>>>> Measured boot relies on creating hashes of artifacts and writing these
>>>>>> to TPM. If the hashes don't match the OS will either warn or refuse to
>>>>>> boot. The device-tree is one of the artifacts that are measured.
>>>>>>
>>>>>> If we have random values in /chosen, measured boot will fail.
>>>>>>
>>>>>> When an EFI RNG protocol is provided by the firmware, GRUB and the
>>>>>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
>>>>>
>>>>> There's a comment on top of that function that explains what happens as well.
>>>>> In short the EFI stub does not even look at the KASLR seed and never
>>>>> randomizes the physical placement of the kernel. It only does that
>>>>> when the EFI_RNG protocol is there.
>>>>
>>>> OK thank you. I suppose I am more just wondering why it got added in
>>>> the first place?
>>>
>>> For booting via the legacy Linux entry point adding kaslr-seed allows to
>>> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
>>
>>
>> Not the kernel physical placement. It randomizes only the virtual placement
> 
> So, are you saying that U-Boot adds this field into the FDT and then removes it?

kaslr-seed can be added via cmd/kaslrseed.c and 
arch/arm/cpu/armv8/sec_firmware.c. Both is before the user decides if he 
wants to boot via EFI or via legacy boot.

Best regards

Heinrich
