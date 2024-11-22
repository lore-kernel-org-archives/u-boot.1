Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1A1D75E53
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C75F89866;
	Fri, 22 Nov 2024 15:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RODelVlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE2DD89854; Fri, 22 Nov 2024 15:05:53 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB67F8984F
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 15:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-432d9b8558aso18894595e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 06:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732284349; x=1732889149;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=beVIiuUQ+DN5VKG3eGdqO9U7RBO1N9prvMTA71R/SYw=;
 b=RODelVlJPrqu5uVN7DzbcUSLtCJ2dpksrPRYRyo8DeDNjAgqGNkR709wg75minj5s+
 MHkZntL+elloS9QxAF8x/q/+paK9VRS0dufW4GUHGlxL4ESa7ZIVehM+JRwxP5TEA0GN
 qlayWzHwVPJyRbXwOhOm+aVch1DSJDRHK7S/lco5iaHdJFr/uWSPpikivLmz7TJt8p+Q
 tq6uJ2yB9OWewg7shuJA0IO3tAq51mTSGVF84SCBc3WcWfMyYUzySrbqG6LAyjeGmsdG
 6cMKic4t0ubHDRKcKv8xcvI2YDwB1mAlWlsfqWDcpY0WZhd9rUe8ix2r0wfQFGNauAZb
 262w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732284349; x=1732889149;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=beVIiuUQ+DN5VKG3eGdqO9U7RBO1N9prvMTA71R/SYw=;
 b=G7VYq9038U2amSVT5++amS/Ydc0Y7MHXub68dkP6pnl9C7TDfnL0nQoSGElGJtInna
 NKTjVzgsupLxd0rPAtXQf+JvtBEJs2UTK3+q1lJCxusfOEFjuhJmWTdsUrQBYAT6H8E4
 7hsOaX5OoIA88NFHPlXSC1vV/TugsKNoa3F+XBsVLhthMRvGzNetgiXPVVj2kS7d8ox0
 pQy9ErqmzmhyZDCWiJ2YaH/6n8KDatOAYiH1VcvKzcuQ/0KrpRIQKz8/hhFOuDXGzTX9
 LfbZstTTNyGgWWTUtY/9KV+ev9fs20QWPJh8oJFPp/uNRaQ+XL7efGT9PxOxYSkMGZrO
 q7mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+zor9OPqFtRNrNfSpRLtSfMcEgFPpfang7BUgnHZQQQYslMGHaHebCsCVWnRZ0vOCP+UNxgU=@lists.denx.de
X-Gm-Message-State: AOJu0YyaIMtBx+7Y9KYZOsOvz0st9E5bJlhTp2s6JjS2CQcJfUauO2x8
 nN884ymDDZHBwbpOdcAfp1PYisG76TOCfeOKF/RqrcgM33/dMRi0vfwCig7O/jM=
X-Gm-Gg: ASbGnctLN7hUp5NXMzTjqHPR/NH8v8oMB+RsgcDkx5xwfGrqIpFubd5vlASSAMcx5BI
 6G7oWL/JfXL3YJz2LMKxoDuLuClWbjlLl8Pq7xB59lnrrTYdBCOzsHUMezvQxK4oPEBZVbIWuFf
 /bgHvt/ytDohSmHA1sPNAE5J4OB30iMtD28VZ65z9VckIsNbovCOZ763Kh2sY/D8hDg2wSOCr+T
 Hi9nPi60iqneCUowVjANSQn48oxyzKWoI+24zZVwdnhGHlYxLwbWixrHUo=
X-Google-Smtp-Source: AGHT+IHG90AX3D3pPByAqhxEzUjc5duBqiwFcy1ne1OZz4U6aAEX62JyIE20C8m7PRKcI18v1VUXug==
X-Received: by 2002:a05:600c:a0b:b0:431:4a82:97f2 with SMTP id
 5b1f17b1804b1-433c5c95780mr64975225e9.6.1732284342305; 
 Fri, 22 Nov 2024 06:05:42 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde97ed4sm28309825e9.39.2024.11.22.06.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 06:05:40 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: boot: Bind bootmeth_{cros,
 android} only once per run
In-Reply-To: <CAFLszTjvoOSD+yADG9Oin__tKLs_W-TEkpZ3DPhtRCB4YxmhzQ@mail.gmail.com>
References: <20241121-bootstd-test-fix-multiple-bind-v1-1-f6c06b9581b1@baylibre.com>
 <CAFLszTjvoOSD+yADG9Oin__tKLs_W-TEkpZ3DPhtRCB4YxmhzQ@mail.gmail.com>
