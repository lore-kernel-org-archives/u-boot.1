Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722FBCD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27C8849CE;
	Tue, 23 Jun 2026 14:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WwdLvGgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B17A849CE; Tue, 23 Jun 2026 14:46:14 +0200 (CEST)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1A5849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-30c23abc62eso3591956eec.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 05:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782218770; cv=none;
 d=google.com; s=arc-20240605;
 b=WgkmxEojEYwTjaIM0U4J59tzVPjIo6dI6cFwaw8iInsVlqd+1uBkSStGpT5aHhvyqP
 YmhvkjymOLrXe3Y9R9ljnxlrdQoQwW6/Gn0Rw3HeQ6dMbEOsCba7ydO32fxCOgeKrjV7
 jsvYhC1r7Fd/iPHzgxt+pqrCWW1MpOq3w7SvzhiR+TJrSzsA3RMvB44NKh5FOQZyhJS3
 uYhBlE6pbFmwT4kaYU1Vim9xfias3Npx1ncZkIl1IqMUZXg0IWbLh21fuzkeKxUB5Xtt
 p5JWUWPKm6xnDmWBdlP93uJD/KPlLdJUrI6u+e5ySG8pGRdEZgFgTJOogfQBWR7fITqq
 t4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xLauE7n351hvrNEFpGJ2fOUnqdFx0WgKwTNteQx5THg=;
 fh=xvaab2g0CTbS4ZCXMOWlyZS61qQTtaM+PvqZdyx2ZJE=;
 b=CQXzD/p3g8/V6w7rkKP6JRBv7jFGr3KkHEcUSStq76uF4f+OOsfEWo2dLL5aGkxqMZ
 A3KdcHsN3dQIc/ay1+UZNpW5VJmGtYQ6JtaSedDBxmjatgUa+Jn8KVyQSFFba7tKH04/
 eopXzxbAk+/hEha09dsGEuvQfrHQtnYV7/q2ZyRS6Bcjcf6RGYpzLdQ6iNvbTULYSWGN
 MmxA8pf/EorNs8vmmqiRxe2QRR1mJ2lhhtzOK15mLETLdQPOYQJNxb4jVcGTnVqUiEh+
 lDkQDpo2tyFR88dIVt7FdD/i9uDjikAj/mX4hGL0018kCpnvDTpbZ5/rA9YQZ0G/Xm5P
 tW3g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782218770; x=1782823570; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xLauE7n351hvrNEFpGJ2fOUnqdFx0WgKwTNteQx5THg=;
 b=WwdLvGgd4PBkVGL+nrnG5d8YPT6td59ihXClCrqY365/MwZs2F+KCu+nFFD0POe66y
 /X34qiy2bYRBT6IJD7vsjpjrxunmwtTCKhCJHwER3NquC0TczZVZrgVadx1yJtbwr5IJ
 B6lkKWSWCB18doEIeN2c87EvUzF6tmJ/4OCYvdfjSt+cCEenWlMAcJ149uR5I8DonaKR
 5hTIUL+TVzyqjlnXHWvo4J+dCrwC7MoKkAREsP9NXE/yWuHo1AEbMyQtpaEoLm1Yb5rc
 Yo13pBaWnV/gqF9FzrX1N8Iqwk+2SklpNvEg9GhkGJCzdQivnzrLeZLB2kOHu1I3nQLv
 VM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782218770; x=1782823570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLauE7n351hvrNEFpGJ2fOUnqdFx0WgKwTNteQx5THg=;
 b=Y/XPM1pCtW+Szq6j2O9BBBa8IpgOESQbSWAMYt4TP6nkBprNtEyO3645uCkUyJHbdP
 igf7to2KbYLX/zXw/cL5K+vpjBkaSQjMCX4pLWUpfN6Kq1q+6s/ldYp0Su8sn58RR2Z2
 0oOPk5u4PBX8hNDNTGY87O/tXOjiL+zggfAc73JVKsZKc5163+R01s5FevL0jGnABxRA
 rxgpRnOhUYZ8YRmxC6JL+l/caJq0t/tjz4PgkW9DGBEStXbSoTrgduL9vPsxJFQdY50S
 PyJ8DmI6QTNNO4azYom1NapmoxRB5xznJzx7oQKX+exXYFuB2jBVAVg1OfEbQZMBpuE5
 oVDw==
