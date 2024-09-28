Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F619CF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3960388DB7;
	Sat, 28 Sep 2024 22:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gKAXfdj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F7188DEE; Sat, 28 Sep 2024 22:01:21 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C97A88D78
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a1a7c0f612so17461865ab.3
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727553674; x=1728158474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoB/d5KMy5bQbG/sdT9C5HMay44BmDwloivxXMnx05o=;
 b=gKAXfdj2Odo22xtA1xiDUO4DKFRwxmDjb73K/mzdp4hLo2lX524+q0NSxYY/jk7dGt
 JlGp61fIiugvZ5bHBEbEG0BPuMFsN48jJfOId8I1nnDW84iaPZF/nmdvsUA3fPLT0V76
 BUNo2alSpJI5hqo5preGczLFaAd0PDCbjDNTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727553674; x=1728158474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoB/d5KMy5bQbG/sdT9C5HMay44BmDwloivxXMnx05o=;
 b=TW7UaA45cqd0WiZj/Ylsc0JhvpMykqrXMnFSEA+PaWzS1BdoAyei4rBxwv+qBhdehL
 +B8ndxnG44neOx63Nc9l1AVD+Rvrn4nkNtvW7rDazUBlgoUnGhw9bGDiAIVJaMEbX07w
 JwmQ2mwlaF73bsijkPNshErMOAoViFo90UB0yB282C4OdK+ECSfXhS6Se0K8lN3QneLR
 v+TtNbaBQXHe2IApEPZviClPB+gTqixHN6wdGKDG+COCsWtOktZbOkSANlWBBqP6FBO4
 DyuM9J6Klkp1yI+fcZtQm99H1XEfCVZv7SbqTCuGj6UEpUKoXkIdjIUKyqmyCMaQXz8g
 HF3Q==
X-Gm-Message-State: AOJu0YyHvLRJga5U0IJ9ERimUn4shYpPwGSBPWlYnI1JTWAl6IdMtinu
 MGsBH75SJGG4S7DJ/loF6fcNTD1n7ES5Szb194loNXkmTKcwZyXxnDkS1nfC8t+LpRHCnevZahc
 QqQ==
X-Google-Smtp-Source: AGHT+IFCuJixhTIMXJbaRhMJYAgOJNt6h8GavHdUGdnAC8BaudbfH6tLp3hNmOXEOeX3c4nNPsviPQ==
X-Received: by 2002:a05:6e02:1aa6:b0:3a2:f7b1:2f70 with SMTP id
 e9e14a558f8ab-3a3451b9ea5mr66655885ab.21.1727553673479; 
 Sat, 28 Sep 2024 13:01:13 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888835307sm1242590173.2.2024.09.28.13.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 13:01:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 25/30] xpl: Add a function to indicate when in xPL
Date: Sat, 28 Sep 2024 14:00:25 -0600
Message-Id: <20240928200030.194546-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240928200030.194546-1-sjg@chromium.org>
References: <20240928200030.194546-1-sjg@chromium.org>
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

Add the opposite function to not_xpl() for completeness.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/spl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/spl.h b/include/spl.h
index c9ab0f3e977..f90c3f56329 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -144,6 +144,16 @@ static inline bool not_xpl(void)
 	return true;
 }
 
+/* returns true if in xPL, false if in U-Boot proper */
+static inline bool is_xpl(void)
+{
+#ifdef CONFIG_XPL_BUILD
+	return true;
+#endif
+
+	return false;
+}
+
 /**
  * spl_prev_phase() - Figure out the previous U-Boot phase
  *
-- 
2.34.1

