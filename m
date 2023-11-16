Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BFC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 19:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44C8287441;
	Thu, 16 Nov 2023 20:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hVa3G0PG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41B887443; Thu, 16 Nov 2023 20:43:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D56587206
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 20:43:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64F153F6EF
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700163804;
 bh=C9yW9BSEA+NUeG8oCpSoW52Z/jHSvZ0u5WgT0nCySoE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hVa3G0PGWDmtY4QQtPW3NxH0DC5zo0kEUZsgHyzgFSUXDz+fKKnPfdONLNf5pffXq
 xSks/+btWqEb9ZmTlJ9DqnqE7G8C1ohd4V9Jf3AZvSGP77KD8H+Szr8Ku0uDL7NEnS
 fzeGK0GN1f34fanckrs4tfq07Hao/YKMv1gvURwny+MQQm72XMnOa+yVwQLX4+wcyE
 9gE6ulXcypBUAKtuZzH79VwpMxmuB5dk+SvKzeBsQvgHAvK473nl/V+eklhNxMDfr+
 CbrfNfCCdEAVbqyMt3pIz09ShtVt8Kpoc/Cxnc+NuSIiu3YOJmfo3cRu8vE7NzrmVo
 dLKQB1zXyO/hg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32fa41d0564so587051f8f.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 11:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700163802; x=1700768602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9yW9BSEA+NUeG8oCpSoW52Z/jHSvZ0u5WgT0nCySoE=;
 b=qbG9drP46jngd87hhEx+Bp3X4JH8LlSz+vxOq+536wcIajDATO3/CrNwWuUemJlycO
 6riqArwp/I2QLX+3k/DXsK1XoTEbLSyqYe3BYU9OUy2tBt0m2liZdDnKGYcGEJ6IJisC
 y44QyTeOw3dJ+13QtvnCgkiE2t0aUjNQ7K10y+R7XcMkaXT+HXdtwVUs1WXvpsZauBRJ
 7TVm5sEzze8YZOtFTwdRC83ODcLFQdnYauN9aw29pcX0OzA/YF/drVwShGHlH9Bpk0Gj
 AgrMQ4x18fqV8yMCHo0JCInYLja4mhQpuYEodfA9VQbrGFFy9iZEnFfKQrSVWts118Sv
 rlhg==
X-Gm-Message-State: AOJu0YwAu/aF7nLxZG0mnfGb9BIwruwj+CBpGMl2kj9J/3Us+JVuIlYH
 DTNOg7trJw33lwoIJGtsweG489iQusvM9ld22hZ4gJLkF/8JGMQgMVrmy+ZSJwbGKlJ3WAJ5CCt
 tRhpbyD7eaaOVR8WO4Vcq5Rsk9xU0a20=
X-Received: by 2002:a5d:6c61:0:b0:32d:8819:4620 with SMTP id
 r1-20020a5d6c61000000b0032d88194620mr13701202wrz.14.1700163802383; 
 Thu, 16 Nov 2023 11:43:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESVynN+Amg+vyEhC1AwIw+z7gjDhC2oEQ/aFJXE5FsmSH86gYIluCH9KNi77AlZx4xroHpmQ==
X-Received: by 2002:a5d:6c61:0:b0:32d:8819:4620 with SMTP id
 r1-20020a5d6c61000000b0032d88194620mr13701174wrz.14.1700163801908; 
 Thu, 16 Nov 2023 11:43:21 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 s13-20020a5d6a8d000000b0032fbe5b1e45sm232827wru.61.2023.11.16.11.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 11:43:21 -0800 (PST)
Message-ID: <86182fad-ba42-46ba-a504-9f3f4deb34a4@canonical.com>
Date: Thu, 16 Nov 2023 20:43:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] acpi: do not write ACPI tables on TARGET_QEMU_VIRT
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Alexander Gendin <agendin@matrox.com>, Zong Li <zong.li@sifive.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
References: <20231115142355.123038-1-heinrich.schuchardt@canonical.com>
 <20231115142355.123038-2-heinrich.schuchardt@canonical.com>
 <20231116183345.GA170968@bill-the-cat>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231116183345.GA170968@bill-the-cat>
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

On 11/16/23 19:33, Tom Rini wrote:
> On Wed, Nov 15, 2023 at 03:23:50PM +0100, Heinrich Schuchardt wrote:
> 
>> RISC-V QEMU provides the ACPI tables. We do not need to generate them
>> ourselves.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   lib/acpi/Makefile      | 2 +-
>>   lib/acpi/acpi_writer.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
>> index c1c9675b5d..19fa6ac869 100644
>> --- a/lib/acpi/Makefile
>> +++ b/lib/acpi/Makefile
>> @@ -12,7 +12,7 @@ obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_table.o
>>   obj-y += acpi_writer.o
>>   
>>   # With QEMU the ACPI tables come from there, not from U-Boot
>> -ifndef CONFIG_QEMU
>> +ifeq ($(CONFIG_QEMU)$(CONFIG_TARGET_QEMU_VIRT),)
> 
> The goal here is to say that we have been passed ACPI tables, and not to
> generate them, yes? Lets just introduce a symbol which says that and
> enable it as needed in both QEMU targets and others as needed please.

These are the conflicting function implementations:

drivers/misc/qfw.c:158:ulong write_acpi_tables(ulong addr)
lib/acpi/acpi_writer.c:72:ulong write_acpi_tables(ulong start_addr)

drivers/misc/Makefile has:

ifdef CONFIG_QFW
obj-y += qfw.o

but inside the driver we find another constraint:

#if defined(CONFIG_GENERATE_ACPI_TABLE) && !defined(CONFIG_SANDBOX)

So probably we should probably have a symbol which is set for

CONFIG_QFW && CONFIG_GENERATE_ACPI_TABLE && !CONFIG_SANDBOX

Maybe call it CONFIG_QFW_ACPI, "Read ACPI tables from QEMU".

Best regards

Heinrich
