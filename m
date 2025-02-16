Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E428AC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F163A80FAC;
	Sun, 16 Feb 2025 21:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bOYUDxvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC5180F96; Sun, 16 Feb 2025 21:45:16 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29C1A80F62
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d03ac846a7so13244755ab.2
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738712; x=1740343512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=bOYUDxvDcZl9nE94s5aIJV0Z5lpCY4FAFfmsg3wLHeG555tnYphK4GZSoI9R5nxTza
 RD8DE5wouxJsfWe8vlXCm+UwoyD3vIiuMJUXcPU/QLTJ7Y0BC/CBkQMwOIkK8x15C5v5
 hjPZYgHrZMDwIeFVCGh6i2pt5L63logQW2eVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738712; x=1740343512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OL+SdnJwpe5BOmmnoV9SoNZInavcIsY+uTHTCChoPA=;
 b=ljkZxPLX5YTFfs9ykkSiWIRPS2b2NXLIqezf9xYlM8aCZlk0/PhTeeze3R5iU/Lp/s
 fHYX4mNb5Wga8EU8jLQ7F42qirS6O14bYhKbDHQnb5qbPpLRk6hHGDzqc7Z11yPuCDwO
 Wd5RTnDlszanxJ/uk9bhbf5wiWlyNqkzXgCi90cpeuAxYdlo1V8up9JV8yLuajS1TIQN
 tct9Z/7CvCYBLa5BrB/xj9+sAmxOPVYBTPjAR4cLsNG/cU1dFxOtv4qo8Mp+0RnCSeYw
 kMnQBXYUrU3vydzO8WuLc3jYss60OBTfN4jjdln0kqRODWycqKd9kyrM+ANOK31gd1AS
 qCkQ==
X-Gm-Message-State: AOJu0Yxpk+HaJRyItLi+v0lH1ao9MQJwkq6DboXOAiCFCAMkqawklEdL
 dtF+x2L9EIJhvGK7wBc+eYds3AWb6Q37Z3J2f2mK5AeXRqrMuPl8azX6WdNRmbpy18pLCFPk3aI
 =
X-Gm-Gg: ASbGncviw1y778owRIJNzlDlHvn/2zTD2d0tsygv5Haq6QkM8ULo4oV/kWtbdMAQcEx
 IygL/2GiJLBiupU55WH5m96qpNljgNhkI8PUbTu6OowTBZYZgq+StN5nhjrW8SutrW+Xbb1BB3Y
 MaFokd6j8f09ra0fLgxHrhyo4szf10yeEMRUtqfm7UIxqOKPKQNuN5dixP+Aqz7dYXow0WpxEm6
 aXSVWEWx2uX1wbKddTdGyoz7X/1w/XO2INaDen7DL9KUnlJQ1YqYWmUpejN0++OyVPUoj0xb2EP
 w3qwtqVtNXvEymDDt5jS3oNq2Xz9eCmLG6iJew7Pu6kqHZOmMRFY
X-Google-Smtp-Source: AGHT+IFsp1mMluZ+6pUUq8zdqIKUb5SNtx3FclICasAOnn8XMM55+qRwXnDTb9SCxCWOo29pdVaUAA==
X-Received: by 2002:a05:6e02:3103:b0:3d1:863e:5536 with SMTP id
 e9e14a558f8ab-3d28090f547mr70262205ab.18.1739738711941; 
 Sun, 16 Feb 2025 12:45:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:45:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/28] x86: Use defines for the cache flags
Date: Sun, 16 Feb 2025 13:43:55 -0700
Message-ID: <20250216204421.3560012-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

Use some named flags when setting up the cache, so it is easier to see
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/i386/cpu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 3bbad3b2eca..845e00ca439 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -592,6 +592,13 @@ int cpu_has_64bit(void)
 #define PAGETABLE_BASE		0x80000
 #define PAGETABLE_SIZE		(6 * 4096)
 
+#define _PRES BIT(0)	/* present */
+#define _RW   BIT(1)	/* write allowed */
+#define _US   BIT(2)	/* user-access allowed */
+#define _A    BIT(5)	/* has been accessed */
+#define _D    BIT(6)	/* has been written to */
+#define _PS   BIT(7)	/* indicates 2MB page size here */
+
 /**
  * build_pagetable() - build a flat 4GiB page table structure for 64-bti mode
  *
@@ -604,15 +611,17 @@ static void build_pagetable(uint32_t *pgtable)
 	memset(pgtable, '\0', PAGETABLE_SIZE);
 
 	/* Level 4 needs a single entry */
-	pgtable[0] = (ulong)&pgtable[1024] + 7;
+	pgtable[0] = (ulong)&pgtable[1024] + _PRES + _RW + _US + _A;
 
 	/* Level 3 has one 64-bit entry for each GiB of memory */
 	for (i = 0; i < 4; i++)
-		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i + 7;
+		pgtable[1024 + i * 2] = (ulong)&pgtable[2048] + 0x1000 * i +
+			_PRES + _RW + _US + _A;
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = 0x183 + (i << 21UL);
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+					 (i << 21UL);
 }
 
 int cpu_jump_to_64bit(ulong setup_base, ulong target)
-- 
2.43.0

