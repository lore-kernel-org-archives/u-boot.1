Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2693CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BD886BA9;
	Sun, 24 Sep 2023 22:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cjCHUpuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1802D86B88; Sun, 24 Sep 2023 22:40:35 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1D6586B2C
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79f96daf565so153615039f.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588031; x=1696192831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fm/8rftg1ySi13Tv7jP0ykE3uoSgSnj1tsNc4dXIFcc=;
 b=cjCHUpuXrcYj/nACaRgiEmihM6OOhsd6N2ZBSAuOtAgQHnv/2w5t9PcbvRWEa2NWlE
 vVlvQ6tRoIH8SMo+HFhfISGEY4kewNb/Lhpygsu1HMOpzqi6AdHjY4ShZoVYFqHJsYS0
 KkSGk0mXmnvV9EFwAjb/uZg0FkoKS/W/A3Xlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588031; x=1696192831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fm/8rftg1ySi13Tv7jP0ykE3uoSgSnj1tsNc4dXIFcc=;
 b=sT2Aa2Qs8QWQqbrBBndHueLNDBCefZo+0j70w3AyBuk73Mx67k0CsXi0LIkYyGTh5p
 23b9YXuGkd6xwxtus6U3IV3SZ4RLav97MWzbjuH9dQY8+LdjkIXycYxJiAoD6AduK0lj
 qUtsI2tcpgLKWsqA3qky5y6UspZQCSG8bmqnjy5t250t7TnGz/0Mpm0QO/vMIK97LMXy
 r0HqTrAhFFfggKgx5sLxhzsY23dwv5i/6ajiHkDgU66sHkYqpq8kG/TMi4/Ijh7hdA87
 4xt3ToQIRXKtWC7q8WBKNoFXRkZ92h0U/QhohBNXgZuK8u6QzNaCO7ISrzeZTiH7B5Ms
 MQ0g==
X-Gm-Message-State: AOJu0Yw6dyZQRlJSOQp3x6gCzyBjUKjNGRR+WHZFf/6w9lo/n34sdCi+
 Yk/gHJz2gqQHmAA9vHwLR1dORSGq4ZOdHe0AJ5U=
X-Google-Smtp-Source: AGHT+IEygieYvNWKm9D5gbfnkGfg9IE2crSdfTKdf1RjlYT86eLx/vDbNc+/Mv4RDvwAZ431afdDaw==
X-Received: by 2002:a05:6e02:1062:b0:348:ffdb:78 with SMTP id
 q2-20020a056e02106200b00348ffdb0078mr6309152ilj.9.1695588031539; 
 Sun, 24 Sep 2023 13:40:31 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH 13/25] pxe: Depend on CMDLINE
Date: Sun, 24 Sep 2023 14:39:31 -0600
Message-ID: <20230924203953.1829820-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

We cannot use PXE or sysboot commands without CONFIG_CMDLINE so add the
required condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index cdc22a067b27..a254c41110ec 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1995,6 +1995,7 @@ config CMD_ETHSW
 
 config CMD_PXE
 	bool "pxe"
+	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via network using PXE protocol
@@ -2230,6 +2231,7 @@ config CMD_SOUND
 
 config CMD_SYSBOOT
 	bool "sysboot"
+	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via local extlinux.conf file
-- 
2.42.0.515.g380fc7ccd1-goog

