Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA1FD25056
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B2283B7E;
	Mon, 12 Jan 2026 10:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="uvDv6uMB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD2883C14; Mon, 12 Jan 2026 10:06:02 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 140168392C
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-64ba9a00b5aso8883976a12.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 01:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1768208759; x=1768813559;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qi1ozt92ux8mhcRgOCQISbnHUh7Y6hhsX+mKuumdDPM=;
 b=uvDv6uMBvYOdEPeQl1SSx4b5jFuu13uf4fyrq8BbAAW8qVbIqvNESMPtxj8jju4qXo
 WiL1JOT7vTNik+vCquPg6I0kH13djpoGJ1y4ZNxYR2E3rieGjGKzfP/PPw06ao0781h0
 D6vLqBkqcdZQzfVzFqhxV0N6pq9fMIkb5dbVI6fW94ZvRWrAy3cqjwtP3ir5HzyW3IPg
 E9NIj0Hkai+P1n/4fS7zHGCCiAmN9B0zQeFeko7DtZR1wcTB3lj6ASWSBT0fAK1wpF3B
 eHCjNi9iV+Iv31x7AylJR8tFpzHFWZr29KHwtCKp03CTJtwYz2RUXdowkz8UbWqee1sQ
 JfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768208759; x=1768813559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qi1ozt92ux8mhcRgOCQISbnHUh7Y6hhsX+mKuumdDPM=;
 b=OraLK/NWKoem6+MC7QJT0rc0gC3HDah1np5dRfxw+1wMXVtpdrHd+Jh66RXae7NSgK
 aaxAXFwn5Hw5sSWqJVRNlUGcSf2SPSfhSX3jnKl3aw8sRTIzxWVjBGTvJRpxhSdfeuWg
 VJWWSwptJqvi9rBo2dMKPmP6miwxfPmLoBUXVul8cFpvIt6wNlE+SuLse7qEZqh/oZB+
 V3qd25yMGzmwOw+L4XLOerbEcx5SsMfJiTyp73wzC9FKYt+/Qr6VdM3XdKo31FCb0YXC
 ptHG5M6dyPcR3ar1rfux+bj2WoCv0R2kdEZV9xkNXq2dAiyFzAOH/nVb4pHbaLFmM7fy
 wYZg==
X-Gm-Message-State: AOJu0Yz1FNKZDh1kM9pLmr061cHLjXqJ0SK4MU0SIt7Nmgaol4Omz2QZ
 cPFV0ie+fyxjg+K56/QHXnzDHINZxPa7bt6OOirwQUbVGn7wOERRBk0aFh7jp0e6nQ==
X-Gm-Gg: AY/fxX6rKeDDV/MEvlnOtZVvr7e1U6RH1dH0TKJCW/M9mOVksR2/eztlhRTHfMTwcPa
 5hlfzCUhSlW+5hidsjQoP379Qrvu2RyxdC6c5HxSauPCFviVCHehLQvWlRjL5jX5pNMDsGdDRvN
 3QaoE6wnHjbz4M4OdCiAtHAQmgNms/PU0mFjZc9P6iLzBLVzq70peLT9APBntfgMOAhbncvlfc6
 HD230voOXI0Rmrn9x7AX+4yXFL9YVtyeISwg6+xEvJpJiXJjz/Op0gUqTp4uv4/KyPg/5tPmqG0
 vO1CxLgTknM+6hraehxdy4trazYAxjZdQ6V3VG6abxA9pLatSSZwKMTNWLgl7VN40ZCxy0wWAyw
 ZEg9nSIu13ak5iU5vZEjCNKt/phvLBawoUMC4Cy4cRDdCjsxuj13KwaaaGMYoAz2c4a5n7611V4
 u/K+dXRPm2P6av
X-Google-Smtp-Source: AGHT+IHd4K0EJ/YTZwqA/bPIb9wC49kbWFvvcMv8TOXknzs+w94Rj6mhXWVyBcwTcLz5T7beapuK9w==
X-Received: by 2002:a05:6402:3508:b0:64b:7885:c971 with SMTP id
 4fb4d7f45d1cf-65097e50e11mr15209027a12.20.1768208759219; 
 Mon, 12 Jan 2026 01:05:59 -0800 (PST)
