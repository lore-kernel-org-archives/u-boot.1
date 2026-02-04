Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BCAE9D3FB
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 15:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 721AC802C1;
	Wed,  4 Feb 2026 16:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G2HQBEct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94C78063E; Wed,  4 Feb 2026 16:29:10 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE9D80086
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 16:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45c7a71ba20so2380884b6e.2
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 07:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770218947; x=1770823747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVyq25o/pmZfMZzIOB0zelIwzApBus5UN+nLBA0RiAQ=;
 b=G2HQBEcttfchedBgKy9sKQuyL0CgDNqFyFOf5RM5JxX++vrkPjVsNskKTMhGunhtNI
 eADSPElTpkvW94OF1C3rwkm0Wr4FSC+ydl3hnm2K//YNTf9GXWfxX66BZF9lNidTZMzC
 QQdJzFzuTNmJq3qVSl5tqiWwMf+yNikX9XRTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770218947; x=1770823747;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wVyq25o/pmZfMZzIOB0zelIwzApBus5UN+nLBA0RiAQ=;
 b=u6Sm6oebE2cncHShAyvKM4lF2bActhsj4MNPXIfMRSONnxFJf9Pg4gTqoFTjSEpnKl
 9GdHDDuqA5DVrfwLuF/6zLsR3gGVsQ3slogxVRSZF5AzWaXgV1F0Gho2EfuUt//+CcsV
 v3eE8efSO1Vvdp2JGHLQsggpN8G3rlbxwPvE4YrcLozBRmsnEYblo8akZYA0GZS5WUve
 SeY9b4gkLvScPGlINzYLitEMPd7cT5BmqGTQ7OeOo7rLpduKCq89RzEcVp+c//cMzWgG
 S9CGsuCebcskbrvBCJDG4G7f3dPxePfCj98C+nqfiNnO0+QabO0KEZwRxM0vEVa7C5Bm
 7euw==
X-Gm-Message-State: AOJu0YwTePn+tlWSChhgYr154q2yv9VvKI4kCy/DYPRVMn2oQtp1JMsv
 3jDjDsPK3Lr4+t36aFMIs/SjbXiRHOtmkHC2IshniOSq5KKr1yeIZtKoGZ4+6KisWKY=
X-Gm-Gg: AZuq6aItYVBdUOK2UXlindzrQv1K/Lx+ZJKAK2LcUwjKlFU+slDOftQvEola/03t/w5
 CTC8Pq/uYb1nHHtA5mec6ldpiCsz5UdZ1H+AXZaRm96B/RVId29Ixg3NYlnMz9dHjGzHtDxSRlD
 godpjmlgzSK3z1eBKT+3JilnqsQfDAoKNs4EAdjmsYqD6pRPpFdvgp17XMiqI9tfCcQMi4QLkwy
 3SIngXFehmR73sFIZYJ2W+JKizHLInUU0We5sZInEOOoJJ7Kdl9of6v+vDqlTeiAalnAq7xXvxW
 +U/tWFX7U9OhOJ1atGu1NLF4ymb5GC7knbKBDZMsqb5VcImdIiuUl4EaxF0xg7MH1Ycs7Lwydl3
 Dp+DhskP+62uyNbb0YdBcXmIJskGBLDJa4t92x8K+G5fRvRe5LFJJ2nVjOPyy05AuClkxQlnPcj
 laa/Nide0Hz5/ESv6kLgxZ4LU8oK1Ltso8O76z09kqdGNWMBHGouDlpQswTUZypLp+i+SMvYLx9
 DfYpaGA816jaWmxAmDE9JguirGRIDqU4empwA==
X-Received: by 2002:a05:6808:150d:b0:44d:b72e:ec1a with SMTP id
 5614622812f47-462d5a75d8bmr1770712b6e.45.1770218946903; 
 Wed, 04 Feb 2026 07:29:06 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d67d07absm1499301b6e.19.2026.02.04.07.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 07:29:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.denx.de, nd@arm.com
In-Reply-To: <c0656bc6-cff2-425a-9a5a-063a242a97af@arm.com>
References: <c0656bc6-cff2-425a-9a5a-063a242a97af@arm.com>
Subject: Re: Please pull net-20260204
Message-Id: <177021894524.1757122.5789501284642550111.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 09:29:05 -0600
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

On Wed, 04 Feb 2026 11:32:50 +0100, Jerome Forissier wrote:

> The following changes since commit a8d982e1f1726254ef27bbdf362f98954ee3feb7:
> 
>   x86: cpu: Fix crash on FTRACE enabled builds (2026-02-03 12:51:43 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20260204
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


