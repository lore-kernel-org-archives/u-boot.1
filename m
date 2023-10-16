Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A712DCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66EA86F5A;
	Tue, 17 Oct 2023 00:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KKHuW11K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DF186F14; Tue, 17 Oct 2023 00:31:50 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5A186DE6
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7757523362fso344391985a.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495472; x=1698100272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXuEtpiYScKBDDnXyeUszWjTgOFImJd2OlkYxQSxsrs=;
 b=KKHuW11KMSr55sw8BfhL4IiOrVuQsUHPNcTLC+g9dJF9UwhN5kwKtDWGOMmvu32FKw
 sWD8OWx3n11pxBpjKOPCm65yqg5r9kb2AK6DwOQx/YjK6flZBuU3fmP/tG6tag1Qszwl
 SWKMSoVdoUGvxy9AGuKkqLNDZX1In4c6Q80ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495472; x=1698100272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QXuEtpiYScKBDDnXyeUszWjTgOFImJd2OlkYxQSxsrs=;
 b=Eb8REgXUFfBA0PZw0i/s+mhYw9yvv3yed0E5KSXISCqjZNg8CNdA2X+x6AbGSUy/80
 rqagCkq6OQ5e4mkebw1x0nhTDPXP6j9F3pchstN3FueQL9Dq05xE1gvbwN2TZ6tlkzUI
 /48tKWhlMtag5lLGl3KY/+LDWRgPFz9aIFGREFG4nR9zgNCUK2ELP2N5yIh7DXOz0CTP
 MjBP3znCHiNBYXyPd0hpwTXlsf+b49OrKlO6V+jCLfu4KToJxDKlldBgt+rwH95hze07
 PVDlGCSETc+rKIPkgThYzUcBD8RTeF/sJ2DJP+txuIcB831Tb78cI7Rg8Osse7UJlcpY
 ocZg==
X-Gm-Message-State: AOJu0YyyL4BCA9dbIBobrcb/i4xiXH9VeE3aRGIE6izsjC3eWZmzy6MR
 rdDSHasQJ5cqzlf3fx4iXJL/GQSrYb28GbcT7f5Caw==
X-Google-Smtp-Source: AGHT+IEgArPLzRhZcqvDHHhSPC9h1988o+uBq2aJMiXNX4vBo4JyTi+T0ews7m5uydfQFf37kCmgqQ==
X-Received: by 2002:a05:620a:2944:b0:775:7996:3431 with SMTP id
 n4-20020a05620a294400b0077579963431mr560486qkp.52.1697495471787; 
 Mon, 16 Oct 2023 15:31:11 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v3 16/32] net: Depend on CONFIG_CMDLINE
Date: Mon, 16 Oct 2023 16:28:07 -0600
Message-ID: <20231016222835.596572-17-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

At present it isn't possible to use networking without the command line
enabled. Add this as a condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
---

(no changes since v1)

 cmd/Kconfig | 1 +
 net/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 148414f011df..c6ea5c860e33 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1694,6 +1694,7 @@ if NET
 
 menuconfig CMD_NET
 	bool "Network commands"
+	depends on CMDLINE
 	default y
 	imply NETDEVICES
 
diff --git a/net/Kconfig b/net/Kconfig
index 4215889127c9..25d494e1db46 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig NET
 	bool "Networking support"
+	depends on CMDLINE
 	default y
 
 if NET
-- 
2.42.0.655.g421f12c284-goog

