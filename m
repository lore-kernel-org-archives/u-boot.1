Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22283C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 23:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACADF86EA3;
	Fri, 17 Nov 2023 00:08:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YtfLZaCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150EA87208; Fri, 17 Nov 2023 00:08:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB82842D0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 00:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 365303F275; 
 Thu, 16 Nov 2023 23:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700176093;
 bh=0Mv6iMf7zTCHLLR3IUTG7/OLAMnKILEHyyb8dX5a4w8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=YtfLZaCaexYx4SqJjWGC12xxIgkjtXP0EWEQtj9OtyzlvSNP9R488kznYS0G6WWmM
 2el5EakBBjv3ZbRqnK3vsF1QYBMfA5ZPzHTzw+pVLd4xypicNYd7puU5ELJxKX2rpE
 +N6PbELke50fpqp4KledceMZ9tAGFUsQDGxSivTrx5YUfBDFgDFxOepGfycu7/blmv
 l90Wi1XfCto7B4peq1Z2zRwn3QWXlWYgYM7x/+GEsWacqfoZrrJb2KOG1amsjBRuGW
 JV74aoVGcp047Y+tYDtOPDyRkrvOPdfF87sjG3OaQ3/JX1phiOa2LVKevZ+eXVuztj
 AXG4y7mpbuSgg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: eficonfig: create shortened boot options
Date: Fri, 17 Nov 2023 00:08:06 +0100
Message-Id: <20231116230806.20506-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The boot options created by eficonfig should use shortened device-paths to
avoid problems if drives are enumerated in a different sequence.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/eficonfig.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e6e8a0a488..3d95092109 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -528,6 +528,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	p += fp_size;
 	*((struct efi_device_path *)p) = END;
 
+	dp_volume = efi_dp_shorten(dp_volume);
 	dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
 	free(buf);
 
-- 
2.40.1

