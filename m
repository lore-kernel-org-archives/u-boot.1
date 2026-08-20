Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE8DC5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 169AF60805;
	Thu, 20 Aug 2026 12:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwCYTDiALGph; Thu, 20 Aug 2026 12:13:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787228000;
	bh=plikTJH4U7ZC8Tdq3H32HBek8Nhx3Jw/pgBS12m1dtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JnFuzp8lNf8MBW7AauWshRBcCm1St3CkxETY0RuyQbqI/ZeRV1ihIozX0CBY+9ghO
	 Ofg/MfsLY6hakzblxirsmAcjaQOsb+HOIf1VgKCN8ByXb9Gvynmj285pIX8tuzcLce
	 WywiG7T68SPs9ykw3Tbfj3QB6RXSkdcERICUbC7oVT/TjJpj6HZU/+RYsJ3WiGqwDn
	 V4hWZi2au1eqbJt7j7tEyBzBlG6xfV3BZRHCNRgAYzCX7TEr4p1FwgeDCJLaDVQ5i0
	 OVNeHUNEzzJ/tTVs7nz3gpT0/uJ3a1HWXTJsvqKLzVO5ua0FBrRH8UXGtZDx+pylvz
	 hJ6n7bjrtd0Uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C14D160794;
	Thu, 20 Aug 2026 12:13:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0410C23F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAA27405F5
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgrmlGWh_Jl6 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:13:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=IHIiLMJm
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 522EE405F2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:13:17 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so2625001a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787227996; cv=none;
 d=google.com; s=arc-20260327;
 b=GsuhjQVfZ6h7B3ypNxhGuoE7xlvd3rzvix+Z1So+F9D1NkcokXk3Cr1mPMdqHtJ4pQ
 c0CeCCys5w4l5F1xbs1GMY02IYZVXeHt3L6ibqPG8LifrjPLWRfBdzJ71PoSsPFTCVV+
 IF5t5mHxSFq2WM+2jemezDQsv3nsDzNWXETVxA4jlR3sFKtCrLZ7Ktb2m94tCuqIfqRg
 owL/rWE9XKotVGIvjMD5FuKax99IIZiLwL4/eKKprRkYfLWk8Dkr7monqepGx8FBVFPU
 jPHxKRWa4iae7o6meA8Q/yb7Z6swb2Kn3favkeAbjRVNVEyzAljCGGx/LVg4HIuySmpe
 zSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=plikTJH4U7ZC8Tdq3H32HBek8Nhx3Jw/pgBS12m1dtg=;
 fh=Bwjok4jWsPwFzEPPOJOguv26ANoKPtuv9PCfDq8ap3w=;
 b=kr8cob5CQryw9DykVJ91KyscjLKumJX+25uA2i52ERnS5XeifH6QbNpuOZMOOvZXml
 HEQdXl7vZbLHaZ0dVV37XvMLWyNhySrRp2faU0j6fqI/Q0B/pu8ff+GhbOgdJGRfreS1
 sIVIsvdZMQg1xQiQ5yZR/YqRUioFk3RTpsFUjrfumgMbDlc5VzlTEODqVlantDro/Zb+
 J1HoiFrUK+YaSK0kTH3Iy/YbIPzsAA4jbvZocQAVrdcCohhlBRoM2e5LGtwZv+5H2+tM
 50GAnc6WQrTddgb6LjlwjqjWvlJ6IH69/Js0VXj95LyMd5sIQdR4TjK2DJ/2xNM02YJs
 hmsw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787227996; x=1787832796;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=plikTJH4U7ZC8Tdq3H32HBek8Nhx3Jw/pgBS12m1dtg=;
 b=IHIiLMJmMLwbryVWJDy+VN6FMy/WdvwyIMxkbkIyTH3c29sQYOea3Unz2UyB9cJ8ul
 KH8OYfBvVr6d5RX9eeotdZh5knuO4K24nGEWCz5ze32EPe3AYbBhHtK60K5vqc1Q85aX
 UsIhQ5YiesRTbNda1veqt66mtuU4mChei4EEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787227996; x=1787832796;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=plikTJH4U7ZC8Tdq3H32HBek8Nhx3Jw/pgBS12m1dtg=;
 b=G5EWgTQhPynOtDJ3yMK+be7c/hP7BqYxX+HnVCGHxJgr/EkusJpPxpQvlVWEkl6Gkb
 1LOYeCKqzDPIX9RW19WfKuk7ZqlNRECx6FKMEzQLCjQfKyFXBmRG6VVlHWxmmFdCyfc3
 9VUqXkjdQpgXLSE3j6GUJuWWnMp6U7DsU6VTerXniZcSca1tpvje/IoK6Xl54cpVkoOk
 WY3t1XR7QB4h030SzYbGpNlF6XTppq8A8b4v9saqH5St6ILbz2XDDrwNFbxHBP7orM8V
 WOdzLBPO1DHpz4le3C8DgZJn6Nt/LX6njCz8mEk/TdV/yA9yroH6pirmqJejOVwy5snW
 n6WQ==
