Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B2CC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 10:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBF886C83;
	Sat, 18 Nov 2023 11:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V0AgR4/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF95286D33; Sat, 18 Nov 2023 11:59:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3BD864C3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 11:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5D6CE3F886
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 10:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700305190;
 bh=RbEz3UHlgWMcRc+CyK2Dqmtmx26LJoq61QvBmaVSfs4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V0AgR4/s6Y8uG7rnleckMBqFzTOE0KePOkLwQqNhgspfH6bCNZq+nCUIcTBOR9ULM
 SMLJqTLqmrav27rFMga/EOQMbobLYAl0xmGRZ4HNJkDm+CM7/Qi7pQtfQ/svqusYaJ
 DrPC76UB+b0+YmOAyqR5WUcF1kJyI7fblqp0v5O4s8o0QsYUHyEWXa9puNO2na/dII
 erDgw7CAPCHeqoIhufKGsip7AhkiTqnHc0akCsktZVAVR+c03bqUaT+TmhoP0z/RiG
 dP9vQTuKB50Ymu6+61vZlwBCZCB/x5dCVEQ6nIfWID4D+0gyv96h/l9Zr1xn+Zrzh0
 uNwAAR3hDgx9Q==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40a700481f4so1803625e9.1
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 02:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700305190; x=1700909990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbEz3UHlgWMcRc+CyK2Dqmtmx26LJoq61QvBmaVSfs4=;
 b=SpYFUznxFLwrSkQTZy68LKGGNmTIjaMTO9A39TBjjVSKIDktsHwoyRdABhkkfO1b1Y
 5AVyf8c0jILG5m2BBiwxNtVHJt5f1KXTxeUVxY5gevfBasBZ48M9yJqlvkm4ud56xweV
 8kHBxGKRebvdfUNDcHzK+aDIjmYOqKXEEuwgI+G0HEW0fga8m/AZ4ciHTbQ7UQbNeq+1
 uDuxzSMhm48iZdU0pDzBToXuWun2B70c49aZ2atZCf/Dky0FvZATahU/rI98t/N7ECgB
 F/FRY5vFNqIg8TRIwxNeQdQFe727UA1T5qGePVunFYWm3zKsIjpjYcE/u4h2sA1esFGX
 Tzbw==
X-Gm-Message-State: AOJu0YzkkRtg6R9ed/xPH4X07ru30CcwyOo663gGoO/cYApv2TJ/ldLM
 kJFDB6gW+yEYeXMIPdaoXjjuCTxFABd/FWqHbriH9MwMJ+Ndu2mrvYtTo8ln7me0wiY8k+lOwH9
 um+dx+cm8Bu9SPF6sJ1/q+4+lVU0C12A=
X-Received: by 2002:a05:600c:4fcc:b0:408:492a:8f3 with SMTP id
 o12-20020a05600c4fcc00b00408492a08f3mr1674286wmq.5.1700305189965; 
 Sat, 18 Nov 2023 02:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8if5bIYqfxwcFfNStHQEgrX5pxVf5bovuVhwN4498/Z5hlt9miJbxqn0d2E9MoGg5UWMhWA==
X-Received: by 2002:a05:600c:4fcc:b0:408:492a:8f3 with SMTP id
 o12-20020a05600c4fcc00b00408492a08f3mr1674256wmq.5.1700305188981; 
 Sat, 18 Nov 2023 02:59:48 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 je14-20020a05600c1f8e00b0040596352951sm10700411wmb.5.2023.11.18.02.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 02:59:48 -0800 (PST)
Message-ID: <0f330e06-ea06-4041-a281-b3713cac785b@canonical.com>
Date: Sat, 18 Nov 2023 11:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: eficonfig: create shortened boot options
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de
References: <20231116230806.20506-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+=XdBzhnLvTp9Sv=bc6aC5pzUQD0ZQkUdagAhJ037Adw@mail.gmail.com>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+=XdBzhnLvTp9Sv=bc6aC5pzUQD0ZQkUdagAhJ037Adw@mail.gmail.com>
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

On 11/18/23 08:35, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Fri, 17 Nov 2023 at 01:08, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The boot options created by eficonfig should use shortened device-paths to
>> avoid problems if drives are enumerated in a different sequence.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   cmd/eficonfig.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
>> index e6e8a0a488..3d95092109 100644
>> --- a/cmd/eficonfig.c
>> +++ b/cmd/eficonfig.c
>> @@ -528,6 +528,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
>>          p += fp_size;
>>          *((struct efi_device_path *)p) = END;
>>
>> +       dp_volume = efi_dp_shorten(dp_volume);
> 
> efi_dp_shorten can return null.  Dont we need to check that here?

Thank you for reviewing.

In the current usage we always have a dp_volume selected in 
eficonfig_select_volume. Only if we had an EFI_SIMPLE_FILE_PROTOCOL on a 
device that is not a block device we could receive NULL here.

Thinking of future support of network files it is probably wiser to 
catch this case too.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>>          dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
>>          free(buf);
>>
>> --
>> 2.40.1
>>

