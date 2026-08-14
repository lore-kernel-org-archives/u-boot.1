Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71914C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37DC460A6F;
	Fri, 14 Aug 2026 22:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WXNyH8i-8ZZh; Fri, 14 Aug 2026 22:55:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BA65608B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786748130;
	bh=S0KDOyksWmVkxS+x8bUx8taBTCHiVUc5PiXP21Qkb44=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d1llXl3S+OCI+ziy96qehTE7ZOq8c42bz+xo56n4UVmwwZLHNBuswn6x/ulb1Mx9g
	 mzJI6QCArnzo0hOclmmFLgOxzPBTHMD995FfxSYN7pwMJ/lHelSLUs4lmPVna7kCi8
	 T/an/KOhm8ce5S6dlh99Ta1h4SocQbf2BZpr0JJ7m5/el7faSpCOOzst6ro5V6W6a/
	 Mz7XNmL1ep4HJlhiSj3zXsRqnn5PskJaJGfI+pvtr96xzwvJR6v2lbCn4vgIJpAQ1C
	 CjUcHfbjEQ2esE9ksZMOzBVilUu+e36llXzySsONOjo5u+HQropiby9/v70q2F76A4
	 czK9ZQnrWNKjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BA65608B4;
	Fri, 14 Aug 2026 22:55:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 93D35194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 794D340B19
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zblYPYJiuJM4 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:55:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9B73A40064
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B73A40064
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=irY5N6MB
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9B73A40064
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:55:27 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so462512366b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 15:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786748125; cv=none;
 d=google.com; s=arc-20260327;
 b=paoZa9SfroKMz2lq6fKdNB60BM5XDwpjkoaSzcu4kO7gswAM0wq7PZ6hxGCYnan4Us
 JeK5JDrimwYSFF0oswV+ilItwDskWpaXHRJ+rAyIybTX70s3cWWvnzlFFax5WKVEKVoe
 IFg52r7B82KrgvyOwoSYDHJ9t0VIyO6o6hSyhr4aDeu3p2y2vuWEXIWsm8BU1X9cgBo4
 WAJik3zmYaxiRpKx5kG5He7d3HM1vEutIbC5e4sok9GGyqmyrs7k9OZiYO0A7Dgxiafl
 8tAOXjlqT/YFeaSa5NdzP/Fh/nA8R08hs+eThiDp3pY+fzu2yIiC8rcVdOEWOJmecKDq
 4vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S0KDOyksWmVkxS+x8bUx8taBTCHiVUc5PiXP21Qkb44=;
 fh=CWoM8UuBv/dglXElNYTHZV4SkYgGFbIL0j0tzpI/BR0=;
 b=oE0UDHExt5TFidnPvQlAmXnGJaz7iiwwzeWyRItSMC9E/cXoOyHDm3KdBrdPXNRy+y
 P79XavLGOpUB+LYh3bXHczzo8QP+fm4XaMoUYzKvC6Ot1lCHDySSBE9YXEqoI8aXIBsA
 hH92qrllIcLj5k+bYsQiGKE8iChhGKJz3OZcdGWoG3V3TiqPQIfKjufI63ENdoxIJJpo
 7AKxXJ34su0KXk3TdRYDfRVMzCw1ijIuczGVXPEAHQftDUVFeOfMeGaBqjfjka5eUuuN
 tymDTxkmJS0+XJno5ZsLkPJraV5qBzu0Jr0yAb+rHXlyfaCmjAbkk/cfZ00EdxJ+lQ1R
 Z0QQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786748125; x=1787352925;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S0KDOyksWmVkxS+x8bUx8taBTCHiVUc5PiXP21Qkb44=;
 b=irY5N6MBdQboDyRuHR/zW4bLy93XXtk9+d0zreOI9uZCU08W2YJ2yPTIkAlOnhorIP
 hvzEt2ABQZp8huCjPXZDC4RPXPGbIPXOrlGorhz6KbwrH6e7Rayke0DdUMyXvUTrmkNm
 XcmIPLoJuwH0UPKTfhqUWcD7aAR/deq5E8fgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786748125; x=1787352925;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=S0KDOyksWmVkxS+x8bUx8taBTCHiVUc5PiXP21Qkb44=;
 b=NghoAnenXmDC2rLXqbjQpICiDw5Z24pT1wUNv1A+uzBaAiY6knpeazzNo8alcZIE8h
 6UqiKCK1JflWxO3qgcKPHAz3D0hcIgfsESOXU/IIqtaM/aFk4TOG9FcOY0Lgt6eexsvn
 L5HiNid6983iFGlFFgXBvytu82mrCox5Cur8meP88L6OufVwdkfxALD9Evn3TpmGAwB+
 Fe1vvTo7q3IZUkUwjXsVMNm/+g1Jt3EbYq5fpwK/BZd22pT6fmBdIrRf5NWioxENEmV5
 2Jk6NiQSc50syIoSfMiilhU3CY5/vs1IhcT519jdlnOwzytp075xU7bgO/8HZrR8WJWJ
 so0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox/ltcOxLgoV3SoRYAKj55mP8bFEDzFW6qPDBsXOwPD9+FYAjsr8kkPm0R44BO4uFe2oxeumI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyWO6NqhwSdWwYm+6ca2kuSC3RiYYdo1OC1p0JDYzQ8A8YhzodX
 EU0MnseCi9sWVQ+YsSmXpe22aex9Ci5UASuLXbio/lPYLAUqWp8Ov9a0f0xGGjh8XQ7WSj/9E1w
 atyQ8I2B0XxNU/X9ahuXRoX9PYSdIkpW69bdJyFwr
