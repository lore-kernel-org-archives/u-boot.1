Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC73DCCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 14:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34328362A;
	Thu, 23 Oct 2025 16:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fpjhUcCY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E72D83677; Thu, 23 Oct 2025 16:26:53 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E66383621
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 16:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4711810948aso6898795e9.2
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229610; x=1761834410; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nji57YXywsAKDsbWp5j9+YWJsKatRExxMLRiouiud48=;
 b=fpjhUcCYvgEql5cX0DHj4OhvyOWHDOBOLo1ENWhtVFK/QYRC+pKBNhbWTn59xy6HRT
 CA8QtfDSVYpdbz5tcZU5zZ5wnvnzp2edYPs/624Lq/a6FAfyrWbkZIf/hBHqb8vs8eFR
 yUnfkXCoTHS/KbnFttz7vB0UDHbpAeP27x7I0fcBjsEDRNWYG3b09DGE35T96cWleDyx
 /3+UpuJM0p2PTNqCQIHszoxzid9lHooraSgKGJuGWGqsQWsUESdJt+lkj25HUszHYxcp
 8K0DinegVo18Vorpbmk+n8m9XgzocDtPs7K3Sc6sg3ns+P1SZM1PdEw8CQPgY/0POWn4
 EWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229610; x=1761834410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nji57YXywsAKDsbWp5j9+YWJsKatRExxMLRiouiud48=;
 b=rwFjJl+4/Lt/clEUaDPv5gjKm4MfJRVn8wd0DPnHPjb65DEtbctOZ6AzgZTTDi5/SA
 K83y84N+rCB/Gjy5nXg8Xxv4ljISeyi3EKaEABjuivcPLPnEZcIPUq2Vl1Xg4HORagrm
 fcqXdSR0mJmv8Ti8hN/U86FPmR3rkBo5mZpRYrwCT6BZTgZk3szmHxIfO1RSKavZ1s+j
 C1sAK8VI41Tiurl8YZwlYc9yFS22ndgcAk5f8hACjSw7maOmg8R/9VekDWobaOAkIsAj
 mD8dPeanCI1p8YdndcAAdQ8fkItPH542wGQJw14wwlMcKnbolCCVBGz2x4YQ/QnoZVq9
 bEvA==
X-Gm-Message-State: AOJu0Yyu0IEcRPQDlK5SNgBrWo7UzM963W+L1K26bxkzVdeqAHaOcJoj
 G2In7sqVkqsK9dMndZg4mhPHqoYVRt4AKWJPofffap9UwxtQg2nVOnoGMALzFeW/lYM=
X-Gm-Gg: ASbGncu017ggoVEBsie7fGseRam42ae7JuzMknbfdujevag6qygtngQg7SrHWbSatxu
 NGi5on8EtuKFhWvwB6YVAfOZ4bUavtxMaVfhdm7WidGdFpC5fjZyCTk/sIERqRssrGPaN0HhE60
 qxVyYGiOTQYlHowq6ATjPNrHWs0WJjaypPZfyw2rImqWKMLjtnVv5zn8C4iDbHKUxJcqQSob572
 gLKOIji/ZfbfnSLu27S1u1T/uJRr9IjBKE3+K4fP9Y/cv4aLgxGy8heL7UktzKvrvyJ4Hc1hmEm
 Qkl+x1eWrZZAl6tiQTaS50556tlkb4XIEdCAvsvNJGI5s+XGLIq5qBLID9tH9+nry0aqccVPhc4
 xRLvUF+Cx1U/7Fk6kZyervOxGJ6vVuzgLSWG1h7RHDxXcwi1ZdRZS03IKINRBb0fJGkRzwl9UcY
 ocktZ8uNadQcXFBdSjF155xKKsxQ9Py7RrTzaG3Nw4VIjM
X-Google-Smtp-Source: AGHT+IFCS/F3arEqzMByt31edomOJZ5/MUOy6NXyb/bxjWFElZrms+mReX0oocED8dCoCAhN/y/bgg==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-4711791cadfmr215812855e9.32.1761229610576; 
 Thu, 23 Oct 2025 07:26:50 -0700 (PDT)
