Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422D0C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 12:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFD4F6074D;
	Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rhQTJS-p9g7f; Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4895160760
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789476813;
	b=h8U2O3bt+VMWYnZ69q1kQ9ddJMh5T/WOGcTLGYFqfVGpcP2cp2PY65XsDxF9OP3MB9ZA
	 nGoBr2HoNIG0fWgXuUgTG/x1B5nDSwSYRScvfPgJCVZ2x0F8/ovd/xgHCz9kemJ6ke0t7
	 Eu2vfTOA//9/utCut9hSr3KanhslrI0yWYI7PtklR2vLUJsg0d4nAiGHXAWL52fv1wcQm
	 zB6S+RHW8rOlfsPsTZSz11GgtNfnRMPMEmqrWOCf5WnB81k45V+IsDY7U2rvzTrO5T02H
	 4lYXSdiKSOdRmKg4X3Bh60LtKPRRub6HD9/70GKLHcOCNeMBaL3Z7MfwB6BWpgHkPJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476813;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=POXwMJWCLdIjh3Xsi/N8Pfhd5RkczbfS++CgUdJSink=;
	b=ZJkNaFkQDroZFXIdiFXYkF3Aq93XJvWqxMrHoO83/uaqAZV45SdOrAQUVbzgW48EQlcB
	 GaT2qxKV9KEBce9kVgcaCLHCtXHy+JndNmXc3jjct5EUmYrsVJ0N+Pa/g8SsR7gOnBGgK
	 s/fqRty3Ghthrv3XUbuAvXJnBvJ3IHOAAFPUxTPZ+8SPBGNXLYrrn04bxLmPG6IUa4pbI
	 yPm60Ed0mkhDntNYG0/qA8ypE8H1n/AnNKFZShdQmCyG3B9swpqmqlnw0YaYuvhHV9/KX
	 GKR5wC3ZbZOvt1666jeRzfF7fNy9DrZVDfM95TFzcirOxET7qwwDN5SLqQU178Amtkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789476813;
	bh=POXwMJWCLdIjh3Xsi/N8Pfhd5RkczbfS++CgUdJSink=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oWNG+THNWab6AyohfFfbHRYH+FdKPf+8VroOM7vIc6mmi0xN2ZDT3Xvyfl5jsGvXR
	 7JSwkMx9PR1gJlkU25EiNhNUq5W+mOKViDumqAOFscepIXwf9Fggi5yYwKOqUghXjD
	 0N99TDRI6Ga2XCkEvI646AXz4hkn9/J2xeYvX4bC72bVHnXKya1aSszPzWXkUGgo4R
	 xUDqHUs6ltcgxUwJYGrRPpimUaLaFBPRsiecUKSRrWvfYACRnTC9EIPdpOgeXsFU/L
	 1eGVms7RwKl3kcXSDw2413D6R7xNd19Bv71BGzgLlMmbg3aVh6qwkyMEy9pMCQDcwS
	 vIxjbgjRQRvZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4895160760;
	Tue, 15 Sep 2026 12:53:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85B64259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C94C4009D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g6C0QQVPB9AF for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 12:53:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0799C4002B
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476809;
 b=ib8yDLFkU3gjf0w+Bsyh4/jHqGA13enreBW1vr0hRUsfZ1KA/YebcyZ2g42ul1KAKNTD
 hAeNHajxeSjxQ7uoJiJqmF+EKKXQ8p/Wi7ap4pFVlKntM8WIj0zroKeRc/vKU2BcbZsgD
 j5yEHBQ6qD1kEDvRNMijjQl0iWmELYWgsyr/xiON48fnoPiy7LgwL8v53QaE8C3Py8De9
 cAEX37vcLc11ww47XpFu3BLkPaCI+FqCW0kYqMRc3M5PWcqWm+SKjBsCwO7KRP1aqejYW
 6NX/z7I2iT3sXEs3//ye3Xp/ptA8T8KuZbIUFGHTAzYti2x4TYTjXFgVhgdoU4Ohumg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476809;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
 X-Flowmailer-Platform:Feedback-ID:X-Virus-Scanned:X-Virus-Status;
 bh=POXwMJWCLdIjh3Xsi/N8Pfhd5RkczbfS++CgUdJSink=;
 b=kFWMAJFpJT4/q0zVEl+DW2FSSlJMMhwWKv+cevz7QlqQm0eIY9O/PiouqxKac5SL+eSX
 HRG/4VuDMNvMwawnXQontoIf5P/AiTISjk18GmLUWHCUZeA6qVp6fHeBjC3HVuH0AFh+G
 JvSG/ERLmmkEo4cj0w0EtmfbPA4zCFi/fP9P0Mq6PmbA1XQpHJevofc79v0rJXYC76MyO
 tCA8BcNBkFLOw3/8Q4sdT+2+8V8syPsmfa9tf2pt/D/ygPSc9o4ZY5ZqHOAU9zA885Oru
 wWJNmzgooDOGNPW4246TZu0pE32BeOT3QrwT2D5X/YqCDFJUNflGscngg0bUAGPIMAg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 spf=fail smtp.mailfrom=siemens.com;
 dkim=pass header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=DIYDFCpR; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=ludwig.nussel@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=DIYDFCpR
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0799C4002B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 12:53:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A31E847EA; Tue, 15 Sep 2026 14:53:24 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D128404D
 for <u-boot@lists.denx.de>; Tue, 15 Sep 2026 14:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com
 header.b="DIYDFCpR"; dkim-atps=neutral
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260915125321f8685600aa0002072b for <u-boot@lists.denx.de>;
 Tue, 15 Sep 2026 14:53:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=POXwMJWCLdIjh3Xsi/N8Pfhd5RkczbfS++CgUdJSink=;
 b=DIYDFCpRjAXfjFnHemzu42Hn9zlPyXjGY5nSqe1o+AN6TSYcMzKNTuJr/FHO/lpkxDy7dd
 QG6l5reEHu1RfujKNNcE3BT4WKouhgAnXULiVgRAJp++0PyUWrPMQCO8ha/0p8K51QNXaYHt
 T5GYpWPDzTI3BflRkuy7/WJkoI1Ru/CDVM2wtN+fbELAkmCJtLIcF/nOUM8hqGxcp9grL/h2
 ctKec7CcePKS8LY1wdxg6cA9NWQZ12W9R12Jwzr2JgO3lgl4hAY4gkdFEH7SDZkf3ep/K2XY
 zYpHlgEA2IYCRTydzfX15IxKrZROWPXkCbfVta5H3TwAgSj6gkxr9DJQ==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v9 1/8] test: include mapmem.h explicitly
Date: Tue, 15 Sep 2026 14:52:12 +0200
Message-ID: <20260915145217.v9.1.20756bff4397b8b9e5cd57e4be96a99118b7c1ba@changeid>
In-Reply-To: <20260915125317.180911-1-ludwig.nussel@siemens.com>
References: <20260915125317.180911-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

The file uses map_to_sysmem() from mapmem.h but relies on implicit
includes which may not work in all circumstances

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v1)

 test/boot/measurement.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/boot/measurement.c b/test/boot/measurement.c
index 71f503f1567..de4f7ff6196 100644
--- a/test/boot/measurement.c
+++ b/test/boot/measurement.c
@@ -9,6 +9,7 @@
 #include <bootm.h>
 #include <env.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <asm/io.h>
-- 
2.43.0

