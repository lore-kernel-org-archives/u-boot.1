Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE65D637A9
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C8E8936F;
	Wed, 13 Nov 2024 19:54:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XwhbN4Nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3595988216; Wed, 13 Nov 2024 19:54:09 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3344989549
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a3b7442db5so27777265ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524044; x=1732128844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZT2CFKII22ohj3AnIFm3MH72P5ppfQ6V+eKscDiEFE=;
 b=XwhbN4NmTP6QQpBaR7yi463RxGEOj5t5kE0t+6JNYAUuH9KCYOUWn7KFpilV+/FnQR
 3zDoETTJKjnuPcDdqnyKzuQSIfGU9VJVcRndn/1CpU0GefKMNf5vh4AB3ZheuUUcAAny
 2O7DQvxY5AsjcYDojzDh0QJOPiY5676Or5si4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524044; x=1732128844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZT2CFKII22ohj3AnIFm3MH72P5ppfQ6V+eKscDiEFE=;
 b=Ob78iHAfbx+kSxh6GzyodJ88P8zgiPVfWop6xWW2FwBtMeQjZ2dhoryAuta2GCy63C
 SDL2R7HrSL3vMaD4v2NvFJLBZJNvyz/Avaq63l2M/c5X3kTY2ogDgAJmPG4wjwFBjsaf
 f74/uHuHCdnDOjkrH0LOqLAaOzO561jmMRbJUGVUJkpG+fvkJ/A0KpgOtDWM1z92eNBE
 Rss9pb5g4WHSIwjh3kJbiHffumJ9Ui1OP587CQIxZQWI5/pLZTVZE/QX75itO/f0t33e
 kNWobihFMX8aMG6sFxjrfrpTKegMmhad4f+GXsPz0gcEsed68C8GoKsc5j0JNRdJ+JuJ
 tmkQ==
X-Gm-Message-State: AOJu0YztCrYqOSfXjLFbxk2qeh3wGzEbm8SsdVcWpv8oYHSXIpkQYqJi
 csiEBECWSnVZykSLiTxHEg26+fDhqUpNVpIrLSRki/l4Oo/vQfrKhlqbVGfCpaYDYvvX/MpQmP4
 =
X-Google-Smtp-Source: AGHT+IGKALdco6scYQsHnz60ViVk8X+bosEvkKiUZGasRPewY7n3H+hw4Y3qKtZMcjCyEjW+7k+hsQ==
X-Received: by 2002:a05:6e02:1a2e:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a6f19c33b0mr169442685ab.12.1731524044109; 
 Wed, 13 Nov 2024 10:54:04 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:54:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 6/9] docker: Fix LegacyKeyValueFormat warning with
 PYTHONPATH
Date: Wed, 13 Nov 2024 11:53:37 -0700
Message-Id: <20241113185340.1661198-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113185340.1661198-1-sjg@chromium.org>
References: <20241113185340.1661198-1-sjg@chromium.org>
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

Fix a warning due to the syntax used for PYTHONPATH:

   LegacyKeyValueFormat: "ENV key=value" should be used instead of
      legacy "ENV key value" format (line 304)

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 048a57c5b16..aa97dadbd64 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -301,4 +301,4 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
+ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.34.1

