Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0907606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CHxuLGAS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=kbteCdpX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Nmn7myCc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76DB84061D;
	Sun, 22 Nov 2026 22:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SNVaMvu_S-c9; Sun, 22 Nov 2026 22:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98225405F4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795385547;
	b=UbcUgUlyHVc7knwQI7UOEyjMcSnDTLxg3r09u9H1o8yg5iOw9z0Su0/a3wxhBJRid9il
	 fT1idrG44XGnz3keySaGFeCsGZ+QI4otY+jQCZqxo0mZXmOIiOT+PGmcBrXRYe43Iog+0
	 SmUjVcO/fup2WXFV0jhQq3gbyU6TmEAAStNKMsAGsduTtcZklF0wAbn/xjdizvDgWa6Wq
	 F9dGYhnU0JwRIb8zRBZtUYU5o0ScpApMCfPmttu/ylyk/WCfjVYgZ+rOFNEDFYYwbTqz9
	 P3v1JSEcnHhseDILVkMuF7kfa5MuT0qdtSBNRHoZtvZkFlo5+Wq7zcc2IekqgIrw2Lw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795385547;
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
	bh=JOr7i+9cXsNtUgJFTQQKKdwBsJCwXPamFfxgEOB633E=;
	b=gqBqri4EWAg9FVNPDHHrCxgC5ATvPjy2Z7xcrB6ep1oHgyy9b0yp2EnM+jDMsyMYTyKD
	 Q4HCP/ekI4aHGbvuGCFwHmeZyWY3F1mUwIdH1Vxbg6IvFIFQG+vYLJa2qZFC3ckl+floA
	 CqDzBBpiBYdfzB3IGzkeyUzen4SglBu2j4mMRMRfpRDvb5T0Y36vPhjFEF4zlz9S+yFtH
	 wfEuiF2aWXq93TIBLHrSbQA+xP+uJAOfmYS0+GmzlidO3HNSzmDM7l4xSwrqgoFTes1bz
	 gCIwzjfgGfCLOT5AR2gb0bkO46VDr+NSXf4v6i2wD9i7Jkvca5loMeiVL9bmyXO06kw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=kbteCdpX;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Nmn7myCc;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795385547;
	bh=JOr7i+9cXsNtUgJFTQQKKdwBsJCwXPamFfxgEOB633E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CHxuLGASCkMXbuhZ1ROCVRCTyqoSmh2JBefkh4Pe/6/m2jNSuV7iasw7Q8ZWtwZki
	 ldS+LN2BmwwIQamtX9g1cdwoMXJNtOlLJHgi7oyo5Xgf3jEjidssFMRbzARqfQ4c9R
	 f5nc3V3UnIrdHnQCfMGlYc065Qy/l1BljdqR1qVAx7OpkzZhTDgRFEot7MdZQswhS1
	 W/6GJiNfr7E996CQ9RyfVyFNFEQDS4ajvb/VNy6jBJeq9sAqYgf6o+q6x7gcbfoQeW
	 zca2v0y+kJhSBHRwfHXV/qwLyZ4KNSpgwKX7KSxwK5KtcbZtU9lydLWH01ftX77LRW
	 AK1iuGmTMNfKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98225405F4;
	Sun, 22 Nov 2026 22:12:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4817310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AA94405E6
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h6nRYI-uIZOV for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 22:12:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 14186405EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.1;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=kbteCdpX; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=Nmn7myCc
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14186405EE
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=JOr7i+9cXsNtUgJFTQQKKdwBsJCwXPamFfxgEOB633E=; b=kbteCdpXOBqy4j6C0INqRg2ceI
 cx+CBKbXnaLF0zYEtnTOuUKuvmzt8srs837NbFS6+ao5Rt0ZxH/Ma4pz3J/SkZNVmmjHetl9X68II
 g5rpi4PqRxhQRvzQrKC/VY89j/10WV4JHPQal8dIX4qgMEwx4gXd/Grp31muoGIpYqMQ=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVFnD-00000009kUE-3XDU
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 22:12:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=JOr7i+9cXsNtUgJFTQQKKdwBsJCwXPamFfxgEOB633E=; b=Nmn7myCcPSivYrmYI34ANYKhDI
 Ode/rGVjc1GiKKDLuOFrBCBlmWIXbjsu+QFtyJFbE23f/DwH6qiarwBOm3JcBNwV3OnKwwqS8ffIO
 FChq3VlAFrDScsVQqeIRSkdbl7pC7eXjNf/S6fHCOfkNrurVd94SBoHobcWITWiKqmHw=;
Received: from [79.28.115.6] (port=61029 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVFmv-000000004nS-15qz; Sun, 22 Nov 2026 22:11:57 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sun, 22 Nov 2026 23:11:37 +0100
Subject: [PATCH 2/2] arm: dts: k3-am625-beagleplay: drop bootph-all tags
 for regulators
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-tsp65219-spl-configs-v1-2-20492ba3f1e9@valla.it>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
In-Reply-To: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
To: "Kumar, Udit" <u-kumar1@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=francesco@valla.it;
 h=from:subject:message-id; bh=NBZTiPMtnhwt3FAQ4h2qTlco5YJepEy2jUIoTaHpwUE=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMGavXXus62ufwW3Rz8aT/SpO3NmcFPBHks9e9mhLPo
 u9Q6mHRUcrCIMbFICumyBKy7sa9PXPNv6VtYHwEM4eVCWQIAxenAEwk7yEjw2azEuVvJdNc7Nd5
 zTE+5LfvhowDi2GA8rboi+5KU07zWDMyLC1jbclvO2680eJVxosNfdFzczc39H6QjBRi8PapO6H
 KBwA=
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
X-SGantispam-id: f838c5ecefdda4aaf0cb0863da2fefd0
X-AntiAbuse: ID - f838c5ecefdda4aaf0cb0863da2fefd0
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVFnD-00000009kUE-3XDU-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com; 
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The bootph-all tags on the regulators provided by the TSP65219 PMIC were
added to solve a boot hang caused by a change in the behavior of the
underlying driver; now that the driver is no more compiled for the SPL
they can safely be dropped.

Link: https://lore.kernel.org/u-boot/20260813-beagleplay_boot_failure_fix-v1-1-01d73d735cbb@ti.com
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 2a0b19173c08..d06cbd899c2a 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -229,34 +229,6 @@
 	bootph-all;
 };
 
-&buck1_reg {
-	bootph-all;
-};
-
-&buck2_reg {
-	bootph-all;
-};
-
-&buck3_reg {
-	bootph-all;
-};
-
-&ldo1_reg {
-	bootph-all;
-};
-
-&ldo2_reg {
-	bootph-all;
-};
-
-&ldo3_reg {
-	bootph-all;
-};
-
-&ldo4_reg {
-	bootph-all;
-};
-
 &cpsw_port2 {
 	status = "disabled";
 };

-- 
2.56.1

