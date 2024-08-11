Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C29C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A5288ABA;
	Sun, 11 Aug 2024 16:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UNDHz0DO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17A0889E3; Sun, 11 Aug 2024 16:52:49 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5CA88A05
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso15679635ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387966; x=1723992766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF4L4/LqhTmHLXLs6sfz2g4aPV4zfNGACs/y8Y8HoFs=;
 b=UNDHz0DOPznfYu5WG10+JMceJCdYl/g4khXX/Ql/CRGF57qEiOyWgFFvEoFWF1DFNW
 9xkrK4OwPWH5bF1vYk5Hf2fLw4y6OcmKCyeApy/FBzwf1vKiv8FYspitL9lKtlB+9+Wx
 BSXU4kzXZ7rzH16dHbS2/f/VQDNl9CVPxH+aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387966; x=1723992766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gF4L4/LqhTmHLXLs6sfz2g4aPV4zfNGACs/y8Y8HoFs=;
 b=VWq29fmRXieNXzKIP8YTgkqTiDbmbqHhmMgvINIWU2Po7MRBDZMCWk5SHgVyyQRABa
 Bo7Ntvi5wdHHmLaqmal+pJ0j8+tS1iM0ONOqKcxZEcpfG37dZ6xcHm0yQamBEAQ1zP1M
 9mEWkr3w0eAjpMnded3hJTvAGXUwqNObHbftaee6k+zjTQCVafdd2sYripQ9WtvGs6cG
 31CDhExMNwT2Bs8YgVI8hAt+2X4PCQasgInSdnKeTiCd97Ktg4bk/BxE5lXJvkZFvhrQ
 WbrrUHFqXsz6Gk8O08tEU2zd49ypMxIPLW2NhSRFzyiiCkvXMbCtDwbKkezCJifKcbbm
 3Gdg==
X-Gm-Message-State: AOJu0YymVGr3jBoTW9jkZDzTsRTSXOI6GsILx3g5HAQG5vJjxWKmcceh
 INWyp2swkUa5RnJ1ErWsE8SdgHpg0jwnkFT1lafh/CLTCfzElJTSSSK3k9IxKeDA5U8cQO8zD2A
 =
X-Google-Smtp-Source: AGHT+IGpzwntCQN/K7WrShOKo8ktyW6+rz9lpiWZ9CBZlYE1/jMaDCIgYbZfSzp5lkJ7eeZxWkW1DQ==
X-Received: by 2002:a05:6e02:1a2e:b0:398:770d:1fa4 with SMTP id
 e9e14a558f8ab-39b7a462d12mr90316035ab.25.1723387966297; 
 Sun, 11 Aug 2024 07:52:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/40] read: Tidy up use of map_sysmem() in the read command
Date: Sun, 11 Aug 2024 08:51:48 -0600
Message-Id: <20240811145209.4191404-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

Rename the variable to 'ptr' since it is a pointer, not an address. Make
sure to unmap the pointer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Correct the commit subject and message

 cmd/read.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/cmd/read.c b/cmd/read.c
index af54bd17654..8e21f004423 100644
--- a/cmd/read.c
+++ b/cmd/read.c
@@ -20,7 +20,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	struct disk_partition part_info;
 	ulong offset, limit;
 	uint blk, cnt, res;
-	void *addr;
+	void *ptr;
 	int part;
 
 	if (argc != 6) {
@@ -33,7 +33,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (part < 0)
 		return 1;
 
-	addr = map_sysmem(hextoul(argv[3], NULL), 0);
+	ptr = map_sysmem(hextoul(argv[3], NULL), 0);
 	blk = hextoul(argv[4], NULL);
 	cnt = hextoul(argv[5], NULL);
 
@@ -48,13 +48,15 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	if (cnt + blk > limit) {
 		printf("%s out of range\n", cmdtp->name);
+		unmap_sysmem(ptr);
 		return 1;
 	}
 
 	if (IS_ENABLED(CONFIG_CMD_WRITE) && !strcmp(cmdtp->name, "write"))
-		res = blk_dwrite(dev_desc, offset + blk, cnt, addr);
+		res = blk_dwrite(dev_desc, offset + blk, cnt, ptr);
 	else
-		res = blk_dread(dev_desc, offset + blk, cnt, addr);
+		res = blk_dread(dev_desc, offset + blk, cnt, ptr);
+	unmap_sysmem(ptr);
 
 	if (res != cnt) {
 		printf("%s error\n", cmdtp->name);
-- 
2.34.1

