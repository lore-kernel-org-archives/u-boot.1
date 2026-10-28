Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39352606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y/avAUhG;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=QNpeM0S5;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=R0sTn7ib
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F30D980E4C;
	Wed, 28 Oct 2026 10:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TKR_eFmICsj4; Wed, 28 Oct 2026 10:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0453280E50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183497;
	b=qDme/1u1SRTzIFhlVK8ctpsybP3+4w8ujC4wP4vSbcQE1RiKg9beeLh/k91UIzha5p6g
	 G5ZkG8b9oVSf+4udKbVGhq4K3rdVm03sIv5A4IYG2PdetT8YU/Uh1UQJTO++48SYw77XD
	 gnyvIsWnwb/bxadyn3EARGiHZJcSOWax9mBnziWAvgxo65SXFiYs9iZyerrBdlVzp9mZU
	 CJy8SjS6jLcONdxMGSL11f7iNQGDDHyTThwEEZQfOJ4hvroEzZh7amLgAjQGmCkuQMFtX
	 cYmsPUwHPRu3JyANUO9B1yOoiO7pfTaxXwje4qOMsavSvjASNZ8y76EIoVsj+UAQmiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p2Agaok/xZFn7DUpmVURNCBNvKAk/mHxUiTBE/MHi8U=;
	b=FDkHpgctLJ3tc9I6Z44PQO583niHVRYIqtAOOM+PTrGnWEafdoeOBgJ9NEip21rDehcO
	 2GOpzyu7NY+Oz5XV669ZAp6Qgojt7MxxnV3OPsyBYLyP2O0JIgbOACeflXovwODKx6Ume
	 I8TOz9DFLL/YPgYsyFbhQn+To5XJqsry+QENv1m4YeV3L14lGOWaU8i2NzssHEOj0Fa76
	 XnqK7AUcX2027WCEpSc3o6YC5n/cLnwY/D/E4BMNYxoCvX6R/oqJpII6M/8iPoon6Jy7N
	 ml0E2GSSRR4pf/Sny1z3OCrrIl3qbaBmQAGTbSNWdhdlM6e8VBOdRH5BVCa3smvLvRQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=QNpeM0S5;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=R0sTn7ib;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183497;
	bh=p2Agaok/xZFn7DUpmVURNCBNvKAk/mHxUiTBE/MHi8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y/avAUhG8rQoCtFwg+wif93dWm2orfpeGBxbc997yK/txy0Q/rnMG3ldW3skNmQZP
	 117Cr4uYI0QqcpvXCO3iq9AE8aq96KkhM38i2R0utzUkIriVmzJP+i2YMIJCvRc8V7
	 frQrt29fiIHc9eeQuNYmEQp2WlzR4ecG7tetIqzMHxw5kuP2Gc52BrIqexY+IHr0wQ
	 6UmbqqXSc4Y4EEQhiU0+5zo/O8BW/qFBWTCgmFFcoI8k/O56gqFK8N3dKW8VqGMcQp
	 FJJSJSQ+Shr5q/NIZMgh2Ao1j7m9Ee3e+W9E/ltm1PfEYtB3/u5sdC83g/l7x3zSvd
	 WRI9zmH2y2Pzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0453280E50;
	Wed, 28 Oct 2026 10:31:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FC4F972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 816BF80DAB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8y3sJONpOhpq for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D86F580CCC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183493;
 b=ibBlq20/wHm6Vu+U7mQAPx/kNGb3k2sfP7FVSHW5hoVHqmRwKnqy9HeAfkU0lHeaAq1V
 Ri5SXSz2A1Srx8QYkjJDGCwmmBJYStDKEiNBgE0D3NEHqgurF4A6RW0yJ2J+Cp4shVVZu
 iQdMSdgqE/LCrlNZtfOOGMiLzrgye8NW3l0tdGvXz/Ddjh+dbmhXLaPzBoP7hZztj/TFX
 NYztj5qHsLzhT9vbNpqJSxL9eRnU9i40v2XBBGoqrTYe2T5XdhtT8o1HyyU8nqHi+BWiV
 hZpyS12h4Llw85ar8/LywRzF6C5yzwzwsaZ+z6xcQ9cIdbzwJQUzi8S9my85MU91XHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183493;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=p2Agaok/xZFn7DUpmVURNCBNvKAk/mHxUiTBE/MHi8U=;
 b=FJFCU5lFU0OUjY8Ofbs9hs2jBXuNN3Iv9YJKrBFk0Azrmhv7/FDNP9v4FA0GOxamtDer
 6AztXJQB8eynG1nFu5ZLJM4t0bfDDGrt0L7FR/DT2U2K3tPASkUxSQSpqBh43ThkOSx8s
 2TmGP4z8FzE83lcJR5tUfWJh88PSwRYMZBDrB5kJAMIDv+kL8mJrZCHUD1D/rfgrkihmI
 im3yeG76sPvXzLz+WdE19rqR8xooFcvWBd5NBsI3i17xUYjz4teKg9MpBnWhOQkZAlT4P
 LGnntGtV+G07xrPlxw1OSiODrQZd2a1CvBhrAnSX6ryNV6c6kdo7DG/4bV7xaCA/KEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=QNpeM0S5; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=R0sTn7ib; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=QNpeM0S5; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=R0sTn7ib
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D86F580CCC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183486;
 x=1793788286; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=p2Agaok/xZFn7DUpmVURNCBNvKAk/mHxUiTBE/MHi8U=;
 b=QNpeM0S5YjJfxC00MRBLna4x/QUsgXdE1f50FQWLIQQFlzWJ31t8/dsCXUTQCU4s90qq08PHzvjIl
 VApK93JlGc+ixTM/G2XAkG9I5/867ZD9Q1GnF83p78UEocKpGOLAYqdqJYXQG4nu9KJZhAqswWu0b1
 JESZL2XVvvXQS4o2GUYxrpI/CL33n+8hHYVBShhWJ/RrGypnjamzH7YoUo6vhdeSg0bQrTYov4CHq8
 sIxfaVv9/9BhDyEhAem4wPnLRtGtLOfwjW9CnNtkun6LvdmS0RdDtXzZfgrKa5H0jHzLMvjGzn/ykL
 IOTdvcGDv12PW/BkBbi5Pa0RxHPqwdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183486;
 x=1793788286; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=p2Agaok/xZFn7DUpmVURNCBNvKAk/mHxUiTBE/MHi8U=;
 b=R0sTn7ibdP2V4X3BbCWvndKwLFXv4//FqiJWgRPl9UriiHzU7tSOvopPqcmGfCVxvcv0XzDOkPOmQ
 I05W7uXAQ==
