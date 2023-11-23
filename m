Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A397C61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 11:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396568760D;
	Thu, 23 Nov 2023 12:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lcbAGG8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FE687633; Thu, 23 Nov 2023 12:02:52 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6039B87627
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 12:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507b9408c61so973519e87.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 03:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700737368; x=1701342168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lv91sSXKs35P3x8woNZs+HbBMI4zxYxCmyNbLb4bINQ=;
 b=lcbAGG8StDNalKSVJcdyfD2j68sMBFlxDqWgSymqeApHYXFCOXQB+f1jAX9nWTVQKs
 MTjDhGA0+rZsu+Hz7ky4jdW2gi4m1kBuXRQC2fVnJoVfZCj1HCTWpWw/T83MiYX3B0qF
 RqsbAJYu1R6dsqr1O8h0g0HO/kEM/Laj7i6i4rJmvyOAvlHLXYd+65se0ydQIbCgijXr
 wht1UQnnbakFm/8YqfUXLTc8Nfx5ojWU+mGkBsy/OdwfG+3CN1aZQFRIlYClRDe+TeIT
 bStxtKr5eXHYZSl5GvTIkLeEMkobTEDwfva0ra///ZwNIPqDjnGwXn13P6YI9dU4C3CF
 j6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700737368; x=1701342168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lv91sSXKs35P3x8woNZs+HbBMI4zxYxCmyNbLb4bINQ=;
 b=gqT5zJ7ZvQAs/TdQz/31ilRNIRHj9B/JWSy/Ei4gwt1/TmutMJDxMxKlmEzoNH7JSB
 HrovB4z9YnbJyubRt11fqI3FJm4VhCTBVh1J8CeI1gUKWZ8jF6RzwedJjQvltNd2wSbk
 Wi+W6TyWfj4ggiJGhdC/FhNP1cBV35hYKfZ/4NOnc0bEQaGAgdjBufy5mv7julc2XoeT
 3j+2CpW0WCTm3enL6Htel21OlSka34IPhj4zukg7NAe9h7Cwh5hoPLMD5ASIlmEDC2X/
 uwTD5Vw0YwZMEWDl1eBZsenHd1OwimeOsSEvs+SMv1MXPgvKrmdqqxeJDwxvGryMkpvA
 40WA==
X-Gm-Message-State: AOJu0YwyxwX/opfr65bRLI8Ey1u2Ql2Jj14JKZ9NtQUNMhby7gg9L3K8
 HBFuEpVGDrOzsJWePL2AmhQ=
X-Google-Smtp-Source: AGHT+IGXHQU13fEerqbf4PEgdqa4OzZWmtNDExtHe2tDewvU+nwrSG/c9DCp5Kf4MUGu0ejxjnosUA==
X-Received: by 2002:ac2:4c1b:0:b0:509:45ed:1083 with SMTP id
 t27-20020ac24c1b000000b0050945ed1083mr3117376lfq.40.1700737368572; 
 Thu, 23 Nov 2023 03:02:48 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac254a7000000b0050ab61a09f3sm156857lfk.104.2023.11.23.03.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 03:02:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 4/5] lib: membuff: fix readline not returning line in case
 of overflow
Date: Thu, 23 Nov 2023 13:02:21 +0200
Message-Id: <20231123110222.15116-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231123110222.15116-1-clamor95@gmail.com>
References: <20231123110222.15116-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

If a line overflows readline's maxlen it won't advance the membuffer
and will return 0 as read amount which isn't even documented.
Fix by removing this behavior alltogether.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 lib/membuff.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/membuff.c b/lib/membuff.c
index 36dc43a523..f582193dcd 100644
--- a/lib/membuff.c
+++ b/lib/membuff.c
@@ -292,15 +292,12 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
 {
 	int len;  /* number of bytes read (!= string length) */
 	char *s, *end;
-	bool ok = false;
-	char *orig = str;
 
 	end = mb->head >= mb->tail ? mb->head : mb->end;
 	for (len = 0, s = mb->tail; s < end && len < maxlen - 1; str++) {
 		*str = *s++;
 		len++;
 		if (*str == '\n' || *str < minch) {
-			ok = true;
 			break;
 		}
 		if (s == end && mb->tail > mb->head) {
@@ -309,13 +306,6 @@ int membuff_readline(struct membuff *mb, char *str, int maxlen, int minch)
 		}
 	}
 
-	/* couldn't get the whole string */
-	if (!ok) {
-		if (maxlen)
-			*orig = '\0';
-		return 0;
-	}
-
 	/* terminate the string, update the membuff and return success */
 	*str = '\0';
 	mb->tail = s == mb->end ? mb->start : s;
-- 
2.40.1

