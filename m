Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA98C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B07E640612;
	Tue, 25 Aug 2026 17:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9WFoE3eFBnE7; Tue, 25 Aug 2026 17:00:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677222;
	bh=aemmI//3h55V2YeYRiN3yzp6Vh/LK1tI+++8xZDM2+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AgpZozoKJHLt6PqPhTcfQf2fSeMvABgs74QpRz9WefDgQC2CDcY1+Il6geQBV8gVn
	 yWoVXvZdM2I/l2bIX3YfAgewBzdviu8HFKqt26m4gFA85Y64waL34wfVq9b7pwT8j1
	 JoODZqmX21qSczvpMtWJF/IqedzP19PumR6HfodzsdMdgXnSUy5n9w+qW2GDD4rbJW
	 rsmeRbbWvExveF4O8M3J4m4yof2sWfpf9u96gZqrixPR/2Ok0rCTUyAjV1URMhXV1r
	 gzganajFJalB1VJ2OE+BOl0pPDEGvXRxvu6bsA/UHKqJQnp+aTQFg2jHnGsjp2Q9e+
	 KXQCBSxiTcjLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B95DD405ED;
	Tue, 25 Aug 2026 17:00:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D7EB43DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C89DD4004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbKoMf81omZ4 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=DRnZkG8N
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCE424002B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0V1PPZzjnX;
 Tue, 25 Aug 2026 18:50:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676617;
 bh=aemmI//3h55V2YeYRiN3yzp6Vh/LK1tI+++8xZDM2+Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DRnZkG8NLzehF90HMekLjb4ttVgq5mxS7VjUAlbw4rJAsJqMYu4Dy4ljNJcl7U0FU
 Wd3fTYPk4ROM2qAY38U9SED7zJK2KHzp8V2eVbAvXy1dZtB2VLb7+7d7NK+QxQE1i+
 SsP1zOkawq8m6ZU86etvftV0GEQuXMMoeYn1oSPALrVngqodF5P8SOPjeI3bW7j4D5
 Z7zewjBNhCNJMfhjNovJLUOP2fL/uibT3z1b8DJXHgc3lhg3ermBJe+xGtLFTKnK4M
 +DRueLD8b87MO7XAf56Sk/79AsdsXqOzV17o2n+Z/GepPuP3ZKx3IMGMbmAaEAh/bO
 C1xYhfnpQZ3gg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0S4RLczX4k; Tue, 25 Aug 2026 18:50:16 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:46 +0200
Subject: [PATCH next 09/45] doc: arch/x86: update link to ACPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-9-ee7573fe3a4a@cherry.de>
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

acpi.info doesn't expose anything anymore.

One of the last archives of that link on the Wayback Machine states[1]
that the ACPI spec is now hosted on uefi.org, so let's update the link
to something that actually is interesting to the user.

[1] https://web.archive.org/web/20190522071820/http://www.acpi.info/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/x86/x86.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index 13d2b2ea9af3..28726f717f6e 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -486,4 +486,4 @@ TODO List
 .. _SFI: https://en.wikipedia.org/wiki/Simple_Firmware_Interface
 .. _MP: https://en.wikipedia.org/wiki/MultiProcessor_Specification
 .. _SeaBIOS: https://www.seabios.org/
-.. _ACPI: http://www.acpi.info
+.. _ACPI: https://uefi.org/acpi/specs

-- 
2.55.0

