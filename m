Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3109606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lMb4T1Jf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=yoD3hEWd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=R74SoC07
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5F4F6060E;
	Sat, 21 Nov 2026 21:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pbj9801V9-U6; Sat, 21 Nov 2026 21:47:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F04906061A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795297664;
	b=heym+8XTBMwquMY7DCisce3bWgQ6eT3FQ18pqrgV7WEPciuWHWswYVBuIspmngVgp+iU
	 kVjH++xZJ/ZbdGapz6w32c/riMITGf4HEwkbRmHTmE54lDuEQ9bP0ifR8UlPojvlN9Kgh
	 Z+bc76TtZcgDyMVd6H9Bi3qzX5563bSQsfH8rAPhGyE38R1Eb0GNC5izNxb4x3JfnJrnZ
	 DCxX6WLo2IKqGj/yvjMG15jwbq+ERLpH1Z4EV3FQGRaPfAOWWIu3PWXln8CQWCcmv1/O8
	 RXgehnIo78bRatiQ0OhD34wEUjtO3pXXExzm3CHe3hoHaH5rdIGGFv6iHygsaG/VllA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795297664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:X-SGantispam-id:
	 X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:AntiSpam-TS:
	 CFBL-Address:CFBL-Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vMBY5+1lerWLbhxFSQyU42zF2a7stCoffLSGPsGDErA=;
	b=OYZ+MFQtgLjA3VbUqD0T5C83tPeQxaS/IzR0KkP5/LOZoAe7D9KZeWXnpdNPkDSPaUFT
	 AvfZdVYLe86JclaMXCEpYggGQHHm4fYhPuIQ3hmW22Jv8rSLjd8X+V0868b8IyjVXbr1I
	 z8OFXVu9AE9pb4RMMnpj1fKPr4jtqOsb2MhmA/c5GRF9qzDGGWtXPozxMo7LxLptBq8hm
	 G/ZnR4Myq61XnhP/tXvtAojYFZWf59ZsyBH9SlKpQjw0JpJjhFfR2BiYwgjLE08qJFHjJ
	 35Le1S0nnLCQ2VlU2rsi+kyNtKbKUipHDY0DxvR4/lqfe/kbrul4XCFzHGm4hijbk/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=yoD3hEWd;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=R74SoC07;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795297664;
	bh=vMBY5+1lerWLbhxFSQyU42zF2a7stCoffLSGPsGDErA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lMb4T1JfSh63OUbLPVAAJjlkdy98PtMMpFh8c+ockj1WfLdJaFDttD2TWQuaFLOJ4
	 IiTLsNGL9BC5WRGs6gqfqZlNRJCZMPes1RsjL5rYSvz9LZO4lZz/zAo6hmg/Ov+YLl
	 Z/JRJb/5FNvBK77CrcGhWv41OOFK2w4nOFh7SYQWtcLbUBPHM5IifibxxFlXWEVR2a
	 oH25SaUjhDBtRCH9rbm907p1NOmIiSxk4btcMrHvbWElCw+hCRe1r37OLk7IgjMXHX
	 s1OjsfLs342xj6uvqNAE6jKRQ15WgdpqGBHmOqLJ9ChIU2G6DOXVuSqDclCBIyOR9E
	 ydIP6woXHdzFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F04906061A;
	Sat, 21 Nov 2026 21:47:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 84011465
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 21:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67F036061A
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 21:47:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpBRfxBpcIIS for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 21:47:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0445B6060E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.11
X-Greylist: delayed 725 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 21 Nov 2026 21:47:39 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=yoD3hEWd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=R74SoC07
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.11;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0445B6060E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 21:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=vMBY5+1lerWLbhxFSQyU42zF2a7stCoffLSGPsGDErA=; b=yoD3hEWdz03hoqvO308AcUdMCM
 kjcdoyk7fPwreoQMSvz5xmURw7MGKn87jHpqhlQWbXS3FWPhtG/DPr5COL5s8JcfuHHsxXkGq1vfv
 Ms7MOe2u6IAlZUPKtYaAv04A/qga9Te5fjtd1mIOSdvE1OidDvzYqQMwOhSiI+xCooDo=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-4zq2.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xUsk6-0000000C3u9-321m
 for u-boot@lists.u-boot-project.org; Sat, 21 Nov 2026 21:35:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=vMBY5+1lerWLbhxFSQyU42zF2a7stCoffLSGPsGDErA=; b=R74SoC07WMvWOdj+6GS1C5kcdx
 81rA/+yjehyT8X7q/wDTAUeeaTi6UIJmz9ojsLH+I/UX4YXDOClhgW5LVU32PqSIb+TXdWqizzq+g
 BPdumXnORTWeSBQgs6MpPyLIzpGtJjateJnQPGZq3pVxctiDjtV86h9HcZUKfm+VBnGs=;
