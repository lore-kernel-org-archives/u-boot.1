Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A520C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 20:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6941386F63;
	Sun,  5 Nov 2023 21:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CsKift1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD96A86EB5; Sun,  5 Nov 2023 21:05:14 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CE986EB5
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso114290539f.1
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699214710; x=1699819510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q1D7VZ1IeGj0+uYov6L2gJA0ATY2A4rbQ1twiCn0AsM=;
 b=CsKift1elW4uUo+f+wWjCPfSUSLoi40J7Hai+AIeQKr4kywqAjYWqBePsR9FUXkLyL
 ff4CXI2PBTCzF47S3T9w7etGIZcDBk28w1f5CXQyM/cNU7/8KlajKqgzOFUAB5pFZOlr
 8MV5Qm/bVxfQmR4NjaPtWQFKcbRLTF4ZIPD+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699214710; x=1699819510;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1D7VZ1IeGj0+uYov6L2gJA0ATY2A4rbQ1twiCn0AsM=;
 b=T6og1t1GgtVLAY0P/G5HCyXgqiZVsyxaLDNZlxhOIKWZuOIeYuf260JJoGw9gzEL7W
 Nc4ZrtTwwPGPODuQ/4fC88b9umFQlNUOwZ+z9oLd7x87anmG+1ZpZU5j4nNHmKttc9FY
 kvTTxZJ4galluzKaJvguOcy8UVvY3bg7eYUnLz9Bj9qhHIk4J6m86ZmfWNvpsd/vHRtX
 y3pUctpjVDYRsZ6cdfgWVgpZyfkiidc9YE+TWRbyy6pwXHUwbOxm0eMcexrlB3/7ifPD
 27gx31mfYxjLzt/N0TlaDagpkZcWpw+Agfwl14Dznd2nKvwzpZODo0lg1dix0GigS4jr
 8i6Q==
X-Gm-Message-State: AOJu0Ywqjn1N+OuxHPS199IrU5mtj5ZJSGb8GCUFOMiCf7SKAJgjX6vY
 gfFpWumlKNblE1gfnKxopnhU/5nOquHPyzJGYeJ/9A==
X-Google-Smtp-Source: AGHT+IHxtJ9RiBgyDpuv0p59DrLjylQ9kYYVFnDJh6VR4HuBG57W5bEDC7h0qxx+vuJ0T5sk9CX5tw==
X-Received: by 2002:a05:6602:2a51:b0:7a9:61fa:9605 with SMTP id
 k17-20020a0566022a5100b007a961fa9605mr34258492iov.5.1699214709932; 
 Sun, 05 Nov 2023 12:05:09 -0800 (PST)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a029693000000b0044d10eda3a8sm1685512jai.158.2023.11.05.12.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:05:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 0/4] bootm: Handle compressed arm64 images with bootm
Date: Sun,  5 Nov 2023 13:03:50 -0700
Message-ID: <20231105200453.1887418-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

This little series corrects a problem I noticed with arm64 images,
where the kernel is not recognised:

   ## Loading kernel from FIT Image at 10000000 ...
      Using 'conf-930' configuration
      Verifying Hash Integrity ... OK
      Trying 'kernel' kernel subimage
        Description:  Linux-6.6.0-rc7-next-20231024-00003-g259c196f194c
        Type:         Kernel Image (no loading done)
        Compression:  gzip compressed
        Data Start:   0x10000138
        Data Size:    13667956 Bytes = 13 MiB
      Verifying Hash Integrity ... OK
   Bad Linux ARM64 Image magic!

The problem is that the arm64 magic is checked before the image is
decompressed.

Another issue is that the load address is read from the 'load' property
even with a kernel_noload image. This means that the kernel is loaded
to address 0, which may not be valid on the board. We can use the
kernel_addr_r environment variable instead.

A patch is included to show the kernel load-address, so it is easy to
see what is going on.


Simon Glass (4):
  bootm: Allow ignoring the load address with kernel_noload
  bootm: Move arm64-image processing later
  image: Show the load address when decompressing
  image: Correct load_bug typo

 boot/bootm.c    | 61 ++++++++++++++++++++++++++++++-------------------
 boot/image.c    | 13 +++++++----
 include/image.h |  2 +-
 3 files changed, 48 insertions(+), 28 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

