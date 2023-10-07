Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C6FE95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C018986F2C;
	Sun,  8 Oct 2023 01:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d4SGb9Zx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3293486F46; Sun,  8 Oct 2023 01:14:40 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF76F86F04
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3528bc102adso13851685ab.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720394; x=1697325194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8n8d/8TxKJJTR/dDT1+u7DZcg9UxMEXGWGY9/JmIAs=;
 b=d4SGb9ZxKB93a4t2mbeazhcD7+bNv6IySyGzp+vaQghUN6mgiqTu9VSZSZO8AYTmqw
 d/P/AFs/uK8rO1CXTXkQfC2ALlV7IyF+zzrOKzWiV9jK6MjQgVSXl+23cjM2VpLzO4pU
 R3otC9Qs78mjTgk4OLk5L/cc+M7wWWRyGtGrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720394; x=1697325194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8n8d/8TxKJJTR/dDT1+u7DZcg9UxMEXGWGY9/JmIAs=;
 b=hn8BVZYobtlaBpoISd/B1vAh+YqwQVdHy7TSlvPem3/paYHVovkUD4qviZdF3T6mYB
 vWvEq2jFaZhSizR5U3TRz2QXIm2y1a5JPxtL7c3MmTTz0sYG+DlNRCn7BQOMkCamsTKF
 qnplUf+aFaYVeb0f8K1OfJvtk/hINFXnrwFT1esvcTJ3VVNyWmV9gXWt8fVowEFROXYN
 MocoYQB+ku6QTcis0uW4geon3MetwlYUeVqWdaxEyeICd1DpcgTtsVRJte0x1u2eWAeY
 6w/H0S3RckDUujzvqpyOjbUoM71aQBlmGYtRfImebT/YgCSDN65rCErcbAAVgFIy3j+i
 cbCg==
X-Gm-Message-State: AOJu0YxdWRwAE3hb2MIK7KGye2YKVbIuhkspQE+CDoTdPq50cvJ1L9XE
 jChsMyYOrhzYoe6Ga1mc5Sl9N2ibpH/bO4ZvzJc=
X-Google-Smtp-Source: AGHT+IFtRN22qv69nI2ml0edr7xni3Qv1IfxeshkW56bK6vvqjOxCT2HSRC1OhPkkQfjyYg4ysIOlQ==
X-Received: by 2002:a05:6e02:1189:b0:352:a2f8:99a1 with SMTP id
 y9-20020a056e02118900b00352a2f899a1mr10449814ili.25.1696720394467; 
 Sat, 07 Oct 2023 16:13:14 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/27] pxe: Depend on CMDLINE
Date: Sat,  7 Oct 2023 17:12:32 -0600
Message-ID: <20231007231255.277623-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

We cannot use PXE or sysboot commands without CONFIG_CMDLINE so add the
required condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f914da6fe1ac..f9e023730c53 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1995,6 +1995,7 @@ config CMD_ETHSW
 
 config CMD_PXE
 	bool "pxe"
+	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via network using PXE protocol
@@ -2230,6 +2231,7 @@ config CMD_SOUND
 
 config CMD_SYSBOOT
 	bool "sysboot"
+	depends on CMDLINE
 	select PXE_UTILS
 	help
 	  Boot image via local extlinux.conf file
-- 
2.42.0.609.gbb76f46606-goog

