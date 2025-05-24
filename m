Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD26C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60FD1835AA;
	Sat, 24 May 2025 19:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HlqEu50j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49A982E28; Sat, 24 May 2025 19:28:40 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3747282E8E
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-86135ad7b4cso21795739f.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748107716; x=1748712516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXhsh0IX0lfyzTGOS1WOzo07X8x5QxHKWPv4PtwQh8I=;
 b=HlqEu50jM7fvV+2qcGq1fpur6YHiTnK7O/jDhQ7sV3FuFodDmrgmPkSgSSxi1ixjQX
 6uIgUcLuMJ0qF38e4OZMmZQ1RAA/glia/esy+5ABbxW5+if7Ifp9VDxBW9jsJlW4DPoS
 WDhY+x38f8bLV62bI9470hllSAS5mP4GwBPOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107716; x=1748712516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXhsh0IX0lfyzTGOS1WOzo07X8x5QxHKWPv4PtwQh8I=;
 b=GVU2buGbxcz0EIRn7Vw4dHhkInjdik2MeXiWOzY6cZ5+6nu2pR6oM/dMXI31RcNLDc
 7FbGTD4zeRJxMBCdTMmxTuIGoEtyFccZycper68lPaTXGXapotLQJmC9eZLevlgZpTLq
 ijpKmI4j+20+RvezMSmngBtrZfN7eztUMb1z1VoxHG+1k9Vbo5bDNAADaf0z079anbdd
 7TqoMNe5tdVpK4PJ0cDnUrlMTAUx7z2VDhEM7yVHHnn4Zul1yk291rhz4AX3oKz8u3Qf
 nISeFCPCDyU449fU+SCHTxncO0zZ8+2vAMzQK4qmYYYbIWXRMUpXd/4h1oDkaAYKNdOJ
 NKBw==
X-Gm-Message-State: AOJu0YzbJ91ji9GiKNinD3qECU162cPtUEmwKdMVyLbXrn/MHainlRsQ
 eA2nCmPwrFD3G1/kmW7lNyKcyJemIhPzbS8v5ARpxGW9aRd8mN0/TMAsFcJjUpnYBwJvhwTjF27
 NbuxwAsfM
X-Gm-Gg: ASbGncvM/0uOuDIeLaWw4ARMxDdhpkNQnwnCZvA9TYC3LO64OgEat6LXvLbJ0eKgmy9
 npXQtVc8rzAxAcn/CKMRppk37rXX7F5YqCzsHLVplgupZ8lqdoolc5Dv6xM1lFQZhZ6+Q68yEsa
 vL492sOdRG1gmJMtRXlHd/FlnjJmxKLfjmfScUVW6ZUJnsJKBTo3h0+yxVPekASF/iaElhpGdf8
 RWWWkOPvYdknOvyi04nHQ3U9llJfIzhC/kUDmzcUDxMoBedawTW+mJfehegT5a7BlO39V5BkrU1
 0PI+i8zHz9OVb8293r+jfv4od/5iZnHtcadS+opco9fRujAePhgioRrT/kHSOqABNZR1CtaMpW2
 SSTfQfdNK3yuC
X-Google-Smtp-Source: AGHT+IHQe20G+KYcw3CxJ7DVTwtwOHkZvIKEecNirhQ6wtX8Ol7vgB24z6hbjKmWafDwen2DrJ/x0Q==
X-Received: by 2002:a05:6e02:1aa5:b0:3dc:7f3b:aca9 with SMTP id
 e9e14a558f8ab-3dc9b70ffeamr21922015ab.14.1748107716390; 
 Sat, 24 May 2025 10:28:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc79b5b4a0sm26521105ab.11.2025.05.24.10.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:28:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] efi: Include device-path functions in the EFI API docs
Date: Sat, 24 May 2025 11:28:22 -0600
Message-ID: <20250524172827.1243975-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524172827.1243975-1-sjg@chromium.org>
References: <20250524172827.1243975-1-sjg@chromium.org>
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

Include these function so they can be browsed in the API docs. Exclude
END since it causes a warning, which becomes an error:

   ./include/efi_device_path.h:22: warning: cannot understand function
      prototype: 'const struct efi_device_path END; '

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 doc/api/efi.rst           | 6 ++++++
 include/efi_device_path.h | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..a98298f93dc 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -178,6 +178,12 @@ Driver binding protocol
 .. kernel-doc:: include/efi_driver.h
    :internal:
 
+Device paths
+------------
+
+.. kernel-doc:: include/efi_device_path.h
+   :internal:
+
 Unit testing
 ------------
 
diff --git a/include/efi_device_path.h b/include/efi_device_path.h
index 67474d6d0c1..33b6cfe9b79 100644
--- a/include/efi_device_path.h
+++ b/include/efi_device_path.h
@@ -14,7 +14,7 @@ struct blk_desc;
 struct efi_load_option;
 struct udevice;
 
-/**
+/*
  * END - Template end node for EFI device paths.
  *
  * Represents the terminating node of an EFI device path.
-- 
2.43.0

base-commit: bab54f5942c428be698216224fd10b91d974d4da
branch: app-us
