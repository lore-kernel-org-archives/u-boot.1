Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D34C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD16288A5A;
	Tue,  6 Aug 2024 14:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BnUxSlXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BCF88A55; Tue,  6 Aug 2024 14:59:35 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E12188A54
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so22798339f.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949166; x=1723553966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=BnUxSlXYMkWihHiNtKYVhSa/2MANomVKD5wZ/uWzH+M4XLab0q+Vd8nhU5rWj9MM2b
 EBPQC2mN/btyHguP6QeSHD1SdJ51xrCTgwEAmkDwmPVwPcBzY1kf7PB3NtgdTH3dTytV
 tmYYebWsaK+BfRiiBE3v6WZ1i5Bc+17+xEpvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949166; x=1723553966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=WzztYl7pqq0tF0TiADFf57YpQEnOigO0xlHKaiXU7rHgWorQ8SwSprFs5WZ5Mkc5LP
 P9JYBpXpKoE+QrA2PltPbYucyDrn2t7WRNWqJ97euDInNB8aoEZJMcrYBM+l+B0MV/eC
 dIKWfrQq8QAF0o6sirZH7c7eClWANxCyzVN3W7gHKogCX2dCBq3Q6gWiXd3qOh2VTXxR
 bLW/3ucs3lvkCIHZW77lgWQcEiKVNfGDeRf6OLog8Crea7G85lVOLJ4em8ez650DwUaF
 UnCEPM8ilRBuxZtUB3TBPdyMh8s3tKY3NutVgbHxnFsVs4bnMsZ5a/DwjVsB6TxqqMDq
 7bmg==
X-Gm-Message-State: AOJu0YwO+PfWlGHbc3unoKyX6rgXOWVzY/B8FqAT5R+a0AFQv8RYKcts
 XH0XL2qgWnumyORqxw5N5ZINXljyYgktBE2b6/pdDtSBt6StqYCBteITolcLqdHgSv2nZMWG8Mo
 =
X-Google-Smtp-Source: AGHT+IF+eexBgFIAj+brpl1e4GjrGGGGCNm07lA02otV6rssJZg3yrb2BFtsdBLhoApCETVvU48+5g==
X-Received: by 2002:a92:d683:0:b0:374:ac3a:e32c with SMTP id
 e9e14a558f8ab-39b1fb8885cmr165878785ab.16.1722949166608; 
 Tue, 06 Aug 2024 05:59:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Marek Vasut <marex@denx.de>, Neal Gompa <neal@gompa.dev>
Subject: [PATCH v2 09/39] usb: Add DEV_FLAGS_DM to stdio for USB keyboard
Date: Tue,  6 Aug 2024 06:58:20 -0600
Message-Id: <20240806125850.2316956-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

This device contains a pointer to struct udevice so set the flag
indicating that, just to be tidy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/usb_kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index b834b2f703d..1d9845b01ed 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -612,7 +612,7 @@ static int probe_usb_keyboard(struct usb_device *dev)
 	debug("USB KBD: register.\n");
 	memset(&usb_kbd_dev, 0, sizeof(struct stdio_dev));
 	strcpy(usb_kbd_dev.name, DEVNAME);
-	usb_kbd_dev.flags =  DEV_FLAGS_INPUT;
+	usb_kbd_dev.flags = DEV_FLAGS_INPUT | DEV_FLAGS_DM;
 	usb_kbd_dev.getc = usb_kbd_getc;
 	usb_kbd_dev.tstc = usb_kbd_testc;
 	usb_kbd_dev.priv = (void *)dev;
-- 
2.34.1

