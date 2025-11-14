Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9048CCE7B13
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1482383F54;
	Fri, 14 Nov 2025 15:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Uq+u5mGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB158410D; Fri, 14 Nov 2025 15:29:59 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B93D83968
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D67F14013C
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 14:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763130594;
 bh=s4PQFg1ie2DAW2KcqJCqA5zU1u8kdtHq2XCZwz7CukY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Uq+u5mGxPE68TJHMT6jm7AsAEQ271TTRjGnM71WIFxCSTDdH1xV0JSCG6aeYn1E4P
 0ihe3RzLEaPkWs3nlWspKfe1eRFA91jErjz6o/PtngJ3tXfo7im+4Bk9fUOrP/WHSH
 lbGavCuhjMQaVPFSjeP03ooRfRHGo+pAdSd2Hq8pHC2q3F3oXII7IC0+KBV+Y+Rqv6
 byAyd09EPku8D0O9LW2zyFB0uFGJEMWckUf/gWeM09I7kbXZK47tErW7sDu7k1nvxg
 lIEhU58xBeh//qJJT3GPrZhjc3+2L9rzJwRFO+dG16yJH9QUu/3yTPdsk/sr6r9Id7
 BevuStOsOhw5tAgQfW4zQzVLCoRE5oWxxnmZNE8KeHzIX02uNV6i44Ee/qHbTbIoqe
 fYO4ZAEIy1FmQ0b7RkWpaTzTlOmSftmNa3+Z6HI+D6ZLuukIOh7lm4rZQRvxlPnLx6
 C6fG3Uc2PdWX03uay/8Uf+s0C8v3cMb1Na9wx1C2P9oHOroiBasIjsepFOz8hOQD4e
 sItk+5A7GJMRN5jteRmYHUhz8EkUcXZxyd2syB4kxuqBjFb7s0PXoW6Yew6n7osSUU
 WVoYKKxAFPExUKzBDB60RsLhncXXKaVDjrxpFNKflCwFpYV11zwsfOzDYEyNrAIe4l
 p2Dvq18P62OlfUIm0C1XejDU=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47788165c97so13325425e9.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763130593; x=1763735393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4PQFg1ie2DAW2KcqJCqA5zU1u8kdtHq2XCZwz7CukY=;
 b=qpdTGAgjG0/SLR75QVdtnZjzxe7LMrKkYq6NPaCoOS4zVwpgZKV7y7bny0stf8Xxbs
 U6SxDgOvCV0rfWqVW/cfSaUAxsRUiYLeu5duTcZeZYIWtXSxyndmqHP36NSLRBKeaDLx
 DuXK4cKMKN7H2LbnMuKBfIKQKuqxcNODHC85e9r3bLTflt4MC31Ii0r6zxsaR7E67EnG
 F7BzFCEG5ivQfVG+eyDYGL28o+u3icVkn823r2a0aZC2V3Hw4yjDP14UoDnX4ymX1yf+
 O0c8Hah/ey7+XgJ2i9ve2CGYAjqOdaJFjdLiIORZplgTA2rJF2/P8vFtImCRlY+ap5Mp
 Wvxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuQ7KV5wmiPuYHBkOSvpk3IcTeoCvCMHq4xak34b09B9spVh8ewoXfEMRREqwZJpYTjTkIrGM=@lists.denx.de
X-Gm-Message-State: AOJu0YzU/KkBkKgEnmxZoHyf7Akw/SPlCT8SlPUAZUjYOYSZdn8cwEtG
 czQdA0BHitS38vbF5ol/pIJzKaGbiYwnLFGxj/+Xc7vp04g3WPAspEuGU7AdUdQtLtjH7qXBLBy
 6mMdmT0BMSXDbmQmnkJDUVo43hOSh2NAoOGJ4xWGULRp/8HYuLVXVof/x6649FfakULSZ5A4=
X-Gm-Gg: ASbGnctaAp5m5c5O38i9nQqehBZqMpInGU9jUufDXYYa7mRv0cQdFcepwGUq8onbedV
 K/NmHNqxUGKNUw8txK1o49GySPlrFdnXzkmHO6YMood9FOsoUVBtX5Clus2AavMVEPoQhbexoax
 dLbVp+YFPYOzrDSG+qh4kAMBHnKB5ZyQuzBQUb7M0oozUX8L/j1FTi+UuuUaiATYOJ5NYv4YEil
 fX7eecIhUGJhlZUPA47jXCbwc8O0JhLANpGZVf2jqbKEPY57YaTEUWJbwZzgOEG8OfkCi413n+S
 m+TppQAF8KVlZDgFN6bLAZbgziF4lPsbBwsrsWS32xL8C8zERYASiq6VLiZwEpEiB37eG+BoGr2
 Si3r9WuYJnxdQ4BStAYpaBktsavPwsNK0JoAlgUmW9/y8pAZdHueT86/w1bGAkjxOdH2IJpAa
X-Received: by 2002:a05:600c:a44:b0:477:5aaa:57a6 with SMTP id
 5b1f17b1804b1-4778fe69cb3mr34469845e9.10.1763130593576; 
 Fri, 14 Nov 2025 06:29:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtFKLR7UN2iyKjN/l9mgMjPac0a+dQpHpS02rE0s0HaAFhgds3a5yl/xwVEW2DyeItoYDSLw==
