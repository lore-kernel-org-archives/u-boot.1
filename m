Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4987A606A325
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IgoDMaup;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=TEZOjWjl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27E3560750;
	Fri, 20 Nov 2026 07:56:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMriEp6nleHi; Fri, 20 Nov 2026 07:56:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 72AAE607BE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795161361;
	b=TZ3QhF6IOFue6GdWEvKv2jXRU+C5h5q2Hg+q9FJv+MtqXtF0DgoCZ/ZDKdN00dSWrQFp
	 EIu0qgVwgjI8Nk/+fe24GG0ygRsdf5YWdYHf0u5tNYuW30v3i8qC/6pEDmfIWEm9ml6e8
	 Ag+OI+wv9n33rQgw1Af7evqmFpWz9g9s2NwuE6DRdRqK9YZfKDz5FbKUWZh0AHmUNxMXz
	 +vEpungypV3Zw7Tn4soEuZQBCZD2/CKSkhhePIxJLBd3AjMmuBgSAf1d8e9GFoQ52Ik/X
	 RC1/jhSotqATmcUyWbz2UTr6r8MNFpSMAJSSWcojFojRo/fw9c/eYZprdrOqdwpuF2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795161361;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tpiZGq9yAge802UxKg8bj/rwrhjiC7ipPgrHGvy3pqw=;
	b=k3lImuvGgOQoug2pZwUiYnuAAKv9z8Cu1v37DLM97kbgv0oSXWXTyUVg+DbH01QoAKtX
	 t1jBmjHp9uS2AYcs7qwuM4mRrhG3QQV7rGDbgg6ygMv4TkbolUOGl2vU5vqxWhJ/dvkyP
	 Iu3R3OJDFsRBBM2bxMaaVQDw6gwa1GkeBNILxqqJ5HlbTQhucPsrvs7VMH+IxCfm0IcQE
	 ZNdQsL5tGi9mY4pJWW5sEmRlRQjdmUvmjLw/rFSxotYtb8d4SGnjRrspLBNGfeA4UNBFO
	 xlTB86hoYgiLEaTcPJ24Cl3sUzqSRRxoRKNQnxp6VoG83vUZtPkM1wRvpONElOQm0Xg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795161361;
	bh=tpiZGq9yAge802UxKg8bj/rwrhjiC7ipPgrHGvy3pqw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IgoDMaup9u6mS2UG4/eNJdeXHulGKSXtbGdEvskS152L50pgLsn3ZgEsLsGpCYtQ5
	 9806aUXLAKTsZeFsXLNaru+Zdxi+jzMZ/sFv3dnJEx9oAVaw5j9A9lS+uxV3gQmQO1
	 1PTDp0KYNGVtmqWlUUT3zZRKZ2Tnjr219WiotLgRP7+j496iSTiiouHgPXnvRFN1zb
	 wziLPbN/zniZy0hiMIjMNdrHZ4gfF7fW1qNHNo8M7wlITV97JmJGUkocjeQUl+YKuS
	 UvmqOpWHIoc5Re57xn8KQApZpUmLniK+QvmgHb1lHSuc6pwxXNj6RPkQOMxGzy9zFR
	 /leXSFt0N5gXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72AAE607BE;
	Fri, 20 Nov 2026 07:56:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C22FE52
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DC3140D68
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXOb0Fs45oDl for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 07:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1ED4740D61
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=TEZOjWjl
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1ED4740D61
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=tpiZGq9yAge802UxKg8bj/rwrhjiC7ipPgrHGvy3pqw=; b=TEZOjWjleQshWspB2J9VXQAAjE
 A97w2TMgRppr4VLBTchxFUXTw2Uyv06Pj43TYXsJ6SHSpf1SqZzbYn2BgAM7K3pKIvkh1u144+zHX
 /2IdlSLvMMSEdDajHXqIQ3j0HUUuhdd0qC8pT99rFMtEMPsNY/p8kXLYHw0pqDgTGdU5HL6jmdlTe
 wAtWqir4+YVZkF3ExzGZYRdlYROF6BLj806OcnzF4eZpgTg7KisiHLwnEPioirjfDPJRL6s7i+y0M
 tPO0Ex1gFZrNLVzFHyBk+dT1WIDz8Y5BsJb3NeSVy1RZlifsMABqIDOFRLYwxzo4nzDKV0GzLbdOV
 Y094GOcg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJ3M-000AvQ-1s; Fri, 20 Nov 2026 08:29:00 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xUJ3L-0005Bu-1e; Fri, 20 Nov 2026 08:29:00 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Martin Schmiedel <Martin.Schmiedel@tq-group.com>,
 u-boot@lists.u-boot-project.org, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH] imx9: clock: support external RMII REF_CLK source for EQOS
Date: Fri, 20 Nov 2026 08:28:40 +0100
Message-ID: <20261120072844.1502841-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28188/Thu Nov 19 07:24:39 2026)
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

From: Martin Schmiedel <Martin.Schmiedel@tq-group.com>

The CPU supports RMII REF_CLK as output from the CPU
and as input to the MAC in the CPU. While the first case
is supported the second is not.

Check the presence of 'snps,rmii_refclk_ext' property
in the MAC device node in imx93_eqos_interface_init
and configure the direction bit in WAKEUPMIX BLKCTRL
accordingly.

No changes for exisiting boards intended.

Signed-off-by: Martin Schmiedel <Martin.Schmiedel@tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  1 +
 arch/arm/mach-imx/imx9/clock.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 55f4f34e1bc..0358b0a9b2a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -90,6 +90,7 @@
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_RMII         (0x4 << 1)
 #define BCTRL_GPR_ENET_QOS_INTF_SEL_RGMII        (0x1 << 1)
 #define BCTRL_GPR_ENET_QOS_CLK_GEN_EN            (0x1 << 0)
+#define BCTRL_GPR_ENET_QOS_CLK_SEL_EXT           (0x1 << 0)
 
 #define TRDC_AON_BASE		(0x44270000UL)
 #define TRDC_WAKEUP_BASE	(0x42460000UL)
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index b05194502cd..c65a35c58fe 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -12,6 +12,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <div64.h>
+#include <dm/read.h>
 #include <errno.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -913,6 +914,17 @@ static int imx93_eqos_interface_init(struct udevice *dev, phy_interface_t interf
 			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
+		/*
+		 * On boards where the PHY is REF_CLK master (its own crystal,
+		 * feeding REF_CLK into the SOC), the MAC's REF_CLK source mux
+		 * (the register right after eqos_gpr) must be switched to the
+		 * external pin - matches Linux's imx93_set_intf_mode()
+		 * (drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c). CLK_GEN_EN
+		 * is set unconditionally either way, same as Linux does.
+		 */
+		if (dev_read_bool(dev, "snps,rmii_refclk_ext"))
+			clrbits_le32(&bctrl->enet_clk_sel,
+				     BCTRL_GPR_ENET_QOS_CLK_SEL_EXT);
 		setbits_le32(&bctrl->eqos_gpr,
 			     BCTRL_GPR_ENET_QOS_INTF_SEL_RMII |
 			     BCTRL_GPR_ENET_QOS_CLK_GEN_EN);

base-commit: e6fa1282975af50acf44be7aa678b89e187f0860
-- 
2.53.0