X-Gm-Message-State: AOJu0YwkGoC91vtQtuRgw79m9xaPE3QOFXXr3n1DgjUA+a7Rangd83+C
 W6N2M9yyBHYHUM3kzGSBoyMT+GcRWYZPU7ewJHpKWQlBXEPYm0c5KIX0gtP5zXfEusLC0SvUQs2
 ulcsHM5EL8FhKJj3RTBMnvmOmZrKBz3m3MluxT6LL
X-Gm-Gg: AR+sD10VM9k/n+pfAurrkmMaBqimPfGfKuIteOWj91aX9ev0/sPHECA1FJbpEDRxTqt
 2XIbrCtH8X3A38O8UBKeYCWDYw7qd3qO5XlXZ/VfVe2lQhi9t7HBBJfOAbzqI/ZTrE5f3i32pfV
 Fub+yKm+p9KqHcBCsHaOhoHwvJP1mfH06Hc9MHs5LQZSOJgKFedgHftPGvEbGMFue1kE3My5BnZ
 9TD3WFK1DRwgmpO96bCPc3rGbAICHY9TDvGyq6u+UsG1AA/QrIAaRrWiSWggO1B2jOOCaifcHXX
 /eGUrklEOxKntdFs5u2kdwza6uU2BOi2axmFpS1whwE=
X-Received: by 2002:a17:906:6a19:b0:c1c:4d59:2b03 with SMTP id
 a640c23a62f3a-c23e81ef391mr829158066b.3.1787227996013; Thu, 20 Aug 2026
 05:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
 <20260811-b4-reset-edl-rebootmode-v1-7-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-7-2e15adc156a3@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:12:52 -0600
X-Gm-Features: AcwNN1UL0rxfzeeuwMPilEW0gX2Uw8t3gTPNrlGL0b296E8sAidYofksBwY7IYA
Message-ID: <CAFLszTj5dD0z0cE7c8-XjfgX5dJw+PNSLG61jDXjkWyABYUJqQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] test: dm: reboot-mode: test trigger dispatch and mode
 enumeration
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Balaji,

On 2026-08-11T05:18:35, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> test: dm: reboot-mode: test trigger dispatch and mode enumeration
>
> Add a trigger-only reboot-mode backend and two device tree modes to the
> sandbox test tree, then cover the new trigger path:
>
>   - reboot_mode_request() fires the owning device's trigger op with the
>     correct magic cells for both a 2-cell and a 1-cell mode;
>   - an unknown mode, and a backing-store-only mode (gpio/rtc), both return
>     -ENOENT because they are not triggerable;
>   - reboot_mode_list() enumerates only the triggerable modes and hides the
>     backing-store modes.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> arch/sandbox/dts/test.dts |  6 ++++
>  test/dm/reboot-mode.c     | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 93 insertions(+)

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -5,6 +5,7 @@
>
>  #include <dm.h>
>  #include <reboot-mode/reboot-mode.h>
> +#include <console.h>
>  #include <env.h>
>  #include <log.h>

Please sort alphabetically - console.h belongs above dm.h (or at least
above env.h), not tucked in after the subdirectory header (which
should be at the end).

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -16,6 +17,42 @@
> +static int test_trigger(struct udevice *dev, const u32 *magic, int count)
> +{
> +     int i;
> +
> +     test_trigger_count = count;
> +     for (i = 0; i < count && i < REBOOT_MODE_MAX_MAGIC; i++)
> +             test_trigger_magic[i] = magic[i];
> +
> +     /* A real backend does not return here; the test one does. */
> +     return -EINPROGRESS;
> +}

Since the framework's contract is that trigger() does not return on
success, returning -EINPROGRESS here is a bit of a smell - a future
change that treats any negative return as failure would break this
test silently. Consider returning 0 and asserting 0, or add a comment
near the ops declaration reminding readers this is a deliberate
test-only convention.

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -66,3 +103,53 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
> +     test_trigger_count = 0;
> +     test_trigger_magic[0] = 0;
> +     test_trigger_magic[1] = 0;

memset(test_trigger_magic, '\0', sizeof(test_trigger_magic)) is safer
- with REBOOT_MODE_MAX_MAGIC == 3, magic[2] is left uninitialised, and
if a future mode grows to 3 cells this partial clear will hide state
leaked across ut runs.

> diff --git a/test/dm/reboot-mode.c b/test/dm/reboot-mode.c
> @@ -66,3 +103,53 @@ static int dm_test_reboot_mode_rtc(struct unit_test_state *uts)
> +     ut_assert_nextline("Available reset modes:");
> +     ut_assert_nextline("  obelisk");
> +     ut_assert_nextline("  sarcophagus");
> +     /* Backing-store modes (test/download) have no trigger and are hidden */
> +     ut_assert_console_end();

This bakes in the property iteration order of dev_for_each_property()
and the uclass probe order. That happens to be deterministic on
sandbox today, but please add a brief comment explaining why the order
is guaranteed, otherwise a future dts reshuffle will look like a test
regression.

Regards,
Simon
