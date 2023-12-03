Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C876AC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D332D8779C;
	Sun,  3 Dec 2023 14:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rtYi3XOz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nKWxM4Ve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5D886F6F; Sun,  3 Dec 2023 14:17:17 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50BF68761C
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4SjnQL67kTz9sTR;
 Sun,  3 Dec 2023 14:17:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0E6qArBcQBn5/vxMJemH0TK74qcBEbO5KEe3aUKBJRk=;
 b=rtYi3XOzFo3RPsKoxNZO/RvEnVifD1LFa0cujmTPO0WLMJQUjDavQ6O8oqI1rcOeSf64pY
 R+B5Ztn5IeqEmzQ0UVpEpd87YiUwkJL3PNZv5tbl4ty3jtEiRAXNEj/QzvXxRzwmzokVlj
 qID5BrGs1DIp9IrRYAY2OBZ0P3txUks3FQAX6PoQh8JQTkMIPN+u7MkDzl6D9cRhCbAEDK
 ATG7BXfm6ZlLrT82G52P10CaZMkEfSKkj4nzFlpf9Y7CB5zZicVRIpscL1eqlbiwNDyaSh
 0HfC1GnTb8oj6H3VBdzI9oFb9nvTHY3JBsKRuqSvpnUGjailXBd8An8q76iwaA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0E6qArBcQBn5/vxMJemH0TK74qcBEbO5KEe3aUKBJRk=;
 b=nKWxM4VenyMAXkHaxRKb+iRu6TAYMUm5rRRIagCoc+jLMIW2FiXoAj4DR3YW+FC4c0G1wP
 LJLkYhR6m+Ujn/ChekYBT2egcs9jRdvFQHn2PdTVYf/6U+r3ufjPqOzWbgRgMXHqhUeu7/
 M0FM4qGahSNlu7KDF17qAwIsX41ejOxYyYCJKq1iZ0VkzObIl232fcV1oaeW9NYcKrQWQE
 mIak8GfQg91wFKT2M7EMhjLatuqLvk86rMzQWb0J4xT5Am8apJr7R59bVtc4+GLehVB+D4
 LdI1oNb8isewDiwlR2kubICWiCRaIBBsgNwGopS8sHok0TV6br5M7MkcnkZYNw==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/12] ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs
 with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:23 +0100
Message-ID: <20231203131635.119191-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a03d77291cece496ed6
X-MBO-RS-META: 4podrxonjc5boe4iutchafonchnzk95e
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

Synchronize R-Car R8A77990 E3 DTs with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77990.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/r8a77990.dtsi b/arch/arm/dts/r8a77990.dtsi
index 1be0b99c15e..4c545eff9b4 100644
--- a/arch/arm/dts/r8a77990.dtsi
+++ b/arch/arm/dts/r8a77990.dtsi
@@ -76,7 +76,7 @@
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
 			dynamic-power-coefficient = <277>;
-			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
+			clocks = <&cpg CPG_CORE R8A77990_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 		};
 
@@ -88,7 +88,7 @@
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			cpu-idle-states = <&CPU_SLEEP_0>;
-			clocks =<&cpg CPG_CORE R8A77990_CLK_Z2>;
+			clocks = <&cpg CPG_CORE R8A77990_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 		};
 
-- 
2.42.0

