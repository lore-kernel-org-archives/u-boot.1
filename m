Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336D3CEDD8C
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B649283C5E;
	Tue, 18 Nov 2025 15:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EM2aSfKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4A3383CB1; Tue, 18 Nov 2025 15:05:17 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801BA83B95
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-74526ca79beso4235960a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763474714; x=1764079514; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d79fin1Q2lQw1VmEvyhaxyk9xelWGYnPJARjHJRMuzc=;
 b=EM2aSfKa75MT7N+D31NMf44Q7kJmlAq4Sr3ujIOdHAZN+3qsv7pxlHaxK75AaFejPo
 0ZNVS5mjejjC5VRMnpMVp3B2NkcBdlgGtibfMPMGQozTUTwFphWQBq3UCg3UHh8b2GbG
 nBImvUaL33kcEllIWrfNEgo5m5AFtR+3fBTFYSy79ij/lvfIg3sWgmJMAmTJRUHU8/2U
 5GxsgY3HjkOMiB20fH7tqYs4goj5Z7dEj3V8q1pp37C1wNv+QoMTj8P+TfHqoOLEXS2e
 EB9RuzeBbTtXaWNlZLm7feSA2Kp5yy/LXgZWpvFiQhxET+cQf3/CA3JNvOQnAJ2hEBFo
 BxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474714; x=1764079514;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d79fin1Q2lQw1VmEvyhaxyk9xelWGYnPJARjHJRMuzc=;
 b=M1vOdHoWLSazHDIGD8obL6PWigGDR5BEDij5Az+CnGRiP9yUVzoUSvSUAtngXnEvWo
 jcce6fZcgA9kk6fSG+qrhi+p4Ru+MyHEfrrQZNOjppFBJFsGKNRM6copXitf5zaulcHB
 bme/PMZ6YXEinMrrKBAY8g0wrL1XkZSqhJLIcT7lTS+oZOQLpbdfqSPKkEBTDpEQGvim
 cZqOtihgjNU3ljTlNiSoV9dO58gzorhzZ8jxIDXnwlDnVjzWhHKhp+O4MdXniIyn94x4
 mGRIGZ0I+YHhjvPmdPM6IGRkSIgdjOYLryaanvART7I47INLywkCGyp9aV9VFkaN2oRp
 LnTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo7g6xfFnIiFdh1slf/I7cNofvcVfgDiyNxadW+spVlqH9eHkzwtiMZFNRoYEFfxj0UQ8Wz2M=@lists.denx.de
X-Gm-Message-State: AOJu0YyYk9V0gaw6dcGvZhb8VG/83ib9UvHckeSRODAH9mzAxJm5kqj3
 5kUNNQC4nUWDFIwE4l5Ec+jlf7OhtVE9kbmz2+QOxOT0/lFGpnlJNi6UKr3OQBMMsjnYZ1uNxIq
 QID5pP5cRzkStHedcTorkT7m8R6pMFplGeQyg
X-Gm-Gg: ASbGncuoDPFD3xXpopcMcy6t60yq7mKYz+DxIiBJ0dIs9GTcldbPzmb0iI+hvMXX+Rw
 gqRKPgzw7YpeQROjgCzYPzitBK3Ak0AT4g0pDjTqIDeTdrJ0O23KdpNYFuMCnGGJ7cSMttRM1JK
 Ja+qEYVebYQaJVChoby9NM0xnDH0LtRONNjByrKJIpL5MFdQvJLP1t+4a9dhvKXs9krlyWWdKJF
 GOdBkzizrylyGIcyIeBGYzzX0iMwfsSzIJe3buvrPY3ZNNnD7YZgNW8ZcaNLbfiYV6OP/s=
X-Google-Smtp-Source: AGHT+IHmheU9xyI3XXPBF9+M6T0U8X+izjhSW2V1MGzuAHEgjt6aMM9PNHulx/wofVAmzUPN5rY64tZVLluA9wpk3Zc=
X-Received: by 2002:a05:6830:449f:b0:7c7:c71:849b with SMTP id
 46e09a7af769-7c7444659aamr12270640a34.14.1763474714120; Tue, 18 Nov 2025
 06:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20251104223023.1613-1-briansune@gmail.com>
In-Reply-To: <20251104223023.1613-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 18 Nov 2025 22:05:02 +0800
X-Gm-Features: AWmQ_bnvOTZO8e-kctU0V7he9ZCI0iH4fzirtUDMQPOUhgTlZZz4IThEiY_FVo4
Message-ID: <CAN7C2SDRj7qXakP_nv6G9su3HAy+jBbUvORB=q5zc36omwCTFA@mail.gmail.com>
Subject: Re: [PATCH v7] Add optimized Makefile support for SoCFPGA handoff
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tienfong.chee@altera.com>
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

> Add optimized Makefile support for SoCFPGA handoff
>
> - Introduce socfpga_g5_hanoff_prepare target in U-Boot
>   arch/arm/mach-socfpga/config.mk
> - Users can convert the handoff via make prepare.
> - Detects Altera/Intel SoCFPGA boards from .config
> - Combines vendor/board extraction into a single shell call
> - Checks for hps_isw_handoff folder and .hiof files
> - Uses ls -d instead of find for faster folder detection
> - Runs BSP generator script only if files exist
> - Non-blocking: continues if handoff folder or files are missing
> - HANDOFF_PATH user define allows overriding auto-detected folder
> - Minimizes subshells and other slow constructs for faster CI

Any trouble on this new compile flow?

Brian
