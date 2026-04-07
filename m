Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C273FEEF29
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 12:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9789783F98;
	Tue,  7 Apr 2026 14:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SWuJMSb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6570784034; Tue,  7 Apr 2026 14:34:52 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F31083A41
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 14:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A76CC1A31C6
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:34:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7DA29603C7;
 Tue,  7 Apr 2026 12:34:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D11A1045020A; 
 Tue,  7 Apr 2026 14:34:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775565289; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=gAWJ1CXGkcWuqYOS/wMlkfzn1D0YhLqHeosmqzeLqmc=;
 b=SWuJMSb+YlqONKf+Xpyo6OEwHyH3jea6bAF0rCGPvCK/tkK92A/GRLbQkhm2jpUo2vGMhS
 Tom7sXfnHcbvvRDmu/C70l9Yb2PZNaX4xZxRlBMAOlkx/AoJF3KInmNRsRN0kr+BIjRQQg
 5n3PJkHVIRvcSz4d9WDPvePJGXtzw2S2PDq3BZIjcsHGX8AJRIN9ky4xEtiXUzMSCS/P4N
 xNNvfh3nqh/1lmgFqStBurde4SFo/so+pIPsC0BV1Fv6yk04JmVmxyygsAqvp5PZmoSIoz
 TsEdn8r5g18vF8GJMZ3KRiiO7/u6o+j2t2+esOy9QdE1uwX3eUfZnaH3TKvbDg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, ilias.apalodimas@linaro.org,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: [PATCH] tools: fwumdata: Fix use-after-free in parse_config()
Date: Tue,  7 Apr 2026 14:34:35 +0200
Message-ID: <20260407123438.48582-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

In parse_config(), devname is dynamically allocated by sscanf().
When sscanf() fails to fill enough fields (rc < 3), devname is freed and
the loop continues to the next line. However, if the next call to sscanf()
fails to match (rc == 0), devname is not written and still holds the stale
freed pointer. The subsequent free(devname) then operates on
already-freed memory.

Fix this by resetting devname to NULL before each sscanf() call, so
that a non-matching call leaves a NULL pointer and the subsequent
free() becomes a harmless no-op.

Reported-by: Coverity Scan
Link: https://lists.denx.de/pipermail/u-boot/2026-April/614161.html
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 tools/fwumdata_src/fwumdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/fwumdata_src/fwumdata.c b/tools/fwumdata_src/fwumdata.c
index c5b0f56842d..44195ce2bf2 100644
--- a/tools/fwumdata_src/fwumdata.c
+++ b/tools/fwumdata_src/fwumdata.c
@@ -84,6 +84,7 @@ static int parse_config(const char *fname)
 		if (line[0] == '#' || line[0] == '\n')
 			continue;
 
+		devname = NULL;
 		rc = sscanf(line, "%ms %lli %lx %lx",
 			    &devname,
 			    &devices[i].devoff,
-- 
2.43.0

