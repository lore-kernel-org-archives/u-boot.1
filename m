Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB4606A31C
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EZBmOHr3;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=IKZh/B4l
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0AEB811D4;
	Wed, 11 Nov 2026 10:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBz6EZqrMvwf; Wed, 11 Nov 2026 10:13:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F0E31812C3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392021;
	b=meSgbEB+AD+kyIcmvHnMKc7s2nOxvhcPyOgIIe8ZmwQvOJoWdB8z3MwjyTEOtBQ1SpfE
	 VAAXP3NXSTbQ6iR+FADwX5WnX6JvALv+ZAJ1DIN534vbPl/3bhIf/DtHStlh8Auufwv2u
	 tYUnCeJT7V+gjm5caUD3N0VeeoYwiDy1lIL8OBPUAzryYi030hiPaQNdo/n1AkufJ8K8K
	 Tbkfc6S08Gj5cXhCWNEXh2oG4XZkij4tv1DWmMpWcA7MX4Eymmkkapy0NNFA8Ukn7fViv
	 EbWP3BzDrMzw5PAOT36whqUpvH7NEhhg9lRIgxTHVV9U4HxfgNT5K6i/UV9/JXiQj5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fP+uLsGOH9bs4t+jbPbku8Eu/Wcn31m5YvRwPTkPLEE=;
	b=i4sFz59eoyhjzF/sifCrfiKSN+WC0o8h8BEKhmNR8WJ4TSRUZYXGRmj1EgZKM35zL64S
	 uE4/hd921SFAIDptTJHJf9xC9o8LFzbQPFOPZ1Tu5ldcNa2NxYcGUDrvBXY8DHGRdzHPp
	 CoOULuikZd4pg/p+I+rMBThq8Yt6js7m3PkPk8NHqyXpFuSxu8BsJIHaNtyP2Xb+QMvaM
	 xyJdqC44twcBVWK9wzmqZRBPKqOnpGbed6KdA9v8TvQI6EtXcnwjQh51oXs8qZqEIr5Nb
	 MFpx5zJSYlByCeNBJatpQUSJFc2ShBZWOi3f0jFK0e2xdlugjeabYnuffQvG+cirwvQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b="IKZh/B4l";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392021;
	bh=fP+uLsGOH9bs4t+jbPbku8Eu/Wcn31m5YvRwPTkPLEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EZBmOHr3t6BIkfnAp2Mjd8gLiFWL634+eW7RFHhvXSfk171uVUEDUTWfN99kYWR07
	 q62ib51ubsSFKhSM3Kh+D1pdVLGXL91kZn315UuOFsM7hRLQGxr6TXWF53Oxs4Hcmy
	 IgUj94qVYKK0Ke/KQVVaZv2oflk5ywiu7c2d3viiC8gv43OC7bTWX7A7/ApqhMscW3
	 uO+bKCN/8fEEO5QZzcsMhJH17gCKpmVBGpfs3pMgpML8nV8o82NUnCBudXe+DyNjod
	 7HKopIAJWY8qwkpPQYV3uPQzNgmVfcDfyzmXFvks5JlkNYjbhwgE/csc8AnfWmskk+
	 W0ADLSQKUG9dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0E31812C3;
	Wed, 11 Nov 2026 10:13:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED3BC17CB
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA1ED811D4
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrO3o4rlLCYj for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 035C781200
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=IKZh/B4l
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 035C781200
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=fP+uLsGOH9bs4t+jbPbku8Eu/Wcn31m5YvRwPTkPLEE=; b=IKZh/B4lmCfNNrMQrVnck5WmXv
 9pNt8QpOoL5fR37KX4moRANusah2Zl6+RsfzLk6uP55kkYtJe4vXhaGoT27TkYCXkDDB0PEyCmNBc
 sGYOlmgssAmhcuds1hFIlbOaC2ylbakmj42vN84abCv9V2ax1iknX1WnYHfE9vyoAfcq2O0q7PnXV
 fYrxIPNjPVFnlT6/zQbQBm0Nb/i4G7NXqm1HPXCRDSxSlEfxTq3XGbxHVQqUZmCN31zCOD1/gmBBp
 bWYu+8fz3w3pJaFYpWoE2aKJkrIxja8AkWTgcVtw0xYxPS8U0VCMqzYNoVpuQ3Dnx7/e5q0z3hFhJ
 If7CY6xA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KW-0004xK-2L; Wed, 11 Nov 2026 11:13:24 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KW-000Lq2-31; Wed, 11 Nov 2026 11:13:24 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 4/7] power: domain: imx-gpcv2: do not unconditionally
 select CONFIG_CLK
Date: Wed, 11 Nov 2026 11:12:55 +0100
Message-ID: <33d3be328fa3427a74b019244df847aa535f90ef.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
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

No clock is needed on the i.MX7D, and currently no clk-imx7d driver
exists, so CONFIG_CLK can't be enabled.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/power/domain/Kconfig                  | 1 -
 drivers/power/domain/imx-gpcv2-power-domain.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 40cc30961c0..2915be0fc76 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -36,7 +36,6 @@ config BCM6328_POWER_DOMAIN
 config IMX_GPCV2_POWER_DOMAIN
 	bool "Enable i.MX8M power domain driver"
 	depends on POWER_DOMAIN && ARCH_IMX8M
-	select CLK
 	help
 	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
 
diff --git a/drivers/power/domain/imx-gpcv2-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
index 2fc5bf7613e..f61982df60f 100644
--- a/drivers/power/domain/imx-gpcv2-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
@@ -517,7 +517,7 @@ static int imx_gpcv2_power_domain_probe(struct udevice *dev)
 
 	/* Grab optional power domain clock. */
 	ret = clk_get_bulk(dev, &pdata->clk);
-	if (ret && ret != -ENOENT) {
+	if (ret && ret != -ENOENT && ret != -ENOSYS) {
 		dev_err(dev, "Failed to get domain clock (%d)\n", ret);
 		return ret;
 	}
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

