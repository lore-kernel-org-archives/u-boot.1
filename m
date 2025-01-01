Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E489FE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A556F8042F;
	Wed,  1 Jan 2025 23:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HGoGHy+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BF980714; Wed,  1 Jan 2025 23:23:22 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B7380379
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163b0c09afso143592685ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770198; x=1736374998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VOZC1n4NEG1mvtHjZ9Ac9MeaGGD65LVEX0/JpMhBhSY=;
 b=HGoGHy+r4Ebb5z3IiNbEdBZgWAvsUazdPwveAq8N2wlpWCc9NDcWlsYPPmjIGBTwxK
 wD7gp1cFzMnY66FVgP49PxrOV3boFZh0xqqe6clxS/z3XyYvkNlMeRweZOXM4Y+qvgZz
 5Ck+hpvaQ2T6m+HrmJiZcerwv1lvMNqoBKtNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770198; x=1736374998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VOZC1n4NEG1mvtHjZ9Ac9MeaGGD65LVEX0/JpMhBhSY=;
 b=uhLmgSrQvbNHlByMl/qokO2ZEdldXBGDs4ANZ0v3ZT80CrnmbUL0QQjfR/k4Bkhrc5
 T06tjGLtM4BvZQ1d0k0TdHouVW+dNi9Ty5bUSIq0G9xMK6qn0Qa2A0azOa5tF9Y8CC4n
 uyONQj4ASK2xTXcYXNMkirL1VNjP/ixiaBtR1BwreNRHrzOF8pflcoInQqiv44D59AqH
 vtR3hAuLyI658UgvYNvHpAyTWbJw2XbUl2/vE+7M0hW/utDr5RncdMQ3x3xMkAsRJPZf
 FhNfwGS+q/XX4Fkm6mDelj+33A+O5xsUKzDuKbP/QPEw0tKI4GGfhEP2RnlxW/8utP7T
 88Rg==
X-Gm-Message-State: AOJu0Yz3WGiVnjNrpR0cePlabC4as0Pi3veq9oouDkHCp8cjs48a3HR3
 poFa12IPtRJPreqFvL9GdPopqmDgEhj0YRKQ1CQsmcQTXLg/q6KZc6jXfFx5P8UFjbE1IFSOj2Y
 =
X-Gm-Gg: ASbGncuDL+yPLLN29f1LPrZcPucJ1bqCTeK9HQSISibRHjlqbi6YRLM9Z/+l0BXZ2fA
 JkLoqhIQoDPPIAwivB+s5zmeazsIdMjwZ/dlxBtSGx2ajcaXv1WwsCks4MUF5yaGpXEJZ7JdqeR
 NcfuAtor6hoXCHTUUvFw1KO0749qRnzCBRt33U4Ddf+QTmn+ALgBWV66PDgFO5LlWDh8TcbXIcO
 wkXByw0qcieeg2Obpjn92ZQML3KGK+fRIstlzHjduRzQ3mdZ9cdodQ=
X-Google-Smtp-Source: AGHT+IFqmM7r2pVWG490zJqAd6H2YR5BeHwEBv8qPUIaYrqxwGdIjvQpaW4qdbkqPnGdbUu5S8k8iA==
X-Received: by 2002:a05:6a00:ad3:b0:728:b601:86df with SMTP id
 d2e1a72fcca58-72abdd91456mr62357952b3a.10.1735770197999; 
 Wed, 01 Jan 2025 14:23:17 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 62/67] upl: Add missing word in comment for upl_write_handoff()
Date: Thu,  2 Jan 2025 11:09:48 +1300
Message-ID: <20250101221003.1944600-63-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The word 'we' is missing. Add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/upl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/upl.h b/include/upl.h
index d5b2cad7196..b9bcdf60089 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -324,7 +324,7 @@ struct upl {
  * @root: root node to write it to
  * @skip_existing: Avoid recreating any nodes which already exist in the
  * devicetree. For example, if there is a serial node, just leave it alone,
- * since don't need to create a new one
+ * since we don't need to create a new one
  * Return: 0 on success, -ve on error
  */
 int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing);
-- 
2.43.0

