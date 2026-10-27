Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB3606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0iyOW2sm;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=HsO2geJP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9586405E8;
	Tue, 27 Oct 2026 09:40:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q59jkHiGzkeR; Tue, 27 Oct 2026 09:40:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 05E674062B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793094021;
	b=D1doQ9ZutdNYMLD+IQ3piP0iQp+k9x3d8KhUYn1rDU3tVu13b+5uxWU98mhIwiOGLhp+
	 oYjHjj+ikGL0WxyM3Jk2/c7JF4a/sEo1BUQr5AQ0g7glXYYCZZofvHMuFnyI66p+sC+vH
	 qJe0vBa0wnAp1iypkAjy7J71TYKCior21ltPhBYhMHnhLvqNoudxzXW1iwkv5duOoGEIh
	 2s7NH5aPm0X2G1OimmovBcHXuLYjCBDQQbZc27TX4hbVwzMTWCJlueKejckLHWhcbFgFY
	 3+p3rgyi1/GFQiulhluT2JMeUTbPySulGBEFHLaoYDzZdT/XTvgvv7XN/oOHXgDYn0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793094021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XiHMD2zABgI3+ZBdUfoIaN1oqxXRmSTs9ZLOz04V5a8=;
	b=honJh0rP9mdsV464TmgDiGwsmOGZQV5CQl2QoKSAM0U0panDi55/uChVg7WzFj/4Ppte
	 FxWC8M0x86S2xFLDEwy5tPcCNEIDPqbIx1SMKidG70YmkPRQfa1Egen07o3FbZgexIkYy
	 U//oVsDQI4RN8O/sc0YsyxV/siKoAB0yrv9BsXzBIZLHInBWBTijgW7iW994nrgZownry
	 Uuc3ceDFm0BDD8UV4yyc2s4UeiIIs8bJ2dW/us+4WP8q2M0d8n8Jcpk/7v67pbg9qNpuh
	 MiToD5q5J95RoHLwUv9t56HSF0LoA+d4HiMucPfB7DDVZ6/xM2AWgzDAplvk6VeOrig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=HsO2geJP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793094021;
	bh=XiHMD2zABgI3+ZBdUfoIaN1oqxXRmSTs9ZLOz04V5a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0iyOW2smf1f2a6PDR/RS5MH0AWDKC299no6hDJzYsimCubbgFu5Z+7JnTmn4m3yX/
	 jLzS8Tk5VU9M3lhbOTtUXcgm22Mq9JGFLs2qTi6M7TK2Q9XyCzq/UG+pG9vwIu7ip7
	 azHLjHiQrGQIS/BesLg/8PEPBp0QyWv8nGA2bQG94K7H9MC7oBD8OoYUcxjOqlzEZ4
	 qTn9edtFOySIbvSFChSxWeTaN0Bm5QFpx5T86sWELyp0DbPUCPWKEzF6U9A45dxgqb
	 lBG4xUx1wXJaEKqASPUDa731Ig6Z51SSfQF0SRT8T76BNQXrHeJRCymP2jmGAXGv8b
	 zPNqUMhNUBZow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05E674062B;
	Tue, 27 Oct 2026 09:40:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B4671DE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 019BD40636
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9DFP8Jvk7kLz for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 09:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C350A405E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793094018;
 b=cAZbMbx7d4E9TqpEe+UGYmp18bcw4Lk+KrBLMVF7/9Uzq6FoQyEWH217P4WdYlEZvabA
 ByPuKb1WZRryTb7SSBQ4iATxBdXz/iiwpQQLRVtAchRQpUjwD6huZ5CxvLvewAfTv6HSX
 GLwuQ8l3yk0coBM2bpLvsUc4Cr97Bz8e9mmRW3owcw51jqy7HVLoZjVoPxiW33jLcWrWZ
 O++zIjZggoic3O5Ncf0QdbbZ/lLVSupKO48AqxEKkyTDMNaiyRSejmVWREZZRZRh8fIHO
 P0TbhRi4bGYbWhoAoHAy0AukNGY1zxqJ4K4IM3mh0Ko+JGi6YZZTqG51TP//2ININxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793094018;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=XiHMD2zABgI3+ZBdUfoIaN1oqxXRmSTs9ZLOz04V5a8=;
 b=gvvG4sCWeI86YPFr8nA9r931/cOSR2V4cDUqcAGuFKWkolK5bKOfCPKC2l0EPFUG6x/I
 lrJFSBsYtHt7Kib/zvDzFOpyGbgTKW43QLq8C/nrBTfP8NIIVnVa3fNGdywn7B3DY3Y1d
 OYJQ2b1TlY+7GKsyu5pJVy84hw98aAMm7KAYRfI/wd4t29w8q0mW2CgTZ6Z+eLZpJc5Wb
 IPO+3jD9E0T3CVRsuCaOgWJzFdM270MceXY0O6WJ0cQrEArXJSD0TbDmkc48+Vx3Rf3I9
 QydR9Dt+pVT8BzrCSeKxvAuaCpIniKyo59ak1TQjxBbf5jPeZLw4skCfwF49pLYAI7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=ew.tq-group.com;
 dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=HsO2geJP; 
 arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=HsO2geJP
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C350A405E8
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XiHMD2zABgI3+ZBdUfoIaN1oqxXRmSTs9ZLOz04V5a8=; b=HsO2geJP3zHaHpLTYCpvF/XeRQ
 uJxwLsZ2ul+svvKip6vQ3UlsfBC5C/sC6ZYN72oS/4SSiithIW//NJkr3/3jeZxXMzmq+7+rTND1l
 cV9XMsdVhyIhrj9W+AIiKEahIhvNXARbxUesfFDDreG77d0onVuPDvQAC+TrTd9FQlxhqe8tbhWo7
 zsanQY8dKutuRy7CKEXpawMGkFuxh93hEBzhuPvCFNHxiOy1vz3SLoZsOBoN7GcN5p6qQmf+L2fkr
 MgLdu2TfRKXJXecODkY22TteBSypfI+lcDJwt/nN4yUIUDlJfIBGEscMvNGviUqSxMNAaSrTCxOUj
 FCIFMnUw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfC-0007Tr-3D; Tue, 27 Oct 2026 10:40:15 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xLdfD-00022y-05; Tue, 27 Oct 2026 10:40:14 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH 01/16] phy: introduce generic_phy_get_by_phandle_args()
