Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A35DD3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA0A891A6;
	Fri, 18 Oct 2024 05:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SqjqKuCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A41CB891D6; Fri, 18 Oct 2024 05:00:59 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA02891CC
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-83aba655593so13411339f.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220455; x=1729825255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qup0lOFft8CuF/AelIfXrOHa4byYIjwYetXO4cIbb1I=;
 b=SqjqKuCqzve9PcCvP3Qa6zy1rr4WE5enabaJiuX4JYXQV3hi++oPV/IValY1pcFu8Y
 GiSTeyKiv+TVJQqdVx+Hc1fG2+QZtD1cKj9o622ixstJJN13e0/yPlxWfD2umSbZHLV4
 sNwra0mLVSmKL98c3WRDt/OdYsSM6yvePTgCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220455; x=1729825255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qup0lOFft8CuF/AelIfXrOHa4byYIjwYetXO4cIbb1I=;
 b=ug6YRBkDwgd+hfmvP2dVm90F/TYfnpMalhQG0PLFj1RCdvMOFlnY9pk5o4vPR5AhAY
 ADgHsCTHKKiz712QY1VHG4zQlJvCPe72mrN+vhawPRB14qMOOEMzEHfHrFKTNUPXRAYD
 m+9CK3R/yrVNP8EaFm1ZVNyAu5THy3bHvsHIpGFtT6TOYdX+tgB7vx/c4mhsc+3iyf0q
 fB6gMtXCVxDoBZKvCtykx8MgkldRv5GXmNkveTi9FVuBghcUMahz2q3dB9K1HU/Yx35H
 i/7pkNVRbKP4PgvdyAsPQkTBOBXdqB9h601zwMBgN9VqG2qIyo18800XTMDDf91znaIc
 Csig==
X-Gm-Message-State: AOJu0YxdT5E2CKI5DjgWnuvwCDOeqEySVA/oGIMYwXHIHQM2eji+NlTA
 jvhGI9HV7vmQzXk+l/VY2mj8OIneM8QB011ul4qxpbxPWrLTgk8M5cHq5eATQolUt5QULTssqbU
 =
X-Google-Smtp-Source: AGHT+IGUniu6fXSZMq/tzzVyWYN0VKCSqXh5t/hfuRd0hPyUeSgIfkTw7gffkPsxnepsuKIM6gQc+Q==
X-Received: by 2002:a05:6602:6d0f:b0:83a:b7c8:a3dc with SMTP id
 ca18e2360f4ac-83aba5b5008mr103858539f.1.1729220455208; 
 Thu, 17 Oct 2024 20:00:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83e6dsm192499173.39.2024.10.17.20.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:00:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] membuf: Minor code-style improvements
Date: Thu, 17 Oct 2024 21:00:26 -0600
Message-Id: <20241018030027.842749-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018030027.842749-1-sjg@chromium.org>
References: <20241018030027.842749-1-sjg@chromium.org>
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

Show the start in end in the comment. Comment a missing variable in
membuf_readline() and fix its line length.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h | 6 ++++--
 lib/membuf.c     | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/membuf.h b/include/membuf.h
index 636ed703ee7..46764690f53 100644
--- a/include/membuf.h
+++ b/include/membuf.h
@@ -25,7 +25,7 @@
  *
  * .............xxxxxxxxxxxxxxxx.........................
  *		^		^
- *		tail		head
+ * ^start	tail		head                     ^end
  *
  * xxxxxxxxxxxxx................xxxxxxxxxxxxxxxxxxxxxxxxx
  *		^		^
@@ -194,11 +194,13 @@ int membuf_free(struct membuf *mb);
  * @mb: membuff to adjust
  * @str: Place to put the line
  * @maxlen: Maximum line length (excluding terminator)
+ * @minch: Minimum ASCII character to permit as part of the line (e.g. ' ')
  * @must_fit: If true then str is empty if line doesn't fit
  * Return: number of bytes read (including terminator) if a line has been
  *	   read, 0 if nothing was there or line didn't fit when must_fit is set
  */
-int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch, bool must_fit);
+int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
+		    bool must_fit);
 
 /**
  * membuf_extend_by() - expand a membuff
diff --git a/lib/membuf.c b/lib/membuf.c
index 695d16d051e..f38ff36cb0b 100644
--- a/lib/membuf.c
+++ b/lib/membuf.c
@@ -287,7 +287,8 @@ int membuf_free(struct membuf *mb)
 			(mb->end - mb->start) - 1 - membuf_avail(mb);
 }
 
-int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch, bool must_fit)
+int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
+		    bool must_fit)
 {
 	int len;  /* number of bytes read (!= string length) */
 	char *s, *end;
-- 
2.34.1

