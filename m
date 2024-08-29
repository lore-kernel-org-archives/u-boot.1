Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4A6C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51C088CA0;
	Thu, 29 Aug 2024 16:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MLqrsu7W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A6388C70; Thu, 29 Aug 2024 16:58:36 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB0388CA3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-39d311d8091so2722275ab.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943511; x=1725548311; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CtfFvJonR1FqlwlBLZ5CXEmdeAHhHB31QymJzP/cOYI=;
 b=MLqrsu7WADETYl03TuUwVNKNjGtWQ1ybUCiec+uw5dOao/szU+FNvGm/ZOqrgGiYow
 QEV2JoMYrmPlSyah8U3K055FYTQV8KN78HIr9CD2sgDVY9719H/v6YW6VERJ6XnaKQyl
 FW5Kwd2mTJqy+KYhcSauf9ydO2iXRB+USTfPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943511; x=1725548311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CtfFvJonR1FqlwlBLZ5CXEmdeAHhHB31QymJzP/cOYI=;
 b=Kss4d4d45yUDx6naXIpabk+Ca5u06D/Mujt7zzWYynhMm6fhUEIx23pRhAzV3qNQm9
 PZ6oHvWarFCXvK6wmzyE7Cdg6f2eLkEfhlkwTTYQdvjIyisKhRZ2cmpDP6FNILoDMn9q
 OiGJBna5VD3SIKDuxZumKtzMjzn6iShskguCqa0A+vHJVlqNqRW1sVZQA+HUzmIsHdm6
 wJFLAZd38XgfQsjz+OBmsM8IPQye5hslQBqyktpVw6ihzMLQPTF/IiI8Odw8JD6jJ/E6
 l0uVh226cjojwS2gmd2SNZZLvKwhJifOgCy+0EbE4NZS/skarAfNmi44X2IM6HTpd1Nb
 1UoA==
X-Gm-Message-State: AOJu0YypHkdP/n2pD5o6OOyAuvt2BMJA1hRE9KgMzPXXAhoGwhOLpvm8
 K9Y5rGsYvIqobR8PpTj0Yy897246L0I27gojoeU+Mh03Qi6XDxuBFmKJO4lqF9rZkoLag7/hW44
 =
X-Google-Smtp-Source: AGHT+IHsknD4n6/fr1p2nRORVngXbnf3q8D7vR+DcMzDFeioOXCjZ/NBdOkafT9UBAX6hizzCX0gow==
X-Received: by 2002:a92:c56f:0:b0:396:c825:4db6 with SMTP id
 e9e14a558f8ab-39f378693cdmr38580225ab.26.1724943510838; 
 Thu, 29 Aug 2024 07:58:30 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 17/19] lib: Allow crc8 in TPL and VPL
Date: Thu, 29 Aug 2024 08:58:00 -0600
Message-Id: <20240829145802.1827952-18-sjg@chromium.org>
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

Provide options to enable the CRC8 feature in TPL and VPL builds.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 72a5f3cb04f..b2d5e8d04a7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -698,6 +698,24 @@ config SPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config TPL_CRC8
+	bool "Support CRC8 in TPL"
+	depends on SPL
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

