Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46382606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F9f1HJfm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=oLe1c/r6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=jytdm/7A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 154EC80DC8;
	Mon, 23 Nov 2026 23:45:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XiI48408DmpL; Mon, 23 Nov 2026 23:45:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 67C3880E31
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795477525;
	b=hpOpvUvCINSl5BoSbVlCd3eb5Q2EZKFReAwWMpwCQhsG4NV99mLoLRUbcwBY5c4RBIUp
	 OVE/3hlozUEuUijp9tBvxVRN84ueUs81lZzmX0tr45sBTx66mn3mnK3aijV4jUJQOrpMT
	 5ReoCUgbrCVPdR+Z9BpOBg2ny4LJhz5hntx/MmrtMNjKYvPF3/MF7rGlLz1YmTL8P8YXF
	 2jGaLqskZeis3R9hOPPpJl9sxCMx4cYtmgeovsyTqS2J7N0tvZZPNmKGejV9BnWQPNDNQ
	 P7Co3Osz6X1+bubASiucZj+aFP1CH2BRupDjcn8e4NjSv5AEcD2mIloWT2Q+aZKngMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477525;
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
	bh=Ix9fHzzCwfjGaavrSOH3SogvOWrlIQfAH8K7JABmue4=;
	b=ijxhedmA2rbQhaZdcv/fpd6wUMgryHNW140sjm/hEZywzMACyFQvB3UEqe9kEN8dvucb
	 DzZCmyqZrBKPJip097215bgLJHUciXJ+bGITWyYIuDJUAKKWDL4JiGhUjEBDFsF0fcKL2
	 5ArAIJOy0GYV2AMIIrkztzNP1V1JrocoiyAB0Qvy9vUMp+zcQ3S1Xd7Ue2tHltvbHdZF3
	 sGv70XT0FPIMAbSo9aDm75AQIrVZk2tVfGKdxpzVgOHi7TpPymUNMh3vl6lSPL5/4aIXS
	 s0uFd1fpTIDbdh7m42lJoO9zu/hfsAwahpNkH6ipCNsDMVvlfIMGebW8MnbssZTr+1A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b="oLe1c/r6";
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b="jytdm/7A";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795477525;
	bh=Ix9fHzzCwfjGaavrSOH3SogvOWrlIQfAH8K7JABmue4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F9f1HJfmUgX9kZNPQzAknh746lFRH1031STWXa2KE2K0T3ZQF5VNN7ISDTKpCVK+3
	 ETpq7JfslpY1Hhg9rFKMJZRuzSyiEJNGAgZh3tZIh5MF7Fuy/57WnoAbnbHCG4nQsv
	 uUpjPPK/6wQhhPoD/7iYYO0UnLMtXgVihuaXDFmPBlnUbi4qugpsFolnbewfiGPJXX
	 gFVLZ6W+tckjb4N6oCb1Fs5yvQn88Ft4biSQM5U6QuDT7z8JGd6OIz/X4G0h2aJ+6Z
	 6Wyyp/cFhcDGQ/dXGUVcLf9ZfmnomhfHCquEGbGnKmeHGV8SjdI3Tn8zBJqZBjf4Zc
	 rgAh4v4HmlAtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67C3880E31;
	Mon, 23 Nov 2026 23:45:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D94C2D31
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C19AF80E31
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7QRNb6bm8y3D for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB5E980DC8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.4;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=oLe1c/r6; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=jytdm/7A
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB5E980DC8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=Ix9fHzzCwfjGaavrSOH3SogvOWrlIQfAH8K7JABmue4=; b=oLe1c/r6wjewhx9f0Osymx4W7M
 0YJrfK5NGtZ4uDehJrna4rtaeM0aHvAFbMweD2/6PS8NlvWx3QW8vV2N4AEVBLj8vatjV0p53gN12
 ehoeoRGmRJuLXG3FPWVpMi5AW1+qicPmTGxIWvDgO3EkZD+UvWW+DA+Z9gxWiLduPMrA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-h034.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVdiq-0000000CThP-0Mug
 for u-boot@lists.u-boot-project.org; Mon, 23 Nov 2026 23:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=Ix9fHzzCwfjGaavrSOH3SogvOWrlIQfAH8K7JABmue4=; b=jytdm/7A/yLH5T1hIaG80uKz+x
 eyKbddzocEl1nIYAOJqWee8guD98Y9qmXHD/+3oST5Ao5moyvLXZ2hI1+cmhgBGrMvu7BGvM0Y6ld
 nG1z+Lvy8+xMqZbJg4vTGA1r0fFkoGTtdbqQuzcFB2LQC5ZpzmE4DSJzruI5aN98Pzzo=;
Received: from [79.28.115.6] (port=61909 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVdih-00000000MHw-0Cbk; Mon, 23 Nov 2026 23:45:11 +0000
From: Francesco Valla <francesco@valla.it>
Date: Tue, 24 Nov 2026 00:44:32 +0100
Subject: [PATCH 2/2] arm: dts: k3-j722s-r5: Move DMA access configuration
 to generic dtsi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-am67a-j722s-unify-v1-2-19a83f16d38a@valla.it>
References: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
In-Reply-To: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
To: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Andrew Davis <afd@ti.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; i=francesco@valla.it;
 h=from:subject:message-id; bh=5+I8a7ugWFjyj7DgIWrENxKLhVeZCvNADWNIYiawDH4=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNksF1jmbdJT/NXU+bKtVtRp1vIrsdP2yd3+fiTbuaKrT
 1OAWSGvo5SFQYyLQVZMkSVk3Y17e+aaf0vbwPgIZg4rE8gQBi5OAZjIhH8MfwXmOUyU+u2rU3pF
 8NWRJ46L8875vI0SNVzd6nlJv0mWQZWRYX9IlXJ9U4M5/0e/LT7sz0oCV21bdH/7+r9Zacytpt/
 6GAA=
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
X-SGantispam-id: fe38e02bf904b05783e535ba446b3dec
X-AntiAbuse: ID - fe38e02bf904b05783e535ba446b3dec
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVdiq-0000000CThP-0Mug-feedback@antispam.mailspamprotection.com
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

In R5 SPL, the UDMA ring and channel configuration requests must
always go through the DM2TIFS channel (dm_tifs) rather than the default
dmsc node; this is not board-dependent, but applies at SoC level.

Move the configuration from the EVM dts to the generic dtsi; in this
way, the BeagleY-AI (the only other user of the dtsi) can benefit as
well.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/k3-j722s-r5-evm.dts | 8 --------
 arch/arm/dts/k3-j722s-r5.dtsi    | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index e1ef5d181ed7..62c44d33e186 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -15,11 +15,3 @@
 &wkup_uart0 {
 	status = "okay";
 };
-
-&main_bcdma {
-	ti,sci = <&dm_tifs>;
-};
-
-&main_pktdma {
-	ti,sci = <&dm_tifs>;
-};
diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
index 9ddb951e078c..cc1efa5e20c1 100644
--- a/arch/arm/dts/k3-j722s-r5.dtsi
+++ b/arch/arm/dts/k3-j722s-r5.dtsi
@@ -76,6 +76,14 @@
 	};
 };
 
+&main_bcdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};
+
 &main_timer0 {
 	/delete-property/ clocks;
 	/delete-property/ clocks-names;

-- 
2.56.1

