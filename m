Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7DACD6E51
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 06:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40DFA83DA6;
	Sun, 31 May 2026 08:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="mgld09Gb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0617840ED; Sun, 31 May 2026 08:41:06 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A7A838D7
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 08:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780209663; x=1780468863;
 bh=9Kpo4JsCu2OiY/kZ64ijoUAcrLyjXw4zylylsuCsFSU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=mgld09GbNWUOFlgNWDxLzuO70cg6M0n5ya6Ie/gW9pldb1gEYt2WCj5VZYeo31BT1
 +jk+f8wJLq+ch5mj/3vidfgfPx2DFynlU8GqkSZaQkErNNy9e+y1E2NKvKUgDo+hnv
 D7bBHwutJq1i4KJ6M46CUDLbKtbczcbGAMuUl57oTlbDNXXqeBhI8+VyVlrjGCPwnG
 zbmo208Mpsb8IB25JAp6Bx/g/rHo+s6ayh+SQ8X/lMQ6cDUjZ3EoCSl/Et8EQnkqPQ
 ZhPo5xh0q2H3qnB3NbIYicNUhMz3bCR6E/1GmrcMySg7khjdPUNxKdAMS6mXOQVRhF
 eq5CzwC9aybog==
Date: Sun, 31 May 2026 06:40:59 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Sam Day <me@samcday.com>
Subject: [PATCH] board: qualcomm: phone: fix 'Dump bootargs'
Message-ID: <20260531-qcom-phoneconfig-fix-v1-1-110a1c542dc3@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: dae7577573dc6f4ba717e8c9288a2461cd507126
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

This menu option wasn't dumping /chosen, because no FDT addr had been
set yet.

Signed-off-by: Sam Day <me@samcday.com>
---
 board/qualcomm/qcom-phone.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
index e91ae3ecdfb..d1c586bd3fb 100644
--- a/board/qualcomm/qcom-phone.env
+++ b/board/qualcomm/qcom-phone.env
@@ -39,7 +39,7 @@ bootmenu_5=3DReset device=3Dreset
 bootmenu_6=3DDump clocks=3Dclk dump; pause
 bootmenu_7=3DDump environment=3Dprintenv; pause
 bootmenu_8=3DBoard info=3Dbdinfo; pause
-bootmenu_9=3DDump bootargs=3Dfdt print /chosen bootargs; pause
+bootmenu_9=3DDump bootargs=3Dfdt addr $fdt_addr_r; fdt print /chosen boota=
rgs; pause
=20
 # Allow holding the volume down button while U-Boot loads to enter
 # the boot menu

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260531-qcom-phoneconfig-fix-a788b1c1538c

Best regards,
--=20
Sam Day <me@samcday.com>


