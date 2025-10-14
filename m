Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EFBCCD193
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 17:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16C58323A;
	Tue, 14 Oct 2025 19:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YWIXewxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BA883303; Tue, 14 Oct 2025 19:03:40 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36E3807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 19:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f715b18caso2834582b6e.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760461416; x=1761066216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBjIO1Keb8LhBenjx5Tp2yNaqX8qoyCkV6gW5SZvTs0=;
 b=YWIXewxPvJNQDbWb76soSvBI3R1vNKkvqWlp+DJ2m2j2tefdetAo2SGBQHa/XTHmHc
 YfLxoUoiDjFsY5B+NTd6YS52arMJ0rVXtkIw/HfvyQcG44hRpCbIR6JU8GcztQN674vZ
 YmpjAHjYx3BvijfRzMHgk++OUecO88dykDi1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760461416; x=1761066216;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBjIO1Keb8LhBenjx5Tp2yNaqX8qoyCkV6gW5SZvTs0=;
 b=PNb9PQmNtnE9k7F22OWTIz1pudd3TaYfIMqMcVvAr596ihruzvTCBaVL9/ryLUpWHQ
 67rkhIK9cWFiIpzhgYMfVYmA4QgfXJLMxJs3LIUmu7fNO4we0qoL1UPM4hxUEqJ2fFtm
 NilyIn2uLjDqvr/MUZ0362Gi61S/HAGVxO7RLf8qpvQ7x3DOcffIuNToxDRIMcbGsUAo
 yGclDDP3IIznJ+1TDEyVAibjJw0eIbZGqnPjIOvHudyd5OOvTOFFr6rtQA3rNnFQBW3w
 CxstYrSYw0qjeiic4CETEf358gyF//FiqSid+9Q75XLFc2dMLKFCoBmxHJN0km88liJG
 JLdQ==
X-Gm-Message-State: AOJu0YyuUkecUhJQhwj5HP5ZAwJ7ca2KmRXkpVXjfqWf/71eQnMXaHSK
 6LaqtH7bTT0q+BXrbX8NR1bHXuajP0xzqYbnemajsPKmOs4ShHtvDmURi4stsrV1iifVkbTjty9
 Er+B2FsZEog==
X-Gm-Gg: ASbGnctVHzj9He/xY+h7LO51fZZ6Oih28sJ7cp/oLtmR42Y1p9xQGSIefU2d8JxNNGk
 FIx8InLCpxqfCYoOTY3xoQUvTRY4P5/T+P3JaJAs/RVyx85PwJamG4iTUnVETihR8HXAKdWpjK2
 htP8+RTFCRANfPPbI308WEISpOgBrVOc2ojY1COLzRj7NgJJg/hW1Y5Dn5noV5gtaQTz3LtJpTD
 VXHT3Qht0agDhoIcYkXvx0v7yncw7puMD9UcKM8dKLwDyuoHjGggmwVTmaJwCKi6ZhF9iT7xMYI
 KErjH3SiMtEbEdfe/wuW7BuzZFEDVZZCxatAN6DiZO/XvgY4kGSc0WMr0a72f6tLB54nID0M8Oz
 X8mBzZ31S8X+GLE2NASmrUdRkgSTVOj36O5zPtcWbtxKNdXDz0ST8a1iEzw87ye7xqnpVVHXxJd
 O3KAHKgUVmfFypgw==
X-Google-Smtp-Source: AGHT+IGnaS+C+bn69Rf+mZyd4h+hsZFSEmR9HHb3PGwm/B4tzpTZK+I6SfxK7rHAIBXTTD/Drzu/Gg==
X-Received: by 2002:a05:6808:170c:b0:43f:76e6:871a with SMTP id
 5614622812f47-4417b390c3fmr11183057b6e.24.1760461416352; 
 Tue, 14 Oct 2025 10:03:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419887fd8bsm3415138b6e.2.2025.10.14.10.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 10:03:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <4ffe0d16-3b4f-4a00-a3dc-7dcd7239f5f1@monstr.eu>
References: <4ffe0d16-3b4f-4a00-a3dc-7dcd7239f5f1@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2026-01-rc1 v2
Message-Id: <176046141530.303005.15619020700967062839.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 11:03:35 -0600
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

On Tue, 14 Oct 2025 17:14:30 +0200, Michal Simek wrote:

> please pull these patches to your tree.
> I have also took FWU patches which are only for our platform.
> 
> Thanks,
> Michal
> 
> The following changes since commit eea470fd7f6a0db9fbdf8ab187a8b522dbb49c10:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


