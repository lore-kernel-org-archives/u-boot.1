Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C319DCFC53F
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 23:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E61283B7E;
	Sun, 23 Nov 2025 00:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s6wYUfyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3831A83B82; Sun, 23 Nov 2025 00:53:04 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A5883B72
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 00:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9FC123F475
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763855579;
 bh=JWbgGENfrhhVrvTnAVDgxNOjE1aLrxqq85tCPAtvFKc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=s6wYUfydn2lPizEPkG4X6yKfoinZ2ETGnEkRDQGySgjQw+T8cd8pj1m4+7zauSQKS
 LO5NutnmT2+cLcmHyr2eES3uUGmO9GvFW5lSNVar0OwVDkcWfGtvLyS1QUgb8ds03g
 gay40DBYMqB2CvucQeQrd7PXkF2cvwPWoKkv302lrN+OWRIkBrA5Av9vw00INPXysP
 9bs9Bnnq6ljcmbCvd52QRMcx5dW44q+KxosCI876kk2JzCf72gHL/q8mnn34nDDoW/
 jBZ7IvUsBHeocp5705B+i/pw3yhtpFdwgMLz8IcLPy5f4PoSNPUz36SrgAynPNO1h0
 AatxK3E0BhyTo5jr1JWX2kVSiWlYs+Z7ySa4D5v/w0QWz8lUTFSM6RzRPm7GPDlAog
 TsxEYkTC0c8bq05YhF3w9gSymYV99fc4guZ9tEFKnCkzc6iwhdBihpxRn5SWQUppNS
 7NMy5x3S0spO+82pLoumouQSdvu8i9ATQq9hN8j6D72u8DC172Sd+nKcbTVlvWNOUY
 GBmCyGbj1au1ofx8fa6JJBroGxp0DnFTSdaIKTG61ljFJB5QnsrRECjlFmoUdNgHsf
 qnBn9ECARCEdRomP/a8kgN+hN7/PAssSFUnOFwdS/DbFLhNxa0N/tSHDe+MJMsLpNh
 lCydWvJFfIK4rAXrm+IEVMdc=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so26125105e9.2
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 15:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763855579; x=1764460379;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWbgGENfrhhVrvTnAVDgxNOjE1aLrxqq85tCPAtvFKc=;
 b=lvSlgpBpnGzCS6bDOyH6qJLCer41g4Eh1BbPxmS4DpqUnZT0VTDQREe91/m9VCxBLy
 D3bGZprQuq6PL9RwPlRLa0+AmUOdEvSt7gLzfWZiJ0NH9Ra0GZ+akot1VVMoLhlPRMja
 f46ppDTp6njkP8QMXQ9DauKjX6G4Crd0uZYxu2ZVO9GIXUvi2ztvmAhUyCFxnJ1yvO70
 kcZraUK2LAafKKfxKJAH9L0tvkl85LiHmOdTqXqJ+b0dVJKEnBu3bYJFyiB4qhLZlmDs
 CiIyY2yLvjoysDLv7UE0AIS9jwRMdJRYVRIwwJJeAGGYwqpm3RAmVfF92enLLuG9LHsV
 J9OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+RYHDnp6UOnagZD8VD3O/Wg7e1f+xJhpLfTCAJwbm0NTCfGvNxJG56CqGYjjVyXS4oOS6jkw=@lists.denx.de
X-Gm-Message-State: AOJu0YyjKXqPU/sN/JNOww/OYMByAXoF/46IwOBvp920kzHTq5qtuF/1
 zEK16xEhRPYvSCIfWUuMlsnag4FefiWF+uUkzxj6M+qL6/0aOqRGM7gtQxlwqNCO8sWKJy2P9IL
 j7FuNuk8DyANKS2vlOkJzreVzhbbYk3nu2SPpWYUqUvnENBdxe78NzOADVnpwbJF1HyFN5wY=
