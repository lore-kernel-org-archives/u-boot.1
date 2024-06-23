Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860C6C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72EA388477;
	Sun, 23 Jun 2024 19:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ndD2mMf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738D38851C; Sun, 23 Jun 2024 19:53:26 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4262088387
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eb85e80661so136407539f.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165202; x=1719770002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=ndD2mMf9SgUuFzbVj/9YHyJLXFuQxBy7/Z7rlahCnQgk2msyusN/3AeIXUxDbSETNk
 Z1TR/NZl52rI3YlzCejx4J6lr+L8eD5ZgUKGtt6JiMW055EQmdhaLsjHr4uPrfjwn2/b
 34izkUNo06cqCzr28sHY2M/WgExI+QoPESHCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165202; x=1719770002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7f7BP+opKLFa9/ciieR5UyH6P8YpaRYZrb5EZwJ4oQ=;
 b=tXBdXwl1CgSz5zHkYQJgnBc4i5W2UEpWFdSAskL0KamZenuJLJuAYY3GhhSGzHCuMI
 XEBMMi3SdAoXzb3n8+JsmpU73JBkr5pR9V/voPYFJ23gmGpfc5xaT8GXijtAmbfX4cbN
 YMqmzEMvQmzX6Gy7fAKbs7bEXZ9FxU2mSQ+DgmuGo5n9sZwGSY4+SrgMffxLffflox0b
 uT06AoRp5hPLH5FlY1zNwfJU0HcWUhVlTIV97fQVGOye3QhTniXlLqw8mFaYG7JElNfo
 P1gyzg/9F+tUoupvAsHV1gGJVTep5wqrKFFFblqEqELssVwHOPIbIBNc71n9VGA9baUL
 EKrA==
X-Gm-Message-State: AOJu0YxW2s7YaO1BbDXWRORNrOOxTxTY9Wi3u4tNAbmi9w+yf2wpd/sH
 phsp326HaHODklW5Dh9sMc2rwwSqCp/z9OzUNzFL4XRH1hpGP/Meh88cEWSW/kP6lluIsPsZnKl
 PJg==
X-Google-Smtp-Source: AGHT+IFse+2X0LzekOmaSZtzOIbQfGpyY2n/FbaePA5a3mPhxbyo83vnn3nEKonzQEgD+4sah2FXHQ==
X-Received: by 2002:a05:6602:1681:b0:7eb:6d0a:613a with SMTP id
 ca18e2360f4ac-7f3a74a9ddbmr300309339f.2.1719165201703; 
 Sun, 23 Jun 2024 10:53:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v4 03/16] binman: Deal with mkeficapsule being missing
Date: Sun, 23 Jun 2024 11:52:49 -0600
Message-Id: <20240623175302.1463973-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

Tools cannot be assumed to be present. Add a check for this with the
mkeficpasule tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: b617611b27a ("binman: capsule: Add support for generating...")
---

(no changes since v1)

 tools/binman/etype/efi_capsule.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index e3203717822..47da5da324b 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -150,6 +150,10 @@ class Entry_efi_capsule(Entry_section):
         if ret is not None:
             os.remove(payload)
             return tools.read_file(capsule_fname)
+        else:
+            # Bintool is missing; just use the input data as the output
+            self.record_missing_bintool(self.mkeficapsule)
+            return data
 
     def AddBintools(self, btools):
         self.mkeficapsule = self.AddBintool(btools, 'mkeficapsule')
-- 
2.34.1

