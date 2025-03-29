Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616C0C36008
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 15:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CA48171B;
	Sat, 29 Mar 2025 16:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zD1NNXdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DAEA81F44; Sat, 29 Mar 2025 16:07:09 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CD581E5B
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 16:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso5696705a12.0
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 08:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743260827; x=1743865627; darn=lists.denx.de;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsJnTeENfpAaOhcavGTcOx15mC97IDRpL2Bgb02RzPc=;
 b=zD1NNXdNay4L834rhJGaRl2SsfiOChLkkQQ3uHuDSBjd15F1oOYq7etm28LZG/EmoP
 /N0UT6BDJ2J82DgeJKVkEPp+TZfQz3GpKtAnB/9ixqE4XNSridFhabUAQSXQ+Z/0BqXw
 Q3fo0v6fltwVso4o89FpbnEy1ZUv3+OmHIAPe1A/VfyZrBzkymKdd/Qkx6Mwuf7yrtIZ
 kzS0hewSql/BS6Q8wA+z8e7ppMMp0/q4uBcY6lIeIiC0QZLzmzq++8eBWT5pET40M/Rq
 UAMvj5KP5CZJ57GrPexqW4nJDVF4hg6UiUkpcKCjFJ8KU/UHsAT/+Q1lEv/tkmK0ZLj5
 K3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743260827; x=1743865627;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nsJnTeENfpAaOhcavGTcOx15mC97IDRpL2Bgb02RzPc=;
 b=NdJEZs59ftFB1kbsmIHE6Zg7tGLckwY/fnzdk5x1/HTQK9pDtBcNkz90bKRxj39Jzt
 0cf2ZFK7/bQrlzz7cWWtCZ4xXlq1OXFRC+fqPMlBhjxdYc2DxBD/h3e6I4KJUudP7yOU
 ZdnRwinQmbu//wH0gQ+AZuAdzHKm4JLb6c+53U3JXh85KLLOXv5G3/9l1/MsXBq2AJFn
 BKeTNd3VCWIGO96ymDnOUpvUnwO8OihPGPg3aNedGi3B6nSsKU0Dp9uLpz3wyfEAtnWb
 sE3yR8ScUBR0KWshEbd8gkgF+/KmBdZ3Hgp7DQqSqIjELlKjegYTEKwzHUVbSuKzzeah
 bD7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnYnJviLBeDQ+dxDe6/REVNXiAGgUnHPMZh2Pl16VmpkDLkqeKOiSsPY8HflhdbVAZ9fibo+s=@lists.denx.de
X-Gm-Message-State: AOJu0YwjehsOLfbygxhjHYIsa1kJzfN2srS3H5AtrI5GFlZPSeOD1y46
 trCgmoHAei6LhsIBjIldKIrKzQiR2128HDJLxbhd4VSibMFwNvsWBQgqe6Oh4Io=
X-Gm-Gg: ASbGncviWbzU5gsmXBHqvxx1YtIMWs2y6vI64+tvwbpYr90QJvBDt+VcKUvuQtCQXZN
 NXflwBYzJyAqHZGjmAkviQ9B5E54lNDAsuJhqyYBS9QodJoFsAfkkmOl9wlPg9Kn0/CX75GdHOz
 Y55nbCSJIvCsz7ko1952ApiZ3jQSdESI+9zK58yeycBD0MFu4IozOo0v1KXeix8mWxGVKeRiuMt
 eG3AYi6LYQri5sg7MlhhwUuj3ODM5F9nGA4eCXABUC9u65tqXlU81IuzVboquAzVv2SehLuM4jx
 U5w4oVe23IrHnXsWLv8HMdQGedmlQzcCc1uorLPDbQpTKEPI7tHV2BDVAzbyh/r7GYJiBhlJ93i
 cNPnh
X-Google-Smtp-Source: AGHT+IFQE3KEogZ4kaZxSFhwFw7lfwOXMP1KgElK88dSSo45Czp7fYdo9BkRbi/S66dsVsejGllx2Q==
X-Received: by 2002:a17:906:dc8f:b0:ac6:d160:e39e with SMTP id
 a640c23a62f3a-ac738b3c81bmr255967066b.31.1743260826592; 
 Sat, 29 Mar 2025 08:07:06 -0700 (PDT)
Received: from localhost (ppp089210073071.access.hol.gr. [89.210.73.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b027sm340726766b.47.2025.03.29.08.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 08:07:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 29 Mar 2025 17:07:04 +0200
Message-Id: <D8SUDZ25B6NC.37Z4K12FL4M6S@linaro.org>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, "Varadarajan Narayanan"
 <quic_varada@quicinc.com>
Cc: <trini@konsulko.com>, <sjg@chromium.org>,
 <EABachinin@salutedevices.com>, <jerome.forissier@linaro.org>,
 <rasmus.villemoes@prevas.dk>, <ansuelsmth@gmail.com>,
 <sughosh.ganu@linaro.org>, <michal.simek@amd.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.0
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <92f8a810-981b-4ad7-9a6b-be013ccf084e@gmx.de>
In-Reply-To: <92f8a810-981b-4ad7-9a6b-be013ccf084e@gmx.de>
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

On Sat Mar 29, 2025 at 2:02 PM EET, Heinrich Schuchardt wrote:
> On 3/26/25 06:46, Varadarajan Narayanan wrote:
>> If the EFI runtime services pointers are relocated even though
>> relocation is skipped, it corrupts some other data resulting in some
>> unexpected behaviour.
>>
>> In this specific case, it overwrote some page table entries resulting in
>> the device memory address range's mappings getting removed. Eventually,
>> after the completion of efi_runtime_relocate(), when a driver tries to
>> access its device's registers it crashes since the mappings are absent.
>
> Hello Varadarajan,
>
> thank you for pointing out this issue.
>
> I found two places where the flag is set:
>
> lib/efi/efi_app.c:198:  board_init_f(GD_FLG_SKIP_RELOC);
> board/synopsys/iot_devkit/iot_devkit.c:117:     gd->flags |=3D
> GD_FLG_SKIP_RELOC;
>
> iot_devkit_defconfig does not support UEFI.
>
>
> lib/efi/efi_app.c:198:  board_init_f(GD_FLG_SKIP_RELOC);
>
> efi-x86_app64_defconfig does not support UEFI either.
>
>
> For existing boards this seems to be a non-issue.

It's not but IIRC it was discovered because they added the non reloc flag i=
n a Qualcomm board.

>
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   common/board_r.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/board_r.c b/common/board_r.c
>> index 179259b00de..1dd3b96c2de 100644
>> --- a/common/board_r.c
>> +++ b/common/board_r.c
>> @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
>>   	 */
>>   	efi_save_gd();
>>
>> -	efi_runtime_relocate(gd->relocaddr, NULL);
>> +	if (!(gd->flags & GD_FLG_SKIP_RELOC))
>> +		efi_runtime_relocate(gd->relocaddr, NULL);
>
> efi_runtime_relocate() is called twice:
>
> * when moving U-Boot to high memory (that is here)
> * when the OS call SetVirtualAddressMap()
>
> Removing the call here looks like the right thing to do when main U-Boot
> is not relocated.
>
> Did you test that starting an operating system via UEFI works in your
> use case?

He did and I also asked him to run a runtime service -- e.g GetVariable.

>
> It would be preferable to have a QEMU based defconfig where we could
> test this scenario and add it to the CI.
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

As I said this looks correct, but please test the runtime invovation

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>
>>   #endif
>>
>>   	return 0;
>>
>> base-commit: 244e61fbb7f5045e4e187024f7ae80434c952145

