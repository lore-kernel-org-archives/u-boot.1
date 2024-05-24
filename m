Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36B0C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15FA788489;
	Fri, 24 May 2024 13:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7881988664; Fri, 24 May 2024 13:46:59 +0200 (CEST)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7250788442
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm3DK0vGXz21w;
 Fri, 24 May 2024 13:46:57 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm3DJ4mnJzG4J; Fri, 24 May 2024 13:46:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 24 May 2024 13:46:35 +0200
Subject: [PATCH 1/3] .mailmap: redirect Philipp Tomsich Theobroma address
 to Vrull
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-tsd-to-cherry-v1-1-3002bed55f19@cherry.de>
References: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
In-Reply-To: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
To: Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The Theobroma address bounces as Philipp is not working there anymore,
so let's update with the one that seems to be working right now.

Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 8049856d41c..e530949a308 100644
--- a/.mailmap
+++ b/.mailmap
@@ -88,6 +88,7 @@ This contributor prefers not to receive mails <noreply@example.com> <pali.rohar@
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
 Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
+Philipp Tomsich <philipp.tomsich@vrull.eu> <philipp.tomsich@theobroma-systems.com>
 Piyush Mehta <piyush.mehta@amd.com> <piyush.mehta@xilinx.com>
 Prabhakar Kushwaha <prabhakar@freescale.com>
 Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@amd.com> <punnaiah.choudary.kalluri@xilinx.com>

-- 
2.45.1

