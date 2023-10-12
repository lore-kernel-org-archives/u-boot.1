Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BE2CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D0C86B36;
	Thu, 12 Oct 2023 04:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CVfnY2eA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06EFB86E75; Thu, 12 Oct 2023 04:01:22 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6075C86E75
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59f6441215dso6141087b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075811; x=1697680611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfVfhB0gai03kpRDF6gwvv4XwBnKSad8IOk1Q5LlH08=;
 b=CVfnY2eA1Ces3OaAvcW4UEp9H19oHPx7gl+SWLCUc4xLK0kWojHoV3GohcR3e6gW2m
 l1YGhpt9uTNIp9fEIAXURpsVaUEd5kLzMRzUZGD47JCdPAXyEn6joqwJOZSLGWoIXHn4
 GhiG1VmUxgayvIc0BqZEw+eddcZ5tB0Fw45RIkjcHsuvNZrCDZb1jZ9WKNofmPJdvPdz
 bxpZETlyG9bRaLItwBei444u7G3QZhXgn2pN2iceY5nC5y69jD0J6dQRFg6Ve7qH+p6l
 Rgwd11KCtyTYmi9xcldkuYncVId6gccRwKR+R5zzzKanf+VeLaGGA1dI3z6O7vfMxzLL
 EqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075811; x=1697680611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfVfhB0gai03kpRDF6gwvv4XwBnKSad8IOk1Q5LlH08=;
 b=O/sNaGZNHSzeqvxX3cFOutnc5HUNB4cf88ucY31i1+vMGSeQ/Fs6MjvAkekfIvNWId
 DZ4cFrp4NdMtUn4yBAb2al3HC3XLab3qhobi5dD0RFqufpgF8zhx7ILCD2bi1mnrTpkh
 wJGkKIecG1I+M4vzJodHgLR6sRRYqU/FFR1vmqq1TOCl5N5Y06ryzhsFmSFQmnx8HI9R
 Jc0r4ZxnUooBYI3+2cvXApdTDJSw6EWNrGBs9V28Rul5UA2Uo3oHo11cQjBnMoubpc4w
 781NlmA+1g1kU/qc/sb/lnbKy8rpUh74cfbwF/xzZHcF9M7Bpx6dT9saaSZUynVfaQVO
 +XjA==
X-Gm-Message-State: AOJu0YztW0ZcE2vjqY89l1DZp0ssk8SCXZ9mc7g9Zim05r73zEwVCJlT
 x46E56Y5FFSaLPD9LUhMuj6+Li962Lp1ow==
X-Google-Smtp-Source: AGHT+IGvw6F0Uh7OWsSK9ccdGA4Ovj+Pd3R/oriBARWjMKHnxyfavuU2EBnHAUXe6IaAPVXfU8qiSw==
X-Received: by 2002:a81:7103:0:b0:59b:586c:c65e with SMTP id
 m3-20020a817103000000b0059b586cc65emr27216847ywc.36.1697075810897; 
 Wed, 11 Oct 2023 18:56:50 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 os22-20020a05620a811600b007757acf488esm5665768qkn.39.2023.10.11.18.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:50 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 19/26] test: spl: Fix spl_test_load not failing if fname
 doesn't exist
Date: Wed, 11 Oct 2023 21:56:19 -0400
Message-Id: <20231012015626.3487451-20-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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
---

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
index 06daa3700b8..500867ffd49 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -59,10 +59,8 @@ static int spl_test_load(struct unit_test_state *uts)
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

