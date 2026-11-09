Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61485606D803
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vGiPf7hi;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6tsAxD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA802606EF;
	Mon,  9 Nov 2026 04:34:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C4CewrrT2U2X; Mon,  9 Nov 2026 04:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E71966067B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794198841;
	b=JLmHsaZ0J7ajd4AzVt6yTj19yF2fTE9wHDYgvf/lU4LEUcGCJ3M0gJuOnjzA8tIZ0VR9
	 kbld58RsF3ix6cUahOQzh1PEtJp31R4cikEHBbdscN01DJm9Clr01yIRmuOEyp/ai/fy+
	 wUjOdTMPumVu+hd44a5wvp59KP5wIiW3VAYkoEAIk3piym5Sc3OrJmE4l7OlWYHAi9bl8
	 uzvgJYEoUVBjbvWfP3A0/2C8TqVTc0hZaFV/Veu3MaONzhbBLt6ffoS6rLcEWIiRcOCQ3
	 1AkWkuSHyO487BsfdO+DFRMisBgxgWE5F4RyOr/p98q7Z9KM+2jksPEHb7tWjBEeQag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794198841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ZNVqax6pbZXf+kxRN/ZHqOCJC12B8cwYtltkU6Fm40Q=;
	b=ZFZwVVmn5kfStLcLCasJ+EoICRHz7L7+qR/EJ3uWD/OESvMBp8fCGWyPxZgcbx2oKlXK
	 WjQrCGQ/Ls8s+EzsjpgYyVQCFsU1SXap/JosduDq7O6IOt8zZ5uHkomXyL+SPo6uZqP3R
	 PGDddz8kALxOJRXAkrrS16I+4fbKf+PL9Tfki0Ldo6kNHQFbSAmQUauEZYgRxZQjPW+ra
	 u8xocVggKeL0Bna3Yz1SD0NVmzM1MRydGNxuvACewlLH4RnoxFXg/1B8h29DXT4WdKpMe
	 kEAp3umTKiGkYmesjtXA6XPR8vBLfOWPRpF/PVmweeqz0KHwisfHg9Jw2jZMZ7ho1/w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794198841;
	bh=ZNVqax6pbZXf+kxRN/ZHqOCJC12B8cwYtltkU6Fm40Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=vGiPf7hi06v2A+sHWlW4MV8VvRNq/ajVb+gyIhUVfJtQ8ha6Iaq7CV4NwG9ArZa6U
	 8jziGVPZodgY9bquK6cErphbo4bYAgesww/G4VP+BzICuJByWREOltinwUpAP5iHsG
	 sf1Qvz+7pMXElo4pXs7an/84ZXPsWTKbEtkYdi3izrt/Nnv4kmfmqBilNCpHRhXLQJ
	 0re6Mzar6TlIxaYGRQrUYjS7DthycliaR2xKIcWkRxl+F3yPv9LE5jXvR8MKa0JUkW
	 aafAPoJwN1+NZOieoalTFQbf0vHi8BwChGf0uM47IZ5JdLDLgRUhFPeWYFhd4h0UZ1
	 KkBbA2YMDmPrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E71966067B;
	Mon,  9 Nov 2026 04:34:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A7E2235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E498040649
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6y2u3a5CpeT for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C9552405DA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Pl6tsAxD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C9552405DA
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F70043EBC;
 Mon,  9 Nov 2026 02:58:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E7DF01F008A5;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794193082;
 bh=ZNVqax6pbZXf+kxRN/ZHqOCJC12B8cwYtltkU6Fm40Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Pl6tsAxDw2tPHZRx17TVvsidRwIiIGGb/FE/qivDYz69tdudCmYUIii6+z3TEdbJn
 uX0HeE2H7kvLzq3AJvZOtNCdWUCbQUc9ZBuSHJ6kXxRxAxmlm8uuXzb/kMKE4vPklY
 4XwT9r3lymrX2mtKZaWjkZTKx+xsJmYL36DqsYmKm4Jve1GSQv6W/WK2h5lgXaYOhV
 jt0rNrA5QI8gtNrKcM59UU9QuORCY6YNX3aFDJzoKY4JzFwRwjOY9gCpZa4TVNzNQt
 OH7eTzHf6gfNJCsMKDb/L0l2irs3NEL+LF2JN6+HcDuZo014sIgFu/vypk7IGyzP5r
 D6XY0YLdQhtxg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7C25A4825C;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Mon, 09 Nov 2026 03:58:00 +0100
Subject: [PATCH 3/3] phy: rockchip: naneng-combphy: fix RK3588 SATA
 pipe_con1 register offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-rk3588-sata-fixes-v2027-01-v1-3-e54ca8e68f18@pardini.net>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
In-Reply-To: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=Q3Cve4zvVjlX4+VTW+xM72LErIs4mz3VhCpxoPE6y/4=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBq8Ta3M7L0/Nl8Tc5vBtggHZLTrmXK/So4jVgWX
 mdPhxH+Ac2JATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCavE2twAKCRA7Xj/jnsft
 6bEyB/4sTpXpmQEwMi8gaXfvQf53SrWReltxgZ7peZ+wKfSXW7YtOlVnuRLRPTP2a2otGDI/oQP
 Uf1GMjuDwAmt19N/7r22Uz89D4gs1BLNIpwXfm4TFZt9DDkXlSgnbCYbu4c06t5aaAjgz2N+1sd
 smbzYfCjncXzl2rNwPo6xk3PBOB8YmkfY2H1NjWu75QBh4JyXqqjB9mhvqViHfo2zW3sGDJ2xD1
 JxtEiXVDNSMEAL+H5CGskw9ESLwQ7842ce+LJEnU95vDrAtHunkLe0nz9olfNZFViYH6p/i8CaI
 zGK/U4uYhTjho6tVAXxMHL2TDlNwPUCHbRunCPkiAM+ZdG6i
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 04:33:56 +0000
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


