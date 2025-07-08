Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E88C83F0A
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 12:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B544A8304D;
	Tue,  8 Jul 2025 14:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mLB9kfr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC4A88305C; Tue,  8 Jul 2025 14:20:53 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9EE583018
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 14:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A1BF3F2CB
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751977250;
 bh=znP5whX+OHmpiGIw9vIddJZCZEL/IVycScpiyJPa2lQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=mLB9kfr0ny+F6lFi5XmJinjrb/vG2QvrfooQgwdZ/aqfb+n0YWP1r98x+cZcumgIg
 CZMnOShmgeluZoKvtnkgM6R6ynqPvpZ7E4+drdZvMciSK6iGYj2tQ8VVsmsnIC4SDd
 m9pKqP2fiDRX7qCvRiIxSIE0YV9ongasK2S8TLueQ0UYsH57MNgwD8OGTjFqxzjoPm
 dZNfUSSCiAMeKz9TS9/01LovVUL4GdEIr97Hc6TN6j/Jhzeke/lMGwMs6tewuizpT+
 Qn713X1bDB98bRCBzFbmy0YIr1iGnAwnni8fs5GIX8LvvnsRv9zT/fdXLh3UsIfuek
 fJyxkglFm561w==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3af3c860ed7so1936319f8f.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 05:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751977250; x=1752582050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znP5whX+OHmpiGIw9vIddJZCZEL/IVycScpiyJPa2lQ=;
 b=APxaEh40ttl8S1VuBSDWLDOMdBh4q15PtARfJKLH6KcEHjOgf5gd/6SrjARqDVAh1g
 hALXTKft+q1SkRwAEsg0ZNjXoIavc7R4a7OKn/eshHj+qLQDp1tXZ/dJgM6K++e97QAn
 5X/rKwZBWB2ktlFSq169/7FHixH/EHxb1QtDEX1je2Uh6tuxluGBmL4IKvuNwxre105f
 WdFiMqyuLG/bEtReUUhfkgoZPWQzRmXrzksVZxqdhuwIW7xZx+vLvkgwWhEwdfyWerkc
 uRQ4wlVrUTlWeBIgN7cZwK5JBq78UExMPFH3z/fYIRdJxs8BIMCmDo2Fpx4Tx8KNGpPO
 +mFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ZFxgcFi2GJIWRexuQTIxGhx70uWqP0gI3Vz8IwZeF8BMUYv7a8/eoq3r1xxYdfnV2d4PLto=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8EU+pkq1Gpj1tDPFbTseugFmmyra+yvdMVeM7p/YHRILN8UN7
 RIe0Q5bfnILHDIJBD0gI6w5sX+PeVzhPBiXC2RHGVKSQybDHq1enMiZT2DseRkY6BwS29lpyY6T
 /xWZ1DJ7gtHY9XvfxGOKm0MqZzSKxu1rrCNcl6Xbb4wLZvqoZVyyn53ZoEvrbxFBRW3yXXa0=
X-Gm-Gg: ASbGnctWOoQaGZCG0q42aYQnYiIh4Gi4fzzmZHCjJzRxYayAhNTi7zRweI8zYOvSgCl
 apG41fzCEJ8y6B1dM6yQIz1lvy1L3QGBUKs+JaKuoROGO25w+Nmowh7Vmkkbzhr37o3SmwYKvtM
 AaRihMrx8+u1aFDG8Qvc/gr0cF8TjDd8v1ekSs+WU+SsgLNP7o/L9Xj0b9rRzSHen1vLrNax+cs
 ZqkXZy3YA35a0k4NRAw/dLLx6gsO+R3ahTSsXsATnnk76bgec4gQlqGbOFwYXcvJtiJ0j30CXEN
 cKb3IE195BRm7YqjIdkq5EabgBOsSCVqmu0/X6BGCi37kXB1jY/OmLoEMgzIOZk9eUuWNgJwxuz
 GmYgAmV2xLI9Y3lvNdr4=
X-Received: by 2002:a05:6000:2910:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3b497038e99mr11653550f8f.31.1751977249687; 
 Tue, 08 Jul 2025 05:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgNW79A8BrP21EWSs7lKUKdILa06LH5bVAwBaOGGKTGtsUuKzF/1aJyfa0YVS71SOtjmayRQ==
X-Received: by 2002:a05:6000:2910:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3b497038e99mr11653535f8f.31.1751977249314; 
 Tue, 08 Jul 2025 05:20:49 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d2656sm20804455e9.21.2025.07.08.05.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 05:20:48 -0700 (PDT)
Message-ID: <c2b30b63-8920-4c74-a154-09d676de12e0@canonical.com>
Date: Tue, 8 Jul 2025 14:20:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: add missing check in FMP.GetImageInfo()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
References: <20250708114851.78109-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjKCtmN8Pn4VRNKRgH0OXymtp8=vc0J_q=MxTDLvTXgSxw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjKCtmN8Pn4VRNKRgH0OXymtp8=vc0J_q=MxTDLvTXgSxw@mail.gmail.com>
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

On 08.07.25 13:56, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Tue, 8 Jul 2025 at 14:48, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The UEFI 2.11 specification, chapter 23.1.3 requires
>> EFI_FIRMWARE_MANAGEMENT_PROTOCOL.GetImageInfo() to return
>> EFI_INVALID_PARAMETER if *ImageInfoSize is not too small
>> and ImageInfo is NULL.
>>
>> Fixes: f27c20148511 ("efi_loader: add firmware management protocol for FIT image")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> That being said, we need to double check the FIT capsule users. I
> think we can probably remove it in the future.

It is not clear if you mean the check or the FIT version of the protocol.

efi_firmware_get_image_info() is a protocol implementation that may be 
called from anywhere outside of U-Boot. We should not remove checks 
required by the UEFI specification even if our internal usage of the 
protocol would not require them.

> Are you aware of use cases that FIT supports, which we don't support
> from the RAW variant?

Maybe Takahiro remembers, why both RAW and FIT were implemented.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>>   lib/efi_loader/efi_firmware.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
>> index 75501e21557..216df83de67 100644
>> --- a/lib/efi_loader/efi_firmware.c
>> +++ b/lib/efi_loader/efi_firmware.c
>> @@ -332,6 +332,8 @@ static efi_status_t efi_fill_image_desc_array(
>>
>>                  return EFI_BUFFER_TOO_SMALL;
>>          }
>> +       if (!image_info)
>> +               return EFI_INVALID_PARAMETER;
>>          *image_info_size = total_size;
>>
>>          ret = efi_gen_capsule_guids();
>> --
>> 2.48.1
>>

