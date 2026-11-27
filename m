Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AD606A324
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TrCNDsRb;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fqf6Ibot
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6357981235;
	Fri, 27 Nov 2026 13:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChR9HqwxBetq; Fri, 27 Nov 2026 13:25:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65A8281231
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785952;
	b=eeBkeErzF93viM3Z+CjSTzM6otrAppWFpVQF211Qt/BV8ZQGoESYsln3VaYAMK7yZp8M
	 JDn8Ce05LAWDZqv1Qm7E2iNjBqTqSxt8Gu/JVE11QSYK1Z569Zqsr6Ww+SEAHSQJgPaHf
	 FTdpvHCRW+aSOPolV7jRVsyQ+uRhfVkZ1+iL0hMmyfgsVonSliCkDu43C1QprhAg1F5Dz
	 2vXGLyC4GX9zHE7cXidSkN29kxN5mNNtFbSUnQGZypwEh3G2E70FaA9tYycp/otLE0sh/
	 6wq1Gge4RoKtykSxML17/RWN8gQm5BxrIQT9atEAAint6YL0W0vSvD9Yv1QGl0pne7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=iv/C1Md8Jkg3uZRAnAoyiNUsyo4Gx2Lf/xt+9Ib5idI=;
	b=bOU+MDOzrf7Z5JbGE0u/BFtlMqcmfEF0zcaEgQasFquYHVLBDZf/KPZaKuZrcpyXs5uK
	 JrLuA1Ro8GK/51XeVAWE3aHatPiSo08UYBnoP39gElSGwtOo/KqqesmVtVZY5pOSwQK7h
	 rgVs+rdSRgm4NeV1RjcBHzxk8PA7V/BtQpm791yBA1UH+nuDnI4FEJZbop2Cb+tt52eZs
	 Gm7XU4lRnsmQ0wpB6BI/EBJWq1Wj4rmROnuUFfq2SAT8Q/YrY1zyvk95mm80D1wLpcuh1
	 ESgVqc21WeYGObEgN6yJhBL7DX64/3gjVLCMBeSdjYpdPmVAzNkOQlmESanSYbklPfw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785952;
	bh=iv/C1Md8Jkg3uZRAnAoyiNUsyo4Gx2Lf/xt+9Ib5idI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TrCNDsRbis48AgB5bqfjU7XaX2hKYyCfl0X3RjaJ2ijdOefEehbrOS+nKOUkUdc5s
	 +TGRBzvq5AhLaPtElP3yRvniE9+xiLcmnGvrjVN6MCHWp39In/l1GfTUu5VxmtTjkE
	 4uQHEKNqReoovdvIvWJaIst6QXCloyW3nqaakB6L6KgX5Z+p0LH+JG6uVYehnXXco3
	 K+6KMtC+tkzHKr/bW1Majez0EY/X2N6qB4nbuiq8BoAiVATq4UsIEhj2kvhj8w8J6U
	 Kq/WmgL7axNmNIfiUS6cDqrJX9E33sBXRRKpi6y0T+K2wSYPqixyZGYJp1f7CJQDko
	 Zn7ywNei4VjMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65A8281231;
	Fri, 27 Nov 2026 13:25:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D12DC26D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C235340A34
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LjZ60FksCrdu for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B3D1E40A29
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Fqf6Ibot
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3D1E40A29
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5739C61FF0;
 Fri, 27 Nov 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 85F971F0089F;
 Fri, 27 Nov 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795785254;
 bh=iv/C1Md8Jkg3uZRAnAoyiNUsyo4Gx2Lf/xt+9Ib5idI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Fqf6IbotHZrO7GciCPEIfJeCiI4TS8qB2oaEIfuGLpZODiQ0nwughbJJZ/gUI0CkD
 FfW2hnEa0/mQC0jouQAJdj0o9Gc5YgRW1vw8EeBZKE/FwHrmIhoNRyN7JclaO8Wblh
 +i4P+F8HViShxWOQJZDqDh1+wRSuEDbtC12bxLeD9nQQvzEZbW5f03zuMXxQ18RY30
 PLibtzRLO1naV1FtGe80j0Y0qbhDzwAAyPeUZsbszhGsvODI/ywt9uwbfpEOX5ZzIe
 pdLec8ulQcQK1ia5RrZK3q0HPthHqmjjxfAozfpfGW+81K0D31x2Hp8Ty0yOCEjSTk
 SXB7rAxwuYnNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 13C454B7F3;
 Fri, 27 Nov 2026 13:14:04 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Fri, 27 Nov 2026 14:13:01 +0100
