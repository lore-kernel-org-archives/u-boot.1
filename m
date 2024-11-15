Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ADBD68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220F889711;
	Sat, 16 Nov 2024 00:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dqxZozd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A47896FD; Sat, 16 Nov 2024 00:20:02 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1882896F3
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83a9cd37a11so81825439f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712797; x=1732317597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMHRF7I/HYUWFVtWqOQddv72+zgYK7iClIHn7w6RERc=;
 b=dqxZozd7ZFoXapN5B2wQCjocs6cB0v+dpxKAYgDstsdf8IUH5OysN9uAdN0DdamvYB
 GZYLvhzXXLY2xAB0HFo5BR9MpkAnSyXhpgMUOo+VuYIH24urCUEXf/7qlzXS0ZmT4lOW
 P7tUaudjIfeOf/Il+i24wG5yY1u0nQjBKdac0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712797; x=1732317597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMHRF7I/HYUWFVtWqOQddv72+zgYK7iClIHn7w6RERc=;
 b=Psf9BsZ1cFtzOINTOwIH009R++/slC0DrnGRz+9BCuXd+8vY4SbA2jx1RHOxFyjyoS
 Xck62zZoU4Ksjf0ZOG2VoT1jlsQ4vP1eMpIrbljFi+UNAbZmXc1t3DelAgPqfvACJDW9
 ihWtGtuLeellftrXVKls/hrUjSo4IF3JlSPScb53QavUPSkV7fruKIBRn81bSd5I5NUy
 u8CSxyZ8uUJ5x385Ml4SCl90Xe/IZAx06YI1X1ELiDaW9HXBIN21Mjcfu0zga3ddsJCt
 oshr/fXXASZtM7yhlvYbRdSOzEp4CltX6Q3ver7oAz9imxL3FVT9LLhgIzTXm42E9SQ4
 6G2Q==
X-Gm-Message-State: AOJu0YzqtZfv2zXObxhlYjJ7O+j8C8VaMUGjm5DdUb+yphYjQsxAH/2V
 LxlbFCtYPzwPNPpyKKzi2bl3u/5P9zxY/hy08gegSRfDnugmI5njFaX026g3Mx/JLNL4jgi4xeg
 =
X-Google-Smtp-Source: AGHT+IE7uJEdhMMlpsIQ2BBEOXmHZZpcGDXHR0NfKshzbVx9c3RgPcp2DxTuwreFrGE6R2DIdMaNQw==
X-Received: by 2002:a05:6602:27c1:b0:83b:5221:2a87 with SMTP id
 ca18e2360f4ac-83e6c285e53mr640925739f.3.1731712796799; 
 Fri, 15 Nov 2024 15:19:56 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v4 08/19] boot: pxe: Drop the duplicate comment on
 get_pxe_file()
Date: Fri, 15 Nov 2024 16:19:15 -0700
Message-Id: <20241115231926.211999-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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
index 3ae17553c6d..8c9c7f84d97 100644
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

