Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BE3E64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C0189392;
	Thu, 21 Nov 2024 23:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TCVcsGdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FD6896EE; Thu, 21 Nov 2024 23:32:28 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2AAF8934C
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6ee7ea48ad8so15931297b3.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228344; x=1732833144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SGEnX0FnHPJ7NdSASI6NPP5pDxIDsYQ+9RrHdIqX5uw=;
 b=TCVcsGdWqvCklPIJGyyISkCqdgqm3/KoCPChQ+ciA9ou5tXLBoyHLii8ag4qJK8mVB
 iLJbP1vq5oAPYz6goD4JFeQKiuufojytzquRbJibNobXfAeNo07NgCjs+9mtUOL5wKHN
 +lgaqhzzcbAhycWKQYShdRpkNzkCEvx6BtT8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228344; x=1732833144;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SGEnX0FnHPJ7NdSASI6NPP5pDxIDsYQ+9RrHdIqX5uw=;
 b=KnxZT7TYLKO8Q1cyZGuslR6/2v8Y4j2w3+p9dmC/1PLahk0syuxESVJNGi9XPAu59Q
 bpiaU2neqwDqCwluvvfVr9ny+abl8TI9ocEWplCvwcNYX0zN1djB/h1sVcya1yADbxqo
 gRrgxoUvNBFmRPn3bY9R2mldeeMvnNfl9MLTdYtn4I861PjmuCT7eKIvykLveQVpOy1c
 Fll6M2pDfkWfbPE68Kx/av9mOIEB0J+klwyfGFjw9cUDOdoP9OnnxZKLTUSfykZxj3tf
 ggP+Ozrc+06vQllReujh4of5oWs1YFeVor2AVx4mthzTC/lstCb+SJNOtA+C4bqB0UFG
 I1lg==
X-Gm-Message-State: AOJu0Yx86fslJFjUBTHnHYzWW/GQkv6BUtcfad7dTth9ZEDVvNyGzn0R
 6bBdevjsW4pxMHnu1gmGL48WX/sMf8FP9cPuBlq+WV5NpODp5PKSwdZ9kYifeOrK42b9tSVl8wE
 =
X-Gm-Gg: ASbGncvzzRbW4XZdFg4M7iDxlAFMBArX1Aaw9tJp4gxcCjfPZ42vCb9ZnASS4oc2J7f
 sWhpfzi3biFYbv6xONdzk0xh6tWE6BRedth8q8XW/kTgv/dfamhrGV4ccNvNqoC8E7kJ1jx2Qix
 GLVejsN8V1YqjfBWfNvN3N7oZWrlf+1xlOXFhkS167q0PmNTFX3vaN9DnI19lhqH+RsX966DJ4X
 mcTtMEfsVJvtDha80osPTQPjmv0q+PYMh0vxhpVn3IQfF0=
X-Google-Smtp-Source: AGHT+IFF9sCBO6fpp2pySecwtxKCmn0/bgudWJ/JvpEBtiAlGCT0uluxH9aUboc6fdlB9zxUSotacA==
X-Received: by 2002:a05:690c:2506:b0:6ee:4209:731 with SMTP id
 00721157ae682-6eee0a6176dmr12979467b3.39.1732228344008; 
 Thu, 21 Nov 2024 14:32:24 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/8] test: Avoid needing sudo for image-creation
Date: Thu, 21 Nov 2024 15:32:06 -0700
Message-ID: <20241121223217.330117-1-sjg@chromium.org>
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

This series rebases and tidies up a series sent by Richard Weinberger
to use unpriviliged code to build the test images.

Link: https://patchwork.ozlabs.org/project/uboot/list/?series=417786

Changes in v2:
- Fix a few pylint errors
- Split out image-size patch and default to 20MB
- Attempt to reduce the diff, for easier review
- Add new patch to drop exception handling
- Add new patch to use the built mkimage
- Separate out patch to drop support for fallback files
- Add patch to remove prepared images

Richard Weinberger (3):
  test_fs: Allow running unprivileged
  test_fs: Rename mount dir to scratch
  test_ut: Allow running unprivileged

Simon Glass (5):
  test_ut: Add an image size to setup_image()
  test_ut: Drop exeception handling
  test_ut: Use the built mkimage
  test_ut: Drop support for fallback files
  bootstd: Remove prepared images

 test/py/tests/bootstd/flash1.img.xz | Bin 4924 -> 0 bytes
 test/py/tests/bootstd/mmc1.img.xz   | Bin 4480 -> 0 bytes
 test/py/tests/bootstd/mmc4.img.xz   | Bin 7072 -> 0 bytes
 test/py/tests/fs_helper.py          |  11 +-
 test/py/tests/test_fs/conftest.py   | 225 +++++++------------------
 test/py/tests/test_ut.py            | 245 ++++++++++------------------
 6 files changed, 157 insertions(+), 324 deletions(-)
 delete mode 100644 test/py/tests/bootstd/flash1.img.xz
 delete mode 100644 test/py/tests/bootstd/mmc1.img.xz
 delete mode 100644 test/py/tests/bootstd/mmc4.img.xz

-- 
2.43.0

