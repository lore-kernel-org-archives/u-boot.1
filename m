Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7992FC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB4BA87787;
	Mon, 27 Nov 2023 14:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RTnLHKlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B98787784; Mon, 27 Nov 2023 14:01:35 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90A787768
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so5884423e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090092; x=1701694892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WkBVcZ1MWvqwAIrwXPVwtT1d15U9Mmk77jaWthOKI7k=;
 b=RTnLHKlJjQnFU9jQNtepHa4pX0OmowwMFp2yE+wj8i9nCJaybkRe7TaJEON/INCgW4
 p7xJCAqZoIOhqKlD11wnSvIoIDFge3uSJhgbJgZKdNLico8wvQ0EW1G6Rx8iPdEMCj3Q
 2ZmYXp1YqkLQnsTjK3866pr/MMBKpoN/KeOp/KBp+fqWNnof+FkhKnkRdo6gdGo3eV9i
 nQ2Y0xpVWzNL75r3AjyyWlFfZ1HrCoPXqc8byUHXTV3uPXo86wL6dFBR+L+tXd4m/DQJ
 mK26IctWey9p+peFZ8S9p6Pi+qPwZhO56tvahGUrLrOV09yLsk9hvrN4/fngQC951Pvg
 wMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090092; x=1701694892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkBVcZ1MWvqwAIrwXPVwtT1d15U9Mmk77jaWthOKI7k=;
 b=DnViRXkMfLA40g/N6kpmXTjviJK8GRdy+GBkuKK5HZJhDmno7Zux5POY6+ZsO+1tyu
 Q13/1UgAdo2ADf3d/UTQyzFT534uFqbtaqdsyVD5ubmjh4EhIhmNjYLyMiPD5V1qoCiv
 DgLkTPvEGoVKci9RRuogQ01afFtXEMMFbCXEV5sO0bwNpo9rQfTJlHr1Uap2rWUzZTGf
 u5jQUsayQQL75fA46E20R6Q4w+gVOxZ3ctDT4Bx+UHYiA2MCKR1+/bJYCByz2ISXo+LD
 D0q82OHb5WcUJp+FvejN4ybynE139itlGt/ZMxs5XGlbJLaNZaAR2dLeh6yNIbAELJWb
 r77g==
X-Gm-Message-State: AOJu0YwNH3uCTRBZ25mLG2VM7K1se66ntF83oTcV5jD0cmzWW+1YHKr0
 5FsrAVtQG4dgiCY41flzxh23L4WtY/5yYuxj4AgekA==
X-Google-Smtp-Source: AGHT+IEt2DXKiC7V8SAbS4ymGQ54tDHN+I9k07/r0zb5Zfs7snaStCEjsZNv0137/8n2KuR/tqFffw==
X-Received: by 2002:ac2:5473:0:b0:50b:a82f:8576 with SMTP id
 e19-20020ac25473000000b0050ba82f8576mr4765078lfn.50.1701090092400; 
 Mon, 27 Nov 2023 05:01:32 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:32 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 36/43] configs/gardena-smart-gateway-mt7688_defconfig:
 increase size
Date: Mon, 27 Nov 2023 18:57:19 +0600
Message-Id: <20231127125726.3735-37-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.
  limit:  0xa0000 bytes
  actual: 0xa0f54 bytes
  excess: 0xf54 bytes

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/gardena-smart-gateway-mt7688_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index bedc596910..4a26e6bbe0 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -25,7 +25,7 @@ CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
 CONFIG_MIPS_BOOT_FDT=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=655360
+CONFIG_BOARD_SIZE_LIMIT=720896
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-- 
2.30.2

