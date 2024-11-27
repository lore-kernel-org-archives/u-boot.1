Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D24D6ACF4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 17:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A1D8961A;
	Wed, 27 Nov 2024 18:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="taCPj48s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F2A4896FC; Wed, 27 Nov 2024 18:22:58 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B938936D
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 18:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d842280932so118146d6.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732728174; x=1733332974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CisaVjTsXsPACKxwbYATx8Wtq1TJnfTmY6U+K7WQUv8=;
 b=taCPj48sLX4CG5rzXzs6HQNZQ65yIDSnx84+1N0jVX4+upefFNEMP049oH7GXSil2S
 b+I0iAWxldAxskFWyNkjGsnTtBCgsdNdHkXe0YOiHeUac9P9Z3F3196S7Ib1zB33RIZ7
 QxjxH9Jko0B+k2K5aUnXXEO6oeGKeghKIWARo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732728174; x=1733332974;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CisaVjTsXsPACKxwbYATx8Wtq1TJnfTmY6U+K7WQUv8=;
 b=OimMqxYpUeeXViz9DlU0CATU8jCR/zsmyC0J+EHnZIYfuo6OS/6XcVoPwNmVMOGTOI
 az7x5KcoxwrtOriOuppHdcbHiL+Xl4kBm/O3zRGkJefdF6QZg52W2GTcKnhqw9u3+ChP
 kmk3G5857YSWxnPSEg16JrQ0tjin/ZMYSzAdG+e2OTQFkzOW8nMIKE903cA732Vi5eNt
 g5dDm/cbwY6BmR1LC9mkvmr+W7p1N0IaXEN/EO8qZNxRN/Py63U2NSpfyiwOlzV6D8Sp
 uMfekrmlPTS4l+NHClZ7k2cLrNmlnVVv9GwDmHA+Igxo2u/BHeE0svse+OG4sUI0HNA4
 YTTQ==
X-Gm-Message-State: AOJu0YzS66hE6ghlvwqaaVsgli7DXQ79kByl68v6FHYiZaBb0Y1X/aRW
 oRPUzbz1imzwLRKyZ6eVCgY3bh6VT8VnxTJ8EZ7FRw4u3Eaw0BxxTGrAKmFfJNADlERHzG9fzpn
 TMLQ=
X-Gm-Gg: ASbGnctO62/TgfWq53xF29pgJTgzAAh1+0cNXeHBj1bTlreosrONVgd+75B7PckdlJM
 D6/mbQNounHrrm3LaP7+SZuQIdRtWyB0D4fg/9tSaCWhO1DYqTZVlNjCtjeNVbrUr9lFDH7W1Xo
 puE1Egma0Oallo78hrqc0JX62Aj9rGxsYPggj2ssC3EWUdbLsVM6VecYhWC3IAJIkgAP92XSiJ2
 W5rVOKy5wcPhPuKAioC76xDRX9ibeO5CJCS14jZ3omVVqApYbGdzPPgXYmTCmBmgV42kUmA
X-Google-Smtp-Source: AGHT+IH0HXJcCkCIt1fdzgqQtUnaXx0jyIMK+iKta5ebNK4DqD2aRzZ4J21g7GjHDtTQlS8u7Degjg==
X-Received: by 2002:a05:6214:2424:b0:6d4:e0a:230e with SMTP id
 6a1803df08f44-6d864d26013mr57643646d6.16.1732728174642; 
 Wed, 27 Nov 2024 09:22:54 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b23e25sm67160976d6.89.2024.11.27.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 09:22:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [v6 0/12] CI: Set up for an arm64 runner
Date: Wed, 27 Nov 2024 11:17:18 -0600
Message-ID: <20241127172247.1488685-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is picking up Simon's v5 of the above-named series and making a few
more changes so that the follow-up series I have leads to arm64 being
supported for almost all jobs. To quote Simon's cover letter:

All gitlab runners are currently amd64 machines. This series attempts to
create a docker image which can also support arm64 so that sandbox tests
can be run on it.

The TARGET_... environment variables for grub could perhaps be adjusted,
using the new variables, but I have not done that for now.

Adding to what Simon said, we now build grub for all architectures as
the reason to install it was to be able to use the binaries in QEMU.
That won't provide us with amd64 binaries on arm64 hosts so we can't use
that shortcut anymore.

Changes in v6:
- Re-introduce patches dropped in v4
- Add x86_64 toolchain
- Move to grub-2.12 and then build that (with -j$(nproc)) for all
  architectures

Changes in v5:
- Drop the comment in the gitlab file
- Add back a final missing sudo

Changes in v4:
- Leave the 'sudo' in

Changes in v3:
- Move ARGs to the top
- Revise documentation to explain a common error and building on arm64
- Use grub-efi and linux-image-generic for both archs
- Add patch to install toolchains on arm64 host
- Drop patches which remove grub and tracing for arm64

Changes in v2:
- Update docs also
- Add comments to the ARG variables
- Swap order so that amd64 is the exception

Link: https://lore.kernel.org/all/20241115134807.3068947-1-sjg@chromium.org/
-- 
Tom

