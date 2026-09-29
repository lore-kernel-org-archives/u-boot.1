Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23996CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E029D407D3;
	Tue, 29 Sep 2026 19:38:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ds17nHFnccLi; Tue, 29 Sep 2026 19:38:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1FC69407BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710706;
	b=QVkT9qwMJDYUI1WpFWjyjjyWk8ijFkywgKbZJ2Xsp73c39IBomjRCBqNaaE6uGEJ9LNL
	 kar+dlprFkNxuqmptwmMGFGGETBkRCNBnqEK/G7huNIOQCf4wRP2YieaRYmDrS7ZLIh+S
	 G4F4iVamOYHluXuwZWOhmGEgxvJVxGOCddAUiUCbW4Z0UKy2jWCASFsl8nlRM9tAYPc5s
	 LyXixEwrigfEPCpc6OeCrzxs3bRDzKxRWfhtQFJ/EUsZLEfQaySRw9seUePQN/cPeBN3r
	 rAO+nH2I8tuQPeoRPzmSiZLtopXmg3dUpFL6RlN600xq1xvY83DHuCbAU1PEAjFtV6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Pxl401zuW5q1YPAdXSg99t2POiq2Xj4peBkJftg70Sc=;
	b=shWiqNoYaO6rAzgA0WCJwH47QZ8UxMfdOSYPMnxfgiyAS+xPEnsi0Xhjpd6QZ9E1B1zZ
	 KCnKvlF68XD2XrSD6K7g+mVVpONifZfHxk+6ZZPW9kmMXieaRt9r3r3eaw46+Lu2FKnS4
	 OfIKqTGHrXmUfJKxoxD5vufZcmslJX1oSF3381ewv5q25ltD8UaDOy/caaej1Wk+CgXCR
	 XBjJA+k9m9JBhOnrR5jge8bg4cmHmijJl/AUr9enbfZ4erwlZd9mpoLONNdeopg/v02hI
	 OORM6VJuLzfnDSytVFCNmEOEib5WBl6gMQnGurTdWQim9gMSe5/VIbYdcUHc075pqYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=isxdZpbD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710706;
	bh=Pxl401zuW5q1YPAdXSg99t2POiq2Xj4peBkJftg70Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2TAN0RBtgjifgOezl4U6xbtFi8FYo8qEn1oh5nX1X/23HoAxrefxeem6Yq7+eZf4
	 veTc1WCQLD9wlEffeC2qOcY+lYPug5XnUnk0CN6VDItQVH2y+zv7byg1z3JYS27nJB
	 gTI9ICSbXqVvjK0IMP/u3NhZmeraYighPnqfgoShPQDw6Boisyt5rYa8duhnDMYaNW
	 lCWyIdSiXCk1RFMKBYbVi8GkcfDS+q+w932nQffd7mR6Ph2iUttInFd9Uwhq6rf7va
	 4hQ6bgBXwytjiHfo4megYhBSoYTVICcXnMNeJuOOfRjzjSmlv4W3m+ZuEC1jBEozJ7
	 qmgMkdt/hpWPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FC69407BC;
	Tue, 29 Sep 2026 19:38:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C1753D8
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DC40407BC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NakHl5LYNF2K for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 42BEA4066C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710704;
 b=fnLQ6qQtjLkkvI1xOpSOxa9bjulNM1kh6KYLFdj6Hcoao0nBDRU98wxOROgMq5e1z/vA
 Jl7lLfI8qpn/D7Mjyvm4GpW/pqt+H8sSHk8S8FI9tSmjOARfqQSMuyj7uTSOCFPMUlBsY
 1pXgGuM1jXk3+EdELurU7z22FL0YCbT8bHMAn6lnojz28mkJbLBQzx0WoQHkPaIkUVThc
 cR0mhOgIqes14oXmF5UMA7v9x1naC8x3ahfiZIicWOdd4ML0H1SCDjq171b/hD2pgvQgs
 1B4cCDSQmYcePDZWE7jYynHtClQbol4iZ7q3zOELK4nOvRgZuOEdmIMaerGSBaKe0Kg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710704;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Pxl401zuW5q1YPAdXSg99t2POiq2Xj4peBkJftg70Sc=;
 b=sCU5Uxu8uKg6k/Si+PoP7TREFZEGptNvDzFV0VNCmC68UYsdN0lJEmFWwGKCmWOQSH7D
 bBam9SuaspgCYDaDQ+GqY7qEf70n4hSUg2ZTXU2gEqsEDim0mj9SfP5rgrO9PgSEGNi9F
 kEl37gDjbTIdUgjHXyM+WDbKimDMhuUo2851azC0dKC27MCmZYICFFqmTzyKU/1bP27up
 wr1+7+ROZMBhmhox3O6ly8cU0boFJPB24oTkeubCpRujHiEflPQwdddISlgNdofZXPBLR
 NnrbkEDbs2e+C6kAtFb2Ny464Kr3o8Vo+rz8cSmxqA1rTVcksMgDJeXjAvlKFqqVQOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=isxdZpbD; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=isxdZpbD
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42BEA4066C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:38:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 503FBB0053D;
 Tue, 29 Sep 2026 21:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710702;
 bh=HKHDm5dgTDV5BSEn/72bZgkPOKVGJu6GqOIpzw9D8dU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=isxdZpbDVVfgC1H9xZYD+t9bUhQSN7eqXv1ZazrWGyJQN9TEC0oodwklrdRjOxib/
 FUelXjNJA27WzBsLNMTnPouqzYlDhdQVDP/1SoZPNGMiOETvCSWynsTBHUQUkfIw9B
 dESB5NcJzxE80DndymOJQkUqhC71+flyLnVTP4lKqavUXwUlmLfkxpLM9oQOipRcCX
 wMA6m7UB5jmf/gw0UIf0keXhVBtcsHd6FvVgtyFekZyLuZsoxBN48YYyMZ1dib5FA3
 THJlRWlOtMKmd9G/ks+lK6JryxeH/C33r1kGDWi0ehFfnEKUvdYRwJvTPfVbyHlIzA
 bS4BU9gW7zx3A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 12/13] doc: lx2160a: document the sd1 hwconfig option
