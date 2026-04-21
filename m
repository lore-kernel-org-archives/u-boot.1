Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8F2F94CB3
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F11E842FD;
	Wed, 22 Apr 2026 00:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pa6b4a6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFE68419C; Wed, 22 Apr 2026 00:49:35 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B55D83936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba388bc0a9dso845394566b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811773; cv=none;
 d=google.com; s=arc-20240605;
 b=E3PzzEgxWZfaWFM49eJAtzFjw36Ze2XvWLZSc6vrQwsJqRZ7w9HKIjYUzcsaQ/8w01
 j2kXu7zXtXMk5JhjE3da8XciLiYwSw77DUcJVk0N3YZ5SyTpJfjmEPmNlS8rlJNxI7Ry
 vSPcSoVj06kODw1IjRzx35DAnSaWhW9JlCRRujd0awkHNwDEjhzUGpDCPBp/3SjTIv90
 jFA1fr2S2HtQYa2ogekWTRMKV3pzOxF5V3LkuyiRJFHPZJHSdVk8Z9JNA6ENEYvL0M3A
 iA+iO5mgv+TM3MZj+88LWQb50h4MS6ngx3xctCv8BJVKjcj6qAyDxdF3AGtpM1wVrLsq
 gFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qZeYl1byV4sj7WXeyYiiD3MJq3RnIvxiup2XqDflAvw=;
 fh=UJSFcnL+qFtgZwBT5ygkk9y+iYxU8voFUi5KTuzZZ3s=;
 b=EaP15EYFRNw227TuLfXtLMAXcR9rP/919tbomdQeIEe0CoSHBaDZjt95lPh2CLJZtj
 fgbKi/3izbJGqCw7i+0mP9SLa4CJUHOaLNeKkl90MzYCSHKzATNAJxT+ZerfULZxzrFv
 Fxg6TSHsWPd5cIzt/hdUk5CJa6VGq08aKXrE6V3o37EHRIiimWs95rnJdZM3EmKtxRQp
 wNzOJ63SiiiWlI5lfOi6K8BAWAp31w5nG2lIFpVJ4gC335qUPSAHX8GW2oRQmZgT0r/X
 o8Fh3lunW1VFFjZF3BOf8LA8RlP30a81fHERZQF2DYmNzN2NyTw5QKIAE0ILFMrChVOc
 MsWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811773; x=1777416573; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qZeYl1byV4sj7WXeyYiiD3MJq3RnIvxiup2XqDflAvw=;
 b=Pa6b4a6MBGVxp8iBSGD/fqRiW4KbMeUpRD5Tz9WS9pT9molOaz7wccYmaCW0QA+LSZ
 OtNUehTVkxgwJSLWHJCJrzJepi3j0HDPuDjWx4tYpBeNTJh5kp7irDKooNPj5zPZZCik
 yjhoo23/fL+8bWgkrQTYyDPqt2gR4BNkTJCKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811773; x=1777416573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZeYl1byV4sj7WXeyYiiD3MJq3RnIvxiup2XqDflAvw=;
 b=BY0CqMt745mHZ1rAWgKbp/2nAzhaNE3uSJMRg3GeymgnAeoQyZBg218TL98Ao8KkeS
 OYPt13LIWoOLsqKBJbRWQfUFysqkaq7abY/l2JwY97m+TR8Yuh0Z+kAHmgTejwFYQdTe
 vkJMfYmbr9W/R6o47TX79B9fs6D5G9hCRIcwOUMRvAjGY7Tw2b81eDthlffdRTi65r0e
 BUX1lM4Kh9WxTuarVSwMhCE1UBCYY0Eq6Umd92I/JO7rByvdJgPO5giHNqljd/y4axN6
 q2mqIHHBf/wwAR5Bd+NnfV+sFExnY4u/XKVgsbS6UDcKPyn3xijqhVLsg5q/mWRQIvpR
 O4Qg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LnigFflLQWq142AKuZtjl3TgiY4/dL3YCG+pg4i1kHG5pU1SX3veRL74EKPpeVA58AdS6FTE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb9jO0C4Cla8bMXX0bY8hRvsjfQnVlOygHL5u2gmSFjpQ4lFmf
 SRVnXG5yVxbA1mGEwdmZz4CGkNv/Nqq6dljTmVCrUgzBvq7RmAAhh+QJccTN3uMUEJn6iRqHcua
 C6dkEYPtlXPYXOq+ShSsEtsxEWNYbWZF8wWTyFKat
X-Gm-Gg: AeBDies5LrZ07o4doXkZi85qoLn12j7O59A6zYtdv0Emki1RQBUNCK3IvZoeYqsf1BX
 hT61/S9L0D02mkWAP0tt6Bx93fTYxYYzj9Vsk65tt1Qm4B7uUssPIuZTwmc816CWRoKk/vM6wfK
 ghTklBhyFipuMKpaOdjcXjGfIXReIyXftpSzPy64lzE+D2AaPp1FPWb2bDm214B7+dD4K1E/ggF
 F6ZICMwQ7UnV0plo1WvY6kuSmQhkCZMxaELFgbIeG257gZNEfAy8a7qn84at9tCaPkb2ygDphnm
 PklZFRowD5wlKfXyv6lHI2bW2qM/esM=
X-Received: by 2002:a17:906:6a13:b0:ba7:9eae:18a9 with SMTP id
 a640c23a62f3a-ba79eae1ab8mr557327166b.17.1776811772726; Tue, 21 Apr 2026
 15:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220804.71564-1-heinrich.schuchardt@canonical.com>
 <20260420220804.71564-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220804.71564-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:49:15 +1200
X-Gm-Features: AQROBzAwOu-Qiasq-rIfEiMpk4RBCp_f2zKGY2JnFP68lN1wfbdpuN8erTMRks8
Message-ID: <CAFLszTgBvFjAkb86fBJfQ-8djpUkKHcV3+cHdbYk7HGe2_GCJQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] doc: document index parameter of `acpi dump`
To: heinrich.schuchardt@canonical.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On 2026-04-20T22:08:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> doc: document index parameter of acpi dump
>
> Describe the new index parameter.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> doc/usage/cmd/acpi.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/doc/usage/cmd/acpi.rst b/doc/usage/cmd/acpi.rst
> @@ -125,6 +125,12 @@ acpi dump
> +Index
> +    Hexaecimal index starting (default 0)

Hexadecimal

Seems incomplete, perhaps: "Hexadecimal zero-based index (default 0)" ?

Regards,
Simon
