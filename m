Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC12AD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69A08932B;
	Sat, 19 Oct 2024 17:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="awhDWy94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBDF892A5; Sat, 19 Oct 2024 17:22:58 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF0A89318
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so108496339f.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351375; x=1729956175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGanZBy9M3edqDmcU0oo6ewTIBOftdhFZB6GvMov7qE=;
 b=awhDWy94j90hS0Sfzflu8qAFT0AFQMRozWJrAWG3kGAAzcYC70w7pLiFUzs/JaDz9s
 X1cklgmoSRvwIrgAvjVIB9ZADRjVPPHT50JYvS0YgfCJk06mA8F82Obyergu3vw7J2Au
 cO91jpBWSI/rss7/oynvn2Hkg/0mmIJiwaWsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351375; x=1729956175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGanZBy9M3edqDmcU0oo6ewTIBOftdhFZB6GvMov7qE=;
 b=Eq+rmzLCDbcN/igYbulJFnG0Bab47QaTcAorujOt2+q+JUnmJsomRnJ31RK53K6yp9
 VY8+uRbbjae4FjC1ahkNsVGaqNizSoHY0M7Ao8dk+RWGkreALtaLj8OBDEfigj7Q2z3M
 13fqFR38B5U3ulQrIjdP7V4v8U6qD/jDA7Q1F9a5JkqLZrW2y4BvZErKTJ58MDPQ9gvV
 Up0Uy4O1d0dTdXiGi6XWdD89eNSlSZGsm38uOat5mG7cZBRFBPVHTpzjA3WjnRr/ZNZy
 LaoagVaS3iEmsJn/oVA5wTN8m6+igvIvfmRFyyaqEhzRTCAcBSb5XhwKhTUPjR80CYoV
 b0UA==
X-Gm-Message-State: AOJu0YzM5U5ISXZy1asQNvxXm5sYJf/IvaUYL1hxGpNRPcfthvZfIEqY
 XYCE22yvfhRjRSGqeSUag+jORSsvx1f+owYETkehhWwGCgFi/YxpYEkx78hJJswF3+EGqaz6njw
 =
X-Google-Smtp-Source: AGHT+IG28MEtZzEg/aGVnYJgh8tck0g3RC1tMkC7Rp9yNjhc1ThHDLVGT/kqIoIEjM7A0mY1Wg736w==
X-Received: by 2002:a05:6602:26d0:b0:83a:b74c:800e with SMTP id
 ca18e2360f4ac-83aba649c2fmr718003139f.12.1729351374826; 
 Sat, 19 Oct 2024 08:22:54 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 22/31] boot: pxe: Drop the duplicate comment on
 get_pxe_file()
Date: Sat, 19 Oct 2024 09:22:02 -0600
Message-Id: <20241019152211.1014896-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

This function is exported, so document it in the header file. Drop the
duplicate comment in the C file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index d6a4b2cb859..4fd26524286 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -133,16 +133,6 @@ static int get_relfile(struct pxe_context *ctx, const char *file_path,
 	return 1;
 }
 
-/**
- * get_pxe_file() - read a file
- *
- * The file is read and nul-terminated
- *
- * @ctx: PXE context
- * @file_path: File path to read (relative to the PXE file)
- * @file_addr: Address to load file to
- * Returns 1 for success, or < 0 on error
- */
 int get_pxe_file(struct pxe_context *ctx, const char *file_path,
 		 ulong file_addr)
 {
-- 
2.34.1

