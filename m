Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B525CC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EA788A4E;
	Wed, 17 Jul 2024 10:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZoaY1jjr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50E188A3C; Wed, 17 Jul 2024 10:31:19 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3761885B6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367ab50a07aso4085208f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205077; x=1721809877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d29XWoULdw1zC0AIN1yvZpS/H89DUp1KoQEPkB6xAqw=;
 b=ZoaY1jjrYblJ0X50PKjfUVSo4x/yEb94NemukFlJtIAvScqzlt3L9CMoWkvPwjq9Zd
 G8oJzZ7AbroYCZNBeQ8XWLNOMN6QGQB4a4ANJIU39bX/fJqwn3k/Bt/j1DEjeyxSdrhH
 3deI+tz9TzWAroGnsf7IczqgQygoI/sSiKSRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205077; x=1721809877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d29XWoULdw1zC0AIN1yvZpS/H89DUp1KoQEPkB6xAqw=;
 b=l0KuQ4nYOu0vTwxbNMu0ZJ9bJQ16DX/+fY0Tx0bNNIpZzOxFPtFZ+l6mVm5SCLT86b
 fYJQAhQEHc9lk6IdYNRTkrheDYcO5c223ZQRuIYjx0ODGnj6PHSXKO2zD6hd8Ni8w9+g
 Y/PmDasK5QciB3+KotHW2NXVtmqztm+hbJhbp5t9BxSpscfKfucoL3e53WjR/WEWUr2e
 /7eRUYsGAN7rGM9z+CR9bRLPSg8sScGyHWGDBaPsnJWiGIwjDlbiTOMyIKZRmxOf14si
 34Xp7aFWcidsQs9kF5VoavS1/uZWwSibl5BFhsCFcuUfCEvuLAWEq+sVou1VML/t4F/f
 10cQ==
X-Gm-Message-State: AOJu0YwisJDPqf2g0/o1nq4QOFE/dUEgn8MVYXvMC9o25sJjHStWaE78
 FbDAaxQZlabl2eirsnPMZXu+YoUuEfmSFZJ03G3+AfThOUzvwyhioDTbM2VRKq/q1drkN7b3GuM
 =
X-Google-Smtp-Source: AGHT+IFsW8D2WvMRibrSBfmUq7Vp0Rmv2+2Vmp08wd8TDHKCkX48IW5GNDTbzAWEK3TfCZMLOLZcrQ==
X-Received: by 2002:adf:e6c2:0:b0:367:97e7:879a with SMTP id
 ffacd0b85a97d-368317c0425mr769361f8f.65.1721205077200; 
 Wed, 17 Jul 2024 01:31:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/14] doc: Mention automatic binding of bootmeths
Date: Wed, 17 Jul 2024 09:30:53 +0100
Message-Id: <20240717083104.1963431-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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

Add a note about how bootmeth drivers are instantiated.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v2)

Changes in v2:
- Add new patch to mention automatic binding of bootmeths

 doc/develop/bootstd/overview.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 761f61a573b..d5051e986bb 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -419,6 +419,9 @@ Bootmeth drivers are provided for:
    - VBE
    - EFI boot using boot manager
 
+Each driver is controlled by a Kconfig option. If no bootmeth driver is
+selected by a compatible string in the devicetree, all available bootmeth
+drivers are bound automatically.
 
 Command interface
 -----------------
-- 
2.34.1

