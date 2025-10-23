Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9794FCCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 14:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E515083677;
	Thu, 23 Oct 2025 16:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZjA/nEyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACAE383677; Thu, 23 Oct 2025 16:26:54 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B092783653
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 16:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-475c696ab72so7174235e9.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761229612; x=1761834412; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W4KzH8c10ZW2UPNU9E02xkdjocmBbAt7JNtBKodIfpE=;
 b=ZjA/nEyGBoh6PJKCZQCErHXKZ/s9sCVSv8n7iP3sEkuzTmXPW3xJd3tX9ODOyetIIR
 NHAP6bjmAmLtiumhPQNxaSvkOz+ysnP2I+5W/zOe2T6GlgISEC5E2DdF9+IXWc+9sRtP
 fQ2uFlsy7Wtj6BecYMqGqApJD52lGQkTBmWU0NAgWovCrb0FJSr03Z32uMluuhJdg2MW
 FqY9lpVFmIRO8iHkddp9KgJSbTZZYbfcnQ5Iz6Cs7/pXBjtPFNi8vePSQf3XE3c++K1p
 Qo3BgXo7oNXbXfKJuqo8Rgmutlhydr+wN/btob1bQLNHW9HRYpISPERICG0or5VcpHcr
 EfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761229612; x=1761834412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W4KzH8c10ZW2UPNU9E02xkdjocmBbAt7JNtBKodIfpE=;
 b=GGYK/RjvQY7lukDJLFLKjXKI5PnQCTX3h29CzCPmatki4FKet4R43C79KvlJrfWHwo
 jCMd0lZguceOw6IbWmmUI5tou8aB+joqz8/8XLMLTosLgGtfTe49uExElTDSl2YfVaW4
 J2DH39nz19QUs/1MAGBjTtxnkZUqTZOezpZ9fp7Ywd8h5g12DPZWosdx9cWRG3Zc+ZjO
 00W1nsWEbDMl5NL/ukQN87V/ZIVvrYNfWiT+e3NV+JgSf6nBM05DUXyuxX5RGvQLM5tp
 xP2OllTVeFra73SvlMTZGi12gEKOA2lZVlF74gqplj8SpQqKYyPLwlvhFa4D2FkW+RPN
 /wkg==
X-Gm-Message-State: AOJu0YygYEs+RSIFzynZ9LR8JT/yzyHXFWAJ5KxLDJ9Fg32lg8enY0NH
 pHdUPxLm2NK3btX/iYXZZcjP2ErfCENTCXM2UfMSmvTd9V4efGtedZUGVKNXEY+livSDC9wDUg4
 cMf63
X-Gm-Gg: ASbGncsJ9mRgUW+hbafQDA6SwCSSjGt+IPKmkwc/4g5I0G1uU9p4yDklmnFKaNPNEsN
 VoWOyFEhLnNomJ/aFe+jLDVBwZ6+kuDo4jZIBdPaQmd55qvM03Iwwcm8+qAIH32F0S9WIFXfny1
 ZDcVRX6u8ls7U/aRlPozr3g6umwJ2e0PHWz23jdhMQmdMVRL3n7VXym+aoXVPalkWZ56NMPOVto
 BNN6RK++yvXuK2z+7LHi4mIQpaHIR9cLPU/Touba2Y0TUDqfiGuWcACURMBMSfSizEKMnp96eSw
 AozrQJJKadbqWSg0K/A8y77ompqK7KPlqFVxK+Myd9JFRJRfU21Rc3v1ZjdeXPhPuQpcRYM0NZS
 QGrElSMD24QtXiP1fgrJ99z8lNPYnPFxPBaBPK0GAwizwIIGJJqhyMvdPCktmfpU9SmrzjKmPNe
 kiUisF3/Dlc9ZdF1pBI2lmEW/x3FKzonlez0KrWEshrOJe
