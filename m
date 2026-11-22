Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6E606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=smVmGzYv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=krG8iDcK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=DB66uN29
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BFFF80D0F;
	Sun, 22 Nov 2026 23:54:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jtmy7DaNgh4r; Sun, 22 Nov 2026 23:54:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 533EB80D35
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391664;
	b=rnztDodSQIRD4SRvPEyneWxnydVLI5SJiH/JYFgSYnBq8dprAt7ocAOJs2vxRAce1NhJ
	 RlF0fsGI7VdJk0PaO1CFNdHlJSdFjfAc+Oxi2p9CmqIWRK1Gm8GckreXC0ftfGAZ3gQ11
	 U5TpxNKZG30P8BADaamjF2yOBLP3qvVmjZop/AdhEvjJdVv3BZSudgQ0P4f9sOzxcGw6e
	 u5NIwKBgTIDxbsLwgOfRXZ22R3c06Vx9ZZMS5L0YOJpz+FTxxPgbKJoXLWSP22+X1xtQj
	 CCmA2OYYQi0LGcMR4aa1QZ/FSsCU5A/fCZbfLriQUOTNcwNvHzeTQRAAsunVYozhrXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391664;
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
	bh=02tSLe8wvSkKqu81Ml5g3FDyacmww+tyiiXNeR7T2WE=;
	b=ZrJ/Vfz2c81Ss9tDesEdCcJiXyWdwQ8bNYxZZR/2uJlNL5PAEyN1muKQqABgUviKH/0E
	 D4PIdsTsw5pyxirJwIX0BBto+NzLDtVOk9EJ1cpKiJ1RFiCFfiY9swQedDyxV7Wx3zIT+
	 AXwl65B7Njl5aSsaiHcSd/nmu7oWi72gVC8Cmzw/M306LcxXdu67B5cYAXEKwoWkj4iyG
	 dwe1L4SAmtJ3aXO/jugMGaZDDdzKGz6VZmh9WjtbhPzXN59j+m/mTXhwyFY+cFg5/9/GT
	 vtJRMuoO41cFQl74PGq6Az6aShU4cPM4/SerxY4AAfFT0m2p4ugp5tmNVcFHJzHEN3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391664;
	bh=02tSLe8wvSkKqu81Ml5g3FDyacmww+tyiiXNeR7T2WE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=smVmGzYvJEdNEq2aGTE6DoOrrt9GwxZCch2AR2Z1qoKoTo0VNTeW2XnD+T5g2mLEA
	 kJYFNCirblgi5+KhAsKdXgzL+IZfP89LONASzCu6DQnhQExKJ7NwsrCh5PzCLyDeao
	 /1mrULdEbpTMj+Ylki9FNdRINFxqJn+yiWiwqc1LIpIiQuwUihEFyp0VRwPuz9jf0P
	 0VRyOYq6qKxHDsDy9mCp58KMtAT8b2iaJeUo88t8K8TNx366Z4sGX6XFGTWSk5D9/P
	 2ppuj8qsn3ysm++x7jauzqjA1UV6k5m1ysiJO0LrYIESL3hxok58byHHJ+L7SUKDS+
	 NYenCNgbNa9dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 533EB80D35;
	Sun, 22 Nov 2026 23:54:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B2759392
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A408D403F0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lpFehAgYDsR2 for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DBDF40198
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.9;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=krG8iDcK; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=DB66uN29
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DBDF40198
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=02tSLe8wvSkKqu81Ml5g3FDyacmww+tyiiXNeR7T2WE=; b=krG8iDcKdcuNjyv6gvwHtm3cS/
 pDoIukkduN+EQqvbw9xGSfCDBTx7be0O01VvYlULX0S30G8eds3kUeCU/QBOuR9STuZq+jsfzEYq7
 IFoiCWyI6LxQDcFxK/1bU7SeWz39Pvs/Jq0XfYCY1fz7wXl5tkgDA46Oh9YCeuVIdaM4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNw-0000000B2Yi-0mXU
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=02tSLe8wvSkKqu81Ml5g3FDyacmww+tyiiXNeR7T2WE=; b=DB66uN29/lCd5SOPyGb/1g/Ucg
 sTWDvoe1zmGJQCNJXI4NEBCZUU3Tho9fLaxzO7APyL8s76WiaDEH13A4DCel4wcPWdBfmBw3PXi3g
 j4cI0z5KnX0Y11xefYDFcakNS7RcfItqqGpbD/VACUPoZuemYeNkZH2+lZAXWFBZ+x2U=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNr-000000005H0-1giW; Sun, 22 Nov 2026 23:54:11 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 23 Nov 2026 00:54:04 +0100
Subject: [PATCH 1/6] arm: dts: k3-am67a-r5: Fix DM2TIFS secproxy thread ID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-am67a-ethernet-boot-v1-1-94520ed74c90@valla.it>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=francesco@valla.it;
 h=from:subject:message-id; bh=KEVJDLsN0+loT7Odv7gLm7iL2fuFx21vbtRcR/wgy5A=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDQuNV6sGMk2c8scinsuzt/PberUbyjaBzq91GLjqh
 OKrY+07SlkYxLgYZMUUWULW3bi3Z675t7QNjI9g5rAygQxh4OIUgIl4rmBk+Hu0z1FocfPZixsX
 9D/7VXN+9vIOJX3vA2yFhREB5dsavRgZpve3qiT1npYTkis4tpprodWUpvdLFWpuuew4pNt4+3w
 2LwA=
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
X-SGantispam-id: 66d44bf81c1a4a89c095cd30fbb80b3b
X-AntiAbuse: ID - 66d44bf81c1a4a89c095cd30fbb80b3b
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNw-0000000B2Yi-0mXU-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; 
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

The DM2TIFS secure proxy threads for the AM67A R5F are 28/29, as already
fixed for the J722S EVM in commit e25900438256
("arm: dts: k3-j722s-r5-evm: Fix DM2TIFS secproxy thread ID"), following
the TISCI documentation:
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j722s/sec_proxy.html

This went unnoticed because nothing in the BeagleY-AI R5 SPL used the
dm_tifs channel until now.

Fixes: b27c94958b97 ("board: beagle: Add support for BeagleY-AI")
Signed-off-by: Francesco Valla <francesco@valla.it>
---
 arch/arm/dts/k3-am67a-r5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am67a-r5.dtsi b/arch/arm/dts/k3-am67a-r5.dtsi
index 48bd15f480fc..22471badd321 100644
--- a/arch/arm/dts/k3-am67a-r5.dtsi
+++ b/arch/arm/dts/k3-am67a-r5.dtsi
@@ -33,8 +33,8 @@
 		ti,host-id = <36>;
 		ti,secure-host;
 		mbox-names = "rx", "tx";
-		mboxes= <&secure_proxy_main 22>,
-			<&secure_proxy_main 23>;
+		mboxes= <&secure_proxy_main 28>,
+			<&secure_proxy_main 29>;
 		bootph-all;
 	};
 };

-- 
2.56.1

