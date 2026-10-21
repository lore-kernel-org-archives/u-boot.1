Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9AB606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z1mxo9g4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9780811DE;
	Wed, 21 Oct 2026 14:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5z4BA-hIuya; Wed, 21 Oct 2026 14:09:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 14B60811D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792591788;
	b=NwGJFRW36lc8StvjcH/IE5dueub8QECJCoAV9ee54ExmqeFYKHPH4//HVKPa03cBLYVe
	 Zsjmvn8kVlaECDnXDGDH1vwa/DNK38eZdn0hjLyt2Y15sBd2yj9KNiYFJKuEtpJquBOis
	 2Sz5QjoZtEDJngUVLRpLOFHThStUKX8JVc8j3DkCa/YxSS7lC6G1hxDOR34/3IT4nQa+2
	 h1GCvTEsIsYQ8zwHZoTdR7t2I8B3ThVNrAwiYCadaGNu2WnvROSAqzmWL89fZneNy6aXt
	 MqYXb3f0OMpJAOf597pWS3vHq8MHcMk5PBxkIGdnKSPvZ9dcNIZaQXwFY8RTyO4AKiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792591788;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iDAWHfx4pH0g64DXIManPDnHjBcyZ5ouagdT5qQ7NC0=;
	b=WxA1busUS5EvhY1XxXzGIbcRfkPV5gGIo/PrjdruWSpDZl38Fzxz3ZbE+Op7/e72sT3g
	 M+21bfn+DclJiX1uj4vQJwnLhQHsRlOxfVp1AN0JmOsEBW5xCpvjX+YQPJpI7surTcbnN
	 nBfbWuZLfmV2V7CdF0V6WyNiQ3zAo7icJzvn+kBNpP4bGb8/nkq2+ZLWaZCo7YBERDY3O
	 Hzsa/69zoH0ohk9L2jHgfltdJ5GbrMLR5yP4CrNn/TYHW5FP8cQxtlA2siiD3+IiCGoK3
	 Whg1NwZ2XnIDefgw0jI+BbCHec69rADmTxEXf5Pefi/JdpenTeAa33pR2r5muwf2QYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792591788;
	bh=iDAWHfx4pH0g64DXIManPDnHjBcyZ5ouagdT5qQ7NC0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z1mxo9g4AnqOXCSl2Bqoc69ihuJ+DH5WDjLjs4SNpsUgP3AFLWoLh/uh1KW+eWVJY
	 1mrMWMurEXfnJLmn8uuDos8b7MGPbnqo9NTYapq7J8LMQoB/TaaEMRoZbgqRkv/qQR
	 iwScwxE5zriPmTQEtqpDthZ4BuAapv8oxd3IXimAe4x5xywEd3ntwHB5lOzEtaaO9U
	 8AB+wkhQcCTd9OzM2GSYLp1vsPqtiAS4iKcLNGfjWoZccJag/mFG8KqKx9Aj90QPVM
	 /5IKCT59BWz+Q9I4WoYx+ejCldy2LvbNwuN/IuVSYneLuPNVioqW8DjMR71VfzLA9/
	 PmUmfRjTOFrKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14B60811D9;
	Wed, 21 Oct 2026 14:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 17B751E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1586F403B9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jzIhuzPWwj25 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:09:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3777B4039F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792591786;
 b=ViJaCsth/p8G3K3NE8Y31tOA7B5ZirFHF0vgu5TR0wzP6wPoT7hkcI40A8zEZcxt2Sii
 T1qlZ45nLtk0s5s6t28Jr5LMclksrIYRnn8Ipl/LtyFIlYkURRIkOQY37LRzwK5aop/aB
 sUZaiqg0wMQbg0vWA5njPiHxdp1aj15dE5c7Z0NkUqzuEEMJwraDnPB/p9aaL4QM7b1OP
 bktSMw9BpgpNaH387EuKlo9504lRexLhU1P3ouL1kbA/Tj8hdn1aWzPIE9BHsXvgD4hRv
 3FhNgCuEG6tbMWfthwDNCxGakOf12l5nbK4cAUf8QRRT1vwRljYAjIxfEMFBaBW1YnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792591786;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=iDAWHfx4pH0g64DXIManPDnHjBcyZ5ouagdT5qQ7NC0=;
 b=Q1z74xn4SpngGOmeTfWxQZ+HWcWUxlJWdrjZNVYfq10rrNO4yqrwIs9LZzTW5MqzVVhX
 DySwna0uz+dAZGIKDAv2H3xF6ewpqYDvzwNK3rjaYap7xTT5e/+ngyyPITn+g0fVTkPpo
 fwCr0urloYvEKKIctAZ1d9rVbgqEKUpFjRWSxab3+eGq24q+7HrZi1STWwEuJh6FtG5P5
 y43LAlUBKKJ/1aeIGkBkmD2/5wlVZbHaevGr48zZJPUupMm2V89isWiklG9LcA0JlBf7y
 j2r8Bld1g/ysWuwI0lNLSbw3U5P8PDNQ6hd2JKDa2Hi/0GzwU+y3A/74o4ot4pIPopg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3777B4039F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:09:45 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xJWxZ-0000000026C-0WjK;
 Wed, 21 Oct 2026 14:09:42 +0000
Date: Wed, 21 Oct 2026 15:09:40 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Anton Ivanov <anton@binarly.io>, Vincent Jardin <vjardin@free.fr>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v2 06/11] doc: develop: sort the imagemap index entry
Message-ID: <e89ae89ad03d99bb3b98ed7428ba526536185be3.1792591479.git.daniel@makrotopia.org>
References: <cover.1792591479.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1792591479.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The imagemap entry sits between bloblist and bootstd/index, where the
surrounding list is alphabetical.

Move it after global_data.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: No changes since v1.

 doc/develop/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 3b4cc2e28a7..cb172b66b12 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -31,7 +31,6 @@ Implementation
 
    directories
    bloblist
-   imagemap
    bootstd/index
    ci_testing
    commands
@@ -46,6 +45,7 @@ Implementation
    cedit
    event
    global_data
+   imagemap
    lmb
    logging
    makefiles
-- 
2.56.0
