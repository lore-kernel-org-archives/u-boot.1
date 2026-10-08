Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40465CA6013
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9745F4093B;
	Thu,  8 Oct 2026 22:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPWnrAVj8Tvu; Thu,  8 Oct 2026 22:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B00EA40933
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791499628;
	b=rooFjHFi8rhrVaC3W3V1k1VFqeY/NA2cDqoRka2R3TmY3WXrCDXoPvmnQQl1vJc22uZn
	 N6VXaEtfunm35Law3xriiZDLHXCVLWvf0t/nRkgpaPtci+kJH6hOphtYlD3xcrfy0SNdx
	 pOTH053LH+Pqp4QlGHVfliD+4zGs95/ZcnIlvEGr2qsxdRk2LufPoKGlE430FY00EXiOR
	 nHdOEA1KfJ3yDrSZ9yCnNYEstuOpJVPRvAK2qHsE2opJ7UlxV0A6HL9JpEjBbQD9NzEda
	 S4E9p5zI/PlvNPo9OhOwI4A/ouj6U30m/f4OnSATQluJBYUTeGby8JrYyMmtyA0GUxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791499628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=psVXV/a7yBY8uBIevnyOz/TosNUWd6cV5sfVdBGJ4iw=;
	b=bCG1nQrL46Trv3c54tSRE9Rw974+mBWsQcLWtxm53UWLd9H/MT2dfAzQRu/068VDpew9
	 ja4sAIa2klnunuTTFG+LjefhGDCPNaRpCqRShZc4zQunbAB9CkO0jcn/UJiCbb8tmoJm+
	 lDHHXpzvQPi34jt69CYcf7CUPI1Y/89rYsCGA0IPPp2wnZst5wIHDCe6mejAuz4bFFYSm
	 kUny3Fn5Z0m+WDo1Gl6TFQ5MpjI2y0316FU3vky25hZsotyRmtgmX3hEvk0X62x139rHj
	 WGf43imVj8RVU1HtaWJAX6gTBDSa/eJM9Jtq9LuQnGTofcdy3GTHAdvIU0K5jo13R1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791499628;
	bh=psVXV/a7yBY8uBIevnyOz/TosNUWd6cV5sfVdBGJ4iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HS5zItyqPpDjE0QzNxWWqMA1KYGDEONoBtPLAcX+SfvklRQxOAlH18FAQdKUI5C6h
	 rIcQoDiXacHs4z3HX3WtR1D1QxmcaQpb6MFzgW5ioEDnHXSnIlRW3ockRDmhny3o1A
	 /TPk5v0JUpmKseAPnm4pOz/JzhHS7J/q8m/OOFdTf4RE0Ioc4GBjXjQ0fS/a1agyRM
	 4zuPif7c00X+JvHdBDEDHm0HZ1Gx1Wm51BDORtP306Oln0pjWaMx1eb48mB+L4cfGc
	 lBDc+Bk6tcb8Eeks1Egajnx8GfNp+KZT3jWJPIT+8HJPJj0W26chh52xRPvjINn/kx
	 aPuprP4wU4x1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B00EA40933;
	Thu,  8 Oct 2026 22:47:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C97034E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 729AC813FD
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzCMUj3Ctuuo for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC2EB813D0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791499625;
 b=dBRzI8RTsoKbaTJAgNYbQpblXA1VygCxxCFSIz8nZ6PM2cdBtW7hUKBWyGy5F7gf0Xgl
 iF3j6FW7GhtOToquqnKP5mUwmrKnonW/RYDvT2rri+B5za8J39CIq2na/Z4JuMrYxwuU+
 FoPlnf06XeY7eisAvdnBWjcGMRk6x/U5zNxdJYqtiYrwOCQC2x9cu61DnmyI5bcJjXCkR
 myjwd8ljbLs1yPVcSfZ+c4lG/mUu2Qggc2xyO4v++kBxkuSW35MI4Hc/hxLBsS/2Cfigv
 FsETcPR6NuIHkY2B44AwJ0OCpFjNzTvmQPUA7YUoeFCv83mc0ftpNl+fxts9gTKx+Nw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791499625;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=psVXV/a7yBY8uBIevnyOz/TosNUWd6cV5sfVdBGJ4iw=;
 b=cwUEvtxkLPn1rDW3jhSsr5ctAZHjgkqU+a39VihffB1HFXXsAWIIKPlI1Z8eippT8E6W
 wIkZL/rSIv9qd8JEJEqpS3MvmWqq0j+S+ZJjqhCi1PnSMA4J4dgXiScoDmZKTDBgOy/O/
 s7/l1AOVNdSSkfisWJALFc+iujxYfmXuC+lu8kz1x8Eb3f5YERnQg6XbAdI94AfKQEIKj
 BT7Ttg0gy2uEjVFSibgKElAv1PFiqP4mooeSjlEzYZ26/KIHerQR8nN2GJ0qc/x1edQRQ
 kqzBpDEx/qAVyfhicUTpXzK0rW8QyL36L63kKVWsA5g5YxZo4sJlk0cxESnqmLK3DwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=X4tuApl9; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=X4tuApl9
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC2EB813D0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8CF21B0054C;
 Fri,  9 Oct 2026 00:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1791499624;
 bh=XDA6fQS68P7AQe7Oj991WglFOy/0hPYYRcA/+Ac9KdE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X4tuApl92Zb7XP52ZBYswPTx3D582MVFW/8f4IYI0Nyq1dzOOkuNw0jbxF3jac7eG
 uURLNWPI9VqMfGmvPVYKjqmXAb0utAW/er4TkBb/mYmUnKnvkZQvRgogPe/hVIugss
 /qZ5zwlmxauIYzmEQUZWn+joHfh2g77S9oVFy51rb85dLELYISUpvMNgIpRdk7YpXP
 vjjj5xf2bxbpXl7jSuaY3q5untOLD2ZbFIFgXCYCAGOxHbIn0THoVa9OcLy8O/2pzM
 MehaPFu2M4JPPT2XlQFHCGl7O7oiVcOX84DVqPeV2coGUoVGULnZU+N2chOoR830yp
 TqaWDyatBNnjQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v7 12/13] doc: lx2160a: document the sd1 hwconfig option
