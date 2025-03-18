Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831D3C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2EBB81D27;
	Tue, 18 Mar 2025 16:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AC9tjHcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D4B81951; Tue, 18 Mar 2025 16:21:25 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8232C81C64
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso17134275e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311281; x=1742916081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EESBZnOLPFW+FJgYkWDurgNAw3gvJ4uYGp20jM4cQLA=;
 b=AC9tjHclRxjYudBZtDNjm0NByuTzf3xVAJk+34Vp8zYSspI5ExESbOtx6gD6kd+Co8
 G3mH98H7Fv8x4jV054XnDSYOSh9pHtHXrQ4swZeawS4RI8i9n+mMp5zprwf+m3O61DQk
 2JHk1e2/m+YFBGucyGyKNhlnSWWtRNfu8DJnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311281; x=1742916081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EESBZnOLPFW+FJgYkWDurgNAw3gvJ4uYGp20jM4cQLA=;
 b=uycVGcIdeY72UpwWeeAJQyCH4//KET0hU5TISxlCfETrra5Oz4VhADIzCBoh14Jph8
 L73RbgRYHbRLiaIgNErjGWR1Gl5IHRvP8IzZ7QMtD58KmGLIZ2Op25cSKZ2TqYBEcNTL
 IxxB23KJenH3U9i4h5OKX2TyQ7qElDHkalPpsFYjhmtRRKomfDtW1wo/JNE0MJiAbGeY
 M17kxW/AjtjwdQNCljVMEKj6AWyGdx6kuxLDnFCJyI/Z9gAwH3Xz9Hst9IS2swrexDAE
 iiKuPToTOvSpWYzEVrAhz+IFIrDHRngViLKuIPWGF7RI+o6lwepvYfCFuxYJ7pYVgFZE
 Ns/g==
X-Gm-Message-State: AOJu0YyEsdupnYM2T53Tt7EXUT9YcWBZvRCCMjgpGJkG7KnsMM1jmYaq
 CXAg58fI3YJkjlwpVtAETbo+auGRSqT8RvSLo1beyfQ++vHXmfgofI0wesl+mLMy3WzDhDrDZ4h
 m3POU
X-Gm-Gg: ASbGncuhlIKIqSGFCjuCren30TcEsA8LjTXkJ0iplgFENQI8xmzrzMDjZ7f5gjy4eDu
 zlgM0489WSqIK9FfWev1veyzSSm8YDBnLC6cJmq6gik+i/m60CswkEvXDLgeRVESbEWGv0n9o4V
 behSRkmAjD8czxpyTWN5EKm5fjxd49dGBWBt9VXFKPHo0YidBB1R1ufbmNp/3ZrijKr++mCHryN
 rHC5gg9t2KSw4RILxXcAm9U9ziDjDkcuWV5H8/HbUldUVsODJjfDD1aMIh0HoIalgBfugGM8ah6
 /DPdrEkFlO8F9/+YwGZVoSRUR95H1l8aRSe6Dr1Mxw==
X-Google-Smtp-Source: AGHT+IEKAVbvtCHhERGssf9PhklB+C3HTcyDvDDNbAm4/+xQdZbfVe0SKwNF3wzR5WuP/gYfurL/BA==
X-Received: by 2002:a05:600c:1d2a:b0:43d:1c3:cb2e with SMTP id
 5b1f17b1804b1-43d3b9a4268mr32463415e9.17.1742311281291; 
 Tue, 18 Mar 2025 08:21:21 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 7/7] membuf: Minor code-style improvements
Date: Tue, 18 Mar 2025 16:20:48 +0100
Message-ID: <20250318152059.1464369-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318152059.1464369-1-sjg@chromium.org>
References: <20250318152059.1464369-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0

