Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B054FE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:27:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FD08931F;
	Fri,  1 Nov 2024 16:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGAOmad0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90E288E35; Fri,  1 Nov 2024 16:26:39 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1857F892FF
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso2681319a12.2
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474796; x=1731079596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzWagHBBz3KBiquXdYdA9F9aQZ11VSxRtZTZmBlZBms=;
 b=cGAOmad0vZx0MiKd1AcoxW0J5iKrvH+iOEJzKmfjXiRCVT6JF318/j6Tb/OhqEb1sT
 +myNU1bVg3pw8dosD7yb5xnK2wyvybtzxk/K83dVRhEFxIUkL2uOSJklTQveF9WKEcKR
 AVqVmvaK/u1ljiQesRCOQwjM4zqKaAoYphIDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474796; x=1731079596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzWagHBBz3KBiquXdYdA9F9aQZ11VSxRtZTZmBlZBms=;
 b=DtuVXtjosAPxFssPJlYNtLTzYTREE4v2XOWkT1IUg2mE+u6c0gjEN1tHCFAcb/709v
 v2+3RJ5GuUlXaeJzY3zzfVWuPsjTiVUfuzAHEpUf4+45funWIMbeE/1ZhMeq2uddPT8e
 ikJ7E+H9TObMXNP1HbxUo3aLUulFA77id3aQtdheYHxqgzjj/4LRFSSnzNFv2R60moqE
 GxwT5cmNhgF2j1qwxCohhv4mbcqN4zXR/ZVs5HsCfOk24YaJHCjocKOxjoRrw9bNSEwJ
 UJa3jYcxiund1jRc3wYfCIWgCG/92oOKcAhBrhyCthWuIJKppPfVEaPMTnsZ5ry0C0fl
 pkWw==
X-Gm-Message-State: AOJu0YxKr9sMvgA/eC+bAgS+hcofnuI03Gu5a8S31hp8ACwSxP/NjhJq
 FGreA+D6LecSx6xvQWns7s6Kc5s/yzg+Lpp7+kQ2H29kqgQi1GcG+ut2XimtJdnwZKkaVa7NfTD
 iRCwd
X-Google-Smtp-Source: AGHT+IFQX98BqvIUbmiv8wcX/iYLEDp9ohBer/HaMIbzQ91jDV6HIe7QI9MSpazX+DT5hM72S76E2A==
X-Received: by 2002:a17:907:7e84:b0:a9a:123d:3f1a with SMTP id
 a640c23a62f3a-a9e508d4af3mr631619866b.17.1730474796073; 
 Fri, 01 Nov 2024 08:26:36 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v9 09/11] sandbox: virtio: Disable the sandbox virtio blk
 device
Date: Fri,  1 Nov 2024 16:26:07 +0100
Message-ID: <20241101152614.238747-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

This is not implemented so cannot actually be used to read blocks.
Disable it until it is implemented, to avoid causing a hang with EFI,
which probes every available BLK device.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Issue: https://source.denx.de/u-boot/u-boot/-/issues/37
---

(no changes since v6)

Changes in v6:
- Drop the patch to disable sandbox virtio blk with EFI
- Add new patch to disable the sandbox virtio blk device

 arch/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f1f4667012..c39efb4d0a2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -212,7 +212,8 @@ config SANDBOX
 	imply VIRTIO_MMIO
 	imply VIRTIO_PCI
 	imply VIRTIO_SANDBOX
-	imply VIRTIO_BLK
+	# Re-enable this when fully implemented
+	# imply VIRTIO_BLK
 	imply VIRTIO_NET
 	imply DM_SOUND
 	imply PCI_SANDBOX_EP
-- 
2.43.0

