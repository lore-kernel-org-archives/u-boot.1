Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BA7C61DB9
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 21:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 191C640A2C;
	Fri, 28 Aug 2026 21:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DH23ZsbqP5vf; Fri, 28 Aug 2026 21:00:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787950828;
	bh=kLk4y8fIRODqdVZf/WYKtGc+e/xrUIzdDYR/u+yJNgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rpmW9woLjORDZssxsVkUojO6J7zw6eRPr0oLdX2THLBoghDEgS/DIgvDapb+wqBbJ
	 OH3lzoxjSUDvarjadxjV/aNLhFHxMb7CwqjIYiMwhN5F25SQzIv0W9AWZrIq8Jr18D
	 9z/RDoQfuv1dWxN9T4G6wenTYpiBL7rjGQbDPCQ/CHOnglPPpEBF3KKnLaM777p+FO
	 otwcVs2bBv5EyWZKpZIq7LMgkBknmaTNaaDad5fu4+38Wya/lu7HBpVaEhTlGqXOTc
	 wtTWpODWnElenBcKZfpNUPnqqhwI2LTcvxoB27jd6rPIsWuOppKWXCSizHzJ+rcscK
	 O2hZWkySJtXWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24F4C40A06;
	Fri, 28 Aug 2026 21:00:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E606355
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 21:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 808D34085C
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 21:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5_X-zJyd8Fa for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 21:00:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=ng1IlpUj
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BB8F40845
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 21:00:20 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWrPY074ZzRgl;
 Fri, 28 Aug 2026 23:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787950816;
 bh=kLk4y8fIRODqdVZf/WYKtGc+e/xrUIzdDYR/u+yJNgk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ng1IlpUj506jIULkWfrPSFILd30dYYoV0CfzhR1jygQ9uDXb+oDnvinkPySQAAqqK
 Sfwbgj7aGjNzpPrT6hhVVhQyL1CO8p15iAk/Y8pwihFdJIMM65lcPkieKNo/bpO6LF
 HdKnSWstMzwmNDKkSBNNvpW9E8UNpwOgJ6g+EdjKxqlNkQQlWHozaiNr7UZVzl/zwO
 VaKYBplFheiiCLWLtjLhJLqgPuOjVtuCRglDpDhrtAKGedCyRPjgVIQzzinMsylVKv
 5ZoRkMCLz/vllol85+G1A0XmrxmhZ5Fv1BPMbHjbg8demeqAU/Z91EVfuVFobuBNqR
 JEueoKO+D9R3g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWrPT3M4zznkL; Fri, 28 Aug 2026 23:00:13 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
To: u-boot@lists.u-boot-project.org,
	u-boot-amlogic@groups.io
Cc: uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org,
 neil.armstrong@linaro.org, marek.vasut+renesas@mailbox.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, adeep@lexina.in,
 sbabic@nabladev.com, festevam@gmail.com, smoch@web.de,
 alpernebiyasak@gmail.com, le.jin@siemens.com, jan.kiszka@siemens.com,
 iwamatsu@nigauri.org, pbrobinson@gmail.com, seanga2@gmail.com,
 bmeng.cn@gmail.com, lukma@denx.de, mkorpershoek@kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH next 44/45] binman: btool: bootgen: update link to user guide
Date: Fri, 28 Aug 2026 23:00:02 +0200
Message-ID: <20260828210003.823954-1-foss+uboot@0leil.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The link doesn't serve the document anymore. It's available both in HTML
and PDF form at another address but let's point at the HTML version in
hope it stays online longer.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 tools/binman/btool/bootgen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/bootgen.py b/tools/binman/btool/bootgen.py
index 1bc9f0aa96f3..f740381b7047 100644
--- a/tools/binman/btool/bootgen.py
+++ b/tools/binman/btool/bootgen.py
@@ -7,7 +7,7 @@
 bootgen allows creating bootable SPL for Zynq(MP)
 
 Documentation is available via:
-https://www.xilinx.com/support/documents/sw_manuals/xilinx2022_1/ug1283-bootgen-user-guide.pdf
+https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/
 
 Source code is available at:
 https://github.com/Xilinx/bootgen
