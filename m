Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12547CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3EB87454;
	Thu, 19 Oct 2023 17:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nwxsfZqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87DD987469; Thu, 19 Oct 2023 17:01:30 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4A087465
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a8ada42c2aso33209387b3.3
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727682; x=1698332482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cGOdhNVkcYPMtZzqjWnlWgn6vUL8XkbpxI8jruxoWQM=;
 b=nwxsfZqmSE+fJYA8eT3NKkJ9l8A1AVSuXCUUNq02NyXxGq+NowGnfnE3R42NBB6XUb
 78p4rTJQ8tD16E2kCmUpY05LUHMuA4Q0jbbgETDg2oB3kioPJBjO5h17bP7jCyGpo8PH
 Yq4kF+AxmNL7r+GpMBBT1RuYy3HgnA1ILp9/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727682; x=1698332482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGOdhNVkcYPMtZzqjWnlWgn6vUL8XkbpxI8jruxoWQM=;
 b=e2YCsYS+tnK2i1uLRFxTo3pMwVDwbO911bBIlN8L8zk1Da9yil6IoWUb28JEpGHjL6
 RZ4OzuTiKSaSBFBRXs6NNl/C6mUiTmszOoule+18VVY+N5dLsHex6aBmOXtXK0TKXlve
 C+sjkgx6Aoyuz6KmLqT2QTuDTomsLm2UUiQhhAY86rPg5S7yId2SMSFlrxsKoHMXk35E
 Rds6mHQVBZg+naL+aAP7BCf2t3+MY2V0dPjHIwIJIv2aSPxU1I00R3EGWNyPK2MlAPNQ
 /iyCv6gfTTdGl7T+7ClJ9DMyaOBg7Xh+WQA+pPFi7M2/kXobEP72n9n0Z0Yc7t37XMpT
 3bsg==
X-Gm-Message-State: AOJu0Yxam4d4oHrASV16TTjqAUMcPzchZnJnh2slFCepeq11Z07ZY92/
 OzN+/1JRIVyDaTKBZjKx/mc0hKpRn7XECSDUWdbgmQ==
X-Google-Smtp-Source: AGHT+IEf+AD03rKdWot8qXlvNDk6S/f9346qnof+QksgUYaepYZoNVt4TzAF+x7Zzu/Ib6a2wJSRow==
X-Received: by 2002:a0d:d995:0:b0:59c:aea:d877 with SMTP id
 b143-20020a0dd995000000b0059c0aead877mr2485870ywe.40.1697727682153; 
 Thu, 19 Oct 2023 08:01:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 14/24] boot: Make DISTRO_DEFAULTS select CMDLINE
Date: Thu, 19 Oct 2023 11:00:55 -0400
Message-Id: <20231019150105.714407-14-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

