Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7139C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 12:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC268214B;
	Fri, 18 Apr 2025 14:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k/hmM32D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08248304C; Fri, 18 Apr 2025 14:51:27 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EDB819D2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 14:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-86135ae2a29so160680839f.2
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 05:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744980683; x=1745585483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxKnNLbxcbhiBVfMIeu98FjacIJdFAJFSvMJw6hlfe0=;
 b=k/hmM32D+PQkkm68zLmptpPbo8nj3kPdnhssbwkbeZOor7zYSpxstiPIcxbGtvE8TS
 g7gACQ6cojVTQzVtL0GpOKGNkRPEXHJlK2weoTZmm9by20hiqM2+X5PU5INyjsvjTa6W
 181wPlQYMB9ZKt5aaKowoZmiYvgaOaj9OYgNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744980683; x=1745585483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DxKnNLbxcbhiBVfMIeu98FjacIJdFAJFSvMJw6hlfe0=;
 b=D4pksD/pbHrFYyKpLi2snXq7Db86Gn8ZwpWoOuTJjcWWRiZlWDyfKF1uU/TVe4ToRi
 lwYyLCjfN1mQDHmZkYImqYsGqNnf8ci1GLPtnV5pKHczD0CJPxuQ36ytfgHq+y7VFhaF
 8WSCPQq+EW8sCWoDLkziGoflRGaksBxJDHsqmSrnXuHDUkyUC4yiOLM09E9CK6TJT1Z/
 3S4WGb0zj0rzLo3YYFEzPESb6kSSlGZZN3+n1bZ6vPb+lrFSejqdcU+bUtbp11VlHl5M
 LqKb/R7a8+i66380Oi1mVUVkZ6/Me3o+Kpb4v2UhDmswOatEUX26vOnwQVynZblvIAsN
 NU+A==
X-Gm-Message-State: AOJu0YwXEZR3dkWg3vc+ZAhDoxvamFt3LO4XCPmq3UokWVfznwj6kKwo
 WJC8OM/EkuC9HTYNmJDCLsMTRkBZ3o7AAe/RzEeT84RtjGbJbbOsk3wx8HnuQNJAahnlrPXnJXw
 =
X-Gm-Gg: ASbGnctnsk234lmEOwFMNS26/0lC0oF3EiU8blsC36NZ0EfXHK/PPGTKy2M1r5CCNCr
 qTFB6ngRdiJnL4zA2jMgYzsi0p9SVQMSBHa+0IJo0YNBAHj69+G4IY/8BAjbHryBx8xCoirNfS+
 vNztK/AM7jAD76cXVd3tI4nfqlfJU8HBIdVE/N2CEAAv8tK+t3+wtDiwsIvvju5a3AyLSF8oC0R
 fM7EDoYDvAw9GtxwQy5hMuw5l4ereWmRcSescC6xlbMiFbcYxfg5vEwY/+TxQ7vZIoebb6ClZLY
 kj/gaaOPHHaRA3xKvxKQBUOgVRKbpGIXA/qeFdeg6HZOyCVN4kKFHfaQPmHCKy0472JiHkQMV5u
 7NA==
X-Google-Smtp-Source: AGHT+IHSuzpPu1i0gYhHSqR6ook9EShCOXy5tUN1iuQDqlr55cIUJAeUMWmMbUuRfT6gNHP/pfDosQ==
X-Received: by 2002:a05:6602:4182:b0:861:c4cf:cae8 with SMTP id
 ca18e2360f4ac-861dbddc869mr212342539f.2.1744980683001; 
 Fri, 18 Apr 2025 05:51:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cc0a3sm427555173.20.2025.04.18.05.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 05:51:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/3] bootm: Add RISC-V support in booti_is_supported()
Date: Fri, 18 Apr 2025 06:51:01 -0600
Message-ID: <20250418125111.2193434-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418125111.2193434-1-sjg@chromium.org>
References: <20250418125111.2193434-1-sjg@chromium.org>
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

RISC-V uses a similar linux 'Image' format to ARM64, so add support for
it in bootm_load_os()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 2ed78295ead..7be5ec796fc 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -666,7 +666,7 @@ static bool booti_is_supported(struct image_info *os)
 	if (!IS_ENABLED(CONFIG_CMD_BOOTI) || os->os != IH_OS_LINUX)
 		return false;
 
-	return os->arch == IH_ARCH_ARM64;
+	return os->arch == IH_ARCH_ARM64 || os->arch == IH_ARCH_RISCV;
 }
 
 static int bootm_load_os(struct bootm_headers *images, int boot_progress)
-- 
2.43.0

