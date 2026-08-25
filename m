Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29971C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5A776070A;
	Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKXa31ePiTHT; Tue, 25 Aug 2026 17:00:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677214;
	bh=lNnuePxtR6aZaeZF7T9xbme82EZBPQSs1sKCSOi4PPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IQRrvixDuKIwXUU64+YTn2g8PjI994srwDN70JaJy6SodEv/R0N0OmpRMIjzgcg5z
	 fexQmmi3beoipEFIRg63iY2UnJDXHEQ8sCnUYzwnfzKTpV6u4FxYOLRddooBT9Eh1H
	 c2uwURP9pI6k4rwE73U3SBKW0Lfc+etGNIP30DG60PUdgtsT2olD8F7KdiSE1IfX16
	 2Y06g5Z+IKfmEkCOGpU58+hQV5D8z7spzDaVoEEJELhhikdZpV9ZKNikDhroHf28jy
	 UKYYHLbTXVbbXW9Pobe7L1TfNVUeGD9OklIiSmTiT8xlLKL1iENHOXi4ixCIiHZctD
	 VjjmloMG3KD9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A467D606FA;
	Tue, 25 Aug 2026 17:00:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2A1E3DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8E98401DE
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FOFPPHXxiCGE for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:12 +0000 (UTC)
X-Greylist: delayed 598 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 17:00:12 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=C/TZ9aEB
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6B06401DD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:12 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0b3JNtzhtC;
 Tue, 25 Aug 2026 18:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676623;
 bh=lNnuePxtR6aZaeZF7T9xbme82EZBPQSs1sKCSOi4PPg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=C/TZ9aEBZPyiemkIqY2JekXCaPH1llZLvLwV2zz+1EXViakYQUNJTxqpuOdCK7Siy
 1i7m5nfVuG6yo7G/0ipND7EBFmn2pJAtInd9QhtQIjfqYiWYZUrEGle5zR3Ub5Hou1
 c3pz7M/Ik0DNXMgP6a7DagNdQvAuKliRh9ePmzTvf2qM/vNQmJN9XV1a1Q0x9nxUnt
 oKl2LWeR02YdOnPkACaXMd/0AhqOv+bK2cC/smfAwXZcgrjTUQPYcKjcFRZ8+KNM+j
 FIuSOZVLDNJ7m36zEZbJj5RxJ/6pMuUEySd7Tk6gdNBFgadGE8nXmaxa9TQebSC+Ll
 4P9+++Eb1IL5A==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0Y66FSzZ1p; Tue, 25 Aug 2026 18:50:21 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:50 +0200
Subject: [PATCH next 13/45] doc: board/amlogic: jethub-j80: use redirect
 link directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-13-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
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

The product page link redirects permanently to something else, so avoid
the hop by pointing at that link instead.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/amlogic/jethub-j80.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
index 9195df690502..c3800f9588aa 100644
--- a/doc/board/amlogic/jethub-j80.rst
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -3,7 +3,7 @@
 U-Boot for JetHub J80 (S905W)
 =============================
 
-JetHome Jethub H1 (http://jethome.ru/jethub-h1) is a home automation controller device
+JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device
 manufactured by JetHome with the following specifications:
 
  - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz

-- 
2.55.0

