Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497B5CCF2D1
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA2783966;
	Mon, 19 Jan 2026 10:54:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="JzxYdPcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9B3080B98; Mon, 19 Jan 2026 10:54:44 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E11800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peko@korsgaard.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=JzxYdPcbXByLeXkiaXCIbGYLeCDgfS7Rrv3WHemguJnmaVXVcWcV9KUx1pLzLPs8bzcn9zfci7rTnVE9h2+kaWNIOM1mr9ITFpyBhreYxF3fJ9Z0B6XZJqoP76RIksdV+/8mm9Wiqau/8MLXn9Gk6eAGlwZqC9ZoCUrkgXC6/h+dwFWKrSwATsv6Ed7UHMPHKTOSUFGYsDvC7yUNbe38BwV072hDlXP97TAyzZEqkHmAYlIIwIXvzzBnJhzyI+egq5FrS8/sAvVKc90VxnTpIcmayewSpb9rdHXXvLAz8ByJCKxc/V/o5X05eM30/t/wU3NiciyEbGWjNxeIG7N2oQ==;
 s=purelymail3; d=purelymail.com; v=1;
 bh=hVRqf90YTVILv8tssrIKHT0X+4ZoFji/quJaTPLDWfY=;
 h=Feedback-ID:Received:Received:From:To:Subject:Date; 
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1001042314; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 19 Jan 2026 09:54:40 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.98.2)
 (envelope-from <peko@dell.be.48ers.dk>) id 1vhly3-0000000Bdvf-252o;
 Mon, 19 Jan 2026 10:54:39 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, lukma@denx.de, Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH 2/2] drivers/clk/clk_zynqmp.c: get rid of compiler warning for
 !CONFIG_CMD_CLK builds
Date: Mon, 19 Jan 2026 10:54:37 +0100
Message-ID: <20260119095437.2775081-2-peter@korsgaard.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119095437.2775081-1-peter@korsgaard.com>
References: <20260119095437.2775081-1-peter@korsgaard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
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

When built without CONFIG_CMD_CLK, we get a warning about the unused
clk_names variable:

../drivers/clk/clk_zynqmp.c:153:27: warning: =E2=80=98clk_names=E2=80=99 de=
fined but not used [-Wunused-const-variable=3D]
  153 | static const char * const clk_names[clk_max] =3D {

So also guard it with CONFIG_CMD_CLK to get rid of that.

Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
---
 drivers/clk/clk_zynqmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 7a433a667a4..765cae92241 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -150,6 +150,7 @@ enum zynqmp_clk {
 =09clk_max,
 };
=20
+#if IS_ENABLED(CONFIG_CMD_CLK)
 static const char * const clk_names[clk_max] =3D {
 =09"iopll", "rpll", "apll", "dpll",
 =09"vpll", "iopll_to_fpd", "rpll_to_fpd",
@@ -177,6 +178,7 @@ static const char * const clk_names[clk_max] =3D {
 =09NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 =09NULL, NULL, NULL, NULL, "gem0_ref", "gem1_ref", "gem2_ref", "gem3_ref",
 };
+#endif
=20
 static const u32 pll_src[][4] =3D {
 =09{apll, 0xff, dpll, vpll},=09=09/* acpu */
--=20
2.47.3

