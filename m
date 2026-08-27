Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB47AC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D10460847;
	Thu, 27 Aug 2026 19:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WjU-iHFDzLcp; Thu, 27 Aug 2026 19:54:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860467;
	bh=qpQ43mzla7bdgOuX/rD0EyVaWCXRwOKFGZCtg3R3dj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IbW+2nm3ri0Nhg3R3Rji3rivbjG1Wn0rTL/8noMb3KXGi9e4CtZAaGcbZad0ZBV53
	 cRVEP7f5meTIGFaCJ/fpBcuCfsaz4c7Ko0YOM4p6Y8vfvq/dPY/QGAhkzFFDEe9Kii
	 YgamlP6HkTBDdgx4i0ge4dSlYAD+wgSx7Xp+gZ/W744wPCQBZSmiYgtNmAVy+SO4hV
	 2j6CqOzc/9cfiYlZN+7YvoMq0Rr4mA7Hls89QqjjRGQkCneZAmRwZI+kTL8EtH6xjI
	 s81mad3MCDy3Z/fS/uqThJgIwLtO2fKDgbceCLzxdZ7aYNHVIxOcdJ70fVI6qZ58RU
	 zpwm0SeMe1+nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91ACF6081F;
	Thu, 27 Aug 2026 19:54:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65332B2C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56DBA60802
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6gMWMHbqeqJI for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:54:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::190e; helo=smtp-190e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=b+NChFHg
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::190e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F55C6082C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:54:11 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzk1VMYz10Tm;
 Thu, 27 Aug 2026 21:54:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860449;
 bh=qpQ43mzla7bdgOuX/rD0EyVaWCXRwOKFGZCtg3R3dj4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b+NChFHg0DERnUXh9G8qMEyy7OHHHbjLVW8GLlmfrJH+j5mSOUMKj2/dWQnwiUOaU
 OweKUFlQzrlyvG0EnJhgnv7ocmQ+o/T0qaQ6P4izqGpbwKNFXqshHUkYo2rT1Fa4zl
 /QuARlPWsI1eGi67fk0m1/lLSFkEERaiMSvviZ6uAJzTcMuHANxV/lb7b+S6+clSD4
 D06Go22dySiSJEo3g408erWtUZUw2/JPJE/hv55gDO9ZIFo661A31ZoTtus+BMP6fQ
 K3ypPApM/ndDOn+e/GWcWmKACfId/MHA6AHshqS4FXq1FwGYgkc+pAQRHd+WCxysiA
 Owe1aHAjcApPg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBzh3n46zRKD; Thu, 27 Aug 2026 21:54:08 +0200 (CEST)
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
Subject: [PATCH 41/45] doc: chromium/chainload: update instructions on booting
 on Snow
Date: Thu, 27 Aug 2026 21:53:09 +0200
Message-ID: <20260827195313.129994-20-foss+uboot@0leil.net>
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

The link returns a 404 and the Appendix A. link at the bottom of
https://www.chromium.org/chromium-os/developer-library/guides/firmware/firmware-porting-guide
is a dead link. I found this by looking on a web search engine for a
couple seconds and it seems to be matching the title. No clue where this
file is supposed to be exposed so let's point at the file in the git
repo for now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/chromium/chainload.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/chromium/chainload.rst b/doc/chromium/chainload.rst
index 0f61e020db8d..6f8a134c94bf 100644
--- a/doc/chromium/chainload.rst
+++ b/doc/chromium/chainload.rst
@@ -34,7 +34,7 @@ Snow (Samsung ARM Chromebook)
 
 See here:
 
-https://www.chromium.org/chromium-os/firmware-porting-guide/using-nv-u-boot-on-the-samsung-arm-chromebook
+https://chromium.googlesource.com/playground/chromium-org-site/+/refs/heads/main/chromium-os/firmware-porting-guide/using-nv-u-boot-on-the-samsung-arm-chromebook.md
 
 
 Nyan-big
