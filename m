Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C5DCA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A80660802;
	Thu,  1 Oct 2026 20:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NrL14tY6InzA; Thu,  1 Oct 2026 20:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3D2A5607E3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887930;
	b=HOlqgxMjWkchrdLPe3pFLnRJe989A16O0vu0kXkCZIFYDEtly86uI/D84JUFc7tUcy4b
	 W5X5ggannH/5/e2BxF66QcCkaAOyB1Y0NU7ihJqnmB4aapNZwou0GMX+wDheQuJ1nL8he
	 99h/syhLkjlHNSVAddNJW6Khg/EwzKrCT4ocDTXPScEvcrcIKm2z8GpgrRCGT7laCn/R0
	 HzqZXoZgKfv5j/om4YiivJDDLx6ERGsjsyx4T2ToU1Igsc27fB8uz2Zno7vfIF3qjWjMM
	 JOR3fyvztk9+g9SB+X0YGHqgdM/sdne8nX7WAfTNwXIqo9Vp4+sScUZviEaY+/YMn5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ul20IUlpqmYnNeB/Qey3KwWtehkqXv+CHvQ3ecSM6tY=;
	b=IG/kdztNVnTJnJUte1ANJetHSV15dtDwygRaU5Vha6yCEcJKRv5t4xDX+8kN+2Rf8Qse
	 UAavX+zoDN0X+zjBrld4BF5BOl0g2cA5v0m5m6xugq8WTyFQl+MTnogd5Tp3BnyVqEML2
	 fOWx/y68RE4qNaBoLHRjtifLQL6+ZUYbr1SUVKs55WVEUbhUwgbtzSXe3LpbB/EIfz5Eg
	 JH3rwBZZnTzb1UaSXRrsCygKe+k9dUu9GncjdT3mvPqTmxL49JW9yPXWU3YpGuv8hwWBH
	 Mj3c/EhMJimLP7v/6f6HmjoYRrRbZsAis/V6ajmIfZ8Mm0LMwifTZTOsyoXOrmPMixw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887930;
	bh=ul20IUlpqmYnNeB/Qey3KwWtehkqXv+CHvQ3ecSM6tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cH3ZpUsXdr2tJX+UAPGjpqzQBxa0VsrdBWEq9zHjRA3eYH3qm3Re4DoAPwgQP2cNP
	 an4rgNQEnlkuM3StxXmPnQcYGZ0wB+5RA/3CBxdb4nUZYlJtW2XzxJN71HTBpOuSRv
	 ztFraauzHrUAoqx9TI4VUUt9aBIStT+DbMyzw3nReAw4Du200DXRqw/r8DJ1WMu5vt
	 YBbYIkY3ZRS1IS0SKgrnlO4Mnwduz13r+lyUQPJQcOI+jfT+dG3mn50AQd6KOmX8wn
	 tI2WQ/pOizbkr6HjkeJ3MSOwRJYjXZaNRVooPOY3r6wuwn0S8aYGGb1lJGs/wicbop
	 qQI/u+yqZAY+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D2A5607E3;
	Thu,  1 Oct 2026 20:52:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 185A122B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A31A40BEB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1O6xmkVFkkO for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:52:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4321040BAC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887928;
 b=MfPsV3n8KmajbXA1YFRdwQdKVUMoNnlG/FpCtjHXQJu26qNyXicdzEwwVwtQujE1AVZa
 UKxey+jxsVNVy7FEcETLXnFAbmXEml/s2t9zoGVQdsUcUo8cuSvuHG0Xq4hVq4YWqspGW
 2LfYj1cSZnIkZ7y+K60NBoUryk4CqH8PQhfDRQjEmD7DE+wfemo47IqdRj+l+6dVmlBFt
 KlS3TazMqjXKTU0rXr1A3i+WoVO9vr4JCjUZ3YyjBz3O93lAf27Oux4PrtyVEAhuMPgfv
 GUIzg9dkKX11vZX8leFYLAti77yqmYeeFzoq8+efhiFJlfd41gp1gnhyZLIsgWKf2aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887928;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ul20IUlpqmYnNeB/Qey3KwWtehkqXv+CHvQ3ecSM6tY=;
 b=a7pWRigWXeZJpLD0ceqm4FuMWRFYwM/zHedUDPwZQabukXjDVZ2I5Yz+utOWKE4pSuMk
 zzwF7g0uAAyvEXCvQFnEoUS4K8oZ0YBoKFw6x4qhRGCdT3DDO50OJyc4jb9sne4fmqKYu
 HJ8gJ59OpYR5VVQRBd+BgUWikvljfnqKXYG+TKVrUKcgFN6Dvpbk2zBSCJPAO0anoL8Xq
 2Zhx0w3If8WOjM5724scRsL2TBvjHfhQa0x9DbWr5g+0oS3ep2353fP7eDflhk41B7As7
 NAQEQb1NySFyi8GQcVgUupggr8DXLMJuKY+tNc2z8o/v3PLdDY/wk2PfW1c+MPArqKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=gfBcNWG7; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=gfBcNWG7
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4321040BAC
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id B234CB0055A;
 Thu,  1 Oct 2026 22:51:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887926;
 bh=UWw9kptWFSZdv2TAQvmMo5vTekt6nACXrhqyU5GcDBU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gfBcNWG7S2n35Yc0o84WV+WtmZLKfqDQWCEsRLDQ6jCx1te3mnOZcPrFzCbhRJZNO
 4eqHTrWavEuTsXHjOSNl0sKcD4JCC9BF7fvSz1IrtLYwuh3Gfbo57jqGnlrw8quxpm
 B5UPbua3iJswnAINZYQH5QZeez5WFL3M8OanR4beEQUB5TR4YuLBAtKsnT0AZFlrRy
 vLuTMDZd7hFk3UJOwltI3GVuW1/87OMQy142o8RIYR4aTuNvmwIECP21sKcz4l9+Va
 41J4KvGr9yLv+ys52aZmAXlN7NeuDnEf/qpOPs84gdoefyl/4w3FH6u8Wcj7ON0AfK
 pYFsQGwP46/aw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 12/13] doc: lx2160a: document the sd1 hwconfig option
Date: Thu,  1 Oct 2026 22:47:29 +0200
Message-ID: <20261001204731.1774613-13-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
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
 doc/README.fsl-hwconfig                       | 64 +++++++++++++++++++
 2 files changed, 71 insertions(+)

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
index e752505da49..91bc39d7238 100644
--- a/doc/README.fsl-hwconfig
+++ b/doc/README.fsl-hwconfig
@@ -44,3 +44,67 @@ usb
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

