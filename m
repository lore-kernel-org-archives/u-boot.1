Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0687C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C9D56071F;
	Tue, 25 Aug 2026 17:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MioL8Y7lXxlJ; Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677219;
	bh=/Ra5CB1lmPomqXaTQ2QHsD3Dh+WyEMYPwDUvGyWuT6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DTyl1Z/gSQwO8nwxRuNJvgC411/SUJUtbbrVH0QOTyDaO+NuhrUk5548m2EHaDSYx
	 MWXHHQ7at/Ji5dSWr6g27/+eyCX2EqOMQKXWD0EOPn+tdximSldVFuM3mePMkYL+MP
	 p1N3YisFZR6sG+pctFvTxSSJLkdCVvIA/dCXU5Tre4XuZNoGbzihPM5LIFPDiBb0VW
	 69WiCMz6fmpQVXd8gZTPMYnMAGQiJVN4ctlF7HxP4QQweTNF+LH9azk7uShiN353/v
	 wYsT121ugTbE9seTey1J0LyEC1DM2OiDh42mogn9nd+xjYwjWm1pRmx0P1Nzq35AjK
	 KUPt0R7lVPSjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 496E260728;
	Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9248D396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84750401DE
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id df1-4zjsaIs4 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:14 +0000 (UTC)
X-Greylist: delayed 594 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 17:00:14 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=e38rKzXu
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::8fa9; helo=smtp-8fa9.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::8fa9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C8B3401DD
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:13 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0X4sCXzjh5;
 Tue, 25 Aug 2026 18:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676620;
 bh=/Ra5CB1lmPomqXaTQ2QHsD3Dh+WyEMYPwDUvGyWuT6w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=e38rKzXuNjoPkDZEB6TJR5iIk0qL+BiUtX9h0G3ARLILpPcpgN69TWFBBqsVIz61f
 XoBPUFebJDpGKsAxKBK4WngPMSXWlsZMyKsB2exLdJ1v6zE0WBJ2rTh3HKeyYV479L
 d5IiRxRZi7fX2pq0/gUOMA0uSf+36SzuF2YOT6/O9C4yqT1wlqN0/u+IVY5QRoeAs8
 FI3CDQGNvcf+IoP2Hn0cfw/6uNKH8vvQGTwfhwN6KcK18Di7Un0nQANYF6JdgFKdhO
 p1Y9GkzfFjpNNCg9g9ZrZ+mbQ1i2vgwWEHVy4xVKNB+/oaj/Dw58xHEh4N63hJ8SHh
 /8sDLed4KyujQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0W13SDzYd3; Tue, 25 Aug 2026 18:50:19 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:48 +0200
Subject: [PATCH next 11/45] doc: develop: uefi: update link to ipxe git
 repo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-11-ee7573fe3a4a@cherry.de>
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

http://git.ipxe.org/ipxe.git redirects to https://github.com/ipxe/ipxe
so let's use the proper link without a redirect in-between.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/uefi/iscsi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/uefi/iscsi.rst b/doc/develop/uefi/iscsi.rst
index 51d38cde2438..52fa79f35620 100644
--- a/doc/develop/uefi/iscsi.rst
+++ b/doc/develop/uefi/iscsi.rst
@@ -125,7 +125,7 @@ iPXE
 
 For running iPXE on arm64 the bin-arm64-efi/snp.efi build target is needed::
 
-    git clone http://git.ipxe.org/ipxe.git
+    git clone https://github.com/ipxe/ipxe
     cd ipxe/src
     make bin-arm64-efi/snp.efi -j6 EMBED=myscript.ipxe
 

-- 
2.55.0

