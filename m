Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD26FC88E6F
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 17:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C64840688;
	Mon, 14 Sep 2026 17:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qjlaDuToDsgd; Mon, 14 Sep 2026 17:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 59CCC40566
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789405589;
	b=IBebOwU2QHEWEob4AWOiVojXg+pm5JQuXKAKRTK+mGzs19x62nEotXjKrBgz84jnwrny
	 Q234JhZ7ASUFFJdHjONTpiaxFCPt790KjuiEkHoDb3ueNt27xVogrwS3KJNLBYWVpzdYX
	 vGq56gvwjxZYDce7OhC7MN9Ftqr8JIo9bnWhzHBFQSHnqpVpaFJx04pxfVRRrJYeiU4iw
	 5Z/0QGduHg7y628np97+5f14m4Z3I/8DXdKsKP6ra9Z9qHnILAG6OEZwGVFTbP/y/6kK1
	 4JYhxUzMnqZWY5dR+fAeTb0fB4AcXIGp3YwvbKR5Vbxtq7vKOwqip6mHqeCIFzHks+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789405589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nknx5jloIQLjrY0sbyf/GEJWNKApRV88SxU49ltlMVc=;
	b=CbaR7JPALEtro5zXa+jgxY91T6FL057DHkW8mueeSnjPmLW5Aw0yuE/PC7mcLfxBgRZK
	 3no8/ZFg2z39hmjzyfa+fDlpMjI09HKZmCdJyAQshq6HGBGy32OyIUDTCbHqzayg3BEX4
	 aIeA6yBJXnTv/+GbJqOET6uHxeJBqY+/Na4LBYWvzYZBWIKHPiwcdbXVvDZ3ZVYNM21qe
	 iLACTHiExDl7rDbLyct584+so4iWJTXFYqD6ro9KdwBeHcNYjpsAdLRTMXAZykT/nWW6N
	 xCnGlJJsYiCgqNim3Y7UVpiglFrxBfw7Kxi12zcaQci39MhD1gQYOpy1uWBvYgaEx6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789405589;
	bh=nknx5jloIQLjrY0sbyf/GEJWNKApRV88SxU49ltlMVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TE49lho7G8Rzb+Z8Bn+0yGin2umlJbmPAhdCQi/EqlgHl7G5nT75ZTWXFxfSxRrUl
	 O5X2psGiMRy8RYtDmxlLU1yR7akEaUCP2CLQxrJxG48Twwgn4EEry62Yrrk4y4XpzY
	 +PIn4+UCLnPBO6ueHwd7dgYmQ80VRp77zoeoeQx3NK1koLtx84GQnhxqFcXPt3RCCH
	 pM5JaOcRSzLtDWGFer1u0opOBC5b5kaPIM/XFy/lX0gs01Vv3vIhVIzUSas/uNhodi
	 vVA+t1tSM2j1Ed8VYPvfCAp4NtVWzbLGLAQc1tG4/dxFP2AXMJ6PAaeReM+nG6FxkV
	 8egpK8IoBFUCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59CCC40566;
	Mon, 14 Sep 2026 17:06:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C6CA6224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B885580E45
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TVzJfruGEXZE for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 17:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 17E3C80E42
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789405587;
 b=S6hk2HFddagHXaJgTt6LI9h76H8oQk8HWLbRM91Q347qg6fzKEa5VHwjGvpOS8eOZPgp
 hSENtOgZCvp87WUOdQW+kzkPBSRDRy4t5/MPKY4KPxUPCTDVyco+r2lHSN6xVVve1HFyT
 CRNOze7JcU7eh8NthA/A8CD1e1z3CctPlOtlmvnQbDhlsKXPtkuNOAVIk5i/bR2CcG8Z9
 nRpwBMYAWbZ2w+pzCZeUJVsXjKjHwCpJaYrbiFwziPTL8h+R2fZP5v2KXnero101LUVQ7
 Uktm5+banI6K5tWtKYWLUHLixujdpR3oIe64S1fZ/LenCc4dGwYu1bwwXdVQSnxSE+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789405587;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nknx5jloIQLjrY0sbyf/GEJWNKApRV88SxU49ltlMVc=;
 b=G7SlC4w4DFROeWnofguVcSsqNcOXAsfIlsmz54qrO9NHt3QSi3/IBxCgNeFUeFkZdZer
 TWgKTyFCDbdAxpEASdZYz2W/itWWwbWKWWb5SAyYUW40NgM1kLOehGFgxjwrhO7l2/sK6
 nQFdK4gbHhUaKkJ0AekF99dU5umlGq6kinghFdarKCEzFEGLMrHdeBcG9M0nJV9GwBX9C
 MAGQqveRmW+ay52LXdZ+8AsVmZKfBsBlukxca2BdelJbkv3lMd9o2vQDcIKULlcAtPzG9
 zicdq23W5UucsiJFAbDfZzFTl4YPtnAGRM8NDaWGHLel4Hav5tpjqYxG+ACQjNz25NQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=dmZixvtA; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=dmZixvtA
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17E3C80E42
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5973FB00539;
 Mon, 14 Sep 2026 19:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789405584;
 bh=upu6xPmZ2bz1fu+00Iz4DQ7djaz92npYw7ZUXMdvYTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dmZixvtAUSlKCMtCgfCRgD4nZuaHlnX4liPag8jxeQO3w62ZyE10YvxVFTBKyDSeC
 BfscrxtazdX0QwECuFqGn38LDHbonyPBwMJuIRdnWv1YPodWzgW+xd9PgOqS4bezDE
 cAm1fCTsDVy0dDKhNrj9gI+f6IfMwmb7s/K7yngr6yfUG9I5Y/OnjMzzAiHvgSCRQt
 BO+Z0WOh/tvFKJS8itvddOuyPbZvY480IpTv+IwNTIXS0JopVweMhWIItHhvrWc1yg
 HvcHMKEvy7CQU7Sdz5jMjGUFlC4Ck1SaBN239R4M/nE7k4ZSfozkIZenx3julea32L
 2RlvDMWQOjuhg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Tom Rini <trini@konsulko.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v2 5/5] doc: lx2160a: SerDes 1 runtime lane grouping
