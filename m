Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78029C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF8F88A4B;
	Tue, 30 Apr 2024 17:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I/RalBuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA36688A52; Tue, 30 Apr 2024 17:33:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCB288A4C
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491138; bh=cJCvrB+H9bTQ7lLlRKHolL+zqNlN9TY1vvdjCOIEnv0=;
 b=I/RalBuX3hwEuMSSLO45sXfLiBXVuKB1PZGwbkT91mC5mVCcj6v+oLRf9AvWOhRKpmj7Gb+3Y
 WdBnYjwHXNgyBwN2qMFQhVNeCKWY+/Dwe+tUmhr9Sun7Nlv67p6z8Sk/sDIeQhbb78MPZ7uOTy+
 jONx7V38fBPk71UqdxujoMACbTfhTkockoLlFiaWRCmA/RjWiBSO9mc8pWX7qc8eEU7ccOJn4nx
 CP1SbZHG9Sd6jn/fEWLohMPFkSScnAPUAkciY4203Sp1LRZR5CZIoxFy4p7B+NQ7vFpBKLj8l0G
 r9pmtR37t5tsc+dKMOU7iaSW6Ok+5OQ8vJ4CGZZieedQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Peter Robinson
 <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 14/18] rockchip: rk3399: Fix bootph prop for vop nodes
Date: Tue, 30 Apr 2024 15:30:21 +0000
Message-ID: <20240430153053.308788-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310ef4d99e42224315b901
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

The vop nodes should not be included in TPL/SPL control FDT, it should
only be included at U-Boot proper pre-reloc phase.

Change to use bootph-some-ram prop to fix this.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch split from "Fix loading FIT from SD-card" patch
---
 arch/arm/dts/rk3399-u-boot.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index b9b8d3ee1d92..496f25d9fbf6 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -143,9 +143,9 @@
 };
 
 &vopb {
-	bootph-all;
+	bootph-some-ram;
 };
 
 &vopl {
-	bootph-all;
+	bootph-some-ram;
 };
-- 
2.43.2

