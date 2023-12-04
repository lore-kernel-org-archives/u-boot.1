Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688B1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D508763E;
	Mon,  4 Dec 2023 01:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+WWr1mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E406877FE; Mon,  4 Dec 2023 01:27:46 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A3C6877E4
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d03fb57b69so12914705ad.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649662; x=1702254462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AO/5lscFHwsdsQM3r9OpIk7pytRrR6EvRDsrTIXD2Nk=;
 b=O+WWr1mrXtphazLlz7/WL63TP0xsx3felZrZ4kkD5xvKTtV0uOBjfKPtGK9n8B4KOW
 M0uQ/FRl+vHd6/3NqS4lO9NGcnHpqkRbqF0FzFDwCSzCJcy2uu+n3z1xbGyt2oS9NuWy
 7OCNWWewAVe703IwOhksc2Oc/mrqg6qxwJmJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649662; x=1702254462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AO/5lscFHwsdsQM3r9OpIk7pytRrR6EvRDsrTIXD2Nk=;
 b=t+Oj/e3cVBP6l/DXTlX7oVBgH7GfJQW8VG3+pflpEnGHi6rNo0NLjvy/Ft3d2btlIx
 qqqYiNxAjWkOb2TvQ7eP9cwIok1/n79hZ0QzyS2DSUJXXJzuCuClrc2+wBwBdCZxlQ/F
 wgfCR7yk1IC/f3rNkxj9RrqSC8UaA41U+wWlmM9g1cPuLVVSI9BXzHNJcer3AhkEBNXv
 H7oTCYsp5eTGgz7MrM8xwnP20y2DuT6npRB7TcRYbmiNc811MHVbznSKKfQQA/T+h7mm
 2drGFnviZqT1HvDFiuwqQ5HyjXMC4vS6kM1YRFcyLOnpjKbgaC8bc15LNa31G55sTvf+
 Eohg==
X-Gm-Message-State: AOJu0YwGR/Oba6wuFI8f6ATwipUbuqIShSGnnGauMgQZ+q8jjlkwwPh9
 lt3Y0r+xD1iWxuis8o712bbrK88zVNacqAgp5irMMw==
X-Google-Smtp-Source: AGHT+IFKnCElhGhsSC7sdKxPDghZ+lWgKb1h9Twbn/MDYHDlTBHV8u/+LkKbpv2mCr8vOrMWgZKnkg==
X-Received: by 2002:a17:902:a3c3:b0:1cc:29ef:df81 with SMTP id
 q3-20020a170902a3c300b001cc29efdf81mr1033187plb.41.1701649662237; 
 Sun, 03 Dec 2023 16:27:42 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Scott McNutt <smcnutt@psyent.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH 10/18] nios2: Add a reset_cpu() function
Date: Sun,  3 Dec 2023 17:26:26 -0700
Message-ID: <20231203172622.10.I2c0bbce52ecf7ce9458c481fbd12b6029e5ebd27@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002642.895926-1-sjg@chromium.org>
References: <20231204002642.895926-1-sjg@chromium.org>
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

The current do_reset() is called from a command context. Add a function
which can be used from anywhere, as is done on ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/nios2/cpu/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/cpu/cpu.c b/arch/nios2/cpu/cpu.c
index 79a54d1bc259..de7bfa947f11 100644
--- a/arch/nios2/cpu/cpu.c
+++ b/arch/nios2/cpu/cpu.c
@@ -35,11 +35,17 @@ int checkboard(void)
 }
 #endif
 
-int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+void reset_cpu(void)
 {
 	disable_interrupts();
 	/* indirect call to go beyond 256MB limitation of toolchain */
 	nios2_callr(gd->arch.reset_addr);
+}
+
+int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	reset_cpu();
+
 	return 0;
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

