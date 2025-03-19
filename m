Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0086C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FEEE8283E;
	Wed, 19 Mar 2025 15:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MdbCYoCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7A982898; Wed, 19 Mar 2025 15:56:54 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9258283E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43948021a45so47356745e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396211; x=1743001011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v8MjgFzbHJj922YEFub/U6MYF9WiDCB+GzvJLsz2UY=;
 b=MdbCYoCNWsD/abJ9yJ+8E2WqgDIBz8h471HO8ax1oBJI7U8gLby3Duj017oUIP79L2
 WplU4renYkCby4HOIu8F/N/5alAI0Q8e66DHGUcB/GXjDFhzhpdTzJRiGZwagFwJ/ER7
 AW0ROkrxWum4jw6OSsrKVn/Raji5OIIesvDGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396211; x=1743001011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6v8MjgFzbHJj922YEFub/U6MYF9WiDCB+GzvJLsz2UY=;
 b=t0tQyeDhU2/QD1vpgt98w/paLM1daGfZadwjdrVkp028Oxut9O1PQmz2mseGndfsUz
 vRolK5DBNQTK3o4UnNeXH1UgtG5Lc8HwraGYA99MOZBe05zKO62eTVK2ozXy8lYYVQbW
 xe1g292IYM3eeeVINmxrdMONb5DDgLRCsOaLqj+dBi4HfzU4y8O+BE2r3wB4ErRP2gE9
 d83BG66HRrvJFK4uq5fWZizX1Jk5Gx0DUFbJZu3KgmKwnFUN32t8vqESOq7q7cIFd6Fs
 JqsGLuzCoxM0B3A5oFyaj+iHcMu9sP2GLOx/Q0aLFu4NZgZc1IYMgbPDKm3jP/pWEm58
 CArw==
X-Gm-Message-State: AOJu0Yz1ZJhYghgdF1Vo+473o2NJmbLYNOhuxHbhbvkF6iUhkVffK/dh
 pf7NJ17veRcUHjFfvJSGMCNxUspDzDDxklKqjdlGVqlueO0G2o6e2+2BonpErl6L0mu1kil+0L8
 =
X-Gm-Gg: ASbGncvBLcTB4AiMVXAVCOI3myxKzPz61XHtskXD3yutxODdiNXjiT3SycoPb+iCck5
 tiy38dGXyiLVoGRxg9fl8hsdrOjSD7MwxrjSl+l7xtpfZiFaH8F4zBESjpw7S17zU7x/FMHu7qk
 A5Q85mXrS/wMnIeN6RI8QFmAvR+ybgT1MeOo3KopK7vqcwNua0pWhqKJQ98iRVIDXxEFcL8+kav
 Lkxe3USPqnkdxQJnJeXRdy3opE+FcqxVGM/T9ngDOZ6IvxIhp6bD2hWVcABVdR8OjLkmhNumAEh
 m30eOX+LsEMN7AGPJgX3F/Y1fITdrNE6xw5+nUgOww==
X-Google-Smtp-Source: AGHT+IEAHsZW2HEV4UFQeZYOCQ9ggUGkhr0MCxcwEM3Z3KgUqnFAzVhg6BuvBnRs7eREok3DW+Ko2A==
X-Received: by 2002:a05:600c:46c6:b0:43c:f5fe:5c26 with SMTP id
 5b1f17b1804b1-43d43786292mr29470425e9.4.1742396210859; 
 Wed, 19 Mar 2025 07:56:50 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 45/52] expo: Adjust expo_poll() to avoid looping forever
Date: Wed, 19 Mar 2025 15:54:50 +0100
Message-ID: <20250319145512.2391122-46-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

If the user does not quickly provide some input, exit so that other
things can be done, such as searching for the next OS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 4e855f60d84..bf2f1dfc68a 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -324,12 +324,14 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 
 	ichar = cli_ch_process(&exp->cch, 0);
 	if (!ichar) {
-		while (!ichar && !tstc()) {
+		int i;
+
+		for (i = 0; i < 10 && !ichar && !tstc(); i++) {
 			schedule();
 			mdelay(2);
 			ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
 		}
-		if (!ichar) {
+		while (!ichar && tstc()) {
 			ichar = getchar();
 			ichar = cli_ch_process(&exp->cch, ichar);
 		}
-- 
2.43.0

