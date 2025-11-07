Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9806DCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6CF83D2E;
	Fri,  7 Nov 2025 15:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qw13FJUA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609C983D7A; Fri,  7 Nov 2025 15:17:05 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D4D83D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 15:17:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c2816c0495so480901a34.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762525022; x=1763129822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMV5/t65LucvtJgYPRmAH6KR6IviXJp+89+szTc/Leo=;
 b=qw13FJUAEHpycvmzH7CUURYmz/WV+L6xrJRU87Lgw9QxujR9SI5zzKqhuVjhBOI21z
 pvorTHQzbtUcX36QYP5hCrVYr3FZdnFh+rF9I9HxMr/FUl5NLklhf936rVXlHXbLmksI
 9zftY8bhc0rP4O1KBWIHpU5buXawzRlUVKcWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762525022; x=1763129822;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMV5/t65LucvtJgYPRmAH6KR6IviXJp+89+szTc/Leo=;
 b=hJrIjXHzpNsaDLPQJ44Jyapl8flrEwnef9pdpqUYM4MzYPsl5aoAkCKcT+yoaiaxFA
 2goN7wk1Ob1W1Q77mLDIdO6oe50js0JfsbsHi0BTvaFtjHlELzlWEdXWmPZuDs7PY42s
 cD1XCuRwro2ygghZqLaez7FdFPvoVdj0QvT50nH0FLtWiIXXlbh7WbhJ/wySF7pwipKk
 xYJ0t9w9KpUz1FOt9Dl/1w/AQp5rRzVaqiP/hVQHWksts6bzCuAuAtfLPeUsGz85h/NQ
 qKQvIoS/YJGvhmNDqNA2xQSNaGrZPJ3sSspbupkajnfcufC4f2gYNkod1RfI+/5rhZti
 SCVQ==
X-Gm-Message-State: AOJu0YylUZZmY3SKeW5jZbXF4vhiCaQXcnyIUoYGlSHGnVGGElkZk686
 BMCaljnBAcS3cmn5gp8tXw9proJeoKab2RtY7J4e7x/QOrv85do3++fxbd8EHM7TsU4=
X-Gm-Gg: ASbGnctt7UkXnsQ5cIuRWSHJ89vREMCa6xkgv9y8dBchCAvSgZ8IYiF0m1es5gNyxA6
 7IdjhwCdDjnzsejj7SnznHmLAMHtNFNTMPY93S+poS/NIByJLQtevfIE07b2xUp1mRvp1yQxigL
 scS33k9mLc5RTLcnKS8teGUnF5uPk80OW5itILI3lymybI4VzT9UFrsb4amAJY7+/WHE45+i9gr
 fy+YWFquEzxUcozODazSWEDviqhtle623o2I+U7jjNPv6LBCBpQ19HSyvtKVQ+IotfNliHQmReA
 iCrW40J3QatzPKy8bNnhOe9MaPnicJunBLj1H5+J8QY+d3jM+wxJSREm728QOhk+mO35skBDjxu
 IfjPGwQKNqXQdryC9sh8kzz1UxJSVjO6axKa8ygcCduHjIGmlCxdQjHjePHPv05DfNtM9Ix/V0s
 Sc/6kNjBOhGXb4a3AUguuedQweULDReBalXPR0cg==
X-Google-Smtp-Source: AGHT+IHl1Eufv8UWEhq57fHGeqgixNlNKq0EPmGjCobXKv0qfUPXU6m9Ms4W4fNx/vCDT3Ht4WIUnQ==
X-Received: by 2002:a05:6830:7189:b0:7c5:3045:6c81 with SMTP id
 46e09a7af769-7c6ef96a2b4mr2352222a34.0.1762525021922; 
 Fri, 07 Nov 2025 06:17:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f0f0bb8dsm1479692a34.6.2025.11.07.06.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 06:17:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Huy Bui <huy.bui.wm@renesas.com>, 
 Tam Nguyen <tam.nguyen.xa@renesas.com>, 
 Thanh Quan <thanh.quan.xn@renesas.com>
In-Reply-To: <20251106221010.373101-1-marek.vasut+renesas@mailbox.org>
References: <20251106221010.373101-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176252502107.3410992.623732361304785125.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 08:17:01 -0600
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

On Thu, 06 Nov 2025 23:05:47 +0100, Marek Vasut wrote:

> This is mostly R-Car Gen5 drivers for GPIO, pin control, RSwitch3
> and matching PHYs. There is also a few trivial clean ups for arch
> headers and configs. Board code, DT and clock are coming in follow
> up PR.
> 
> The following changes since commit c488907f91ec90bb6a93803b1db53e24b93b52ea:
> 
>   Invalidate cached FAT device upon boot error (2025-11-06 08:31:34 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


