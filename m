Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5509CD6E4A
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 01:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C58E8405A;
	Sun, 31 May 2026 03:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="mucJDM+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FE18840CB; Sun, 31 May 2026 03:18:43 +0200 (CEST)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E248404D
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 03:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780190319; x=1780449519;
 bh=CyBaxpH8hM1QY7X/1/Aox6pXyj64EZf1qDUIfZrHYjs=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mucJDM+toYVX6GKFGmEytKqWalwBlLHRm8XDRsJF2plQM7hQTyQatISug5aLZD2rY
 oTOjzUpdJM+A59qwxeH6maeWDzWUtcnb63f5fishsjYIz+NPKJMyDx7kezYD7hTE3c
 oLfm/NI1M1AS7/cTEceeGyjT6TzJUJ0CngDpCeT3YOmXStxdWFPrLo4m8BsMnCgnep
 JTuQE/u5oRah5jSg17UPAZxrEsEIN/BZUB+SsirIscGzwB2wMWsvIA6JZ6npx6PqaY
 s2DVuVnZd0wIokenejX1fopLsE8XhazL5wqk6pkJG+xOQU4iB37CxQMEjONJCWbmaA
 RXFNbcCVqDiPg==
Date: Sun, 31 May 2026 01:18:34 +0000
To: Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: dragonboard410c: fix chainloaded.config
Message-ID: <20260531-db410c-chainloaded-fix-v1-1-94176aa147d1@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: b199dfaed3fea5c5a78879c2f8bd3574c2497854
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Since c8a74db0c, SYS_INIT_SP_BSS_OFFSET only supports hex encoding.

Signed-off-by: Sam Day <me@samcday.com>
---
 board/qualcomm/dragonboard410c/configs/chainloaded.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/bo=
ard/qualcomm/dragonboard410c/configs/chainloaded.config
index 3fd064924a1..cf334d7ee20 100644
--- a/board/qualcomm/dragonboard410c/configs/chainloaded.config
+++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
@@ -4,4 +4,4 @@ CONFIG_TEXT_BASE=3D0x0
 # CONFIG_REMAKE_ELF is not set
 CONFIG_POSITION_INDEPENDENT=3Dy
 CONFIG_INIT_SP_RELATIVE=3Dy
-CONFIG_SYS_INIT_SP_BSS_OFFSET=3D524288
+CONFIG_SYS_INIT_SP_BSS_OFFSET=3D0x80000

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260531-db410c-chainloaded-fix-e3e5135b873e

Best regards,
--=20
Sam Day <me@samcday.com>


