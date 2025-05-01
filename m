Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B1C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6771F820F6;
	Thu,  1 May 2025 15:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AfpHGW/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7278D81E25; Thu,  1 May 2025 15:37:44 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC82482132
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d93f4fe5baso3051605ab.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106660; x=1746711460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eizxsLf8jqtD0IcfROmIlry+2NhXsalB3AeakDaoICQ=;
 b=AfpHGW/Rmzx6vMTedjrDMdG7ShzqHchpjCpH/rpd1Sb3f7yyr8z3We/gJ4oYsOfrZe
 QrDWfh53BVBah9tNw/yCI7GnGn1tWycQr1I/pU6UGpkCgntPaCmf/5QlSfcu7J92gF7p
 hAeFhjVyaRXAwDSiih+P/sDc/dXWaX4zGASvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106660; x=1746711460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eizxsLf8jqtD0IcfROmIlry+2NhXsalB3AeakDaoICQ=;
 b=IqyyFixKH+f8EDMk8EPGcEk15D44BdWDiQE3onxJn0JnZBvXiA3vX4GWNBzHYT3NaD
 4IDtc2GnSN1NHqeLIhkuAwXK9rJeTzGML3VbfJvLH5zTGflF6jbpn53Yr0jWuFs5QY3N
 /jSskFuNOHgxDnhzGcGjyCX4AVhLtk4k2+w2oKYXk7SyAX7QJhrTEbCLqfWcg/3IFDrQ
 Bb1SdtNfscGviyxHYYxwBW4BugPj7yn2EXiTGZaGsudUha5qPaEg39hmFYwI/tXdb+wL
 G5Na/eBdJHPSu9lcD3LomozlQMYLCglF4VFGVPbTDRAtyLpO/5zz9C+N+4FG/rIMHbtT
 kEUw==
X-Gm-Message-State: AOJu0Yy0j5gnlogRMAHugn4mMSlCXl7B/liQ9QZQVBqCYfp7bdbvhj4A
 U11H3j3kwo30sch/9KkC30LeaKhxk5MOiTr7PqkVboCnuhnFOLaIzhgUWjHG773+FRRdj41gdO4
 =
X-Gm-Gg: ASbGnctgQc8bjtwZjTPMc0wC5jTmKrJjEb4Z7TNvFOun5+sooVvjrCdwZBru0kncQKM
 tKLsCnmtMOkwl+TFSJz4rvpRtkomlHxeT/FC5vXqr8jqe3L9OMmuRRx0hXo5ERXANGmTaItBJh4
 imgD3ZkGJWNtp/TjR9pzPvUGy68zI+pSu2pCinOjd/+VWgqR2takfyvGG8NQfv8AiNikShMCrHx
 PR5hMa9c17eAR7sQoAU3gLh1BbvK9jSY7nGHOznBjqaJ3rHmKxJYJBnLDK7XwZqpIpUkJFPNiTB
 xWFR0rXYMIIJu8m5Pki4CjQ/Nj+pC0D7Y8dzVQ5/btC4lqUnnhDIaYc5lIlfSzC2TIlowKZAs2h
 OBg==
X-Google-Smtp-Source: AGHT+IH9vHwhSVU4nlvm/UpC2fu8sszAHbjBka2lAeFw0sGk/shASlkaPoc7SWSzk4rh8pCLMFmT+g==
X-Received: by 2002:a05:6e02:380e:b0:3d9:34c8:54ce with SMTP id
 e9e14a558f8ab-3d97029120dmr31559455ab.18.1746106660036; 
 Thu, 01 May 2025 06:37:40 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/18] bootstd: Add more debugging to bootmeth_efi
Date: Thu,  1 May 2025 07:37:05 -0600
Message-ID: <20250501133726.2627373-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

Add a little more debugging to help figure out why bootflows are not
found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_efi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 0c9b4c3d59d..01cc7ec3bec 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -103,6 +103,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	char fname[256];
 	int ret, seq;
 
+	log_debug("starting part %d\n", bflow->part);
 	/* We require a partition table */
 	if (!bflow->part) {
 		log_debug("no partitions\n");
@@ -116,7 +117,8 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		 desc = dev_get_uclass_plat(bflow->blk);
 	ret = bootmeth_try_file(bflow, desc, NULL, fname);
 	if (ret) {
-		log_debug("File '%s' not found\n", fname);
+		log_debug("File '%s' not found (desc devnum %d)\n", fname,
+			  desc->devnum);
 		return log_msg_ret("try", ret);
 	}
 
@@ -165,6 +167,7 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 		log_debug("No device tree available\n");
 		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
 	}
+	log_debug("found\n");
 
 	return 0;
 }
-- 
2.43.0

