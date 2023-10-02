Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806ABE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327DA870B6;
	Mon,  2 Oct 2023 03:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DnmpiwBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5E587118; Mon,  2 Oct 2023 03:14:17 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4306870FF
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3af609c4dfeso3188392b6e.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209241; x=1696814041; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4sVQAjqWIx4D/8PX0RaOyez/CZy9bH0AOe5SCEtqrk=;
 b=DnmpiwBcercYn1aInmwEZ5IIThTCnHbd3jckE7Qn0EhIlDJFTibRRlsm9Jx8+ejXHk
 Jlgt4PU0UOjUwcOrgYQ2iGuV1AAtDlgfy8s0CvM/JfdhK6zU9DCRFRqn3Px/O+2uB2gA
 fPjb7Zi1ZyuuHAInYuhA1LsvISpg43yqH45JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209241; x=1696814041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4sVQAjqWIx4D/8PX0RaOyez/CZy9bH0AOe5SCEtqrk=;
 b=lmkLlXoiuGDEEt4h7JZG3e3VQpnvQkSqlpBsNVN8UFYvoWYty0DHgWd8W52Hi6fDs9
 43jDLmlLIFdIHTaEVpvB7R/hezoKdUv4dccu2ZRczLILY5WwQCIPePFRyIXqxsUHNbAM
 Ca+uqWiYjdTh6HzNzGZeDNh9Sa54HjuWgsSTLtcHkFRUhqKR3sINkri+zLhZjP6C4Op9
 bI4zK11hWimkJpw0jPugC6/k1XSt795nRSZpU+sofzdPXssfKoa08ztc8/OtgrWOQqaf
 9/joZBGcQiLhX1q8z/m+zQ75XV/Rr6gCju4DWixdXfZvLFDKySENgrHzb8jyHeYpdshK
 KbYg==
X-Gm-Message-State: AOJu0YxpWtbPU5D5LR+wSUYQb3M0gEF/TID528js0tryrOVGYIKyljZ3
 J4Z90sckhjCQ+dlu2vaHOKO6vqpP+pyrbj9YGYI=
X-Google-Smtp-Source: AGHT+IHWI2CpplIy+R2Stqly+Jg5jgNakRTdHffjFtCMkmlbeLH1Mf0n3RzI3OrHOOWY9x3/8JRpng==
X-Received: by 2002:a05:6808:3bb:b0:3ad:29a4:f560 with SMTP id
 n27-20020a05680803bb00b003ad29a4f560mr10633051oie.34.1696209241523; 
 Sun, 01 Oct 2023 18:14:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/36] cli: Terminate the string in cread_line_process_ch()
Date: Sun,  1 Oct 2023 19:13:14 -0600
Message-ID: <20231002011349.461284-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Rather than relying on the caller, terminate the string inside this
function. Do this each time we return, whether input is finished or
not. It is not needed when the input is aborted, since the string will
be discarded in that case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 62d419bb36a7..fdb84d9204f6 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -263,6 +263,7 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 
 	if (ichar == '\n') {
 		putc('\n');
+		buf[cls->eol_num] = '\0';	/* terminate the string */
 		return 0;
 	}
 
@@ -413,6 +414,12 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 		break;
 	}
 
+	/*
+	 * keep the string terminated...if we added a char at the end then we
+	 * want a \0 after it
+	 */
+	buf[cls->eol_num] = '\0';
+
 	return -EAGAIN;
 }
 
@@ -467,7 +474,6 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 			break;
 	}
 	*len = cls->eol_num;
-	buf[cls->eol_num] = '\0';	/* lose the newline */
 
 	if (buf[0] && buf[0] != CREAD_HIST_CHAR)
 		cread_add_to_hist(buf);
-- 
2.42.0.582.g8ccd20d70d-goog

