Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D1ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE8B86FC9;
	Sun, 15 Oct 2023 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hKg4Z7yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9619C86F1B; Sun, 15 Oct 2023 09:18:42 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B77586F48
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-57e40f0189aso1874868eaf.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354245; x=1697959045; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79pmNXlDoY3NqbeFiTsvRhGUkUfUICrol5oQC+/XKBc=;
 b=hKg4Z7yyHB0AflTxgdZnZRhogruDwq68vd4DlcejJ8vQC1HupIqCcnQBWEip/DaG7o
 dik1xq5hRbQgSGWcFVUcxj7DY67qlz2LjsKQVi4z2fKZM2EUeDOnJg2T9Wiz5qqXtqOQ
 pyJigrfSPzjctIfFVM/PTHw6oQfpfhh7hqJD8lVcNIzvSxSZBrIsnWZQOoFci4Wcbc9c
 wOF3haKWL+JsDED/xRK3r3GsNPoMwpy/JWD794DmzpettiFSlVc9ImcWMySGTWyNyiq4
 UZ0SzbOwS634AZyyH7qvkdeNGdhhAjfH6o/gGV77YiTcfYm81uRf6FC9kx2qbHIwVtbL
 4zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354245; x=1697959045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79pmNXlDoY3NqbeFiTsvRhGUkUfUICrol5oQC+/XKBc=;
 b=CliuikoM0qwhLzMCyp73q0McIwBjVfA8fjJxbFxUqp6uRh8Qk0V14jhms4wjwG1Zje
 NmFjgBm9BQ++3c61tvc1SiHY26PUd0RnWQYVcsXSvBQ0LOxn2ZJAlTbI/siAAlX/XO17
 cjq91zqjd1P3FiOvZPG7c5wrWT5rmdaXlfmGOxqDRNJ5McWVabC3ujjjGP3h7a6Qnz8g
 42a+2+W8wE7XqlRYY5OdP3WdeMUna9mKIhvI5rPbyMpTD+FYXIaTqn3ZYmeOE5aPmsha
 an2PsZOa0482X936Pc+zoLZHW1WVhmgqE/fCkkRd22OBjXVDQZb7Tm5dlgNPaYlUkJwj
 AxPg==
X-Gm-Message-State: AOJu0Yy3AOr+fdkyKBZe8vGmhsNU0UzseOqcS1f4h7ncKCIVpY0e3zqM
 YVhSELjKYTLu2V/6osN0wXrJwCG1+P80UQ==
X-Google-Smtp-Source: AGHT+IHxqad9V63W99XPJMRL+8pbyPP4dchYCHIrG0Dg4OW9+g7L9Yq89J193w7BAFKQApAls9Kt7A==
X-Received: by 2002:a05:6214:c81:b0:66d:1112:e870 with SMTP id
 r1-20020a0562140c8100b0066d1112e870mr11112807qvr.22.1697316512413; 
 Sat, 14 Oct 2023 13:48:32 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 cz29-20020a05620a36dd00b0077263636a95sm1723937qkb.93.2023.10.14.13.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:32 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 22/29] test: spl: Fix spl_test_load not failing if fname
 doesn't exist
Date: Sat, 14 Oct 2023 16:47:58 -0400
Message-Id: <20231014204805.439009-23-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Returning a negative value from a unit test doesn't automatically fail the
test.  We have to fail an assertion. Modify the test to do so.

This now causes the test to count as a failure on VPL. This is because the
fname of SPL (and U-Boot) is generated with make_exec in os_jump_to_image.
The original name of SPL is gone, and we can't determine the name of U-Boot
from the generated name.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/sandbox_vpl_defconfig | 1 +
 test/image/spl_load_os.c      | 6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 8d76f19729b..5bd0281796d 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -262,3 +262,4 @@ CONFIG_UNIT_TEST=y
 CONFIG_SPL_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+# CONFIG_SPL_UT_LOAD_OS is not set
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index bf374f2164d..3b2967d017a 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -58,10 +58,8 @@ static int spl_test_load(struct unit_test_state *uts)
 	load.read = read_fit_image;
 
 	ret = sandbox_find_next_phase(fname, sizeof(fname), true);
-	if (ret) {
-		printf("(%s not found, error %d)\n", fname, ret);
-		return ret;
-	}
+	if (ret)
+		ut_assertf(0, "%s not found, error %d\n", fname, ret);
 	load.filename = fname;
 
 	header = spl_get_load_buffer(-sizeof(*header), sizeof(*header));
-- 
2.37.1