Received: from [10.254.183.223] ([149.199.62.131])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf667fcsm16950082a12.29.2026.01.12.01.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 01:05:58 -0800 (PST)
Message-ID: <10d67e2e-6515-4fb4-bf9a-77e5b0961b7b@monstr.eu>
Date: Mon, 12 Jan 2026 10:05:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] tools: Add dumpfwumdata tool for FWU metadata image
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com,
 Daniel Golle <daniel@makrotopia.org>, E Shattow <e@freeshell.de>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-5-dario.binacchi@amarulasolutions.com>
 <CAHTX3dKhhuA2rbg5fiL3bZcUNJVWLCfJ9Vppr1oEB8v6_6qHDA@mail.gmail.com>
 <CABGWkvqG_6TYTvBb9NrzJpH==Kwd21ADxwOAMpuuF98z62nx5g@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <CABGWkvqG_6TYTvBb9NrzJpH==Kwd21ADxwOAMpuuF98z62nx5g@mail.gmail.com>
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



On 1/11/26 16:17, Dario Binacchi wrote:
> Hello Michal,
> 
> On Mon, Jan 5, 2026 at 4:40 PM Michal Simek <monstr@monstr.eu> wrote:
>>
>> ne 28. 12. 2025 v 16:19 odesílatel Dario Binacchi
>> <dario.binacchi@amarulasolutions.com> napsal:
>>>
>>> Allow reading FWU metadata from userspace.
>>>
>>> According to [1], after updating the software on bank B, setting
>>> active_index to point to it (i. e. 1) and marking it as a Valid bank, it
>>> must be possible to read this information from userspace on the next
>>> boot to verify whether the boot chain of bank B succeeded.
>>>
>>> The metadata must then be updated again, marking the bank as INVALID if
>>> the active_index points to bank A (i. e. 0) or as VALID if the boot was
>>> successful.
>>>
>>> To allow reading the active_index and bank state, this new tool has been
>>> added.
>>>
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> ---
>>>
>>>   tools/Kconfig        |   7 +++
>>>   tools/Makefile       |   4 ++
>>>   tools/dumpfwumdata.c | 128 +++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 139 insertions(+)
>>>   create mode 100644 tools/dumpfwumdata.c
>>>
>>> diff --git a/tools/Kconfig b/tools/Kconfig
>>> index 652b0f225579..9de7eed1bbbb 100644
>>> --- a/tools/Kconfig
>>> +++ b/tools/Kconfig
>>> @@ -194,6 +194,13 @@ config LUT_SEQUENCE
>>>          help
>>>            Look Up Table Sequence
>>>
>>> +config TOOLS_DUMPFWUMDATA
>>> +       bool "Build dumpfwumdata command"
>>> +       default y if FWU_MULTI_BANK_UPDATE
>>> +       help
>>> +         This command allows users to read and display the raw FWU
>>> +         metadata. The exact access method depends on the platform.
>>> +
>>>   config TOOLS_MKFWUMDATA
>>>          bool "Build mkfwumdata command"
>>>          default y if FWU_MULTI_BANK_UPDATE
>>> diff --git a/tools/Makefile b/tools/Makefile
>>> index ae6a30526466..bc105a086927 100644
>>> --- a/tools/Makefile
>>> +++ b/tools/Makefile
>>> @@ -271,6 +271,10 @@ mkeficapsule-objs := generated/lib/uuid.o \
>>>          mkeficapsule.o
>>>   hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
>>>
>>> +dumpfwumdata-objs := dumpfwumdata.o generated/lib/crc32.o
>>> +HOSTLDLIBS_dumpfwumdata += -luuid
>>> +hostprogs-$(CONFIG_TOOLS_DUMPFWUMDATA) += dumpfwumdata
>>
>> you need to update this based on changes
>>
>> commit bd3f9ee679b4d1456d0d3c261ab76788950e6096
>> Author:     Sughosh Ganu <sughosh.ganu@linaro.org>
>> AuthorDate: Tue Dec 16 11:16:24 2025 +0200
>> Commit:     Tom Rini <trini@konsulko.com>
>> CommitDate: Fri Jan 2 10:28:14 2026 -0600
>>
>>      kbuild: Bump the build system to 6.1
>>
>>
>> add missing always.
>>
>>> +
>>>   mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
>>>   HOSTLDLIBS_mkfwumdata += -luuid
>>>   hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
>>> diff --git a/tools/dumpfwumdata.c b/tools/dumpfwumdata.c
>>> new file mode 100644
>>> index 000000000000..4965484df1be
>>> --- /dev/null
>>> +++ b/tools/dumpfwumdata.c
>>> @@ -0,0 +1,128 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2025, Amarula Solutions
>>> + */
>>> +
>>> +#include <errno.h>
>>> +#include <getopt.h>
>>> +#include <limits.h>
>>> +#include <stdio.h>
>>> +#include <stdint.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +#include <generated/autoconf.h>
>>> +#include <sys/types.h>
>>> +#include <sys/stat.h>
>>> +#include <u-boot/crc.h>
>>> +#include <uuid/uuid.h>
>>> +
>>> +typedef uint8_t u8;
>>> +typedef int16_t s16;
>>> +typedef uint16_t u16;
>>> +typedef uint32_t u32;
>>> +typedef uint64_t u64;
>>> +
>>> +#undef CONFIG_FWU_NUM_BANKS
>>> +#undef CONFIG_FWU_NUM_IMAGES_PER_BANK
>>> +
>>> +/* This will dynamically allocate the fwu_mdata */
>>> +#define CONFIG_FWU_NUM_BANKS           0
>>> +#define CONFIG_FWU_NUM_IMAGES_PER_BANK 0
>>> +
>>> +#include <fwu_mdata.h>
>>> +
>>> +static const char *opts_short = "h";
>>> +
>>> +static struct option options[] = {
>>> +       {"help", no_argument, NULL, 'h'},
>>> +       {NULL, 0, NULL, 0},
>>> +};
>>> +
>>> +static void print_usage(void)
>>> +{
>>> +       fprintf(stderr, "Usage: dumpfwumdata [options] <fwumdata file>\n");
>>> +       fprintf(stderr, "Options:\n"
>>> +               "\t-h, --help                  print a help message\n"
>>> +               );
>>> +}
>>> +
>>> +static void print_mdata(struct fwu_mdata *data)
>>> +{
>>> +       int i;
>>> +
>>> +       fprintf(stdout, "FWU Metadata\n");
>>> +       fprintf(stdout, "crc32: %#x\n", data->crc32);
>>> +       fprintf(stdout, "version: %#x\n", data->version);
>>> +       fprintf(stdout, "active_index: %#x\n", data->active_index);
>>> +       fprintf(stdout, "previous_active_index: %#x\n",
>>> +               data->previous_active_index);
>>> +
>>> +       if (data->version == 2) {
>>> +               uint8_t state;
>>> +               char cstate;
>>> +               for (i = 0; i < 4; i++) {
>>> +                       state = data->bank_state[i];
>>> +                       if (state == FWU_BANK_ACCEPTED)
>>> +                               cstate = 'A';
>>> +                       else if (state == FWU_BANK_VALID)
>>> +                               cstate = 'V';
>>> +                       else if (state == FWU_BANK_INVALID)
>>> +                               cstate = 'I';
>>> +                       else
>>> +                               cstate = '?';
>>
>> Isn't it better to print accepted, valid, invalid instead?
>>
>> I had to look at code to understand what that print value means.
>>
>>> +
>>> +                       printf("bank_state[%d]: %c\n", i, cstate);
>>> +               }
>>> +       }
>>
>> It is a good start but I think more information should be printed.
>> Number images, custom fields, etc.
>>
>>> +}
>>> +
>>> +static int fwu_read_mdata(struct fwu_mdata *mdata, const char *mdata_file)
>>> +{
>>> +       FILE *mfile = NULL;
>>> +       size_t ret, size = sizeof(struct fwu_mdata);
>>> +
>>> +       mfile = fopen(mdata_file, "r");
>>> +       if (!mfile) {
>>> +               fprintf(stderr, "Error: Failed to open %s\n",
>>> +                       mdata_file);
>>> +               return -1;
>>> +       }
>>> +
>>> +       ret = fread(mdata, 1, size, mfile);
>>> +       fclose(mfile);
>>> +       if (ret != size) {
>>> +               fprintf(stderr, "Error: Failed to read from %s\n",
>>> +                       mdata_file);
>>> +               return -1;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +       int c, ret;
>>> +       struct fwu_mdata mdata;
>>> +
>>> +       if (argc < 3) {
>>> +               print_usage();
>>> +               return -EINVAL;
>>> +       }
>>
>> above you have only help and here you are asking for 3 args which
>> seems to me wrong.
> 
> Thank you for your review and the feedback on my patch series.
> After I sent the series, I realized that this series had previously
> been posted:
> https://lore.kernel.org/all/20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com/.
>  From what I understand, it starts from the same need as mine, namely
> the implementation of a tool that
> allows reading FWU metadata from Linux. My version is definitely more
> minimal compared to what Kory
> has done.
> Therefore, before sending a v2, I think it would be useful to
> understand which of the two makes more sense
> to move forward with. Could you help me with that? I have also CCed
> Kory to keep the discussion shared.

Kory's version looks more complete. If Kory is happy to send another version I 
think you should test it, review it. If he is not going to send v3 I think you 
should merge your series with his and send another version.

Thanks,
Michal


