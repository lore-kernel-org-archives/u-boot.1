Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB39C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2810188614;
	Sun, 23 Jun 2024 19:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UdnCQqH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 645CD88271; Sun, 23 Jun 2024 19:56:30 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF3D4885DF
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3762eadd807so10244645ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165386; x=1719770186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCwlFGKg08f8qABk7PqsT5dI1TREUOUAElNW2boYH/k=;
 b=UdnCQqH+nDmfMNIzkxH+dfL7Qtd/igW+cDtqY43rGnT4h7Vyq4zTTOdyPHSA6OY2mB
 Y9hRX7Jz5dI1q6HmVAz9Z+Ne74Rdz8qF3LAoxsTW682EWdJAE+R19V1ZOO0ksMQWsZQo
 QvfUov3OSTJRyy4ngOOkkKyMQWwDD8fjWnnAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165386; x=1719770186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCwlFGKg08f8qABk7PqsT5dI1TREUOUAElNW2boYH/k=;
 b=PkekZ69z93ViMk4NdaQAmGRoW1kuDossNYugGAobfB1/7FnONt5864QdWTOPshgkqQ
 sBHfhMuaF0YV+Qq4HDZ0GuSTzoaSLXe16bl6aGpxIeSE4peXyldNxj1qh1Eu/VbIsPPY
 A69vrJCulPPN8M+vgFj/dtye3AunEQIdV5I3pVNrDZYMGHBI6AF4/B9dqZZPGtrmq4G5
 TNDvt1hFGOqRI+tPWS/6VNIzKZg1ffwP59d/4uROA0cCeZScCIry97YLC1YV43CduMmv
 Oj+mRC6aTp2JK7ECI5XFKmQGcqOlkeTPGnWYqox2+SHFRtgftL5z4YPITErTFXzElD2R
 7ZqQ==
X-Gm-Message-State: AOJu0YwFlrZXaUSmsBJfKljKN30tMWBGvRY1GicNYzb5SQc/a1ctSkCv
 AR6wRKhA3AaSljhNSZw0lb5O1Ahx5Ui5gREhFQvya4jqc9rMlEBtFWr4pgn7ywYL/3v0jUg5Avx
 qhw==
X-Google-Smtp-Source: AGHT+IGdeBRMOLJAdu/YU4UdnbDOk0g2eMwkWa/cgCAPs3YQK2E/YKqWdbh4KJ5edUvpUCFq5JKwBg==
X-Received: by 2002:a05:6e02:168a:b0:376:1c71:1e1d with SMTP id
 e9e14a558f8ab-3763f5b823cmr45949725ab.12.1719165386595; 
 Sun, 23 Jun 2024 10:56:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3762f2fb1bbsm13551465ab.12.2024.06.23.10.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:56:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH v3 2/6] buildman: Add python3-pycryptodome
Date: Sun, 23 Jun 2024 11:56:18 -0600
Message-Id: <20240623175622.1468600-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175622.1468600-1-sjg@chromium.org>
References: <20240623175622.1468600-1-sjg@chromium.org>
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

This is used by some Binman entry types, so add it to allow more tests
to pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Add to buildman requirements instead

 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 564e54898a4..052d0ed5c6f 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,4 +1,5 @@
 coverage==6.2
 jsonschema==4.17.3
+pycryptodome==3.20
 pyyaml==6.0
 yamllint==1.26.3
-- 
2.34.1

