Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D0BC61DBC
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D638C4027C;
	Tue, 25 Aug 2026 17:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xw5RK4q8iZ5p; Tue, 25 Aug 2026 17:00:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677232;
	bh=rZ2ePUItTXRfPO3ZaAIGhtxCt5REr3BBHcrHDjWTzkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vT/GuK+SHnyu/IwVwpp9eLcOlGWU/xm4/SicEh73raKz/Y/3NmKJK+nKxZ3iulSVS
	 0nrIIBo255P2Xax6GiFzb+c3SDwDrHHVlQuIAxFf7+MqgQ864D95yXtt9ql0hhJbfa
	 0TIiLLgZG6xta2jecjEcc2JTPVV5wqx8Y09ozheIwG4AGCDPkc16HXRvYeswxLiYOg
	 i6Iy2LrHIxd7QYy+vMQlMIzXbxWs8hpCZz1qOJXVOIJzXQCPCpKDiWt7XS36im8X2w
	 lN1E3dE9yoXcBFeMyz7bp8Wj5NsK7cp2stClO2PYEeYN4FKTHToFFbaC6X2NBvlK0r
	 0BMzXRE90DTgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB95040606;
	Tue, 25 Aug 2026 17:00:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BA153DA
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DB9F4004E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FfkGh7O-wQzZ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.172;
 helo=smtp-8fac.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=XtYv6jaE
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [83.166.143.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D32514002B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:21 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0f17GrzhF9;
 Tue, 25 Aug 2026 18:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676625;
 bh=rZ2ePUItTXRfPO3ZaAIGhtxCt5REr3BBHcrHDjWTzkY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XtYv6jaEEhjXvKILfMp7xfmvGl7mOY+uXTQDyWErO2q+SnuZynBx7hBF8rPB6ZjJ+
 Tv8/Zfd2uGd0wH5PlrbQY0zyju9H+5fX57xtLocKn7Wd7o51YmiSyThvUuxH7iQVvD
 0D/boLJB9ZQaTrrn/cY1oCC0bbFRMjb+L8ld/XuO3TXeCaBu/jryuXTH7gdoKXz1GV
 gtsOxRfOQHsIQ4O6TO3S4qN4VxaRKIZn7eFTth51CvGzC5LH6UbNPyCcSIubeb7oMQ
 G8bwRWLitVsSCpnGvCXCG2dyEWcYs2IMA5dOXeNqhCPi5phyAocm0ixAMg0xQ+jFUd
 rxDDtPjBiQ7eA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0c3tzZzYXF; Tue, 25 Aug 2026 18:50:24 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:52 +0200
Subject: [PATCH next 15/45] doc: develop: sending_patches: update link to
 GPL license
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-15-ee7573fe3a4a@cherry.de>
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

The link actually (after a looooooong time) redirects to the GPL-3.0
license which isn't the appropriate license. Instead, point at the
GPL-2.0 page.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/sending_patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 3944ca4206a0..92c34c0669d0 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -361,7 +361,7 @@ Notes
 
 1. U-Boot is Free Software that can redistributed and/or modified under the
    terms of the `GNU General Public License
-   <http://www.fsf.org/licensing/licenses/gpl.html>`_ (GPL). Currently (August
+   <https://www.gnu.org/licenses/old-licenses/gpl-2.0.html>`_ (GPL). Currently (August
    2022) version 2 of the GPL applies. Please see :download:`Licensing
    <../../Licenses/README>` for details. To allow that later versions of U-Boot
    may be released under a later version of the GPL, all new code that gets

-- 
2.55.0

