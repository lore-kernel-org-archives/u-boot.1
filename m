Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664E3CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 21:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CF083BB5;
	Tue, 11 Nov 2025 22:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="F5rBjGAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC4783BBE; Tue, 11 Nov 2025 22:18:57 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4275F83B8C
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 22:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 433FA3F7D1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762895925;
 bh=6SgaDKCW0p7stY3O0ET8GoQDiHMxMV02b+wZ2oGxmDU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=F5rBjGAi6JZoXasKAfyOnygYYFg7W42brGNI4Gwgh2NGxd0zzqnSBrqR6Vsd01WYT
 WJy1OPQjZMQd3kR0Ko9TxFFjpuCrBxoWlwZB4xOcHS1y7NbvB/5O+D4wJ6yYHOm0fz
 bl7lZePb7P605pKJv4rvOVtw/gd3DJXF6wzvlogLvtLSEy4fLyEUUJf5Yt6ZAtfI/U
 pLOkYC/68XLIUhxcsd2Gndu4hOisnqHyG85fXn7P17lk9A8xmHTHBK6AbjLjnRyRaB
 Qc0Gvrl3cCCqpfy80Wtw8eSRzh9Y1ejSAfndKqq+dAifdExWXRRLleqFEM+GyPAEHO
 BreoOXONri/1+7V9XdH3TLAc02xH2FVMXiLlfk8jWB9K3xrJTHsyP/v1sAb27DX14U
 ie6NTtNcK6Q7ZvOtIWQa3c18kocTNBupZT/M3z92OlSCf4xNqfWcandAxqTkx8An+z
 Nzxpmyjyp6HN38X4PIWB60+vm6tkMgHi28LvteXFVH121RNqo6kshxTOv3X+fyYQhl
 bTBpo+2MCETq09MtrhJ72L2s9j4ylLSXoP0FrF5ESJkHhpQd6KUl2EApKN18/kaO4l
 b0lrtpcYRU3v+XopS+CDjdDdC/cl0uwLq3bSpw1lRJbzpO/RSttHuwFsPgShxUtz6q
 Ah+mWXzpgraCwhlzGPHMoLU4=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so713905e9.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762895925; x=1763500725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6SgaDKCW0p7stY3O0ET8GoQDiHMxMV02b+wZ2oGxmDU=;
 b=S4lqpbEp26wV5F5xMTkcFsMaxkhwingSbAJXy+zmEQhXGURIfarJNqrP81N2Gvw8YP
 DJ2sKoLIm+vzMfr6nRArDVOmkzsodJmJVdI9dgQ9TMw6DZnjxCikxniaPuom3zRUZ00L
 MR+k/7DdfGydB1uxew0xMSzttpb2BWV81KIFU2iypsAVMKGaxkW9XbHadaVyUtE/RaPC
 WOuxzoW7vDjpY8/lx/z8yLEEoPsIpYxPcEe9Km3r74F6NvdfRSjN1PoZ7nXfLbIvSW0k
 pru7WhO5RNebCX6nkEHsEVAZ5Bd2MH+QbLJ85v1BkBvlVKivEbFOI7W0Ym+aU0CNLW63
 wAag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEzvptQtuW13JHTWGIf8YYJqgQ1o+MjL7HvkQJrORk4vE3uSPvsTVpCPZETOlIDEKhshi+Rzw=@lists.denx.de
X-Gm-Message-State: AOJu0YyDZvrK3eTmaBWPqyR05+FBK4xq1gTAJe/jO/rMTF0vPDnloIvt
 FCWv7UJKXvjfEazvcLv7mO+Tkn1TowhoFTWYpZNzgB1W1QawdZYCA/W0LwmJ9POpzRGkwcvcgKc
 V0XtsmaJJ6AfFfNEDW6VyICIXXQ017YGy94Gfa0PwiV2wnhbKlZffJqMTpQ185cyBvHiYFUk=
X-Gm-Gg: ASbGncueJsigRv4wxH1t1XrcMLixHS2O6dBXK7Q7jdgdtzZezQrXOIbeHc5P7XtoPgo
 ZTgBvf+QPUHCafxgRLr43LqlPjKaMs540n15wMyfmiEiDFioK8oScjrbQhkIU2p9ZD4sQ8tpc6R
 LGaydRhxhD9Gx3q7QVbVGSAL7vfcfJ6B2Q9KBFVr1haR4u5yHj/Jtw5O6w5/hGqcAsU7YqtpD8B
 yjOLBqarYDVkyrxhMrFUnzMwmM0pw/7tsbrBJ7RkZXXes6wTdVdiz/1ajZbpDnbGpPZRPaXXqDP
 vLDdBGzaRVFM7zI3ti10Q1Kz792N98DcJqpbySBv5dz8H/iZgsH2EIzWklwcpuf72b5yCo3flAC
 zZz+WhlKHmcNLhvINn/5FqC6ke9ONoQFCfzYGceAg5FpgYfZSlixLAYC5YiKifnCqAIL4KoU4
X-Received: by 2002:a05:600c:1d0a:b0:46e:32f7:98fc with SMTP id
 5b1f17b1804b1-477870962bemr6596325e9.21.1762895924799; 
 Tue, 11 Nov 2025 13:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETOcTg+QYIPq0Ro2K0sDS3V11YIH8rLreUZWpv9VdFufxUUnlQI0OzSDaAMsj8sSlXTOG5Vw==
X-Received: by 2002:a05:600c:1d0a:b0:46e:32f7:98fc with SMTP id
 5b1f17b1804b1-477870962bemr6596095e9.21.1762895924378; 
 Tue, 11 Nov 2025 13:18:44 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679607esm29649293f8f.43.2025.11.11.13.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Nov 2025 13:18:43 -0800 (PST)
Message-ID: <7247453e-e164-4d96-936e-a3fa5b61cae6@canonical.com>
Date: Tue, 11 Nov 2025 22:18:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Adriano Cordova <adrianox@gmail.com>, Harrison Mutai
 <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
 <CAC_iWjK_SUEZsEzT3zb2BK-dwcXdp1gZoU880Wc1efSPAzftMw@mail.gmail.com>
 <20251111133205.GR6688@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251111133205.GR6688@bill-the-cat>
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

On 11/11/25 14:32, Tom Rini wrote:
> On Tue, Nov 11, 2025 at 10:29:23AM +0200, Ilias Apalodimas wrote:
>> Hi Heinrich
>>
>> On Sun, 9 Nov 2025 at 12:10, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERLAY
>>> is enabled.
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>>   test/cmd/fdt.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
>>> index 96a8488e172..a36f2dcdda8 100644
>>> --- a/test/cmd/fdt.c
>>> +++ b/test/cmd/fdt.c
>>> @@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_state *uts)
>>>          char fdt[8192], fdto[8192];
>>>          ulong addr, addro;
>>>
>>> +       if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
>>> +               return -EAGAIN;
>>
>> The asserts return CMD_RET_FAILURE on failures. Should't we use the same here?
>>
>>> +
>>>          /* Create base DT with __symbols__ node */
>>>          ut_assertok(fdt_create(fdt, sizeof(fdt)));
>>>          ut_assertok(fdt_finish_reservemap(fdt));
> 
> Or just guard the whole test if #ifdef CONFIG_OF_LIBFDT_OVERLAY ...
> #endif.
> 

-EGAIN is used for skipping in a good number of tests.
See also the usage in test/test-main.c.

Best regards

Heinrich