X-HalOne-ID: ba0ae1aa-d2ba-11f1-9e44-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id ba0ae1aa-d2ba-11f1-9e44-5b5978544972;
 Wed, 28 Oct 2026 10:31:25 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 2/6] lib: ecdsa: Remove outdated key lookup comments
Date: Wed, 28 Oct 2026 11:30:58 +0100
Message-ID: <20261028103102.414657-3-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The signer already uses key-name-hint to find keys in the key directory.
Remove comments that describe the old lookup behavior.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Add Simon Glass's Reviewed-by.

 lib/ecdsa/ecdsa-libcrypto.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index a8e6b8f4c6f..402c49cf61c 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -8,12 +8,6 @@
  * Deviations from behavior of RSA equivalent:
  *  - Verification uses private key. This is not technically required, but a
  *    limitation on how clumsy the openssl API is to use.
- *  - Handling of keys and key paths:
- *    - The '-K' key directory option must contain path to the key file,
- *      instead of the key directory.
- *    - No assumptions are made about the file extension of the key
- *    - The 'key-name-hint' property is only used for naming devicetree nodes,
- *      but is not used for looking up keys on the filesystem.
  *
  * Copyright (c) 2020,2021, Alexandru Gagniuc <mr.nuke.me@gmail.com>
  */
-- 
2.53.0

