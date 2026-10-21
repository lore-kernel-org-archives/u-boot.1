Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29448606A325
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=knWpN7VU;
	dkim=temperror header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=XNz4yLha;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=XoTepEZD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 155CF8104D;
	Wed, 21 Oct 2026 10:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ja9NrqcZwFf1; Wed, 21 Oct 2026 10:26:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5F97380F35
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578403;
	b=Z3izmKsJcPDEIsJDloDHNQxJJSx4ZiYEHmP4Pbcy23HA4WW+Uam2bEGHt9b+pGbL9E28
	 IKUF3R6tNxqtZDY2Pblq1O0OqbvlpY4bC3b7IBTClTbAeeKrvJ0FD4k4VpzZ3S9EZpnZO
	 ODg3t7z3pRIvca20c69HIb0PgaTvsX8wAbHIYPVAxJHm1R6kSAnlG1yRCvK9HzJ79MBvU
	 GoURcuWx1tj/TqY9Xstca03QPviO8L/ZkzuUIDt1loEhDHZwhECRWP/evt1kji7cWqFS4
	 oyizt/KjhOMqwAQJ5LLzNaghTuBZ3FPb7KVsn0XBm0VR93UUWCEJ+O+7z1tYxjss/KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=h5EsdlLaxiYGbhJLQXRHytutZlS8iD2ZLmcJibsdp5A=;
	b=sXV65yTN0yCjvBm/eUsDCn4+IencVYECknHGaJHXG+4/Fn+fh+6NrinrKYfDI1QtiME4
	 AuxXMV6IXa+YJC2eqx9Zt/Ys+cQMliM9/5JuSPw8ziT/0jd1HJg+9DJ9dE+xWO7wq5m3m
	 BKugcKfKDWFfNaEom/ZBmaMm3xRzFNNw2Wo9rhdwP0yQt9RpG1snZsrzqWLkYZoN4epMH
	 WX3qLw0xZBmHU7PmdWxP69HTzNr/oBRMU14HZE+0WuHshOF9SUFYYSm7EHUOASzkpvwDZ
	 33ysRsFe8t6dDW27IgpQV05w/ikYtwjHZmOTiyGa7F0b7kT+ewkU/F+dL7UraMeTHtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=XNz4yLha;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=XoTepEZD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578403;
	bh=h5EsdlLaxiYGbhJLQXRHytutZlS8iD2ZLmcJibsdp5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=knWpN7VUb/pBu3jbs3Vq4ONmv8unwtKNQ64IQv4cARe1W66LdoVKVEr/eXlnmaK9R
	 wDhkrTa4BBH1b7o6gje+8qnBLnQGPJE+XvfKx6zgvFLLOJSipGVbakVmcUmhSddxLi
	 Quh6LkOnnzU9OVoA7qDEt3bYcLeEcPvZA9B6odp4bjGU1uG4krQ6tekC6xmOKlN8mI
	 5jSOwVRlPHeS7S4NnINIFIVsaZkLb3bTl6Kc8MR+vpYqQ7lromolbtZRNQG6TfGzqf
	 bn9vjm49b1vlgvHBdQa3hTt/HNW/mohDzEj4+fqRuICKhICNseMa53bXSZUxZ4X8BP
	 MVJkEQ9KsFpZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F97380F35;
	Wed, 21 Oct 2026 10:26:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DC961E50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEB5880D9C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yw3keGgYGb2U for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6D4E8100D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792578398;
 b=bzJVCYpdbX1iZfJbMRvUFo1YXmNre85Y9gRDGU91FSKRk9xyQ0g1jGlnFqJCsQItrBSX
 6YYXyG+/yCqqvB+p7uGJws8kvQhuIsGXOWc1RzDACPidXGG0mUrtY7hLlUBa/XVvWTEkI
 L0sEKBqx5tMnw0bOX7nefygbVrzZVNhPlNGOSYm4ZX4hUSa0ZTGlkip2KpUHdq9dtlXUt
 GON57Mv75okryqOHmu85+o3Qm4pxYVimfJl7WygtlyrnzKxgRWY8kNP8wCgWmef6qLU16
 hcqPIiAKyWvMdSau+pgK8bntOBKzamSBxWYivnp+gub+pKNR/Ny2kfo7SJDMvrDRIlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578398;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=h5EsdlLaxiYGbhJLQXRHytutZlS8iD2ZLmcJibsdp5A=;
 b=BmZQ6nod0XMW2C+1yici5mqPsHomrZRUqv8tgHkPADdcA6nujNTsnTDL9jZujTgaOjDh
 apSIFdlI0N8eNnpjTvWRumHCavpdTOiZ4OIAbSxEQrSBKxu6k1LwSWIQJ9bGCCUH/i3ND
 9lll3JRmcUWJzhcTZB65duZiqcpHnrmZAJI4QUFkotYk6p8pT/YsR/BOwoQUQ8MmJzBZR
 vBRD34EfX8c3eXnXJ86PKvDxfEbjbT6GIemjZb/IE9eipy+018iOruFIAy26z7G65MgrB
 Bt/45/0pNWGmG0YgXLI3fUPSsEs2Jw5CsCokXGtqalgUtNupP3GrwiJygX2eBEkyudw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=XNz4yLha; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=XoTepEZD; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=XNz4yLha; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=XoTepEZD
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6D4E8100D
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792578393;
 x=1793183193; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=h5EsdlLaxiYGbhJLQXRHytutZlS8iD2ZLmcJibsdp5A=;
 b=XNz4yLhaR0l5IIRD9MsV4hot/uPUoG1ROSh1V8moLgdYPo0xx1OJ15qfyikxHVtQexLLYMiJp1hyR
 2zB6lL5fTcQA01FpyQRoussdG/kLcYQ2teeIx9Q83h1socjYpzU4rVS6pwc0FcKKi2I4awsh0WGoRp
 4jbE2fwXLq9I8nJ45Q58eTOHuR/kUCsDbW7+dvi0i3mFaMvR/wg3phMArA+sv3eQDA1kfLmIftVAcT
 LnotthDc/OMvrT/yyKWfh+Z0rUgn1NPgFOEwinOFITzJMD0fzPGA8Vyvejstfh1Jk0uPhR8DrnC17E
 97mspjxCzUx4dG2wjoyuV/jHwaXuOTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792578393;
 x=1793183193; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:from;
 bh=h5EsdlLaxiYGbhJLQXRHytutZlS8iD2ZLmcJibsdp5A=;
 b=XoTepEZDjtcza2iv1QLR8gym1pa50pa1ka8yD1/JLwY5GZc1bIvaZHzunjPQENkvVcoIvKc/cLD0q
 7wohztoCQ==
