Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9083CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B44286EE2;
	Tue, 17 Oct 2023 00:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QMe5Htwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688EB86F15; Tue, 17 Oct 2023 00:31:16 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B167286ED1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d2f3bb312so22196326d6.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495431; x=1698100231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlR0o+utmEoVFE/I+M0XWGieFvdB3pkjlFSJCM+uuOQ=;
 b=QMe5HtwyzFOHbkWo1ZHperjY5pNjIxwuVRSinQ99Muc6v5ncFnCR25KE9Cai5yEBfk
 D/qa+Mkbdumm+ChEWS+gDiLkMN06+zri6R18ggb2t78ADem360jKybZjsQZ+834TRgeg
 CjZ77xtcj6qf9EfM6tLsAjMbGc/tSxeQrbApk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495431; x=1698100231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlR0o+utmEoVFE/I+M0XWGieFvdB3pkjlFSJCM+uuOQ=;
 b=B05WKJwK4z1mWCWemv5X14VkT0rj2/bykuMfiJHYbh7onNANrSPpeVIlubAJxkJvJ/
 36JHJVO/M0VX1fMmLhWmjvQMnm4VR13DkOJwrNjYusNUzsKkoLbnqVKfontIgJkFqLoM
 5vtfN7tEftyWeLNIeeVYPe99ked8IH4JZiFXkEYSxJw8p0WNCmDjvUa/a9uXY7Npe2rE
 rke0byL0IszPmQWYf8pdOiA+HRQiSZZBfQ1X4xGj6eqtM+tvufUoFEQY4nGiIXG23WvP
 9l9RXbdFUvFNOn4NuWzPu09M2fwdmk1AYEgFSqgWsPBgWcvg5FLO+iICw7P40KHxDtwc
 QiAQ==
X-Gm-Message-State: AOJu0Yym/mwwkusLU3aqNd53t2iA2SbWGXjXu4rZJEorpoewY+NzjOm2
 wxUbfU1XvRmxib3s1TsfvRXRLtTYC0KCUeArwbToHw==
X-Google-Smtp-Source: AGHT+IFDvfGBbLaNCKWiBpQZ+onncrTWYo3tWDl2I30GzLiYKG/+wgfUhUGInWtCUvfOdap9+kRssA==
X-Received: by 2002:a05:6214:c6b:b0:66d:63f8:255f with SMTP id
 t11-20020a0562140c6b00b0066d63f8255fmr953771qvj.56.1697495431620; 
 Mon, 16 Oct 2023 15:30:31 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/32] pxe: Depend on CMDLINE
Date: Mon, 16 Oct 2023 16:28:02 -0600
Message-ID: <20231016222835.596572-12-sjg@chromium.org>
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

We cannot use PXE or sysboot commands without CONFIG_CMDLINE so add the
required condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 00a7f84bce99..18be3da972d2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2002,6 +2002,7 @@ config CMD_ETHSW
 
 config CMD_PXE
 	bool "pxe"
+	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via network using PXE protocol
@@ -2237,6 +2238,7 @@ config CMD_SOUND
 
 config CMD_SYSBOOT
 	bool "sysboot"
+	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via local extlinux.conf file
-- 
2.42.0.655.g421f12c284-goog

