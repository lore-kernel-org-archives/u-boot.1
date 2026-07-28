Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B71C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 22:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 835E060A85;
	Tue, 28 Jul 2026 22:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V0zZRrNGsT6b; Tue, 28 Jul 2026 22:12:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B70F260A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785276755;
	bh=xEAEQrElJSRYvGbFiToObtyragfljE94ACxWRxHDvjM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rLjXDsxVHWT2MGwK/v864prDMy7NOIMl7xF/t5S/xXirraJUSINLwaHsQlhUNImpM
	 zPO41aGD9Eh+tPVL7NZozaM5SVQ2JgI8UPGMZZ75XZYhDgW44VSYFPlGj8hBC+QvIJ
	 knpG7zzfBysLHNvona6aOmtGsfMdyCFca1MKGQ88gPxZn9AGkxe6OdgVKRMqBlUjo0
	 oYfF7U4vk8yWHZsGwR8foitpIV3ieIi5z+G4NuaMON3N2ic6kWoOLkexb7G6caUlwI
	 mX05q3oVxeCOXhpmP9D3qcNT+VGgwOB4BSuWS3S5ehb+a5XYs9UIxk4IwP72xf6Rsj
	 XSKKREJWrvkCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B70F260A4D;
	Tue, 28 Jul 2026 22:12:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E832842A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD0DF403A1
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNyXUzUZ1YwQ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 22:12:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2A45A40051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A45A40051
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A45A40051
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 22:12:33 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ee125ec926so250977a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 15:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785276753; x=1785881553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xEAEQrElJSRYvGbFiToObtyragfljE94ACxWRxHDvjM=;
 b=I1yeHkd51xtUkwIFayMaQkqwJ9q76J0XzmO7AbvyA4Emw20Pg5L+4YdWY4ZUZRxHZ0
 Hd/0rs3d9QlQpQ1n7z7uRb1QFcXgJ5rRnka1rDyEWjlWRmrp1qPHCtqPjXlqI8KRIUYn
 GWR/ndoKFSdx6bri1jZigihp67BwW0XZ4akoETNdAwtABerHlJvbo6qYMlY/ruQNgXik
 P/Cr0UKpof5qZq5zbeAulyifwQ7Qi6ULYeT0KNO3W/B5YS+ntCcgaPq0qB2owGzKz/ps
 2Fk/gtkm2l7GzLlUZEFPDM3jdcYVfcFB6Bjh4ZhhQzcDwiVDDqYwawpKfdXATa13V775
 N9OA==
X-Gm-Message-State: AOJu0YxJVwsJ6LhQrazw3AMsbOw/t0JwunJRkinEvNaHXDWM9lXGZJSP
 eo7S/m1GVoySgKIm9kweH7Nmmg4R7cFxkQ8FRif/sKrY5lrBcnPJBK0krJSbcFL2RA5W4chpyc9
 sYod0gts=
X-Gm-Gg: AR+sD130BZzxg8SwS1iB4ibfM0GKaOmwkc7k+KwudCkhP7sDnoISiZv13jmY8hK7hJ5
 zMuQAyhD+9AGFlRsCWG4pNNdEj35JptJUpg+t3YznrwCsQf11iiW/zm7txdGUR2KH7VECQOAznm
 dnEK+048z+lviKyio3A6XVdu9aZMfweWz08iwiBNXw80eAkHMzVZ5z35NuZCPyoV8kRZCdfIK43
 7iRyYDSL9whT5fm/EQ3nb0G5LknXdl5k3+MmnGWjVpE/Bo2liON0pEhzLsfrynl9MrcLsH/it1Q
 ORkroQh2TiYVqwsQ+45cuJfipPJRFkpQnmIOGaglVJfAeSdfrevbKC4ejJh62Thp/55k8vk7vYl
 NGIgBRm/UjHtJEl/GyUhlZpoT/4LCg1nVJZ8fVGZB/mWqtJCl3n/3Binw0woYx790mM9GsjxXRe
 qj6crYa3jN/yBu4V0SVV+4ouvHvSvg+fZEKUUIdBVqOIjKBeBsPGY1GtV4eXh9eSMgvWQsZdANd
 m9ZcRlkxAB/xhr1GXWV/idioYWATOiQUtp21xzZ/cKW8zRc99uBXCppkwQbq8qnR8r+zs4CaVSq
 QTK/bvsR1UbfzaQYGSURAomr8AHq4e/21Q==
X-Received: by 2002:a05:6808:f03:b0:496:11f1:f2ad with SMTP id
 5614622812f47-4ad5b964c36mr2645475b6e.6.1785276752967; 
 Tue, 28 Jul 2026 15:12:32 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6f03403fsm298168b6e.18.2026.07.28.15.12.32
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:12:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] CI: Azure: Correctly skip semihosting tests on vexpress_fvp
Date: Tue, 28 Jul 2026 16:12:31 -0600
Message-ID: <20260728221231.1745444-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785276753; x=1785881553;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xEAEQrElJSRYvGbFiToObtyragfljE94ACxWRxHDvjM=;
 b=nyify3/H6Oaepu8MIYt5HWh0RIuitEyF8sLs3BzwgDIExMQk8Zi+I6fyWVG57I+z1z
 YCyAkQarDZv27wCMMlqV4ejFvq8WaXAdDLI/U3NZAtAAhcgkG0xwXDvqqiWL5hog7gTZ
 3S7eYrICVfP06K/voVzMz+4kFtz4lyyT8+WkM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nyify3/H
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

In commit d75998b476de ("Docker, CI: Add vexpress_fvp /
vexpress_fvp_bloblist support") we specifically disable the semihosting
tests on FVP using platforms due to upstream issues. With commit
7ffa20af30dd ("Merge patch series "fs: regression-safe load <iface> for
null_dev_desc_ok fstypes"") we add a new test that was not caught with
"hostfs" because it's a semihosting test. Update the logic in our
pipeline to skip all semihosting tests.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index dcf2f6155af6..352269b08354 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -465,10 +465,10 @@ stages:
           TEST_PY_TEST_SPEC: "not sleep"
         vexpress_fvp:
           TEST_PY_BD: "vexpress_fvp"
-          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
+          TEST_PY_TEST_SPEC: "not sleep and not semihosting"
         vexpress_fvp_bloblist:
           TEST_PY_BD: "vexpress_fvp_bloblist"
-          TEST_PY_TEST_SPEC: "not sleep and not hostfs"
+          TEST_PY_TEST_SPEC: "not sleep and not semihosting"
         integratorcp_cm926ejs:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
-- 
2.43.0

