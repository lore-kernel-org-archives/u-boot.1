Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00CDFB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43B684277;
	Tue, 17 Mar 2026 02:24:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SR4gy7cO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0C48425F; Tue, 17 Mar 2026 02:24:42 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F6684129
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-67bac077116so2708472eaf.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710679; x=1774315479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+w0r5kYSvfX8G0xPqP2ymHKtdssFmtU1w79fA1kFmb8=;
 b=SR4gy7cO5zs128+0XIOA5/Bt7N7VyPDRA8HEqzBGoMNUz/S8Nz6zZw8OCGh6OSO1xt
 okTEpRFytjTN0mCP5/os9sh1F6TkZFMljxJel8HQTTWuDspcdUet/G3xNzcybWDxhWYV
 IqTdVaXuwMBIthIIxovB0fBC5P8rPFnMGL4zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710679; x=1774315479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+w0r5kYSvfX8G0xPqP2ymHKtdssFmtU1w79fA1kFmb8=;
 b=BuD9Eobv5BkP/rVg7WPtbYbQkgpsbI4eYZBeVFlOj1IUcg3YRNbhY9aj9pM/67gZAh
 J7jpKn7VgFYzq3lDL/ei+wzKUS4OQ+BBGdHRZZ0CTOHjehoeUInya4/IwgvoToYNnoFD
 bdRARCDACb+ck3y6qwfsjXs3N847fpXS4+H0RWd4aZ+NRxrYG/+npGDJQm+t4uVfuEcm
 8iVsZpDvkQY/Iew2BAFJXG43Xa3YJuhheyaPULEGbPV/EnLMAjAE4171fSVjiHd4XwTU
 D6swsS5UaUPxfWDiB3I0wH69dHeWmvb1ImHYsdQ2Uy6LmhsTaCMJo+d+3n7+rpTLjDzg
 z71g==
X-Gm-Message-State: AOJu0YzoYAX8g+GUlF534HjDlWozZhq3pphm/KsFFFBzR1y8lZjY1mhn
 Ce0ZPjPHVvdiFxq7BJR/E/FAp1qDUcISN8VFifvoQ5De2MzD+SrF2+SOwmfBV0+l+0YjE2KJm65
 X7H02TXo=
X-Gm-Gg: ATEYQzwRf9L7nWHoBw+R1j7/CPq6X1F6+H575f0TJECy/cd+dXeKgBhsMJLVSWw9MIa
 9JLobYR7FsiW7SyQx1cXehrMsz/TfE5Vwc2ulSqit/QcG4eJcSRAf/8Eit2NGI1eE1UqK0oezjp
 nJpvAOF8YWqJjMqc/b8xBrQVf8/QhbUtnQ6pULIOPI/242AIqog2ROVZvHAJawvD4ji2mHgI1MZ
 2Dp6lMu3TsnCps2cmDL4uBPzTpH8GUMHqzUmP4O6IHEHpF737PHvjOulonSLfWYK70RyxiYZsIx
 SnzPhJmAz8aFgJkhS5+PiSlRju8AuXM0LQLhMATvC1JuC+c7I1S320c75MZa5UbfLVfW0iRVvWw
 LMsS1FbTA5+4H6D1DPUoI+0pYsZv5nya1y+D/laM4HS6nOX69CTG63s5hmUqBav7j2fxEGftSGe
 ybM4wMaImlx7jVInxsrZR1altjss8Oalvs6op01DzoiKQb9C4MQqqyKkQGs+OmLgv4MFATStEIT
 nNkmJ6CdBygQGtpR6GbOlbyxlrnnkJ/ukar1FdTyKCfW9bYTG8=
X-Received: by 2002:a05:6820:169e:b0:67b:cf34:e38f with SMTP id
 006d021491bc7-67bdaa79c75mr10276377eaf.54.1773710679265; 
 Mon, 16 Mar 2026 18:24:39 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9332686sm10978789eaf.13.2026.03.16.18.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH] input: Correct dependencies for BUTTON_KEYBOARD
Date: Mon, 16 Mar 2026 19:24:37 -0600
Message-ID: <20260317012437.4162554-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issue with the dependencies
for BUTTON_KEYBOARD. This needs to also depend on DM_GPIO, and then
select BUTTON as well as BUTTON_GPIO, in order to meet all its
requirements.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/input/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 47ce0ea690fd..5bf122c55051 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -48,7 +48,8 @@ config APPLE_SPI_KEYB
 
 config BUTTON_KEYBOARD
 	bool "Buttons as keyboard"
-	depends on DM_KEYBOARD
+	depends on DM_KEYBOARD && DM_GPIO
+	select BUTTON
 	select BUTTON_GPIO
 	help
 	  Enable support for mapping buttons to keycode events. Use linux,code button driver
-- 
2.43.0

