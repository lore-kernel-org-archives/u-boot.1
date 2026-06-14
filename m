Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5F2CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 16:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4FF2848A2;
	Sun, 14 Jun 2026 18:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H8632jA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3820A848A1; Sun, 14 Jun 2026 18:19:14 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D9384105
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 18:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so3847034a12.0
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 09:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781453951; cv=none;
 d=google.com; s=arc-20240605;
 b=kr8drQeNHhleFNW1C9xPgMQjGznc6AQVtTiEeEDbnaOet/RmjCCBDqpqyk+Ttd+KJc
 +PzGbvuNjsiBYNel3/YqxEeJ99naOWU9T3fmuYj+6cY6BOEkZ82tmkdiSVa/GZ4EF9zc
 ekEFL8+C15vLvkBXmwQESekx1ydCGO31YwR4gXLrLoau6FgM7rRaP33aBjDgzdLTnOsk
 pqYA2fnDI4MRMmQWF2DvpcJ2VkijOcSYb7kMf+7roNXP11f0Juj8Eo+vOMAzJrl5KqvK
 PZi/dRltbK6378RwA9cFj/HjTNZDmEHAVqeURxFPkhvcSrM6ORsD3y7HfWhMPYb99RfN
 Fpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pwz6dIlHosSnEc4aW3W9ITk33XuUIE8q1GYELPU9l+0=;
 fh=zR2buvS04tl8yfD/I/5YjPdhsEu7HKufx604qAmmYsI=;
 b=XD6ghuQI+urzeTEGwYYGFElEIOax1tsO6kOpoBrD8cLQUwr7KO7CFpnfgYfJWFA5Sp
 pfam+dkonUfLA8dcvk2q18AuA0Agq69Ds08LbFRxn5F4HWnBVBaBDzJkg8gi6q0TTbZb
 Wwj3GeTg5UCbG1cbeB5t1+8GHh+b/Vaj0ZYPwEbFslqxp8z9tXAFTdVQ9c4+Jq4DgF/u
 Y9yEU5WFryTEsA+yWrp3Kpiua5BoycV59jTCAdhHtPtf0tq8ZYkh5CMOEh/Fuu8nNEF7
 sfqI/o0aJvZKliqgC5mbr/DNtlmNNAPQsCsBBxH9sGuXv9Hus6HKUkb9Ye/gksW8ZSCT
 +mmQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781453951; x=1782058751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pwz6dIlHosSnEc4aW3W9ITk33XuUIE8q1GYELPU9l+0=;
 b=H8632jA3hNCuK4SU2ViFaP9gX/0gShjLh2colosHu+Ys62P59zXsvFArnhqSOmMlUD
 9BZJceuL81/2BkVNCP0nEzgDHdpPGA6VmwRzbbRRKlW+PMVZzKm+cUR5Wt0sq7eGOBSS
 QjFKns8bHCg2hHkf1Gep+RCIw8tq6XfHvkAv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781453951; x=1782058751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pwz6dIlHosSnEc4aW3W9ITk33XuUIE8q1GYELPU9l+0=;
 b=FhKdRJ+g4ZVNVwYuInNqYQXX+wc1rEgWWqadIvgXHN/YHKlgS+jjHwZID9GjdEQcpo
 /wQNdXuOqTPQ9wnK3W7hxd2n9EckAVHMfD8bs5LR/utCIOIGgKkxF3hUjXonLtLf/wbh
 4fD1eQREtNrmlwwcDmQizOCXp8QJzpgbuRXguL0ODKWMqdBQhyQV3uyfIQZBqTfB7qXJ
 5NTm5NsFsB/bn1CYPgPkRo+yYeFI/FZdR8SGjt/vrvCyUzPs3FW7Jt8bCdpCQS/ECsPP
 LrwkIL6I1zBf2ufZW8WN0f218Sl5kK+mssZ7BPJaD2I8oXzsAMEay1UrQiPW5RTqpjdz
 8FDQ==
X-Gm-Message-State: AOJu0YwVdlsli5VIqo3d1aY0iBeHtFgs6Frvyi5sMSXKoYfN7O5chfqR
 5K64GXQCtoFK/7sga2UOIno0pZoZXIAK97DuaMVUjn8k0ym2Gs8Jiiiir0tDRBd6weeaZqTKmRD
 lqlg/mpVQeoDXFYqR5iZRHqqPvmBcSMcaeZJ3hLkR
X-Gm-Gg: Acq92OEwBAni0Mm7HBHXMGyT7rmOA5QbZJGzKd1GW7hV5pFL9ducsQNW/4FhtoNqUTJ
 ZAW9i/xmTdpDwiamJ1gF4UVBJEciRpDRlL+oKT8w8l7CqjBQTXgzgKew/tmoSBuSrNJPR7MGMWo
 S9U52l6PDGpt9UaH0XO4VOyYHkw0MU0ZU18fyq9xL+ZqWSHgIaVVS1lSZ5ZID6BTGiNQAYe9Oie
 4FahO0qzecIBi+EXJ0EtkptJNZRyJ5NuBynqW3vvqnemcM2DkL+1pZ8Rj7kPPv6KHCcWwCnZp+R
 5HDtQrIesWcNSPF+
