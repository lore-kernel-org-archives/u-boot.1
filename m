Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6405AD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF45089215;
	Tue,  5 Nov 2024 17:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OinJkiTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9843B89025; Tue,  5 Nov 2024 17:07:53 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F71D891D1
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a6c2077afcso9303995ab.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730822870; x=1731427670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhp3gOtZbJskzNQ2TrUxO5tNQB3/XjjvaME5lVdwWG4=;
 b=OinJkiTdy+yQCZIbNNOX6M5drfqfc4k6mgGcBHQJjKxRV1ctHbBUpu5XFpuCX8HNo4
 TNCNfFFuRjGyfaCIcQORl41Y3BSwfQQAmReOiiWkttkFzqq2WHWEtaBR7ziMTxAt5VJZ
 OInP2HMsBQc5lIOouunQoKitJ9LKLvdcr2h4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822870; x=1731427670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vhp3gOtZbJskzNQ2TrUxO5tNQB3/XjjvaME5lVdwWG4=;
 b=N/mBEV8ZcXRx+7OhHTjf9Px3Hw/QFrM+yn8ZTS0QYtSIm2ZL7iKTDPzzSrCOAcinKM
 atJ8MfAInqvCxyAj9l/EQpzY5B7GITa0PdojmTMywI+Pe5jVtagPMQNw8VWbUjeReUmP
 46ztdbvjH+ZlwKEJpH/HCrvszA+sCJpVzJ3oQQr9oKJZSppxmCoWxy+KC+e6eeblTHi0
 jhNWrFez/9p9dIOawvzA6jaZKwnRVVFI3XCb9F5lg/MxL9wjOtUlZisW1Y2iPMdbS7ho
 3CVJJ+chLq3kNPv4z9OcnQ0Us5i++Uu/z0SXlOZgnCGNK1Grf8SoTrHsrD2Xov0tJUn1
 FxLQ==
X-Gm-Message-State: AOJu0YziZVjcXRMODS7UkaRRD+LwA5CCvY9KZvg/G3Jx+Mwj5YQC1fh5
 dH6wnOG98T/TcuZDLRxZk9yNxBOaNSoNVAJGbDSppcHXvVCmDsxqfTB1wyF4suYFnv2e7cd13XU
 =
X-Google-Smtp-Source: AGHT+IFxwaVMGaoUepPFXNm4vd6NHLbQS21PWSjSc5nzkMsuAjozvSoqQkNARNQC4qIB4//zg5E5+w==
X-Received: by 2002:a05:6e02:1fcc:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a4ed3057c0mr354443665ab.22.1730822869533; 
 Tue, 05 Nov 2024 08:07:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a99ccbf5sm29640285ab.44.2024.11.05.08.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 08:07:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 2/9] test: Adjust print_ut test to use unsigned char
Date: Tue,  5 Nov 2024 09:07:31 -0700
Message-Id: <20241105160738.3795497-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105160738.3795497-1-sjg@chromium.org>
References: <20241105160738.3795497-1-sjg@chromium.org>
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

Since char is unsigned on arm64, this test currently fails. It seems
better to use unsigned anyway, since 0xff is written into the string at
the start. Update the terminator-assert to use a character instead of a
byte.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

Changes in v2:
- Use '\0' instead of 0

 test/print_ut.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/print_ut.c b/test/print_ut.c
index f5e607b21a3..7ab79e4617f 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -242,7 +242,7 @@ PRINT_TEST(print_display_buffer, UTF_CONSOLE);
 
 static int print_hexdump_line(struct unit_test_state *uts)
 {
-	char *linebuf;
+	u8 *linebuf;
 	u8 *buf;
 	int i;
 
@@ -255,10 +255,10 @@ static int print_hexdump_line(struct unit_test_state *uts)
 	linebuf = map_sysmem(0x400, BUF_SIZE);
 	memset(linebuf, '\xff', BUF_SIZE);
 	ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75));
-	ut_asserteq(-1, linebuf[0]);
+	ut_asserteq(0xff, linebuf[0]);
 	ut_asserteq(0x10, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 76));
-	ut_asserteq(0, linebuf[75]);
-	ut_asserteq(-1, linebuf[76]);
+	ut_asserteq('\0', linebuf[75]);
+	ut_asserteq(0xff, linebuf[76]);
 
 	unmap_sysmem(buf);
 
-- 
2.34.1

