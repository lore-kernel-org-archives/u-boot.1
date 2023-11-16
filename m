Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059C9C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB68787454;
	Thu, 16 Nov 2023 05:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nX2O91oR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D728743F; Thu, 16 Nov 2023 05:11:23 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7CF87258
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7b05e647c09so11937439f.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107880; x=1700712680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfzgIIISeDqr0mlYCJwzLxB3tqTZ0UYYykHi/0bnSYw=;
 b=nX2O91oR8FxtNMMZ/PX+rYb4PtkK+mDgL0g9pt9RKicU/G4XMaS97eJcTaQRjsMjm8
 Opcrp0R6gjP+Uw8SyH6Yohek1glyQhHOOD+lmrrIsHXvk4m1mZwSyQYLl9P+ZPwm9T5r
 NVWUyj1EHQsUaFah59yHbm5d5InGTtwpWHppU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107880; x=1700712680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfzgIIISeDqr0mlYCJwzLxB3tqTZ0UYYykHi/0bnSYw=;
 b=qi8dfLrCOYuc8fNb/DKA/BGh3OGAaX8anSdPBXcPrej96eEsJwiT66sWj+Z7J+W3CY
 s4JTx4Z6am/q7kDifTiCgH4HgDppOurUW5tzP8UwNpS5FXrQBCD9bZ8odeBZJhWY+ZLD
 ca2U176qIg+Pek9BXNCBs0H4JVfKFeDj86YNEwy3uyYTLk2NF2ZRuLSRlAujPjbEHNfe
 z4RugHgdTxJMSKhSRWxUGWingSY5yR0NNsqHsycu6vvSzBerTKnvlz36iqnlbWa2qqZP
 OVgk4XupqOE0/Kbk8N/GgHyndLBl91J4Uh0WQrygjYUMiDKjTmdytiCLRgo2DV0ZAEZD
 dXlA==
X-Gm-Message-State: AOJu0YweH47mSOEoFWV6gCbOqHzDaQ1RZYcZLf3xfZ71yiKbQIXX6K/o
 Y5bGwNW+wjio+cv48Uqkzlu69YUm4G7JUtMpDERx4A==
X-Google-Smtp-Source: AGHT+IE/f51Msz3TtLOp63zezfXOgrQ/wvaLdLsY1XnCCSmaZmfZ7NSgFAk8KVtK79jywje/mSyfGA==
X-Received: by 2002:a5d:9b0d:0:b0:794:d7e8:d239 with SMTP id
 y13-20020a5d9b0d000000b00794d7e8d239mr15471549ion.17.1700107880079; 
 Wed, 15 Nov 2023 20:11:20 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 02/32] README: Correct docs for CONFIG_SPL_BUILD
Date: Wed, 15 Nov 2023 21:10:02 -0700
Message-ID: <20231116041043.362055-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

This option is defined in both SPL and TPL builds, so correct the docs
related to this. Also point to spl_phase() which is normally a better
option. Mention VPL as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 README | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 60c6b8a19db1..f26c34a5e200 100644
--- a/README
+++ b/README
@@ -1545,16 +1545,26 @@ Low Level (hardware related) configuration options:
 		globally (CONFIG_CMD_MEMORY).
 
 - CONFIG_SPL_BUILD
-		Set when the currently-running compilation is for an artifact
-		that will end up in the SPL (as opposed to the TPL or U-Boot
-		proper). Code that needs stage-specific behavior should check
-		this.
+		Set when the currently running compilation is for an artifact
+		that will end up in one of the 'xPL' builds, i.e. SPL, TPL or
+		VPL. Code that needs phase-specific behaviour can check this,
+		or (where possible) use spl_phase() instead.
+
+		Note that CONFIG_SPL_BUILD *is* always defined when either
+		of CONFIG_TPL_BUILD / CONFIG_VPL_BUILD is defined. This can be
+		counter-intuitive and should perhaps be changed.
 
 - CONFIG_TPL_BUILD
-		Set when the currently-running compilation is for an artifact
-		that will end up in the TPL (as opposed to the SPL or U-Boot
-		proper). Code that needs stage-specific behavior should check
-		this.
+		Set when the currently running compilation is for an artifact
+		that will end up in the TPL build (as opposed to SPL, VPL or
+		U-Boot proper). Code that needs phase-specific behaviour can
+		check this, or (where possible) use spl_phase() instead.
+
+- CONFIG_VPL_BUILD
+		Set when the currently running compilation is for an artifact
+		that will end up in the VPL build (as opposed to the SPL, TPL
+		or U-Boot proper). Code that needs phase-specific behaviour can
+		check this, or (where possible) use spl_phase() instead.
 
 - CONFIG_ARCH_MAP_SYSMEM
 		Generally U-Boot (and in particular the md command) uses
-- 
2.43.0.rc0.421.g78406f8d94-goog

