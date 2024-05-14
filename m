Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1BBC04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F5288311;
	Tue, 14 May 2024 14:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MzJLY1fC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AD9E88312; Tue, 14 May 2024 14:57:34 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E01880F8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A9EC441070
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715691451;
 bh=g3vZd0np10s/jIWWqAjh+HDgS5bFshXmxxs9q8g87y8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=MzJLY1fCHKxR/t3GQyoSJVC3vE3p7K8KhlOFhwuC9v80BHblB0+NQ3J9sSRi8HJZj
 POqIrjUJKq6hWOJcfqD2EXX5Y29MXeVmjisB7clFw9l+k2zPAwoZm20HndxXobT1By
 Ud54PzFLlSdpS9bdE7oNJ5Z1jB9FgAc92KXN8+tAs0AwAXC786Ug1ifU6roogG5cOg
 +izQL5hPCWBEwVoGxgl5w6PUU5ZUDxQ63WvU7R1waBusimapAhqIqGvSFXqhc+9VF8
 0vxJoBNbA6oXEsi8Hdt7M49TH43QVa+1PD930xodr36e/XhuGxGn2KefXbZ7jWvVUz
 BDYDYOnHG32tw==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59cfaba975so203272366b.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 05:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715691451; x=1716296251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g3vZd0np10s/jIWWqAjh+HDgS5bFshXmxxs9q8g87y8=;
 b=tRt6xi1FZcGWX8wggTmiYGstmcEHB40ce04khOHQHyfTp4pEVLMKfsOyrxTAVXZgfy
 MtvE4RVyeckoDiDTx87FDhbgtVxQOChXjkE5KGnnSmsJUHTvY/YdPXyPgSrO/Emi3WdC
 31Qlq5SwzaAw715gooxbIMx0lPH+QTviIoo4cTx8PLDY9SBJyeEALgUGvqxRSHrgzEsY
 c/VxDgFbDaut9s07RZlaXUYV8bHAKoG/KPr1mXZGGKFzln1zHQmb3IOFpOgP3XsRFeHL
 HNlfDzAxcTpDGJAfoSkfjnKYIYm+rQCcuAjn7NKdHB6glNLb79SvaBdflqQ1buvRLFK8
 w+BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTzI0X7Gq/623UoPMOeKsyDXaEI7nqtFcy4D81xBMxhVItlUpqyYSNUYFpYCOApHDoZVjzJGiM8A/Ae7j+vc6X/JvjlA==
X-Gm-Message-State: AOJu0YxLzadBlegRUt9wudGrxiszLwXM06zT5mhPLzp3lE/N5p4JSSRd
 TjkIvHD5DnivC2R42SSNiwE7JuI5uw+zeGajSxrCp2OeopNaq7fKIgzfoZQWLxsyUUfxVxUhG1r
 rfLzcdvTfvhGfMGQCDYD7oOcp6dD9xLhWCmnr/1D+9JbDUKd2rKOSlZjFTXQ1A88gKrw=
X-Received: by 2002:a50:870d:0:b0:572:6af5:1b61 with SMTP id
 4fb4d7f45d1cf-5734d597d67mr11906218a12.6.1715691451331; 
 Tue, 14 May 2024 05:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIwmvkly64N4y1f9dvlEKaP79MTK/fndy9/tcSNs6hGjFdeOG6fMrLiaWCHY/3c6xFwE16Dw==
X-Received: by 2002:a50:870d:0:b0:572:6af5:1b61 with SMTP id
 4fb4d7f45d1cf-5734d597d67mr11906197a12.6.1715691450946; 
 Tue, 14 May 2024 05:57:30 -0700 (PDT)
Received: from [10.55.2.71] ([149.11.192.251])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574d3fc4eedsm1919046a12.78.2024.05.14.05.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 05:57:30 -0700 (PDT)
Message-ID: <2a112982-db20-487e-8a17-1ee2c8d598c4@canonical.com>
Date: Tue, 14 May 2024 14:57:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 12/14] efi_loader: return binary from efi_dp_from_lo()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-13-heinrich.schuchardt@canonical.com>
 <CAC_iWjJrD3BODipSJ=t9_qpAXzefjzRPw_4r2fQAsOqyq8mkYg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJrD3BODipSJ=t9_qpAXzefjzRPw_4r2fQAsOqyq8mkYg@mail.gmail.com>
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

On 4/28/24 15:28, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Fri, 26 Apr 2024 at 17:14, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Up to now efi_dp_from_lo() only could return the initrd or fdt device-path.
>> Allow returning the binary device-path to.
> 
> Why do we need this?

In patch 14/14 I add this line:

+	dp = efi_get_dp_from_boot(NULL);

The binary path indicates the partition on which to search for the 
default dtb as indicated by $fdtfile.

I should have added an explanation in the commit message.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_loader/efi_device_path.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
>> index 75fe95c9c1e..c8893f5626b 100644
>> --- a/lib/efi_loader/efi_device_path.c
>> +++ b/lib/efi_loader/efi_device_path.c
>> @@ -1140,17 +1140,18 @@ ssize_t efi_dp_check_length(const struct efi_device_path *dp,
>>   }
>>
>>   /**
>> - * efi_dp_from_lo() - Get the instance of a VenMedia node in a
>> - *                    multi-instance device path that matches
>> - *                    a specific GUID. This kind of device paths
>> - *                    is found in Boot#### options describing an
>> - *                    initrd location
>> + * efi_dp_from_lo() - get device-path from load option
>>    *
>> - * @lo:                EFI_LOAD_OPTION containing a valid device path
>> - * @guid:      guid to search for
>> + * The load options in U-Boot may contain multiple concatenated device-paths.
>> + * The first device-path indicates the EFI binary to execute. Subsequent
>> + * device-paths start with a VenMedia node where the GUID identifies the
>> + * function (initrd or fdt).
>> + *
>> + * @lo:                EFI load option containing a valid device path
>> + * @guid:      GUID identifying device-path or NULL for the EFI binary
>>    *
>>    * Return:
>> - * device path including the VenMedia node or NULL.
>> + * device path excluding the matched VenMedia node or NULL.
>>    * Caller must free the returned value.
>>    */
>>   struct
>> @@ -1161,6 +1162,9 @@ efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>>          struct efi_device_path_vendor *vendor;
>>          int lo_len = lo->file_path_length;
>>
>> +       if (!guid)
>> +               return efi_dp_dup(fp);
>> +
>>          for (; lo_len >=  sizeof(struct efi_device_path);
>>               lo_len -= fp->length, fp = (void *)fp + fp->length) {
>>                  if (lo_len < 0 || efi_dp_check_length(fp, lo_len) < 0)
>> --
>> 2.43.0
>>

