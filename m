Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C89606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EH2GSFty;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=e54eXMHP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=M2k3ic0/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36E2B40531;
	Sun, 22 Nov 2026 23:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pZiGiFT2xqP; Sun, 22 Nov 2026 23:54:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83EF54053C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391666;
	b=XRAoexxAyASm58A5jWiP+FqnnfYRi8PTQY+JfH6moxsJ6yN989soRbW4wbDt3OfljBNP
	 yPcdxApN4WLXGLCEWIMPNbx7sF1+mqIZ6KPAFBr+pyr77x4jqF8nWgnbj24YIUWlt9EMU
	 rn6qUF4jBxvlaWAxwiXDmWqAmS+P9CHmv9yGs5GXZGMtNDJ4NpQGe3MRANpBuB9/kdVRt
	 gTmzzdFScI4MYsRDusI5D1Jm6Tr3bbU6rlgvx4Yi0q4cJPLQPiNmZ/BvThaCQ5ItKt6UE
	 UPrIUrhS7lKhvIYB8OqDs+oTRkxurdQkq4T4cM0vCOrH97PE6l7jhstypt8igaZOgSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391666;
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
	bh=BQ+vysXFHZK0LQKvCWRkkEa0VUWAOjRs1sphTCUtsIE=;
	b=Qkxx7ZWerPPz1JheDju58eUys6WlLsxnrWUBiJZ9BsjIfNkvkW01VXmILWs2RvrErtqi
	 vBydoIYham67bnAlyOpnJuBKPmy+JULCGl2lbkGuu/079g+Juyt1/Ws2wj/Tg2+eNIBUo
	 8K2iHFTG9qdMV4hp4EA9QL7LgRQOzBmMlpxHXsYlqTUb6DMrBoLFgpscrY/LQYnzG6a/W
	 ksleSPzPTlAZuOg5iTveatkzz7XsrURjqBM3R0z0ianPVBeXRR9ZDluTawecB0UOp2T1Y
	 re0cJBCnCdkOFyVf3xKFByH8XYTIaP/5KGcn3YL/S4rXcF2yXDRd75C/d24Wl4nvWpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391666;
	bh=BQ+vysXFHZK0LQKvCWRkkEa0VUWAOjRs1sphTCUtsIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EH2GSFtyZosYp8LaV13V+cRybxnQpPTHEL0fV55kffnnQ+fr1FfNggvzMAbffQk6I
	 I47iC3ssPwbCTdfzrXtEuoTl98pNzm269HjvVy201TuYZxZhXcbV/dJsdjliOkw0cr
	 cZLwqfK0UV1uO3xbDn6fNL0fh7KqQSPaQ4YSV6MQ99DQmtXAoZejvir/9lcPmvCA9c
	 4U4JKeGuR1ngfvDpLVwBGWe0QZGx1SXHeoKtiyktje6h6CjF3V516o/4gcujzlXTuM
	 0mWYeT3Xh8+bq8zlDziUFwznSId6TljWl3oyKD/vC/jCt1pm60R/0T/dpUFjNaG2cU
	 oyeKVMpTbOvew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 83EF54053C;
	Sun, 22 Nov 2026 23:54:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C175B260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B349180C3B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UpiLWQ7WZeHt for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50E0280BBE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.11;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=e54eXMHP; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=M2k3ic0/
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 50E0280BBE
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=BQ+vysXFHZK0LQKvCWRkkEa0VUWAOjRs1sphTCUtsIE=; b=e54eXMHPUODwilMVWz2FU2AFHu
 GqHbrzYeGnCdA37PFxFLcOTr/PfQpniIFO/20MzerCFXeKFwcjfLAf++NPGadGnYgSjohm+OpDOQe
 w93jkv0AqV7xrmi9JBNHy2c4KHosRdEAKGJ1BT19Ob9z8wo/ck+GeKvBiEVkAmSIpDxE=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-h034.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNw-00000009z3N-1ed3
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=BQ+vysXFHZK0LQKvCWRkkEa0VUWAOjRs1sphTCUtsIE=; b=M2k3ic0/nc9TmmC93HYWp3yn0T
 WKlBS3IF7khOUacO+NR4qI6dW2pi/mzS6UVTvHN1/wE5aZDK+uUwn/WFi7mCm7ju0mw/SJH9ILcQh
 pYRO8f2euY0QFDU0AlBvKjkbEXXFDuMlro3HHPFPV0bTgBIm+CG7b3mkLBbYpsF5XB/A=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNr-000000005H0-3lsA; Sun, 22 Nov 2026 23:54:11 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 23 Nov 2026 00:54:05 +0100
Subject: [PATCH 2/6] arm: dts: k3-am67a-r5-beagley-ai: Use dm_tifs for DMA
 controllers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-am67a-ethernet-boot-v1-2-94520ed74c90@valla.it>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=francesco@valla.it;
 h=from:subject:message-id; bh=xhGzGm8Mnm2fqrondJkNGE/LOJKwZbFLEKMTdGY329s=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDQt3NTDv3hpastLEYL3VLIsfjS/S3OoM3CRdduwTz
 XiwKPl+RykLgxgXg6yYIkvIuhv39sw1/5a2gfERzBxWJpAhDFycAjCRqE2MDIu+WxeEh+REbnxz
 7N/jnbsnc0xmU3L8cSfSx6Zzj2vNZiNGhp8+66MW6QmmLvacMr3Byd/2z+df9knFc1ad7++bxpD
 3kAkA
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
X-SGantispam-id: f6d53b1595ff38e71c1d90cb8471edee
X-AntiAbuse: ID - f6d53b1595ff38e71c1d90cb8471edee
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNw-00000009z3N-1ed3-feedback@antispam.mailspamprotection.com
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

In R5 SPL, the UDMA ring and channel configuration requests must go
through the DM2TIFS channel (dm_tifs) rather than the default dmsc
node, as done on the J722S EVM and the other K3 R5 boards that do DMA
in SPL.

Without this, when booting over Ethernet the resource management
requests sent to dmsc time out, the secure proxy thread goes into an
error state and the CPSW port fails to start:

  ti-udma dma-controller@485c0000: TISCI config ring fail (-61) ring_idx 19
  ti-udma dma-controller@485c0000: alloc dma res failed -61
  am65_cpsw_nuss_port ethernet@8000000port@1: TX dma get failed -22

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/k3-am67a-r5-beagley-ai.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
index 61ee75b74323..2d8147a09e18 100644
--- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
+++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
@@ -17,3 +17,11 @@
 &wkup_uart0 {
 	status = "okay";
 };
+
+&main_bcdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};

-- 
2.56.1

