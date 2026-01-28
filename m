Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797BBD46C01
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 22:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC2B83C2B;
	Wed, 28 Jan 2026 23:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Dtgb+tjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C61B783C65; Wed, 28 Jan 2026 23:53:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FD183BE1
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 23:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 097B43FA7C
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 22:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1769640803;
 bh=QzxYiJQXn6kLeBRsiNKQoZib/GplfkK+VoL6HlBymUE=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=Dtgb+tjpqjgYjijku7oGVQ+l5RTcNBWBsF87HC9owXEnCtYVVh4GAlA7jWGCTldKL
 m0ES0kxyFh/mjv9IIuT5HN4Y1zt4vOVZykQjqy40cTGLD+LzSjeRGNf+NKATD+CyE8
 8cHke7Fs+b89jaxFyf7XoUIVIW2cBs7YRIXTrGplrL4kIGaEK9GvOjnfuaKcpwalp1
 Uev0mqLpsi79UMmOFUyV8dW9uyNeiqyLAs62EbmwFuuCK3QD49CB/HSeq8NvKG355u
 uTKRoJAAZ4nETLOjdfsWaNw6m4aCqEnc9yn14rHtjUA50yzIvYt1yXz/3BOoFvykmS
 rXgcOt9iX2MGP6le3BlZqLVli2GSFqyDnnlhG5MDE+963oKx/YuKlQyMnMqL+D8NNm
 wQkwIhg1utmoapCtmo3PbZTUViiPKo6rr8tK5fxBhQ6vFAtv0MFLy9FVjc8YuVQ3bA
 fBXLsyrFVRqqgZIMsXjpfapvX6okoO6nqvkhjYXtVQqzmkX5BbaKUHY5qNIO7P86FY
 dyWFGbbWTb8Gi5K6YP5crWO3oeDI3jcmhSGnu0N3tcTaotKvpAkRPX+Ojv/C0ELwmq
 4gYxbXjPXiQ85fL/O9+EwL0dnKDbFA6HUBEsUI3+yqGIqDDiKkAV/fQ9BUWvpyxRTy
 B9J0u1bfBRlwsCxVzF+Zb4kM=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47edfdc6c1aso3129155e9.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 14:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769640802; x=1770245602;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QzxYiJQXn6kLeBRsiNKQoZib/GplfkK+VoL6HlBymUE=;
 b=e1TkEwVBxallkll4BPieKJwZ6LHcdzd1fKn0IJjIfCaedP8Yh1dg3WDvFLVr5lCnQ/
 pGlwVLgSBdCxsJH5w40mO+q+hXE3X3voqx1b2sUPovp3YYPjkTjdlbs2US+pQ6PbzH0z
 wd8wBui98S5YXtE9dLi1s0ji/FYogAZG2tGY77BsFdaDeYCr2CzKjUXGHpB/u+ynlInt
 FqT7QhzY4y0CIP0oS+iYDKXivN4/U4f053aPnG14LGaLRPF/078g8DagX7tsymp2voU0
 exa8sYZKMjjYKwwRMFeEC4r3NgVTi7sysKkQJ6Wq5J/d0OvmsidhLN+x3QZtEmWmOzfg
 dJsw==
X-Gm-Message-State: AOJu0YyAdIJhEf6v6Oox9Yc87oEPxRSAThmoEYUKwJ1C2G9rCiwb6guc
 q8p87Tz9wuucgM29gr0u5PnLH4D8+qld1Z6oXKQqB+/SidlTj7hEOZzKfOAKJOFOuxXg/+su8+C
 ueOv6nmTfnyMAu5ObJVgt6zoi6LTAhVrM4yYJdS8VhLmAqy0TMJv5xpFw3eN7EoWLNLaoKk3i64
 JBf3w=
