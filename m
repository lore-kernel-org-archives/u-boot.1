Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE003C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D83869C3;
	Mon,  4 Sep 2023 16:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZmP4+4Uv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108E9869A4; Mon,  4 Sep 2023 16:41:46 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4218086936
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-34e202a9cc9so4306285ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838501; x=1694443301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUwTrNOrBU3cDJ/jUUNKTqXrANK3FAh44F+MUkfbvuk=;
 b=ZmP4+4UvrE/8rXLNDy0NjJTs56pkcQ7g7hAkxURaHQkm2Vd3LXBFwkuNKWoZ8CC6CC
 RtKRAQ+vdyUHUzPihPxX67K1L9e6Kw9UCGqFWZ8AMMk3EttsA0BInCT3btY0d898zGJA
 SfwhIQ7WOzXx7Sls0CCkAGVx+H3EExFj5kh3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838501; x=1694443301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUwTrNOrBU3cDJ/jUUNKTqXrANK3FAh44F+MUkfbvuk=;
 b=WfWaFMt2JBg8V5vmRZX8+TKaBUV7/qINezBbG4zAWcruaqv9eWE7l4DXt9Jb9EMTP3
 WtWplDcRoiZqzHwsFz2NqI73+KzzDDqO8InBvUJPNJdsNraMZBSfIzeMl4apU8Yg9Sqb
 vR+2MTHoRvE5v5N3U6cLdx9qps1RCUTXz31FTEYC98PK5lBhmRiUt9ZRCYrQMyBkOtjv
 75/btrIsim3v0WAjhBAVi6BYZOfFUC+f6Ky7LXEVx2sh37WlzJZzbzmWriIXWZFRfehq
 KGzjn2KhO3rVr9LgTvRQyfuyuHGgt2hAFnlt+quEJ2Svb70rDz6pX1Eev72NGx4p8x5g
 eZ9A==
X-Gm-Message-State: AOJu0Ywr7ZkBThRtTw65vFvqD2iaPFpSs5gRuB6j9varigndUG+M4znX
 aFCz2wgKvtDnhz/aFaDNbBDIm4K/cdZZ9WOey8A=
X-Google-Smtp-Source: AGHT+IFK0fr9d3S2WYCGD349MBuYKzSlvJcyrvEQYPcLipgXIAzpcxOGtAboh7QBg0cwTW4dnK2h+A==
X-Received: by 2002:a92:d944:0:b0:34a:be3f:9ee6 with SMTP id
 l4-20020a92d944000000b0034abe3f9ee6mr10754718ilq.12.1693838501798; 
 Mon, 04 Sep 2023 07:41:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 02/20] Kconfig: Move API into general setup
Date: Mon,  4 Sep 2023 08:41:05 -0600
Message-ID: <20230904144131.2699824-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

This is perhaps not a commonly used feature so should not have its own
option in the main menu. Move it under general setup.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 91170bf8d223..0a2e97578dfc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -585,10 +585,10 @@ config MP
 	  This provides an option to bringup different processors
 	  in multiprocessor cases.
 
-endmenu		# General setup
-
 source "api/Kconfig"
 
+endmenu		# General setup
+
 source "boot/Kconfig"
 
 source "common/Kconfig"
-- 
2.42.0.283.g2d96d420d3-goog

