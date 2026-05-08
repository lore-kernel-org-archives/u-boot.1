Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069F7CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BA184B02;
	Fri,  8 May 2026 10:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="hXVWTwzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395884B0E; Fri,  8 May 2026 10:21:35 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D2384AF6
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67e9b3037dcso1525113a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 01:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778228492; cv=none;
 d=google.com; s=arc-20240605;
 b=dchuGxbToVliiVHt7ElnP5CUuPsZIHzgSZfaGFbmJw7QvynzyVstEDhsTKl5B+020N
 S6uqD+CRnFLro0oaQAjC70cNpPOdYsVuEOw4hCCDYcbdns4z1aEFgzFxrg6VycmPwZu+
 ctTRiui4dQSTWOuvR4OOl9PlSadpsCfByuMQJch8ODi/cn4DEPjwwvQDBZVcaWR+1Ecs
 LdLtKAXJlWWFC5DGNDhMbGZQ5uN/sM9L7pXJE/RDVRRAPcJAbNLgsQAZIjzRpSrDoaX0
 hX1bJRT7qIAuJHNLL7yflP+u4WX/qRmqs/xRq4ckC/tgp73lDzCPONPxz8O22iRUqtPk
 vjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I3RO3z9v9nfzB+u9695HWeO2nagR0niRVFgThWjpnaE=;
 fh=K14gpZ6JKPaQhC9E5R+893RCU86w86q8zttNTAU9Ryw=;
 b=fBgaqhdnuKakz1KIj+T2OOpPfvMAtDjFM16YCfQjk9UOt5PtAENZX2OzyHHf+W7WKz
 fdJniB0ocvkVrL5YclaQoagTmLqKnrt6rpn4o0Xkd8vW6N/Gbmb/2miIUlFzv9A9FOYH
 H3nJS89Y/cdYW+gp8MBx0VpkhI2zliR1R+ZePO86mbvEuCRXaSgHT/kgkEXZqKQWR5hN
 87HSdldztggo4sBnL3PQzpWnSfNP6fzQ1IMfCF297E/eKQlEmgxers5hnOyFYiPv+T2U
 hoLqoM8+FMwURBzIjCvfcPfKJdMw4Vhovek7gqJX55mNDJ2wLOSaqKXJ/LLXGyOgKCDQ
 NpDw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778228492; x=1778833292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3RO3z9v9nfzB+u9695HWeO2nagR0niRVFgThWjpnaE=;
 b=hXVWTwzuZg2GENzQ6lFtVBb3ryyeT2dqdwcrRNJrDksXtn4bQgZvzonC0VlupxW6kS
 aonTQ3Twi8v4eNuOE0ncsFqK7p0cknm05v/6+ERnLmPQUfODG+EdP+fDRcqRjpdKNiqg
 8PIneILY1atXVxO0xSJhxReEuJqtU+N0JK5b67NS+Q2hnujjvZhnef6BaeHxB5LX95Q/
 oRkyFM+c7kHFM3iGcgJ2hyRLl9elQqJaQClqMLxEbt0IksAFJ1ld7B1NjhWCTp05IMYw
 cK4Ej1CNhiormx5Dvy7InVrRSDqBe9BhoT0WH0j109YzDLRwe6jn/WqSW3ogEBwuNt1B
 Jfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778228492; x=1778833292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3RO3z9v9nfzB+u9695HWeO2nagR0niRVFgThWjpnaE=;
 b=lXtBx2nGNZdZh/Z55y26sKpLC+e8XWQoDnnFbvRYxWW+l6Z8dw+xfyaEY16hi0pbpi
 V5tvmLHQBjaEUgNhipgfvTP2FOqhtJQmXd+L5T9bvoAEW0Q792URNyj4xxTeC5MTaUhj
 fQB3Pm0c84qok0SQjBUKVHuMRzS+I4HvVFU0SDN0cg74SgMiTFgLk/99B3uiru+1nIg1
 Mvx0TZXM8xAPqXwaYw3Ab2qCmL+3EVCZesbAQZtuOqh0MMkg2oJW28HKY3S3afGDKhMq
 0vgYZgZc+nio1cReuXkFBoV527ZZewe2sUN/31kBFVt2S+VoW7MQfmiN68vmyzELAY66
 0nCg==
