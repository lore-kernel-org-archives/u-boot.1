Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC1C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B91187005;
	Mon,  6 Nov 2023 03:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AFv8IhwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B9E8700F; Mon,  6 Nov 2023 03:26:35 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E8786F56
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-66d87554434so28945846d6.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237570; x=1699842370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2EmK/sStAyRd/ShAnl1bI9L5XvJnJQeGhXL4qU4nvo=;
 b=AFv8IhwNedNdfHD/5rHu4PkHfxx1fW1kbYCIh3rMSSFVus3k6rIW2/epTxrUh7O/7W
 nOtzkHH+Y6R7WfqskmLO0qRmdST05AaVaxbZWXMYtKVR98U6s/RbAAxcbi87cQJvGw0V
 aKMDJtedZ6JeuYH3nwMyF4j+r6Oihik47YB1s/a2WpEjENBxgJE9c89bTVgG1OsbckrQ
 l6E8kt2M90wvSkOkJPHRjrSFDAYu1SHn2t7fmUywHbBgnrxHsymL5SaF4zwDG6r6lZof
 aqrthngeThE1J9OE6DmuctnkAm7BT4rrxkeu+zdfp/c2nYrcfBDm6KPN0jE/1vq6Fx1b
 hwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237570; x=1699842370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2EmK/sStAyRd/ShAnl1bI9L5XvJnJQeGhXL4qU4nvo=;
 b=nlSxTQGTJ5ob3sIjzsK6P/WkHyNJWKQi/kmzviZR0aMBwK5vWd7LQFqYN26GmGezX7
 GYvZwirdpVuGJ5zZbnHyRLopo1unBxriJNEeW2+phRhi5nG3oQoOmeU+zDWRNth/mksQ
 8W9aVAN/eGQdgKijMQkVIH/do0ia5Q8TZWfiC270ytIxMF8JXAxhuVZLw5dStFw3Nzso
 ml2zOenEfTR8JyqljBg7ZtYxwZbPoHMQrUux9mFhp2RgbZqwKxWAxC4Mb2RmnIJ1GfF9
 koQiNmUREMAq2pfwSxqNlrgkpJCEJTVoTIPUh7F8hu96qXwE1cX3b4qmEtCo39v5gdB6
 NURA==
X-Gm-Message-State: AOJu0Ywmb2A71WcY4vZeCksaVobHpkkxGzMFUvMVVuWi4knXbjvKnsRX
 FlJD0kYu8/pkM/gBfbqcPxo=
X-Google-Smtp-Source: AGHT+IG7f+6CLKG+gQc3k3Ilq2vWftQ6MAEnhdqj3zffug8w7BG+WM9p2kvU92qYZ9ow6x+NZXoBNQ==
X-Received: by 2002:a05:6214:d8a:b0:671:e02a:8bf6 with SMTP id
 e10-20020a0562140d8a00b00671e02a8bf6mr27646766qve.34.1699237569860; 
 Sun, 05 Nov 2023 18:26:09 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 y4-20020ad445a4000000b0065b17ec4b49sm3048167qvu.46.2023.11.05.18.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:09 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 03/25] spl: Make SHOW_ERRORS depend on LIBCOMMON
Date: Sun,  5 Nov 2023 21:25:41 -0500
Message-Id: <20231106022603.3405551-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

The purpose of SHOW_ERRORS is to print extra information. Make it depend
on LIBCOMMON to avoid having to check for two configs.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v5)

Changes in v5:
- New

 common/spl/Kconfig | 1 +
 common/spl/spl.c   | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 00332cf243a..e929f1bbae1 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -183,6 +183,7 @@ config SPL_SYS_REPORT_STACK_F_USAGE
 
 config SPL_SHOW_ERRORS
 	bool "Show more information when something goes wrong"
+	depends on SPL_LIBCOMMON_SUPPORT
 	help
 	  This enabled more verbose error messages and checking when something
 	  goes wrong in SPL. For example, it shows the error code when U-Boot
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 732d90d39e6..7ce38ce46d4 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -718,8 +718,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	ret = boot_from_devices(&spl_image, spl_boot_list,
 				ARRAY_SIZE(spl_boot_list));
 	if (ret) {
-		if (CONFIG_IS_ENABLED(SHOW_ERRORS) &&
-		    CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT))
+		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			printf(SPL_TPL_PROMPT "failed to boot from all boot devices (err=%d)\n",
 			       ret);
 		else
-- 
2.37.1

