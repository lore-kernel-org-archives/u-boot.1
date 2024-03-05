Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781CCC48BF6
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 02:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D566087FF5;
	Tue,  5 Mar 2024 03:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dKdsVkyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74CA87FFC; Tue,  5 Mar 2024 03:11:39 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629ED87FB1
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 03:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7da6e831972so1202292241.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 18:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709604695; x=1710209495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdFbbPv/TJAsum3ekKSU6dSLYv8sbyyiRpPnLd9rDSk=;
 b=dKdsVkyW8SlTkndYtTG6NEIiJjGoviZjHX1uxeuXe/+7his+XezGLULIoDDrWm6Opk
 GjTraNMjrBH5qnrfQIMDb0ALfAgdyZ3cB3DAzaTS+KGOn79RR/WUFnobPoWtHjb7Zhnh
 fZ8EKmmDcR2kl7RghAn5js7dKuSbklfxcGPWCojcwLWxKBl8H+QGEff5VDryluS5ocK1
 2yD7SSxXRXBldIyjfBeWQ3W331RxsdB112oasFpILzzy0dKqO/IjI4riIyrqymND9u5E
 vZV0iZ6YO3QDjvicvSeMwp2Gh38nKqULP9alKqxaZiD80FM0wzqNDpmYZzaKN63eOStq
 rEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709604695; x=1710209495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KdFbbPv/TJAsum3ekKSU6dSLYv8sbyyiRpPnLd9rDSk=;
 b=P/FzEMCoi1uzQSgOqUd9FpRszLWtNm+zY/am0JA3+K5l3WJUq5AGIHBak+whdLxsn6
 K92bcsaIizmQ3qUEMfNY9X/eBbR0N6t2Uf5eLphA1X2rghDT3k9HigKr90U8txP6QYnC
 6eNUtZ5Z3BktWVKhoXVR7FNaGHofSW69lC/N43seJBDdT0CM5aO3E7TsBmmvIg0YPnHS
 kLeoTHAmYNCXps1fXpmKkEjhXaNc7pBH6JDPJCci+PciGsGP6qv7fi8adSRQFcan1Qw0
 2MXmX4YHC/X/whiN/a53yar3PXGd+DTjnmClJayVOJFzIuGwMekfMltBAuMrwixFOiUq
 NXRg==
X-Gm-Message-State: AOJu0Yx2lHJqw7//D5/hUT+CsWw/8a1Dyeukw+uAdS+2DjdiLo7VbNii
 cacu9mCQHj4/MPIClQrMtKddudLWAqfSzQ7YmB/HYgPCaHR8W5MGrgtoY7EvOF0=
X-Google-Smtp-Source: AGHT+IFtWH7qWeOSn3/5jLQMhhqzz3NYNvUvyuMeTqlIwe7iDwFWKIslMvzkNSFZBIoq9knHT6fUrQ==
X-Received: by 2002:a05:6102:510f:b0:472:7619:1a67 with SMTP id
 bm15-20020a056102510f00b0047276191a67mr746619vsb.3.1709604694754; 
 Mon, 04 Mar 2024 18:11:34 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254]) by smtp.gmail.com with ESMTPSA id
 i19-20020ac860d3000000b0042ef122e15asm1558534qtm.12.2024.03.04.18.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 18:11:33 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH] configs: rockchip: rock5b: enable environment
Date: Mon,  4 Mar 2024 21:10:46 -0500
Message-ID: <20240305021051.22405-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
In-Reply-To: <20240305021051.22405-1-twoerner@gmail.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
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

Following the pattern of other Rockchip devices, enable the U-Boot
environment to be stored in MMC. This patch specifically assumes the
environment will be stored on the SDcard.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 configs/rock5b-rk3588_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 0595325e8107..64a242003aa1 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -60,6 +60,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-- 
2.43.0.76.g1a87c842ece3

