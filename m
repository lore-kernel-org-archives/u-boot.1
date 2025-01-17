Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56730C02187
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 00:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA4088069D;
	Fri, 17 Jan 2025 01:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kLDR9FKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78E880761; Fri, 17 Jan 2025 01:10:16 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB2C780716
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 545DE3F2B2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737072613;
 bh=xskDKg8h0TiRkE5wVrKbtS7jfnY9nGJisa6nvzm/PkY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kLDR9FKYgO1alwLhl2PY1LjAHUzfyqXP7AHATQ0jrnTPEFS7OTMkXwiK59qOyChvh
 1hK26JvZSUmRk9lxf2epabxZpW/4iDmkx7d6gmf+Me5SsIw2J692XP04IgqH3IjjIX
 H09TBNtRDsaHXvO9yv5MJam1J2Bo0tAyt5a6/Q33sqARczD0yQirzdOeaZNX9V3oMw
 GqLVvGblpmh3aT6irUYIPl2fYWpgMDqCZaIjUTjeNlnwNU8Qmrz085XPLz37hs3rVf
 OblPWdT+D5Gc1XwMK7CQEHuEyctvLfm82dBLRNqIX12tsYdk3tnyget4K66Kg0kup6
 +FRkJJ/dNqG6Q==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa689b88293so129668466b.3
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737072613; x=1737677413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xskDKg8h0TiRkE5wVrKbtS7jfnY9nGJisa6nvzm/PkY=;
 b=IB/zV+hSclu8fevqX+5FvC8HDkF9P1iGIoW1+qYw5Sq7lOXNk+Xqct2n41J7ZW4uP5
 60sOO1BCgXWeYCYXUDWYaGYPoc+qKUCwstZGTA7vMd8zPl+dQ1aJCx3VQYTAdtQUVzy1
 yHKMH3L53jzLPhWBOItku34OyvEejlOowRkrvoOSR9spIVFcYo89NnB6ZGFjIkxUaxne
 T1S5BOn6uFOffsQ1ZIAOHbOzpt6wRr6z/mJAuJXlijaAMExmxkJM037yTB9gLh0Sc7FA
 Lx7lOhZ+ZdKP9mFrVNKlo0ZkqlMaXRrhqh/ilJRDhv/B7wCeCW3LxqmKhDvTpLLjmCm7
 8+pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq1UJ6BePIuVSqpMR9uURSKay0skGboZWzfB1BjnHslP0OGOHoSzWmHqHyOpz94GhZLDYKaaE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1goFlfC/OwEooZeBswDfqAyKFwUHAa2HDckWz2T04Rd1bA4qD
 v96a7QRJwrh4MVqxDlK8Koe4e6Roz2WfdEsZ5QI/Wq3btmyn899bWiZEX3W9jLXd+0MAmsTRU5L
 HfgXW9sVWv4YI6al5OYRY279fDYbKj7Ui69iOiLXDv6hHfENVvZnjYy6KkkbliC6gUQ4=
X-Gm-Gg: ASbGncu0t8sgNB8GQIC5Vkh8i9Zkci6LS1Cq7lnDOGCkJLZjEswkYJOHjXyUvpYX4KO
 /sXcvWmlKTcOvly9IePNXvrPbwE9qBuH0LQWCdRNvhaJtuchz10B5rkBHQRxO/77LLXcmIstrT3
 kSNdO8W/9100iPHZjav1fs9v1n5c6Z/8yyf8p0vtlfLkWtj0R1biS1fTuMQTaHDVtrgq3tF0dwA
 pb77CY27EKkT3ADV5eQNgDNfr+4N2xIHbcmKtItPQuoS0jT81PuGgfvrHMd60sLzE3nOTSSylWZ
 vV2n6vcpcftvTw==
X-Received: by 2002:a17:907:97d6:b0:aa6:8ed8:a82d with SMTP id
 a640c23a62f3a-ab38b163bf5mr61230666b.31.1737072612859; 
 Thu, 16 Jan 2025 16:10:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8lUbxfcGzfaDONPN6o7+2OLde6XB9UdXQhcL1/SZ9IV0es9bZPCYi1jxWYSRoAS9IIOg30w==
X-Received: by 2002:a17:907:97d6:b0:aa6:8ed8:a82d with SMTP id
 a640c23a62f3a-ab38b163bf5mr61229866b.31.1737072612512; 
 Thu, 16 Jan 2025 16:10:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384d27117sm71986466b.75.2025.01.16.16.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 16:10:10 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] log: make log_has_file() static
Date: Fri, 17 Jan 2025 01:09:52 +0100
Message-ID: <20250117000954.531785-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
References: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
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

Function log_has_file() is not used externally. Make it static.

Rename the function to log_has_member() as we can reuse for filtering
other strings.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/log.c  | 20 ++++++++++++++------
 include/log.h | 12 ------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/common/log.c b/common/log.c
index c9fe35230d6..b2b5f3c81ba 100644
--- a/common/log.c
+++ b/common/log.c
@@ -130,17 +130,25 @@ bool log_has_cat(enum log_category_t cat_list[], enum log_category_t cat)
 	return false;
 }
 
-bool log_has_file(const char *file_list, const char *file)
+/**
+ * log_has_member() - check if a string is in a comma separated list
+ *
+ * @list:	Comma separated list of strings
+ * @member:	String to find
+ *
+ * Return: ``true`` if @member is in @list, else ``false``
+ */
+static bool log_has_member(const char *list, const char *member)
 {
-	int file_len = strlen(file);
+	int member_len = strlen(member);
 	const char *s, *p;
 	int substr_len;
 
-	for (s = file_list; *s; s = p + (*p != '\0')) {
+	for (s = list; *s; s = p + (*p != '\0')) {
 		p = strchrnul(s, ',');
 		substr_len = p - s;
-		if (file_len >= substr_len &&
-		    !strncmp(file + file_len - substr_len, s, substr_len))
+		if (member_len >= substr_len &&
+		    !strncmp(member + member_len - substr_len, s, substr_len))
 			return true;
 	}
 
@@ -181,7 +189,7 @@ static bool log_passes_filters(struct log_device *ldev, struct log_rec *rec)
 			continue;
 
 		if (filt->file_list &&
-		    !log_has_file(filt->file_list, rec->file))
+		    !log_has_member(filt->file_list, rec->file))
 			continue;
 
 		if (filt->flags & LOGFF_DENY)
diff --git a/include/log.h b/include/log.h
index 4f6d6a2c2cf..3f9023ae0d2 100644
--- a/include/log.h
+++ b/include/log.h
@@ -571,18 +571,6 @@ struct log_device *log_device_find_by_name(const char *drv_name);
  */
 bool log_has_cat(enum log_category_t cat_list[], enum log_category_t cat);
 
-/**
- * log_has_file() - check if a file is with a list
- *
- * @file_list: List of files to check, separated by comma
- * @file: File to check for. This string is matched against the end of each
- *	file in the list, i.e. ignoring any preceding path. The list is
- *	intended to consist of relative pathnames, e.g. common/main.c,cmd/log.c
- *
- * Return: ``true`` if @file is in @file_list, else ``false``
- */
-bool log_has_file(const char *file_list, const char *file);
-
 /* Log format flags (bit numbers) for gd->log_fmt. See log_fmt_chars */
 enum log_fmt {
 	LOGF_CAT	= 0,
-- 
2.47.1

