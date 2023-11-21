Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439D1C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E2A864F3;
	Tue, 21 Nov 2023 02:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y9SNJgPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D23787574; Tue, 21 Nov 2023 02:31:38 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E17C87584
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc4d306fe9so11476775ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530258; x=1701135058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCUBljU3l7bLi+2Mof6yKcdAJGAgEsp6V13IE4RoUsg=;
 b=y9SNJgPC+M9K6B2UYWY5lHfmp20BaZM3ZvbgimLVi9qiPmHK0+vJIUR4cL0pf54iiI
 t4wlWoXq/dpIqsGh5Hy40e/gaF9naTePUms9RMeRKaik7xymarbeOJgOM76ualylZoaz
 nhZpxOroPfx8EHIBzkqS2zgB8Qj0sudacIGWlJLaAy3ZDahFbuz6qNpo1FyvZdbMRqm+
 1K7P+2jLHhJ5Lku2gA3izG0nlhASE5o1dAtcqNqg4MdcNDhTf6Z0QgfsfeQDhkCP8NFY
 sL2jXx5Wu8ouYqR6zQ/GLYOe8wk77cuplgPC+nwRtAT2mFPBzW7CWoptH9UjaS3jd1EB
 J4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530258; x=1701135058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCUBljU3l7bLi+2Mof6yKcdAJGAgEsp6V13IE4RoUsg=;
 b=Lcpb/FBTeujP6yPbjHY+WdBel2lys08SPflMJD74AuySeo6KoeHA4mTKsfVd8RXPez
 4WP7Y+1qx6DHt0XtbQI1LY7/rFv9OUS7U4Qgkv47eAJmDAZ6nrbfl1e9uwW/NF404Ryd
 rqCfElN9yvVhsiQf334yjRKMfDp7x0EFNywj764vsTNjMvi/aYHqbeXiibAuU8BwKnfU
 gH61495dp5EbWSaOAtmO+HOutUnJLPNT1358NoJkaIHVES+bFyukhedF1Akj3LvZYXHB
 3JPWXuXy5NqBTyNPkwJ5YwydXKx96dhHdhQVw30W7oVm5n2zFSxEfqRt9TQ5f/GEe8Ho
 WVNQ==
X-Gm-Message-State: AOJu0YwtUfP6BYjgzC8K2T6Iafy5ndqLMwoYvnfinUMIk4wqJOkX4utg
 hXbx1iNs+jxPP6mpNqSXs7M3xA==
X-Google-Smtp-Source: AGHT+IEu1OqsYQ3vzftNX8ivwdkD88eJJHoEU2Pa8MMDtWXX9tcIXnStmQDf9Kv7+QSDGmcR4GqXzQ==
X-Received: by 2002:a17:903:2448:b0:1ce:ca8:74d5 with SMTP id
 l8-20020a170903244800b001ce0ca874d5mr11947114pls.1.1700530257769; 
 Mon, 20 Nov 2023 17:30:57 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:57 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 12/12] fs: remove explicit efi configuration dependency
Date: Tue, 21 Nov 2023 10:29:50 +0900
Message-Id: <20231121012950.156539-13-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 fs/fs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 4cb4310c9cc2..70cdb594c4c8 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 		return 1;
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
-				len_read);
+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
+			(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
+			len_read);
 
 	printf("%llu bytes read in %lu ms", len_read, time);
 	if (time > 0) {
-- 
2.34.1

