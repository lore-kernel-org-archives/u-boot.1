Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D360FC2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 20:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08DB78756F;
	Mon, 20 Nov 2023 21:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H2WcK8mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3C887572; Mon, 20 Nov 2023 21:17:28 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A98874FC
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 21:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-58a6ad82b07so2622657eaf.2
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 12:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700511444; x=1701116244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=aqJv12i3QgIWkrC/I4TWf4jPcOqP+3aAAsWyfR7CuYY=;
 b=H2WcK8mz6afltabcZeN7BJIVjiUGdNftI0LlioLGvcNHs9GjXebFlQzXLymQbsGoJk
 zqErdLfYp2U4yIDrv+6mViScQ6UGc5Dllm9GfkNAxveON7uvs+t4wDcKoE1QbGM6zSuj
 I40TAU4aDLImz/IuaChWzHrVCr3F6ZENjNk20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700511444; x=1701116244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aqJv12i3QgIWkrC/I4TWf4jPcOqP+3aAAsWyfR7CuYY=;
 b=bpCKFkW+wemosemmVtZgRaKnAcwOcj84FQdisVpWiloAGwoQjpYArGIFSC/2h7C55w
 tgyj0qdkUQbHnVxN0W9Dq7tmeD94zD+g4YVwIHD5wqyUiIq5fHQbYEXtqfBVxGkX13jn
 fiNdGZKFc7Z4nDMFXCawUbANr5fk43Ft6t1HweVtA/eRVkQF4436VwtTZ7nbF0KiRXIq
 7iLeXa/2pH4gr2pT8LkKZLpqF+VIoafd5Px2bldjNRzaAMI1lJYkl3lnYFG5LjuGtDtB
 Sgdr5FpPrZWs6ZQPO7Jr5CqIZE2imF6NJuQn/nU0f+i6qbMc5x/hV6vEcZiXJ4Rzb86i
 Z/yg==
X-Gm-Message-State: AOJu0YypwKMR6DtVaUwPa1sGx7eCK5T9ovoJPABAo9G20TttsYRINfzt
 /jAN7kz1GsSZREObMzxvkOQ9La+7M+kIq0Yo7A6xmw==
X-Google-Smtp-Source: AGHT+IFpWI8HIGhnBzKjGmWfLw0gnhgtmZfx1LDg0uNNh0GBlT6EjiQBcxl8nagWFUbjeIgP4NYygg==
X-Received: by 2002:a05:6820:619:b0:582:28e:93a8 with SMTP id
 e25-20020a056820061900b00582028e93a8mr9117086oow.3.1700511444739; 
 Mon, 20 Nov 2023 12:17:24 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6bdd-4a9c-acaa-1ce1.res6.spectrum.com.
 [2603:6081:7b00:6400:6bdd:4a9c:acaa:1ce1])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a0562141c0600b00679d9324ff2sm1186591qvc.77.2023.11.20.12.17.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 12:17:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] lib/Kconfig: Correct typo about SYSINFO_SMBIOS in help message
Date: Mon, 20 Nov 2023 15:17:23 -0500
Message-Id: <20231120201723.619989-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The correct symbol to enable to have SMBIOS populate fields based on the
device tree is SYSINFO_SMBIOS and not SMBIOS_SYSINFO.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 19649517a39b..d47df6bb1cfa 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -995,7 +995,7 @@ config GENERATE_SMBIOS_TABLE
 
 	  Check http://www.dmtf.org/standards/smbios for details.
 
-	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
+	  See also SYSINFO_SMBIOS which allows SMBIOS values to be provided in
 	  the devicetree.
 
 endmenu
-- 
2.34.1

