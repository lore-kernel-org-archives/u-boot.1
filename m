Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12182C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C76A8329B;
	Fri, 23 May 2025 15:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lvMwes6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 423778329B; Fri, 23 May 2025 15:07:55 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A16E83236
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a37535646aso679899f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005672; x=1748610472; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBicNgo6Yru+FwdMnFT9xqJ4Ekkp/D3p6kctqcpECWg=;
 b=lvMwes6kXA0dChp/48BGI2TKFrDM88bbtOQOaMN4Xa2KzIkdDaQPv5Caj/uzbe447F
 nQj0d2mrXTxu8QV+4iUhom+q8Bvjc5kZHYJlWR7onXCx6eoU/2Nf08Xuly8bnBH8gyYm
 aim/5Fv6xmFkyjoD1o6AX8MbpI19kVVW1ndHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005672; x=1748610472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBicNgo6Yru+FwdMnFT9xqJ4Ekkp/D3p6kctqcpECWg=;
 b=ZXj32clbV3v6Mgpfak+FYAjXL3DasHpfVdAUptf6FzNFYcW3KGiYzXm5zfjjBCwFkf
 VqErn7hCtzYBhn4+/ShEr5IgfCSl+mgfxR4Qrbh/CKGcSa1ewp70btgpJ11ElSM6bG3h
 +3ly9RggHLB6IW1vFlh6o4zKalo8C7CkgsgMIS5QuEWTx4jllyb/5bpFd11Ymo4kCYzg
 jawZiVUxPwUdPc3+V2eRh+rSkVnNKdgBVvQjzWPN7SUQlXuUBsYbrDX/C9xX2Vj/7yOA
 2Es0eB2PMzmpQf+nATF8PSY9FpQ4E1JXLsYxPxu03MQEShq0kUrkQzhFKOWB82JmZsZx
 GGuQ==
X-Gm-Message-State: AOJu0YwJFhqYGamG7dLssLL391wZnADMcuIWjk7I0Iu0uIiHBwmph5Lf
 yJtDCrKxyOsqJmm06kgAY0Z7HNMpkKaZjCe6E6PfjlkMDmefrnI9/Y722GNwP2uz0j0vZP/U+CX
 f6235cCtN
X-Gm-Gg: ASbGncueXFw2rLqeWeaNmQ4N40yTL6N8zASmTs3QlDUYvyrVcPnU+I/RdIeKrEZqcGj
 Exm45PjqSaouelwv7xXCAxsC+VDdNz+I0daQZ4MfzXlP9YUzzuEuUUU0hY7F5T7WnM/SE8cGX8H
 YxScLmqyHL5j2Vi3/ImflOnDlSrjo7IZ3yj7U932uaKtNEF2iDo2oAznWAYdTPs73blmDTdZ85Q
 k7TZbkzCizqEGKIlMX08Imik85g0kF5RsVjW/pMkeDUAkpQAwZe1MTA15n8J+0BkMswtdxIUZQj
 S5RedDph0rHByUSGgT/5r0oSzQ0XCHFsJKa1CzbhYs2j9BEqYOlwJIakQmHlJ6kZxxBp6vQ=
X-Google-Smtp-Source: AGHT+IH6HUlSiXXaQMWRuVWudCifXZ6arqxriEFaKqFY8fTmZ5H5J+srT5wSSaerVVf3nF9rbA1S+Q==
X-Received: by 2002:a05:6000:18aa:b0:3a3:70ab:b274 with SMTP id
 ffacd0b85a97d-3a4c14f78cbmr3169924f8f.12.1748005672190; 
 Fri, 23 May 2025 06:07:52 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/10] efi: Update maintainers for EFI_CLIENT
Date: Fri, 23 May 2025 14:06:42 +0100
Message-ID: <20250523130651.1329593-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

The 'EFI PAYLOAD' entry really refers to the EFI loader and EFI APP
refers to the app and the payload.

Rename 'EFI PAYLOAD' to 'EFI LOADER' and 'EFI APP' to 'EFI CLIENT'

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec8cafac13c..929b0382866 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1061,7 +1061,7 @@ F:	drivers/core/
 F:	include/dm/
 F:	test/dm/
 
-EFI APP
+EFI CLIENT
 M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
@@ -1084,7 +1084,7 @@ F:	include/efi_log.h
 F:	lib/efi_loader/efi_log.c
 F:	test/lib/efi_log.c
 
-EFI PAYLOAD
+EFI LOADER
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
 S:	Maintained
-- 
2.43.0

