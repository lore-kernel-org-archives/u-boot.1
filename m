Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EFBCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C302D83A5D;
	Fri, 31 Oct 2025 18:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B5583A57; Fri, 31 Oct 2025 18:08:43 +0100 (CET)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [83.166.143.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB3B839DF
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:08:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cynWD67jfzZHZ;
 Fri, 31 Oct 2025 18:08:40 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cynWC2fFpz14x; Fri, 31 Oct 2025 18:08:39 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/5] rsa: fix dependency, rename and relocate RSASSA PSS
 symbols
Date: Fri, 31 Oct 2025 18:08:19 +0100
Message-Id: <20251031-rsa-pss-always-v2-0-a29184ea064d@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPtBGkC/3XMQQrCQAyF4auUrI10RsZSV95Dush0og1IWxKpl
 jJ3d+ze5f/gfRsYq7DBpdpAeRGTaSzhDxX0A40PRkmlwdc+uNq3qEY4myE937Qaphgp9KFJrTt
 BOc3Kd/ns4K0rPYi9Jl13f3G/9S+1OHRIycdz8NwEoms/sOp6TAxdzvkLZ/w88awAAAA=
X-Change-ID: 20251029-rsa-pss-always-dbba5c57d913
To: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Alexander Graf <agraf@csgraf.de>, Loic Poulain <loic.poulain@linaro.org>, 
 Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, E Shattow <e@freeshell.de>, 
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

While historically signature verification is mostly done for FIT such
FIT_SIGNATURE dependency for signature algorithm makes sense, it isn't
the only kind of file we can verify signatures of. It can also be done
manually with rsa_verify_hash() with an embedded public key.

Considering the impacted code is guarded by RSA_VERIFY, let's make the
symbol depend on that otherwise selecting it without RSA_VERIFY won't do
anything. The FIT_SIGNATURE dependency wasn't also enough before as it
only implied RSA_VERIFY.

Then, simply relocate the RSA SSA PSS padding with the other RSA symbols
in lib/rsa instead of in boot/ and rename it to remove the mention to
FIT.

Finally, add the PSS padding wherever PKCS1.5 padding is specified as
one or the other can be used.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- do not always enable PSS padding, the increase in size is too much,
- added patch renaming the symbol,
- added patch to fix input prompt and dependency on RSA_VERIFY,
- added patch fixing missing PSS in docstring,
- added patch to group SPL_FIT_ symbols together,
- added patch to remove duplicate VPL_FIT symbol,
- Link to v1: https://patch.msgid.link/20251029-rsa-pss-always-v1-1-ad2b652e75aa@cherry.de

---
Quentin Schulz (5):
      boot: fix incorrect dependency of FIT_RSASSA_PSS
      boot: remove duplicate config entry for VPL_FIT
      boot: group SPL_FIT symbols together
      rsa: rename FIT_RSASSA_PSS to RSASSA_PSS and move symbols under lib/rsa
      rsa: update doxygen doc for RSA signature verification to mention PSS

 boot/Kconfig              | 62 ++++++++++++++++-------------------------------
 configs/sandbox_defconfig |  2 +-
 lib/rsa/Kconfig           | 14 +++++++++++
 lib/rsa/rsa-sign.c        |  2 +-
 lib/rsa/rsa-verify.c      |  8 +++---
 tools/Kconfig             |  2 +-
 6 files changed, 42 insertions(+), 48 deletions(-)
---
base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
change-id: 20251029-rsa-pss-always-dbba5c57d913

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