X-Google-Smtp-Source: AGHT+IEvmDbUDX5o2Kz9xbPtF2yneBRbY0nNJHqhfBvxFzkaDK4P5qZk+4zLz/L1Tl65C2wGmANaqQ==
X-Received: by 2002:a05:600c:34cd:b0:46e:7247:cbc0 with SMTP id
 5b1f17b1804b1-471178aabb6mr183075685e9.18.1761229612088; 
 Thu, 23 Oct 2025 07:26:52 -0700 (PDT)
Received: from lion.localdomain (p4fc3da2c.dip0.t-ipconnect.de.
 [79.195.218.44]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae9f292sm38585445e9.5.2025.10.23.07.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 07:26:51 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 23 Oct 2025 16:26:47 +0200
Subject: [PATCH 2/2] efi_loader: efi_console: jump to prev/next word with
 ctrl+arrow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-eficonfig-ux-improvements-v1-2-f5fc93b126ed@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=9/AuZkA12HZSRh/p01aE6GZgMZZrhORNZN6vVu2BjIE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoxf1urzPvJXab1ofFxflxoS1LLFfpm3YsXrt9eWhIX7T
 uyPKufoKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABPZep7hn0r+25qEAJlopvyA
 8+Wr3Be3TRAJDNyrurv00K4lbWkKsxj+1zqmbnx8xFRL09dQPbC14rTjdytl/mnNNyrLbrac6X7
 LDwA=
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

Extend the previous improvements to efi_console_get_u16_string() by also
implementing support for jumping to the previous/next word by holding
ctrl when pressing left/right arrow.

This unfortunately can't be handled with only the basic text input
protocol, so for now hackily look at the internal state of the efi
console to read the modifier keys.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 lib/efi_loader/efi_console.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 7bfd18233feb..87de38a26569 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -1387,8 +1387,9 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
 	efi_uintn_t len;
 	efi_uintn_t cursor;
 	efi_uintn_t i;
 	struct efi_input_key key;
+	struct efi_key_state key_state;
 
 	printf(ANSI_CURSOR_POSITION
 	       ANSI_CLEAR_LINE_TO_END
 	       ANSI_CURSOR_SHOW, row, col);
@@ -1401,10 +1402,18 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
 		printf(ANSI_CURSOR_POSITION "%ls"
 		       ANSI_CLEAR_LINE_TO_END ANSI_CURSOR_POSITION,
 		       row, col, buf, row, col + (int)cursor);
 		do {
+			/*
+			 * FIXME: we would ideally just use the proper extension protocol but we
+			 * can't easily get a handle to it... Since this is only called
+			 * internally we can be cheeky and access the internal state.
+			 */
 			ret = EFI_CALL(cin->read_key_stroke(cin, &key));
-			mdelay(10);
+			if (ret == EFI_SUCCESS)
+				key_state = next_key.key_state;
+			else
+				mdelay(10);
 		} while (ret == EFI_NOT_READY);
 
 		if (key.unicode_char == u'\b') {
 			if (cursor > 0) {
@@ -1429,11 +1438,17 @@ efi_status_t efi_console_get_u16_string(struct efi_simple_text_input_protocol *c
 		} else if (key.unicode_char == 0x3 || key.scan_code == 23) {
 			return EFI_ABORTED;
 		} else if (key.scan_code == 3) { /* Right arrow */
 			cursor += (cursor < len) ? 1 : 0;
+			while (key_state.key_shift_state & EFI_LEFT_CONTROL_PRESSED &&
+			       cursor < len && buf[cursor] != u' ' && buf[cursor] != u'.')
+				cursor++;
 			continue;
 		} else if (key.scan_code == 4) { /* Left arrow */
 			cursor -= (cursor > 0) ? 1 : 0;
+			while (key_state.key_shift_state & EFI_LEFT_CONTROL_PRESSED &&
+			       cursor > 0 && buf[cursor - 1] != u' ' && buf[cursor - 1] != u'.')
+				cursor--;
 			continue;
 		} else if (key.scan_code == 6) { /* End */
 			cursor = len;
 			continue;

-- 
2.51.0

