Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCCF7CCA471
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DBB83544;
	Wed,  1 Oct 2025 22:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y3BGwxZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B10A83544; Wed,  1 Oct 2025 22:30:37 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4651A8328F
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7bb79ad6857so175510a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350634; x=1759955434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/eE/badhfGuLvkHknmDwSxvxnUsol0N0mBZNhb1IV6g=;
 b=Y3BGwxZ1SpJahvwpre6uiJDsk+SWPNqW4vrgknwNlMQulASXYmm4b/x83fPzsUr8k8
 Q60HnWtdi7aNBxcBWdnvXbo9RQri/q1dTg6QIHgPT0lL67aDPVjk+iq4xFgKAdBU30xa
 Ggp++6saj5Dv1QSno+63DjJPngZJI2AD4pNsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350634; x=1759955434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/eE/badhfGuLvkHknmDwSxvxnUsol0N0mBZNhb1IV6g=;
 b=NZRxKjeoSdvwtfbKN0NIu/2IelgM01umjaQM3u8Ta0gSGuGgd7stMsm+LKa9trX7ih
 /4oyZJnT9av3WyZ/qxfhCA4ve9mhBM3t6NlCbQeAs27PhMqLht/K4+QzLRO7/kemfHP4
 0HSYBN3YGYgsE7KUoODKhOoK5gWTcvfXjRiB59pN0Alh1jnrMeEtJk5u3ScAgsV5WUSx
 0KChSwnUTP/LNf7VtkSq3n5J3KAwM6aCGND+PQ0MAp9IIiR8RvF96nCQFF9BxZjR1Pc8
 Tpxzj1OYtk/68PjHX6F1twRXg9WuKkyhmh3tkKVo00A2IbOLuUfSMPdIgLkZc6FVWX6h
 M2cg==
X-Gm-Message-State: AOJu0YxDNc3uuPuwJdyMbc5Ca7bhJVxlePYu2TMREXymFFqf/QM0dKe1
 yyR5N3eW205OgStS8iLEcQg+aZ7aUjXEiFxWAd5C7PcHG2mtrAK10NAHV8+Cj/CLlcAsK7Xvc0T
 sKxhuG9I=
X-Gm-Gg: ASbGnctSmsBEp37tgGJNzcJo64sqS7ZFJDkDd0nxtYuXQ4ewk1O9jHB21qyRsjYb98z
 faxIKIEsQVS8M64Rn2NKhWF9dSVAE4vk1mBlNtlj0zgsUv308N5llT7Cwx5Pk2l4n7m9Xuw2Mcr
 92P1tgMz+bqXKbjSSmzlYvMGbcl/1e44gL6bs8FXtxpSR7es+gYSnFwi6waLeW+hnchv5dou2R/
 MEtDixkrEPZwOmspMaNbQqm3xwMtqiUS62KLk3CrHmJEabtTyV27aFuUV54E5UM/qZoimppErdA
 wC3G2xVKRYtlviEvUWfp7nuVvA7OhKHoqZYcRBxdb6470ItmEm1yArztFFYWZ3Sj0tggzPfbM4J
 F9ZqrkSnNAqx+38h27llbq4Q8mxi6EotO2E5zr/Y/1JPpUXLvzPyvAYDCl4FaA7uyZkI8cELzLH
 7E4ppPXiHAD/4aUvZzQw==
X-Google-Smtp-Source: AGHT+IFBbpm9x6/LoL0J1dfFac+Haup6kHxZleqTqn8XNQeTcq+sTDUiopFUvVCim4XW3fUZYtOyWA==
X-Received: by 2002:a05:6830:4998:b0:758:85e2:9a00 with SMTP id
 46e09a7af769-7bddcf0e13amr2805265a34.17.1759350634005; 
 Wed, 01 Oct 2025 13:30:34 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf43404d82sm115304a34.30.2025.10.01.13.30.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] dts: Set a default value for DEFAULT_DEVICE_TREE for SANDBOX
Date: Wed,  1 Oct 2025 14:30:32 -0600
Message-ID: <20251001203032.2828213-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As part of building with "allyesconfig" we need to have the correct
default value for the sandbox architecture provided here.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 dts/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/Kconfig b/dts/Kconfig
index c8bc5232f9b7..4e2622d48d04 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -215,6 +215,7 @@ config OF_OMIT_DTB
 config DEFAULT_DEVICE_TREE
 	string "Default Device Tree for DT control"
 	depends on OF_CONTROL
+	default "sandbox" if SANDBOX
 	help
 	  This option specifies the default Device Tree used for DT control.
 	  It can be overridden from the command line:
-- 
2.43.0

