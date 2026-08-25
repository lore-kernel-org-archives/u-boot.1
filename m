Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2D5C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BA2780DE1;
	Tue, 25 Aug 2026 17:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MbIwpKbSs3RV; Tue, 25 Aug 2026 17:00:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677233;
	bh=KfwhNWXmcJ/BF5SiWnE8FU6dt1UEnO+K3JDHP+cP+g8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yWxYvhH9kKuG6GJkPzvJITrtAJufAfAnhQaTECosZljVuOBwG9gqEUvPbzS3qAz0j
	 SZxcMNzsDyZm6mG5gxbh9exN6SARNieUCLn26PcSoUc+nUzUT0Qthrgc7oRFAxZdyw
	 vTPOaEI53kTxpcwVPJRN2uG1QZSc+SR36WnBrW8Sz2xpkx4rjsB11ThvGQGjspojoS
	 9gatcyEaY4fuWBWAJLg5AmSi2hlvFllGfWp7HcUHlrDxY47R1es66++w7Iz0tH2CeE
	 JKom6rMu6pvC3GMtPTdy2cEadwJt9xUvuVqT6jtxhrFbFml5bpJzoe2nu4ZQzTlv1T
	 62Dgvkk4XhKNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB22B80B49;
	Tue, 25 Aug 2026 17:00:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 994A935E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8994D80529
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tdg0Nv3ZVKKf for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::bc08; helo=smtp-bc08.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=egGVbgrt
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::bc08])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AA9680B49
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:24 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0l2lw4zjy3;
 Tue, 25 Aug 2026 18:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676630;
 bh=KfwhNWXmcJ/BF5SiWnE8FU6dt1UEnO+K3JDHP+cP+g8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=egGVbgrtk7WlUFBXgEZnx9ZwK0KpueACNVaYqbjgcy4PO053nySCLg7E1dS03diQw
 dbW0FKQ8y1AdoocPceByseNduzkyuv76MXoKODtKd/qpjH646h/ePaaaPLlboEx47i
 J2lWV62oAuryq+FnHPtjwhtAzn5MhqZ6+bLmPbFa5oDSDp+icPKMjkxIe8N9r8AiKA
 FQDQKMbE3o1UJ9gE02WIfZ0iNkApTGU6uTbrC/N245lpoZ7uDiUu/nOepWsUZMtvrE
 tUXTzCVas4IMD4rQRZZLWHhHrnuy2hwKswFZY07iJHvcCpdwxcH5YAoi7ZpaQrQImS
 23TR3Df3F8nVA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0j573KzYvq; Tue, 25 Aug 2026 18:50:29 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:56 +0200
Subject: [PATCH next 19/45] doc: develop/coccinelle: update links
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-19-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The original links often time out. On the Wayback Machine[1], the root
URL is redirected to https://coccinelle.gitlabpages.inria.fr so use that
link directly.

[1] https://web.archive.org/web/20251028230912/http://coccinelle.lip6.fr/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/coccinelle.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/develop/coccinelle.rst b/doc/develop/coccinelle.rst
index 70274c3f5f5a..54ea8eee0e9c 100644
--- a/doc/develop/coccinelle.rst
+++ b/doc/develop/coccinelle.rst
@@ -34,7 +34,7 @@ of many distributions, e.g. :
 
 Some distribution packages are obsolete and it is recommended
 to use the latest version released from the Coccinelle homepage at
-http://coccinelle.lip6.fr/
+https://coccinelle.gitlabpages.inria.fr/website/
 
 Or from Github at:
 
@@ -66,7 +66,7 @@ The wiki documentation always refers to the linux-next version of the script.
 
 For Semantic Patch Language(SmPL) grammar documentation refer to:
 
-http://coccinelle.lip6.fr/documentation.php
+https://coccinelle.gitlabpages.inria.fr/website/documentation.html
 
 Using Coccinelle on the Linux kernel
 ------------------------------------

-- 
2.55.0

