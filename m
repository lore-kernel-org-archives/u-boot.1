Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93F606A330
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OPs2mjtC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UHhmf/lT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAE9280E29;
	Mon,  9 Nov 2026 04:33:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBRjuIzng-yq; Mon,  9 Nov 2026 04:33:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A20C80E33
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794198839;
	b=Xuso5krsMu0fPvLyFq9X+W6leIR63pNN+3jl3/BewO5Ygemudc/5GvemvLdK2wcfEP49
	 j5SXCJkGxRAEIFbdwC94xBwqEfTm/cZfhLLl2z0EmSxe4nHK6YAQ2xvND3xbr02A95tHD
	 cbcAteAr2xX5BBzwUouSNZ0hy8TV6u5oAWbdzpiL+5WpzdJFyoSz/wcozsUmYgvi809A9
	 75cBTCuwayDWY0xNAkl/hmwLAzQOo+VNAXIiBOADoDruFEuKHxsnm3TR5idRu29u7GkU8
	 SAD/nkny6rgETpOWj7Wpx8adElJjn9IiAsPr1Yuo8kMTFUZ2yPCTvJyrTzGQdKzfx8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794198839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=IpbVpJbKKBbzTjKssEETRs0utZYDS/U5sVpbvzPF2Kc=;
	b=gRz3nlSyM+GUzAkoU5aBCODARI7an0bb+Ey8KM6+/ag/OA+BFlBGcU1OEjKBVD5L02Wq
	 oDRoGyj1rytNN9n+wuWcVkKVfIbLngKAH2f0bZdJ6+MV/6KoqKzaICXTSLm1CUculNhNd
	 u9wnq/vxIzQTQtW1oyomDWTNnrOBEAVDr8HmbDVXFsZwsot+shiIApr8w5OqERIB4VqLP
	 /HRkFKAfdFeUqeQ90WLKt3JfZLipId0kjhp4SaBuzkcig6Sv2tVhBF0m2D1FJSKknPJFA
	 fkHOhTbsc3hZVGyTiBLWl7mTD4LmEla+CPGH7pbQnBQj9Sol+e2Aq00GHYWhPb9w0ig==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794198839;
	bh=IpbVpJbKKBbzTjKssEETRs0utZYDS/U5sVpbvzPF2Kc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OPs2mjtC/vOOSUG6X3iWxp4YJHdLxqmNQKh7hj1s/C93uDWqf7ZrKBATi/3NJijlw
	 lM4a0v6UNxZlGcxfZKVk2fw2o4A2ec6kxY1h1l91WxlkU6zoHGjZOSUwE5+bvPbqIq
	 F5ePxaPgwq6HvNPiLoEZYkzGG99dSoOK2QoBmuEtTT8xxHl++B1/BO2jn27Ga9UEOX
	 hbf6/2qz8tdfkIwVoDxiWr3NReE0svUnJYBLXrnnFF1u0U56fAxL5x2Q0Co8Tid8CY
	 yoTm0f39sHN8cnlK90mJNwCyegiW8oVJoO4PuqI4ZnvuyymfOAIF+G5luIViqx7K/r
	 7TpjWc3rLlVGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A20C80E33;
	Mon,  9 Nov 2026 04:33:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB12B235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC6724010C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X9FOnGm44bMF for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 02:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BD30640050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UHhmf/lT
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BD30640050
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 02:58:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EFF943E2C;
 Mon,  9 Nov 2026 02:58:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id C86C51F008A2;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794193081;
 bh=IpbVpJbKKBbzTjKssEETRs0utZYDS/U5sVpbvzPF2Kc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=UHhmf/lTHzuFMEZSNMeFFqMUBCzR6S6WE773fa53sMz7WMt/BQDH+C68ap3sh+TWT
 g/6owVqD95jsAW/J81eIe0s6u8RV8b3hImi6vSCjqm/9+pDGSaiLTiAiPfkBtSO8MX
 pow9fAEdNNV09b0zYgLNOlNQDr5de3/ptOrfqzxCCknL6BALnhXdazBuXpr2kyDGFS
 bGItrXVB2AkX1kpLxr6k8lBLlpr/WqIhwHpoxYlJI64JhhoZcC9aqbvhbzz/vsL5+U
 OsbSavGj9EsrKTb3POsVNAkLJlxDAMPXVPr9kwXHs/f6sSLaSz/kgCeS/LZqfSJSFh
 P+gAZWbxEvJ5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5C4E748254;
 Mon,  9 Nov 2026 02:58:00 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Mon, 09 Nov 2026 03:57:58 +0100