Date: Mon, 14 Sep 2026 19:04:17 +0200
Message-ID: <20260914170417.3052423-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914170417.3052423-1-vjardin@free.fr>
References: <20260914170417.3052423-1-vjardin@free.fr>
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

Add the 'serdes1' hwconfig option to README.fsl-hwconfig and a short
note to the Layerscape README.soc.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

(no changes since v1)

 .../cpu/armv8/fsl-layerscape/doc/README.soc   | 10 ++++++++
 doc/README.fsl-hwconfig                       | 25 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
index f2efd4cc1d7..a6f729059a1 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
+++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
@@ -332,6 +332,16 @@ LX2160A SoC has 2 more similar SoC personalities
        a) Eight 64-bit ARM v8 Cortex-A72 CPUs
 
 
+SerDes 1 runtime lane grouping
+  The SerDes 1 protocol selected by the RCW (SRDS_PRTCL_S1) is latched
+  at reset and cannot be changed afterwards. On the LX2160A boards under
+  board/nxp/lx2160a/, U-Boot can nevertheless re-group the eight SerDes 1
+  lanes before the management complex starts: 2x 100GE can become
+  1x 100GE + 4x 25G, 2x 40GE, 1x 40GE + 4x 10G or 1x 100GE + 4x 10G.
+  See the 'lx2160_sd1' and 'lx2160_serdes' commands and the 'serdes1'
+  option in doc/README.fsl-hwconfig.
+
+
 LS1028A
 --------
 The QorIQ LS1028A processor integrates two 64-bit Arm Cortex-A72 cores with
diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
index e752505da49..605a5fd0d77 100644
--- a/doc/README.fsl-hwconfig
+++ b/doc/README.fsl-hwconfig
@@ -44,3 +44,28 @@ usb
 		usb1:dr_mode=host;usb2:dr_mode=peripheral'
 
 		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
+
+serdes1
+	Specific to the LX2160A boards under board/nxp/lx2160a/.
+
+	This option re-groups the eight lanes of SerDes 1 at boot, before
+	the DPAA2 management complex latches the protocol converters. The
+	RCW-selected SerDes 1 protocol (SRDS_PRTCL_S1) is latched at reset
+	and cannot be changed; these modes change what the lanes carry
+	while keeping that protocol number. The same modes are available
+	at the prompt through the 'lx2160_sd1' command, and 'lx2160_serdes
+	status' shows the resulting lane grouping.
+
+	'serdes1:100g4x25g'
+		2x 100GE -> 1x 100GE + 4x 25G
+
+	'serdes1:2x40g'
+		2x 100GE -> 2x 40GE
+
+	'serdes1:40g4x10g'
+		1x 40GE + 4x 10G (converts to 2x 40GE first if needed)
+
+	'serdes1:100g4x10g'
+		1x 100GE + 4x 10G
+
+	Only one of them applies; '100g4x25g' wins if several are given.
-- 
2.43.0

