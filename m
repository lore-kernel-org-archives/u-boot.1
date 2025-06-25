Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B13C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C282A82D21;
	Wed, 25 Jun 2025 16:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Spf5YK8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA3182D34; Wed, 25 Jun 2025 16:58:30 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C2282CFA
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E61CF4A1F0;
 Wed, 25 Jun 2025 14:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9C1C4CEEB;
 Wed, 25 Jun 2025 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750863499;
 bh=FJiOI9Zdo2gD39nQI773QaOqRGtYm6xXTLaw845g+/Y=;
 h=From:Date:Subject:To:Cc:From;
 b=Spf5YK8fcfqf+UfKlVZlP7MZb5yKFLCG14pCEJTpU5wkmLdSKisoSSKr/v47VUR1p
 OVt2dn3yroEYrW0qAlzI8Vnmye1BGoX03DVfyVDXlEgKqxB0d4F+seq1O5VeTkvb9v
 qaCQNHLSn3IZZxVuSShCOg9G1nNiZ3UmG/edtuiBpgLtGz02p83NRcAA0IS1ICc3kG
 HBlPf9+xUZC9iWIqY7bx6Fnivi2bLg225F68SZwlvvFn0WAGfvisCd8H7t8mshdnFH
 J/6NSlSL8uDrfixLZ1TK646Hkzj54RIaQKTnR6CpEX3EpH3ZckEzs0BykOs05cZFTv
 zcxzuyevpZhWQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Wed, 25 Jun 2025 16:58:15 +0200
Subject: [PATCH] doc: board: ti: Add defconfigs for AM69-SK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-doc-ti-am69-v1-1-67527a9c8dfa@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIYOXGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyNT3ZT8ZN2STN3EXDNL3RQjgxRDUyPLNGNzMyWgjoKi1LTMCrBp0bG
 1tQDCi+yOXQAAAA==
X-Change-ID: 20250625-doc-ti-am69-d20d1529f376
To: Apurva Nandan <a-nandan@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=FJiOI9Zdo2gD39nQI773QaOqRGtYm6xXTLaw845g+/Y=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBoXA6ITIL88O34ndFB8Uf1bXBeZJkyrjjzJ2elQ
 vDn01vVPUuJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCaFwOiAAKCRAZDR20Zk4Z
 NU9kCADi3b+d8ovAXhTCvnrmLy9XTSB2xvxYhR3EpiT74D60sfQvAczVGeaV+rWaCWDb037q9Aq
 oA2YqMpgSxAXbWA5FWPBgsxmI8dGjBcls/48SV+D1BVukqtQI3tvfBg2Yglub4OOQld5GL7fCRP
 OH5eFbaib6bTAq5YAooOeVQxbL1KvGj7AecdHOauLsd7mDyrBkCMFwJOoRjj6Sqd3f7pvFsQo/Q
 M5vu+Y+pPTZ5V8dx6pw26vRQJ8YQQtWfw00MfiGAuIR3utSnzY4cY0BpxpaPy//fj5kmXmexsI7
 I1SxxhG9sQpU3NhLKoebi6eTbmDo7N5GGfELoujZ2GeVvggD
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
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

The J784S4 and AM69 Platforms page only details the defconfigs for
J784S4.

Mention the ones needed for AM69-SK as well, to guide users on how to
build for that board.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 doc/board/ti/j784s4_evm.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 349fb394d747ac1f98b5a4af092bede60c5ed06a..22442874110d29d862ee79b1666e50269645a2f2 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -90,6 +90,15 @@ Set the variables corresponding to this platform:
    export OPTEE_PLATFORM=k3-j784s4
    export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
 
+.. note::
+
+   For AM69-SK, use the following U_BOOT_CFG instead:
+
+   .. prompt:: bash
+
+      export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
+      export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
+
 .. j784s4_evm_rst_include_start_build_steps
 
 1. Trusted Firmware-A

---
base-commit: 59e6462d7c08eeba744afa0f17846c398b8ef9e1
change-id: 20250625-doc-ti-am69-d20d1529f376

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>

