Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4779CCFC539
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 16:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2965783B43;
	Sat, 22 Nov 2025 17:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y2wiN3mD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E64839DF; Sat, 22 Nov 2025 17:23:32 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30905839E8
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 17:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-657244ed2c2so608567eaf.1
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 08:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763828609; x=1764433409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQlc7CqqcihgnXQIcaEP7bsxf9hKHsXI1fqWRoz8d4U=;
 b=Y2wiN3mD72BbmF5RCChc2o9I7q5v/rTMSncTC2eXYxJI5kv50JJxHQGN03X8Q64aNi
 5YZZZlLSZPDjwI1lF+WH5Ch2jKxPn8MSz3vwsAZ0oyGn7lnAIG/16KvNstUbBYCe2NZD
 UPVnDrKW8Rmeo/Km4zHT6RLXIGP9fmrpt6pdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763828609; x=1764433409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQlc7CqqcihgnXQIcaEP7bsxf9hKHsXI1fqWRoz8d4U=;
 b=OUhlJ+LYVsoH40oeswp7oWrIjG6tk73u5SXxU/CzyTraCUCjE+WQXGBepwBTpXcyz2
 voG52cJIlut8v/sh0Be4gUPuhnAbZg38Ofuiu/KzNbJw1Cz0dENm/sDUjzdrXS2ibk7U
 WR22ao+fJFeI1uEHqO9LIOePhlVL7R9yo4uCmohJMCzdiNQW3EA/fpW5iqWGKNHYYnln
 5R9p5usjtcKcw+SFWoDule3hEKE8UeitRCT1YvDgmDEeiZ1BG2AjPiSmgwKm97EyaKku
 e2DdsT4Jons35HUTw/ZeVn86jTNh9TgxpxHhdfOIFdc4t2aqcPVWybaJKTuwl7tFcLQR
 fVvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzK7OYTif+x+uTxd03Vf7U1qDGpZBDPd2QTkTSpMd9XYynLeq3QlWJKbW+mV4luiYGpF8WiEU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzn33DwYnnSObNHlsQxUQuwCoag/BFUYYOakEJu/Kk9q0YTElRc
 Njw2Xf58vhSq1n/OoNlC25njA2hsXIpepcLoynOkPlt16+quY/KOGXEwbgllFCxDwGw=
X-Gm-Gg: ASbGnctA6l5bZ8QUz16i09AabpH4xnqgBaz2m0o8bXUR+h+8dIANICUGAkjLmd8Zl6v
 WJO+hA3JmajZle0zhKwvG44bgm+IXFnUca3d1ajL1QLUDKXldWBP9EDdcfUGdKkqmJCPxQ1bjAt
 AuQ1Ut4YqjjUmRQ/8bgiXRqQR3vL+J4zHxyvnHgXjpYjf1/a+lQXJx0p5Lr0qWWz62lYAruAHQL
 M0kWKpheqB+qE56GUH4at9CM23VOLcxpr3wPG5BiGTKkoAXD/YbBLkebZd2iYICPH21vW2lqCU/
 2wozIUOklCDmxbFqNCqZOpkdyVEoOhCnzCOycgJQq1n5V7KsUlDG3Yxb8Q2C0LXm6ltCDIDyUeh
 bxDH5npxl8RSbOn8+j1nyG8t90FvAahwNfisu/NE9Mia3MrnrS/Vx5+ktsoQLddpNjnwM1AvXm0
 yuOHKGC2X+zuZDgaObXRh+tnzWBwun/wlUuAOjPctbH2BbQ5Kb
X-Google-Smtp-Source: AGHT+IGTbDgX7vRdWghe1RaLJFuuELhX0YxF4HZndSK88jjNYsyBw3d9SkafGgGNyf85X4fqnJFwfA==
X-Received: by 2002:a05:6820:1c85:b0:657:633d:7361 with SMTP id
 006d021491bc7-65792570d26mr2101120eaf.4.1763828608899; 
 Sat, 22 Nov 2025 08:23:28 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782a359efsm2488378eaf.4.2025.11.22.08.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Nov 2025 08:23:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, thomas.petazzoni@bootlin.com, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20251117152308.900316-1-kory.maincent@bootlin.com>
References: <20251117152308.900316-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH v3] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
Message-Id: <176382860770.3054897.9752991238920009623.b4-ty@konsulko.com>
Date: Sat, 22 Nov 2025 10:23:27 -0600
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

On Mon, 17 Nov 2025 16:23:07 +0100, Kory Maincent wrote:

> Fix two memory allocation bugs in label_boot_extension():
> 
> 1. When label->fdtdir is not set, overlay_dir was used without any
>    memory allocation.
> 
> 2. When label->fdtdir is set, the allocation size was incorrect,
>    using 'len' (just the fdtdir length) instead of 'dir_len' (which
>    includes the trailing slash and null terminator).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] boot: pxe_utils: Fix memory allocation issues in overlay_dir handling
      commit: 2d7eee5a55472f885474168acd3295d47a559755
-- 
Tom


