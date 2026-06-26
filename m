Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085A1CDE00B
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 01:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0F88497A;
	Fri, 26 Jun 2026 03:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mS9h4OB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52CE284981; Fri, 26 Jun 2026 03:10:36 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A0E84974
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 03:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e6d2f297f4so216073a34.2
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782436232; x=1783041032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfpCBsOcsMg9/hLinVb3lDs/JNVxwxT9+zPAJYF+CdM=;
 b=mS9h4OB+qGu9Uoo6D0DdQ3o2D2XQev8neTcEcuU9WB5RgZ+37pQrSNINQg6g5LyXGB
 x6whyohrsj3+GgGF7qsQiBNrvf6OXrV26RVyxwq7+g8yVVVJRoHjbtNk0gWSTltpznzI
 J5rfWZWi5jl38u+YbQkNdV4EVV2ViKT9cZDBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436232; x=1783041032;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GfpCBsOcsMg9/hLinVb3lDs/JNVxwxT9+zPAJYF+CdM=;
 b=jaU2tgLC7cWuNIUfbh1kRiQwYe5BQv3OV7RJM+RjgBywfiphTerAOE/m1DLDoCCdbr
 o7B8HPVtRtNs3SOZry9uPwSxLC2rgQ2OHRDzRXfpqR+RzeFyInOBkL+5y/79Rdm28KXO
 VfuVV0S6S72nVTjA8p2kbLbXr26unaHc5ZMQpFQGABpHLgndRkVwd7AThEgxDEW6w3TY
 27jeMn/Sr8zpWw0fMr8eWhoNOgk6anbB3OA88LDvQYLUqaEbEAZhaBh+uP5sx3ftfhra
 z351yyQYTZlXeQU0w0L3onECV/lqSzY92dbmSHguGlSbX0B6wLNA5YB5MxY6UA+rsbqh
 QktA==
X-Gm-Message-State: AOJu0YwegjoeUwFH+opnnRthFlhOhdavwf3SDtT4Uvv6O/phm6yoxDqq
 +EMs/B7yABvNrmTDxWbjq9oFIhr6jvUvJnpw8kYPx3LzmUKKBzGmW0hzIXA7FRsaviCG8Wk87Lx
 rwIxoFtE=
X-Gm-Gg: AfdE7clD7/s586s/hI80a4aDWZ6AxVF3+AWRlZ/yvw6+/5wwo1lOWk1i0gwd/vjUp9y
 SFMHpWFiaaMp/dS0QHydv7zJTFSSFvhSjM0L/GkGPJGZfJ46I3AnY7H9vv2JGAU1SoZQLs7IzXA
 QNwE3uq8Hl3AHIIEDYGReelM4bO4J8Gh0/Z19EXnTn/cGaqmh38hVUdVxWX8vMdYd/qxQ3JYtcO
 MU1cFdgzkJTlDIkrEesN0Dqh2cEXMWiFzlFWH9p2xkdsJDs1PWZ+wd6oqe3/ISJVbgtKIjGV9w3
 VcJtc9mIwWO4Q+2c79uUKK8jIT36JY1dXEMv3KATONHeL2MrzTapsuoFaBq+KFWoAbJnV3V3n0b
 MgPCMytIZz6FolVtNgutKlkMY5Fio7se/laFWzTTJDKW5yrXUI2FuDOSBzDvcCJ76drDmFfa5e0
 cgkeNyeP/o1fPi7675h92PPEAM4gU0t9LQaIIIxkSgqi89BmB3EOj/iunIRiwYpi8qvLwAHndbm
 i+bovDuHfpobTN4tPaO5Zopg/ddVZhzaF7AoVQ=
X-Received: by 2002:a05:6830:6d05:b0:7e7:57d8:a8c2 with SMTP id
 46e09a7af769-7e99c35dd5cmr4635950a34.12.1782436232499; 
 Thu, 25 Jun 2026 18:10:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e9aa57c85asm502406a34.3.2026.06.25.18.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 18:10:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20260625142625.18375-1-marek.vasut+usb@mailbox.org>
References: <20260625142625.18375-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <178243623184.3992479.3898538590774151690.b4-ty@konsulko.com>
Date: Thu, 25 Jun 2026 19:10:31 -0600
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

On Thu, 25 Jun 2026 16:26:13 +0200, Marek Vasut wrote:

> The following changes since commit fcda974e36033ad5331a9b4a4a551af4e141ad7d:
> 
>   arm: aspeed: Fix AST2600 SPL external DTB alignment (2026-06-23 10:41:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


