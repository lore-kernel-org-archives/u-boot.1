Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407E606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fg/8ZzY4;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RmLcu0gm
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D335D810D0;
	Mon, 16 Nov 2026 17:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LM-6DYTwncLB; Mon, 16 Nov 2026 17:36:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8312810CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794850570;
	b=hz2RChgEb0LZa2rVgBKmd9hVldGUZFRvY1jlrq7QKcgNT9Pp6qIRq8WmiqKts+MMlzpO
	 k4mAoYRNBHjxuBnCPXja9aimbTotURsZEBeEZZk4W9LqFwG97QPiwiH9kklf0q9watuzK
	 WVM+rzAKWutagrgj8o075XbhCxQsOijUyjexlouEm0llU/JiHYQ6l64xK8qsatUfguBVD
	 ovygZRU7fzeshKYjfmPH8RezL9B9TIsN0aD4VkjsLjMH9OSMbevjOIQ/Qy8GKU4cYfwKy
	 0dBD84ArskXqxA+Socr66KQKQ/N5KOsY81LsCext4uhnblDl8C4eJTqD7ybDmZcfCeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794850570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1ROT+rcwIIyBDUyLQjNA90/yP/ExC+AYabiyjQ/EDeg=;
	b=UmLtt1takx8NEDfDCk2Z9CUUPjeYoqbHS+lqudJ2lQ+0coBpQhtGwwPK8VY3CHV2/L6c
	 i2CyRFqlXdHHOmI/FfLpwJoreajeFwRznd3Dos7cjNnBixEvsC+MB7aeS9OkLZOGMf6K7
	 JOU+sT8NL2VtrKUwJ+EO/Fi5jX0rrhd9Irh+BFm3rfQMzeoQiAeZFhxA80D6F98dZaW12
	 DHWzDDj5UcD8wIbDN2RZb59QCfvf7qLsIkxAhaChF+6DwVP68IYgi8ZrXghMiafNe7UGl
	 jvfuB0JTaPFcLsN+ryiN0lEyQswZyU+Ju8deZdHKK/w2OM1LGersMwHoTCkiwxQXeIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794850570;
	bh=1ROT+rcwIIyBDUyLQjNA90/yP/ExC+AYabiyjQ/EDeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fg/8ZzY4G65FENEX9zS64JC81V0yR+tq6Dxwg3UZs+ncf8HWvOqGuUaqNFPt9Vwb6
	 UBLTwncHzeSthuc48bBN/GbIb0zUDpz3ovZxM4P22CpisD4zP+VOTAN9+k0xa85zpB
	 vOBqr4eIBEgK8cVX2HmbtLNbJ6l85FfHCzEM82bCoUXRtbzp9POnFJeA2QJUe0GeXB
	 11/QiJx7h7fJEhPb+yCDQCaOzP/4gG0MEjrGVRFKKa72akQ62wtu6575iiwCClgdgm
	 fJzJGKRu6WXw0D+4ZJBJ7dwkRA/+7DYkoVst9r4G3/lk3+aHZPVmeFZ3OPzzhP8kiP
	 kGTH2VRfelXEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8312810CE;
	Mon, 16 Nov 2026 17:36:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 260142FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B2D440588
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eINtaW1q8rVU for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E9FDB4075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=RmLcu0gm
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9FDB4075F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:35:57 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSw4p0R19z8vWB;
 Mon, 16 Nov 2026 18:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794850554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ROT+rcwIIyBDUyLQjNA90/yP/ExC+AYabiyjQ/EDeg=;
 b=RmLcu0gmlTmTQBSB+P2nPqy/cjcEdrOo5SLYYC0Av6tmNTKaIUFlA2CYa3IrqQ9Ywj5QRt
 zO8cNmj9rfwmCBlE7KYDgmb8lB9Ia69PSGh9nJKG3tsy2vtuw+mWpybHB/qLmtvTJYNu/P
 KPwyAwiqectli7hXHLpq1JKF98XEi+j5p/bP2vokzwyVPZlO1Gb9Y46LkTfKfB+/15H9cI
 KTloKgle6C9245P/hiP65n0PMmA3s9oNEQQtHUgWiwvi0cNWPS26xsn1RcGQZHyj53+6wm
 okHj2AM5X2l42YXpOrTCJ+KmqFsqEIv0PO29stX8n7gY5iAZIZrRxGLph8CKRA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@nabladev.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/20] clk: imx: Constify driver ops
