Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABC0606A31A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cBOlLmiS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=ZsZHfRd0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=pQCyJOmm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D197B80D30;
	Sun, 22 Nov 2026 23:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0LkmSFqinu-Y; Sun, 22 Nov 2026 23:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2129980BBE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795391675;
	b=VXILU54Q72B9Dd8AF+9Brf8daXyCeRjvrty/2tAe0rgeXxtSXnp/D3MuoEBfNuWuI1Tf
	 cOhs14/wBLCGBkqMMJC0WsFyBBDy5lKzjgO/G4Rz6xqZ1NoukCKcHfWMielrf3l9Q4m6M
	 S+HubF6rw32dLvxovONrRu0C+U8aTh2cKfEwATqvvSnv43pmGB4BK1YoO7/B0aKqQVy02
	 bve2iA0SELd0nUUkEusUiwDUOYMkwPdZyn5c0I1RUvjQuY7QrwgU9/2zMlMrj31wn4n2I
	 Aep/JORYVPoi3BHTZY6Gmjsx7eAwBW8pzdwypTQJRaTG7CcZ8EDGnnFtpD4JGTlyWWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795391675;
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
	bh=+w8TapAdORNVmEQunW0qX4kMIoFuamjoFN62qq+ge48=;
	b=U2LHr3b3ditKfVwRcNOeippCcEhJfjuQtu/nArncFhjfPAmFxjQfKn3rARv9pcU2qZ0n
	 JY8lrkUu9mBRQF1JU5ElomahLVIhwaFng6mHbi8UmBI1l16Hh2LZV4n8B2dDzelQAs0NE
	 xMCo5di5oXRW2EycAGWLG3oT4HPjjB3N3aVBzcqIrOkbw1ST2p1qu3nlAI3ZqSLE9ZDpQ
	 tYnW/eDr+TU4isa3vsh8+h6VUXorTCFYvBLwZUqXsCKgW7h72mnWdP507PRXww1eky9DB
	 5h210eaSt3Fwj19Etv3bKTeFQ9iALyIaEKYZujKtowwXaheGBHVAKBVJFmWlHhJxNPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795391675;
	bh=+w8TapAdORNVmEQunW0qX4kMIoFuamjoFN62qq+ge48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cBOlLmiSz2Dh8CG2cicyfdPEiNaxoYf6BnyiuCCo6Ta6uQmGy78eABOl+SwxHgVND
	 sVjZQuFrm5wSO/i9xoZ3SSz0in9YN4I0aXeLdXTIm6tja9prm86x85ly/RFhrX2lcg
	 L3yLy+/zFkYYWdQRN5r8v59JsTPtqijHL80kwzYV3P9hnc/nuA83syyASO4QiK2InK
	 CoTCVoADtBuXmPxi7oTGoxcOkS3CpDc14HWLpAjdk89AGBsz0ksXqkrG3Co2ePUs3c
	 M0uxHL3A8o2NjaqqLWSGGmA31X+7+eeG38gQgv/Lay1gIRoyDKNdcfZZMIWUcpOUX1
	 NhDKmi4NiaHVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2129980BBE;
	Sun, 22 Nov 2026 23:54:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D337260
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F31F54043C
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KI5NyFEYZjUK for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 23:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E01B0403F0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=185.56.87.0
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.56.87.0;
 helo=delivery.antispam.mailspamprotection.com;
 envelope-from=francesco@valla.it; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com
 header.i=@antispam.mailspamprotection.com header.a=rsa-sha256
 header.s=default header.b=ZsZHfRd0; 
 dkim=pass (1024-bit key,
 unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256
 header.s=default header.b=pQCyJOmm
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.0])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E01B0403F0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
 :Date:From:Reply-To:List-Unsubscribe;
 bh=+w8TapAdORNVmEQunW0qX4kMIoFuamjoFN62qq+ge48=; b=ZsZHfRd0SFI1ZdnUeQ5l/+UEwf
 Ckxuk9O5Spb8+3OA1ZlMidW5MjzdBdbD0NQtZW0vML4uF1e2Ph8SZyD63XB7G/mEYXucZEKU4b7P2
 p4qiPGGbxbmKSSk4GZcHh8yTGYjUSHKH+TgLB9yfqmLadxC2o+BQz8xBBD4OM9PRLybI=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-h034.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <francesco@valla.it>) id 1xVHNy-00000009z5Q-1JYy
 for u-boot@lists.u-boot-project.org; Sun, 22 Nov 2026 23:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Cc:To:Subject:Date:From:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=+w8TapAdORNVmEQunW0qX4kMIoFuamjoFN62qq+ge48=; b=pQCyJOmmiJsAoZf3puhBS9JXa7
 RnxiZ5i6Uw9+dgV6kup3l7lErDcCw/0iMoi8yueCdnAFANNxtOwKTXlBEg2rZx0wBS+5xnKYUQUKw
 ppKq95d73Ain3D7gC2Ru/Utfohb1VVZuVv6jXTRbbgfrHjdyDadOOojDbpk455laldPQ=;
Received: from [79.28.115.6] (port=62562 helo=[192.168.178.175])
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <francesco@valla.it>)
 id 1xVHNt-000000005H0-3e9l; Sun, 22 Nov 2026 23:54:13 +0000
From: Francesco Valla <francesco@valla.it>
Date: Mon, 23 Nov 2026 00:54:09 +0100
Subject: [PATCH 6/6] board: beagley-ai: add network boot targets
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-am67a-ethernet-boot-v1-6-94520ed74c90@valla.it>
References: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
In-Reply-To: <20261123-am67a-ethernet-boot-v1-0-94520ed74c90@valla.it>
To: Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=francesco@valla.it;
 h=from:subject:message-id; bh=eoElidcvWma7zS3R5FxE0NWlB4TEnAhUPBFzrj4oRUw=;
 b=owGbwMvMwCX2aH1OUIzHTgbG02pJDNnMDYtSnyXomXf3/DySvOqWywNb1RnbWi1m3bq2IkMxV
 dhzesu6jlIWBjEuBlkxRZaQdTfu7Zlr/i1tA+MjmDmsTCBDGLg4BWAiAXsZ/srOPaQ/t8Ltp0nn
 rZyms1JGL+Of91+e/Dfpfvw3Jb6TTqUM/1TemYk8fOc5L1A5ZltG3d7bd6Z8+mC/S0VGOd8y2+D
 NTl4A
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
X-SGantispam-id: c88a4aad736f7bf59c5c63b9f937f0af
X-AntiAbuse: ID - c88a4aad736f7bf59c5c63b9f937f0af
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xVHNy-00000009z5Q-1JYy-feedback@antispam.mailspamprotection.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add PXE and DHCP as boot targets for the BeagleY-AI, so that a board
booted via Ethernet can find its OS even without an SD card inserted.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 board/beagle/beagley-ai/beagley-ai.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
index 70afbf9763f9..7e9d8f5fac84 100644
--- a/board/beagle/beagley-ai/beagley-ai.env
+++ b/board/beagle/beagley-ai/beagley-ai.env
@@ -14,7 +14,7 @@ run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 set_led_state_fail_load=led led-0 off
 set_led_state_start_load=led led-0 on
 
-boot_targets=mmc1
+boot_targets=mmc1 pxe dhcp
 bootmeths=script extlinux efi pxe
 boot=mmc
 mmcdev=1

-- 
2.56.1

