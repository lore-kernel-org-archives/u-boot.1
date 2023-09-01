Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B59BCA0FEF
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 18:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FCF985894;
	Fri,  1 Sep 2023 20:08:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FSqJVdR8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D117C860CA; Fri,  1 Sep 2023 20:08:32 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D75881FA8
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 20:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so6726739f.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 11:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693591708; x=1694196508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ba/MBdoq3JaST6GFAtt6it5edlPO6J7t/fi9YV+B8mA=;
 b=FSqJVdR8ziFQzb45BbnS1RpfbOD+qFvNHfkBo2wiS3cGT0pa2c+14KHnTxK73ioCEp
 ouKDUJOlZeEUHA5RanAx40/AK5TSKT4ETPbUHA5IZ88+cl3DZNRvxlLLeRmMKLZrfvvs
 he5FjCfXJNAtlUMMlJ8EGcYeTSgO6XgL7Mhq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693591708; x=1694196508;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ba/MBdoq3JaST6GFAtt6it5edlPO6J7t/fi9YV+B8mA=;
 b=JWA4sgoI2XOXipqVREdu0Ku8O5rbaPPVqsiglzvpTUrgX7W2Q+WQGK5GXEwv8uN9CX
 9sNNCnDYoIw3r/zAjzCnuNvdx9SRsq5+rlJLbkb+cdPqvIZDgWJ+gA48gXctUObTUjxQ
 hSpd/aQzJ2GUz1XWpehoKa/oktlfT27aKO72x19jq948hvz/YN1yylFf++AFRxM/s7qn
 AGgoo23hL9ArlV6s66RD1Naztcn+CbvPnVhXfs5CZBTtpXMJJiEHIV7w0pPklEI5almc
 rYSuFvyKDXxWaWYPK+nrrycIqSYEQ9XG3S7i9wr6MLrLJZA4uOxLWAfwNVISQeRhTpk4
 BWMA==
X-Gm-Message-State: AOJu0Yx1Em2TUSQpgRbg7/KBBwdBaTLFse3FSlwCe7ycluXBlADIu2M4
 iaUfjfM6PnANU2Ix3iccOIQ5TvN17BwqZEzXfps=
X-Google-Smtp-Source: AGHT+IHtvIWcZdHrOShwYn4qKBh2Czs67PnWo65Fy1pc/rVro2r+v4fvzfQpE62FjLVpuvPkYpVtwA==
X-Received: by 2002:a6b:3f06:0:b0:795:d33:861f with SMTP id
 m6-20020a6b3f06000000b007950d33861fmr5562333ioa.6.1693591708410; 
 Fri, 01 Sep 2023 11:08:28 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:6e93:c368:57d1:5c46])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a056602039700b007836252a084sm1198161iov.48.2023.09.01.11.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 11:08:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH] x86: doc: Document the -cdrom issues I ran into
Date: Fri,  1 Sep 2023 12:08:23 -0600
Message-ID: <20230901120822.1.Ic1e930902ae178ecee565ab48b9579482d03056c@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

Add a note about using -cdrom with QEMU.

Suggested-by: Bin Meng <bmeng@tinylab.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/board/emulation/qemu-x86.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
index 15f56b6bc70..c604e42990e 100644
--- a/doc/board/emulation/qemu-x86.rst
+++ b/doc/board/emulation/qemu-x86.rst
@@ -193,6 +193,9 @@ Linux is selected from grub, e.g. with `debian-12.1.0-i386-netinst.iso`::
 The bochs video driver also seems to cause problems before the OS is able to
 show a display.
 
+The QEMU `-cdrom` option is intended to work with the original ISO-format
+images, not the recently invented ISOHybrid image.
+
 Finally, the use of `-M accel=kvm` is intended to use the native CPU's
 virtual-machine features to accelerate operation, but this causes U-Boot to hang
 when jumping 64-bit mode, at least on AMD machines. This may be a bug in U-Boot
-- 
2.42.0.283.g2d96d420d3-goog