X-HalOne-ID: e1fa4571-cd39-11f1-8915-33fc7c51c1c8
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-7f8e-6877-ce5b-5167.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:7f8e:6877:ce5b:5167])
 by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id e1fa4571-cd39-11f1-8915-33fc7c51c1c8;
 Wed, 21 Oct 2026 10:26:32 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>, E Shattow <e@freeshell.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/5] doc: fit: Document private key filename fallbacks
Date: Wed, 21 Oct 2026 12:26:26 +0200
Message-ID: <20261021102626.264091-6-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
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

Document RSA and ECDSA private key filename preferences and fallback
behavior in the FIT guide and mkimage manual.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 doc/mkimage.1               | 3 +++
 doc/usage/fit/signature.rst | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 9a2d07cee75..6dd241366c8 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -392,6 +392,9 @@ necessary when embedding it into another device tree using
 .BR \-K .
 .I name
 is the value of the signature node's \(oqkey-name-hint\(cq property.
+RSA prefers the .key extension and ECDSA prefers .pem. If the preferred
+private key file does not exist, mkimage tries the other extension.
+Both files contain PEM-encoded private keys.
 .
 .TP
 .BI \-G " key-file"
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index da08cc75c3a..bcfb6b24340 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -497,9 +497,10 @@ the path to a file containing the signing key.
 
 The alternative is to pass the 'keydir' argument. In this case the filename of
 the key is derived from the 'keydir' and the "key-name-hint" property in the
-FIT. In this case the "key-name-hint" property is mandatory, and the key must
-exist in "<keydir>/<key-name-hint>.<ext>" Here the extension "ext" is
-specific to the signing algorithm.
+FIT. The "key-name-hint" property is mandatory. mkimage first tries
+``<keydir>/<key-name-hint>.key`` for RSA or
+``<keydir>/<key-name-hint>.pem`` for ECDSA. If that file does not exist,
+it tries the other extension. Both files contain PEM-encoded private keys.
 
 
 Hardware Signing with PKCS#11 or with HSM
-- 
2.53.0

