Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B9F109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35D18408D;
	Wed, 25 Mar 2026 20:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cy5NGT15";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870FC8407E; Wed, 25 Mar 2026 20:00:37 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E4883FD9
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-466f1c3c627so84596b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465233; x=1775070033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oa7FJUEb1su0T4NC3xW7HcXloSLk7XOFGPmAhag1oUw=;
 b=cy5NGT15JX9kPCD77atgfOW8CHbCZexloKe4So8WdYJjodWbLGoKQZijdwjpn7sf98
 8+3WRlcAaj7VDmfv2udkSGJB/v2Pd5h8mz+9pigoBc3VzFfF1jbT3eEean1Ulq0bw3qC
 JLosQiNpgctlkBVSe34oAtuZp4WqNXVK48TPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465233; x=1775070033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oa7FJUEb1su0T4NC3xW7HcXloSLk7XOFGPmAhag1oUw=;
 b=XMqmQ3rBM1sUlywvj/Nmz5AalM7Zw4o2ByZDynfn6RHNOM/YYTqZjEnwM2mfc/Eznc
 bd1ylcw3BnWBmJIZ132AwGx5WYnQdefaQkw/JJugqlN0ua9XIqjFCp3Kjd2ENo//Gg9y
 yOZc1yxmAnXif3e6BrZYGyr8lkbKobpWX24Ua9OCpPRQY2j1EwfbXpBFIgHPvvGZ21Rr
 SOzSaF1OHLo/8X4GmPUNyZrOwUiTYdsNUcaCiTCUBdrZee26KMmOegTKJkNsnPPdGdmV
 u/JczUI1YSsnNtaC10inUoFXfufDte/+y0dgjPYfUbunuy5WgBiKchEP8MRXwcO7c3VL
 bC6g==
X-Gm-Message-State: AOJu0Yy/aM5+ejtvHs1qh88NcP5qN6T3oxL7p1tLqlNme6guAOqx3wj+
 zaCVD9S9jwQQ+nCxaAppsz5T6SuApljqe3WWLUJtaBvfCsM6U+dtptrYZzaIxoIObsAPyVuEJZG
 2hVmd8F8=
X-Gm-Gg: ATEYQzxLIaWJcmkf/2ezUz9fciHl8JKs12BVyYogKhO0uvIoR8HZ/IgRgTtJGyVFHRB
 LEcV3PsDpjXhuNdA6MIpuoqHu915tljzoj8azRR+ZCBWmoSu0OwqYx35ekbrfETY8B8XiAtSD0P
 bYTX1A9sYeX0VcYGBtEM9r8IB8SV09DhroE0S3TxYpL+d54xapE5nhiEt+ru0wcpIRDjvlHxEkM
 1BLfCeh6OOKlg9xouLq06LMLJ3qTJqlXa680+UaOAvJzyiU2qK2ywWT2YrgYBKCcbxdWZgOqMF3
 nH61hkn+8D+/qOhzxvEpPF1uyTqluQCZZUFeHcDEhvdlGziP/sQl+JwuNur9xfGlqVIJTHrQNOc
 0MsqW4aRDx/Mpz0p0mvQrCdPCmgchJQG+zUkAOCnesMGr8sj+7q4IUJaA0pSrnC7bZ9DbIP7+Ue
 s3TwoVjFSuZkENekDwMV4h/NxdggqmL344RsuRDICiUwvER/Cl1/CU9ryFZ3DKfbWJLagKM50Tb
 XTUKRTlNAAogildAvSSZ+7zfXQKaLzKO2RAVWbvM44TeSjKjTk=
X-Received: by 2002:a05:6808:309b:b0:459:bcff:a9ff with SMTP id
 5614622812f47-46a5c70ebbemr2582165b6e.34.1774465233085; 
 Wed, 25 Mar 2026 12:00:33 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a70adc611sm204147b6e.17.2026.03.25.12.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH] s5p4418_nanopi2: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:31 -0600
Message-ID: <20260325190031.3428654-1-trini@konsulko.com>
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Bosch <stefan_b@posteo.net>
---
 board/friendlyarm/nanopi2/board.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
index 4dff32e10d6b..ca8ae529ddf4 100644
--- a/board/friendlyarm/nanopi2/board.c
+++ b/board/friendlyarm/nanopi2/board.c
@@ -406,11 +406,6 @@ __exit:
  * call from u-boot
  */
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	bd_hwrev_init();
-- 
2.43.0

