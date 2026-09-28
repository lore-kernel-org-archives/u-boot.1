Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF215C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5BC28087F;
	Mon, 28 Sep 2026 10:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HDsrIdsF0739; Mon, 28 Sep 2026 10:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DE1EB8084B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790590635;
	b=qZ8JQcgguKh+4tWZ54k1e0qNkyThhy5Gynz4Bd+3KTMP9C6gLi368DqQbirs3SvUEX+3
	 NjmrifCU2WCbquuvrIu6hCKMWLizQfAL5pLYLKq3v1dra2NaLriHAK0+ust3YMiT3rfM/
	 McdDxJ2P/fuAHptCZMO8lzk93OFGZIf2MXZzq1TFlkYWJjjEYYCYUozB3AymIQsxH5K4a
	 8YCVF0B9xF6JvwTiNToGb2R01FMBXF89hrxCYbkVTVZKxbJSAOy42xCFNMhTaRbc5BrJh
	 Vvmok5G4iv7sPrCjc2UIJnukbFqHi276Wy9OhtGSUrNJlr4NjSFs36wTf8rXuW6si5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790590635;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K3mOCRDP9SeO34xqyHqaOqTaQLANSUZ+R7JVBROjzf0=;
	b=IF4ozkCnyl5idrg2z48ddfEQvNcGLB8DuEqEnuaYTMRAKFzDruJcllxSk7ShWAeJYi1z
	 00PUNjEUPO3Il4Mk1qbIPSD0isNNFErTzMKZgpXwrv6AIzIYtudQK0TQQjArQT4hC13nL
	 gdEZduMAjx8lRQPZj+P52+nagNEUri8cFofrtWsoL9HEvIWj2tE5pvc9mWWy3P/KLDDjK
	 320XOghLGeL4rldP/WZ+ghSVtUSjKS7OlKjOPFwUruXzTndQZBfh6jJyT9INzqZmlKKVA
	 hvL8r9b0BUSqKM2VfFRgymp7Mj8U7awbZUOxpW0at0E1V2b+mZsTR9hB4XGnI7enRtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790590635;
	bh=K3mOCRDP9SeO34xqyHqaOqTaQLANSUZ+R7JVBROjzf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TNc4WIkm9jLp6rcemeXFhk9VFy46f67883WuoZhxzMAsYEOGQSWRXK7v8Oa+Zh5Y1
	 HexyP9YTLYvpnzPs8S0Vj49MO+eVv6L93jm3RcaMldgN5TCZb81QntfxQUg5FWbl5n
	 KqCwmV4puY7CTviyxnjdtTVqXF8JDnxUdIM+l+KimnEDlCMKl4+B2kOO8+rk/gV69g
	 TlauffylupHTU+efJXA5LEg0/THfsnor80qld3JOIQTKZnV8C5ekAZx7r9HnEMxoJt
	 9dVrkGwb2xtePnM9eCx3LXR5RryO1KWGvI52447oDczR2i8zzL9CNAMsHaQyF4n68+
	 1OE8ztI1eGVLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE1EB8084B;
	Mon, 28 Sep 2026 10:17:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A1EB3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E40AD60681
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GCw-MXVhCXu for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:17:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 03CF16067F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790590633;
 b=Tl8U4xbzOGldZN7Ja/Het/D9z21WJfdF8DrpswzHudYRLc7g3R6Ag4RTUIZ5eZoB7lLk
 JA9vtHfZHYr7tgYP9befyiCT/C+gS80RR8aW3C6nfXJC/FL1XyhJ3lq2roM8P7kRNB53R
 OpGAAGseYibIiFp7d2ZNaGO6ja6gA6GkcLkswTL1t3bghe77UjKZimOCBbyBgjykAV5RO
 zw6sFs1AtjhjWyfUvxthDuxNVRkmDIs8k9UR7xKwOSzISJbQjKpemtTYEZ1NlqCIE9fwz
 K3eVALYTpi90MGyY4N5L69keiobl6v4ITaNd2oalTrfTAQcSsaCxMLYXhETAaY+ou0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790590633;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=K3mOCRDP9SeO34xqyHqaOqTaQLANSUZ+R7JVBROjzf0=;
 b=VkHkdyYbG9dHbDSGVUwHTTcnAQY5TNoMdRoHMQh6j3j5gZ0VF44KNJjocnPjZmb60aPd
 USjDpJHqMZuzQrBnYO+f5Ydlu3Z6lY3Vj86j3im+cKNFTgpej2KFlkMT/7x57/bvJKAG8
 ieQNqtLGuyR/BJWehPxrkF5KewtebngSpBLMLFcbYl56GGKxhAei+/+Ic0K/vcRD9kgI4
 I8tecYkWOLXagS9mVDmdtJqte9ZUPRCSIokV3Emc2ZNq5mfZuoqrbDVSjoa+QZp8aK1CY
 MCsSAeCcdjbldSUCXh6rsMuM9nLNUDhplpHkDOTtSGfSFDm8/yVsnXaNiUY5UxjT8mw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=oZfBNUxn; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=oZfBNUxn
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03CF16067F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id EE11AB0053E;
 Mon, 28 Sep 2026 12:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790590630;
 bh=HUpdTfNuRxCCLS4uEg9GlERgG50Dsq9dRg8Ul84pYZI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oZfBNUxnZdRQG52aWbHhUhdeuPCqRfTSJ9gQwI0tKHlKvIzzUZNSKNiRHY5Gyz9SF
 I8s5KksT1yuaWpuhRfOv8RFaViHz4VVPR3f6q6TDg2dH1p2EZZKvJxZGflKJSNIrA2
 9M6u1aavLX6cCin+E6KZnzrdhflqzttIF1UygQzfhTSkinPTVbNVSdiVrGf+MAzYdP
 aDid8HBiTWeBNd4Hr6N4G6MNdg+NB2JmCP3skXk/0N15YHda750Htz2rQHwNQdWuEQ
 mNs2IGWaqTuICAKPreiWXCWQyX1th5TtUmlPfXPdVnduQNUzNn+B3MVW07HYPXo0Z2
 7QyGOKpwYMQ/A==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v4 09/10] doc: lx2160a: document the sd1 hwconfig option
Date: Mon, 28 Sep 2026 12:13:28 +0200
Message-ID: <20260928101330.881662-10-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928101330.881662-1-vjardin@free.fr>
References: <20260928101330.881662-1-vjardin@free.fr>
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

Changes in v4:
- was v3 5/5, rewritten using a table

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |  7 +++
 doc/README.fsl-hwconfig                       | 60 +++++++++++++++++++
 2 files changed, 67 insertions(+)

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
index e752505da49..3f9d2ddad75 100644
--- a/doc/README.fsl-hwconfig
+++ b/doc/README.fsl-hwconfig
@@ -44,3 +44,63 @@ usb
 		usb1:dr_mode=host;usb2:dr_mode=peripheral'
 
 		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
+
+serdes1
+	Specific to the LX2160A boards whose reset_phy() calls
+	lx2160a_serdes_apply_hwconfig() before mc_env_boot(): lx2160aqds.
+
+	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
+	can still be configured before the DPAA2 management complex (MC) starts.
+	This option picks the grouping. The RCW, and RCWSR29, keep the
+	protocol number.
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
+	- The MC must not be running yet. Otherwise the mode is refused and
+	  SD1 is left as it is.
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