X-Gm-Gg: ASbGncvxHXldtdWSZ4mATE7gCQOFseSggustdQNm94qEx13jOgpSdyhdXwhuDIwPtqV
 R3oYvaH51Xm8Zg0KCynSZsWUiv249Vey69ZbIga9Wd/Rdqu6yAvzSBhSSnMeShRGnT00csPnTuR
 7Gnzv8CxONUgoM3zKaWuF66FYD/KD5D4FGYu7hhJ21xLrWXXx5e+f3SjC1/EgulGhTfilDqVc3q
 8nQyMzxyctbmIfyJ5kNwXsvB2HnCfSpbfmObcFevEEGjddMWe/H2lHS2FCuls/xSjDBIi+fDDLt
 CyU2twNtBQWhnfFOaEqplasYWBTX8xNmTmxBGoxeKbQQjdkVISndGp7HNRqRNrzCHNStu5oez65
 K1vWzBxXDq1c2tYhzb1K8bWy8JoLbJcbeg5/Akkh+L+kyVJDl1a6eu/o3TZCJmol4nFLaGaIMEB
 v13RPwprw=
X-Received: by 2002:a05:600c:1f8f:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-477c01ee3camr71417575e9.23.1763855579170; 
 Sat, 22 Nov 2025 15:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvyFcd5l+kSEczr6YPe49gHUcyfFVDza/6DrZnLHebcoKslIjR/9QPNUBAg2V3RSBmcoM3Zw==
X-Received: by 2002:a05:600c:1f8f:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-477c01ee3camr71417425e9.23.1763855578787; 
 Sat, 22 Nov 2025 15:52:58 -0800 (PST)
Received: from [192.168.123.154]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df392sm118383915e9.1.2025.11.22.15.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Nov 2025 15:52:57 -0800 (PST)
Message-ID: <6fa2e054-e122-44c9-99a6-5e3e096c8630@canonical.com>
Date: Sun, 23 Nov 2025 00:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
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
 <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
 <20251122162321.GA3053902@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251122162321.GA3053902@bill-the-cat>
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

On 11/22/25 17:23, Tom Rini wrote:
> On Sun, Nov 09, 2025 at 11:10:02AM +0100, Heinrich Schuchardt wrote:
> 
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
>>   	char fdt[8192], fdto[8192];
>>   	ulong addr, addro;
>>   
>> +	if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
>> +		return -EAGAIN;
>> +
>>   	/* Create base DT with __symbols__ node */
>>   	ut_assertok(fdt_create(fdt, sizeof(fdt)));
>>   	ut_assertok(fdt_finish_reservemap(fdt));
> 
> So, this is interesting. As part of merging this, I see that on
> qemu_arm64 for example:
>                 u-boot: add: 0/0, grow: 4/-4 bytes: 284/-9691 (-9407)
>                   function                                   old     new   delta
>                   print_hexdump_line                         472     556     +84
>                   fdt_test_move                              568     652     +84
>                   print_do_hex_dump                         1704    1764     +60
>                   print_display_buffer                      1736    1792     +56
>                   static.__func__                           5670    5655     -15
>                   bdinfo_test_all                           3064    2884    -180
>                   fdt_test_chosen                           1496     516    -980
>                   fdt_test_apply                            8524       8   -8516
> 
> So we're as expected shrinking fdt_test_apply with a build time
> optimization. But we've been building and running this test as can be
> seen in older pipelines and their published artifacts. Should it not
> have been a failing test? Did it fail for you somewhere or was this
> found by inspection?
> 

Hello Tom,

The target of the series was to test QFW and ACPI passthrough in the CI 
using qemu-riscv64_smode_acpi_defconfig.

fdt_test_apply and other tests failed on 
qemu-riscv64_smode_acpi_defconfig. This is why I touched the tests.

CONFIG_OF_LIBFDT_OVERLAY is not enabled on qemu_arm64_defconfig in 
origin/master. Without this setting the `fdt apply` sub-command is not 
available. So the test would not pass on this board.

But running `fdt ut` for qemu_arm64_defconfig shows:

=> ut fdt
Running 19 fdt tests
Test: addr: fdt.c
Skipping: Console recording disabled
Test: addr_resize: fdt.c
Skipping: Console recording disabled
Test: apply: fdt.c
Skipping: Console recording disabled
Test: bootcpu: fdt.c

The fdt_test_apply_test was compiled but is always skipped.

We should enable console recording on boards where we want proper testing.

Furthermore we should change test/py/tests/test_ut.py to show skipped C 
tests by calling pytest.skip(), see

[PATCH 1/1] test: Let pytest indicate skipped C unit tests
https://lore.kernel.org/u-boot/20251122234920.80114-1-xypron.glpk@gmx.de/T/#u

Best regards

Heinrich
