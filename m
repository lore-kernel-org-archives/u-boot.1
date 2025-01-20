Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42953C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A8380820;
	Mon, 20 Jan 2025 22:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BhFrOTdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D0F80A0A; Mon, 20 Jan 2025 22:27:29 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E5578083F
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so17513415ab.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408445; x=1738013245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmCCr1sb/OshWk1E6Z0dTtGPKxPqgSO3GWN3mejkVbo=;
 b=BhFrOTdDqNW9s6wndnS/2imy+X+c7sS4LVYaQ/HbxXk8ve4OvFqhsygiy3vFFxMjSb
 RIP5pP+fJQ/wJpq2YyH7hJ2t2thM4MH6TFATeLMsFdcKB/UPW+86QD3B9UFUwNnh4WMD
 U8e3N5Fc/5GXzzhqyY5kifPkzyWWMI4w/8sdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408445; x=1738013245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmCCr1sb/OshWk1E6Z0dTtGPKxPqgSO3GWN3mejkVbo=;
 b=l62NRij8X30yjYYgdGf1t0VPMP88PVhjsNN1qkLhPY/M8X6PAZA7flrIahPzg4rz7x
 zIMlIj7mclsoAG+L+apIyYn1GRjLf18V49J41pzKOUJBCsJNXSXc0T8ydPHTT/dG+gZa
 e+vChajtkObvAfhRbRMuRodXH1X0uVnTiixqhMgWCyyP29F6nd//lN/qFBUFv8pWBym5
 K9MgcbBeqHKJ9MFjCrEmKX97pPT9SnW5mlaaMgCLzwTNtE/nOBQEyOdZWRc94bPO3kV9
 BRg+5JzXHRBR48/saOTihANB4vMaWw8tP2cHF7cNxqSy6tCnUASSJbq3A6kfDIcCPSAD
 VhXA==
X-Gm-Message-State: AOJu0YxNVHotI4eyoO8GWmhfGj9Ll7UnYHlhVQJguEVWnMBLHwjC0Fka
 cjqZIKHRJNQI7tFyONhJi9MTDxlZX4LNNRF3mt7bXwR3HnviqjoNxpsp8MUjFaeDisWZi513qCQ
 =
X-Gm-Gg: ASbGncuaV+61v1Vv1l3Vj35lhV8KROmbrvVCuambFybKRNecZ1Hso1WguBLDXNk9EVR
 2uF1JKKzY5WEplCnIvZQfniK3U7IdrOP5n5lvW+/0fMexrRni3NUrvVbwx8jqAgZfyqAPcMq7kz
 e6f+erQfMX/D0QURMm+VW1KWIbntYMtAZgUcgtIv7IhSP5KUP95rw8C3bPnVjNv2y7BXWbpboqY
 TtQNc1ZmbrZvdDluXQIJq1kjqKGyjy97WiHjbji6cIspHAPICRoSpPbf8J/4hr1DloFqDZlHiff
 1uBkZIBdNz27rV+5fI6CXvsCmgG9cE0=
X-Google-Smtp-Source: AGHT+IGbeSYtWHUDfh5tDsyUNQVtEQoJPX44NXxRHNIIzpmEX1Pi0ZgzUfgaH6/qpzObI/GCQ9Z+Zw==
X-Received: by 2002:a05:6e02:1fc4:b0:3ce:5af3:783e with SMTP id
 e9e14a558f8ab-3cf743fdf68mr118436795ab.7.1737408445325; 
 Mon, 20 Jan 2025 13:27:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 31/44] test: Drop the function for running pci_mps tests
Date: Mon, 20 Jan 2025 14:25:53 -0700
Message-ID: <20250120212613.516664-32-sjg@chromium.org>
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

 include/test/suites.h |  2 --
 test/cmd/pci_mps.c    | 10 ----------
 test/cmd_ut.c         |  2 +-
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index f6b33da5a28..49c18ebf456 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -35,8 +35,6 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
diff --git a/test/cmd/pci_mps.c b/test/cmd/pci_mps.c
index 2595ea103ff..8b3ea4a6134 100644
--- a/test/cmd/pci_mps.c
+++ b/test/cmd/pci_mps.c
@@ -28,13 +28,3 @@ static int test_pci_mps_safe(struct unit_test_state *uts)
 	return 0;
 }
 PCI_MPS_TEST(test_pci_mps_safe, UTF_CONSOLE);
-
-int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char * const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(pci_mps);
-	const int n = UNIT_TEST_SUITE_COUNT(pci_mps);
-
-	return cmd_ut_category("pci_mps", "pci_mps_test_", tests, n,
-			       argc, argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 3620be62ce6..080a36a909c 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -184,7 +184,7 @@ static struct suite suites[] = {
 	SUITE(loadm),
 #endif
 #ifdef CONFIG_CMD_PCI_MPS
-	SUITE_CMD(pci_mps, do_ut_pci_mps),
+	SUITE(pci_mps),
 #endif
 #ifdef CONFIG_CMD_SEAMA
 	SUITE_CMD(seama, do_ut_seama),
-- 
2.43.0

