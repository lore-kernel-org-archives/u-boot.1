Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A53C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C479876C3;
	Wed,  8 Nov 2023 17:49:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NpIlPXl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63FCB875F3; Wed,  8 Nov 2023 17:49:08 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46826871A2
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7788f513872so454952185a.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462145; x=1700066945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IZa+E6XnMsce4VW6tpuXKynbvhTxY0ngBp61aIS5Os=;
 b=NpIlPXl4I0Fz8ii7oWAC1N+Te409DbfQNDRnNVkBa7iL/HY+43GuajkvaEZ/C2BAQ/
 gM61hZxlgdg/21SvJWvWT5dHxtqvv2lYZYlNcIJgLy8W4Op7uP621LLlWDWvX1luQSco
 DqA78cAcWoMQZL19Y/XhVQ0MIXS2gKKNvEYURJY6bHUmufAqbBup2LfpF/ZNg2Qghl4r
 +jg5qxK3df+6Zn4IHtdvn3icyXiyAyNoUx1i6Hml8cbzEqu+mYbHkEeCLvrJolcUcU14
 U5Q8LwS8ij0h/8r7cuinJJIki/a/6aCRvmuyZ63EKGDzoQ/VIgtz8IT3BNQH7WodOXK3
 sxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462145; x=1700066945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IZa+E6XnMsce4VW6tpuXKynbvhTxY0ngBp61aIS5Os=;
 b=cJH/4sN+CRRiMvw+MjEWiVzUoF4W5ku/xyz8VBJhR+xBUfWCpD+h4Slfgpdeb+vYc6
 0SpbQuP668G9w7l/dLm86ZDcHNS6m4QJrxNUlZcJhcwqxV8UbtUhKNVvF0Tu7FeYaGPq
 v5S7SGSvln6U2/KjBnBvlZWayDQHnpW0Fw7J3T+sq7HOkHGvjBt5DiNtLgexXkPOSutP
 MaTSXNWIb4N0IEZy2mkQAHYIZoXspfNHcz/Mx7Bro4HtDJKGqM/6S+CTBDdSPUvmPje+
 OLb2BcN1fRor3evzcokPXv6v/Wky0LjcBzUOgscBg8LmuuCe8y+sC9ktPxrNqh39/bHi
 zXfg==
X-Gm-Message-State: AOJu0YyHMWdpld9to6Dsq72IE4aIOVhTjsuHdQTqZkJNU2Tjay6WybxW
 qFoPG6X4XSf56d62/rnxz04=
X-Google-Smtp-Source: AGHT+IGfNjnKQLtj3s3109pgN0CZ08CshZaAVxJwz8n7WfvbkKfaITKrxdCC+XpCGsSYg4hT5QKk2w==
X-Received: by 2002:a05:620a:2445:b0:773:b50f:c6f3 with SMTP id
 h5-20020a05620a244500b00773b50fc6f3mr2136507qkn.52.1699462145065; 
 Wed, 08 Nov 2023 08:49:05 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 e26-20020a37ac1a000000b00767e98535b7sm1224609qkm.67.2023.11.08.08.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:04 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 03/26] spl: Make SHOW_ERRORS depend on LIBCOMMON
Date: Wed,  8 Nov 2023 11:48:35 -0500
Message-Id: <20231108164858.3497420-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

