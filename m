Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DD3FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9F118447F;
	Sat, 25 Apr 2026 21:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UwtlpkCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F401C84312; Sat, 25 Apr 2026 21:25:05 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F001844AF
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:25:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-50e5b55062fso61199581cf.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777145102; x=1777749902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9a02FxZToIZRATXD8zqX1UmnH5u93q82eY4KTMKdDq8=;
 b=UwtlpkCrsIgze9BPJhcLlo+FjBvKwxOaErBpWpG8ZWWJk4lNyrj3it63cM4MmlBTTg
 JJmxEGVnlFWrIvrFve6Cx1IN+3xVrZOkz4X0O1tSGp81mtBEK4XEBh1SU+MSAMHVkcCN
 +MuT/PZosAw2STG+d3ThHIkQSQg+znV6zxnI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777145102; x=1777749902;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9a02FxZToIZRATXD8zqX1UmnH5u93q82eY4KTMKdDq8=;
 b=Uf/rCZJ5vk6Vt2jZliEol0moJ1Iq3t03vuJj6FkF1vTkEsTMtxvGQPon1LxBup8QPp
 8VhKFyTMT28IDkuaRkh0ThSL2aIwc1hTo+Y71g2riRghcnlUhSMTxAqa3g+oKe7Pt6Ow
 GGa9jTmvwI0UvMGxUxj0B6ih3jKD52naj2ehMF+YDAd3V/u8LNzMwWjDbjqlY17SxLZa
 6DBlqUyOmRk5SDTgW1DbX86/OGrc8mHhUqnlaX9uzDePAAUPRQsOxkIYymPkv60ylWdW
 qVAVJ3FibY91wezGuKTv+sJeskisBxbjSpYcZLn1tU2X1D2OJQqtUB0aOkTxZ/QfiXxf
 UL1Q==
X-Gm-Message-State: AOJu0YytSKBYxRqPsKZ/bBAOVInSbp+gV9LzZXAyxdNs4559sYNaffbq
 72HAzCeej0kQaQUXqNUcqFOEcXtRcocSgBTQ5CQND89FWgd/DqZuO8AKTtVQZErUQC1pU3GmogE
 TrNaiO8SIjQ==
X-Gm-Gg: AeBDiesWf0FesLiX/IXESzqyPpR7CuNGT7iH98wb+D5pZXAyOzGP7xdivpZYDft3PK4
 PziU+C7XanG75MVbSR2ParSekAMMEhZnYnlkxOQa1IoUTXKRW6tOOz38IFdrMbu9vIcsr6sqrEf
 VldDdjHjNV0uuuCSgeL1aI0F630onnSlNgBreisnk8Ok9FA7bSIe5oXf1sibGh10iawx0bwo0cl
 u2YQM0u+DcL304DK6DpTvBhYWK7/vgIRTF7mnpzntRH48bviWXiqDmcF9Ioh3YEOPEj7SEE0iPa
 zkGleL/V4T3eit+jiL/k1xLPiDSno5BQanuayukFa2MhjNHncpdJAzgDvBTw3imslpQR2QSYdZ3
 XHJpVkHs9v6vabfd61F1N0bknEAhwxvlT/uVRqUnafhbKpFKO6B7/eX5C5gyMMFpXAWnqor5vZX
 rsRiN1GtWnMHSb/cmefWdgiUfQ3RTzFV7nL0oQWK+l7ePtz17BhltLmZnRiroNTYBFfcMdTjNxB
 ql6ASa/BFmQQvbfVSwh2HFBPIfu3ITz/dY0lvQPv679Au/7/Yj8yk1TdOET
X-Received: by 2002:a05:6830:67ec:b0:7dd:e032:3cdf with SMTP id
 46e09a7af769-7dde03240f4mr7949105a34.19.1777056655683; 
 Fri, 24 Apr 2026 11:50:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Levi Shafter <levi.shafter@elder-tomes.com>
Cc: sjg@chromium.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <732a4d19-0e19-47ed-9f8e-0f28b8c50f73@elder-tomes.com>
References: <732a4d19-0e19-47ed-9f8e-0f28b8c50f73@elder-tomes.com>
Subject: Re: [PATCH] Makefile: fix host CPP pollution in cmd_gen_envp
Message-Id: <177705665494.2527258.800841046817921724.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:54 -0600
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

On Fri, 17 Apr 2026 16:45:09 -0600, Levi Shafter wrote:

> Commit 2956a84 ("Makefile: don't use CFLAGS for environment text file")
> switched cmd_gen_envp to use $(cpp_flags) so that KCPPFLAGS would be
> honored when preprocessing the environment text file. However,
> cpp_flags also includes $(PLATFORM_CPPFLAGS), which carries
> architecture-specific flags such as -march=armv8-a+crc set by
> arch/arm/Makefile for CONFIG_ARM64_CRC32=y targets. These flags are
> appropriate for cross-compiled object files but cause the host CPP
> invocation to fail on x86 build machines:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: fix host CPP pollution in cmd_gen_envp
      commit: 9f61fd5b80a43ae20ba115e3a2933d47d720ab82
-- 
Tom


