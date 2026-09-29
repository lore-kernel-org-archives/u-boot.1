Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB31CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 19:36:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46E20605AD;
	Tue, 29 Sep 2026 19:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBY1BOvajnbZ; Tue, 29 Sep 2026 19:36:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8B081607D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790710598;
	b=QvZPjVMyGbgI7xfXAYStmYjo0i9m0sijc/h4ONtazM9A4hmBLTY57nddbLC2KlV0C1P2
	 AmpAVNPKbPaWT3RR03SmMX0q9urJzCMiXwxEp1lCswNfTj/XmxicQyVyp3ux8rRTyw8Go
	 LZ8dvesH6t0B/iRtZj3ItuxlXXJd4uHBO9jyiWvcrWQl72OqKpbnIeVkv56qIo3pWUJ+p
	 C3HObt9HnFJ+DVoQPNZsGVuUJw1ted9TfzgQ5W1qBiPWiZaRhjPnQfOPF/bMV1s5Um5xQ
	 IpB9AJPVqkib56jClTLs4TwIMfBaV0gZmE4ZHC7yf8qUSqut5UKIialEDyN/A3kACLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790710598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
	b=BQcI5rjFfX8qvcf27wVzaBLs3p5iAOK60PScoQmg4No0XEnjh6bZ4pbGcxssNLTyXlDE
	 JiqMWQaRH0cEsRRveW9BJy+fpbOej52ZIqW2WSJW5zJQLFXMH0xVqVLNFRioqDe+Lz7P2
	 c2/OdYR5JdMUZqrVSCHGQ3O0siwi+Oenu6I+KjrTKSIAMXHDZ/YHzeOxaujZp004C+uLv
	 JJBNIegIfT3oe2ZnkqLUG99dX6xpqxcstkIHK9x7b3Z7UUOBhupkhIU+0M+banHaq/SUP
	 Dpy8iTdQkUTBgrSy5h54q8E6k2hqM6+/3wqC7XHIIFH72rgaYxMOHqOgk2R0s4E/KcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790710598;
	bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zM/1Am8oK4oHILVc7mvcKtwaoa5F3Wn5jrF7kg3HXz/Y56R//BfqGATVXVPNYTHDk
	 UH+SBzL/qTyQgx5oLaAnJp52NNKzkIkrRUXTa7TAp2UHy9PIWsmd1lhcWzrupT7tWf
	 d7gT3UE7wP3FUcZXcxNhDVwWH7UFU72DmgzqG8kTJU2C7EB+Fcv+p3wX4v9M8yvmjf
	 I9TGwGu0ky4r21t0hwoClulGBMoT92mWv0K4G2XSq6wgNFha4z1mivvxFGW7F2QzLA
	 hbIm9+Qv+u7lsXsH2QktQz+KhcFY1EUoTj+9vWnPVXDbbL81bUR1nEP90xgb1BBmRO
	 nx71ybjTcU3AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B081607D5;
	Tue, 29 Sep 2026 19:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EFF032A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C3E84032B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rtDDZ-HIJH4d for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 19:36:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9F91A400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790710596;
 b=boaYyYjzHhE6tnaEQUPiFNGE0emVexSnDIKJGpd9F64iAAF25rJhksq6+AQq6dVfVJMA
 5T7wkCxqRjMj3M/XC0aruHr7gsGXMyu0OuEZFwtmhXpqdG+tXSReWaCy0uHEXKq0GqHNN
 Afi0cElgLMlGcXWIH7btaD9cdkWQ9A55HdsBlNXkJeB+Z3zh/XzI/YNBVFWoIkqYIduEw
 CQIP9eVp1vqwulTQ1hMoMgEbQN1MAJAquU5WSrX9GYQs6GKqgDXLS2lclvThr8E0v/Tb7
 uvK0xRyz6E2Nm73dcI8ujPKSxWtZSPaz0ZQjf2XjSbvT9t2njqmi+fzu6Tetz5bJcfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790710596;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=vTXs1yrbIFXU+Q66pNHwGa/TbSfzHUtmNxy5fJi552A=;
 b=I6Ujy8ywUpbe4z1VVeFWW5ChEuMIlpjzONtfdUeVeK35tZv+y8WpK5NC1X8i2LJgFKd9
 X+IoS3hrthSk3MREBSpOd5bn/wdjfum7c7Lh0NfdZdGfDlh80DUX7hPjWBt2Dh2zdbrl4
 PvUohw5KF8EwYZxGzt6ie/IhwUwvbwnco1k6c91Q7X7i7M9wDDTenPVlEyS9g3/pzd/DJ
 uaRG+9joiavSGq8MMchwhvRPuGA56OXSlvnEdtEJjkVLg1hUMoHNJ7x9BgwUKs/PWT35V
 Xt53gwO1X+v6WIbUksxkj4M8WH0yX1ZgAQEAYzHS5myJZoAj5TNxuFmRTK1C71RXz+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Lyir9uYw; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Lyir9uYw
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F91A400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 19:36:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 17649B0054C;
 Tue, 29 Sep 2026 21:36:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790710595;
 bh=Opxz+RFZAppJK6lJ37UQV0A1K/QZGcL/ZB3CSwhC0Ak=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lyir9uYwOP6Um8BJwH4vq5+rv5QpMBn9x85y6m1ff6IUjDv6UtsJ53Gqi4KOzY/Fk
 QaIVq7WGZxImJ4W+OUlx2CMGt56MpFBp8c7ULsEGUWvjjcBEy3tCXy5XMeVLtvgQt9
 n+wfWqYxegvr53iOZ1yq85U/+iVYgWICR0JM617wfE3iIXEPcazy4zyIXejfq8Jmi5
 YRUxmQ7HlBT4puhFD8BDbV0Gq1wDyHA3otbNP9/+DOJZQAHSO1itYXZm2OjHYHguA0
 /OrcdVkl1RyDIz4TmF6R+fRZZJphxtaBtOsWzUKe2E7eYD54WFdg2UQloIZkDjSOCX
 HOSqdk+nJ86LA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 07/13] board: lx2160a: serdes: no SD1 config once MC runs
Date: Tue, 29 Sep 2026 19:59:39 +0200
Message-ID: <20260929175947.1379710-8-vjardin@free.fr>
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

The MC reads the SD1 lane grouping once, when it boots.
lx2160a_serdes_apply_hwconfig() has to run before.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

---

(no changes since v4)

Changes in v4:
- New patch

 board/nxp/lx2160a/serdes_split.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 57504a2327c..ba3be4bc0d7 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -12,6 +12,7 @@
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch3.h>
 #include <asm/arch/soc.h>		/* gur_in32() picks the GUR endianness */
+#include <fsl-mc/fsl_mc.h>
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -524,6 +525,12 @@ void lx2160a_serdes_apply_hwconfig(void)
 	if (mode->is_active(srds_base(FSL_SRDS_1)))
 		return;
 
+	if (IS_ENABLED(CONFIG_FSL_MC_ENET) && get_mc_boot_status() != -1) {
+		printf("lx2160a serdes: the MC is already running, serdes1:%s not applied\n",
+		       mode->name);
+		return;
+	}
+
 	sd1_enter(mode);
 }
 
-- 
2.43.0

