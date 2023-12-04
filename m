Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA1BC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54EFA8761C;
	Mon,  4 Dec 2023 01:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jyXFebfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8500A875F5; Mon,  4 Dec 2023 01:27:07 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7347787499
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35d67599613so9993815ab.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649624; x=1702254424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fDo6z31sJX+v7DwuT9LBCy7LXin1aNP5NRQz8CR/wU=;
 b=jyXFebfcAgc/63COgqzEgiq55X00j6pGSVsPPh0VS9wCwcylMJ3vyFFb4FD0M4RUsL
 r6W/vfn3W4qYZtll3/OS/tvK6mbHHDbALsY7tNz7JfvVe2mFe04DsJbu/rlDKYmJFnj2
 Nxsx9U7N8ZBldSKRMhNtOg+5BMOHcmKFbvwBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649624; x=1702254424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fDo6z31sJX+v7DwuT9LBCy7LXin1aNP5NRQz8CR/wU=;
 b=W9glx12J0Plqw9kXXpOqYwc2B+SEAs7pB+m9wW4ch6ID0UInCMkF+y9SUWgmJKYra/
 Hgwr2vdR4E49pi6dTUFsBSfP5U0SCC2kwNS774b4oEVm5Wo9WJhkmO8vevJV2JPRhJhF
 /86XFvjg/chyvNKZIMNgcIXoMdVSaLe1Rsxb3GT2eN1YpZbZtxND6dYznpg9+3SWsbs1
 RiBm8xZmN8LJZuLFJEmmgPVr/dsoUBnzOB5x6jHG2An7bbz1xGdxOcOFcLaEMR2f15JB
 LOU3ILJsBRyLSg8iavAgfyjAIEAF/y2uJGkV1hLW0AVle3Yogto4Mc+r/xynZGzHRZoa
 sf3g==
X-Gm-Message-State: AOJu0YxjvGq02Wa3M6HLIU/a/CXDPJQGsGCyFX3chivpzCoZ7dMmsLES
 ZM0nrlVawRVv1VIqW44Mh75BZYv4DNEbWqQkzJJaTA==
X-Google-Smtp-Source: AGHT+IFpn0SdHmWNtFTDL87xhqVWoBvgUjmitnq0RjPgdjRMtwuFWky8uakD3NNKkLv0A8B0lfRtog==
X-Received: by 2002:a92:d7c8:0:b0:35d:59a2:2b7 with SMTP id
 g8-20020a92d7c8000000b0035d59a202b7mr4683128ilq.87.1701649623986; 
 Sun, 03 Dec 2023 16:27:03 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 01/18] bootm: netbds: Drop passing of arguments
Date: Sun,  3 Dec 2023 17:26:17 -0700
Message-ID: <20231204002642.895926-2-sjg@chromium.org>
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

It isn't clear how useful it is to pass the arguments of bootm to the
OS. For example, if "bootm 1000 2000 3000" is used, the three arguments
at the end are passed to the OS. This seems like a strange approach,
since the argument have already been parsed by U-Boot and processed.

Rely instead on the "bootargs" mechanism, which is the standard
approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm_os.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index b92422171a84..b5055d78706c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -102,19 +102,9 @@ static int do_bootm_netbsd(int flag, int argc, char *const argv[],
 			os_hdr = hdr;
 	}
 
-	if (argc > 0) {
-		ulong len;
-		int   i;
-
-		for (i = 0, len = 0; i < argc; i += 1)
-			len += strlen(argv[i]) + 1;
-		cmdline = malloc(len);
-		copy_args(cmdline, argc, argv, ' ');
-	} else {
-		cmdline = env_get("bootargs");
-		if (cmdline == NULL)
-			cmdline = "";
-	}
+	cmdline = env_get("bootargs");
+	if (!cmdline)
+		cmdline = "";
 
 	loader = (void (*)(struct bd_info *, struct legacy_img_hdr *, char *, char *))images->ep;
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

