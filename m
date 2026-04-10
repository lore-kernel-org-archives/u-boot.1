Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1055F36B97
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 01:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240BE83DC9;
	Fri, 10 Apr 2026 03:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jD7zPGSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F94384099; Fri, 10 Apr 2026 03:02:45 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0D983CF5
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 03:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d86eb7c854so786486a34.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775782962; x=1776387762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bobjXIdaVtNIbXg71Fupkqa/CxrG0vGJDSt/EjjYd70=;
 b=jD7zPGSXPYcr0WWEX7IdCNt5HttayeHXdWGJFIRIC794rXfuhRyFCXWRHWcDIqwCbJ
 hT7ZKLfaGpnVtqB2sbI1mh/8mIVFmJEoFpS5UQ6Y3MSmk1T6C2I3phdjdzK0+VNQgXnT
 DEAZ5gBxiESuA6NuynQ8FcvIeJqEOyve7R7mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775782962; x=1776387762;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bobjXIdaVtNIbXg71Fupkqa/CxrG0vGJDSt/EjjYd70=;
 b=pkuMy6bLV5LtjpdYI6lZ+4otWBRKwUbbYPd0+BTmhVeSJ/jRYRLHKXIJrb7hD2lMZw
 +epPmM6gGmOXGnmPyq3epvc1QvgvnCxBZt3Iz6lJWfV1V5DqcRTuhLFN0f8LbDgsPglx
 FRWYIf4eHio52b/yZN3XHbU9+blDe/4b2aLbfYrM48dj11GmqeGGhS8vJhscpq2rB959
 efv5lXZrECUJGQ4RnBoYiNywY9REnfHN0XKQT7uzZco4wC6e/RayZokMpesyi3rInSPA
 027m3Zmt2oH/xlDPPZw/amGYk2bz7GjARuo2a+t7YR4/6ld7Y+XMDWA0fi7ERvtg+mHA
 6Nhw==
X-Gm-Message-State: AOJu0YzFwjqQD1g25aC7HUBs0zrJ1BTkFzPYHOv5tLwtnSkIVLt0I34n
 +ds5OoQGij2lOoxvA/mW85EswXoZXudLXYQtxQkQmyK7xWtcKrzEdZ+9wso8L2x5nA4=
X-Gm-Gg: AeBDieu2KXB229XnLXEFFJ9ol+6+ypa+EzjboF2AsGaOtVrbApTVNSLu8hMEgzcZKir
 vmuSi/XDvmWHG4ONZDpWfVphYMqFKudFmbHueEonv6mZ6/mUliRuEUXq1Bwx0j/mVYdR3Y74R7c
 rDxJLfoChwM7pzMZYCcZPzaIz6JM18hibZJPHOLxtyLJ+QkTDWaBPRPBRrcZXFcCCjSV1RSI4Eq
 RqKaW/Q+bzK39izpJQOnxIgFl1vNXcNjOcdCNHvBIzOkKv+O3Y/FLJ22eW3X7xUsoaHubvF3Pbe
 W9Z+Gcq75953fF/TNUsIS9AVcPQEWTgNtxKAjwKKBq5JukWcvwl1HSpUqiI2ix5ANDyiOuZyMg5
 bBj9LBId2gZNc7SEF0L2XdZvDua1lKDftl02o1SZ67Mnous+TEwF2byO3RgPQ/tjO0OJkZ8AaXE
 7HlZbZDp7Jm8psQI8UgNiCrYSxWaYf82rNfxfzBAcO+mLDwOYY7B37GRXRTW4dxTD2lsl9ExlSE
 s9xQ/GwufLPXaW+dNuPVOTl9fxDsyDM+B6q/0sReY6jO3S0Gg==
X-Received: by 2002:a05:6830:4ac1:b0:7d7:d0bf:7045 with SMTP id
 46e09a7af769-7dc27c9c987mr868254a34.8.1775782961970; 
 Thu, 09 Apr 2026 18:02:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc26965485sm889564a34.22.2026.04.09.18.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 18:02:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260409171057.16628-1-marek.vasut+renesas@mailbox.org>
References: <20260409171057.16628-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <177578296118.1241225.3706558346917310455.b4-ty@konsulko.com>
Date: Thu, 09 Apr 2026 19:02:41 -0600
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

On Thu, 9 Apr 2026 19:09:04 +0200, Marek Vasut wrote:

> Assorted fixes and tweaks, HUSH parser, preboot env variable, SMC command
> enablement, s_init and 32bit/64bit code clean up, DBSC and APMU remoteproc
> clean ups, UFS dev_phys_to_bus() remap support and SCIF R-Car Gen5 support.
> 
> The following changes since commit a383c9689282269bb9687ec6c115de094c27fa67:
> 
>   dm: Respect dma-ranges size (2026-04-07 15:27:22 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