Received: from [95.251.96.187] (port=59224 helo=[10.0.0.1])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xUsk2-00000000Nms-16dG; Sat, 21 Nov 2026 21:35:26 +0000
From: Francesco Valla <francesco@valla.it>
Date: Sat, 21 Nov 2026 22:35:13 +0100
Subject: [PATCH] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 regulators as bootph-all
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-beagley-regulators-fix-v1-1-467ace9d717f@valla.it>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqDMAyF4VeRXC9gI5RtrzJ20WrsMkRHYmVDf
 Hc7vfwOnH8FYxU2uFcrKC9iMo0F7lJB+wpjYpSuGKgm7xw5jBzSwD9UTnkI86SGvXyxaWofKF5
 vvico549ymY/w43nacnxzO/9rsG07oatTm3oAAAA=
X-Change-ID: 20261121-beagley-regulators-fix-3306a2b896f2
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=francesco@valla.it;
 h=from:subject:message-id; bh=hwHKa7mvdc1UjZ2NUKDZvWFRDU52FXikga2BnrDXyFI=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNlMfDPdp2g3cotVu1225zm8/PY2thucEj3rX6m++i6Ze
 X/Px0XNHaUsDGJcDLJiiiwh627c2zPX/FvaBsZHMHNYmUCGMHBxCsBEAhYz/E965/3FT5aD59ms
 YLnMG96dz917L67W7hV6XvTWJGVzwhFGhhnzxbz/v5y9L1bzYo5RfIT+6j3HDqo0rihT7jJ1KnZ
 +wQcA
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
X-SGantispam-id: ada93c2ede69d3ccd5f66fb80e10994b
X-AntiAbuse: ID - ada93c2ede69d3ccd5f66fb80e10994b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xUsk6-0000000C3u9-321m-feedback@antispam.mailspamprotection.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
missing") changed the behavior of TPS65219 PMIC driver, which now fails
to probe if the regulators sub-node is missing. This leads to a hang if
a device marks as bootph-all the PMIC node but not the sub-nodes.

On the BeagleY-AI, this results in no further messages after TF-A in
normal conditions or, if early debug is enabled, an explicit failure:

  spl_early_init() failed: -6

  resetting ...
  no sysreset
  ### ERROR ### Please RESET the board ###

With the bootph-all property added to all regulators, the boot completes
successfully.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
I'll send the corresponding fix to the kernel as soon as possible, so
tit can be picked up at next DTS sync.
---
 arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
index 0e810e7f492d..72f9284471e4 100644
--- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
+++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
@@ -57,6 +57,30 @@
 	bootph-all;
 };
 
+&buck1_reg {
+	bootph-all;
+};
+
+&buck2_reg {
+	bootph-all;
+};
+
+&ldo1_reg {
+	bootph-all;
+};
+
+&ldo2_reg {
+	bootph-all;
+};
+
+&ldo3_reg {
+	bootph-all;
+};
+
+&ldo4_reg {
+	bootph-all;
+};
+
 #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
 
 &binman {

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261121-beagley-regulators-fix-3306a2b896f2

Best regards,
--  
Francesco Valla <francesco@valla.it>

