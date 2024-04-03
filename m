Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F45CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44433883A1;
	Wed,  3 Apr 2024 17:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PDclYH3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD310881B7; Wed,  3 Apr 2024 17:34:19 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A6E88359
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 91F3D3FAEA
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712158456;
 bh=Uka5mu7DHyB3unhSbtw/PhfYpi2IlF3Xh1kmsr9XLP4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PDclYH3FUUD56GzzXJm9L+4IgWD9p1yJL81wQb/ruP5rR/BzlhlE0++YLvDS+pMpN
 3sacegjB/rvaO6ToneC11uwWwD8YPZArDKD0OH8v348RioyqZP+aYc4nxRWHL+0REi
 QOiR8MYcNgQ0TfbYNO/VFIA4PdI8QypsCWlfkDuYhpIZFGOPAOiiaxQtes3eKX1r3e
 Z4dgojKjlgxwdc7X+vwLqZpIdPjWuZzIifeVPbPTUfTppvXBGPer8lpDXxzDeNUYB8
 7/u5mh+sUV7wJeS6WGz5xTedhrucjBIXrSI/LtHX/X6PjEQCJKIuDYc/vnRB5V/l3C
 bBgd4XPhGhORQ==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4147f17da12so31861085e9.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158456; x=1712763256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uka5mu7DHyB3unhSbtw/PhfYpi2IlF3Xh1kmsr9XLP4=;
 b=sL8U5aR7Z256dbzCVSM237M4vR7bD14N6qN8UZX/TDgAlcVXeYAgUHNf0f7V/Q28tF
 X6aRPl7YRAicFBtVzvgGhuR1pDhWaRdIZmyag/Phi7P81ZlV4h3MwSeGV5ZXEMQHmsbd
 JVfTfom0+joFH1rN1gZgZ0KF/lkOjytbUMCPmbqqUFFKqaF+yRmDevTYWBEj6Uuk5d99
 B+uls61MmuQqSFO1O9X/oCrn9u00TOmvr48iKq4CAaNhzkCXtPVGC1SI3boMLn68WmNf
 8m4xhtsZ3lrRd/7qBQ5ewuU+/iQdWnqXEskEUI7vxKRygFr7JerEnzXZDdZf/9i2rTYB
 Soow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVRQmW4dOQzeKB2xHz9ICsjw7dBu2jI4Z6LDnqw1UwhjBWXtdrnwr6COx296399QF2t9JJ3GEyJ66FmW2YbO7ArZN17w==
X-Gm-Message-State: AOJu0YyE2loRKy0eUnSgKOXe2YTFrl4aXSL4Om/6I/O8InPBOt2g1gn+
 ZH0h3r4wbWOf6pdPPco9IUutRhM08/4u5Kzy0RMIhC5/t7J6VevKy03HintHxXUnn4tA+/1bhmt
 NJXW1d5lqNWbZJlHGjOCt4vBbtENK1uNwhY/olU9Vat8Lxsgfxn+6OLlgnDCyAsY+Kf4=
X-Received: by 2002:a05:6000:1371:b0:33e:69db:bf8a with SMTP id
 q17-20020a056000137100b0033e69dbbf8amr2237812wrz.59.1712158455973; 
 Wed, 03 Apr 2024 08:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxidQMAsp7J72OxlvfUd/oQ/5+jMQT30PXj0gjfrA+6tc36cThcslWpnzKavIQ8IHG2nZkmw==
X-Received: by 2002:a05:6000:1371:b0:33e:69db:bf8a with SMTP id
 q17-20020a056000137100b0033e69dbbf8amr2237794wrz.59.1712158455589; 
 Wed, 03 Apr 2024 08:34:15 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 cs2-20020a056000088200b003418016b04csm17585710wrb.76.2024.04.03.08.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:34:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] efi_loader: EFI_VARIABLE_READ_ONLY should be 32bit
Date: Wed,  3 Apr 2024 17:33:34 +0200
Message-ID: <20240403153335.96971-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
References: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
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

GetVariable() and SetVariable() only accept a 32bit value for attributes.
It makes not sense to define EFI_VARIABLE_READ_ONLY as unsigned long.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_variable.h        | 2 +-
 lib/efi_loader/efi_variable.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 805e6c5f1e0..42a2b7c52be 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -8,7 +8,7 @@
 
 #include <linux/bitops.h>
 
-#define EFI_VARIABLE_READ_ONLY BIT(31)
+#define EFI_VARIABLE_READ_ONLY 0x80000000
 
 enum efi_auth_var_type {
 	EFI_AUTH_VAR_NONE = 0,
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index efe17d98f5a..48ad813d79b 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -276,8 +276,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		/* attributes won't be changed */
 		if (!delete &&
 		    ((ro_check && var->attr != attributes) ||
-		     (!ro_check && ((var->attr & ~(u32)EFI_VARIABLE_READ_ONLY)
-				    != (attributes & ~(u32)EFI_VARIABLE_READ_ONLY))))) {
+		     (!ro_check && ((var->attr & ~EFI_VARIABLE_READ_ONLY)
+				    != (attributes & ~EFI_VARIABLE_READ_ONLY))))) {
 			return EFI_INVALID_PARAMETER;
 		}
 		time = var->time;
-- 
2.43.0

