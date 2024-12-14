Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5B5E7716A
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 18:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1705180079;
	Sat, 14 Dec 2024 19:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dnGNOhaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C4F80083; Sat, 14 Dec 2024 19:20:43 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E18800AD
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84435dbda4bso131969739f.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 10:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734200440; x=1734805240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLADFX8zgj9fMgLJ/poPYOYijUwyDbuZQcY/CUdBo+k=;
 b=dnGNOhafxTOWoEris/IJ/eixUoHct2oox9qMWuH/7YBd+uMV+RG7Yha7BV7/te25io
 /Ll4OitUi7bFE+QAR7m4tpEhSvpAsggKgrF32EsLmIyb0b5Kc79HqiXkAIFXl+Xhq1dq
 0otJ8bes9dOUrdDbBlRCEMcbzuIHqMiWPVgmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734200440; x=1734805240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLADFX8zgj9fMgLJ/poPYOYijUwyDbuZQcY/CUdBo+k=;
 b=imi3o8C6CwxgPxve6/Lhl/Xy34RzPtmjBw9XyMR16OPBvkWTs7UfQHPR2/Gta+edQH
 4gARzXiWCikMpNqIhOVzb+muFvhzLt6uS8b59f8NAjXVh3U8aMVXF4fKzYCz+1klCo6I
 tak17DvpGhd4ylpo4F547XME/E/pDqQ6R/nWfh5O7L//ofi4tPI4rMolzCD3PizdX28f
 oaVRymN/qK/DjVP+HAcrMu8u/z0XKziporzTT09JJZp6rU/x0CaX2t0rpkzjVIfXkxZV
 DsyfDkwsROhTgoFLUWkirhs7hL/EktQWcrk+wD1ropxUOYQP8rTDz7mjxAk8Auxl4nA9
 1JdA==
X-Gm-Message-State: AOJu0YzQIuS20NevSsKJso3QbG7qLNvub6XVnOk81Fo/KKX+u7oJDZFg
 /dfKrsiJVevQ5VE7briK9Q/0dPmayp/tZtrzb6oxZEsmqGjAbodZtNS45vV80xyQkZMGAP+oHPU
 =
X-Gm-Gg: ASbGncsMJm2VpK6qxzcmvfacSdBVavmUNTQIJJmPZtSSJpJVLj9DqoYsh09MvHbvfil
 LjofwqEre7luJq4xroMBZ3Lb/0jUTIe9ZDBMRZWOrKVTdjT31gSyL+8CUScijSRnHID9ngas54i
 uHsuWM5mDaez9sdbPCp0frUIPPD2Yn5oCj2xGQTsUaEfRP+Bhx6gGrOYeOcJEKGW5JPVK/bmYPC
 FXhAGuBkRTOKoPIZnfWHM6JDJmOuH0ki5qKhUbpTpufUa200zKwQX7KcnRTN0iiuzLRd+WJ06Hq
 4kDLl0x2fwTMydv1jQ==
X-Google-Smtp-Source: AGHT+IEPy/pBP4U7ZyruKrnmjQX0TwnujOUiYqhDXIjGWcDMsAzRjfoJYGXbSsii6AtqNJbrb7EjGQ==
X-Received: by 2002:a5e:cb41:0:b0:844:2ef3:a95a with SMTP id
 ca18e2360f4ac-844e5b6e500mr810602239f.7.1734200439812; 
 Sat, 14 Dec 2024 10:20:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5dd620e20sm415135173.0.2024.12.14.10.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 10:20:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/5] buildman: Drop unused OUTPUT_FILE constant
Date: Sat, 14 Dec 2024 11:20:22 -0700
Message-Id: <20241214182024.1954974-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241214182024.1954974-1-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
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

This is not actually used but its presence suggests that it is the
filename for the board database. Drop it to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/boards.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/buildman/boards.py b/tools/buildman/boards.py
index 9e7b486656b..e7aa0d85a58 100644
--- a/tools/buildman/boards.py
+++ b/tools/buildman/boards.py
@@ -25,7 +25,6 @@ from u_boot_pylib import tools
 from u_boot_pylib import tout
 
 ### constant variables ###
-OUTPUT_FILE = 'boards.cfg'
 CONFIG_DIR = 'configs'
 SLEEP_TIME = 0.03
 COMMENT_BLOCK = f'''#
-- 
2.34.1

