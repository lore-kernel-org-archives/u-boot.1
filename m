Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F58C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E8FA40817;
	Mon, 17 Aug 2026 15:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDwuR03WxJNX; Mon, 17 Aug 2026 15:37:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 414E64064E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981077;
	bh=Y0IS85E7o5ixf1RFLJcaFg48bApfY1XXyqq3y5DqpLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rgx8QTGmBD/iu3KxvyrWf6hM3rVg00nyqovGmFcIEcIfReJFM1FtQVkTf6obMOwkW
	 TcfuGCu2gW9dkhPUjwjgnO1Y/vOWq4XXezXqUavV/BZb/U7R4lKkrwcOM/1331r4M1
	 KgZKEeLWGC6Q8ZQMUvUWLqqiYtH+iNE4MI4onjzeBpVw7iI3k6R0Z8T/Mq2Xwm+112
	 16k7jrsshCbuzo265yhuS6XXX5WTAZOsOij3Nf1FiEXgnXY1faNkZUe3cH2yP3sr5C
	 0ylsaaJDmJoYqS9G6PpZymzcgM9LmDBs9gSMB5ChrbuqhImsA1P9hPuwW8/iszcEp5
	 Bv3QJfZX3wmjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 414E64064E;
	Mon, 17 Aug 2026 15:37:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8E6D2B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAD5180ECB
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_y0xwv71J9d for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:37:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D6D7C80F6B
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6D7C80F6B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=jB/A3hmh
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6D7C80F6B
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 34F80B00579;
 Mon, 17 Aug 2026 17:37:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981073;
 bh=XgPD3rRaKsxM4vicz55lT8NxbSIJLxktuBYbTLEEX50=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jB/A3hmh/y0oXD0EtuCn6jlzvWLIwsY6IaCYMIfkaU0TDFbNIMXdQybnWNTTQGU58
 j5Kz28ppoHqILWjbaOiKoP+fsVmMkuFRAEzWm082dLqF3LeY9a1LaoxurNG5T+cziQ
 kp+UGEXzh2kxLSYnq1o12H6oYq9mGRc2tx+1+N/sEsnLX1kVt6GxWQQ7tRzV/wOqv0
 2Zf86STy3mHF6Kpd1r8ZF8PoX8PyXW5lPlkiR2uTSmicJP6DoihhS3WYcMjaTOTpAO
 hrOROInVTbauOxvADdtnIjRJ7nqXX1b384+GfdDxEF2So6qEsytlasAvNbx7dhz+EU
 Iid09z0kgwAew==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 20/23] arm: dts: nbxv3: bump SBSA watchdog timeout to 120s
Date: Mon, 17 Aug 2026 17:31:38 +0200
Message-ID: <20260817153144.1951036-21-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The shared fsl-lx2160a.dtsi sets timeout-sec = 30 on the SBSA
generic watchdog. 30s can be too short on various slow boot paths.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index ad10326ad48..d2e4cb53bf1 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -364,3 +364,7 @@
 		regulator-always-on;
 	};
 };
+
+&wdt0 {
+	timeout-sec = <120>;
+};
-- 
2.43.0

