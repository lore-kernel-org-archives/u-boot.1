Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20047C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB57F80B3D;
	Tue, 25 Aug 2026 17:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M4eev0rtLBMh; Tue, 25 Aug 2026 17:00:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677224;
	bh=mpmdsyrjSskTfACVedcjXwhpa+LO3vsOVPUkiqn0egs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8iBhN4nswZxM+D60ZyRhyPXEHC2gL/NOoLK0D+4CQQkQUjOYbvvLMd3OP6ToJbld
	 N6PF8eiDhfDtXjQ1Nqp2t42u3763+qGWEW8lboEIE9ozFLUiuXBWBZEqTt7iLxGQZx
	 kXWYteFrG2Xf+vjjnO3NMWm7+AdhSQYDdL7YIgzBehouUUQ7/KqfcI6Hhu0EVlN2S2
	 rGPmvemlLnf55WlosA77V5awP2sIkMfgnsIc5x4uWCciBnYTPrrJdoN6QCSyJISYXy
	 8Op1TbHVU/7JNdjCwtic/XeO4HIxdyyewwfF/L07Q0PGiDYLcPTmcJW/6cdFQ5t+hb
	 SFeyNvey3USCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB9A980B49;
	Tue, 25 Aug 2026 17:00:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 00C73396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB60680559
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKMuKF1O5HVQ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
X-Greylist: delayed 606 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 25 Aug 2026 17:00:15 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=PeQqfmwG
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.8;
 helo=smtp-bc08.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch
 [45.157.188.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5C8380542
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:15 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0n1cS6zfjn;
 Tue, 25 Aug 2026 18:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676632;
 bh=mpmdsyrjSskTfACVedcjXwhpa+LO3vsOVPUkiqn0egs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PeQqfmwGOCIkBTLfGjI7uEZivmpkh9D7aSJ+vesHWAsqfWNzKCFJN0vlC6z1T2Uwd
 gmOBJWvvyDLYg7sdUgx8XvuW9MqW75MNILkCTxcnnwZdGSA3h+hBqFASxVw6vsvfUC
 MKK1oAA0kNvm+GjMB0CgwYMgxs1KNK3cxNXFI9IG3cJUBLeUkfmw3otG00rk8Mg+Jk
 mo0aGX6TvNg2Dzg2qNgJvggcArQGJojPwdaDe/cIFmrp9+JVii0MqNPEK/cNaFW/I+
 T5Eu7tHWr1BzEmRRc3PTYOcJ96CoMSlANiyxjylgDn5rrqrq+dPHA3RwBjU6RVFHth
 AIY2C1ljSoztw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0l0STLzZVC; Tue, 25 Aug 2026 18:50:31 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:57 +0200
Subject: [PATCH next 20/45] doc: develop/coccinelle: remove dead link in
 supplemental documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-20-ee7573fe3a4a@cherry.de>
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

It redirects to a fancy 404. From a cursory look at the Wayback
machine[1], I don't think it has more than what's already in this file
so simply remove the mention of it.

[1] https://web.archive.org/web/20240915073329/https://bottest.wiki.kernel.org/coccicheck
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/coccinelle.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/doc/develop/coccinelle.rst b/doc/develop/coccinelle.rst
index 54ea8eee0e9c..d0ad803fc7b8 100644
--- a/doc/develop/coccinelle.rst
+++ b/doc/develop/coccinelle.rst
@@ -58,12 +58,6 @@ https://github.com/coccinelle/coccinelle/blob/master/install.txt
 Supplemental documentation
 --------------------------
 
-For supplemental documentation refer to the wiki:
-
-https://bottest.wiki.kernel.org/coccicheck
-
-The wiki documentation always refers to the linux-next version of the script.
-
 For Semantic Patch Language(SmPL) grammar documentation refer to:
 
 https://coccinelle.gitlabpages.inria.fr/website/documentation.html

-- 
2.55.0

