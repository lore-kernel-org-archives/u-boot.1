Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B997CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF889839C6;
	Fri, 28 Nov 2025 17:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ClYKLCYp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D544E83A5C; Fri, 28 Nov 2025 17:11:11 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13DF983957
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c7503c73b4so1162522a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764346266; x=1764951066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7u2+H5AXePJsFjU1M5tz3yKIpXpC2EI/c2TSGwpKY1Y=;
 b=ClYKLCYpvXX8/EBtl57UMBIA5YAKk/bOmBHg5L1HjbHclGYkAUw0AfYd51lfgfsdV8
 TvGt8kqdyVxAeMUFaUEL/8I+1+iT+sG53ydingjKYer6408WmMBANxf8IF1fT2xhFDoz
 2AHuAsOEh1sN8QpGhlt8c77AVZhHY1pqPm58k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764346266; x=1764951066;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7u2+H5AXePJsFjU1M5tz3yKIpXpC2EI/c2TSGwpKY1Y=;
 b=VivrenWf5Vwr9EC3BSjqOF3ZLEBeqDlxs9ocWrzV++KbGH8qJhVJWvNItv9bt/0mU7
 yHz5jObKwQIdJqG7mbuus0ntiMHQnoo29mFcXdj5rS+3ew78yPtaVh2dQsSuuvvi0sUk
 T2EB0gMhucG9Pm3SGJzzJwmyOwwBABjO2Lfl4GErxWUTRpriew/NfABQvp8jUim6ruaY
 5ziHN7ZrC3FX5RLYs2Y4cPWLFDjzsb9TlYNvYt0qF56zZCaQl9skMh5LJp+FlbamXMlc
 +ncbymfzmoSnzX5NjPkKFhAsWnl7WYL31wxYQV3X8NSmojHS5V14NrTnKpo59OB1nD3X
 asgQ==
X-Gm-Message-State: AOJu0YzZJ9NmD5nMfwlQKyZecXMyqzjaCE4vczfEv26NbHdOg0R9Byio
 Ey1DPs494JIwcOwhLJmSqxraZnkAHYQX2xX9x4Q7XgSixiJ2aa9fe34uB3S5S8eh1QU=
X-Gm-Gg: ASbGnctDxe3WQHvfUsCH7C832qPImdeExGZDE3OToZzjaIQi4k/mIE+J00tVKOrK7Le
 c9HkGQ1BFwBmAkiNQwI0y28bapmEVWOH6IamAqY3hnZ3nNYzy4u6HiYJHE1prOXIAnQ6zqV0cNk
 mLLHBSpyPgg0xaTN+rjQAiU3cFwHTbZLfMhWt+bph3eaSSmkuCm9qVn7kyDwsx4VMcEIVN97MvA
 ftkxjTjJlKrDbWasgozTtYCg0wNkV8HQsu9zc2YLLJ8jR6PvppFvSpmwNmRHlN9B5yFyc3PbZB4
 Gnp1kBdJ4jEvFvVRvICR2+Hkpvpxy2gp+PWS/7aKlKrbSAy9ucsGcA/IVkS2faJqvKOnqM5An9V
 UEG0JVxsDQT+s/R22VLHu1Y9LVjeYDnw6iU0tqfoDO9RP7P1vWSmNHjsJGnTtl14DdaiZc1OJED
 6/91rZliHsj7LhTUQ3rJ/OM6NDyDG/jh5AdVQvvkx9LeLUlov0
X-Google-Smtp-Source: AGHT+IGXVO3PMk1rnvrUhiUNU/a9aBzgp+yaLQXZ+Mr5893CFjbfDnU5HNS/N9fZMDtdr34x9HHI0A==
X-Received: by 2002:a05:6808:f8d:b0:44f:6a32:535e with SMTP id
 5614622812f47-451159c88a9mr11897368b6e.10.1764346264722; 
 Fri, 28 Nov 2025 08:11:04 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dca3e8a5sm1957358fac.7.2025.11.28.08.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:11:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, mbrugger@suse.com, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <CALeDE9MjchwyyuRahALK9EU=ie1BuAhBgP2M=hXt4LAmYBo3Rw@mail.gmail.com>
References: <CALeDE9MjchwyyuRahALK9EU=ie1BuAhBgP2M=hXt4LAmYBo3Rw@mail.gmail.com>
Subject: Re: Pull request: rpi-2026.01
Message-Id: <176434626410.216060.9632287798852009379.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 10:11:04 -0600
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

On Fri, 28 Nov 2025 14:06:57 +0000, Peter Robinson wrote:

> Please pull the updates for the Raspberry Pi.
> 
> Updates for RPi for 2026.01:
> - rpi: Fix DRAM size reporting to show total RAM
> - rpi: Use the U-Boot control FDT for fdt_addr
> - pinctrl: bcm283x: Add GPIO pull-up/down control for BCM2835 and BCM2711
> - rpi: Fix compilation with larger configs
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


