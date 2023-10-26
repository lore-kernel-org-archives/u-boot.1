Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F26C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE7AF87B7E;
	Thu, 26 Oct 2023 20:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hROe+Zmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8930E87AE9; Thu, 26 Oct 2023 20:31:56 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135338763F
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77897c4ac1fso91542285a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345112; x=1698949912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cGOdhNVkcYPMtZzqjWnlWgn6vUL8XkbpxI8jruxoWQM=;
 b=hROe+Zmkzw8kA/s7q6VTtyXKv/wKL22CYK+NQAuJ10PAmWDyzbTxrzOyyeKJNjOCVR
 RJ6ux1CHreG6LZeP4I3JkLdqlltf/l88ExQ9S2H3PPSTROawlF1ReloiZsBe9RY6eoBK
 GTGTK8eoIrFlvqS3hRtOueXMxidNCTGkCpJic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345112; x=1698949912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGOdhNVkcYPMtZzqjWnlWgn6vUL8XkbpxI8jruxoWQM=;
 b=h/1cyxqDlGVCmlbtDFCY8BQo9xn7LNXoi5Qw0J3WKXQ+NJbHrwn3RGQuhF/N+kdzUx
 1NhsqnL/wZyzPBYQ65EG5CooHiU0dNYCFcpRTet05WWKilZXcETCD3B0IXJxXXAbeT6a
 1syjc2BL5/G9Q+IF0MwByRJJ+G2idJp5Aset5i/JQOrx8Pl4uQTWBq57fROKGVc+kGGk
 o2iN3Wh90VTQy4KN6jDMs8c9cVOf0ZkzQ/777709BeQCqf0w8ZjtJbb1viTPrQZ8RC10
 pWeM6dYj0xDNWU5ZRm/epEPPikptuLWNFfZhbHpjXrIoiHQVehUy7e89tnrjH5ybAKA3
 3BlQ==
X-Gm-Message-State: AOJu0YxHK0Dp3Bk7+CUBPQGJV2g2x13dLtFfyueIUbBSjk8pls8gCZcW
 A3nojt0Do8ENLATf4LaBFgE6USrWDLzYkMBVsMUYxw==
X-Google-Smtp-Source: AGHT+IGAKp8G3Xe03f96kTcbAMiGi2eA7OGR1n877W4WddajErYLv5Kh797oQY260WtNPpItHiUVGw==
X-Received: by 2002:a05:620a:6016:b0:778:8dc1:bb7b with SMTP id
 dw22-20020a05620a601600b007788dc1bb7bmr141522qkb.27.1698345112617; 
 Thu, 26 Oct 2023 11:31:52 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 15/30] boot: Make DISTRO_DEFAULTS select CMDLINE
Date: Thu, 26 Oct 2023 14:31:23 -0400
Message-Id: <20231026183138.636948-15-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

The implementation of DISTRO_DEFAULTS is done in environment scripts and
requires the command line in order to work. Because of this, select
CMDLINE here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 0dbd10a93469..2075ecd34b1f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -777,6 +777,7 @@ endmenu		# Boot images
 
 config DISTRO_DEFAULTS
 	bool "(deprecated) Script-based booting of Linux distributions"
+	select CMDLINE
 	select BOOT_DEFAULTS
 	select AUTO_COMPLETE
 	select CMDLINE_EDITING
-- 
2.34.1

