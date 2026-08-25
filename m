Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB45C61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3B2B6072B;
	Tue, 25 Aug 2026 17:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iULyOdKMKMqc; Tue, 25 Aug 2026 17:00:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677225;
	bh=zl1jG54sKgC/LBZMnQThdcCB622Zl1OmsqAy4A4y5DE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yIbJmrThfFdZBUjs+8wjUJsAM5J94oUlVPDan2msgJW0kWAlMApJwKT1WhX10Axu4
	 24wprwPdWLLUYzVP2Ly4Pvu3ddKtr6iXSk7uMEQReOXGbdb3FcsqiU6XkcN6xzUzG1
	 CTj8lfMmaTzXjOm99KDHmQ4TXve5CY0WzRRaHAVGNbtRHAWglIzH0iQETEUZkS8HwS
	 frWAfcSvtXhOGdghG09Pf0JkFoYEsUGaUWbdT+aAZX7CxPaQpIMbVlh/Lc/yyJyT1v
	 1i+tfVdXp/5FbJg//JwRzWBXFPkSGMDBw07W1bFMK8YIF3ZuHNehNB4sAbuHcyOzVv
	 uvhTgk7/FLywQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07E086072F;
	Tue, 25 Aug 2026 17:00:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBC561AF
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A210180560
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBvFxD3iK1ar for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=d+R/CRDW
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA33080550
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0r2B6jzj1s;
 Tue, 25 Aug 2026 18:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676635;
 bh=zl1jG54sKgC/LBZMnQThdcCB622Zl1OmsqAy4A4y5DE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=d+R/CRDWmkBjSEs7DHqtqGdKiYO/RjmuBqVQwKy4l8LkMttFSdw9bOogxtJgPzUAl
 a3Hyu9ykQA4f6InkLU4DVIuHr+cv1CxPPmjBPU5ySCerdokRkp8yktOIMcUpphkP9n
 xnEGm0FddjjnrBPw3JHMHxW2x33Vlq2pKFKWLcO9ee3EZCYfhTOhq0iNMtCAttz2gS
 p8eAqIurNuWmGfBzfOPis1bTOzsktllfugruM9VguexGgqVeLhpYKPT1mKI2EWqDZO
 QYjdwH8xE8wMlJs7mHQL+bAmOZzF1xZ8GTHW9VlkDHeQuGKAuLO2k/AE65aJNLOCzJ
 XDqSPo3YSubVg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0n1pStzYXJ; Tue, 25 Aug 2026 18:50:33 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:58 +0200
Subject: [PATCH next 21/45] doc: board/nxp: mx6ullevk: replace broken link
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-21-ee7573fe3a4a@cherry.de>
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

Having the link split like that doesn't work at all as it inserts a
space in a URL, which isn't possible without being escaped. While at it,
replace with the URL it currently redirects to.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/nxp/mx6ullevk.rst | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/doc/board/nxp/mx6ullevk.rst b/doc/board/nxp/mx6ullevk.rst
index a26248a1e3b5..0a7d2616f583 100644
--- a/doc/board/nxp/mx6ullevk.rst
+++ b/doc/board/nxp/mx6ullevk.rst
@@ -42,6 +42,4 @@ Connect the USB cable between the EVK and the PC for the console.
 Insert the micro SD card in the board, power it up and U-Boot messages should
 come up.
 
-The link for the board: http://www.nxp.com/products/microcontrollers-and- \
-processors/arm-processors/i.mx-applications-processors/i.mx-6-processors/ \
-i.mx6qp/evaluation-kit-for-the-i.mx-6ull-applications-processor:MCIMX6ULL-EVK
+The link for the board: https://www.nxp.com/design/design-center/development-boards-and-designs/i-mx-evaluation-and-development-boards/evaluation-kit-for-the-i-mx-6ull-and-6ulz-applications-processor:MCIMX6ULL-EVK

-- 
2.55.0

