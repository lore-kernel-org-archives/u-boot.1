Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FC606A324
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BAIxBiM+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlBz1rMW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C344D40A70;
	Fri, 27 Nov 2026 13:25:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLjtLCI8nYz4; Fri, 27 Nov 2026 13:25:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BAA5B40971
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785955;
	b=MpOnPe6Gz9M5u6bItf9JPbuUKGcw/qeXcjMSb949FkPdqiDOSKB13iuno3wU0ouS54Ir
	 445arMUJBbMUayNRO/MfQoKpw9xAZdT7yz8Dv0yN7LUTXitxossWjNn8mzuOxTFkZVDpt
	 ikSUD9KGQ8A6eF5v+ubk4XrClzTKXZxCsfdUAdaUgKgvkTr4j3VF8+XEeVEgCaMv7ra2N
	 n05phsImHMxZcBCsPhpfsbGB+8ZMFwHWGidVmp+jI+Bnj6WAJ/oyXkLS2NHpzK3kEhDBH
	 yce0oWWI1SfvP7QQCaZgHYbqWdgf+cXg3Tuh9Sv036TmcYQYNAwhFBpyYQx8k4a9W+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=z1zxFoM1Y4U3urtcvsTRgYOOIprxJdQvvdMc2Rg3a9w=;
	b=XYbRXAylKUe3AqODPmiErOyCLD6ZTvi52I5PDD3llgmJkTTS4+GJ2AdEHO8AWWnl0hdU
	 /z3z9a7Zp4KKrRfQCTpQanDSHCqL8tp7dbBnbtA6LFAVAAVY4fT0df9Y6zbhcQt3SzYi8
	 MTZ1IFIafRD0rY/U+iYTka1dbbr4Rt4GUZTLzEqFOlKElFLGunMw8PlNLwMvzlEMe7DXD
	 xWssta/vlPh/lY6+pjE1/6wP+9Fpng9NENhbnrbVHqHDN/B4MO/NF4FoMorO0jf5eTx0H
	 exoDjmMfdgVwOZ5lVlOZZlxf1Tw+bwX9S4PNxAKOGlq8QA0OciWP3Mpfa7GD28VeC5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785955;
	bh=z1zxFoM1Y4U3urtcvsTRgYOOIprxJdQvvdMc2Rg3a9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=BAIxBiM+Cf5g8kTLq22CTDAxW1j3PQ9r8rYbgzd10jbDY+9Rx1f1rBWK/7k6t2rn2
	 xy+H43A+s/nvVDRh+jIqYm4YR9eTentJFNzO7NvJGZIPz2FF9hA19mYiemw+DSYsqa
	 KL/+9G1ETFqOIYmpjxNSyIb5VeoMGP0oAG+n/Sg2DgTm+Mmv5vJFDojHZp47x4Lajc
	 LwFiXbx7CmVpTPsdf4k9ueUdOBvmdn3pOcqu1842ESx88D6wPjQBmZUxpKBoECL9ip
	 epVejNJFx2Rr0W45HzmVnqWQFPr9NRmU1OUUySVWSARzA6EV5ixrvhyOFSVQ6M8i0v
	 +vtixOlqeu1kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAA5B40971;
	Fri, 27 Nov 2026 13:25:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E185373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6404160AC2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0vNQ0Fh1g4_V for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:14:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 66EBB608CD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TlBz1rMW
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66EBB608CD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C52A844718;
 Fri, 27 Nov 2026 13:14:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4587D1F0089B;
 Fri, 27 Nov 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795785256;
 bh=z1zxFoM1Y4U3urtcvsTRgYOOIprxJdQvvdMc2Rg3a9w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=TlBz1rMWllC40KcM1GSbCVLzVszoDUPqKKLFMdY5xSsIx0YrySBMMFJSgddu40cbW
 i/BOEfMK/718WzdGUhYS1cqmRyILLXKAFeesuDNqYtKUbhC6sJglFycOcb/XryPmg0
 pYIWKbNxVjNGHgklNVHatkhaOXWWknm6kCgYU+2ZIu7eH9ZHtponmjdBbLeGgcsULc
 hBYzJK8YoXYNEP+tr0dlnrGJ+rOwCUX5Vxc5PCM1SzaAsSOWKo/Jc0CzoC3G79q9w0
 jhjpTJgpnOEMllzUHPWyPEbya9kwy/O7Y/y+THy+kzkzLJFvSKESqtXUdPzG7/UVTf
 eXACtmlSQ8TWw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CA33D4B7EB;
 Fri, 27 Nov 2026 13:14:03 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Fri, 27 Nov 2026 14:12:59 +0100
Subject: [PATCH v2 2/4] ata: dwc_ahci: get the PHY from the sata-port
 subnodes if any
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-rk3588-sata-fixes-v2027-01-v2-2-dbdf7770972a@pardini.net>
References: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
In-Reply-To: <20261127-rk3588-sata-fixes-v2027-01-v2-0-dbdf7770972a@pardini.net>
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Eugen Hristev <ehristev@kernel.org>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ricardo Pardini <ricardo@pardini.net>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=jMc4maRHATqvBOpmaGWwi0WL8TS7p4hi/1K0YzF8JMw=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBrCYIZr4XAedgn/zbutvGOIHKJStkEhdoInLmn+
 Hnyk8b0U/WJATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCawmCGQAKCRA7Xj/jnsft
 6c7TB/4+K5mHIhzPlYF2pg5uasJmt1KFvbbnPSoXXW6foxl+Pr0AOYqXo3KEMcLaHkiZsH1SPbY
 KttVq8b8OFOHmIKTGl9q6WtkEYa/2PXFEtUIxz5RHRJA8lVzFVPKcgkqaG923dyPBjKOO8ek30N
 C5A+toyoTtQcXlhmz0Wu6zS9qG05toSRSIcuq2jYufIEiBiUm1i+8HTFUvCFtbb4S6awmUYjtQf
 McDnLoyjzxGGmgfGxVeTJ236+B81swez3kMhe3SA6itBBq8ZFSC8BNBR/iN+9aa9E1Zy80yDcjg
 bXqBguEkay8jf6GPKRTRDNiVo4a4GRpQvuzeMUSWj6iFU7+p
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ricardo Pardini <ricardo@pardini.net>

If the controller node has sata-port subnodes, take the PHY of the
first enabled one instead, like Linux's libahci_platform does.

This fixes probing on RK3588 and on RK356x sata1/sata2, whose DTs
have the PHY in sata-port@0.

Link: https://patch.msgid.link/20260201191804.41421-2-heiko@sntech.de
Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 drivers/ata/dwc_ahci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index 138a025cb02..97315441950 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -55,8 +55,20 @@ static int dwc_ahci_probe(struct udevice *dev)
 	struct dwc_ahci_priv *priv = dev_get_priv(dev);
 	int ret;
 	struct phy phy;
-
-	ret = generic_phy_get_by_index(dev, 0, &phy);
+	ofnode node;
+
+	/* Like Linux: first enabled sata-port subnode, else the controller */
+	if (dev_get_child_count(dev)) {
+		ret = -ENODEV;
+		dev_for_each_subnode(node, dev) {
+			if (!ofnode_is_enabled(node))
+				continue;
+			ret = generic_phy_get_by_index_nodev(node, 0, &phy);
+			break;
+		}
+	} else {
+		ret = generic_phy_get_by_index(dev, 0, &phy);
+	}
 	if (ret) {
 		pr_err("can't get the phy from DT\n");
 		return ret;

-- 
2.47.3


