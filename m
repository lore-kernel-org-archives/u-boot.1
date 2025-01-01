Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B22E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D29F8062B;
	Wed,  1 Jan 2025 23:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JKPg6I4z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBCA80391; Wed,  1 Jan 2025 23:16:59 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C212806CB
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216426b0865so142773375ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769813; x=1736374613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sq/quVzXt/0wd82KOl/lT1KyK5GSv36R8p61iXsanTA=;
 b=JKPg6I4zttc2Puc0nG//Kvu3h03w9cXNG0BnE2TTuwUFAEzP2dIbOr0nPl6VqB3S6v
 x2i+bvPnQrJ1eyLZqvm1SeLEHS4BbwlN0KknrVPt6aHuVXvPPMRx0GaYsX5IRL0Q56yX
 azXxk+NigotxffhrSYp6r2Gl8mpERowls2k4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769813; x=1736374613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sq/quVzXt/0wd82KOl/lT1KyK5GSv36R8p61iXsanTA=;
 b=pfrjEQhnqyN2XjQrK0QpDRIL6rtYOi2LU8EnbWwjaFPzwX7BV+pnbh1ychD5bcPO6x
 JMWxSrdHlYt/vU6LHuu5+xDPcQ/rXoYF2ixtqg1fnOgPzi9FZ21Ivm84+4vpL1fe90a2
 5wYM9G+4qgOLasaKSX9fEvy1I+wok9hPqxBBSZqnGd+zdL/UnfDzdxDma9JHhNkL97MO
 Gi7iJaGDCeNiGbrNUd2YbsOXUSd+PjGfLnOk+JwaT6Ahf3b1Lwhp4HgJDxs+86rx8DrN
 /dXlTKlxDvIim0Sp+oBLAXcoqeW0MzK6LfgzsiXXWck/va9IinD6VhcJxDY0i5ZRu0vP
 6FDg==
X-Gm-Message-State: AOJu0YyH1g8WlXOhgaqqYo3igQCRGeshFUGyROhwsmekI5t2aW76zgKr
 rA2q5AN8Zv2pLaJZDnvvSg9/eRLYRZPZl9RUqCp5AmTpn6WEng72XysEksq44mMuNAIx7A/9vg8
 =
X-Gm-Gg: ASbGnct1DI8RvVdaIOJV027Wk3KIfOrZvPmVtSfbBq3Sk4oV7GKi1jCnX8gOYAvmovu
 UwmHGIGrOAj9TuMbovYuz5PWFe8Z14GMd/oU4gZhqp23/t7FRChhEB+s0Sdx2/blkKdm8uvu/u4
 dzdnWtlYqhv8fwZYvHY0SC+DkSWBL7wEP2zjO0vK9VACWw4UNP8Qz9I/XhhbOPShYh68eYxjKMP
 ia6hg3Ilc7MY3mAEoETIr57lb2gFUnGF9ZoaU5k2DUlU/MMQ62se/8=
X-Google-Smtp-Source: AGHT+IHH//LBrrPx5tXj9gvwk4j1wxzehY5B0VKzSuURqE/CUfmfjlghcfxGm/IGO0WdovdJ0mKBkQ==
X-Received: by 2002:a05:6a00:392a:b0:71e:1722:d019 with SMTP id
 d2e1a72fcca58-72abdeb7326mr64097515b3a.22.1735769813277; 
 Wed, 01 Jan 2025 14:16:53 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:16:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 36/67] x86: emulation: Enable UPL
Date: Thu,  2 Jan 2025 11:09:22 +1300
Message-ID: <20250101221003.1944600-37-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Enable creation of a UPL handdoff in U-Boot proper, so that the
next-stage firmware can be called.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/qemu-x86_64_defconfig | 3 +++
 configs/qemu-x86_defconfig    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 2771a4b9e19..003af54498b 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -22,6 +22,9 @@ CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_BOOTSTD_FULL=y
+CONFIG_UPL=y
+CONFIG_UPL_IN=y
+# CONFIG_SPL_UPL_OUT is not set
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_SHOW_BOOT_PROGRESS=y
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 947d15cd727..5183117854c 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -13,6 +13,8 @@ CONFIG_GENERATE_PIRQ_TABLE=y
 CONFIG_GENERATE_MP_TABLE=y
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
+CONFIG_UPL=y
+CONFIG_UPL_IN=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
 CONFIG_SHOW_BOOT_PROGRESS=y
-- 
2.43.0

