Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4E7CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 21:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F199C83B8C;
	Tue, 11 Nov 2025 22:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QmsPlf3G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5688183BB2; Tue, 11 Nov 2025 22:13:06 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A0283B8A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 22:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E34F13F6A0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762895583;
 bh=ln4EZaNbZZrkU76B/EPgDJH7dM1v1zJa9+HmHJbBDts=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=QmsPlf3G4YVJ/0mPQ41/TjhD3FhMKUFUyPvyrtXeYbmDRfR6qc9D9J8U1nri2X83a
 DhTXgJk3/swaiQ0AciB1Z23ghcSnXgobqNWRfELbxC2eG19ZuwdVWxN7/2T3ONCdH3
 fJtV8YmorZokYfgICHlJuTBWNXAMLluNG5bR6fmNlTBqP/6PyIhBKZ9J0+3nrQwumu
 QoeXUq9tA+ohiOlyGChTqrOiytldjoA+Pj9BP1p1bU4YEJp3rGD1k95xwF3jD+npre
 iMLQmgngAmB9reKHMOPu8RdGlGUubZWDwudBfaOg/dEccabB2o9Lma4lvSCsgv/lJ8
 9PL3uAMXPftfvrMeIA3wPU/K60ylaztXnxr+Pi/HL9tFPmL1lsZ//221wMmOqlljzn
 NanQWU9FKohqHxyBg34lYYLLEsMHi1Cl12sbokg+i7g85VQNIDJwaoPKuYsRlGyaoH
 vS3MAiW3s7qo+7Xd170revzEd/eQwOEzJSlme74ZP2v0wLxAZjA4qeU1Pejbzikeey
 bu2ogIjD9eZ6vGzWQoMoJe3VV4Bsk3KR8JPuPQrarW+fdhgnTZyFaPBxXzh5NGrTGO
 qZHBds0ubAOmQGTIOwL5QTW6VGGzXPvQyfNucqhdIMwisw5D+JdATKJHihMifVHcln
 S/so0kgIBw0BspMmA3mgwuQQ=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c5da68e5so36199f8f.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762895583; x=1763500383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ln4EZaNbZZrkU76B/EPgDJH7dM1v1zJa9+HmHJbBDts=;
 b=B5fevPoe37CEsOjh1+6bFPniR6YJg8S9naoFnNIc+r4odU/QbZyHieIG1A/47HxXjh
 HGOpNFF3u/8AT74iSsbGFaOc+dMNksRgBYoot9ekMJLpWi3qlqk/hnm3EmTOUVlAIp5o
 cJHd8ovmKD8Uy4oxrtEKt96maks/qI/nQNnRTeKemeUojwM+fbDoLbQGXsW3XdyFGVjW
 38YAVpE3PDfSNigz/CSyfjY1NP/fISI6diPjC9roNK7lRZ72qLH+DD+Nk1lsGiytkWaa
 4SsQIJGIoPl9cG4JqzGZug1q1QbjarpqRzUrTxwjXrihVBiKf/Heh5ZcJn61K299ODrE
 6+zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmjW0PROY1nkEi34ROmTyYw0cDi3xSwyqWBDFX4dUYj+uQ2nEdr2X3Hc0hQ/nAuSuzIaDTQVI=@lists.denx.de
X-Gm-Message-State: AOJu0YzTWd3xsE+IX/n9zREJjBPcXBgrC3AYSxpWib/VpuLEquY8+BaM
 vH7/XVo9ZZ6lXLNT3yDTQH+bBUi6SlCxoAdvPDry6sJGanY4eIAfUZdAOhJdEWvlxmZY2Q7ZM+V
 dGmpj97GVFPRCfjAn8Sr0PSI4zjddB27zT/RMPrJpN4AYqvPvW1N2Am/MF6pd9uVaG5KmNTA=
X-Gm-Gg: ASbGncvNThEjKRtHAZLBtnbOrQGZie8+/T970KzJJZpFx0/WEb89eLALIvJPf4npbRL
 LsKjr2LcF7HcHhq1NNb/o2HjNYw5HACVm7+/qoQR0LsQSz++yG2kRS/dO5dDGQZrj7rPBxT5lBo
 ncpOHcD2QZ8HpctDNV5Xhgseg1/TSxASBflQ9cv6eAiTU5t/oX8QvHHwhnPlVxAHehw5Y4m/yqX
 oCRAm40apGSCsRaEOQs5PRGfcf6zg+zwwhh68dvEgNnHQ2uQeD4mHEJuI1fkbdPENfwB4rfdpRr
 YF8bQQNHPXqwiyfPY205juWU9dL8Q3RiUYC+Ff/XpShTMULGgXw4UDxlBBbbkRvUwCIirPmsadk
 bJz45/xvf9Ep9wJPtznqwQ936j6wAAzg7JtSJ5us2X4Kb6y13EvtnJaAkThihHigLpFl0M7MX
X-Received: by 2002:a05:6000:4008:b0:428:56ed:c68e with SMTP id
 ffacd0b85a97d-42b432b1c9cmr4676302f8f.9.1762895582878; 
 Tue, 11 Nov 2025 13:13:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEFJ7buEKsE0ydut/0D73L+O0rIHgclnl9ReliD1H1CPKh9rvlt4BoM0VsWRtNvhg/4gX0rw==
X-Received: by 2002:a05:6000:4008:b0:428:56ed:c68e with SMTP id
 ffacd0b85a97d-42b432b1c9cmr4676276f8f.9.1762895582496; 
 Tue, 11 Nov 2025 13:13:02 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b2b08a91esm24295788f8f.2.2025.11.11.13.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 13:13:01 -0800 (PST)
Message-ID: <b02be747-1843-4688-acf4-690366493635@canonical.com>
Date: Tue, 11 Nov 2025 22:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>,
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
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
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

On 11/11/25 09:29, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERLAY
>> is enabled.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   test/cmd/fdt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
>> index 96a8488e172..a36f2dcdda8 100644
>> --- a/test/cmd/fdt.c
>> +++ b/test/cmd/fdt.c
>> @@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_state *uts)
>>          char fdt[8192], fdto[8192];
>>          ulong addr, addro;
>>
>> +       if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
>> +               return -EAGAIN;
> 
> The asserts return CMD_RET_FAILURE on failures. Should't we use the same here?

There is nothing wrong in CONFIG_OF_LIBFDT_OVERLAY=n. This is not a failure.

-EAGAIN signals a skipped test.
Look for EAGAIN in test/test-main.c.

We should describe this in doc/develop/tests_writing.rst.

Best regards

Heinrich

> 
>> +
>>          /* Create base DT with __symbols__ node */
>>          ut_assertok(fdt_create(fdt, sizeof(fdt)));
>>          ut_assertok(fdt_finish_reservemap(fdt));
>> --
>> 2.51.0
>>
> 
> Regards
> /Ilias