Date: Tue, 27 Oct 2026 10:38:58 +0100
Message-ID: <c8c246fa2b1c756456ae629626972ff649c6c12d.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28166/Tue Oct 27 07:24:12 2026)
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

Add a generic_phy_get_*() variant that allows the caller to resolve
non-standard attributes like fsl,usbphy.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 drivers/phy/phy-uclass.c | 35 +++++++++++++++++++++++------------
 include/generic-phy.h    | 29 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
index 6ba4cc593df..51256b30247 100644
--- a/drivers/phy/phy-uclass.c
+++ b/drivers/phy/phy-uclass.c
@@ -137,25 +137,14 @@ static int generic_phy_xlate_offs_flags(struct phy *phy,
 	return 0;
 }
 
-int generic_phy_get_by_index_nodev(ofnode node, int index, struct phy *phy)
+int generic_phy_get_by_phandle_args(struct ofnode_phandle_args args, struct phy *phy)
 {
-	struct ofnode_phandle_args args;
 	struct phy_ops *ops;
 	struct udevice *phydev, *supply = NULL;
 	int i, ret;
 
-	debug("%s(node=%s, index=%d, phy=%p)\n",
-	      __func__, ofnode_get_name(node), index, phy);
-
 	assert(phy);
 	phy->dev = NULL;
-	ret = ofnode_parse_phandle_with_args(node, "phys", "#phy-cells", 0,
-					     index, &args);
-	if (ret) {
-		debug("%s: dev_read_phandle_with_args failed: err=%d\n",
-		      __func__, ret);
-		return ret;
-	}
 
 	ret = uclass_get_device_by_ofnode(UCLASS_PHY, args.node, &phydev);
 	if (ret) {
@@ -213,6 +202,28 @@ err:
 	return ret;
 }
 
+int generic_phy_get_by_index_nodev(ofnode node, int index, struct phy *phy)
+{
+	struct ofnode_phandle_args args;
+	int ret;
+
+	debug("%s(node=%s, index=%d, phy=%p)\n",
+	      __func__, ofnode_get_name(node), index, phy);
+
+	assert(phy);
+	phy->dev = NULL;
+
+	ret = ofnode_parse_phandle_with_args(node, "phys", "#phy-cells", 0,
+					     index, &args);
+	if (ret) {
+		debug("%s: dev_read_phandle_with_args failed: err=%d\n",
+		      __func__, ret);
+		return ret;
+	}
+
+	return generic_phy_get_by_phandle_args(args, phy);
+}
+
 int generic_phy_get_by_index(struct udevice *dev, int index,
 			     struct phy *phy)
 {
diff --git a/include/generic-phy.h b/include/generic-phy.h
index 567dd3974ad..2dbb120a188 100644
--- a/include/generic-phy.h
+++ b/include/generic-phy.h
@@ -360,6 +360,35 @@ int generic_phy_get_by_index_nodev(ofnode node, int index, struct phy *phy);
 int generic_phy_get_by_name(struct udevice *user, const char *phy_name,
 			    struct phy *phy);
 
+/**
+ * generic_phy_get_by_phandle_args() - Get a PHY device by phandle arguments
+ * without a device
+ *
+ * @args:	The resolved phandle arguments
+ * @phy:	A pointer to the PHY port
+ *
+ * This is a version of generic_phy_get_by_*() that allows the caller to resolve
+ * a phandle itself, for example to handle non-standard property names.
+ *
+ * example:
+ * usb1: usb_otg_ss@xxx {
+ *       compatible = "xxx";
+ *       reg = <xxx>;
+ *   .
+ *   .
+ *   fsl,usbphy = <&usbphy>;
+ *   .
+ *   .
+ * };
+ * Here, the PHY is referenced using a vendor-specific property
+ * rather than using the generic 'phys', so it must be resolved using
+ * ofnode_parse_phandle_with_args() and then passed to
+ * generic_phy_get_by_phandle_args().
+ *
+ * Return: 0 if OK, or a negative error code
+ */
+int generic_phy_get_by_phandle_args(struct ofnode_phandle_args args, struct phy *phy);
+
 /**
  * generic_phy_get_bulk - Get all phys of a device.
  *
-- 
2.55.0

