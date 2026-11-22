Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44222606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tal5D4L6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=JVUkGeBd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=ZZEIPr3n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADA4880D85;
	Sun, 22 Nov 2026 23:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KQXSbIGSfkjI; Sun, 22 Nov 2026 23:54:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B4C080D86
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391671;
	b=dFXPaC0VNbj+MIXUxBznJRnEbRbA5zAisajTA93bPnqsRIK0Rp6pgh3iLeC/wvw3bemN
	 H5bpK0WztmLWeXlvO0K83uiwKN1VcXNqJUazco2Xu33+3cl9CXPZpnRZwWAVC4iewghMO
	 G4slhC53sG2DVuG4YsgqCKHDGlGScjS580UnHne57taW5Ck4dK4P5AWWj/kkwA/66ZBJK
	 SEMnZ62zHsf6jfeZGWCjffx5GFJnxipl03+/vVewxu5oKlinWIN4dge787txRysyDx4dc
	 eKkjQYqb5Dy+uIaP5m7TUV5AUHV/14HAuv+yzGQllLgF95P9vj3TcwQQ8P8wqMjNtPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391671;
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
	bh=Hf8bTiatGc1AuVRPVBOF0jmtTsOLsA1X+C+jmY3YRXI=;
	b=stRoGutBC0nLpcPmcvcHk+lR0sPVucrunDm4wLwtXSkO4h4sZoCtavoX1gBpJ9fopsvt
	 PGg5EQgq8RMuA124lhwZiW2eHuipmNCOspZANLUDrYIV2q/tFNblQB1jQ8e9QqpshB2KK
	 dRWJetZVV9t4Ou7OnBP8bL29Gb9ZGb1RXtq3hFQAficaE0aCBBjDoEUcRpftCqZNtFTYR
	 Smh0+gbrO68rTjfYy78AkuYB+HkUMMgmjeSH17Ji2TKOe6ixKETot4Ix9VOCUoOcdg9Y4
	 2JX7OyQYJO4x0i5kEZRVQbC6uc+qjDmZa5OVM7QQGZ6U0RUKCdmsVUusnUfJ0nnJhxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391671;
	bh=Hf8bTiatGc1AuVRPVBOF0jmtTsOLsA1X+C+jmY3YRXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tal5D4L6udiUblZsc+K1aC9V8CmweayMoiAF6O4Z6cbh5aQNJ/gUgO04/1vMJif4y
	 JJqyfgdg6X7nN/DZczPrOB+ccN23jHd8XpCz8eNgAJdS6wEjWJtKfwI+/gSJnAlRPR
	 RuTSB89XoFXNaLmsODKRYH7gUMtyY3vISdmokDYdXQjkQ56CztW3VR3NQkbWeGK2DZ
	 LjEkgbHs+GoTcI26ctqHR9LZ41iL9BqsnW5uF7Vh7rruYoMa+Lih56vmwf4x7Hn1Zx
	 MIgsgREJQ1G7UxWJtw60FqGAGSbGY62t3K3Har3SDqjj9h55SG/qRvkXUOGTKJ+jvN
	 cPCJNgonlMCow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B4C080D86;
	Sun, 22 Nov 2026 23:54:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6873D392
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F0974043C
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jykoP1Db52bS for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6675640352
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.13
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.13;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=JVUkGeBd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=ZZEIPr3n
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6675640352
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=Hf8bTiatGc1AuVRPVBOF0jmtTsOLsA1X+C+jmY3YRXI=; b=JVUkGeBdqnie5Jg1lmvx54ToUN
 kUFDovVDFqvz8PL4YJFCPwLtNkeAMod+87WlhtR03wr/drN2gHPI50cpgUOOuRMbBPRYT/ZnICo5R
 EFRGkGYLJNykSNmhMR/kbdQzPf4xGDPD34xSqv+D7AT+HPn6EYxIKTcp0wglGxH6pKXo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-h034.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNx-00000009z3g-1Rau
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=Hf8bTiatGc1AuVRPVBOF0jmtTsOLsA1X+C+jmY3YRXI=; b=ZZEIPr3nyfaWnS0uvUNJ+2OxTD
 K5G2s/guVimC9ICqiUMwi0DfcDs0+d1nkcCpLz71kp0X8t7Sdm/Ha6Ly9VqSQSi59U6mhl0yrCHCX
 qRF0EUAf2ocqdZhHPGy24xLF93WCHFl3/IjhrAZ2dacNjslsQ7F0TCCbGuRgWVpAmv40=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNs-000000005H0-3hT5; Sun, 22 Nov 2026 23:54:12 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 23 Nov 2026 00:54:07 +0100
Subject: [PATCH 4/6] configs: am67a_beagley_ai: add configs for Ethernet boot
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-am67a-ethernet-boot-v1-4-94520ed74c90@valla.it>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=francesco@valla.it;
 h=from:subject:message-id; bh=oZerNt1HvU2PxKB7QD1SyfIC62CKMrGD/ILs0Cxc5cw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDYvmz36cctElca7bm40bP/m33wxVenJS+rWFppHB9
 5+PPEuFO0pZGMS4GGTFFFlC1t24t2eu+be0DYyPYOawMoEMYeDiFICJvPjE8D+R0XHlbuZdv+UC
 1v9kUdd/IyiWOzVcRuGMhIhV158DAumMDCdWfPD6kcc07WXPl3ytbI9LWssdUo9e02PYd7xhwdR
 VE9gA
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
X-SGantispam-id: 05ea92cb38e387d55f1442a98930c672
X-AntiAbuse: ID - 05ea92cb38e387d55f1442a98930c672
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNx-00000009z3g-1Rau-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h034.prod.antispam.mailspamprotection.com; 
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

Add configurations suitable for Ethernet boot of the BeagleY-AI for
both the R5F and A53 cores.

As done for similar platforms (e.g.: AM62, AM68, AM69), keep them
separated from the regular configurations to avoid increasing their
sizes (in particular for the R5F, where space is limited).

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 configs/am67a_beagley_ai_a53_ethboot_defconfig |  7 +++++++
 configs/am67a_beagley_ai_r5_ethboot_defconfig  | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/configs/am67a_beagley_ai_a53_ethboot_defconfig b/configs/am67a_beagley_ai_a53_ethboot_defconfig
new file mode 100644
index 000000000000..5c2db954b5d6
--- /dev/null
+++ b/configs/am67a_beagley_ai_a53_ethboot_defconfig
@@ -0,0 +1,7 @@
+#include <configs/am67a_beagley_ai_a53_defconfig>
+
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM67A U-Boot A53 SPL"
+CONFIG_SPL_SYSCON=y
diff --git a/configs/am67a_beagley_ai_r5_ethboot_defconfig b/configs/am67a_beagley_ai_r5_ethboot_defconfig
new file mode 100644
index 000000000000..044dbfd5ca02
--- /dev/null
+++ b/configs/am67a_beagley_ai_r5_ethboot_defconfig
@@ -0,0 +1,13 @@
+#include <configs/am67a_beagley_ai_r5_defconfig>
+
+# CONFIG_NO_NET is not set
+CONFIG_SPL_MMC=n
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_NET=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM67A U-Boot R5 SPL"
+CONFIG_SPL_SYSCON=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_TI_AM65_CPSW_NUSS=y

-- 
2.56.1

