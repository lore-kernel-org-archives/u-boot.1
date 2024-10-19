Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4476BD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B58D89301;
	Sat, 19 Oct 2024 17:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UmYMVOUT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73B56892F0; Sat, 19 Oct 2024 17:22:53 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 598AA892A5
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a3938e73d3so12059055ab.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351370; x=1729956170; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60f8MBpTNJqTQ06jU6dQc9FvzH/pU/ecmjL3TgTUpGU=;
 b=UmYMVOUT5tiJVP8LxlkjJlb0i+dJDXWAwt0EHixGM9oU2cMwZHCvKhoENSlj9JaBMe
 b1hOCvTtbE6/2C/y/Ca9Edj2IiHcR7L12SS1x2wOI0zjkSrhfDoZzRSJ6RMvCrDP8s3k
 qBMDL/YgtSEfWOCwYXCVY/z8jQsLGyIMymwM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351370; x=1729956170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60f8MBpTNJqTQ06jU6dQc9FvzH/pU/ecmjL3TgTUpGU=;
 b=Ee+P3ptLhmFI7Z1XnAgHKIkD+0iMUYth3FDtxKjcQMLLY9pgxbp6YTMwrFR/QTQsZm
 Rl0XrY1va8kPHSxG/GxVPRv0FPL4nm9xZ3gkUTKhG6Vs+UP+uBHa61MioO8SqaG6cHVT
 AB0ynEtX6sosx2HOSqOSh+k1Hv+x7wVTpvqT8T0zRMbSYk+W7W5vnCUSUzqZPOAlhj3R
 I9Dl7UU4tsnu0EITHoF/5Gl75Eg/oUya/893+lKhObI7CQzTg/YIAkLOZdBMKLVlVF4d
 FhFzm+pA2+xF5TBOLhZn3N3deTbcocbQpJH/Dr+B0a3ssfc7n8CCIEMA++Cbc+WoeYuk
 fADA==
X-Gm-Message-State: AOJu0YyRnPYBPzjy7jq679yqolzWYnwP0liMxp32f+hiw4IiMSykwW4A
 aRYSQKdsh+YKip8XMl1rZqAkxWRoJwLGXt9K5A1C7ziUMau1d1tKlSsQcm+TX9rw0jPQT37f3Cc
 =
X-Google-Smtp-Source: AGHT+IHHVbdD4ubJycbRLr74rw7749voFQvKAjLPm+5SipxRBgUfYZuq3+aoJ2/t5K19kg7s8ja5fA==
X-Received: by 2002:a92:ca4f:0:b0:3a0:909c:812d with SMTP id
 e9e14a558f8ab-3a3f406242fmr54660485ab.11.1729351369930; 
 Sat, 19 Oct 2024 08:22:49 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 18/31] test: boot: Update bootflow_iter() for console
 checking
Date: Sat, 19 Oct 2024 09:21:58 -0600
Message-Id: <20241019152211.1014896-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

This test checks console output so should have the UTF_CONSOLE flag. Add
it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8ea284098e7..efb82ee628b 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -370,7 +370,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT);
+BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
 /* Check using the system bootdev */
-- 
2.34.1

