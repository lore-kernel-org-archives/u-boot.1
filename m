Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EC4EE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:26:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5AA87059;
	Sat, 19 Aug 2023 23:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MMFj1FUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6EC87057; Sat, 19 Aug 2023 23:23:36 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2427F87002
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79196067c75so65683639f.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480213; x=1693085013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnpxuYjuwiPWtLU9Nu+hgWfnl5FrS1xUNIfaApm6kyQ=;
 b=MMFj1FUCeRbTDTBiC3KKHJWKMMLMWPfrO/RQSkVIeCVrMbZuWmXxeXTb57XVSrq3XZ
 659KcMJKwqUTxpIP1vJtKXXvkyL2+HMEakpnXRcFyiR6YF/eu17LvtxeIIQTgKTt73kq
 bdNy1IgHIdxp9h6Gcec5UtEIPm1gIATlqWJR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480213; x=1693085013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnpxuYjuwiPWtLU9Nu+hgWfnl5FrS1xUNIfaApm6kyQ=;
 b=eplQN0Ex6sKX5rnvTb2ROta2k3HI8DTjq87eT+f+iZZwNL3Zk1/soZwehOswoDrMBh
 WXaqI6dPdS1I8UtQ+LdBvRL1FWorl6x1AMSXO7mUTuyVaRYPU3GHbr0pvCzsKK6zT9fw
 EnJAHwA/LTbXw8fKdRNHm5jQ8edbxgt8PJMoNqhLH+62CBkJRQAWOMCbPvYAcgaPtkQT
 pdyB0tpToC6RBumMZLcDlFisiD+Xlcm029355kWtBNpYU2Z/CtFEQCWJQQZiIkvMo/ND
 DR47/HlNVZ3WXVhDK+N2ODYFb3IerPAorfGbh19PYYwydlwGT8VxnwvUCEXQJBvrDMoa
 TXcQ==
X-Gm-Message-State: AOJu0YzVIsCRkIEh5UFwW879COeHL/LgYEozCgSNl1ICODzeg0sDqPRI
 PoLMxIGlVraRsN1Hl9TEtv5gYP6e1J1fWQRJHfE=
X-Google-Smtp-Source: AGHT+IFUUHEYAiGg4gq/dcnFbeu4I6Xw3XXN2njrp6vU4fcmuzcgWfQ0icTvZnCasE5HoN3fj/qH0Q==
X-Received: by 2002:a6b:da09:0:b0:787:1c51:ff99 with SMTP id
 x9-20020a6bda09000000b007871c51ff99mr3420271iob.11.1692480212826; 
 Sat, 19 Aug 2023 14:23:32 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 19/19] x86: doc: coreboot: Mention 64-bit Linux distros
Date: Sat, 19 Aug 2023 15:22:57 -0600
Message-ID: <20230819212309.1094440-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

Add a little more detail as to why coreboot64 is preferred for booting
Linux distros.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch

 doc/board/coreboot/coreboot.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 88437c27740e..a32c3a864f90 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -82,6 +82,8 @@ build in `$CBDIR`::
       -device ahci,id=ahci \
       -device ide-hd,drive=disk,bus=ahci.0 \
 
+This allows booting and installing various distros, many of which are
+64-bit-only, so cannot work with the 32-bit 'coreboot' build.
 
 CBFS access
 -----------
-- 
2.42.0.rc1.204.g551eb34607-goog

