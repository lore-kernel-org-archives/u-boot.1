Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE28CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB1DC86BD7;
	Tue, 19 Sep 2023 20:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IhipT+Z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A67786BD5; Tue, 19 Sep 2023 20:09:35 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FFF86AA8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fc7f51441so13473535ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146971; x=1695751771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aK9/BJIE8uEO1eqLJrPO0kbhlae5h0FMLY6PGx4CX00=;
 b=IhipT+Z7UAio423pW0+cxeBUVPeiPk3X0Sxmr7fLN3VDNryEgV3RfFTEt0N5OeesMv
 UDfUBXE/ClERm556oTZtfIkia1DXcBoUn8fJLTHL6raS9wx4+9tWx20xlQEhukLbCUT+
 gjhm/nc+BoBQKTOr0LWLNpCeObnu5fnvssgtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146971; x=1695751771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aK9/BJIE8uEO1eqLJrPO0kbhlae5h0FMLY6PGx4CX00=;
 b=bOYNUBMyU4SX2SsNHWYq+5wl/Pi5jdp74bChoq5yk4TCc1kYS1uWKoxkVI+/wqagyd
 OBmT84T9xFP40lwU7xjxWRuyfJPAUWPhxBRIgfZiLbYJnB193Naw+ZKwybvmWFW7Qz87
 bh7Xdmn+ZZm4Vsv2FIoVHRXGvTDboVjmkf9vLyX4QQ5uYqUFT/nQRySY8jdqDy7TuYey
 yuFXhc4CsigW6EPlMBLwAxeSVfrkbjtAd5jpCKwrwQsoAyKgdSma8fzNCPjyNY1G9upj
 eu7MG/Hs+fcB6hBdDxrPJCAXYPZBgdJbIwr1P8FcZas7c2lPe3xuA5SARP38wCBiWTrd
 j2ew==
X-Gm-Message-State: AOJu0YxUIQ48iUUvj0zQHpgC2FIFw762AhcSwIZsSMH795OJdNXKLV60
 VxFK8OlvWE9NZDQ/owVTLFO8Ga8kFm8EvW6uH5Y=
X-Google-Smtp-Source: AGHT+IHXuz8GA3tXlJ+skUReSpCpW8PQgsdYTdYH7Tx8Ul2Z0mbBj3My/F0SI+l2+6KlsB0M2M7G6Q==
X-Received: by 2002:a05:6e02:1bed:b0:34f:1e9c:45df with SMTP id
 y13-20020a056e021bed00b0034f1e9c45dfmr707970ilv.4.1695146971702; 
 Tue, 19 Sep 2023 11:09:31 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/36] cli: Implement delete-word in cread_line()
Date: Tue, 19 Sep 2023 12:08:35 -0600
Message-ID: <20230919180918.2904313-6-sjg@chromium.org>
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

The Ctrl-W option is implemented in the cread_line_simple() but not in
the full version. This seems odd, so add an implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 458e927e492..687e239bfa7 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -89,6 +89,14 @@ static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
 
 #define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
 
+static void getcmd_putchars(int count, int ch)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		getcmd_putch(ch);
+}
+
 static void hist_init(void)
 {
 	int i;
@@ -337,6 +345,29 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		case CTL_CH('o'):
 			insert = !insert;
 			break;
+		case CTL_CH('w'):
+			if (num) {
+				uint base;
+
+				for (base = num - 1;
+				     base >= 0 && buf[base] == ' ';)
+					base--;
+				for (; base > 0 && buf[base - 1] != ' ';)
+					base--;
+
+				/* now delete chars from base to num */
+				wlen = num - base;
+				eol_num -= wlen;
+				memmove(&buf[base], &buf[num],
+					eol_num - base + 1);
+				num = base;
+				getcmd_putchars(wlen, CTL_BACKSPACE);
+				puts(buf + base);
+				getcmd_putchars(wlen, ' ');
+				getcmd_putchars(wlen + eol_num - num,
+						CTL_BACKSPACE);
+			}
+			break;
 		case CTL_CH('x'):
 		case CTL_CH('u'):
 			BEGINNING_OF_LINE();
-- 
2.42.0.459.ge4e396fd5e-goog

