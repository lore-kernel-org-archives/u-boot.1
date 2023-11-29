Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30479C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9326C8761C;
	Wed, 29 Nov 2023 18:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jxosDOV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1847F8761C; Wed, 29 Nov 2023 18:31:29 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E959F8701C
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7b06844971dso225130339f.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701279085; x=1701883885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6bTNwdhL8ogtWsta9sYOQ+1amhuVaoDPiVWJ+dmZhD0=;
 b=jxosDOV94m/k/hb0ZsGxmQEawaArn4Pghyjk4Klxvu7DFJwTGxToYUDf3vzy6ztx7Q
 5/1f9dCbtOASs6A/icxGhPpOq3Bz+n/El05hbUNSRk9hKK36UjZNZehM3IgAXSRwJLvI
 oHPBOGCKR/EZt4XlaVrZkLmsXWhQ4pDDjL0Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701279085; x=1701883885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bTNwdhL8ogtWsta9sYOQ+1amhuVaoDPiVWJ+dmZhD0=;
 b=eRlvzcav8xwpBTA1s21D8OWPK7FjP4iZlJkWtL8see/EY4ZiTAoyAYtW6p4PPpRrNW
 vSdjpsO2p0RFFb4NdQHtWS83RzP0QBt0mGjQTO2MzTyGhEub80vGoLDXb8VsaGIlgKyL
 g4KTUXh8Cu1Gi0QwcZrmoWP6wMRy0wF7bMAn259Rfykm9GAiEK+4fHwztY1r6SGtNz1Z
 aK5aDFzJU+M5H8xrjQGzHUeL2ivqn7wW6xsdRy50FtYiPnHi//nbH1oZlkrEjccve/VN
 orrCJWOT0sn6bPlkuXg4ieCiCNGNlcSyCiG/rr/1t/lM/SlBy6ZwTXN3WFGQKVmLFI90
 l94g==
X-Gm-Message-State: AOJu0YzqP2EsM3wPlwP6iRf7ejW1rKbAE6EelT1SOZk92u/taWvOVRNJ
 Z3Uf9puMxtHSLoUEQQVC75QuyTAn12V3872PGUk=
X-Google-Smtp-Source: AGHT+IFrDvMJl/Nq6hiQ2YC6La0Qk8mtxWSRr7JWffWQ+hygKY+FqbYVFjTPv2c5e/qaBpfDJ02oYw==
X-Received: by 2002:a6b:d808:0:b0:7b3:98ed:b884 with SMTP id
 y8-20020a6bd808000000b007b398edb884mr12831022iob.2.1701279085439; 
 Wed, 29 Nov 2023 09:31:25 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:f4fd:5056:45a8:b749])
 by smtp.gmail.com with ESMTPSA id
 ei18-20020a05663829b200b0045a1063713asm3475486jab.130.2023.11.29.09.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:31:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootflow: Allow setting a cmdline arg with no value
Date: Wed, 29 Nov 2023 10:31:19 -0700
Message-ID: <20231129103119.1.I183c8602567828319b4677b66c6e67151dc97773@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

This is supposed to be supported by the 'bootflow cmd' command, at
least according to the help. There is a 'bootflow cmd clear' but it is
often more intuitive to use 'bootcmd cmd set' with an empty value.

Update the command to pass BOOTFLOWCL_EMPTY in this case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/bootflow.c       | 4 ++--
 test/boot/bootflow.c | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 3aeb40d690f..c6aa06b9ce9 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -524,9 +524,9 @@ static int do_bootflow_cmdline(struct cmd_tbl *cmdtp, int flag, int argc,
 	op = argv[1];
 	arg = argv[2];
 	if (*op == 's') {
-		if (argc < 4)
+		if (argc < 3)
 			return CMD_RET_USAGE;
-		val = argv[3];
+		val = argv[3] ?: (const char *)BOOTFLOWCL_EMPTY;
 	}
 
 	switch (*op) {
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index b97c566f000..43cba3cc783 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1013,6 +1013,10 @@ static int bootflow_cmdline(struct unit_test_state *uts)
 	ut_asserteq(0, run_command("bootflow cmdline get mary", 0));
 	ut_assert_nextline_empty();
 
+	ut_asserteq(0, run_command("bootflow cmdline set mary abc", 0));
+	ut_asserteq(0, run_command("bootflow cmdline set mary", 0));
+	ut_assert_nextline_empty();
+
 	ut_assert_console_end();
 
 	return 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog

