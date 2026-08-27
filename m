Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE81FC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DAD96082C;
	Thu, 27 Aug 2026 19:54:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id owX6P6K28cjd; Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860454;
	bh=ayHQR4KTnOmkpHyK3Qew8zD2Lz+PHnPwIBq0E89gxc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BjCnafuAkRLRDzo6NBRXzFjiTmc89fpzRYEZP2Km7SR8EdDIjYPacVm8PSvqpRKhU
	 k5/PywsxaO0Rhd4TOcU2ps3kRS3Ai6vLG0p+cqQoVzykjVYln/QjeQaoOJDKVCzrGM
	 zXqvX8Q4pAwXAOl6uiMYx3NMU8rOq3JNYVhLl7QPEjwxWSS/aK3V+IZjFB+7l2bFWa
	 ogqsD5kDDWq1BTxBNGIkDxmgmJtzn3s3b3YgyWAuXHyOLQf0PxBA6nYzqLylEMygCU
	 A2IRs+a4TJ7ObBjmegVNGrXRFGeNmAvW2wrHVhNxWUvkuRjHwnI3IyaI8165Kjy+Wh
	 WbaqvEPdQX3fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 874CD60802;
	Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B79A4CBC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E42A400D7
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gzWZTJW4FM3 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::190d; helo=smtp-190d.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=jFyOI9kg
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::190d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDC8A400D5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:02 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzW6nvhzRKm;
 Thu, 27 Aug 2026 21:53:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860439;
 bh=ayHQR4KTnOmkpHyK3Qew8zD2Lz+PHnPwIBq0E89gxc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jFyOI9kgsF+UYgmfRsZ6LMRNs/vq0/cHT0/+ktea0cljZ9G4qEhYydtCG8/2+YDGL
 ND1YEulaLPcBH7edp0RRdulpuI6KKSZiN0WzFD10a9VaS5BOgOfkkAWG8HDL/dIcjt
 Cn8noKSbyqiuSQKNblevdxPJVWNQWnA52KCUaBVoGjZ52OQbCaXAUOpEPo3vRiUVjE
 67P8GZbHUhm76lJatYhvlu6QTF1yPiR00elJieFOeU9fGLZvrnZfG/i2QMdqapWElZ
 BHkhv1D57q7oFB0Rh9O6aOglly5ucuq+txNFTtl2VLR67Bonf7jYqatuY6kVAbIGez
 KQ1Ycmad8TNSg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzV26flzQKK; Thu, 27 Aug 2026 21:53:58 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 34/45] doc: board/siemens: iot2050: update links to files on
 GitHub
Date: Thu, 27 Aug 2026 21:53:02 +0200
Message-ID: <20260827195313.129994-13-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Quentin Schulz <quentin.schulz@cherry.de>

The repo got reorganized into multiple layers in commit
https://github.com/siemens/meta-iot2050/commit/db272a3508ed0f0226f6da5bb19e4d21fab55391
so let's update the links to still point at what's intended (hopefully).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/siemens/iot2050.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/board/siemens/iot2050.rst b/doc/board/siemens/iot2050.rst
index 37b23f6146ba..2c0a324485cc 100644
--- a/doc/board/siemens/iot2050.rst
+++ b/doc/board/siemens/iot2050.rst
@@ -25,7 +25,7 @@ ATF:    Upstream release 2.4 or newer
 OP-TEE: Upstream release 3.10.0 or newer
 
 Binary dependencies can be found in
-https://github.com/siemens/meta-iot2050/tree/master/recipes-bsp/u-boot/files/prebuild.
+https://github.com/siemens/meta-iot2050/tree/master/meta/recipes-bsp/u-boot/files/prebuild.
 The following binaries from that source need to be present in the build folder:
 
  - seboot_pg1.bin
@@ -44,7 +44,7 @@ needs to be present in the build folder:
  - otpcmd.bin
 
 Regarding how to generating this otpcmd.bin, please refer to:
-https://github.com/siemens/meta-iot2050/tree/master/recipes-bsp/secure-boot-otp-provisioning/files/make-otpcmd.sh
+https://github.com/siemens/meta-iot2050/blob/master/meta/recipes-bsp/secure-boot-otp-provisioning/files/make-otpcmd.sh
 
 Building
 --------