Date: Fri,  9 Oct 2026 00:42:25 +0200
Message-ID: <20261008224228.512353-13-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008224228.512353-1-vjardin@free.fr>
References: <20261008224228.512353-1-vjardin@free.fr>
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

Changes in v7:
- 2x40g is also what protocol 20 builds (Vladimir)
- one column per dpmac in the table of the active DPMACs (Vladimir)
- the mode names read right to left against the SRDS_PRTCL_S1
  table of the RM (Vladimir)

Changes in v6:
- Only 161.1328125 MHz PLLS reference clock is supported,
  from the PLLS input or through SRDS_INTRA_REF_CLK_S1 (Vladimir)

Changes in v5:
- Reword the grouping sentence, suggested by Vladimir
- PLLS reference clock as an initial condition
- Drop the MC bullet, and the list of boards

Changes in v4:
- was v3 5/5, rewritten using a table

 .../cpu/armv8/fsl-layerscape/doc/README.soc   |  7 ++
 doc/README.fsl-hwconfig                       | 70 +++++++++++++++++++
 2 files changed, 77 insertions(+)

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
index e752505da49..6b628f30317 100644
--- a/doc/README.fsl-hwconfig
+++ b/doc/README.fsl-hwconfig
@@ -44,3 +44,73 @@ usb
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
+		2x 40GE (XLAUI-4), what protocol 20 builds
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
+		2x40g       2x100g    13 or 20        PLLS
+		40g4x10g    2x40g     13 or 20        PLLS
+		100g4x10g   2x100g    13              PLLF and PLLS
+
+	Active DPMACs for each mode:
+
+		mode        dpmac.1   dpmac.2   dpmac.3 ... dpmac.6
+		2x100g      100GE     100GE     -
+		100g4x25g   -         100GE     4x 25G
+		2x40g       40GE      40GE      -
+		40g4x10g    -         40GE      4x XFI
+		100g4x10g   -         100GE     4x XFI
+
+	A mode name lists its ports from lane A to lane H: in 100g4x25g,
+	dpmac.2 is 100GE on lanes A-D, and dpmac.3 to dpmac.6 are 25G on
+	lanes E-H. The SRDS_PRTCL_S1 table of the reference manual lists
+	the lanes from H to A, so its rows read right to left against the
+	mode names.
+
+	Initial conditions:
+
+	- PLLS needs a 161.1328125 MHz reference clock, for which 2x40g,
+	  40g4x10g and 100g4x10g program it. It can come from the SD1
+	  PLLS reference clock input, or from the PLLF one with
+	  SRDS_INTRA_REF_CLK_S1=1. A 156.25 MHz PLLS reference clock is
+	  not supported. With protocol 13 PLLS is not in use, so nothing
+	  checks that clock before these modes start it.
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

