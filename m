Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CE9C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC4E806DC;
	Mon, 20 Jan 2025 22:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XEYCkXQ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 903B5809A8; Mon, 20 Jan 2025 22:27:12 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C778077F
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ce88909991so17073005ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408428; x=1738013228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1CJDpvwPXyKQYKJS5gPK94DWB9rkrc1s+2BJq7wng60=;
 b=XEYCkXQ1XA0jXlv2xzsQF+1qTJHp2DHQYxWCsXwv9U8Jr5RlP4oDUOOseeP6s3gZwK
 vepePJTIhE2Qx259or8zr0NvMlb7uCIpgw0Lmf7NvNkGNf0KD2MGmd8GDIYuorF3wPEK
 h/tSujGk/0LBiQuqsOaUsZAm6G6e6YJmsrrG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408428; x=1738013228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1CJDpvwPXyKQYKJS5gPK94DWB9rkrc1s+2BJq7wng60=;
 b=BPjbAjE4s1bua/8fTyaJOID2oRISOikgtbDuSa7ae0mxOgDPn3I+2OOIkvxiVWH9Hh
 lCNUrvOSPKGiFqc6Ilu1DHCQw42whXx7VNbx23RQw8rfbDZYEpUpDa4k5T3EyjVF/N7L
 DrmzeUscEUhQv/8LvB3Vgn2mtBb1nNh6iLAWOcstfJCqJJu1/q1k2VdQeVhv/lKApJDx
 wubSH/n0D8baa3CZKgQ+y9l7P5KIOFZXTiC+xb6kOOEdPQ4AigR5ZpehwnCa2EWDaYo1
 GfkVViYabt8Tkbx571x/HMc0zG/c8X6kqyM2cswdeoL3QHtjlk0mZpWdaYdfOQO+TYmM
 efsQ==
X-Gm-Message-State: AOJu0Yz1SfnabuS1MThajYnO12H+jRQ7vTRpfRALJqji1fN9v36MXQYI
 /K3C1VxRIgqUfUFgyIMMpgvdMfFsh0S5CrN/txD4D/j8eduqfzgu06qaHNFlthytyyd7NCuCZUs
 =
X-Gm-Gg: ASbGncsYJTuGuyQ/7Xk27bb9EMQZ4fn24EUhZFKU2FAk15i+FP7XRkxUei6JiN91OsF
 w5ubawDccrjEKo6KoeFdljTMZwYXp9108vRqa2NFPwT5lLyMrDgEA2CbIsUK5PJ3Z2EbXbsS66B
 iiC5iBBPyZhTLsV1PT4UJg3I7JUAtLmo0jht4ZW1Ydvbt2Obb6EE0mQeAZrx3lQGlIpXBcM5i2z
 xQvogdIiZ6v/ViRRWlymsVKCJwp7hKTzUl6rGzr+fT7fK9wmeDhed9KmhuzAySnCYBcbDLrrlq0
 w0wJ3iyjpekiz0bQrl6xGcaEwxGL6NA=
X-Google-Smtp-Source: AGHT+IEaHmd61vQSpDbD+VPB7ShdDaAyQmWRQ5KyGrDHqUe6PT6dqIytfMitDeiu40NGSsoP7pFVuQ==
X-Received: by 2002:a05:6e02:6cf:b0:3ce:7c7d:37b3 with SMTP id
 e9e14a558f8ab-3ce84a62d72mr167474285ab.9.1737408428120; 
 Mon, 20 Jan 2025 13:27:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 22/44] test: Drop the function for running mbr tests
Date: Mon, 20 Jan 2025 14:25:44 -0700
Message-ID: <20250120212613.516664-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 1 -
 test/cmd/mbr.c        | 8 --------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 72f98eb3558..612167fe053 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -39,7 +39,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_measurement(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 int do_ut_mem(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index ad859921ce5..45bab04923a 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -471,11 +471,3 @@ static int mbr_test_run(struct unit_test_state *uts)
 
 /* Declare mbr test */
 UNIT_TEST(mbr_test_run, UTF_CONSOLE, mbr);
-
-int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(mbr);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(mbr);
-
-	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index a196702dd17..1a69b1c215b 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -159,7 +159,7 @@ static struct suite suites[] = {
 #endif
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_MBR) && defined(CONFIG_CMD_MMC) \
         && defined(CONFIG_MMC_SANDBOX) && defined(CONFIG_MMC_WRITE)
-	SUITE_CMD(mbr, do_ut_mbr),
+	SUITE(mbr),
 #endif
 	SUITE_CMD(mem, do_ut_mem),
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_CMD_SETEXPR)
-- 
2.43.0

