Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C0D3C53E
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402E189119;
	Fri, 18 Oct 2024 03:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sV+s9ws8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384E889112; Fri, 18 Oct 2024 03:01:13 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D77890CA
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6A6DD3F458
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729213265;
 bh=fcyoWZDDe3HqjaZUao7cWQyBfhZhYmBihIgZ5hRT/78=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=sV+s9ws8sk57OqGtqnNtvp/H2K1QeQGs0yqdpIEDhiJipcdsEWRBYV0LbAnH5H4Pq
 qcK8T0L/uI17g2hXMcKlhiETL0zYzVUBUS4IqJQA9gupoGiUumzaGRyvweuXEi8IQN
 0qaIYygLIxsDsDrDRQ9DtwPnrx6h1nxuENgNUjuffN76C5pIEpH0Q/nB89v6zTLC+Y
 M70Xh6RCI5xqaD+J3rCjVwl9U1vpsOF0sT/nk0Zn2eCymv/kgKi+vXLmAayK40RWgT
 qtnLsMBacSndTQOvAm2cwrDB9BE3BMxAf9zl+uMafqgIo4hUmz3g6etjjY0g6+5wc4
 7LTYPE3YWxvDA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so1492265f8f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729213263; x=1729818063;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fcyoWZDDe3HqjaZUao7cWQyBfhZhYmBihIgZ5hRT/78=;
 b=OrhLX5yQK+0iJFeuhiTDppIZt8dM5nhxDBv5cDh3U6uYMdxL/hp7DsPPaTQpj2J7PW
 4qjkhHPdktu2YItpuYE4t14lvHkB/dCtQHEpHYsv0sTAnlQMbSV3VatjzRNVeFZNLbSE
 yJwid5q8/vpszMUAum+6kLIwHsTLGd41euh49Z8IvNPorurLiokTQh8MkywO/W0SJtaA
 ZHpsT28IdpetAdTNzVBqdvNjttilkBHFaDL/b94fAS+YLaFmpQ/fNnmzHBYHANA1I7zr
 K4yUQ9CE2KsQRedulcxmCiGn3wTdWk8AfkFUt+VczXah6rYZESpYuw5rqshF7+TlalE/
 q43g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7MNTfSNs9OKK19GY5s5TYOWZlPuiCHavzd5ip+Kw7RJuVi61gGixgCW9BWchsETolzvJEe/U=@lists.denx.de
X-Gm-Message-State: AOJu0YyZzve3/Vj6+kPNb5x4vsds3+mZbkQ1p8ptrYU0ctSJn7mAYySl
 /GGFR7VGqyQaXkb4I70jqhBUGuXj+YKDTqfq8wAL9UHP92t6iVSTc/QPAeYXlAu+t/V7K4VOMO7
 Gjqf0GFrZC442bS/yvkVJ94uXYBJe8o3xP41fQovhvZI8DjEbya0bSohQimHdNqQSqKA=
X-Received: by 2002:a5d:4a12:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-37ecef67964mr308926f8f.1.1729213262989; 
 Thu, 17 Oct 2024 18:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1IU3QhldEVin8lLQIeqWkpTlOlDPre91lcATrxnwZ7r2vVJYdAs5QC6MFY/h9Go0AY5jLXA==
X-Received: by 2002:a5d:4a12:0:b0:37d:3baa:9f34 with SMTP id
 ffacd0b85a97d-37ecef67964mr308915f8f.1.1729213262560; 
 Thu, 17 Oct 2024 18:01:02 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ecf118310sm416212f8f.94.2024.10.17.18.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 18:01:00 -0700 (PDT)
Message-ID: <1774369c-9c2c-4e0f-bf01-9dc7e1fdacbc@canonical.com>
Date: Fri, 18 Oct 2024 03:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sandbox: add bootmethod EFI boot-manager
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
References: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
 <875xpyhfz7.fsf@baylibre.com>
 <CAFLszThR-qMK0e9f6nsSTVh+t-rkfN1KF+OWYWixYR7ds_soHQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThR-qMK0e9f6nsSTVh+t-rkfN1KF+OWYWixYR7ds_soHQ@mail.gmail.com>
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

On 10/18/24 01:23, Simon Glass wrote:
> Hi Heinrich,
> 
> On Fri, 11 Oct 2024 at 08:27, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Heinrich,
>>
>> Thank you for the patch.
>>
>> On mer., oct. 09, 2024 at 00:32, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>
>>> The EFI boot-manager is the default method to boot EFI binaries.
>>> We should be able to use it on the Sandbox.
>>>
>>> * Enable EFI boot-manager bootmethod on the sandbox.
>>> * Adjust unit tests to reflect the additional boot method.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>>> ---
>>>   arch/sandbox/dts/test.dts |  4 ++++
>>>   test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
>>>   2 files changed, 21 insertions(+), 11 deletions(-)
>>>
> 
> This produces the following output on sandbox, for me:
> 
> => bootfl scan
> efi_set_blk_dev_to_system_partition() No EFI system partition
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> efi_set_blk_dev_to_system_partition() No EFI system partition
>       efi_var_to_file() Failed to persist EFI variables
> 
> Perhaps we need to make this option, e.g. with a 'bootstd' command to enable it?

These messages only appear if you have no ESP on a connected block 
device and store EFI variables on disk. For each block device a BOOT#### 
variable is created.

Instead of changing this patch we should reduce the noisiness.

For a user it should be sufficient to read once that EFI variables 
cannot be persisted due to a missing ESP.

Best regards

Heinrich
