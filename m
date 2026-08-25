Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A7CC61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA37380C6F;
	Tue, 25 Aug 2026 16:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vp-xo9KZh0p3; Tue, 25 Aug 2026 16:55:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676935;
	bh=eeDnXSK0v/CUGxQQpyZelUaWKCh6lNl8KbcHPMvA4z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MICdmEr2VZHlFEeY5uRHVTcZlNsShG+cUbmg6AFruOoOnm6dOvOf6UgIrqHbK8wND
	 vLGUfSewCZTFMOIRWQApcBvgQ4o2RPcW+9hgi52MIzEEZZHVvxsNI/xulW+fsYdjmX
	 /iL1rkkNAb9h6eIHCii41BrYC8SUfaXC9QbiloAuv4TLjki9n2udJ1049FhCWGxWqn
	 kuxpHpN18fwSzQekFPgjgu8GA/9MCyAzY5xSLCVATg1bsYjClulRrl6/Rkpkjfb0I6
	 JEHYU8da8XBntlivFRWfuW8vTkC1j3wVlz6ME1mw7MDqnIEBjQCZovgMx8DDPMNJvX
	 hhhILuPO84jig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF4F280CDC;
	Tue, 25 Aug 2026 16:55:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C752135E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B60C760703
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RwPr9HnAoqqi for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=FyxCSQ6o
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F3CE606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:30 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0M644Xzh3M;
 Tue, 25 Aug 2026 18:50:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676611;
 bh=eeDnXSK0v/CUGxQQpyZelUaWKCh6lNl8KbcHPMvA4z4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=FyxCSQ6oiBaWgTuzlxRWVanzKEpDzkS/6zhhJleUnxu93o4asco4XgbMOSMiU6Uzd
 iJeFs48hAHkxS967R0WbL4xUlHKO1/OVyCIAGGJZ9oTRSKkJmYZsaL3D7dtjOCriFJ
 w13H3/pfCYDV0mBRYGgo7w8vqMeFpYvD9R0pFCSDyUP8UuI6VmSP6qMTjjEzjz6Wmw
 pz9KjvK9H/JXHCkI8mrqyl46s6YKfIfzVhkgp/Mh9pvkEu3Dog41fOkdEb8OHUjw6H
 THzvH/wjnrSYlVHgbokEbrTxiUzJtXdTNEP0cvop0RXjupUdriK2aIMheUHo45/Fx8
 fY/E8+HBgvMtg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0F2BsrzYk6; Tue, 25 Aug 2026 18:50:05 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:41 +0200
Subject: [PATCH next 04/45] doc: arch/x86: fix URL to em100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-4-ee7573fe3a4a@cherry.de>
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

The URL points to nothing on the Coreboot Gerrit. Instead, let's point
at the project page on Gerrit from which one can get the command to use
to clone the repo and also show the changes (patchsets) related to the
project.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 066838b956b8..7abf819e36f4 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -185,7 +185,7 @@ These notes are for those who want to port U-Boot to a new x86 platform.
 Since x86 CPUs boot from SPI flash, a SPI flash emulator is a good investment.
 The Dediprog em100 can be used on Linux.
 
-The em100 tool is available here: http://review.coreboot.org/p/em100.git
+The em100 tool is available here: https://review.coreboot.org/admin/repos/em100,general
 
 On Minnowboard Max the following command line can be used::
 

-- 
2.55.0

