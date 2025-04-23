Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A30C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566C580F03;
	Wed, 23 Apr 2025 14:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q57CKxyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2178F80F6B; Wed, 23 Apr 2025 14:54:03 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16EBE80BA8
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B1235402D4
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 12:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745412840;
 bh=Zwp++48eXV75k7Ejwqv8ahXEc64+dpe3fEp+bPSxD40=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Q57CKxyX8afDX2o8B84qMZqoofrU1SW9K7+BJcQ0UT/JLVwIsvrVVHMl2PkRNUodE
 QBJ+9fPThJ8NXREe4WT7p0uzEYpJotxfvcbV4Ple/licUOP5on2RIbokieBYwfvUmN
 ajNtXIAGbTm7+KDd/AmuZcHbV1u91BHJQ8MKW+TwIAuqzwnyjlTBoZWZM07vhlnDHJ
 RdBkttPvinQWbGJdCtZGw6rotpnkF+kONkUb2w0PLMWYLBD3B5jTK/Y51ImLnGQscK
 gjz7402IYQDzDjJuCMKUdNYKgLf1+Lzjq5IAbi0jDUT0eRvw12SWPY8EfkyId6c0PX
 HWK4q+SBvJBiQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39ef89b862dso2942581f8f.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745412840; x=1746017640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zwp++48eXV75k7Ejwqv8ahXEc64+dpe3fEp+bPSxD40=;
 b=MGQLlmYzTU5Udk8zJJpQZSim7brzG2vJwckziEO3H5akouAqAd8Wk2TCkMVXdLdAnw
 /1koJOar9zJRXbWgqymaYFoc/Yj9L0+rtDMACA5WHMqBTUtKVL9cQH7YETne8OYHGHGz
 3P4tjIZkgR3CZoRKWrPyQI8i25JAhLmVhkLOH3nkK4bXD3/E+DT6v6ZJQxK8IV3MNWJZ
 Mf+hcr5On0q4woeF+Wmaz7OzImxog5ne/D18D8mCmyM8FEqpdUzhvursEDFgMa/zVaqs
 hfZkjX+R5g7NMSBoJk5HKDZY0IL1tVL2z8PBtUP0XXLgkBO6I5e46w0FCAxp8BMA8R2Q
 G+8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfi43KF24vEUs+K3tx4wMCCcPVt5kkNH0J86bSXlidojguakV6mJlREk9ebd4uOtFci4q/Xdk=@lists.denx.de
X-Gm-Message-State: AOJu0YzkhshNk37RyLjy0gpH3fO2LhGO1YRr0sNmkh0dfTgmWrJmVQo6
 6hHseFAuGqYvB/hhibrdbsr2S69j2G75CCeQArgsEoOWfEwAJy4FM36htFv7oNTfWHM5irTM+uB
 Cce3KEna2k/Z5NvBTfR8mAYwTvA6f85n9XLiS6yQOAvSjlIZb9WgGcNKX5BvBxkaR4OU=
X-Gm-Gg: ASbGncsiQl6fn51E9T3g5qnY2kGsLkgym+PZRbvpkn20TJExdgRLFTYzSkqqHWREsvs
 DXUJYFrHCEpiTUe/tlSZvHNIPMYq580qjjZNEjLCSCTV+rkmaWKJ0qSCj4pxtMkpFGlCHTQ5YEt
 PjLw4bIDzFuYabm6B9ymThUaEUFrlGQue4NcmQH5eHe103VAVB9g/1RqbG0wUKFUvlo1TdSapif
 mjtlVx38hyWbGS3jimw7QLLzjFKUItLTAu5PCr/iVqmAOjdROkDCCnKn5UR7+WEzkiQcf9nK7xR
 dz7sM60Z1s8wckOTFW5URTJqTqC+mcF+F8oXk4mON16ky/3JTYGJYHkOUKo+TSbfJkyb6erICd+
 juGImyV35
X-Received: by 2002:a5d:5f91:0:b0:39c:11c0:eba1 with SMTP id
 ffacd0b85a97d-39efba2629fmr14578348f8f.12.1745412840230; 
 Wed, 23 Apr 2025 05:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx+a+IV/KU39/KirD4anzhsBQkap+zzpYB0pTxAdBlUi/nw2F0zNFQAf/0PTvhfn0YNAjZDg==
X-Received: by 2002:a5d:5f91:0:b0:39c:11c0:eba1 with SMTP id
 ffacd0b85a97d-39efba2629fmr14578326f8f.12.1745412839927; 
 Wed, 23 Apr 2025 05:53:59 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4f21sm18989263f8f.91.2025.04.23.05.53.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 05:53:59 -0700 (PDT)
Message-ID: <2c28be83-aab4-455a-9ced-602b7c6b1354@canonical.com>
Date: Wed, 23 Apr 2025 14:53:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/8] boot: BOOTMETH_DISTRO should select BOOTMETH_EFI_BOOTMGR
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-3-heinrich.schuchardt@canonical.com>
 <CAFLszTgn3kXFrbsfbQCpJ0pHmgAvF2Df_V7_tTZ732k3Q4UVew@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTgn3kXFrbsfbQCpJ0pHmgAvF2Df_V7_tTZ732k3Q4UVew@mail.gmail.com>
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

On 23.04.25 14:28, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Distros expect the EFI boot manager to run. It falls back to launching
>> EFI\BOOT\BOOT<ARCH>.EFI from the ESP.
>>
>> BOOTMETH_EFILOADER is obsolete.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   boot/Kconfig | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index fb37d912bc9..71ddb37f6bb 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -597,6 +597,9 @@ config BOOTMETH_EFILOADER
>>          imply CMD_TFTPBOOT if CMD_NET
>>          default y
>>          help
>> +         This bootmeth is obsolete. BOOTMETH_EFI_BOOTMGR takes care of
>> +         launching EFI\BOOT\BOOT<ARCH>.EFI if not boot option matches.
>> +
> 
> I don't agree with marking this as obsolete and your commit message
> doesn't explain why it should be.

This method was written in a way that per se violates the UEFI 
specification as it does not set up required UEFI variables.

You must never run this before the boot manager as booting 
EFI/BOOT/BOOT<ARCH>.EFI if there is a boot option violates the UEFI 
specification-

The boot manager covers the functionality of this bootmeth.

We should delete this method.

Best regards

Heinrich

> 
>>            Enables support for EFI boot using bootdevs. This makes the
>>            bootdevs look for a 'boot<arch>.efi' on each filesystem
>>            they scan. The resulting file is booted after enabling U-Boot's
>> @@ -648,7 +651,7 @@ config BOOTMETH_DISTRO
>>          select BOOTMETH_SCRIPT if CMDLINE # E.g. Armbian uses scripts
>>          select BOOTMETH_EXTLINUX  # E.g. Debian uses these
>>          select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
>> -       select BOOTMETH_EFILOADER if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>> +       select BOOTMETH_EFI_BOOTMGR if EFI_BINARY_EXEC # E.g. Ubuntu uses this
>>
>>   config SPL_BOOTMETH_VBE
>>          bool "Bootdev support for Verified Boot for Embedded (SPL)"
>> --
>> 2.48.1
>>
> 
> Regards,
> Simon

