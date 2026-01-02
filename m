Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AFCFA374B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AFD84292;
	Fri,  2 Jan 2026 16:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hOW3DDqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F0A684295; Fri,  2 Jan 2026 16:19:04 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E928428C
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:19:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CBFAE3F5B6
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767367141;
 bh=Gg/ZrvpRDakCy50NluNdOdSCdDywc7VzEAOCM2BX56k=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hOW3DDqKqHNFFR0TH64MKcJ8VrLAsMAhysQ7odXC+BLlNAkC5wYXL/t0SC+tgmfGY
 G0xx7p7/IFnuSe9z4RXCCj/OJ9L7g38qaLmGBP7DLfwfGV7vpYCq+KE/h8fBYeNmuI
 6Di10+TvFlucoI97+Zxq6ZE0D41O2UNrRpVLJXdDigMmsZwcIoWvVrdtarwQ0GUHA0
 m0mIdT+04bzDRwN5eYgUWOuf2crDX8yvMijX7MfJnRqB0qD7DjHAHNR/kf4jNaj0yl
 H6CmElnd60mZR4L0Ho99BDvAht4HxBGbGmoP2azdVXBDklslNKsrO7AP1af1k0cnB5
 hcY2DzHBCDASzp/YWcadG9yOPJ0EuqDmaas6TE+PMZdZBnasPA+Zlsw8voN2fUqpHa
 NtZh8fpeJaFFEZKpjqhw6jSb/UBm49yLKXPofFTNGkIGCeFwyanWhrb+eqyIdDnp5T
 8i/ihKTrOZdq+UDcg+MhV+Lq6KnzUR2qNlnepH6gfhmYt1IgqCdEHQcK2+tXou59eh
 5YELynMfN2Vtk1ff1TzbaLd+qvxIKShptBhtSEEMUwaeKfcAWl63RfI6VQhnh9hfgm
 clE4oEsHyEeFR3Iaei2g79PWRRQenLIhj+nn/sx9zxmAXjmCzCF9Q0WzqosI3dKy/j
 JLoI7UeuwOeJJneTqRacwb+4=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso4586317f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767367141; x=1767971941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gg/ZrvpRDakCy50NluNdOdSCdDywc7VzEAOCM2BX56k=;
 b=kU/nWxVC4V3GwDoRaGXsMULmTbjP0W4zzT7//VdScSgTwA51o8+kPCfWPO1LsyDy86
 /yMXhaZB/5N7IEfK8PQQinTTDjSQw90oSuQuEdtzRPsgqbuf8m+Sa48uLgS+0d0/s0ID
 MFMPsrpjUMq7gKIYpe7HGyPFn6bC3CmdA0CJIXgNvpvPyQm7B0pPNOHor6NCSm45Yl1T
 rJVDH1vKmUfFKbYsfD1dGvL8ag0DlRGdPlNvAueYaoWtDQTBmc1tPCk25uQlj57rCpLm
 Gc9Y0yMkUWT80pcPRrtiAE33NzsVVoETZb9/JtcJchPjFIONeuEMYRYrunEyEWJ2RG6v
 pMBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUowACAEF3Jic0T4BGZ1DVJ9oTIRQJsmU+D/b7yhW5DnC14h1bi+nvRRnR1M9Cn2bJ2v5kUMxI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy16qBOPCUGKfl3h/xxRyTd99LTRjv++7PTBM5zgT1GEs2ZPJTK
 iv36SMYbL0FtyvUTRmmnsvemJQznj9K3eLBet4vNYuCD0jbkllYpGJTN1RPIjgudoYcc0bXgynx
 f/9Sv80hQx89QfuM+NggsPUcb9me+PCGARBbhczWLXsSclA+PoquC5123vp0W3xRAslC/Y1s=
X-Gm-Gg: AY/fxX5Jsc6IoxCrKIGgWZnqgSocftyFtj2HuH1UmMWe9xq3Vu+LJjH4lEg5hfaIo2e
 Ztt+OgDSKpg97GdOtV9l2IhCQrGyzxz2jSUxmG4COH1ccqtn5kBdpeFYTm7KGAq34DBFkZ7xMoh
 sWofFSrp4x69HkWdbykd1qFThz4G9fuF2e4NJwKTPoJCHcx2tbfJfgVXeWUbQ3iWFK+lphD8iF+
 JeBkc23whzYFg55W9cIVUSCPPgOvqwDgbJF9FyF4YzLdoa8CMNxafrinTX1dhC3kev6bkcdthBV
 OQ1MLOfFNQcCq/CYx3Ww/9w9R+Vsahko3zxsqYiXJGOn5aTjZfe3QxvyiJi/XeQBvc6/yIVYwTx
 EHp07xuBPkoSh8Xlu4o3hE1ZvDN6bdrfe9vuZKnK0PAGCiGXcGpMaPwJbxHwBWkpu1f4i31AnR0
 +ouW3/4dU=
X-Received: by 2002:a05:6000:2c0a:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-4324e4cbcafmr58903987f8f.14.1767367141373; 
 Fri, 02 Jan 2026 07:19:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN32fq/kpRAb/lsr88jcB6DWuH2it88pEN0aUrkU/bEo7p/czRtG0UhMRQmtsD96xOq8cgyw==
X-Received: by 2002:a05:6000:2c0a:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-4324e4cbcafmr58903952f8f.14.1767367141013; 
 Fri, 02 Jan 2026 07:19:01 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab2721sm84673780f8f.39.2026.01.02.07.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:19:00 -0800 (PST)
Message-ID: <7befea69-0f45-4d7c-88e2-04450563cc29@canonical.com>
Date: Fri, 2 Jan 2026 16:18:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] test: do not imply os_malloc() outside of the sandbox
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-3-heinrich.schuchardt@canonical.com>
 <CAFLszTinaB_wvQKijgW=CvP8Qz5dgjOv0ykGrSfEpUG3Jjevtw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTinaB_wvQKijgW=CvP8Qz5dgjOv0ykGrSfEpUG3Jjevtw@mail.gmail.com>
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

On 1/2/26 13:29, Simon Glass wrote:
> Hi Heinrich,
> 
> On Wed, 31 Dec 2025 at 12:11, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y the C compiler does not
>> execute all optimization paths and add a reference to os_malloc().
>>
>> Remove the reference if CONFIG_SANDBOX=n using #ifdef.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   test/test-main.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/test/test-main.c b/test/test-main.c
>> index 3254325e8b1..1815d60acf7 100644
>> --- a/test/test-main.c
>> +++ b/test/test-main.c
>> @@ -734,6 +734,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
>>
>>          uts->of_root = gd_of_root();
>>          uts->runs_per_test = runs_per_test;
>> +#ifdef CONFIG_SANDBOX
>>          if (fdt_action() == FDTCHK_COPY && gd->fdt_blob) {
>>                  uts->fdt_size = fdt_totalsize(gd->fdt_blob);
>>                  uts->fdt_copy = os_malloc(uts->fdt_size);
>> @@ -743,6 +744,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
>>                  }
>>                  memcpy(uts->fdt_copy, gd->fdt_blob, uts->fdt_size);
>>          }
>> +#endif
>>          uts->force_run = force_run;
>>          ret = ut_run_tests(uts, prefix, tests, count, select_name,
>>                             test_insert);
>> --
>> 2.51.0
>>
> 
> Oddly I hit this same problem some months back but I didn't end up
> needing to patch it.
> 
> Which board are you building here and which toolchain?

I am on Ubuntu 26.04 (gcc 15.2.0-7ubuntu1) and the board was 
qemu-riscv64_smode_defconfig.

Best regards

Heinrich