X-Received: by 2002:a05:600c:a44:b0:477:5aaa:57a6 with SMTP id
 5b1f17b1804b1-4778fe69cb3mr34469305e9.10.1763130593085; 
 Fri, 14 Nov 2025 06:29:53 -0800 (PST)
Received: from [192.168.103.118]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bcfa2e9sm45639325e9.12.2025.11.14.06.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 06:29:52 -0800 (PST)
Message-ID: <986f59b2-6cf2-4195-ba1f-4249428b9009@canonical.com>
Date: Fri, 14 Nov 2025 15:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
 <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiHVqgn5eox3p7CWt0=XjAcYMBjR7F03UqweRftZg5fDg@mail.gmail.com>
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

On 11/14/25 13:31, Simon Glass wrote:
> Hi Heinrich,
> 
> On Sun, 9 Nov 2025 at 03:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The location of memory depends on the board. Do not assume memory at fixed
>> memory locations. Use memalign() instead to allocate a buffer.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   test/cmd/fdt.c      |  8 ++++++--
>>   test/common/print.c | 37 ++++++++++++++++---------------------
>>   2 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
>> index b950123b6da..4c3c6308ab4 100644
>> --- a/test/cmd/fdt.c
>> +++ b/test/cmd/fdt.c
>> @@ -265,7 +265,7 @@ FDT_TEST(fdt_test_addr_resize, UTF_CONSOLE);
>>   static int fdt_test_move(struct unit_test_state *uts)
>>   {
>>          char fdt[256];
>> -       ulong addr, newaddr = 0x10000;
>> +       ulong addr, newaddr;
>>          const int size = sizeof(fdt);
>>          uint32_t ts;
>>          void *buf;
>> @@ -275,8 +275,10 @@ static int fdt_test_move(struct unit_test_state *uts)
>>          ts = fdt_totalsize(fdt);
>>
>>          /* Moved target DT location */
>> -       buf = map_sysmem(newaddr, size);
>> +       buf = memalign(8, size);
>> +       ut_assertnonnull(buf);
>>          memset(buf, 0, size);
>> +       newaddr = map_to_sysmem(buf);
>>
>>          /* Test moving the working FDT to a new location */
>>          ut_assertok(run_commandf("fdt move %08lx %08lx %x", addr, newaddr, ts));
>> @@ -288,6 +290,8 @@ static int fdt_test_move(struct unit_test_state *uts)
>>          ut_assert_nextline("Total of %d byte(s) were the same", ts);
>>          ut_assert_console_end();
>>
>> +       free(buf);
>> +
>>          return 0;
>>   }
>>   FDT_TEST(fdt_test_move, UTF_CONSOLE);
>> diff --git a/test/common/print.c b/test/common/print.c
>> index 2ac7eeed2c1..f33476a36b4 100644
>> --- a/test/common/print.c
>> +++ b/test/common/print.c
>> @@ -266,74 +266,70 @@ static int print_do_hex_dump(struct unit_test_state *uts)
>>   {
>>          u8 *buf;
>>          int i;
>> +       ulong addr;
>>
>>          buf = calloc(1, BUF_SIZE);
>>          ut_assertnonnull(buf);
>> +       addr = map_to_sysmem(buf);
>>          for (i = 0; i < 0x11; i++)
>>                  buf[i] = i * 0x11;
>>
>>          /* bytes */
>>          print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
>>          ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_nextline("%0*lx: 10 00                                            ..",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x10UL);
>> +                          addr + 0x10UL);
>>          ut_assert_console_end();
>>
>>          /* line length */
>>          print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
>>          ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x8UL);
>> +                          addr + 0x8UL);
>>          ut_assert_nextline("%0*lx: 10 00                    ..",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x10UL);
>> +                          addr + 0x10UL);
>>          ut_assert_console_end();
>>
>>          /* long line */
>>          buf[0x41] = 0x41;
>>          print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true);
>>          ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_nextline("%0*lx: 00 41                                                                                                                                                                                            .A",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x40UL);
>> +                          addr + 0x40UL);
>>          ut_assert_console_end();
>>
>>          /* 16-bit */
>>          print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
>>          ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_nextline("%0*lx: 0010                                     ..",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x10UL);
>> +                          addr + 0x10UL);
>>          ut_assert_console_end();
>>
>>          /* 32-bit */
>>          print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
>>          ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_nextline("%0*lx: 00000010                             ....",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x10UL);
>> +                          addr + 0x10UL);
>>          ut_assert_console_end();
>>
>>          /* 64-bit */
>>          print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
>>          ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_nextline("%0*lx: 0000000000000010                   ........",
>>                             IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf + 0x10UL);
>> +                          addr + 0x10UL);
>>          ut_assert_console_end();
>>
>>          /* ASCII */
>> @@ -345,8 +341,7 @@ static int print_do_hex_dump(struct unit_test_state *uts)
>>          buf[8] = 255;
>>          print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
>>          ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....",
>> -                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
>> -                          (uintptr_t)buf);
>> +                          IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
>>          ut_assert_console_end();
>>          free(buf);
>>
>> --
>> 2.51.0
>>
> 
> This is adding memory allocations to a test for hex dumping.
> 
> It would be better and simpler to use a fixed address and make this a
> sandbox-only test. I struggle to see the value of running these sorts
> of tests under QEMU?

I cannot see any added value in restricting a test such that it can only 
be run on the sandbox.

My expectation is that tests should be executable on any platform be it 
a physical board or a virtual machine. There are few use cases for the 
sandbox in real life.

Best regards

Heinrich
