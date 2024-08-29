Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA7AC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0FA88C7C;
	Thu, 29 Aug 2024 16:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cxb7DKbE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FB388C68; Thu, 29 Aug 2024 16:58:25 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 271A588C3E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-82a22127e97so18153839f.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943502; x=1725548302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHNHz6op4mTjIk24HuuufD1kSTRfTm/UKGJmAiYD1pI=;
 b=Cxb7DKbEXrUXsiTk3NIjxTd39/ZDvT87aQRFhdPdOqzhTSVTl8hZbSygcm1pLS+8T7
 wruJlWnBVmPU4RUZTO6LAW0OsUu1DjNhvtVmDYqMeTjchcdBJBQB5PWwb9gLrt+qVTUj
 n7Ycl6QiIIEEA19ZJHxu6M9bWvnPplwMJ0cR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943502; x=1725548302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHNHz6op4mTjIk24HuuufD1kSTRfTm/UKGJmAiYD1pI=;
 b=k+T4BWKoOrr35v3MFvtRL2xdbc9DegOjlskoEk/oVvs8659uUo8XubNZYQu4HM4ztt
 aq4xgmj9Cz+VXIvn1Y5d3YAvAdhBHpiIhwqghHOXgu55shZ0pthKwd8dVnAN0kNjthBG
 gIEi4jMSipZn0vlseznjR+tI8HZfv/OjX2++6Vnl0MAks8AiEsfIVcuQ4Jv8lI2g1rX1
 dN5ne5AQOVUxa5qHSvRyZgtvmuLuxP+E4t9rnIPiQZYka8hW/4xLXo2qESAVzmeB8UGU
 ttzravclpO5JCr1pLFEAfpQjAWJN6sP7k90SOqLqBsW86ilXmWR8KvUqMO/JvhHekS/n
 81tA==
X-Gm-Message-State: AOJu0YyKdf4NU7fAFDDJOsl1L9U2oXZvhpa3VLZy33MIJpb3zPXVHNod
 osQTkRxwJs2RVZBjpjaQctGKceypAoFSttd2jyD42mLJXe5iCbvXqHexOyaFMS44aXDaeeGACB0
 =
X-Google-Smtp-Source: AGHT+IGRFHbSO5aGqMg0sq3/Ta+9aVhsXmqvfeDiGsuNNHP5yogBRff73LWWxrXrVWHnIGR0QSjLJw==
X-Received: by 2002:a05:6e02:194a:b0:396:f026:b0ac with SMTP id
 e9e14a558f8ab-39f3781de65mr43424885ab.14.1724943501714; 
 Thu, 29 Aug 2024 07:58:21 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/19] malloc: Provide a simple malloc for VPL
Date: Thu, 29 Aug 2024 08:57:50 -0600
Message-Id: <20240829145802.1827952-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

The VPL phase may want to use the smaller malloc() implementation, so
add an option for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/Kconfig.vpl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index d06f36d4ee4..3dc0e95e09f 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -222,6 +222,15 @@ config VPL_SPI_FLASH_SUPPORT
 	  lines). This enables the drivers in drivers/mtd/spi as part of a
 	  VPL build. This normally requires VPL_SPI_SUPPORT.
 
+config VPL_SYS_MALLOC_SIMPLE
+	bool "Only use malloc_simple functions in the VPL"
+	default y
+	help
+	  Say Y here to only use the *_simple malloc functions from
+	  malloc_simple.c, rather then using the versions from dlmalloc.c;
+	  this will make the VPL binary smaller at the cost of more heap
+	  usage as the *_simple malloc functions do not re-use free-ed mem.
+
 config VPL_TEXT_BASE
 	hex "VPL Text Base"
 	default 0x0
-- 
2.34.1