X-Gm-Message-State: AOJu0Yxk+WlqVyZzncctdtpHNg/aJ0mrby46SQhr7ZDlH+5h7vOyg2Cj
 HM2RkiRYMNW4L2PbBE7hSwmKwPFbveNixLb7CpuHUGURdAgOvptR48cCmCm7Ltyh/sudiFSAL81
 VgNT/v2avsUJQfU9fp2atPe+kgHrcpfbG0d7cINJfug==
X-Gm-Gg: Acq92OFfCS4kOoua2SBTVKfBFp3LN0uQUV4tiqH4rAh14W98A0a7P9k7zfFfLODWt7P
 Rz6NAYPJJ/zXNUgg1xytSeNex3s0+OMXB590nSK+zTKrPX9c61ObLxNH7Va+d4Je2Yo/8zEGgmt
 Y7qn3wJ+sYqE/6mVZzzWYG5JwcN9gnGawGtRKnVk0IsU9A72oAsc3rcYAketoDdYnP56lR7cQN1
 W7ZJgB+CHESMGze9OQgKB5Z+ZFkRTHDIt28/fyuq+A1s51q9xpit2mU/tfADo5epDvvbKxwEkRH
 ZCr1nnPqPSg7Qx9wtBLt8/7x9zZGHrhp/dy/jHS/
X-Received: by 2002:a17:907:9346:b0:bc3:b598:7f47 with SMTP id
 a640c23a62f3a-bcaad226929mr107050766b.42.1778228492430; Fri, 08 May 2026
 01:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
 <13650571778172129@c82c52a0-4efd-47b9-b2a9-5a9057476b1d>
In-Reply-To: <13650571778172129@c82c52a0-4efd-47b9-b2a9-5a9057476b1d>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 8 May 2026 12:21:23 +0400
X-Gm-Features: AVHnY4KvKbZSvI8CAgbHgzJC5zvtoY2GGOMJyNRUX1HdyYum1AS0xe9bqBJiSAU
Message-ID: <CAKTNdwG-Keu5Gf9EA5TUw7mG-KGBLumOco54Gm=iRM2Oif-F7w@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Anton Burticica <mouse@ya.ru>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, May 7, 2026 at 8:48=E2=80=AFPM Anton Burticica <mouse@ya.ru> wrote:
>
> The original idea was to _not_ disable USB3 OTG port when booted from USB=
:
>
> https://github.com/flipperdevices/u-boot/pull/20/changes

Hi Anton, thanks for the context!

It seems, however, that the minimal change out of your original pull
request which fixes the observed initialization issue is just the
assertion of the reset line. The rest may be helpful but is apparently
not directly relevant to what I'm trying to fix here - thus the
significantly trimmed down patch body compared to your original
version (one change at a time).

> There is a possibility that with already running analogue blocks, disabli=
ng the port will leave the controller in some weird state and it's not poss=
ible to fully reset it via exposed reset lanes without full SoC reset.

Could be. However, having a different initial hardware state by the
time the driver loads, depending on the original bootsource, sounds
like future pain.

The Linux driver(s) also seem to be able to properly reinitialize the
relevant hardware blocks regardless of where the boot ROM and U-boot
left them, so I don't think we are dealing with a case of
"unrecoverable weird state requiring full SoC reset". We just need to
figure out what we are missing here, out of the substantial difference
between the two codebases.

> To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>;
> Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Philip=
p Tomsich <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com=
>, Jonas Karlman <jonas@kwiboo.se>, Anton Burticica <mouse@ya.ru>, Alexey C=
harkov <alchark@flipper.net>;
> Subject: [PATCH] rockchip: rk3576: Properly handle USB controller takeove=
r from BootROM;
> 15:53, April 27, 2026, Alexey Charkov <alchark@flipper.net>:
>
> From: Anton Burticica <mouse@ya.ru>
>
> When booting via USB download mode (Maskrom), the BootROM leaves the
> USB3OTG0 controller in an active state. U-Boot must properly reset
> the controller before reinitializing it for fastboot or other USB
> gadget functions.
>
> Without this change, USB gadget mode commands such as fastboot and ums
> fail when U-Boot is loaded via Maskrom USB download because the
> controller state is inconsistent.
>
> Signed-off-by: Anton Burticica <mouse@ya.ru>
> [Removed unrelated changes, adjusted the commit description]
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
>  arch/arm/mach-rockchip/rk3576/rk3576.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

[Please avoid top posting per mailing list etiquette, as that makes
tracing the context for your reply harder]

Best regards,
Alexey
