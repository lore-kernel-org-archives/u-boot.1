Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172FAC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 15:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705D682162;
	Fri,  9 May 2025 17:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCi0ZRBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9700282A0D; Fri,  9 May 2025 17:43:11 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E54E82991
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 17:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-878af63c5b3so1144837241.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746805388; x=1747410188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=89HzNYESpvFwcSdwgJ5iSSZfjITzazGD4XWXF6cIH+o=;
 b=TCi0ZRByRjC8VoQAO+2vs2N5Ibq1mVuMDhuxgY+fKS8pOU2mx0hirpXbaSa5W3VoOe
 smXi9WXxhuQ169JAFpTbN8yeism3pd/FZvAHvkykWOciioyEityfZy3BYMlPCphdSKSd
 Eow2RceghEV71PhC067ad04LM6kxPiUYSSoTgTwT1sFjoodT6WEjPnSuHSPsdcH2hpPb
 7baYsjAlNFqKBps7wywWpIr2Q7sOqi8mBWU7QMK1D2fgvGhJ5dqMfoCY25yYQqtQMh/f
 sVT5zQS4XbCt6/Z7XXbbAEOIGz7kkdxM/C9bWiTujoO4eii3F6FlTwFGrfZMn83btVkX
 EfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746805388; x=1747410188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=89HzNYESpvFwcSdwgJ5iSSZfjITzazGD4XWXF6cIH+o=;
 b=itKvbadJhSC728wF36seMpoDpQq6P+XC8CsECl/cGaYg0rVeLYkXINg7HI5N7/dkeU
 XGDEKLGEUDulgZDbSKqoo9K7Bx9agfH0Ztk7Zvt5cVLHh6qlLVgHMAITSyRxgvAthK24
 P3plurqRRXJcjwFPloxnwQb/UEyVOUdXUUzfDWBbk2nF7oymoabgIPiTSTMTOakH10zp
 8UduGrUVbnqfhoj1cMQ2AmfSVthfNossmfRI1EHmgoBU91duUY8FVizEaYOI2hHAvM2u
 Eod0hIPLPrqY/BMhz0p8oNFuGsu5GBsS07HGHvFfbbUys4rSwPuJhhdHB1GdyTV3GMqQ
 CEew==
X-Gm-Message-State: AOJu0YyfqX/zleozfCq4FZnGq2Lsi2b7aTfTw7T7SNjnB8ap6SgjUtpU
 cUaI7bd4VCWb35Q/3s8MjeCkAC0ByHYjHeOov4hkRzilE3KSsc/vEDyBn1bn
X-Gm-Gg: ASbGnctewUzp0zgc/Bg4ouV5EGCc/TONM1k5SVn76T5el33tcwhLaC4xJLSpkpZRbHs
 GD/XjUaLc56RyjSTX82DoJQpS3dceWHmljRuHKQF9Y+vueLZPdOKqmMGbaEFS9xZ502kLdgsh6n
 5DC5I8EtVKrJK/h+ws/5lNBuJEMSA7u6yHlRbjHkfNfzNEmfdr6wPpwKzHpU7S+hKFzXOn/TajK
 vYFjeb0q44fp5WqQmvs+ZsYSZkvCIJ/cbVytBo5eIl5rDhQha+cJXPfzUW1NZoSw3K+K1wVVXrm
 ipADcUrWDU1QaCUGbOmyKlclP48PjWljyzBhDSKmSlaRk7Sh9C6u
X-Google-Smtp-Source: AGHT+IHnNjBFCusoq5SHHFjFr1b1ZMVzYsRvxasLsmkspyA3wED2PLvV1fqXw6ckZAt2F/6XQxLx+A==
X-Received: by 2002:a05:6102:5e97:b0:4cb:5e02:7538 with SMTP id
 ada2fe7eead31-4deed3e8a2amr4175644137.22.1746805388231; 
 Fri, 09 May 2025 08:43:08 -0700 (PDT)
Received: from adriano.. ([2800:300:6f54:8180:9366:b0c8:336a:d2c7])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-4deb203c1d4sm1303285137.28.2025.05.09.08.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:43:07 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/3] cmd/Kconfig: enable wget on qemu
Date: Fri,  9 May 2025 11:43:51 -0400
Message-ID: <20250509154352.3483523-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250509154352.3483523-1-adriano.cordova@canonical.com>
References: <20250509154352.3483523-1-adriano.cordova@canonical.com>
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

select CMD_WGET for ARCH_QEMU. This way HTTP can be tested
on the qemu platforms in CI.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..fa353c6fcac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2153,7 +2153,7 @@ config CMD_TFTPBOOT
 
 config CMD_WGET
 	bool "wget"
-	default y if SANDBOX
+	default y if SANDBOX || ARCH_QEMU
 	select WGET
 	help
 	  wget is a simple command to download kernel, or other files,
-- 
2.48.1

