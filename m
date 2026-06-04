Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9D0CD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 23:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3022584931;
	Fri,  5 Jun 2026 01:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E1TuC7uT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345FE849AF; Fri,  5 Jun 2026 01:05:06 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130E2848BC
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 01:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e61e25199bso529744a34.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780614302; x=1781219102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/3oNti3Y++tQI8z8sU095/e6f/QIDRsSfgFnpak6N4=;
 b=E1TuC7uTDJzbUyDxwt221Jm01DLPCSxf+ajbq4qqe+CfokoC2tSIDt5Nmz6n9EbGsT
 jIJc4KXURpQhOLJKCN6qCEK0B3W/3x3gQNHBHW/Un72itRBP+5LQPvK4tIWsCHDq+CPe
 e/nAOR/HHN4lyFSkZvEWg66UlwavJZaI9+hAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780614302; x=1781219102;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4/3oNti3Y++tQI8z8sU095/e6f/QIDRsSfgFnpak6N4=;
 b=mZhZCffm7F8wWiQ+EinEyAx3yKIEZMTcwTse8oz2OKMdnwT782DEKBSlPRslJIjgcA
 l4ryxHPa37yd+x3cM8PWhfOFC3utgzzAn0bycB9Sv298YpdQA8p7CBmlyydXYkfU6rzd
 VO6I+FiwE6WY3ys6mF5IQ4OMFuIZwoceXESHx2cmlgauHSB+4znUdQutqy5ZnVjK3McN
 ZuYacnAB0//fjuojos5QcL1obhKXM3uPjaWhSBN2UIZ4HfMO3Ee10602oychEesGSwsr
 Jp76NIOuOvCzYfLEABY+TX5z/2f9uJcsLiT/XPXAUzaiJrXRKLpoKrKxosm3MqVyiLRB
 lepg==
X-Gm-Message-State: AOJu0YxGe6iLw6P3Rn/DxlCLInt8JAC2xejUvQYVVFuAV9hGRnJoX7xm
 VFpDp2J9ZMuwdxPeCannH9WpiinENv7NDwUuCdBGQZFJDsqLlsecn+o61RLEWPio7UpLYeoyOCc
 aMlGQpIk=
X-Gm-Gg: Acq92OFRwEnS/Ut+ReihmPibBt2XwhzvjeWTKghHGKiybK3Yqo+jvQs7eydJOHdKjqp
 OP4YSngX9otDmlyUP5XBDHkMQN/NnGkhLzMNEDCIb7fmzsEG2J3u4KPQDg4PwmvSCBflVH1yAam
 9Uc9zGTjOHn4N2zcHYiuAYAGcxEsKTME2lB9Qia0KJqBnMOoPGWkNYazcNfINNVyAbOOv8jgVye
 Nrxv+6SEfDhEx6j4YwbGniTEKJEV2tBjQdUzPEi6/Yrl9oLHGe5rB5YyAM+1HXPKzPHrxYW3J4r
 RafYxKqcMCi7dtEAHqZnl7tCxu8hfCmGLBDx2iZMnjB1W1lIWmR9zuVLLO5r6leMXxjA7xukZ4e
 P6zXUAo9UifoBN2jXyfd9nQsO4qTdjaGBBYvLXZgFmbIWtT6kXt4jaTjPdc51FEe251VN3hbd7C
 PKYs4zxAMJbBUP1RXzQQW79EeOR/CM1L2zvCM8ANmjcx7E+K+9zcqzXbEjrWhckPBCKIpGORk88
 YBKk1EEzDWcNE4ZkqwpnOqUvzIqHEPUlJOVs3Du2oirvl10vn2eVisIVi7Y
X-Received: by 2002:a05:6820:1805:b0:69e:2f0b:a5f9 with SMTP id
 006d021491bc7-69e68c0a5acmr637331eaf.30.1780614302142; 
 Thu, 04 Jun 2026 16:05:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e46298798sm4167477eaf.8.2026.06.04.16.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:05:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260520001234.1555120-1-trini@konsulko.com>
References: <20260520001234.1555120-1-trini@konsulko.com>
Subject: Re: [PATCH 0/3] Cleanup some linker list usage issues
Message-Id: <178061430070.146358.10344417720052348756.b4-ty@konsulko.com>
Date: Thu, 04 Jun 2026 17:05:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 19 May 2026 18:09:51 -0600, Tom Rini wrote:

> Hey all,
> 
> In looking at some other issues, I saw the comment in include/event.h
> about LTO discarding linker lists sometimes. Upon further investigation,
> this was a sandbox-specific problem for which this problem was a
> symptom. Also, the linker list code has always marked itself as "unused"
> and while Marek thinks this might have been due to warnings at the time,
> that is no longer the case. This series corrects sandbox to not have an
> issue with linker lists in two files, stops marking linker lists as
> unused and removes a now obsolete comment.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] sandbox: Drop special link order treatment of start.o and sdl.o
      commit: 3ab8ea4a444ae798a173a25811081ae06cb358e3
[2/3] linker_lists: Do not set "unused" attribute
      commit: 4355a9a5f0065b31e19178a377bc5f0a7968768d
[3/3] event: Remove obsolete comment and __used attributes
      commit: 6e73890c739378776fe53f231471f202200bc79c
-- 
Tom


