Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D2BC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6942A87B25;
	Thu, 26 Oct 2023 09:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA2B87AF7; Thu, 26 Oct 2023 09:32:40 +0200 (CEST)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84A9C87B09
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
Received: from toolbox.int.toradex.com ([213.66.31.70]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Lu6z2-1rehLz3AaU-011TBq; Thu, 26 Oct 2023 09:32:26 +0200
From: Marcel Ziswiler <marcel@ziswiler.com>
To: u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v1 0/2] imx: spl_imx_romapi: fixes
Date: Thu, 26 Oct 2023 09:32:18 +0200
Message-Id: <20231026073220.244387-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V9r3own5/nvchmtgxWapbvi3I+++uvivG4OZgw8V5zG6K2W+9Ao
 00ORJ0SDCU6qiN1SoplW1wVPv14mq0Po7ByNXH5hEgngtw2dre0hbXkH4ASkRnDz/3j47nJ
 hQkpcnSqwWfoLz2V2+rt5t0FnkM7H40WOj5nan8I1db2YH7DsVw6jPF3IoRfzjFJGJBgMfw
 YY73ot6H8vd87Mi/PAdrg==
UI-OutboundReport: notjunk:1;M01:P0:BakJ8nQpvWU=;cmpxzDttG6tHdMp4nJg7dEREKC+
 kMx+Xb4WJ0DeBzBFwKayFYr4/eKmzrvaD4TKpWvEzd+yf1XdBEp5/zxwH2DEo/bx4N9JtTM8L
 QnlBJiPMXw74cRLaaTb3wDHsE94mMuOj6Z0pRxdSiHztLETsW8cspVADrLHgQgjjEf/NRPO7I
 NB9uiE0PikTnu8gU2vyipF79Nk7akSS+lCdrshfN6wIzuuBl078T/vJ5HYN1rOyTVTCg9kki6
 tqIPgFEzZHI5InH1eRZKlKBk0WB5PWkIjk7MwFAi6qzTgvPoA6/cyym0qwU9KLR6HAyYEDHcZ
 Kz/VpHNoglO0fVicJwipzIapqFZP/40L6//riI39OwLm8PzTwTeKO5FCLNGjmR0vFdyF8D1ZM
 JtOmcYRQPyijsGBDXno/7qg9g4M8p+lI8e+gdkewZajBQaLMltQvBlM/Oy5LJpE/BUOGjIOjR
 aMqkwsZMerWfGhaj1rUyTGSqyX1FeHmXEGq5ebbPCGoT37T/RPCp12m+VM/WOXugOaVKflqFn
 G7/b/C6RqKTCkGfpbsgu7/jI3Z5uBdQL6u85/9YHbWLoGOqm45xBEyCfyXYl9RjLEPYwvUlTH
 SHuW6JyALVm4oJdftRWcxSgRQHaInk5KN+gsI/DuLN923T7Gl+ICGDIsG8wKbqeEmoh7+CHqI
 9SEG2iA/vWET3cmP7+SzSsmPveq0yeRrEEBXOaNAY4sJoBvyvtGouMFrbsL8xqguFufGa1xvk
 9ngo4OmXfce5YTpnfYKtoy5akiWod5CNGJOPugxZwK6WgIO339CVFbU9GXOnnlP7DyYRlHDiR
 3l+qZmq26RcCn7NEGbzP79Z85yN3f9yco4yuoFftVO6HMa9RfWHjHVqBNLPelS6LYJ/dJJ01i
 5OcwSFQFTC/+zBQ==
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


The first patch is a trivial spelling fix in comments. The second fixes
a recent regression that only manifests in the eMMC fast boot mode case
which does actually also use streaming rather than seekable.

Thanks go to Rasmus who helped me debug this and suggested the fix.

@Stefano: This one is also still missing [1]. Thanks!

[1] https://lore.kernel.org/all/20230828213803.454303-1-marcel@ziswiler.com


Marcel Ziswiler (2):
  imx: spl_imx_romapi: fix comment about stream(usb) download failure
  imx: spl_imx_romapi: fix emmc fast boot mode case

 arch/arm/mach-imx/spl_imx_romapi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.36.1