Received: from lion.localdomain (p4fc3da2c.dip0.t-ipconnect.de.
 [79.195.218.44]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f292sm38585445e9.5.2025.10.23.07.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:26:49 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 23 Oct 2025 16:26:46 +0200
Subject: [PATCH 1/2] efi_loader: efi_console: support editable input fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-eficonfig-ux-improvements-v1-1-f5fc93b126ed@linaro.org>
References: <20251023-eficonfig-ux-improvements-v1-0-f5fc93b126ed@linaro.org>
In-Reply-To: <20251023-eficonfig-ux-improvements-v1-0-f5fc93b126ed@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15-dev-52d38
X-Developer-Signature: v=1; a=openpgp-sha256; l=3951;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=9vYDkaU7MpfkEd/U66UZh55gXMAkGf0yYHfa7+o/4sE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoxf1uo6NdvUNL6fr71Szyj2lmdhyCu+vhdSsq+DbNdJa
 ycZ5D/sKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABM5as/wP+ZRScv16Lv6ZzSC
 WuoFjqy0PLCS51rirZ9HUqbuy3UumsDwP6Hvpy9Hx997DxT2JGRy3n77SqJCVOzGnpLlbOe8I3P
 kqgA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

When editing eficonfig "optional data" (typically cmdline arguments)
it's useful to be able to edit the string rather than having to re-type
the entire thing. Implement support for editing buffers to make this a
whole lot nicer. Specifically, add support for moving the cursor with
the arrow keys and End key as well as deleting backwards with the delete
key.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 cmd/eficonfig.c              |  2 ++
 lib/efi_loader/efi_console.c | 52 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 8ac0fb98e02e..d8d946c87ac8 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -973,8 +973,10 @@ static efi_status_t handle_user_input(u16 *buf, int buf_size,
 	tmp = calloc(1, buf_size * sizeof(u16));
 	if (!tmp)
 		return EFI_OUT_OF_RESOURCES;
 
+	/* Populate tmp so user can edit existing string */
+	u16_strcpy(tmp, buf);
 	ret = efi_console_get_u16_string(cin, tmp, buf_size, NULL, 4, cursor_col);
 	if (ret == EFI_SUCCESS)
 		u16_strcpy(buf, tmp);
 
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 953f6831466e..7bfd18233feb 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -1383,36 +1383,61 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
 					efi_console_filter_func filter_func,
 					int row, int col)
 {
 	efi_status_t ret;
-	efi_uintn_t len = 0;
+	efi_uintn_t len;
+	efi_uintn_t cursor;
+	efi_uintn_t i;
 	struct efi_input_key key;
 
 	printf(ANSI_CURSOR_POSITION
 	       ANSI_CLEAR_LINE_TO_END
 	       ANSI_CURSOR_SHOW, row, col);
 
 	efi_cin_empty_buffer();
 
+	len = u16_strlen(buf);
+	cursor = len;
 	for (;;) {
+		printf(ANSI_CURSOR_POSITION "%ls"
+		       ANSI_CLEAR_LINE_TO_END ANSI_CURSOR_POSITION,
+		       row, col, buf, row, col + (int)cursor);
 		do {
 			ret = EFI_CALL(cin->read_key_stroke(cin, &key));
 			mdelay(10);
 		} while (ret == EFI_NOT_READY);
 
 		if (key.unicode_char == u'\b') {
-			if (len > 0)
-				buf[--len] = u'\0';
-
-			printf(ANSI_CURSOR_POSITION
-			       "%ls"
-			       ANSI_CLEAR_LINE_TO_END, row, col, buf);
+			if (cursor > 0) {
+				if (cursor == len) {
+					buf[--cursor] = u'\0';
+				} else {
+					for (i = cursor - 1; i < len; i++)
+						buf[i] = buf[i + 1];
+					cursor--;
+				}
+				len--;
+			}
+			continue;
+		} else if (key.scan_code == 8) { /* delete */
+			for (i = cursor; i <= len; i++)
+				buf[i] = buf[i + 1];
+			len--;
 			continue;
 		} else if (key.unicode_char == u'\r') {
 			buf[len] = u'\0';
 			return EFI_SUCCESS;
 		} else if (key.unicode_char == 0x3 || key.scan_code == 23) {
 			return EFI_ABORTED;
+		} else if (key.scan_code == 3) { /* Right arrow */
+			cursor += (cursor < len) ? 1 : 0;
+			continue;
+		} else if (key.scan_code == 4) { /* Left arrow */
+			cursor -= (cursor > 0) ? 1 : 0;
+			continue;
+		} else if (key.scan_code == 6) { /* End */
+			cursor = len;
+			continue;
 		} else if (key.unicode_char < 0x20) {
 			/* ignore control codes other than Ctrl+C, '\r' and '\b' */
 			continue;
 		} else if (key.scan_code != 0) {
@@ -1427,9 +1452,18 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
 
 		if (len >= (count - 1))
 			continue;
 
-		buf[len] = key.unicode_char;
+		/*
+		 * Insert the character into the middle of the buffer, shift the
+		 * characters after the cursor along. The check above ensures we
+		 * will never overflow the buffer.
+		 * If the cursor is at the end of the string then this will
+		 * do nothing.
+		 */
+		for (i = len + 1; i > cursor; i--)
+			buf[i] = buf[i - 1];
+		buf[cursor] = key.unicode_char;
+		cursor++;
 		len++;
-		printf(ANSI_CURSOR_POSITION "%ls", row, col, buf);
 	}
 }

-- 
2.51.0

