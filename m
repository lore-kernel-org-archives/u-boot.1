Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B488606C966
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xn/gX5cu;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GT5VWo6Y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2D7960EAF;
	Fri, 20 Nov 2026 18:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h9pR88LLtPmY; Fri, 20 Nov 2026 18:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0425360EAB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198418;
	b=DUWuY+ygWG3AOLxcXpy5RGtthoFCiFIRpTx5kUgp6oG3gVqrLhucU4XoAgYUDIIFIRw2
	 4A3xbMTNOOnvfNu+yG9tMaMdL+UUvdHkKlDHAvR+rrjFKJVMtAZVno72x/o/rhKq0CMwh
	 vaXuqnjip8pZHg4xwrCSLFqZZi2O/56mfYh7eQGEjLEymd3fYXbNXCxMC7GQVO7MvezBo
	 KltgWbrwtzh8snUjqkSP1b9TGQdIulUzL1+pYoVB83khcZ7wUMyHLqUG8q22PcPh5qHul
	 QynCNCLuLRsUcTnNDv9e/8/dYtwLK+FMIyDEgH4EThlAbZD1UznozUnbqN70mvuou7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6yQHdWpgYpKZsTQBZVi6iMi4STUSEAceSFMA/zQaYes=;
	b=RnAj97Xhtxm8IUf4Gklf6VYx6t83XmxPkwF201nHIx7NDZohHUeAu+SAURi8CFriOes7
	 mFFYvLPun5imAqCrpe74iw+0Zb3H4+zTe1l6rIinRHaC+Ee3pBSu9FqU0pT2Tq5ttrWJm
	 gOksbRDFXzzF5sFt2J3bE7E3rAwu43+P4ZAHStQ9L08gtPjEY0/MGTUvPgX7JJxhjWxEP
	 QbzhsABB/NfQS5lgaTh0vMxd7SK8vdb6OOM4iFOwstzrbRzHqe7e2j4tvrpyA1Opl3vkY
	 w6L7BXI3zzoMORg74HOEo8LjmfO8U3DJKSTfHQ8sHvCnjGi7Jr08FiDv7Rlw7XG0ASQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198418;
	bh=6yQHdWpgYpKZsTQBZVi6iMi4STUSEAceSFMA/zQaYes=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xn/gX5cuy7dx2BrlTZiEa4d7l3omDIi0jNbAlDpWbH4YmEaFWLQ2smFG8g4MLYs8e
	 TFx0IJ7Bs9h0PncRZYsrb+3Z41sudLkipp0vDMtODfkNrlxaajm0VZg3jpiQfRR1Sn
	 Wk4zyw9NmdBkTuh9zYkgVQwXpjFvZOQ/JyUYlA+fUafguRU9sqrGTRmAUvwALb497Z
	 q5pOZo/ozrO18urpUNI0Ixi6bsZwIkj2t1L3DMH+ERuC529o0xcbm/EWsKt5UH5ryX
	 bezzkSEjL1xaN/cmlNygdq/mUF6Tv7mZBobL+YdNc6UleDl+47F6a6yMztGsAvOEF3
	 1yDKFMOZuVkiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0425360EAB;
	Fri, 20 Nov 2026 18:13:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0872915D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE9E64022E
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IMNMkhvCVl8x for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2AADF400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=GT5VWo6Y
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AADF400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198411; x=1826734411;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Us+wsE6VtSwoO0gkWVOTQIxLyDmTBL82Gp7yAQgh1VM=;
 b=GT5VWo6Ymcz5xmPW+ddDCL0fdrBX5vcvh8zyBfibkpVs2cBpEmUT4tAU
 BrHPMrs+4rlPnXJnDEOPYFhw0anq6yyiqD8G6NbgAHblPXFmqVbgQEUnF
 3mmV1mX+tW7W4QjMeieMHVxFSggP1M07HdMyx/yeQSOdlCL+JFTq53xjq
 k3UJXSKIODNt+uzcvASCjAH56eYXzFEXCZL0DdL3w995+dQEeyAMm0heJ
 gyLpe5eHWNUCIVzYPdm0eAjJt+aeaxF/pmMnMABVwZqNYzbVlY8KxJ9YP
 s4gHmm1pGEyfGmqOcudrHVDr2OW+qLzyMFilgvAyvT9QXQMbBG75YLC+I w==;
X-CSE-ConnectionGUID: npydLCNtSlO5DQ0/lWRQpg==
X-CSE-MsgGUID: 4/VoIT1eTRWGFhiOg7/SjQ==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="65862329"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 11:13:30 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 11:13:30 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:26 -0700
From: Charles Perry <charles.perry@microchip.com>
Date: Fri, 20 Nov 2026 13:13:01 -0500
Subject: [PATCH 2/6] net: macb: check the return status of phy_config()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-2-d344297d5b44@microchip.com>
References: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
In-Reply-To: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
To: <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Nathan Whitehorn <nwhitehorn@pa.msu.edu>, Conor Dooley
 <conor@kernel.org>, Romain Caritey <romain.caritey@microchip.com>, "Mame
 Maria Mbaye" <MameMaria.Mbaye@microchip.com>, Charles Perry
 <charles.perry@microchip.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

phy_config() can fail for various good reasons. Check the return code.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/macb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index fabfe72210fb..f3850022e721 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -724,7 +724,11 @@ static int macb_phy_init(struct udevice *dev, const char *name)
 			return -ENODEV;
 		}
 
-		phy_config(macb->phydev);
+		ret = phy_config(macb->phydev);
+		if (ret) {
+			printf("%s: phy_config() failed: %d\n", name, ret);
+			return ret;
+		}
 
 		status = macb_mdio_read(macb, macb->phy_addr, MII_BMSR);
 		if (!(status & BMSR_LSTATUS)) {

-- 
2.53.0