X-Gm-Gg: AR+sD13ckaRLuEMMjzvI8qs2HfbTLyHb2udKlxt4dh96P5t8ULz22Of59tXIA6VfoAU
 XTdy0cwZfPAvTmxaWwoZTB17CNyeEsvqjurj4CFqlUd974UYK0yMCbOjTmP18y8PVB2bbwr5uTt
 1yjFueHsLGRr66mSkpcv20f2gut1x/sv+8m9OmGVHPFG6Judq1fFkEx4G+KK5K+i5Us0dmEWy+v
 RjwPMOeDdkWX0s1GN1aIfvIgOioxdMgv3igbap2olYunvJJGoJ+068uDi8yJiWkDBPigRhGpfSZ
 x6xrseoqPjZn0YUvP8/80ZaMu/9aU6lIy5oDsaoNWTI=
X-Received: by 2002:a17:906:f58f:b0:c20:f9d5:8d71 with SMTP id
 a640c23a62f3a-c2109f45faamr749823566b.5.1786748125354; Fri, 14 Aug 2026
 15:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-rinta-watchdog-gettime-v2-0-d8a5a7aa0df7@nokia.com>
 <20260812-rinta-watchdog-gettime-v2-5-d8a5a7aa0df7@nokia.com>
In-Reply-To: <20260812-rinta-watchdog-gettime-v2-5-d8a5a7aa0df7@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 16:55:11 -0600
X-Gm-Features: AUfX_mxdyHkcdP0jbZsa9FsQmPRQuNl1u_sC28osc0Z_YC_VmdG9FGB7S0xNukU
Message-ID: <CAFLszTi1U9=XihfqRjqMaGhL54d00ux=zYjcfUuk0GX7LLpU7A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 5/5] test: wdt: add a test for max_timeout_ms
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 u-boot@lists.u-boot-project.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Juuso,

On 2026-08-12T09:48:39, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> test: wdt: add a test for max_timeout_ms
>
> Add a DM test for the case where wdt_start() is called with
> a timeout_ms value greater than the (emulated) hardware-supported
> limit.
>
> Add console-print asserts for both the clamped and unclamped cases,
> as well as for the per-device uclass-plat data max_timeout_ms field.
>
> Add matching tests for the GPIO driver, which does not set the
> max_timeout_ms value.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> test/dm/wdt.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -16,34 +17,68 @@
> +static void format_wdt_servicing_str(char *str, size_t len, struct udevice *dev)
> +{
> +     if (IS_ENABLED(CONFIG_WATCHDOG)) {
> +             u32 reset_period = dev_read_u32_default(dev, "hw_margin_ms",
> +                                                     4000) / 4;
> +
> +             snprintf(str, len, " with servicing every %ums ",
> +                      reset_period);
> +     } else {
> +             snprintf(str, len, " without servicing ");
> +     }
> +}

This helper reimplements internal wdt-uclass details (the format
string, the "every %ldms" text, and the hw_margin_ms / 4 calculation
from wdt_pre_probe()). If any of that drifts, the tests silently rot
rather than catching a real change. Please drop the string
reconstruction and either match against a fixed literal (choose
test-side values that make the expected text deterministic) or split
the assertion into a handful of ut_assert_nextlinen() / substring
checks. Reproducing driver-private logic in the test isn't the right
layer.

Also, wdt-uclass prints "every %ldms" (long), not %ums, and when
CONFIG_WATCHDOG is not enabled the driver's format string produces two
spaces before the '(' (because svc_str is empty inside " %s ("), while
this helper emits only one trailing space. Sandbox does not select
CONFIG_WATCHDOG, so I suspect the ut_assert_nextline() calls below
will not match today.

> diff --git a/test/dm/wdt.c b/test/dm/wdt.c
> @@ -16,34 +17,68 @@
> +     /* Clamped timeout path */
> +     console_record_reset();
> +     ut_assertok(wdt_start(dev, SANDBOX_WDT_MAX_TIMEOUT_MS + 1000, 0));
> +     ut_asserteq(SANDBOX_WDT_MAX_TIMEOUT_MS, state->wdt.counter);
> +     ut_assert_nextline("WDT:   Started %s%s(%ds timeout, requested %ds)",
> +                        dev->name, svc, SANDBOX_WDT_MAX_TIMEOUT_MS / 1000,
> +                        (SANDBOX_WDT_MAX_TIMEOUT_MS + 1000) / 1000);
> +     ut_assert_console_end();

The clamped case only exercises timeout_ms > max_timeout_ms. The
uclass code has a second branch, the sub-second difference guard, that
suppresses req_str when the whole-second value would be unchanged. How
about a case where timeout_ms is greater than max but rounds to the
same whole second (e.g. max + 100ms), to lock down that behaviour?

Regards,
Simon
