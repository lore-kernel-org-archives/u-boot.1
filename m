Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB3606A31E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ByqA7gSu;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=WvGtNZWK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 804C240A53;
	Fri, 27 Nov 2026 08:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jl0wzDnuugRH; Fri, 27 Nov 2026 08:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7891240A4A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795767466;
	b=JnnHIDwvBgF/I1Xfmj/0ikj3wcQJ+kMflXAiejX2/RsrQlGBVBsyqzhUjB0VgkXD2uUx
	 8V55M/RuPJ43wgeZBwQUndN5G/jkAbn7kTPEPkWnRh74oCBeG+/raJOoV6c/ItBm7bFe3
	 VevTC474247FyFdFR49fd3Rg58Ow6ThYPuvD2vHwujMD9OAQpbAnRPI8KTrV9hibSVerM
	 2SKbjFHN8+nnr4yDbvBaG60nkILZcV+pVcAwcIwXTRm55Wyt0BHMsFl7XXqFeVtLRzsmj
	 S/cxOpZWQDIO1nZYJelitnr0e90yXUQTe9A0KBLtbe4Z/XOUw3STM+AweNYYd204ADw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795767466;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5h76ctBVSp1T2gHYXuHOGeMBLujHaRgdncVNxEIVJpQ=;
	b=TOGimr1tBO4yrajO0VeQkhDYTdWK0Hz0pzY3f2MgmWLrq3PjaF3lbodIEAOy2YM8sDR8
	 RyMGoxPloALJLxFl1I4ODkjZDN/n5xu/9HkKWGG35qpxwLv8YRRr+Ri7+5PMYUHO+PZz0
	 CVhNlc7HbQl0d2MVrPTRypW6/YLQkPxUJPiemDzW0OLnktw3BK2b+rMElZhcvt/Cf7wcA
	 6DAr7/oGSgL1U9m0Q4pHCJiFt2AACBU4ki4B7aPH/ZoHvmEn6j87RQkXcNYR9EaVYE9aM
	 OfRc3IK8+6TW7z6nyS+5oSKAiz+iDvq8IB69dvWQJLGbfTMoYz4T4fuPWgcSSziiC9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795767466;
	bh=5h76ctBVSp1T2gHYXuHOGeMBLujHaRgdncVNxEIVJpQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ByqA7gSuMzFcikbwvGF8y4WjlT1B/jexlPg1djw2Y3S7lfvnKEHpgTKsd/+E2heXB
	 k8nONnvaAFAGhtnBdCfdn7UgLRhNRiz8pAmkwNJHVa9zXJ6sV0OBZ0LPDw5QOQk2gH
	 vJ0nsT/+JaJFnX6sCBKQm3JbRvIq5Tp99jW5+9BeiX7fJMZcQ9OQinn0ePJdpsLGaZ
	 HKUwt48rHRgRnpFVIYBfnCQAAgJ5MOWINq5y+UkgwNGZPkg+fPNNC/hZBE80imJVHK
	 fCnmrJZJv1B5I0HMiQsD32ZWBID1q2N3BdDnnUQX3067YjxcNcMJhsofo0CTXqkITA
	 cYsWtPWc22GDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7891240A4A;
	Fri, 27 Nov 2026 08:17:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 90260266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76052811F0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:17:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cZOAkSrnY-ot for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 08:17:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0C778115E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=WvGtNZWK
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0C778115E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id B9D26B0054C;
 Fri, 27 Nov 2026 09:17:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1795767459;
 bh=GB8aIoiHzSYZ0MdmmBlro71fGvzwaEbCHOxo9R2tXt4=;
 h=From:To:Cc:Subject:Date:From;
 b=WvGtNZWKDYK069LZbuMpnVrZVBkuPH7BQR9KPETbyhk9ziZyw1E7URaGrorDUlZq9
 c1QUaeQrLlpsfeu8R7J/wruu0Nfeqvh/GUG82CYT5+l7+aIH4KFSUbZIARJ2EgquCw
 RSEDuQ0/liGqgELtsi1oMshdJvDQp+I7wSEvDJlG5RZaiSh3E+h59CQr4zFZU/9fUU
 xKfV8AvkbEsbHntHGS1/6uIOD5i7qz7v02IKSwLqXHfu4f/zDCc2IvGfO7Y7qLsbmv
 Q/NLbMi+F/SS97nFBEVFeEDox/9nup3Fyd94vU4EBKY3tjFv9ljesVYDEy2GaT9BgT
 ITEdwd3ncZZuA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Maxime Leroy <maxime@leroys.fr>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH] net: ldpaa_eth: track the open state in the driver
Date: Fri, 27 Nov 2026 09:17:14 +0100
Message-ID: <20261127081721.788638-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Maxime Leroy <maxime@leroys.fr>

ldpaa_eth_open() and ldpaa_eth_stop() use eth_is_active() to check
if the port is open.
But eth_is_active() tells whether the port is in use, not whether it
is open!

Fixes: 44340456475d ("net: tftp: don't call stop callback from UDP handler")
Signed-off-by: Maxime Leroy <maxime@leroys.fr>
Signed-off-by: Vincent Jardin <vjardin@free.fr>

---
It has been tested on an LX2160A board (Nodebox v3) on its RGMII port
(DPMAC 17), at the U-Boot prompt: 3 rounds of a tftp of a missing file
with the errors:
  "TFTP error: 'File not found' (1)"
then a tftp of an existing file, each load transferring the file.
Two loads in a row and a ping.

 drivers/net/ldpaa_eth/ldpaa_eth.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
index 27ae6747464..03d704eab69 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.c
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
@@ -380,7 +380,7 @@ static int ldpaa_eth_open(struct udevice *dev)
 	struct dpni_queue d_queue_cfg = { 0 };
 	struct dpni_queue_id d_queue;
 
-	if (eth_is_active(dev))
+	if (priv->started)
 		return 0;
 
 	if (get_mc_boot_status() != 0) {
@@ -476,6 +476,8 @@ static int ldpaa_eth_open(struct udevice *dev)
 		goto err_qdid;
 	}
 
+	priv->started = true;
+
 	return dpmac_link_state.up;
 
 err_qdid:
@@ -502,8 +504,9 @@ static void ldpaa_eth_stop(struct udevice *dev)
 	int err = 0;
 	u64 *data;
 
-	if (!eth_is_active(dev))
+	if (!priv->started)
 		return;
+	priv->started = false;
 
 	data = kzalloc(sizeof(u64) * LDPAA_ETH_DPNI_NUM_STATS, GFP_KERNEL);
 	if (data) {
---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
branch: for-upstream/ldpaa-eth-open-state-v1

-- 
2.43.0

