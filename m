Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3991C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 21:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEC0740712;
	Wed, 16 Sep 2026 21:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVB3cf1NBoug; Wed, 16 Sep 2026 21:17:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0473440722
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789593475;
	b=Qbk6gvKTaOUgCOT0PkuiBkLQMOIq1BD2zDTwDkg1cC4+jBl2HUK4G3Zlf1EJCAcj8M1h
	 Kgyh6rA2TaeEBQcLfMGMSCBrPjHzMuEoWop28OGgRNCCvFp52Um8EFD2r7bRqU+H4BhWC
	 KgjqJkcvvCvmmO1ELp8LM4m783nz+KRUV6pXJJVDseCGSMdnMF4B21QN++V8FsplWhsBp
	 dmA1i5rKyfM1hUP5aMni/ESnYDa5bm29mKLjO4PmJuOBvjW0H7LrHdelbtU0SoFl3rJHO
	 Cj3W/UN4sbZyFSGvLPNj+ckcWWrcHq4O/s7gguFI+5PqUlAIljncKjVt1suNb5p2jEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789593475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nknx5jloIQLjrY0sbyf/GEJWNKApRV88SxU49ltlMVc=;
	b=Uy61Yyb8GqxM5gOQ2C0Z2kuJJSQhuoT1gywE/ie4fnlqu3qDdnmSkGgEDMDICMcVOvFi
	 XvalsB5QhgyIRX4vay1lfu8kPSgUiSmVgI1HSgP7RTqB8CZJiKXICpAcSRDvg+bwN8JYw
	 srpUfDL8ZrA3FDHKfMAprwHd3IgoEkjILqb0h45vknMIHy1EGgAV5uK1JAZa24ESBmTfu
	 1HBdRd6iwBxUm/znKd8mdAfP27QulTUpEP+BvixDf8kD/nJXo//pIfWxSyUJoTIjqA+3q
	 dRMw0UVxA0zIaDai85450TqQYcToPKRZhj5XyvecucpC6uiLzmMvWp1fKr2GwJguivg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789593475;
	bh=nknx5jloIQLjrY0sbyf/GEJWNKApRV88SxU49ltlMVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fmUYasXUH0Bwhm8K3aDc4BVhZqvHa5/MWIEx5g7wnLKTuPAJqUR7HPcpbFayE96mn
	 Z4v+IeAuwqxMD2m3C5/4ZM8pqRIeCb+mAZu0dKz0ZeDkAo68/issYEFTnufOHfKB6O
	 o2EIPVFo2pf0MqRgO+boxUJPyMmr4rZK6ZQFXyMud0Zwh0a61IDE/LkM3aBsqjShFz
	 zOZdT7lzQTfLO8qv4O7r6HV9p2ziG06RQln2AjJljKJKdxfUeBjW5ykmAIXWBjTqMS
	 sq9N9RDNbjes9mzHAxR+2Y+BZyeCxzXTUR//9kvI4N/EMrDHzJLBupfBDN2IzqICLL
	 anjyl23whhalA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0473440722;
	Wed, 16 Sep 2026 21:17:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C5BF13D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E73E400B0
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkpQaK75MJ8g for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 21:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D073E40081
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789593473;
 b=JqQR/ligqHclNXDSOoIzbvz02bjGQENwxqQmSDMKZRK4sFYTJ++3Yay7QWWhJ8PMdDXS
 qPPDY323yjKpPzSbL2nwsCKNavgeQy6pfmrlQ/JODsQxS7Idvw9HwEdt+mZtpOHZx9qG7
 7PqFnz7rO/QO9vnJfMVWLBZWg//nGS5DYCR5MO7qO7021dVVqMy62U5WBsa5dOC8rf8cS
 rFI9tNpvAFCEdUKCV91NNH/gAlLul2QzUdfzFXrmXYsj2sDw4HRwdgUCwcFRs32pl56Eo
 4HrjTPNPMpE2q4Hvh4+AfY+xWOD0OGZ5pFx0oelQyG016nm1xc/98l446CHMKS+X+XA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789593473;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=nknx5jloIQLjrY0sbyf/GEJWNKApRV88SxU49ltlMVc=;
 b=fQmWQANNXyWOiu+3gDqD1QpmmwSevQGK7rtlkqR80tMan3w6fECyxS3AJiNmWIaIlwC2
 +PHe6xoQy9mV4IVu3jXKzhrcGuhdapZuHKzvNjM74Wu8IW4cJtLN5wRWvD+LRynvN1CTg
 0gte+rv0IzwmKiTUUza2OSwjpz5Ur+j0GCCSa0/RWqruChzCQHQq4RXEIHfom6+WQGizE
 hL745qCWGKj9NlgKlUUJTqNRGV9SiBqasRs3bpY3lhNLJZFIKyXWVjT5Hz9fsWgz39rfG
 ZH1v+7N8alp6Imr7J89eJuQfLxF/kqvsdhQXL8pcrS36bQeZWOI1Wu7Ds6XBqkSyqxg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=iKuPxXMF; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=iKuPxXMF
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D073E40081
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id E6F33B0053E;
 Wed, 16 Sep 2026 23:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1789593471;
 bh=upu6xPmZ2bz1fu+00Iz4DQ7djaz92npYw7ZUXMdvYTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iKuPxXMFFgWnNIL6QAVfeerLD3fRzivkiwKxBBLY4DnPUw6dQovYwmoLDA4zuMKp7
 H4kmgrUpvSLRT0i7wBN9DLb3Ju1PSTBJFI/WUv2yJ/8ZM1sTuHN8YjEHyOBgiRO0z8
 R6ajbCH+1Ue+Ac2hLaKLKvHw38702MF/aQpSEIWWrO+ZzmJ4XW7uMDiGAXq8fbYDE8
 n12yjPkmIvVWqOD8GpDW/kjqiQnhH3F80BY8swWGn4eaQvD+NHXIc0coy9DJioGF/I
 go9A7oQ9QMvguErbJocJ8H/7b0c/eNO9M3WyO8fkOgJw53GKt4N++wZBxEICFez1++
 XO0HYDTLxEZyA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v3 5/5] doc: lx2160a: SerDes 1 runtime lane grouping
Date: Wed, 16 Sep 2026 23:15:49 +0200
Message-ID: <20260916211549.3432913-6-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916211549.3432913-1-vjardin@free.fr>
References: <20260916211549.3432913-1-vjardin@free.fr>
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

