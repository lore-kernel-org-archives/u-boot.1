Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F8606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h1ec2KQe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E75680E3F;
	Sat, 31 Oct 2026 11:11:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KEU250qjxEjZ; Sat, 31 Oct 2026 11:11:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0AF3810DD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793445071;
	b=iGPVtj2RHWknYk5S6G0Ezu215z+JV6oKtThuWVurdqPQdRodU3tWY/HQUB58237X6wxI
	 oeezftwby3eSZ+JH4FgyhPKtkXH1mwMXsjQitG7uvpWW5+YLyTNKnBUC5eiEtMGR4AytC
	 pLz3TGa9J3eZAY91dOa+BOcUd5QsZqzx/iG2jT3zYkX4EfE38lzThAw+m78lQbprmygQE
	 v73bGxVTBIqrYWS5ue0qwdpPYJ/3SVZgJX9LhlcYvHIlEIdBroiPaW5nAnBuY7xkLttVf
	 PHqy2LvVVp8iO/bfx/ugL3OOY6lqmqjkf0eCKq1NxfEJ9DuyuSOVj7T2mpck7mtAnqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793445071;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wml+RdI42fiUr2YsEHwpCB5nD9d9y4/mQlwWndM9+4A=;
	b=rwcZsnQoFSI2D1gucm/yIRo0Mkgzx6Qq4xJSiE9DIu+NtPJHO3pO8YeoJPl/v1yZHRil
	 W0WjUdHeEXS9VRkRHj3y9sF33uzQQ13B9aJoJGb9ZDg5RglymNnodtS/2N4KTqDu2lSE6
	 LEC6geIFtZGg3jof9h3zW3csVSJhvqMJqP6D/3UF6Gn7QOKt6DfBtm2r6lyUhplD+TfpS
	 1EcqDKHdP15wyq7ZAFuL+QBZX3oeTBnDqlnoQiw55MVjKUgN31+2tyuAvRgYZByBJdbe2
	 g6lbsYd+hPpCDgj804OlpgnY8swfFH8us1aCmV85c2d0/LMSO08W1RXvF0awMhJC7TQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793445071;
	bh=wml+RdI42fiUr2YsEHwpCB5nD9d9y4/mQlwWndM9+4A=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h1ec2KQe/KvRAdGW4hAHdRlwneZZ7Jr/sUCYNztqCqwuef+rFIeF47r7Fc0unMhTU
	 oALcUZ5hd0+khwAwJ+2NcTObUqFhxrOlLI9luCmu4AeYCCK7dnqVzw6q1i6VyAqJ2g
	 4J45ws7Kx+oJrj5N81IOPTKMWpo019enOKbHig0gw6DTYTj/6Mc8iO1L85cZoXTrbT
	 OBwQC2IcUoD9M0S6uNqvTYDwismGf4mYpMX66MYO4RTQh6C+niDGXzjclzsPMKs/rO
	 4hC8GpzLz4F8XWds85MTj8S2uoObm1ODP7bDnDpwkMsevWadQyWHvUQT0uyEHy8VMY
	 j5bUfXZ5zlPNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0AF3810DD;
	Sat, 31 Oct 2026 11:11:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EDF4473
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 407AA810DD
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abOqn7lIt212 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 11:11:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DFF880E3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793445069;
 b=ags+pwAnhflYyFCcO9kcuk1ROkzNJC6WDMMSRXdDmR0CLGh6bId2WsTSEDIVJm43dwcf
 TDcYiT9z0JDIO6+XnHNg7CYI+eOj9tZ8+2FiXxeu7QrzYbwCXpCt1QhjN0t3NARpghlsO
 W0DTMaEaYR3RvsN8HYaxFa69fl/IxObLJV6PZnEUTtI+chDj4CVmZ1vDny29M7+v1G2Ie
 yP+3ApozzbN80x6/HeGdYizuTMfPwTpbGbYl+2CnDMkgRwSVKk2gI0A/wndU9Qs46llp6
 oa9BXmRJ7zL663z99kOlQNkVSnD/yK/lRYrCkKqJQWK37Vzm7KRlwUh1hLDz1s1XiVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793445069;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=wml+RdI42fiUr2YsEHwpCB5nD9d9y4/mQlwWndM9+4A=;
 b=KQBIrJESsskM0gc8uGJpuIG2mJUeVS1Vm6LWOedOTP2D20DMDQiVU8BMiP1OvNfisDZz
 DRN39u2kqD9Cvbtj/7uxnyFKd2ElqjOEMdN7Gtjd/rXXciYnV5UfGkiETuAH1wLoIcEx/
 tFWHQ2jkWM79RjUHjZugrs3+36tNrYTpZuPXgqUh/FNTSLYzrDd7BVqCCuqd4IH/KtEkM
 WuHHRHyb48Ay0B+NVAnTsHNKra8zyWBtfvJBQoMyJjxjgKPc2KG8x/QMNQZooG1UJsnqX
 8O/wQzmm+UhS6bJtklyOijHJ1ScyGifgr8UEVOHH9W9UT4Rq/meg3WpC02CfNcsr1cQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DFF880E3F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 11:11:09 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xN6wC-000000003P8-2NZi;
 Sat, 31 Oct 2026 11:11:06 +0000
Date: Sat, 31 Oct 2026 11:11:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH v3 06/11] doc: develop: sort the imagemap index entry
Message-ID: <f0de192bbc7f2f190611c396265b9da98b7cb1be.1793384548.git.daniel@makrotopia.org>
References: <cover.1793384548.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793384548.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The imagemap entry sits between bloblist and bootstd/index, where the
surrounding list is alphabetical.

Move it after global_data.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: No changes since v1.
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