X-Gm-Message-State: AOJu0YxynsrgwGhhWC5C21pea2Sb4vMp1Z5aMzFajm3yBKYYTeZW1OTD
 wnC/wygrZn+P8fpY1lCgL77jRUPqkKZXF2diOCBtyYKD1TUTOUqZpgfHz5ox0EnHK5N/PyFAqo4
 JMk5nO5OojxY6sNZjHxtjhnbAMwy8e/c=
X-Gm-Gg: AfdE7cn7MwVBQ3eLUgzJjkgQSBLApA6+xoT5FzWj0Wubp4Y402qeI6JjM0PmiGI8+HZ
 69Ltz4vvfMcrSgsBQUgozvT+kOoiQBM65TQQMskT0tz3k9GDOR12CSJPD6nZSPapbJEV6+AzJbe
 JZgJlPV2F48/DtSl5J9sRZIGS3ZxOawEl9xprWyO4g5LlbQYrHn67wWpqBzXDbNqy3r4UkaBWQm
 6ocDqugGxUoMCm9Ywq+LuHw7yvkLTcwiD6Lh5v2uybzNUxHG0nrFi9Hx+jIRxtOOpRRYJku
X-Received: by 2002:a05:7300:d507:b0:30c:1276:cdf7 with SMTP id
 5a478bee46e88-30c5bc78138mr1758446eec.25.1782218769420; Tue, 23 Jun 2026
 05:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
 <20260619220820.301787-2-andreas.zdziarstek@gmail.com>
 <5e0b06e0-5003-4242-a1b0-ea76fa5808d4@kwiboo.se>
In-Reply-To: <5e0b06e0-5003-4242-a1b0-ea76fa5808d4@kwiboo.se>
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Date: Tue, 23 Jun 2026 14:45:57 +0200
X-Gm-Features: AVVi8Ce6pzgwauxvJ3EPAj0PGSg_zRF6u5Dz9jyZWaojR2icpPUgUpM4ItrRW4o
Message-ID: <CADU25K+Ne+4up8qZYKO1SdvJTHYn_=H1qUbnTuAY8UVW7ptc+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rockchip: rk3568: make the WDT trigger a first global
 reset
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Jonas

Am Di., 23. Juni 2026 um 12:53 Uhr schrieb Jonas Karlman <jonas@kwiboo.se>:
> It should likely be enough to configure this in XPL_BUILD?

Generally yes. I'd like to point out though, that PX30 currently sets
it unconditionally
as well. I thought there may be valid reason to do so in cases where
we don't actually
use the mainline SPL but an rkbin miniloader blob or something. There
was a mention
of that in rockchip.rst.

In that case, moving it into XPL_BUILD might break, depending on
whatever the mini-
loader does.

>
> We should possibly also clear SOC_CON1 to handle reset in similar way as
> TF-A / PSCI reset. RK356x boards use PSCI reset in U-Boot proper
> primarily to work around issues found when working on [1], using first
> global reset seemed to wipe too much information we may want to retain.
>
> [1] https://lore.kernel.org/u-boot/20240202001221.531207-1-jonas@kwiboo.se/

If we want to clear SOC_CON1, we must do it at init as well, as there
is (I think)
no good way to clear it during a WDT reset as it's hardware-autonomous. So this
would make the BOOT_MODE_REG survive every global reset regardless of
cause. Is that the intention?

I could see a wrinkle with a watchdog specifically: What if the cause of the WDT
reboot is related to BOOT_MODE_REG? E.g. we built a U-Boot that somehow
locks up during USB boot, then trips the watchdog. The philosophical question
now: Should the watchdog go back to maskrom again or resume the standard
boot behavior? I guess my expectation would be the latter but not totally sure.

Best,
Andreas
