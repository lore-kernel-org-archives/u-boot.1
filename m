Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B61C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A6D4888FA;
	Mon, 15 Jul 2024 12:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="huk+SJ0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC68888B2; Mon, 15 Jul 2024 12:14:13 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC03888D4
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c79so5744734e87.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038451; x=1721643251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihm2nOsxglI3jI6tfj6rNXZym6deL2vB8VPpOrtx/ic=;
 b=huk+SJ0Sbv9XauPyOOJNZj+xyxTwGmDwnscqekZAgnB2k06lXZ9ga+2E6XmKmvhLuV
 oJ2DBu5mDvsXPGDPjb0XdYllxF4YdRIfnh2Wn5WI3SToca6D/c7pluDsEqcLRC67Fwew
 tk9sR3HDkmTo+5VDolf7Zf1uaBjOA5EpNlLgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038451; x=1721643251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihm2nOsxglI3jI6tfj6rNXZym6deL2vB8VPpOrtx/ic=;
 b=vD8US6Ij0SXbGMRLBddko6bnAIjCtFavvXJOXcSnd3Fx7w5/jYj5mwiPkRqrtHV+0s
 fQ6eam5Yc+zbTIcoLcT1lR6h0mUx6zj3uUwsqoLoQ6vP6lUgJQxiKi47CVsbVyIorP9b
 cEmAMzMa1ko3QrTXni0qhNJXSxheJrFDaWFoWK5XAwtG2u0yB0A0s+L5maw32lpyqYNz
 UWEql80zF5FuvqOoFtxZ75Y9d1uPQH7+zuCK8FOxKB3Yn0zPWVrxIK7enGtJytUwZbaw
 l9wOsF/ilHrCvkP2cCs87dN96ROBKUoKeP6JAaISiXDcUJmg99BOtQyK75iKlxcm8c+e
 tfYA==
X-Gm-Message-State: AOJu0Yw1AtaXh5IdULFNAmJLBMCcUtIhLYL0TwPv+ENjZC/NnLH9/OAG
 JNcGrhD+znE8qu2qpmLH3aCCsxHQGmOVauLJGR4uR1DQ/eeZsaYKJyf/99nolCoi2KzCdHnC1zA
 =
X-Google-Smtp-Source: AGHT+IEJ8uqsfSOH1jaHlN+9beukcUH96Sps+C0D21F+Y7a7H5r0SWDjwInobytnbhvC1g4yqfOncg==
X-Received: by 2002:a05:6512:74b:b0:52c:e393:6634 with SMTP id
 2adb3069b0e04-52eb99a325dmr9713183e87.33.1721038449961; 
 Mon, 15 Jul 2024 03:14:09 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 13/13] doc: Describe the bootstd settings
Date: Mon, 15 Jul 2024 11:13:54 +0100
Message-Id: <20240715101354.97895-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101354.97895-1-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
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

The bootstd node provides some configuration properties. Add these to
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd/overview.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 0d7454246f6..f3caf8b7956 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -406,6 +406,19 @@ You should probably also enable `CONFIG_BOOTSTD_DEFAULTS`, which provides
 several filesystem and network features (if `CONFIG_NET` is enabled) so that
 a good selection of boot options is available.
 
+Some devicetree properties are supported in the bootstd node when
+`CONFIG_BOOTSTD_FULL` is enabled:
+
+    filename-prefixes
+        List of prefixes to use when searching for files on block devices. This
+        defaults to {"/", "/boot/"} if not provided.
+
+    bootdev-order
+        Lists the bootdev ordering to use. Note that the deprecated
+        `boot_targets` environment variable overrides this, if present.
+
+    theme (subnode)
+        Sets the theme to use for menus. See :doc:`/develop/expo`.
 
 Available bootmeth drivers
 --------------------------
-- 
2.34.1

