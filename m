Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6B8CC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D6E080DB9;
	Wed, 14 Oct 2026 08:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46fdj7Y6llJm; Wed, 14 Oct 2026 08:39:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5909F80AA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967176;
	b=gdxJDlXF7Wthbr2n/2GozandNmvzH7YgZRe2KgJSgO4mE2dKePS3iE9jSRdPARxWidfB
	 qs8d5acyQ0zpXSrFGynvBJmCK4Chxis/i7ivO8/v+oHYcMIZAKv+xWoWJ3waSUD7Z3AO3
	 wR3AOAWaCv8X8tnFDA1/B7q3SSCICciRxR9UNCT5S7q1xl2iue17Aio4CWMWjHl1HxBpy
	 NedPSE1SFGmnb+oALGWXUR7BMBm7RUVTPsKNyVefREeBnZNqvbuQ9GzWt4YwkHi+5j75B
	 +MN0qnzmg23p3ap/az3ewysKG7lfXJ0KnHdAgq1EDJKre163rvzHLeQwtZq5tQHzgCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2o/6OPw+zyGYSrFRUbDTeuX9aiY/0H1BoHTPDUplLPw=;
	b=XslJRcWPKiuojGxLBlc2LpMhi0DPArJbqdDn3iE/NWjNh3c69+krsa1op+liBTRL9b8g
	 SC25Yw5/pfyG2EluPNz/GPPbsBFLNkwluLV8598GBWgpA5EpMzv8w519qqfH9fp9q/Tpi
	 /LuP0bZgzuTmN+utE/+EisqFbVhdVdxqMEeKZRRO/IkRC2csUiF5zV7sE9xzU/HKcY8HT
	 KZyQbh1jtJ38H698K7KQ2T7ZFs5SY0EMPdhYkzSpIkvegNH7kRdIRDohZLpS/yYLN+59J
	 aXyfG2v+YVe/Hp2OlxmuFAFjy3xj1X+pRXkWlldrfCEiY1OXoVqAcmRUALwlSLsn7DQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=makrotopia.org;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967176;
	bh=2o/6OPw+zyGYSrFRUbDTeuX9aiY/0H1BoHTPDUplLPw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B3AXpI9lfPwyH4YY7SP4jYfVZjB8MWyR36h4YoO+VCC+oI5px5Ma8j6sZB6pPq0R7
	 tnwsOaeISi994nyw+8dMIGrjYzJnRjpxN50dXsjjTBnAe8/CghwtQYuFM8DKamisJ/
	 tDVw4Gx840CYpX77gxvuu5WmGh47R8gVzjOkaVhMqfof/+LT2jXNR750WbchBPV7B/
	 bgUwDz+St38CmXITJv3W4il3P4PKuqwKCbEsX4cwoBle5iwmyBfBCmhqybSgD8I9sF
	 xMRnBCJA81Qf8byewee1cnXhhenuVJtCpe/LkkBr1n9+x9/XDuUBqumfV+gxqPwyvv
	 pQ1NTj2HAlVFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5909F80AA2;
	Wed, 14 Oct 2026 08:39:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C03DC235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5E7F80A86
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVevb8SM_I5X for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:39:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E32E80AA2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967175;
 b=R7ZLWXuS+SBTuXvpP82TuyrU5WnGZR4MVoUYNXVY3kljxk2GdcXrQg1dL+H0eFr8f3rF
 PVQqsWu4xPFH2wyoWlFSRsOr2zHwph5j9yvn8aNcfRiVBxV6KN4lX3rBZRk7zZig7gn8/
 TUS30xxkvBp1Jtnmx4GYRJnfgkc1/nk2jTYKUkwAimzgwj9cGjSdxbW0u7yO157Yt6jWZ
 lcreUvdozXOtP/vRlOcWJcIZev/VbVG0luAhIyZeqjhkIL4E8vZH9V60lepQuXVWaJ+2j
 Rb+rTPnc4qEbDqeDsyF9Luv9PRPhHh4luR52W0D+LSKP1Eb0WQh2bDiRRZ9RzXgwq6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967175;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=2o/6OPw+zyGYSrFRUbDTeuX9aiY/0H1BoHTPDUplLPw=;
 b=iy8RVYWdQ+vxmwltVGrft/IYl1j779S0Ut8U77wa//phENK7hNsAG8RTLquZ0pfkidg8
 kaKyt+5k6ynyZFR1NUK+MRAhq7+wdWXLXWd0PqyrufNCEYOi/hS9O8P/347Qn4XOkQTM5
 DzoOlnYzZLiDDP1sP7NcYTqrri3e47lxrazgrWcZTTAnfWwOCmOSWOqsoJ0naaBqpwnI8
 GAzJMtZ5P7oWhpdB4achpaaQ46k2c0wqa90DAYSGNtWa8LGd9e97HvgnGFKWmKt0ht9e4
 va61oqV03eQpP7z4bMqedR5oDmKGPkfhK3yHd/W93u6vNYGETlcnou9iaPejq4J/JPA==
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
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E32E80AA2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:39:34 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuWJ-000000005dL-1pwk;
 Wed, 14 Oct 2026 08:39:31 +0000
Date: Wed, 14 Oct 2026 09:39:28 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 06/11] doc: develop: sort the imagemap index entry
Message-ID: <a31012076023af2162824f03a53820d947cc715d.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The imagemap entry sits between bloblist and bootstd/index, where the
surrounding list is alphabetical.

Move it after global_data.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
