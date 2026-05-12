Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486EACD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 23:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D785800AE;
	Wed, 13 May 2026 01:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BMW3Lyh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A67CB83CD3; Wed, 13 May 2026 01:47:49 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E3D800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 01:47:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so6602834a34.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778629666; x=1779234466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGu0uZ/zggVo/GIgn5AtiASpOQG/DSXK8z4j8G8UJy0=;
 b=BMW3Lyh1TEqi/BRyghJd/17Mzf5SA7QdD9VQuXn9gB+gjaP8tQq+hGv6mIBAV59PKk
 8FZDN9YwgE5egPTR4OY5CAYxWQKLz1r7sB5/HgaHDbx5hPoohC1GwqcJllvKh7sIemur
 O+Dfx52WFED97yt/d5Sm5rw+lkf7qWQjBisNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629666; x=1779234466;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eGu0uZ/zggVo/GIgn5AtiASpOQG/DSXK8z4j8G8UJy0=;
 b=JmFBxYWn7plfqJuwGImciFD9YTC2earHkH+X9CnRRe75z72edPmHxahp28NQhKi7tX
 MUX2qB9ORBQbRwWRg2WT0qcw4ymOKBf9sapJXdJzIThXS/JvOq+14IDvyazP3IYu6pH2
 oc9IhlYjWavKweKikkXpg06BE8IEvJ94T2bpvaWTRCN7UkCgb5GxX0QBC3yIpdaWtRcM
 QvRoNpsPqxU04c9IvOrUxbGgZa4/YLLMiIOVUJXnZqQAvQ8BXoOw109VxbzhIAWZvlwu
 jHaewOtxDmXdzCUxou3xHStATcpbYm2nEo2dqNIyHP3EK6czG3qE3ZGTX+YRxlY2FIRw
 3wxA==
X-Gm-Message-State: AOJu0YzhkQjS/USri3n9CILIXXOals+Yt+oYoqCRWYdjag9MY4Xp5+r9
 llvgh+RZ6PstvVwOutrdz85dyPvjbygTUaAK7dh43nzKliTANmmUiEhUhnOvMHgzYEhHRxSsiO/
 VhePG7Yw4mo3e
X-Gm-Gg: Acq92OHjmG86B+/V4OfwkQkUnlU79bRwfZGrJV4cyX5UCeYnM+Iqcue649bYuS4R1a1
 ytYQmYetNkEN3Kxu2ThpWmP83g6N+PGlkqWXqgNzd2SEw7tb+qbPXMyxBwcW6ljV2YZl+Ym94Ya
 2gF3g8lFGEbIqjbU9jJ8AeQyXIoXniCkuYV06KGlIOl8asT0fAr5ZUclZ+kcdjRGl0Ysvs03c6L
 +KW1Qa5FfsNdamN8itfmttkldAR8uEiqZpv6dL3cdtNYZX3pqSzo7bzdlmkTmfEIiM2QeYNVyH7
 UgSV+WgnzXlZIG0E8zvH/sYXHoAcuDWudJ1qQfh5ALezYCZZdZYvBOtrCruNL82D2t+Ox5Ya7zX
 +uI9Ap4Gswl+r69A+mOZC0pxAq6Y7eVbN5RSA6XuiXbuTlmvkchuq4mV0AdnR0T33NlIbtjlOGR
 88xd4oclYBHCg85kMPfDssPAwK+EvyjByYIQ1st5fO+7d0+tiKW7Ss2XVlw4t/3Z5G9Ve3p7dAl
 CMIwGFguN7ij+o5mLHHaARORK6X/YnkO1a31C5D5NLEF4QaZQ7QKZWv0EYw
X-Received: by 2002:a05:6830:3c81:b0:7d9:7ea8:7a4f with SMTP id
 46e09a7af769-7e3dc8807b9mr273885a34.16.1778629666342; 
 Tue, 12 May 2026 16:47:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c05393sm10403641a34.9.2026.05.12.16.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 16:47:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260421075439.16696-1-ravi@prevas.dk>
References: <20260421075439.16696-1-ravi@prevas.dk>
Subject: Re: [PATCH v2 0/9] add memdup_nul(), use it and memdup() in a few
 places
Message-Id: <177862966554.3364622.16027203540982484336.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 17:47:45 -0600
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

On Tue, 21 Apr 2026 09:54:30 +0200, Rasmus Villemoes wrote:

> There are quite a few places where we allocate X+1 bytes, initialize
> the first X bytes via memcpy() and then set the last byte to 0.
> 
> The kernel has a helper for that, kmemdup_nul(). Introduce a similar
> one, and start making use of it in a few places. Also the existing
> memdup() helper can be put to more use.
> 
> [...]

Applied to u-boot/next, thanks!

[1/9] string: fix prototype of memdup()
      commit: ca1c292d2ee6bcb06be71400d25ae37e9dc2c1aa
[2/9] stdio: drop stdio_clone
      commit: 719cacb92e039308e23cbd6b653275e939a5aca5
[3/9] lib/string.c: drop pointless __HAVE_ARCH_STRDUP
      commit: 349d148f16d83da3b1e3475be0e43bfda4f4ab71
[4/9] lib/string.c: introduce memdup_nul() helper
      commit: 8c664d2135723a110a60b792a8614c4864ad82a3
[5/9] lib/string.c: implement strdup() and strndup() in terms of memdup_nul()
      commit: ee8be5d4a1035de232b3497563fe9f6773775f96
[6/9] lib/hashtable.c: use memdup_nul() in himport_r
      commit: b87ff4878d081103c45f0ebea7528609a0b173f3
[7/9] common/cli.c: use memdup_nul() in run_command_list()
      commit: 11168813bf9c088e1fce8a96f4b493ee815c966b
[8/9] drivers/core: use memdup() instead of malloc()+memcpy()
      commit: 4ef201e607ebed2432ee929446e3fb9b57c53a54
[9/9] test: lib: add test of memdup_nul()
      commit: 8d209186a1e4aca4ec44745d05d51de7e80f7e3e
-- 
Tom


