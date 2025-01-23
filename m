Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A48C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C763E80214;
	Thu, 23 Jan 2025 15:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eP4FNH5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AD480780; Thu, 23 Jan 2025 15:37:36 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9A380137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d96944401dso1797254a12.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643054; x=1738247854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wc0Pq0joo0Cvr2QjJTLD1TVKUTi9gQrmbS7MftB/LWs=;
 b=eP4FNH5VVWBijmRRn4unJ266RwgHuE8bCYEsXMWeYDWLKgkbkr8zL5KLGK5FVGEGsO
 yTKXtpb1orxULVBscNqRmTHh/NPgolvFkQmTHfg8LpSyTPDqk5aT8jPLgLQbE5fpX2qd
 6jYTo9xT5bc3s9WZEW0OvmSdGxgUTTnGQeYcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643054; x=1738247854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wc0Pq0joo0Cvr2QjJTLD1TVKUTi9gQrmbS7MftB/LWs=;
 b=tgyVzv0xHGLMx09LkHcPqJZciHX6wfxEw7zTX8nks2CW3CQ2eMq1wPqUUHwuZsK9o1
 C58KUij36v+PCXTmsiCaa8F1P1YfkB1OeBHPU2LJmtMBg7pyrV1yeRVMINxxTVRS6sGL
 lueSSEJMj/Qmxqtltlk/1yuOSJbYmTmTdS27tP7mESLl/r5D7a0J99WSRF9m3bVKC/8z
 tWEhvpjFng4HZpoGvYE7g9SJr0nLqquLHqVJHTx7XCTnOMlRmmKK463hAO37NFWxqPAi
 b40QRHw6xKRx33g9w51C0FNgFlGDIPU0b2BQzP5r+B6JCmnGrMxDTAb29dewLkLYPChK
 CS/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8hxM6QUC73Uppuvv97bHJnUnee4fAP7BlCmvVyb8ElbrXiso3kwj/Q4xof3DoEccZItI/yxc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtsk5Kz8lRvHthiLmuGCcwH39jBFdSxuwzI6Hs8pcMb8QK91Cl
 K1bNfI0T5XLDT4AAUX9SWx/lQhxpkyrWPJrDHqjEUXc3drx7SJzoJW2z+vPw9i0hFfAVNK29mmV
 i/g7cxtYopfELNjn5MkOHqycjGrYYCidirSQ6
X-Gm-Gg: ASbGncv3kLKSDs011YbZfbvlaX+ehvH3niVs5peewxT5nOSNd2wJrJGFUG/XF2YeFaA
 Y4I71pWwMtVp3P/u5Vh7YDh+f+Nhspr0Rbz/edZn9DJFQ3sztKDZbxX7Wg8WYND0=
X-Google-Smtp-Source: AGHT+IGhmuHmkrhk5+ytj25gDLXY/iET/uzmMC2Lspe1yPhRhnei0wrfIBUHegnJPgZZ1ePvO62YucASw1SdXOKnCPY=
X-Received: by 2002:a17:906:7315:b0:aa6:6c46:7ca1 with SMTP id
 a640c23a62f3a-ab38b0b807amr2644250166b.10.1737643052376; Thu, 23 Jan 2025
 06:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20250117-clarify-probe-after-bind-v1-0-273f046ce5dd@linaro.org>
 <20250117-clarify-probe-after-bind-v1-2-273f046ce5dd@linaro.org>
 <CAFLszTi_=S9m54DvKdjdNXf=zOhgg6tog8kcQ+dxjkjQ8BoP4Q@mail.gmail.com>
 <a33678e1-b4e2-43e2-b6de-55618bbb8579@linaro.org>
In-Reply-To: <a33678e1-b4e2-43e2-b6de-55618bbb8579@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:37:20 -0700
X-Gm-Features: AbW1kvZN6ey29GbtEBi9_R6KOGDYJ4I6wMJEfk7D4go1VWXEHVOpLB6y20MY9UM
Message-ID: <CAFLszThLEUsPmxUkQnGNAtojya6E82iGuwfPLLyTCfRXbszoJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: remove bogus DM_FLAG_PROBE_AFTER_BIND flags
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, 
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

On Tue, 21 Jan 2025 at 05:00, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 18/01/2025 05:32, Simon Glass wrote:
> > On Fri, 17 Jan 2025 at 00:29, Caleb Connolly <caleb.connolly@linaro.org
> > <mailto:caleb.connolly@linaro.org>> wrote:
> >>
> >> Some drivers set DM_FLAG_PROBE_AFTER_BIND, this does nothing since it's
> >> only every applied on a per-device basis.
> >>
> >> Remove the flags.
> >>
> >> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org
> > <mailto:caleb.connolly@linaro.org>>
> >> ---
> >>  drivers/mailbox/zynqmp-ipi.c  | 1 -
> >>  drivers/watchdog/da9063-wdt.c | 1 -
> >>  2 files changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/mailbox/zynqmp-ipi.c b/drivers/mailbox/zynqmp-ipi.c
> >> index 713d93a200c4..851aa737c03e 100644
> >> --- a/drivers/mailbox/zynqmp-ipi.c
> >> +++ b/drivers/mailbox/zynqmp-ipi.c
> >> @@ -269,6 +269,5 @@ U_BOOT_DRIVER(zynqmp_ipi) = {
> >>         .name = "zynqmp_ipi",
> >>         .id = UCLASS_NOP,
> >>         .of_match = zynqmp_ipi_ids,
> >>         .probe = zynqmp_ipi_probe,
> >> -       .flags = DM_FLAG_PROBE_AFTER_BIND,
> >>  };
> >> diff --git a/drivers/watchdog/da9063-wdt.c b/drivers/watchdog/da9063-wdt.c
> >> index b7216b578630..ec9bc0330114 100644
> >> --- a/drivers/watchdog/da9063-wdt.c
> >> +++ b/drivers/watchdog/da9063-wdt.c
> >> @@ -144,6 +144,5 @@ U_BOOT_DRIVER(da9063_wdt) = {
> >>         .name = "da9063-wdt",
> >>         .id = UCLASS_WDT,
> >>         .of_match = da9063_wdt_ids,
> >>         .ops = &da9063_wdt_ops,
> >> -       .flags = DM_FLAG_PROBE_AFTER_BIND,
> >>  };
> >>
> >> --
> >> 2.48.0
> >>
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
> >
> > It is actually a bit unclear, since the comments for struct driver
> > mention DM_FLAG_... for the flags.
>
> Yep, some of the flags (most even?) can be applied to drivers and there
> is no proper distinction between which apply to drivers and which to
> devices.

I would rather have one set of flags if we can.

There are flags which only affect binding so perhaps they should be at
the start of the enum, with flags which only affect the device after
that.

But the original reason for not setting a flag like
DM_FLAG_PROBE_AFTER_BIND in the driver was that the driver wanted to
control whether to set it in the device.

>
> DRIVER_FLAG_... and DEV_FLAG_... or something maybe better, something to
> revisit in the future for sure.
>
> Thx for the review

Regards,
SImon
