Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4822606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eBIXW+Oh;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sNibJ+me
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92B50810EF;
	Mon, 16 Nov 2026 17:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TW4t7XCV5elW; Mon, 16 Nov 2026 17:45:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2F3A810E2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794851110;
	b=emdnwmQGtZkiFMsK50kJnNmogniCOV+RTtr6cQD1fNin8JE54Lku+/jIcXHxI0hw2Vpd
	 VE6Ee8ySyzR6t8odwaX3BWTF4s7IXMgwPeW6t7C4Ds2f3iRd2wCu2BjDpsE/0+Y8Sqa3+
	 1tGFhZQUanI0PRDqejGROnHLFhSr9UvVodqxMXlfs2BOJOpZUp3EfXEa/xZyqHMnSFQtd
	 Fn1kzT5BASzPpSJ1HF32ZW+iydGb+ygf1Dk0Nx+Z5BKFNhT2i/r/rStJ7SVh3ktoq6L2m
	 FoJyxtIFtzx5e5JtAtwm2Kdptspj0mLo3MlQix29KbtNJF5TFukn7CslCylCqbYk3WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794851110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J0Tx5Fws9cn50rFekeRGgsmx9zqJQHsjCcsb3THI4Ek=;
	b=KmseVnYcuEDrPcpo3DvnNCb4ioo/tAhgD7BFDpg94zzikfMTd5qoZad7lus/s2ns075E
	 IT4/Y2CVbAKvUweBO5Tc2b7XFqWZqEBynYRK6IcW4iqOvHm94ApoW6hYdnjAcuhPq57Iq
	 aDvRTy3wdlHKgqoc8z9U9NWC2cx+oS1BJ9t3RlpbE0N3bjqxzh16wwyPtMd0KbbY0lIjN
	 3E3i6adC1ePY65IvnEFjJJ6pGWXAYlDgTuv04JcKiSG7GR935r1ypPpAZaTIzGyW29dl4
	 //PXh1FZTXPznw/nqQCaWMdrNbg3HvzBOzk5ikq4YLo9JdzHMM6Pze7kJi4NS6gLonQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=sNibJ+me;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794851110;
	bh=J0Tx5Fws9cn50rFekeRGgsmx9zqJQHsjCcsb3THI4Ek=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eBIXW+Oh+u1D7vgRcdC1MNnbrPB+3fuygl6pCQyuMw5V0wdngFsPCPsTdKSlhXi+0
	 Mk9Htg87jH0owzD3fUoqGAtJ/8rhizY2b1Xm6krOGdQimRK/hPWNZ2Dohnm+4KDqiL
	 NhfgHeT9/8Jn7bUPcb2aeqGFjdwf3sxYcJOlQPe1PxebQ0+nA+rjTPZHUurwQ5ek+U
	 ktn2W1LQxBMO7qMbxYrRxna0KL3i4iv0DbQhTNiHcnYEM0TQQcABu3lJlQWfKslAuc
	 3/CRxbrIiQofUVDLL+Pl2AFMu1PKGP1Bz9trMuzz1Bv30FmZ4pZyqHCLq4Kc7kjqPU
	 Gvxsi0iXUcAag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2F3A810E2;
	Mon, 16 Nov 2026 17:45:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 771762FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DCD0810E2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:45:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BawdgsWTKk4v for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2BBD810D8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=sNibJ+me
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2BBD810D8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:45:07 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSwHN32FPzKnCX;
 Mon, 16 Nov 2026 18:45:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794851104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=J0Tx5Fws9cn50rFekeRGgsmx9zqJQHsjCcsb3THI4Ek=;
 b=sNibJ+meZzexPeLnwp0K2hD6Jywpfja5P1VBNJPfvst/IEO+YFjAotqplZzv9DH9MoHqH/
 yMciijkuSoLZXQLALDRVr76GttSJRojWLUUJpYelQnct9vll07ev9v3ImUeRI4o6IM7rKG
 GHjKLjcqPkb1Vni9dP8dDRFtwQILtOlK6inr7mTDMajL4Wgs5ISvdyHEGJ/GdrpFbhksQA
 metmS04MQbbgYYCbrCoBvMflOYKOmjc62yTD+6HdjKoSPDYiklY+WC/5gixwNB2Syfe50z
 Uq1FdfsPqw2pok7WW/F77yBFgFHUkkQeVAeDD6U2QAG3y5Xi/GmUPjqFYktAQA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Stefano Babic <sbabic@nabladev.com>, Stephan Gerhold <stephan@gerhold.net>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: Constify driver ops
Date: Mon, 16 Nov 2026 18:44:57 +0100
Message-ID: <20261116174501.3488413-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i1o5t3kodhmq5dhnb88kdn319itkqt13
X-MBO-RS-ID: 0a0ae229ee27bf965f9
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/video/exynos/exynos_mipi_dsi.c | 2 +-
 drivers/video/imx/lcdif.c              | 2 +-
 drivers/video/mcde_simple.c            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index edeb0a87bbb..588b94f6207 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -166,7 +166,7 @@ struct mipi_dsim_ddi
 }
 
 /* define MIPI-DSI Master operations. */
-static struct mipi_dsim_master_ops master_ops = {
+static const struct mipi_dsim_master_ops master_ops = {
 	.cmd_write			= exynos_mipi_dsi_wr_data,
 	.get_dsim_frame_done		= exynos_mipi_dsi_get_frame_done_status,
 	.clear_dsim_frame_done		= exynos_mipi_dsi_clear_frame_done,
diff --git a/drivers/video/imx/lcdif.c b/drivers/video/imx/lcdif.c
index 9f4fc7f5152..3bf375df7d9 100644
--- a/drivers/video/imx/lcdif.c
+++ b/drivers/video/imx/lcdif.c
@@ -298,7 +298,7 @@ static const struct udevice_id lcdifv3_video_ids[] = {
 	{ }
 };
 
-static struct video_ops lcdifv3_video_ops = {
+static const struct video_ops lcdifv3_video_ops = {
 	.video_sync = lcdifv3_video_sync,
 };
 
diff --git a/drivers/video/mcde_simple.c b/drivers/video/mcde_simple.c
index 2ba5d0de152..c48eaf18cfe 100644
--- a/drivers/video/mcde_simple.c
+++ b/drivers/video/mcde_simple.c
@@ -121,7 +121,7 @@ static int mcde_simple_video_sync(struct udevice *dev)
 				  MCDE_FLOW_COMPLETION_TIMEOUT);
 }
 
-static struct video_ops mcde_simple_ops = {
+static const struct video_ops mcde_simple_ops = {
 	.video_sync = mcde_simple_video_sync,
 };
 
-- 
2.53.0