Date: Fri, 22 Nov 2024 15:05:39 +0100
Message-ID: <8734jjcqj0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

On ven., nov. 22, 2024 at 06:37, Simon Glass <sjg@chromium.org> wrote:

> Hi Mattijs,
>
> On Thu, 21 Nov 2024 at 08:03, Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> We make fewer calls to dm_test_restore() since
>> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
>>
>> Because of this some valid test combinations are now broken:
>>
>> $ ./test/py/test.py --bd sandbox --build -k test_ut
>> $ ./test/py/test.py --bd sandbox --build -k "bootflow_android or bootflow_cros"
>>
>> Shows:
>>
>>   Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4       ',
>>   got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2       '
>>
>> Here prep_mmc_bootdev() is called twice and it will bind bootmeth_cros twice.
>>
>> Since bootmeth_cros is bound twice, 'bootflow scan' will find 2x the
>> expected bootflows.
>>
>> Before
>> commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
>> this did not happen because a cleanup was called each time.
>>
>> Check if the bootstd already has a "cros" or "android" driver and only bind it
>> if it does not exist.
>>
>> Fixes: fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> Initially, this was found when merging some Android bootflow patches
>> from [1].
>>
>> However, this can be reproduced on 'next' as well.
>>
>> Here is the test output that's broken (we have 4 cros bootmethods instead of 2)
>>
>> => ut bootstd bootflow_cros
>> Test: bootflow_cros: bootflow.c
>> Showing all bootflows
>> Seq  Method       State   Uclass    Part  Name                      Filename
>> ---  -----------  ------  --------  ----  ------------------------ ----------------
>> 0  extlinux     ready   mmc          1  mmc1.bootdev.part_1 /extlinux/extlinux.conf
>> 1  cros         ready   mmc          2  mmc5.bootdev.part_2
>> 2  cros         ready   mmc          2  mmc5.bootdev.part_2
>> 3  cros         ready   mmc          4  mmc5.bootdev.part_4
>> 4  cros         ready   mmc          4  mmc5.bootdev.part_4
>> ---  -----------  ------  --------  ----  ------------------------ ----------------
>> (5 bootflows, 5 valid)
>> test/boot/bootflow.c:1192, bootflow_cros(): console:
>> Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4       ',
>> got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2       '
>> Test bootflow_cros failed 1 times
>>
>> [1] https://lore.kernel.org/r/all/87mshvxhq3.fsf@baylibre.com/
>> ---
>>  test/boot/bootflow.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
>> index 9397328609d0..835d2e6e35a6 100644
>> --- a/test/boot/bootflow.c
>> +++ b/test/boot/bootflow.c
>> @@ -552,15 +552,21 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>>         /* Enable the cros bootmeth if needed */
>>         if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
>>                 ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
>> -               ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
>> -                                       "cros", 0, ofnode_null(), &dev));
>> +               /* Only bind the bootmeth once to avoid duplicate scan results */
>> +               if (device_find_child_by_name(bootstd, "cros", &dev) == -ENODEV) {
>> +                       ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
>> +                                               "cros", 0, ofnode_null(), &dev));
>> +               }
>>         }
>>
>>         /* Enable the android bootmeths if needed */
>>         if (IS_ENABLED(CONFIG_BOOTMETH_ANDROID) && bind_cros_android) {
>>                 ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
>> -               ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
>> -                                       "android", 0, ofnode_null(), &dev));
>> +               /* Only bind the bootmeth once to avoid duplicate scan results */
>> +               if (device_find_child_by_name(bootstd, "android", &dev) == -ENODEV) {
>> +                       ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
>> +                                               "android", 0, ofnode_null(), &dev));
>> +               }
>>         }
>>
>>         /* Change the order to include the device */
>>
>> ---
>> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
>> change-id: 20241121-bootstd-test-fix-multiple-bind-159bd2523414
>>
>> Best regards,
>> --
>> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>
> Instead of this, could you add flags to the test to tell it to reset
> driver mode?
>
> UTF_DM | UTF_SCAN_FDT

That works as well, and seems like a cleaner approach. Thanks a lot for
the suggestion.

Will send a v2.

>
> Regards,
> Simon
