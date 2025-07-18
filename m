Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DCEC83F34
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 19:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425F0836B4;
	Fri, 18 Jul 2025 21:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NGMb2FA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E87228361E; Fri, 18 Jul 2025 21:43:27 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56558361E
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 21:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2eb5cbe41e1so1591352fac.0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752867804; x=1753472604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MiiJz60cTbQw++vfbBgg0r11wB3Py3RFelPCFxpllWo=;
 b=NGMb2FA1+APo1xiPgFVJrI94dw8i2qr/1jXlbKnjTFFlK6YygPVxf2+VgJkRQH0zSv
 KGgn/Q2BaA0hE7LjJWMbsolcvfJlZeiQ//nmMbG2lKfNpsR2d8qNyPs3XthBE1U4fRaS
 poDrE7J3Wy672gEPLhvOtgoOLmDE+XApeIa6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752867804; x=1753472604;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiiJz60cTbQw++vfbBgg0r11wB3Py3RFelPCFxpllWo=;
 b=FrPVPH8Pgupf38ftubKujDmlhcSpU26Amk81dOPyemvGGSfPsomQp5oWJVYRotodbe
 pk5FV9blpUq4yMMZC/eDDcSYMYHX7jiS6IDGra6QQ3M5yMwRJ3M+UqNrPZqja8WLH/J6
 AUW4jhCgQoKaXtGjkff1k0PIByb+0zMns0W1c9WXJ7ibq4JELXF/ciqA0FCUdR+Ex8oa
 9dQilPHlYLOnqHLbUJV4qhrNjvfID1FpNKH2RoNE/Pd6XHB+N+By0B93B5yGoRFd/bVt
 kd5BHb+4I9dWyCYCafLKB8gGgbuO2VYeQPJV0NV2SiuoNeBX/PjCW2A3R/gm/qNDMqlf
 nqKA==
X-Gm-Message-State: AOJu0YxkIlaE69VaKVllE4znTkAKiKnWlT9XOtJEWU3yoUjcfVP0/fHq
 rlURoFg+7a0DBM2YcBT+DtnLlQvIT+MJem+QH/HJRGjCRfeLLpKBbvpsHr91wcqr66eXbLZQL0T
 jwwka0G4=
X-Gm-Gg: ASbGncucoEgfGeWJ1IbsrtvIv2SUUAhya6pyS+gxbvGCl+qU/FI6dDyuknngfxXjRAn
 uzuHagzqwqD3EwUCl6r/GeejXLHtSN1LZI8U/WffHvwK5LcG7fBSMnRMh2fqiq4bR63Xd/SAFni
 s+F8UMwJYb0ypzqpapXsLSOZEC2avp7ty6DvqMr8LMN9kObZYcBLqhxvpefr4fYLDn7luwubv8B
 Of90INMsRQxO8ODk5RUzY9/udlpa+ujz/LDcX6gmJHFyOE9tyaqmTz23OhZoRNZIzGSLNWV5Jrk
 fMW3JJy1BXG70G0n8VNGPAultP3PMDC52ltrkdQQ0gQ2y7J0C2YR4Hq0jtIhxeCeZMVk+9ZvdZj
 1rad2isuilmVo4yDcTYdS0JG3z890wmZVJ6Jv7kXzVLfoLJCxVv38mIVtbewFksIXsg==
X-Google-Smtp-Source: AGHT+IHkNKgCh8VDsPaldOSxYv6smrlTyahgMR0Q+dSEY/GZyrIfw4MUTxNsk956cnF5kF2iVlE9mw==
X-Received: by 2002:a05:687c:218a:b0:2d6:2a1b:320f with SMTP id
 586e51a60fabf-2ffd06331fbmr5783187fac.11.1752867804499; 
 Fri, 18 Jul 2025 12:43:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0be4csm871076a34.39.2025.07.18.12.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 12:43:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250711152012.2225465-1-trini@konsulko.com>
References: <20250711152012.2225465-1-trini@konsulko.com>
Subject: Re: [PATCH] input: Tighten dependency requirements for TEGRA_KEYBOARD
Message-Id: <175286780316.1647311.8053696905350360180.b4-ty@konsulko.com>
Date: Fri, 18 Jul 2025 13:43:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 11 Jul 2025 09:20:12 -0600, Tom Rini wrote:

> This driver requires headers which only exist on Tegra. Express that
> requirement in Kconfig as well.
> 
> 

Applied to u-boot/master, thanks!

[1/1] input: Tighten dependency requirements for TEGRA_KEYBOARD
      commit: a05c01c8e65dac94060d3a74220ac3da84e1cb82
-- 
Tom


