Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1662CDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369E589014;
	Fri, 27 Sep 2024 00:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aNrnTNu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A56A89014; Fri, 27 Sep 2024 00:46:50 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F0789028
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4581f44b9b4so9535651cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390806; x=1727995606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqv8jDvf3hyGABjLNMYEmSg58jRPtJ2g4OErKsJLRsQ=;
 b=aNrnTNu2/ph4ilTxtxWz1ZikVcQlHjMISujpqMVGafapiI9RlRWBLOKmUmeXg7MJ5H
 EJ+LmTZfv+dHjqU1FPHw4Ym7b6ggZJbyHVZd2wJh5tbRSGKaqgtB15hqRxChaHnUQdyT
 n1NWueruKg3qYjahkL+qmQHiFvI0PlTR8P8IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390806; x=1727995606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqv8jDvf3hyGABjLNMYEmSg58jRPtJ2g4OErKsJLRsQ=;
 b=JtAGSWc0xdsztloMiUZ06nVU1YQvvaCCjCBgHLehg1RYo018OBhw3p5WS3MouzkxrM
 wj/+Wp8H3WluqBkhUJPs7mhLWHs1JPXJICWmcah6LqlxdYcZlQF0R0q+MBHV1ZVlX0hq
 t7U2NgtTL/sLosGJtTg4/ZGtDVVWB7yJtnTEaOoOZ4Ap/79nfyzisOc//89lVOSGRtn8
 4TYf0bpjUPdWW/iLKwwBIXjhm+tEHpauNPCYOUJAffCDO2e3erYsPzoZf1aRs8w+hV6L
 t7uChs2JjVweQCPP/mBhq/H79vj0YPCgA/rg3rahR6DTwmztNUZXImjlDIqDvvXrQhl7
 PlGA==
X-Gm-Message-State: AOJu0Yyw4dm1MX3zW2YY1hE9dzvtCiTFjKUkt19zyKnPLkI6vXcOhR3/
 zbxXdlpzT9y9bYJCLTozHRVP1NVrtHJMG2lPYepTPcitMjveYx/dKCAnyBftLCedUWmYEq3lkyv
 iPBoOly8=
X-Google-Smtp-Source: AGHT+IF5g1u4hG2QArbybBrQpuwnqZ90yJuq1ALhgzQgN0ngxd3k2PA2NFfiuBp7TZVPveeEHRiKbw==
X-Received: by 2002:a05:622a:15cf:b0:458:1def:72ba with SMTP id
 d75a77b69052e-45c9f2829bbmr18174141cf.46.1727390806235; 
 Thu, 26 Sep 2024 15:46:46 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:46:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>
Subject: [PATCH 37/42] xpl: Add a function to indicate when in xPL
Date: Fri, 27 Sep 2024 00:36:02 +0200
Message-ID: <20240926223814.1276764-38-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

 include/spl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/spl.h b/include/spl.h
index bea4d78f8c6..3281b02d63b 100644
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
2.43.0

