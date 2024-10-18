Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB98D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92D80891A2;
	Fri, 18 Oct 2024 05:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I1zmg+lU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97064891A5; Fri, 18 Oct 2024 05:00:55 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1607D891AF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83a9be2c028so56035439f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220452; x=1729825252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf7zGpuGkEjIg83uHYBY9Qy7T/SRKgD4Sza/N+YwABs=;
 b=I1zmg+lUcqyaQyIpu26tL7HcrrM7TjbnGQoqZiyWb0TMlgeSUq7J7qa16jNvk9j65N
 92a3RxUtF2q15iE5Ckok2eRNgJeldCjef8f23nwwwa/KGHLGqzdYXV29eQZMV0xvL1x0
 mvAGFB8SAvscUFWVaQ8lKID6TqAM8F1ulds/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220452; x=1729825252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zf7zGpuGkEjIg83uHYBY9Qy7T/SRKgD4Sza/N+YwABs=;
 b=IUv6KiWppx020fn11sIaUSaYUh/sOZq7O83l1TTuEhPh6L4wwqK/ujvKMXI18VOt8d
 7Qqe1Ui74i3mrlAsVW1wv5YPo7TzYxfF7MBYwJiNU1BQPb8KKhSYOngsreLpz/hh/6NB
 sljNt2O41E3iGNF+V2n0YUmkvxodNlhx4u+LqXqtALXW8wxovLsiK7X9PP/FHarz+TlA
 bgXbSFEkvgmXJhQUYzD/eRQ+P4Y065Y5eyxPOL+ULufM79SCQYswuZdyQQY7RnFu7MHF
 xULhMtNhuZ5EfoVl9AxtPMcFJYq6sFxkb0wSQRvWgW+0OSiJPetRwxAYqX93Yd3+zIBo
 tfnQ==
X-Gm-Message-State: AOJu0Ywu/Sc10n0k+mjrjeo1zh8EK9k2wM67Zbx80GAtIU/LYZCiyFF8
 mzLGqBnV1Rwz8EweMt5rLJ0gjicBqI7RkUcOYieG+raXg6gdJ82ZAqvN9BcLswtOmAHOoiG8nhY
 =
X-Google-Smtp-Source: AGHT+IHV3X5pKMIzhxd6gkV+RSnoqe6QBVI9V3RMT5MZuAM5OMk7QigDddonYSHPDm4UPMCHFQKz9A==
X-Received: by 2002:a05:6602:2cd5:b0:82c:fa71:2326 with SMTP id
 ca18e2360f4ac-83aba5ee8e0mr87380939f.8.1729220451565; 
 Thu, 17 Oct 2024 20:00:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] membuf: Include stdbool
Date: Thu, 17 Oct 2024 21:00:23 -0600
Message-Id: <20241018030027.842749-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

This uses a bool type so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/membuf.h b/include/membuf.h
index 17616d5577e..636ed703ee7 100644
--- a/include/membuf.h
+++ b/include/membuf.h
@@ -9,6 +9,8 @@
 #ifndef _membuf_H
 #define _membuf_H
 
+#include <stdbool.h>
+
 /**
  * @struct membuf: holds the state of a membuff - it is used for input and
  * output buffers. The buffer extends from @start to (@start + @size - 1).
-- 
2.34.1

