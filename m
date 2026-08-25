Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EC2C61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DED5E80DBA;
	Tue, 25 Aug 2026 17:00:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8fvq0iiM9YIj; Tue, 25 Aug 2026 17:00:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677227;
	bh=IO/U7SwsQQXJg1p6QCa0yvJxNdJUQhc/uIviLdXgvSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wGarNWsxh4/LMLAPLB2y1MxtUpCOo8WHXiF5D2cE8hWbqKDq6MnC0THOusO6V7UBA
	 X3kj+dpSPupUfu/bz4R2fLWimrE3yaY3y6yAQTT4C5cKHyRFJ8VYPaaqMTaszwRvQn
	 JVDl4KmLIA5iU/wJwt95+UaeNDAdftOe/gXoHDMW9/eTOASJ6Dwhw/PbQ60iYDRfyL
	 a7PmpNpSLQMUDAccvGW8aTBNQo1yXT7xUayplwCvP/GMfZ/Iwk9hWEihzYm+lRizFp
	 1KArkuUDWLhXZ4aSFgoRUC+n6fkbYvKCU3z/bl9pLXdekYNongex2wnOlFn9h1i6Wc
	 w0PjhvNdOu10Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6879F80ACC;
	Tue, 25 Aug 2026 17:00:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B925035E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FA484004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDE-VAfrMIhb for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.14;
 helo=smtp-bc0e.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ivBFliPK
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [45.157.188.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8F914002B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:19 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0Z0KqSzfT2;
 Tue, 25 Aug 2026 18:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676621;
 bh=IO/U7SwsQQXJg1p6QCa0yvJxNdJUQhc/uIviLdXgvSg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ivBFliPKk6w//3LhYK5dgCU+plMD3ANVrHJ+EnmHZqTkPnXZXIbrqNy1ioUDN2E9p
 NH/aE3SnXoYkzAEvXqXqeoTRVjR6ilbnor4xnmJ6VhhQYqRFcs4GbjX35E7PhZnr6W
 suUY4gbVjdafO7ZQ/7EHhiE02aI6EtzmlkVSEYn0G+MxOleKd1ysksKRmPbSzvyhN3
 dNaDw4JOEK+yEs4DNuXInahgdvVxyvMjtXnknyZTlRT3gxvrByFRZrTO8Uv/ly+qUo
 lNw/dtWvQqFPZZKzUREiGCJikGEpuzm+DWBC95xvCw2GuT0lkpNZ0k5aBv3YFnuL7B
 X5h92Z5bIZ2qA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0X2RRRzWLN; Tue, 25 Aug 2026 18:50:20 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:49 +0200
Subject: [PATCH next 12/45] doc: board/amlogic: jethub-j100: update product
 page
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-12-ee7573fe3a4a@cherry.de>
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

The original link is 404, replace with one I believe to be correct based
on the info on the product page.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/amlogic/jethub-j100.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/jethub-j100.rst b/doc/board/amlogic/jethub-j100.rst
index cbf1ea761077..053d5aa57ec7 100644
--- a/doc/board/amlogic/jethub-j100.rst
+++ b/doc/board/amlogic/jethub-j100.rst
@@ -3,7 +3,7 @@
 U-Boot for JetHub J100/J110 (A113X)
 ===================================
 
-JetHome Jethub D1/D1+ (http://jethome.ru/jethub-d1p) is a home automation controller device
+JetHome Jethub D1/D1+ (https://jethome.com/d1p/) is a home automation controller device
 manufactured by JetHome with the following specifications:
 
  - Amlogic A113X (ARM Cortex-A53) quad-core up to 1.5GHz

-- 
2.55.0

