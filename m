Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC369606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O2q1xGmM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GD0EOyaV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D5C260AD7;
	Fri, 27 Nov 2026 13:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XghCuPS2iljv; Fri, 27 Nov 2026 13:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CD8EE60AC4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785949;
	b=Bi6E7webRSrEHtLO3V/CmiZMQuzgQUzUga81L2vRdy2+EKsyldnr/QDZjtSAJDebB3ia
	 ycD8Yrj4Nq2GMYjuylfWRzfZ7JtdNwaCmT8CUsacnpaK6dOWp2zCXjepQ0XgLQPUe3sl7
	 OyBdm0lQvJWPleQOc0ax+ZO1Ln4M/PZiWP2IcJnxaqdXHiS+jKzNxMiSdfgN2YhVR1lSi
	 bxavTzeUPb16ciy2AETKarzTezZcH1gZ3bANnQ6b0enE6Xot8Vob9ZEOfwS7gFn21GKjI
	 3K5lYDA0Tf18gb/PXIG4SckuGFwTdM/sfsJy1yhtE5O7jtA2no/gRnI42JA31eXeHEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Kul2tDFaddDXBMm8LU7LDTUDEipHxaBeW2BNFmvgmv8=;
	b=XtXZ+Lpnsh5MpUfyuw/UGMcHyIOnhFy5//CXDQTdzE2mAiI9thhAOqT6aFXwqdnZCYyL
	 n0bPx3NUC6UMcmgW//DYkFmm8pItOfL2A5fl4Uqxlp+tBE8nLHrpYt8YGkXeiiyDuPWCm
	 55JKJ2EJ6ODXGUMuhnXhtX1e1Kg2mfFYRfwvNPznX+Cn0mjP9QX4QX0yFtbE/xzoXjb3p
	 ZiJXeMQEkexKBM4LA7JZGuAVf7cPclfRIod9mDDydwrWxQRr1l41XO5TdbsuIlNaPDa4y
	 +uPOVQcteqMy0rlM9WF+JoURJvFJSwUuzht0eiMji2JC+Hekl/mon0e+g9TCH/BQzDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785948;
	bh=Kul2tDFaddDXBMm8LU7LDTUDEipHxaBeW2BNFmvgmv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=O2q1xGmMUW6cGavQzF4KFxwxpek0z7KyhQpbVpBXIbvlaEfXHQ3tAJyDbdwRlS7SX
	 CH61F/rJRu0D8xi+P+D84Ss1TR7iqop7QmwCBSTxyp5DcnnNhu8v2sQWvQRp5f9hCb
	 /G6NrzIHc4+1LBz6EHCn+eFYhxB1UUbqiUfajVaCZ7XtjWR1QYbKAk1DVqTcjIHbOT
	 TNdD9+zzLyBvOioVQVNo0oUw7f48fZEkVfdrUJ1c01sNJQvHc3bp3WB6J2hvmPITmE
	 qHWTbuaPGlSkVkhOGf70Mx5l+yFqzmgxsdXvVzuntatYAr8IwT4k9bUNDouYQDlXY2
	 HFghxJyK5CToA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD8EE60AC4;
	Fri, 27 Nov 2026 13:25:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7A2626D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCDA8811F7
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X0nx5ELLW8-r for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DB60D8117D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+ricardo.pardini.net@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GD0EOyaV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB60D8117D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:14:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD1E3612A9;
 Fri, 27 Nov 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 25F801F0089A;
 Fri, 27 Nov 2026 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795785248;
 bh=Kul2tDFaddDXBMm8LU7LDTUDEipHxaBeW2BNFmvgmv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=GD0EOyaVUEKI6Djttx2Om1wE5lMsgzjRFqeKQcSp+0PuYuYDgPmVZMDf0XBsr04yP
 Hi1CB7Z6rbyGCEPoY4n6v9KCC/pj4D5St6hQwhfbL3A2sO+TxfhgFk6ZKrZz0VJhPK
 dWlPeNwc717EGPgmA0lxvZu+HBMm/+II4CgL7PIXwuqgVevVXi63AgggaCv6H0Jbdj
 jjEhDGxXCD3gJCHQOGVFdpL5SHKvvBwPdPO8+7mUrkIGJWd82MuXdGWlzlTEYdBFiN
 oQYyirfXMUYhKJHgYqL/RMlBeWZbajYcRMYOqPYleuI/AK4hreSj+rOuT2vxUzrv8P
 aB9tjGrIoqDdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A4D954B7E5;
 Fri, 27 Nov 2026 13:14:03 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Fri, 27 Nov 2026 14:12:58 +0100
Subject: [PATCH v2 1/4] ata: dwc_ahci: use the first PHY, ignoring
 phy-names
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-rk3588-sata-fixes-v2027-01-v2-1-dbdf7770972a@pardini.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=ricardo@pardini.net;
 h=from:subject:message-id;
 bh=wm01rhWtnsB77YGcacSw/rSmvhsvQkWhSu/IMB4QbQw=;
 b=owEBbQGS/pANAwAKATteP+Oex+3pAcsmYgBrCYIZDtEIDQ15EoFitiYMwgx7dgRicZQgmrW/9
 ULnuCTriL2JATMEAAEKAB0WIQSsGCMM9q/qytxIiJM7Xj/jnsft6QUCawmCGQAKCRA7Xj/jnsft
 6auoCACTaao9NX2DHHM3wQEI6Xcz/nHbtygvFBH0QsV9PhRyegyDraDORpOR8oibkSaZ/09lqkX
 zlU480UvzJ6bhszBdZUbV5lXS/eQdfBv6rDgP0+RQDddigvmWfGFw7Kuhc06yF0IGFkIDHnuzhe
 7ypfdDPCw508SaLx20H2eAG3WRVl9YE16A5taodz6y14lmpzQCJHyuRB9Pyb5ZAZ60HD6J+0LWg
 gEyi/KUyRu1E4/DUyIWjnVxUV5xYVVZr6N0awhtfU4Hw2vew1nteUPn8yXOm19x/GfUetmIcvXY
 aItzsqI1zzdU366AhlsIyRLEp7CI+rLvxjNJpz4f6mOUckkI
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

Take the first PHY of the controller node instead of looking it up
by the "sata-phy" name, like Linux's libahci_platform does. The
binding allows a single PHY and phy-names is optional.

Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 drivers/ata/dwc_ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/dwc_ahci.c b/drivers/ata/dwc_ahci.c
index 0431d370716..138a025cb02 100644
--- a/drivers/ata/dwc_ahci.c
+++ b/drivers/ata/dwc_ahci.c
@@ -56,7 +56,7 @@ static int dwc_ahci_probe(struct udevice *dev)
 	int ret;
 	struct phy phy;
 
-	ret = generic_phy_get_by_name(dev, "sata-phy", &phy);
+	ret = generic_phy_get_by_index(dev, 0, &phy);
 	if (ret) {
 		pr_err("can't get the phy from DT\n");
 		return ret;

-- 
2.47.3


