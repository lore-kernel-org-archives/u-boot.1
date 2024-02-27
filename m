Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C6CC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C661287FC7;
	Tue, 27 Feb 2024 07:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="ko09HVhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F98E87FA4; Tue, 27 Feb 2024 07:56:06 +0100 (CET)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69C2487FAA
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 07:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9014912F3B9; Tue, 27 Feb 2024 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1709016963; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=W4RGjUAKsNAa4xf53OqC3zdGKEmTCCb+L/N/V+hTqbs=;
 b=ko09HVhLTVJ43yq2xRyq1x2DAboszauWbW3LSJxkfz40kRWF4IB2ZYrQFfAqNhw4nSsETZ
 Z3ItR6TsUyIXngVs/teY5RJPykgwx8r/zO5rAXinE+vY3b/9DyOsFBOmAHA8t5jt9wQRth
 jWl1a3IW4SAA0tvJzRe6Gs3rlC4Ajj54uGWQ5Bn/BWgUY3M1nfLHEWjCD8jkHHOCvFEV6C
 uFUQqhiCQVcYRT8KoXYHuG6tXc77snOFm+quez4XrO7B6iwYkhpJqc9+kjcgf41IcJhvPz
 9yhm9I4MkjPo5Kb7bUs6oVUpuTNyVNS1xK5d1xiVm3nClsO842p1lXrxzke7aQ==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/3] board: amlogic: jethubj100: update MAINTAINERS
Date: Tue, 27 Feb 2024 09:54:05 +0300
Message-ID: <20240227065551.580199-3-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227065551.580199-1-adeep@lexina.in>
References: <20240227065551.580199-1-adeep@lexina.in>
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

Fix mispell in maintainer name for jethub j100 board files

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 board/amlogic/jethub-j100/MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/amlogic/jethub-j100/MAINTAINERS b/board/amlogic/jethub-j100/MAINTAINERS
index 43f6a5fc86b..3edc5d8865c 100644
--- a/board/amlogic/jethub-j100/MAINTAINERS
+++ b/board/amlogic/jethub-j100/MAINTAINERS
@@ -1,5 +1,5 @@
 JetHome JetHub
-M:	Vyacheslav Bocharov <adeep@lexina.in>
+M:	Viacheslav Bocharov <adeep@lexina.in>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 F:	board/amlogic/jethub-j100/
-- 
2.43.2

