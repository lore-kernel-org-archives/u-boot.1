Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B86BC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1D580805;
	Wed, 15 Jan 2025 14:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XMVMC1Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C1B80040; Wed, 15 Jan 2025 14:31:37 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3002807DD
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso528258639f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947894; x=1737552694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFzVl4TzMDIA/6OxsjB008bEA/i0PHWQ1CcpTSIqVvQ=;
 b=XMVMC1Jl80UnlMyZk2NFZRpO707PlDhCmeebn0sOopkSfYx8L89+NO8qEtF+zofZbl
 VOumKY0OvHnpE82zb2W45CzVVKIKu+cgHVZVhFf5i+X33lzd9/pTTrut52nKCrrpt231
 lmWCxtqmObj9gmBjC6btRDLAVUARlt78vTe+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947894; x=1737552694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zFzVl4TzMDIA/6OxsjB008bEA/i0PHWQ1CcpTSIqVvQ=;
 b=eq/ESiOfbqoAeKy+DUlCS6FMTEhQvczfVGvxUlpT5ty8Xy6TqQopJQyRCXLraTNxtV
 DTji2Eg+NTe0Ect+81s7FBE1n8QkuHXp2J6U3vJBAGgjzHWbKsggA4WV/085An7VwVvS
 IYDz9KcnqmiM9rkRnlsEeeZs3qGidDsXcRiFGj8WnfhV3ouDY7i0lFjv73E35iMFpZCW
 8AQjjRNXTDk+rFam4KgeT2KL3KD4iTs/TCvbGzKRr5tvkPJeQggNZSiiUMptG/2T4sUW
 OT5AEgcIWYDh3TlrvGsz4j2FU4ESEcoDdYfKE0aW2PIgJ+rXtA8S3i3vniLc3DVlplJ8
 skiA==
X-Gm-Message-State: AOJu0YxknBCljn+uH36aNFCZRIi3IMUw6khG7Y+cdw5nf8qhMq3I2Wmy
 Y9scdE7TmCiB/dwmxVTzRNt58czNg89En/n15ATYui9yeUN57wyb1GH14e6ZwugsusviAMhd0Cs
 =
X-Gm-Gg: ASbGncuAm4Fq5OBGU6YuWzMayrjPShJUHZ9AHUmx+HEHB9m7ccZ3fZFJT31puLQMD+j
 UAxZgXWDuHZA1Ej2KKPiJ/7yUNPQ4xlHNR65vpINK8fFYTqwHFU2cdTLHQ6yr8+anapJlnloBB3
 YQO7771IAyoiK5CGNUgwgwG3Ur+sJ0l+cnIY9iXeesBeNuPB2sIfsf3PbqlVVbrtbdZssqpkbeU
 uUoK73etGNaoEOYmXkxY/mpoaShiEddC4c/MtPDIV/BJcZ5QTcw/GvNBss/fcCjze3Ys3l+EjAM
 UMJfmnzJ9tPOx9EkOA==
X-Google-Smtp-Source: AGHT+IEIUZ674q+DdTZD6nq7yr0NfMy/1RIW+AqQk6tRwkJoxGM8IAZnPwEYEuwF/hxNgL7YRfxfWQ==
X-Received: by 2002:a05:6602:3e8f:b0:849:c82e:c03a with SMTP id
 ca18e2360f4ac-84ce0163894mr2466844839f.10.1736947893973; 
 Wed, 15 Jan 2025 05:31:33 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/43] test: Update ut info to show suites
Date: Wed, 15 Jan 2025 06:30:38 -0700
Message-Id: <20250115133114.590375-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

It is helpful to see a list of available suites. At present this is
handled by the longhelp for the 'ut' command, but this is not in a
format which can be easily parsed by python tests.

Add a -s option to show this. At present it is not possible to show the
number of tests in each suite, but future work will address this. For
now, show a ?

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index d25c2c37e7a..b6ceeb94a30 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -151,9 +151,21 @@ static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
+	const char *flags;
+
 	printf("Test suites: %d\n", (int)ARRAY_SIZE(cmd_ut_sub));
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
+	flags = cmd_arg1(argc, argv);
+	if (flags && !strcmp("-s", flags)) {
+		int i;
+
+		puts("\nTests  Suite\n");
+		puts("-----  -----\n");
+		for (i = 1; i < ARRAY_SIZE(cmd_ut_sub); i++)
+			printf("%5s  %s\n", "?", cmd_ut_sub[i].name);
+	}
+
 	return 0;
 }
 
@@ -184,7 +196,7 @@ U_BOOT_LONGHELP(ut,
 	"\n"
 	"\nOptions for <suite>:"
 	"\nall - execute all enabled tests"
-	"\ninfo - show info about tests"
+	"\ninfo [-s] - show info about tests [and suites]"
 #ifdef CONFIG_CMD_ADDRMAP
 	"\naddrmap - very basic test of addrmap command"
 #endif
-- 
2.34.1

