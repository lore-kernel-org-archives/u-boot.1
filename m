Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EFBC61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 16:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3692C80DBA;
	Tue, 25 Aug 2026 16:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ERN8yxLnO6P; Tue, 25 Aug 2026 16:55:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787676942;
	bh=AI4/0CznMgJDfWFt2HQMFVSDiKwlT2vFCaeecif1O6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=av2OBXCdokCWNC/jsCPhE4OOD0gvz6jmxN0ibPkzyV684aSxPixyBAXaF4slit4Pe
	 CzjmVCU6DQmQ1A2zDYax99S6uzrvUSwQ3huM/OeVXk0z42rtj2wclq2jsybK6YgHvY
	 i375CmGVSeISueXoc93xm+0Qb4V/rpUiF7QwT/xo3IEvwG2ROuvgYiu5h3ogrIBfXC
	 C3KKRg/ln5EkcfGd4zMmM9jLygc+RHDYQpfMCTVOQK9NKY/NZuTkhwy+4yL8uNq1rv
	 8PbMbn9hTdP+BwShaTVzwnUzO4f4lBliZr59cTw3MwBIgzdCpF+BAGfD3VO2d8Y/di
	 iWLDX9yvokh0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 26DF380D97;
	Tue, 25 Aug 2026 16:55:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A70B1465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CDAB40169
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pmpR8vO3NQW3 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 16:55:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::bc0e; helo=smtp-bc0e.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ehzba33r
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::bc0e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 191C740186
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:55:36 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0B6KRnzjyy;
 Tue, 25 Aug 2026 18:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676602;
 bh=AI4/0CznMgJDfWFt2HQMFVSDiKwlT2vFCaeecif1O6w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ehzba33rJoMjWMHUs0ptu7rNWVOWjmpCHSvTUg3a7ZEIAXJBruElxAehQrWGRwkfX
 k8YW1EYOvxZHbgkg/d2P65mbvHpRpjOb45+tpYPLqz3Vg3RN+oNmSLAtMTcUhVHxDi
 epbJQ1MEcuVyXeQyz58sZ/WNly3SAjL2/05FLobXepptqtK0ZjcUgYVLwtEHFMd3n9
 mISD/g+TqotQC/GeP9SpZK9c+tq73+MYWMmVSaOr9vMxh23ups4UAaJdgmec4g2q/A
 SwHHgsOqyxuHwn5UfIH8eJT8KBQQsmQYUNV9YhCq+ElxLZoAlEEqT7UGmlxgO3dj1C
 LvGv60NufWtUA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv090myJzZh7; Tue, 25 Aug 2026 18:50:01 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:38 +0200
Subject: [PATCH next 01/45] doc: arch/mips: update link for Buildroot toolchain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-1-ee7573fe3a4a@cherry.de>
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

http://buildroot.uclibc.org/ redirects to https://buildroot.org so let's
use the final URL directly.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/mips.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/mips.rst b/doc/arch/mips.rst
index aeb58247943a..70d9aa57c389 100644
--- a/doc/arch/mips.rst
+++ b/doc/arch/mips.rst
@@ -8,7 +8,7 @@ Notes for the MIPS architecture port of U-Boot
 Toolchains
 ----------
 
-  * `Buildroot <http://buildroot.uclibc.org/>`_
+  * `Buildroot <https://buildroot.org/>`_
   * `kernel.org cross-development toolchains <https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/>`_
 
 Known Issues

-- 
2.55.0