Subject: [PATCH v2 4/4] phy: rockchip: naneng-combphy: fix RK3588 SATA
 pipe_con1 register offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-rk3588-sata-fixes-v2027-01-v2-4-dbdf7770972a@pardini.net>
References: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
In-Reply-To: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Heiko Stuebner <heiko@sntech.de>, Yifeng Zhao <yifeng.zhao@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=eZHwcajI2cNPqesoEfLVtK/QAE2stGltMbnHnZInN6g=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBrCYIaetdCtRgFRY3SJUEzlrNkWh2N796FOHBcb
 X9hzDQh1E2JATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCawmCGgAKCRA7Xj/jnsft
 6RVmB/0cP06njBy34ItpfS5vdZ0+HImWHKnYw/NcGXuiEv1GT5DtD3fhjt67ix1hNnwKpqbXBhq
 CS6mB7SDHQKyYJTfjXuVPwL3To/BHLH8K3etYA/rVWdJ2CTCIrOMrPZsQ8zPvgvPEUZ5H3bKRm1
 KbFDg+YSxssrkWVEwRkFDWJuAiNQ4HcQkpUQwaLHDyzaYQ4ymzINsiyPBMneSv43qCNGFOAJ2xN
 wME184Q/t0yDLlYrmMxqfa+67dXbedK/FYc742subJmaLQVPQalHZEoAen3x3UXruipXSetaCoJ
 xBONA58ilFFrcZ6WVLTBDDwOOY6o/4ZHUsihEeMMFdR3S1Oq
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 13:25:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: ricardo@pardini.net
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ricardo Pardini <ricardo@pardini.net>

On RK3588, the sata2 PHY speed is selected by sata2_phy_spdmode in
PHP_GRF_PHP_CON1[1:0] (offset 0x0004), with sata2_phy_rx_err in bit 2.
rk3588_combphy_grfcfgs has pipe_con1_for_sata at offset 0x0000 though,
so the value 0x2 (6.0 Gb/s, rx_err cleared) ends up in PHP_GRF_PHP_CON0
and CON1 is never written.

This leaves sata2 at its 1.5 Gb/s reset value, so the link only trains
at 1.5 Gb/s, even with a 6 Gb/s capable disk. sata0 and sata1 are not
affected: their speed fields are in PHP_GRF_PHP_CON0 and are set by
pipe_con0_for_sata.

The register layout is described in the RK3588 TRM V1.0 Part1, section
6.17 "PHP_GRF Register Description". Rockchip fixed this in their BSP
kernel in 2022 by moving pipe_con1_for_sata to offset 0x0004; the same
fix was sent for Linux.

Tested with an mSATA SSD on sata2 (combphy2_psu): PxSSTS (0xfe230128)
reads 0x113 (1.5 Gb/s) before and 0x133 (6.0 Gb/s) after.

Fixes: c5b4a012bca8 ("phy: rockchip: naneng-combphy: Support rk3588")
Link: https://github.com/rockchip-linux/kernel/commit/2f5fe2c0bbd4fa95102aadd60da1100989103aa0
Link: https://patch.msgid.link/20261109-rk3588-combphy-sata2-6g-v1-1-e9135c91de6a@pardini.net
Cc: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 82353ae7678..675401e085f 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -727,7 +727,7 @@ static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
 	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 11, 5, 0x00, 0x22 },
-	.pipe_con1_for_sata	= { 0x0000, 2, 0, 0x00, 0x2 },
+	.pipe_con1_for_sata	= { 0x0004, 2, 0, 0x00, 0x2 },
 	.pipe_pcie1l0_sel	= { 0x0100, 0, 0, 0x01, 0x0 },
 	.pipe_pcie1l1_sel	= { 0x0100, 1, 1, 0x01, 0x0 },
 };

-- 
2.47.3


