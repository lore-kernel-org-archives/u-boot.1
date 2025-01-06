Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BF4E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FFEE8056D;
	Mon,  6 Jan 2025 15:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P3ABpqli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70AC4805F5; Mon,  6 Jan 2025 15:32:56 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507B0801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a817ee9936so56069635ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173972; x=1736778772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMfyaR6RJqBfD3er8C32Qdvs+olSMFXco2LY62vKR8Y=;
 b=P3ABpqliFDcN4W0mjR3z37iMycQtUI1/ycCFtNUD5UkvgKSjYHnKeAuelqOpDJxxAD
 D5RoCXhhvWN44oaNLC/5ZWAV9on3H4+TbBP1vro1pA+xwZpzJiO57pW9JW7cF1Vt4pF/
 G9vLlQCJFqNNxynfxbNU2eWA931Up1ByqmFyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173972; x=1736778772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMfyaR6RJqBfD3er8C32Qdvs+olSMFXco2LY62vKR8Y=;
 b=HYQJuauOMG784OR+KUbXn4UVBcY395TC87WDB/KkxpTGEKI6mS4MPCG7hlPsUxCAK9
 nYFVNAbn/HYcfmBf3PMx2jzaUoPq30yKigZeHT8xKKP9/ZYufKmeGp+CvCaucKlB6yi7
 8FnTvQ6M83qUlRfbWbN7ARaM1JFGHmfX08qBaGfpO6R2EAKEcmyyTScPkWzqiH4U2cYH
 Hqomy4cEZm9DYLbsOBQK97/b25e0C9znXW+SdZNDmkjQYramM+0LW8MhGz+kqehsB8+S
 jJgKhLNovppc7XcQM2Jd46fl7Kd3V+UY0AmvUHrleAYgfAxXyCJloGvDS+OX4b9nV+Yx
 IcZQ==
X-Gm-Message-State: AOJu0YyIvQYW6qkXHEXSVh85+m1qFg3DaYhpY2K3kF/kjnyyav5d5Ot+
 fuov63WctjNhcB8kyv6TfPhNg9dDPcZ9KN0l1nXKFSWdOC6TFOXTyy3t/vvJhd85SiAgqIXIQJE
 =
X-Gm-Gg: ASbGnctYxXSZIwNC6ZrxICTr0tfRF1MqvtdDOIhTX4sXaiAnKvpMLhEaQZT3VF8RyfA
 FoYD7aIjh7LmcBgqrSynXAgLmw8HoeVp/l+BD5u6O/pLNvKZsZ5pP8CiGgER9r3voE6EFwoZ484
 uVTrBTRssQCt76FGqV+8OkpADwv4tNvibwYSQN5BtxgO0EELlNnGpGOe+5Uu538sqlrA60DkYhm
 8VVXVb9SHgekSB43ATlE+uZnF2zQ0MR/DCBDl0guI5zil6DlZP1WH7+sXYIUy7Su/BxjPC2siis
 FgfXF2RiBxba0jIpeA==
X-Google-Smtp-Source: AGHT+IEBGaas3v63MbMmUNlt13hehdn8DhmBad+DNFNyNkPGTnNCycf1cp42pUOJ9oWSK1tiPMm63w==
X-Received: by 2002:a05:6e02:1d0d:b0:3a7:e286:a56b with SMTP id
 e9e14a558f8ab-3c2d1aa30d8mr433184905ab.5.1736173972160; 
 Mon, 06 Jan 2025 06:32:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:32:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/33] abuf: Allow use in host tools
Date: Mon,  6 Jan 2025 07:32:01 -0700
Message-Id: <20250106143229.3023771-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Some header files included on the host are moving to use abuf, so adjust
the header-inclusion to bring in size_t correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/abuf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/abuf.h b/include/abuf.h
index 76e314b9a47..de21cefade4 100644
--- a/include/abuf.h
+++ b/include/abuf.h
@@ -9,7 +9,11 @@
 #ifndef __ABUF_H
 #define __ABUF_H
 
+#ifdef USE_HOSTCC
+#include <sys/types.h>
+#else
 #include <linux/types.h>
+#endif
 
 /**
  * struct abuf - buffer that can be allocated and freed
-- 
2.34.1

