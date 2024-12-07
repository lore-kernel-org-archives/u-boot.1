Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B5CE7717D
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085CD89522;
	Sat,  7 Dec 2024 18:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ik34Ho04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B81089529; Sat,  7 Dec 2024 18:26:49 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7149D88DC6
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-8418f849466so115714639f.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592406; x=1734197206; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkz0c06gRRPJZlbLDbF7vNYbw9EquMbF8TIbpry3kCw=;
 b=Ik34Ho046G7V3oVjlOcxkGknWlGeMhxuY9/1Bjztq3pQLvq95CXAtVjp1rQEpmaHdZ
 YXJ6U6esxVtXNEnHTs1zh5R+tEFl5RVj2AfDme7WnJttkMXcK4TZ2PfrHkf/mCi6DmGz
 iTFpXsTS7Km4sR/ChfGAN1EpOfs/qEs27SMtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592406; x=1734197206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkz0c06gRRPJZlbLDbF7vNYbw9EquMbF8TIbpry3kCw=;
 b=pUYP4eUeipSiEk46nKwes7A2SB3F3G5bm89IuoGjF3bemTImRCIMFbe+lRymVklUmG
 3MdJYVuO89FIRLMBgOmHEiA9FROnwpo7hMklEAWu31r+jW17PWy5lk3dE6b3lpkpxbXK
 LLlTNLIwBeugrOvvMpYzqvcysMJvhKg/x+wmMVibFyxHgTWlSbKQLQuIzHxQl4ZXl/ZK
 6wmPVBVeRGZXvzpcZkjYMUG6s5WU4dn68stKgx/lBg+viCSsPTMq8H6GYbrCzKn5ZTlT
 CSVCAHCoLLbX2ugCkMZZiZoV9QoGMyGiT+JAliQd0T3G2PF6jkZ+drTMueRtMPBzglr4
 BvYg==
X-Gm-Message-State: AOJu0YwEDVktM/ZxgQ5eY57Y1fceHlCivPBX9NOTQGUC55IT6ulEM/Ic
 NwNxepuDdf+17l/ctPektFiPbHGzhTsUkgyg141147vaJotq0cLsaGyRVFe/kfnsaaa1/lGx4Xg
 =
X-Gm-Gg: ASbGncu2e28fHiP40odXSQislifE+IxIGRZxeIZGHkKcyHT+QbjBdRYC9nGIHjUIHeq
 Bu78y/UcuLOVwx1yWYCneYKVuh/WW0VRRi71vGi7KmsJm0vTsqTbWJwZ2d3Lua+IgSbWEEbMNaC
 OQ71Jpa/N/bF85mzvuBdt7CSMpJWZQgeqikpM9P7ktsAR84cXfg8tx+lTDLIIFK2hqua4byTath
 XeCZ4tzeGcmiOPjeerfRODJz3jhi15TZxrAn2hQmIWWbRlTksW1YLJh8NQcEdem3JmWMOzNWsz+
 wnc+D9RzC5s=
X-Google-Smtp-Source: AGHT+IHRAIDD0QjxbXD4njSavbPwlM3FwR5qf2sCG8fSmmNUyUyjUdUjg+aPsxI+upCKn8ecM/8NpQ==
X-Received: by 2002:a05:6602:48e:b0:843:f30f:7d77 with SMTP id
 ca18e2360f4ac-8447e24286bmr870382339f.9.1733592405739; 
 Sat, 07 Dec 2024 09:26:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 17/19] lib: Allow crc8 in TPL and VPL
Date: Sat,  7 Dec 2024 10:24:10 -0700
Message-Id: <20241207172412.1124558-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

Provide options to enable the CRC8 feature in TPL and VPL builds.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Fix 'depends on SPL' to depend on TPL

 lib/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 3fa580ab1eb..c8ac99df78e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -719,6 +719,24 @@ config SPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config TPL_CRC8
+	bool "Support CRC8 in TPL"
+	depends on TPL
+	help
+	  Enables CRC8 support in TPL. This is not normally required. CRC8 is
+	  a simple and fast checksumming algorithm which does a bytewise
+	  checksum with feedback to produce an 8-bit result. The code is small
+	  and it does not require a lookup table (unlike CRC32).
+
+config VPL_CRC8
+	bool "Support CRC8 in VPL"
+	depends on VPL
+	help
+	  Enables CRC8 support in VPL. This is not normally required. CRC8 is
+	  a simple and fast checksumming algorithm which does a bytewise
+	  checksum with feedback to produce an 8-bit result. The code is small
+	  and it does not require a lookup table (unlike CRC32).
+
 config SPL_CRC16
 	bool "Support CRC16 in SPL"
 	depends on SPL
-- 
2.34.1

