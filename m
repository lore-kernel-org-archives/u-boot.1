Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7473CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75E586BF4;
	Tue, 19 Sep 2023 20:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gt2u+n4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EDA886BDF; Tue, 19 Sep 2023 20:09:39 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D18F86BC2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fc881e09bso12815345ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146976; x=1695751776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2O373WIz4eUYPv1os+1A5Czw0DnT/bMpGoCcmbsqARQ=;
 b=Gt2u+n4Htz7fJkM6mncREvmscOoRqyTMAi3o1qmprh9vx/4JnNtZ+dwP7tMLd62kWk
 /owQj3TrCjfo/vescfK8oCxLOe+jIOIAcwNJSuXTDYdCjx61aYRvQEOqinzyf1OylBWw
 b8rhUZZtD3EwepMnzJ2uba4D0Wup/5ekfbw3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146976; x=1695751776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2O373WIz4eUYPv1os+1A5Czw0DnT/bMpGoCcmbsqARQ=;
 b=ftgLRBRw/ZWTA3SRr/4poQzpagU8BrudHZend0c6zbB0tm/CCb1YhHax636jOApYIT
 iKW/DoYC4UJggc1K1Pd1fsziwJktJAIfoALoVVUMwkoLQ7UWqxVyp/uck8GUFnNVDywN
 xD8+2OjmFyIOVrq8S71mIVb8pzwnPxIAH6LRTPbAbtRdNwuj/0xwl3UzkADenIMTawZg
 8SeSAidaYIoAiayZv5obM/OkkSVKOym+hQmMzbEzdDuy+xD1CvjwBXEbk+tkrPGFVwvU
 +i0c9FIq+R4inkXL7RKRX0hxMAldA/fCG83eGA9tYUKW/aPGaLu07z6OchvnP9d06k0a
 //3Q==
X-Gm-Message-State: AOJu0YyqlecXRJC0Sxh4I1OH8wayEoF3LpU1JqR02/gOG5cXH3xW9Fjy
 W2yKYiMWPv1+f0JkGQoalEID0isxMtpPSnbUnv8=
X-Google-Smtp-Source: AGHT+IG8BKXL+gLDao29tjLrq1NB+9bxqjaNuzNXVkN0gpEXVvQ/QRX/q6Lqlvc7jrKXIkvtpcejsA==
X-Received: by 2002:a92:c7d3:0:b0:350:f0bb:6a33 with SMTP id
 g19-20020a92c7d3000000b00350f0bb6a33mr448817ilk.13.1695146975880; 
 Tue, 19 Sep 2023 11:09:35 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 10/36] cli: Terminate the string in cread_line_process_ch()
Date: Tue, 19 Sep 2023 12:08:40 -0600
Message-ID: <20230919180918.2904313-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 common/cli_readline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 62d419bb36a..fdb84d9204f 100644
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
2.42.0.459.ge4e396fd5e-goog

