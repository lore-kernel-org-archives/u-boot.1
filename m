Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9566CC61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 369F440811;
	Thu, 27 Aug 2026 19:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OrO8V06Y8Rpj; Thu, 27 Aug 2026 19:53:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860435;
	bh=k8CoQNsIMYmuxD1Snt+z3bKqfIokAxSYdr4dS82Imk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIPb36kPC/dsRaRG3wVy/ZtEordQQriKYFrEQa7pO+Qh4SQ4CuZRt2aC5tm0BGVMo
	 LZipKXeyrytv0CLoINkOx5011Uglq+tN/1vzxANiOLkUK0SJbfCXRP+PsULIb/Flxr
	 ljAwefVfq/gkcR7jPsDWHjvg6UbzYno+X7ywM5NrII6KCmxtHXunSV1V94KD+ZsQfW
	 ambUTjHALOr0sI2q6lzuzmwx6lHQmz+GjjMehwgWnjWrfGUqj63FX+xMwnVkGfeCfW
	 8v0AjPQKkRQPGsESl55UjBOlM75Kk1HV0WV/JWAK8+vR96KPKHWz+h6YJqiEijPwUc
	 Tcs3pr6Gs1Lzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D253407FE;
	Thu, 27 Aug 2026 19:53:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 30ABDB2C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E2BF607A9
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWUqMXJw7k3Y for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 19:53:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.171;
 helo=smtp-8fab.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=KFy9RuJ8
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F31B4607A8
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 19:53:49 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hWBzB5bFLz2Vq;
 Thu, 27 Aug 2026 21:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787860422;
 bh=k8CoQNsIMYmuxD1Snt+z3bKqfIokAxSYdr4dS82Imk0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KFy9RuJ88Di51k39ufVMJVcDEUoBAmBUYKLyxQ+BqesNveA+oSMLTHVnW0vUaP1kY
 cmtFBrs+UVZQ+tR3BogIZxzcMxCZM/DApMuoqx8lRkNcZbCEQCZbiNVzRPabUrqrCP
 jEVLl9x6MZ/Lp9iTjB8GcWTC9EjzEPzGYykT64rcUzokPP2A+o13NeflkhIxN9JSCH
 N8Mts6ME22pwbmNMaFeV1mM9gYIBqmHc6ZFa1cPeMcgUCJFIwnGpNMP1JJDgcnV7ad
 MC1YBKdYBTMK4rS8PEuXHUdUXhKDxkXYT+MmRM3w5lFujgr5mzK2OU2Mm9l3vFiKXH
 zwwe/yxaPAoLQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hWBz74B6KzNL7; Thu, 27 Aug 2026 21:53:39 +0200 (CEST)
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
Subject: [PATCH 22/45] doc: arch/arc: update link
Date: Thu, 27 Aug 2026 21:52:50 +0200
Message-ID: <20260827195313.129994-1-foss+uboot@0leil.net>
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

Replace with the link it currently redirects to (it has HTTPS also :) ).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/arc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/arch/arc.rst b/doc/arch/arc.rst
index f8e04a34f14e..18556e5d3724 100644
--- a/doc/arch/arc.rst
+++ b/doc/arch/arc.rst
@@ -8,7 +8,7 @@ that SoC designers can optimize for a wide range of uses, from deeply embedded
 to high-performance host applications.
 
 More information on ARC cores avaialble here:
-http://www.synopsys.com/IP/ProcessorIP/ARCProcessors/Pages/default.aspx
+https://mips.com/processor-solutions/arc-processors/
 
 Designers can differentiate their products by using patented configuration
 technology to tailor each ARC processor instance to meet specific performance,
