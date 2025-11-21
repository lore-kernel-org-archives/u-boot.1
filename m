Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECFFCFC274
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 13:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D80980433;
	Fri, 21 Nov 2025 14:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41A0838CE; Fri, 21 Nov 2025 14:22:34 +0100 (CET)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A20802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 14:22:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dCbVc1RX6z5ZG;
 Fri, 21 Nov 2025 14:22:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dCbVb2QZrzd8D; Fri, 21 Nov 2025 14:22:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next 0/3] CI: use mirrors for GNU tools
Date: Fri, 21 Nov 2025 14:22:13 +0100
Message-Id: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBPSEKqrRAu1sWaRxVghhHdPW
 r7F/y8kZMIEo3iB8aFER6xQjQC/2biipKUadKuNUlrJNd5yJ+aD5dA7F2zXGm8t1OBkDJT/2QQ
 R8wVzKR+SmFexYgAAAA==
X-Change-ID: 20251121-gnu-mirror-98bbfa305caa
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

I have to add one (1) package to the Dockerfile as a new dependency and
wanted to build the image to verify it works. I wasn't able to because
GNU servers are just not reliable at all.

The git server URL we're using doesn't seem to be a mirrored one, and
switching to mirror URLs seem to make fetching possible again.

Unfortunately, we don't have the option to do that for coreboot's
dependencies, though we can ask coreboot to download the dependencies
through its own mirror, which we do in this series.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      CI: use GNU mirror for grub (and switch to HTTPS)
      CI: use mirror for gnulib dependency of grub
      CI: use coreboot mirror for GNU dependencies of coreboot

 tools/docker/Dockerfile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 8ff90aa64b730c3f511921d4ff79e9f64e625867
change-id: 20251121-gnu-mirror-98bbfa305caa

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

