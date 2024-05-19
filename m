Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58E2C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:19:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023BC8817C;
	Sun, 19 May 2024 21:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RF4L7eeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1268817C; Sun, 19 May 2024 21:19:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CB288193
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34eb52bfca3so1704995f8f.0
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 12:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716146342; x=1716751142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5NlsrRGReUVabQ3nzOPMqaF2HNneAUD6Al0bjGEGQsM=;
 b=RF4L7eeMEeOs3CrfrkE4UoYdIYOcPU5KQVVzCToTZFNxzAx9zRrI9JlISTQaXNTfks
 GmWXKB55d+x+zrVhrFURX9QM/S0eBITXNjJK9SVUUkoTtlTsXFLNhbsuiQBvmbia0vpI
 U5XZmnWEkzqVzmKjIWSUc7vg+tJZ7/Nv9rGfMcKMFSRCuBmph7CsOymfNAqt2BaWx4UP
 sI3QQsp/WOQ35/l/cupVaXSu4jNiELntNHIXT1/hs35FV2ethXnAdWex/HRcloPMITyg
 WVcjGZr/bPCfXEAMv6lQrCz7csxbzWoMjlM6N4vsZ9W+0SwtAcuvS3FVZP6rJmiQrZeJ
 Khyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716146342; x=1716751142;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5NlsrRGReUVabQ3nzOPMqaF2HNneAUD6Al0bjGEGQsM=;
 b=cw4CvnYLRJUnGQ97XFqVlgPq+MZmVX85jzmJsw6JQvK6kuR/t1CqyaYXogv16XLGxR
 2ZcQaVRqjptl7rI+D/277247gPdhJ1UtTgCMXitIqxhH/YVqbGY0uzOqfWuCe6DnGUZw
 95u37VmvFOUThdJa7y4Z+biO9e/w+3CO0EFTGERqwKBIUfqTd4kDhAPdyjpeLdnaxO7k
 OlMgddegTvGFrUhkDrk1au8wsttwj5ImPvIQcqvd2BzGQSOuhTywqUkGyDXq4WzO5hHE
 3RZe1USHDm1us0B9yPt0MggoIPgXC+ow9K2Vbetd8A6o+kmNTYYnLjeZ6F7uTXR4Hilg
 uSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5HoYM7u2++yfVpChOA79eW2mwOZEbB4swt5UH/P0sdHTgLEdAAnKafyjgDIM0FXiAr36WGLmKJfN1qNGQoomWOhqGjQ==
X-Gm-Message-State: AOJu0YyS5EelmPpJdpo0++pUtVqpYGmK+6QeQXL4kw1i7YE6nmx2MXnW
 /HiGXvWuQRhyLv97wmckFAAAMV4jiyWGNwp+ROv5WkvBg4lTtMBJ
X-Google-Smtp-Source: AGHT+IHGczgShwJF2rId1HNQuMy6IxtnAQH+GCRVkaIcDdVnXM7wN/ll5C+fcCxnkFjbqGCuVN0S2A==
X-Received: by 2002:adf:f342:0:b0:34d:9ec4:7b78 with SMTP id
 ffacd0b85a97d-3504a969229mr21549617f8f.56.1716146342222; 
 Sun, 19 May 2024 12:19:02 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b89583dsm27411682f8f.33.2024.05.19.12.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 12:19:01 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: r.stratiienko@gmail.com, mkorpershoek@baylibre.com, igor.opaniuk@gmail.com,
 dsimic@manjaro.org, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, eajames@linux.ibm.com, marek.vasut+renesas@mailbox.org,
 paulerwan.rio@gmail.com, u-boot@lists.denx.de
Subject: [PATCH 0/3] Android partition load optimization
Date: Sun, 19 May 2024 19:18:53 +0000
Message-Id: <20240519191856.2582174-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This series offers an optimization of the Android image loading procedure.

The first patch introduces a new 'abootimg load' command, which loads
partitions from storage into memory. It uses malloc() to find a free
memory region, whereas previously, the developer had to find a free
memory region by himself.

The remaining patches reduce boot time by avoiding extra disk activity.

The second patch implements get_preloaded_partition(), which picks a
partition from memory previously loaded by the 'abootimg load' command.

The third patch optimizes the 'abootimg load' command by skipping zeros
loading at the partition's end.

Roman Stratiienko (3):
  abootcmd: Add load subcommand
  avb: Implement get_preloaded_partition callback
  abootimg: Implement smart image load feature

 boot/image-android.c |  70 ++++++++++++++++++++++++++
 cmd/abootimg.c       | 116 ++++++++++++++++++++++++++++++++++++++++++-
 common/avb_verify.c  |  53 ++++++++++++++++++++
 include/image.h      |  12 +++++
 4 files changed, 250 insertions(+), 1 deletion(-)

-- 
2.40.1

