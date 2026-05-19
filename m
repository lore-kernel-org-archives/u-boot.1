Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26860CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C98D84713;
	Tue, 19 May 2026 22:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vjgbn+NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF1184707; Tue, 19 May 2026 22:00:47 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DECA84707
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 22:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b936331786dso524760266b.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 13:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779220844; cv=none;
 d=google.com; s=arc-20240605;
 b=Bcu50/vCG8CRyw+qqazktEmnrkbkQhXy1GA8dtNw/Ow4tKy4HooLs4p8p8YdENPVk0
 9frvW19OMcDB6Fd8XDz1TAtzXFEclGByRsB+tcVGmKo1s9am/MgtDfJFVQZ5/SHLIrtA
 +Rme38eXIwWf432mny12JZF/A1RzcwajEPN0BM6rChElEjeRaPOx7OmFOKjpfqKxFMRq
 X1RyXIcBw1MerO8BgtTVJplikL0ltnG38413dfgeLlUz1u1YKioC/LU9q9Xa4ut0oMB+
 xDtBJVi8NV2uGpRhuPR4Y7h5aiclYpGy73KuCMFbrcAV9h5oRyhABI96BgU/+3SzGGLU
 WAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
 fh=01kIhYdAk8KIKzFrSpUjcsxOynJuI3kqFhKkT+8Fueg=;
 b=i7Ux2YZHngiyVt5yMyAx48bOX5nqwm1ko5gBnp5/P3/hR3ZcGYHsKJ/dR78aaBHddw
 kD/f6f6rK1F1PWk/+mfP1Uofeefib/hb2OHQZOO/O4FIKPMJz13VMv+kylPng/oCLmfU
 tZ5HkOERD/oxPmkETCZ1vrr9cXehD77cMtuQs/ZOLUIfL17I2KZCJMgrF+iPgoM7UPxd
 sTWQ41vvvSPe9b8mQe8CN7PN9ktv7FZ+H/qQEL7gOTBIsBGElc4aN4iUsMAjkTZY+m+B
 RekpkkXjgzdMmZQbBgP5T2LCpM3cBV7js5My8Cik/JVA27MngA/65B3dlCciAJaFNOQM
 SWxA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779220844; x=1779825644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
 b=Vjgbn+NPH5rIQsED2H+OYN3pYQvo+GdcMPFKyMXUtFvb04kRnTCLCC0BDkjtErhCYl
 /002fM1fuH4Bp5WacpD7faLZQAChyZFfxaCjq0DInWzjxxg6hKWmIOBwoJ7aifpZX4Tj
 ze5l6gf8pQTH7RnPjlzKIVP4ZRk8kgRAzQpKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779220844; x=1779825644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCZ3JqoysNE9TiYNsF5liZsuZ03stCANBEnkx2eZ5uw=;
 b=bOvrLvVytpUB1CnFyoMbku0xdDOIs62ErgPXIAE1xs7Z8aQqNprfmdx737S3DMt5rB
 DlOohcbaGfSmarAxsm1ex3/QvPe+XoMNQDvVbhAKErYqTEuiNguj8xI4oRDn8SUVnfAx
 DnXsSSIHjQeh8WuMMqahlrBRwMkhzRVscWMcI6yCii/0MPrt1PZAcXnzTwAHSxcJir3S
 VzjIUvYZopFcIspKCuE5ynML6Hr/BIPN3VXrfQ8Oh8OtcJwlz5+rZtHQLkOMLEYZ77kL
 7ymETG8eUJEMq0o+u0J/GrLU8ldcoTrKJSRYJca/vKIhkJef/Zupa2knMKbJdTgIJ3In
 yDWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RcHdhzTsmpHHDyYgh4J3hXcLAjwpeMCvEUiIHHH1VIdEU2y1tZ5kZUIfUYaPPF5+zqbj3vUY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyik07j/eZ02ETY9XXSgeIe8F5NAzT6swWM0aMh+z9UEoItg8VI
 mWVJtUqhlCHYTmTCBFrqJntmpY1usdsUozQ01b5llm7fZxc3qytlEWH6rsPW+NFCRqd7VpFQ47U
 I2l555mFqXlU97wUNouMnYmyt9BInRtomgIvHza+t
X-Gm-Gg: Acq92OFoDUYCL9LVRdDHhCqeQVRbFH4e/dIjbt3Zhpg870FsOf7bKbuIcJYpdzHchRK
 X7p+qOUFNIU6DpD209atjTBQBOcgW/vCs0NV0MKARqnbNlP1VRdHvxiR4kSdnILkWnb8nffevct
 MU5dUGbgk1xItIsCiXRNqGTe/vvJA/GZH17Gh4QczW8KdQxluoff9dnJ3wBx+jAK18Wu3FETtQX
 P2LbaCY6Wcp1SoFxP2PEths1kmBxWUCvWoIrHfI93/1BZnytsJG7mUASfUtOcudOokQPIDXHVk7
 AU/1t+bw2T75K7Y6
X-Received: by 2002:a17:907:7ba9:b0:bd0:783c:9dd0 with SMTP id
 a640c23a62f3a-bd517966ab4mr1142839366b.40.1779220843826; Tue, 19 May 2026
 13:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 May 2026 14:00:31 -0600
X-Gm-Features: AVHnY4JXKoQbnUnIF8QmMjGYjI09x77nd-7tujmANE4GPST_yWO1UPjFAykUn_U
Message-ID: <CAFLszThEXe_dskFi4nNCnEq6-75GcRo6YNA2CCgt1tmacs_S7g@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: Probe RTC early in dm_test_host()
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On 2026-05-18T05:57:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: Probe RTC early in dm_test_host()
>
> The ext4 driver probes and reads the RTC which allocates memory.
>
> Ensure that the device is already probed and read once in dm_test_hook()
> to avoid false positives.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/dm/host.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

> diff --git a/test/dm/host.c b/test/dm/host.c
> @@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
>       ulong mem_start;
>       loff_t actwrite;
>
> +     /*
> +      * Probing and first read from the RTC allocates memory.
> +      * Do it before the measurement.
> +      */

Please mention here (and in the commit message) which call inside this
test ends up touching the RTC. It is non-obvious that fs_write()
further down now reaches into the RTC via patch 5, and a future reader
will not understand why an RTC probe belongs in a host test.

> diff --git a/test/dm/host.c b/test/dm/host.c
> @@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
> +     if (CONFIG_IS_ENABLED(DM_RTC)) {
> +             struct rtc_time tm;
> +
> +             uclass_first_device(UCLASS_RTC, &dev);
> +             if (dev)
> +                     dm_rtc_get(dev, &tm);
> +     }

Since this is a DM test you should assert each of these calls.

Also, would it be simpler to take a second mem_start sample after the
warm-up, so the RTC allocation is naturally outside the measured
window without needing to know it exists?

> Ensure that the device is already probed and read once in dm_test_hook()
> to avoid false positives.

Should be dm_test_host(). Also spell out that it is the
ut_check_delta() leak check at the end of the test that gets fooled by
the RTC's one-shot allocation.

Regards,
Simon
