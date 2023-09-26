Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5DCE7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90B6A86E73;
	Tue, 26 Sep 2023 16:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iBZKg6mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B54786E8D; Tue, 26 Sep 2023 16:16:22 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC6186DC4
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3512b425662so19463715ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737764; x=1696342564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qq2hnOHWvcRvzIiBKnGIasA/FBXg9O00dibXm8Tivgo=;
 b=iBZKg6mwXCVmq/tMIWwULi/uELQBXnd5lmE+DVmgHBKACOPXeHW06adIGKUJGjwQbx
 cv9SWM4mSmUy9wzMRfN+DGXxBLQgXpUAagUb01OR4GyvCt2bLo1qRiHG7XrYGEKTyY7V
 7kjHNDWBDIu5rGw8QD881xGPm8MXc8K/mMwzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737764; x=1696342564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qq2hnOHWvcRvzIiBKnGIasA/FBXg9O00dibXm8Tivgo=;
 b=iRA/3CWrOriLcDHNuOnSjwRgxEu3OZRHQ9ssT0nRYgjviEX9tuDb7U6Wo793zuVlL0
 U2iUBeEkVBjp/MbqMpc4lX+JlFzoMPU8oLtQ8+vqR5AkzSAv5C3Qz11pP3xt8c3fK2gJ
 e83lpLmv84F62qpZ6HE4+HoTEacUH2692T/rpuspOe+o6Wj3KxQhSOzbYuy7LbY8dB+2
 wdYOR1jhXMwczegGbh9wrBRPNir1a6rlKBoP5ho9drXIEA9hTh7FtJRHiioQt5JLxfqF
 2vQIVAM6NDTQw1v7IyJRc2jA33iOAj1r4LH17u3O6hmZLn/Cc9vjLhTgBqXC3BBGap0y
 /gUQ==
X-Gm-Message-State: AOJu0Ywf8jXfZzB7lkaTxJf0K6aTi42R6+/KTgycGx/pHBVSrQ6hQq6Q
 BUwqt2s9Do07AKAw6vHH38bzOL645WwM/iUZi8Y=
X-Google-Smtp-Source: AGHT+IFox+Kw19HIjEG7h+pVfdz3wOW/q/FfSHwZUXcw4G1xSE0cwQnR/ibEfW/ISj446QP/tKXEmw==
X-Received: by 2002:a05:6e02:1d05:b0:351:5137:e89d with SMTP id
 i5-20020a056e021d0500b003515137e89dmr2994648ila.27.1695737764169; 
 Tue, 26 Sep 2023 07:16:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:16:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 41/44] spl: Add C-based runtime detection of SPL
Date: Tue, 26 Sep 2023 08:14:55 -0600
Message-ID: <20230926141514.2101787-42-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

The spl_phase() function indicates whether U-Boot is in SPL and before
or after relocation. But sometimes it is useful to check for SPL with
zero code-size impact. Since spl_phase() checks the global_data flags,
it does add a few bytes.

Add a new spl_in_proper() function to check if U-Boot proper is
running, regardless of the relocation status.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Add new patch with C-based runtime detection of SPL

 include/spl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/spl.h b/include/spl.h
index e958ace2cc62..a3510edecf24 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -132,6 +132,16 @@ static inline enum u_boot_phase spl_phase(void)
 #endif
 }
 
+/* returns true if in U-Boot proper, false if in SPL */
+static inline bool spl_in_proper(void)
+{
+#ifdef CONFIG_SPL_BUILD
+	return false;
+#endif
+
+	return true;
+}
+
 /**
  * spl_prev_phase() - Figure out the previous U-Boot phase
  *
-- 
2.42.0.515.g380fc7ccd1-goog