Subject: [PATCH 1/3] ata: dwc_ahci: fall back to the PHY in the sata-port
 subnode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-rk3588-sata-fixes-v2027-01-v1-1-e54ca8e68f18@pardini.net>
References: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
In-Reply-To: <20261109-rk3588-sata-fixes-v2027-01-v1-0-e54ca8e68f18@pardini.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, Quentin Schulz <u-boot@0leil.net>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=MaeLlyyV0DUNr5n18iGh2V4/rzNY16Gc/0SxdTgALc8=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBq8Ta2QFu+kMlaujlh6/ILQtN8GTlD9BXkRahpn
 LdtUN8+XEOJATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCavE2tgAKCRA7Xj/jnsft
 6X+/B/9Eb49J9eYxjoh3TTf7jju87NXs2+0/mHdxdGH63pu2XpcUN/2bmw1fVBi5obe4+MwolyG
 znD+sQDJ88egIFOXM9FD+LrSMK1KeeVbwk8hUqzF8SXq/K5pvwafbXboj1CMRDrAMhh/N0DrN6T
 cCkWhT0mu8/1x4KiINqm5AIt0N9PgMWjK7D6kHyjNyRXZsMx8Xp2yjKJlA8vmrJ7/tx9jY/VKAB
 ZYe/4inRUTwMQZ2AKORg4hMYuPNeL8SnuAzjDIxCpGXU20XmJdCy/SCUiZdXaZVJrqtFYflrPbw
 YVFR4qQvcWZC0qKS2gN8uBejtw2LzOnP/JczBjUgSBLCOnFL
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ricardo Pardini <ricardo@pardini.net>

dwc_ahci_probe() only looks for a "sata-phy" PHY on the controller node.
The RK3588 device tree, as synced from Linux, describes the PHY in the
sata-port@0 subnode instead (the binding allows per-port PHYs, which is
how Linux's libahci_platform consumes them), so probing every RK3588
on-board SATA controller fails:

  => scsi scan
  scanning bus for devices...
  can't get the phy from DT

RK3566/RK3568 sata1 and sata2 have been affected the same way since the
v7.1 DT sync (d0a838bdc62), which brought in the Linux change "arm64:
dts: rockchip: Add port subnodes to RK356x SATA controllers" (linked
below). Only RK3568 sata0 still has the PHY on the controller node.

If the controller node has no "sata-phy" in phy-names, use the first PHY
of the first enabled subnode. A "sata-phy" that is declared but cannot
be resolved still fails the probe. Only one PHY is brought up, as
before; the RK3588 and RK356x controllers have a single port
(ports-implemented = <0x1>).

Only tested on RK3588.

Link: https://patch.msgid.link/20260201191804.41421-2-heiko@sntech.de
Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 drivers/ata/dwc_ahci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index 0431d370716..8192d2f5f34 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -57,6 +57,19 @@ static int dwc_ahci_probe(struct udevice *dev)
 	struct phy phy;
 
 	ret = generic_phy_get_by_name(dev, "sata-phy", &phy);
+	if (ret && dev_read_stringlist_search(dev, "phy-names",
+					      "sata-phy") < 0) {
+		ofnode node;
+
+		/* e.g. RK35xx: the phy is in the sata-port@N subnode */
+		dev_for_each_subnode(node, dev) {
+			if (!ofnode_is_enabled(node))
+				continue;
+			ret = generic_phy_get_by_index_nodev(node, 0, &phy);
+			if (!ret)
+				break;
+		}
+	}
 	if (ret) {
 		pr_err("can't get the phy from DT\n");
 		return ret;

-- 
2.47.3


