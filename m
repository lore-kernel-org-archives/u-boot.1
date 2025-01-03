Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D2DE7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 07:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3CC802EF;
	Fri,  3 Jan 2025 08:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S/JaHxdL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E772C802EF; Fri,  3 Jan 2025 08:46:55 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5717D8036D
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 08:46:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso161787185ad.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 23:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735890409; x=1736495209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXdXdoM59IuIinzb8vLNJAfjFs+jofzGYnkHRIu31io=;
 b=S/JaHxdL2Q0ukCFv/bdoYMB/ZOqEAShlMd3+q7okb8oPvwzIuzbbnKo5Ul8DxN2T3S
 F3asExUhYErLvfgGXkYgJKIm20POgbDgQFJiJuVeIoJ267ZiO+2AEUfSuajMwr/w/gkI
 BmQJRrBkluUVGk6NSXWfd5Z57PleHgz4xISTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735890409; x=1736495209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXdXdoM59IuIinzb8vLNJAfjFs+jofzGYnkHRIu31io=;
 b=VrjIme6e7BQAk+gG3eH7kERz7iKsb8PEdVFdUTkRs3MflvCgZFors9b+SoySR/8LIb
 X35GEw8ZKLtXxwnz0t1rdLGgCZ/A8Wq8aZoQ5ntEUtFN58OzKU3VLd1Bd/pq7EB3IK0/
 69TZU+V4GmLiClbIVh3hvVGqZqBbsq7qX3++KUntXbAjGliAp9SGV9Ta+mVB6KePHTZN
 upWfSLEGX8BV91Yq1ZYWdjDiBinmUSUiAdqqJhsSkEiR+eu0T584pJ6b5Gs53sryNPsH
 dQsKGuIeMB10dvZxaNiEtNiII+COEBj22itsopIcjNi4OuePd8a7+gTxt+zzdY6DKkB8
 7ClQ==
X-Gm-Message-State: AOJu0YzNaev3dqkeIgaNmxliw+0Eurl8f0jFF6ve6tmiqUWoJPWFuuKK
 XZE1BCKwlOZnpHoKyveOU87lU+wclxkIeRl6/4eQ8e6UpM/IWQfZJuaWtNsSOCckEvRvQMGBElA
 =
X-Gm-Gg: ASbGnctMVq3nGG3Bh1avOZW5oHGOmMSccHOGArdGq1L4/QfXjASLOVZyBZHrZrFM470
 xCEnH288J3fX/0Ja4O0epgvE0OUjvqp3/8ISpulDXNqzEgKnIjYk6juyLZf/UBslDQOzcah2mWF
 nD1XloC89EKzxYlE8XROMRJnGM1m0gyswm7+cdRX3uqeRrRs9VFjKQFjHbMB5oKoYevzJ8IO7zq
 w6HXBGWW8/Va4URNIrRboLjOjL3+W9GBkA4Fd2/uOumUkxzqyoR3hbVBQhfUbWgddbw1gVbtgr0
 r5Ugccg=
X-Google-Smtp-Source: AGHT+IHGywJNWO4Yzx94BadaSIp9V6nLmJr0NpmLgu00yDX5bbU1NtpB9dbdpWVKqv56M+veEOzxCg==
X-Received: by 2002:a17:902:c406:b0:215:854c:a71a with SMTP id
 d9443c01a7336-219e6ebb68dmr575039755ad.34.1735890409250; 
 Thu, 02 Jan 2025 23:46:49 -0800 (PST)
Received: from chromium.org (219-89-85-241.adsl.xtra.co.nz. [219.89.85.241])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842e36c9e3fsm19869376a12.73.2025.01.02.23.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 23:46:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/4] upl: Correct handling of ISA serial
Date: Fri,  3 Jan 2025 20:46:08 +1300
Message-ID: <20250103074638.2348387-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250103074638.2348387-1-sjg@chromium.org>
References: <20250103074638.2348387-1-sjg@chromium.org>
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

The current implementation sets stdout-path to /isa/serial even if the
serial port actually has a unit address. It also uses the wrong name for
the compatible string.

Fix these two problems.

Also, the hard-coded serial port turns out not to be needed, so drop
that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_write.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/boot/upl_write.c b/boot/upl_write.c
index d8211b2cf77..85d4004cd4a 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -537,14 +537,10 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 
 	parent = root;
 	if (ser->access_type == UPLAT_IO) {
-		ret = ofnode_write_string(node, UPLP_STDOUT_PATH, "/isa/serial");
-		if (ret)
-			return log_msg_ret("uc0", ret);
-
 		ret = ofnode_add_subnode(root, "isa", &node);
 		if (ret)
 			return log_msg_ret("uc1", ret);
-		if (ofnode_write_string(node, UPLP_UPL_PARAMS_COMPAT, "isa") ||
+		if (ofnode_write_string(node, UPLP_COMPATIBLE, "isa") ||
 		    add_addr_size_cells(node, 2, 1))
 			return log_msg_ret("uc2", -EINVAL);
 		parent = node;
@@ -563,7 +559,6 @@ static int add_upl_serial(const struct upl *upl, ofnode root,
 		}
 	}
 
-	// ret = ofnode_write_string(node, UPLP_COMPATIBLE, "ns8250");
 	ret = ofnode_write_string(node, UPLP_COMPATIBLE, ser->compatible);
 	if (!ret)
 		ret = ofnode_write_u32(node, UPLP_CLOCK_FREQUENCY,
-- 
2.43.0

