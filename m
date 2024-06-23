Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F832C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D9E88327;
	Sun, 23 Jun 2024 19:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OjSklaO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D95884BE; Sun, 23 Jun 2024 19:53:28 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 438F4884B2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7eb6b1045f7so138612339f.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165205; x=1719770005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfcLD1zI16U3eN8QPXtyDsRvUuj2hvtPCbl0nEveeBM=;
 b=OjSklaO9jrhcAeNmwMlsp+m8ZO6a9DlOnZZQaS+0OSpbHb3wXVsED6plNc4/1LsNvO
 ElyVitAi7yZ6QJe3oEUHolweSMtR+KEGLBJZNmaFCkCE/MW9LM19fWzsoaV49MISLz+w
 RinicRjZv+5P3vZIK0mIhRXnnyM0gjjKsW47g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165205; x=1719770005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfcLD1zI16U3eN8QPXtyDsRvUuj2hvtPCbl0nEveeBM=;
 b=tUVfa+Gop5jmkR0DjAyZAqmWv9H0YTjnc/i5P46ZWLiX4eLeB/8dXC6gj+xqw96wfc
 EKzFFIjzSdY0qgicHWwHY3NB2MIT0LXrNyzGoodtoOhKxKHVDwJRiBclMGQ5MZFKVlLV
 gwIDSTd8M0MTbx5GOY8+eF/4otM+RE5mhqO9tMTOrDx7xJJpg5PItUBGryWtZ0c/XvtN
 IoWso+W2pmbWU+VPSGFEgy2B0P8IgxC34/U4DD8IeZr3dUQT5U/ShxUyoIrI8W+0bgVo
 DxElXHHY7SXN1dlSMR4i0+9L5V2MLc900RZRa0zTa6HyF/81pE37FNYnUHNihTQ02yrN
 bHLA==
X-Gm-Message-State: AOJu0YzJxS8GtCMj1teOU1nKpQQQlGUOqdjMo0U6L+mj4GzFGeq4zO6q
 IgOKOXP/aih1l51+IazKe8+0gaf6RwXEd2y+nJ9BaOOU3V5xnUu+M5kA+/WNHSVXsAhxx4RtFpE
 QzA==
X-Google-Smtp-Source: AGHT+IHB3+dxvC1L9raNbddBXymUIG338gpWtf3m9UIuawq2vwH5IUJPo5oaiV2CMmon4addfUbBbw==
X-Received: by 2002:a05:6602:1504:b0:7ec:cf:1d3 with SMTP id
 ca18e2360f4ac-7f3a75fa927mr287500139f.19.1719165204798; 
 Sun, 23 Jun 2024 10:53:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 07/16] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Date: Sun, 23 Jun 2024 11:52:53 -0600
Message-Id: <20240623175302.1463973-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

It does not make sense to enable all SHA algorithms unless they are
needed. It bloats the code and in this case, causes chromebook_link to
fail to build. That board does use the TPM, but not with measured boot,
nor EFI.

Since EFI_TCG2_PROTOCOL already selects these options, we just need to
add them to MEASURED_BOOT as well.

Note that the original commit combines refactoring and new features,
which makes it hard to see what is going on.

Fixes: 97707f12fda tpm: Support boot measurements
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too

 boot/Kconfig | 4 ++++
 lib/Kconfig  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6..b061891e109 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
 config MEASURED_BOOT
 	bool "Measure boot images and configuration when booting without EFI"
 	depends on HASH && TPM_V2
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..568892fce44 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -438,10 +438,6 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
-	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
-- 
2.34.1