Date: Tue, 29 Sep 2026 19:59:44 +0200
Message-ID: <20260929175947.1379710-13-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929175947.1379710-1-vjardin@free.fr>
References: <20260929175947.1379710-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enrich README.fsl-hwconfig with this sd1 reconfiguration scenarios.
Add a reference to the Layerscape README.soc.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

Changes in v5:
- Reword the grouping sentence, suggested by Vladimir
- PLLS reference clock as an initial condition
- Drop the MC bullet, and the list of boards

Changes in v4:
- was v3 5/5, rewritten using a table

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |  7 +++
 doc/README.fsl-hwconfig                       | 63 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
index f2efd4cc1d7..a641e4978aa 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
@@ -331,6 +331,13 @@ LX2160A SoC has 2 more similar SoC personalities
 2)LX2080A, few difference w.r.t. LX2160A:
        a) Eight 64-bit ARM v8 Cortex-A72 CPUs
 
+SerDes 1 lane grouping
+  SRDS_PRTCL_S1 is latched at reset. U-Boot can still configure SD1 before
+  the MC starts:
+  1x100GE + 4x25G, 2x40GE, 1x40GE + 4x10G or 1x100GE + 4x10G.
+  See 'serdes1' in doc/README.fsl-hwconfig, and the 'lx2160_serdes status'
+  command.
+
 
 LS1028A
 --------
diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
index e752505da49..cbacbe72545 100644
--- a/doc/README.fsl-hwconfig
+++ b/doc/README.fsl-hwconfig
@@ -44,3 +44,66 @@ usb
 		usb1:dr_mode=host;usb2:dr_mode=peripheral'
 
 		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
+
+serdes1
+	Specific to the LX2160A boards whose reset_phy() calls
+	lx2160a_serdes_apply_hwconfig() before mc_env_boot().
+
+	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
+	can still be configured before the DPAA2 management complex (MC) starts.
+	This option alters the Ethernet MAC-to-lane grouping after the fact
+	(RCWSR29 keeps reporting the initial protocol).
+
+	'serdes1:2x100g'
+		2x 100GE (CAUI-4), what protocol 13 builds: nothing to do
+
+	'serdes1:100g4x25g'
+		1x 100GE + 4x 25G
+
+	'serdes1:2x40g'
+		2x 40GE (XLAUI-4)
+
+	'serdes1:40g4x10g'
+		1x 40GE + 4x 10G (XFI)
+
+	'serdes1:100g4x10g'
+		1x 100GE + 4x 10G (XFI)
+
+	Each mode starts from the one in the 'from' column, which is
+	entered first when SD1 is not in it yet, and so on down to what
+	SRDS_PRTCL_S1 built:
+
+		mode        from      SRDS_PRTCL_S1   lanes run on
+		2x100g      -         13              PLLF
+		100g4x25g   2x100g    13              PLLF
+		2x40g       2x100g    13              PLLS
+		40g4x10g    2x40g     13 or 20        PLLS
+		100g4x10g   2x100g    13              PLLF and PLLS
+
+	What each mode makes of the two four-lane ports of protocol 13:
+
+		mode        dpmac.2 port   dpmac.1 port
+		2x100g      100GE          100GE
+		100g4x25g   100GE          4x 25G: dpmac.3 to dpmac.6
+		2x40g       40GE           40GE
+		40g4x10g    40GE           4x XFI: dpmac.3 to dpmac.6
+		100g4x10g   100GE          4x XFI: dpmac.3 to dpmac.6
+
+	Initial conditions:
+
+	- PLLS must be fed a reference clock from which the 10.3125 GHz
+	  clock net can be derived: 161.1328125 MHz, which 2x40g,
+	  40g4x10g and 100g4x10g program PLLS for. Protocol 13 keeps PLLS
+	  powered down, so nothing checks that clock before these modes
+	  power it up: the board has to provide it.
+	- The MC DPC must set follow_hw_pssr in board_info/serdes, for the
+	  MC to read the lanes rather than look at protocol, and the DPL
+	  must use the dpmacs of the new grouping.
+
+	'lx2160_serdes status 1' shows the resulting lane grouping and
+	protocol converters.
+
+	Example:
+		setenv hwconfig serdes1:100g4x25g
+		saveenv
+		reset
-- 
2.43.0

