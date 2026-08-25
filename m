Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D154C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF1356070E;
	Tue, 25 Aug 2026 16:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8nEYFl0aDIup; Tue, 25 Aug 2026 16:55:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676930;
	bh=09MaZqeuSc7QC3m6snHUZe5f8ciYxgFtqP1huumGqLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADgESU/bgEKnZzz0LyfNCk4QFRsJd0MjHJ3LAlNtL7DmbvnSZdLcAmRaCxvWXtdgT
	 2QKCgAE3gMIgnTbFKJ05JAmlEB5eHki3rfJkUl4qh5lOPH9E8FCIG48X1UOUr2Sk06
	 8qcDa1URZU3dGHPqd02j9m+oMH5LDN5P1iL2YKQYzvviZc/MJCb3+OBEoRMPsV/pad
	 eSokAoEax+eL/Vehw+eh0EdVrF+3M9+IVQINhIrzrxh4Gv+T1cc4fMAO5crqJZIZ+n
	 oVhcv4blgLP3YbP8weYLtHdYdeGQvmHwhbaax+ZITP76eam+RlwTx85lY5v6lbhQBT
	 FnghLVxc+ISXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FE73606F8;
	Tue, 25 Aug 2026 16:55:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F13396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C4AE80C2D
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1SdxcfmyDEfW for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:26 +0000 (UTC)
X-Greylist: delayed 317 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 16:55:26 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=BDvCIC3c
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::42a8; helo=smtp-42a8.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::42a8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 769EB80BF4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:25 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0D0yyCzZYD;
 Tue, 25 Aug 2026 18:50:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676603;
 bh=09MaZqeuSc7QC3m6snHUZe5f8ciYxgFtqP1huumGqLI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BDvCIC3cvIoDgWz4eynKUj9ikHAdBBkVwPtXypx0nZVIVYiItoVxdOeyeZyf8xoCY
 //Od2LrVx89b5qnyS2Q8od2fuIplRfPSs7aRDdojItY5bspmA2kxPZ6H0Qb///yQJ4
 OFbafV//57KRhZ3DUWjUtmC9qem2964LokoLNnnpN6AosTNSQWYcm9rybpAyzCpqdw
 dRZC7zJiaIt3nHoquNQxvd4KifltYBqC7biqOkdgMF1cuo9kGkq+Hvr8+b4IN9znhv
 Ez9v2rBnOIAAxRgHydSFf8cUEHWNWoN3XsL7MiieYgct1zUV1ZzWeqETfa+/DDCeYN
 2PRwg6w2rEnEA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0B4G04zYHc; Tue, 25 Aug 2026 18:50:02 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:39 +0200
Subject: [PATCH next 02/45] doc: arch/x86: fix "link" to IRQ router DT binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-2-ee7573fe3a4a@cherry.de>
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

The device-tree binding is not part of our Sphinx docs so we cannot
refer to it this way. Instead, follow what we've already done for other
DT bindings and simply use the :download: role.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index f67216d6ce02..066838b956b8 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -242,7 +242,7 @@ debug serial port may be useful here. See setup_internal_uart() for an example.
 During the U-Boot porting, one of the important steps is to write correct PIRQ
 routing information in the board device tree. Without it, device drivers in the
 Linux kernel won't function correctly due to interrupt is not working. Please
-refer to U-Boot `doc <doc/device-tree-bindings/misc/intel,irq-router.txt>`_ for
+refer to :download:`intel,irq-router.txt <../../device-tree-bindings/misc/intel,irq-router.txt>` for
 the device tree bindings of Intel interrupt router. Here we have more details
 on the intel,pirq-routing property below.
 

-- 
2.55.0

