Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E735C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 241D480542;
	Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 65aCo6qbbZHP; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677218;
	bh=OUU/GhSM3K7jr+Agn1Yw4EPiolNd88Dps946dhR7mbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCAo7ie9SSF+BurNYQKY76csm+D0FfKQ8DSGqtFnqb9Ck7h0wIn91HP1JRPEOVVAv
	 7uU89gdi7IX2OzD0tZkJrSwWr7KgYeH9LzZ91j+qlW9En/2ZEMgrieWDt6sdBKLqgV
	 9g+wSPA1w5VAA0ywuEnah/a0zPn7io+GGEuijs+Wrwii0LQmIKKgNwK0cRNb+lZtnx
	 ak0F/lnUDjX3jCqW7j6mBsCq98eLxX3tW8NNa9B1/VCSKmDMoldDLhBnWb+o7RvGj+
	 JzVqGDqqFu2eQ/cIKHljggjqmj6R1/vDxNhYpWMdihmzEgTz+MxKhQ01bSH9f4u0YX
	 A5Qu0DoRTHSAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FCD080559;
	Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79382396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D763606E1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 909LXMdeH0rG for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.173;
 helo=smtp-8fad.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=QEr1RUI1
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BF6F60656
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:13 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0R4qZwzhkH;
 Tue, 25 Aug 2026 18:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676615;
 bh=OUU/GhSM3K7jr+Agn1Yw4EPiolNd88Dps946dhR7mbI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QEr1RUI1rMdn/01Jo0eJa00N75ScvSXfeY50VosqrcGgn+affgH4Za8ahBvzyOq5N
 VfRHVPe1nVrCKdQbrHM2ObyIwJ5ow03LzhlWdGSwke63SlvPJGsNHTDRZHEyCc1Gzn
 GkzK5HrxCKt1ienxnJsPxm9OLMnEElZN6wMTMaVle8H/CENQeeRhWDdXTS/6XgKype
 mblZUmQKwfr3o6Q96xQy0Q6im2JDXUHUDgITwCEusC9xu6tSXa5U92pOd5zaLNeEwr
 QDkmP2R8wUZ/ENs9DzarvndssxKTFbwkMrzZ07KyT5tUFpNtbQZ0TRA2qXcglL3uZb
 4y+wqIEN11e/A==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0Q0TWMzYyS; Tue, 25 Aug 2026 18:50:14 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:44 +0200
Subject: [PATCH next 07/45] doc: arch/x86: update MP link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-7-ee7573fe3a4a@cherry.de>
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

The page on the Intel website has been redirecting to a generic page for
the last 10 years according to the wayback machine. Let's just point at
the Wikipedia page instead of some generic and unhelpful URL.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 3c61c3058f7e..e7bd9205caa9 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -484,6 +484,6 @@ TODO List
 .. _QEMU: http://www.qemu.org
 .. _microcode: http://en.wikipedia.org/wiki/Microcode
 .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
-.. _MP: http://www.intel.com/design/archives/processors/pro/docs/242016.htm
+.. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
 .. _SeaBIOS: http://www.seabios.org/SeaBIOS
 .. _ACPI: http://www.acpi.info

-- 
2.55.0