Date: Mon, 16 Nov 2026 18:34:44 +0100
Message-ID: <20261116173546.3487841-5-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
References: <20261116173546.3487841-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nfmzx5mexkfyw8c4h5oz4gbx5fqwsya8
X-MBO-RS-ID: a32955974347c8ec3ed
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
Cc: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/imx/clk-imx6q.c     | 2 +-
 drivers/clk/imx/clk-imx6ul.c    | 2 +-
 drivers/clk/imx/clk-imx8.c      | 2 +-
 drivers/clk/imx/clk-imxrt1020.c | 2 +-
 drivers/clk/imx/clk-imxrt1170.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 846b8011f5c..b37f9ccb268 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -39,7 +39,7 @@ static int imx6q_clk_request(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops imx6q_clk_ops = {
+static const struct clk_ops imx6q_clk_ops = {
 	.request = imx6q_clk_request,
 	.set_rate = ccf_clk_set_rate,
 	.get_rate = ccf_clk_get_rate,
diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index 32fb949ffbc..ef80952bbbf 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -25,7 +25,7 @@ static int imx6ul_clk_request(struct clk *clk)
 	return 0;
 }
 
-static struct clk_ops imx6ul_clk_ops = {
+static const struct clk_ops imx6ul_clk_ops = {
 	.request = imx6ul_clk_request,
 	.set_rate = ccf_clk_set_rate,
 	.get_rate = ccf_clk_get_rate,
diff --git a/drivers/clk/imx/clk-imx8.c b/drivers/clk/imx/clk-imx8.c
index 96cf5fece75..0e7e646b9e1 100644
--- a/drivers/clk/imx/clk-imx8.c
+++ b/drivers/clk/imx/clk-imx8.c
@@ -78,7 +78,7 @@ static void imx8_clk_dump(struct udevice *dev)
 }
 #endif
 
-static struct clk_ops imx8_clk_ops = {
+static const struct clk_ops imx8_clk_ops = {
 	.set_rate = imx8_clk_set_rate,
 	.get_rate = imx8_clk_get_rate,
 	.enable = imx8_clk_enable,
diff --git a/drivers/clk/imx/clk-imxrt1020.c b/drivers/clk/imx/clk-imxrt1020.c
index c14afdaf236..a36f6baa0f3 100644
--- a/drivers/clk/imx/clk-imxrt1020.c
+++ b/drivers/clk/imx/clk-imxrt1020.c
@@ -13,7 +13,7 @@
 
 #include "clk.h"
 
-static struct clk_ops imxrt1020_clk_ops = {
+static const struct clk_ops imxrt1020_clk_ops = {
 	.set_rate = ccf_clk_set_rate,
 	.get_rate = ccf_clk_get_rate,
 	.enable = ccf_clk_enable,
diff --git a/drivers/clk/imx/clk-imxrt1170.c b/drivers/clk/imx/clk-imxrt1170.c
index bfd5dd6c464..8323ac8bc45 100644
--- a/drivers/clk/imx/clk-imxrt1170.c
+++ b/drivers/clk/imx/clk-imxrt1170.c
@@ -89,7 +89,7 @@ static int imxrt1170_clk_set_parent(struct clk *clk, struct clk *parent)
 	return clk_set_parent(c, cp);
 }
 
-static struct clk_ops imxrt1170_clk_ops = {
+static const struct clk_ops imxrt1170_clk_ops = {
 	.set_rate = imxrt1170_clk_set_rate,
 	.get_rate = imxrt1170_clk_get_rate,
 	.enable = imxrt1170_clk_enable,
-- 
2.53.0

