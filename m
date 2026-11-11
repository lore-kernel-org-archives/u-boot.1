Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B62D606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cP6IS4Ks;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Sxcmx88p
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E662440A6D;
	Wed, 11 Nov 2026 10:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXIm9x2yaKgT; Wed, 11 Nov 2026 10:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E56FA40A69
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392016;
	b=eIgZStUnD2/oFtVKXowpLn2A6U4GCW061a5ZbA0L5yv7EkneqElfZEEN2zLtzcPTvMpQ
	 EZSsgyulqreQ+0W6MECSb5WEJSxxh3akzT5dX+ierxuPOnUqIodmH4urwwUO3Gjl1A4iq
	 sEyl/NJZrxNWSUJDx5UNqZlD60EKHVBmiuXwAE+YyEk09TOSHOQ386qEVNy0xGJFV9EyZ
	 3eOfAWIyvaEgNg3hmCoUdGiXhrqRaxQ9jGyLGh5t29NVmWU7ICcq/IUfANLqAa9FW8YaD
	 BACQ0tTEbhxCf5oJjw0sY2Rx35fpce8FpMConmbY2GSfJO5GBnH9mhrvsEyqPyKGf+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EEkIcVkX100SqXB3e+s5Q5b2OCPzpZwhnjVqurU37P8=;
	b=PltfBN69Iitr0FhFxT+k8ZfuF8MBvOGUXGtoICCwc7DEFeiy3+t6Qg1FmBwNu4A7QPPW
	 2sZjplE0V6pYKc2f9u8EikunG+2kZluYmr4rPv9xp7+nxHEO0etP5RYk1RBdVCznFNfDi
	 OBADSh3x7g36peM9hEQRMJbWBUn+xEs1Mg03SPGzCiA8gFXPjiGxm458Ha8Jed9kL2IIb
	 LupX7GKE0txGKnn9PalnNNK02r+3NWMJwUmPnPGCo1Z4Oh9N4m0+lT4pQGpDUDEamjfdT
	 HY5+3sXclgiEJXg696ffHGVRoSQwkZgycf1YQsLnRqfSuRRVDIhK4swAxijvAyBT7gQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392016;
	bh=EEkIcVkX100SqXB3e+s5Q5b2OCPzpZwhnjVqurU37P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cP6IS4Ks0FodZxHlggWfgXHAoR4fEMQ9FweeY0ALkufeX5P9rQY4gyH0JjPxxuigG
	 2h57zOZvDiQoOHkdTMzK/jOg8qC1LyxruxUqIjeV+cIYjud4srH05NtodLlktRxflX
	 4veyut5wXGCHR0iMl4rAmT/YBWW2ikNJowXdWUrcMgWtK794pxXEjUyhKrdPt9fB/5
	 LRDfuCMtw72b5b9NpDScIHc0ucZYJN56edltZCpzpm04Fv/s6XXf5hNOSpwtg9FVYJ
	 6V4FD4wAveXN/YS6tmj6MVGnY2n33UcfGYYW7hvAkF/Vt4czVKY7rQGy7uO4kzjUe8
	 CWbUo4H2NGVxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E56FA40A69;
	Wed, 11 Nov 2026 10:13:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5047217CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36D108121D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3NbV5EeMyME for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 49BFB811DA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Sxcmx88p
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49BFB811DA
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EEkIcVkX100SqXB3e+s5Q5b2OCPzpZwhnjVqurU37P8=; b=Sxcmx88p5DEQcF8fX+yH9DVKO9
 IMq+ks/MOp35/fHmg7PcWZnG3mL1Ei4k9eVnSi3cI2ubYYrMdp5yPTmAPDu9XtonFx43s72lmFCn7
 Rjc4h3nV+d+fDgNicMwG3dKpU3bGcpFUC/yg0RkEPFgezvMAUfRgCQT4fRQxAa8m3IXg59t4KzkCi
 dsQMQqwccpyjSBqB1oKSNyhVxQ5XDSJqdQy2N8xBj77RF7F6iK8CJ2bW+qmJ3gOHLfxTctFMR0KNa
 beltI5LX2PB9se2s1UrbmG6qRVH29cIab2wPBLUeAtHt/2KOoxec+sWzCl60/S7BP30dNIHpBIAgY
 Mgw9AyhA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KX-0004xi-0T; Wed, 11 Nov 2026 11:13:25 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KX-000Lq2-19; Wed, 11 Nov 2026 11:13:24 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 5/7] power: domain: imx-gpcv2: set CPU domain mapping on
 probe
Date: Wed, 11 Nov 2026 11:12:56 +0100
Message-ID: <5025cf1f81c5e005ce91867b2d106b283379d356.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CPU domain mapping registers and bits were already defined, but they
were not written to the hardware. This is necessary on the i.MX7D.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/imx-gpcv2-power-domain.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/domain/imx-gpcv2-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
index f61982df60f..b94ec60fc0d 100644
--- a/drivers/power/domain/imx-gpcv2-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
@@ -522,6 +522,9 @@ static int imx_gpcv2_power_domain_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (pdata->domain->bits.map)
+		setbits_le32(pdata->base + pdata->regs->map, pdata->domain->bits.map);
+
 	return 0;
 }
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

