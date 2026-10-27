Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B23606A31F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XEZ/yDZ4;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=D6bafY6x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1569E6075D;
	Tue, 27 Oct 2026 10:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phfAVlsO5ELd; Tue, 27 Oct 2026 10:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 618A360748
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793095556;
	b=DhiNlQ+pIi+uMuRipZ6Nr3cmGEUEOleNk+cZGxyPIKOCEyLlBRKRnE5SBUi+4HM3EMaV
	 Tic8PI7ZYQ7NY2kYHxATAkDC7EmCXlIXTHwiWBHtFoeg8xVBgq7RsJIIiuoRfk+tKVRb5
	 CkC5sTgT7e79XrxYHWyFel7sq+TlH2a8YpI/4tBpL2iG5hjcSHkQFVfiVOPuefoI2UZ1h
	 1O59MUlzO9vwWH+ca+u8QOFcnjeOOF09BYsPmQgFeZ/SKCzH3igqyW5L7FrDfM+iAQ2+Q
	 RSbmUDzK+/HgtfVs8jdiIx/tUmGDGuTr9Rx08ffWU6DD+aJc+LkK2xjAXhHk/YF3M6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793095556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=USQpRa9U8sBoxlpzviFYR5d/RKuSHxCYPdYfBiqiGKM=;
	b=hNKWf6/GwMTo0M+T/JRJGAeMA2lOFz7R3Ij96DTozNLM+YqNhi1qWKbZAzcuX+oe3LYk
	 uw+pAOW4QMBTS82yE57QIRiARWVWTv+abWuKuxy2XA6eifcPL62/7+GtVY5oKpvAaJ1EU
	 NlwbY1Lkoq3aXx9+KOTfRbYiLzvTgg+Lwa4bmtfk5w96ku7Rbj18mjwEWq4+rlI8tE1ej
	 lkjhgBTly8bn94yEytVFEA7BnON+pVwi5vGH+chG2KPuWzsxj7HMItrkQuC0CPZKS5T8T
	 QJxReIzsXpXX5fJfUbzf8aOCidxR8abig3X05vaNIQAjERVxNjb4CRlRyLTmTlLk6RA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793095556;
	bh=USQpRa9U8sBoxlpzviFYR5d/RKuSHxCYPdYfBiqiGKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XEZ/yDZ4e8O4Dj9O0KhhNE6cIjszwDHCKpgEKGHUHsrZHbTK6Z3f2goQvPw8L7aMT
	 CNR5ZhO64Ih9dwRvxAzBULKgQsyfAwpJO5woIgBmsmY2/ClnxbPQDAfUjpeR0GTFKH
	 eMShnmoU8bUkWnmAns0dqjc5QCDdQDoBkuKMDCahDgR6B7Y7DM+EmjwtfYUjQ1nH70
	 wfXclD/SLairTBKvO6r/i1CiwJ4CvVV4bHfCbkZUEMpW1YeONCnzO5+c3r7LzlKpt+
	 JqzkIqGOE8kxv+BA56FR92G3EPkEQIj6rNeKEL7tKI3wUrjCqr8PtPG0y0grK/gnak
	 c5H/J3VYl9Rwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 618A360748;
	Tue, 27 Oct 2026 10:05:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D2B4235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0ACAA4063A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtMf1GfeOWr0 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 10:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A20740636
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793095552;
 b=WVEq3qfy+0A+y2GdXF9LWHc5TUC3hIjnd6daiMBJ28XbGq/s0yEa5diDeHZY8YSKy8nr
 EivKrPtMAzuetDryXFzzEKSWFym3nNn7PHU6CVrr2QtbKKGOtJWwbBHSJHZpui6X5r/ci
 Rnr4G1PCYh6HV6Rd/kgT1G5UQSK7U1LKbJnc9uoF/9qg4PmtHccyeLuvGn6iq63LooSiC
 WRUpKOuvStMM8rYxAHEMVZNxwA2VI5v5hwd2Sks2ixXk4+SMZafnUVMlxssqAP48Z6PuN
 95y+HTwW9VqvVL7BBRK/3j2gndTs5Yq4+TWXw4Z+WTjqF6/RtLenkCk6Vm5HPl4ix7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793095552;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=USQpRa9U8sBoxlpzviFYR5d/RKuSHxCYPdYfBiqiGKM=;
 b=MrOJZv5m1RI/q187IB5LuPyXTAIOJWpKMCYOXdllqZKEbeLBkrHDYwAR3i0+EaWei7aS
 x/vQPHxnlkjkuq2JArFpKJmMdbSDdYZ1bGZCe4izxdpc21PAhN5r9nIwW9It0qqFd7ys6
 xwJg+vtbhtKUlM05kbgNlmuxb6esGVgcQx568yNx81ASgsE9TfAt43HutgpD19jnaHZ1n
 dhgReJ1ba1T41hAhHDurrfo1kS7SqSxYCTjy6Kk/HbIjpN6yXyFP7fzgkdcwrO3trtLfO
 2hlyaGm7Q70YBpAzsiYqX1/MOJIPgMlTJJozcMz9oXiaxSJ3bl/zlNJaLjL8iD5Ha7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=D6bafY6x; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=D6bafY6x
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A20740636
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=USQpRa9U8sBoxlpzviFYR5d/RKuSHxCYPdYfBiqiGKM=; b=D6bafY6xyTyqnZ3wUQHdidYelO
 ejEb7WldvjZB5nmUpF7UP7g/GAzhDSO1Nfv0wk7Be39sit/gMMg6acswWBu7FfkWzrxVpyD+I8zFL
 ZFPBuHpju/IyDIZTpHBhEl3qs/HvjTD2bB7wPam9srp7Y27yMsamGy4d4LUAZEycgApFv8KeA8kTA
 cC96gLRGAw8ZPA+tHQUauMpI/4qVMHbCKwEorcd2GuLUsoxVyoMc//XdjseWccVI2oEMDRSql/iAz
 IvlbWHw2iSKBcLbzJb47ZbG2ibKP4SuZOqKSnijyaEXhDIHmf63IzOQ2yJ6+ZInXooJGWbLnyT12r
 GGJgw7PA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLe3v-000C0I-25; Tue, 27 Oct 2026 11:05:47 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfI-00022y-1j; Tue, 27 Oct 2026 10:40:20 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 16/16] configs: tqma7: enable PHY and power domain support for
 USB HSIC
Date: Tue, 27 Oct 2026 10:39:13 +0100
Message-ID: <c217043cbe6d3ad91e09f6af49575f034402ef8e.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
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

Allow the USB hub to work instead of hanging the whole board when
attempting to configure the USB controller for HSIC.

The obsolete CONFIG_MXC_USB_OTG_HACTIVE setting is removed; it was
unused by the MBa7, as all VBUS enable signals are controlled as
regulators.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 configs/tqma7_common.config | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/tqma7_common.config b/configs/tqma7_common.config
index 9b055849ad1..03ece307974 100644
--- a/configs/tqma7_common.config
+++ b/configs/tqma7_common.config
@@ -98,13 +98,18 @@ CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX7=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PFUZE100=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_ANATOP=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_DS1307=y
 CONFIG_CONS_INDEX=5
@@ -114,7 +119,6 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_MXC_USB_OTG_HACTIVE=y
 # CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_IMX_WATCHDOG=y
 CONFIG_CC_OPTIMIZE_LIBS_FOR_SPEED=y
-- 
2.55.0

