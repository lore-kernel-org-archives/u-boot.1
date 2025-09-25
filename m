Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F4CAC5B5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9EB832AD;
	Thu, 25 Sep 2025 22:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h/j6mwf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6138B834E1; Thu, 25 Sep 2025 22:51:36 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA19835B3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-35bdcaf79e7so1131840fac.0
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833493; x=1759438293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rIPZ5Cc9g6zPYIrFENlD7eXObdl8uq06lk7gYo7ed/4=;
 b=h/j6mwf3rgxyXbIMCnRKTZNC4KnffaxxqVbvWwm+MU/stZb52Y154pfRqT3Eyw6ZV1
 DK84TE1o3il9Te9jG4mMNwfX2VYFzAdz17L8wB4K7fCpfRpMozF3u1mFbOMwH0oc/+Dg
 nGXey/ECA5X6nGRPVqjLU0cVuZcxNv2tWKUVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833493; x=1759438293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIPZ5Cc9g6zPYIrFENlD7eXObdl8uq06lk7gYo7ed/4=;
 b=n0pXmHEIJq2UgOpNTUTWMQQKdvIHXtChYqRn1hNabqXGn21cxS+NmrqQmrZbaYAcNy
 fbQErAKpWX/oJUpct5CQRRaEQ7RcykyCkmrpaX5/EWdrxddBLM+4l/+DtCnfhuOSbBIY
 NoTA8hqR8zzLqMbMDHKdUMdYA17/lowuordYqfmPxLgSUWJ5mwXjjjTQ7PZScIcO/cbr
 gCvgmwAK2by+BEdibKJsRvC5qkxgldov8IQ+HMa8DmHOkdyFd1RBpiZZh6W1VfdSN5Vu
 Vw8pWpUFJ9NNNytXwl/nnqEAo87+3k95n4dAoUmRATQYw5DlhgxqlnG7FvkkbuUn2xcH
 gQkA==
X-Gm-Message-State: AOJu0Yx3ENhAJ9oGkhA1jXfQcukIVhYB/AX+NLPRIcbov57wQg5OrMlX
 kSg4gqLNb+gkHJ+ikLvCnoTICRvCRPJsmtPWzK/AfHXqbxNmJivyUJbeiqV7zDVB6BCJdV7bfFp
 HOxTGyP0=
X-Gm-Gg: ASbGncs8aqeEiNDwNj+3Kc3PeEqRa2S6Lq33EMJQUBWLWronAaKiXFtXzImWzxfpJRO
 DgctAxw8yiDfqzPf7xhF9S92vqmwGY4LgXMbnxzhK8imoEPvlzVCWgkcjystjQHVzkvFieUO8F3
 HWE8gSZQygehklPGfvkZfTjUVINq/KiAVV/AulrZ272ekTmqUnCXtuyjHPe+MjrlB81J821Stda
 UAyqTFAD3a5hEbX9UCH6Btoqd1QGM+2PDNggTxYmGfsmasjRdG8SJUgumrMr3g8DdFLD8WAPh8H
 l5mEQPoXd+7F9pieHe2NcuJIFdkCA23Za6+vlQ2fEVg53dNM8ySSIkwLGnlLGTnRT6SGXCdq0ED
 T73e7aAOpFvCDbfwT6gZ31w9WNKwCgfg/aoZjv1afc4u8VUhR3FL2AYJkDuYlVmMqVq1Y9g==
X-Google-Smtp-Source: AGHT+IGpwtFUczrDZm4RIZw4yvF0fFAJ9FVfG9xawnEZpbLyqldaGDN8yeOUAP6nXb3Cbi51vORaYA==
X-Received: by 2002:a05:6871:610:b0:331:15b8:807 with SMTP id
 586e51a60fabf-35eea4720ddmr2845859fac.41.1758833492760; 
 Thu, 25 Sep 2025 13:51:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a3d461e4sm842554fac.13.2025.09.25.13.51.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:51:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] cmd: Make CMD_MP depend on the CPU framework being disabled
Date: Thu, 25 Sep 2025 14:51:30 -0600
Message-ID: <20250925205131.3561949-1-trini@konsulko.com>
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

The CMD_MP (and cmd/mp.c) command provide a "cpu" command which is
mutually exclusive from the "cpu" command provided by cmd/cpu.c and the
CPU framework. Make CMD_MP depend on CPU not being enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3248583b4e85..c457cc8e5c42 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2425,7 +2425,7 @@ config CMD_SLEEP
 
 config CMD_MP
 	bool "support for multiprocessor commands"
-	depends on MP
+	depends on MP && !CPU
 	default y
 	help
 	  This enables commands to bringup different processors
-- 
2.43.0

