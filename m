Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7BDCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB26688D9C;
	Mon, 30 Sep 2024 03:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WpBeaKNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8DA88E4B; Mon, 30 Sep 2024 03:50:28 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575B988E06
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8323b555ae2so185757039f.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661025; x=1728265825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqDRYmuRpWD20Gg8h4f3kAYjbVrOkxVPhD/vGc3EmCc=;
 b=WpBeaKNhXa1L3sCR1ODK6CvJgX8pABmT0jq8p5mKs/uCbkRAewp09aKmb8t4b1Djft
 je1eLmOLcnAcbtxmPRB5ZtpVOOE+HUq/jQU3iU6LeVkhAdiCpFU+LZBG+VJ5xtdm0TDL
 PU11FnUruZiw2EPv8ETpMAyWcieERHSQ8RNMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661025; x=1728265825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqDRYmuRpWD20Gg8h4f3kAYjbVrOkxVPhD/vGc3EmCc=;
 b=fpGqoYRJ3+vWAvaS+1lxzjHsILPbWLP7QMRWqwNLXnHbJbLo5EuKojSEhk++KuBdp6
 lVPasNTh4Yju8W3RigCDpCTnuCF8Gorv1y9IQhr6ejpcWeBwOzFYEATAK+aOHoz+KRdi
 MAjdQEjxulFugWd8wkgKHX/KQEJQ3CnffLiIdSFquIToB+DtnmPMSND6sQL8K6Kkfczy
 eSujTvTmLfaCGd4Dn8IRYMYpdeWJFaUXz/CJFvNoxY85pxNueaF7/74pY2GVkXL6kdlR
 QLwqtL3/8zHiSYHiYkcIBpJXjKNGTiUjeecXih56+YuGyMghrTZf+umeq3lWcaMD2/Gs
 8VYg==
X-Gm-Message-State: AOJu0Yz7u3hzpCfwj7Rb9v7drJCbs0dJwsknBGrN/nFUid0s1TgeI899
 Y+ay4ajlg4n2lTixgOD9VMKHaxd0LXbODxmBd6AmCgwGDTSwUG4OmnMZet8JArM+o9qpbDT8NOb
 ILQ==
X-Google-Smtp-Source: AGHT+IFh+BrXwBZG6oJ3RkmXc19C0a95Z76Hx8hBPAa88/rYMY2r3KLpNfHUhdlbswbjR7szH4oeJg==
X-Received: by 2002:a05:6e02:13a7:b0:3a0:92a4:a462 with SMTP id
 e9e14a558f8ab-3a345161df1mr92173015ab.10.1727661024860; 
 Sun, 29 Sep 2024 18:50:24 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH v3 15/33] xpl: Add a function to indicate when in xPL
Date: Sun, 29 Sep 2024 19:49:38 -0600
Message-Id: <20240930014956.1434060-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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
index 948486164d9..fe2df78b0a6 100644
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

