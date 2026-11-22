Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0B606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eqIuDZGu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=vu+u6YMc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=YtXj3FqD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3501480D7D;
	Sun, 22 Nov 2026 23:54:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B51s5Rr-Np9V; Sun, 22 Nov 2026 23:54:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C39680D35
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391668;
	b=WbAKLDPLl4/gsGY7Ng1uYO8fRD76dUM6G5QOzWWPnR0vJ2kAKasrd9rIZCNMfH/QJZCM
	 l4z50uZnhxCbJBvbi1jOcpI2HaOXB8qnynVx144k7X905gHw4oc9GeTc+o93XX+D6Af8N
	 Ysxn1N4FHff5VGReIXdULVpwBs1IirpCmy9vAKYUKHVqhG1fYcga0+hmBX61kZRm8sMxZ
	 v4gao8+Wg2iwWpPdiXuTHIMLTaknIYRfLPfdfc3RSH5OzmpEwSbWS3ZdmeGibnumjLx83
	 I/YTj5Zlxi1irN4DDIPf+LclLQGBb1IBP3Ci4eskecvogTO8R+AHbkBksgJpXe/sYmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NvhSS9QF/xdrUgz0Th6KpCY1BufPI+UOKbgV6DFms9I=;
	b=rwWpYcb3MzK9UVZA6yAb+THsyUc1By56KVPIDgkcfj9Npkfq2R+/xmJzBT1zdFUJOjIp
	 ezaBeVXJySxBLSHF2NjCCklbkHFuhhvO8G6JNoO94qIcViIjIblW71eV0V62tEu1W/agB
	 a2RGSxR4l2v+4H7AknWFB4tayWl0hzRP3rZt4PXxJWPmRmJjlwHUHBZPWkF7NJ6m3MvnW
	 YimKiqzHGeuoM0fXNpOs2hVS8TlX8e7wdFkX2OO/p3NMXreA6mH/wclQ2hQ2B+hPzLzpd
	 4zLmSWYmnmMl/B/4gJ9hCJ3Ti4+rquFiAc3FdTQN+SccxPdw6WnCIxdp7LDSWy9+tLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391668;
	bh=NvhSS9QF/xdrUgz0Th6KpCY1BufPI+UOKbgV6DFms9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eqIuDZGu0T1o0FLR0R+EYk4pSZ3M7lAvL6q7AOtUinEdgNXB73nN3vPCV+UqNJubU
	 lCbLy+1+aLSuBLbL9Vjpu80ZLF4Vr3wirQ9sASLfEIE0pmr43CsnDaOpObZ7I2trsw
	 ip1p0qxRE1qiH3cIVjVQgnM81aiVtRlfI7LLRY7kgLT7kVzA0ZEIuqaUkrz4n/pwVa
	 N40QBgpR+CV9FNDcM/w91YFQJ0RZpHSBNXV+LwLmSe7TcafANkSl36yZ3JzERzWmnI
	 2wLTsP0SCzHkGGJE0xpfcW3++OeNQfJY3ZfOK2BOSiwuwUSz6OvmZXHdOjhqBWpTOM
	 wyh87+8BZ+6Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C39680D35;
	Sun, 22 Nov 2026 23:54:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5575260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D78ED400C7
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdQrGids_QjK for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 50F6D4006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.11;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=vu+u6YMc; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=YtXj3FqD
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50F6D4006F
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=NvhSS9QF/xdrUgz0Th6KpCY1BufPI+UOKbgV6DFms9I=; b=vu+u6YMc1soEeUFCyKe87fwwRb
 nI2lKBVikQmxzx3sqMZM1K//CXfDWgoMyZFsHGKpYqqHJE6ZakU54ymfzMC5u3E9hm2aDdtv7HTrU
 pjxEKLKhjG/bpQnKsgU6MvgU/Lfn65Iu1xXAlJHX34xmAV70SD/iYvMGyIYAUFO7s27Y=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNw-0000000AEQH-33If
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=NvhSS9QF/xdrUgz0Th6KpCY1BufPI+UOKbgV6DFms9I=; b=YtXj3FqDoPF73FXwM/7yU1SJIy
 V6kCLgBpPdmi8I4qrduUeusBE4zcgDIZYU8qHD93EGRurxSCMLsEKE7nqKvSQqscUeBfH9W2XqtfL
 0pRX1srevXZ5fIiRPOQNUvRtTF71yr99GmIxbC7YznWikCiQXISJ7uuQovQnupRLZ/oI=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNs-000000005H0-1cIk; Sun, 22 Nov 2026 23:54:12 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 23 Nov 2026 00:54:06 +0100
Subject: [PATCH 3/6] arm: dts: k3-am67a-beagley-ai-u-boot: allow SPL
 ethernet boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-am67a-ethernet-boot-v1-3-94520ed74c90@valla.it>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=francesco@valla.it;
 h=from:subject:message-id; bh=+trH254pmAxCyA9LyLml4GfYAr9V6sxu5TeZZl2Xzyg=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDYtKGvxOFupyfC86vLTdXatAof7lhzOf2ypjp9m7t
 4Z7rzPtKGVhEONikBVTZAlZd+Penrnm39I2MD6CmcPKBDKEgYtTACby/w3D//TS1VareuSEPwpz
 KwTruqVWmjesvmLi5PQ9yvTlnRxeBYb/JS47iv8uqY7U7mrasXBzhrrUn2xBofJ1f8y4Ni+fO/E
 SIwA=
X-Developer-Key: i=francesco@valla.it; a=openpgp;
 fpr=CC70CBC9AA13257C6CCED8669601767CA07CA0EA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.u-boot-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 4dd15e647e2000e91cdb7e9f8f9445bd
X-AntiAbuse: ID - 4dd15e647e2000e91cdb7e9f8f9445bd
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNw-0000000AEQH-33If-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-lgmz.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark all nodes required for Ethernet boot in SPL with bootph-all.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 0e810e7f492d..551e628ec20f 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -57,6 +57,41 @@
 	bootph-all;
 };
 
+&mdio_pins_default {
+	bootph-all;
+};
+
+&cpsw3g_mdio {
+	bootph-all;
+};
+
+&cpsw3g_phy0 {
+	bootph-all;
+};
+
+&rgmii1_pins_default {
+	bootph-all;
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
+&cpsw_mac_syscon {
+	bootph-all;
+};
+
+&cpsw3g {
+	bootph-all;
+	ethernet-ports {
+		bootph-all;
+	};
+};
+
+&cpsw_port1 {
+	bootph-all;
+};
+
 #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
 
 &binman {

-- 
2.56.1