X-Gm-Gg: AZuq6aJU/M+r7WvN3Q70ei9Df3o4nBIddn/WeuopGqylHFjbFXrdEsxhTXXWeD6driV
 Puv640nCbUwXm7LEYPd6f7JTwaz4PNYkTXO0jAtlzcDRG8SF0p16mXo+TpaFxhdFhq/Q38HXoC9
 DpcQrOjnMXjPjQlcaLob6f6fCFN37K8x+byQBfRtnqZqjfvk5xpo3tk99pOx1QNmGkWvfpZxqBB
 RiUYWSXW9EDOwEtumx5Srd5Pmlc5wMJeBgMR1tuyurJ9uNRCORILXAy9SlBwOLJ+sFnO25nmBHm
 KhoPQzbo1XsoRHCNbin+kJ087h2RWdesVi61MtlZgp4ZKoKhiyK6N9IcDQOWsiIROVHSz5RLR9g
 72mVyCMHe/Z+u6hJeiaWtcOLMiRAwreS73uGSOUUvqHkZpQaPyGhMoIEymaUF0c24jA9n5cAEbo
 AcvA==
X-Received: by 2002:a05:600c:450b:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-48069c5fed2mr72207465e9.27.1769640802594; 
 Wed, 28 Jan 2026 14:53:22 -0800 (PST)
X-Received: by 2002:a05:600c:450b:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-48069c5fed2mr72207285e9.27.1769640802150; 
 Wed, 28 Jan 2026 14:53:22 -0800 (PST)
Received: from ?IPV6:2a02:3037:6e4:3a21:e5f9:4824:4c1f:bab0?
 ([2a02:3037:6e4:3a21:e5f9:4824:4c1f:bab0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5d2fcd0sm1426935e9.1.2026.01.28.14.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 14:53:21 -0800 (PST)
Message-ID: <a937a2e4-2bd0-4158-9b74-55131054c2ab@canonical.com>
Date: Wed, 28 Jan 2026 23:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Pull request doc-2026-04-rc2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Tom,

The following changes since commit e8ec8d980a31c4a1d665e4aa9089d6aa27cb0d0b:

   Merge patch series "dm: core: Support same compatible in host/gadget 
musb drivers" (2026-01-28 09:21:17 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git 
tags/doc-2026-04-rc2

for you to fetch changes up to 302c054d64a19c5bb579c3a74cc809f7338cf9de:

   doc: develop: process: Document using b4 and patchwork for custodians 
(2026-01-28 21:20:07 +0100)

Gitlab Ci showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/29122

----------------------------------------------------------------
Pull request doc-2026-04-rc2

Documentation:

* describe QEMU VGA emulation
* development process
   - Move the existing block about patch application
   - Rework the custodian feedback section
   - Explain when/how Custodians may edit patches
   - Move Custodians section
   - Make "Work flow of a Custodian" a subsection
   - Document using b4 and patchwork for custodians
* develop: codingstyle: Update b4 external link
* develop: sending_patches: Update link to patchwork

----------------------------------------------------------------
Heinrich Schuchardt (1):
       doc: describe QEMU VGA emulation

Tom Rini (8):
       doc: develop: process: Move the existing block about patch 
application
       doc: develop: process: Rework the custodian feedback section
       doc: develop: process: Explain when/how Custodians may edit patches
       doc: develop: process: Move Custodians section
       doc: develop: process: Make "Work flow of a Custodian" a subsection
       doc: develop: codingstyle: Update b4 external link
       doc: develop: sending_patches: Update link to patchwork
       doc: develop: process: Document using b4 and patchwork for custodians

  doc/board/emulation/index.rst   |   1 +
  doc/board/emulation/video.rst   |  63 ++++++++++++++++++++++++
  doc/develop/codingstyle.rst     |   4 +-
  doc/develop/process.rst         | 106 
+++++++++++++++++++++++++++-------------
  doc/develop/sending_patches.rst |   4 +-
  5 files changed, 143 insertions(+), 35 deletions(-)
  create mode 100644 doc/board/emulation/video.rst

