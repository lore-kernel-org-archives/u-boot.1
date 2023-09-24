Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DDECE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E6718698D;
	Sun, 24 Sep 2023 21:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M2rUrM+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9648386B1B; Sun, 24 Sep 2023 21:26:34 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D4BA86B5D
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fa2125e19so127659539f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583581; x=1696188381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sb7bBWAiDNoaqdOtKTmuTaynVR7GHKOEwpPsieeGxKY=;
 b=M2rUrM+JFUf0jLvxyXXKkYaYw0bpM5VtDnbyKjhmXQvIexcsAakOqwP31SjM/+tOZ2
 JBQvAtmz+koMcvlcLNaBgvG66g4sKe/Ix5pa7cY9CjxoYITIqPL1at/9IqRq7FnNMUbs
 B58fJWkuwoMq1HjShQlBDl9EmqXP1rFg2WP5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583581; x=1696188381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sb7bBWAiDNoaqdOtKTmuTaynVR7GHKOEwpPsieeGxKY=;
 b=t/HtxYyq3U8NMLD5JFstcVTaOt5S83UrWCIxtjoXqwauVyLim/iGeQZu4FR2pUpHuv
 Ey0tuNTekDw/ufNfo1j3XunJHz+ZXAFTdHhpNK0JIgo1DDPonFtuQUWQuh5WbmZU32rK
 aKQ9epY9WPymvlAQNyyOW4m2jv5xtutRJSM/j/JMJDU+zsJIrkzdaaXZGX9LB6hdqWI7
 ikHYwVvEGxF7hwh3Ui3DyAKkF5cWH+Yb7vItOzhimW5vZJH+RVi0bwVC1XJ3Cq/YUrPp
 ER20q0SmyIoC6baCrUg75DCEBFQVtAyheg6szDPVK6uI33SrgMMrQSoGqS7Ix9k8YQC1
 mORQ==
X-Gm-Message-State: AOJu0YxcoZreUIZqayxcsaC/WM1wjJ3c9LW153SzA3b2ks2xTXd7Eq9L
 IW2aoIyIFhS9HOhmKoeanywE5cckdWJYN7+IyDA=
X-Google-Smtp-Source: AGHT+IGUYnKhwS6+yDNisan3qti959Kz16aV/ABTn5jhW5Qo+rZtqUh1IUpjvadbkIzwlZ9604hw1w==
X-Received: by 2002:a5e:a914:0:b0:79a:bbd2:8f5a with SMTP id
 c20-20020a5ea914000000b0079abbd28f5amr5627459iod.12.1695583581244; 
 Sun, 24 Sep 2023 12:26:21 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 37/38] command: Include a required header in command.h
Date: Sun, 24 Sep 2023 13:25:22 -0600
Message-ID: <20230924192536.1812799-38-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

This uses ARRAY_SIZE() but does not include the header file which declares
it. Fix this, so that command.h can be included without common.h

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/command.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/command.h b/include/command.h
index ae7bb4a30b05..8aebf7a95bf8 100644
--- a/include/command.h
+++ b/include/command.h
@@ -15,6 +15,9 @@
 
 #include <linux/compiler_attributes.h>
 
+/* For ARRAY_SIZE() */
+#include <linux/kernel.h>
+
 #ifndef NULL
 #define NULL	0
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog

