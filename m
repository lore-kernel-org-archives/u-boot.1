Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E4BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26FD286F18;
	Tue, 17 Oct 2023 00:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OFYvPljI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DEB0868C1; Tue, 17 Oct 2023 00:32:02 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C0E86E2F
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-777754138bdso1536685a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495500; x=1698100300; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sd0DCqtFfkJTWG/sbLJRWZvb77dJYwFyWwVYjXwgOQo=;
 b=OFYvPljIhtoI5m3hhuoJBVRnL5u805Ag71Mrik+nirKRyoDTnZrDn4c1pgfMdJAgDD
 siF7uYIoGFnTCBqSIr/qsiske3zfd8XOZ57ChlFX0rW6bc5ZUl7UEQCTvw9XDUGUObD3
 yDGgegqw2EfpdswPLx338xuObG7ORgWbbIqGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495500; x=1698100300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sd0DCqtFfkJTWG/sbLJRWZvb77dJYwFyWwVYjXwgOQo=;
 b=RL02sbmvBANFveph1hWa0KD1Gzvdd9k4EJ7vUE5dWuCbpVMEWmENR+/eQlZVPcEERb
 8n84CZUHqN11iaM3CkgtUue4IdnkeGKpTYHJvvKJguZokBYfx6jK1fZLAagVpo9n3O4+
 l2s5l5jTo5rOBOF0b6pxDMjc2qVeG75AwsDjY1ZCylUlKIkuUFRflEcgxyUuzvL1fKGm
 0Uj3/r9OI3Auw7XuM3/vZQ1YtFOT9L20O9bFf8Cjg9brlrlwGnRaA1E1rTHZAJlZ1xY/
 1UhRKF4F9PhkPKU3gdGJif0rVOR6skwCuMfoFeujWuf9GbW1xkWQjpSavbJf6Uu4kV33
 08hw==
X-Gm-Message-State: AOJu0YySIMJpY3Xl76oVOLBYT3KsebO7vNUtYy6PXxbZWsN+qPLOmGlP
 2x1rN79VkrXwZCcsLkaoJRhgjdCxw1Tlwd6wt87w5w==
X-Google-Smtp-Source: AGHT+IF0kAyuc5qrGlgoziiKshBs0lWeay730oo8Ur+XfMA/9AGJADDB+gJpZf+gCM1nT1NJvRTbtQ==
X-Received: by 2002:a05:620a:1712:b0:774:13e:71cd with SMTP id
 az18-20020a05620a171200b00774013e71cdmr594515qkb.56.1697495500455; 
 Mon, 16 Oct 2023 15:31:40 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 20/32] efi: Make commands depend on CMDLINE
Date: Mon, 16 Oct 2023 16:28:11 -0600
Message-ID: <20231016222835.596572-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

Most of the EFI functionality requires the command line, so make this
explicit. Future work could adjust this, but it needs effort within
the booting support first, like the bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---

(no changes since v2)

Changes in v2:
- Adjust the depends on the commands, instead of EFI_LOADER

 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c6ea5c860e33..46e484fc08b6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -384,7 +384,7 @@ config SYS_BOOTM_LEN
 
 config CMD_BOOTEFI
 	bool "bootefi"
-	depends on EFI_LOADER
+	depends on EFI_LOADER && CMDLINE
 	default y
 	help
 	  Boot an EFI image from memory.
-- 
2.42.0.655.g421f12c284-goog