X-Received: by 2002:a05:6402:26d1:b0:691:affa:38bd with SMTP id
 4fb4d7f45d1cf-693784f7effmr4680865a12.3.1781453951284; Sun, 14 Jun 2026
 09:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
 <20260610-android-binman-v3-4-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-4-710298a38fcc@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 10:18:58 -0600
X-Gm-Features: AVVi8CcN1ZLyIgPZqDtWe5YJdQmiOlioL9IQ-1uSzFjxuffvGfOvQ9At7Mel8_E
Message-ID: <CAFLszTh4ZQ06L+YoWjBo0wph9hzjJEcV+x+Jy9bGvs=dEGZH2Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] binman: Android boot image support
To: me@samcday.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Javier Tia <floss@jetm.me>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, 
 yan wang <yan.wang@softathome.com>, Marek Vasut <marex@nabladev.com>, 
 Denis Mukhin <dmukhin@ford.com>
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

Hi Sam,

On 2026-06-10T01:27:41, Sam Day via B4 Relay
<devnull+me.samcday.com@kernel.org> wrote:
> binman: Android boot image support
>
> Introduce initial support for Android boot images (abootimgs).
>
> The AOSP implementation was used as a reference for this work.
>
> We start with just v0 and v2 support. v1/v3/v4 are deliberately left
> unimplemented for now as no use-case has been found for them yet.
>
> Since we're targeting U-Boot use cases here, a couple of things were
> omitted from this impl, namely 'second' and recovery_dtbo support.
>
> Link: https://android.googlesource.com/platform/system/tools/mkbootimg/
> Signed-off-by: Sam Day <me@samcday.com>
>
> tools/binman/etype/android_boot.py                 | 285 +++++++++++++++++++++
>  tools/binman/ftest.py                              | 148 +++++++++++
>  tools/binman/test/android_boot_chonky_cells.dts    |  13 +
>  tools/binman/test/android_boot_dtb_in_v0.dts       |  12 +
>  tools/binman/test/android_boot_invalid_addr.dts    |  13 +
>  .../binman/test/android_boot_invalid_pagesize.dts  |  11 +
>  tools/binman/test/android_boot_invalid_subnode.dts |  12 +
>  tools/binman/test/android_boot_missing_kernel.dts  |   9 +
>  .../test/android_boot_oversized_bootname.dts       |  12 +
>  .../test/android_boot_unsupported_version.dts      |  11 +
>  tools/binman/test/android_boot_v0.dts              |  34 +++
>  .../test/android_boot_v0_pagesize_too_smol.dts     |  12 +
>  tools/binman/test/android_boot_v2.dts              |  50 ++++
>  tools/binman/test/android_boot_v2_missing_dtb.dts  |  12 +
>  .../test/android_boot_v2_pagesize_too_smol.dts     |  13 +
>  tools/binman/test/android_boot_v2_vendor_dt.dts    |  14 +
>  16 files changed, 661 insertions(+)

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,285 @@
> +    def _BuildV0SectionData(self, required):
> +        kernel = self._GetEntryData('kernel', required)
> +        ramdisk = self._GetEntryData('ramdisk', required, b'')
> +        if not required and (kernel is None or vendor_dt is None or
> +                             ramdisk is None):
> +            return None

...

> diff --git a/tools/binman/test/android_boot_v2_vendor_dt.dts b/tools/binman/test/android_boot_v2_vendor_dt.dts
> @@ -0,0 +1,14 @@
> +             android-boot {
> +                     header-version = <2>;
> +                     kernel {};
> +                     dtb {};
> +                     vendor-dt {};
> +             };

This fixture and the corresponding testAndroidBootV2VendorDt() in
ftest.py belong in patch 6 - they exercise the vendor-dt subnode which
this patch does not yet recognise. Against this commit alone,
ReadEntries() raises "Unexpected subnode 'vendor-dt'" rather than the
message the test asserts on. Also vendor_dt is not defined
yet...please bisect-check the series.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,285 @@
> +BOOT_IMAGE_HEADER_V0 = '<{}s10I{}s{}s{}s'.format(len(BOOT_MAGIC),
> +                                                    BOOT_NAME_SIZE,
> +                                                    BOOT_ARGS_SIZE,
> +                                                    IMAGE_ID_SIZE)

Continuation lines are over-indented past the opening paren. Please
align with the '(' or drop to a single hanging indent.

> diff --git a/tools/binman/etype/android_boot.py b/tools/binman/etype/android_boot.py
> @@ -0,0 +1,285 @@
> +        boot_id_payloads = [kernel, ramdisk, b'']
> +        image_id = self._BootId(*boot_id_payloads)

The v2 path passes the payloads inline to _BootId() - please do the
same here for consistency; the temporary list doesn't seem worth it.

Regards,
Simon
